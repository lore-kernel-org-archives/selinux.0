Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8EJ1WNs007737
	for <selinux@tycho.nsa.gov>; Wed, 14 Sep 2005 15:01:33 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8EIwS9v016459
	for <selinux@tycho.nsa.gov>; Wed, 14 Sep 2005 18:58:29 GMT
Received: from [192.168.2.105] (cpe-24-59-125-231.twcny.res.rr.com [24.59.125.231])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j8EIwUSI024741
	for <selinux@tycho.nsa.gov>; Wed, 14 Sep 2005 14:58:30 -0400 (EDT)
Message-ID: <4328745F.9060702@cornell.edu>
Date: Wed, 14 Sep 2005 15:05:03 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: [ SEPOL ] Detach old debug system from new
Content-Type: multipart/mixed;
 boundary="------------000200010505050001060004"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000200010505050001060004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fixes DEBUG.

--------------000200010505050001060004
Content-Type: text/x-patch;
 name="libsepol.fix.debug.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.fix.debug.diff"

diff -Naur libsepol/src/debug.c libsepol.new/src/debug.c
--- libsepol/src/debug.c	2005-09-14 11:44:44.000000000 -0400
+++ libsepol.new/src/debug.c	2005-09-14 14:59:59.000000000 -0400
@@ -42,16 +42,9 @@
 
 void sepol_enable_debug(
 	void (*fn)(const char* fname, const char *fmt, ...)) {
-
 	DEBUG = (fn)? fn: default_printf;	
-
-	/* Compatibility  - old debug system */
-	sepol_debug(1);
 }
 
 void sepol_disable_debug() {
 	DEBUG = suppress_printf;
-
-	/* Compatibility - old debug system */
-	sepol_debug(0);
 }

--------------000200010505050001060004--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
