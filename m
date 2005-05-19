Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4JKLQgA017595
	for <selinux@tycho.nsa.gov>; Thu, 19 May 2005 16:21:26 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4JKHGDf025897
	for <selinux@tycho.nsa.gov>; Thu, 19 May 2005 20:17:16 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies [144.51.25.7])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4JKHtRH016725
	for <selinux@tycho.nsa.gov>; Thu, 19 May 2005 16:17:55 -0400 (EDT)
Subject: Re: [RFC]{Patch 4/5] Polyinstantation
From: Chad Sellers <cdselle@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
In-Reply-To: <1115825438.28084.31.camel@moss-huskies.epoch.ncsc.mil>
References: <1115825438.28084.31.camel@moss-huskies.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-xd0urTRGpFy7eiOpzuZV"
Date: Thu, 19 May 2005 16:18:42 -0400
Message-Id: <1116533922.22044.22.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-xd0urTRGpFy7eiOpzuZV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

New patch for per-user support.

http://www.flux.utah.edu/~sds/gdm-2.6.0.8-12.poly.0.src.rpm

On Wed, 2005-05-11 at 11:30 -0400, Chad Sellers wrote:
> Attached is the patch to gdm, as well as the diff of the rawhide spec
> file for the SRPM.  If you want to download a patched SRPM, it is
> available here:
> 
> http://www.flux.utah.edu/~sds/gdm-2.6.0.8-12.poly.0.src.rpm
> 
> 
-- 
Chad Sellers
cdselle@tycho.nsa.gov

--=-xd0urTRGpFy7eiOpzuZV
Content-Disposition: attachment; filename=gdm-2.6.0.8-selinux-poly.patch
Content-Type: text/x-patch; name=gdm-2.6.0.8-selinux-poly.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -urN gdm-2.6.0.8.orig/configure gdm-2.6.0.8/configure
--- gdm-2.6.0.8.orig/configure	2005-05-05 10:55:37.000000000 -0400
+++ gdm-2.6.0.8/configure	2005-05-05 11:11:22.000000000 -0400
@@ -29067,6 +29067,7 @@
 
 	cat >>confdefs.h <<\_ACEOF
 #define HAVE_SELINUX 1
+#define SELINUX_POLY 1
 _ACEOF
 
 	EXTRA_DAEMON_LIBS="$EXTRA_DAEMON_LIBS -lselinux -lattr"
diff -urN gdm-2.6.0.8.orig/configure.in gdm-2.6.0.8/configure.in
--- gdm-2.6.0.8.orig/configure.in	2005-03-07 15:40:09.000000000 -0500
+++ gdm-2.6.0.8/configure.in	2005-05-05 11:11:22.000000000 -0400
@@ -588,7 +588,7 @@
 	echo "SELinux support requested (--with-selinux was given), checking prerequisites"
 	if test -d /usr/local/selinux/include ; then
 		echo "Found /usr/local/selinux/include, will look there for SELinux stuff as well"
-		CFLAGS="$CFLAGS -I/usr/local/selinux/include"
+		CFLAGS="$CFLAGS -I/usr/local/selinux/include -DSELINUX_POLY=1"
 		LDFLAGS="$LDFLAGS -L/usr/local/selinux/lib"
 	fi
 	AC_CHECK_HEADER(selinux/selinux.h)
diff -urN gdm-2.6.0.8.orig/daemon/slave.c gdm-2.6.0.8/daemon/slave.c
--- gdm-2.6.0.8.orig/daemon/slave.c	2005-05-05 10:55:28.000000000 -0400
+++ gdm-2.6.0.8/daemon/slave.c	2005-05-19 14:58:01.000000000 -0400
@@ -30,7 +30,9 @@
 #include <unistd.h>
 #include <utime.h>
 #if defined(_POSIX_PRIORITY_SCHEDULING) && defined(HAVE_SCHED_YIELD)
+#undef __USE_MISC
 #include <sched.h>
+#define __USE_MISC 1
 #endif
 #ifdef HAVE_LOGINCAP
 #include <login_cap.h>
@@ -84,6 +86,16 @@
 #include "errorgui.h"
 #include "cookie.h"
 
+/* Just including this so I don't have to figure out the make process yet */
+#define SELINUX_POLY 1
+#ifdef SELINUX_POLY
+#include <sys/syscall.h>
+#include <sys/mount.h>
+#include <linux/unistd.h>
+#define CLONE_NEWNS 0x00020000 /* Flag to create new namespace */
+static inline _syscall2 (int, clone, int, flags, int, arg)
+#endif
+
 /* Some per slave globals */
 static GdmDisplay *d;
 static gchar *login = NULL;
@@ -3517,6 +3529,56 @@
 		gdm_error (_("%s: setsid() failed: %s!"),
 			   "session_child_run", strerror(errno));
 
