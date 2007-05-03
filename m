Subject: Re: [RFC] Ability to allow unknown class and permissions -v4
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, Chad Sellers <csellers@tresys.com>
In-Reply-To: <1178140294.3897.22.camel@dhcp59-235.rdu.redhat.com>
References: <1178130337.3897.14.camel@dhcp59-235.rdu.redhat.com>
	 <1178134459.3443.105.camel@moss-spartans.epoch.ncsc.mil>
	 <1178140294.3897.22.camel@dhcp59-235.rdu.redhat.com>
Content-Type: text/plain
Date: Thu, 03 May 2007 08:50:10 -0400
Message-Id: <1178196610.3443.140.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-02 at 17:11 -0400, Eric Paris wrote:
> It does get rid of the special casing but it isn't much less complex.
> Anyone see a way to make this bit better?
> 
> -Eric
> 
> 
> @@ -322,6 +316,38 @@ static int context_struct_compute_av(struct context *scontext,
>  	avd->seqno = latest_granting;
>  
>  	/*
> +	 * Check for all the invalid cases.
> +	 * - tclass 0
> +	 * - tclass > policy and > kernel
> +	 * - tclass > policy but is a userspace class
> +	 * - tclass > policy but we do not allow unknowns
> +	 */
> +	if (unlikely(!tclass))
> +		goto inval_class;
> +	if (unlikely(tclass > policydb.p_class.nprim))
> +		if (tclass > kdefs->cts_len || 
> +		    !kdefs->class_to_string[tclass - 1] ||
> +		    policydb.handle_unknown != ALLOW_UNKOWN)
> +			goto inval_class;
> +
> +	/* 
> +	 * Kernel class and we ALLOW_UNKNOWN so pad the allow decision 
> +	 * the pad will be all 1 for unknown classes.
> +	 */
> +	if (tclass <= kdefs->cts_len && (policydb.handle_unknown == ALLOW_UNKNOWN))
> +		avd->allowed = policydb.undefined_perms[tclass - 1];
> +
> +	/*
> +	 * Kernel class not in policy and we ALLOW_UNKNOWN.  Since decision is 
> +	 * completed return.
> +	 */
> +	if (unlikely(tclass > policydb.p_class.nprim &&
> +		     tclass <= kdefs->cts_len))

You can drop the second test (tclass <= kdefs->cts_len) or turn it into
a BUG_ON, because you should only reach this point if that is true.  And
you must ensure that you don't go further if the first test is true
regardless, as you will otherwise index beyond the end of the
class_val_to_struct array.

> +		return 0;
> +
> +	tclass_datum = policydb.class_val_to_struct[tclass - 1];
> +
> +	/*
>  	 * If a specific type enforcement rule was defined for
>  	 * this permission check, then use it.
>  	 */
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
