Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA02129
	for <selinux@tycho.nsa.gov>; Mon, 15 Oct 2001 11:33:23 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA00961
	for <selinux@tycho.nsa.gov>; Mon, 15 Oct 2001 15:32:50 GMT
Received: from mrelay.jrc.it (mrelay.jrc.it [139.191.1.65])
	by jazzband.ncsc.mil  with ESMTP id PAA00957
	for <selinux@tycho.nsa.gov>; Mon, 15 Oct 2001 15:32:49 GMT
Received: from mrelay.jrc.it (localhost [127.0.0.1])
	by mrelay.jrc.it (LMC5614B) with ESMTP id f9FFXIs05660
	for <selinux@tycho.nsa.gov>; Mon, 15 Oct 2001 17:33:18 +0200 (MEST)
Received: from isis-ms.sti.jrc.it (isis-gs.sti.jrc.it [139.191.8.244])
	by mrelay.jrc.it (LMC5614A) with ESMTP id f9FFXHs05646
	for <selinux@tycho.nsa.gov>; Mon, 15 Oct 2001 17:33:18 +0200 (MEST)
Message-ID: <3BCB01B2.4060203@jrc.it>
Date: Mon, 15 Oct 2001 17:33:06 +0200
From: "James Bishop" <james.bishop@jrc.it>
MIME-Version: 1.0
To: Stephen Smalley <sds@tislabs.com>, selinux@tycho.nsa.gov
Subject: Re: Compiling for SuSE 7.2
References: <Pine.GSO.4.33.0110111248230.18477-100000@raven>
Content-Type: multipart/mixed;
 boundary="------------050902030509000603090708"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050902030509000603090708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Good afternoon,

I finally managed to get the util-linux-2.11b/login to work, and attach 
the diffs from the SuSE 7.2. util-linux-2.11b/login.c source file.

This login program worked after I commented out these three system calls:

    signal(SIGHUP, SIG_IGN);    /* ignore signal from TIOCNOTTY */
    ioctl(0, TIOCNOTTY, NULL);
    signal(SIGHUP, SIG_DFL);

These occur in the "else if (childPID)" block after the fork() (see e.g 
lines 1239 - 1250 in the SELinux util-linux-2.10/login-utils/login.c); 
and were commented out in the SuSE 7.2 pam_login source file.

Perhaps this is an improvement introduced in the util-linux-2.11b 
package? It's not really important, but if some kind soul has the time 
to explain the purpose of these calls, I'd be grateful.

James Bishop

--------------050902030509000603090708
Content-Type: text/plain;
 name="login.c.diffs"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="login.c.diffs"

--- util-linux-2.11b/login-utils/login.c	Thu Mar 15 11:09:58 2001
+++ selinux/util-linux-2.11b/login-utils/login.c	Mon Oct 15 17:08:03 2001
@@ -137,6 +137,14 @@
 #  include <shadow.h>
 #endif
 
+#ifdef CONFIG_FLASK
+#include <linux/flask/flask_types.h>
+#include <flask_util.h>
+#include <fs_secure.h>
+#include <ss.h>
+#include <get_user_sid.h>
+#endif
+
 #ifdef USE_PAM
 #  include <security/pam_appl.h>
 #  include <security/pam_misc.h>
@@ -336,6 +344,17 @@
     int ioctlval;
 #endif
 
+#ifdef CONFIG_FLASK
+    security_context_t user_context;
+    security_id_t user_sid;
+    security_id_t ttyn_sid;  /* The current sid of ttyn device */
+    security_id_t vcsn_sid;  /* The current sid of vcsn device */
+    security_id_t vcsan_sid;  /* The current sid of vcsan device */
+    security_id_t newdev_sid;   /* The new sid of a device */
+    struct stat statbuf;
+    int FLASK_flag;
+#endif
+
     signal(SIGALRM, timedout);
     alarm((unsigned int)timeout);
     signal(SIGQUIT, SIG_IGN);
@@ -751,6 +770,21 @@
     }
 #endif /* !USE_PAM */
     
+#ifdef CONFIG_FLASK
+
+    /* Make sure FLASK is really installed on this system */
+    if ( (FLASK_flag = is_flask_enabled()) )
+    {
+        /* Get security context and SID for user */
+        if (!get_user_sid (username, strlen (username), &user_context, &user_sid))
+        {
+            syslog (LOG_ERR, "UNABLE TO GET VALID SID FOR %s", username);
+            exit(0);
+        }
+    }
+
+#endif
+
     /* committed to login -- turn off timeout */
     alarm((unsigned int)0);
     
@@ -911,6 +945,23 @@
 	  (gr = getgrnam(TTYGRPNAME)) ? gr->gr_gid : pwd->pw_gid);
     chmod(ttyn, TTY_MODE);
 
+#ifdef CONFIG_FLASK
+    if (FLASK_flag) {
+            if (stat_secure(ttyn, &statbuf, &ttyn_sid) != 0) {
+                    perror("stat_secure");
+                    exit (0);
+            }
+            if (security_change_sid (user_sid, ttyn_sid, SECCLASS_CHR_FILE, &newdev_sid) != 0) {
+                    perror("security_change_sid");
+                    exit (0);
+            }
+            if (chsid (ttyn, newdev_sid) != 0) {
+                    perror("chsid");
+                    exit (0);
+            }
+    }
+#endif
+
 #ifdef CHOWNVCS
     /* if tty is one of the VC's then change owner and mode of the 
        special /dev/vcs devices as well */
