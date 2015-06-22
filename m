Message-ID: <5587FC1E.6010404@tresys.com>
Date: Mon, 22 Jun 2015 08:14:22 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: James Carter <jwcart2@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 06/10 v3] libsepol/cil: Refactored CIL neverallow checking
 and reporting.
References: <1434737956-17932-1-git-send-email-jwcart2@tycho.nsa.gov>
 <1434737956-17932-7-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1434737956-17932-7-git-send-email-jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/19/2015 02:19 PM, James Carter wrote:
> Use the libsepol neverallow checking to determine if a given neverallow
> rule is violated. If a violation is found, use the function
> cil_find_matching_avrule_in_ast() to find the AST node of the particular
> rule that violates the neverallow. This allows CIL to provide a more
> informative error message that includes the file and line number of the
> node and all of its parents.
> 
> Example error report:
> Neverallow check failed at line 31285 of cil.conf.neverallow
>   (neverallow typeset4 self (memprotect (mmap_zero)))
>     <root>
>     booleanif at line 152094 of cil.conf.neverallow
>     true at line 152095 of cil.conf.neverallow
>     allow at line 152096 of cil.conf.neverallow
>       (allow ada_t self (memprotect (mmap_zero)))
> 
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>

Acked-by: Steve Lawrence <slawrence@tresys.com>

