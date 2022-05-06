# Technical architecture - as is

This page documents the existing technical architecture for the Database of Qualified Teachers (DQT).


## Core diagrams
Visualising this hierarchy of abstractions is then done by creating a collection of **Context**, **Container**, **Component** and (optionally) **Code** (e.g. UML class) diagrams.

## Level 1: DQT - System Context diagram

![](images/c4/c4-teacher-services-landscape.png)

## Level 2: DQT - Container diagram

The Container diagram shows the high-level shape of the software architecture and how responsibilities are distributed across it. It also shows the major technology choices and how the containers communicate with one another.

![](images/c4/c4-dqt-container.png)

## Level 3: DQT - Component diagram

The Component diagram shows how a container is made up of a number of "components", what each of those components are, their responsibilities and the technology/implementation details.

### DQT Web Portal Component Diagram

![](images/c4/c4-web-portals-component.png)

### DQT Data Interface Component Diagram

![](images/c4/c4-dqt-data-interfaces-component.png)
