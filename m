Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u0CDqLDm002005
 for <selinux@tycho.nsa.gov>; Tue, 12 Jan 2016 08:52:21 -0500
Subject: Re: [PATCH 1/2] Add description of missing newrole parameter -p in
 newrole man page.
To: Lukas Vrabec <lvrabec@redhat.com>, <selinux@tycho.nsa.gov>
References: <1452504641-26411-1-git-send-email-lvrabec@redhat.com>
From: Steve Lawrence <slawrence@tresys.com>
Message-ID: <569504FF.9070306@tresys.com>
Date: Tue, 12 Jan 2016 08:51:59 -0500
MIME-Version: 1.0
In-Reply-To: <1452504641-26411-1-git-send-email-lvrabec@redhat.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/11/2016 04:30 AM, Lukas Vrabec wrote:
> Signed-off-by: Lukas Vrabec <lvrabec@redhat.com>

I fixed a minor typo in this patch. Otherwise looks good. Both patches
applied. Thanks!

> ---
>  policycoreutils/newrole/newrole.1 | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/policycoreutils/newrole/newrole.1 b/policycoreutils/newrole/newrole.1
> index c47bc52..3bd57e7 100644
> --- a/policycoreutils/newrole/newrole.1
> +++ b/policycoreutils/newrole/newrole.1
> @@ -8,6 +8,7 @@ newrole \- run a shell with a new SELinux role
>  [\fB-t\fR|\fB--type\fR]
>  \fITYPE\fR
>  [\fB-l\fR|\fB--level\fR]
> +[\fB-p\fR|\fB--preserve-environment\fR]
>  \fILEVEL\fR [-- [\fIARGS\fR]...]
>  .SH DESCRIPTION
>  .PP
> @@ -38,7 +39,12 @@ specified by
>  If
>  \fILEVEL\fR
>  is a range, the new context will have the sensitivity level and clearance
> -specified by that range.
> +specified by that range.  If the
> +.B -p
> +or
> +.B --preserve-environment
> +option is specified, then shell with new SELinux context will preserve environment variables,
> +otherwise new minimal enviroment is created.
>  .PP
>  Additional arguments
>  .I ARGS
> 
