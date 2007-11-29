Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lATGH1xx013009
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2007 11:17:01 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id lATGH1tu009340
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2007 16:17:01 GMT
Message-ID: <474EE5F9.5000300@manicmethod.com>
Date: Thu, 29 Nov 2007 11:16:57 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Chad Sellers <csellers@tresys.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH v2] Initial policy load from load_policy
References: <4739FA01.9030804@tresys.com>
In-Reply-To: <4739FA01.9030804@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chad Sellers wrote:
> Updated to include error message on loading failure in enforcing mode.
>
> The below patch adds a -i option to load_policy to perform the initial 
> policy load. The inital policy load is currently done in systems using 
> sysvinit by init itself, which then re-exec's itself. Ubuntu uses 
> upstart instead of sysvinit. In talks with the Ubuntu folks, they'd 
> prefer to load policy from initramfs before upstart starts rather than 
> patching upstart.
>
> Signed-off-by: Chad Sellers <csellers@tresys.com>

Merged as of policycoreutils 2.0.32

Your patch was somehow malformed so I merged the following (which should 
be identical):

Index: policycoreutils/load_policy/load_policy.c
===================================================================
--- policycoreutils/load_policy/load_policy.c   (revision 2677)
+++ policycoreutils/load_policy/load_policy.c   (working copy)
@@ -19,13 +19,13 @@
 
 void usage(char *progname)
 {
-       fprintf(stderr, _("usage:  %s [-q]\n"), progname);
+       fprintf(stderr, _("usage:  %s [-qi]\n"), progname);
        exit(1);
 }
 
 int main(int argc, char **argv)
 {
-       int ret, opt, quiet = 0, nargs;
+       int ret, opt, quiet = 0, nargs, init=0, enforce=0;
 
 #ifdef USE_NLS
        setlocale(LC_ALL, "");
@@ -33,7 +33,7 @@
        textdomain(PACKAGE);
 #endif
 
-       while ((opt = getopt(argc, argv, "bq")) > 0) {
+       while ((opt = getopt(argc, argv, "bqi")) > 0) {
                switch (opt) {
                case 'b':
                        fprintf(stderr, "%s:  Warning! The -b option is no longer supported, booleans are always preserved across reloads.  Continuing...\n",
@@ -43,6 +43,9 @@
                        quiet = 1;
                        sepol_debug(0);
                        break;
+               case 'i':
+                       init = 1;
+                       break;
                default:
                        usage(argv[0]);
                }
@@ -61,8 +64,28 @@
                        "%s:  Warning!  Boolean file argument (%s) is no longer supported, installed booleans file is always used.  Continuing...\n",
                        argv[0], argv[optind++]);
        }
-
-       ret = selinux_mkload_policy(1);
+       if (init) {
+               if (is_selinux_enabled() == 1) {
+                       /* SELinux is already enabled, we should not do an initial load again */
+                       fprintf(stderr,
+                                       _("%s:  Policy is already loaded and initial load requested\n"),
+                                       argv[0]);
+                       exit(2);
+               }
+               ret = selinux_init_load_policy(&enforce);
+               if (ret != 0 ) {
+                       if (enforce > 0) {
+                               /* SELinux in enforcing mode but load_policy failed */
+                               fprintf(stderr,
+                                               _("%s:  Can't load policy and enforcing mode requested:  %s\n"),
+                                               argv[0], strerror(errno));
+                               exit(3);
+                       }
+               }
+       }
+       else {
+               ret = selinux_mkload_policy(1);
+       }
        if (ret < 0) {
                fprintf(stderr, _("%s:  Can't load policy:  %s\n"),
                        argv[0], strerror(errno));
Index: policycoreutils/load_policy/load_policy.8
===================================================================
--- policycoreutils/load_policy/load_policy.8   (revision 2677)
+++ policycoreutils/load_policy/load_policy.8   (working copy)
@@ -4,7 +4,7 @@
 
 .SH SYNOPSIS
 .B load_policy 
-[-q]
+[-qi]
 .br
 .SH DESCRIPTION
 .PP
@@ -17,7 +17,23 @@
 .TP
 .B \-q
 suppress warning messages.
+.TP
+.B \-i
+inital policy load. Only use this if this is the first time policy is being loaded since boot (usually called from initramfs).
 
+.SH "EXIT STATUS"
+.TP
+.B 0
+Success
+.TP
+.B 1
+Invalid option
+.TP
+.B 2
+Policy load failed
+.TP
+.B 3
+Initial policy load failed and enforcing mode requested
 .SH SEE ALSO
 .B booleans
 (8),



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
