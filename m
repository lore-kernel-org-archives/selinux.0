Message-ID: <1343417285.17570.89.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH] You can now specify a sebool= flag in seapp_contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov, William Roberts <w.roberts@sta.samsung.com>
Date: Fri, 27 Jul 2012 15:28:05 -0400
In-Reply-To: <1343416759-32071-2-git-send-email-w.roberts@sta.samsung.com>
References: <1343416759-32071-2-git-send-email-w.roberts@sta.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-07-27 at 12:19 -0700, William Roberts wrote:
> and that rule will ONLY be applied on a match to that
> boolean, and only if the boolean is set to true.

First line of commit message should be short description for subject
line, then longer description on next line for body.

> 
> Change-Id: Ifdba35cd3a78ce1c8173786514db649203018e28
> Signed-off-by: William Roberts <w.roberts@sta.samsung.com>
> ---
>  src/android.c |   41 ++++++++++++++++++++++++++++++++++++++---
>  1 files changed, 38 insertions(+), 3 deletions(-)
> 

> @@ -217,12 +228,13 @@ int selinux_android_seapp_context_reload(void)
>  		int i;
>  		for (i = 0; i < nspec; i++) {
>  			cur = seapp_contexts[i];
> -			selinux_log(SELINUX_INFO, "%s:  isSystemServer=%s user=%s seinfo=%s name=%s -> domain=%s type=%s level=%s levelFromUid=%s",
> +			selinux_log(SELINUX_INFO, "%s:  isSystemServer=%s user=%s seinfo=%s name=%s -> domain=%s type=%s level=%s levelFromUid=%s sebool=%s",
>  				    __FUNCTION__,
>  				    cur->isSystemServer ? "true" : "false",
>  				    cur->user, cur->seinfo, cur->name,
>  				    cur->domain, cur->type, cur->level,
> -				    cur->levelFromUid ? "true" : "false");
> +				    cur->levelFromUid ? "true" : "false",
> +				    cur->sebool);

sebool is an input selector, not an output value, so it belongs right
after the name.

> @@ -348,7 +360,18 @@ int selinux_android_setfilecon2(const char *pkgdir,
>  			if (context_range_set(ctx, cur->level))
>  				goto oom;
>  		}
> -		
> +
> +                if (cur->sebool) {
> +                        int value = security_get_boolean_active(cur->sebool);
> +                        if (value == 0)
> +                                continue;

Too late - it needs to go after checking cur->name but before we set the
type/range, i.e. after we have checked all other input selectors but
before we start applying the specified changes.

We use tabs not spaces in libselinux.  Sorry, we're Linux kernel coding
style, not Android.

> @@ -443,6 +466,7 @@ int selinux_android_setcontext(uid_t uid,
>  
>  	for (i = 0; i < nspec; i++) {
>  		cur = seapp_contexts[i];
> +

Noise.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
