## edld - Environment Data Logging Daemon

*edld* is an environmental data logger. It will take data from a variety of sensors/sources and dumpt to a db.

The current goal is to be able to retrieve data from my [Current Cost Envir](http://www.currentcost.com/product-envir.html) and dump into a mysql db in a format that [MeasureIT](https://code.google.com/p/measureit/) can use.

### Goals

* ability to daemonize
* decent logging
* decent CLI ui/ux
* ease to get up and running
* scheduled tasks for calculating usage - hourly, daily, weekly, monthly etc etc 
* handle multiple sensors
* email alerting system for errors
* send data to PVOutput
 * plugins would be a good idea here


### Contributing

See [Contributing](CONTRIBUTING.md)

### Licence

The MIT License (MIT)
Copyright 2013 Mick Pollard @aussielunix

See [LICENSE](LICENSE.md)
