Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8QLZKrT028781
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 17:35:20 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8QLZJhU011592
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 21:35:19 GMT
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id EE92FBFCB
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 22:35:13 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1CBgqf-00083I-5G
	for selinux@tycho.nsa.gov; Sun, 26 Sep 2004 22:46:25 +0100
Date: Sun, 26 Sep 2004 22:46:25 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: BUG: looks like net contexts is being ignored
Message-ID: <20040926214625.GK28076@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

i'm using cvs linux2.6 from 2 weeks ago.
latest cvs policy, tools and libs selinux-usr.

the bug is that any tcp or udp port access by any program appears to be
attempted as reserved_port_t.

e.g:

denied { name_bind } for /sbin/dhclient
scontext=system_u:system_r:dhcpc_t
tcontext=system_u_object_r:reserved_port_t tclass=udp_socket
  
  and

denied { name_bind } for /usr/sbin/sshd src=22
scontext=system_u:system_r:sshd_t
tcontext=system_u_object_r:reserved_port_t tclass=tcp_socket

zero modifications to net_contexts have been made.

okay i admit it i made some mods to fs/proc/base.c to split up a
function in order use 98% of that function somewhere else.

also i reduced autofs4's NEGATIVE_TIMEOUT from 60 seconds to 5.

nothing significant or what i would call relevant.

l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
