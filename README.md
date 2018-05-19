# Gitlab control script for linux #
----
### 1. Description ###
* This script is to control gitlab under docker machine.


### 2. Requirements ###
* docker
* gitlab image

### 3. My OS ###
* win10
* Docker version 18.05.0-ce, build f150324
* Gitlab images: gitlab/gitlab-ce:latest

### 4. Get script ###
git clone https://github.com/wjainiya/Gitlab-ctl.git

### 5.Command Usage ###
* start gitlab image as a container
<pre>
    * start with port 8080
    * ./gitlab-ctl.sh start e420c3fac3e3 8080  
    * start with default port 1234
    * ./gitlab-ctl.sh start e420c3fac3e3 
</pre>

* stop gitlab container
<pre>
    * stop gitlab container with id 
    * ./gitlab-ctl.sh stop ea043b285fa4  
    * stop first running container 
    * ./gitlab-ctl.sh stop 
</pre>

2018/5/19 17:10:00 