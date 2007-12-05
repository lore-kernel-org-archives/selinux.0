Subject: Re: PATCH: peersid capability support
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Todd C. Miller" <tmiller@tresys.com>
Cc: selinux@tycho.nsa.gov, jbrindle@tresys.com, paul.moore@hp.com
In-Reply-To: <200712031941.lB3Jf7PK008934@cadmus.columbia.tresys.com>
References: <200712031941.lB3Jf7PK008934@cadmus.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 05 Dec 2007 13:58:58 -0500
Message-Id: <1196881138.16006.79.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-12-03 at 14:41 -0500, Todd C. Miller wrote:
> > Stephen Smalley wrote:
> > Looks like the libsepol patch puts the policycaps ebitmap at a different
> > location in the policy image than the kernel patch expects.
> 
> I had initially changed the ebitmap reading/writing location from
> where Josh had it to work around an issue with semodule.  This version
> preserves the location in the final policy binary without confusing
> sepol_module_package_info().
> 
>  - todd
> 
> --
> 

> Index: trunk/libsepol/src/expand.c
> ===================================================================
> --- trunk.orig/libsepol/src/expand.c
> +++ trunk/libsepol/src/expand.c
> @@ -2252,6 +2252,12 @@ int expand_module(sepol_handle_t * handl
>  	out->mls = base->mls;
>  	out->handle_unknown = base->handle_unknown;
>  
> +	/* Copy policy capabilities */
> +	if (ebitmap_cpy(&out->policycaps, &base->policycaps)) {
> +		ERR(handle, "Out of memory!");
> +		goto cleanup;
> +	}
> +
>  	if ((state.typemap =
>  	     (uint32_t *) calloc(state.base->p_types.nprim,
>  				 sizeof(uint32_t))) == NULL) {
> @@ -2418,6 +2424,7 @@ int expand_module(sepol_handle_t * handl
>  	retval = 0;
>  
>        cleanup:
> +	ebitmap_destroy(&out->policycaps);

This happens on the success path too - thereby clearing the policycaps
before they are written out to the kernel policy file.  Which would
explain why Paul doesn't see anything kernel side.  

If dismod/dispol had support for displaying the bitmap, you'd be able to
see that more easily...

>  	free(state.typemap);
>  	free(state.boolmap);
>  	return retval;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
