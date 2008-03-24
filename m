Subject: Re: [RFC][PATCH] user_transition support for libsepol/checkpolicy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Caleb Case <ccase@tresys.com>
In-Reply-To: <47E7E7A5.6090603@manicmethod.com>
References: <47E7E7A5.6090603@manicmethod.com>
Content-Type: text/plain
Date: Mon, 24 Mar 2008 16:15:18 -0400
Message-Id: <1206389718.3302.107.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-03-24 at 13:40 -0400, Joshua Brindle wrote:
> This implements user_transition in the toolchain. It should help on
> distro's like Ubuntu that can't use run_init due to the user not knowing
> the root password. It also seems like a more eloquent way to handle
> service restarts than assigning system_r to user accounts and having the
> daemons run as someuser:system_r:foo_t.

Yes, that's something that has been wanted in Fedora for quite some
time.

The real issue with run_init isn't the re-authentication stage, as that
can always be disabled via pam config (and was just a weak form of
confirming user intent, not an authorization mechanism), but rather the
difficulty in transparently interposing it into all situations where
services get started/re-started.  Only Gentoo seemed to have a good
story there.

> This has some issues in policy due to users not always being known in
> the policy (eg., semanage users). I hope Chris or Dan will be able to
> give some suggestions there.

I'm not sure why anyone needs to add users to policy via semanage users
given the base set of generic users and the ability to map Linux users
to them via seusers aka semanage login.

