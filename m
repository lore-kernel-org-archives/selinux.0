Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6CC1GHa007849
	for <selinux@tycho.nsa.gov>; Sat, 12 Jul 2003 08:01:17 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6CC0InJ008368
	for <selinux@tycho.nsa.gov>; Sat, 12 Jul 2003 12:00:18 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h6CC0Fhr008365
	for <selinux@tycho.nsa.gov>; Sat, 12 Jul 2003 12:00:16 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 86E78BF4E
	for <selinux@tycho.nsa.gov>; Sat, 12 Jul 2003 22:01:12 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 11459-09
 for <selinux@tycho.nsa.gov>; Sat, 12 Jul 2003 22:01:11 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 9D009BF49
	for <selinux@tycho.nsa.gov>; Sat, 12 Jul 2003 22:01:10 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 56AE4924EC
	for <selinux@tycho.nsa.gov>; Sat, 12 Jul 2003 22:01:10 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 672757F0D3
	for <selinux@tycho.nsa.gov>; Sat, 12 Jul 2003 22:01:07 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: another patch for the new release
Date: Sat, 12 Jul 2003 22:01:06 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Ci/D/JN06LDX5QN"
Message-Id: <200307122201.06936.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_Ci/D/JN06LDX5QN
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I think that it is desirable that when a user is authorized for user_r and 
staff_r that staff_r is the default.

I patched spasswd to have svigr, and to fix a bug in the Makefile with 
creating a directory.

xstat_conv.h doesn't work for me, it seems that struct kern_stat not struct 
stat is required.  Haven't fully tested this yet but at least it makes it 
compile.

A couple of minor changes to the devfsd shared object that I've posted here a 
couple of times but which don't seem to make it.

Also a patch to the makefile to make it compile on HPPA.  Of course it doesn't 
really do much good without HPPA kernel support.  ;)

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_Ci/D/JN06LDX5QN
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="diff"

--- selinux-small-2003071106.orig/utils/appconfig/default_contexts
+++ selinux-small-2003071106/utils/appconfig/default_contexts
@@ -1,3 +1,3 @@
-system_r:local_login_t  user_r:user_t staff_r:staff_t
-system_r:sshd_t		user_r:user_t staff_r:staff_t
-system_r:crond_t	user_r:user_crond_t staff_r:staff_crond_t system_r:system_crond_t
+system_r:local_login_t  staff_r:staff_t user_r:user_t
+system_r:sshd_t		staff_r:staff_t user_r:user_t
+system_r:crond_t	staff_r:staff_crond_t user_r:user_crond_t system_r:system_crond_t
--- selinux-small-2003071106.orig/utils/spasswd/Makefile
+++ selinux-small-2003071106/utils/spasswd/Makefile
@@ -14,12 +14,13 @@
 GROUPDEL=/usr/sbin/groupdel
 GROUPMOD=/usr/sbin/groupmod
 VIPW=/usr/sbin/vipw
+VIGR=/usr/sbin/vigr
 
 CFLAGS += -Wall -g -I$(INCDIR)
 LDFLAGS += -static -L$(LIBDIR)
 LIBS += -lsecure
 
-PROGS = spasswd sadminpasswd suseradd suserdel svipw schfn schsh sgpasswd susermod \
+PROGS = spasswd sadminpasswd suseradd suserdel svipw svigr schfn schsh sgpasswd susermod \
 	sgroupadd sgroupdel sgroupmod
 
 all:  $(PROGS)
@@ -42,6 +43,9 @@
 svipw.o: spasswd.c
 	$(CC) $(CFLAGS) -DADMIN_USE -DPASSWD=\"$(VIPW)\" -c -o $@ $<
 
+svigr.o: spasswd.c
+	$(CC) $(CFLAGS) -DADMIN_USE -DPASSWD=\"$(VIGR)\" -c -o $@ $<
+
 schfn.o: spasswd.c
 	$(CC) $(CFLAGS) -DPASSWD=\"$(CHFN)\" -c -o $@ $<
 
@@ -64,7 +68,7 @@
 	$(CC) $(CFLAGS) -DADMIN_USE  -DPASSWD=\"$(GROUPMOD)\" -c -o $@ $<
 
 install: all
-	test -d $(BINDIR) || install -m 755 -o root -g root $(BINDIR)
+	test -d $(BINDIR) || install -m 755 -d -o root -g root $(BINDIR)
 	install -m 555 -o root -g root $(PROGS) $(BINDIR)
 
 clean:
