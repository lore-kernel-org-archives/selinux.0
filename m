Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA04705
	for <selinux@tycho.nsa.gov>; Mon, 4 Feb 2002 10:07:54 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA23226
	for <selinux@tycho.nsa.gov>; Mon, 4 Feb 2002 15:07:00 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id PAA23222 for <selinux@tycho.nsa.gov>; Mon, 4 Feb 2002 15:07:00 GMT
Date: Mon, 4 Feb 2002 10:07:14 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Paul Krumviede <pwk@acm.org>
cc: selinux <selinux@tycho.nsa.gov>
Subject: Re: strange audit messages from the dhcpc_t domain
In-Reply-To: <22613336.1012639388@localhost>
Message-ID: <Pine.GSO.4.33.0202040942430.5419-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 2 Feb 2002, Paul Krumviede wrote:

> 1)	Feb  1 04:02:05 fermat kernel: avc:  denied  { recvfrom } for  pid=2235
> 	exe=/usr/sbin/sendmail saddr=0.4.172.16 daddr=218.138.0.0 netif=eth1
> 	scontext=system_u:system_r:dhcpc_t
> 	tcontext=system_u:object_r:netmsg_eth1_t tclass=packet_socket
>
> why is sendmail running in the dhcpc_t domain? and the saddr and daddr
> values look
> mangled.

The recvfrom permission check is performed between the security context of
the receiving socket (inherited by default from the process that created
the socket) and the security context of the packet.  For permission checks
performed during a network input operation, you can't rely on the current
process information (the 'pid' and the 'exe'), because 'current' may be
set to a process that is unrelated to the network operation.  Hence,
sendmail is not running in the dhcpc_t domain; the failure is occurring on
a socket created by dhcpcd due to a lack of this permission in dhcpc.te.
At present, the dhcpc.te file only grants recvfrom permission for eth0,
but you can add permission for eth1 (or, more generally, use the
'netmsg_type' attribute in place of a specific type to grant access to
messages received on any network device).

With regard to the saddr and daddr, this is a bug in the AVC audit code -
it fails to test the skb->protocol field to verify that the protocol is
IP, so it is extracting IP header fields from a packet that may not have
an IP header.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
