Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4K68wRb016528
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 02:08:58 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4K66WB2006767
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 06:06:32 GMT
Received: from smtp800.mail.ukl.yahoo.com (smtp800.mail.ukl.yahoo.com [217.12.12.142])
	by jazzswing.ncsc.mil  with SMTP id i4K66Vwi006763
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 06:06:31 GMT
Date: Thu, 20 May 2004 06:06:06 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Steve Greenland <steveg@moregruel.net>, SE-Linux <selinux@tycho.nsa.gov>,
   193644@bugs.debian.org, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: Bug#193644: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=193644 (cron upstream patch)
Message-ID: <20040520060606.GG24597@lkcl.net>
References: <20040519091454.GL7348@lkcl.net> <1084973453.30873.76.camel@moss-spartans.epoch.ncsc.mil> <20040519140239.GF4221@lkcl.net> <20040519181120.GA6115@moregruel.net> <20040519200057.GD24597@lkcl.net> <20040519215409.GA7459@moregruel.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
In-Reply-To: <20040519215409.GA7459@moregruel.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 19, 2004 at 04:54:09PM -0500, Steve Greenland wrote:
> On 19-May-04, 15:00 (CDT), Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote: 
> > 
> >  ... therefore, i take it that you mean that the letters "system_u"
> >  _could_ be used as a username, whereas "*" is an invalid character
> >  which, _if_ used in /etc/passwd, would cause a login error.
> 
> Yes.
> 
> >  and i take it that _that_ is why you object to its use, yes?
> 
> No. How many times do I have to say this? It's the WRONG FSCKING FIELD.
> The field the SE linux people are so obsessed with changing is NOT
> THE USERNAME field. The username field is available. Using it for
> controlling the SE context would do the right thing, right? 

 no, it wouldn't, because in some cases the context switch must
 come from "system".

 "system" is like... a privilege ABOVE root, and i presume its
 closest equivalent is to the "SYSTEM" SID on the NT
 (actually VAX/VMS) security model.

 i think this can be resolved by adding an extra argument to
 process_crontab.  to put that another way: if an extra
 argument is added which is used solely the selinux context,
 the issue you have, steve, over the change from *system*
 to system_u goes away.

 patch to add extra argument which does not interfere with
 the concept of "*system*" is attached.

 l.


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=x

--- database.c.old	2004-05-19 09:03:06.000000000 +0000
+++ database.c	2004-05-20 06:04:24.000000000 +0000
@@ -30,6 +30,11 @@
 #include <sys/stat.h>
 #include <sys/file.h>
 
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
+#include <selinux/flask.h>
+#include <selinux/av_permissions.h>
+#endif
 
 #define TMAX(a,b) ((a)>(b)?(a):(b))
 
@@ -46,7 +51,11 @@
 
 #endif /* ifndef PATH_MAX */
 
-static	void		process_crontab __P((char *, char *, char *,
+static	void 		process_crontab __P((char *, char *,
+#ifdef WITH_SELINUX
+					     char *,
+#endif
+					     char *,
 					     struct stat *,
 					     cron_db *, cron_db *));
 #ifdef DEBIAN
@@ -168,6 +177,9 @@
 
 	if (syscron_stat.st_mtime) {
 		process_crontab("root", "*system*",
+#ifdef WITH_SELINUX
+				SYSUSERNAME,
+#endif
 				SYSCRONTAB, &syscron_stat,
 				&new_db, old_db);
 	}
@@ -205,7 +217,11 @@
 
 		/* statbuf is used as working storage by process_crontab() --
 		   current contents are irrelevant */
-		process_crontab("root", fname, tabname,
+		process_crontab("root", fname,
+#ifdef WITH_SELINUX
+				SYSUSERNAME,
+#endif
+				tabname,
 				&statbuf, &new_db, old_db);
 
 	}
@@ -236,7 +252,11 @@
 		(void) strcpy(fname, dp->d_name);
 		snprintf(tabname, PATH_MAX+1, CRON_TAB(fname));
 
-		process_crontab(fname, fname, tabname,
+		process_crontab(fname, fname,
+#ifdef WITH_SELINUX
+				fname,
+#endif
+				tabname,
 				&statbuf, &new_db, old_db);
 	}
 	closedir(dir);
@@ -312,9 +332,16 @@
 
 
 static void
-process_crontab(uname, fname, tabname, statbuf, new_db, old_db)
+process_crontab(uname, fname,
+#ifdef WITH_SELINUX
+		se_ctx_name,
+#endif
+		tabname, statbuf, new_db, old_db)
 	char		*uname;
 	char		*fname;
+#ifdef WITH_SELINUX
+	char		*se_ctx_name;
+#endif
 	char		*tabname;
 	struct stat	*statbuf;
 	cron_db		*new_db;
@@ -324,6 +351,13 @@
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
@@ -349,6 +383,14 @@
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
@@ -385,6 +427,14 @@
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
@@ -425,6 +475,31 @@
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
+		if (get_default_context(se_ctx_name, NULL, &user_context)) {
+			log_it(se_ctx_name, getpid(), "NO CONTEXT", tabname);
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
@@ -436,6 +511,12 @@
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

--BXVAT5kNtrzKuDFl--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
