Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i74AwPrT027235
	for <selinux@tycho.nsa.gov>; Wed, 4 Aug 2004 06:58:25 -0400 (EDT)
Received: from smtp800.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i74AwNWC013637
	for <selinux@tycho.nsa.gov>; Wed, 4 Aug 2004 10:58:23 GMT
Date: Wed, 4 Aug 2004 12:09:31 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Hannes Reinecke <hare@suse.de>
Cc: SE-Linux <selinux@tycho.nsa.gov>,
   Linux Hotplug Dev List <linux-hotplug-devel@lists.sourceforge.net>
Subject: Re: [patch] udev-selinux: restores file security context and sets mode in matchpathcon
Message-ID: <20040804110931.GB3878@lkcl.net>
References: <20040803152623.GE4043@lkcl.net> <4110AD53.70800@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
In-Reply-To: <4110AD53.70800@suse.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

duh!

On Wed, Aug 04, 2004 at 11:33:07AM +0200, Hannes Reinecke wrote:
> Luke Kenneth Casson Leighton wrote:
> >okay, updated.
> >
> >this is an experimental patch.
> >
> [ .. ]
> >the reason for using this patch is because of speed:
> >if matchpathcon is used in the same process, the lookups etc.
> >are cached.
> >
> >a reason for _not_ using this patch is for a udev in initrd
> >where the smaller klibc is used.  it would be necessary to add
> >rexeg to klibc and to compile a special libselinux1 with it.
> >
> >if you do not intend to put udev into an initrd, this patch is
> >perfectly acceptable for use.
> >
> >l.
> So where is it then?
> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke			hare@suse.de
> SuSE Linux AG				S390 & zSeries
> Maxfeldstra?e 5				+49 911 74053 688
> 90409 N?rnberg				http://www.suse.de

-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility if acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=f

--- udev-add.c.orig	2004-07-09 18:59:09.000000000 +0100
+++ udev-add.c	2004-08-03 16:21:59.000000000 +0100
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
+				seretval = matchpathcon(p, S_IFDIR, &scontext);
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
+			retval = matchpathcon(file, mode, &scontext);
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
+		seretval = matchpathcon(file, mode, &scontext);
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
@@ -150,7 +224,11 @@
 	}
 
 exit:
+#ifdef WITH_SELINUX
+	return retval < 0 ? retval : seretval;
+#else
 	return retval;
+#endif
 }
 
 /* get the local logged in user */
@@ -304,10 +382,36 @@
 
 		dbg("symlink(%s, %s)", linktarget, filename);
 		if (!fake) {
+#ifdef WITH_SELINUX
+			int seretval = 0;
+			security_context_t scontext;
+		   if (is_selinux_enabled() > 0)
+		   {
+				seretval = matchpathcon(filename, S_IFLNK, &scontext);
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
 
@@ -403,6 +507,11 @@
 	char *pos;
 	int retval;
 
+#ifdef WITH_SELINUX
+	int seretval;
+	security_context_t prev_scontext;
+#endif
+
 	memset(&dev, 0x00, sizeof(dev));
 
 	dev.type = get_device_type(path, subsystem);
@@ -438,6 +547,23 @@
 
 	dbg("name='%s'", dev.name);
 
+#ifdef WITH_SELINUX
+	/* record the present security context, for file-creation
+	 * restoration creation purposes.
+	 *
+	 * we're going to assume that between now and the time that
+	 * this context is restored that the only filecreation of any
+	 * kind to occur will be mknod, symlink and mkdirs.
+	 */
+
+	if (is_selinux_enabled() > 0)
+	{
+		seretval = getfscreatecon(&prev_scontext);
+		if (seretval < 0) {
+			dbg("getfscreatecon failed\n");
+		}
+	}
+#endif
 	switch (dev.type) {
 	case 'b':
 	case 'c':
@@ -474,6 +600,16 @@
 		break;
 	}
 
+#ifdef WITH_SELINUX
+	if (is_selinux_enabled() > 0)
+	{
+	   /* reset the file create context to its former glory */
+		if (seretval == 0)
+			seretval=setfscreatecon(prev_scontext);
+		freecon(prev_scontext);
+	}
+#endif
+
 exit:
 	sysfs_close_class_device(class_dev);
 
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

--LZvS9be/3tNcYl/X--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
