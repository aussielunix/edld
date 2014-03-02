## edld - Environment Data Logging Daemon

*WARNING: This is a work in progress and is not stable yet*

*edld* is an environmental data logger. It will take data from a variety of sensors/sources and dump to a variety of outputs.

It is fully plugable in all directions.

* input sources
* protocol to process
* outputs

## Input Sources

This can be a variety of things, you just need to write the source plugin.

* Read from a serial port
* consume an external API (eg: weather data)
* read from a unix socket
* read from a tcp socket
* ??

## Protocols

Each source you want to work with will implement their own data format - xml, json, csv or some custom format.  
You just need to write a protocol plugin for processing the raw data feed.

## Outputs

Edld uses the 'Observer' software design pattern to make it easy to notify more
than one 'observer' or 'notifier' when new data is recieved.  
This means that you just need to write an output plugin that takes the data and
does something with it and register it in the config file.

* stores in a db
* sends offsite to thirparty api
* sends to graylog2, logstash, splunk logging system
* drops data onto some sort of message bus (amqp etc)
* ??

### Goals

The immediate goal is to be able to retrieve data from my [Current Cost Envir](http://www.currentcost.com/product-envir.html) and dump into a db.  
Long term goal is to be able to read data from almost anything and to send it to almost anywhere.

* ease to get up and running
* easy to contribute / extend
* extremely flexible



### Contributing

See [Contributing](CONTRIBUTING.md)

### Licence

The MIT License (MIT)  
Copyright 2014  
Mick Pollard [@aussielunix](http://twitter.com/aussielunix)

See [LICENSE](LICENSE.md)
