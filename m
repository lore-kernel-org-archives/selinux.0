MIME-Version: 1.0
In-Reply-To: <55A8F80C.8080806@tycho.nsa.gov>
References: <VI1PR03MB1006B3B0EFB3FB97DC18A3AB9E980@VI1PR03MB1006.eurprd03.prod.outlook.com>
 <55A8F80C.8080806@tycho.nsa.gov>
Date: Fri, 17 Jul 2015 11:47:20 -0400
Message-ID: <CAHC9VhSWUQ5sw62g-06K=mwPoB_aSeH3r6ifQ=cws6VRmfcKXg@mail.gmail.com>
Subject: Re: Restricting samba to only talk to one network interface?
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Cc: "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Jul 17, 2015 at 8:41 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 07/17/2015 06:46 AM, Colin Powers wrote:
>> Hi,
>>
>> I have a case where I want to apply a more restrictive policy to the samba daemon, smbd. I am not sure what the best way to approach this problem is, any ideas?
>>
>> My situation is:
>> * I have two network interfaces
>>       * I am using iptables to label packets based on the network interface. E.g. all packets on eth0 are eth0_packet_t and all packets on eth1 are eth1_packet_t
>> * I want smbd to be able to interact with only one of the network interfaces
>> * I have a policy module that allows smbd_t to send/recv eth0_packet_t
>> * Problem: if the firewall is off, I would like smbd to be unable to communicate on the network.
>>       * However, it seems in default targeted policy smbd can communicate over the network using unlabelled packets, so it can talk to either network interface in this state.
>>       * How do I alter things so samba can only communicate on the network using eth0_packet_t - therefore making it impossible for smbd to communicate on the network unless the iptables is labelling packets as eth0_packet_t?
>>
>>
>> Possible ideas:
>> * take ownership of the whole policy rather than build on top of the default RHEL policy, and customise the samba policy that is delivered?
>> * make a copy or symlink of the smbd daemon and apply custom policy to it?
>> * somehow relabel the existing smbd executable with a custom type that can only communicate on eth0_packet_t?
>>       * but what's the best way to "override" the default policy? must I unload the samba policy module with semodule to allow smbd to be labelled with some other type?
>> * something else?
>>
>> Potentially it seems like any of those ideas can work but I'm trying to figure out which one is the path of least resistance - i.e. which one causes the smallest maintenance headache e.g. when default targeted policy is updated. Any thoughts/recommendations?
>
> There are two reasons why it can communicate when the iptables SECMARK
> rules are flushed:
> 1. Policy allows it (there is an allow domain unlabeled_t:packet { send
> recv }; rule in the unlabelednet policy module.

I've never liked this policy module for this exact reason, but it was
born out of necessity in the early days before the dynamic network
checks were implemented.  At some point we should disable this by
default and see what breaks; I suspect not much, if anything.

> 2. The kernel disables the packet permission checks entirely when there
> are no iptables SECMARK rules loaded (this is for both performance and
> compatibility) _unless_ the policy defines the always_check_network
> policy capability (cat
> /sys/fs/selinux/policy_capabilities/always_check_network).  The policy
> capabilities are defined in the base policy module.

Please don't enable the always_check_network policy capability, or ask
for it to be backported.  There are better ways to solve this, see
below ...

> A possible alternative would be to use peer labeling (NetLabel or
> labeled IPSEC) configured only for loopback labeling and the net
> egress/ingress permission checks instead of SECMARK.  Examples of
> configuring those mechanisms for loopback only labeling can be found in
> the selinux-testsuite (under tests/inet_socket) and in The SELinux
> Notebook.  However, those checks are also subject to being disabled if
> the peer labeling configuration (NetLabel or labeled IPSEC) is unloaded
> unless always_check_network is set (but they wouldn't be affected by
> flushing iptables).

Stephen is correct about peer labeling, but I believe he got the terms
slightly wrong ... you likely want the static/fallback labeling,
although configuring the labels for loopback traffic is something
you'll want to do as part of it.  The idea is that you want to
configure the kernel to label traffic coming into the system (it
already has a label when it exits, it inherits it from the sending
socket) and then use SELinux to enforce access control policy on this
traffic.  It's the same idea as what you were doing with
netfilter/iptables, but if you use the peer labeling mechanisms you
are not at the whim of someone flushing your iptables config.

The link below give you a simple example of configuring the NetLabel
static/fallback labels, take a look, I think it is what you're looking
for:

 * https://paulmoore.livejournal.com/5536.html

-- 
paul moore
www.paul-moore.com
