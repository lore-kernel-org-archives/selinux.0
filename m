Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA17855
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 14:32:39 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA25084
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 18:31:10 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id SAA25080 for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 18:31:10 GMT
Date: Thu, 11 Jul 2002 14:31:47 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Simon Han <simonhan@ee.ucla.edu>
cc: <selinux@tycho.nsa.gov>
Subject: Re: dhcpc_t
In-Reply-To: <Pine.GSO.4.10.10207111032020.19504-100000@centauri.ee.ucla.edu>
Message-ID: <Pine.GSO.4.33.0207111425000.21775-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 11 Jul 2002, Simon Han wrote:

> 	It seems to me that normal user needs to have packet_socket
> permission.  Of course, I can add directly to macros/user_mmacros.te, but
> I would like to seek for advice before doing so since packet_socket is
> relatively powerful.

That wouldn't be a good idea, and it is not necessary for the audit
messages you showed.  In each message, the denial was caused when the
AF_PACKET socket created by dhcpcd received a packet from another domain.
Hence, at most, you would add a rule to dhcpc.te permitting dhcpcd to
receive packets from any domain (e.g. allow dhcpc_t domain:packet_socket
recvfrom;).  I'm not even sure whether this is necessary for the operation
of dhcpcd; you might be able to just use dontaudit to suppress these
messages and silently drop these packets from the dhcpcd socket.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
