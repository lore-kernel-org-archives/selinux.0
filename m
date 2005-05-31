Subject: Re: [Patch 1/3] Loadable policy module infrastructure
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux <selinux@tycho.nsa.gov>, selinux-dev@tresys.com
In-Reply-To: <1117128423.3483.19.camel@localhost>
References: <1117128423.3483.19.camel@localhost>
Content-Type: text/plain
Date: Tue, 31 May 2005 11:49:00 -0400
Message-Id: <1117554540.28924.184.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-05-26 at 13:27 -0400, Joshua Brindle wrote:
> diff -burNd a1/libsepol/include/sepol/ebitmap.h b/libsepol/include/sepol/ebitmap.h
> --- a1/libsepol/include/sepol/ebitmap.h	2005-05-25 13:14:59.135669264 -0400
> +++ b/libsepol/include/sepol/ebitmap.h	2005-05-25 13:11:19.706027640 -0400
> @@ -47,6 +47,7 @@
>  
>  int ebitmap_cmp(ebitmap_t * e1, ebitmap_t * e2);
>  int ebitmap_or(ebitmap_t * dst, ebitmap_t * e1, ebitmap_t * e2);
> +int ebitmap_or_eq(ebitmap_t *dst, ebitmap_t *e1);
>  int ebitmap_cpy(ebitmap_t * dst, ebitmap_t * src);
>  int ebitmap_contains(ebitmap_t * e1, ebitmap_t * e2);
>  int ebitmap_get_bit(ebitmap_t * e, unsigned int bit);

Poor name, suggests equality test rather than assignment.

> diff -burNd a1/libsepol/include/sepol/hierarchy.h b/libsepol/include/sepol/hierarchy.h
> --- a1/libsepol/include/sepol/hierarchy.h	2005-05-25 13:15:54.657228704 -0400
> +++ b/libsepol/include/sepol/hierarchy.h	2005-05-25 13:11:19.945991160 -0400
> @@ -1,6 +1,5 @@
>  /* Authors: Jason Tang <jtang@tresys.com>
>   *	    Joshua Brindle <jbrindle@tresys.com>
> - *          Karl MacMillan <kmacmillan@tresys.com>
>   *

Did you mean to remove attribution for Karl?

> diff -burNd a1/libsepol/include/sepol/policydb.h b/libsepol/include/sepol/policydb.h
> --- a1/libsepol/include/sepol/policydb.h	2005-05-25 13:15:54.659228400 -0400
> +++ b/libsepol/include/sepol/policydb.h	2005-05-25 13:11:19.429069744 -0400
> @@ -192,6 +259,11 @@
>  	struct genfs *next;
>  } genfs_t;
>  
> +typedef struct policycon {
> +        uint32_t component_type;
> +	struct ocontext *head;
> +} policycon_t;
> +
>  /* symbol table array indices */
>  #define SYM_COMMONS 0
>  #define SYM_CLASSES 1
> @@ -203,6 +275,10 @@
>  #define SYM_CATS    7
>  #define SYM_NUM     8
>  
> +/* this #define gives the index into policycon tables for attributes */
> +#define SYM_ATTRIBS (SYM_BOOLS + 1)
> +#define POLICYCON_NUM (SYM_ATTRIBS + 1)

Did you mean to overlap indices with levels and categories (albeit in a
different table)?

