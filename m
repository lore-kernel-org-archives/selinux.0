Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KEOwRb019017
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 10:24:58 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4KEMVB2000027
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 14:22:31 GMT
Received: from smtp803.mail.ukl.yahoo.com (smtp803.mail.ukl.yahoo.com [217.12.12.140])
	by jazzswing.ncsc.mil  with SMTP id i4KEMUwi000017
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 14:22:30 GMT
Date: Thu, 20 May 2004 14:22:12 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Steve Greenland <steveg@moregruel.net>, SE-Linux <selinux@tycho.nsa.gov>,
   193644@bugs.debian.org
Subject: Re: Bug#193644: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=193644 (cron upstream patch)
Message-ID: <20040520142212.GE8810@lkcl.net>
References: <20040519091454.GL7348@lkcl.net> <1084973453.30873.76.camel@moss-spartans.epoch.ncsc.mil> <20040519140239.GF4221@lkcl.net> <20040519181120.GA6115@moregruel.net> <20040519200057.GD24597@lkcl.net> <20040519215409.GA7459@moregruel.net> <1085054262.521.27.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8t9RHnE3ZwKMSgU+"
In-Reply-To: <1085054262.521.27.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 20, 2004 at 07:57:42AM -0400, Stephen Smalley wrote:
> On Wed, 2004-05-19 at 17:54, Steve Greenland wrote:
> > No. How many times do I have to say this? It's the WRONG FSCKING FIELD.
> > The field the SE linux people are so obsessed with changing is NOT
> > THE USERNAME field. The username field is available. Using it for
> > controlling the SE context would do the right thing, right? For the
> > real user crontabs, it would have the real username, even for root. For
> > the system crontabs, under /etc, it could be system_u. Then calling
> > SE_get_security_context(username) (or whatever the function/terminology
> > is) would always be the right thing to do, yes?
> 
> Yes, if we can get the field to be system_u for system crontabs (at
> least when SELinux is enabled), then that would likely be fine. 
> get_default_context will then get the proper context for system cron
> jobs.
 
 okay, what steve is saying is slowly sinking in.

 okay.  in process_crontab, line 360 or thereabouts, comment is
 "if name begins '*system*', don't worry about password".

 therefore, whatever you specify under such circumstances (fname
 == '*system*'), the uname argument is completely irrelevant.
 it could, in fact, be NULL.

 therefore, under such circumstances, whatever is specified in
 uname there can be no objection about.

 therefore, it is perfectly reasonable to do this, at both lines
 179 and 220 or thereabouts:

 process_crontab ("system_u", "*system*", ...)

 now, it so happens that at line 250 or thereabouts, the
 first and 2nd arg are identical (fname).

 conclusion:

 by doing process_crontab ("system_u", "*system*", ...) wherever
 "*system*" is used, and by doing get_default_context(uname, ...)
 inside process_crontab, the correct semantics are maintained.

 so in a roundabout way we conclude what appears to be very
 obvious, namely that instead of selecting "root" as the default
 context, we select "system_u" [in the same circumstances where
 cron "fudges" things by creating something non-user-ish called
 "*system*" which non-selinux-unix doesn't support].

 patch attached.... 

 l.


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=f

--- database.c.old	2004-05-19 09:03:06.000000000 +0000
+++ database.c	2004-05-20 14:15:55.000000000 +0000
@@ -30,6 +30,11 @@
 #include <sys/stat.h>
 #include <sys/file.h>
 
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
+#include <selinux/flask.h>
+#include <selinux/av_permissions.h>
+#endif
 
 #define TMAX(a,b) ((a)>(b)?(a):(b))
 
@@ -167,7 +172,7 @@
 	new_db.head = new_db.tail = NULL;
 
 	if (syscron_stat.st_mtime) {
-		process_crontab("root", "*system*",
+		process_crontab(SYSUSERNAME, "*system*",
 				SYSCRONTAB, &syscron_stat,
 				&new_db, old_db);
 	}
@@ -205,7 +210,7 @@
 
 		/* statbuf is used as working storage by process_crontab() --
 		   current contents are irrelevant */
-		process_crontab("root", fname, tabname,
+		process_crontab(SYSUSERNAME, fname, tabname,
 				&statbuf, &new_db, old_db);
 
 	}
@@ -324,6 +329,13 @@
 	int		crontab_fd = OK - 1;
 	user		*u;
 
+#ifdef WITH_SELINUX
+	security_context_t  file_context=NULL;
+	security_context_t   user_context=NULL;
+	struct av_decision avd;
+	int retval=0, selinux_enabled = (is_selinux_enabled() > 0);
+#endif
+
 #ifdef DEBIAN
 	/* If the name begins with *system*, don't worry about password -
 	 it's part of the system crontab */
@@ -349,6 +361,14 @@
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
@@ -385,6 +405,14 @@
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
@@ -425,6 +453,31 @@
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
+		if (get_default_context(uname, NULL, &user_context)) {
+			log_it(uname, getpid(), "NO CONTEXT", tabname);
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
@@ -436,6 +489,12 @@
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
--- cron.h.old	2004-05-19 09:03:48.000000000 +0000
+++ cron.h	2004-05-20 14:17:39.000000000 +0000
@@ -40,6 +40,12 @@
 #include "config.h"
 #include "externs.h"
 
+#ifdef WITH_SELINUX 
+#define SYSUSERNAME "system_u"
+#else
+#define SYSUSERNAME "root"
+#endif
+
 	/* these are really immutable, and are
 	 *   defined for symbolic convenience only
 	 * TRUE, FALSE, and ERR must be distinct

--8t9RHnE3ZwKMSgU+--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
