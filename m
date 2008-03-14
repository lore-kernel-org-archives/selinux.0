Subject: Re: libselinux/matchpathcon has a memory leak
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <47D9B7AB.4040701@tycho.nsa.gov>
References: <47D9B0DB.90308@redhat.com>  <47D9B7AB.4040701@tycho.nsa.gov>
Content-Type: text/plain
Date: Fri, 14 Mar 2008 09:20:11 -0400
Message-Id: <1205500811.22912.26.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-03-13 at 19:24 -0400, Eamon Walsh wrote:
> Daniel J Walsh wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Looks like the selabel stuff is leaking.
> >   
> 
> Try this patch please:
> 
> Index: libselinux/src/label_file.c
> ===================================================================
> --- libselinux/src/label_file.c	(revision 2848)
> +++ libselinux/src/label_file.c	(working copy)
> @@ -490,9 +490,8 @@
>  				goto finish;
>  			}
>  			if (NULL == (data->spec_arr =
> -				     malloc(sizeof(spec_t) * data->nspec)))
> +				     calloc(data->nspec, sizeof(spec_t))))
>  				goto finish;
> -			memset(data->spec_arr, 0, sizeof(spec_t)*data->nspec);

Fine as a cleanup, but wouldn't make a difference to this leak, so
that's a separate patch.

>  			maxnspec = data->nspec;
>  			rewind(fp);
>  			if (homedirfp)
> @@ -504,7 +503,7 @@
>  	free(line_buf);
>  
>  	/* Move exact pathname specifications to the end. */
> -	spec_copy = malloc(sizeof(spec_t) * data->nspec);
> +	spec_copy = calloc(data->nspec, sizeof(spec_t));

Unnecessary - if you look at the code that follows, it ensures that
every entry in spec_copy is initialized.

>  	if (!spec_copy)
>  		goto finish;
>  	j = 0;
> Index: libselinux/src/matchpathcon.c
> ===================================================================
> --- libselinux/src/matchpathcon.c	(revision 2848)
> +++ libselinux/src/matchpathcon.c	(working copy)
> @@ -284,6 +284,8 @@
>  
>  int matchpathcon_init_prefix(const char *path, const char *subset)
>  {
> +	matchpathcon_fini();

I think this burden belongs on the caller and shouldn't be silently done
here.

> +
>  	if (!mycanoncon)
>  		mycanoncon = default_canoncon;
>  
> Index: libselinux/src/label.c
> ===================================================================
> --- libselinux/src/label.c	(revision 2848)
> +++ libselinux/src/label.c	(working copy)
> @@ -95,7 +95,7 @@
>  	if (compat_validate(rec, lr, "file_contexts", 0))
>  		return NULL;
>  
> -	if (translating &&
> +	if (translating && !lr->ctx_trans &&
>  	    selinux_raw_to_trans_context(lr->ctx_raw, &lr->ctx_trans))
>  		return NULL;

This is the only part applicable to the leak.

>  
> 
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
