Message-ID: <557AD7AB.1080408@tycho.nsa.gov>
Date: Fri, 12 Jun 2015 08:59:23 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [PATCH 03/10] libsepol: Refactored neverallow checking.
References: <1434047207-25503-1-git-send-email-jwcart2@tycho.nsa.gov>
 <1434047207-25503-4-git-send-email-jwcart2@tycho.nsa.gov>
 <5579EA96.5020108@tycho.nsa.gov>
In-Reply-To: <5579EA96.5020108@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/11/2015 04:07 PM, Stephen Smalley wrote:
> On 06/11/2015 02:26 PM, James Carter wrote:
>> Instead of creating an expanded avtab, generating all of the avtab
>> keys corresponding to a neverallow rule and searching for a match,
>> walk the nodes in the avtab and use the attr_type_map and ebitmap
>> functions to find matching rules.
>>
>> Memory usage is reduced from 370M to 125M and time is reduced from
>> 14 sec to 2 sec. (Bounds checking commented out in both cases.)
>>
>> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
>> ---
>>   libsepol/include/sepol/policydb/policydb.h |   2 +-
>>   libsepol/src/assertion.c                   | 225 ++++++++++++++++++-----------
>>   2 files changed, 145 insertions(+), 82 deletions(-)
>>
>> diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
>> index 1d8310c..b3cf9db 100644
>> --- a/libsepol/include/sepol/policydb/policydb.h
>> +++ b/libsepol/include/sepol/policydb/policydb.h
>> @@ -652,7 +652,7 @@ extern void level_datum_init(level_datum_t * x);
>>   extern void level_datum_destroy(level_datum_t * x);
>>   extern void cat_datum_init(cat_datum_t * x);
>>   extern void cat_datum_destroy(cat_datum_t * x);
>> -
>> +extern int check_assertion(policydb_t *p, avrule_t *avrule);
>>   extern int check_assertions(sepol_handle_t * handle,
>>   			    policydb_t * p, avrule_t * avrules);
>>
>> diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
>> index c335968..35698df 100644
>> --- a/libsepol/src/assertion.c
>> +++ b/libsepol/src/assertion.c
>> @@ -27,11 +27,16 @@
>>
>>   #include "debug.h"
>>
>> -static void report_failure(sepol_handle_t *handle, policydb_t *p,
>> -			   const avrule_t * avrule,
>> +struct avtab_match_args {
>> +	sepol_handle_t *handle;
>> +	policydb_t *p;
>> +	avrule_t *avrule;
>> +	unsigned long errors;
>> +};
>> +
>> +static void report_failure(sepol_handle_t *handle, policydb_t *p, const avrule_t *avrule,
>>   			   unsigned int stype, unsigned int ttype,
>> -			   const class_perm_node_t *curperm,
>> -			   const avtab_ptr_t node)
>> +			   const class_perm_node_t *curperm, uint32_t perms)
>>   {
>>   	if (avrule->source_filename) {
>>   		ERR(handle, "neverallow on line %lu of %s (or line %lu of policy.conf) violated by allow %s %s:%s {%s };",
>> @@ -39,69 +44,164 @@ static void report_failure(sepol_handle_t *handle, policydb_t *p,
>>   		    p->p_type_val_to_name[stype],
>>   		    p->p_type_val_to_name[ttype],
>>   		    p->p_class_val_to_name[curperm->tclass - 1],
>> -		    sepol_av_to_string(p, curperm->tclass,
>> -				       node->datum.data & curperm->data));
>> +		    sepol_av_to_string(p, curperm->tclass, perms));
>
> So you're reporting the entire list of permissions from the allow rule,
> not just the offending ones?  I guess I could go either way; the old
> approach was more indicative of what the problem was, while the new is
> closer to what they might find in source (albeit after macro expansion).

It is just the offending ones (node->datum.data & curperm->data).

>
>>   	} else if (avrule->line) {
>>   		ERR(handle, "neverallow on line %lu violated by allow %s %s:%s {%s };",
>>   		    avrule->line, p->p_type_val_to_name[stype],
>>   		    p->p_type_val_to_name[ttype],
>>   		    p->p_class_val_to_name[curperm->tclass - 1],
>> -		    sepol_av_to_string(p, curperm->tclass,
>> -				       node->datum.data & curperm->data));
>> +		    sepol_av_to_string(p, curperm->tclass, perms));
>>   	} else {
>>   		ERR(handle, "neverallow violated by allow %s %s:%s {%s };",
>>   		    p->p_type_val_to_name[stype],
>>   		    p->p_type_val_to_name[ttype],
>>   		    p->p_class_val_to_name[curperm->tclass - 1],
>> -		    sepol_av_to_string(p, curperm->tclass,
>> -				       node->datum.data & curperm->data));
>> +		    sepol_av_to_string(p, curperm->tclass, perms));
>>   	}
>>   }
>>
>> -static unsigned long check_assertion_helper(sepol_handle_t * handle,
>> -				  policydb_t * p,
>> -				  avtab_t * te_avtab, avtab_t * te_cond_avtab,
>> -				  unsigned int stype, unsigned int ttype,
>> -				  const avrule_t * avrule)
>> +static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void *args)
>>   {
>> -	avtab_key_t avkey;
>> -	avtab_ptr_t node;
>> -	class_perm_node_t *curperm;
>> -	unsigned long errors = 0;
>> +	struct avtab_match_args *a = (struct avtab_match_args *)args;
>> +	sepol_handle_t *handle = a->handle;
>> +	policydb_t *p = a->p;
>> +	avrule_t *avrule = a->avrule;
>> +	class_perm_node_t *cp;
>> +	uint32_t perms;
>> +	ebitmap_t src_matches, tgt_matches;
>> +	ebitmap_node_t *snode, *tnode;
>> +	unsigned int i, j;
>>
>> -	for (curperm = avrule->perms; curperm != NULL; curperm = curperm->next) {
>> -		avkey.source_type = stype + 1;
>> -		avkey.target_type = ttype + 1;
>> -		avkey.target_class = curperm->tclass;
>> -		avkey.specified = AVTAB_ALLOWED;
>> -		for (node = avtab_search_node(te_avtab, &avkey);
>> -		     node != NULL;
>> -		     node = avtab_search_node_next(node, avkey.specified)) {
>> -			if (node->datum.data & curperm->data) {
>> -				report_failure(handle, p, avrule, stype, ttype, curperm, node);
>> -				errors++;
>> -			}
>> +	if (k->specified != AVTAB_ALLOWED)
>> +		goto exit;
>> +
>> +	for (cp = avrule->perms; cp; cp = cp->next) {
>> +		perms = cp->data & d->data;
>> +		if ((cp->tclass != k->target_class) || !perms) {
>> +			continue;
>> +		}
>> +
>> +		ebitmap_and(&src_matches, &avrule->stypes.types,
>> +			    &p->attr_type_map[k->source_type - 1]);
>> +		if (ebitmap_length(&src_matches) == 0)
>> +			continue;
>> +
>> +		if (avrule->flags == RULE_SELF) {
>> +			ebitmap_t matches;
>> +			ebitmap_init(&matches);
>> +			ebitmap_and(&matches, &p->attr_type_map[k->source_type - 1], &p->attr_type_map[k->target_type - 1]);
>> +			ebitmap_and(&tgt_matches, &avrule->stypes.types, &matches);
>> +			ebitmap_destroy(&matches);
>
> ebitmap_and() can fail on memory allocation failure so we need to check
> and handle.

Don't know how I missed that.

>
>> +		} else {
>> +			ebitmap_and(&tgt_matches, &avrule->ttypes.types, &p->attr_type_map[k->target_type -1]);
>> +		}
>> +
>> +		if (ebitmap_length(&tgt_matches) == 0) {
>> +			ebitmap_destroy(&src_matches);
>> +			continue;
>>   		}
>> -		for (node = avtab_search_node(te_cond_avtab, &avkey);
>> -		     node != NULL;
>> -		     node = avtab_search_node_next(node, avkey.specified)) {
>> -			if (node->datum.data & curperm->data) {
>> -				report_failure(handle, p, avrule, stype, ttype, curperm, node);
>> -				errors++;
>> +
>> +		ebitmap_for_each_bit(&src_matches, snode, i) {
>> +			if (!ebitmap_node_get_bit(snode, i))
>> +				continue;
>> +			ebitmap_for_each_bit(&tgt_matches, tnode, j) {
>> +				if (!ebitmap_node_get_bit(tnode, j))
>> +					continue;
>> +				a->errors++;
>> +				report_failure(handle, p, avrule, i, j, cp, perms);
>>   			}
>>   		}
>>   	}
>>
>> -	return errors;
>> +exit:
>> +	return 0;
>> +}
>> +
>> +int report_assertion_failures(sepol_handle_t *handle, policydb_t *p, avrule_t *avrule)
>> +{
>> +	struct avtab_match_args args;
>> +
>> +	args.handle = handle;
>> +	args.p = p;
>> +	args.avrule = avrule;
>> +	args.errors = 0;
>> +
>> +	avtab_map(&p->te_avtab, report_assertion_avtab_matches, &args);
>> +	avtab_map(&p->te_cond_avtab, report_assertion_avtab_matches, &args);
>> +
>> +	return args.errors;
>> +}
>> +
>> +static int check_assertion_avtab_match(avtab_key_t *k, avtab_datum_t *d, void *args)
>> +{
>> +	int rc;
>> +	struct avtab_match_args *a = (struct avtab_match_args *)args;
>> +	policydb_t *p = a->p;
>> +	avrule_t *avrule = a->avrule;
>> +	class_perm_node_t *cp;
>> +
>> +	if (k->specified != AVTAB_ALLOWED)
>> +		goto exit;
>> +
>> +	for (cp = avrule->perms; cp; cp = cp->next) {
>> +		if ((cp->tclass == k->target_class) && (cp->data & d->data)) {
>> +			break;
>> +		}
>> +	}
>> +	if (!cp)
>> +		goto exit;
>> +
>> +	rc = ebitmap_match_any(&avrule->stypes.types, &p->attr_type_map[k->source_type - 1]);
>> +	if (rc == 0)
>> +		goto exit;
>> +
>> +	if (avrule->flags == RULE_SELF) {
>> +		/* If the neverallow uses SELF, then it is not enough that the
>> +		 * neverallow's source matches the src and tgt of the rule being checked.
>> +		 * It must match the same thing in the src and tgt, so AND the source
>> +		 * and target together and check for a match on the result.
>> +		 */
>> +		ebitmap_t match;
>> +		ebitmap_init(&match);
>> +		ebitmap_and(&match, &p->attr_type_map[k->source_type - 1], &p->attr_type_map[k->target_type - 1] );
>> +		rc = ebitmap_match_any(&avrule->stypes.types, &match);
>> +		ebitmap_destroy(&match);
>> +	} else {
>> +		rc = ebitmap_match_any(&avrule->ttypes.types, &p->attr_type_map[k->target_type -1]);
>> +	}
>> +	if (rc == 0)
>> +		goto exit;
>> +
>> +	return 1;
>> +
>> +exit:
>> +	return 0;
>> +}
>
> Seems like we are duplicating a lot of logic between the check and
> report functions.  I assume you split them so that the check function
> could be reused for CIL.  Can we perhaps take the common code though to
> a shared helper or macro?
>

It is split so it can be reused for CIL. I'll see if I can factor out some of 
the common code.

>> +
>> +int check_assertion(policydb_t *p, avrule_t *avrule)
>> +{
>> +	int rc;
>> +	struct avtab_match_args args;
>> +
>> +	args.handle = NULL;
>> +	args.p = p;
>> +	args.avrule = avrule;
>> +	args.errors = 0;
>> +
>> +	rc = avtab_map(&p->te_avtab, check_assertion_avtab_match, &args);
>> +
>> +	if (rc == 0) {
>> +		rc = avtab_map(&p->te_cond_avtab, check_assertion_avtab_match, &args);
>> +	}
>> +
>> +	return rc;
>>   }
>>
>>   int check_assertions(sepol_handle_t * handle, policydb_t * p,
>>   		     avrule_t * avrules)
>>   {
>> +	int rc;
>>   	avrule_t *a;
>> -	avtab_t te_avtab, te_cond_avtab;
>> -	ebitmap_node_t *snode, *tnode;
>> -	unsigned int i, j;
>>   	unsigned long errors = 0;
>>
>>   	if (!avrules) {
>> @@ -111,54 +211,17 @@ int check_assertions(sepol_handle_t * handle, policydb_t * p,
>>   		return 0;
>>   	}
>>
>> -	if (avrules) {
>> -		if (avtab_init(&te_avtab))
>> -			goto oom;
>> -		if (avtab_init(&te_cond_avtab)) {
>> -			avtab_destroy(&te_avtab);
>> -			goto oom;
>> -		}
>> -		if (expand_avtab(p, &p->te_avtab, &te_avtab) ||
>> -		    expand_avtab(p, &p->te_cond_avtab, &te_cond_avtab)) {
>> -			avtab_destroy(&te_avtab);
>> -			avtab_destroy(&te_cond_avtab);
>> -			goto oom;
>> -		}
>> -	}
>> -
>>   	for (a = avrules; a != NULL; a = a->next) {
>> -		ebitmap_t *stypes = &a->stypes.types;
>> -		ebitmap_t *ttypes = &a->ttypes.types;
>> -
>>   		if (!(a->specified & AVRULE_NEVERALLOW))
>>   			continue;
>> -
>> -		ebitmap_for_each_bit(stypes, snode, i) {
>> -			if (!ebitmap_node_get_bit(snode, i))
>> -				continue;
>> -			if (a->flags & RULE_SELF) {
>> -				errors += check_assertion_helper
>> -				    (handle, p, &te_avtab, &te_cond_avtab, i, i,
>> -				     a);
>> -			}
>> -			ebitmap_for_each_bit(ttypes, tnode, j) {
>> -				if (!ebitmap_node_get_bit(tnode, j))
>> -					continue;
>> -				errors += check_assertion_helper
>> -				    (handle, p, &te_avtab, &te_cond_avtab, i, j,
>> -				     a);
>> -			}
>> +		rc = check_assertion(p, a);
>> +		if (rc) {
>> +			errors += report_assertion_failures(handle, p, a);
>>   		}
>>   	}
>>
>>   	if (errors)
>>   		ERR(handle, "%lu neverallow failures occurred", errors);
>>
>> -	avtab_destroy(&te_avtab);
>> -	avtab_destroy(&te_cond_avtab);
>>   	return errors ? -1 : 0;
>> -
>> -      oom:
>> -	ERR(handle, "Out of memory - unable to check neverallows");
>> -	return -1;
>>   }
>>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
