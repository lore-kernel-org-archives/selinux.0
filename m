Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA19191
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 16:21:26 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA02011
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 20:19:57 GMT
Received: from mail.simplyaquatics.com (66-0-92-223.deltacom.net [66.0.92.223])
        by jazzband.ncsc.mil  with ESMTP id UAA02007 for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 20:19:56 GMT
Reply-To: <blacknet@simplyaquatics.com>
From: "Ed Street" <blacknet@simplyaquatics.com>
To: "'Stephen Smalley'" <sds@tislabs.com>,
        "'Simon Han'" <simonhan@ee.ucla.edu>
Cc: <selinux@tycho.nsa.gov>
Subject: RE: dhcpc_t
Date: Thu, 11 Jul 2002 16:21:24 -0400
Message-ID: <00e101c22918$8775e680$0a01a8c0@ed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <Pine.GSO.4.33.0207111425000.21775-100000@raven>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I can think of a few kiddie wacker toys that would/could make use of
that that allow.

Ed

=> -----Original Message-----
=> From: owner-selinux@tycho.nsa.gov
[mailto:owner-selinux@tycho.nsa.gov] On
=> Behalf Of Stephen Smalley
=> Sent: Thursday, July 11, 2002 2:32 PM
=> To: Simon Han
=> Cc: selinux@tycho.nsa.gov
=> Subject: Re: dhcpc_t
=> 
=> 
=> On Thu, 11 Jul 2002, Simon Han wrote:
=> 
=> > 	It seems to me that normal user needs to have packet_socket
=> > permission.  Of course, I can add directly to
macros/user_mmacros.te,
=> but
=> > I would like to seek for advice before doing so since packet_socket
is
=> > relatively powerful.
=> 
=> That wouldn't be a good idea, and it is not necessary for the audit
=> messages you showed.  In each message, the denial was caused when the
=> AF_PACKET socket created by dhcpcd received a packet from another
domain.
=> Hence, at most, you would add a rule to dhcpc.te permitting dhcpcd to
=> receive packets from any domain (e.g. allow dhcpc_t
domain:packet_socket
=> recvfrom;).  I'm not even sure whether this is necessary for the
=> operation
=> of dhcpcd; you might be able to just use dontaudit to suppress these
=> messages and silently drop these packets from the dhcpcd socket.
=> 
=> --
=> Stephen D. Smalley, NAI Labs
=> ssmalley@nai.com


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
