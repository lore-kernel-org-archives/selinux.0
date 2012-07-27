Message-ID: <1343419618.17570.106.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH 2/2] You can now specify a sebool= flag in seapp_contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov, William Roberts <w.roberts@sta.samsung.com>
Date: Fri, 27 Jul 2012 16:06:58 -0400
In-Reply-To: <1343418124-3562-3-git-send-email-w.roberts@sta.samsung.com>
References: <1343418124-3562-1-git-send-email-w.roberts@sta.samsung.com>
	 <1343418124-3562-3-git-send-email-w.roberts@sta.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-07-27 at 12:42 -0700, William Roberts wrote:
> and that rule will ONLY be applied on a match to that
> boolean, and only if the boolean is set to true.
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

sebool is an input selector, thus belongs right after name=%s before ->.

> @@ -443,6 +466,7 @@ int selinux_android_setcontext(uid_t uid,
>  
>  	for (i = 0; i < nspec; i++) {
>  		cur = seapp_contexts[i];
> +

Extraneous whitespace change.

>  		if (cur->isSystemServer != isSystemServer)
>  			continue;
>  		if (cur->user) {

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