> ---
>  libsepol/cil/src/cil_binary.c | 492 ++++++++++++++++++++++++++++--------------
>  libsepol/cil/src/cil_binary.h |   4 +-
>  2 files changed, 330 insertions(+), 166 deletions(-)
> 
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index 03f4924..fd5983a 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -37,6 +37,8 @@
>  #include <sepol/policydb/conditional.h>
>  #include <sepol/policydb/constraint.h>
>  #include <sepol/policydb/flask.h>
> +#include <sepol/policydb/expand.h>
> +#include <sepol/policydb/hierarchy.h>
>  
>  #include "cil_internal.h"
>  #include "cil_flavor.h"
> @@ -45,6 +47,7 @@
>  #include "cil_tree.h"
>  #include "cil_binary.h"
>  #include "cil_symtab.h"
> +#include "cil_find.h"
>  
>  /* There are 44000 filename_trans in current fedora policy. 1.33 times this is the recommended
>   * size of a hashtable. The next power of 2 of this is 2 ** 16.
> @@ -68,39 +71,9 @@ struct cil_args_booleanif {
>  	policydb_t *pdb;
>  	cond_node_t *cond_node;
>  	enum cil_flavor cond_flavor;
> -	struct cil_list *neverallows;
>  	hashtab_t filename_trans_table;
>  };
>  
> -struct cil_neverallow {
> -	struct cil_tree_node *node;
> -	struct cil_list *rules;
> -};
> -
> -struct cil_neverallow_rule {
> -	struct cil_symtab_datum *src;
> -	struct cil_symtab_datum *tgt;
> -	uint32_t class;
> -	uint32_t perms;
> -};
> -
> -void cil_neverallows_list_destroy(struct cil_list *neverallows)
> -{
> -	struct cil_list_item *i;
> -	struct cil_list_item *j;
> -
> -	cil_list_for_each(i, neverallows) {
> -		struct cil_neverallow *neverallow = i->data;
> -		cil_list_for_each(j, neverallow->rules) {
> -			struct cil_neverallow_rule *rule = j->data;
> -			free(rule);
> -		}
> -		cil_list_destroy(&neverallow->rules, CIL_FALSE);
> -		free(neverallow);
> -	}
> -	cil_list_destroy(&neverallows, CIL_FALSE);
> -}
> -
>  static int __cil_get_sepol_user_datum(policydb_t *pdb, struct cil_symtab_datum *datum, user_datum_t **sepol_user)
>  {
>  	*sepol_user = hashtab_search(pdb->p_users.table, datum->fqn);
> @@ -628,14 +601,21 @@ int __cil_typeattr_bitmap_init(policydb_t *pdb)
>  	int rc = SEPOL_ERR;
>  
>  	pdb->type_attr_map = cil_malloc(pdb->p_types.nprim * sizeof(ebitmap_t));
> +	pdb->attr_type_map = cil_malloc(pdb->p_types.nprim * sizeof(ebitmap_t));
>  
>  	uint32_t i = 0;
>  	for (i = 0; i < pdb->p_types.nprim; i++) {
>  		ebitmap_init(&pdb->type_attr_map[i]);
> +		ebitmap_init(&pdb->attr_type_map[i]);
>  		if (ebitmap_set_bit(&pdb->type_attr_map[i], i, 1)) {
>  			rc = SEPOL_ERR;
>  			goto exit;
>  		}
> +		if (ebitmap_set_bit(&pdb->attr_type_map[i], i, 1)) {
> +			rc = SEPOL_ERR;
> +			goto exit;
> +		}
> +
>  	}
>  
>  	return SEPOL_OK;
> @@ -675,6 +655,7 @@ int cil_typeattribute_to_bitmap(policydb_t *pdb, const struct cil_db *db, struct
>  		if (rc != SEPOL_OK) goto exit;
>  
>  		ebitmap_set_bit(&pdb->type_attr_map[sepol_type->s.value - 1], value - 1, 1);
> +		ebitmap_set_bit(&pdb->attr_type_map[value - 1], sepol_type->s.value - 1, 1);
>  	}
>  
>  	rc = SEPOL_OK;
> @@ -1324,89 +1305,7 @@ exit:
>  	return rc;
>  }
>  
> -static void __cil_neverallow_handle(struct cil_list *neverallows, struct cil_symtab_datum *src, struct cil_symtab_datum *tgt, uint32_t class, uint32_t perms)
> -{
> -	struct cil_neverallow *neverallow = neverallows->head->data;
> -	struct cil_list *neverallow_rules = neverallow->rules;
> -	struct cil_neverallow_rule *new = NULL;
> -
> -	new = cil_malloc(sizeof(*new));
> -	new->src = src;
> -	new->tgt = tgt;
> -	new->class = class;
> -	new->perms = perms;
> -
> -	cil_list_append(neverallow_rules, CIL_LIST_ITEM, new);
> -}
> -
> -static int __cil_is_type_match(enum cil_flavor f1, struct cil_symtab_datum *t1, enum cil_flavor f2, struct cil_symtab_datum *t2)
> -{
> -	if (t1->fqn == t2->fqn) {
> -		return CIL_TRUE;
> -	} else if (f1 == CIL_TYPEATTRIBUTE && f2 != CIL_TYPEATTRIBUTE) {
> -		struct cil_typeattribute *a = (struct cil_typeattribute *)t1;
> -		struct cil_type *t = (struct cil_type *)t2;
> -		if (ebitmap_get_bit(a->types, t->value)) {
> -			return CIL_TRUE;
> -		}
> -	} else if (f1 != CIL_TYPEATTRIBUTE && f2 == CIL_TYPEATTRIBUTE) {
> -		struct cil_typeattribute *a = (struct cil_typeattribute *)t2;
> -		struct cil_type *t = (struct cil_type *)t1;
> -		if (ebitmap_get_bit(a->types, t->value)) {
> -			return CIL_TRUE;
> -		}
> -	} else if (f1 == CIL_TYPEATTRIBUTE && f2 == CIL_TYPEATTRIBUTE) {
> -		struct cil_typeattribute *a1 = (struct cil_typeattribute *)t2;
> -		struct cil_typeattribute *a2 = (struct cil_typeattribute *)t1;
> -		/* abusing the ebitmap abstraction for speed */
> -		ebitmap_node_t *n1 = a1->types->node;
> -		ebitmap_node_t *n2 = a2->types->node;
> -		while (n1 && n2) {
> -			if (n1->startbit < n2->startbit) {
> -				n1 = n1->next;
> -			} else if (n2->startbit < n1->startbit) {
> -				n2 = n2->next;
> -			} else {
> -				if (n1->map & n2->map) {
> -					return CIL_TRUE;
> -				}
> -				n1 = n1->next;
> -				n2 = n2->next;
> -			}
> -		}
> -	}
> -	return CIL_FALSE;
> -}
> -
> -static int __cil_check_neverallows(struct cil_list *neverallows, struct cil_symtab_datum *src, struct cil_symtab_datum *tgt, uint32_t class, uint32_t perms)
> -{
> -	struct cil_list_item *curr = NULL;
> -	enum cil_flavor al_src_flavor = ((struct cil_tree_node*)src->nodes->head->data)->flavor;
> -	enum cil_flavor al_tgt_flavor = ((struct cil_tree_node*)tgt->nodes->head->data)->flavor;
> -	cil_list_for_each(curr, neverallows) {
> -		struct cil_neverallow *neverallow = curr->data;
> -		struct cil_tree_node *node = neverallow->node;
> -		struct cil_list_item *curr_item = NULL;
> -		cil_list_for_each(curr_item, neverallow->rules) {
> -			struct cil_neverallow_rule *curr_rule = curr_item->data;
> -			enum cil_flavor nv_src_flavor = ((struct cil_tree_node*)curr_rule->src->nodes->head->data)->flavor;
> -			enum cil_flavor nv_tgt_flavor = ((struct cil_tree_node*)curr_rule->tgt->nodes->head->data)->flavor;
> -			if ((curr_rule->perms & perms) && (class == curr_rule->class)) {
> -				int src_match = __cil_is_type_match(al_src_flavor, src, nv_src_flavor, curr_rule->src);
> -				if (src_match) {
> -					int tgt_match = __cil_is_type_match(al_tgt_flavor, tgt, nv_tgt_flavor, curr_rule->tgt);
> -					if (tgt_match) {
> -						cil_log(CIL_ERR, "Neverallow found that matches avrule at line %d of %s\n", node->line, node->path);
> -						return SEPOL_ERR;
> -					}
> -				}
> -			}
> -		}
> -	}
> -	return SEPOL_OK;
> -}
> -
> -int __cil_avrule_expand_helper(policydb_t *pdb, uint16_t kind, struct cil_symtab_datum *src, struct cil_symtab_datum *tgt, struct cil_classperms *cp, struct cil_list *neverallows, cond_node_t *cond_node, enum cil_flavor cond_flavor)
> +int __cil_avrule_expand_helper(policydb_t *pdb, uint16_t kind, struct cil_symtab_datum *src, struct cil_symtab_datum *tgt, struct cil_classperms *cp, cond_node_t *cond_node, enum cil_flavor cond_flavor)
>  {
>  	int rc = SEPOL_ERR;
>  	type_datum_t *sepol_src = NULL;
> @@ -1425,28 +1324,19 @@ int __cil_avrule_expand_helper(policydb_t *pdb, uint16_t kind, struct cil_symtab
>  		return SEPOL_OK;
>  	}
>  
> -	if (kind == CIL_AVRULE_NEVERALLOW) {
> -		__cil_neverallow_handle(neverallows, src, tgt, sepol_class->s.value, data);
> -	} else {
> -		if (kind == CIL_AVRULE_DONTAUDIT) {
> -			data = ~data;
> -		} else if (neverallows != NULL && kind == CIL_AVRULE_ALLOWED) {
> -			rc = __cil_check_neverallows(neverallows, src, tgt, sepol_class->s.value, data);
> -			if (rc != SEPOL_OK) {
> -				goto exit;
> -			}
> -		}
> +	if (kind == CIL_AVRULE_DONTAUDIT) {
> +		data = ~data;
> +	}
>  
> -		rc = __cil_get_sepol_type_datum(pdb, src, &sepol_src);
> -		if (rc != SEPOL_OK) goto exit;
> +	rc = __cil_get_sepol_type_datum(pdb, src, &sepol_src);
> +	if (rc != SEPOL_OK) goto exit;
>  
> -		rc = __cil_get_sepol_type_datum(pdb, tgt, &sepol_tgt);
> -		if (rc != SEPOL_OK) goto exit;
> +	rc = __cil_get_sepol_type_datum(pdb, tgt, &sepol_tgt);
> +	if (rc != SEPOL_OK) goto exit;
>  
> -		rc = __cil_insert_avrule(pdb, kind, sepol_src->s.value, sepol_tgt->s.value, sepol_class->s.value, data, cond_node, cond_flavor);
> -		if (rc != SEPOL_OK) {
> -			goto exit;
> -		}
> +	rc = __cil_insert_avrule(pdb, kind, sepol_src->s.value, sepol_tgt->s.value, sepol_class->s.value, data, cond_node, cond_flavor);
> +	if (rc != SEPOL_OK) {
> +		goto exit;
>  	}
>  
>  	return SEPOL_OK;
> @@ -1456,7 +1346,7 @@ exit:
>  }
>  
>  
> -int __cil_avrule_expand(policydb_t *pdb, uint16_t kind, struct cil_symtab_datum *src, struct cil_symtab_datum *tgt, struct cil_list *classperms, struct cil_list *neverallows, cond_node_t *cond_node, enum cil_flavor cond_flavor)
> +int __cil_avrule_expand(policydb_t *pdb, uint16_t kind, struct cil_symtab_datum *src, struct cil_symtab_datum *tgt, struct cil_list *classperms, cond_node_t *cond_node, enum cil_flavor cond_flavor)
>  {
>  	int rc = SEPOL_ERR;
>  	struct cil_list_item *curr;
> @@ -1465,7 +1355,7 @@ int __cil_avrule_expand(policydb_t *pdb, uint16_t kind, struct cil_symtab_datum
>  		if (curr->flavor == CIL_CLASSPERMS) {
>  			struct cil_classperms *cp = curr->data;
>  			if (FLAVOR(cp->class) == CIL_CLASS) {
> -				rc = __cil_avrule_expand_helper(pdb, kind, src, tgt, cp, neverallows, cond_node, cond_flavor);
> +				rc = __cil_avrule_expand_helper(pdb, kind, src, tgt, cp, cond_node, cond_flavor);
>  				if (rc != SEPOL_OK) {
>  					goto exit;
>  				}
> @@ -1473,7 +1363,7 @@ int __cil_avrule_expand(policydb_t *pdb, uint16_t kind, struct cil_symtab_datum
>  				struct cil_list_item *i = NULL;
>  				cil_list_for_each(i, cp->perms) {
>  					struct cil_perm *cmp = i->data;
> -					rc = __cil_avrule_expand(pdb, kind, src, tgt, cmp->classperms, neverallows, cond_node, cond_flavor);
> +					rc = __cil_avrule_expand(pdb, kind, src, tgt, cmp->classperms, cond_node, cond_flavor);
>  					if (rc != SEPOL_OK) {
>  						goto exit;
>  					}
> @@ -1482,7 +1372,7 @@ int __cil_avrule_expand(policydb_t *pdb, uint16_t kind, struct cil_symtab_datum
>  		} else { /* SET */
>  			struct cil_classperms_set *cp_set = curr->data;
>  			struct cil_classpermission *cp = cp_set->set;
> -			rc = __cil_avrule_expand(pdb, kind, src, tgt, cp->classperms, neverallows, cond_node, cond_flavor);
> +			rc = __cil_avrule_expand(pdb, kind, src, tgt, cp->classperms, cond_node, cond_flavor);
>  			if (rc != SEPOL_OK) {
>  				goto exit;
>  			}
> @@ -1495,7 +1385,7 @@ exit:
>  	return rc;
>  }
>  
> -int __cil_avrule_to_avtab(policydb_t *pdb, const struct cil_db *db, struct cil_avrule *cil_avrule, struct cil_list *neverallows, cond_node_t *cond_node, enum cil_flavor cond_flavor)
> +int __cil_avrule_to_avtab(policydb_t *pdb, const struct cil_db *db, struct cil_avrule *cil_avrule, cond_node_t *cond_node, enum cil_flavor cond_flavor)
>  {
>  	int rc = SEPOL_ERR;
>  	uint16_t kind = cil_avrule->rule_kind;
> @@ -1509,12 +1399,6 @@ int __cil_avrule_to_avtab(policydb_t *pdb, const struct cil_db *db, struct cil_a
>  		goto exit;
>  	}
>  
> -	if (cil_avrule->rule_kind == CIL_AVRULE_NEVERALLOW && db->disable_neverallow == CIL_TRUE) {
> -		// ignore neverallow rules
> -		rc = SEPOL_OK;
> -		goto exit;
> -	}
> -
>  	src = cil_avrule->src;
>  	tgt = cil_avrule->tgt;
>  
> @@ -1530,7 +1414,7 @@ int __cil_avrule_to_avtab(policydb_t *pdb, const struct cil_db *db, struct cil_a
>  			if (!ebitmap_get_bit(&type_bitmap, i)) continue;
>  
>  			src = DATUM(db->val_to_type[i]);
> -			rc = __cil_avrule_expand(pdb, kind, src, src, classperms, neverallows, cond_node, cond_flavor);
> +			rc = __cil_avrule_expand(pdb, kind, src, src, classperms, cond_node, cond_flavor);
>  			if (rc != SEPOL_OK) {
>  				ebitmap_destroy(&type_bitmap);
>  				goto exit;
> @@ -1538,7 +1422,7 @@ int __cil_avrule_to_avtab(policydb_t *pdb, const struct cil_db *db, struct cil_a
>  		}
>  		ebitmap_destroy(&type_bitmap);
>  	} else {
> -		rc = __cil_avrule_expand(pdb, kind, src, tgt, classperms, neverallows, cond_node, cond_flavor);
> +		rc = __cil_avrule_expand(pdb, kind, src, tgt, classperms, cond_node, cond_flavor);
>  		if (rc != SEPOL_OK) goto exit;
>  	}
>  
> @@ -1548,9 +1432,9 @@ exit:
>  	return rc;
>  }
>  
> -int cil_avrule_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_avrule *cil_avrule, struct cil_list *neverallows)
> +int cil_avrule_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_avrule *cil_avrule)
>  {
> -	return __cil_avrule_to_avtab(pdb, db, cil_avrule, neverallows, NULL, CIL_FALSE);
> +	return __cil_avrule_to_avtab(pdb, db, cil_avrule, NULL, CIL_FALSE);
>  }
>  
>  int __cil_cond_to_policydb_helper(struct cil_tree_node *node, __attribute__((unused)) uint32_t *finished, void *extra_args)
> @@ -1593,7 +1477,7 @@ int __cil_cond_to_policydb_helper(struct cil_tree_node *node, __attribute__((unu
>  		break;
>  	case CIL_AVRULE:
>  		cil_avrule = node->data;
> -		rc = __cil_avrule_to_avtab(pdb, db, cil_avrule, args->neverallows, cond_node, cond_flavor);
> +		rc = __cil_avrule_to_avtab(pdb, db, cil_avrule, cond_node, cond_flavor);
>  		if (rc != SEPOL_OK) {
>  			cil_log(CIL_ERR, "Failed to insert avrule into avtab at line %d of %s\n", node->line, node->path);
>  			goto exit;
> @@ -1762,7 +1646,7 @@ static int __cil_cond_expr_to_sepol_expr(policydb_t *pdb, struct cil_list *cil_e
>  	return SEPOL_OK;
>  }
>  
> -int cil_booleanif_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_tree_node *node, struct cil_list *neverallows, hashtab_t filename_trans_table)
> +int cil_booleanif_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_tree_node *node, hashtab_t filename_trans_table)
>  {
>  	int rc = SEPOL_ERR;
>  	struct cil_args_booleanif bool_args;
> @@ -1837,7 +1721,6 @@ int cil_booleanif_to_policydb(policydb_t *pdb, const struct cil_db *db, struct c
>  	bool_args.db = db;
>  	bool_args.pdb = pdb;
>  	bool_args.cond_node = cond_node;
> -	bool_args.neverallows = neverallows;
>  	bool_args.filename_trans_table = filename_trans_table;
>  
>  	if (true_node != NULL) {
> @@ -3202,17 +3085,9 @@ int __cil_node_to_policydb(struct cil_tree_node *node, void *extra_args)
>  			break;
>  		case CIL_AVRULE: {
>  			struct cil_avrule *rule = node->data;
> -			struct cil_list *neverallows = args->neverallows;
> -			if (rule->rule_kind == CIL_AVRULE_NEVERALLOW) {
> -				struct cil_neverallow *new_rule = NULL;
> -
> -				new_rule = cil_malloc(sizeof(*new_rule));
> -				cil_list_init(&new_rule->rules, CIL_LIST_ITEM);
> -				new_rule->node = node;
> -
> -				cil_list_prepend(neverallows, CIL_LIST_ITEM, new_rule);
> -
> -				rc = cil_avrule_to_policydb(pdb, db, node->data, neverallows);
> +			if (db->disable_neverallow != CIL_TRUE && rule->rule_kind == CIL_AVRULE_NEVERALLOW) {
> +				struct cil_list *neverallows = args->neverallows;
> +				cil_list_prepend(neverallows, CIL_LIST_ITEM, node);
>  			}
>  			break;
>  		}
> @@ -3261,12 +3136,12 @@ int __cil_node_to_policydb(struct cil_tree_node *node, void *extra_args)
>  	case 3:
>  		switch (node->flavor) {
>  		case CIL_BOOLEANIF:
> -			rc = cil_booleanif_to_policydb(pdb, db, node, args->neverallows, filename_trans_table);
> +			rc = cil_booleanif_to_policydb(pdb, db, node, filename_trans_table);
>  			break;
>  		case CIL_AVRULE: {
>  				struct cil_avrule *rule = node->data;
>  				if (rule->rule_kind != CIL_AVRULE_NEVERALLOW) {
> -					rc = cil_avrule_to_policydb(pdb, db, node->data, args->neverallows);
> +					rc = cil_avrule_to_policydb(pdb, db, node->data);
>  				}
>  			}
>  			break;
> @@ -3728,6 +3603,289 @@ exit:
>  	return rc;
>  }
>  
> +static void __cil_destroy_sepol_class_perms(class_perm_node_t *curr)
> +{
> +	class_perm_node_t *next;
> +
> +	while (curr) {
> +		next = curr->next;
> +		free(curr);
> +		curr = next;
> +	}
> +}
> +
> +static int __cil_rule_to_sepol_class_perms(policydb_t *pdb, struct cil_list *classperms, class_perm_node_t **sepol_class_perms)
> +{
> +	int rc = SEPOL_ERR;
> +	struct cil_list_item *i;
> +	cil_list_for_each(i, classperms) {
> +		if (i->flavor == CIL_CLASSPERMS) {
> +			struct cil_classperms *cp = i->data;
> +			if (FLAVOR(cp->class) == CIL_CLASS) {
> +				class_perm_node_t *cpn = NULL;
> +				class_datum_t *sepol_class = NULL;
> +				uint32_t data = 0;
> +
> +				rc = __cil_get_sepol_class_datum(pdb, DATUM(cp->class), &sepol_class);
> +				if (rc != SEPOL_OK) goto exit;
> +
> +				rc = __cil_perms_to_datum(cp->perms, sepol_class, &data);
> +				if (rc != SEPOL_OK) goto exit;
> +				if (data == 0) {
> +					/* No permissions */
> +					return SEPOL_OK;
> +				}
> +				cpn = cil_malloc(sizeof(class_perm_node_t));
> +				cpn->tclass = sepol_class->s.value;
> +				cpn->data = data;
> +				cpn->next = *sepol_class_perms;
> +				*sepol_class_perms = cpn;
> +			} else { /* MAP */
> +				struct cil_list_item *j = NULL;
> +				cil_list_for_each(j, cp->perms) {
> +					struct cil_perm *cmp = j->data;
> +					rc = __cil_rule_to_sepol_class_perms(pdb, cmp->classperms, sepol_class_perms);
> +					if (rc != SEPOL_OK) {
> +						goto exit;
> +					}
> +				}
> +			}
> +		} else { /* SET */
> +			struct cil_classperms_set *cp_set = i->data;
> +			struct cil_classpermission *cp = cp_set->set;
> +			rc = __cil_rule_to_sepol_class_perms(pdb, cp->classperms, sepol_class_perms);
> +			if (rc != SEPOL_OK) {
> +				goto exit;
> +			}
> +		}
> +	}
> +	return SEPOL_OK;
> +
> +exit:
> +	return rc;
> +}
> +
> +static void __cil_init_sepol_type_set(type_set_t *t)
> +{
> +	ebitmap_init(&t->types);
> +	ebitmap_init(&t->negset);
> +	t->flags = 0;
> +}
> +
> +static int __cil_add_sepol_type(policydb_t *pdb, const struct cil_db *db, struct cil_symtab_datum *datum, ebitmap_t *map)
> +{
> +	int rc = SEPOL_ERR;
> +	struct cil_tree_node *n = datum->nodes->head->data;
> +	type_datum_t *sepol_datum = NULL;
> +
> +	if (n->flavor == CIL_TYPEATTRIBUTE) {
> +		ebitmap_node_t *tnode;
> +		unsigned int i;
> +		struct cil_typeattribute *attr = (struct cil_typeattribute *)datum;
> +		ebitmap_for_each_bit(attr->types, tnode, i) {
> +			if (!ebitmap_get_bit(attr->types, i)) continue;
> +			datum = DATUM(db->val_to_type[i]);
> +			rc = __cil_get_sepol_type_datum(pdb, datum, &sepol_datum);
> +			if (rc != SEPOL_OK) goto exit;
> +			ebitmap_set_bit(map, sepol_datum->s.value - 1, 1);
> +		}
> +	} else {
> +		rc = __cil_get_sepol_type_datum(pdb, datum, &sepol_datum);
> +		if (rc != SEPOL_OK) goto exit;
> +		ebitmap_set_bit(map, sepol_datum->s.value - 1, 1);
> +	}
> +
> +	return SEPOL_OK;
> +
> +exit:
> +	return rc;
> +}
> +
> +static avrule_t *__cil_init_sepol_avrule(uint32_t kind, struct cil_tree_node *node)
> +{
> +	avrule_t *avrule;
> +
> +	avrule = cil_malloc(sizeof(avrule_t));
> +	avrule->specified = kind;
> +	avrule->flags = 0;
> +	__cil_init_sepol_type_set(&avrule->stypes);
> +	__cil_init_sepol_type_set(&avrule->ttypes);
> +	avrule->perms = NULL;
> +	avrule->line = node->line;
> +	avrule->source_filename = node->path;
> +	avrule->source_line = node->line;
> +	avrule->next = NULL;
> +	return avrule;
> +}
> +
> +static void __cil_destroy_sepol_avrules(avrule_t *curr)
> +{
> +	avrule_t *next;
> +
> +	while (curr) {
> +		next = curr->next;
> +		ebitmap_destroy(&curr->stypes.types);
> +		ebitmap_destroy(&curr->stypes.negset);
> +		ebitmap_destroy(&curr->ttypes.types);
> +		ebitmap_destroy(&curr->ttypes.negset);
> +		__cil_destroy_sepol_class_perms(curr->perms);
> +		free(curr);
> +		curr = next;
> +	}
> +}
> +
> +static int __cil_rule_to_expanded_sepol_avrule(const struct cil_db *db, policydb_t *pdb, struct cil_tree_node *node, avrule_t **avrule)
> +{
> +	int rc = SEPOL_ERR;
> +	struct cil_avrule *cil_rule = node->data;
> +	struct cil_symtab_datum *tgt = cil_rule->tgt;
> +	uint32_t kind;
> +	avrule_t *rule;
> +
> +	*avrule = NULL;
> +
> +	switch (cil_rule->rule_kind) {
> +	case CIL_AVRULE_AUDITALLOW:
> +		kind = AVRULE_AUDITALLOW;
> +		break;
> +	case CIL_AVRULE_DONTAUDIT:
> +		kind = AVRULE_AUDITDENY;
> +		break;
> +	case CIL_AVRULE_NEVERALLOW:
> +		kind = AVRULE_NEVERALLOW;
> +		break;
> +	default:
> +		kind = AVRULE_ALLOWED;
> +		break;
> +	}
> +
> +	rule = __cil_init_sepol_avrule(kind, node);
> +
> +	rc = __cil_rule_to_sepol_class_perms(pdb, cil_rule->classperms, &rule->perms);
> +	if (rc != SEPOL_OK) {
> +		goto exit;
> +	}
> +
> +	rc = __cil_add_sepol_type(pdb, db, cil_rule->src, &rule->stypes.types);
> +	if (rc != SEPOL_OK) {
> +		goto exit;
> +	}
> +
> +	if (tgt->fqn == CIL_KEY_SELF) {
> +		rule->flags = RULE_SELF;
> +	} else {
> +		rc = __cil_add_sepol_type(pdb, db, cil_rule->tgt, &rule->ttypes.types);
> +		if (rc != SEPOL_OK) {
> +			goto exit;
> +		}
> +	}
> +
> +	rule->next = NULL;
> +	*avrule = rule;
> +
> +	return SEPOL_OK;
> +
> +exit:
> +	__cil_destroy_sepol_avrules(rule);
> +	return rc;
> +}
> +
> +static void __cil_print_parents(const char *pad, struct cil_tree_node *n)
> +{
> +	if (!n) return;
> +
> +	__cil_print_parents(pad, n->parent);
> +
> +	if (!n->path) {
> +		cil_log(CIL_ERR,"%s%s\n", pad, cil_node_to_string(n));
> +	} else {
> +		cil_log(CIL_ERR,"%s%s at line %d of %s\n", pad, cil_node_to_string(n), n->line, n->path);
> +	}
> +}
> +
> +static void __cil_print_rule(const char *pad, const char *kind, struct cil_avrule *avrule)
> +{
> +	struct cil_list *cp_list = avrule->classperms;
> +	struct cil_list_item *i1, *i2;
> +
> +	cil_log(CIL_ERR,"%s(%s ", pad, kind);
> +	cil_log(CIL_ERR,"%s %s ", DATUM(avrule->src)->fqn, DATUM(avrule->tgt)->fqn);
> +
> +	i1 = cp_list->head;
> +	if (i1->flavor == CIL_CLASSPERMS) {
> +		struct cil_classperms *cp = i1->data;
> +		cil_log(CIL_ERR,"(%s (", DATUM(cp->class)->fqn);
> +		cil_list_for_each(i2, cp->perms) {
> +			cil_log(CIL_ERR,"%s",DATUM(i2->data)->fqn);
> +			if (i2 != cp->perms->tail) {
> +				cil_log(CIL_ERR," ");
> +			} else {
> +				cil_log(CIL_ERR,"))");
> +			}
> +		}
> +	} else {
> +		struct cil_classperms_set *cp_set = i1->data;
> +		cil_log(CIL_ERR,"%s", DATUM(cp_set->set)->fqn);
> +	}
> +
> +	cil_log(CIL_ERR,")\n");
> +}
> +
> +static int cil_check_neverallows(const struct cil_db *db, policydb_t *pdb, struct cil_list *neverallows)
> +{
> +	int rc = SEPOL_OK;
> +	struct cil_list_item *i1;
> +
> +	cil_list_for_each(i1, neverallows) {
> +		struct cil_tree_node *node = i1->data;
> +		avrule_t *avrule;
> +		rc = __cil_rule_to_expanded_sepol_avrule(db, pdb, node, &avrule);
> +		if (rc != SEPOL_OK) {
> +			cil_log(CIL_ERR, "Failed to create expanded sepol avrules to check neverallow rules\n");
> +			goto exit;
> +		}
> +
> +		rc = check_assertion(pdb, avrule);
> +
> +		if (rc == CIL_TRUE) {
> +			struct cil_list_item *i2;
> +			struct cil_list *matching;
> +			struct cil_avrule *cil_rule = node->data;
> +			struct cil_avrule target;
> +			struct cil_tree_node *n2;
> +			struct cil_avrule *r2;
> +			target.rule_kind = CIL_AVRULE_ALLOWED;
> +			target.src = cil_rule->src;
> +			target.tgt = cil_rule->tgt;
> +			target.classperms = cil_rule->classperms;
> +			cil_log(CIL_ERR, "Neverallow check failed at line %d of %s\n", node->line, node->path);
> +			__cil_print_rule("  ", "neverallow", cil_rule);
> +			cil_list_init(&matching, CIL_NODE);
> +			rc = cil_find_matching_avrule_in_ast(db->ast->root, CIL_AVRULE, &target, matching, CIL_FALSE);
> +			if (rc) {
> +				cil_log(CIL_ERR, "Error occurred while checking neverallow rules\n");
> +				cil_list_destroy(&matching, CIL_FALSE);
> +				__cil_destroy_sepol_avrules(avrule);
> +				goto exit;
> +			}
> +
> +			cil_list_for_each(i2, matching) {
> +				n2 = i2->data;
> +				r2 = n2->data;
> +				__cil_print_parents("    ", n2);
> +				__cil_print_rule("      ", "allow", r2);
> +			}
> +			cil_log(CIL_ERR,"\n");
> +			cil_list_destroy(&matching, CIL_FALSE);
> +		}
> +		__cil_destroy_sepol_avrules(avrule);
> +		avrule = NULL;
> +	}
> +
> +exit:
> +	return rc;
> +}
> +
>  // assumes policydb is already allocated and initialized properly with things
>  // like policy type set to kernel and version set appropriately
>  int cil_binary_create_allocated_pdb(const struct cil_db *db, sepol_policydb_t *policydb)
> @@ -3822,13 +3980,19 @@ int cil_binary_create_allocated_pdb(const struct cil_db *db, sepol_policydb_t *p
>  	cond_optimize_lists(pdb->cond_list);
>  	__cil_set_conditional_state_and_flags(pdb);
>  
> +	if (db->disable_neverallow != CIL_TRUE) {
> +		cil_log(CIL_INFO, "Checking Neverallows\n");
> +		rc = cil_check_neverallows(db, pdb, neverallows);
> +		if (rc != SEPOL_OK) goto exit;
> +	}
> +
>  	rc = SEPOL_OK;
>  
>  exit:
>  	hashtab_destroy(filename_trans_table);
>  	hashtab_destroy(range_trans_table);
>  	hashtab_destroy(role_trans_table);
> -	cil_neverallows_list_destroy(neverallows);
> +	cil_list_destroy(&neverallows, CIL_FALSE);
>  
>  	return rc;
>  }
> diff --git a/libsepol/cil/src/cil_binary.h b/libsepol/cil/src/cil_binary.h
> index 5045c6e..72c0f95 100644
> --- a/libsepol/cil/src/cil_binary.h
> +++ b/libsepol/cil/src/cil_binary.h
> @@ -250,7 +250,7 @@ int cil_type_rule_to_policydb(policydb_t *pdb, const struct cil_db *db, struct c
>   *
>   * @return SEPOL_OK upon success or an error otherwise.
>   */
> -int cil_avrule_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_avrule *cil_avrule, struct cil_list *neverallows);
> +int cil_avrule_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_avrule *cil_avrule);
>  
>  /**
>   * Insert cil booleanif structure into sepol policydb.  This populates the
> @@ -262,7 +262,7 @@ int cil_avrule_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_
>   *
>   * @return SEPOL_OK upon success or an error otherwise.
>   */
> -int cil_booleanif_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_tree_node *node, struct cil_list *neverallows, hashtab_t filename_trans_table);
> +int cil_booleanif_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_tree_node *node, hashtab_t filename_trans_table);
>  
>  /**
>   * Insert cil role transition structure into sepol policydb.
> 
