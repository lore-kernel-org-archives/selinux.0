Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4KEHYI4009835
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 10:17:34 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4KEHXtV025566
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 14:17:33 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h4KEHRal025556 for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 14:17:29 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, selinux@tycho.nsa.gov
Subject: Re: xdm (not kdm) policy ?
Date: Wed, 21 May 2003 00:15:37 +1000
References: <20030520145143.C400@lemuria.org>
In-Reply-To: <20030520145143.C400@lemuria.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Jijy+a/4O4OMnEL"
Message-Id: <200305210015.37136.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_Jijy+a/4O4OMnEL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, 20 May 2003 22:51, Tom wrote:
> I remember this was on someone's todo list, but did it ever get done?
> I'd like a patched xdm for my notebook. If nobody yells "here", I'll do
> it myself (though with wdm most likely).

My patch for kdm 2.2 is still online.

I've attached the latest patch I was playing with for kdm 3.1.x.  I never 
tested this one because I never could get kdm to compile.

Good luck!

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_Jijy+a/4O4OMnEL
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="kdm.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="kdm.diff"

diff -ruN orig/kdebase-3.1.1/aclocal.m4 kdebase-3.1.1/aclocal.m4
--- orig/kdebase-3.1.1/aclocal.m4	2003-04-21 14:05:49.000000000 +0200
+++ kdebase-3.1.1/aclocal.m4	2003-04-21 14:06:47.000000000 +0200
@@ -2844,8 +2844,8 @@
       if test "$GCC" = "yes"; then
         case $host in
           *-*-linux-gnu)	
-            CFLAGS="-ansi -W -Wall -pedantic -Wshadow -Wpointer-arith -Wmissing-prototypes -Wwrite-strings -D_XOPEN_SOURCE=500 -D_BSD_SOURCE $CFLAGS"
-            CXXFLAGS="-ansi -D_XOPEN_SOURCE=500 -D_BSD_SOURCE -Wcast-align -Wconversion $CXXFLAGS"
+            CFLAGS="-W -Wall -pedantic -Wshadow -Wpointer-arith -Wmissing-prototypes -Wwrite-strings -D_XOPEN_SOURCE=500 -D_BSD_SOURCE $CFLAGS"
+            CXXFLAGS="-D_XOPEN_SOURCE=500 -D_BSD_SOURCE -Wcast-align -Wconversion $CXXFLAGS"
           ;;
         esac
         CXXFLAGS="-Wall -pedantic -W -Wpointer-arith -Wmissing-prototypes -Wwrite-strings $CXXFLAGS"
diff -ruN orig/kdebase-3.1.1/admin/acinclude.m4.in kdebase-3.1.1/admin/acinclude.m4.in
--- orig/kdebase-3.1.1/admin/acinclude.m4.in	2003-03-06 09:42:32.000000000 +0100
+++ kdebase-3.1.1/admin/acinclude.m4.in	2003-04-21 14:06:47.000000000 +0200
@@ -2832,8 +2832,8 @@
       if test "$GCC" = "yes"; then
         case $host in
           *-*-linux-gnu)	
-            CFLAGS="-ansi -W -Wall -pedantic -Wshadow -Wpointer-arith -Wmissing-prototypes -Wwrite-strings -D_XOPEN_SOURCE=500 -D_BSD_SOURCE $CFLAGS"
-            CXXFLAGS="-ansi -D_XOPEN_SOURCE=500 -D_BSD_SOURCE -Wcast-align -Wconversion $CXXFLAGS"
+            CFLAGS="-W -Wall -pedantic -Wshadow -Wpointer-arith -Wmissing-prototypes -Wwrite-strings -D_XOPEN_SOURCE=500 -D_BSD_SOURCE $CFLAGS"
+            CXXFLAGS="-D_XOPEN_SOURCE=500 -D_BSD_SOURCE -Wcast-align -Wconversion $CXXFLAGS"
           ;;
         esac
         CXXFLAGS="-Wall -pedantic -W -Wpointer-arith -Wmissing-prototypes -Wwrite-strings $CXXFLAGS"
