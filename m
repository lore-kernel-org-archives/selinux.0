Subject: Re: [PATCH] Fix neverallowxperm checking on attributes
To: Jeff Vander Stoep <jeffv@google.com>, selinux@tycho.nsa.gov
References: <1463608393-37966-1-git-send-email-jeffv@google.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b6c4daa2-3cde-9995-3642-bfdc3b7dd95b@tycho.nsa.gov>
Date: Thu, 19 May 2016 14:37:10 -0400
MIME-Version: 1.0
In-Reply-To: <1463608393-37966-1-git-send-email-jeffv@google.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/18/2016 05:53 PM, Jeff Vander Stoep wrote:
> The following test incorrectly asserts a neverallowxperm failure.
> 
> 	attribute test1_attr1;
> 	attribute test1_attr2;
> 	type test1_type1, test1_attr1, test1_attr2;
> 
> 	allow test1_type1 test1_attr1:socket ioctl;
> 	allowxperm test1_type1 test1_attr2:socket ioctl { 1 };
> 	neverallowxperm test1_attr1 test1_attr1:socket ioctl { 0 }
> 
> To handle attributes correctly, the neverallowxperm checking has been
> modified. Now when the ioctl permission is granted on an avtab entry
> that matches an avrule neverallowxperm entry, the assertion checking
> first determines the matching source/target/class sets between the
> avtab entry and the neverallowxperm entry. Only the matching sets are
> enumerated over to determine if the neverallowed extended permissions
> exist and if they are granted. This is similar to how
> report_assertion_avtab_matches() reports neverallow failures.
> 
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>

Thanks, applied.

