Message-ID: <412E20AF.7000102@redhat.com>
Date: Thu, 26 Aug 2004 13:41:03 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Bill Nottingham <notting@redhat.com>, harald@redhat.com,
   SELinux <SELinux@tycho.nsa.gov>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   linux-hotplug-devel@lists.sourceforge.net
Subject: Re: Cleaned up udev-selinux patch
References: <20040223213614.GA12242@devserv.devel.redhat.com> <20040224233859.GA3265@kroah.com> <20040224234652.GA14775@devserv.devel.redhat.com> <403C8AE4.10403@redhat.com> <20040228005300.GA13860@kroah.com> <412DFE7B.6060409@redhat.com> <20040826155716.GA30726@kroah.com>
In-Reply-To: <20040826155716.GA30726@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------070503030402070202070504"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070503030402070202070504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:

>On Thu, Aug 26, 2004 at 11:15:07AM -0400, Daniel J Walsh wrote:
>  
>
>>This will create the security contexts on the fly.
>>
>>Please comment on what would be needed to get this acceptable?
>>    
>>
>
>Same things I said on the mailing list:
>	- fix coding style
>	- no ifdefs in .c files
>	- make the selinux stuff all be in its own file
>	- make the build flag look like the other build flags
>	- not make the makefile changes have silly line continuations
>	  when not needed :)
>	- post the patch on the mailing list (linux-hotplug-devel) for
>	  others to comment on after fixing the above.
>
>thanks,
>
>greg k-h
>  
>
Another pass at a cleaned up patch.  This time attempting to folow Greg 
guidelines.

Dan


--------------070503030402070202070504
Content-Type: text/x-patch;
 name="udev-030-selinux.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="udev-030-selinux.patch"

--- /dev/null	2004-06-21 15:29:38.000000000 -0400
+++ udev-030/selinux.h	2004-08-26 13:14:05.730808665 -0400
@@ -0,0 +1,87 @@
+#ifndef SELINUX_H
+#define SELINUX_H
+
+#ifndef USE_SELINUX
+#define set_selinux_set_context(file, mode)     do { } while (0)
+#define selinux_setup_context(file, mode)       do { } while (0)
+#define selinux_init()                          do { } while (0)
+#define selinux_restore()                       do { } while (0)
+
+#else
+
+#include <selinux/selinux.h>
+
+static int selinux_enabled=-1;
+static security_context_t prev_scontext=NULL;
+
+#undef is_selinux_running
+static inline int is_selinux_running(void) {
+	if ( selinux_enabled==-1 ) 
+		return selinux_enabled=is_selinux_enabled()>0;
+	return selinux_enabled;
+}
+#undef selinux_set_context
+static inline void selinux_set_context(char *file, unsigned int mode) { 
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
+#undef selinux_setup_context
+static inline void selinux_setup_context(char *file, unsigned int mode) {
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
+#undef selinux_init
+static inline void selinux_init(void) {
+	/* record the present security context, for file-creation
+	 * restoration creation purposes.
+	 *
+	 * we're going to assume that between now and the time that
+	 * this context is restored that the only filecreation of any
+	 * kind to occur will be mknod, symlink and mkdirs.
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
+#undef selinux_restore
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
--- udev-030/udev-add.c.selinux	2004-08-26 13:06:56.098297558 -0400
+++ udev-030/udev-add.c	2004-08-26 13:22:39.521226968 -0400
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
+			selinux_setup_context(p, S_IFDIR);
 			retval = mkdir(p, 0755);
 			if (retval != 0) {
 				dbg("mkdir(%s) failed with error '%s'",
@@ -117,6 +120,7 @@
 	if (((stats.st_mode & S_IFMT) == S_IFBLK || (stats.st_mode & S_IFMT) == S_IFCHR) &&
 	    (stats.st_rdev == makedev(major, minor))) {
 		dbg("preserve file '%s', cause it has correct dev_t", file);
+		selinux_set_context(file,stats.st_mode);
 		if (udev_preserve_owner)
 		  goto exit;
 		else
@@ -129,6 +133,7 @@
 		dbg("already present file '%s' unlinked", file);
 
 create:
+	selinux_setup_context(file, mode);
 	retval = mknod(file, mode, makedev(major, minor));
 	if (retval != 0) {
 		dbg("mknod(%s, %#o, %u, %u) failed with error '%s'",
@@ -307,6 +312,7 @@
 
 		dbg("symlink(%s, %s)", linktarget, filename);
 		if (!fake) {
+			selinux_setup_context(filename, S_IFLNK);
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
+++ udev-030/Makefile	2004-08-26 13:06:56.138293168 -0400
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

--------------070503030402070202070504--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
