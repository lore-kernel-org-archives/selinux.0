Message-ID: <457ED543.80905@hp.com>
Date: Tue, 12 Dec 2006 11:13:55 -0500
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH 1/1] selinux: Delete mls_copy_context
References: <457EC911.7060006@trustedcs.com>
In-Reply-To: <457EC911.7060006@trustedcs.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
> diff --git a/security/selinux/ss/context.h b/security/selinux/ss/context.h
> index 0562bac..3f57585 100644
> --- a/security/selinux/ss/context.h
> +++ b/security/selinux/ss/context.h
> @@ -55,6 +55,29 @@ out:
>  	return rc;
>  }
>  
> +/*
> + * Copies the effective MLS range from `src' into `dst'.
> + */

This isn't your fault, the old code used the same comment, but I wonder if it is
better to say:

 "Copies the low MLS range from 'src' into 'dst'."

As the concept of "effective" and "clearance" are policy constructs and not
hardcoded into the kernel.

> +static inline int mls_context_scpy(struct context *dst, struct context *src)
> +{
> +	int rc;
> +
> +	if (!selinux_mls_enabled)
> +		return 0;
> +
> +	dst->range.level[0].sens = src->range.level[0].sens;
> +	rc = ebitmap_cpy(&dst->range.level[0].cat, &src->range.level[0].cat);
> +	if (rc)
> +		goto out;
> +
> +	dst->range.level[1].sens = src->range.level[0].sens;
> +	rc = ebitmap_cpy(&dst->range.level[1].cat, &src->range.level[0].cat);
> +	if (rc)
> +		ebitmap_destroy(&dst->range.level[0].cat);
> +out:
> +	return rc;
> +}

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
