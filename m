Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o1OJZATk024435
	for <selinux@tycho.nsa.gov>; Wed, 24 Feb 2010 14:35:10 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o1OJZRvp022627
	for <selinux@tycho.nsa.gov>; Wed, 24 Feb 2010 19:35:27 GMT
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o1OJZ7SR024168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Wed, 24 Feb 2010 14:35:08 -0500
Received: from localhost.localdomain (vpn-11-226.rdu.redhat.com [10.11.11.226])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o1OJZ79T020811
	for <selinux@tycho.nsa.gov>; Wed, 24 Feb 2010 14:35:07 -0500
Message-ID: <4B857F6B.7050503@redhat.com>
Date: Wed, 24 Feb 2010 14:35:07 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: updated libselinux pkgconfig does not work correctly on lib64 machines.
References: <4B857CDE.7010303@redhat.com>
In-Reply-To: <4B857CDE.7010303@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------090309020408010607080305"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090309020408010607080305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 02/24/2010 02:24 PM, Daniel J Walsh wrote:
>
Ignore the first patch it was missing pc.in files.

--------------090309020408010607080305
Content-Type: text/plain;
 name="selinux_pkgconfig.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="selinux_pkgconfig.patch"

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index cfd72e2..bf665ab 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -11,6 +11,7 @@ RUBYLIBVER ?= $(shell ruby -e 'print RUBY_VERSION.split(".")[0..1].join(".")')
 RUBYPLATFORM ?= $(shell ruby -e 'print RUBY_PLATFORM')
 RUBYINC ?= $(LIBDIR)/ruby/$(RUBYLIBVER)/$(RUBYPLATFORM)
 RUBYINSTALL ?= $(LIBDIR)/ruby/site_ruby/$(RUBYLIBVER)/$(RUBYPLATFORM)
+LIBBASE=$(shell basename $(LIBDIR))
 
 VERSION = $(shell cat ../VERSION)
 LIBVERSION = 1
@@ -85,7 +86,7 @@ $(LIBSO): $(LOBJS)
 	ln -sf $@ $(TARGET) 
 
 $(LIBPC): $(LIBPC).in
-	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBDIR):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
+	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
 
 selinuxswig_python_exception.i: ../include/selinux/selinux.h
 	bash exception.sh > $@ 
diff --git a/libselinux/src/libselinux.pc.in b/libselinux/src/libselinux.pc.in
index 9b3808b..5691559 100644
--- a/libselinux/src/libselinux.pc.in
+++ b/libselinux/src/libselinux.pc.in
@@ -1,6 +1,6 @@
 prefix=@prefix@
 exec_prefix=${prefix}
-libdir=${exec_prefix}/lib
+libdir=${exec_prefix}/@libdir@
 includedir=@includedir@
 
 Name: libselinux
diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index 67afc60..003b6f2 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -10,6 +10,7 @@ RUBYLIBVER ?= $(shell ruby -e 'print RUBY_VERSION.split(".")[0..1].join(".")')
 RUBYPLATFORM ?= $(shell ruby -e 'print RUBY_PLATFORM')
 RUBYINC ?= $(LIBDIR)/ruby/$(RUBYLIBVER)/$(RUBYPLATFORM)
 RUBYINSTALL ?= $(LIBDIR)/ruby/site_ruby/$(RUBYLIBVER)/$(RUBYPLATFORM)
+LIBBASE=$(shell basename $(LIBDIR))
 
 DEFAULT_SEMANAGE_CONF_LOCATION=$(DESTDIR)/etc/selinux/semanage.conf
 
@@ -47,7 +48,7 @@ OBJS= $(patsubst %.c,%.o,$(SRCS)) conf-scan.o conf-parse.o
 LOBJS= $(patsubst %.c,%.lo,$(SRCS)) conf-scan.lo conf-parse.lo
 CFLAGS ?= -Wall -W -Wundef -Wshadow -Wmissing-noreturn -Wmissing-format-attribute -Wno-unused-parameter
 
-override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE 
+override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE -fPIC
 
 SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./
 
@@ -82,7 +83,7 @@ $(LIBSO): $(LOBJS)
 	ln -sf $@ $(TARGET)
 
 $(LIBPC): $(LIBPC).in
-	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBDIR):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
+	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
 
 conf-scan.c: conf-scan.l conf-parse.h
 	$(LEX) $(LFLAGS) -t $< > $@
diff --git a/libsemanage/src/libsemanage.pc.in b/libsemanage/src/libsemanage.pc.in
index d0945f8..81e1805 100644
--- a/libsemanage/src/libsemanage.pc.in
+++ b/libsemanage/src/libsemanage.pc.in
@@ -1,6 +1,6 @@
 prefix=@prefix@
 exec_prefix=${prefix}
-libdir=${exec_prefix}/lib
+libdir=${exec_prefix}/@libdir@
 includedir=@includedir@
 
 Name: libsemanage
diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
index 3b19e37..73fdef8 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -3,6 +3,7 @@ PREFIX ?= $(DESTDIR)/usr
 INCLUDEDIR ?= $(PREFIX)/include
 LIBDIR ?= $(PREFIX)/lib
 SHLIBDIR ?= $(DESTDIR)/lib
+LIBBASE=$(shell basename $(LIBDIR))
 
 VERSION = $(shell cat ../VERSION)
 LIBVERSION = 1
@@ -27,7 +28,7 @@ $(LIBSO): $(LOBJS)
 	ln -sf $@ $(TARGET) 
 
 $(LIBPC): $(LIBPC).in
-	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBDIR):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
+	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
 
 %.o:  %.c 
 	$(CC) $(CFLAGS) -fPIC -c -o $@ $<
diff --git a/libsepol/src/libsepol.pc.in b/libsepol/src/libsepol.pc.in
index bc7635c..e52f589 100644
--- a/libsepol/src/libsepol.pc.in
+++ b/libsepol/src/libsepol.pc.in
@@ -1,6 +1,6 @@
 prefix=@prefix@
 exec_prefix=${prefix}
-libdir=${exec_prefix}/lib
+libdir=${exec_prefix}/@libdir@
 includedir=@includedir@
 
 Name: libsepol

--------------090309020408010607080305--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