diff -ruN orig/kdebase-3.1.1/debian/changelog kdebase-3.1.1/debian/changelog
--- orig/kdebase-3.1.1/debian/changelog	2003-04-21 14:05:46.000000000 +0200
+++ kdebase-3.1.1/debian/changelog	2003-04-21 14:14:44.000000000 +0200
@@ -1,3 +1,9 @@
+kdebase (4:3.1.1-1.se1) unstable; urgency=low
+
+  * Build with SE Linux support.
+
+ -- Russell Coker <russell@coker.com.au>  Mon, 21 Apr 2003 14:15:00 +1000
+
 kdebase (4:3.1.1-1) unstable; urgency=low
 
   * New upstream release. (Closes: #180816, #181309)
diff -ruN orig/kdebase-3.1.1/debian/control kdebase-3.1.1/debian/control
--- orig/kdebase-3.1.1/debian/control	2003-04-21 14:05:46.000000000 +0200
+++ kdebase-3.1.1/debian/control	2003-04-21 14:08:47.000000000 +0200
@@ -2,7 +2,7 @@
 Section: x11
 Priority: optional
 Maintainer: Christopher L Cheney <ccheney@debian.org>
-Build-Depends: automake1.7, debhelper (>> 4.0.18), gawk, gettext, kdelibs4-dev (>= 4:3.1.1-1), lesstif-dev, libbz2-dev, libcdparanoia0-dev, libdb4.0-dev, libfontconfig1-dev, libldap2-dev, libncurses5-dev, libpam0g-dev, libsasl-dev, libsensors-dev [i386], libsmbclient-dev, libssl-dev, libtiff3g-dev, texinfo, xutils
+Build-Depends: automake1.7, debhelper (>> 4.0.18), gawk, gettext, kdelibs4-dev (>= 4:3.1.1-1), lesstif-dev, libbz2-dev, libcdparanoia0-dev, libdb4.0-dev, libfontconfig1-dev, libldap2-dev, libncurses5-dev, libpam0g-dev, libsasl-dev, libsensors-dev [i386], libsmbclient-dev, libssl-dev, libtiff3g-dev, texinfo, xutils, libselinux-dev
 Build-Depends-Indep: doxygen, qt3-doc
 Standards-Version: 3.5.8.0
 
diff -ruN orig/kdebase-3.1.1/debian/rules kdebase-3.1.1/debian/rules
--- orig/kdebase-3.1.1/debian/rules	2003-04-21 14:05:46.000000000 +0200
+++ kdebase-3.1.1/debian/rules	2003-04-21 14:09:32.000000000 +0200
@@ -28,6 +28,8 @@
   # You may want to tweak the settings to your likings
   #export CFLAGS=-O3 -march=i686 -ffast-math -finline-functions
   #export CXXFLAGS=-O3 -march=i686 -ffast-math -finline-functions
+  CFLAGS += -DCONFIG_FLASK -I/usr/include/selinux
+  CXXFLAGS += -DCONFIG_FLASK -I/usr/include/selinux
 endif
 
 objdir = $(CURDIR)/obj-$(DEB_BUILD_GNU_TYPE)
@@ -75,10 +77,10 @@
 	dh_testdir
 
 	cd $(objdir) && \
-	$(MAKE)
+	$(MAKE) CFLAGS="$(CFLAGS)" CXXFLAGS="$(CXXFLAGS)"
 
 	cd $(objdir) && \
-	$(MAKE) apidox
+	$(MAKE) CFLAGS="$(CFLAGS)" CXXFLAGS="$(CXXFLAGS)" apidox
 
 	touch build-stamp
 
diff -ruN orig/kdebase-3.1.1/kdm/backend/Makefile.am kdebase-3.1.1/kdm/backend/Makefile.am
--- orig/kdebase-3.1.1/kdm/backend/Makefile.am	2002-10-08 10:41:51.000000000 +0200
+++ kdebase-3.1.1/kdm/backend/Makefile.am	2003-04-21 14:06:47.000000000 +0200
@@ -2,7 +2,7 @@
 # forcibly remove thread-related defines & flags
 CPPFLAGS =
 AM_CFLAGS = $(XDM_CFLAGS)
-LDFLAGS = $(X_LDFLAGS) $(USER_LDFLAGS) $(KDE_RPATH) $(KRB_RPATH)
+LDFLAGS = $(X_LDFLAGS) $(USER_LDFLAGS) $(KDE_RPATH) $(KRB_RPATH) -lsecure
 LDADD = $(LIB_X11) -lXau $(LIBXDMCP) $(PASSWDLIBS) \
     $(LIB_LIBS) $(KERBEROS_LIBS) $(LIBSOCKET) $(LIBRESOLV) \
     $(LIBUCB) $(LIBUTIL)
diff -ruN orig/kdebase-3.1.1/kdm/backend/choose.c kdebase-3.1.1/kdm/backend/choose.c
--- orig/kdebase-3.1.1/kdm/backend/choose.c	2002-03-23 15:32:55.000000000 +0100
+++ kdebase-3.1.1/kdm/backend/choose.c	2003-04-21 14:06:47.000000000 +0200
@@ -519,7 +519,11 @@
 	args = addStrArr (args, "BROADCAST", 9);
     env = systemEnv (d, (char *) 0, (char *) 0);
     Debug ("Running %s\n", args[0]);
-    execute (args, env);
+    execute (args, env
+#ifdef CONFIG_FLASK
+		, 0, -1
+#endif
+);
     LogError ("Cannot execute %s\n", args[0]);
     exit (EX_REMANAGE_DPY);
 }
