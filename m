Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA08489
	for <selinux@tycho.nsa.gov>; Mon, 22 Oct 2001 15:55:05 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA27188
	for <selinux@tycho.nsa.gov>; Mon, 22 Oct 2001 19:54:32 GMT
Received: from eifcomm.temp.veriohosting.com (eifcomm.temp.veriohosting.com [128.121.114.102])
	by jazzband.ncsc.mil  with ESMTP id TAA27180
	for <selinux@tycho.nsa.gov>; Mon, 22 Oct 2001 19:54:30 GMT
Message-ID: <3BD4EA5E.AB64B491@eif.net>
Date: Mon, 22 Oct 2001 20:56:14 -0700
From: R Cescon <roberto@eif.net>
MIME-Version: 1.0
To: James Bishop <james.bishop@jrc.it>, selinux@tycho.nsa.gov
Subject: Re: Patched SuSE 7.2 openssh-2.9p1 / Policy for SuSE 7.2?
References: <3BD447C4.1050107@jrc.it>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello
Where can I get a free suse 7.2 laptop ?
Rob

James Bishop wrote:

> Good afternoon,
>
> I compiled and installed the SELinux 2.4.12 distribution on my SuSE 7.2
> laptop. I got sshd compiled and running from the SuSE openssh-2.9p1
> sources (diffs for the session.c and shpty.c are attached - these were
> generated from my modified sources against the openssh-2.9p1 sources
> with the SuSE patches).
>
> Now I'm trying to sort out an appropriate security policy for the "SuSE
> way". The first avc error message which I 'm trying to resolve concerns
> an executable named "blogger". When booting (or switching run-levels),
> SuSE produces a boot log (/var/log/boot.msg) using a daemon called blogd
> and messages written to it by blogger. When the /etc/init.d/rc script
> terminates, blogd is killed.
>
> As far as I can see from the flask.pdf and policy-200109261436.pdf
> documents, I should define a domain for blogd. Domain definitions (e.g.
> for syslogd & klogd, which appear to be related to blogd - my
> assumption) reside in the policy/domains/system/*te files, but in
> general, how should I determine what privileges / capabilities should be
> assigned to a new  executable?
>
> Alternatively, has anyone sorted this out already?
>
> James
>
>   ------------------------------------------------------------------------
> --- openssh-2.9p1/session.c     Thu Oct 18 10:58:38 2001
> +++ openssh-2.9p1-selinux/session.c     Thu Oct 18 10:58:52 2001
> @@ -68,6 +68,12 @@
>  #include <sat.h>
>  #endif /* WITH_IRIX_AUDIT */
>
> +#ifdef WITH_SELINUX
> +#include <flask_util.h>
> +#include <get_user_sid.h>
> +#include <proc_secure.h>
> +#endif
> +
>  #if defined(HAVE_USERSEC_H)
>  #include <usersec.h>
>  #endif
> @@ -1060,6 +1066,25 @@
>  #endif /* WITH_IRIX_ARRAY */
>  #endif /* WITH_IRIX_JOBS */
>
> +#ifdef WITH_SELINUX
> +       int flask_enabled;
> +       security_context_t scontext = NULL;
> +       security_id_t sid;
> +
> +       flask_enabled = is_flask_enabled();
> +       if (flask_enabled) {
> +               if (!get_default_user_sid(pw->pw_name,
> +                                         strlen(pw->pw_name),
> +                                         &scontext,
> +                                         &sid)) {
> +                       fprintf(stderr, "Could not obtain SID for user %s\n",
> +                               pw->pw_name);
> +                       exit(1);
> +               }
> +       }
> +#endif
> +
> +
>         /* remove hostkey from the child's memory */
>         destroy_sensitive_data();
>
> @@ -1497,6 +1522,7 @@
>                                                 printf("You have new mail.\n");
>                                 }
>                         }
> +
>                         /* Start the shell.  Set initial character to '-'. */
>                         buf[0] = '-';
>                         strncpy(buf + 1, cp, sizeof(buf) - 1);
> @@ -1505,6 +1531,11 @@
>                         /* Execute the shell. */
>                         argv[0] = buf;
>                         argv[1] = NULL;
> +#ifdef WITH_SELINUX
> +                        if (flask_enabled)
> +                                execve_secure(shell, argv, env, sid);
> +                        else
> +#endif
>                         execve(shell, argv, env);
>
>                         /* Executing the shell failed. */
> @@ -1531,6 +1562,11 @@
>         argv[1] = "-c";
>         argv[2] = (char *) command;
>         argv[3] = NULL;
> +#ifdef WITH_SELINUX
> +        if (flask_enabled)
> +                execve_secure(shell, argv, env, sid);
> +        else
> +#endif
>         execve(shell, argv, env);
>         perror(shell);
>         exit(1);
>
>   ------------------------------------------------------------------------
> --- openssh-2.9p1/sshpty.c      Thu Oct 18 10:58:38 2001
> +++ openssh-2.9p1-selinux/sshpty.c      Thu Oct 18 10:58:52 2001
> @@ -21,6 +21,13 @@
>  #include "sshpty.h"
>  #include "log.h"
>
> +#ifdef WITH_SELINUX
> +#include <flask_util.h>
> +#include <get_user_sid.h>
> +#include <fs_secure.h>
> +#include <ss.h>
> +#endif
> +
>  /* Pty allocated with _getpty gets broken if we do I_PUSH:es to it. */
>  #if defined(HAVE__GETPTY) || defined(HAVE_OPENPTY)
>  #undef HAVE_DEV_PTMX
> @@ -297,6 +304,23 @@
>         mode_t mode;
>         struct stat st;
>
> +#ifdef WITH_SELINUX
> +        int flask_enabled;
> +        security_context_t scontext = NULL;
> +        security_id_t user_sid, old_tty_sid, new_tty_sid;
> +
> +        flask_enabled = is_flask_enabled();
> +        if (flask_enabled) {
> +                if (!get_default_user_sid(pw->pw_name,
> +                                          strlen(pw->pw_name),
> +                                          &scontext,
> +                                          &user_sid)) {
> +                        fatal("Could not obtain SID for user %s\n",
> +                              pw->pw_name);
> +                }
> +        }
> +#endif
> +
>         /* Determine the group to make the owner of the tty. */
>         grp = getgrnam("tty");
>         if (grp) {
> @@ -311,9 +335,22 @@
>          * Change owner and mode of the tty as required.
>          * Warn but continue if filesystem is read-only and the uids match.
>          */
> +#ifdef WITH_SELINUX
> +        if (flask_enabled) {
> +                if (stat_secure(ttyname, &st, &old_tty_sid))
> +                        fatal("stat_secure(%.100s) failed: %.100s", ttyname,
> +                              strerror(errno));
> +                if (security_change_sid (user_sid, old_tty_sid, SECCLASS_CHR_FILE, &new_tty_sid) != 0)
> +                       fatal("security_change_sid(%.100s) failed: %.100s", ttyname, strerror(errno));
> +        } else {
> +                if (stat(ttyname, &st))
> +                        fatal("stat(%.100s) failed: %.100s", ttyname,
> +                              strerror(errno));
> +        }
> +#else
>         if (stat(ttyname, &st))
> -               fatal("stat(%.100s) failed: %.100s", ttyname,
> -                   strerror(errno));
> +               fatal("stat(%.100s) failed: %.100s", ttyname, strerror(errno));
> +#endif
>
>         if (st.st_uid != pw->pw_uid || st.st_gid != gid) {
>                 if (chown(ttyname, pw->pw_uid, gid) < 0) {
> @@ -339,4 +376,12 @@
>                                       ttyname, mode, strerror(errno));
>                 }
>         }
> +
> +#ifdef WITH_SELINUX
> +        if (flask_enabled) {
> +                if (chsid (ttyname, new_tty_sid) != 0)
> +                        fatal("chsid(%.100s, %d) failed: %.100s",
> +                                      ttyname, new_tty_sid, strerror(errno));
> +        }
> +#endif
>  }


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
