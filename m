Subject: Re: libsemage patch to not compile modules for seusers and fcontext
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        ivg231@gmail.com
In-Reply-To: <48A48B8C.3070908@redhat.com>
References: <48A48B8C.3070908@redhat.com>
Content-Type: text/plain
Date: Fri, 22 Aug 2008 09:38:37 -0400
Message-Id: <1219412317.18600.60.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-08-14 at 15:46 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Patch speeds up semanage command from 17-20 seconds to 3-4 seconds.
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> 
> iEYEARECAAYFAkiki4sACgkQrlYvE4MpobM9WwCfY1dRI+NDNiUpu0bwhajASwzR
> WVkAnRpWzNWiP+CfBW7n2QTfs+yu0CM1
> =8h+v
> -----END PGP SIGNATURE-----
> plain text document attachment (libsemanage-rhat.patch)
> diff --exclude-from=exclude -N -u -r nsalibsemanage/src/direct_api.c libsemanage-2.0.27/src/direct_api.c
> --- nsalibsemanage/src/direct_api.c	2008-06-12 23:25:16.000000000 -0400
> +++ libsemanage-2.0.27/src/direct_api.c	2008-08-14 11:51:15.000000000 -0400
> @@ -489,12 +489,6 @@
>  	modified |= ifaces->dtable->is_modified(ifaces->dbase);
>  	modified |= nodes->dtable->is_modified(nodes->dbase);
>  
> -	/* FIXME: get rid of these, once we support loading the existing policy,
> -	 * instead of rebuilding it */
> -	modified |= seusers_modified;
> -	modified |= fcontexts_modified;
> -	modified |= users_extra_modified;
> -
>  	/* If there were policy changes, or explicitly requested, rebuild the policy */
>  	if (sh->do_rebuild || modified) {
>  
> @@ -667,11 +661,34 @@
>  		retval = semanage_verify_kernel(sh);
>  		if (retval < 0)
>  			goto cleanup;
> -	}
> +	} else {
> +		sepol_policydb_create(&out);

We should test for failure here (out of memory condition possible).

> +		modified |= seusers_modified;
> +		modified |= fcontexts_modified;
> +		modified |= users_extra_modified;

Should we be setting modified here or just testing for these other
_modified flags where needed?

> +		
> +		retval = semanage_read_policydb(sh, out);

Are there any other situations where we can re-use the existing kernel
policy like this?  e.g. Do we really need to re-link/expand the modules
if we aren't actually modifying modules?  Although there I suppose we
might want a copy of the policy before merging local customizations.

Also reminds me of the whole question of why we don't do incremental
linking to avoid having to re-link each time.

>  
> +		if (retval < 0)
> +			goto cleanup;
> +		
> +		dbase_policydb_attach((dbase_policydb_t *) pusers_base->dbase,out);
> +		dbase_policydb_attach((dbase_policydb_t *) pports->dbase, out);
> +		dbase_policydb_attach((dbase_policydb_t *) pifaces->dbase, out);
> +		dbase_policydb_attach((dbase_policydb_t *) pbools->dbase, out);
> +		dbase_policydb_attach((dbase_policydb_t *) pnodes->dbase, out);

Ivan suggested these shouldn't be necessary as long as you make the
later detach conditional.  But he also raised a concern about merging
with the base seusers or users_extra from the modules?  
   
>  
> -	/* FIXME: else if !modified, but seusers_modified, 
> -	 * load the existing policy instead of rebuilding */
> +		if (seusers_modified) {
> +			retval = pseusers->dtable->clear(sh, pseusers->dbase);
> +			if (retval < 0)
> +				goto cleanup;

I'm a little unclear on what this is doing - can you clarify?

> +		}
>  
> +		retval = semanage_base_merge_components(sh);
> +		if (retval < 0)
> +		  goto cleanup;
> +
> +		/* Seusers */
> +	}
>  	/* ======= Post-process: Validate non-policydb components ===== */
>  
>  	/* Validate local modifications to file contexts.
> diff --exclude-from=exclude -N -u -r nsalibsemanage/src/semanage_store.c libsemanage-2.0.27/src/semanage_store.c
> --- nsalibsemanage/src/semanage_store.c	2008-06-12 23:25:16.000000000 -0400
> +++ libsemanage-2.0.27/src/semanage_store.c	2008-08-08 15:23:20.000000000 -0400
> @@ -1648,6 +1648,47 @@
>  }
>  
>  /**
> + * Read the policy from the sandbox (kernel)
> + */
> +int semanage_read_policydb(semanage_handle_t * sh, sepol_policydb_t * in)
> +{
> +
> +	int retval = STATUS_ERR;
> +	const char *kernel_filename = NULL;
> +	struct sepol_policy_file *pf = NULL;
> +	FILE *infile = NULL;
> +
> +	if ((kernel_filename =
> +	     semanage_path(SEMANAGE_ACTIVE, SEMANAGE_KERNEL)) == NULL) {
> +		goto cleanup;
> +	}
> +	if ((infile = fopen(kernel_filename, "r")) == NULL) {
> +		ERR(sh, "Could not open kernel policy %s for reading.",
> +		    kernel_filename);
> +		goto cleanup;
> +	}
> +	__fsetlocking(infile, FSETLOCKING_BYCALLER);
> +	if (sepol_policy_file_create(&pf)) {
> +		ERR(sh, "Out of memory!");
> +		goto cleanup;
> +	}
> +	sepol_policy_file_set_fp(pf, infile);
> +	sepol_policy_file_set_handle(pf, sh->sepolh);
> +	if (sepol_policydb_read(in, pf) == -1) {
> +		ERR(sh, "Error while reading kernel policy from %s.",
> +		    kernel_filename);
> +		goto cleanup;
> +	}
> +	retval = STATUS_SUCCESS;
> +
> +      cleanup:
> +	if (infile != NULL) {
> +		fclose(infile);
> +	}
> +	sepol_policy_file_free(pf);
> +	return retval;
> +}
> +/**
>   * Writes the final policy to the sandbox (kernel)
>   */
>  int semanage_write_policydb(semanage_handle_t * sh, sepol_policydb_t * out)
> diff --exclude-from=exclude -N -u -r nsalibsemanage/src/semanage_store.h libsemanage-2.0.27/src/semanage_store.h
> --- nsalibsemanage/src/semanage_store.h	2008-06-12 23:25:16.000000000 -0400
> +++ libsemanage-2.0.27/src/semanage_store.h	2008-08-11 09:05:16.000000000 -0400
> @@ -97,6 +97,9 @@
>  			    sepol_module_package_t * base,
>  			    sepol_policydb_t ** policydb);
>  
> +int semanage_read_policydb(semanage_handle_t * sh,
> +			    sepol_policydb_t * policydb);
> +
>  int semanage_write_policydb(semanage_handle_t * sh,
>  			    sepol_policydb_t * policydb);
>  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
