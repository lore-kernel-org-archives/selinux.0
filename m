Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7UIHgrT006865
	for <selinux@tycho.nsa.gov>; Mon, 30 Aug 2004 14:17:42 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7UIGrAE007480
	for <selinux@tycho.nsa.gov>; Mon, 30 Aug 2004 18:16:54 GMT
Message-ID: <41336F3A.9030002@redhat.com>
Date: Mon, 30 Aug 2004 14:17:30 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>
CC: Russell Coker <russell@coker.com.au>, Tom London <selinux@comcast.net>,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Progress! .532 boots! -- but dbus/hotplug/udev problems remain?
References: <4130CF1B.3090909@comcast.net>	<200408291737.17497.russell@coker.com.au> <20040829100641.GG7610@lkcl.net>
In-Reply-To: <20040829100641.GG7610@lkcl.net>
Content-Type: multipart/mixed;
 boundary="------------060401020906020807060204"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060401020906020807060204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Luke Kenneth Casson Leighton wrote:

>btw i didn't see an acknowledgement from the person who sent the
>last udev patch (dan was it you?)
>
>the use of the "mode" argument it is clear has not been used,
>to call i think it was matchpathcon.
>
>instead, because i had three near-identical code portions all
>of which had different S_IFXXX thingies, dan-i-think-it-was
>moved the near-identical code into a function with a "mode"
>argument...
>
>... and forgot to use the "mode" argument such that matchpathcon
>is called with S_IFDIR.
>
>given that i haven't seen an acknowledgement of this issue
>either in my inbox or on the mailing lists (which i am checking
>manually) i thought it best to hassle people until i know it's
>been spotted.
>
>this is IMPORTANT because it will impact the contexts on
>inodes and stuff created in /dev: the "optimising" argument
>"mode" passed to matchpathcon and setfscreatecon, if wrong,
>results in relevant (and correct!) file_context entries being
>skipped!
>
>l.
>
>On Sun, Aug 29, 2004 at 05:37:17PM +1000, Russell Coker wrote:
>
>  
>
>>On Sun, 29 Aug 2004 04:29, Tom London <selinux@comcast.net> wrote:
>>    
>>
>>>Newest Rawhide updates (including udev-030-10, mkinitrd-4.1.8-1,
>>>kernel-2.6.8-1.532, and selinux-policy-strict-1.17.5-2)
>>>now boots in strict/enforcing.
>>>      
>>>
>>I've attached a diff against the CVS policy as well as the .te and .fc files 
>>for udev changes which fix this and address some other issues as well.
>>    
>>
>--
>fedora-selinux-list mailing list
>fedora-selinux-list@redhat.com
>http://www.redhat.com/mailman/listinfo/fedora-selinux-list
>  
>
Yes it was me and I modified out udev rpm, but I guess I never 
responded.  Sorry about that.

Luke thanks for the fix.

Dan

--------------060401020906020807060204
Content-Type: text/plain;
 name="udev-030-selinux.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="udev-030-selinux.patch"

--- udev-030/Makefile.selinux	2004-07-09 13:59:09.000000000 -0400
+++ udev-030/Makefile	2004-08-27 09:28:25.000000000 -0400
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
--- udev-030/selinux.h.selinux	2004-08-27 15:27:32.211405217 -0400
+++ udev-030/selinux.h	2004-08-27 15:26:31.620370476 -0400
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
+		if (matchpathcon(file, mode, &scontext) < 0) {
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

--------------060401020906020807060204--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
