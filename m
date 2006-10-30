MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] libsepol users in non-mls policy bugfix
Date: Mon, 30 Oct 2006 16:41:55 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015885147CD@exchange.columbia.tresys.com>
In-Reply-To: <1162234607.29732.30.camel@localhost.localdomain>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Cc: <selinux@tycho.nsa.gov>, "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Darrel Goeddel" <dgoeddel@TrustedCS.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> 
> On Mon, 2006-10-30 at 13:31 -0500, Joshua Brindle wrote:
> > > From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com]
> > > 
> > > This patch looks ok, but shouldn't we also stop the segfault in 
> > > mls_level_convert? The use of assert there looks like it 
> is catching 
> > > what should be a runtime error that should cause an error message 
> > > rather than bailing.
> > > 
> > > Otherwise:
> > 
> > Yea, I tried thinking of a more elegant way to do it and 
> couldn't come 
> > up with anything, any suggestions?
> > 
> 
> You can put the check in mls_level_convert.
> 
> > Clearly those assertions only apply to the MLS case, and we 
> caught a 
> > plain bug because of them, I think they are not user errors.
> > 
> 
> Yea - I forgot how all of those assertions are used in the link code.
> The alternative is below (with some cleanup up error handling 
> that makes it look larger). Honestly, I don't care which patch.
> 

Looks fine aside from the unrelated parts which should have been split
out :)

> Karl
> 
> 
> Index: libsepol/src/link.c
> ===================================================================
> --- libsepol/src/link.c	(revision 2074)
> +++ libsepol/src/link.c	(working copy)
> @@ -827,19 +827,24 @@
>  	return -1;
>  }
>  
> -static int mls_level_convert(mls_semantic_level_t * src,
> -			     mls_semantic_level_t * dst, 
> policy_module_t * mod)
> +static int mls_level_convert(mls_semantic_level_t * src, 
> mls_semantic_level_t * dst,
> +			     policy_module_t * mod, 
> link_state_t * state)
>  {
>  	mls_semantic_cat_t *src_cat, *new_cat;
>  
> +	if (!mod->policy->mls)
> +		return 0;
> +
>  	assert(mod->map[SYM_LEVELS][src->sens - 1]);
>  	dst->sens = mod->map[SYM_LEVELS][src->sens - 1];
>  
>  	for (src_cat = src->cat; src_cat; src_cat = src_cat->next) {
>  		new_cat =
>  		    (mls_semantic_cat_t *) 
> malloc(sizeof(mls_semantic_cat_t));
> -		if (!new_cat)
> +		if (!new_cat) {
> +			ERR(state->handle, "Out of memory");
>  			return -1;
> +		}
>  		mls_semantic_cat_init(new_cat);
>  
>  		new_cat->next = dst->cat;
> @@ -854,13 +859,16 @@
>  	return 0;
>  }
>  
> -static int mls_range_convert(mls_semantic_range_t * src,
> -			     mls_semantic_range_t * dst, 
> policy_module_t * mod)
> +static int mls_range_convert(mls_semantic_range_t * src, 
> mls_semantic_range_t * dst,
> +			     policy_module_t * mod, 
> link_state_t * state)
>  {
> -	if (mls_level_convert(&src->level[0], &dst->level[0], mod))
> -		return -1;
> -	if (mls_level_convert(&src->level[1], &dst->level[1], mod))
> -		return -1;
> +	int ret;
> +	ret = mls_level_convert(&src->level[0], &dst->level[0], 
> mod, state);
> +	if (ret)
> +		return ret;
> +	ret = mls_level_convert(&src->level[1], &dst->level[1], 
> mod, state);
> +	if (ret)
> +		return ret;
>  	return 0;
>  }
>  
> @@ -994,10 +1002,10 @@
>  		goto cleanup;
>  	}
>  
> -	if (mls_range_convert(&user->range, &new_user->range, mod))
> +	if (mls_range_convert(&user->range, &new_user->range, 
> mod, state))
>  		goto cleanup;
>  
> -	if (mls_level_convert(&user->dfltlevel, 
> &new_user->dfltlevel, mod))
> +	if (mls_level_convert(&user->dfltlevel, 
> &new_user->dfltlevel, mod, 
> +state))
>  		goto cleanup;
>  
>  	return 0;
> @@ -1224,7 +1232,7 @@
>  			}
>  		}
>  
> -		if (mls_range_convert(&rule->trange, 
> &new_rule->trange, mod))
> +		if (mls_range_convert(&rule->trange, 
> &new_rule->trange, mod, state))
>  			goto cleanup;
>  	}
>  	return 0;
> 
> 
> 

Acked-By: Joshua Brindle <jbrindle@tresys.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
