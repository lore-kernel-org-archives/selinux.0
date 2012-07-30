Message-ID: <1343654894.2346.39.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH] Allow non-matched apps to launch when no match found
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov, William Roberts <w.roberts@sta.samsung.com>
Date: Mon, 30 Jul 2012 09:28:14 -0400
In-Reply-To: <1343427403-22826-1-git-send-email-w.roberts@sta.samsung.com>
References: <1343427403-22826-1-git-send-email-w.roberts@sta.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-07-27 at 15:16 -0700, William Roberts wrote:
> Allows the zygote to still spawn apps in the zygote's
> context when no match is found in seapp_contexts. In
> enforcing mode, apps that are not matched will not be
> spawned. A "No match" message will (still) be printed
> to logcat.
> 
> Change-Id: Ibe362cc8e168be7acae5162c9ff6a310233fcbe6

Thanks, applied.

> ---
>  src/android.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/src/android.c b/src/android.c
> index 7974391..b013110 100644
> --- a/src/android.c
> +++ b/src/android.c
> @@ -525,7 +525,8 @@ int selinux_android_setcontext(uid_t uid,
>  		selinux_log(SELINUX_ERROR,
>  			    "%s:  No match for app with uid %d, seinfo %s, name %s\n",
>  			    __FUNCTION__, uid, seinfo, pkgname);
> -		rc = -1;
> +
> +		rc = (security_getenforce() == 0) ? 0 : -1;
>  		goto out;
>  	}
>  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
