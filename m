Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA18562
	for <selinux@tycho.nsa.gov>; Mon, 15 Apr 2002 08:55:55 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA05487
	for <selinux@tycho.nsa.gov>; Mon, 15 Apr 2002 12:54:16 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA05483
	for <selinux@tycho.nsa.gov>; Mon, 15 Apr 2002 12:54:15 GMT
Date: Mon, 15 Apr 2002 08:55:24 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: network policy problems
In-Reply-To: <20020414204323.0561A22A7A@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0204150848540.24406-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 14 Apr 2002, Russell Coker wrote:

> I'm getting messages similar to this for a number of daemons.
>
> It seems that the dhcp daemon has claimed the eth0 interface in some way, and
> a number of daemons think that they are receiving from it when (AFAIK) they
> aren't.
>
> avc:  denied  { recvfrom } for  pid=1250 exe=/usr/sbin/radvd netif=eth0
> scontext=system_u:system_r:dhcpd_t tcontext=system_u:system_r:radvd_t
> tclass=packet_socket

This message simply indicates that a packet sent by radvd has been
received on a PF_PACKET socket created by dhcpd.  The pid and exe
information is unreliable in this case since this check is performed as
part of network input processing, but avc_audit reports all
auxiliary information that appears to be available.

> Actually I'm a bit unclear on the more technical aspects of network policy,
> is there any published document describing it clearly and in detail?

The original technical report (http://www.nsa.gov/selinux/slinux-abs.html)
describes each of the networking permissions in detail.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
