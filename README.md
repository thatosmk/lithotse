# Lithotse

![Build](https://github.com/thatosmk/lithotse/workflows/Build/badge.svg)
This is a data aggregator for health records

## What is data aggregation

[Data aggregation](https://www.import.io/post/what-is-data-aggregation-industry-examples/) is the process of gathering 
data and presenting it in a summarized format. Such data may have been gathered from multiple sources with the intent of
combining these into a summary for analysis.

> Data aggregation helps ensure maximum utilization of organisational data.

## Design

### Data/Table Fields

* Date: Used to sample data from date 1 to date 2

## Functionalities

1. Easy integration with existing tools, import or export into spreadsheets
2. Compatibility with different screens or devices
3. To allow scalability, we should not allow a single datastore.

## Assumptions

* Users of this data aggregation platform includes the client and their managers at their organisation.

## Architecture

The architecture of this platform has been adapted from the one advised on this [medium
article](https://medium.com/@guyernest/building-a-successful-modern-data-analytics-platform-in-the-cloud-4be1946b9cf5)
and will be used as a basis with slight modifications.
Our data aggregation platform will be designed based on the architecture to be shown below, this architecture should be
in line with the assumptions and functionalities listed above;

### Tier 1 (L1) - Raw data in low-cost storage

All data should land in its raw form from every source with little modification or filtering. It should not be organised
nicely with foreign keys between tables or harmonized to have the same format of the address or product ID for instance.

### Tier 2 (L2) - Multiple optimized data derivatives in low-cost storage

With data coming into the first tier, as soon as a file lands in tier 1 build multiple data derivatives based on this file. 
Multiple is a keyword in this case since every analysis is looking at the data from a  different angle and for a
different business need, and eventually, it is developed by a different team.

The data in this tier is mostly aggregated, filtered, or transformed from it original raw form to fit a specific
business question. 

### Tier 3 (L3) - Optional cache data stores

To allow users' interactions with the results of the data analytics, we often need to cache these results to make them
usable for humans for speed and query capabilities. We use *Redis* for fast operations on in-memory data sets, or

### Backend

The backend of this platform will be mainly Ruby, that is, ruby APIs handling data capturing and persistance on to
chosen layers of databases.

#### API Endpoints

- ``` GET /patients```

Returns all the patients

- ``` GET /patients/:id```

Returns a patient with id

