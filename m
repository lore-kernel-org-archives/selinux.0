Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6MDJLrT003993
	for <selinux@tycho.nsa.gov>; Thu, 22 Jul 2004 09:19:21 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6MDIsrx009937
	for <selinux@tycho.nsa.gov>; Thu, 22 Jul 2004 13:18:54 GMT
Message-ID: <40FFBED6.8070609@redhat.com>
Date: Thu, 22 Jul 2004 09:19:18 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: running interpreted scripts in different domains
References: <40FADE92.7060307@gentoo.org> <1090338174.25139.60.camel@moss-lions.epoch.ncsc.mil> <40FD6114.3020808@gentoo.org> <1090355250.25139.130.camel@moss-lions.epoch.ncsc.mil> <40FD814B.2060503@gentoo.org> <20040721230605.GD2848@jmh.mhn.de> <20040722085651.GD3252@lkcl.net>
In-Reply-To: <20040722085651.GD3252@lkcl.net>
Content-Type: multipart/mixed;
 boundary="------------080704030208090602050309"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080704030208090602050309
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Latest cron patch.

--------------080704030208090602050309
Content-Type: text/x-patch;
 name="vixie-cron-selinux.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vixie-cron-selinux.patch"

--- vixie-cron-3.0.1/Makefile.selinux	2004-06-25 12:31:30.000000000 -0400
+++ vixie-cron-3.0.1/Makefile	2004-06-25 12:31:30.000000000 -0400
@@ -55,7 +55,7 @@
 INCLUDE		=	-I.
 #INCLUDE	=
 #<<need getopt()>>
-LIBS		=
+LIBS		= -lselinux 
 #<<optimize or debug?>>
 OPTIM		=	$(RPM_OPT_FLAGS)
 #OPTIM		=	-g
@@ -71,7 +71,7 @@
 #<<want to use a nonstandard CC?>>
 #CC		=	vcc
 #<<manifest defines>>
-DEFS		= -s
+DEFS		= -s -DWITH_SELINUX
 #(SGI IRIX systems need this)
 #DEFS		=	-D_BSD_SIGNALS -Dconst=
 #<<the name of the BSD-like install program>>
--- vixie-cron-3.0.1/user.c.selinux	1995-05-31 17:37:22.000000000 -0400
+++ vixie-cron-3.0.1/user.c	2004-06-25 12:33:43.000000000 -0400
@@ -23,9 +23,73 @@
  */
 
 
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
+#include <selinux/flask.h>
+#include <selinux/av_permissions.h>
+#endif
+
 #include "cron.h"
 
 
+#ifdef WITH_SELINUX
+static	int get_security_context(char *name, 
+				 int crontab_fd, 
+				 security_context_t *rcontext, 
+				 char *tabname) {
+	security_context_t scontext;
+	security_context_t  file_context=NULL;
+	struct av_decision avd;
+	int retval=0;
+	*rcontext = NULL;
+	if (get_default_context(name, NULL, &scontext)) {
+		if (security_getenforce() > 0) {
+			log_it(name, getpid(), "No SELinux security context",tabname);
+			return -1;
+		} else {
+			log_it(name, getpid(), "No security context but SELinux in permissive mode, continuing",tabname);
+		}
+	}
+	
+	if (fgetfilecon(crontab_fd, &file_context) < OK) {
+		if (security_getenforce() > 0) {
+			log_it(name, getpid(), "getfilecon FAILED", tabname);
+			freecon(scontext);
+			return -1;
+		} else {
+			log_it(name, getpid(), "getfilecon FAILED but SELinux in permissive mode, continuing", tabname);
+			*rcontext=scontext;
+			return 0;
+		}
+	}
+    
+	/*
+	 * Since crontab files are not directly executed,
+	 * crond must ensure that the crontab file has
+	 * a context that is appropriate for the context of
+	 * the user cron job.  It performs an entrypoint
+	 * permission check for this purpose.
+	 */
+	retval = security_compute_av(scontext,
+				     file_context,
+				     SECCLASS_FILE,
+				     FILE__ENTRYPOINT,
+				     &avd);
+	freecon(file_context);
+	if (retval || ((FILE__ENTRYPOINT & avd.allowed) != FILE__ENTRYPOINT)) {
+		if (security_getenforce() > 0) {
+			log_it(name, getpid(), "ENTRYPOINT FAILED", tabname);
+			freecon(scontext);
+			return -1;
+		} else {
+			log_it(name, getpid(), "ENTRYPOINT FAILED but SELinux in permissive mode, continuing", tabname);
+		}
+	}
+	*rcontext=scontext;
+	return 0;
+}
+#endif
+
 void
 free_user(u)
 	user	*u;
