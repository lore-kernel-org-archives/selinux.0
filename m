Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBGItqRb027086
	for <selinux@tycho.nsa.gov>; Tue, 16 Dec 2003 13:55:52 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBGIt2jx013641
	for <selinux@tycho.nsa.gov>; Tue, 16 Dec 2003 18:55:02 GMT
Received: from mail.gmx.net (pop.gmx.net [213.165.64.20])
	by jazzswing.ncsc.mil  with SMTP id hBGIt0SR013548
	for <selinux@tycho.nsa.gov>; Tue, 16 Dec 2003 18:55:01 GMT
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: ramsdell@mitre.org (John D. Ramsdell)
Subject: slat makefiles
Date: Tue, 16 Dec 2003 19:52:29 +0100
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tR13/RjyrmJbqBn"
Message-Id: <200312161952.29595.carstengrohmann@gmx.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_tR13/RjyrmJbqBn
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi John,

today I've problems to build a slat rpm with your spec file. The 
attached patch adds $DESTDIR to some makefiles to install all files 
to the right destination like /var/tmp/slat.../ .

Greetings

Carsten

--Boundary-00=_tR13/RjyrmJbqBn
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="slat-1.0.1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="slat-1.0.1.patch"

diff -ur slat-1.0.1.orig/doc/Makefile.in slat-1.0.1/doc/Makefile.in
--- slat-1.0.1.orig/doc/Makefile.in	2003-11-05 14:07:21.000000000 +0100
+++ slat-1.0.1/doc/Makefile.in	2003-12-16 19:40:38.000000000 +0100
@@ -52,10 +52,10 @@
 	done
 
 install:	all
-	$(INSTALL_DATA) $(BASE_NAME).pdf $(pkgdatadir)/$(BASE_NAME).pdf
+	$(INSTALL_DATA) $(BASE_NAME).pdf $(DESTDIR)/$(pkgdatadir)/$(BASE_NAME).pdf
 
 uninstall:
-	rm -f $(pkgdatadir)/$(BASE_NAME).pdf
+	rm -f $(DESTDIR)/$(pkgdatadir)/$(BASE_NAME).pdf
 
 distclean:	clean
 	-rm Makefile
diff -ur slat-1.0.1.orig/ml/Makefile.in slat-1.0.1/ml/Makefile.in
--- slat-1.0.1.orig/ml/Makefile.in	2003-11-05 14:07:21.000000000 +0100
+++ slat-1.0.1/ml/Makefile.in	2003-12-16 19:42:11.000000000 +0100
@@ -136,14 +136,14 @@
 
 install:	all
 	@list='$(PROGRAMS)'; for p in $$list; do \
-	  echo " $(INSTALL_PROGRAM) $$p $(bindir)/$$p"; \
-	  $(INSTALL_PROGRAM) $$p $(bindir)/$$p; \
+	  echo " $(INSTALL_PROGRAM) $$p $(DESTDIR)/$(bindir)/$$p"; \
+	  $(INSTALL_PROGRAM) $$p $(DESTDIR)/$(bindir)/$$p; \
 	done
 
 uninstall:
 	@list='$(PROGRAMS)'; for p in $$list; do \
-	  echo " rm -f $(bindir)/$$p"; \
-	  rm -f $(bindir)/$$p; \
+	  echo " rm -f $(DESTDIR)/$(bindir)/$$p"; \
+	  rm -f $(DESTDIR)/$(bindir)/$$p; \
 	done
 
 # Dependency checking

--Boundary-00=_tR13/RjyrmJbqBn--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
