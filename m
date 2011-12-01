Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pB1EL19U009146
	for <selinux@tycho.nsa.gov>; Thu, 1 Dec 2011 09:21:01 -0500
Received: from mail-vw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id pB1EL0kR022798
	for <selinux@tycho.nsa.gov>; Thu, 1 Dec 2011 14:21:00 GMT
Received: by vbbff1 with SMTP id ff1so1605800vbb.12
        for <selinux@tycho.nsa.gov>; Thu, 01 Dec 2011 06:21:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1322491408.86714.YahooMailClassic@web87009.mail.ird.yahoo.com>
References: <1322491408.86714.YahooMailClassic@web87009.mail.ird.yahoo.com>
Date: Thu, 1 Dec 2011 09:21:00 -0500
Message-ID: <CACLa4ptw_OBUK5EgkEhN2gA_KEL+zdVAevBHqbSrC+DWUqGUqA@mail.gmail.com>
Subject: Re: [PATCH 1/1] policycoreutils: sestatus: Updated sestatus and man pages.
From: Eric Paris <eparis@parisplace.org>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Applied to my devel branch after whitespace fixups.

thanks!

On Mon, Nov 28, 2011 at 9:43 AM, Richard Haines
<richard_c_haines@btinternet.com> wrote:
> sestatus has been modified to present additional information: SELinux root
> directory, MLS flag and the deny_unknow flag. The man page has been updated
> to reflect these changes and an sestatus.conf(5) man page has also been added.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  policycoreutils/sestatus/Makefile        |    2 +
>  policycoreutils/sestatus/sestatus.8      |   62 ++++++++++++++-----
>  policycoreutils/sestatus/sestatus.c      |   82 ++++++++++++++++++++-----
>  policycoreutils/sestatus/sestatus.conf.5 |   97 ++++++++++++++++++++++++++++++
>  4 files changed, 209 insertions(+), 34 deletions(-)
>  create mode 100644 policycoreutils/sestatus/sestatus.conf.5
>
> diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestatus/Makefile
> index 5774e22..c5db7a3 100644
> --- a/policycoreutils/sestatus/Makefile
> +++ b/policycoreutils/sestatus/Makefile
> @@ -15,9 +15,11 @@ sestatus:  sestatus.o
>
>  install: all
>        [ -d $(MANDIR)/man8 ] || mkdir -p $(MANDIR)/man8
> +       [ -d $(MANDIR)/man5 ] || mkdir -p $(MANDIR)/man5
>        -mkdir -p $(SBINDIR)
>        install -m 755 sestatus $(SBINDIR)
>        install -m 644 sestatus.8 $(MANDIR)/man8
> +       install -m 644 sestatus.conf.5 $(MANDIR)/man5
>        -mkdir -p $(ETCDIR)
>        install -m 644 sestatus.conf $(ETCDIR)
>
> diff --git a/policycoreutils/sestatus/sestatus.8 b/policycoreutils/sestatus/sestatus.8
> index 049892d..2fd5bbb 100644
> --- a/policycoreutils/sestatus/sestatus.8
> +++ b/policycoreutils/sestatus/sestatus.8
> @@ -1,4 +1,4 @@
> -.TH "sestatus" "8" "2005111103" "" ""
> +.TH "sestatus" "8" "26 Nov 2011" "Security Enhanced Linux" "SELinux command line documentation"
>  .SH "NAME"
>  sestatus \- SELinux status tool
>
> @@ -12,38 +12,66 @@ This tool is used to get the status of a system running SELinux.
>  This manual page describes the
>  .BR sestatus
>  program.
> -.br
> -This tool is used to get the status of a system running SELinux.  It displays data about whether SELinux is enabled, disabled, the loaded policy and whether it is in enforcing or permissive mode.  It can also be used to display the security context of files and processes listed in the /etc/sestatus.conf file.
> -
> +.sp
> +This tool is used to get the status of a system running SELinux. It displays data about whether SELinux is enabled or disabled, location of key directories, and the loaded policy with its status as shown in the example:
> +.RS
>  > sestatus
>  .br
> -SELinux status:         enabled
> +SELinux status:              enabled
> +.br
> +SELinuxfs mount:             /selinux
> +.br
> +SELinux root directory:      /etc/selinux
> +.br
> +Loaded policy name:          targeted
> +.br
> +Current mode:                permissive
> +.br
> +Mode from config file:       enforcing
>  .br
> -SELinuxfs mount:        /selinux
> +Policy MLS status:           enabled
>  .br
> -Current Mode:           permissive
> +Policy deny_unknown status:  allow
>  .br
> -Policy version:         16
> +Max kernel policy version:   26
> +.RE
> +.sp
> +\fBsestatus\fR can also be used to display:
> +.RS
> +.IP "-" 4
> +The security context of files and processes listed in the \fI/etc/sestatus.conf\fR file. The format of this file is described in \fBsestatus.conf\fR(5).
> +.IP "-" 4
> +The status of booleans.
> +.RE
>
>  .SH "OPTIONS"
> -.TP
> -
>  .B \-v
> -.P
> - Checks the contexts of a files , and a processes listed in the /etc/sestatus.conf file.  It also checks the context of the target, in cases of
> -symlinks.
> -
> +.RS
> +Displays the contexts of files and processes listed in the \fI/etc/sestatus.conf\fR file. It also checks whether the file is a symbolic link, if so then the context of the target file is also shown.
> +.sp
> +The following contexts will always be displayed:
> +.RS
> +The current process context
> +.br
> +The init process context
> +.br
> +The controlling terminal file context
> +.RE
> +.RE
> +.sp
>  .B \-b
> -.P
> +.RS
>  Display the current state of booleans.
> -
> +.RE
>
>  .SH "FILES"
> -/etc/sestatus.conf
> +.I /etc/sestatus.conf
>
>  .SH "AUTHOR"
>  This man page was written by Daniel Walsh <dwalsh@redhat.com>.
>  .br
>  The program was written by Chris PeBenito <pebenito@gentoo.org>
>
> +.SH "SEE ALSO"
> +.BR selinux "(8), " sestatus.conf "(5)
>
> diff --git a/policycoreutils/sestatus/sestatus.c b/policycoreutils/sestatus/sestatus.c
> index 5617319..54b06c2 100644
> --- a/policycoreutils/sestatus/sestatus.c
> +++ b/policycoreutils/sestatus/sestatus.c
> @@ -172,8 +172,8 @@ void printf_tab(const char *outp)
>  int main(int argc, char **argv)
>  {
>        /* these vars are reused several times */
> -       int rc, opt, i, c;
> -       char *context;
> +       int rc, opt, i, c, size;
> +       char *context, *root_path;
>
>        /* files that need context checks */
>        char *fc[MAX_CHECK];
> @@ -193,9 +193,10 @@ int main(int argc, char **argv)
>        int show_bools = 0;
>
>        /* policy */
> -       const char *pol_name;
> +       const char *pol_name, *root_dir;
>        char *pol_path;
>
> +
>        while (1) {
>                opt = getopt(argc, argv, "vb");
>                if (opt == -1)
> @@ -210,8 +211,8 @@ int main(int argc, char **argv)
>                default:
>                        /* invalid option */
>                        printf("\nUsage: %s [OPTION]\n\n", basename(argv[0]));
> -                       printf
> -                           ("  -v  Verbose check of process and file contexts.\n");
> +                       printf("  -v  Verbose check of process and file contexts.\n");
> +                       printf("  -b  Display current state of booleans.\n");
>                        printf("\nWithout options, show SELinux status.\n");
>                        return -1;
>                }
> @@ -242,6 +243,35 @@ int main(int argc, char **argv)
>                return -1;
>        }
>
> +       printf_tab("SELinux root directory:");
> +       if ((root_dir = selinux_path()) != NULL) {
> +               /* The path has a trailing '/' so remove it */
> +               size = strlen(root_dir);
> +               root_path = malloc(size);
> +               if (!root_path) {
> +                       printf("malloc error (%s)\n", strerror(errno));
> +                       return -1;
> +               }
> +               memset(root_path, 0, size);
> +               strncpy(root_path, root_dir, (size-1)) ;
> +               printf("%s\n", root_path);
> +               free(root_path);
> +       } else {
> +                       printf("error (%s)\n", strerror(errno));
> +               return -1;
> +       }
> +
> +       /* Dump all the path information */
> +       printf_tab("Loaded policy name:");
> +       pol_path = strdup(selinux_policy_root());
> +       if (pol_path) {
> +               pol_name = basename(pol_path);
> +               puts(pol_name);
> +               free(pol_path);
> +       } else {
> +               printf("error (%s)\n", strerror(errno));
> +       }
> +
>        printf_tab("Current mode:");
>        rc = security_getenforce();
>        switch (rc) {
> @@ -273,23 +303,41 @@ int main(int argc, char **argv)
>                printf("error (%s)\n", strerror(errno));
>        }
>
> +       printf_tab("Policy MLS status:");
> +       rc = is_selinux_mls_enabled();
> +       switch (rc) {
> +               case 0:
> +                       printf("disabled\n");
> +                       break;
> +               case 1:
> +                       printf("enabled\n");
> +                       break;
> +               default:
> +                       printf("error (%s)\n", strerror(errno));
> +                       break;
> +       }
> +
> +       printf_tab("Policy deny_unknown status:");
> +       rc = security_deny_unknown();
> +       switch (rc) {
> +               case 0:
> +                       printf("allowed\n");
> +                       break;
> +               case 1:
> +                       printf("denied\n");
> +                       break;
> +               default:
> +                       printf("error (%s)\n", strerror(errno));
> +                       break;
> +       }
> +
>        rc = security_policyvers();
> -       printf_tab("Policy version:");
> +       printf_tab("Max kernel policy version:");
>        if (rc < 0)
>                printf("unknown (%s)\n", strerror(errno));
>        else
>                printf("%d\n", rc);
>
> -       /* Dump all the path information */
> -       printf_tab("Policy from config file:");
> -       pol_path = strdup(selinux_policy_root());
> -       if (pol_path) {
> -               pol_name = basename(pol_path);
> -               puts(pol_name);
> -               free(pol_path);
> -       } else {
> -               printf("error (%s)\n", strerror(errno));
> -       }
>
>        if (show_bools) {
>                /* show booleans */
> @@ -374,7 +422,7 @@ int main(int argc, char **argv)
>        printf("\nFile contexts:\n");
>
>        /* controlling term */
> -       printf_tab("Controlling term:");
> +       printf_tab("Controlling terminal:");
>        if (lgetfilecon(cterm, &context) >= 0) {
>                printf("%s\n", context);
>                freecon(context);
> diff --git a/policycoreutils/sestatus/sestatus.conf.5 b/policycoreutils/sestatus/sestatus.conf.5
> new file mode 100644
> index 0000000..b411ddd
> --- /dev/null
> +++ b/policycoreutils/sestatus/sestatus.conf.5
> @@ -0,0 +1,97 @@
> +.TH "sestatus.conf" "5" "26-Nov-2011" "Security Enhanced Linux" "sestatus configuration file"
> +
> +.SH "NAME"
> +sestatus.conf \- The \fBsestatus\fR(8) configuration file.
> +
> +.SH "DESCRIPTION"
> +The \fIsestatus.conf\fR file is used by the \fBsestatus\fR(8) command with the \fB\-v\fR option to determine what file and process security contexts should be displayed.
> +.sp
> +The fully qualified path name of the configuration file is:
> +.RS
> +\fI/etc/sestatus.conf\fR
> +.RE
> +.RE
> +.sp
> +The file consists of two optional sections as described in the \fBFILE FORMAT\fR section. Whether these exist or not, the following will always be displayed:
> +.RS
> +The current process context
> +.br
> +The init process context
> +.br
> +The controlling terminal file context
> +.RE
> +
> +.SH "FILE FORMAT"
> +The format consists of two optional sections as follows:
> +.RS
> +.B [files]
> +.br
> +.I file_name
> +.br
> +.I [file_name]
> +.br
> +.I ...
> +.sp
> +.B [process]
> +.br
> +.I executable_file_name
> +.br
> +.I [executable_file_name]
> +.br
> +.I ...
> +.RE
> +.sp
> +Where:
> +.RS
> +.B [files]
> +.RS
> +The start of the file list block.
> +.RE
> +.I file_name
> +.RS
> +One or more fully qualified file names, each on a new line will that will have its context displayed. If the file does not exist, then it is ignored. If the file is a symbolic link, then \fBsestatus -v\fR will also display the target file context.
> +.RE
> +.sp
> +.B [process]
> +.RS
> +The start of the process list block.
> +.RE
> +.I executable_file_name
> +.RS
> +One or more fully qualified executable file names that should it be an active process, have its context displayed. Each entry is on a new line.
> +.RE
> +.RE
> +
> +.SH "EXAMPLE"
> +# /etc/sestatus.conf
> +.br
> +[files]
> +.br
> +/etc/passwd
> +.br
> +/etc/shadow
> +.br
> +/bin/bash
> +.br
> +/bin/login
> +.br
> +/lib/libc.so.6
> +.br
> +/lib/ld-linux.so.2
> +.br
> +/lib/ld.so.1
> +.sp
> +[process]
> +.br
> +/sbin/mingetty
> +.br
> +/sbin/agetty
> +.br
> +/usr/sbin/sshd
> +.RE
> +
> +.SH "SEE ALSO"
> +.BR selinux "(8), " sestatus "(8) "
> +
> +
> +
> --
> 1.7.7.1
>
>
>
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
