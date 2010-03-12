Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2CJ6SNq009688
	for <selinux@tycho.nsa.gov>; Fri, 12 Mar 2010 14:06:36 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o2CJ74jN023870
	for <selinux@tycho.nsa.gov>; Fri, 12 Mar 2010 19:07:05 GMT
Received: from int-mx03.intmail.prod.int.phx2.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o2CJ6Sna008428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 12 Mar 2010 14:06:29 -0500
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by int-mx03.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o2CJ6RYW019451
	for <selinux@tycho.nsa.gov>; Fri, 12 Mar 2010 14:06:28 -0500
Message-ID: <4B9A90B3.3050901@redhat.com>
Date: Fri, 12 Mar 2010 14:06:27 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: Not sure if I sent this one out with the others but since it has
 not been updated yet...
Content-Type: multipart/mixed;
 boundary="------------020708080505070900010600"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020708080505070900010600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fixes libsepol.pc file.

--------------020708080505070900010600
Content-Type: text/plain;
 name="libsepol-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libsepol-rhat.patch"

Only in libsepol-2.0.41: #ChangeLog#
diff -u -r nsalibsepol/src/libsepol.pc.in libsepol-2.0.41/src/libsepol.pc.in
--- nsalibsepol/src/libsepol.pc.in	2009-11-02 12:58:30.000000000 -0500
+++ libsepol-2.0.41/src/libsepol.pc.in	2010-02-18 10:02:35.000000000 -0500
@@ -1,6 +1,6 @@
 prefix=@prefix@
 exec_prefix=${prefix}
-libdir=${exec_prefix}/lib
+libdir=${exec_prefix}/@libdir@
 includedir=@includedir@
 
 Name: libsepol
Only in libsepol-2.0.41/src: libsepol.pc.in~
diff -u -r nsalibsepol/src/Makefile libsepol-2.0.41/src/Makefile
--- nsalibsepol/src/Makefile	2009-11-02 12:58:30.000000000 -0500
+++ libsepol-2.0.41/src/Makefile	2010-02-18 10:04:51.000000000 -0500
@@ -3,6 +3,7 @@
 INCLUDEDIR ?= $(PREFIX)/include
 LIBDIR ?= $(PREFIX)/lib
 SHLIBDIR ?= $(DESTDIR)/lib
+LIBBASE=$(shell basename $(LIBDIR))
 
 VERSION = $(shell cat ../VERSION)
 LIBVERSION = 1
@@ -27,7 +28,7 @@
 	ln -sf $@ $(TARGET) 
 
 $(LIBPC): $(LIBPC).in
-	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBDIR):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
+	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
 
 %.o:  %.c 
 	$(CC) $(CFLAGS) -fPIC -c -o $@ $<

--------------020708080505070900010600--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
