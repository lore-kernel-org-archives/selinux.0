Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t69Bh8dM029977
 for <selinux@tycho.nsa.gov>; Thu, 9 Jul 2015 07:43:08 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 5EA331A1BD
 for <selinux@tycho.nsa.gov>; Thu,  9 Jul 2015 13:42:41 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id kLSiMb0cFqw0 for <selinux@tycho.nsa.gov>;
 Thu,  9 Jul 2015 13:42:37 +0200 (CEST)
Received: from soldur.bigon.be (unknown [193.53.238.195])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id BED151A1BC
 for <selinux@tycho.nsa.gov>; Thu,  9 Jul 2015 13:42:36 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: 510466@bugs.debian.org
Subject: [PATCH] Add SELinux support to run jobs in the proper domain
Date: Thu,  9 Jul 2015 13:42:36 +0200
Message-Id: <1436442156-1163-1-git-send-email-bigon@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Marcela Mašláňová <mmaslano@redhat.com>

Currently, jobs run by at are run in the crond_t domain and not
transitioned outside of it.

With this patch, the jobs are transitioned in the same domain as the
jobs that are run by the cron daemon:

- When cron_userdomain_transition is set to off, a process for an
  unconfined user will transition to unconfined_cronjob_t. For confined
  user, the job is run as cronjob_t.

- When cron_userdomain_transition is set to on, the processes are run
  under the user default context.

Tested-by: Laurent Bigonville <bigon@bigon.be>
---
 Makefile.in  |  3 ++-
 atd.c        | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 config.h.in  |  3 +++
 configure.ac |  8 ++++++
 4 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/Makefile.in b/Makefile.in
index 5dd2767..2bddc13 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -40,6 +40,7 @@ LIBS		= @LIBS@
 LIBOBJS		= @LIBOBJS@
 INSTALL		= @INSTALL@
 PAMLIB          = @PAMLIB@
+SELINUXLIB      = @SELINUXLIB@
 
 CLONES		= atq atrm
 ATOBJECTS	= at.o panic.o perm.o posixtm.o y.tab.o lex.yy.o
@@ -73,7 +74,7 @@ at: $(ATOBJECTS)
 	$(LN_S) -f at atrm
 
 atd: $(RUNOBJECTS)
-	$(CC) $(LDFLAGS) -o atd $(RUNOBJECTS) $(LIBS) $(PAMLIB)
+	$(CC) $(LDFLAGS) -o atd $(RUNOBJECTS) $(LIBS) $(PAMLIB) $(SELINUXLIB)
 
 y.tab.c y.tab.h: parsetime.y
 	$(YACC) -d parsetime.y
diff --git a/atd.c b/atd.c
index d0b422e..55f6f8d 100644
--- a/atd.c
+++ b/atd.c
@@ -83,6 +83,14 @@
 #include "getloadavg.h"
 #endif
 
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
+#include <selinux/get_context_list.h>
+int selinux_enabled=0;
+#include <selinux/flask.h>
+#include <selinux/av_permissions.h>
+#endif
+
 /* Macros */
 
 #define BATCH_INTERVAL_DEFAULT 60
@@ -195,6 +203,68 @@ myfork()
 #define fork myfork
 #endif
 
