Message-ID: <557EDA32.6060602@tycho.nsa.gov>
Date: Mon, 15 Jun 2015 09:59:14 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH 05/10] libsepol/cil: Add function to search the CIL AST
 for an AV rule.
References: <1434047207-25503-1-git-send-email-jwcart2@tycho.nsa.gov>
 <1434047207-25503-6-git-send-email-jwcart2@tycho.nsa.gov>
 <557B2494.40605@tresys.com>
In-Reply-To: <557B2494.40605@tresys.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/12/2015 02:27 PM, Steve Lawrence wrote:
> On 06/11/2015 02:26 PM, James Carter wrote:
>> The search will be considered a success if any rule is found that
>> at least partially matches all parts (src type, tgt type, and class-
>> perms) of the target rule.
>>
>> For example, for a target of (allow domain file_type (file (read write)
>> the rule (allow init_t init_exec_t (file (read exec)) will match.
>>
>> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
>> ---
>>   libsepol/cil/src/cil_find.c | 281 ++++++++++++++++++++++++++++++++++++++++++++
>>   libsepol/cil/src/cil_find.h |  39 ++++++
>>   2 files changed, 320 insertions(+)
>>   create mode 100644 libsepol/cil/src/cil_find.c
>>   create mode 100644 libsepol/cil/src/cil_find.h
>>
>> diff --git a/libsepol/cil/src/cil_find.c b/libsepol/cil/src/cil_find.c
>> new file mode 100644
>> index 0000000..1eda966
>> --- /dev/null
>> +++ b/libsepol/cil/src/cil_find.c
>> @@ -0,0 +1,281 @@
>> +/*
>> + * Copyright 2011 Tresys Technology, LLC. All rights reserved.
>> + *
>> + * Redistribution and use in source and binary forms, with or without
>> + * modification, are permitted provided that the following conditions are met:
>> + *
>> + *    1. Redistributions of source code must retain the above copyright notice,
>> + *       this list of conditions and the following disclaimer.
>> + *
>> + *    2. Redistributions in binary form must reproduce the above copyright notice,
>> + *       this list of conditions and the following disclaimer in the documentation
>> + *       and/or other materials provided with the distribution.
>> + *
>> + * THIS SOFTWARE IS PROVIDED BY TRESYS TECHNOLOGY, LLC ``AS IS'' AND ANY EXPRESS
>> + * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
>> + * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
>> + * EVENT SHALL TRESYS TECHNOLOGY, LLC OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
>> + * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
>> + * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
>> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
>> + * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
>> + * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>> + * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>> + *
>> + * The views and conclusions contained in the software and documentation are those
>> + * of the authors and should not be interpreted as representing official policies,
>> + * either expressed or implied, of Tresys Technology, LLC.
>> + */
>> +
>> +#include <sepol/policydb/ebitmap.h>
>> +
>> +#include "cil_internal.h"
>> +#include "cil_flavor.h"
>> +#include "cil_list.h"
>> +#include "cil_log.h"
>> +#include "cil_symtab.h"
>> +
>> +struct cil_args_find {
>> +	enum cil_flavor flavor;
>> +	void *target;
>> +	struct cil_list *matching;
>> +	int match_self;
>> +};
>> +
>> +static int cil_ebitmap_match_any(ebitmap_t *e1, ebitmap_t *e2)
>> +{
>> +	/* abusing the ebitmap abstraction for speed */
>> +	ebitmap_node_t *n1 = e1->node;
>> +	ebitmap_node_t *n2 = e2->node;
>> +	while (n1 && n2) {
>> +		if (n1->startbit < n2->startbit) {
>> +			n1 = n1->next;
>> +		} else if (n2->startbit < n1->startbit) {
>> +			n2 = n2->next;
>> +		} else {
>> +			if (n1->map & n2->map) {
>> +				return CIL_TRUE;
>> +			}
>> +			n1 = n1->next;
>> +			n2 = n2->next;
>> +		}
>> +	}
>> +	return CIL_FALSE;
>> +}
>
> Could you use the ebitmap_match_any added in patch 1/10?
>

Yes. I had meant to do that.

>> +
>> +static int cil_type_match_any(struct cil_symtab_datum *d1, struct cil_symtab_datum *d2)
>> +{
>> +	enum cil_flavor f1 = ((struct cil_tree_node*)d1->nodes->head->data)->flavor;
>> +	enum cil_flavor f2 = ((struct cil_tree_node*)d2->nodes->head->data)->flavor;
>> +
>> +	if (f1 != CIL_TYPEATTRIBUTE && f2 != CIL_TYPEATTRIBUTE) {
>> +		struct cil_type *t1 = (struct cil_type *)d1;
>> +		struct cil_type *t2 = (struct cil_type *)d2;
>> +		if (t1->value == t2->value) {
>> +			return CIL_TRUE;
>> +		}
>> +	} else if (f1 == CIL_TYPEATTRIBUTE && f2 != CIL_TYPEATTRIBUTE) {
>> +		struct cil_typeattribute *a = (struct cil_typeattribute *)d1;
>> +		struct cil_type *t = (struct cil_type *)d2;
>> +		if (ebitmap_get_bit(a->types, t->value)) {
>> +			return CIL_TRUE;
>> +		}
>> +	} else if (f1 != CIL_TYPEATTRIBUTE && f2 == CIL_TYPEATTRIBUTE) {
>> +		struct cil_type *t = (struct cil_type *)d1;
>> +		struct cil_typeattribute *a = (struct cil_typeattribute *)d2;
>> +		if (ebitmap_get_bit(a->types, t->value)) {
>> +			return CIL_TRUE;
>> +		}
>> +	} else {
>> +		/* Both are attributes */
>> +		struct cil_typeattribute *a1 = (struct cil_typeattribute *)d1;
>> +		struct cil_typeattribute *a2 = (struct cil_typeattribute *)d2;
>> +		return cil_ebitmap_match_any(a1->types, a2->types);
>> +	}
>> +	return CIL_FALSE;
>> +}
>> +
>> +static void cil_type_matches(ebitmap_t *matches, struct cil_symtab_datum *d1, struct cil_symtab_datum *d2)
>> +{
>> +	enum cil_flavor f1 = ((struct cil_tree_node*)d1->nodes->head->data)->flavor;
>> +	enum cil_flavor f2 = ((struct cil_tree_node*)d2->nodes->head->data)->flavor;
>> +
>> +	if (f1 != CIL_TYPEATTRIBUTE && f2 != CIL_TYPEATTRIBUTE) {
>> +		struct cil_type *t1 = (struct cil_type *)d1;
>> +		struct cil_type *t2 = (struct cil_type *)d2;
>> +		if (t1->value == t2->value) {
>> +			ebitmap_set_bit(matches, t1->value, 1);
>> +		}
>> +	} else if (f1 == CIL_TYPEATTRIBUTE && f2 != CIL_TYPEATTRIBUTE) {
>> +		struct cil_typeattribute *a = (struct cil_typeattribute *)d1;
>> +		struct cil_type *t = (struct cil_type *)d2;
>> +		if (ebitmap_get_bit(a->types, t->value)) {
>> +			ebitmap_set_bit(matches, t->value, 1);
>> +		}
>> +	} else if (f1 != CIL_TYPEATTRIBUTE && f2 == CIL_TYPEATTRIBUTE) {
>> +		struct cil_type *t = (struct cil_type *)d1;
>> +		struct cil_typeattribute *a = (struct cil_typeattribute *)d2;
>> +		if (ebitmap_get_bit(a->types, t->value)) {
>> +			ebitmap_set_bit(matches, t->value, 1);
>> +		}
>> +	} else {
>> +		/* Both are attributes */
>> +		struct cil_typeattribute *a1 = (struct cil_typeattribute *)d1;
>> +		struct cil_typeattribute *a2 = (struct cil_typeattribute *)d2;
>> +		ebitmap_and(matches, a1->types, a2->types);
>> +	}
>> +}
>> +
>> +/* s1 is the src type that is matched with a self
>> + * s2, and t2 are the source and type of the other rule
>> + */
>> +static int cil_self_match_any(struct cil_symtab_datum *s1, struct cil_symtab_datum *s2, struct cil_symtab_datum *t2)
>> +{
>> +	struct cil_tree_node *n1 = s1->nodes->head->data;
>> +	if (n1->flavor != CIL_TYPEATTRIBUTE) {
>> +		return cil_type_match_any(s1, t2);
>> +	} else {
>> +		int rc;
>> +		struct cil_typeattribute *a = (struct cil_typeattribute *)s1;
>> +		ebitmap_t map;
>> +		ebitmap_init(&map);
>> +		cil_type_matches(&map, s2, t2);
>> +		if (map.node == NULL) {
>> +			return CIL_FALSE;
>> +		}
>> +		rc = cil_ebitmap_match_any(&map, a->types);
>> +		ebitmap_destroy(&map);
>> +		return rc;
>> +	}
>> +}
>> +
>> +static int cil_classperms_match_any(struct cil_classperms *cp1, struct cil_classperms *cp2)
>> +{
>> +	struct cil_class *c1 = cp1->class;
>> +	struct cil_class *c2 = cp2->class;
>> +	struct cil_list_item *i1, *i2;
>> +
>> +	if (&c1->datum != &c2->datum) return CIL_FALSE;
>> +
>> +	cil_list_for_each(i1, cp1->perms) {
>> +		struct cil_perm *p1 = i1->data;
>> +		cil_list_for_each(i2, cp2->perms) {
>> +			struct cil_perm *p2 = i2->data;
>> +			if (&p1->datum == &p2->datum) return CIL_TRUE;
>> +		}
>> +	}
>> +	return CIL_FALSE;
>> +}
>> +
>> +static int __cil_classperms_list_match_any(struct cil_classperms *cp1, struct cil_list *cpl2)
>> +{
>> +	int rc;
>> +	struct cil_list_item *curr;
>> +
>> +	cil_list_for_each(curr, cpl2) {
>> +		if (curr->flavor == CIL_CLASSPERMS) {
>> +			struct cil_classperms *cp = curr->data;
>> +			if (FLAVOR(cp->class) == CIL_CLASS) {
>> +				rc = cil_classperms_match_any(cp1, cp);
>> +				if (rc == CIL_TRUE) return CIL_TRUE;
>> +			} else { /* MAP */
>> +				struct cil_list_item *i = NULL;
>> +				cil_list_for_each(i, cp->perms) {
>> +					struct cil_perm *cmp = i->data;
>> +					rc = __cil_classperms_list_match_any(cp1, cmp->classperms);
>> +					if (rc == CIL_TRUE) return CIL_TRUE;
>> +				}
>> +			}
>> +		} else { /* SET */
>> +			struct cil_classperms_set *cp_set = curr->data;
>> +			struct cil_classpermission *cp = cp_set->set;
>> +			rc = __cil_classperms_list_match_any(cp1, cp->classperms);
>> +			if (rc == CIL_TRUE) return CIL_TRUE;
>> +		}
>> +	}
>> +	return CIL_FALSE;
>> +}
>> +
>> +static int cil_classperms_list_match_any(struct cil_list *cpl1, struct cil_list *cpl2)
>> +{
>> +	int rc;
>> +	struct cil_list_item *curr;
>> +
>> +	cil_list_for_each(curr, cpl1) {
>> +		if (curr->flavor == CIL_CLASSPERMS) {
>> +			struct cil_classperms *cp = curr->data;
>> +			if (FLAVOR(cp->class) == CIL_CLASS) {
>> +				rc = __cil_classperms_list_match_any(cp, cpl2);
>> +				if (rc == CIL_TRUE) return CIL_TRUE;
>> +			} else { /* MAP */
>> +				struct cil_list_item *i = NULL;
>> +				cil_list_for_each(i, cp->perms) {
>> +					struct cil_perm *cmp = i->data;
>> +					rc = cil_classperms_list_match_any(cmp->classperms, cpl2);
>> +					if (rc == CIL_TRUE) return CIL_TRUE;
>> +				}
>> +			}
>> +		} else { /* SET */
>> +			struct cil_classperms_set *cp_set = curr->data;
>> +			struct cil_classpermission *cp = cp_set->set;
>> +			rc = cil_classperms_list_match_any(cp->classperms, cpl2);
>> +			if (rc == CIL_TRUE) return CIL_TRUE;
>> +		}
>> +	}
>> +	return CIL_FALSE;
>> +}
>> +
>> +void cil_find_matching_avrule(struct cil_tree_node *node, struct cil_avrule *avrule, struct cil_avrule *target, struct cil_list *matching, int match_self)
>> +{
>> +	struct cil_symtab_datum *s1 = avrule->src;
>> +	struct cil_symtab_datum *t1 = avrule->tgt;
>> +	struct cil_list *cp1 = avrule->classperms;
>> +	struct cil_symtab_datum *s2 = target->src;
>> +	struct cil_symtab_datum *t2 = target->tgt;
>> +	struct cil_list *cp2 = target->classperms;
>> +
>> +	if (match_self != CIL_TRUE && avrule == target) return;
>> +
>> +	if (avrule->rule_kind != target->rule_kind) return;
>> +
>> +	if (!cil_type_match_any(s1, s2)) return;
>> +
>> +	if (t1->fqn != CIL_KEY_SELF && t2->fqn != CIL_KEY_SELF) {
>> +		if (!cil_type_match_any(t1, t2)) return;
>> +	} else {
>> +		if (t1->fqn == CIL_KEY_SELF && t2->fqn == CIL_KEY_SELF) {
>> +			/* The earlier check whether s1 and s2 matches is all that is needed */
>> +		} else if (t1->fqn == CIL_KEY_SELF) {
>> +			if (!cil_self_match_any(s1, s2, t2)) return;
>> +		} else if (t2->fqn == CIL_KEY_SELF) {
>> +			if (!cil_self_match_any(s2, s1, t1)) return;
>> +		}
>> +	}
>> +
>> +	if (cil_classperms_list_match_any(cp1, cp2)) {
>> +		cil_list_append(matching, CIL_NODE, node);
>> +	}
>> +}
>> +
>> +static int __cil_find_matching_avrule_in_ast(struct cil_tree_node *node,  __attribute__((unused)) uint32_t *finished, void *extra_args)
>> +{
>> +	struct cil_args_find *args = extra_args;
>> +
>
> Do you need to ignore macros and abstract blocks like we do in
> cil_binary.c? I assume this function should only return matching avrules
> that would end up in the policy this this would be used for things like
> neverallow checking.
>

I agree that for neverallow checking we do want to ignore those. The tricky part 
is that I would like to be able to search for more than just neverallow rules, 
so I want to keep the search as flexible as possible.

>> +	if (node->flavor == CIL_AVRULE) {
>> +		cil_find_matching_avrule(node, node->data, args->target, args->matching, args->match_self);
>> +	}
>> +
>> +	return SEPOL_OK;
>> +}
>> +
>> +void cil_find_matching_avrule_in_ast(struct cil_tree_node *current, enum cil_flavor flavor, void *target, struct cil_list *matching, int match_self)
>> +{
>> +	struct cil_args_find args;
>> +
>> +	args.flavor = flavor;
>> +	args.target = target;
>> +	args.matching = matching;
>> +	args.match_self = match_self;
>> +
>> +	cil_tree_walk(current, __cil_find_matching_avrule_in_ast, NULL, NULL, &args);
>> +}
>> diff --git a/libsepol/cil/src/cil_find.h b/libsepol/cil/src/cil_find.h
>> new file mode 100644
>> index 0000000..cda9134
>> --- /dev/null
>> +++ b/libsepol/cil/src/cil_find.h
>> @@ -0,0 +1,39 @@
>> +/*
>> + * Copyright 2011 Tresys Technology, LLC. All rights reserved.
>> + *
>> + * Redistribution and use in source and binary forms, with or without
>> + * modification, are permitted provided that the following conditions are met:
>> + *
>> + *    1. Redistributions of source code must retain the above copyright notice,
>> + *       this list of conditions and the following disclaimer.
>> + *
>> + *    2. Redistributions in binary form must reproduce the above copyright notice,
>> + *       this list of conditions and the following disclaimer in the documentation
>> + *       and/or other materials provided with the distribution.
>> + *
>> + * THIS SOFTWARE IS PROVIDED BY TRESYS TECHNOLOGY, LLC ``AS IS'' AND ANY EXPRESS
>> + * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
>> + * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
>> + * EVENT SHALL TRESYS TECHNOLOGY, LLC OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
>> + * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
>> + * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
>> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
>> + * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
>> + * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
>> + * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>> + *
>> + * The views and conclusions contained in the software and documentation are those
>> + * of the authors and should not be interpreted as representing official policies,
>> + * either expressed or implied, of Tresys Technology, LLC.
>> + */
>> +
>> +#include "cil_flavor.h"
>> +#include "cil_tree.h"
>> +#include "cil_list.h"
>> +
>> +#ifndef CIL_FIND_H_
>> +#define CIL_FIND_H_
>> +
>> +void cil_find_matching_avrule_in_ast(struct cil_tree_node *current, enum cil_flavor flavor, void *target, struct cil_list *matching, int match_self);
>> +
>> +#endif
>>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
