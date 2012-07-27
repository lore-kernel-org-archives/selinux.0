Message-ID: <1343408307.17570.68.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH] Allow zygote to spawn non matched apps in permissive
 mode
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov, William Roberts <w.roberts@sta.samsung.com>
Date: Fri, 27 Jul 2012 12:58:27 -0400
In-Reply-To: <1343339045-19207-2-git-send-email-w.roberts@sta.samsung.com>
References: <1343339045-19207-1-git-send-email-w.roberts@sta.samsung.com>
	 <1343339045-19207-2-git-send-email-w.roberts@sta.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-07-26 at 14:44 -0700, William Roberts wrote:
> This patch will allow non-matched apps in seapp_contexts to
> still be spawned via the zygote. An error message will be sent
> to logcat.
> 
> Change-Id: I9fb5dcfeb384a26e6a01d69bffd2ef14af74c51c
> ---
>  src/android.c |   12 +++++++++---
>  1 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/src/android.c b/src/android.c
> index ef27991..953a213 100644
> --- a/src/android.c
> +++ b/src/android.c
> @@ -526,8 +526,7 @@ int selinux_android_setcontext(uid_t uid,
>  		selinux_log(SELINUX_ERROR,
>  			    "%s:  No match for app with uid %d, seinfo %s, name %s\n",
>  			    __FUNCTION__, uid, seinfo, pkgname);
> -		rc = -1;
> -		goto out;
> +		goto err;

This was intentional since we log a more specific message above than the
one in the general err: block.  I guess it does no harm, but you'll end
up with two log messages in that case.

> @@ -559,7 +558,14 @@ err:
>  			    "%s:  Error setting context for app with uid %d, seinfo %s: %s\n",
>  			    __FUNCTION__, uid, seinfo, strerror(errno));
>  
> -	rc = -1;
> +	rc = security_getenforce();
> +	if(rc == -1)

Coding style.

> +		selinux_log(SELINUX_ERROR,
> +			    "%s:  Error getting enforcing level: %s\n",
> +			    __FUNCTION__, strerror(errno));
> +	else
> +		rc = -rc;

This seems a bit obscure to me, although it should work correctly.
I think I'd prefer something like:
	rc = (security_getenforce() == 0) ? 0 : -1;
and not bother with separately logging a security_getenforce() failure.

Still need to address the fact that this will make seapp_contexts errors
largely invisible to developers while in permissive mode; they will have
to be watching adb logcat *:E output carefully to even notice it.

> +	
>  	goto out;
>  oom:
>  	selinux_log(SELINUX_ERROR, "%s:  Out of memory\n", __FUNCTION__);

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