> ---
>  libsepol/src/assertion.c | 117 ++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 95 insertions(+), 22 deletions(-)
> 
> diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
> index f4429ad..a4be880 100644
> --- a/libsepol/src/assertion.c
> +++ b/libsepol/src/assertion.c
> @@ -147,8 +147,8 @@ static int report_assertion_extended_permissions(sepol_handle_t *handle,
>  	avtab_key_t tmp_key;
>  	avtab_extended_perms_t *xperms;
>  	avtab_extended_perms_t error;
> -	ebitmap_t *sattr = &p->type_attr_map[k->source_type - 1];
> -	ebitmap_t *tattr = &p->type_attr_map[k->target_type - 1];
> +	ebitmap_t *sattr = &p->type_attr_map[stype];
> +	ebitmap_t *tattr = &p->type_attr_map[ttype];
>  	ebitmap_node_t *snode, *tnode;
>  	unsigned int i, j;
>  	int rc = 1;
> @@ -174,14 +174,14 @@ static int report_assertion_extended_permissions(sepol_handle_t *handle,
>  					continue;
>  
>  				rc = check_extended_permissions(avrule->xperms, xperms);
> -				/* failure on the extended permission check_extended_permissionss */
> +				/* failure on the extended permission check_extended_permissions */
>  				if (rc) {
>  					extended_permissions_violated(&error, avrule->xperms, xperms);
>  					ERR(handle, "neverallowxperm on line %lu of %s (or line %lu of policy.conf) violated by\n"
>  							"allowxperm %s %s:%s %s;",
>  							avrule->source_line, avrule->source_filename, avrule->line,
> -							p->p_type_val_to_name[stype],
> -							p->p_type_val_to_name[ttype],
> +							p->p_type_val_to_name[i],
> +							p->p_type_val_to_name[j],
>  							p->p_class_val_to_name[curperm->tclass - 1],
>  							sepol_extended_perms_to_string(&error));
>  
> @@ -317,29 +317,19 @@ oom:
>  }
>  
>  /*
> - * If the ioctl permission is granted in check_assertion_avtab_match for the
> - * source/target/class matching the current avrule neverallow, a lookup is
> - * performed to determine if extended permissions exist for the source/target/class.
> - *
> - * Four scenarios of interest:
> - * 1. PASS - the ioctl permission is not granted for this source/target/class
> - *    This case is handled in check_assertion_avtab_match
> - * 2. PASS - The ioctl permission is granted AND the extended permission
> - *    is NOT granted
> - * 3. FAIL - The ioctl permission is granted AND no extended permissions
> - *    exist
> - * 4. FAIL - The ioctl permission is granted AND the extended permission is
> - *    granted
> + * Look up the extended permissions in avtab and verify that neverallowed
> + * permissions are not granted.
>   */
> -static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab,
> +static int check_assertion_extended_permissions_avtab(avrule_t *avrule, avtab_t *avtab,
> +						unsigned int stype, unsigned int ttype,
>  						avtab_key_t *k, policydb_t *p)
>  {
>  	avtab_ptr_t node;
>  	avtab_key_t tmp_key;
>  	avtab_extended_perms_t *xperms;
>  	av_extended_perms_t *neverallow_xperms = avrule->xperms;
> -	ebitmap_t *sattr = &p->type_attr_map[k->source_type - 1];
> -	ebitmap_t *tattr = &p->type_attr_map[k->target_type - 1];
> +	ebitmap_t *sattr = &p->type_attr_map[stype];
> +	ebitmap_t *tattr = &p->type_attr_map[ttype];
>  	ebitmap_node_t *snode, *tnode;
>  	unsigned int i, j;
>  	int rc = 1;
> @@ -373,6 +363,89 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
>  	return rc;
>  }
>  
> +/*
> + * When the ioctl permission is granted on an avtab entry that matches an
> + * avrule neverallowxperm entry, enumerate over the matching
> + * source/target/class sets to determine if the extended permissions exist
> + * and if the neverallowed ioctls are granted.
> + *
> + * Four scenarios of interest:
> + * 1. PASS - the ioctl permission is not granted for this source/target/class
> + *    This case is handled in check_assertion_avtab_match
> + * 2. PASS - The ioctl permission is granted AND the extended permission
> + *    is NOT granted
> + * 3. FAIL - The ioctl permission is granted AND no extended permissions
> + *    exist
> + * 4. FAIL - The ioctl permission is granted AND the extended permission is
> + *    granted
> + */
> +static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab,
> +						avtab_key_t *k, policydb_t *p)
> +{
> +	ebitmap_t src_matches, tgt_matches, matches;
> +	unsigned int i, j;
> +	ebitmap_node_t *snode, *tnode;
> +	class_perm_node_t *cp;
> +	int rc;
> +	int ret = 1;
> +
> +	ebitmap_init(&src_matches);
> +	ebitmap_init(&tgt_matches);
> +	ebitmap_init(&matches);
> +	rc = ebitmap_and(&src_matches, &avrule->stypes.types,
> +			 &p->attr_type_map[k->source_type - 1]);
> +	if (rc)
> +		goto oom;
> +
> +	if (ebitmap_length(&src_matches) == 0)
> +		goto exit;
> +
> +	if (avrule->flags == RULE_SELF) {
> +		rc = ebitmap_and(&matches, &p->attr_type_map[k->source_type - 1],
> +				&p->attr_type_map[k->target_type - 1]);
> +		if (rc)
> +			goto oom;
> +		rc = ebitmap_and(&tgt_matches, &avrule->stypes.types, &matches);
> +		if (rc)
> +			goto oom;
> +	} else {
> +		rc = ebitmap_and(&tgt_matches, &avrule->ttypes.types,
> +				&p->attr_type_map[k->target_type -1]);
> +		if (rc)
> +			goto oom;
> +	}
> +
> +	if (ebitmap_length(&tgt_matches) == 0)
> +		goto exit;
> +
> +	for (cp = avrule->perms; cp; cp = cp->next) {
> +		if (cp->tclass != k->target_class)
> +			continue;
> +		ebitmap_for_each_bit(&src_matches, snode, i) {
> +			if (!ebitmap_node_get_bit(snode, i))
> +				continue;
> +			ebitmap_for_each_bit(&tgt_matches, tnode, j) {
> +				if (!ebitmap_node_get_bit(tnode, j))
> +					continue;
> +
> +				ret = check_assertion_extended_permissions_avtab(
> +						avrule, avtab, i, j, k, p);
> +				if (ret)
> +					goto exit;
> +			}
> +		}
> +	}
> +	goto exit;
> +
> +oom:
> +	ERR(NULL, "Out of memory - unable to check neverallows");
> +
> +exit:
> +	ebitmap_destroy(&src_matches);
> +	ebitmap_destroy(&tgt_matches);
> +	ebitmap_destroy(&matches);
> +	return ret;
> +}
>  
>  static int check_assertion_avtab_match(avtab_key_t *k, avtab_datum_t *d, void *args)
>  {
> @@ -382,7 +455,7 @@ static int check_assertion_avtab_match(avtab_key_t *k, avtab_datum_t *d, void *a
>  	avrule_t *avrule = a->avrule;
>  	avtab_t *avtab = a->avtab;
>  
> -	if (k->specified != AVTAB_ALLOWED && k->specified != AVTAB_XPERMS_ALLOWED)
> +	if (k->specified != AVTAB_ALLOWED)
>  		goto exit;
>  
>  	if (!match_any_class_permissions(avrule->perms, k->target_class, d->data))
> 
