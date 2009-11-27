Message-ID: <4B103097.10502@manicmethod.com>
Date: Fri, 27 Nov 2009 15:03:35 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Guido Trentalancia <guido@trentalancia.com>
CC: SELinux@tycho.nsa.gov
Subject: Re: Patch for Ticket #1 [1672486] (checkpolicy/checkmodule)
References: <1257182068.2916.23.camel@tesla.lan>
In-Reply-To: <1257182068.2916.23.camel@tesla.lan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Guido Trentalancia wrote:
> This patch is proposed to solve Ticket #1 [1672486] (command line
> binaries should support --version and --help).
>
> It adds handling of -h, -V and the long formats --help and --version to
> all binaries (checkpolicy/checkmodule).
>
> It also adds handling of long options for some of the available options.
>
> Manual pages have also been updated accordingly (and a few undocumented
> options have been documented).
>
> Guido Trentalancia
>

Merged in checkpolicy 2.0.21

See other email re: using git to format patches

> diff -pru checkpolicy/checkmodule.8 checkpolicy-new/checkmodule.8
> --- checkpolicy/checkmodule.8   2009-11-01 22:23:01.000000000 +0100
> +++ checkpolicy-new/checkmodule.8       2009-11-02 17:20:51.000000000
> +0100
> @@ -21,23 +21,26 @@ the module package into the module store
>
>   .SH OPTIONS
>   .TP
> -.B \-b
> +.B \-b,\-\-binary
>   Read an existing binary policy module file rather than a source policy
>   module file.  This option is a development/debugging aid.
>   .TP
>   .B \-m
>   Generate a non-base policy module.
>   .TP
> -.B \-M
> +.B \-M,\-\-mls
>   Enable the MLS/MCS support when checking and compiling the policy
> module.
>   .TP
> -.B \-V
> +.B \-V,\-\-version
>    Show policy versions created by this program
>   .TP
> -.B \-o filename
> +.B \-o,\-\-output filename
>   Write a binary policy module file to the specified filename.
>   Otherwise, checkmodule will only check the syntax of the module source
> file
>   and will not generate a binary module at all.
> +.TP
> +.B \-U,\-\-handle-unknown<action>
> +Specify how the kernel should handle unknown classes or permissions
> (deny, allow or reject).
>
>   .SH EXAMPLE
>   .nf
> diff -pru checkpolicy/checkmodule.c checkpolicy-new/checkmodule.c
> --- checkpolicy/checkmodule.c   2009-11-01 22:23:01.000000000 +0100
> +++ checkpolicy-new/checkmodule.c       2009-11-02 17:21:19.000000000
> +0100
> @@ -163,8 +163,18 @@ int main(int argc, char **argv)
>          int ch;
>          int show_version = 0;
>          policydb_t modpolicydb;
> +       struct option long_options[] = {
> +               {"help", no_argument, NULL, 'h'},
> +               {"output", required_argument, NULL, 'o'},
> +               {"binary", no_argument, NULL, 'b'},
> +               {"version", no_argument, NULL, 'V'},
> +               {"handle-unknown", optional_argument, NULL, 'U'},
> +               {"debug", no_argument, NULL, 'd'},
> +               {"mls", no_argument, NULL, 'M'},
> +               {NULL, 0, NULL, 0}
> +       };
>
> -       while ((ch = getopt(argc, argv, "ho:dbVU:mM")) != EOF) {
> +       while ((ch = getopt_long(argc, argv, "ho:bVU:mM", long_options,
> NULL)) != -1) {
>                  switch (ch) {
>                  case 'h':
>                          usage(argv[0]);
> diff -pru checkpolicy/checkpolicy.8 checkpolicy-new/checkpolicy.8
> --- checkpolicy/checkpolicy.8   2009-11-01 22:23:01.000000000 +0100
> +++ checkpolicy-new/checkpolicy.8       2009-11-02 17:16:22.000000000
> +0100
> @@ -18,20 +18,32 @@ policy.conf or policy, depending on whet
>
>   .SH OPTIONS
>   .TP
> -.B \-b
> +.B \-b,\-\-binary
>   Read an existing binary policy file rather than a source policy.conf
> file.
>   .TP
> -.B \-d
> +.B \-d,\-\-debug
>   Enter debug mode after loading the policy.
>   .TP
> -.B \-M
> +.B \-M,\-\-mls
>   Enable the MLS policy when checking and compiling the policy.
>   .TP
> -.B \-o filename
> +.B \-o,\-\-output filename
>   Write a binary policy file to the specified filename.
>   .TP
>   .B \-c policyvers
>   Specify the policy version, defaults to the latest.
> +.TP
> +.B \-t,\-\-target
> +Specify the target platform (selinux or xen).
> +.TP
> +.B \-U,\-\-handle-unknown<action>
> +Specify how the kernel should handle unknown classes or permissions
> (deny, allow or reject).
> +.TP
> +.B \-V,\-\-version
> +Show version information.
> +.TP
> +.B \-h,\-\-help
> +Show usage information.
>
>   .SH "SEE ALSO"
>   SELinux documentation at http://www.nsa.gov/selinux,
> diff -pru checkpolicy/checkpolicy.c checkpolicy-new/checkpolicy.c
> --- checkpolicy/checkpolicy.c   2009-11-01 22:23:01.000000000 +0100
> +++ checkpolicy-new/checkpolicy.c       2009-11-02 17:15:05.000000000
> +0100
> @@ -392,8 +392,19 @@ int main(int argc, char **argv)
>          int state;
>          int show_version = 0;
>          struct policy_file pf;
> +       struct option long_options[] = {
> +               {"output", required_argument, NULL, 'o'},
> +               {"target", required_argument, NULL, 't'},
> +               {"binary", no_argument, NULL, 'b'},
> +               {"debug", no_argument, NULL, 'd'},
> +               {"version", no_argument, NULL, 'V'},
> +               {"handle-unknown", optional_argument, NULL, 'U'},
> +               {"mls", no_argument, NULL, 'M'},
> +               {"help", no_argument, NULL, 'h'},
> +               {NULL, 0, NULL, 0}
> +       };
>
> -       while ((ch = getopt(argc, argv, "o:t:dbU:MVc:")) != EOF) {
> +       while ((ch = getopt_long(argc, argv, "o:t:dbU:MVc:h",
> long_options,
> NULL)) != -1) {
>                  switch (ch) {
>                  case 'o':
>                          outfile = optarg;
> @@ -458,6 +469,7 @@ int main(int argc, char **argv)
>                                          policyvers = n;
>                                  break;
>                          }
> +               case 'h':
>                  default:
>                          usage(argv[0]);
>                  }

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
