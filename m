Message-ID: <793873C240E5D311A0DF00508B6D74A449DB41@chbubexch1.zur.uunet.ch>
From: Michael Bischof <Michael.Bischof@ch.uu.net>
To: "'SELinux@tycho.nsa.gov'" <SELinux@tycho.nsa.gov>
Subject: PATCH: openssh-3.0.1p1   ...please test it
Date: Tue, 27 Nov 2001 02:49:14 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

diff -ruN openssh-3.0.1p1.orig/session.c openssh-3.0.1p1/session.c
--- openssh-3.0.1p1.orig/session.c      Tue Nov 13 13:46:19 2001
+++ openssh-3.0.1p1/session.c   Sat Nov 24 00:54:17 2001
@@ -67,6 +67,12 @@
 #include <sat.h>
 #endif /* WITH_IRIX_AUDIT */
 
+#ifdef WITH_SELINUX
+#include <flask_util.h>
+#include <get_user_sid.h>
+#include <proc_secure.h>
+#endif
+
 #if defined(HAVE_USERSEC_H)
 #include <usersec.h>
 #endif
@@ -1048,6 +1054,23 @@
        int jid = 0;
 #endif /* WITH_IRIX_ARRAY */
 #endif /* WITH_IRIX_JOBS */
+#ifdef WITH_SELINUX
+       int flask_enabled;
+       security_context_t scontext = NULL;
+       security_id_t sid;
+
+       flask_enabled = is_flask_enabled();
+       if (flask_enabled) {
+               if (!get_default_user_sid(pw->pw_name, 
+                                         strlen(pw->pw_name),
+                                         &scontext,
+                                         &sid)) {
+                       fprintf(stderr, "Could not obtain SID for user
%s\n",
+                               pw->pw_name);
+                       exit(1);
+               }
+       } 
+#endif
 
        do_xauth =
            s->display != NULL && s->auth_proto != NULL && s->auth_data !=
NULL;
@@ -1476,6 +1499,11 @@
                        /* Execute the shell. */
                        argv[0] = buf;
                        argv[1] = NULL;
+#ifdef WITH_SELINUX
+                       if (flask_enabled) 
+                               execve_secure(shell, argv, env, sid);
+                       else 
+#endif
                        execve(shell, argv, env);
 
                        /* Executing the shell failed. */
@@ -1505,6 +1533,11 @@
        argv[1] = "-c";
        argv[2] = (char *) command;
        argv[3] = NULL;
+#ifdef WITH_SELINUX
+       if (flask_enabled) 
+               execve_secure(shell, argv, env, sid);
+       else 
+#endif
        execve(shell, argv, env);
        perror(shell);
        exit(1);
diff -ruN openssh-3.0.1p1.orig/sshpty.c openssh-3.0.1p1/sshpty.c
--- openssh-3.0.1p1.orig/sshpty.c       Fri Oct 12 11:15:49 2001
+++ openssh-3.0.1p1/sshpty.c    Sat Nov 24 00:54:17 2001
@@ -22,6 +22,13 @@
 #include "log.h"
 #include "misc.h"
 
+#ifdef WITH_SELINUX
+#include <flask_util.h>
+#include <get_user_sid.h>
+#include <fs_secure.h>
+#include <ss.h>
+#endif
+
 /* Pty allocated with _getpty gets broken if we do I_PUSH:es to it. */
 #if defined(HAVE__GETPTY) || defined(HAVE_OPENPTY)
 #undef HAVE_DEV_PTMX
@@ -356,6 +363,22 @@
        gid_t gid;
        mode_t mode;
        struct stat st;
+#ifdef WITH_SELINUX
+       int flask_enabled;
+       security_context_t scontext = NULL;
+       security_id_t user_sid, old_tty_sid, new_tty_sid;
+
+       flask_enabled = is_flask_enabled();
+       if (flask_enabled) {
+               if (!get_default_user_sid(pw->pw_name, 
+                                         strlen(pw->pw_name),
+                                         &scontext,
+                                         &user_sid)) {
+                       fatal("Could not obtain SID for user %s\n",
+                             pw->pw_name);
+               }
+       } 
+#endif
 
        /* Determine the group to make the owner of the tty. */
        grp = getgrnam("tty");
@@ -372,9 +395,24 @@
         * Warn but continue if filesystem is read-only and the uids match/
         * tty is owned by root.
         */
+#ifdef WITH_SELINUX
+       if (flask_enabled) {
+               if (stat_secure(ttyname, &st, &old_tty_sid)) 
+                       fatal("stat_secure(%.100s) failed: %.100s", ttyname,
+                             strerror(errno));
+               if (security_change_sid (user_sid, old_tty_sid,
SECCLASS_CHR_FILE, &new_tty_sid) != 0) 
+                       fatal("security_change_sid(%.100s) failed: %.100s",
ttyname,
+                             strerror(errno));
+       } else {
+               if (stat(ttyname, &st))
+                       fatal("stat(%.100s) failed: %.100s", ttyname,
+                             strerror(errno));
+       }
+#else
        if (stat(ttyname, &st))
                fatal("stat(%.100s) failed: %.100s", ttyname,
                    strerror(errno));
+#endif
 
        if (st.st_uid != pw->pw_uid || st.st_gid != gid) {
                if (chown(ttyname, pw->pw_uid, gid) < 0) {
@@ -401,4 +439,12 @@
                                      ttyname, mode, strerror(errno));
                }
        }
+
+#ifdef WITH_SELINUX
+       if (flask_enabled) {
+               if (chsid (ttyname, new_tty_sid) != 0) 
+                       fatal("chsid(%.100s, %d) failed: %.100s",
+                                     ttyname, new_tty_sid,
strerror(errno));
+       }
+#endif
 }

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
