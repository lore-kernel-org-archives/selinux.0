From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux <SELinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Makefile patch for policy
Date: Fri, 13 May 2005 18:03:59 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_x9FhCm+TQiXGJfg"
Message-Id: <200505131804.01998.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_x9FhCm+TQiXGJfg
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch is needed to correctly rebuild policy in the case of file 
or directory rename operations.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_x9FhCm+TQiXGJfg
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- Makefile.orig	2005-05-13 18:02:03.000000000 +1000
+++ Makefile	2005-05-13 18:02:44.000000000 +1000
@@ -60,7 +60,7 @@
 POLICYFILES += constraints
 POLICYFILES += $(DEFCONTEXTFILES)
 CONTEXTFILES = $(DEFCONTEXTFILES)
-POLICY_DIRS = domains/program domains/misc
+POLICY_DIRS = domains domains/program domains/misc macros macros/program
 
 UNUSED_TE_FILES := $(wildcard domains/program/unused/*.te)
 

--Boundary-00=_x9FhCm+TQiXGJfg--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