> diff -burNd a1/libsepol/src/assertion.c b/libsepol/src/assertion.c
> --- a1/libsepol/src/assertion.c	1969-12-31 19:00:00.000000000 -0500
> +++ b/libsepol/src/assertion.c	2005-05-25 13:11:20.410920480 -0400
> +static int check_assertion_helper(policydb_t *p, unsigned int stype, unsigned int ttype,
> +        class_perm_node_t *perm, avtab_t *avtab, unsigned long line)
> +{
> +        avtab_key_t avkey;
> +        avtab_datum_t *avdatump;
> +        class_perm_node_t *curperm;
> +
> +        curperm = perm;
> +
> +        while (curperm) {
> +                avkey.source_type = stype + 1;
> +                avkey.target_type = ttype + 1;
> +                avkey.target_class = curperm->class;
> +                avdatump = avtab_search(avtab, &avkey, AVTAB_AV);
> +                if (!avdatump)
> +                        goto cont;

Strange loop construction.  Use a for loop and normal continue
statement.

> +
> +                if ((avdatump->specified & AVTAB_ALLOWED) && (avtab_allowed(avdatump) & curperm->data)) {
> +                        fprintf(stderr, "assertion on line %lu violated by allow %s %s:%s ;\n",
> +                                line, p->p_type_val_to_name[stype], p->p_type_val_to_name[ttype],
> +                                p->p_class_val_to_name[curperm->class - 1]);
> +                        return -1;
> +                }

Given the avrules representation, what about backtracing (via additional
links from avtab) to the actual policy.conf rule that caused the
violation?  The current output can often be confusing, particularly when
the original rule used an attribute.

> +int check_assertions(policydb_t *p, avrule_t *avrules, avtab_t *avtab)
> +{
> +        avrule_t *a;
> +        unsigned int i, j;
> +	int errors = 0;
> +
> +        a = avrules;
> +        while (a) {
> +                if (!(a->specified & AVRULE_NEVERALLOW))
> +                        goto cont;

Strange loop construction, again.


> diff -burNd a1/libsepol/src/conditional.c b/libsepol/src/conditional.c
> --- a1/libsepol/src/conditional.c	2005-05-25 13:15:54.661228096 -0400
> +++ b/libsepol/src/conditional.c	2005-05-25 13:11:19.342082968 -0400
> @@ -220,6 +228,30 @@
>  	return s[0];
>  }
>  
> +cond_expr_t *cond_copy_expr(cond_expr_t *expr)
> +{
> +        cond_expr_t *cur, *head, *tail, *new_expr;
> +        tail = head = NULL;
> +        cur = expr;
> +        while (cur) {
> +                new_expr = (cond_expr_t*)malloc(sizeof(cond_expr_t));
> +                if (!new_expr)
> +                        return NULL;

What frees any nodes that were previously allocated by this loop?

> @@ -382,7 +418,7 @@
>  	}
>  }
>  
> -static void cond_node_destroy(cond_node_t *node)
> +void cond_node_destroy(cond_node_t *node)
>  {
>  	cond_expr_t *cur_expr, *next_expr;
>  
> @@ -393,12 +429,13 @@
>  		next_expr = cur_expr->next;
>  		free(cur_expr);
>  	}
> +        avrule_list_destroy(node->avtrue_list);
> +        avrule_list_destroy(node->avfalse_list);
>  	cond_av_list_destroy(node->true_list);
>  	cond_av_list_destroy(node->false_list);
> -	free(node);
>  }

cond_node_destroy() no longer frees the node itself; are all callers
handling it now?  What about cond_read_node()?

> diff -burNd a1/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
> --- a1/libsepol/src/ebitmap.c	2005-05-25 13:14:58.958696168 -0400
> +++ b/libsepol/src/ebitmap.c	2005-05-25 13:11:19.522055608 -0400
> @@ -58,6 +79,19 @@
>  	return 0;
>  }
>  
> +int ebitmap_or_eq(ebitmap_t *dst, ebitmap_t *e1)
> +{
> +       int ret;
> +       ebitmap_t tmp;
> +
> +       if (ebitmap_or(&tmp, dst, e1))
> +               return -1;
> +       ebitmap_destroy(dst);
> +       ret = ebitmap_cpy(dst, &tmp);
> +       ebitmap_destroy(&tmp);
> +               
> +       return ret;
> +}

Why require the extra memory allocation and copying from tmp vs. just
overwriting dst with tmp here? 

> diff -burNd a1/libsepol/src/policydb.c b/libsepol/src/policydb.c
> --- a1/libsepol/src/policydb.c	2005-05-25 13:15:54.663227792 -0400
> +++ b/libsepol/src/policydb.c	2005-05-25 13:11:19.345082512 -0400
> @@ -401,6 +539,25 @@
>  	return 0;
>  }
>  
> +int policydb_index_types(policydb_t *p)
> +{
> +        free(p->p_type_val_to_name);
> +        p->p_type_val_to_name = (char**)malloc(p->p_types.nprim * sizeof(char*));
> +        if (!p->p_type_val_to_name)
> +                return -1;
> + 
> +        free(p->type_val_to_struct);
> +        p->type_val_to_struct = (type_datum_t**)
> +                malloc(p->p_types.nprim * sizeof(type_datum_t*));
> +        if (!p->type_val_to_struct)
> +                return -1;
> + 
> +        if (hashtab_map(p->p_types.table, type_index, p))
> +                return -1;
> + 
> +        return 0;
> +}
> +

I see no callers of this function in this patchset.

> @@ -415,7 +572,7 @@
>  		       p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim,
>  		       p->p_bools.nprim);
>  
> -		if (mls_enabled)
> +		if (sepol_mls_enabled())
>  			printf(", %d sens, %d cats", p->p_levels.nprim,
>  			       p->p_cats.nprim);
>  

Why did you change this?  Within libsepol, there is no reason to use the
function interface for getting the value of mls_enabled.

> @@ -699,8 +875,11 @@
>  {
>  	role_datum_t *role;
>  	user_datum_t *usrdatum;
> +	ebitmap_t types, roles;
> +        int ret = 1;

ret looks unused.

@@ -715,8 +894,11 @@
>  		 * Role must be authorized for the type.
>  		 */
>  		role = p->role_val_to_struct[c->role - 1];
> -		if (!ebitmap_get_bit(&role->types,
> -				     c->type - 1))
> +		if (type_set_expand(&role->types, &types, p)) {
> +			printf("something bad happened while expanding types\n");
> +                        return 0;
> +		}
> +		if (!ebitmap_get_bit(&types, c->type - 1))
>  			/* role may not be associated with type */
>  			return 0;

Performing the set expansion on every isvalid check seems heavyweight
and prone to possible memory allocation failure.  I'd recommend pre-
expansion and caching in the struct prior to any isvalid calls.
		
> @@ -727,8 +909,11 @@
>  		if (!usrdatum)
>  			return 0;
>  
> -		if (!ebitmap_get_bit(&usrdatum->roles,
> -				     c->role - 1))
> +                if (role_set_expand(&usrdatum->roles, &roles, p)) {
> +			printf("something bad happened while expanding roles\n");
> +                        return 0;
> +                }
> +		if (!ebitmap_get_bit(&roles, c->role - 1))
>  			/* user may not be associated with role */
>  			return 0;
>  	}

Ditto.

More to come as time permits.  BTW, diff -p would be nicer.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
