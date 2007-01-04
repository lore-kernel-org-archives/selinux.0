Message-ID: <459D784C.4090806@hp.com>
Date: Thu, 04 Jan 2007 16:57:32 -0500
From: Linda Knippers <linda.knippers@hp.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, James Antill <jantill@redhat.com>,
        redhat-lspp <redhat-lspp@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [redhat-lspp] Re: [PATCH 2/3] Re: MLS enforcing PTYs, sshd,	and
 newrole
References: <20061012153701.75777.qmail@web36603.mail.mud.yahoo.com>	<1161776892.3987.193.camel@moss-spartans.epoch.ncsc.mil>	<1161778937.3987.218.camel@moss-spartans.epoch.ncsc.mil>	<1161784251.667.28.camel@code.and.org>	<1161784759.3987.295.camel@moss-spartans.epoch.ncsc.mil>	<1161803724.29689.57.camel@code.and.org>	<1161804290.3987.388.camel@moss-spartans.epoch.ncsc.mil>	<1161970810.29689.88.camel@code.and.org>	<1161974293.1306.167.camel@moss-spartans.epoch.ncsc.mil>	<1162238632.31104.11.camel@code.and.org>	<1162239394.31104.13.camel@code.and.org>	<1162304610.32614.24.camel@moss-spartans.epoch.ncsc.mil>	<1162304681.32614.26.camel@moss-spartans.epoch.ncsc.mil>	<1162306839.31104.23.camel@code.and.org>	<1162307495.32614.47.camel@moss-spartans.epoch.ncsc.mil>	<1162310652.31104.46.camel@code.and.org>	<1162311675.32614.81.camel@moss-spartans.epoch.ncsc.mil>	<1162319582.23631.1.camel@code.and.org> <1162384603.32614.163.camel@moss-spartans.epoch.ncsc.mil> <459D72EF.3090707@redhat.
 com>
In-Reply-To: <459D72EF.3090707@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> We still have a problem on MLS machines, in that newrole can be used to
> pass data via pseudo terminals.
> 
> script
> newrole -l SystemHigh
> cat TopSecret.doc
> ^d
> ^d
> cat typescript
> 
> I propose we add this patch to newrole to check if we are on a pseudo
> terminal and then fail if user is using -l.
> 
> Basically this patch checks the major number of the stdin, stdout,
> stderr for a number in the pseudo number range,  If yes the pseudo
> terminal, if not continue.  Not pretty but it solves the problem.  I
> could not figure out another way to check if you are on a pseudo terminal.
> Comments?
> 
> 
> diff --exclude-from=exclude --exclude POTFILES.in --exclude='*.po'
> --exclude='*.pot' -N -u -r nsapolicycoreutils/newrole/newrole.c
> policycoreutils-1.33.7/newrole/newrole.c
> --- nsapolicycoreutils/newrole/newrole.c        2006-11-29
> 17:11:18.000000000 -0500
> +++ policycoreutils-1.33.7/newrole/newrole.c    2007-01-04
> 16:24:47.000000000 -0500
> @@ -67,6 +67,7 @@
> #include <selinux/get_context_list.h>  /* for SELINUX_DEFAULTUSER */
> #include <signal.h>
> #include <unistd.h>            /* for getuid(), exit(), getopt() */
> +#include <sys/stat.h>
> #ifdef USE_AUDIT
> #include <libaudit.h>
> #endif
> @@ -93,6 +94,19 @@
> 
> extern char **environ;
> 
> +static int check_isapty(int fd) {
> +       struct stat buf;
> +       if ((isatty(fd)) && (fstat(fd, &buf) == 0)) {
> +               int dev=major(buf.st_rdev);
> +               if (dev >  135 && dev < 144) {

Where do these numbers come from?  Is UNIX98_PTY_SLAVE_MAJOR in
/usr/include/linux/major.h useful?  That's what the value is on
my system.  There's also PTY_SLAVE_MAJOR (value of 3) in that
file, but on my system that's the major for real ttys.

> +                       return 1;
> +               } else {
> +                       return 0;
> +               }
> +       }
> +       return 0;
> +}
> +                                      /**
>  * Construct from the current range and specified desired level a resulting
>  * range. If the specified level is a range, return that. If it is not,
> then
> @@ -733,6 +747,7 @@
>                                        security_context_t *new_context,
>                                        int *preserve_environment)
> {
> +       int i;                  /* index for open file descriptors */
>        int flag_index;         /* flag index in argv[] */
>        int clflag;             /* holds codes for command line flags */
>        char *role_s = NULL;    /* role spec'd by user in argv[] */
> @@ -793,6 +808,13 @@
>                                        "specified\n"));
>                                return -1;
>                        }
> +                       for (i=0; i < 3; i++) {
> +                               if (check_isapty(i)) {
> +                                       fprintf(stderr, "Error: you are
> not allowed to change levels on pseudo terminals\n");
> +                                       return -1;
> +                               }
> +                       }
> +
>                        level_s = optarg;
>                        break;
>                default:
> 
> 
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
