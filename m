Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4QBtpI4005725
	for <selinux@tycho.nsa.gov>; Mon, 26 May 2003 07:55:51 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4QBtotV007251
	for <selinux@tycho.nsa.gov>; Mon, 26 May 2003 11:55:50 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h4QBtlal007248 for <selinux@tycho.nsa.gov>; Mon, 26 May 2003 11:55:48 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 7552EBF4F
	for <selinux@tycho.nsa.gov>; Mon, 26 May 2003 21:55:45 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 13355-05
 for <selinux@tycho.nsa.gov>; Mon, 26 May 2003 21:55:44 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 0ACDABF4E
	for <selinux@tycho.nsa.gov>; Mon, 26 May 2003 21:55:44 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 89D0092705
	for <selinux@tycho.nsa.gov>; Mon, 26 May 2003 21:55:42 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 6759A986B
	for <selinux@tycho.nsa.gov>; Mon, 26 May 2003 21:55:35 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: gpe-login patch
Date: Mon, 26 May 2003 21:55:34 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_2Cg0+fo7irG8UFz"
Message-Id: <200305262155.34836.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_2Cg0+fo7irG8UFz
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have attached a patch for the gpe-login program that is used in the Familiar 
distribution for iPaQ machines.

To get an iPaQ running SE Linux completely in enforcing mode you need this 
patch, the patch I published previously for busybox, my latest policy tree, 
and a single policy file containing all the iPaQ specific policy.

The iPaQ specific file is not quite ready to release yet (it's very ugly and I 
haven't double-checked it to make sure that I'm not permitting undesired 
things).  But if anyone is in a hurry to try it out then please let me know 
and I'll send you a private copy.

My iPaQ policy allows lots of weird stuff that Familiar depends on which you 
normally don't want to allow (EG xdm creating symlinks under user home 
directories, changing ownership of device nodes, and other nastyness).  For 
that reason I will not put it in a regular section of the policy tree where 
people who don't use Familiar might mistakenly install it and weaken their 
security.  I will create some new section name, maybe a new subdirectory 
under unused for things that definately shouldn't be installed by default.

I will soon sort out all my patches for iPaQ and put them on 
http://www.coker.com.au/arm/ .

I think I am about 3 hours away from having my SE Linux iPaQ ready for full 
production use.


PS  I am not publishing a binary of the modified gpe-login because it's 
impossible for me to provide a coherent method of building it.  Building this 
depends on libraries from XFree86 version 4.3.  To build it myself I used a 
Debian ARM server that only has X 4.2 libraries, so I grabbed the header 
files from an unofficial build of X 4.3 and hacked part of the library code 
to not call one of the new functions that appeared in 4.3.  I will privately 
supply my gpe-login on request to anyone who really needs it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_2Cg0+fo7irG8UFz
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="diff"

--- gpe-login.c	2003-04-28 14:24:29.000000000 +1000
+++ /tmp/gpe-login.c	2003-05-26 21:28:08.000000000 +1000
@@ -7,6 +7,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+#include <syslog.h>
 #include <pwd.h>
 #include <sys/types.h>
 #include <shadow.h>
@@ -44,6 +45,12 @@
 #include <gpe/translabel.h>
 
 #include "rootpixmap.h"
+#ifdef SELINUX
+#include <flask_util.h>
+#include <get_sid_list.h>
+#include <proc_secure.h>
+#include <fs_secure.h>
+#endif
 
 #define _(x) gettext(x)
 #define N_(x) (x)
@@ -264,10 +271,10 @@
       char *xkbd_args[MAX_ARGS + 1];
       close (fd[0]);
       if (dup2 (fd[1], 1) < 0)
-	perror ("dup2");
+	syslog(LOG_NOTICE, "dup2: %m");
       close (fd[1]);
       if (fcntl (1, F_SETFD, 0))
-	perror ("fcntl");
+	syslog(LOG_NOTICE, "fcntl: %m");
       xkbd_args[0] = (char *)xkbd_path;
       xkbd_args[1] = "-xid";
       if (xkbd_str)
@@ -275,7 +282,7 @@
       else
 	xkbd_args[2] = NULL;
       execvp (xkbd_path, xkbd_args);
-      perror (xkbd_path);
+      syslog(LOG_ERR, "Can't execute %s: %m", xkbd_path);
       _exit (1);
     }
   
@@ -357,12 +364,12 @@
 	{
 	case 0:
 	  execl (PRE_SESSION, PRE_SESSION, name, NULL);
-	  perror (PRE_SESSION);
+	  syslog(LOG_ERR, "Can't execute %s: %m", PRE_SESSION);
 	  _exit (1);
 	  break;
 
 	case -1:
-	  perror ("fork");
+	  syslog(LOG_ERR, "Can't fork: %m");
 	  break;
 
 	default:
@@ -433,10 +440,36 @@
       close (fd);
     }
   
+#ifdef SELINUX
+  if(is_flask_enabled())
+  {
+     security_id_t user_sid;
+     char *argv[2];
+     argv[1] = NULL;
+
+     /* Get SID for user */
+     if(get_default_sid(name, 0, &user_sid))
+     {
+        syslog(LOG_ERR, "Unable to get SID for %s", name);
+        _exit(1);
+     }
+     if (access (".xsession", X_OK) == 0)
+     argv[0] = ".xsession";
+     execve_secure(argv[0], argv, environ, user_sid);
+     argv[0] = "/etc/X11/Xsession";
+     execve_secure(argv[0], argv, environ, user_sid);
+     argv[0] = "/usr/bin/x-terminal-emulator";
+     execve_secure(argv[0], argv, environ, user_sid);
+     syslog(LOG_ERR, "Can't exec_secure X session.");
+     _exit(1);
+  }
+#endif
+
   if (access (".xsession", X_OK) == 0)
     execl (".xsession", ".xsession", NULL);
   execl ("/etc/X11/Xsession", "/etc/X11/Xsession", NULL);
   execl ("/usr/bin/x-terminal-emulator", "/usr/bin/x-terminal-emulator", NULL);
+  syslog(LOG_ERR, "Can't execute X session.");
   _exit (1);
 }
 
@@ -1271,6 +1304,8 @@
   if (gpe_application_init (&argc, &argv) == FALSE)
     exit (1);
 
+  openlog("gpe-login", LOG_CONS, LOG_DAEMON);
+
   /* (LanguageCode) translators: please replace this with your own
      Pango language code: */
   pango_lang_code = g_strdup (_("en"));

--Boundary-00=_2Cg0+fo7irG8UFz--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
