Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i72MNnrT016751
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 18:23:49 -0400 (EDT)
Date: Mon, 2 Aug 2004 22:25:20 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>,
   Linux Hotplug Dev List <linux-hotplug-devel@lists.sourceforge.net>
Subject: Re: matchfilecon (the program) vs matchfilecon (the libselinux1 fn)
Message-ID: <20040802212520.GC6260@lkcl.net>
References: <20040801172751.GD20103@lkcl.net> <1091455223.23449.66.camel@moss-spartans.epoch.ncsc.mil> <20040802145724.GG4194@lkcl.net> <1091458325.23449.102.camel@moss-spartans.epoch.ncsc.mil> <20040802191243.GJ4194@lkcl.net> <1091474356.23449.272.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FkmkrVfFsRoUs1wW"
In-Reply-To: <1091474356.23449.272.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

p.s. setting permissions on symlinks was missed out, too.

_and_ directories.  darn.

l.

-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility if acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=f

--- Makefile.orig	2004-08-02 22:23:58.000000000 +0100
+++ Makefile	2004-08-02 22:24:01.000000000 +0100
@@ -25,6 +25,8 @@
 # Leave this set to `false' for production use.
 DEBUG = true
 
+# Set this to compile with Security-Enhanced Linux support.
+WITH_SELINUX = true
 
 ROOT =		udev
 DAEMON =	udevd
@@ -39,6 +41,7 @@
 LOCAL_CFG_DIR =	etc/udev
 HOTPLUG_EXEC =	$(ROOT)
 
+
 DESTDIR =
 
 KERNEL_DIR = /lib/modules/${shell uname -r}/build
@@ -172,6 +175,13 @@
 
 CFLAGS += -I$(PWD)/libsysfs
 
+ifeq ($(strip $(WITH_SELINUX)),true)
+	LIB_OBJS +=	\
+			-lselinux
+	CFLAGS += \
+		-DWITH_SELINUX
+endif
+
 all: $(ROOT) $(SENDER) $(DAEMON) $(INFO) $(TESTER) $(STARTER)
 	@extras="$(EXTRAS)" ; for target in $$extras ; do \
 		echo $$target ; \
--- udev-add.c.orig	2004-07-09 18:59:09.000000000 +0100
+++ udev-add.c	2004-08-02 22:23:27.000000000 +0100
@@ -50,6 +50,10 @@
 
 #define LOCAL_USER "$local"
 
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
+#endif
+
 /* 
  * Right now the major/minor of a device is stored in a file called
  * "dev" in sysfs.
@@ -92,7 +96,31 @@
 			break;
 		*pos = 0x00;
 		if (stat(p, &stats)) {
+#ifdef WITH_SELINUX
+			int seretval = 0;
+			security_context_t scontext;
+		   if (is_selinux_enabled() > 0)
+		   {
+				seretval = matchpathcon(p, 0, &scontext);
+				if (seretval < 0) {
+					dbg("matchpathcon(%s) failed\n", p);
+				} else {
+					seretval=setfscreatecon(scontext);
+					if (seretval < 0)
+						dbg("setfiles %s failed with error '%s'",
+					p, strerror(errno));
+				}
+			}
+#endif
 			retval = mkdir(p, 0755);
+#ifdef WITH_SELINUX
+			if (is_selinux_enabled() > 0)
+			{
+			   /* after mkdir, free the context */
+				freecon(scontext);
+			}
+#endif
+									
 			if (retval != 0) {
 				dbg("mkdir(%s) failed with error '%s'",
 				    p, strerror(errno));
@@ -109,6 +137,10 @@
 {
 	struct stat stats;
 	int retval = 0;
+	int seretval = 0;
+#ifdef WITH_SELINUX
+	security_context_t scontext;
+#endif
 
 	if (stat(file, &stats) != 0)
 		goto create;
@@ -117,6 +149,24 @@
 	if (((stats.st_mode & S_IFMT) == S_IFBLK || (stats.st_mode & S_IFMT) == S_IFCHR) &&
 	    (stats.st_rdev == makedev(major, minor))) {
 		dbg("preserve file '%s', cause it has correct dev_t", file);
+#ifdef WITH_SELINUX
+		/* lkcl: maybe someone would like to do the same thing with se/linux
+		 * security contexts (check they are the same) but hey, not me!
+		 */
+	   if (is_selinux_enabled() > 0)
+	   {
+			retval = matchpathcon(file, 0, &scontext);
+			if (retval < 0) {
+				dbg("matchpathcon(%s) failed\n", file);
+			} else {
+				retval=setfilecon(scontext, file);
+				if (retval < 0)
+					dbg("setfiles %s failed with error '%s'",
+				file, strerror(errno));
+				freecon(scontext);
+			}
+		}
+#endif
 		goto perms;
 	}
 
@@ -126,6 +176,21 @@
 		dbg("already present file '%s' unlinked", file);
 
 create:
+#ifdef WITH_SELINUX
+   if (is_selinux_enabled() > 0)
+   {
+		seretval = matchpathcon(file, 0, &scontext);
+		if (seretval < 0) {
+			dbg("matchpathcon(%s) failed\n", file);
+		} else {
+			retval=setfscreatecon(scontext);
+			if (retval < 0)
+				dbg("setfiles %s failed with error '%s'",
+			file, strerror(errno));
+		}
+	}
+#endif
+						    
 	retval = mknod(file, mode, makedev(major, minor));
 	if (retval != 0) {
 		dbg("mknod(%s, %#o, %u, %u) failed with error '%s'",
@@ -133,6 +198,15 @@
 		goto exit;
 	}
 
+#ifdef WITH_SELINUX
+   if (is_selinux_enabled() > 0)
+   {
+	   /* after mknod, free the context */
+		if (seretval == 0)
+			freecon(scontext);
+	}
+#endif
+						    
 perms:
 	dbg("chmod(%s, %#o)", file, mode);
 	if (chmod(file, mode) != 0) {
@@ -150,7 +224,7 @@
 	}
 
 exit:
-	return retval;
+	return retval < 0 ? retval : seretval;
 }
 
 /* get the local logged in user */
@@ -304,10 +378,36 @@
 
 		dbg("symlink(%s, %s)", linktarget, filename);
 		if (!fake) {
+#ifdef WITH_SELINUX
+			int seretval = 0;
+			security_context_t scontext;
+		   if (is_selinux_enabled() > 0)
+		   {
+				seretval = matchpathcon(filename, 0, &scontext);
+				if (seretval < 0) {
+					dbg("matchpathcon(%s) failed\n", filename);
+				} else {
+					seretval=setfscreatecon(scontext);
+					if (seretval < 0)
+						dbg("setfiles %s failed with error '%s'",
+					filename, strerror(errno));
+				}
+			}
+#endif
+									
+
 			unlink(filename);
 			if (symlink(linktarget, filename) != 0)
 				dbg("symlink(%s, %s) failed with error '%s'",
 				    linktarget, filename, strerror(errno));
+#ifdef WITH_SELINUX
+		   if (is_selinux_enabled() > 0)
+		   {
+			   /* after symlink, free the context */
+				freecon(scontext);
+			}
+#endif
+									
 		}
 	}
 

--FkmkrVfFsRoUs1wW--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
