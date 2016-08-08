From: "Roberts, William C" <william.c.roberts@intel.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 "sds@tycho.nsa.gov" <sds@tycho.nsa.gov>
Subject: RE: [PATCH] libsepol: fix memory leak in expand.c
Date: Mon, 8 Aug 2016 17:29:50 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC56012805C4@ORSMSX103.amr.corp.intel.com>
References: <1470677301-20065-1-git-send-email-william.c.roberts@intel.com>
In-Reply-To: <1470677301-20065-1-git-send-email-william.c.roberts@intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



> -----Original Message-----
> From: Roberts, William C
> Sent: Monday, August 8, 2016 10:28 AM
> To: selinux@tycho.nsa.gov; seandroid-list@tycho.nsa.gov; sds@tycho.nsa.gov
> Cc: Roberts, William C <william.c.roberts@intel.com>
> Subject: [PATCH] libsepol: fix memory leak in expand.c
> 
> From: William Roberts <william.c.roberts@intel.com>
> 
> ebitmap_set_bit() can possible allocate nodes, however, the bail early style of
> type_set_expand() could leave internal ebitmaps allocated but not free'd.
> 
> Modify type_set_expand() so that it free's all allocated ebitmaps before
> returning the error code to the calling routine.
> 
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  libsepol/src/expand.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c index 4d3c623..0ad57f5
> 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -2497,6 +2497,7 @@ int type_set_expand(type_set_t * set, ebitmap_t * t,
> policydb_t * p,
>  	unsigned int i;
>  	ebitmap_t types, neg_types;
>  	ebitmap_node_t *tnode;
> +	int rc =-1;
> 
>  	ebitmap_init(&types);
>  	ebitmap_init(t);
> @@ -2511,7 +2512,7 @@ int type_set_expand(type_set_t * set, ebitmap_t * t,
> policydb_t * p,
>  				 * what's available in the type_val_to_struct
> mapping
>  				 */
>  				if (i > p->p_types.nprim - 1)
> -						return -1;
> +					goto err_types;
> 
>  				if (p->type_val_to_struct[i]->flavor ==
>  				    TYPE_ATTRIB) {
> @@ -2519,11 +2520,11 @@ int type_set_expand(type_set_t * set, ebitmap_t *
> t, policydb_t * p,
>  					    (&types,
>  					     &p->type_val_to_struct[i]->
>  					     types)) {
> -						return -1;
> +						goto err_types;
>  					}
>  				} else {
>  					if (ebitmap_set_bit(&types, i, 1)) {
> -						return -1;
> +						goto err_types;
>  					}
>  				}
>  			}
> @@ -2531,7 +2532,7 @@ int type_set_expand(type_set_t * set, ebitmap_t * t,
> policydb_t * p,
>  	} else {
>  		/* No expansion of attributes, just copy the set as is. */
>  		if (ebitmap_cpy(&types, &set->types))
> -			return -1;
> +			goto err_types;
>  	}
> 
>  	/* Now do the same thing for negset */ @@ -2543,11 +2544,11 @@ int
> type_set_expand(type_set_t * set, ebitmap_t * t, policydb_t * p,
>  				if (ebitmap_union
>  				    (&neg_types,
>  				     &p->type_val_to_struct[i]->types)) {
> -					return -1;
> +					goto err_neg;
>  				}
>  			} else {
>  				if (ebitmap_set_bit(&neg_types, i, 1)) {
> -					return -1;
> +					goto err_neg;
>  				}
>  			}
>  		}
> @@ -2562,7 +2563,7 @@ int type_set_expand(type_set_t * set, ebitmap_t * t,
> policydb_t * p,
>  			    p->type_val_to_struct[i]->flavor == TYPE_ATTRIB)
>  				continue;
>  			if (ebitmap_set_bit(t, i, 1))
> -				return -1;
> +				goto err_neg;
>  		}
>  		goto out;
>  	}
> @@ -2571,7 +2572,7 @@ int type_set_expand(type_set_t * set, ebitmap_t * t,
> policydb_t * p,
>  		if (ebitmap_node_get_bit(tnode, i)
>  		    && (!ebitmap_get_bit(&neg_types, i)))
>  			if (ebitmap_set_bit(t, i, 1))
> -				return -1;
> +				goto err_neg;
>  	}
> 
>  	if (set->flags & TYPE_COMP) {
> @@ -2583,20 +2584,23 @@ int type_set_expand(type_set_t * set, ebitmap_t *
> t, policydb_t * p,
>  			}
>  			if (ebitmap_get_bit(t, i)) {
>  				if (ebitmap_set_bit(t, i, 0))
> -					return -1;
> +					goto err_neg;
>  			} else {
>  				if (ebitmap_set_bit(t, i, 1))
> -					return -1;
> +					goto err_neg;
>  			}
>  		}
>  	}
> 
> -      out:
> +	  out:
> +	rc = 0;
> 
> -	ebitmap_destroy(&types);
> +	  err_neg:
>  	ebitmap_destroy(&neg_types);
> +	  err_types:
> +	ebitmap_destroy(&types);
> 
> -	return 0;
> +	return rc;
>  }
> 
>  static int copy_neverallow(policydb_t * dest_pol, uint32_t * typemap,
> --
> 1.9.1

Sorry for the disorganization in not sending these out as a series, I didn't see the memory leak, but this applies on-top of:
[PATCH] libsepol: fix invalid read when policy file is corrupt

Bill
