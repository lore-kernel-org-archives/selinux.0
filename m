Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6BNVdHa006806
	for <selinux@tycho.nsa.gov>; Fri, 11 Jul 2003 19:31:39 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6BNVcH5004332
	for <selinux@tycho.nsa.gov>; Fri, 11 Jul 2003 23:31:38 GMT
Received: from chris.pebenito.dhs.org (12-251-184-225.client.attbi.com [12.251.184.225])
        by jazzband.ncsc.mil  with ESMTP id h6BNVbRX004329 for <selinux@tycho.nsa.gov>; Fri, 11 Jul 2003 23:31:38 GMT
Subject: Re: Updated Release
From: "Christopher J. PeBenito" <pebenito@ieee.org>
To: Howard Holm <hdholm@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1057952464.5561.322.camel@moss-sooners.epoch.ncsc.mil>
References: <1057952464.5561.322.camel@moss-sooners.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1057966291.1514.50.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: 11 Jul 2003 18:31:31 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've been trying out the updated kernel patches, and I'm noticing a some
different behavior with the nfs lockd and rpciod.  With this release,
they're starting up in kernel_t:

 1057    344 system_u:system_r:portmap_t              [portmap]
 1135    346 system_u:system_r:rpcd_t                 [rpc.statd]
 1211    346 system_u:system_r:rpcd_t                 [nfsd]
 1212    346 system_u:system_r:rpcd_t                 [nfsd]
 1213    346 system_u:system_r:rpcd_t                 [nfsd]
 1214    346 system_u:system_r:rpcd_t                 [nfsd]
 1215      1 system_u:system_r:kernel_t               [lockd]
 1216      1 system_u:system_r:kernel_t                \_ [rpciod]
 1217    346 system_u:system_r:rpcd_t                 [nfsd]
 1218    346 system_u:system_r:rpcd_t                 [nfsd]
 1219    346 system_u:system_r:rpcd_t                 [nfsd]
 1220    346 system_u:system_r:rpcd_t                 [nfsd]
 1224    346 system_u:system_r:rpcd_t                 [rpc.mountd]

Its causing a couple denials:

avc:  denied  { recvfrom } for  pid=1216 comm=rpciod saddr=127.0.0.1
source=799 daddr=127.0.0.1 dest=111 netif=lo
scontext=system_u:system_r:portmap_t tcontext=system_u:system_r:kernel_t
tclass=udp_socket
avc:  denied  { recvfrom } for  pid=1215 comm=lockd saddr=127.0.0.1
source=800 daddr=127.0.0.1 dest=890 netif=lo
scontext=system_u:system_r:rpcd_t tcontext=system_u:system_r:kernel_t
tclass=udp_socket
avc:  denied  { recvfrom } for  pid=1135 exe=/sbin/rpc.statd
saddr=127.0.0.1 source=890 daddr=127.0.0.1 dest=800 netif=lo
scontext=system_u:system_r:kernel_t tcontext=system_u:system_r:rpcd_t
tclass=udp_socket
avc:  denied  { write } for  pid=1215 comm=lockd lport=32770
scontext=system_u:system_r:kernel_t tcontext=system_u:system_r:rpcd_t
tclass=udp_socket

However, I immediately restart with the previous release kerenel, w/o
relabelling or any other change, and they start up in rpcd_t:

 1109    342 system_u:system_r:portmap_t              [portmap]
 1182    344 system_u:system_r:rpcd_t                 [rpc.statd]
 1211    344 system_u:system_r:rpcd_t                 [nfsd]
 1212    344 system_u:system_r:rpcd_t                 [nfsd]
 1213    344 system_u:system_r:rpcd_t                 [nfsd]
 1214    344 system_u:system_r:rpcd_t                 [nfsd]
 1215    344 system_u:system_r:rpcd_t                 [nfsd]
 1216    344 system_u:system_r:rpcd_t                 [nfsd]
 1217    344 system_u:system_r:rpcd_t                 [nfsd]
 1218    344 system_u:system_r:rpcd_t                 [nfsd]
 1220    344 system_u:system_r:rpcd_t                 [lockd]
 1221    344 system_u:system_r:rpcd_t                  \_ [rpciod]
 1224    344 system_u:system_r:rpcd_t                 [rpc.mountd]

Is this intended?


On Fri, 2003-07-11 at 14:41, Howard Holm wrote:
> The SELinux web site <http://www.nsa.gov/selinux/> including the mail
> list archive has been updated. The base kernel versions have been
> updated to 2.5.74 and 2.4.21.
-- 
Chris PeBenito
<pebenito@ieee.org>
AIM: PeBenito78
ICQ#: 10434387

"Engineering does not require science. Science helps
a lot, but people built perfectly good brick walls 
long before they knew why cement works."-Alan Cox

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
