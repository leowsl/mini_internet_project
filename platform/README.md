# The mini-Internet documentation

In this README, we explain how to [install the required software](https://github.com/nsg-ethz/mini_internet_project/tree/master/platform#prerequisite), how to [run the mini-Internet](https://github.com/nsg-ethz/mini_internet_project/tree/master/platform#run-the-mini-internet), how to [delete it](https://github.com/nsg-ethz/mini_internet_project/tree/master/platform#delete-the-mini-internet), how to [configure it](https://github.com/nsg-ethz/mini_internet_project/tree/master/platform#configure-the-mini-internet-topology), how to [access its components](https://github.com/nsg-ethz/mini_internet_project/tree/master/platform#configure-the-mini-internet-topology), and how to use the different [monitoring tools](https://github.com/nsg-ethz/mini_internet_project/tree/master/platform#use-the-monitoring-tools-and-services).

We run our mini-Internet on a server with Ubuntu 18.04 and the Linux 4.15.0 kernel.
For more detail about the default topology used when you run the mini-Internet, along with the other topologies already prepared and ready to be used, see the documentation in the directory `config`.

## Prerequisite

To build the mini-Internet, you need to install the following software.

#### Install the Docker Engine
```
sudo apt-get update
sudo apt install docker.io
```

For further information, see the [installation guide](https://docs.docker.com/install/linux/docker-ce/ubuntu/).

#### Install OpenVSwitch
```
sudo apt-get install openvswitch-switch
```

For further information, see the [installation guide](http://docs.openvswitch.org/en/latest/intro/install/).

#### Install OpenVPN

```
sudo apt-get install openvpn
```

## Build the mini-Internet

To build the mini-Internet, first clone this repository in your server, and go in the directory `platform`.
```
cd platform
```

Then run the startup script:
```
sudo ./startup.sh
```

By default, this will run a mini-Internet with 20ASes. :warning: Make sure your server has enough resources to sustain this mini-Internet (e.g., around 64GB of memory and at least 8 CPU cores are recommended). Otherwise, see in section [configure the mini-Internet](https://github.com/nsg-ethz/mini_internet_project/blob/master/platform/README.md#configure-the-mini-internet-topology) how to run a mini-Internet with only one AS.

## Delete the mini-Internet

The are two ways to delete the mini-Internet. First, you can delete all the virtual ethernet pairs, docker containers, ovs switches and openvpn processes used in the mini-Internet, with the following command.
```
sudo ./cleanup/cleanup.sh .
```

However, this script uses the configuration files, thus if they have changed since the time the mini-Internet was built, or if the mini-Internet did not setup properly, not all the componenents might be deleted, in which case in can make some problems if you want to build a new mini-Internet. We thus also provide you with a script that delete *all* the ethernet pairs, containers and switches, :warning: including the ones not used by the mini-Internet. 
```
sudo ./hard_reset.sh
```

## Configure the mini-Internet topology

In the `config` directory, you can find all the configuration files used to define the topology of the mini-Internet,
and we also describe more in detail the topologies we have prepared and that you can directly use. Of course, you can also define you own topology using the configuration files.

#### Layer 2 topology

`layer2_switches_config.txt`: The file lists the switches in the L2 network. By default there are four switches (ETH-ZENT, ETH-HONG, ETH-IRCH, ETH-OERL). The second column indicates whether the switch is connected to a L3 router, here by default ETH-ZENT is connected to a router. Finally the third column indicates the MAC address used as an 'ID' to configure the switch.

`layer2_links_config.txt`: This file indicates how the l2 switches are interconnected. For instance by default ETH-ZENT is connected to ETH-IRCH, ETH-ZENT is connected to ETH-OERL, etc. The last two columns indicate the throughput and the delay of the link, respectively.

`layer2_hosts_config.txt`: This file indicates the hosts that are in the layer 2 network, and to which switch they are directly connected to. For instance the host student_1 is by default connected to ETH-IRCH. The next two columns indicate the throughout and delay, respectively. The last column indicates in which VLAN is the host. Also, observe that a host can be a VPN server, in which case it must start with "vpn_". 

#### Layer 3 topology

`router_config.txt`: This file lists the routers. In the default L3 topology there are 8 routers. The second column indicates if a tool or service (such as the connectivity matrix or the DNS server) is connected the to the network through the corresponding router. For instance, the DNS server is connected to ROMA. Finally the last column indicates whether a single host or a L2 network is connected to the router. In the default topology, only the router ZURI is connected to a L2 network, all the others are connected to a single host.

`internal_links_config.txt`: This is the internal topology. The first two columns indicate which pair of routers are interconnected, the last two columns indicate the throughput and delay of the link, respectively.

#### AS-level toplogy

`AS_config.txt`: This file lists all the ASes and IXPs in the mini-Internet. By default, there are 20 ASes and 3 IXPs.

`external_links_config.txt`: This file describes the AS-level topology, and which router in one AS is connected to which router in another AS. Let us take this line as example:

`1	HOUS	Provider	3	LOND	Customer	10000	1000	N/A`

This means that the router HOUS (2nd column) in AS 1 (1st column) is connected to the router LOND (5th column) in AS 3 (4th column). AS1 is the provider (3rd column) and AS3 is the customer (6th column).

Sometimes, an AS can also be connected to an IXP, for instance:

`2	BARC	Peer	80	N/A	Peer	10000	1000	1,2,11,12`

When the 5th column is N/A, it means it is an IXP. Here, the AS number of the IXP is 80.
The last column (1,2,11,12) indicates to which participants the routes advertised by AS2 should be propagated.

As usual, the 7th and 8th columns indicate the throughput and the bandwidth, respectively.

The file `subnet_config.sh` is used to configure the IP addresses following a particular scheme (see our [2019 assignment](https://github.com/nsg-ethz/mini_internet_project/blob/master/2019_assignement_eth/mini_internet_project.pdf)), we recommend not to modify these file if you are using our topologies.

#### Change the size of the mini-Internet

You may want to run a smaller or larger mini-Internet. For instance, if you just want to quickly experience the mini-Internet, or if you only have a small VM, you should run a very small mini-Internet with only few ASes. Alternatively, if you want to run the mini-Internet for a class project, you may want to run a larger one with e.g., 60 ASes. 
In the directory `config_2019`, with provide you with a set of configuration files for different size of the mini-Internet that you can just copy/past in the `config` directory. The AS-level topologies follow the structure we used in the 2019 iteration of the mini-Internet project. We always use the same L3 and L2 topologies.

To run a mini-Internet with only 1 AS, just copy the following files:

```
cp config_2019/AS_config_1.txt config/AS_config.txt
cp config_2019/external_links_config_1.txt config/external_links_config.txt
```

To run a mini-Internet with 60 ASes, copy the following files:

```
cp config_2019/AS_config_60.txt config/AS_config.txt
cp config_2019/external_links_config_60.txt config/external_links_config.txt
```

We also provide configuration files for a 2 ASes and a 40 ASes topology.

## Access the mini-Internet

You can access the mini-Internet in two ways.

#### Instructor access with docker

First, if you are the instructor and have access to the server hosting the mini-Internet, you can directly access the containers using the docker commands. First, type `sudo docker ps` to get a list of all the containers running. The names of the hosts, switches and routers always follow the same convention. For instance, to access the router LOND in AS1, just use the following command:

`sudo docker exec -it 1_LONDrouter bash`

If you are in router, run `vtysh` to access the CLI of that router. \

#### Student access with SSH

To enable the student access through SSH, first make sure the following options are se to true in `/etc/sshd_config`:

```
GatewayPorts yes
PasswordAuthentication yes
AllowTcpForwarding yes
```

Then, enable the ssh port forwarding with the following command:

`sudo ./portforwarding.sh`

Then, the students can connect from outside. First, the students have to connect to the ssh proxy container:

```ssh -p [2000+X] root@server.ethz.ch```

with X the group number. The passwords of the groups are automatically generated and available in the file `groups/ssh_passwords.txt`

Once in the proxy container, the student can use the `goto.sh` script to access a host, switch or router. 
For instance to jump into the host connected to the router ABID, use the following command:

```
./goto ABID host
```

Once in a host, switch or router, just type `exit` to go back to the proxy container.

#### Student access with OpenVPN

We now explain how to connect to the mini-Internet through a VPN.
In the file `config/layer2_hosts_config.txt`, the line starting with "vpn" corresponds to a L2-VPN server that will be automatically installed instead of normal host in a container. A L2-VPN is connected to a L2 switch (the one written in the 2nd column), and every user connected to this L2-VPN will be virtually connected to that L2 switch.

To use the VPN, a student must first install OpenVPN, and run it with the following command (in Ubuntu 18):

```
sudo openvpn --config client.conf
```

We provide the `client.conf` file below, where VPN_IP must be replace by the IP address of the server hosting the mini-Internet, and VPN_PORT must be replaced by the port on which the VPN server we want to use listen to.
To find the port of a VPN server, we use the following convention: the port of the n-th VPN server in group X is 1000+(X\*m)+(n-1) where m is number of VPN server per AS (i.e., 2 by default).

```
client
remote VPN_IP VPN_PORT
dev tap
proto udp
resolv-retry infinite
nobind
persist-key
persist-tun
ca ca.crt
cipher AES-256-CBC
verb 3
auth-user-pass
```

The file `ca.crt`, automatically generated when building the mini-Internet and available in the directory `groups/gX/vpn/vpn_n` must be given to the student. 
Finally, the username is `groupX` (X is the group number) and the password is the same than the one used to access the proxy container. 

When connected, the student should have an interface `tap` with an IP address configured and that is connected to the mini-Internet.

## Use the monitoring tools and services

We now explain how are built the different monitoring tools and services, and how to use them.

#### Looking glass

Every container running a router pulls the routing table from the FRRouting CLI every 30 seconds and stores it in `/home/looking_glass.txt`.
Then, you can simply periodically get that file with e.g., `docker cp 1_ABIDrouter:/home/looking_glass.txt .` and make it available to the students, for instance on a web interface.

#### Active probing

To run measurements between any two ASes, we must use a dedicated container called MGT for "management" container. 
To access the management container, we must use the port 2099:

```
ssh -p 2099 root@server.ethz.ch
```

The password is available in the file `groups/ssh_mgt.txt`, and should be made available to the students so that they can access it. \
In the management VM, we provide a script called `launch_traceroute.sh` that relies on `nping` and which can be used to launch traceroutes between any pair of ASes. For example if you want to run a traceroute from AS 1 to AS 2, simply run the following command

```
root@c7a60237994a:~# ./launch_traceroute.sh 1 2.101.0.1
Hop 1:  1.0.199.1 TTL=0 during transit
Hop 2:  1.0.8.2 TTL=0 during transit
Hop 3:  179.24.1.2 TTL=0 during transit
Hop 4:  2.0.8.1 TTL=0 during transit
Hop 5:  2.0.1.1 TTL=0 during transit
Hop 6:  2.101.0.1 Echo reply (type=0/code=0)
```

where 2.101.0.1 is an IP address of a host in AS2 (here we used the topology with 2 ASes). You can see the path used by the packets to reach the destination IP. 

By default, the management container is connected to the router ZURI in every AS. You can see this in the config file `config/router_config.txt`. The second column of the ZURI row is `MGT` which means that the management container is connected to the ZURI router, but you can edit this file so that the management VM is connected to another router instead. 

#### Connectivity matrix

Another container called `MATRIX` is also connected to every AS. By looking at the config file `config/router_config.txt`, we can see to which router it is connected in every AS and towards which router it sends ping requests in every other AS. By default, the matrix container is connected to TOKY, and the pings are destined to the HOUS routers. 
Only the instructor can access the MATRIX container, from the server with:

```
sudo docker exec -it MATRIX bash
```

To generate the connectivity matrix, just run the following script:

```
cd /home
.ping_all_groups.sh
```

The connectivity matrix is then available in the file `/home/connectivity.txt`, where 1 means connectivity, and 0 means no connectivity. You can then periodically download this file and making it available to the students on e.g., a web interface. 

#### The DNS service

Finally, another container, connected to every AS and only available to the instructor runs a bind9 DNS server.
By looking at the file `config/router_config.txt`, we can see that the DNS container is to connected to every router ROMA.
The DNS server has the IP address 198.0.0.100/24, as soon as the students have configured intra-domain routing and have advertised this subnet into OSPF, they should be able to reach the DNS server and use it.

For instance, a traceroute from HOUS-host to ABID-host returns the following output:

```
root@HOUS_host:~# traceroute  1.108.0.1 --resolve-hostnames
traceroute to 1.108.0.1 (1.108.0.1), 64 hops max
  1   1.106.0.2 (HOUS-host.group1)  0.394ms  0.005ms  0.003ms
  2   1.0.6.1 (LOND-HOUS.group1)  0.143ms  0.145ms  0.129ms
  3   1.0.2.2 (BARC-LOND.group1)  2.159ms  2.168ms  2.150ms
  4   1.0.11.2 (ABID-BARC.group1)  2.199ms  2.277ms  2.253ms
  5   1.108.0.1 (host-ABID.group1)  2.383ms  2.289ms  2.290ms
  ```
  
  Observe that we must use the option `--resolve-hostnames` to make traceroute resolve the hostnames.