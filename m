Message-ID: <1343419520.17570.104.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH 1/2] Allow zygote to spawn non matched apps in
 permissive mode
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov, William Roberts <w.roberts@sta.samsung.com>
Date: Fri, 27 Jul 2012 16:05:20 -0400
In-Reply-To: <1343418124-3562-2-git-send-email-w.roberts@sta.samsung.com>
References: <1343418124-3562-1-git-send-email-w.roberts@sta.samsung.com>
	 <1343418124-3562-2-git-send-email-w.roberts@sta.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-07-27 at 12:42 -0700, William Roberts wrote:
> This patch will allow non-matched apps in seapp_contexts to
> still be spawned via the zygote. An error message will be sent
> to logcat.
> 
> Change-Id: I9fb5dcfeb384a26e6a01d69bffd2ef14af74c51c
> Signed-off-by: William Roberts <w.roberts@sta.samsung.com>
> ---
>  src/android.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/src/android.c b/src/android.c
> index 83ba7b7..66671e2 100644
> --- a/src/android.c
> +++ b/src/android.c
> @@ -491,8 +491,7 @@ int selinux_android_setcontext(uid_t uid,
>  		selinux_log(SELINUX_ERROR,
>  			    "%s:  No match for app with uid %d, seinfo %s, name %s\n",
>  			    __FUNCTION__, uid, seinfo, pkgname);
> -		rc = -1;
> -		goto out;
> +		goto err;

Falls over when testing with a deliberately broken seapp_contexts
configuration in enforcing mode.  Test scenario:
- Comment out line for untrusted_app in seapp_contexts, push to device.
- Install third party app.
- Start third party app in permissive mode (works, logs message).
- Switch to enforcing mode.
- Try starting third party app (fails with log message followed by
double free warning, blank screen).


>  	}
>  
>  	ctx_str = context_str(ctx);
> @@ -524,7 +523,7 @@ err:
>  			    "%s:  Error setting context for app with uid %d, seinfo %s: %s\n",
>  			    __FUNCTION__, uid, seinfo, strerror(errno));
>  
> -	rc = -1;
> +	rc = (security_getenforce() == 0) ? 0 : -1;
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
