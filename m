Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j34C8RDo029069
	for <selinux@tycho.nsa.gov>; Mon, 4 Apr 2005 08:08:27 -0400 (EDT)
Received: from hermes.domdv.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j34C6RW6008898
	for <selinux@tycho.nsa.gov>; Mon, 4 Apr 2005 12:06:28 GMT
Message-ID: <42512DC5.8060102@domdv.de>
Date: Mon, 04 Apr 2005 14:06:29 +0200
From: Andreas Steinmetz <ast@domdv.de>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: build fixes for selinux-doc-1.18
Content-Type: multipart/mixed;
 boundary="------------030802090407020101070001"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030802090407020101070001
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

1. added simple top level Makefile
2. replaced db2html with docbook2html as db2html is not part of
   docbook-utils but seems to be created by some distro only
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de

--------------030802090407020101070001
Content-Type: text/plain;
 name="selinux-doc-1.18.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="selinux-doc-1.18.diff"

diff -rNu selinux-doc-1.18.orig/Makefile selinux-doc-1.18/Makefile
--- selinux-doc-1.18.orig/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ selinux-doc-1.18/Makefile	2005-04-04 00:12:35.000000000 +0200
@@ -0,0 +1,4 @@
+subdirs=module uavc policy
+
+all:
+	for i in $(subdirs) ; do make -C $$i || exit 1 ; done
diff -rNu selinux-doc-1.18.orig/module/Makefile selinux-doc-1.18/module/Makefile
--- selinux-doc-1.18.orig/module/Makefile	2004-02-26 21:36:44.000000000 +0100
+++ selinux-doc-1.18/module/Makefile	2005-04-04 00:05:49.000000000 +0200
@@ -20,7 +20,7 @@
 
 $(HTML): $(ALL)
 	-$(RM) -r $@
-	db2html $(TOP)
+	docbook2html $(TOP)
 	if [ ! -z "$(JPG-$@)" ]; then cp $(JPG-$@) $@; fi
 
 clean:
diff -rNu selinux-doc-1.18.orig/policy/Makefile selinux-doc-1.18/policy/Makefile
--- selinux-doc-1.18.orig/policy/Makefile	2004-02-26 21:36:47.000000000 +0100
+++ selinux-doc-1.18/policy/Makefile	2005-04-04 00:05:58.000000000 +0200
@@ -20,7 +20,7 @@
 
 $(HTML): $(ALL)
 	-$(RM) -r $@
-	db2html $(TOP)
+	docbook2html $(TOP)
 	if [ ! -z "$(JPG-$@)" ]; then cp $(JPG-$@) $@; fi
 
 clean:
diff -rNu selinux-doc-1.18.orig/uavc/Makefile selinux-doc-1.18/uavc/Makefile
--- selinux-doc-1.18.orig/uavc/Makefile	2004-05-29 01:57:26.000000000 +0200
+++ selinux-doc-1.18/uavc/Makefile	2005-04-04 00:06:06.000000000 +0200
@@ -20,7 +20,7 @@
 
 $(HTML): $(ALL)
 	-$(RM) -r $@
-	db2html $(TOP)
+	docbook2html $(TOP)
 	if [ ! -z "$(JPG-$@)" ]; then cp $(JPG-$@) $@; fi
 
 clean:

--------------030802090407020101070001--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
