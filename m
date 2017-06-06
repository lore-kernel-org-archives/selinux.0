Received: from [192.168.25.4] (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v56E5agF030316
 for <selinux@tycho.nsa.gov>; Tue, 6 Jun 2017 10:05:36 -0400
Subject: Re: [PATCH v2] libsepol: Expand attributes with
 TYPE_FLAGS_EXPAND_ATTR_TRUE set
To: selinux@tycho.nsa.gov
References: <20170510202544.2338-1-jwcart2@tycho.nsa.gov>
From: jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <d9d14ed0-dbd4-90e4-d93f-13c0f47a1528@tycho.nsa.gov>
Date: Tue, 6 Jun 2017 10:06:30 -0400
MIME-Version: 1.0
In-Reply-To: <20170510202544.2338-1-jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/10/2017 04:25 PM, James Carter wrote:
> Commit 1089665e31a647a5f0ba2eabe8ac6232b384bed9 (Add attribute
> expansion options) adds an expandattribute rule to the policy.conf
> language which sets a type_datum flag. Currently the flag is used
> only when writing out CIL policy from a policy.conf.
> 
> Make use of the flag when expanding policy to expand policy rules
> and remove all type associations for an attribute that has
> TYPE_FLAGS_EXPAND_ATTR_TRUE set. (The attribute will remain in the
> policy, but have no types associated with it.)
> 
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>

This patch has been applied.

> ---
> v2 Just check if each attribute should be expanded in type_attr_map(). No need
> to destroy the types ebitmap.
> 
>   libsepol/src/expand.c | 76 ++++++++++++++++++++++++++-------------------------
>   libsepol/src/link.c   |  8 +++---
>   2 files changed, 43 insertions(+), 41 deletions(-)
> 
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 54bf781..c55226b 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -2337,13 +2337,20 @@ static int type_attr_map(hashtab_key_t key
>   	value = type->s.value;
>   
>   	if (type->flavor == TYPE_ATTRIB) {
> -		if (ebitmap_cpy(&p->attr_type_map[value - 1], &type->types)) {
> -			goto oom;
> -		}
> -		ebitmap_for_each_bit(&type->types, tnode, i) {
> -			if (!ebitmap_node_get_bit(tnode, i))
> -				continue;
> -			if (ebitmap_set_bit(&p->type_attr_map[i], value - 1, 1)) {
> +		if (!(type->flags & TYPE_FLAGS_EXPAND_ATTR_TRUE)) {
> +			if (ebitmap_cpy(&p->attr_type_map[value - 1], &type->types)) {
> +				goto oom;
> +			}
> +			ebitmap_for_each_bit(&type->types, tnode, i) {
> +				if (!ebitmap_node_get_bit(tnode, i))
> +					continue;
> +				if (ebitmap_set_bit(&p->type_attr_map[i], value - 1, 1)) {
> +					goto oom;
> +				}
> +			}
> +		} else {
> +			/* Attribute is being expanded, so remove */
> +			if (ebitmap_set_bit(&p->type_attr_map[value - 1], value - 1, 0)) {
>   				goto oom;
>   			}
>   		}
> @@ -2513,46 +2520,41 @@ int type_set_expand(type_set_t * set, ebitmap_t * t, policydb_t * p,
>   	unsigned int i;
>   	ebitmap_t types, neg_types;
>   	ebitmap_node_t *tnode;
> +	unsigned char expand = alwaysexpand || ebitmap_length(&set->negset) || set->flags;
> +	type_datum_t *type;
>   	int rc =-1;
>   
>   	ebitmap_init(&types);
>   	ebitmap_init(t);
>   
> -	if (alwaysexpand || ebitmap_length(&set->negset) || set->flags) {
> -		/* First go through the types and OR all the attributes to types */
> -		ebitmap_for_each_bit(&set->types, tnode, i) {
> -			if (ebitmap_node_get_bit(tnode, i)) {
> +	/* First go through the types and OR all the attributes to types */
> +	ebitmap_for_each_bit(&set->types, tnode, i) {
> +		if (!ebitmap_node_get_bit(tnode, i))
> +			continue;
>   
> -				/*
> -				 * invalid policies might have more types set in the ebitmap than
> -				 * what's available in the type_val_to_struct mapping
> -				 */
> -				if (i >= p->p_types.nprim)
> -					goto err_types;
> +		/*
> +		 * invalid policies might have more types set in the ebitmap than
> +		 * what's available in the type_val_to_struct mapping
> +		 */
> +		if (i >= p->p_types.nprim)
> +			goto err_types;
>   
> -				if (!p->type_val_to_struct[i]) {
> -					goto err_types;
> -				}
> +		type = p->type_val_to_struct[i];
>   
> -				if (p->type_val_to_struct[i]->flavor ==
> -				    TYPE_ATTRIB) {
> -					if (ebitmap_union
> -					    (&types,
> -					     &p->type_val_to_struct[i]->
> -					     types)) {
> -						goto err_types;
> -					}
> -				} else {
> -					if (ebitmap_set_bit(&types, i, 1)) {
> -						goto err_types;
> -					}
> -				}
> +		if (!type) {
> +			goto err_types;
> +		}
> +
> +		if (type->flavor == TYPE_ATTRIB &&
> +		    (expand || (type->flags & TYPE_FLAGS_EXPAND_ATTR_TRUE))) {
> +			if (ebitmap_union(&types, &type->types)) {
> +				goto err_types;
> +			}
> +		} else {
> +			if (ebitmap_set_bit(&types, i, 1)) {
> +				goto err_types;
>   			}
>   		}
> -	} else {
> -		/* No expansion of attributes, just copy the set as is. */
> -		if (ebitmap_cpy(&types, &set->types))
> -			goto err_types;
>   	}
>   
>   	/* Now do the same thing for negset */
> diff --git a/libsepol/src/link.c b/libsepol/src/link.c
> index f211164..52770f4 100644
> --- a/libsepol/src/link.c
> +++ b/libsepol/src/link.c
> @@ -467,8 +467,8 @@ static int type_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
>   			    state->cur_mod_name, id);
>   			return -1;
>   		}
> -		/* permissive should pass to the base type */
> -		base_type->flags |= (type->flags & TYPE_FLAGS_PERMISSIVE);
> +
> +		base_type->flags |= type->flags;
>   	} else {
>   		if (state->verbose)
>   			INFO(state->handle, "copying type %s", id);
> @@ -890,7 +890,7 @@ static int alias_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
>   		return -1;
>   	}
>   
> -	target_type->flags |= (type->flags & TYPE_FLAGS_PERMISSIVE);
> +	target_type->flags |= type->flags;
>   
>   	base_type = hashtab_search(state->base->p_types.table, id);
>   	if (base_type == NULL) {
> @@ -938,7 +938,7 @@ static int alias_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
>   
>   		base_type->flavor = TYPE_ALIAS;
>   		base_type->primary = target_type->s.value;
> -		base_type->flags |= (target_type->flags & TYPE_FLAGS_PERMISSIVE);
> +		base_type->flags |= target_type->flags;
>   
>   	}
>   	/* the aliases map points from its value to its primary so when this module
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