+#ifdef SELINUX_POLY
+	/* Make the appropriate bind mounts.  */
+	if (security_setupns(0, pwent->pw_uid) > 0) {
+		security_setupns(1, pwent->pw_uid);
+	}
+	/* Copy the .Xauthority file into the user's new home directory */
+	FILE *xauthfile, *newxauthfile;
+	int myrc, mywc;
+	char *c;
+	char *polyfname=NULL, *polypath=NULL, *xdirfname=NULL;
+	polyfname = malloc(PATH_MAX);
+	if (!polyfname)
+		goto polyend;
+	polypath = getenv("HOME");
+	if (!polypath)
+		goto polyend;
+	c = strrchr(polypath,'/');
+	*c = '\0';
+	snprintf(polyfname, PATH_MAX, "%s/.%s-poly-orig/.Xauthority",polypath,(c+1));
+	*c = '/';
+	xauthfile = fopen(polyfname, "r");
+	if (xauthfile != NULL) {
+		snprintf(polyfname, PATH_MAX, "%s/.Xauthority",polypath);
+		newxauthfile = fopen(polyfname, "w");
+		if (newxauthfile != NULL) {
+			while (!feof(xauthfile) && !ferror(xauthfile)) {
+				myrc=fread(polyfname, 1, PATH_MAX, xauthfile);
+				mywc=0;
+				while (myrc > mywc) {
+					mywc+=fwrite((polyfname+mywc), 1, (myrc-mywc), newxauthfile);
+					if (ferror(newxauthfile))
+						break;
+				}
+			}
+			fclose(newxauthfile);
+		}
+		fclose(xauthfile);
+	}
+	/* Link /tmp/.X11-unix to poly directory */
+	xdirfname = malloc(PATH_MAX);
+	if (!xdirfname)
+		goto polyend;
+	sprintf(xdirfname, "/tmp/.X11-unix");
+	sprintf(polyfname, "/.tmp-poly-orig/.X11-unix");
+	symlink(polyfname,xdirfname);
+polyend:
+	free(xdirfname);
+	free(polyfname);
+#endif
+
 	ve_setenv ("XAUTHORITY", GDM_AUTHFILE (d), TRUE);
 
 	/* Here we setup our 0,1,2 descriptors, we do it here
@@ -3863,16 +3925,6 @@
 	}
 #endif
 
-#ifdef HAVE_SELINUX
-	if ( ! gdm_selinux_setup (pwent->pw_name)) {
-		/* 66 means no "session crashed" examine .xsession-errors
-		   dialog */
-		gdm_error_box (d, GTK_MESSAGE_ERROR,
-			       _("Error! Unable to set executable context."));
-		_exit (66);
-	}
-#endif
-
 	VE_IGNORE_EINTR (execv (argv[0], argv));
 
 	/* will go to .xsession-errors */
@@ -4232,7 +4284,36 @@
     /* Start user process */
     gdm_sigchld_block_push ();
     gdm_sigterm_block_push ();
+
+#ifdef HAVE_SELINUX
+	if ( ! gdm_selinux_setup (pwent->pw_name)) {
+		/* 66 means no "session crashed" examine .xsession-errors
+		   dialog */
+		gdm_error_box (d, GTK_MESSAGE_ERROR,
+			       _("Error! Unable to set executable context."));
+		_exit (66);
+	}
+#endif
+
+#ifdef SELINUX_POLY
+    /*
+    * If building with SELinux support, we want to support polyinstantiated
+    * directories.  To do this we clone the child in a new address space
+    * so we can bind mount as necessary.
+    */
+
+    security_set_setupns_printf(gdm_error);
+    setenv("HOME",home_dir,1);
+    if (security_setupns(0, pwent->pw_uid) < 1) {
+	pid = d->sesspid = fork ();
+    }
+    else {
+	pid = d->sesspid = clone(CLONE_NEWNS|SIGCHLD, 0);
+    }
+#else
     pid = d->sesspid = fork ();
+#endif /* SELINUX_POLY */
+
     if (pid == 0)
 	    gdm_unset_signals ();
     gdm_sigterm_block_pop ();

--=-xd0urTRGpFy7eiOpzuZV
Content-Disposition: attachment; filename=gdm.spec.diff
Content-Type: text/x-patch; name=gdm.spec.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

--- gdm.orig/SPECS/gdm.spec	2005-05-03 10:18:52.000000000 -0400
+++ gdm/SPECS/gdm.spec	2005-05-19 10:23:14.000000000 -0400
@@ -16,7 +16,7 @@
 Summary: The GNOME Display Manager.
 Name: gdm
 Version: 2.6.0.8
-Release: 12
+Release: 12.poly.1
 Epoch: 1
 License: LGPL/GPL
 Group: User Interface/X
@@ -46,6 +46,7 @@
 Patch28: gdm-2.6.0.8-xdmcp.patch
 Patch29: gdm-2.6.0.8-fix-halt-command.patch
 Patch30: gdm-2.6.0.8-process-all-messages.patch
+Patch31: gdm-2.6.0.8-selinux-poly.patch
 
 BuildRoot: %{_tmppath}/gdm-%{PACKAGE_VERSION}-root
 
@@ -117,6 +118,7 @@
 %patch28 -p1 -b .xdmcp
 %patch29 -p1 -b .fix-halt-command
 %patch30 -p1 -b .process-all-messages
+%patch31 -p1
 
 # fix the time format for ja
 perl -pi -e "s|^msgstr \"%a %b %d, %H:%M\"|msgstr \"%m/%d \(%a\) %H:%M\"|; s|^msgstr \"%a %b %d, %I:%M %p\"|msgstr \"%m/%d \(%a\) %p %I:%M\"|" po/ja.po

--=-xd0urTRGpFy7eiOpzuZV--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
