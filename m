Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j34DAsDo029449
	for <selinux@tycho.nsa.gov>; Mon, 4 Apr 2005 09:10:54 -0400 (EDT)
Received: from hermes.domdv.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j34D8rW6013167
	for <selinux@tycho.nsa.gov>; Mon, 4 Apr 2005 13:08:54 GMT
Message-ID: <42513C67.7020604@domdv.de>
Date: Mon, 04 Apr 2005 15:08:55 +0200
From: Andreas Steinmetz <ast@domdv.de>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: fix setfiles segfault caused by libselinux-1.22
Content-Type: multipart/mixed;
 boundary="------------040408000402040702060809"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040408000402040702060809
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

setfiles does reset user defined functions by calling the related setup
function with NULL as argument. Instead of resetting to the default
these setup functions did set up NULL as the function pointer. Fix attached.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de

--------------040408000402040702060809
Content-Type: text/plain;
 name="libselinux-1.22.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-1.22.diff"

--- libselinux-1.22.orig/src/matchpathcon.c	2005-04-04 15:01:14.000000000 +0200
+++ libselinux-1.22/src/matchpathcon.c	2005-04-04 15:01:23.000000000 +0200
@@ -29,7 +29,10 @@
 
 void set_matchpathcon_printf(void (*f)(const char *fmt, ...))
 {
-	myprintf = f;
+	if (f)
+		myprintf = f;
+	else
+		myprintf = &default_printf;
 }
 
 static int default_invalidcon(const char *path, unsigned lineno, char *context)
@@ -45,7 +48,10 @@
 
 void set_matchpathcon_invalidcon(int (*f)(const char *p, unsigned l, char *c))
 {
-	myinvalidcon = f;
+	if (f)
+		myinvalidcon = f;
+	else
+		myinvalidcon = &default_invalidcon;
 }
 
 /*

--------------040408000402040702060809--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
