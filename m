Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4J9HeRb008648
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 05:17:40 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4J9HcAR024258
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 09:17:38 GMT
Received: from smtp800.mail.ukl.yahoo.com (smtp800.mail.ukl.yahoo.com [217.12.12.142])
        by jazzband.ncsc.mil  with SMTP id i4J9HbHn024255 for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 09:17:37 GMT
Date: Wed, 19 May 2004 09:14:54 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Cc: 193644@bugs.debian.org
Subject: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=193644 (cron upstream patch)
Message-ID: <20040519091454.GL7348@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="JP+T4n/bALQSJXh8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hiya russell,

regarding the conversation with the upstream author, it
appears that he's expecting a response from you about some
issues with SYSUSERNAME and also with some apparent gcc niggle.

section cut/paste here:

  	if (syscron_stat.st_mtime) {
	> +#ifdef CONFIG_FLASK
	> +		process_crontab("root", SYSUSERNAME,
	> +#else
	>  		process_crontab("root", "*system*",
	> +#endif
	>  				SYSCRONTAB, &syscron_stat,
	>  				&new_db, old_db);
	>  	}

	See, this is still wrong. I asked Russell about it,
	but never got an answer (or I lost it, or never
	sent it, or something; it's not in my mail archive,
	anyway.). To re-iterate: "*system*" is not a username,
	it simply a string used to distinguish user crontabs
	(/var/spool/cron/*) from system crontabs (/etc/crontab,
	/etc/cron.d/*). The only importance is that not be a
	valid user name.

and i note that SYSUSERNAME is #defined to "system_u" in
cron.h

i take it that this is a more "informative" string
than "*system*" but it is equally as non-username-ish
as "*system*" is.

*thinks*....

... i think the patch to cron is wrong: i believe it should be this:

@@ -199,7 +208,11 @@
	continue;

	/* Generate the "fname" */
+#ifdef WITH_SELINUX
+       (void) strcpy(fname, SYSUSERNAME);
+#else
	(void) strcpy(fname,"*system*");
+#endif
	(void) strcat(fname, dp->d_name);
	sprintf(tabname,"%s/%s", SYSCRONDIR, dp->d_name);

@@ -324,6 +337,14 @@

the "fake" name created therefore contains information useful
to SELinux users whilst at the same time maintaining compatibility
with the purpose behind "*system*".

the original patch accidentally changed the behaviour of cron because
of the detection strcmp("*system",..) further on.

NB FOR ALL CRON USERS!!!

l.

-- 
-- 
expecting email to be received and understood is a bit like
picking up the telephone and immediately dialing without
checking for a dial-tone; speaking immediately without listening
for either an answer or ring-tone; hanging up immediately and
believing that you have actually started a conversation.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=f

diff -ru orig/cron-3.0pl1.orig/Makefile cron-3.0pl1/Makefile
--- orig/cron-3.0pl1.orig/Makefile	2004-05-19 09:10:08.000000000 +0000
+++ cron-3.0pl1/Makefile	2004-05-19 09:06:41.000000000 +0000
@@ -52,10 +52,10 @@
 DESTBIN		=	$(DESTROOT)/bin
 DESTMAN		=	$(DESTROOT)/share/man
 #<<need bitstring.h>>
-INCLUDE		=	-I.
+INCLUDE		=	-I. -I/usr/include/selinux
 #INCLUDE	=
 #<<need getopt()>>
-LIBS		= $(PAM_LIBS)
+LIBS		= $(PAM_LIBS) -lselinux
 #<<optimize or debug?>>
 OPTIM		=	-O2
 #OPTIM		=	-g
@@ -74,7 +74,7 @@
 # Allow override from command line
 DEBUG_DEFS = -DDEBUGGING=0   
 # The -DUSE_SIGCHLD is needed for the Alpha port
-DEFS = -DDEBIAN -DUSE_SIGCHLD $(DEBUG_DEFS) $(PAM_DEFS)
+DEFS = -DDEBIAN -DUSE_SIGCHLD $(DEBUG_DEFS) $(PAM_DEFS) -DWITH_SELINUX
 #(SGI IRIX systems need this)
 #DEFS		=	-D_BSD_SIGNALS -Dconst=
 #<<the name of the BSD-like install program>>
diff -ru orig/cron-3.0pl1.orig/config.h cron-3.0pl1/config.h
--- orig/cron-3.0pl1.orig/config.h	2004-05-19 09:10:08.000000000 +0000
+++ cron-3.0pl1/config.h	2004-05-19 09:06:41.000000000 +0000
@@ -43,7 +43,7 @@
 			 */
 
 #define MAILCMD _PATH_SENDMAIL					/*-*/
-/* #define MAILARGS "%s -i -FCronDaemon -odi -oem  %s"		/*-*/
+/* #define MAILARGS "%s -i -FCronDaemon -odi -oem  %s"		-*/
 #define MAILARGS "%s -i -FCronDaemon -oem  %s"		/*-*/
 			/* -i    = don't terminate on "." by itself
                          * -Fx	 = set full-name of sender
diff -ru orig/cron-3.0pl1.orig/cron.h cron-3.0pl1/cron.h
--- orig/cron-3.0pl1.orig/cron.h	2004-05-19 09:10:08.000000000 +0000
+++ cron-3.0pl1/cron.h	2004-05-19 09:06:41.000000000 +0000
@@ -40,6 +40,10 @@
 #include "config.h"
 #include "externs.h"
 
+#ifdef WITH_SELINUX 
+#define SYSUSERNAME "system_u"
+#endif
+
 	/* these are really immutable, and are
 	 *   defined for symbolic convenience only
 	 * TRUE, FALSE, and ERR must be distinct
Only in cron-3.0pl1/: cron.h.old
diff -ru orig/cron-3.0pl1.orig/database.c cron-3.0pl1/database.c
--- orig/cron-3.0pl1.orig/database.c	2004-05-19 09:10:08.000000000 +0000
+++ cron-3.0pl1/database.c	2004-05-19 09:08:13.000000000 +0000
@@ -30,6 +30,11 @@
 #include <sys/stat.h>
 #include <sys/file.h>
 
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
+#include <selinux/flask.h>
+#include <selinux/av_permissions.h>
+#endif
 
 #define TMAX(a,b) ((a)>(b)?(a):(b))
 
@@ -167,7 +172,11 @@
 	new_db.head = new_db.tail = NULL;
 
 	if (syscron_stat.st_mtime) {
+#ifdef WITH_SELINUX
+		process_crontab("root", SYSUSERNAME,
+#else
 		process_crontab("root", "*system*",
+#endif
 				SYSCRONTAB, &syscron_stat,
 				&new_db, old_db);
 	}
@@ -199,7 +208,11 @@
 		  continue;
 
 		/* Generate the "fname" */
+#ifdef WITH_SELINUX
+		(void) strcpy(fname, SYSUSERNAME);
+#else
 		(void) strcpy(fname,"*system*");
+#endif
 		(void) strcat(fname, dp->d_name);
 		sprintf(tabname,"%s/%s", SYSCRONDIR, dp->d_name);
 
@@ -324,6 +337,14 @@
 	int		crontab_fd = OK - 1;
 	user		*u;
 
+#ifdef WITH_SELINUX
+	security_context_t  file_context=NULL;
+	security_context_t   user_context=NULL;
+	struct av_decision avd;
+	int retval=0, selinux_enabled = is_selinux_enabled();
+
+	if (strcmp(fname, SYSUSERNAME) && !(pw = getpwnam(uname))) {
+#else
 #ifdef DEBIAN
 	/* If the name begins with *system*, don't worry about password -
 	 it's part of the system crontab */
@@ -331,6 +352,7 @@
 #else
 	if (strcmp(fname, "*system*") && !(pw = getpwnam(uname))) {
 #endif
+#endif
 		/* file doesn't have a user in passwd file.
 		 */
 		if (strncmp(fname, "tmp.", 4)) {
@@ -349,6 +371,14 @@
 		goto next_crontab;
             }
 
+#ifdef WITH_SELINUX
+	    if (selinux_enabled) {
+		if (fgetfilecon(crontab_fd, &file_context) < OK) {
+		    log_it(fname, getpid(), "getfilecon FAILED", tabname);
+		    goto next_crontab;
+		}
+	    }
+#endif
             if (fstat(crontab_fd, statbuf) < OK) {
 		log_it(fname, getpid(), "FSTAT FAILED", tabname);
 		goto next_crontab;
@@ -385,6 +415,14 @@
 		goto next_crontab;
             }
 
+#ifdef WITH_SELINUX
+	    if (selinux_enabled) {
+		if (fgetfilecon(crontab_fd, &file_context) < OK) {
+		    log_it(fname, getpid(), "getfilecon FAILED", tabname);
+		    goto next_crontab;
+		}
+	    }
+#endif
             if (fstat(crontab_fd, statbuf) < OK) {
 		log_it(fname, getpid(), "FSTAT FAILED", tabname);
 		goto next_crontab;
@@ -425,6 +463,31 @@
 		free_user(u);
 		log_it(fname, getpid(), "RELOAD", tabname);
 	}
+#ifdef WITH_SELINUX
+	if (selinux_enabled)	{
+		/*
+		 * Since crontab files are not directly executed,
+		 * crond must ensure that the crontab file has
+		 * a context that is appropriate for the context of
+		 * the user cron job.  It performs an entrypoint
+		 * permission check for this purpose.
+		 */
+		if (get_default_context(fname, NULL, &user_context)) {
+			log_it(fname, getpid(), "NO CONTEXT", tabname);
+			goto next_crontab;
+		}
+		retval = security_compute_av(user_context, file_context,
+			SECCLASS_FILE, FILE__ENTRYPOINT, &avd);
+		freecon(user_context);
+		freecon(file_context);
+		file_context = NULL;
+
+		if (retval || ((FILE__ENTRYPOINT & avd.allowed) != FILE__ENTRYPOINT)) {
+			log_it(fname, getpid(), "ENTRYPOINT FAILED", tabname);
+			goto next_crontab;
+		}
+	}
+#endif
 	u = load_user(crontab_fd, pw, fname);
 	if (u != NULL) {
 		u->mtime = statbuf->st_mtime;
@@ -436,6 +499,12 @@
 		Debug(DLOAD, (" [done]\n"))
 		close(crontab_fd);
 	}
+#ifdef WITH_SELINUX
+	if(file_context) {
+		freecon(file_context);
+		file_context = NULL;
+	}
+#endif
 }
 
 #ifdef DEBIAN
Only in cron-3.0pl1/: database.c.old
diff -ru orig/cron-3.0pl1.orig/debian/changelog cron-3.0pl1/debian/changelog
--- orig/cron-3.0pl1.orig/debian/changelog	2004-05-19 09:10:08.000000000 +0000
+++ cron-3.0pl1/debian/changelog	2004-05-19 09:06:42.000000000 +0000
@@ -1,3 +1,9 @@
+cron (3.0pl1-83.se1) unstable; urgency=low
+
+  * Built with new SE Linux support.
+
+ -- Russell Coker <russell@coker.com.au>  Fri, 23 Jan 2004 13:58:00 +1100
+
 cron (3.0pl1-83) unstable; urgency=low
 
   * Update default MTA from exim to exim4 (closes:#228561)
diff -ru orig/cron-3.0pl1.orig/debian/control cron-3.0pl1/debian/control
--- orig/cron-3.0pl1.orig/debian/control	2004-05-19 09:10:08.000000000 +0000
+++ cron-3.0pl1/debian/control	2004-05-19 09:06:42.000000000 +0000
@@ -3,13 +3,13 @@
 Priority: important
 Maintainer: Steve Greenland <stevegr@debian.org>
 Standards-Version: 3.6.1
-Build-Depends: debhelper, libpam0g-dev
+Build-Depends: debhelper, libpam0g-dev, libselinux1-dev
 
 Package: cron
 Architecture: any
 Depends: ${shlibs:Depends}, debianutils (>=1.7), adduser
 Recommends: exim4 | postfix | mail-transport-agent
-Suggests: anacron (>=2.0-1), logrotate, lockfile-progs, checksecurity
+Suggests: anacron (>=2.0-1), logrotate, lockfile-progs
 Conflicts: suidmanager (<< 0.50), lockfile-progs (<< 0.1.7)
 Provides:
 Description: management of regular background processing
diff -ru orig/cron-3.0pl1.orig/do_command.c cron-3.0pl1/do_command.c
--- orig/cron-3.0pl1.orig/do_command.c	2004-05-19 09:10:08.000000000 +0000
+++ cron-3.0pl1/do_command.c	2004-05-19 09:06:42.000000000 +0000
@@ -42,6 +42,10 @@
    }
 #endif
 
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
+#endif
+
 
 static void		child_process __P((entry *, user *)),
 			do_univ __P((user *));
@@ -323,6 +327,20 @@
 			}
 			fprintf(stdout,"error");
 #endif
+#ifdef WITH_SELINUX
+			if (is_selinux_enabled()) {
+			  security_context_t scontext;
+			  if (get_default_context(u->name, NULL, &scontext)) {
+			    fprintf(stderr, "execle_secure: couldn't get security context for user %s\n", u->name);
+			    _exit(ERROR_EXIT);
+			  }
+			  if (setexeccon(scontext) < 0) {
+			    fprintf(stderr, "Could not set exec context to %s for user  %s\n", scontext,u->name);
+			    _exit(ERROR_EXIT);
+			  }
+			  freecon(scontext);
+			}
+#endif
                         execle(shell, shell, "-c", e->cmd, (char *)0, jobenv);
 			fprintf(stderr, "execl: couldn't exec `%s'\n", shell);
 			perror("execl");

--JP+T4n/bALQSJXh8--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
