Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h38CCJI4020442
	for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2003 08:12:19 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h38C8bOv008417
	for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2003 12:08:37 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h38C8bY1008414
	for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2003 12:08:37 GMT
Subject: Re: ipv6 tunnel problem.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Kurt Roeckx <Q@ping.be>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20030405232837.GA14825@ping.be>
References: <20030405232837.GA14825@ping.be>
Content-Type: text/plain
Date: 08 Apr 2003 08:12:26 -0400
Message-Id: <1049803947.1606.6.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2003-04-05 at 18:28, Kurt Roeckx wrote:
> I'm not exactly sure what causes it, but I got those 2 messages a
> few times so far:
> 
> avc:  denied  { rawip_send } for  pid=3789
> exe=/usr/local/ircd/sbin/ircd saddr=x.x.x.x
> daddr=y.y.y.y netif=eth0
> scontext=system_u:object_r:unlabeled_t
> tcontext=system_u:object_r:netif_eth0_t tclass=netif
> 
> avc:  denied  { rawip_send } for  saddr=x.x.x.x
> daddr=y.y.y.y netif=eth0
> scontext=system_u:object_r:unlabeled_t
> tcontext=system_u:object_r:netif_eth0_t tclass=netif
> 
> x.x.x.x is the local ipv4 address, and y.y.y.y is the ipv4
> endpoint of my ipv6 (sit) tunnel.

The LSM patch does not presently include hooks for IPv6, so some of the
SELinux processing won't be applied to IPv6.  If you aren't actually
using the SELinux networking functionality, you might want to just
disable CONFIG_SECURITY_NETWORK to omit it.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
