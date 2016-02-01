Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u11EE3Au008061
 for <selinux@tycho.nsa.gov>; Mon, 1 Feb 2016 09:14:03 -0500
Subject: Re: [PATCH] policycoreutils: newrole: add missing defined in #if
To: Nicolas Iooss <nicolas.iooss@m4x.org>, <selinux@tycho.nsa.gov>
References: <1453220308-2967-1-git-send-email-nicolas.iooss@m4x.org>
From: Steve Lawrence <slawrence@tresys.com>
Message-ID: <56AF6829.7030509@tresys.com>
Date: Mon, 1 Feb 2016 09:14:01 -0500
MIME-Version: 1.0
In-Reply-To: <1453220308-2967-1-git-send-email-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/19/2016 11:18 AM, Nicolas Iooss wrote:
> When building newrole with gcc 5.3.0 and some warning flags, the
> compiler reports:
> 
>   newrole.c:77:33: error: "NAMESPACE_PRIV" is not defined [-Werror=undef]
>   #if defined(AUDIT_LOG_PRIV) || (NAMESPACE_PRIV)
>                                   ^
> 
> Indeed, "defined" is missing here.  This nevertheless worked so far
> because when NAMESPACE_PRIV was selected in the Makefile, newrole.c was
> compiled with "-DNAMESPACE_PRIV", which defined NAMESPACE_PRIV to 1.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Patch applied. Thanks!

- Steve

> ---
>  policycoreutils/newrole/newrole.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
> index 65a945d3d3f3..c6544eed07b9 100644
> --- a/policycoreutils/newrole/newrole.c
> +++ b/policycoreutils/newrole/newrole.c
> @@ -74,7 +74,7 @@
>  #ifdef USE_AUDIT
>  #include <libaudit.h>
>  #endif
> -#if defined(AUDIT_LOG_PRIV) || (NAMESPACE_PRIV)
> +#if defined(AUDIT_LOG_PRIV) || defined(NAMESPACE_PRIV)
>  #include <sys/prctl.h>
>  #include <cap-ng.h>
>  #endif
> 