@@ -919,6 +970,41 @@
 	chown(vcsan, pwd->pw_uid, (gr ? gr->gr_gid : pwd->pw_gid));
 	chmod(vcsn, TTY_MODE);
 	chmod(vcsan, TTY_MODE);
+#ifdef CONFIG_FLASK
+        if (FLASK_flag)
+        {
+            if (stat_secure(vcsn, &statbuf, &vcsn_sid) != 0)
+            {
+                perror("stat_secure");
+                exit (0);
+            }
+            if (security_change_sid (user_sid, vcsn_sid, SECCLASS_CHR_FILE, &newdev_sid) != 0)
+            {
+                perror ("security_change_sid");
+                exit (0);
+            }
+            if (chsid (vcsn, newdev_sid) != 0)
+            {
+                perror("chsid");
+                exit (0);
+            }
+            if (stat_secure(vcsan, &statbuf, &vcsan_sid) != 0)
+            {
+                perror("stat_secure");
+                exit (0);
+            }
+            if (security_change_sid (user_sid, vcsan_sid, SECCLASS_CHR_FILE, &newdev_sid) != 0)
+            {
+                perror("security_change_sid");
+                exit (0);
+            }
+            if (chsid (vcsan, newdev_sid) != 0)
+            {
+                perror("chsid");
+                exit (0);
+            }
+         }
+#endif
     }
 #endif
 
@@ -1003,6 +1089,43 @@
     /* allow tracking of good logins.
        -steve philp (sphilp@mail.alliance.net) */
     
+#ifdef CONFIG_FLASK
+    if (FLASK_flag)
+    {
+        if (pwd->pw_uid == 0) {
+            if (hostname)
+              syslog(LOG_NOTICE, _("ROOT LOGIN ON %s FROM %s USING %s"),
+                     tty, hostname, user_context);
+            else
+              syslog(LOG_NOTICE, _("ROOT LOGIN ON %s USING %s"), tty, user_context);
+        } else {
+            if (hostname)
+              syslog(LOG_INFO, _("LOGIN ON %s BY %s FROM %s USING %s"), tty,
+                     pwd->pw_name, hostname, user_context);
+            else
+              syslog(LOG_INFO, _("LOGIN ON %s BY %s USING %s"), tty,
+                     pwd->pw_name, user_context);
+        }
+        free (user_context);
+    }
+    else
+    {
+        if (pwd->pw_uid == 0) {
+            if (hostname)
+              syslog(LOG_NOTICE, _("ROOT LOGIN ON %s FROM %s"),
+                     tty, hostname);
+            else
+              syslog(LOG_NOTICE, _("ROOT LOGIN ON %s"), tty);
+        } else {
+            if (hostname)
+              syslog(LOG_INFO, _("LOGIN ON %s BY %s FROM %s"), tty,
+                     pwd->pw_name, hostname);
+            else
+              syslog(LOG_INFO, _("LOGIN ON %s BY %s"), tty,
+                     pwd->pw_name);
+        }
+    }
+#else
     if (pwd->pw_uid == 0) {
 	if (hostname)
 	  syslog(LOG_NOTICE, _("ROOT LOGIN ON %s FROM %s"),
@@ -1017,6 +1140,7 @@
 	  syslog(LOG_INFO, _("LOGIN ON %s BY %s"), tty, 
 		 pwd->pw_name);
     }
+#endif
     
     if (!quietlog) {
 	struct stat st;
@@ -1057,11 +1181,36 @@
        exit(0);
     } else if (childPid) {
        /* parent - wait for child to finish, then cleanup session */
-       signal(SIGHUP, SIG_IGN);		/* ignore signal from TIOCNOTTY */
+#if 0
+       signal(SIGHUP, SIG_IGN);   /* ignore signal from TIOCNOTTY */
        ioctl(0, TIOCNOTTY, NULL);
        signal(SIGHUP, SIG_DFL);
+#endif
 
        wait(NULL);
+
+#ifdef CONFIG_FLASK
+    if (FLASK_flag)
+    {
+       /* We need to change the contexts of the terminal devices back to
+          the system when the user's session ends.  */
+       if (chsid (ttyn, ttyn_sid) != 0)
+       {
+            perror("chsid");
+       }
+       if (consoletty(0)) {
+         if (chsid (vcsn, vcsn_sid) != 0)
+         {
+            perror("chsid");
+         }
+         if (chsid (vcsan, vcsan_sid) != 0)
+         {
+            perror("chsid");
+         }
+       }
+    }
+#endif
+
        PAM_END;
        exit(0);
     }
@@ -1112,7 +1261,14 @@
 
     childArgv[childArgc++] = NULL;
 
+#ifdef CONFIG_FLASK
+    if (FLASK_flag)
+        execvp_secure (childArgv[0], user_sid, childArgv + 1);
+    else
+        execvp(childArgv[0], childArgv + 1);
+#else
     execvp(childArgv[0], childArgv + 1);
+#endif
 
     errsv = errno;
 

--------------050902030509000603090708--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
