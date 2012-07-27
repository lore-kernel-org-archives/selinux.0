Message-ID: <1343407378.17570.60.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH] Support for sebool in seapp_contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov, William Roberts <w.roberts@sta.samsung.com>
Date: Fri, 27 Jul 2012 12:42:58 -0400
In-Reply-To: <1343330131-11754-1-git-send-email-w.roberts@sta.samsung.com>
References: <1343330131-11754-1-git-send-email-w.roberts@sta.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-07-26 at 12:15 -0700, William Roberts wrote:
> You can now specify a sebool= flag in seapp_contexts
> and that rule will ONLY be applied on a match to that
> boolean, and only if the boolean is set to true.
> 
> Change-Id: Ifdba35cd3a78ce1c8173786514db649203018e28
> ---
>  src/android.c |   39 +++++++++++++++++++++++++++++++++++++--
>  1 files changed, 37 insertions(+), 2 deletions(-)

> @@ -308,6 +320,17 @@ int selinux_android_setfilecon2(const char *pkgdir,
>  	for (i = 0; i < nspec; i++) {
>  		cur = seapp_contexts[i];
>  
> +		if (cur->sebool) {
> +			int value = security_get_boolean_active(cur->sebool);
> +			if (value == 0)
> +				continue;
> +			else if (value == -1) {
> +				selinux_log(SELINUX_ERROR, \
> +				"Could not find boolean: %s ", cur->sebool);
> +				goto err;
> +			}
> +		}

Move this block after all other selectors have been checked, i.e. after
the check of cur->name, so that we don't waste time fetching the active
boolean value if this entry isn't going to match anyway due to one of
the other selectors.  Ditto for the one in selinux_android_setcontext().
Might also want to distinguish errno cases, e.g. errno == ENOENT should
mean that the boolean wasn't defined vs EACCES (not allowed to read
selinuxfs) vs ENOMEM (memory allocation failure when fetching the
boolean).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
