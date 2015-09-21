Subject: Re: [PATCH] Add neverallow support for ioctl extended permissions
To: Jeff Vander Stoep <jeffv@google.com>, selinux@tycho.nsa.gov
References: <1442606276-27062-1-git-send-email-jeffv@google.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56006435.8060505@tycho.nsa.gov>
Date: Mon, 21 Sep 2015 16:10:29 -0400
MIME-Version: 1.0
In-Reply-To: <1442606276-27062-1-git-send-email-jeffv@google.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/18/2015 03:57 PM, Jeff Vander Stoep wrote:
> Neverallow rules for ioctl extended permissions will pass in two
> cases:
> 1. If extended permissions exist for the source-target-class set
>    the test will pass if the neverallow values are excluded.
> 2. If extended permissions do not exist for the source-target-class
>    set the test will pass if the ioctl permission is not granted.
> 
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> ---
>  checkpolicy/policy_define.c                |  38 +++++-
>  checkpolicy/policy_parse.y                 |   5 +
>  checkpolicy/policy_scan.l                  |   8 +-
>  checkpolicy/test/dispol.c                  |  62 +--------
>  libsepol/include/sepol/policydb/avtab.h    |   1 +
>  libsepol/include/sepol/policydb/policydb.h |  10 +-
>  libsepol/include/sepol/policydb/util.h     |   2 +
>  libsepol/src/assertion.c                   | 194 +++++++++++++++++++++++++++--
>  libsepol/src/expand.c                      |  23 +++-
>  libsepol/src/util.c                        |  72 +++++++++++
>  10 files changed, 331 insertions(+), 84 deletions(-)
> 
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 7f32029..ee20fea 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -1729,10 +1729,6 @@ avrule_t *define_cond_pol_list(avrule_t * avlist, avrule_t * sl)
>  	return sl;
>  }
>  
> -#define xperm_test(x, p) (1 & (p[x >> 5] >> (x & 0x1f)))
> -#define xperm_set(x, p) (p[x >> 5] |= (1 << (x & 0x1f)))
> -#define xperm_clear(x, p) (p[x >> 5] &= ~(1 << (x & 0x1f)))
> -
>  typedef struct av_ioctl_range {
>  	uint16_t low;
>  	uint16_t high;
> @@ -1942,6 +1938,8 @@ int define_te_avtab_xperms_helper(int which, avrule_t ** rule)
>  {
>  	char *id;
>  	class_perm_node_t *perms, *tail = NULL, *cur_perms = NULL;
> +	class_datum_t *cladatum;
> +	perm_datum_t *perdatum = NULL;
>  	ebitmap_t tclasses;
>  	ebitmap_node_t *node;
>  	avrule_t *avrule;
> @@ -1968,7 +1966,7 @@ int define_te_avtab_xperms_helper(int which, avrule_t ** rule)
>  	while ((id = queue_remove(id_queue))) {
>  		if (set_types
>  		    (&avrule->stypes, id, &add,
> -		     which == AVRULE_NEVERALLOW ? 1 : 0)) {
> +		     which == AVRULE_XPERMS_NEVERALLOW ? 1 : 0)) {
>  			ret = -1;
>  			goto out;
>  		}
> @@ -1982,7 +1980,7 @@ int define_te_avtab_xperms_helper(int which, avrule_t ** rule)
>  		}
>  		if (set_types
>  		    (&avrule->ttypes, id, &add,
> -		     which == AVRULE_NEVERALLOW ? 1 : 0)) {
> +		     which == AVRULE_XPERMS_NEVERALLOW ? 1 : 0)) {
>  			ret = -1;
>  			goto out;
>  		}
> @@ -1994,6 +1992,7 @@ int define_te_avtab_xperms_helper(int which, avrule_t ** rule)
>  		goto out;
>  
>  	perms = NULL;
> +	id = queue_head(id_queue);
>  	ebitmap_for_each_bit(&tclasses, node, i) {
>  		if (!ebitmap_node_get_bit(node, i))
>  			continue;
> @@ -2011,6 +2010,29 @@ int define_te_avtab_xperms_helper(int which, avrule_t ** rule)
>  		if (tail)
>  			tail->next = cur_perms;
>  		tail = cur_perms;
> +
> +		cladatum = policydbp->class_val_to_struct[i];
> +		perdatum = hashtab_search(cladatum->permissions.table, id);
> +		if (!perdatum) {
> +			if (cladatum->comdatum) {
> +				perdatum = hashtab_search(cladatum->comdatum->
> +							permissions.table,
> +							id);
> +			}
> +		}
> +		if (!perdatum) {
> +			yyerror2("permission %s is not defined"
> +				     " for class %s", id,
> +				     policydbp->p_class_val_to_name[i]);
> +			continue;
> +		} else if (!is_perm_in_scope (id, policydbp->p_class_val_to_name[i])) {
> +			yyerror2("permission %s of class %s is"
> +			     " not within scope", id,
> +			     policydbp->p_class_val_to_name[i]);
> +			continue;
> +		} else {
> +			cur_perms->data |= 1U << (perdatum->s.value - 1);
> +		}
>  	}
>  
>  	ebitmap_destroy(&tclasses);
> @@ -2246,6 +2268,10 @@ int avrule_cpy(avrule_t *dest, avrule_t *src)
>  	}
>  	dest->line = src->line;
>  	dest->source_filename = strdup(source_file);
> +	if (!dest->source_filename) {
> +		yyerror("out of memory");
> +		return -1;
> +	}
>  	dest->source_line = src->source_line;
>  
>  	/* increment through the class perms and copy over */
> diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
> index d8b8ac0..3b6a2f8 100644
> --- a/checkpolicy/policy_parse.y
> +++ b/checkpolicy/policy_parse.y
> @@ -129,6 +129,7 @@ typedef int (* require_func_t)(int pass);
>  %token ALLOWXPERM
>  %token AUDITALLOWXPERM
>  %token DONTAUDITXPERM
> +%token NEVERALLOWXPERM
>  %token SOURCE
>  %token TARGET
>  %token SAMEUSER
> @@ -463,6 +464,7 @@ te_avtab_def		: allow_def
>  			| xperm_allow_def
>  			| xperm_auditallow_def
>  			| xperm_dontaudit_def
> +			| xperm_neverallow_def
>  			;
>  allow_def		: ALLOW names names ':' names names  ';'
>  			{if (define_te_avtab(AVRULE_ALLOWED)) return -1; }
> @@ -488,6 +490,9 @@ xperm_auditallow_def	: AUDITALLOWXPERM names names ':' names identifier xperms '
>  xperm_dontaudit_def	: DONTAUDITXPERM names names ':' names identifier xperms ';'
>  			{if (define_te_avtab_extended_perms(AVRULE_XPERMS_DONTAUDIT)) return -1; }
>  		        ;
> +xperm_neverallow_def	: NEVERALLOWXPERM names names ':' names identifier xperms ';'
> +			{if (define_te_avtab_extended_perms(AVRULE_XPERMS_NEVERALLOW)) return -1; }
> +		        ;
>  attribute_role_def	: ATTRIBUTE_ROLE identifier ';'
>  			{if (define_attrib_role()) return -1; }
>  		        ;
> diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> index e94a917..22da338 100644
> --- a/checkpolicy/policy_scan.l
> +++ b/checkpolicy/policy_scan.l
> @@ -143,11 +143,13 @@ auditdeny		        { return(AUDITDENY); }
>  DONTAUDIT |
>  dontaudit                       { return(DONTAUDIT); }
>  ALLOWXPERM |
> -allowxperm		        { return(ALLOWXPERM); }
> +allowxperm			{ return(ALLOWXPERM); }
>  AUDITALLOWXPERM |
> -auditallowxperm		        { return(AUDITALLOWXPERM); }
> +auditallowxperm			{ return(AUDITALLOWXPERM); }
>  DONTAUDITXPERM |
> -dontauditxperm                  { return(DONTAUDITXPERM); }
> +dontauditxperm			{ return(DONTAUDITXPERM); }
> +NEVERALLOWXPERM |
> +neverallowxperm			{ return(NEVERALLOWXPERM); }
>  SOURCE |
>  source			        { return(SOURCE); }
>  TARGET |
> diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
> index 0c6b8d8..86f5688 100644
> --- a/checkpolicy/test/dispol.c
> +++ b/checkpolicy/test/dispol.c
> @@ -54,65 +54,6 @@ int render_access_mask(uint32_t mask, avtab_key_t * key, policydb_t * p,
>  	return 0;
>  }
>  
> -#define xperms_test(x, p) (1 & (p[x >> 5] >> (x & 0x1f)))
> -#define next_bit_in_range(i, p) \
> -	((i + 1 < sizeof(p)*8) && xperms_test((i + 1), p))
> -
> -int render_ioctl(avtab_extended_perms_t * xperms, FILE * fp)
> -{
> -	uint16_t value;
> -	uint16_t low_bit;
> -	uint16_t low_value;
> -	unsigned int bit;
> -	unsigned int in_range = 0;
> -
> -	fprintf(fp, "{ ");
> -	for (bit = 0; bit < sizeof(xperms->perms)*8; bit++) {
> -		if (!xperms_test(bit, xperms->perms))
> -			continue;
> -
> -		if (in_range && next_bit_in_range(bit, xperms->perms)) {
> -			/* continue until high value found */
> -			continue;
> -		} else if (next_bit_in_range(bit, xperms->perms)) {
> -			/* low value */
> -			low_bit = bit;
> -			in_range = 1;
> -			continue;
> -		}
> -
> -		if (xperms->specified & AVTAB_XPERMS_IOCTLFUNCTION) {
> -			value = xperms->driver<<8 | bit;
> -			low_value = xperms->driver<<8 | low_bit;
> -			if (in_range)
> -				fprintf(fp, "0x%hx-0x%hx ", low_value, value);
> -			else
> -				fprintf(fp, "0x%hx ", value);
> -		} else if (xperms->specified & AVTAB_XPERMS_IOCTLDRIVER) {
> -			value = bit << 8;
> -			low_value = low_bit << 8;
> -			if (in_range)
> -				fprintf(fp, "0x%hx-0x%hx ", low_value, (uint16_t) (value|0xff));
> -			else
> -				fprintf(fp, "0x%hx-0x%hx ", value, (uint16_t) (value|0xff));
> -
> -		}
> -		if (in_range)
> -			in_range = 0;
> -	}
> -	fprintf(fp, "}");
> -	return 0;
> -}
> -
> -int render_xperms(avtab_extended_perms_t * xperms, FILE * fp)
> -{
> -	if ((xperms->specified == AVTAB_XPERMS_IOCTLFUNCTION) ||
> -			(xperms->specified == AVTAB_XPERMS_IOCTLDRIVER))
> -		render_ioctl(xperms, fp);
> -
> -	return 0;
> -}
> -
>  int render_type(uint32_t type, policydb_t * p, FILE * fp)
>  {
>  	fprintf(fp, "%s", p->p_type_val_to_name[type - 1]);
> @@ -214,8 +155,7 @@ int render_av_rule(avtab_key_t * key, avtab_datum_t * datum, uint32_t what,
>  		else if (key->specified & AVTAB_XPERMS_DONTAUDIT)
>  			fprintf(fp, "dontauditxperm ");
>  		render_key(key, p, fp);
> -		render_xperms(datum->xperms, fp);
> -		fprintf(fp, ";\n");
> +		fprintf(fp, "%s;\n", sepol_extended_perms_to_string(datum->xperms));
>  	} else {
>  		fprintf(fp, "     ERROR: no valid rule type specified\n");
>  		return -1;
> diff --git a/libsepol/include/sepol/policydb/avtab.h b/libsepol/include/sepol/policydb/avtab.h
> index 14bc082..d3ea84e 100644
> --- a/libsepol/include/sepol/policydb/avtab.h
> +++ b/libsepol/include/sepol/policydb/avtab.h
> @@ -62,6 +62,7 @@ typedef struct avtab_key {
>  #define AVTAB_XPERMS_ALLOWED	0x0100
>  #define AVTAB_XPERMS_AUDITALLOW	0x0200
>  #define AVTAB_XPERMS_DONTAUDIT	0x0400
> +#define AVTAB_XPERMS_NEVERALLOW	0x0800
>  #define AVTAB_XPERMS		(AVTAB_XPERMS_ALLOWED | AVTAB_XPERMS_AUDITALLOW | AVTAB_XPERMS_DONTAUDIT)
>  #define AVTAB_ENABLED_OLD	0x80000000
>  #define AVTAB_ENABLED		0x8000	/* reserved for used in cond_avtab */
> diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
> index 5da016b..26cec13 100644
> --- a/libsepol/include/sepol/policydb/policydb.h
> +++ b/libsepol/include/sepol/policydb/policydb.h
> @@ -241,13 +241,18 @@ typedef struct class_perm_node {
>  	struct class_perm_node *next;
>  } class_perm_node_t;
>  
> +#define xperm_test(x, p) (1 & (p[x >> 5] >> (x & 0x1f)))
> +#define xperm_set(x, p) (p[x >> 5] |= (1 << (x & 0x1f)))
> +#define xperm_clear(x, p) (p[x >> 5] &= ~(1 << (x & 0x1f)))
> +#define EXTENDED_PERMS_LEN 8
> +
>  typedef struct av_extended_perms {
>  #define AVRULE_XPERMS_IOCTLFUNCTION	0x01
>  #define AVRULE_XPERMS_IOCTLDRIVER	0x02
>  	uint8_t specified;
>  	uint8_t driver;
>  	/* 256 bits of permissions */
> -	uint32_t perms[8];
> +	uint32_t perms[EXTENDED_PERMS_LEN];
>  } av_extended_perms_t;
>  
>  typedef struct avrule {
> @@ -266,8 +271,9 @@ typedef struct avrule {
>  #define AVRULE_XPERMS_ALLOWED 		0x0100
>  #define AVRULE_XPERMS_AUDITALLOW	0x0200
>  #define AVRULE_XPERMS_DONTAUDIT		0x0400
> +#define AVRULE_XPERMS_NEVERALLOW	0x0800
>  #define AVRULE_XPERMS	(AVRULE_XPERMS_ALLOWED | AVRULE_XPERMS_AUDITALLOW | \
> -				AVRULE_XPERMS_DONTAUDIT)
> +				AVRULE_XPERMS_DONTAUDIT | AVRULE_XPERMS_NEVERALLOW)
>  	uint32_t specified;
>  #define RULE_SELF 1
>  	uint32_t flags;
> diff --git a/libsepol/include/sepol/policydb/util.h b/libsepol/include/sepol/policydb/util.h
> index cb97ccf..fa12661 100644
> --- a/libsepol/include/sepol/policydb/util.h
> +++ b/libsepol/include/sepol/policydb/util.h
> @@ -32,6 +32,8 @@ extern int add_i_to_a(uint32_t i, uint32_t * cnt, uint32_t ** a);
>  extern char *sepol_av_to_string(policydb_t * policydbp, uint32_t tclass,
>  				sepol_access_vector_t av);
>  
> +char *sepol_extended_perms_to_string(avtab_extended_perms_t *xperms);
> +
>  /*
>   * The tokenize function may be used to
>   * replace sscanf
> diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
> index d9afbde..5aec658 100644
> --- a/libsepol/src/assertion.c
> +++ b/libsepol/src/assertion.c
> @@ -1,8 +1,8 @@
>  /* Authors: Joshua Brindle <jbrindle@tresys.com>
> - *              
> - * Assertion checker for avtab entries, taken from 
> + *
> + * Assertion checker for avtab entries, taken from
>   * checkpolicy.c by Stephen Smalley <sds@tycho.nsa.gov>
> - *              
> + *
>   * Copyright (C) 2005 Tresys Technology, LLC
>   *
>   *  This library is free software; you can redistribute it and/or
> @@ -25,12 +25,14 @@
>  #include <sepol/policydb/expand.h>
>  #include <sepol/policydb/util.h>
>  
> +#include "private.h"
>  #include "debug.h"
>  
>  struct avtab_match_args {
>  	sepol_handle_t *handle;
>  	policydb_t *p;
>  	avrule_t *avrule;
> +	avtab_t *avtab;
>  	unsigned long errors;
>  };
>  
> @@ -73,6 +75,125 @@ static int match_any_class_permissions(class_perm_node_t *cp, uint32_t class, ui
>  	return 1;
>  }
>  
> +static int extended_permissions_and(uint32_t *perms1, uint32_t *perms2) {
> +	size_t i;
> +	for (i = 0; i < EXTENDED_PERMS_LEN; i++) {
> +		if (perms1[i] & perms2[i])
> +			return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int check_extended_permissions(av_extended_perms_t *neverallow, avtab_extended_perms_t *allow)
> +{
> +	int rc = 0;
> +	if ((neverallow->specified == AVRULE_XPERMS_IOCTLFUNCTION)
> +			&& (allow->specified == AVTAB_XPERMS_IOCTLFUNCTION)) {
> +		if (neverallow->driver == allow->driver)
> +			rc = extended_permissions_and(neverallow->perms, allow->perms);
> +	} else if ((neverallow->specified == AVRULE_XPERMS_IOCTLFUNCTION)
> +			&& (allow->specified == AVTAB_XPERMS_IOCTLDRIVER)) {
> +		rc = xperm_test(neverallow->driver, allow->perms);
> +	} else if ((neverallow->specified == AVRULE_XPERMS_IOCTLDRIVER)
> +			&& (allow->specified == AVTAB_XPERMS_IOCTLFUNCTION)) {
> +		rc = xperm_test(allow->driver, neverallow->perms);
> +	} else if ((neverallow->specified == AVRULE_XPERMS_IOCTLDRIVER)
> +			&& (allow->specified == AVTAB_XPERMS_IOCTLDRIVER)) {
> +		rc = extended_permissions_and(neverallow->perms, allow->perms);
> +	}
> +
> +	return rc;
> +}
> +
> +/* Compute which allowed extended permissions violate the neverallow rule */
> +static void extended_permissions_violated(avtab_extended_perms_t *result,
> +					av_extended_perms_t *neverallow,
> +					avtab_extended_perms_t *allow)
> +{
> +	size_t i;
> +	if ((neverallow->specified == AVRULE_XPERMS_IOCTLFUNCTION)
> +			&& (allow->specified == AVTAB_XPERMS_IOCTLFUNCTION)) {
> +		result->specified = AVTAB_XPERMS_IOCTLFUNCTION;
> +		result->driver = allow->driver;
> +		for (i = 0; i < EXTENDED_PERMS_LEN; i++)
> +			result->perms[i] = neverallow->perms[i] & allow->perms[i];
> +	} else if ((neverallow->specified == AVRULE_XPERMS_IOCTLFUNCTION)
> +			&& (allow->specified == AVTAB_XPERMS_IOCTLDRIVER)) {
> +		result->specified = AVTAB_XPERMS_IOCTLFUNCTION;
> +		result->driver = neverallow->driver;
> +		memcpy(result->perms, neverallow->perms, sizeof(result->perms));
> +	} else if ((neverallow->specified == AVRULE_XPERMS_IOCTLDRIVER)
> +			&& (allow->specified == AVTAB_XPERMS_IOCTLFUNCTION)) {
> +		result->specified = AVTAB_XPERMS_IOCTLFUNCTION;
> +		result->driver = allow->driver;
> +		memcpy(result->perms, allow->perms, sizeof(result->perms));
> +	} else if ((neverallow->specified == AVRULE_XPERMS_IOCTLDRIVER)
> +			&& (allow->specified == AVTAB_XPERMS_IOCTLDRIVER)) {
> +		result->specified = AVTAB_XPERMS_IOCTLDRIVER;
> +		for (i = 0; i < EXTENDED_PERMS_LEN; i++)
> +			result->perms[i] = neverallow->perms[i] & allow->perms[i];
> +	}
> +}
> +
> +/* Same scenarios of interest as check_assertion_extended_permissions */
> +static int report_assertion_extended_permissions(sepol_handle_t *handle,
> +				policydb_t *p, const avrule_t *avrule,
> +				unsigned int stype, unsigned int ttype,
> +				const class_perm_node_t *curperm, uint32_t perms,
> +				avtab_key_t *k, avtab_t *avtab)
> +{
> +	avtab_ptr_t node;
> +	avtab_key_t tmp_key;
> +	avtab_extended_perms_t *xperms;
> +	avtab_extended_perms_t error;
> +	int rc = 1;
> +	int ret = 0;
> +
> +	memcpy(&tmp_key, k, sizeof(avtab_key_t));
> +	tmp_key.specified = AVTAB_XPERMS_ALLOWED;
> +
> +	for (node = avtab_search_node(avtab, &tmp_key);
> +	     node;
> +	     node = avtab_search_node_next(node, tmp_key.specified)) {
> +		xperms = node->datum.xperms;
> +		if ((xperms->specified != AVTAB_XPERMS_IOCTLFUNCTION)
> +				&& (xperms->specified != AVTAB_XPERMS_IOCTLDRIVER))
> +			continue;
> +
> +		rc = check_extended_permissions(avrule->xperms, xperms);
> +		/* failure on the extended permission check_extended_permissionss */
> +		if (rc) {
> +			extended_permissions_violated(&error, avrule->xperms, xperms);
> +			ERR(handle, "neverallowxperm on line %lu of %s (or line %lu of policy.conf) violated by\n"
> +					"allowxperm %s %s:%s %s;",
> +					avrule->source_line, avrule->source_filename, avrule->line,
> +					p->p_type_val_to_name[stype],
> +					p->p_type_val_to_name[ttype],
> +					p->p_class_val_to_name[curperm->tclass - 1],
> +					sepol_extended_perms_to_string(&error));
> +
> +			rc = 0;
> +			ret++;
> +		}
> +
> +	}
> +
> +	/* failure on the regular permissions */
> +	if (rc) {
> +		ERR(handle, "neverallowxperm on line %lu of %s (or line %lu of policy.conf) violated by\n"
> +				"allow %s %s:%s {%s };",
> +				avrule->source_line, avrule->source_filename, avrule->line,
> +				p->p_type_val_to_name[stype],
> +				p->p_type_val_to_name[ttype],
> +				p->p_class_val_to_name[curperm->tclass - 1],
> +				sepol_av_to_string(p, curperm->tclass, perms));
> +		ret++;
> +
> +	}
> +
> +	return ret;
> +}
>  
>  static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void *args)
>  {
> @@ -80,6 +201,7 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
>  	struct avtab_match_args *a = (struct avtab_match_args *)args;
>  	sepol_handle_t *handle = a->handle;
>  	policydb_t *p = a->p;
> +	avtab_t *avtab = a->avtab;
>  	avrule_t *avrule = a->avrule;
>  	class_perm_node_t *cp;
>  	uint32_t perms;
> @@ -122,6 +244,7 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
>  		goto exit;
>  
>  	for (cp = avrule->perms; cp; cp = cp->next) {
> +
>  		perms = cp->data & d->data;
>  		if ((cp->tclass != k->target_class) || !perms) {
>  			continue;
> @@ -133,12 +256,17 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
>  			ebitmap_for_each_bit(&tgt_matches, tnode, j) {
>  				if (!ebitmap_node_get_bit(tnode, j))
>  					continue;
> -				a->errors++;
> -				report_failure(handle, p, avrule, i, j, cp, perms);
> +
> +				if (avrule->specified == AVRULE_XPERMS_NEVERALLOW) {
> +					a->errors += report_assertion_extended_permissions(handle,p, avrule,
> +											i, j, cp, perms, k, avtab);
> +				} else {
> +					a->errors++;
> +					report_failure(handle, p, avrule, i, j, cp, perms);
> +				}
>  			}
>  		}
>  	}
> -
>  	goto exit;
>  
>  oom:
> @@ -175,12 +303,57 @@ oom:
>  	return rc;
>  }
>  
> +/*
> + * If the ioctl permission is granted in check_assertion_avtab_match for the
> + * source/target/class matching the current avrule neverallow, a lookup is
> + * performed to determine if extended permissions exist for the source/target/class.
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
> +						avtab_key_t *k)
> +{
> +	avtab_ptr_t node;
> +	avtab_key_t tmp_key;
> +	avtab_extended_perms_t *xperms;
> +	av_extended_perms_t *neverallow_xperms = avrule->xperms;
> +	int rc = 1;
> +
> +	memcpy(&tmp_key, k, sizeof(avtab_key_t));
> +	tmp_key.specified = AVTAB_XPERMS_ALLOWED;
> +
> +	for (node = avtab_search_node(avtab, &tmp_key);
> +	     node;
> +	     node = avtab_search_node_next(node, tmp_key.specified)) {
> +		xperms = node->datum.xperms;
> +		if ((xperms->specified != AVTAB_XPERMS_IOCTLFUNCTION)
> +				&& (xperms->specified != AVTAB_XPERMS_IOCTLDRIVER))
> +			continue;
> +
> +		rc = check_extended_permissions(neverallow_xperms, xperms);
> +		if (rc)
> +			break;
> +	}
> +
> +	return rc;
> +}
> +
> +
>  static int check_assertion_avtab_match(avtab_key_t *k, avtab_datum_t *d, void *args)
>  {
>  	int rc;
>  	struct avtab_match_args *a = (struct avtab_match_args *)args;
>  	policydb_t *p = a->p;
>  	avrule_t *avrule = a->avrule;
> +	avtab_t *avtab = a->avtab;
>  
>  	if (k->specified != AVTAB_ALLOWED)
>  		goto exit;
> @@ -212,6 +385,11 @@ static int check_assertion_avtab_match(avtab_key_t *k, avtab_datum_t *d, void *a
>  	if (rc == 0)
>  		goto exit;
>  
> +	if (avrule->specified == AVRULE_XPERMS_NEVERALLOW) {
> +		rc = check_assertion_extended_permissions(avrule, avtab, k);
> +		if (rc == 0)
> +			goto exit;
> +	}
>  	return 1;
>  
>  exit:
> @@ -231,10 +409,12 @@ int check_assertion(policydb_t *p, avrule_t *avrule)
>  	args.p = p;
>  	args.avrule = avrule;
>  	args.errors = 0;
> +	args.avtab = &p->te_avtab;
>  
>  	rc = avtab_map(&p->te_avtab, check_assertion_avtab_match, &args);
>  
>  	if (rc == 0) {
> +		args.avtab = &p->te_cond_avtab;
>  		rc = avtab_map(&p->te_cond_avtab, check_assertion_avtab_match, &args);
>  	}
>  
> @@ -256,7 +436,7 @@ int check_assertions(sepol_handle_t * handle, policydb_t * p,
>  	}
>  
>  	for (a = avrules; a != NULL; a = a->next) {
> -		if (!(a->specified & AVRULE_NEVERALLOW))
> +		if (!(a->specified & (AVRULE_NEVERALLOW | AVRULE_XPERMS_NEVERALLOW)))
>  			continue;
>  		rc = check_assertion(p, a);
>  		if (rc) {
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 7b99f40..9047c6d 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -1948,6 +1948,8 @@ static int convert_and_expand_rule(sepol_handle_t * handle,
>  
>  	if (!do_neverallow && source_rule->specified & AVRULE_NEVERALLOW)
>  		return EXPAND_RULE_SUCCESS;
> +	if (source_rule->specified & AVRULE_XPERMS_NEVERALLOW)
> +		return EXPAND_RULE_SUCCESS;
>  
>  	ebitmap_init(&stypes);
>  	ebitmap_init(&ttypes);
> @@ -2378,7 +2380,8 @@ int expand_rule(sepol_handle_t * handle,
>  	int retval;
>  	ebitmap_t stypes, ttypes;
>  
> -	if (source_rule->specified & AVRULE_NEVERALLOW)
> +	if ((source_rule->specified & AVRULE_NEVERALLOW)
> +		|| (source_rule->specified & AVRULE_XPERMS_NEVERALLOW))
>  		return 1;
>  
>  	ebitmap_init(&stypes);
> @@ -2592,6 +2595,7 @@ static int copy_neverallow(policydb_t * dest_pol, uint32_t * typemap,
>  	ebitmap_t stypes, ttypes;
>  	avrule_t *avrule;
>  	class_perm_node_t *cur_perm, *new_perm, *tail_perm;
> +	av_extended_perms_t *xperms = NULL;
>  
>  	ebitmap_init(&stypes);
>  	ebitmap_init(&ttypes);
> @@ -2608,7 +2612,7 @@ static int copy_neverallow(policydb_t * dest_pol, uint32_t * typemap,
>  		return -1;
>  
>  	avrule_init(avrule);
> -	avrule->specified = AVRULE_NEVERALLOW;
> +	avrule->specified = source_rule->specified;
>  	avrule->line = source_rule->line;
>  	avrule->flags = source_rule->flags;
>  	avrule->source_line = source_rule->source_line;
> @@ -2647,6 +2651,15 @@ static int copy_neverallow(policydb_t * dest_pol, uint32_t * typemap,
>  		cur_perm = cur_perm->next;
>  	}
>  
> +	/* copy over extended permissions */
> +	if (source_rule->xperms) {
> +		xperms = calloc(1, sizeof(av_extended_perms_t));
> +		if (!xperms)
> +			goto err;
> +		memcpy(xperms, source_rule->xperms, sizeof(av_extended_perms_t));
> +		avrule->xperms = xperms;
> +	}
> +
>  	/* just prepend the avrule to the first branch; it'll never be
>  	   written to disk */
>  	if (!dest_pol->global->branch_list->avrules)
> @@ -2672,6 +2685,7 @@ static int copy_neverallow(policydb_t * dest_pol, uint32_t * typemap,
>  		free(cur_perm);
>  		cur_perm = tail_perm;
>  	}
> +	free(xperms);
>  	free(avrule);
>  	return -1;
>  }
> @@ -2724,16 +2738,15 @@ static int copy_and_expand_avrule_block(expand_state_t * state)
>  		cur_avrule = decl->avrules;
>  		while (cur_avrule != NULL) {
>  			if (!(state->expand_neverallow)
> -			    && cur_avrule->specified & AVRULE_NEVERALLOW) {
> +			    && cur_avrule->specified & (AVRULE_NEVERALLOW | AVRULE_XPERMS_NEVERALLOW)) {
>  				/* copy this over directly so that assertions are checked later */
>  				if (copy_neverallow
>  				    (state->out, state->typemap, cur_avrule))
>  					ERR(state->handle,
>  					    "Error while copying neverallow.");
>  			} else {
> -				if (cur_avrule->specified & AVRULE_NEVERALLOW) {
> +				if (cur_avrule->specified & (AVRULE_NEVERALLOW | AVRULE_XPERMS_NEVERALLOW))
>  					state->out->unsupported_format = 1;
> -				}
>  				if (convert_and_expand_rule
>  				    (state->handle, state->out, state->typemap,
>  				     cur_avrule, &state->out->te_avtab, NULL,
> diff --git a/libsepol/src/util.c b/libsepol/src/util.c
> index 6e285d5..ff8f7f2 100644
> --- a/libsepol/src/util.c
> +++ b/libsepol/src/util.c
> @@ -119,6 +119,78 @@ char *sepol_av_to_string(policydb_t * policydbp, uint32_t tclass,
>  	return avbuf;
>  }
>  
> +#define next_bit_in_range(i, p) ((i + 1 < sizeof(p)*8) && xperm_test((i + 1), p))
> +
> +char *sepol_extended_perms_to_string(avtab_extended_perms_t *xperms)
> +{
> +	uint16_t value;
> +	uint16_t low_bit;
> +	uint16_t low_value;
> +	unsigned int bit;
> +	unsigned int in_range = 0;
> +	static char xpermsbuf[2048];
> +	xpermsbuf[0] = '\0';
> +	char *p;
> +	int len, xpermslen = 0;
> +	p = xpermsbuf;
> +
> +	if ((xperms->specified != AVTAB_XPERMS_IOCTLFUNCTION)
> +		&& (xperms->specified != AVTAB_XPERMS_IOCTLDRIVER))
> +		return NULL;
> +
> +	len = snprintf(p, sizeof(xpermsbuf) - xpermslen, "ioctl { ");
> +	p += len;
> +	xpermslen += len;
> +
> +	for (bit = 0; bit < sizeof(xperms->perms)*8; bit++) {
> +		if (!xperm_test(bit, xperms->perms))
> +			continue;
> +
> +		if (in_range && next_bit_in_range(bit, xperms->perms)) {
> +			/* continue until high value found */
> +			continue;
> +		} else if (next_bit_in_range(bit, xperms->perms)) {
> +			/* low value */
> +			low_bit = bit;
> +			in_range = 1;
> +			continue;
> +		}
> +
> +		if (xperms->specified & AVTAB_XPERMS_IOCTLFUNCTION) {
> +			value = xperms->driver<<8 | bit;
> +			low_value = xperms->driver<<8 | low_bit;
> +			if (in_range) {
> +				len = snprintf(p, sizeof(xpermsbuf) - xpermslen, "0x%hx-0x%hx ", low_value, value);
> +			} else {
> +				len = snprintf(p, sizeof(xpermsbuf) - xpermslen, "0x%hx ", value);
> +			}
> +		} else if (xperms->specified & AVTAB_XPERMS_IOCTLDRIVER) {
> +			value = bit << 8;
> +			low_value = low_bit << 8;
> +			if (in_range) {
> +				len = snprintf(p, sizeof(xpermsbuf) - xpermslen, "0x%hx-0x%hx ", low_value, (uint16_t) (value|0xff));
> +			} else {
> +				len = snprintf(p, sizeof(xpermsbuf) - xpermslen, "0x%hx-0x%hx ", value, (uint16_t) (value|0xff));
> +			}
> +
> +		}
> +
> +		if (len < 0 || (size_t) len >= (sizeof(xpermsbuf) - xpermslen))
> +			return NULL;
> +
> +		p += len;
> +		xpermslen += len;
> +		if (in_range)
> +			in_range = 0;
> +	}
> +
> +	len = snprintf(p, sizeof(xpermsbuf) - xpermslen, "}");
> +	if (len < 0 || (size_t) len >= (sizeof(xpermsbuf) - xpermslen))
> +		return NULL;
> +
> +	return xpermsbuf;
> +}
> +
>  /*
>   * The tokenize and tokenize_str functions may be used to
>   * replace sscanf to read tokens from buffers.
> 
