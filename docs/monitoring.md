# Monitoring

GOV.UK PaaS is monitored 24/7 via [StatusCake](https://www.statuscake.com/) and a number of reporting and alerting tools to ensure the team is aware of any issues or incidents.

The TRA Systems Development team are introducing:

* Dependabot - which will provide a regular heartbeat (via GitHub) to monitor application availability

* [Logit.io](http://logit.io/) Managed ELK as a Service, Open Distro, Hosted Grafana & APM, which is used across Teacher Services, and provides aggregated logging at the system and application level. 

* [Sentry.io](http://sentry.io/) - which is used widely across Teacher Services and provides error logging and threshold alerting

* [Grafana](https://grafana.com/) - which is used across Teacher Services to provide time series metrics at the system and application level

* [Prometheus.io](http://prometheus.io/) - which provides alerts to the team and any key stakeholders via the service team Slack channel and email alerts via GOV.UK Notify
