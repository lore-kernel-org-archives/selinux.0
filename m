Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pB1EJqf9008947
	for <selinux@tycho.nsa.gov>; Thu, 1 Dec 2011 09:19:52 -0500
Received: from mail-vw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id pB1EJpkR022433
	for <selinux@tycho.nsa.gov>; Thu, 1 Dec 2011 14:19:51 GMT
Received: by vbbff1 with SMTP id ff1so1604500vbb.12
        for <selinux@tycho.nsa.gov>; Thu, 01 Dec 2011 06:19:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1322491263.59641.YahooMailClassic@web87004.mail.ird.yahoo.com>
References: <1322491263.59641.YahooMailClassic@web87004.mail.ird.yahoo.com>
Date: Thu, 1 Dec 2011 09:19:51 -0500
Message-ID: <CACLa4pvTU_oBLZYuNAr4p-txBo=Nw-6C_UX-_BHf2DiMza3pGA@mail.gmail.com>
Subject: Re: [PATCH 1/1] policycoreutils: Added SELinux config file man page.
From: Eric Paris <eparis@parisplace.org>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I believe this one complained about a couple of whitespace things (I
see at least blank lines at the end of files)

However I cleaned those up and applied to my devel branch.

On Mon, Nov 28, 2011 at 9:41 AM, Richard Haines
<richard_c_haines@btinternet.com> wrote:
> Added new man page selinux_config(5) detailing the SELinux config file
> format to new man/man5 directory plus Makefile.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  policycoreutils/Makefile                  |    2 +-
>  policycoreutils/man/Makefile              |    9 ++
>  policycoreutils/man/man5/selinux_config.5 |  142 +++++++++++++++++++++++++++++
>  3 files changed, 152 insertions(+), 1 deletions(-)
>  create mode 100644 policycoreutils/man/Makefile
>  create mode 100644 policycoreutils/man/man5/selinux_config.5
>
> diff --git a/policycoreutils/Makefile b/policycoreutils/Makefile
> index 7244a36..9cfe3bc 100644
> --- a/policycoreutils/Makefile
> +++ b/policycoreutils/Makefile
> @@ -1,4 +1,4 @@
> -SUBDIRS = setfiles semanage load_policy newrole run_init sandbox secon audit2allow audit2why scripts sestatus semodule_package semodule semodule_link semodule_expand semodule_deps sepolgen-ifgen setsebool po
> +SUBDIRS = setfiles semanage load_policy newrole run_init sandbox secon audit2allow audit2why scripts sestatus semodule_package semodule semodule_link semodule_expand semodule_deps sepolgen-ifgen setsebool po man
>
>  INOTIFYH = $(shell ls /usr/include/sys/inotify.h 2>/dev/null)
>
> diff --git a/policycoreutils/man/Makefile b/policycoreutils/man/Makefile
> new file mode 100644
> index 0000000..ea8242e
> --- /dev/null
> +++ b/policycoreutils/man/Makefile
> @@ -0,0 +1,9 @@
> +# Installation directories.
> +MAN5DIR ?= $(DESTDIR)/usr/share/man/man5
> +
> +all:
> +
> +install: all
> +       mkdir -p $(MAN5DIR)
> +       install -m 644 man5/*.5 $(MAN5DIR)
> +
> diff --git a/policycoreutils/man/man5/selinux_config.5 b/policycoreutils/man/man5/selinux_config.5
> new file mode 100644
> index 0000000..c7cdc39
> --- /dev/null
> +++ b/policycoreutils/man/man5/selinux_config.5
> @@ -0,0 +1,142 @@
> +.TH "selinux_config" "5" "18 Nov 2011" "Security Enhanced Linux" "SELinux configuration file"
> +
> +.SH "NAME"
> +config \- The SELinux sub-system configuration file.
> +
> +.SH "DESCRIPTION"
> +The SELinux \fIconfig\fR file controls the state of SELinux regarding:
> +.RS
> +.IP "1." 4
> +The policy enforcement status \- \fIenforcing\fR, \fIpermissive\fR or \fIdisabled\fR.
> +.IP "2." 4
> +The policy name or type that forms a path to the policy to be loaded and its supporting configuration files.
> +.IP "3." 4
> +How local users and booleans will be managed when the policy is loaded (note that this function was used by older releases of SELinux and is now deprecated).
> +.IP "4." 4
> +How SELinux-aware login applications should behave if no valid SELinux users are configured.
> +.IP "5." 4
> +Whether the system is to be relabeled or not.
> +.RE
> +
> +The entries controlling these functions are described in the \fBFILE FORMAT\fR section.
> +.sp
> +The fully qualified path name of the SELinux configuration file is \fI/etc/selinux/config\fR.
> +.sp
> +If the \fIconfig\fR file is missing or corrupt, then no SELinux policy is loaded (i.e. SELinux is disabled).
> +.sp
> +The \fBsestatus\fR (8) command and the libselinux function \fBselinux_path\fR (3) will return the location of the \fIconfig\fR file.
> +
> +.SH "FILE FORMAT"
> +The \fIconfig\fR file supports the following parameters:
> +.sp
> +.RS
> +\fBSELINUX = \fIenforcing\fR | \fIpermissive\fR | \fIdisabled\fR
> +.br
> +\fBSELINUXTYPE = \fIpolicy_name\fR
> +.br
> +\fBSETLOCALDEFS = \fI0\fR | \fI1\fR
> +.br
> +\fBREQUIREUSERS = \fI0\fR | \fI1\fR
> +.br
> +\fBAUTORELABEL = \fI0\fR | \fI1\fR
> +.RE
> +.sp
> +Where:
> +.br
> +.B SELINUX
> +.RS
> +This entry can contain one of three values:
> +.RS
> +.IP \fIenforcing\fR 4
> +SELinux security policy is enforced.
> +.IP \fIpermissive\fR 4
> +SELinux security policy is not enforced but logs the warnings (i.e. the action is allowed to proceed).
> +.IP \fIdisabled\fR
> +SELinux is disabled and no policy is loaded.
> +.RE
> +.sp
> +The entry can be determined using the \fBsestatus\fR(8) command or \fBselinux_getenforcemode\fR(3).
> +.RE
> +.sp
> +.B SELINUXTYPE
> +.RS
> +The \fIpolicy_name\fR entry is used to identify the policy type, and becomes the directory name of where the policy and its configuration files are located.
> +.sp
> +The entry can be determined using the \fBsestatus\fR(8) command or \fBselinux_getpolicytype\fR(3).
> +.sp
> +The \fIpolicy_name\fR is relative to a path that is defined within the SELinux subsystem that can be retrieved by using \fBselinux_path\fR(3). An example entry retrieved by \fBselinux_path\fR(3) is:
> +.br
> +.RS
> +.I /etc/selinux/
> +.RE
> +.sp
> +The \fIpolicy_name\fR is then appended to this and becomes the 'policy root' location that can be retrieved by \fBselinux_policy_root_path\fR(3). An example entry retrieved is:
> +.RS
> +.I /etc/selinux/targeted
> +.RE
> +.sp
> +The actual binary policy is located relative to this directory and also has a policy name pre-allocated. This information can be retrieved using \fBselinux_binary_policy_path\fR(3). An example entry retrieved by \fBselinux_binary_policy_path\fR(3) is:
> +.br
> +.RS
> +.I /etc/selinux/targeted/policy/policy
> +.RE
> +.sp
> +The binary policy name has by convention the SELinux policy version that it supports appended to it. The maximum policy version supported by the kernel can be determined using the \fBsestatus\fR(8) command or \fBsecurity_policyvers\fR(3). An example binary policy file with the version is:
> +.br
> +.RS
> +.I /etc/selinux/targeted/policy/policy.24
> +.RE
> +.RE
> +.sp
> +.B SETLOCALDEFS
> +.RS
> +This entry is deprecated and should be removed or set to \fI0\fR.
> +.sp
> +If set to \fI1\fR, then \fBselinux_mkload_policy\fR(3) will read the local customisation for booleans (see \fBbooleans\fR(5)) and users (see \fBlocal.users\fR(5)).
> +.RE
> +.sp
> +.B REQUIRESEUSERS
> +.RS
> +This optional entry can be used to fail a login if there is no matching or default entry in the
> +.BR seusers "(5) file or if the " seusers " file is missing. "
> +.sp
> +It is checked by \fBgetseuserbyname\fR(3) that is called by SELinux-aware login applications such as \fBPAM\fR(8).
> +.sp
> +If set to \fI0\fR or the entry missing:
> +.RS
> +.BR getseuserbyname "(3) will return the GNU / Linux user name as the SELinux user."
> +.RE
> +.sp
> +If set to \fI1\fR:
> +.RS
> +.BR getseuserbyname "(3) will fail."
> +.RE
> +.sp
> +The \fBgetseuserbyname\fR(3) man page should be consulted for its use. The format of the \fIseusers\fR file is shown in \fBseusers\fR(5).
> +.sp
> +.RE
> +.sp
> +.B AUTORELABEL
> +.RS
> +This is an optional entry that allows the file system to be relabeled.
> +.sp
> +If set to \fI0\fR and there is a file called \fI.autorelabel\fR in the root directory, then on a reboot, the loader will drop to a shell where a root login is required. An administrator can then manually relabel the file system.
> +.sp
> +If set to \fI1\fR or no entry present (the default) and there is a \fI.autorelabel\fR file in the root directory, then the file system will be automatically relabeled using \fBfixfiles -F restore\fR
> +.sp
> +In both cases the \fI/.autorelabel\fR file will be removed so that relabeling is not done again.
> +.RE
> +.sp
> +
> +.SH "EXAMPLE"
> +This example \fIconfig\fR file shows the minimum contents for a system to run SELinux in enforcing mode, with a \fIpolicy_name\fR of 'targeted':
> +.sp
> +.RS
> +SELINUX = enforcing
> +.br
> +SELINUXTYPE = targeted
> +.RE
> +
> +.SH "SEE ALSO"
> +.BR selinux "(8), " sestatus "(8), " selinux_path "(3), " selinux_policy_root_path "(3), " selinux_binary_policy_path "(3), " getseuserbyname "(3), " PAM "(8), " fixfiles "(8), " selinux_mkload_policy "(3), " selinux_getpolicytype "(3), " security_policyvers "(3), " selinux_getenforcemode "(3), " seusers "(5), " booleans "(5), " local.users "(5) "
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
