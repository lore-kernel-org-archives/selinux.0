Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i72MNmrT016749
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 18:23:48 -0400 (EDT)
Date: Mon, 2 Aug 2004 22:12:12 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
   Linux Hotplug Dev List <linux-hotplug-devel@lists.sourceforge.net>
Subject: Re: matchfilecon (the program) vs matchfilecon (the libselinux1 fn)
Message-ID: <20040802211212.GB6260@lkcl.net>
References: <20040801172751.GD20103@lkcl.net> <1091455223.23449.66.camel@moss-spartans.epoch.ncsc.mil> <20040802145724.GG4194@lkcl.net> <1091458325.23449.102.camel@moss-spartans.epoch.ncsc.mil> <20040802191243.GJ4194@lkcl.net> <1091474356.23449.272.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
In-Reply-To: <1091474356.23449.272.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 02, 2004 at 03:19:16PM -0400, Stephen Smalley wrote:

> On Mon, 2004-08-02 at 15:12, Luke Kenneth Casson Leighton wrote:
> > On Mon, Aug 02, 2004 at 10:52:05AM -0400, Stephen Smalley wrote:
> > > What's the objection to patching udev to directly invoke matchpathcon(3)
> > > and setfscreatecon(3) prior to creating each device node?
> >  
> >  time!  how long do those function calls take?
> > 
> >  using /sbin/restorecon, which is the present hack, each device node
> >  creation takes around a quarter of a second (!!)
> 
> Directly invoking the library functions has to be faster than exec'ing a
> separate helper program (restorecon) that then invokes the library
> functions.  Further, restorecon has to re-lookup the device node in the
> filesystem, whereas udev can set up its context upon initial creation. 
> Further, matchpathcon() caches the file context specification upon the
> first call, so if the udev process stays around for multiple device
> creations, then subsequent matchpathcon() calls will be a bit faster
> (although pathname regex matching is still going to take time).

 okay, quick question: if i use setfscreatecon(), is it a "one-time"
 create, or is it effective on all creates up until the time that
 freecon() is called?

 [because if it's "up until freecon() is called", then the bug that
  the selinux patch to udev was suffering from was that free(scontext)
  was being used instead of freecon().]

 oops ;)

 l.

 p.s. first cut at mods attached for general review NO I HAVEN'T
 COMPILED IT.

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=f

--- udev-add.c.orig	2004-07-09 18:59:09.000000000 +0100
+++ udev-add.c	2004-08-02 22:10:50.000000000 +0100
@@ -50,6 +50,10 @@
 
 #define LOCAL_USER "$local"
 
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
+#endif
+
 /* 
  * Right now the major/minor of a device is stored in a file called
  * "dev" in sysfs.
@@ -109,6 +113,10 @@
 {
 	struct stat stats;
 	int retval = 0;
+	int seretval = 0;
+#ifdef WITH_SELINUX
+	security_context_t scontext;
+#endif
 
 	if (stat(file, &stats) != 0)
 		goto create;
@@ -117,6 +125,24 @@
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
+				filename, strerror(errno));
+				freecon(scontext);
+			}
+		}
+#endif
 		goto perms;
 	}
 
@@ -126,6 +152,21 @@
 		dbg("already present file '%s' unlinked", file);
 
 create:
+#ifdef WITH_SELINUX
+   if (is_selinux_enabled() > 0)
+   {
+		seretval = matchpathcon(filename, 0, &scontext);
+		if (seretval < 0) {
+			dbg("matchpathcon(%s) failed\n", filename);
+		} else {
+			retval=setfscreatecon(scontext);
+			if (retval < 0)
+				dbg("setfiles %s failed with error '%s'",
+			filename, strerror(errno));
+		}
+	}
+#endif
+						    
 	retval = mknod(file, mode, makedev(major, minor));
 	if (retval != 0) {
 		dbg("mknod(%s, %#o, %u, %u) failed with error '%s'",
@@ -133,6 +174,15 @@
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
@@ -150,7 +200,7 @@
 	}
 
 exit:
-	return retval;
+	return retval < 0 ? retval : seretval;
 }
 
 /* get the local logged in user */

--PEIAKu/WMn1b1Hv9--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
