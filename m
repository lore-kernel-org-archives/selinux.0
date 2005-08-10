Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7AB73Ob000506
	for <selinux@tycho.nsa.gov>; Wed, 10 Aug 2005 07:07:03 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7AAx57C020021
	for <selinux@tycho.nsa.gov>; Wed, 10 Aug 2005 10:59:06 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 7921161B0E
	for <selinux@tycho.nsa.gov>; Wed, 10 Aug 2005 20:59:05 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 29597-04 for <selinux@tycho.nsa.gov>;
	Wed, 10 Aug 2005 20:59:05 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 1EEDD61B0C
	for <selinux@tycho.nsa.gov>; Wed, 10 Aug 2005 20:59:05 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: spamassassin policy
Date: Wed, 10 Aug 2005 20:59:00 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_33d+CZq2BgN7dLM"
Message-Id: <200508102059.03930.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_33d+CZq2BgN7dLM
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch seems necessary for spamassassin to work correctly.  
Without it spamassassin on my system will categorise everything as spam.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_33d+CZq2BgN7dLM
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- macros/program/spamassassin_macros.te.orig	2005-08-10 16:03:08.000000000 +1000
+++ macros/program/spamassassin_macros.te	2005-08-10 16:04:22.000000000 +1000
@@ -84,7 +84,8 @@
 
 spamassassin_agent_privs($1_spamassassin_t, $1)
 
-# set tunable if you have spamassassin do DNS lookups
+can_resolve($1_spamassassin_t)
+# set tunable if you give spamassassin full network access.
 if (spamassasin_can_network) {
 can_network($1_spamassassin_t)
 allow $1_spamassassin_t port_type:tcp_socket name_connect;

--Boundary-00=_33d+CZq2BgN7dLM--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
