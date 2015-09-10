Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8AH2dNo019010
 for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2015 13:02:39 -0400
Received: by wicmn1 with SMTP id mn1so5192035wic.3
 for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2015 10:02:33 -0700 (PDT)
Date: Thu, 10 Sep 2015 19:02:31 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH] libsepol/cil: Add userattribute{set} functionality
Message-ID: <20150910170230.GB26300@x250>
References: <1441904165-35874-1-git-send-email-ykhodorkovskiy@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <1441904165-35874-1-git-send-email-ykhodorkovskiy@tresys.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Thu, Sep 10, 2015 at 12:56:05PM -0400, Yuli Khodorkovskiy wrote:
> This adds a userattribute statement that may be used in userroles and
> constraints. The syntax is the same as typeattributset.
> 
> Also, disallow roleattributes where roles are accepted in contexts.

what does this mean?

> 
> Specify a userattribute
> 
>     (userattribute foo)
> 
> Add users to the set foo
> 
>     (userattributeset foo (u1 u2))
> 
> Signed-off-by: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
> ---
>  libsepol/cil/src/cil.c                    |  36 ++++++
>  libsepol/cil/src/cil_binary.c             |  99 +++++++++++-----
>  libsepol/cil/src/cil_binary.h             |   7 +-
>  libsepol/cil/src/cil_build_ast.c          | 129 ++++++++++++++++++++-
>  libsepol/cil/src/cil_build_ast.h          |   4 +
>  libsepol/cil/src/cil_copy_ast.c           |  41 +++++++
>  libsepol/cil/src/cil_copy_ast.h           |   2 +
>  libsepol/cil/src/cil_flavor.h             |   2 +
>  libsepol/cil/src/cil_internal.h           |  23 +++-
>  libsepol/cil/src/cil_policy.c             |   5 -
>  libsepol/cil/src/cil_post.c               | 182 ++++++++++++++++++++++++++++++
>  libsepol/cil/src/cil_reset_ast.c          |  33 +++++-
>  libsepol/cil/src/cil_resolve_ast.c        | 114 +++++++++++++++++--
>  libsepol/cil/src/cil_resolve_ast.h        |   1 +
>  libsepol/cil/src/cil_tree.c               |  22 +++-
>  libsepol/cil/src/cil_verify.c             |  12 +-
>  secilc/docs/cil_constraint_statements.xml |   8 +-
>  secilc/docs/cil_user_statements.xml       | 110 +++++++++++++++++-
>  secilc/test/policy.cil                    |  22 +++-
>  19 files changed, 786 insertions(+), 66 deletions(-)
> 
> diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> index a89c585..8716deb 100644
> --- a/libsepol/cil/src/cil.c
> +++ b/libsepol/cil/src/cil.c
> @@ -122,6 +122,8 @@ static void cil_init_keys(void)
>  	CIL_KEY_TYPE = cil_strpool_add("type");
>  	CIL_KEY_ROLE = cil_strpool_add("role");
>  	CIL_KEY_USER = cil_strpool_add("user");
> +	CIL_KEY_USERATTRIBUTE = cil_strpool_add("userattribute");
> +	CIL_KEY_USERATTRIBUTESET = cil_strpool_add("userattributeset");
>  	CIL_KEY_SENSITIVITY = cil_strpool_add("sensitivity");
>  	CIL_KEY_CATEGORY = cil_strpool_add("category");
>  	CIL_KEY_CATSET = cil_strpool_add("categoryset");
> @@ -266,9 +268,11 @@ void cil_db_init(struct cil_db **db)
>  	(*db)->num_classes = 0;
>  	(*db)->num_types = 0;
>  	(*db)->num_roles = 0;
> +	(*db)->num_users = 0;
>  	(*db)->num_cats = 0;
>  	(*db)->val_to_type = NULL;
>  	(*db)->val_to_role = NULL;
> +	(*db)->val_to_user = NULL;
>  
>  	(*db)->disable_dontaudit = CIL_FALSE;
>  	(*db)->disable_neverallow = CIL_FALSE;
> @@ -311,6 +315,7 @@ void cil_db_destroy(struct cil_db **db)
>  	cil_strpool_destroy();
>  	free((*db)->val_to_type);
>  	free((*db)->val_to_role);
> +	free((*db)->val_to_user);
>  
>  	free(*db);
>  	*db = NULL;	
> @@ -552,6 +557,12 @@ void cil_destroy_data(void **data, enum cil_flavor flavor)
>  	case CIL_USER:
>  		cil_destroy_user(*data);
>  		break;
> +	case CIL_USERATTRIBUTE:
> +		cil_destroy_userattribute(*data);
> +		break;
> +	case CIL_USERATTRIBUTESET:
> +		cil_destroy_userattributeset(*data);
> +		break;
>  	case CIL_USERPREFIX:
>  		cil_destroy_userprefix(*data);
>  		break;
> @@ -794,6 +805,7 @@ int cil_flavor_to_symtab_index(enum cil_flavor flavor, enum cil_sym_index *sym_i
>  		*sym_index = CIL_SYM_CLASSPERMSETS;
>  		break;
>  	case CIL_USER:
> +	case CIL_USERATTRIBUTE:
>  		*sym_index = CIL_SYM_USERS;
>  		break;
>  	case CIL_ROLE:
> @@ -924,6 +936,10 @@ const char * cil_node_to_string(struct cil_tree_node *node)
>  		return CIL_KEY_CLASSPERMISSIONSET;
>  	case CIL_USER:
>  		return CIL_KEY_USER;
> +	case CIL_USERATTRIBUTE:
> +		return CIL_KEY_USERATTRIBUTE;
> +	case CIL_USERATTRIBUTESET:
> +		return CIL_KEY_USERATTRIBUTESET;
>  	case CIL_USERPREFIX:
>  		return CIL_KEY_USERPREFIX;
>  	case CIL_USERROLE:
> @@ -2379,6 +2395,26 @@ void cil_user_init(struct cil_user **user)
>  	(*user)->roles = NULL;
>  	(*user)->dftlevel = NULL;
>  	(*user)->range = NULL;
> +	(*user)->value = 0;
> +}
> +
> +void cil_userattribute_init(struct cil_userattribute **attr)
> +{
> +	*attr = cil_malloc(sizeof(**attr));
> +
> +	cil_symtab_datum_init(&(*attr)->datum);
> +
> +	(*attr)->expr_list = NULL;
> +	(*attr)->users = NULL;
> +}
> +
> +void cil_userattributeset_init(struct cil_userattributeset **attrset)
> +{
> +	*attrset = cil_malloc(sizeof(**attrset));
> +
> +	(*attrset)->attr_str = NULL;
> +	(*attrset)->str_expr = NULL;
> +	(*attrset)->datum_expr = NULL;
>  }
>  
>  void cil_userlevel_init(struct cil_userlevel **usrlvl)
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index 52ce067..32304e2 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -144,6 +144,34 @@ static int __cil_get_sepol_level_datum(policydb_t *pdb, struct cil_symtab_datum
>  	return SEPOL_OK;
>  }
>  
> +static int __cil_expand_user(struct cil_symtab_datum *datum, ebitmap_t *new)
> +{
> +	struct cil_tree_node *node = datum->nodes->head->data;
> +	struct cil_user *user = NULL;
> +	struct cil_userattribute *attr = NULL;
> +
> +	if (node->flavor == CIL_USERATTRIBUTE) {
> +		attr = (struct cil_userattribute *)datum;
> +		if (ebitmap_cpy(new, attr->users)) {
> +			cil_log(CIL_ERR, "Failed to copy user bits\n");
> +			goto exit;
> +		}
> +	} else {
> +		user = (struct cil_user *)datum;
> +		ebitmap_init(new);
> +		if (ebitmap_set_bit(new, user->value, 1)) {
> +			cil_log(CIL_ERR, "Failed to set user bit\n");
> +			ebitmap_destroy(new);
> +			goto exit;
> +		}
> +	}
> +
> +	return SEPOL_OK;
> +
> +exit:
> +	return SEPOL_ERR;
> +}
> +
>  static int __cil_expand_role(struct cil_symtab_datum *datum, ebitmap_t *new)
>  {
>  	struct cil_tree_node *node = datum->nodes->head->data;
> @@ -746,43 +774,41 @@ exit:
>  	return SEPOL_ERR;
>  }
>  
> -int cil_userrole_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_userrole *userrole)
> +int cil_userrole_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_user *user)
>  {
>  	int rc = SEPOL_ERR;
>  	user_datum_t *sepol_user = NULL;
>  	role_datum_t *sepol_role = NULL;
> -	ebitmap_t role_bitmap;
> -	ebitmap_node_t *rnode;
> +	ebitmap_node_t *rnode = NULL;
>  	unsigned int i;
>  
> -	rc = __cil_get_sepol_user_datum(pdb, DATUM(userrole->user), &sepol_user);
> -	if (rc != SEPOL_OK) goto exit;
> -
> -	rc = __cil_expand_role(userrole->role, &role_bitmap);
> -	if (rc != SEPOL_OK) goto exit;
> -
> -	ebitmap_for_each_bit(&role_bitmap, rnode, i) {
> -		if (!ebitmap_get_bit(&role_bitmap, i)) continue;
> +	if (user->roles) {
> +		rc = __cil_get_sepol_user_datum(pdb, DATUM(user), &sepol_user);
> +		if (rc != SEPOL_OK) {
> +			goto exit;
> +		}
>  
> -		rc = __cil_get_sepol_role_datum(pdb, DATUM(db->val_to_role[i]), &sepol_role);
> -		if (rc != SEPOL_OK) goto exit;
> +		ebitmap_for_each_bit(user->roles, rnode, i) {
> +			if (!ebitmap_get_bit(user->roles, i)) {
> +				continue;
> +			}
>  
> -		if (sepol_role->s.value == 1) {
> -			// role is object_r, ignore it since it is implicitly associated
> -			// with all users
> -			continue;
> -		}
> +			rc = __cil_get_sepol_role_datum(pdb, DATUM(db->val_to_role[i]), &sepol_role);
> +			if (rc != SEPOL_OK) {
> +				goto exit;
> +			}
>  
> -		if (ebitmap_set_bit(&sepol_user->roles.roles, sepol_role->s.value - 1, 1)) {
> -			cil_log(CIL_INFO, "Failed to set role bit for user\n");
> -			goto exit;
> +			if (ebitmap_set_bit(&sepol_user->roles.roles, sepol_role->s.value - 1, 1)) {
> +				cil_log(CIL_INFO, "Failed to set role bit for user\n");
> +				rc = SEPOL_ERR;
> +				goto exit;
> +			}
>  		}
>  	}
>  
>  	rc = SEPOL_OK;
>  
>  exit:
> -	ebitmap_destroy(&role_bitmap);
>  	return rc;
>  }
>  
> @@ -2183,12 +2209,30 @@ int __cil_constrain_expr_datum_to_sepol_expr(policydb_t *pdb, const struct cil_d
>  
>  	if (expr_flavor == CIL_USER) {
>  		user_datum_t *sepol_user = NULL;
> -		rc = __cil_get_sepol_user_datum(pdb, item->data, &sepol_user);
> +		ebitmap_t user_bitmap;
> +		ebitmap_node_t *unode;
> +		unsigned int i;
> +
> +		rc = __cil_expand_user(item->data, &user_bitmap);
>  		if (rc != SEPOL_OK) goto exit;
>  
> -		if (ebitmap_set_bit(&expr->names, sepol_user->s.value - 1, 1)) {
> -			goto exit;
> +		ebitmap_for_each_bit(&user_bitmap, unode, i) {
> +			if (!ebitmap_get_bit(&user_bitmap, i)) {
> +				continue;
> +			}
> +
> +			rc = __cil_get_sepol_user_datum(pdb, DATUM(db->val_to_user[i]), &sepol_user);
> +			if (rc != SEPOL_OK) {
> +				ebitmap_destroy(&user_bitmap);
> +				goto exit;
> +			}
> +
> +			if (ebitmap_set_bit(&expr->names, sepol_user->s.value - 1, 1)) {
> +				ebitmap_destroy(&user_bitmap);
> +				goto exit;
> +			}
>  		}
> +		ebitmap_destroy(&user_bitmap);
>  	} else if (expr_flavor == CIL_ROLE) {
>  		role_datum_t *sepol_role = NULL;
>  		ebitmap_t role_bitmap;
> @@ -3374,9 +3418,10 @@ int __cil_node_to_policydb(struct cil_tree_node *node, void *extra_args)
>  			if (rc != SEPOL_OK) goto exit;
>  			if (pdb->mls == CIL_TRUE) {
>  				rc = cil_userlevel_userrange_to_policydb(pdb, node->data);
> +				if (rc != SEPOL_OK) {
> +					goto exit;
> +				}
>  			}
> -			break;
> -		case CIL_USERROLE:
>  			rc = cil_userrole_to_policydb(pdb, db, node->data);
>  			break;
>  		case CIL_TYPE_RULE:
> diff --git a/libsepol/cil/src/cil_binary.h b/libsepol/cil/src/cil_binary.h
> index 33b43f9..c59b1e3 100644
> --- a/libsepol/cil/src/cil_binary.h
> +++ b/libsepol/cil/src/cil_binary.h
> @@ -184,12 +184,13 @@ int cil_user_to_policydb(policydb_t *pdb, struct cil_user *cil_user);
>  /**
>   * Insert cil userrole structure into sepol policydb.
>   *
> - * @param[in] pdb THe policy database to insert the userrole into.
> - * @param[in] datum The cil_userrole datum.
> + * @param[in] pdb The policy database to insert the userrole into.
> + * @param[in] db The cil database
> + * @param[in] datum The cil_user
>   *
>   * @return SEPOL_OK upon success or SEPOL_ERR otherwise.
>   */
> -int cil_userrole_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_userrole *userrole);
> +int cil_userrole_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_user *user);
>  
>  /**
>   * Insert cil bool structure into sepol policydb.
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> index 32ebee1..861b606 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -1196,10 +1196,132 @@ void cil_destroy_user(struct cil_user *user)
>  	}
>  
>  	cil_symtab_datum_destroy(&user->datum);
> -	cil_list_destroy(&user->roles, CIL_FALSE);
> +	ebitmap_destroy(user->roles);
> +	free(user->roles);
>  	free(user);
>  }
>  
> +int cil_gen_userattribute(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +{
> +	enum cil_syntax syntax[] = {
> +		CIL_SYN_STRING,
> +		CIL_SYN_STRING,
> +		CIL_SYN_END
> +	};
> +	int syntax_len = sizeof(syntax)/sizeof(*syntax);
> +	char *key = NULL;
> +	struct cil_userattribute *attr = NULL;
> +	int rc = SEPOL_ERR;
> +
> +	if (parse_current == NULL || ast_node == NULL) {
> +		goto exit;
> +	}
> +
> +	rc = __cil_verify_syntax(parse_current, syntax, syntax_len);
> +	if (rc != SEPOL_OK) {
> +		goto exit;
> +	}
> +
> +	cil_userattribute_init(&attr);
> +
> +	key = parse_current->next->data;
> +	rc = cil_gen_node(db, ast_node, (struct cil_symtab_datum*)attr, (hashtab_key_t)key, CIL_SYM_USERS, CIL_USERATTRIBUTE);
> +	if (rc != SEPOL_OK) {
> +		goto exit;
> +	}
> +
> +	return SEPOL_OK;
> +exit:
> +	cil_log(CIL_ERR, "Bad userattribute declaration at line %d of %s\n",
> +		parse_current->line, parse_current->path);
> +	cil_destroy_userattribute(attr);
> +	cil_clear_node(ast_node);
> +	return rc;
> +}
> +
> +void cil_destroy_userattribute(struct cil_userattribute *attr)
> +{
> +	struct cil_list_item *expr = NULL;
> +	struct cil_list_item *next = NULL;
> +
> +	if (attr == NULL) {
> +		return;
> +	}
> +
> +	if (attr->expr_list != NULL) {
> +		/* we don't want to destroy the expression stacks (cil_list) inside
> +		 * this list cil_list_destroy destroys sublists, so we need to do it
> +		 * manually */
> +		expr = attr->expr_list->head;
> +		while (expr != NULL) {
> +			next = expr->next;
> +			cil_list_item_destroy(&expr, CIL_FALSE);
> +			expr = next;
> +		}
> +		free(attr->expr_list);
> +		attr->expr_list = NULL;
> +	}
> +
> +	cil_symtab_datum_destroy(&attr->datum);
> +	ebitmap_destroy(attr->users);
> +	free(attr->users);
> +	free(attr);
> +}
> +
> +int cil_gen_userattributeset(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +{
> +	enum cil_syntax syntax[] = {
> +		CIL_SYN_STRING,
> +		CIL_SYN_STRING,
> +		CIL_SYN_STRING | CIL_SYN_LIST,
> +		CIL_SYN_END
> +	};
> +	int syntax_len = sizeof(syntax)/sizeof(*syntax);
> +	struct cil_userattributeset *attrset = NULL;
> +	int rc = SEPOL_ERR;
> +
> +	if (db == NULL || parse_current == NULL || ast_node == NULL) {
> +		goto exit;
> +	}
> +
> +	rc = __cil_verify_syntax(parse_current, syntax, syntax_len);
> +	if (rc != SEPOL_OK) {
> +		goto exit;
> +	}
> +
> +	cil_userattributeset_init(&attrset);
> +
> +	attrset->attr_str = parse_current->next->data;
> +
> +	rc = cil_gen_expr(parse_current->next->next, CIL_USER, &attrset->str_expr);
> +	if (rc != SEPOL_OK) {
> +		goto exit;
> +	}
> +	ast_node->data = attrset;
> +	ast_node->flavor = CIL_USERATTRIBUTESET;
> +
> +	return SEPOL_OK;
> +
> +exit:
> +	cil_log(CIL_ERR, "Bad userattributeset declaration at line %d of %s\n",
> +		parse_current->line, parse_current->path);
> +	cil_destroy_userattributeset(attrset);
> +
> +	return rc;
> +}
> +
> +void cil_destroy_userattributeset(struct cil_userattributeset *attrset)
> +{
> +	if (attrset == NULL) {
> +		return;
> +	}
> +
> +	cil_list_destroy(&attrset->str_expr, CIL_TRUE);
> +	cil_list_destroy(&attrset->datum_expr, CIL_FALSE);
> +
> +	free(attrset);
> +}
> +
>  int cil_gen_userlevel(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
> @@ -5855,6 +5977,11 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
>  		*finished = CIL_TREE_SKIP_NEXT;
>  	} else if (parse_current->data == CIL_KEY_USER) {
>  		rc = cil_gen_user(db, parse_current, ast_node);
> +	} else if (parse_current->data == CIL_KEY_USERATTRIBUTE) {
> +		rc = cil_gen_userattribute(db, parse_current, ast_node);
> +	} else if (parse_current->data == CIL_KEY_USERATTRIBUTESET) {
> +		rc = cil_gen_userattributeset(db, parse_current, ast_node);
> +		*finished = CIL_TREE_SKIP_NEXT;
>  	} else if (parse_current->data == CIL_KEY_USERLEVEL) {
>  		rc = cil_gen_userlevel(db, parse_current, ast_node);
>  		*finished = CIL_TREE_SKIP_NEXT;
> diff --git a/libsepol/cil/src/cil_build_ast.h b/libsepol/cil/src/cil_build_ast.h
> index 1b40ae5..11f51f5 100644
> --- a/libsepol/cil/src/cil_build_ast.h
> +++ b/libsepol/cil/src/cil_build_ast.h
> @@ -80,6 +80,10 @@ int cil_gen_sidorder(struct cil_db *db, struct cil_tree_node *parse_current, str
>  void cil_destroy_sidorder(struct cil_sidorder *sidorder);
>  int cil_gen_user(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
>  void cil_destroy_user(struct cil_user *user);
> +int cil_gen_userattribute(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
> +void cil_destroy_userattribute(struct cil_userattribute *attr);
> +int cil_gen_userattributeset(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
> +void cil_destroy_userattributeset(struct cil_userattributeset *attrset);
>  int cil_gen_userlevel(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
>  void cil_destroy_userlevel(struct cil_userlevel *usrlvl);
>  int cil_gen_userrange(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
> diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
> index d488870..8c50ff0 100644
> --- a/libsepol/cil/src/cil_copy_ast.c
> +++ b/libsepol/cil/src/cil_copy_ast.c
> @@ -392,6 +392,41 @@ int cil_copy_user(__attribute__((unused)) struct cil_db *db, void *data, void **
>  	return SEPOL_OK;
>  }
>  
> +int cil_copy_userattribute(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
> +{
> +	struct cil_userattribute *orig = data;
> +	struct cil_userattribute *new = NULL;
> +	char *key = orig->datum.name;
> +	struct cil_symtab_datum *datum = NULL;
> +
> +	cil_symtab_get_datum(symtab, key, &datum);
> +	if (datum == NULL) {
> +		cil_userattribute_init(&new);
> +		*copy = new;
> +	} else {
> +		*copy = datum;
> +	}
> +
> +	return SEPOL_OK;
> +}
> +
> +int cil_copy_userattributeset(struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
> +{
> +	struct cil_userattributeset *orig = data;
> +	struct cil_userattributeset *new = NULL;
> +
> +	cil_userattributeset_init(&new);
> +
> +	new->attr_str = orig->attr_str;
> +
> +	cil_copy_expr(db, orig->str_expr, &new->str_expr);
> +	cil_copy_expr(db, orig->datum_expr, &new->datum_expr);
> +
> +	*copy = new;
> +
> +	return SEPOL_OK;
> +}
> +
>  int cil_copy_userrole(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
>  {
>  	struct cil_userrole *orig = data;
> @@ -1717,6 +1752,12 @@ int __cil_copy_node_helper(struct cil_tree_node *orig, __attribute__((unused)) u
>  	case CIL_USER:
>  		copy_func = &cil_copy_user;
>  		break;
> +	case CIL_USERATTRIBUTE:
> +		copy_func = &cil_copy_userattribute;
> +		break;
> +	case CIL_USERATTRIBUTESET:
> +		copy_func = &cil_copy_userattributeset;
> +		break;
>  	case CIL_USERROLE:
>  		copy_func = &cil_copy_userrole;
>  		break;
> diff --git a/libsepol/cil/src/cil_copy_ast.h b/libsepol/cil/src/cil_copy_ast.h
> index bd3a231..78c34b8 100644
> --- a/libsepol/cil/src/cil_copy_ast.h
> +++ b/libsepol/cil/src/cil_copy_ast.h
> @@ -57,6 +57,8 @@ int cil_copy_sid(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
>  int cil_copy_sidcontext(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
>  int cil_copy_sidorder(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
>  int cil_copy_user(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
> +int cil_copy_userattribute(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
> +int cil_copy_userattributeset(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
>  int cil_copy_userrole(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
>  int cil_copy_userlevel(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
>  int cil_copy_userrange(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
> diff --git a/libsepol/cil/src/cil_flavor.h b/libsepol/cil/src/cil_flavor.h
> index 79483c7..9fb5083 100644
> --- a/libsepol/cil/src/cil_flavor.h
> +++ b/libsepol/cil/src/cil_flavor.h
> @@ -63,6 +63,7 @@ enum cil_flavor {
>  	CIL_CLASSPERMISSIONSET,
>  	CIL_USERPREFIX,
>  	CIL_USERROLE,
> +	CIL_USERATTRIBUTESET,
>  	CIL_USERLEVEL,
>  	CIL_USERRANGE,
>  	CIL_USERBOUNDS,
> @@ -164,6 +165,7 @@ enum cil_flavor {
>  	CIL_MAP_CLASS,
>  	CIL_CLASSPERMISSION,
>  	CIL_USER,
> +	CIL_USERATTRIBUTE,
>  	CIL_ROLE,
>  	CIL_ROLEATTRIBUTE,
>  	CIL_TYPE,
> diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
> index e596ab5..a736eff 100644
> --- a/libsepol/cil/src/cil_internal.h
> +++ b/libsepol/cil/src/cil_internal.h
> @@ -127,6 +127,8 @@ char *CIL_KEY_TRANS;
>  char *CIL_KEY_TYPE;
>  char *CIL_KEY_ROLE;
>  char *CIL_KEY_USER;
> +char *CIL_KEY_USERATTRIBUTE;
> +char *CIL_KEY_USERATTRIBUTESET;
>  char *CIL_KEY_SENSITIVITY;
>  char *CIL_KEY_CATEGORY;
>  char *CIL_KEY_CATSET;
> @@ -290,8 +292,10 @@ struct cil_db {
>  	int num_cats;
>  	int num_types;
>  	int num_roles;
> +	int num_users;
>  	struct cil_type **val_to_type;
>  	struct cil_role **val_to_role;
> +	struct cil_user **val_to_user;
>  	int disable_dontaudit;
>  	int disable_neverallow;
>  	int preserve_tunables;
> @@ -418,14 +422,27 @@ struct cil_sidorder {
>  struct cil_user {
>  	struct cil_symtab_datum datum;
>  	struct cil_user *bounds;
> -	struct cil_list *roles;
> +	ebitmap_t *roles;
>  	struct cil_level *dftlevel;
>  	struct cil_levelrange *range;
> +	int value;
> +};
> +
> +struct cil_userattribute {
> +	struct cil_symtab_datum datum;
> +	struct cil_list *expr_list;
> +	ebitmap_t *users;
> +};
> +
> +struct cil_userattributeset {
> +	char *attr_str;
> +	struct cil_list *str_expr;
> +	struct cil_list *datum_expr;
>  };
>  
>  struct cil_userrole {
>  	char *user_str;
> -	struct cil_user *user;
> +	void *user;
>  	char *role_str;
>  	void *role;
>  };
> @@ -1002,5 +1019,7 @@ void cil_default_init(struct cil_default **def);
>  void cil_defaultrange_init(struct cil_defaultrange **def);
>  void cil_handleunknown_init(struct cil_handleunknown **unk);
>  void cil_mls_init(struct cil_mls **mls);
> +void cil_userattribute_init(struct cil_userattribute **attribute);
> +void cil_userattributeset_init(struct cil_userattributeset **attrset);
>  
>  #endif
> diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
> index eefcbc1..a9e2426 100644
> --- a/libsepol/cil/src/cil_policy.c
> +++ b/libsepol/cil/src/cil_policy.c
> @@ -1155,11 +1155,6 @@ int __cil_gen_policy_node_helper(struct cil_tree_node *node, uint32_t *finished,
>  		case CIL_USER:
>  			cil_multimap_insert(users, node->data, NULL, CIL_USERROLE, CIL_NONE);
>  			break;
> -		case CIL_USERROLE: {
> -			struct cil_userrole *userrole = node->data;
> -			cil_multimap_insert(users, &userrole->user->datum, (struct cil_symtab_datum *)userrole->role, CIL_USERROLE, CIL_ROLE);
> -		}
> -			break;
>  		case CIL_CATALIAS: {
>  			struct cil_alias *alias = node->data;
>  			struct cil_symtab_datum *datum = alias->actual;
> diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> index c4ea66a..8050bbb 100644
> --- a/libsepol/cil/src/cil_post.c
> +++ b/libsepol/cil/src/cil_post.c
> @@ -375,6 +375,17 @@ static int __cil_post_db_count_helper(struct cil_tree_node *node, uint32_t *fini
>  		}
>  		break;
>  	}
> +	case CIL_USER: {
> +		struct cil_user *user = node->data;
> +		if (user->datum.nodes->head->data == node) {
> +			// multiple AST nodes can point to the same cil_user data (like if
> +			// copied from a macro). This check ensures we only count the
> +			// duplicates once
> +			user->value = db->num_users;
> +			db->num_users++;
> +		}
> +		break;
> +	}
>  	case CIL_NETIFCON:
>  		db->netifcon->count++;
>  		break;
> @@ -446,6 +457,14 @@ static int __cil_post_db_array_helper(struct cil_tree_node *node, __attribute__(
>  		db->val_to_role[role->value] = role;
>  		break;
>  	}
> +	case CIL_USER: {
> +		struct cil_user *user= node->data;
> +		if (db->val_to_user == NULL) {
> +			db->val_to_user = cil_malloc(sizeof(*db->val_to_user) * db->num_users);
> +		}
> +		db->val_to_user[user->value] = user;
> +		break;
> +	}
>  	case CIL_USERPREFIX: {
>  		cil_list_append(db->userprefixes, CIL_USERPREFIX, node->data);
>  		break;
> @@ -638,6 +657,54 @@ exit:
>  	return rc;
>  }
>  
> +static int __evaluate_user_expression(struct cil_userattribute *attr, struct cil_db *db)
> +{
> +	int rc;
> +
> +	attr->users = cil_malloc(sizeof(*attr->users));
> +	rc = __cil_expr_list_to_bitmap(attr->expr_list, attr->users, db->num_users, db);
> +	if (rc != SEPOL_OK) {
> +		cil_log(CIL_ERR, "Failed to expand user attribute to bitmap\n");
> +		ebitmap_destroy(attr->users);
> +		free(attr->users);
> +		attr->users = NULL;
> +	}
> +	return rc;
> +}
> +
> +static int __cil_user_to_bitmap(struct cil_symtab_datum *datum, ebitmap_t *bitmap, struct cil_db *db)
> +{
> +	int rc = SEPOL_ERR;
> +	struct cil_tree_node *node = datum->nodes->head->data;
> +	struct cil_userattribute *attr = NULL;
> +	struct cil_user *user = NULL;
> +
> +	ebitmap_init(bitmap);
> +
> +	if (node->flavor == CIL_USERATTRIBUTE) {
> +		attr = (struct cil_userattribute *)datum;
> +		if (attr->users == NULL) {
> +			rc = __evaluate_user_expression(attr, db);
> +			if (rc != SEPOL_OK) {
> +				goto exit;
> +			}
> +		}
> +		ebitmap_union(bitmap, attr->users);
> +	} else {
> +		user = (struct cil_user *)datum;
> +		if (ebitmap_set_bit(bitmap, user->value, 1)) {
> +			cil_log(CIL_ERR, "Failed to set user bit\n");
> +			ebitmap_destroy(bitmap);
> +			goto exit;
> +		}
> +	}
> +
> +	return SEPOL_OK;
> +
> +exit:
> +	return rc;
> +}
> +
>  static int __evaluate_role_expression(struct cil_roleattribute *attr, struct cil_db *db)
>  {
>  	int rc;
> @@ -941,6 +1008,9 @@ static int __cil_expr_to_bitmap_helper(struct cil_list_item *curr, enum cil_flav
>  		case CIL_ROLE:
>  			rc = __cil_role_to_bitmap(curr->data, bitmap, db);
>  			break;
> +		case CIL_USER:
> +			rc = __cil_user_to_bitmap(curr->data, bitmap, db);
> +			break;
>  		case CIL_PERM:
>  			rc = __cil_perm_to_bitmap(curr->data, bitmap, db);
>  			break;
> @@ -1163,6 +1233,16 @@ static int __cil_post_db_attr_helper(struct cil_tree_node *node, __attribute__((
>  		if (rc != SEPOL_OK) goto exit;
>  		break;
>  	}
> +	case CIL_USERATTRIBUTE: {
> +		struct cil_userattribute *attr = node->data;
> +		if (attr->users == NULL) {
> +			rc = __evaluate_user_expression(attr, db);
> +			if (rc != SEPOL_OK) {
> +				goto exit;
> +			}
> +		}
> +		break;
> +	}
>  	default:
>  		break;
>  	}
> @@ -1268,6 +1348,102 @@ exit:
>  	return rc;
>  }
>  
> +static int __cil_user_assign_roles(struct cil_user *user, struct cil_symtab_datum *datum)
> +{
> +	struct cil_tree_node *node = datum->nodes->head->data;
> +	struct cil_role *role = NULL;
> +	struct cil_roleattribute *attr = NULL;
> +
> +	if (user->roles == NULL) {
> +		user->roles = cil_malloc(sizeof(*user->roles));
> +		ebitmap_init(user->roles);
> +	}
> +
> +	if (node->flavor == CIL_ROLE) {
> +		role = (struct cil_role *)datum;
> +		if (ebitmap_set_bit(user->roles, role->value, 1)) {
> +			cil_log(CIL_INFO, "Failed to set bit in user roles bitmap\n");
> +			goto exit;
> +		}
> +	} else if (node->flavor == CIL_ROLEATTRIBUTE) {
> +		attr = (struct cil_roleattribute *)datum;
> +		ebitmap_union(user->roles, attr->roles);
> +	}
> +
> +	return SEPOL_OK;
> +
> +exit:
> +	return SEPOL_ERR;
> +}
> +
> +static int __cil_post_db_userrole_helper(struct cil_tree_node *node, __attribute__((unused)) uint32_t *finished, void *extra_args)
> +{
> +	int rc = SEPOL_ERR;
> +	struct cil_db *db = extra_args;
> +	struct cil_block *blk = NULL;
> +	struct cil_userrole *userrole = NULL;
> +	struct cil_symtab_datum *user_datum = NULL;
> +	struct cil_symtab_datum *role_datum = NULL;
> +	struct cil_tree_node *user_node = NULL;
> +	struct cil_userattribute *u_attr = NULL;
> +	unsigned int i;
> +	struct cil_user *user = NULL;
> +	ebitmap_node_t *unode = NULL;
> +
> +	switch (node->flavor) {
> +	case CIL_BLOCK: {
> +		blk = node->data;
> +		if (blk->is_abstract == CIL_TRUE) {
> +			*finished = CIL_TREE_SKIP_HEAD;
> +		}
> +		break;
> +	}
> +	case CIL_MACRO: {
> +		*finished = CIL_TREE_SKIP_HEAD;
> +		break;
> +	}
> +	case CIL_USERROLE: {
> +		userrole = node->data;
> +		user_datum = userrole->user;
> +		role_datum = userrole->role;
> +		user_node = user_datum->nodes->head->data;
> +
> +		if (user_node->flavor == CIL_USERATTRIBUTE) {
> +			u_attr = userrole->user;
> +
> +			ebitmap_for_each_bit(u_attr->users, unode, i) {
> +				if (!ebitmap_get_bit(u_attr->users, i)) {
> +					continue;
> +				}
> +
> +				user = db->val_to_user[i];
> +
> +				rc = __cil_user_assign_roles(user, role_datum);
> +				if (rc != SEPOL_OK) {
> +					goto exit;
> +				}
> +			}
> +		} else {
> +			user = userrole->user;
> +
> +			rc = __cil_user_assign_roles(user, role_datum);
> +			if (rc != SEPOL_OK) {
> +				goto exit;
> +			}
> +		}
> +
> +		break;
> +	}
> +	default:
> +		break;
> +	}
> +
> +	return SEPOL_OK;
> +exit:
> +	cil_log(CIL_INFO, "cil_post_db_userrole_helper failed\n");
> +	return rc;
> +}
> +
>  static int __evaluate_level_expression(struct cil_level *level, struct cil_db *db)
>  {
>  	if (level->cats != NULL) {
> @@ -1739,6 +1915,12 @@ static int cil_post_db(struct cil_db *db)
>  		goto exit;
>  	}
>  
> +	rc = cil_tree_walk(db->ast->root, __cil_post_db_userrole_helper, NULL, NULL, db);
> +	if (rc != SEPOL_OK) {
> +		cil_log(CIL_INFO, "Failed during userrole association\n");
> +		goto exit;
> +	}
> +
>  	rc = cil_tree_walk(db->ast->root, __cil_post_db_classperms_helper, NULL, NULL, db);
>  	if (rc != SEPOL_OK) {
>  		cil_log(CIL_INFO, "Failed to evaluate class mapping permissions expressions\n");
> diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
> index 92f7720..09cff05 100644
> --- a/libsepol/cil/src/cil_reset_ast.c
> +++ b/libsepol/cil/src/cil_reset_ast.c
> @@ -99,7 +99,32 @@ static void cil_reset_user(struct cil_user *user)
>  	user->bounds = NULL;
>  	user->dftlevel = NULL;
>  	user->range = NULL;
> -	cil_list_destroy(&user->roles, CIL_FALSE);
> +}
> +
> +static void cil_reset_userattr(struct cil_userattribute *attr)
> +{
> +	struct cil_list_item *expr = NULL;
> +	struct cil_list_item *next = NULL;
> +
> +	/* during a re-resolve, we need to reset the lists of expression stacks associated with this attribute from a userattribute statement */
> +	if (attr->expr_list != NULL) {
> +		/* we don't want to destroy the expression stacks (cil_list) inside
> +		 * this list cil_list_destroy destroys sublists, so we need to do it
> +		 * manually */
> +		expr = attr->expr_list->head;
> +		while (expr != NULL) {
> +			next = expr->next;
> +			cil_list_item_destroy(&expr, CIL_FALSE);
> +			expr = next;
> +		}
> +		free(attr->expr_list);
> +		attr->expr_list = NULL;
> +	}
> +}
> +
> +static void cil_reset_userattributeset(struct cil_userattributeset *uas)
> +{
> +	cil_list_destroy(&uas->datum_expr, CIL_FALSE);
>  }
>  
>  static void cil_reset_selinuxuser(struct cil_selinuxuser *selinuxuser)
> @@ -403,6 +428,12 @@ int __cil_reset_node(struct cil_tree_node *node,  __attribute__((unused)) uint32
>  	case CIL_USER:
>  		cil_reset_user(node->data);
>  		break;
> +	case CIL_USERATTRIBUTE:
> +		cil_reset_userattr(node->data);
> +		break;
> +	case CIL_USERATTRIBUTESET:
> +		cil_reset_userattributeset(node->data);
> +		break;
>  	case CIL_SELINUXUSERDEFAULT:
>  	case CIL_SELINUXUSER:
>  		cil_reset_selinuxuser(node->data);
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index 5ff4534..0df5c63 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -820,12 +820,6 @@ int cil_resolve_userrole(struct cil_tree_node *current, void *extra_args)
>  	}
>  	userrole->role = role_datum;
>  
> -	if (userrole->user->roles == NULL) {
> -		cil_list_init(&userrole->user->roles, CIL_LIST_ITEM);
> -	}
> -
> -	cil_list_append(userrole->user->roles, CIL_ROLE, userrole->role);
> -
>  	return SEPOL_OK;
>  
>  exit:
> @@ -838,12 +832,22 @@ int cil_resolve_userlevel(struct cil_tree_node *current, void *extra_args)
>  	struct cil_symtab_datum *user_datum = NULL;
>  	struct cil_symtab_datum *lvl_datum = NULL;
>  	struct cil_user *user = NULL;
> +	struct cil_tree_node *user_node = NULL;
>  	int rc = SEPOL_ERR;
>  
>  	rc = cil_resolve_name(current, usrlvl->user_str, CIL_SYM_USERS, extra_args, &user_datum);
>  	if (rc != SEPOL_OK) {
>  		goto exit;
>  	}
> +
> +	user_node = user_datum->nodes->head->data;
> +
> +	if (user_node->flavor != CIL_USER) {
> +		cil_log(CIL_ERR, "Userlevel must be a user\n");
> +		rc = SEPOL_ERR;
> +		goto exit;
> +	}
> +
>  	user = (struct cil_user*)user_datum;
>  
>  	if (usrlvl->level_str != NULL) {
> @@ -881,12 +885,22 @@ int cil_resolve_userrange(struct cil_tree_node *current, void *extra_args)
>  	struct cil_symtab_datum *user_datum = NULL;
>  	struct cil_symtab_datum *range_datum = NULL;
>  	struct cil_user *user = NULL;
> +	struct cil_tree_node *user_node = NULL;
>  	int rc = SEPOL_ERR;
>  
>  	rc = cil_resolve_name(current, userrange->user_str, CIL_SYM_USERS, extra_args, &user_datum);
>  	if (rc != SEPOL_OK) {
>  		goto exit;
>  	}
> +
> +	user_node = user_datum->nodes->head->data;
> +
> +	if (user_node->flavor != CIL_USER) {
> +		cil_log(CIL_ERR, "Userrange must be a user: %s\n", user_datum->fqn);
> +		rc = SEPOL_ERR;
> +		goto exit;
> +	}
> +
>  	user = (struct cil_user*)user_datum;
>  
>  	if (userrange->range_str != NULL) {
> @@ -922,12 +936,22 @@ int cil_resolve_userprefix(struct cil_tree_node *current, void *extra_args)
>  {
>  	struct cil_userprefix *userprefix = current->data;
>  	struct cil_symtab_datum *user_datum = NULL;
> +	struct cil_tree_node *user_node = NULL;
>  	int rc = SEPOL_ERR;
>  
>  	rc = cil_resolve_name(current, userprefix->user_str, CIL_SYM_USERS, extra_args, &user_datum);
>  	if (rc != SEPOL_OK) {
>  		goto exit;
>  	}
> +
> +	user_node = user_datum->nodes->head->data;
> +
> +	if (user_node->flavor != CIL_USER) {
> +		cil_log(CIL_ERR, "Userprefix must be a user: %s\n", user_datum->fqn);
> +		rc = SEPOL_ERR;
> +		goto exit;
> +	}
> +
>  	userprefix->user = (struct cil_user*)user_datum;
>  
>  exit:
> @@ -939,12 +963,22 @@ int cil_resolve_selinuxuser(struct cil_tree_node *current, void *extra_args)
>  	struct cil_selinuxuser *selinuxuser = current->data;
>  	struct cil_symtab_datum *user_datum = NULL;
>  	struct cil_symtab_datum *lvlrange_datum = NULL;
> +	struct cil_tree_node *user_node = NULL;
>  	int rc = SEPOL_ERR;
>  
>  	rc = cil_resolve_name(current, selinuxuser->user_str, CIL_SYM_USERS, extra_args, &user_datum);
>  	if (rc != SEPOL_OK) {
>  		goto exit;
>  	}
> +
> +	user_node = user_datum->nodes->head->data;
> +
> +	if (user_node->flavor != CIL_USER) {
> +		cil_log(CIL_ERR, "Selinuxuser must be a user: %s\n", user_datum->fqn);
> +		rc = SEPOL_ERR;
> +		goto exit;
> +	}
> +
>  	selinuxuser->user = (struct cil_user*)user_datum;
>  
>  	if (selinuxuser->range_str != NULL) {
> @@ -1715,7 +1749,7 @@ int cil_resolve_context(struct cil_tree_node *current, struct cil_context *conte
>  	struct cil_symtab_datum *user_datum = NULL;
>  	struct cil_symtab_datum *role_datum = NULL;
>  	struct cil_symtab_datum *type_datum = NULL;
> -	struct cil_tree_node *type_node = NULL;
> +	struct cil_tree_node *node = NULL;
>  	struct cil_symtab_datum *lvlrange_datum = NULL;
>  
>  	int rc = SEPOL_ERR;
> @@ -1724,12 +1758,29 @@ int cil_resolve_context(struct cil_tree_node *current, struct cil_context *conte
>  	if (rc != SEPOL_OK) {
>  		goto exit;
>  	}
> +
> +	node = user_datum->nodes->head->data;
> +
> +	if (node->flavor != CIL_USER) {
> +		cil_log(CIL_ERR, "Context user must be a user: %s\n", user_datum->fqn);
> +		rc = SEPOL_ERR;
> +		goto exit;
> +	}
> +
>  	context->user = (struct cil_user*)user_datum;
>  
>  	rc = cil_resolve_name(current, context->role_str, CIL_SYM_ROLES, extra_args, &role_datum);
>  	if (rc != SEPOL_OK) {
>  		goto exit;
>  	}
> +
> +	node = role_datum->nodes->head->data;
> +	if (node->flavor != CIL_ROLE) {
> +		rc = SEPOL_ERR;
> +		cil_log(CIL_ERR, "Context role not a role: %s\n", role_datum->fqn);
> +		goto exit;
> +	}
> +
>  	context->role = (struct cil_role*)role_datum;
>  
>  	rc = cil_resolve_name(current, context->type_str, CIL_SYM_TYPES, extra_args, &type_datum);
> @@ -1737,9 +1788,9 @@ int cil_resolve_context(struct cil_tree_node *current, struct cil_context *conte
>  		goto exit;
>  	}
>  
> -	type_node = type_datum->nodes->head->data;
> +	node = type_datum->nodes->head->data;
>  
> -	if (type_node->flavor != CIL_TYPE && type_node->flavor != CIL_TYPEALIAS) {
> +	if (node->flavor != CIL_TYPE && node->flavor != CIL_TYPEALIAS) {
>  		rc = SEPOL_ERR;
>  		cil_log(CIL_ERR, "Type not a type or type alias\n");
>  		goto exit;
> @@ -3036,6 +3087,48 @@ exit:
>  	return rc;
>  }
>  
> +int cil_resolve_userattributeset(struct cil_tree_node *current, void *extra_args)
> +{
> +	int rc = SEPOL_ERR;
> +	struct cil_userattributeset *attrusers = current->data;
> +	struct cil_symtab_datum *attr_datum = NULL;
> +	struct cil_tree_node *attr_node = NULL;
> +	struct cil_userattribute *attr = NULL;
> +
> +	rc = cil_resolve_name(current, attrusers->attr_str, CIL_SYM_USERS, extra_args, &attr_datum);
> +	if (rc != SEPOL_OK) {
> +		goto exit;
> +	}
> +	attr_node = attr_datum->nodes->head->data;
> +
> +	if (attr_node->flavor != CIL_USERATTRIBUTE) {
> +		rc = SEPOL_ERR;
> +		cil_log(CIL_ERR, "Attribute user not an attribute\n");
> +		goto exit;
> +	}
> +	attr = (struct cil_userattribute*)attr_datum;
> +
> +	rc = cil_resolve_expr(CIL_USERATTRIBUTESET, attrusers->str_expr, &attrusers->datum_expr, current, extra_args);
> +	if (rc != SEPOL_OK) {
> +		goto exit;
> +	}
> +
> +	rc = cil_verify_no_self_reference(attr_datum, attrusers->datum_expr);
> +	if (rc != SEPOL_OK) {
> +		goto exit;
> +	}
> +
> +	if (attr->expr_list == NULL) {
> +		cil_list_init(&attr->expr_list, CIL_USERATTRIBUTE);
> +	}
> +
> +	cil_list_append(attr->expr_list, CIL_LIST, attrusers->datum_expr);
> +
> +	return SEPOL_OK;
> +
> +exit:
> +	return rc;
> +}
>  
>  int __cil_resolve_ast_node(struct cil_tree_node *node, void *extra_args)
>  {
> @@ -3296,6 +3389,9 @@ int __cil_resolve_ast_node(struct cil_tree_node *node, void *extra_args)
>  		case CIL_DEFAULTRANGE:
>  			rc = cil_resolve_defaultrange(node, args);
>  			break;
> +		case CIL_USERATTRIBUTESET:
> +			rc = cil_resolve_userattributeset(node, args);
> +			break;
>  		default:
>  			break;
>  		}
> diff --git a/libsepol/cil/src/cil_resolve_ast.h b/libsepol/cil/src/cil_resolve_ast.h
> index e99f0a4..1175f97 100644
> --- a/libsepol/cil/src/cil_resolve_ast.h
> +++ b/libsepol/cil/src/cil_resolve_ast.h
> @@ -54,6 +54,7 @@ int cil_resolve_userlevel(struct cil_tree_node *current, void *extra_args);
>  int cil_resolve_userrange(struct cil_tree_node *current, void *extra_args);
>  int cil_resolve_userbounds(struct cil_tree_node *current, void *extra_args);
>  int cil_resolve_userprefix(struct cil_tree_node *current, void *extra_args);
> +int cil_resolve_userattributeset(struct cil_tree_node *current, void *extra_args);
>  int cil_resolve_selinuxuser(struct cil_tree_node *current, void *extra_args);
>  int cil_resolve_roletype(struct cil_tree_node *current, void *extra_args);
>  int cil_resolve_roletransition(struct cil_tree_node *current, void *extra_args);
> diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
> index 6a731f2..f641baa 100644
> --- a/libsepol/cil/src/cil_tree.c
> +++ b/libsepol/cil/src/cil_tree.c
> @@ -640,15 +640,18 @@ void cil_tree_print_node(struct cil_tree_node *node)
>  		case CIL_USERROLE: {
>  			struct cil_userrole *userrole = node->data;
>  			cil_log(CIL_INFO, "USERROLE:");
> +			struct cil_symtab_datum *datum = NULL;
>  
>  			if (userrole->user != NULL) {
> -				cil_log(CIL_INFO, " %s", userrole->user->datum.name);
> +				datum = userrole->user;
> +				cil_log(CIL_INFO, " %s", datum->name);
>  			} else if (userrole->user_str != NULL) {
>  				cil_log(CIL_INFO, " %s", userrole->user_str);
>  			}
>  
>  			if (userrole->role != NULL) {
> -				cil_log(CIL_INFO, " %s", ((struct cil_symtab_datum *)userrole->role)->name);
> +				datum = userrole->role;
> +				cil_log(CIL_INFO, " %s", datum->name);
>  			} else if (userrole->role_str != NULL) {
>  				cil_log(CIL_INFO, " %s", userrole->role_str);
>  			}
> @@ -785,6 +788,21 @@ void cil_tree_print_node(struct cil_tree_node *node)
>  			cil_log(CIL_INFO, "ROLEATTRIBUTE: %s\n", attr->datum.name);
>  			return;
>  		}
> +		case CIL_USERATTRIBUTESET: {
> +			struct cil_userattributeset *attr = node->data;
> +
> +			cil_log(CIL_INFO, "(USERATTRIBUTESET %s ", attr->attr_str);
> +
> +			cil_tree_print_expr(attr->datum_expr, attr->str_expr);
> +
> +			cil_log(CIL_INFO, "\n");
> +			return;
> +		}
> +		case CIL_USERATTRIBUTE: {
> +			struct cil_userattribute *attr = node->data;
> +			cil_log(CIL_INFO, "USERATTRIBUTE: %s\n", attr->datum.name);
> +			return;
> +		}
>  		case CIL_ROLEBOUNDS: {
>  			struct cil_bounds *bnds = node->data;
>  			cil_log(CIL_INFO, "ROLEBOUNDS: role: %s, bounds: %s\n", bnds->parent_str, bnds->child_str);
> diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
> index 065de88..9ebfa81 100644
> --- a/libsepol/cil/src/cil_verify.c
> +++ b/libsepol/cil/src/cil_verify.c
> @@ -737,16 +737,8 @@ int __cil_verify_context(struct cil_db *db, struct cil_context *ctx)
>  	int found = CIL_FALSE;
>  
>  	if (user->roles != NULL) {
> -		cil_list_for_each(curr, user->roles) {
> -			struct cil_role *userrole = curr->data;
> -			if (userrole == role) {
> -				break;
> -			}
> -		}
> -
> -		if (curr == NULL) {
> -			cil_log(CIL_ERR, "Role %s is invalid for user %s\n",
> -					ctx->role_str, ctx->user_str);
> +		if (!ebitmap_get_bit(user->roles, role->value)) {
> +			cil_log(CIL_ERR, "Role %s is invalid for user %s\n", ctx->role_str, ctx->user_str);
>  			rc = SEPOL_ERR;
>  			goto exit;
>  		}
> diff --git a/secilc/docs/cil_constraint_statements.xml b/secilc/docs/cil_constraint_statements.xml
> index 6f5d9c6..8ef1642 100644
> --- a/secilc/docs/cil_constraint_statements.xml
> +++ b/secilc/docs/cil_constraint_statements.xml
> @@ -51,7 +51,7 @@
>                       <simpara>and:</simpara>
>                          <simpara><literal>  op      : eq neq</literal></simpara>
>                          <simpara><literal>  role_op : eq neq dom domby incomp</literal></simpara>
> -                        <simpara><literal>  user_id : A single <link linkend="user">user</link> identifier.</literal></simpara>
> +                        <simpara><literal>  user_id : A single <link linkend="user">user</link> or <link linkend="userattribute">userattribute</link> identifier.</literal></simpara>
>                          <simpara><literal>  role_id : A single <link linkend="role">role</link> or <link linkend="roleattribute">roleattribute</link> identifier.</literal></simpara>
>                          <simpara><literal>  type_id : A single <link linkend="type">type</link>, <link linkend="typealias">typealias</link> or <link linkend="typeattribute">typeattribute</link> identifier.</literal></simpara>
>                    </entry>
> @@ -154,7 +154,7 @@
>                       <simpara>and:</simpara>
>                          <simpara><literal>  op      : eq neq</literal></simpara>
>                          <simpara><literal>  role_op : eq neq dom domby incomp</literal></simpara>
> -                        <simpara><literal>  user_id : A single <link linkend="user">user</link> identifier.</literal></simpara>
> +                        <simpara><literal>  user_id : A single <link linkend="user">user</link> or <link linkend="userattribute">userattribute</link> identifier.</literal></simpara>
>                          <simpara><literal>  role_id : A single <link linkend="role">role</link> or <link linkend="roleattribute">roleattribute</link> identifier.</literal></simpara>
>                          <simpara><literal>  type_id : A single <link linkend="type">type</link>, <link linkend="typealias">typealias</link> or <link linkend="typeattribute">typeattribute</link> identifier.</literal></simpara>
>                    </entry>
> @@ -236,7 +236,7 @@
>                       <simpara>and:</simpara>
>                          <simpara><literal>  op          : eq neq</literal></simpara>
>                          <simpara><literal>  mls_role_op : eq neq dom domby incomp</literal></simpara>
> -                        <simpara><literal>  user_id     : A single <link linkend="user">user</link> identifier.</literal></simpara>
> +                        <simpara><literal>  user_id     : A single <link linkend="user">user</link> or <link linkend="userattribute">userattribute</link> identifier.</literal></simpara>
>                          <simpara><literal>  role_id     : A single <link linkend="role">role</link> or <link linkend="roleattribute">roleattribute</link> identifier.</literal></simpara>
>                          <simpara><literal>  type_id     : A single <link linkend="type">type</link>, <link linkend="typealias">typealias</link> or <link linkend="typeattribute">typeattribute</link> identifier.</literal></simpara>
>                    </entry>
> @@ -332,7 +332,7 @@
>                       <simpara>and:</simpara>
>                          <simpara><literal>  op          : eq neq</literal></simpara>
>                          <simpara><literal>  mls_role_op : eq neq dom domby incomp</literal></simpara>
> -                        <simpara><literal>  user_id     : A single <link linkend="user">user</link> identifier.</literal></simpara>
> +                        <simpara><literal>  user_id     : A single <link linkend="user">user</link> or <link linkend="userattribute">userattribute</link> identifier.</literal></simpara>
>                          <simpara><literal>  role_id     : A single <link linkend="role">role</link> or <link linkend="roleattribute">roleattribute</link> identifier.</literal></simpara>
>                          <simpara><literal>  type_id     : A single <link linkend="type">type</link>, <link linkend="typealias">typealias</link> or <link linkend="typeattribute">typeattribute</link> identifier.</literal></simpara>
>                    </entry>
> diff --git a/secilc/docs/cil_user_statements.xml b/secilc/docs/cil_user_statements.xml
> index 9fa1a51..38a7d6e 100644
> --- a/secilc/docs/cil_user_statements.xml
> +++ b/secilc/docs/cil_user_statements.xml
> @@ -66,7 +66,7 @@
>                       <para><literal>user_id</literal></para>
>                    </entry>
>                    <entry>
> -                     <para>A previously declared SELinux <literal><link linkend="user">user</link></literal> identifier.</para>
> +                     <para>A previously declared SELinux <literal><link linkend="user">user</link></literal> or <literal><link linkend="userattribute">userattribute</link></literal> identifier.</para>
>                    </entry>
>                 </row>
>                 <row>
> @@ -91,6 +91,114 @@
>           </programlisting>
>        </sect2>
>  
> +      <sect2 id="userattribute">
> +         <title>userattribute</title>
> +         <para>Declares a user attribute identifier in the current namespace. The identifier may have zero or more <literal><link linkend="user">user</link></literal> and <literal><link linkend="userattribute">userattribute</link></literal> identifiers associated to it via the <literal><link linkend="userattributeset">userattributeset</link></literal> statement.</para>
> +         <para><emphasis role="bold">Statement definition:</emphasis></para>
> +         <programlisting><![CDATA[(userattribute userattribute_id)]]></programlisting>
> +         <para><emphasis role="bold">Where:</emphasis></para>
> +         <informaltable frame="all">
> +            <tgroup cols="2">
> +            <colspec colwidth="2 *"/>
> +            <colspec colwidth="6 *"/>
> +               <tbody>
> +               <row>
> +                  <entry>
> +                     <para><literal>userattribute</literal></para>
> +                  </entry>
> +                  <entry>
> +                     <para>The <literal>userattribute</literal> keyword.</para>
> +                  </entry>
> +               </row>
> +               <row>
> +                  <entry>
> +                     <para><literal>userattribute_id</literal></para>
> +                  </entry>
> +                  <entry>
> +                     <para>The <literal>userattribute</literal> identifier.</para>
> +                  </entry>
> +               </row>
> +            </tbody></tgroup>
> +         </informaltable>
> +
> +         <para><emphasis role="bold">Example:</emphasis></para>
> +         <para>This example will declare a user attribute <literal>users.user_holder</literal> that will have an empty set:</para>
> +         <programlisting><![CDATA[
> +(block users
> +    (userattribute user_holder)
> +)]]>
> +         </programlisting>
> +      </sect2>
> +
> +      <sect2 id="userattributeset">
> +         <title>userattributeset</title>
> +         <para>Allows the association of one or more previously declared <literal><link linkend="user">user</link></literal> or <literal><link linkend="userattribute">userattribute</link></literal> identifiers to a <literal><link linkend="userattribute">userattribute</link></literal> identifier. Expressions may be used to refine the associations as shown in the examples.</para>
> +         <para><emphasis role="bold">Statement definition:</emphasis></para>
> +         <programlisting><![CDATA[(userattributeset userattribute_id (user_id ... | expr ...))]]></programlisting>
> +         <para><emphasis role="bold">Where:</emphasis></para>
> +         <informaltable frame="all">
> +            <tgroup cols="2">
> +            <colspec colwidth="2 *"/>
> +            <colspec colwidth="6 *"/>
> +               <tbody>
> +               <row>
> +                  <entry>
> +                     <para><literal>userattributeset</literal></para>
> +                  </entry>
> +                  <entry>
> +                     <para>The <literal>userattributeset</literal> keyword.</para>
> +                  </entry>
> +               </row>
> +               <row>
> +                  <entry>
> +                     <para><literal>userattribute_id</literal></para>
> +                  </entry>
> +                  <entry>
> +                     <para>A single previously declared <literal><link linkend="roleattribute">userattribute</link></literal> identifier.</para>
> +                  </entry>
> +               </row>
> +               <row>
> +                  <entry>
> +                     <para><literal>user_id</literal></para>
> +                  </entry>
> +                  <entry>
> +                     <para>Zero or more previously declared <literal><link linkend="role">user</link></literal> or <literal><link linkend="userattribute">userattribute</link></literal> identifiers.</para>
> +                     <para>Note that there must be at least one <literal>user_id</literal> or <literal>expr</literal> parameter declared.</para>
> +                  </entry>
> +               </row>
> +               <row>
> +                  <entry>
> +                     <para><literal>expr</literal></para>
> +                  </entry>
> +                  <entry>
> +                     <para>Zero or more <literal>expr</literal>'s, the valid operators and syntax are:</para>
> +                     <simpara><literal>    (and (user_id ...) (user_id ...))</literal></simpara>
> +                     <simpara><literal>    (or  (user_id ...) (user_id ...))</literal></simpara>
> +                     <simpara><literal>    (xor (user_id ...) (user_id ...))</literal></simpara>
> +                     <simpara><literal>    (not (user_id ...))</literal></simpara>
> +                     <simpara><literal>    (all)</literal></simpara>
> +                  </entry>
> +               </row>
> +            </tbody></tgroup>
> +         </informaltable>
> +
> +         <para><emphasis role="bold">Example:</emphasis></para>
> +         <para>This example will declare three users and two user attributes, then associate all the users to them as shown:</para>
> +         <programlisting><![CDATA[
> +(block users
> +    (user user_1)
> +    (user user_2)
> +    (user user_3)
> +
> +    (userattribute user_holder)
> +    (userattributeset user_holder (user_1 user_2 user_3))
> +
> +    (userattribute user_holder_all)
> +    (userattributeset user_holder_all (all))
> +)]]>
> +         </programlisting>
> +      </sect2>
> +
>        <sect2 id="userlevel">
>           <title>userlevel</title>
>           <para>Associates a previously declared <literal><link linkend="user">user</link></literal> identifier with a previously declared <literal><link linkend="level">level</link></literal> identifier. The <literal><link linkend="level">level</link></literal> may be named or anonymous.</para>
> diff --git a/secilc/test/policy.cil b/secilc/test/policy.cil
> index 0b532a9..69103d1 100644
> --- a/secilc/test/policy.cil
> +++ b/secilc/test/policy.cil
> @@ -124,7 +124,9 @@
>  	(roleattribute foo_role)
>  	(roleattribute bar_role)
>  	(roleattribute baz_role)
> +	(roleattribute foo_role_a)
>  	(roleattributeset exec_role (or user_r system_r))
> +	(roleattributeset foo_role_a (baz_r user_r system_r))
>  	(roleattributeset foo_role (and exec_role system_r))
>  	(roleattributeset bar_role (xor exec_role foo_role))
>  	(roleattributeset baz_role (not user_r))
> @@ -194,6 +196,7 @@
>  
>  	(role system_r)
>  	(role user_r)
> +	(role baz_r)
>  
>  	(roletype system_r bin_t)
>  	(roletype system_r kernel_t)
> @@ -207,6 +210,23 @@
>  
>  	(userrole foo_u foo_role)
>  	(userlevel foo_u low)
> +
> +	(userattribute ua1)
> +	(userattribute ua2)
> +	(userattribute ua3)
> +	(userattribute ua4)
> +	(userattributeset ua1 (user_u system_u))
> +	(userattributeset ua2 (foo_u system_u))
> +	(userattributeset ua3 (and ua1 ua2))
> +	(user u5)
> +	(user u6)
> +	(userlevel u5 low)
> +	(userlevel u6 low)
> +	(userrange u5 low_high)
> +	(userrange u6 low_high)
> +	(userattributeset ua4 (u5 u6))
> +	(userrole ua4 foo_role_a)
> +
>  	(userrange foo_u low_high)
>  
>  	(userrole system_u system_r)
> @@ -253,7 +273,7 @@
>  	(constrain (files (read)) (not (or (and (eq t1 exec_t) (eq t2 bin_t)) (eq r1 r2))))
>  	(constrain char_w (not (or (and (eq t1 exec_t) (eq t2 bin_t)) (eq r1 r2))))
>  
> -	(constrain (file (read)) (or (and (eq t1 exec_t) (neq t2 bin_t) ) (eq u1 u2) ) )
> +	(constrain (file (read)) (or (and (eq t1 exec_t) (neq t2 bin_t) ) (eq u1 ua4) ) )
>  	(constrain (file (open)) (dom r1 r2))
>  	(constrain (file (open)) (domby r1 r2))
>  	(constrain (file (open)) (incomp r1 r2))
> -- 
> 1.9.3
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJV8beiAAoJENAR6kfG5xmcVKAMAK5tAZRQnq2gIOzRv1fnciOc
k91ABlOqm5j+ongchsRSJJj+mleKnzCVqPA/dtKbV3Nw5fWsrdgz4rLQpI9w+rCi
qiSewA+xDSgsxuBgASprIycRB3X1Hxg4T6e6qSyM95hT6LFsYpPhG078Td85q6w9
lJ5zhvAKS8BIYOy3RZkR+ejEox9w/AxA6fCP66+vvQhqCwhmLTqH8X8l9+KHIMm+
0o81Ooa4vE/6BIU+dTctvqUJ69rkwVoau7IT0/qYDzcEepQoF9Ynb3I+JOamutMh
79DPB7bjuDf9p0GC7kusimsZtAmvvJSS5qB3oVAFhHaB/DNJpTYoJyhWIY/iErPx
OTjinbzq2gr1ya9eXsqhcR2+AxagvKC7NEkivO9h6JESIjlPzmJfe0uAUeqtirXt
nvlU/5yckmF1TtxvI/HQGfH7SRy1S1zODMx5VkNhlycDo2EbPUyq9aqHKkK9wEXP
rvo73IJBIyAt0iaCvKJTM+pGjBjMsJOu7/Liq3JnaQ==
=ZuJf
-----END PGP SIGNATURE-----
