Message-ID: <1343316928.5186.9.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH] Support for sebool in seapp_contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov, William Roberts <w.roberts@sta.samsung.com>
Date: Thu, 26 Jul 2012 11:35:28 -0400
In-Reply-To: <1343266208-4869-2-git-send-email-w.roberts@sta.samsung.com>
References: <1343266208-4869-1-git-send-email-w.roberts@sta.samsung.com>
	 <1343266208-4869-2-git-send-email-w.roberts@sta.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-07-25 at 18:30 -0700, William Roberts wrote:
> Change-Id: Ib2f95d526ef20179f113254d4683836bdabdfbea
> ---
>  src/android.c |   45 +++++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/src/android.c b/src/android.c
> index 83ba7b7..921e8dc 100644
> --- a/src/android.c
> +++ b/src/android.c
> @@ -53,6 +54,12 @@ static int seapp_context_cmp(const void *A, const void *B)
>  	const struct seapp_context **sp1 = A, **sp2 = B;
>  	const struct seapp_context *s1 = *sp1, *s2 = *sp2;
>  
> +	/* Give precedence to a specified sebool= over an unspecified sebool=. */
> +	if (s1->sebool && !s2->sebool)
> +		return -1;
> +	if (!s1->sebool && s2->sebool)
> +		return 1;

I would put this last (i.e. after name) in seapp_context_cmp, i.e. sort
by the other criteria first, then by sebool.

> @@ -196,6 +203,14 @@ int selinux_android_seapp_context_reload(void)
>  				cur->level = strdup(value);
>  				if (!cur->level)
>  					goto oom;
> +			} else if (!strcasecmp(name, "sebool")) {
> +				cur->sebool = strdup(value);
> +				if (!cur->sebool)
> +					goto oom;
> +			} else if (!strcasecmp(name, "sebool")) {
> +				cur->sebool = strdup(value);
> +				if (!cur->sebool)
> +					goto oom;

Duplication?

> @@ -308,6 +324,18 @@ int selinux_android_setfilecon2(const char *pkgdir,
>  	for (i = 0; i < nspec; i++) {
>  		cur = seapp_contexts[i];
>  
> +		if (cur->sebool) {
> +			int value = security_get_boolean_active(cur->sebool);
> +			if(value == 0) {
> +				continue;
> +			}

Coding style.  Space between if and opening paren.  No need for curly
brackets around a single statement.

> +			else if(value == -1) {
> +				selinux_log(SELINUX_ERROR, \
> +				"Could not find boolean: %s ", cur->sebool);
> +				goto err;
> +			}
> +		}

I would put this last, i.e. after name comparison, so that we only read
the boolean value if the entry matches on all other criteria.  

> @@ -443,6 +471,19 @@ int selinux_android_setcontext(uid_t uid,
>  
>  	for (i = 0; i < nspec; i++) {
>  		cur = seapp_contexts[i];
> +
> +		if (cur->sebool) {
> +			int value = security_get_boolean_active(cur->sebool);
> +			if(value == 0) {
> +				continue;
> +			}
> +			else if(value == -1) {
> +                                selinux_log(SELINUX_ERROR, \
> +                                        "Could not find boolean: %s ", cur->sebool);
> +				goto err;
> +			}
> +		}

Ditto.


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
