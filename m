Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1868B53025095
	for <selinux@tycho.nsa.gov>; Tue, 8 Feb 2005 01:08:12 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1868BZa007589
	for <selinux@tycho.nsa.gov>; Tue, 8 Feb 2005 06:08:13 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 205F261B00
	for <selinux@tycho.nsa.gov>; Tue,  8 Feb 2005 17:08:03 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 15518-10 for <selinux@tycho.nsa.gov>;
	Tue, 8 Feb 2005 17:08:02 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id ACB4161AFF
	for <selinux@tycho.nsa.gov>; Tue,  8 Feb 2005 17:08:02 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: Policy makefile
Date: Tue, 8 Feb 2005 17:07:27 +1100
Cc: Karsten Wade <kwade@redhat.com>, dwalsh@redhat.com
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_icFCC2X1dDdc80H"
Message-Id: <200502081707.30822.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_icFCC2X1dDdc80H
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch will cause policy.conf to be rebuilt when a .te file is 
removed from domains/misc or domains/program, or if a file is added to those 
directories that is not newer than policy.conf (EG moving a file from the 
unused directory).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_icFCC2X1dDdc80H
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- Makefile.orig	2005-02-08 17:03:39.000000000 +1100
+++ Makefile	2005-02-08 17:05:10.000000000 +1100
@@ -46,6 +46,7 @@
 POLICYFILES += $(ALL_TUNABLES) $(TE_RBAC_FILES)
 POLICYFILES += $(USER_FILES)
 POLICYFILES += constraints initial_sid_contexts fs_use genfs_contexts net_contexts
+POLICY_DIRS = domains/program domains/misc
 
 UNUSED_TE_FILES := $(wildcard domains/program/unused/*.te)
 
@@ -146,9 +147,9 @@
 	grep -v dontaudit policy.conf > policy.audit
 	mv policy.audit policy.conf
 
-policy.conf: $(POLICYFILES) 
+policy.conf: $(POLICYFILES) $(POLICY_DIRS)
 	mkdir -p tmp
-	m4 $(M4PARAM) -Imacros -s $^ > $@.tmp
+	m4 $(M4PARAM) -Imacros -s $(POLICYFILES) > $@.tmp
 	mv $@.tmp $@
 
 install-src: 

--Boundary-00=_icFCC2X1dDdc80H--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
