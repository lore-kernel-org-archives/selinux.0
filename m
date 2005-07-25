Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6PL7jgA027653
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 17:07:45 -0400 (EDT)
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6PL1aAP014161
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 21:01:36 GMT
Message-ID: <36282A1733C57546BE392885C0618592AF2E21@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   Daniel J Walsh
	 <dwalsh@redhat.com>
Cc: James Morris <jmorris@redhat.com>,
   Casey Schaufler
	 <casey@schaufler-ca.com>, gyurdiev@redhat.com,
   Joshua Brindle
	 <jbrindle@tresys.com>,
   Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov
Subject: RE: Iptables discussion
Date: Mon, 25 Jul 2005 17:04:44 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> 
> I think the better way would be to change the way the policy works,
> rather then conditionally applying the attribute.  The default should
> probably be to not have any netifcon statements except for interfaces we
> want different behavior.  The above macro would be changed to use
> netif_t as the target, rather then netif_type.  Then all interface types
> still keep the netif_type attribute, so the privilege of using all
> interfaces still exists, if needed, but since there are no netifcons,
> all interfaces fall back to the initial sid type (netif_t).  When the
> user wants different behaviors for a specific interface, then the tool
> would add the netifcon to the policy, and add the appropriate rules to
> the policy.
> 
> To make this work better, then the can_network*() macros could be
> modified to have an additional optional parameter to specify which
> interface(s) to use.  Then if the interface is supplied, the specified
> interface type is used; otherwise, the generic interface (netif_t) is
> used.
> 
> So you could have:
> 
> can_network(apache_t)
> 
> and then to change it to only use eth0,
> 
> can_network(apache_t,eth0_netif_t)
> 
> and label the external interface in net_contexts:
> 
> netifcon eth0 system_u:object_r:eth0_netif_t 
> system_u:object_r:unlabeled_t
> 
> or perhaps the type could just be shortened to just eth0, and the type
> name inferred.  This would then just result in a one line 
> policy change,
> and a netifcon for each specified interface.

There is a problem with virtual interfaces here as they contain colons I
believe.

> 
> The reference policy does not have the can_network() style macros, but
> rather specifies ports, nodes, and netifs interfaces 
> separately, so this
> would also be fairly simple.  So the apache policy might 
> start out with
> this:
> 
> corenet_tcp_sendrecv_generic_if(apache_t)
> 
> to use generic (netif_t) interfaces, and to make it use the "external"
> interfaces eth1 and eth2, we just change it to
> 
> corenet_tcp_sendrecv_external_if(apache_t)
> 
> and label the external interfaces by adding this in corenetwork:
> 
> network_interface(external, eth1,s0, eth2,s0)
> 
> (sensitivity would be dropped on non MLS policies)
> 

I like the ideas above and think they sound reasonable.  

-Chad

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
