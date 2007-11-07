Subject: Re: [PATCH] Initial policy load from load_policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chad Sellers <csellers@tresys.com>
Cc: selinux@tycho.nsa.gov, ubuntu-hardened@lists.ubuntu.com
In-Reply-To: <47322B55.10806@tresys.com>
References: <47322B55.10806@tresys.com>
Content-Type: text/plain
Date: Wed, 07 Nov 2007 16:26:14 -0500
Message-Id: <1194470774.3956.188.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-11-07 at 16:17 -0500, Chad Sellers wrote:
> The below patch adds a -i option to load_policy to perform the initial 
> policy load. The inital policy load is currently done in systems using 
> sysvinit by init itself, which then re-exec's itself. Ubuntu uses 
> upstart instead of sysvinit. In talks with the Ubuntu folks, they'd 
> prefer to load policy from initramfs before upstart starts rather than 
> patching upstart.
> 
> Signed-off-by: Chad Sellers <csellers@tresys.com>
> ---
> 
> load_policy.8 |   19 ++++++++++++++++++-
> load_policy.c |   29 +++++++++++++++++++++++++----
> 2 files changed, 43 insertions(+), 5 deletions(-)
> 
> Index: policycoreutils/load_policy/load_policy.c
> ===================================================================
> --- policycoreutils/load_policy/load_policy.c    (revision 2679)
> +++ policycoreutils/load_policy/load_policy.c    (working copy)
> @@ -19,13 +19,13 @@
>  
>  void usage(char *progname)
>  {
> -    fprintf(stderr, _("usage:  %s [-q]\n"), progname);
> +    fprintf(stderr, _("usage:  %s [-qi]\n"), progname);
>      exit(1);
>  }
>  
>  int main(int argc, char **argv)
>  {
> -    int ret, opt, quiet = 0, nargs;
> +    int ret, opt, quiet = 0, nargs, init=0, enforce=0;
>  
>  #ifdef USE_NLS
>      setlocale(LC_ALL, "");
> @@ -33,7 +33,7 @@
>      textdomain(PACKAGE);
>  #endif
>  
> -    while ((opt = getopt(argc, argv, "bq")) > 0) {
> +    while ((opt = getopt(argc, argv, "bqi")) > 0) {
>          switch (opt) {
>          case 'b':
>              fprintf(stderr, "%s:  Warning! The -b option is no longer 
> supported, booleans are always preserved across reloads.  Continuing...\n",
> @@ -43,6 +43,9 @@
>              quiet = 1;
>              sepol_debug(0);
>              break;
> +        case 'i':
> +            init = 1;
> +            break;
>          default:
>              usage(argv[0]);
>          }
> @@ -62,7 +65,25 @@
>              argv[0], argv[optind++]);
>      }
>  
> -    ret = selinux_mkload_policy(1);
> +    if (init) {
> +        if (is_selinux_enabled() == 1) {
> +            /* SELinux is already enabled, we should not do an initial 
> load again */
> +            fprintf(stderr,
> +                _("%s:  Policy is already loaded and initial load 
> requested\n"),
> +                argv[0]);
> +            exit(2);
> +        }
> +        ret = selinux_init_load_policy(&enforce);
> +        if (ret != 0 ) {
> +             if (enforce > 0) {
> +                /* SELinux in enforcing mode but load_policy failed */

An error message here would be helpful, assuming that such error
messages are displayed at all on the console.

How do you plan to handle an error in the caller?  System should be
halted in this case.

> +                exit(3);
> +            }
> +        }
> +    }
> +    else {
> +        ret = selinux_mkload_policy(1);
> +    }
>      if (ret < 0) {
>          fprintf(stderr, _("%s:  Can't load policy:  %s\n"),
>              argv[0], strerror(errno));
> Index: policycoreutils/load_policy/load_policy.8
> ===================================================================
> --- policycoreutils/load_policy/load_policy.8    (revision 2679)
> +++ policycoreutils/load_policy/load_policy.8    (working copy)
> @@ -4,7 +4,7 @@
>  
>  .SH SYNOPSIS
>  .B load_policy
> -[-q]
> +[-qi]
>  .br
>  .SH DESCRIPTION
>  .PP
> @@ -17,7 +17,24 @@
>  .TP
>  .B \-q
>  suppress warning messages.
> +.TP
> +.B \-i
> +inital policy load. Only use this if this is the first time policy is 
> being loaded since boot (usually called from initramfs).
>  
> +.SH "EXIT STATUS"
> +.TP
> +.B 0
> +Success
> +.TP
> +.B 1
> +Invalid option
> +.TP
> +.B 2
> +Policy load failed
> +.TP
> +.B 3
> +Initial policy load failed and enforcing mode requested
> +
>  .SH SEE ALSO
>  .B booleans
>  (8),
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
