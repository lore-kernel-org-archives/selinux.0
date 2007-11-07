Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA7LJPg0030298
	for <selinux@tycho.nsa.gov>; Wed, 7 Nov 2007 16:19:25 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id lA7LJNiD004660
	for <selinux@tycho.nsa.gov>; Wed, 7 Nov 2007 21:19:24 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] Initial policy load from load_policy
Date: Wed, 7 Nov 2007 16:18:41 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588013316A9@exchange.columbia.tresys.com>
In-Reply-To: <47322B55.10806@tresys.com>
References: <47322B55.10806@tresys.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Chad Sellers" <csellers@tresys.com>, <selinux@tycho.nsa.gov>
Cc: <ubuntu-hardened@lists.ubuntu.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chad Sellers wrote:
> The below patch adds a -i option to load_policy to perform
> the initial policy load. The inital policy load is currently
> done in systems using sysvinit by init itself, which then
> re-exec's itself. Ubuntu uses upstart instead of sysvinit. In
> talks with the Ubuntu folks, they'd prefer to load policy
> from initramfs before upstart starts rather than patching upstart.
> 
> Signed-off-by: Chad Sellers <csellers@tresys.com>
> ---

Acked-by: Joshua Brindle <jbrindle@tresys.com>

> 
> load_policy.8 |   19 ++++++++++++++++++-
> load_policy.c |   29 +++++++++++++++++++++++++----
> 2 files changed, 43 insertions(+), 5 deletions(-)
> 
> Index: policycoreutils/load_policy/load_policy.c
> ===================================================================
> --- policycoreutils/load_policy/load_policy.c    (revision 2679)
> +++ policycoreutils/load_policy/load_policy.c    (working copy) @@
> -19,13 +19,13 @@ 
> 
>  void usage(char *progname)
>  {
> -    fprintf(stderr, _("usage:  %s [-q]\n"), progname);
> +    fprintf(stderr, _("usage:  %s [-qi]\n"), progname);      exit(1);
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
> +    while ((opt = getopt(argc, argv, "bqi")) > 0) {          switch
>          (opt) { case 'b':
>              fprintf(stderr, "%s:  Warning! The -b option is
> no longer supported, booleans are always preserved across
> reloads.  Continuing...\n", @@ -43,6 +43,9 @@
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
> +            /* SELinux is already enabled, we should not do
> an initial
> load again */
> +            fprintf(stderr,
> +                _("%s:  Policy is already loaded and initial load
> requested\n"), +                argv[0]);
> +            exit(2);
> +        }
> +        ret = selinux_init_load_policy(&enforce);
> +        if (ret != 0 ) {
> +             if (enforce > 0) {
> +                /* SELinux in enforcing mode but load_policy
> failed */
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
> +++ policycoreutils/load_policy/load_policy.8    (working copy) @@
> -4,7 +4,7 @@ 
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
> +Initial policy load failed and enforcing mode requested +
>  .SH SEE ALSO
>  .B booleans
>  (8),



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