--- selinux-small-2003071106.orig/libsecure/src/xstat_conv.h
+++ selinux-small-2003071106/libsecure/src/xstat_conv.h
@@ -36,7 +36,7 @@
 
     case _STAT_VER_LINUX:
       {
-	struct stat *buf = ubuf;
+	struct kernel_stat *buf = ubuf;
 
 	/* Convert to current kernel version of `struct stat'.  */
 	buf->st_dev = kbuf->st_dev;
--- selinux-small-2003071106.orig/devfsd/devfsd-conflet
+++ selinux-small-2003071106/devfsd/devfsd-conflet
@@ -1,23 +1,7 @@
-REGISTER ^(kmem|mem|port)	CFUNCTION devfsd-se.so set_sid $devname system_u:object_r:memory_device_t
-REGISTER ^u?random	CFUNCTION devfsd-se.so set_sid $devname system_u:object_r:random_device_t
-REGISTER ^tty		CFUNCTION devfsd-se.so set_sid $devname system_u:object_r:devtty_t
-REGISTER /disc$		CFUNCTION devfsd-se.so set_sid $devname system_u:object_r:fixed_disk_device_t
-REGISTER /part[0-9]+$	CFUNCTION devfsd-se.so set_sid $devname system_u:object_r:fixed_disk_device_t
-REGISTER ^[mr]d/[0-9]+$	CFUNCTION devfsd-se.so set_sid $devname system_u:object_r:fixed_disk_device_t
+REGISTER ^nb[^/]+$	CFUNCTION devfsd-se.so set_sid $devname system_u:object_r:fixed_disk_device_t
 REGISTER [0-9]/cd$	CFUNCTION devfsd-se.so set_sid $devname system_u:object_r:removable_device_t
-REGISTER ^floppy/	CFUNCTION devfsd-se.so set_sid $devname system_u:object_r:removable_device_t
-REGISTER ^misc/rtc	CFUNCTION devfsd-se.so set_sid $devname system_u:object_r:clock_device_t
 REGISTER ^initctl	CFUNCTION devfsd-se.so set_sid $devname system_u:object_r:initctl_t
-REGISTER ^printers/	CFUNCTION devfsd-se.so set_sid $devname system_u:object_r:printer_t
-REGISTER ^input/(mouse|mice|event)	CFUNCTION devfsd-se.so set_sid $devname system_u:object_r:mouse_device_t
-REGISTER ^misc/psaux	CFUNCTION devfsd-se.so set_sid $devname system_u:object_r:mouse_device_t
 REGISTER ^gpmctl	CFUNCTION devfsd-se.so set_sid $devname system_u:object_r:gpmctl_t
-REGISTER ^ptmx		CFUNCTION devfsd-se.so set_sid $devname system_u:object_r:ptmx_t
-REGISTER ^sound/	CFUNCTION devfsd-se.so set_sid $devname system_u:object_r:sound_device_t
-REGISTER ^agpgart	CFUNCTION devfsd-se.so set_sid $devname system_u:object_r:agp_device_t
 REGISTER ^dri		CFUNCTION devfsd-se.so set_sid $devname system_u:object_r:dri_device_t
-REGISTER ^misc/apm_bios	CFUNCTION devfsd-se.so set_sid $devname system_u:object_r:apm_bios_t
-REGISTER ^ppp$		CFUNCTION devfsd-se.so set_sid $devname system_u:object_r:ppp_device_t
-REGISTER ^fb/.*$	CFUNCTION devfsd-se.so set_sid $devname system_u:object_r:framebuf_device_t
-
-
+REGISTER ^sound/.*	CFUNCTION devfsd-se.so set_sid $devname system_u:object_r:sound_device_t
+REGISTER ^pts/.*	IGNORE
--- selinux-small-2003071106.orig/devfsd/devfsd-se.c
+++ selinux-small-2003071106/devfsd/devfsd-se.c
@@ -19,7 +19,7 @@
 {
   security_id_t sid;
   struct stat buf;
-  const char * const initial_context = "system_u:object_r:devfs_t";
+  const char * const initial_context = "system_u:object_r:device_t";
   const char * const no_context = "system_u:object_r:unlabeled_t";
 
   if(is_flask_enabled())
--- selinux-small-2003071106.orig/module/Makefile
+++ selinux-small-2003071106/module/Makefile
@@ -6,7 +6,7 @@
 FLASKDIR=$(PREFIX)/flask
 INCDIR=$(PREFIX)/include
 
-ARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ -e s/arm.*/arm/ -e s/sa110/arm/)
+ARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ -e s/arm.*/arm/ -e s/sa110/arm/ -e s/parisc.*/hppa/)
 
 # Build the checkpolicy program.
 all:

--Boundary-00=_Ci/D/JN06LDX5QN--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
