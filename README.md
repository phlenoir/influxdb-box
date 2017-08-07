# influxdb-box
A Vagrant Centos7 box to play with InfluxDB time series database.
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
See these [instructions](https://github.com/phlenoir/influxdb-sampledata/blob/master/README.md) to start Kapacitor tasks that will consume data sent on UDP port 9100 and produce streams of data into an Influxdb database

## About ##

This box will install the following from yum repository
* Vim
* Git
* python 2.5
* Java JRE
* net tools

and also
* InfluxDB 1.2
* Kapacitor 1.3
* Grafana 4.3
* [pip](https://pip.pypa.io/en/stable/) 
* python dependencies
* a few helper stop/start scripts for no-standard environment

