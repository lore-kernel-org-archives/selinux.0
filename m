Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA13001
	for <selinux@tycho.nsa.gov>; Thu, 19 Sep 2002 09:55:48 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA13247
	for <selinux@tycho.nsa.gov>; Thu, 19 Sep 2002 13:54:03 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id NAA13243 for <selinux@tycho.nsa.gov>; Thu, 19 Sep 2002 13:54:00 GMT
Date: Thu, 19 Sep 2002 09:55:08 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: logging error
In-Reply-To: <200209191050.04728.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0209190948370.8887-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 19 Sep 2002, Russell Coker wrote:

> I'm seeing messages such as the following, I believe that this must be wrong.
> 192.5.41.40 is an address not in my range.  203.15.120.110 is a ppp modem
> user.  klogd is not involved in the communication...
>
> Sep 19 18:45:57 caesar kernel: avc:  denied  { udp_send } for  pid=341
> exe=/sbin/klogd saddr=192.5.41.40 source=17680 daddr=203.15.120.110 dest=76
> netif=ppp0 scontext=system_u:object_r:netmsg_eth1_t
> tcontext=system_u:object_r:netif_t tclass=netif
> Sep 19 18:45:57 caesar kernel:
> Sep 19 18:45:57 caesar kernel: avc:  denied  { udp_send } for  pid=341
> exe=/sbin/klogd saddr=192.5.41.40 source=17680 daddr=203.15.120.110 dest=76
> netif=ppp0 scontext=system_u:object_r:netmsg_eth1_t
> tcontext=system_u:object_r:node_t tclass=node

The current process information (pid, exe) is unreliable when the check is
performed as part of network input processing, but avc_audit reports
whatever auxiliary information appears to be available.  Looks like a
packet received on eth1 (and thus assigned netmsg_eth1_t) is being
forwarded to ppp0.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