+#ifdef WITH_SELINUX
+static int set_selinux_context(const char *name, const char *filename) {
+       security_context_t user_context=NULL;
+       security_context_t  file_context=NULL;
+       struct av_decision avd;
+       int retval=-1;
+       char *seuser=NULL;
+       char *level=NULL;
+
+       if (getseuserbyname(name, &seuser, &level) == 0) {
+               retval=get_default_context_with_level(seuser, level, NULL, &user_context);
+               free(seuser);
+               free(level);
+               if (retval) {
+                       if (security_getenforce()==1) {
+                               perr("execle: couldn't get security context for user %s\n", name);
+                       } else {
+                               syslog(LOG_ERR, "execle: couldn't get security context for user %s\n", name);
+                               return -1;
+                       }
+               }
+       }
+
+       /*
+       * Since crontab files are not directly executed,
+       * crond must ensure that the crontab file has
+       * a context that is appropriate for the context of
+       * the user cron job.  It performs an entrypoint
+       * permission check for this purpose.
+       */
+       if (fgetfilecon(STDIN_FILENO, &file_context) < 0)
+               perr("fgetfilecon FAILED %s", filename);
+
+       retval = security_compute_av(user_context,
+                                    file_context,
+                                    SECCLASS_FILE,
+                                    FILE__ENTRYPOINT,
+                                    &avd);
+       freecon(file_context);
+       if (retval || ((FILE__ENTRYPOINT & avd.allowed) != FILE__ENTRYPOINT)) {
+               if (security_getenforce()==1) {
+                       perr("Not allowed to set exec context to %s for user  %s\n", user_context,name);
+               } else {
+                       syslog(LOG_ERR, "Not allowed to set exec context to %s for user  %s\n", user_context,name);
+                       retval = -1;
+                       goto err;
+               }
+       }
+       if (setexeccon(user_context) < 0) {
+               if (security_getenforce()==1) {
+                       perr("Could not set exec context to %s for user  %s\n", user_context,name);
+                       retval = -1;
+               } else {
+                       syslog(LOG_ERR, "Could not set exec context to %s for user  %s\n", user_context,name);
+               }
+       }
+  err:
+       freecon(user_context);
+       return 0;
+}
+#endif
+
 static void
 run_file(const char *filename, uid_t uid, gid_t gid)
 {
@@ -424,6 +494,13 @@ run_file(const char *filename, uid_t uid, gid_t gid)
 
 	    nice((tolower((int) queue) - 'a' + 1) * 2);
 
+#ifdef WITH_SELINUX
+	    if (selinux_enabled > 0) {
+	        if (set_selinux_context(pentry->pw_name, filename) < 0)
+	               perr("SELinux Failed to set context\n");
+	    }
+#endif
+
 	    if (initgroups(pentry->pw_name, pentry->pw_gid))
 		perr("Cannot initialize the supplementary group access list");
 
@@ -707,6 +784,10 @@ main(int argc, char *argv[])
     struct passwd *pwe;
     struct group *ge;
 
+#ifdef WITH_SELINUX
+    selinux_enabled=is_selinux_enabled();
+#endif
+
 /* We don't need root privileges all the time; running under uid and gid
  * daemon is fine.
  */
diff --git a/config.h.in b/config.h.in
index 4d7dc91..681d68e 100644
--- a/config.h.in
+++ b/config.h.in
@@ -192,6 +192,9 @@
    <sys/cpustats.h>. */
 #undef UMAX4_3
 
+/* Define if you are building with_selinux */
+#undef WITH_SELINUX
+
 /* Define to 1 if `lex' declares `yytext' as a `char *' by default, not a
    `char[]'. */
 #undef YYTEXT_POINTER
diff --git a/configure.ac b/configure.ac
index f3d2e35..1f6494a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -239,6 +239,14 @@ AC_ARG_WITH(daemon_username,
 )
 AC_SUBST(DAEMON_USERNAME)
 
+AC_ARG_WITH(selinux,
+[ --with-selinux       Define to run with selinux],
+AC_DEFINE(WITH_SELINUX, 1, [Define if you are building with_selinux]),
+)
+AC_CHECK_LIB(selinux, is_selinux_enabled, SELINUXLIB=-lselinux)
+AC_SUBST(SELINUXLIB)
+AC_SUBST(WITH_SELINUX)
+
 AC_MSG_CHECKING(groupname to run under)
 AC_ARG_WITH(daemon_groupname,
 [ --with-daemon_groupname=DAEMON_GROUPNAME	Groupname to run under (default daemon) ],
-- 
2.1.4
