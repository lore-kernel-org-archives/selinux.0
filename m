Subject: Re: [PATCH] Allowing MLS->non-MLS and vice versa upon policy reload
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: selinux@tycho.nsa.gov, eparis@parisplace.org, jmorris@namei.org
In-Reply-To: <201001312243.o0VMh9qn023003@vivaldi39.register.it>
References: <201001312243.o0VMh9qn023003@vivaldi39.register.it>
Content-Type: text/plain
Date: Mon, 01 Feb 2010 13:16:06 -0500
Message-Id: <1265048166.12435.206.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

One last comment below:

On Sun, 2010-01-31 at 23:43 +0100, Guido Trentalancia wrote:
> diff -pruN security-testing-2.6/security/selinux/ss/services.c security-testing-2.6-new/security/selinux/ss/services.c
> --- security-testing-2.6/security/selinux/ss/services.c	2010-01-29 02:02:47.742042805 +0100
> +++ security-testing-2.6-new/security/selinux/ss/services.c	2010-01-31 23:28:26.440336638 +0100
> @@ -1614,9 +1620,29 @@ static int convert_context(u32 key,
>  		goto bad;
>  	c->type = typdatum->value;
>  
> -	rc = mls_convert_context(args->oldp, args->newp, c);
> -	if (rc)
> -		goto bad;
> +	/* Convert the MLS/MCS fields or deal with policy type switch */
> +	if (args->oldp->selinux_mls_enabled
> +	    && args->newp->selinux_mls_enabled) {
> +		rc = mls_convert_context(args->oldp, args->newp, c);
> +		if (rc)
> +			goto bad;
> +	} else if (args->oldp->selinux_mls_enabled
> +		   && !args->newp->selinux_mls_enabled)
> +	/* Switching between MLS/MCS and non-MLS/non-MCS policy: */
> +	/* free any storage used by the MLS fields in the        */
> +	/* context for all existing entries in the sidtab.       */
> +		mls_context_destroy(args->oldp, c);
> +	else if (!args->oldp->selinux_mls_enabled
> +		 && args->newp->selinux_mls_enabled) {
> +	/* Switching between non-MLS/non-MCS and MLS/MCS policy:  */
> +	/* ensure that the MLS fields of the context for all      */
> +	/* existing entries in the sidtab are filled in with a    */
> +	/* suitable default value, likely taken from one of the   */
> +	/* initial SIDs.                                          */
> +		oc = args->newp->ocontexts[OCON_ISID];
> +		range = &oc->context[0].range;
> +		mls_range_set(c, range);
> +	}

ocontexts[OCON_ISID] is a list of initial SIDs and their contexts.
Your current code takes the MLS range from whatever happens to be the
first entry in the list and uses that for all of the contexts.  That
isn't very well-defined.  At present, the first entry in the list
happens to be the last initial SID just by virtue of how the list is
constructed, but nothing else relies on any ordering of that list.

We could scan the list for a particular initial SID, e.g.
	while (oc && oc->sid[0] != SECINITSID_UNLABELED)
		oc = oc->next;

That would at least give us well-defined behavior regardless of the list
order.  However, it still doesn't really reflect what would happen if
the system had booted with the MLS/MCS policy in the first place, as
demonstrated by the sshd behavior.

Another difference is that initial SID contexts are only loaded upon the
first policy load (via policydb_load_isids).  I suppose
convert_context() could in fact just replace c with the contents of
oc->context[0] if key == oc->sid[0] to update the initial SIDs, although
care would need to be taken that the number of initial SIDs did not
change.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
