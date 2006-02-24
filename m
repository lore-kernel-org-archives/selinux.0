Subject: Re: [PATCH] context based audit filtering (take 4)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        Linux Audit Discussion <linux-audit@redhat.com>,
        Dustin Kirkland <dustin.kirkland@us.ibm.com>,
        Amy Griffis <amy.griffis@hp.com>, James Morris <jmorris@namei.org>
In-Reply-To: <43FDF3EC.7000303@trustedcs.com>
References: <43F49805.2000109@trustedcs.com>
	 <43FB86DD.2020708@trustedcs.com>
	 <1140619592.31467.218.camel@moss-spartans.epoch.ncsc.mil>
	 <43FDF3EC.7000303@trustedcs.com>
Content-Type: text/plain
Date: Fri, 24 Feb 2006 08:27:37 -0500
Message-Id: <1140787657.21179.143.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-02-23 at 11:42 -0600, Darrel Goeddel wrote:
> diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> index 640d0bf..df358be 100644
> --- a/security/selinux/ss/mls.c
> +++ b/security/selinux/ss/mls.c
> @@ -385,6 +385,31 @@ out:
>  }
>  
>  /*
> + * Set the MLS fields in the security context structure
> + * `context' based on the string representation in
> + * the string `str'.  This function will allocate temporary memory with the
> + * given constraints of gfp_mask.
> + */
> +int mls_from_string(char *str, struct context *context, gfp_t gfp_mask)
> +{
> +	char *tmpstr, *freestr;
> +	int rc;

Likely should be checking selinux_mls_enabled on entry and returning an
error in that case (mls_context_to_sid will just return 0 in that case).

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index d877cd1..a2ad2cd 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c

Need to #include <linux/selinux.h> now to pick up the function
prototypes for the selinux_audit_ functions to ensure that they are
checked against the real functions.

> +	default:
> +		/* only the above fileds are valid */

Nit:  Typo in comment.

Otherwise, looks good.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
