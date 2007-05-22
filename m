Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4MJOa9R002974
	for <selinux@tycho.nsa.gov>; Tue, 22 May 2007 15:24:36 -0400
Received: from atlrel6.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4MJOak3016362
	for <selinux@tycho.nsa.gov>; Tue, 22 May 2007 19:24:36 GMT
From: Paul Moore <paul.moore@hp.com>
To: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Subject: Re: AVC: IPv6 problems
Date: Tue, 22 May 2007 15:24:28 -0400
Cc: SELinux List <selinux@tycho.nsa.gov>
References: <6AA1314E-2718-446E-BFC9-6961DE951E09@sf-net.com>
In-Reply-To: <6AA1314E-2718-446E-BFC9-6961DE951E09@sf-net.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705221524.28541.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, May 22 2007 2:22:09 pm Stefan Schulze Frielinghaus wrote:
> periodically I receive the following AVC denial:
>
> audit(1179815459.477:213): avc:  denied  { rawip_send } for
> saddr=fe80:0000:0000:0000:0211:d8ff:feea:XXXX
> daddr=fe80:0000:0000:0000:0211:24ff:fee1:YYYY netif=eth0
> scontext=system_u:system_r:kernel_t:s15:c0.c255
> tcontext=system_u:object_r:link_local_node_t:s0 tclass=node
>
> My local rule-set:
>
> allow kernel_t link_local_node_t:node rawip_send;
> # another AVC denial which often raises up
> allow kernel_t compat_ipv4_node_t:node rawip_send;
>
> The rules seem to be ignored. Every day I receive some of the
> mentioned AVC denials despite the fact that the TE rules are loaded.
> Is this a known problem with IPv6 traffic in LANs? Is there even a
> solution out?

The problem doesn't appear to be related to the TE rules, but rather with the 
MLS sensitivity labels.  The kernel is running with a very high sensitivity 
label (s15:c0.c255) and it trying to write/send to a node with a very low 
sensitivity label (s0) which I believe violates the MLS constraints unless 
the kernel_t domain or link_local_node_t object has a type attribute which 
provides MLS overrides.

It's hard to say what the solution is because it most likely depends on what 
you are trying to do.  You might want to share your goals with the list and 
perhaps we can help, otherwise I would recommend you look at the MLS 
reference policy interfaces.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
