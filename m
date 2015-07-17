From: Colin Powers <Colin.Powers@nexor.com>
To: "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
Subject: Restricting samba to only talk to one network interface?
Date: Fri, 17 Jul 2015 10:46:04 +0000
Message-ID: <VI1PR03MB1006B3B0EFB3FB97DC18A3AB9E980@VI1PR03MB1006.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

I have a case where I want to apply a more restrictive policy to the samba daemon, smbd. I am not sure what the best way to approach this problem is, any ideas?

My situation is:
* I have two network interfaces
  	* I am using iptables to label packets based on the network interface. E.g. all packets on eth0 are eth0_packet_t and all packets on eth1 are eth1_packet_t
* I want smbd to be able to interact with only one of the network interfaces
* I have a policy module that allows smbd_t to send/recv eth0_packet_t
* Problem: if the firewall is off, I would like smbd to be unable to communicate on the network.
	* However, it seems in default targeted policy smbd can communicate over the network using unlabelled packets, so it can talk to either network interface in this state.
	* How do I alter things so samba can only communicate on the network using eth0_packet_t - therefore making it impossible for smbd to communicate on the network unless the iptables is labelling packets as eth0_packet_t?


Possible ideas:
* take ownership of the whole policy rather than build on top of the default RHEL policy, and customise the samba policy that is delivered?
* make a copy or symlink of the smbd daemon and apply custom policy to it?
* somehow relabel the existing smbd executable with a custom type that can only communicate on eth0_packet_t?
	* but what's the best way to "override" the default policy? must I unload the samba policy module with semodule to allow smbd to be labelled with some other type?
* something else?

Potentially it seems like any of those ideas can work but I'm trying to figure out which one is the path of least resistance - i.e. which one causes the smallest maintenance headache e.g. when default targeted policy is updated. Any thoughts/recommendations?

Regards

Colin
