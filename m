Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA05648
	for <selinux@tycho.nsa.gov>; Mon, 4 Feb 2002 12:01:23 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA04822
	for <selinux@tycho.nsa.gov>; Mon, 4 Feb 2002 17:00:34 GMT
Received: from khaipur.xiat.org ([66.125.68.98])
	by jazzswing.ncsc.mil  with ESMTP id RAA04818
	for <selinux@tycho.nsa.gov>; Mon, 4 Feb 2002 17:00:33 GMT
Date: Mon, 04 Feb 2002 08:52:47 -0800
From: Paul Krumviede <pwk@acm.org>
To: Stephen Smalley <sds@tislabs.com>
cc: selinux <selinux@tycho.nsa.gov>
Subject: Re: strange audit messages from the dhcpc_t domain
Message-ID: <137812083.1012812767@localhost>
In-Reply-To: <Pine.GSO.4.33.0202040942430.5419-100000@raven>
References: <Pine.GSO.4.33.0202040942430.5419-100000@raven>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--On Monday, 04 February, 2002 10:07 -0500 Stephen Smalley 
<sds@tislabs.com> wrote:

>
> On Sat, 2 Feb 2002, Paul Krumviede wrote:
>
>> 1)	Feb  1 04:02:05 fermat kernel: avc:  denied  { recvfrom } for
>> pid=2235 exe=/usr/sbin/sendmail saddr=0.4.172.16 daddr=218.138.0.0
>> 	netif=eth1 scontext=system_u:system_r:dhcpc_t
>> 	tcontext=system_u:object_r:netmsg_eth1_t tclass=packet_socket
>>
>> why is sendmail running in the dhcpc_t domain? and the saddr and daddr
>> values look
>> mangled.
>
> The recvfrom permission check is performed between the security context of
> the receiving socket (inherited by default from the process that created
> the socket) and the security context of the packet.  For permission checks
> performed during a network input operation, you can't rely on the current
> process information (the 'pid' and the 'exe'), because 'current' may be
> set to a process that is unrelated to the network operation.  Hence,
> sendmail is not running in the dhcpc_t domain; the failure is occurring on
> a socket created by dhcpcd due to a lack of this permission in dhcpc.te.

OK. i had been assuming that the permission check was finding the
process owning the socket to which the packet is destined, but that
seems to be incorrect.

> At present, the dhcpc.te file only grants recvfrom permission for eth0,
> but you can add permission for eth1 (or, more generally, use the
> 'netmsg_type' attribute in place of a specific type to grant access to
> messages received on any network device).

i was reluctant to grant this permission until i knew why i was seeing
such messages.

> With regard to the saddr and daddr, this is a bug in the AVC audit code -
> it fails to test the skb->protocol field to verify that the protocol is
> IP, so it is extracting IP header fields from a packet that may not have
> an IP header.

i was wondering if it might have been an off-by-2 error, as an address
matching legitimate addresses on the subnet in question seemed to be
split across the saddr and daddr fields.

thanks,
-paul


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
