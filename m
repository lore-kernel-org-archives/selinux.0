Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n31EM0gM023034
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 10:22:00 -0400
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n31ELxN0013655
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 14:21:59 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n31ELs3F029160
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 10:21:54 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n31ELtBT031703
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 10:21:55 -0400
Received: from dhcp-100-2-12.bos.redhat.com (dhcp-100-2-12.bos.redhat.com [10.16.2.12])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n31ELsiv029118
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 10:21:54 -0400
Message-ID: <49D37881.6040102@redhat.com>
Date: Wed, 01 Apr 2009 10:21:53 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: We have moved matchpathcon to /sbin from /usr/sbin
Content-Type: multipart/mixed;
 boundary="------------090306090902010902020109"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090306090902010902020109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Some init scripts wanted to use matchpathcon before /usr is mounted.

--------------090306090902010902020109
Content-Type: text/plain;
 name="matchpathcon_makefile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="matchpathcon_makefile.patch"

--- nsalibselinux/utils/Makefile	2009-03-06 14:41:45.000000000 -0500
+++ libselinux-2.0.79/utils/Makefile	2009-03-27 10:09:31.000000000 -0400
@@ -2,28 +2,33 @@
 PREFIX ?= $(DESTDIR)/usr
 LIBDIR ?= $(PREFIX)/lib
 BINDIR ?= $(PREFIX)/sbin
+_BINDIR ?= $(DESTDIR)/sbin
 
 CFLAGS ?= -Wall
 override CFLAGS += -I../include -D_GNU_SOURCE $(EMFLAGS)
 LDLIBS += -L../src -lselinux -L$(LIBDIR)
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
+
+
 ifeq ($(DISABLE_AVC),y)
 	UNUSED_TARGETS+=compute_av compute_create compute_member compute_relabel
 endif
 ifeq ($(DISABLE_BOOL),y)
 	UNUSED_TARGETS+=getsebool togglesebool
 endif
-TARGETS:= $(filter-out $(UNUSED_TARGETS), $(TARGETS))
+TARGETS:= $(filter-out $(UNUSED_TARGETS) matchpathcon, $(TARGETS))
 
-all: $(TARGETS)
+all: $(TARGETS) matchpathcon
 
 install: all
 	-mkdir -p $(BINDIR)
 	install -m 755 $(TARGETS) $(BINDIR)
-
+	-mkdir -p $(_BINDIR)
+	install -m 755 matchpathcon $(_BINDIR)
+	(cd $(BINDIR); 	ln -fs ../../sbin/matchpathcon)
 clean:
-	rm -f $(TARGETS) *.o 
+	rm -f $(TARGETS) *.o *~
 
 indent:
 	../../scripts/Lindent $(wildcard *.[ch])

--------------090306090902010902020109--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
