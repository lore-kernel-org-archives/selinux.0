Message-ID: <412F37D2.7070105@redhat.com>
Date: Fri, 27 Aug 2004 09:32:02 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Bill Nottingham <notting@redhat.com>, harald@redhat.com,
   SELinux <SELinux@tycho.nsa.gov>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   linux-hotplug-devel@lists.sourceforge.net
Subject: Re: Cleaned up udev-selinux patch
References: <20040224233859.GA3265@kroah.com> <20040224234652.GA14775@devserv.devel.redhat.com> <403C8AE4.10403@redhat.com> <20040228005300.GA13860@kroah.com> <412DFE7B.6060409@redhat.com> <20040826155716.GA30726@kroah.com> <412E20AF.7000102@redhat.com> <20040826175139.GA12225@kroah.com> <412E34EB.1030909@redhat.com> <20040826225928.GD6058@lkcl.net> <20040826225640.GA13818@kroah.com>
In-Reply-To: <20040826225640.GA13818@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------090200040601060303010905"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090200040601060303010905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Further cleanup and using all static inlines versus defines.  Renamed a 
couple of functions to make them clearer.

Dan

--------------090200040601060303010905
Content-Type: text/x-patch;
 name="udev-030-selinux.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="udev-030-selinux.patch"

--- /dev/null	2004-06-21 15:29:38.000000000 -0400
+++ udev-030/selinux.h	2004-08-27 09:26:40.160862612 -0400
@@ -0,0 +1,80 @@
+#ifndef SELINUX_H
+#define SELINUX_H
+
+#ifndef USE_SELINUX
+
+static inline void selinux_setfilecon(char *file, unsigned int mode) { }
+static inline void selinux_setfscreatecon(char *file, unsigned int mode) {}
+static inline void selinux_init(void) {}
+static inline void selinux_restore(void) {}
+
+#else
+
+#include <selinux/selinux.h>
+
+static int selinux_enabled=-1;
+static security_context_t prev_scontext=NULL;
+
+static inline int is_selinux_running(void) {
+	if ( selinux_enabled==-1 ) 
+		return selinux_enabled=is_selinux_enabled()>0;
+	return selinux_enabled;
+}
+static inline void selinux_setfilecon(char *file, unsigned int mode) { 
+	if (is_selinux_running()) {
+		security_context_t scontext=NULL;
+		if (matchpathcon(file, mode, &scontext) < 0) {
+			dbg("matchpathcon(%s) failed\n", file);
+		} else {
+			
+			if (setfilecon(file, scontext) < 0)
+				dbg("setfiles %s failed with error '%s'",
+				    file, strerror(errno));
+			freecon(scontext);
+		}
+	}
+}
+
+static inline void selinux_setfscreatecon(char *file, unsigned int mode) {
+	int retval = 0;
+	security_context_t scontext=NULL;
+
+	if (is_selinux_running()) {
+		if (matchpathcon(file, S_IFDIR, &scontext) < 0) {
+			dbg("matchpathcon(%s) failed\n", file);
+		} else {
+			retval=setfscreatecon(scontext);
+			if (retval < 0)
+				dbg("setfiles %s failed with error '%s'",
+				    file, strerror(errno));
+			freecon(scontext);
+		}
+	}
+}
+static inline void selinux_init(void) {
+	/* record the present security context, for file-creation
+	 * restoration creation purposes.
+	 *
+	 */
+
+	if (is_selinux_running())
+	{
+		if (getfscreatecon(&prev_scontext) < 0) {
+			dbg("getfscreatecon failed\n");
+		}
+		prev_scontext=NULL;
+	}
+}
+static inline void selinux_restore(void) {
+	if (is_selinux_running()) {
+		/* reset the file create context to its former glory */
+		if ( setfscreatecon(prev_scontext) < 0 )
+			dbg("setfscreatecon failed\n");
+		if (prev_scontext) {
+			freecon(prev_scontext);
+			prev_scontext=NULL;
+		}
+	}
+}
+#endif /* USE_SELINUX */
+#endif /* SELINUX_H */
--- udev-030/udev-add.c.selinux	2004-08-26 13:06:56.000000000 -0400
+++ udev-030/udev-add.c	2004-08-26 14:16:05.000000000 -0400
@@ -50,6 +50,8 @@
 
 #define LOCAL_USER "$local"
 
+#include "selinux.h"
+
 /* 
  * Right now the major/minor of a device is stored in a file called
  * "dev" in sysfs.
@@ -92,6 +94,7 @@
 			break;
 		*pos = 0x00;
 		if (stat(p, &stats)) {
+			selinux_setfscreatecon(p, S_IFDIR);
 			retval = mkdir(p, 0755);
 			if (retval != 0) {
 				dbg("mkdir(%s) failed with error '%s'",
@@ -117,6 +120,7 @@
 	if (((stats.st_mode & S_IFMT) == S_IFBLK || (stats.st_mode & S_IFMT) == S_IFCHR) &&
 	    (stats.st_rdev == makedev(major, minor))) {
 		dbg("preserve file '%s', cause it has correct dev_t", file);
+		selinux_setfilecon(file,stats.st_mode);
 		if (udev_preserve_owner)
 		  goto exit;
 		else
@@ -129,6 +133,7 @@
 		dbg("already present file '%s' unlinked", file);
 
 create:
+	selinux_setfscreatecon(file, mode);
 	retval = mknod(file, mode, makedev(major, minor));
 	if (retval != 0) {
 		dbg("mknod(%s, %#o, %u, %u) failed with error '%s'",
@@ -307,6 +312,7 @@
 
 		dbg("symlink(%s, %s)", linktarget, filename);
 		if (!fake) {
+			selinux_setfscreatecon(filename, S_IFLNK);
 			unlink(filename);
 			if (symlink(linktarget, filename) != 0)
 				dbg("symlink(%s, %s) failed with error '%s'",
@@ -441,6 +447,7 @@
 
 	dbg("name='%s'", dev.name);
 
+	selinux_init();
 	switch (dev.type) {
 	case 'b':
 	case 'c':
@@ -478,6 +485,7 @@
 	}
 
 exit:
+	selinux_restore();
 	sysfs_close_class_device(class_dev);
 
 	return retval;
--- udev-030/Makefile.selinux	2004-07-09 13:59:09.000000000 -0400
+++ udev-030/Makefile	2004-08-27 09:28:25.080035864 -0400
@@ -25,6 +25,8 @@
 # Leave this set to `false' for production use.
 DEBUG = false
 
+# Set this to compile with Security-Enhanced Linux support.
+USE_SELINUX = true
 
 ROOT =		udev
 DAEMON =	udevd
@@ -172,6 +174,11 @@
 
 CFLAGS += -I$(PWD)/libsysfs
 
+ifeq ($(strip $(USE_SELINUX)),true)
+	CFLAGS += -DUSE_SELINUX
+	LIB_OBJS += -lselinux
+endif
+
 all: $(ROOT) $(SENDER) $(DAEMON) $(INFO) $(TESTER) $(STARTER)
 	@extras="$(EXTRAS)" ; for target in $$extras ; do \
 		echo $$target ; \
@@ -216,6 +223,7 @@
 		udevdb.h	\
 		klibc_fixups.h	\
 		logging.h	\
+		selinux.h	\
 		list.h
 
 ifeq ($(strip $(USE_KLIBC)),true)

--------------090200040601060303010905--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