> The kernel patch (forthcoming after this is accepted) so far only
> implements the transition on process transitions. Later on I plan on
> doing a patch to expand role_transition to object classes (this is a
> change needed for policy rbac support to work). I suspect I'll do the
> same for user at that time. The question here is, do we think its worth
> it to do fine grained transitions like we did for range_trans? (I don't).

Offhand, I can't see a use for per-class user transitions, if that is
what you mean.

I don't think per-class role transitions is really the fundamental
obstacle to enabling use of roles on objects - more thought is required
there.  What will be fun there is role/type and user/range validation,
which presently gets to ignore everything that has object_r.

> Index: libsepol/include/sepol/policydb/policydb.h
> ===================================================================
> --- libsepol/include/sepol/policydb/policydb.h	(revision 2854)
> +++ libsepol/include/sepol/policydb/policydb.h	(working copy)
> @@ -156,6 +156,14 @@
> 	mls_level_t exp_dfltlevel; /* expanded range used for validation */
> } user_datum_t;
> 
> +typedef struct user_trans {
> +	uint32_t user;		/* current role */
> +	uint32_t type;		/* program executable type */
> +	uint32_t new_user;	/* new role */
> +	struct user_trans *next;
> +} user_trans_t;
> +
> +
> /* Sensitivity attributes */
> typedef struct level_datum {
> 	mls_level_t *level;	/* sensitivity and associated categories */
> @@ -225,6 +233,13 @@
> 	struct role_trans_rule *next;
> } role_trans_rule_t;
> 
> +typedef struct user_trans_rule {
> +	ebitmap_t users;	/* current role */
> +	type_set_t types;	/* program executable type */
> +	uint32_t new_user;	/* new role */
> +	struct user_trans_rule *next;
> +} user_trans_rule_t;
> +
> typedef struct role_allow_rule {
> 	role_set_t roles;	/* current role */
> 	role_set_t new_roles;	/* new roles */
> @@ -348,6 +363,9 @@
> 	char *module_name;
> 
> 	struct avrule_decl *next;
> +
> +	user_trans_rule_t *user_tr_rules;
> +	
> } avrule_decl_t;
> 
> typedef struct avrule_block {
> @@ -470,6 +488,8 @@
> 
> 	ebitmap_t policycaps;
> 
> +	user_trans_t *user_tr;
> +
> 	unsigned policyvers;
> 
> 	unsigned handle_unknown;
> @@ -524,6 +544,9 @@
> extern void role_trans_rule_init(role_trans_rule_t * x);
> extern void role_trans_rule_list_destroy(role_trans_rule_t * x);
> 
> +extern void user_trans_rule_init(user_trans_rule_t * x);
> +extern void user_trans_rule_list_destroy(user_trans_rule_t * x);
> +
> extern void role_datum_init(role_datum_t * x);
> extern void role_datum_destroy(role_datum_t * x);
> extern void role_allow_rule_init(role_allow_rule_t * x);
> @@ -588,10 +611,11 @@
> #define POLICYDB_VERSION_AVTAB		20
> #define POLICYDB_VERSION_RANGETRANS	21
> #define POLICYDB_VERSION_POLCAP		22
> +#define POLICYDB_VERSION_USERTRANS	23
> 
> /* Range of policy versions we understand*/
> #define POLICYDB_VERSION_MIN	POLICYDB_VERSION_BASE
> -#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_POLCAP
> +#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_USERTRANS
> 
> /* Module versions and specific changes*/
> #define MOD_POLICYDB_VERSION_BASE	   4
> @@ -600,9 +624,10 @@
> #define MOD_POLICYDB_VERSION_RANGETRANS	   6
> #define MOD_POLICYDB_VERSION_MLS_USERS	   6
> #define MOD_POLICYDB_VERSION_POLCAP	   7
> +#define MOD_POLICYDB_VERSION_USERTRANS	   8
> 
> #define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
> -#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_POLCAP
> +#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_USERTRANS
> 
> #define POLICYDB_CONFIG_MLS    1
> 
> Index: libsepol/src/policydb.c
> ===================================================================
> --- libsepol/src/policydb.c	(revision 2854)
> +++ libsepol/src/policydb.c	(working copy)
> @@ -105,6 +105,12 @@
> 	 .ocon_num = OCON_NODE6 + 1,
> 	 },
> 	{
> +	 .type = POLICY_KERN,
> +	 .version = POLICYDB_VERSION_USERTRANS,
> +	 .sym_num = SYM_NUM,
> +	 .ocon_num = OCON_NODE6 + 1,
> +	 },
> +	{
> 	 .type = POLICY_BASE,
> 	 .version = MOD_POLICYDB_VERSION_BASE,
> 	 .sym_num = SYM_NUM,
> @@ -129,6 +135,12 @@
> 	 .ocon_num = OCON_NODE6 + 1,
> 	 },
> 	{
> +	 .type = POLICY_BASE,
> +	 .version = MOD_POLICYDB_VERSION_USERTRANS,
> +	 .sym_num = SYM_NUM,
> +	 .ocon_num = OCON_NODE6 + 1,
> +	 },
> +	{
> 	 .type = POLICY_MOD,
> 	 .version = MOD_POLICYDB_VERSION_BASE,
> 	 .sym_num = SYM_NUM,
> @@ -150,7 +162,14 @@
> 	 .type = POLICY_MOD,
> 	 .version = MOD_POLICYDB_VERSION_POLCAP,
> 	 .sym_num = SYM_NUM,
> -	 .ocon_num = 0},
> +	 .ocon_num = 0
> +	 },
> +	{
> +	 .type = POLICY_MOD,
> +	 .version = MOD_POLICYDB_VERSION_USERTRANS,
> +	 .sym_num = SYM_NUM,
> +	 .ocon_num = 0
> +	 },
> };
> 
> #if 0
> @@ -348,6 +367,30 @@
> 	}
> }
> 
> +void user_trans_rule_init(user_trans_rule_t * x)
> +{
> +	memset(x, 0, sizeof(*x));
> +	ebitmap_init(&x->users);
> +	type_set_init(&x->types);
> +}
> +
> +void user_trans_rule_destroy(user_trans_rule_t * x)
> +{
> +	if (x != NULL) {
> +		ebitmap_init(&x->users);
> +		type_set_destroy(&x->types);
> +	}
> +}
> +
> +void user_trans_rule_list_destroy(user_trans_rule_t * x)
> +{
> +	while (x != NULL) {
> +		user_trans_rule_t *next = x->next;
> +		user_trans_rule_destroy(x);
> +		free(x);
> +		x = next;
> +	}
> +}
> void role_allow_rule_init(role_allow_rule_t * x)
> {
> 	memset(x, 0, sizeof(role_allow_rule_t));
> @@ -985,6 +1028,7 @@
> 	unsigned int i;
> 	role_allow_t *ra, *lra = NULL;
> 	role_trans_t *tr, *ltr = NULL;
> +	user_trans_t *ut, *lut = NULL;
> 	range_trans_t *rt, *lrt = NULL;
> 
> 	if (!p)
> @@ -1058,6 +1102,14 @@
> 	if (ltr)
> 		free(ltr);
> 
> +	for (ut = p->user_tr; ut; ut = ut->next) {
> +		if (lut)
> +			free(lut);
> +		lut = ut;
> +	}
> +	if (lut)
> +		free(lut);
> +
> 	for (ra = p->role_allow; ra; ra = ra->next) {
> 		if (lra)
> 			free(lra);
> @@ -1983,6 +2035,40 @@
> 	return 0;
> }
> 
> +int user_trans_read(user_trans_t ** t, struct policy_file *fp)
> +{
> +        unsigned int i;
> +        uint32_t buf[3], nel;
> +        user_trans_t *ut, *lut;
> +        int rc;
> +
> +        rc = next_entry(buf, fp, sizeof(uint32_t));
> +        if (rc < 0)
> +                return -1;
> +        nel = le32_to_cpu(buf[0]);
> +        lut = NULL;
> +        for (i = 0; i < nel; i++) {
> +                ut = calloc(1, sizeof(struct user_trans));
> +                if (!ut) {
> +                        return -1;
> +                }
> +                if (lut) {
> +                        lut->next = ut;
> +                } else {
> +                        *t = ut;
> +                }
> +                rc = next_entry(buf, fp, sizeof(uint32_t) * 3);
> +                if (rc < 0)
> +                        return -1;
> +                ut->user = le32_to_cpu(buf[0]);
> +                ut->type = le32_to_cpu(buf[1]);
> +                ut->new_user = le32_to_cpu(buf[2]);
> +                lut = ut;
> +        }
> +        return 0;
> +}
> +
> +
> int role_allow_read(role_allow_t ** r, struct policy_file *fp)
> {
> 	unsigned int i;
> @@ -2679,6 +2765,48 @@
> 	return 0;
> }
> 
> +static int user_trans_rule_read(user_trans_rule_t ** u, struct 
> policy_file *fp)
> +{
> +        uint32_t buf[1], nel;
> +        unsigned int i;
> +        user_trans_rule_t *ut, *lut;
> +        int rc;
> +
> +        rc = next_entry(buf, fp, sizeof(uint32_t));
> +        if (rc < 0)
> +                return -1;
> +        nel = le32_to_cpu(buf[0]);
> +        lut = NULL;
> +        for (i = 0; i < nel; i++) {
> +                ut = malloc(sizeof(user_trans_rule_t));
> +                if (!ut) {
> +                        return -1;
> +                }
> +                user_trans_rule_init(ut);
> +
> +                if (lut) {
> +                        lut->next = ut;
> +                } else {
> +                        *u = ut;
> +                }
> +
> +                if (ebitmap_read(&ut->users, fp))
> +                        return -1;
> +
> +                if (type_set_read(&ut->types, fp))
> +                        return -1;
> +
> +                rc = next_entry(buf, fp, sizeof(uint32_t));
> +                if (rc < 0)
> +                        return -1;
> +                ut->new_user = le32_to_cpu(buf[0]);
> +                lut = ut;
> +        }
> +
> +        return 0;
> +}
> +
> +
> static int role_allow_rule_read(role_allow_rule_t ** r, struct 
> policy_file *fp)
> {
> 	unsigned int i;
> @@ -2805,9 +2933,14 @@
> 	if (cond_read_list(p, &decl->cond_list, fp) == -1 ||
> 	    avrule_read_list(p, &decl->avrules, fp) == -1 ||
> 	    role_trans_rule_read(&decl->role_tr_rules, fp) == -1 ||
> -	    role_allow_rule_read(&decl->role_allow_rules, fp) == -1) {
> +	    role_allow_rule_read(&decl->role_allow_rules, fp) == -1)
> +	    {
> 		return -1;
> 	}
> +	if (p->policyvers >= MOD_POLICYDB_VERSION_USERTRANS) {
> +		if (user_trans_rule_read(&decl->user_tr_rules, fp))
> +			return -1;
> +	}
> 	if (p->policyvers >= MOD_POLICYDB_VERSION_RANGETRANS &&
> 	    range_trans_rule_read(&decl->range_tr_rules, fp) == -1) {
> 		return -1;
> @@ -3179,6 +3312,10 @@
> 				goto bad;
> 		if (role_trans_read(&p->role_tr, fp))
> 			goto bad;
> +		if (r_policyvers >= POLICYDB_VERSION_USERTRANS) {
> +			if (user_trans_read(&p->user_tr, fp))
> +				goto bad;
> +		}
> 		if (role_allow_read(&p->role_allow, fp))
> 			goto bad;
> 	} else {
> Index: libsepol/src/expand.c
> ===================================================================
> --- libsepol/src/expand.c	(revision 2854)
> +++ libsepol/src/expand.c	(working copy)
> @@ -1060,6 +1060,80 @@
> 	return 0;
> }
> 
> +static int copy_user_trans(expand_state_t * state, user_trans_rule_t * 
> rules)
> +{
> +	unsigned int i, j;
> +	user_trans_t *n, *l, *cur_trans;
> +	user_trans_rule_t *cur;
> +	ebitmap_t types;
> +	ebitmap_node_t *rnode, *tnode;
> +
> +	/* start at the end of the list */
> +	for (l = state->out->user_tr; l && l->next; l = l->next) ;
> +
> +	cur = rules;
> +	while (cur) {
> +		ebitmap_init(&types);
> +
> +		if (expand_convert_type_set
> +		    (state->out, state->typemap, &cur->types, &types, 1)) {
> +			ERR(state->handle, "Out of memory!");
> +			return -1;
> +		}
> +		ebitmap_for_each_bit(&cur->users, rnode, i) {
> +			if (!ebitmap_node_get_bit(rnode, i))
> +				continue;
> +			ebitmap_for_each_bit(&types, tnode, j) {
> +				if (!ebitmap_node_get_bit(tnode, j))
> +					continue;
> +
> +				cur_trans = state->out->user_tr;
> +				while (cur_trans) {
> +					if ((cur_trans->user == i + 1) &&
> +					    (cur_trans->type == j + 1)) {
> +						if (cur_trans->new_user ==
> +						    cur->new_user) {
> +							break;
> +						} else {
> +							ERR(state->handle,
> +							    "Conflicting user trans rule %s %s : %s",
> +							    state->out->p_user_val_to_name[i],
> +							    state->out->p_type_val_to_name[j],
> +							    state->out->p_user_val_to_name[cur->new_user - 1]);
> +							return -1;
> +						}
> +					}
> +					cur_trans = cur_trans->next;
> +				}
> +				if (cur_trans)
> +					continue;
> +
> +				n = (user_trans_t *)
> +				    malloc(sizeof(user_trans_t));
> +				if (!n) {
> +					ERR(state->handle, "Out of memory!");
> +					return -1;
> +				}
> +				memset(n, 0, sizeof(user_trans_t));
> +				n->user = i + 1;
> +				n->type = j + 1;
> +				n->new_user = cur->new_user;
> +				if (l) {
> +					l->next = n;
> +				} else {
> +					state->out->user_tr = n;
> +				}
> +				l = n;
> +			}
> +		}
> +
> +		ebitmap_destroy(&types);
> +
> +		cur = cur->next;
> +	}
> +	return 0;
> +}
> +
> static int exp_rangetr_helper(uint32_t stype, uint32_t ttype, uint32_t 
> tclass,
> 			      mls_semantic_range_t * trange,
> 			      expand_state_t * state)
> @@ -2163,6 +2237,9 @@
> 			goto cleanup;
> 		}
> 
> +		if (copy_user_trans(state, decl->user_tr_rules))
> +			goto cleanup;
> +
> 		/* expand the range transition rules */
> 		if (expand_range_trans(state, decl->range_tr_rules))
> 			goto cleanup;
> Index: libsepol/src/write.c
> ===================================================================
> --- libsepol/src/write.c	(revision 2854)
> +++ libsepol/src/write.c	(working copy)
> @@ -487,6 +487,31 @@
> 	return POLICYDB_SUCCESS;
> }
> 
> +static int user_trans_write(user_trans_t * u, struct policy_file *fp)
> +{
> +	user_trans_t *tr;
> +	uint32_t buf[3];
> +	size_t nel, items;
> +
> +	nel = 0;
> +	for (tr = u; tr; tr = tr->next)
> +		nel++;
> +	buf[0] = cpu_to_le32(nel);
> +	items = put_entry(buf, sizeof(uint32_t), 1, fp);
> +	if (items != 1)
> +		return POLICYDB_ERROR;
> +	for (tr = u; tr; tr = tr->next) {
> +		buf[0] = cpu_to_le32(tr->user);
> +		buf[1] = cpu_to_le32(tr->type);
> +		buf[2] = cpu_to_le32(tr->new_user);
> +		items = put_entry(buf, sizeof(uint32_t), 3, fp);
> +		if (items != 3)
> +			return POLICYDB_ERROR;
> +	}
> +
> +	return POLICYDB_SUCCESS;
> +}
> +
> static int role_allow_write(role_allow_t * r, struct policy_file *fp)
> {
> 	role_allow_t *ra;
> @@ -1325,6 +1350,32 @@
> 	return POLICYDB_SUCCESS;
> }
> 
> +static int user_trans_rule_write(user_trans_rule_t * t, struct 
> policy_file *fp)
> +{
> +	int nel = 0;
> +	size_t items;
> +	uint32_t buf[1];
> +	user_trans_rule_t *tr;
> +
> +	for (tr = t; tr; tr = tr->next)
> +		nel++;
> +	buf[0] = cpu_to_le32(nel);
> +	items = put_entry(buf, sizeof(uint32_t), 1, fp);
> +	if (items != 1)
> +		return POLICYDB_ERROR;
> +	for (tr = t; tr; tr = tr->next) {
> +		if (ebitmap_write(&tr->users, fp))
> +			return POLICYDB_ERROR;
> +		if (type_set_write(&tr->types, fp))
> +			return POLICYDB_ERROR;
> +		buf[0] = cpu_to_le32(tr->new_user);
> +		items = put_entry(buf, sizeof(uint32_t), 1, fp);
> +		if (items != 1)
> +			return POLICYDB_ERROR;
> +	}
> +	return POLICYDB_SUCCESS;
> +}
> +
> static int role_allow_rule_write(role_allow_rule_t * r, struct 
> policy_file *fp)
> {
> 	int nel = 0;
> @@ -1414,6 +1465,10 @@
> 	    role_allow_rule_write(decl->role_allow_rules, fp) == -1) {
> 		return POLICYDB_ERROR;
> 	}
> +	if (p->policyvers >= MOD_POLICYDB_VERSION_USERTRANS) {
> +		if (user_trans_rule_write(decl->user_tr_rules, fp))	
> +			return POLICYDB_ERROR;
> +	}
> 	if (p->policyvers >= MOD_POLICYDB_VERSION_RANGETRANS &&
> 	    range_trans_rule_write(decl->range_tr_rules, fp) == -1) {
> 		return POLICYDB_ERROR;
> @@ -1642,6 +1697,10 @@
> 		}
> 		if (role_trans_write(p->role_tr, fp))
> 			return POLICYDB_ERROR;
> +		if (p->policyvers >= POLICYDB_VERSION_USERTRANS) {
> +			if (user_trans_write(p->user_tr, fp))
> +				return POLICYDB_ERROR;
> +		}
> 		if (role_allow_write(p->role_allow, fp))
> 			return POLICYDB_ERROR;
> 	} else {
> Index: libsepol/src/link.c
> ===================================================================
> --- libsepol/src/link.c	(revision 2854)
> +++ libsepol/src/link.c	(working copy)
> @@ -848,6 +848,34 @@
> 	return -1;
> }
> 
> +static int user_bitmap_or_convert(ebitmap_t * users, ebitmap_t * dst,
> +			       policy_module_t * mod, link_state_t * state)
> +{
> +	unsigned int i;
> +	ebitmap_t tmp;
> +	ebitmap_node_t *rnode;
> +
> +	ebitmap_init(&tmp);
> +	ebitmap_for_each_bit(users, rnode, i) {
> +		if (ebitmap_node_get_bit(rnode, i)) {
> +			assert(mod->map[SYM_USERS][i]);
> +			if (ebitmap_set_bit
> +			    (&tmp, mod->map[SYM_USERS][i] - 1, 1)) {
> +				goto cleanup;
> +			}
> +		}
> +	}
> +	if (ebitmap_union(dst, &tmp)) {
> +		goto cleanup;
> +	}
> +	ebitmap_destroy(&tmp);
> +	return 0;
> +      cleanup:
> +	ERR(state->handle, "Out of memory!");
> +	ebitmap_destroy(&tmp);
> +	return -1;
> +}
> +
> static int mls_level_convert(mls_semantic_level_t * src, 
> mls_semantic_level_t * dst,
> 			     policy_module_t * mod, link_state_t * state)
> {
> @@ -1004,13 +1032,22 @@
> 	link_state_t *state = (link_state_t *) data;
> 	policy_module_t *mod = state->cur;
> 	symtab_t *usertab;
> +	scope_datum_t *scope;
> 
> 	user = (user_datum_t *) datum;
> 
> +	scope = hashtab_search(state->cur->policy->p_users_scope.table, key);
> +	assert(scope);
> +	if (scope->scope == SCOPE_REQ) {
> +		//this is required user, no role or mls data
> +		return 0;
> +	}
> +
> 	if (state->dest_decl == NULL)
> 		usertab = &state->base->p_users;
> -	else
> +	else {
> 		usertab = &state->dest_decl->p_users;
> +	}
> 
> 	new_user = hashtab_search(usertab->table, id);
> 	assert(new_user != NULL);
> @@ -1173,6 +1210,49 @@
> 	return -1;
> }
> 
> +static int copy_user_trans_list(user_trans_rule_t * list,
> +                                user_trans_rule_t ** dst,
> +                                policy_module_t * module, link_state_t 
> * state)
> +{
> +        user_trans_rule_t *cur, *new_rule = NULL, *tail;
> +
> +        cur = list;
> +        tail = *dst;
> +        while (tail && tail->next) {
> +                tail = tail->next;
> +        }
> +        while (cur) {
> +                if ((new_rule =
> +                     (user_trans_rule_t *) 
> malloc(sizeof(user_trans_rule_t))) ==
> +                    NULL) {
> +                        goto cleanup;
> +                }
> +                user_trans_rule_init(new_rule);
> +
> +                if (user_bitmap_or_convert(&cur->users, 
> &new_rule->users, module, state))
> +			goto cleanup;
> +		if (type_set_or_convert(&cur->types, &new_rule->types, module, state)) {
> +                        goto cleanup;
> +                }
> +
> +                new_rule->new_user = 
> module->map[SYM_USERS][cur->new_user - 1];
> +
> +                if (*dst == NULL) {
> +                        *dst = new_rule;
> +                } else {
> +                        tail->next = new_rule;
> +                }
> +                tail = new_rule;
> +                cur = cur->next;
> +        }
> +        return 0;
> +      cleanup:
> +        ERR(state->handle, "Out of memory!");
> +        user_trans_rule_list_destroy(new_rule);
> +        return -1;
> +}
> +
> +
> static int copy_role_allow_list(role_allow_rule_t * list,
> 				role_allow_rule_t ** dst,
> 				policy_module_t * module, link_state_t * state)
> @@ -1446,6 +1526,10 @@
> 		return -1;
> 	}
> 
> +	if (copy_user_trans_list(src_decl->user_tr_rules, 
> &dest_decl->user_tr_rules,
> +				 module, state))
> +		return -1;
> +
> 	if (copy_range_trans_list(src_decl->range_tr_rules,
> 				  &dest_decl->range_tr_rules, module, state))
> 		return -1;
> Index: checkpolicy/test/dismod.c
> ===================================================================
> --- checkpolicy/test/dismod.c	(revision 2854)
> +++ checkpolicy/test/dismod.c	(working copy)
> @@ -354,6 +354,21 @@
> 	return 0;
> }
> 
> +int display_user_set(ebitmap_t *u, policydb_t *p, FILE *fp)
> +{
> +	ebitmap_node_t *node;
> +	int i;
> +
> +	fprintf(fp, " { ");
> +	ebitmap_for_each_bit(u, node, i) {
> +		if (ebitmap_node_get_bit(node, i)) {
> +			display_id(p, fp, SYM_USERS, i, "");
> +		}
> +	}
> +	fprintf(fp, " } ");
> +	return 0;
> +}
> +
> int display_bools(policydb_t * p, FILE * fp)
> {
> 	int i;
> @@ -461,7 +476,18 @@
> 		fprintf(fp, "\n");
> 	}
> }
> +void display_user_trans(user_trans_rule_t * tr, policydb_t * p, FILE * fp)
> 
> +{
> +	for (; tr; tr = tr->next) {
> +		fprintf(fp, "user transition ");
> +		display_user_set(&tr->users, p, fp);
> +		display_type_set(&tr->types, 0, p, fp);
> +		display_id(p, fp, SYM_USERS, tr->new_user - 1, " :");
> +		fprintf(fp, "\n");
> +	}
> +}
> +
> void display_role_allow(role_allow_rule_t * ra, policydb_t * p, FILE * fp)
> {
> 	for (; ra; ra = ra->next) {
> @@ -641,6 +667,10 @@
> 			}
> 			break;
> 		}
> +	case 7:{
> +			display_user_trans(decl->user_tr_rules, policy, out_fp);
> +			break;
> +		}
> 	default:{
> 			assert(0);
> 		}
> @@ -806,6 +836,7 @@
> 	printf("c)  Display policy capabilities\n");
> 	printf("l)  Link in a module\n");
> 	printf("u)  Display the unknown handling setting\n");
> +	printf("U)  Display user transitions\n");
> 	printf("\n");
> 	printf("f)  set output file\n");
> 	printf("m)  display menu\n");
> @@ -918,9 +949,11 @@
> 			display_policycaps(&policydb, out_fp);
> 			break;
> 		case 'u':
> -		case 'U':
> 			display_handle_unknown(&policydb, out_fp);
> 			break;
> +		case 'U':
> +			display_avblock(7, 0, &policydb, out_fp);
> +			break;
> 		case 'f':
> 			printf
> 			    ("\nFilename for output (<CR> for screen output): ");
> Index: checkpolicy/test/dispol.c
> ===================================================================
> --- checkpolicy/test/dispol.c	(revision 2854)
> +++ checkpolicy/test/dispol.c	(working copy)
> @@ -299,6 +299,18 @@
> 	return 0;
> }
> 
> +static void display_user_transitions(policydb_t *p, FILE *fp)
> +{
> +	user_trans_t *cur;
> +	for (cur = p->user_tr; cur; cur = cur->next) {
> +		fprintf(fp, "user_transition ");
> +		fprintf(fp, "%s %s %s;\n",
> +			p->p_user_val_to_name[cur->user - 1],
> +			p->p_type_val_to_name[cur->type - 1],
> +			p->p_user_val_to_name[cur->new_user - 1]);
> +	}
> +}
> +
> static void display_policycaps(policydb_t * p, FILE * fp)
> {
> 	ebitmap_node_t *node;
> @@ -332,6 +344,7 @@
> 	printf("\n");
> 	printf("c)  display policy capabilities\n");
> 	printf("u)  display unknown handling setting\n");
> +	printf("U)  display user transitions\n");
> 	printf("f)  set output file\n");
> 	printf("m)  display menu\n");
> 	printf("q)  quit\n");
> @@ -448,9 +461,11 @@
> 			display_policycaps(&policydb, out_fp);
> 			break;
> 		case 'u':
> -		case 'U':
> 			display_handle_unknown(&policydb, out_fp);
> 			break;
> +		case 'U':
> +			display_user_transitions(&policydb, out_fp);
> +			break;
> 		case 'f':
> 			printf
> 			    ("\nFilename for output (<CR> for screen output): ");
> Index: checkpolicy/test/Makefile
> ===================================================================
> --- checkpolicy/test/Makefile	(revision 2854)
> +++ checkpolicy/test/Makefile	(working copy)
> @@ -6,7 +6,7 @@
> LIBDIR=$(PREFIX)/lib
> INCLUDEDIR ?= $(PREFIX)/include
> 
> -CFLAGS ?= -g -Wall -O2 -pipe
> +CFLAGS ?= -g3 -gdwarf-2 -Wall -O0 -pipe
> override CFLAGS += -I$(INCLUDEDIR)
> 
> LDLIBS=-lfl -lsepol -lselinux $(LIBDIR)/libsepol.a -L$(LIBDIR)
> Index: checkpolicy/policy_define.c
> ===================================================================
> --- checkpolicy/policy_define.c	(revision 2854)
> +++ checkpolicy/policy_define.c	(working copy)
> @@ -2020,6 +2020,76 @@
> 	return -1;
> }
> 
> +int define_user_trans(void)
> +{
> +        char *id;
> +        user_datum_t *user, *u;
> +	ebitmap_t users;
> +        type_set_t types;
> +        struct user_trans_rule *rule = NULL;
> +        int add = 1;
> +
> +        if (pass == 1) {
> +                while ((id = queue_remove(id_queue)))
> +                        free(id);
> +                while ((id = queue_remove(id_queue)))
> +                        free(id);
> +                id = queue_remove(id_queue);
> +                free(id);
> +                return 0;
> +        }
> +
> +        ebitmap_init(&users);
> +        type_set_init(&types);
> +
> +	while ((id = queue_remove(id_queue))) {
> +		u = hashtab_search(policydbp->p_users.table, id);
> +		if (!u) {
> +			yyerror2("unknown user %s", id);
> +			free(id);
> +			return -1;
> +		}
> +		if (ebitmap_set_bit(&users, u->s.value - 1, TRUE))
> +			return -1;
> +	}
> +	while ((id = queue_remove(id_queue))) {
> +		if (set_types(&types, id, &add, 0))
> +			return -1;
> +	}
> +	id = (char *)queue_remove(id_queue);
> +	if (!id) {
> +		yyerror("no new user in transition definition?");
> +		goto bad;
> +	}
> +	if (!is_id_in_scope(SYM_USERS, id)) {
> +		yyerror2("user %s is not within scope", id);
> +		free(id);
> +		goto bad;
> +	}
> +	user = hashtab_search(policydbp->p_users.table, id);
> +	if (!user) {
> +		yyerror2("unknown user %s used in transition definition", id);
> +		goto bad;
> +	}
> +	rule = malloc(sizeof(struct user_trans_rule));
> +	if (!rule) {
> +		yyerror("out of memory");
> +		return -1;
> +	}
> +	memset(rule, 0, sizeof(struct user_trans_rule));
> +	rule->users = users;
> +	rule->types = types;
> +	rule->new_user = user->s.value;
> +
> +	append_user_trans(rule);
> +
> +	return 0;
> +
> +      bad:
> +	return -1;
> +}
> +
> +
> int define_role_allow(void)
> {
> 	char *id;
> Index: checkpolicy/policy_scan.l
> ===================================================================
> --- checkpolicy/policy_scan.l	(revision 2854)
> +++ checkpolicy/policy_scan.l	(working copy)
> @@ -102,6 +102,8 @@
> type_change			{ return(TYPE_CHANGE); }
> ROLE_TRANSITION |
> role_transition			{ return(ROLE_TRANSITION); }
> +USER_TRANSITION |
> +user_transition			{ return(USER_TRANSITION); }
> RANGE_TRANSITION |
> range_transition		{ return(RANGE_TRANSITION); }
> SENSITIVITY |
> Index: checkpolicy/policy_define.h
> ===================================================================
> --- checkpolicy/policy_define.h	(revision 2854)
> +++ checkpolicy/policy_define.h	(working copy)
> @@ -42,6 +42,7 @@
> int define_role_allow(void);
> int define_role_trans(void);
> int define_role_types(void);
> +int define_user_trans(void);
> int define_sens(void);
> int define_te_avtab(int which);
> int define_typealias(void);
> Index: checkpolicy/module_compiler.c
> ===================================================================
> --- checkpolicy/module_compiler.c	(revision 2854)
> +++ checkpolicy/module_compiler.c	(working copy)
> @@ -1214,6 +1214,17 @@
> 	decl->role_tr_rules = role_tr_rules;
> }
> 
> +void append_user_trans(user_trans_rule_t * user_tr_rules)
> +{
> +	avrule_decl_t *decl = stack_top->decl;
> +
> +	/* role transitions are not allowed within conditionals */
> +	assert(stack_top->type == 1);
> +
> +	user_tr_rules->next = decl->user_tr_rules;
> +	decl->user_tr_rules = user_tr_rules;
> +}
> +
> /* this doesn't actually append, but really prepends it */
> void append_role_allow(role_allow_rule_t * role_allow_rules)
> {
> Index: checkpolicy/policy_parse.y
> ===================================================================
> --- checkpolicy/policy_parse.y	(revision 2854)
> +++ checkpolicy/policy_parse.y	(working copy)
> @@ -103,6 +103,7 @@
> %token TYPE_MEMBER
> %token TYPE_CHANGE
> %token ROLE_TRANSITION
> +%token USER_TRANSITION
> %token RANGE_TRANSITION
> %token SENSITIVITY
> %token DOMINANCE
> @@ -261,6 +262,7 @@
>                          | transition_def
>                          | range_trans_def
>                          | te_avtab_def
> +			| user_trans_def
> 			;
> attribute_def           : ATTRIBUTE identifier ';'
>                          { if (define_attrib()) return -1;}
> @@ -411,6 +413,9 @@
> role_trans_def		: ROLE_TRANSITION names names identifier ';'
> 			{if (define_role_trans()) return -1; }
> 			;
> +user_trans_def		: USER_TRANSITION names names identifier ';'
> +			{ if (define_user_trans()) return -1; }
> +			;
> role_allow_def		: ALLOW names names ';'
> 			{if (define_role_allow()) return -1; }
> 			;
> Index: checkpolicy/module_compiler.h
> ===================================================================
> --- checkpolicy/module_compiler.h	(revision 2854)
> +++ checkpolicy/module_compiler.h	(working copy)
> @@ -80,6 +80,7 @@
> void append_role_trans(role_trans_rule_t * role_tr_rules);
> void append_role_allow(role_allow_rule_t * role_allow_rules);
> void append_range_trans(range_trans_rule_t * range_tr_rules);
> +void append_user_trans(user_trans_rule_t * user_tr_rules);
> 
> /* Create a new optional block and add it to the global policy.
>   * During the second pass resolve the block's requirements.  Return 0
> 
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
