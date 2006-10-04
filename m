Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k94D5XQN012969
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 09:05:33 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k94D4wCa027890
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 13:04:58 GMT
Message-ID: <36282A1733C57546BE392885C0618592015CF81A@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        redhat-lspp@redhat.com
Subject: RE: [redhat-lspp] Networking policy patch
Date: Wed, 4 Oct 2006 09:05:15 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> +# netmsg is now used for the unconditional (and redundant 
> when a packet has
> +# already been flow-controlled via [CONN]SECMARK) check that 
> happens in the
> +# SELinux post_route_last netfilter hook for ALL network traffic.
> +# The following would need packet.flow_out access to network_t:
> +# a. Any domains needing to access the network bypassing 
> (CONN)SECMARK.
The following also applies to item 'a' here:
	  These domains will also need packet.flow_in access to network_t.
> +# b. Outbound domains specified in the (CONN)SECMARK rule 
> contexts specified
> +#    via iptables. This shouldn't actually be needed (just 
> like a packet.flow_in access
> +#    of these domains to network_t isn't needed), but is 
> currently required due to the
> +#    underlying kernel implementation constraints.
> +type network_t;
> +sid netmsg		
> gen_context(system_u:object_r:network_t,s0 - s15:c0.c255)
> +
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
