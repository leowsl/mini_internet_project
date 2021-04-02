# An Open Platform to Teach How the Internet Practically Works

Welcome in the official repository of the mini-Internet project.

### The mini-Internet project

A mini-Internet is a virtual network mimicking the real Internet. Among others, there are routers, switches and hosts that are located in different ASes. A mini-Internet runs in a single server and is tailored to teach how the Internet practically works. Each component of the network is running in its own dedicated linux container, that are remotely accessible by the students with simple ssh connections.

The mini-Internet project is the flagship piece of our [Communication Networks course](https://comm-net.ethz.ch/) at ETH Zurich since 2016. The concept is rather simple: we let each student group operate their own AS. Their goal? Enabling Internet-wide connectivity.

We find this class-wide project to be invaluable in teaching our students how the Internet infrastructure practically works. Among others, our students have a much deeper understanding of Internet operations alongside their pitfalls. Besides students tend to love the project: clearly the fact that all of them need to cooperate for the entire Internet to work is empowering

### How we use the platform at ETH

- We use the platform in our introductory course to [Communication Networks](https://comm-net.ethz.ch/). In the [communication_networks_course](communication_networks_course) directory, we detail the mini-Internet project and show what we ask our students to do. We also show the configuration files that we used so that you can run the same project in your computer network classes.

- We use the platform in our [Advanced Topics in Communication Networks course](https://adv-net.ethz.ch/) so that students can have hands on experience on more advanced concepts and protocols such as MPLS, LDP, BGP Free Core, BGP VPN, VRF and Multicast. In the [advanced_networks_course](advanced_networks_course) directory, we detail the different mini-Internet-based exercises that we give to our students.

### Build _your_ mini-Internet

With this platform, you can easily build your own mini-Internet, tailored for your teaching objectives.
The documentation as well as the source code of the platform can be found in the [platform](platform) directory.
In a nutshell, after defining your topology in configuration files, you can build your mini-Internet with a bash script and use it for your networking class. 

If you use the platform, please cite our SIGCOMM CCR'20 **[paper](https://dl.acm.org/doi/pdf/10.1145/3402413.3402420)**. Here is the bibtex:
```
@article{10.1145/3402413.3402420,
author = {Holterbach, Thomas and B\"{u}hler, Tobias and Rellstab, Tino and Vanbever, Laurent},
title = {An Open Platform to Teach How the Internet Practically Works},
year = {2020},
issue_date = {April 2020},
publisher = {Association for Computing Machinery},
url = {https://doi.org/10.1145/3402413.3402420},
journal = {SIGCOMM Comput. Commun. Rev.},
}
```

### News

*3/12/20:* Added the BGP VPN MPLS and Multicast exercises of our Advanced Topic in Computer Networks course \
*29/09/20:* Changed the Dockerfile for the router image. Now FRR is compiled from the source with a particular version of the libyang library so that VRF are supported \
*08/07/20:* Added the docker image to use for the hosts in the config files \
*29/06/20:* Added support for MPLS and Multicast \
*15/04/20:* Fixed a security issue with the docker containers. Now students' containers only run with limited capabilities. \
*18/03/20:* Several fixes (e.g., prevent containers to crash because too many processes are running) and improvements (e.g., configure different internal topologies)

### Useful links

- We presented the mini-Internet at NANOG 78 in February 2020. The [talk](https://www.youtube.com/watch?v=8SRjTqH5Z8M&list=PLO8DR5ZGla8jSzWlrWt_cz13LLAz44rHY&index=11&t=0s) is available on youtube.

- We presented the mini-Internet at SIGCOMM'20 in the "Best of CRR" session. The virtual [talk](https://www.youtube.com/watch?v=PoEo4yGN0Rw&t=687s) is available on youtube. 

- We wrote a [blogpost](https://blog.apnic.net/2020/04/14/develop-your-own-mini-internet-to-teach-students-virtually-about-network-operations/) on the APNIC website about the mini-Internet.

- We presented the mini-Internet at the [AIMS-KISMET](https://www.caida.org/workshops/kismet/2002/) workshop. Our [slides](https://www.caida.org/workshops/kismet/2002/slides/kismet2002_tholterbach.pdf) are available online. 

### Contacts

Thomas Holterbach <thomahol@ethz.ch> \
Tobias Bühler <buehlert@ethz.ch> \
Tino Rellstab <tino.rellstab@gmail.com> \
Laurent Vanbever <lvanbever@ethz.ch> \
[NSG Group website](https://nsg.ee.ethz.ch/home/)

### Acknowledgment

We are grateful to everyone who contributed to improve the platform.

We are especially thankful to the following ETH students who helped us developping the platform during their studies:
- Martin Vahlensieck, 2021 (BGP policy analyzer)
- Denis Mikhaylov, 2020 (Implemenation of RPKI)

### Disclaimer

This platform has been tailored to teach how the Internet works in our Communication Networks lecture at ETH Zurich. Although this platform may be useful for other kind of purposes (research, experiments, etc), it has not been designed for them.

If you want to use this platform for your networking class, we recommend that you spent some time understanding the code and how we build the mini-Internet, and we recommend you to try it first before using it with actual students.
We assume no responsibility or liability for any problem you may encounter while using the platform.