@@ -37,15 +101,20 @@
 		ne = e->next;
 		free_entry(e);
 	}
+#ifdef WITH_SELINUX
+	freecon(u->scontext);
+#endif	
 	free(u);
 }
 
 
 user *
-load_user(crontab_fd, pw, name)
+load_user(crontab_fd, pw, uname, fname, tabname)
 	int		crontab_fd;
 	struct passwd	*pw;		/* NULL implies syscrontab */
-	char		*name;
+	char		*uname;
+	char		*fname;
+	char            *tabname;
 {
 	char	envstr[MAX_ENVSTR];
 	FILE	*file;
@@ -64,7 +133,7 @@
 	/* file is open.  build user entry, then read the crontab file.
 	 */
 	u = (user *) malloc(sizeof(user));
-	u->name = strdup(name);
+	u->name = strdup(fname);
 	u->crontab = NULL;
 
 	/* 
@@ -72,6 +141,22 @@
 	 */
 	envp = env_init();
 
+#ifdef WITH_SELINUX
+	if (is_selinux_enabled() > 0) {
+		char *sname=uname;
+		if (pw==NULL) {
+			sname="system_u";
+		}
+
+		if (get_security_context(sname, crontab_fd, 
+					 &u->scontext, tabname) != 0) {
+			free_user(u);
+			u = NULL;
+			goto done;
+		}
+	}
+#endif
+
 	/*
 	 * load the crontab
 	 */
--- vixie-cron-3.0.1/database.c.selinux	2004-06-25 12:31:30.000000000 -0400
+++ vixie-cron-3.0.1/database.c	2004-06-25 12:31:30.000000000 -0400
@@ -297,7 +297,7 @@
 		free_user(u);
 		log_it(fname, getpid(), "RELOAD", tabname);
 	}
-	u = load_user(crontab_fd, pw, fname);
+	u = load_user(crontab_fd, pw, uname, fname, tabname);
 	if (u != NULL) {
 		u->mtime = statbuf->st_mtime;
 		link_user(new_db, u);
--- vixie-cron-3.0.1/cron.h.selinux	2004-06-25 12:31:30.000000000 -0400
+++ vixie-cron-3.0.1/cron.h	2004-06-25 12:31:30.000000000 -0400
@@ -39,7 +39,9 @@
 #include "pathnames.h"
 #include "config.h"
 #include "externs.h"
-
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
+#endif
 	/* these are really immutable, and are
 	 *   defined for symbolic convenience only
 	 * TRUE, FALSE, and ERR must be distinct
@@ -174,6 +176,9 @@
 	char		*name;
 	time_t		mtime;		/* last modtime of crontab */
 	entry		*crontab;	/* this person's crontab */
+#ifdef WITH_SELINUX
+        security_context_t scontext;    /* SELinux security context */
+#endif
 } user;
 
 typedef	struct _cron_db {
@@ -219,7 +224,7 @@
 		**env_copy __P((char **)),
 		**env_set __P((char **, char *));
 
-user		*load_user __P((int, struct passwd *, char *)),
+user		*load_user __P((int, struct passwd *, char *, char *, char *)),
 		*find_user __P((cron_db *, char *));
 
 entry		*load_entry __P((FILE *, void (*)(),
--- vixie-cron-3.0.1/do_command.c.selinux	2004-06-25 12:31:30.000000000 -0400
+++ vixie-cron-3.0.1/do_command.c	2004-06-25 12:31:30.000000000 -0400
@@ -29,6 +29,9 @@
 # include <syslog.h>
 #endif
 
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
+#endif
 
 static void		child_process __P((entry *, user *)),
 			do_univ __P((user *));
@@ -251,6 +254,18 @@
 			 */
 			(void) signal(SIGCHLD, SIG_DFL);
 #endif
+#ifdef WITH_SELINUX
+			if (is_selinux_enabled() >0 ) {
+				if (setexeccon(u->scontext) < 0) {
+					if (security_getenforce() > 0) {
+						fprintf(stderr, 
+							"Could not set exec context to %s for user  %s\n", 
+							u->scontext,u->name);
+						_exit(ERROR_EXIT);
+					}
+				}
+			}
+#endif
 			execle(shell, shell, "-c", e->cmd, (char *)0, e->envp);
 			fprintf(stderr, "execl: couldn't exec `%s'\n", shell);
 			perror("execl");


--------------080704030208090602050309--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
