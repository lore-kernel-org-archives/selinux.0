From: Colin Powers <Colin.Powers@nexor.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "SELinux@tycho.nsa.gov"
 <SELinux@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>
Subject: RE: Restricting samba to only talk to one network interface?
Date: Fri, 17 Jul 2015 12:57:03 +0000
Message-ID: <VI1PR03MB100621E733A787451EF9B7FA9E980@VI1PR03MB1006.eurprd03.prod.outlook.com>
References: <VI1PR03MB1006B3B0EFB3FB97DC18A3AB9E980@VI1PR03MB1006.eurprd03.prod.outlook.com>
 <55A8F80C.8080806@tycho.nsa.gov>
In-Reply-To: <55A8F80C.8080806@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Thanks Stephen, that's really helpful.

I had a suspision that creating a whole new policy might end up being the answer, but thought it was worth making sure.

In my case the firewall should always be on; I will have to have a think about whether it is worth the effort to fork the policy or whether I would be better off having something like a script periodically checking the firewall state and taking appropriate action.

For the record I am on RHEL 6.6, but I suspect all the information you have given is still valid in this case.

Many thanks.
Colin

-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: 17 July 2015 13:42
To: Colin Powers; SELinux@tycho.nsa.gov; Paul Moore
Subject: Re: Restricting samba to only talk to one network interface?

On 07/17/2015 06:46 AM, Colin Powers wrote:
> Hi,
> 
> I have a case where I want to apply a more restrictive policy to the samba daemon, smbd. I am not sure what the best way to approach this problem is, any ideas?
> 
> My situation is:
> * I have two network interfaces
>   	* I am using iptables to label packets based on the network interface. E.g. all packets on eth0 are eth0_packet_t and all packets on eth1 are eth1_packet_t
> * I want smbd to be able to interact with only one of the network interfaces
> * I have a policy module that allows smbd_t to send/recv eth0_packet_t
> * Problem: if the firewall is off, I would like smbd to be unable to communicate on the network.
> 	* However, it seems in default targeted policy smbd can communicate over the network using unlabelled packets, so it can talk to either network interface in this state.
> 	* How do I alter things so samba can only communicate on the network using eth0_packet_t - therefore making it impossible for smbd to communicate on the network unless the iptables is labelling packets as eth0_packet_t?
> 
> 
> Possible ideas:
> * take ownership of the whole policy rather than build on top of the default RHEL policy, and customise the samba policy that is delivered?
> * make a copy or symlink of the smbd daemon and apply custom policy to it?
> * somehow relabel the existing smbd executable with a custom type that can only communicate on eth0_packet_t?
> 	* but what's the best way to "override" the default policy? must I unload the samba policy module with semodule to allow smbd to be labelled with some other type?
> * something else?
> 
> Potentially it seems like any of those ideas can work but I'm trying to figure out which one is the path of least resistance - i.e. which one causes the smallest maintenance headache e.g. when default targeted policy is updated. Any thoughts/recommendations?

There are two reasons why it can communicate when the iptables SECMARK
rules are flushed:
1. Policy allows it (there is an allow domain unlabeled_t:packet { send
recv }; rule in the unlabelednet policy module.

2. The kernel disables the packet permission checks entirely when there
are no iptables SECMARK rules loaded (this is for both performance and
compatibility) _unless_ the policy defines the always_check_network
policy capability (cat
/sys/fs/selinux/policy_capabilities/always_check_network).  The policy
capabilities are defined in the base policy module.

This assumes that your kernel even supports this policy capability.  You
didn't mention your RHEL version or kernel version.

So to enforce this restriction even when iptables rules are flushed, you
would need to rebuild both the base module (with a modified
policy/policy_capabilities file that defines always_check_network), and
you would need to remove the unlabelednet module.  At that point, you
are basically maintaining your own forked policy and should probably
install it with a different policy NAME (build.conf) / SELINUXTYPE
(/etc/selinux/config), and switch your /etc/selinux/config to refer to
it so that any selinux-policy-targeted updates will not affect your
system.  Then you would need to manually merge updates into your custom
policy.

A possible alternative would be to use peer labeling (NetLabel or
labeled IPSEC) configured only for loopback labeling and the net
egress/ingress permission checks instead of SECMARK.  Examples of
configuring those mechanisms for loopback only labeling can be found in
the selinux-testsuite (under tests/inet_socket) and in The SELinux
Notebook.  However, those checks are also subject to being disabled if
the peer labeling configuration (NetLabel or labeled IPSEC) is unloaded
unless always_check_network is set (but they wouldn't be affected by
flushing iptables).
