Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6M9JarT002967
	for <selinux@tycho.nsa.gov>; Thu, 22 Jul 2004 05:19:36 -0400 (EDT)
Received: from flame.hosts.ndo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6M9J8rx026828
	for <selinux@tycho.nsa.gov>; Thu, 22 Jul 2004 09:19:08 GMT
Received: from th-pm01-28.ndirect.co.uk ([195.7.225.92] helo=lkcl.net)
	by flame.hosts.ndo.com with esmtp (NDO SMTP Pool (Abuse to: abuse@ndo.com))
	id 1BnZCz-00025F-00
	for <selinux@tycho.nsa.gov>; Thu, 22 Jul 2004 09:45:45 +0100
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BnZNj-0000u4-AV
	for selinux@tycho.nsa.gov; Thu, 22 Jul 2004 09:56:51 +0100
Date: Thu, 22 Jul 2004 09:56:51 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SELinux <selinux@tycho.nsa.gov>
Subject: Re: running interpreted scripts in different domains
Message-ID: <20040722085651.GD3252@lkcl.net>
References: <40FADE92.7060307@gentoo.org> <1090338174.25139.60.camel@moss-lions.epoch.ncsc.mil> <40FD6114.3020808@gentoo.org> <1090355250.25139.130.camel@moss-lions.epoch.ncsc.mil> <40FD814B.2060503@gentoo.org> <20040721230605.GD2848@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040721230605.GD2848@jmh.mhn.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jul 22, 2004 at 01:06:06AM +0200, Thomas Bleher wrote:

> How does cron handle this? I think that cron is in a similar situation
> since it can't exec the users crontab. From macros/program/crond_macros.te:
> 
> # Permit a transition from the crond_t domain to this domain.
> # The transition is requested explicitly by the modified crond
> # via execve_secure.  There is no way to set up an automatic
> # transition, since crontabs are configuration files, not executables.
> domain_trans(crond_t, shell_exec_t, $1_crond_t)
> 
> Additionaly, crond has this:
> # Set exec context.
> can_setexec(crond_t)
> 
> Maybe someone who knows the cron code better than me can explain what
> exactly cron is doing and if this can be applied to the fastcgi code as
> well.

this patch fragment is out-of-date, dan walsh has done some updates
since:

	--- database.c.old	2004-05-19 10:03:06.000000000 +0100
	+++ database.c	2004-05-20 15:15:55.000000000 +0100
	@@ -30,6 +30,11 @@
	 #include <sys/stat.h>
	 #include <sys/file.h>
	 
	+#ifdef WITH_SELINUX
	+#include <selinux/selinux.h>
	+#include <selinux/flask.h>
	+#include <selinux/av_permissions.h>
	+#endif
	 
	 #define TMAX(a,b) ((a)>(b)?(a):(b))
	 
	@@ -46,7 +51,7 @@
	 
	 #endif /* ifndef PATH_MAX */
	 
	-static	void		process_crontab __P((char *, char *, char *,
	+static	void 		process_crontab __P((char *, char *, char *,
							 struct stat *,
							 cron_db *, cron_db *));
	 #ifdef DEBIAN
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
	
which i believe to be testing the access permissions on the crontab
file, and in child_process() which is called by do_command() which
is called by job_queue():


#ifdef WITH_SELINUX
            if (is_selinux_enabled()) {
              security_context_t scontext;
              if (get_default_context(u->name, NULL, &scontext)) {
                fprintf(stderr, "execle_secure: couldn't get security context for user %s\n", u->name);
                _exit(ERROR_EXIT);
              }
              if (setexeccon(scontext) < 0) {
                fprintf(stderr, "Could not set exec context to %s for user  %s\n", scontext,u->name);
                _exit(ERROR_EXIT);
              }
              freecon(scontext);
            }
#endif
                        execle(shell, shell, "-c", e->cmd, (char *)0, jobenv);
            fprintf(stderr, "execl: couldn't exec `%s'\n", shell);
            perror("execl");
            _exit(ERROR_EXIT);
        }

which ensures that the command is run under the correct user context (u->name).

dan, steven, russell and the deb maintainer steve greene had a bash at
going over this because the deb maintainer would not accept the patch:
the reason it turned out was because of bugs in the patch _and_ in
cron over how to deal with running cron jobs as non-user (i.e. as
the cron system, and the fake and deliberately nonexistent username 
*system* was used to "represent" the cron system such that if a
getpwnam was called with "*system*" it would always fail).

of course, cron _does_ have the concept of system, called system_u :)

anyway, as you can see, the shell command is exec'd, there's also
a cron_popen() but i haven't tracked down how it's called.

if fastcgi does an exec?e to run the cgi script, cron's code would,
i believe, be a useful starting point.

l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
