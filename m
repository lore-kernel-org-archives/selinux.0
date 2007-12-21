Subject: Re: PATCH: libsepol should not write policy.18 with mls enabled
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Todd C. Miller" <tmiller@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200712112220.lBBMKOme018372@cadmus.columbia.tresys.com>
References: <200712112220.lBBMKOme018372@cadmus.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 21 Dec 2007 12:25:53 -0500
Message-Id: <1198257953.2944.75.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2007-12-11 at 17:20 -0500, Todd C. Miller wrote:
> Currently, libsepol will write a binary policy with the MLS flag set
> even if the policy version is unable to support MLS.  For instance, you
> can build a policy.18 with mls enabled.  The resulting policy binary is
> invalid and can't be read by the kernel or the various tools.
> 
> Fixing this is just a matter of adding the appropriate check to
> policydb_write().
> 
> Signed-off-by: Todd C. Miller <tmiller@tresys.com>

Thanks, merged.

> 
> Index: libsepol/src/write.c
> ===================================================================
> --- libsepol/src/write.c	(revision 2704)
> +++ libsepol/src/write.c	(working copy)
> @@ -1531,8 +1531,19 @@
>  	pd.p = p;
>  
>  	config = 0;
> -	if (p->mls)
> +	if (p->mls) {
> +		if ((p->policyvers < POLICYDB_VERSION_MLS &&
> +		    p->policy_type == POLICY_KERN) ||
> +		    (p->policyvers < MOD_POLICYDB_VERSION_MLS &&
> +		    p->policy_type == POLICY_BASE) ||
> +		    (p->policyvers < MOD_POLICYDB_VERSION_MLS &&
> +		    p->policy_type == POLICY_MOD)) {
> +			ERR(fp->handle, "policy version %d cannot support MLS",
> +			    p->policyvers);
> +			return POLICYDB_ERROR;
> +		}
>  		config |= POLICYDB_CONFIG_MLS;
> +	}
>  
>  	config |= (POLICYDB_CONFIG_UNKNOWN_MASK & p->handle_unknown);
>  
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