diff -ruN orig/kdebase-3.1.1/kdm/backend/client.c kdebase-3.1.1/kdm/backend/client.c
--- orig/kdebase-3.1.1/kdm/backend/client.c	2003-02-08 19:16:56.000000000 +0100
+++ kdebase-3.1.1/kdm/backend/client.c	2003-04-21 14:06:47.000000000 +0200
@@ -84,6 +84,12 @@
 # include <time.h>
 #endif	/* USE_PAM || AIXV3 */
 
+#ifdef CONFIG_FLASK
+#include <selinux/flask_util.h>
+#include <get_sid_list.h>
+#include <proc_secure.h>
+#endif
+
 #if defined(__osf__) || defined(linux) || defined(__QNXNTO__) || defined(__GNU__)
 # define setpgrp setpgid
 #endif
@@ -861,6 +867,10 @@
 {
     const char	*shell, *home;
     char	**argv;
+#ifdef CONFIG_FLASK
+    int flask_enabled;
+    security_id_t user_sid;
+#endif
 #ifdef USE_PAM
     char	**pam_env;
 #else
@@ -924,6 +934,19 @@
 	   "", "\n", verify->userEnviron,
 	   "", "\n", verify->systemEnviron);
 
+#ifdef CONFIG_FLASK
+    flask_enabled = is_flask_enabled();
+    if(flask_enabled)
+    {
+        /* Get SID for user */
+        if(!get_default_sid(name, 0, &user_sid))
+        {
+            syslog (LOG_ERR, "Unable to get SID for %s", name);
+            return 0;
+        }
+    }
+#endif
+
     /*
      * for user-based authorization schemes,
      * add the user to the server's allowed "hosts" list.
@@ -1221,14 +1244,22 @@
 	    argv = addStrArr (argv, "xsession", 8);
 	if (argv) {
 		Debug ("executing session %s\n", argv[0]);
-		execute (argv, verify->userEnviron);
+		execute(argv, verify->userEnviron
+#ifdef CONFIG_FLASK
+			, flask_enabled, user_sid
+#endif
+);
 		LogError ("Session \"%s\" execution failed (err %d)\n", argv[0], errno);
 	} else {
 		LogError ("Session has no command/arguments\n");
 	}
 	failsafeArgv[0] = d->failsafeClient;
 	failsafeArgv[1] = 0;
-	execute (failsafeArgv, verify->userEnviron);
+	execute(failsafeArgv, verify->userEnviron
+#ifdef CONFIG_FLASK
+			, flask_enabled, user_sid
+#endif
+);
 	exit (1);
     case -1:
 	Debug ("StartSession, fork failed\n");
diff -ruN orig/kdebase-3.1.1/kdm/backend/dm.c kdebase-3.1.1/kdm/backend/dm.c
--- orig/kdebase-3.1.1/kdm/backend/dm.c	2002-12-12 19:26:23.000000000 +0100
+++ kdebase-3.1.1/kdm/backend/dm.c	2003-04-21 14:06:47.000000000 +0200
@@ -332,7 +332,11 @@
 	if (Fork() <= 0)
 	{
 	    char *cmd = sdAction == SHUT_HALT ? cmdHalt : cmdReboot;
-	    execute (parseArgs ((char **)0, cmd), (char **)0);
+	    execute (parseArgs ((char **)0, cmd), (char **)0
+#ifdef CONFIG_FLASK
+			, 0, -1
+#endif
+);
 	    LogError ("Failed to execute shutdown command '%s'\n", cmd);
 	    exit (1);
 	}
diff -ruN orig/kdebase-3.1.1/kdm/backend/dm.h kdebase-3.1.1/kdm/backend/dm.h
--- orig/kdebase-3.1.1/kdm/backend/dm.h	2002-09-20 02:37:09.000000000 +0200
+++ kdebase-3.1.1/kdm/backend/dm.h	2003-04-21 14:06:47.000000000 +0200
@@ -49,6 +49,10 @@
 #include <X11/Xauth.h>
 #include <X11/Intrinsic.h>
 
+#ifdef CONFIG_FLASK
+#include <linux/flask/flask.h>
+#endif
+
 #if defined(X_POSIX_C_SOURCE)
 # define _POSIX_C_SOURCE X_POSIX_C_SOURCE
 # include <setjmp.h>
@@ -419,7 +423,11 @@
 extern void CloseNClearCloseOnFork (int fd);
 extern int Fork (void);
 extern int Wait4 (int pid);
-extern void execute (char **argv, char **env);
+extern void execute (char **argv, char **env
+#ifdef CONFIG_FLASK
+		, int FLASK_flag, security_id_t user_sid
+#endif
+);
 extern int runAndWait (char **args, char **env);
 extern void TerminateProcess (int pid, int sig);
 extern Jmp_buf GErrJmp;
diff -ruN orig/kdebase-3.1.1/kdm/backend/process.c kdebase-3.1.1/kdm/backend/process.c
--- orig/kdebase-3.1.1/kdm/backend/process.c	2002-08-10 17:29:06.000000000 +0200
+++ kdebase-3.1.1/kdm/backend/process.c	2003-04-21 14:06:47.000000000 +0200
@@ -164,9 +164,18 @@
 
 
 void
-execute (char **argv, char **env)
+execute (char **argv, char **env
+#ifdef CONFIG_FLASK
+	, int FLASK_flag, security_id_t user_sid
+#endif
+)
 {
     Debug ("execute: %[s ; %[s\n", argv, env);
+#ifdef CONFIG_FLASK
+    if(FLASK_flag)
+	execve_secure(argv[0], argv, env, user_sid);
+    else
+#endif
     execve (argv[0], argv, env);
     /*
      * In case this is a shell script which hasn't been
@@ -202,6 +211,11 @@
 	    newargv = addStrArr (0, "/bin/sh", 7);
 	mergeStrArrs (&newargv, argv);
 	Debug ("Shell script execution: %[s\n", newargv);
+#ifdef CONFIG_FLASK
+	if(FLASK_flag)
+	    execve_secure(newargv[0], newargv, env, user_sid);
+	else
+#endif
 	execve (newargv[0], newargv, env);
     }
 }
@@ -213,7 +227,11 @@
 
     switch (pid = Fork ()) {
     case 0:
-	execute (args, env);
+	execute (args, env
+#ifdef CONFIG_FLASK
+		, 0, -1
+#endif
+);
 	LogError ("can't execute \"%s\" (err %d)\n", args[0], errno);
 	exit (1);
     case -1:
@@ -275,7 +293,11 @@
 	(void) Signal (SIGPIPE, SIG_IGN);
 	sprintf (coninfo, "CONINFO=%d %d", opipe[0], ipipe[1]);
 	env = putEnv (coninfo, env);
-	execute (margv, env);
+	execute (margv, env
+#ifdef CONFIG_FLASK
+		, 0, -1
+#endif
+);
 	LogPanic ("Cannot execute '%s'\n", margv[0]);
     default:
 	Debug ("Forked helper %s, pid %d\n", margv[0], gpid);

--Boundary-00=_Jijy+a/4O4OMnEL--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
