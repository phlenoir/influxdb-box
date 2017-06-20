# influxdb-box
A Vagrant box to play around with InfluxDB time series database.
The box comes with influxdb, kapacitor and grafana installed plus a couple a utilities, among them a sample data generator (see https://github.com/phlenoir/influxdb-sampledata.git)

## Installation 

### Download and install the box
1. Install VirtualBox
1. Install Vagrant
1. Install Git
1. run `git clone https://github.com/phlenoir/influxdb-box.git`
1. run `cd influxdb-box`
1. run `vagrant up`

### Checks
* influxdb is up and running
* kapacitor is up and running, listening on UDP port 9100
* grafana is up and running

## Play
See these [instructions] (https://github.com/phlenoir/influxdb-sampledata/blob/master/README.md) to start Kapacitor tasks that will consume data sent on UDP port 9100 and produce streams of data into an Influxdb database
