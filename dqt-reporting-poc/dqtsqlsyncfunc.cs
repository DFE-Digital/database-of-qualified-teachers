using System;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Host;
using Microsoft.Extensions.Logging;
using System.Data.SqlClient;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;

namespace tradigital.dqt.reporting
{
    public class dqtsqlsyncfunc
    {
        private readonly ILogger<dqtsqlsyncfunc> _logger;
        private readonly IConfiguration _configuration;


        /* change subscriber to avoid the published func app to pick up the msg before the local debug..*/
#if DEBUG
        private const string subscriptionName = "localdebugsubscriber";
#else
        private const string subscriptionName = "sqlserversyncfuncsubscription";
#endif

        public dqtsqlsyncfunc(ILogger<dqtsqlsyncfunc> log, IConfiguration configuration)
        {
            _logger = log;
            _configuration = configuration;

        }

        private string GetSetting(IConfiguration configuration, string setting)
        {
            return configuration.GetValue<string>(setting);
        }


        [FunctionName("dqtsqlsyncfunc")]
        public async Task Run([ServiceBusTrigger("dqtstream", subscriptionName, Connection = "dqtreppoc_SERVICEBUS")] string mySbMsg)
        {
             /* localdebugsubscriber
             /*_logger.LogInformation($"C# ServiceBus topic trigger function processed message: {mySbMsg}");*/
            dynamic lparsedmsg = JsonConvert.DeserializeObject(mySbMsg);

            _logger.LogInformation($" message name: {lparsedmsg.MessageName}");
            _logger.LogInformation($" Primary Emtity ID: {lparsedmsg.PrimaryEntityId}");
            _logger.LogInformation($" Primary Emtity Name: {lparsedmsg.PrimaryEntityName}");

            string msgtype = lparsedmsg.MessageName;
            string entityID = lparsedmsg.PrimaryEntityId;
            string entityName = lparsedmsg.PrimaryEntityName;

            try
            {
                var sqlDictionary = new Dictionary<string, dynamic>();

                dynamic lattributes = lparsedmsg.InputParameters[0].value.Attributes;
                foreach (dynamic attribute in lattributes)
                {
                    var dKey = attribute.key.ToString();
                    var dValue = GetValueForAttribute(attribute);

                    sqlDictionary.Add(dKey, dValue);

                    /*  foreach (KeyValuePair<string, dynamic> pair in sqlDictionary)
                     {
                         _logger.LogInformation("KEYVALUEPAIR: {0}, {1}", pair.Key, pair.Value.ToString());

                     } */

                }
                string sQuery = "";

                if (msgtype == "Create")
                {
                    sQuery = $"insert into dbo.{entityName} (Id,{string.Join(",", sqlDictionary.Keys)} ) values (@Id,{string.Join(",", sqlDictionary.Keys.Select(k => $"@{k}"))})";
                    if (entityName.ToLower() == "lead")
                    {
                        System.Diagnostics.Debugger.Break();
                    }
                }
                else
                {
                    sQuery = $"update dbo.{entityName} set {string.Join(",", sqlDictionary.Keys.Select(k => $"{k} = @{k}"))} where Id = @Id";
                }

                _logger.LogInformation(sQuery);



                SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder();

                builder.DataSource = _configuration.GetValue<string>("DataSource");
                builder.UserID = _configuration.GetValue<string>("UserID");
                builder.Password = _configuration.GetValue<string>("Password");
                builder.InitialCatalog = _configuration.GetValue<string>("InitialCatalog");


                using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
                {

                    connection.Open();

                    using (SqlCommand command = new SqlCommand(sQuery, connection))
                    {
                        command.Parameters.AddWithValue("@Id", entityID);
                        foreach (string key in sqlDictionary.Keys)
                        {
                            command.Parameters.AddWithValue($"@{key}", ((Newtonsoft.Json.Linq.JValue)sqlDictionary[key]).Value ?? System.DBNull.Value);
                        }
                        int rowsAffected = await command.ExecuteNonQueryAsync();

                    }
                }
            }
            catch (SqlException e)
            {
                _logger.LogCritical(e.ToString());
                throw e;
            }
            _logger.LogInformation("Task Finished.");
            Console.ReadLine();
        }



        private dynamic GetValueForAttribute(dynamic attribute)
        {

            if (attribute.value is Newtonsoft.Json.Linq.JValue)
            {
                // Is Primitive, or Decimal, or String
                return attribute.value;
            }
            else
            {
                if (((string)attribute.value.__type).StartsWith("OptionSetValue"))
                {
                    return attribute.value.Value;
                }
                else
                {

                    return attribute.value.Id;
                }
            }


        }

    }
}

