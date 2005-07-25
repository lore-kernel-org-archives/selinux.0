Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6PIRRgA025654
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 14:27:29 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6PIM8eR003419
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 18:22:08 GMT
Subject: Re: Iptables discussion
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: James Morris <jmorris@redhat.com>,
   Casey Schaufler <casey@schaufler-ca.com>, gyurdiev@redhat.com,
   Joshua Brindle <jbrindle@tresys.com>,
   Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <42E50756.5030302@redhat.com>
References: <20050724152822.95995.qmail@web34310.mail.mud.yahoo.com>
	 <Lynx.SEL.4.62.0507250019380.21934@thoron.boston.redhat.com>
	 <42E50756.5030302@redhat.com>
Content-Type: text/plain
Date: Mon, 25 Jul 2005 14:24:28 -0400
Message-Id: <1122315868.13068.200.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-07-25 at 11:37 -0400, Daniel J Walsh wrote:
> With the current way that policy is written all devices get the 
> netif_type by default.  This type is then only used in the can_network 
> macros. 
> 
> define(`base_can_network',`
> ...
> #
> # Allow the domain to send or receive using any network interface.
> # netif_type is a type attribute for all network interface types.
> #
> allow $1 netif_type:netif { $2_send rawip_send };
> allow $1 netif_type:netif { $2_recv rawip_recv };
> ...
> 
> 
> Since we would want to take this ability away from a specific device,
> we would need some kind of boolean or tunable to take away the
> netif_type for say the ethernet device.

I think the better way would be to change the way the policy works,
rather then conditionally applying the attribute.  The default should
probably be to not have any netifcon statements except for interfaces we
want different behavior.  The above macro would be changed to use
netif_t as the target, rather then netif_type.  Then all interface types
still keep the netif_type attribute, so the privilege of using all
interfaces still exists, if needed, but since there are no netifcons,
all interfaces fall back to the initial sid type (netif_t).  When the
user wants different behaviors for a specific interface, then the tool
would add the netifcon to the policy, and add the appropriate rules to
the policy.

To make this work better, then the can_network*() macros could be
modified to have an additional optional parameter to specify which
interface(s) to use.  Then if the interface is supplied, the specified
interface type is used; otherwise, the generic interface (netif_t) is
used.

So you could have:

can_network(apache_t)

and then to change it to only use eth0,

can_network(apache_t,eth0_netif_t)

and label the external interface in net_contexts:

netifcon eth0 system_u:object_r:eth0_netif_t system_u:object_r:unlabeled_t

or perhaps the type could just be shortened to just eth0, and the type
name inferred.  This would then just result in a one line policy change,
and a netifcon for each specified interface.

The reference policy does not have the can_network() style macros, but
rather specifies ports, nodes, and netifs interfaces separately, so this
would also be fairly simple.  So the apache policy might start out with
this:

corenet_tcp_sendrecv_generic_if(apache_t)

to use generic (netif_t) interfaces, and to make it use the "external"
interfaces eth1 and eth2, we just change it to

corenet_tcp_sendrecv_external_if(apache_t)

and label the external interfaces by adding this in corenetwork:

network_interface(external, eth1,s0, eth2,s0)

(sensitivity would be dropped on non MLS policies)

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
