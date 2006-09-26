Message-ID: <451969E4.9040407@tresys.com>
Date: Tue, 26 Sep 2006 13:56:52 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
CC: SELinux List <selinux@tycho.nsa.gov>,
        Christopher PeBenito <cpebenito@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: [PATCH take 3] allow range_transitions and MLS users in modules
References: <450EDC2E.50009@trustedcs.com> <4519681B.7080107@trustedcs.com>
In-Reply-To: <4519681B.7080107@trustedcs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Darrel Goeddel wrote:
> - Add the ability to require MLS sensitivities and categories in policy
> modules.
> - Remove the restrictions on defining users in MLS-enabled modules.
> - Handle range_trans_rules in modules.
> - Cleanup some uses of calloc/memset
>
> This all allows range_transition statements to be used in policy modules
> and allows definition of users in MLS policy modules.
>
> ---
>
> New and improved!  Now with less calloc()s/memset()s.
>
> checkpolicy/module_compiler.c              |  116 +++++++++++++++++
> checkpolicy/module_compiler.h              |    2
> checkpolicy/policy_parse.y                 |   33 ++---
> libsepol/include/sepol/policydb/policydb.h |    4
> libsepol/src/expand.c                      |   29 ++--
> libsepol/src/link.c                        |  189 
> +++++++++++++++++++++++++----
> libsepol/src/policydb.c                    |   43 +++++-
> 7 files changed, 361 insertions(+), 55 deletions(-)
>
>
> diff -ruNp --exclude=.svn selinux/checkpolicy/module_compiler.c 
> selinux-modular-mls/checkpolicy/module_compiler.c
> --- selinux/checkpolicy/module_compiler.c    2006-09-05 
> 06:44:56.000000000 -0500
> +++ selinux-modular-mls/checkpolicy/module_compiler.c    2006-09-26 
> 06:57:48.000000000 -0500
> @@ -937,6 +937,122 @@ int require_bool(int pass)
>     }
> }
>
> +int require_sens(int pass)
> +{
> +    char *id = queue_remove(id_queue);
> +    level_datum_t *level = NULL;
> +    int retval;
> +    if (pass == 2) {
> +        free(id);
> +        return 0;
> +    }
> +    if (!id) {
> +        yyerror("no sensitivity name");
> +        return -1;
> +    }
> +    level = malloc(sizeof(level_datum_t));
> +    if (!level) {
> +        free(id);
> +        yyerror("Out of memory!");
> +        return -1;
> +    }
> +    level_datum_init(level);
> +    level->level = malloc(sizeof(mls_level_t));
> +    if (!level->level) {
> +        free(id);
> +        level_datum_destroy(level);
> +        free(level);
> +        yyerror("Out of memory!");
> +        return -1;
> +    }
> +    mls_level_init(level->level);
> +    retval = require_symbol(SYM_LEVELS, id, (hashtab_datum_t *) level,
> +                &level->level->sens, &level->level->sens);
> +    if (retval != 0) {
> +        free(id);
> +        mls_level_destroy(level->level);
> +        free(level->level);
> +        level_datum_destroy(level);
> +        free(level);
> +    }
> +    switch (retval) {
> +    case -3:{
> +            yyerror("Out of memory!");
> +            return -1;
> +        }
> +    case -2:{
> +            yyerror("duplicate declaration of sensitivity");
> +            return -1;
> +        }
> +    case -1:{
> +            yyerror("could not require sensitivity here");
> +            return -1;
> +        }
> +    case 0:{
> +            return 0;
> +        }
> +    case 1:{
> +            return 0;    /* sensitivity already required */
> +        }
> +    default:{
> +            assert(0);    /* should never get here */
> +        }
> +    }
> +}
> +
> +int require_cat(int pass)
> +{
> +    char *id = queue_remove(id_queue);
> +    cat_datum_t *cat = NULL;
> +    int retval;
> +    if (pass == 2) {
> +        free(id);
> +        return 0;
> +    }
> +    if (!id) {
> +        yyerror("no category name");
> +        return -1;
> +    }
> +    cat = malloc(sizeof(cat_datum_t));
> +    if (!cat) {
> +        free(id);
> +        yyerror("Out of memory!");
> +        return -1;
> +    }
> +    cat_datum_init(cat);
> +
> +    retval = require_symbol(SYM_CATS, id, (hashtab_datum_t *) cat,
> +                &cat->s.value, &cat->s.value);
> +    if (retval != 0) {
> +        free(id);
> +        cat_datum_destroy(cat);
> +        free(cat);
> +    }
> +    switch (retval) {
> +    case -3:{
> +            yyerror("Out of memory!");
> +            return -1;
> +        }
> +    case -2:{
> +            yyerror("duplicate declaration of category");
> +            return -1;
> +        }
> +    case -1:{
> +            yyerror("could not require category here");
> +            return -1;
> +        }
> +    case 0:{
> +            return 0;
> +        }
> +    case 1:{
> +            return 0;    /* category already required */
> +        }
> +    default:{
> +            assert(0);    /* should never get here */
> +        }
> +    }
> +}
> +
> static int is_scope_in_stack(scope_datum_t * scope, scope_stack_t * 
> stack)
> {
>     int i;
> diff -ruNp --exclude=.svn selinux/checkpolicy/module_compiler.h 
> selinux-modular-mls/checkpolicy/module_compiler.h
> --- selinux/checkpolicy/module_compiler.h    2006-09-05 
> 06:44:56.000000000 -0500
> +++ selinux-modular-mls/checkpolicy/module_compiler.h    2006-09-26 
> 06:57:48.000000000 -0500
> @@ -56,6 +56,8 @@ int require_type(int pass);
> int require_attribute(int pass);
> int require_user(int pass);
> int require_bool(int pass);
> +int require_sens(int pass);
> +int require_cat(int pass);
>
> /* Check if an identifier is within the scope of the current
>  * declaration or any of its parents.  Return 1 if it is, 0 if not.
> diff -ruNp --exclude=.svn selinux/checkpolicy/policy_parse.y 
> selinux-modular-mls/checkpolicy/policy_parse.y
> --- selinux/checkpolicy/policy_parse.y    2006-09-05 
> 06:17:18.000000000 -0500
> +++ selinux-modular-mls/checkpolicy/policy_parse.y    2006-09-26 
> 06:28:11.000000000 -0500
> @@ -834,10 +834,8 @@ require_decl_def        : ROLE        { 
>                         | ATTRIBUTE   { $$ = require_attribute; }
>                         | USER        { $$ = require_user; }
>                         | BOOL        { $$ = require_bool; }
> -/* MLS-enabled modules are not implemented at this time.
>                         | SENSITIVITY { $$ = require_sens; }
>                         | CATEGORY    { $$ = require_cat; }
> -*/
>                         ;
> require_id_list         : identifier
>                         { if ($<require_func>0 (pass)) return -1; }
> @@ -1301,7 +1299,7 @@ static int define_sens(void)
>         yyerror("out of memory");
>         goto bad;
>     }
> -    memset(level, 0, sizeof(mls_level_t));
> +    mls_level_init(level);
>     level->sens = 0;    /* actual value set in define_dominance */
>     ebitmap_init(&level->cat);    /* actual value set in define_level */
>
> @@ -1310,7 +1308,7 @@ static int define_sens(void)
>         yyerror("out of memory");
>         goto bad;
>     }
> -    memset(datum, 0, sizeof(level_datum_t));
> +    level_datum_init(datum);
>     datum->isalias = FALSE;
>     datum->level = level;
>
> @@ -1347,7 +1345,7 @@ static int define_sens(void)
>             yyerror("out of memory");
>             goto bad_alias;
>         }
> -        memset(aliasdatum, 0, sizeof(level_datum_t));
> +        level_datum_init(aliasdatum);
>         aliasdatum->isalias = TRUE;
>         aliasdatum->level = level;
>
> @@ -1384,15 +1382,19 @@ static int define_sens(void)
>         free(id);
>     if (level)
>         free(level);
> -    if (datum)
> +    if (datum) {
> +        level_datum_destroy(datum);
>         free(datum);
> +    }
>     return -1;
>
>       bad_alias:
>     if (id)
>         free(id);
> -    if (aliasdatum)
> +    if (aliasdatum) {
> +        level_datum_destroy(aliasdatum);
>         free(aliasdatum);
> +    }
>     return -1;
> }
>
> @@ -1480,7 +1482,7 @@ static int define_category(void)
>         yyerror("out of memory");
>         goto bad;
>     }
> -    memset(datum, 0, sizeof(cat_datum_t));
> +    cat_datum_init(datum);
>     datum->isalias = FALSE;
>
>     ret = declare_symbol(SYM_CATS, id, datum, &value, &value);
> @@ -1517,7 +1519,7 @@ static int define_category(void)
>             yyerror("out of memory");
>             goto bad_alias;
>         }
> -        memset(aliasdatum, 0, sizeof(cat_datum_t));
> +        cat_datum_init(aliasdatum);
>         aliasdatum->isalias = TRUE;
>         aliasdatum->s.value = datum->s.value;
>
> @@ -1554,15 +1556,19 @@ static int define_category(void)
>       bad:
>     if (id)
>         free(id);
> -    if (datum)
> +    if (datum) {
> +        cat_datum_destroy(datum);
>         free(datum);
> +    }
>     return -1;
>
>       bad_alias:
>     if (id)
>         free(id);
> -    if (aliasdatum)
> +    if (aliasdatum) {
> +        cat_datum_destroy(aliasdatum);
>         free(aliasdatum);
> +    }
>     return -1;
> }
>
> @@ -3682,11 +3688,6 @@ static int define_user(void)
>     level_datum_t *levdatum;
>     int l;
>
> -    if (policydbp->policy_type == POLICY_MOD && mlspol) {
> -        yyerror("Users cannot be declared in MLS modules");
> -        return -1;
> -    }
> -
>     if (pass == 1) {
>         while ((id = queue_remove(id_queue)))
>             free(id);
> diff -ruNp --exclude=.svn 
> selinux/libsepol/include/sepol/policydb/policydb.h 
> selinux-modular-mls/libsepol/include/sepol/policydb/policydb.h
> --- selinux/libsepol/include/sepol/policydb/policydb.h    2006-09-05 
> 06:16:47.000000000 -0500
> +++ selinux-modular-mls/libsepol/include/sepol/policydb/policydb.h    
> 2006-09-26 03:58:59.000000000 -0500
> @@ -532,6 +532,10 @@ extern void type_datum_init(type_datum_t
> extern void type_datum_destroy(type_datum_t * x);
> extern void user_datum_init(user_datum_t * x);
> extern void user_datum_destroy(user_datum_t * x);
> +extern void level_datum_init(level_datum_t * x);
> +extern void level_datum_destroy(level_datum_t * x);
> +extern void cat_datum_init(cat_datum_t * x);
> +extern void cat_datum_destroy(cat_datum_t * x);
>
> extern int check_assertions(sepol_handle_t * handle,
>                 policydb_t * p, avrule_t * avrules);
> diff -ruNp --exclude=.svn selinux/libsepol/src/expand.c 
> selinux-modular-mls/libsepol/src/expand.c
> --- selinux/libsepol/src/expand.c    2006-09-05 06:44:54.000000000 -0500
> +++ selinux-modular-mls/libsepol/src/expand.c    2006-09-26 
> 06:57:46.000000000 -0500
> @@ -823,13 +823,17 @@ static int sens_copy_callback(hashtab_ke
>     if (state->verbose)
>         INFO(state->handle, "copying sensitivity level %s", id);
>
> -    if ((new_level =
> -         (level_datum_t *) calloc(1, sizeof(*new_level))) == NULL
> -        || (new_level->level =
> -        (mls_level_t *) calloc(1, sizeof(mls_level_t))) == NULL
> -        || (new_id = strdup(id)) == NULL) {
> +    new_level = (level_datum_t *) malloc(sizeof(level_datum_t));
> +    if (!new_level)
> +        goto out_of_mem;
> +    level_datum_init(new_level);
> +    new_level->level = (mls_level_t *) malloc(sizeof(mls_level_t));
> +    if (!new_level->level)
> +        goto out_of_mem;
> +    mls_level_init(new_level->level);
> +    new_id = strdup(id);
> +    if (!new_id)
>         goto out_of_mem;
> -    }
>
>     if (mls_level_cpy(new_level->level, level->level)) {
>         goto out_of_mem;
> @@ -847,9 +851,10 @@ static int sens_copy_callback(hashtab_ke
>       out_of_mem:
>     ERR(state->handle, "Out of memory!");
>     if (new_level != NULL && new_level->level != NULL) {
> -        ebitmap_destroy(&new_level->level->cat);
> +        mls_level_destroy(new_level->level);
>         free(new_level->level);
>     }
> +    level_datum_destroy(new_level);
>     free(new_level);
>     free(new_id);
>     return -1;
> @@ -870,10 +875,13 @@ static int cats_copy_callback(hashtab_ke
>     if (state->verbose)
>         INFO(state->handle, "copying category attribute %s", id);
>
> -    if ((new_cat = (cat_datum_t *) calloc(1, sizeof(*new_cat))) == 
> NULL ||
> -        (new_id = strdup(id)) == NULL) {
> +    new_cat = (cat_datum_t *) malloc(sizeof(cat_datum_t));
> +    if (!new_cat)
> +        goto out_of_mem;
> +    cat_datum_init(new_cat);
> +    new_id = strdup(id);
> +    if (!new_id)
>         goto out_of_mem;
> -    }
>
>     new_cat->s.value = cat->s.value;
>     new_cat->isalias = cat->isalias;
> @@ -887,6 +895,7 @@ static int cats_copy_callback(hashtab_ke
>
>       out_of_mem:
>     ERR(state->handle, "Out of memory!");
> +    cat_datum_destroy(new_cat);
>     free(new_cat);
>     free(new_id);
>     return -1;
> diff -ruNp --exclude=.svn selinux/libsepol/src/link.c 
> selinux-modular-mls/libsepol/src/link.c
> --- selinux/libsepol/src/link.c    2006-09-05 06:44:54.000000000 -0500
> +++ selinux-modular-mls/libsepol/src/link.c    2006-09-26 
> 06:57:46.000000000 -0500
> @@ -468,25 +468,8 @@ static int user_copy_callback(hashtab_ke
>     char *id = key, *new_id = NULL;
>     user_datum_t *user, *base_user, *new_user = NULL;
>     link_state_t *state = (link_state_t *) data;
> -    scope_datum_t *scope;
>
>     user = (user_datum_t *) datum;
> -    if (state->base->mls) {
> -        scope =
> -            hashtab_search(state->cur->policy->p_users_scope.table, id);
> -        if (!scope) {
> -            ERR(state->handle,
> -                "No scope information for user %s in module %s\n",
> -                id, state->cur_mod_name);
> -            return -1;
> -        }
> -        if (scope->scope == SCOPE_DECL) {
> -            ERR(state->handle,
> -                "Users cannot be declared in MLS modules");
> -            return -1;
> -        }
> -        /* required users fall through */
> -    }
>
>     base_user = hashtab_search(state->base->p_users.table, id);
>     if (base_user == NULL) {
> @@ -502,9 +485,8 @@ static int user_copy_callback(hashtab_ke
>             goto cleanup;
>         }
>         user_datum_init(new_user);
> -        /* new_users's roles field will be copied during
> -           fix_user_callback().  the MLS fields are currently
> -           unimplemented */
> +        /* new_users's roles and MLS fields will be copied during
> +           user_fix_callback(). */
>
>         new_user->s.value = state->base->p_users.nprim + 1;
>
> @@ -592,10 +574,72 @@ static int bool_copy_callback(hashtab_ke
>     return -1;
> }
>
> +static int sens_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
> +                  void *data)
> +{
> +    char *id = key;
> +    level_datum_t *level, *base_level;
> +    link_state_t *state = (link_state_t *) data;
> +    scope_datum_t *scope;
> +
> +    level = (level_datum_t *) datum;
> +
> +    base_level = hashtab_search(state->base->p_levels.table, id);
> +    if (!base_level) {
> +        scope =
> +            hashtab_search(state->cur->policy->p_sens_scope.table, id);
> +        if (!scope)
> +            return -SEPOL_LINK_ERROR;
> +        if (scope->scope == SCOPE_DECL) {
> +            /* disallow declarations in modules */
> +            ERR(state->handle,
> +                "%s: Modules may not declare new sensitivities.",
> +                state->cur_mod_name);
> +            return -SEPOL_LINK_NOTSUP;
> +        }
> +    }
> +
> +    state->cur->map[SYM_LEVELS][level->level->sens - 1] =
> +        base_level->level->sens;
> +
> +    return 0;
> +}
> +
> +static int cat_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
> +                 void *data)
> +{
> +    char *id = key;
> +    cat_datum_t *cat, *base_cat;
> +    link_state_t *state = (link_state_t *) data;
> +    scope_datum_t *scope;
> +
> +    cat = (cat_datum_t *) datum;
> +
> +    base_cat = hashtab_search(state->base->p_cats.table, id);
> +    if (!base_cat) {
> +        scope =
> +            hashtab_search(state->cur->policy->p_cat_scope.table, id);
> +        if (!scope)
> +            return -SEPOL_LINK_ERROR;
> +        if (scope->scope == SCOPE_DECL) {
> +            /* disallow declarations in modules */
> +            ERR(state->handle,
> +                "%s: Modules may not declare new categories.",
> +                state->cur_mod_name);
> +            return -SEPOL_LINK_NOTSUP;
> +        }
> +    }
> +
> +    state->cur->map[SYM_CATS][cat->s.value - 1] = base_cat->s.value;
> +
> +    return 0;
> +}
> +
> static int (*copy_callback_f[SYM_NUM]) (hashtab_key_t key,
>                     hashtab_datum_t datum, void *datap) = {
> NULL, class_copy_callback, role_copy_callback, type_copy_callback,
> -        user_copy_callback, bool_copy_callback, NULL, NULL};
> +        user_copy_callback, bool_copy_callback, sens_copy_callback,
> +        cat_copy_callback};
>
> /* The aliases have to be copied after the types and attributes to be
>  * certain that the base symbol table will have the type that the
> @@ -783,6 +827,43 @@ static int role_set_or_convert(role_set_
>     return -1;
> }
>
> +static int mls_level_convert(mls_semantic_level_t * src,
> +                 mls_semantic_level_t * dst, policy_module_t * mod)
> +{
> +    mls_semantic_cat_t *src_cat, *new_cat;
> +
> +    assert(mod->map[SYM_LEVELS][src->sens - 1]);
> +    dst->sens = mod->map[SYM_LEVELS][src->sens - 1];
> +
> +    for (src_cat = src->cat; src_cat; src_cat = src_cat->next) {
> +        new_cat =
> +            (mls_semantic_cat_t *) malloc(sizeof(mls_semantic_cat_t));
> +        if (!new_cat)
> +            return -1;
> +        mls_semantic_cat_init(new_cat);
> +
> +        new_cat->next = dst->cat;
> +        dst->cat = new_cat;
> +
> +        assert(mod->map[SYM_CATS][src_cat->low - 1]);
> +        dst->cat->low = mod->map[SYM_CATS][src_cat->low - 1];
> +        assert(mod->map[SYM_CATS][src_cat->high - 1]);
> +        dst->cat->high = mod->map[SYM_CATS][src_cat->high - 1];
> +    }
> +
> +    return 0;
> +}
> +
> +static int mls_range_convert(mls_semantic_range_t * src,
> +                 mls_semantic_range_t * dst, policy_module_t * mod)
> +{
> +    if (mls_level_convert(&src->level[0], &dst->level[0], mod))
> +        return -1;
> +    if (mls_level_convert(&src->level[1], &dst->level[1], mod))
> +        return -1;
> +    return 0;
> +}
> +
> static int role_fix_callback(hashtab_key_t key, hashtab_datum_t datum,
>                  void *data)
> {
> @@ -893,13 +974,16 @@ static int user_fix_callback(hashtab_key
>     user_datum_t *user, *new_user = NULL;
>     link_state_t *state = (link_state_t *) data;
>     policy_module_t *mod = state->cur;
> +    symtab_t *usertab;
>
>     user = (user_datum_t *) datum;
>
>     if (state->dest_decl == NULL)
> -        return 0;
> +        usertab = &state->base->p_users;
> +    else
> +        usertab = &state->dest_decl->p_users;
>
> -    new_user = hashtab_search(state->dest_decl->p_users.table, id);
> +    new_user = hashtab_search(usertab->table, id);
>     assert(new_user != NULL);
>
>     if (state->verbose) {
> @@ -910,6 +994,12 @@ static int user_fix_callback(hashtab_key
>         goto cleanup;
>     }
>
> +    if (mls_range_convert(&user->range, &new_user->range, mod))
> +        goto cleanup;
> +
> +    if (mls_level_convert(&user->dfltlevel, &new_user->dfltlevel, mod))
> +        goto cleanup;
> +
>     return 0;
>
>       cleanup:
> @@ -1096,6 +1186,55 @@ static int copy_role_allow_list(role_all
>     return -1;
> }
>
> +static int copy_range_trans_list(range_trans_rule_t * rules,
> +                 range_trans_rule_t ** dst,
> +                 policy_module_t * mod, link_state_t * state)
> +{
> +    range_trans_rule_t *rule, *new_rule = NULL;
> +    unsigned int i;
> +    ebitmap_node_t *cnode;
> +
> +    for (rule = rules; rule; rule = rule->next) {
> +        new_rule =
> +            (range_trans_rule_t *) malloc(sizeof(range_trans_rule_t));
> +        if (!new_rule)
> +            goto cleanup;
> +
> +        range_trans_rule_init(new_rule);
> +
> +        new_rule->next = *dst;
> +        *dst = new_rule;
> +
> +        if (type_set_convert(&rule->stypes, &new_rule->stypes,
> +                     mod, state))
> +            goto cleanup;
> +
> +        if (type_set_convert(&rule->ttypes, &new_rule->ttypes,
> +                     mod, state))
> +            goto cleanup;
> +
> +        ebitmap_for_each_bit(&rule->tclasses, cnode, i) {
> +            if (ebitmap_node_get_bit(cnode, i)) {
> +                assert(mod->map[SYM_CLASSES][i]);
> +                if (ebitmap_set_bit
> +                    (&new_rule->tclasses,
> +                     mod->map[SYM_CLASSES][i] - 1, 1)) {
> +                    goto cleanup;
> +                }
> +            }
> +        }
> +
> +        if (mls_range_convert(&rule->trange, &new_rule->trange, mod))
> +            goto cleanup;
> +    }
> +    return 0;
> +
> +      cleanup:
> +    ERR(state->handle, "Out of memory!");
> +    range_trans_rule_list_destroy(new_rule);
> +    return -1;
> +}
> +
> static int copy_cond_list(cond_node_t * list, cond_node_t ** dst,
>               policy_module_t * module, link_state_t * state)
> {
> @@ -1278,6 +1417,10 @@ static int copy_avrule_decl(link_state_t
>         return -1;
>     }
>
> +    if (copy_range_trans_list(src_decl->range_tr_rules,
> +                  &dest_decl->range_tr_rules, module, state))
> +        return -1;
> +
>     /* finally copy any identifiers local to this declaration */
>     ret = copy_identifiers(state, src_decl->symtab, dest_decl);
>     if (ret < 0) {
> diff -ruNp --exclude=.svn selinux/libsepol/src/policydb.c 
> selinux-modular-mls/libsepol/src/policydb.c
> --- selinux/libsepol/src/policydb.c    2006-09-05 06:44:54.000000000 
> -0500
> +++ selinux-modular-mls/libsepol/src/policydb.c    2006-09-26 
> 06:57:46.000000000 -0500
> @@ -252,6 +252,29 @@ void user_datum_destroy(user_datum_t * x
>     }
> }
>
> +void level_datum_init(level_datum_t * x)
> +{
> +    memset(x, 0, sizeof(level_datum_t));
> +}
> +
> +void level_datum_destroy(level_datum_t * x __attribute__ ((unused)))
> +{
> +    /* the mls_level_t referenced by the level_datum is managed
> +     * separately for now, so there is nothing to destroy */
> +    return;
> +}
> +
> +void cat_datum_init(cat_datum_t * x)
> +{
> +    memset(x, 0, sizeof(cat_datum_t));
> +}
> +
> +void cat_datum_destroy(cat_datum_t * x __attribute__ ((unused)))
> +{
> +    /* it's currently a simple struct - really nothing to destroy */
> +    return;
> +}
> +
> void class_perm_node_init(class_perm_node_t * x)
> {
>     memset(x, 0, sizeof(class_perm_node_t));
> @@ -502,7 +525,11 @@ int policydb_user_cache(hashtab_key_t ke
>         return -1;
>     }
>
> -    if (p->policy_type != POLICY_KERN) {
> +    /* we do not expand user's MLS info in kernel policies because the
> +     * semantic representation is not present and we do not expand 
> user's
> +     * MLS info in module policies because all of the necessary mls
> +     * information is not present */
> +    if (p->policy_type != POLICY_KERN && p->policy_type != POLICY_MOD) {
>         mls_range_destroy(&user->exp_range);
>         if (mls_semantic_range_expand(&user->range,
>                           &user->exp_range, p, NULL)) {
> @@ -907,9 +934,10 @@ static int sens_destroy(hashtab_key_t ke
>     if (key)
>         free(key);
>     levdatum = (level_datum_t *) datum;
> -    ebitmap_destroy(&levdatum->level->cat);
> +    mls_level_destroy(levdatum->level);
>     free(levdatum->level);
> -    free(datum);
> +    level_datum_destroy(levdatum);
> +    free(levdatum);
>     return 0;
> }
>
> @@ -918,6 +946,7 @@ static int cat_destroy(hashtab_key_t key
> {
>     if (key)
>         free(key);
> +    cat_datum_destroy((cat_datum_t *) datum);
>     free(datum);
>     return 0;
> }
> @@ -2199,7 +2228,7 @@ static int mls_read_level(mls_level_t * {
>     uint32_t *buf;
>
> -    memset(lp, 0, sizeof(mls_level_t));
> +    mls_level_init(lp);
>
>     buf = next_entry(fp, sizeof(uint32_t));
>     if (!buf) {
> @@ -2305,9 +2334,10 @@ static int sens_read(policydb_t * p
>     level_datum_t *levdatum;
>     uint32_t *buf, len;
>
> -    levdatum = calloc(1, sizeof(level_datum_t));
> +    levdatum = malloc(sizeof(level_datum_t));
>     if (!levdatum)
>         return -1;
> +    level_datum_init(levdatum);
>
>     buf = next_entry(fp, (sizeof(uint32_t) * 2));
>     if (!buf)
> @@ -2347,9 +2377,10 @@ static int cat_read(policydb_t * p
>     cat_datum_t *catdatum;
>     uint32_t *buf, len;
>
> -    catdatum = calloc(1, sizeof(cat_datum_t));
> +    catdatum = malloc(sizeof(cat_datum_t));
>     if (!catdatum)
>         return -1;
> +    cat_datum_init(catdatum);
>
>     buf = next_entry(fp, (sizeof(uint32_t) * 3));
>     if (!buf)
Acked-By: Joshua Brindle <jbrindle@tresys.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
