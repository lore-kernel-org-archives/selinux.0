Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u1HDl13g015433
 for <selinux@tycho.nsa.gov>; Wed, 17 Feb 2016 08:47:04 -0500
Subject: Re: [PATCH 1/2] libsepol: fix __attribute__((unused)) annotations
To: Nicolas Iooss <nicolas.iooss@m4x.org>, <selinux@tycho.nsa.gov>
References: <1454709309-5505-1-git-send-email-nicolas.iooss@m4x.org>
From: Steve Lawrence <slawrence@tresys.com>
Message-ID: <56C479D4.6030602@tresys.com>
Date: Wed, 17 Feb 2016 08:47:00 -0500
MIME-Version: 1.0
In-Reply-To: <1454709309-5505-1-git-send-email-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/05/2016 04:55 PM, Nicolas Iooss wrote:
> clang warns about variables which are used in a function body even
> though they were marked __attribute__((unused)).  For example:
> 
>     interfaces.c:129:2: error: 'handle' was marked unused but was used
>     [-Werror,-Wused-but-marked-unused]
>             handle = NULL;
>             ^
>     interfaces.c:233:2: error: 'handle' was marked unused but was used
>     [-Werror,-Wused-but-marked-unused]
>             handle = NULL;
>             ^
> 
> Remove these warnings either by removing meaningless assigments or by
> removing the attribute.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Patchset applied. Thanks!

> ---
>  libsepol/cil/src/cil_binary.c      |   2 +-
>  libsepol/cil/src/cil_build_ast.c   | 146 ++++++++++++++++++-------------------
>  libsepol/cil/src/cil_copy_ast.c    |   2 +-
>  libsepol/cil/src/cil_post.c        |   8 +-
>  libsepol/cil/src/cil_resolve_ast.c |   2 +-
>  libsepol/src/booleans.c            |   1 -
>  libsepol/src/debug.c               |   2 -
>  libsepol/src/hierarchy.c           |   4 +-
>  libsepol/src/interfaces.c          |   2 -
>  libsepol/src/nodes.c               |   1 -
>  libsepol/src/policydb.c            |   8 +-
>  libsepol/src/ports.c               |   1 -
>  libsepol/src/roles.c               |   1 -
>  libsepol/src/users.c               |   2 -
>  14 files changed, 84 insertions(+), 98 deletions(-)
> 
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index 47c751c0ef06..f749e53b5d96 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -3588,7 +3588,7 @@ exit:
>  	return rc;
>  }
>  
> -int __cil_binary_create_helper(struct cil_tree_node *node, __attribute__((unused)) uint32_t *finished, void *extra_args)
> +int __cil_binary_create_helper(struct cil_tree_node *node, uint32_t *finished, void *extra_args)
>  {
>  	int rc = SEPOL_ERR;
>  
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> index f29d0c6220fc..1135e0677d54 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -150,7 +150,7 @@ void cil_clear_node(struct cil_tree_node *ast_node)
>  	ast_node->flavor = CIL_NONE;
>  }
>  
> -int cil_gen_block(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, uint16_t is_abstract)
> +int cil_gen_block(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, uint16_t is_abstract)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -206,7 +206,7 @@ void cil_destroy_block(struct cil_block *block)
>  	free(block);
>  }
>  
> -int cil_gen_blockinherit(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_blockinherit(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -251,7 +251,7 @@ void cil_destroy_blockinherit(struct cil_blockinherit *inherit)
>  	free(inherit);
>  }
>  
> -int cil_gen_blockabstract(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_blockabstract(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -296,7 +296,7 @@ void cil_destroy_blockabstract(struct cil_blockabstract *abstract)
>  	free(abstract);
>  }
>  
> -int cil_gen_in(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_in(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -343,7 +343,7 @@ void cil_destroy_in(struct cil_in *in)
>  	free(in);
>  }
>  
> -int cil_gen_class(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_class(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -406,7 +406,7 @@ void cil_destroy_class(struct cil_class *class)
>  	free(class);
>  }
>  
> -int cil_gen_classorder(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_classorder(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -475,7 +475,7 @@ void cil_destroy_classorder(struct cil_classorder *classorder)
>  	free(classorder);
>  }
>  
> -int cil_gen_perm(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, enum cil_flavor flavor, unsigned int *num_perms)
> +int cil_gen_perm(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, enum cil_flavor flavor, unsigned int *num_perms)
>  {
>  	char *key = NULL;
>  	struct cil_perm *perm = NULL;
> @@ -513,7 +513,7 @@ void cil_destroy_perm(struct cil_perm *perm)
>  	free(perm);
>  }
>  
> -int cil_gen_perm_nodes(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *current_perm, struct cil_tree_node *ast_node, enum cil_flavor flavor, unsigned int *num_perms)
> +int cil_gen_perm_nodes(struct cil_db *db, struct cil_tree_node *current_perm, struct cil_tree_node *ast_node, enum cil_flavor flavor, unsigned int *num_perms)
>  {
>  	int rc = SEPOL_ERR;
>  	struct cil_tree_node *new_ast = NULL;
> @@ -705,7 +705,7 @@ void cil_destroy_classperms_list(struct cil_list **cp_list)
>  	cil_list_destroy(cp_list, CIL_FALSE);
>  }
>  
> -int cil_gen_classpermission(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_classpermission(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	int rc = SEPOL_ERR;
>  	char *key = NULL;
> @@ -764,7 +764,7 @@ void cil_destroy_classpermission(struct cil_classpermission *cp)
>  	free(cp);
>  }
>  
> -int cil_gen_classpermissionset(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_classpermissionset(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	int rc = SEPOL_ERR;
>  	struct cil_classpermissionset *cps = NULL;
> @@ -817,7 +817,7 @@ void cil_destroy_classpermissionset(struct cil_classpermissionset *cps)
>  	free(cps);
>  }
>  
> -int cil_gen_map_class(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_map_class(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -859,7 +859,7 @@ exit:
>  	return rc;
>  }
>  
> -int cil_gen_classmapping(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_classmapping(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	int rc = SEPOL_ERR;
>  	struct cil_classmapping *mapping = NULL;
> @@ -915,7 +915,7 @@ void cil_destroy_classmapping(struct cil_classmapping *mapping)
>  }
>  
>  // TODO try to merge some of this with cil_gen_class (helper function for both)
> -int cil_gen_common(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_common(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -962,7 +962,7 @@ exit:
>  
>  }
>  
> -int cil_gen_classcommon(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_classcommon(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -1010,7 +1010,7 @@ void cil_destroy_classcommon(struct cil_classcommon *clscom)
>  	free(clscom);
>  }
>  
> -int cil_gen_sid(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_sid(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -1060,7 +1060,7 @@ void cil_destroy_sid(struct cil_sid *sid)
>  	free(sid);
>  }
>  
> -int cil_gen_sidcontext(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_sidcontext(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -1121,7 +1121,7 @@ void cil_destroy_sidcontext(struct cil_sidcontext *sidcon)
>  	free(sidcon);
>  }
>  
> -int cil_gen_sidorder(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_sidorder(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -1182,7 +1182,7 @@ void cil_destroy_sidorder(struct cil_sidorder *sidorder)
>  	free(sidorder);
>  }
>  
> -int cil_gen_user(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_user(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -1234,7 +1234,7 @@ void cil_destroy_user(struct cil_user *user)
>  	free(user);
>  }
>  
> -int cil_gen_userattribute(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_userattribute(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -1301,7 +1301,7 @@ void cil_destroy_userattribute(struct cil_userattribute *attr)
>  	free(attr);
>  }
>  
> -int cil_gen_userattributeset(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_userattributeset(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -1355,7 +1355,7 @@ void cil_destroy_userattributeset(struct cil_userattributeset *attrset)
>  	free(attrset);
>  }
>  
> -int cil_gen_userlevel(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_userlevel(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -1416,7 +1416,7 @@ void cil_destroy_userlevel(struct cil_userlevel *usrlvl)
>  	free(usrlvl);
>  }
>  
> -int cil_gen_userrange(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_userrange(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -1477,7 +1477,7 @@ void cil_destroy_userrange(struct cil_userrange *userrange)
>  	free(userrange);
>  }
>  
> -int cil_gen_userprefix(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_userprefix(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -1523,7 +1523,7 @@ void cil_destroy_userprefix(struct cil_userprefix *userprefix)
>  	free(userprefix);
>  }
>  
> -int cil_gen_selinuxuser(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_selinuxuser(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -1572,7 +1572,7 @@ exit:
>  	return rc;
>  }
>  
> -int cil_gen_selinuxuserdefault(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_selinuxuserdefault(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -1633,7 +1633,7 @@ void cil_destroy_selinuxuser(struct cil_selinuxuser *selinuxuser)
>  	free(selinuxuser);
>  }
>  
> -int cil_gen_role(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_role(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -1685,7 +1685,7 @@ void cil_destroy_role(struct cil_role *role)
>  	free(role);
>  }
>  
> -int cil_gen_roletype(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_roletype(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -1732,7 +1732,7 @@ void cil_destroy_roletype(struct cil_roletype *roletype)
>  	free(roletype);
>  }
>  
> -int cil_gen_userrole(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_userrole(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -1830,7 +1830,7 @@ void cil_destroy_roletransition(struct cil_roletransition *roletrans)
>  	free(roletrans);
>  }
>  
> -int cil_gen_roleallow(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_roleallow(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -1877,7 +1877,7 @@ void cil_destroy_roleallow(struct cil_roleallow *roleallow)
>  	free(roleallow);
>  }
>  
> -int cil_gen_roleattribute(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_roleattribute(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -1947,7 +1947,7 @@ void cil_destroy_roleattribute(struct cil_roleattribute *attr)
>  	free(attr);
>  }
>  
> -int cil_gen_roleattributeset(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_roleattributeset(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -2268,7 +2268,7 @@ void cil_destroy_type_rule(struct cil_type_rule *rule)
>  	free(rule);
>  }
>  
> -int cil_gen_type(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_type(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -2323,7 +2323,7 @@ void cil_destroy_type(struct cil_type *type)
>  	free(type);
>  }
>  
> -int cil_gen_typeattribute(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_typeattribute(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -2394,7 +2394,7 @@ void cil_destroy_typeattribute(struct cil_typeattribute *attr)
>  	free(attr);
>  }
>  
> -int cil_gen_bool(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, int tunableif)
> +int cil_gen_bool(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, int tunableif)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -2460,7 +2460,7 @@ void cil_destroy_bool(struct cil_bool *boolean)
>  	free(boolean);
>  }
>  
> -int cil_gen_tunable(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_tunable(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -2816,7 +2816,7 @@ exit:
>  	return rc;
>  }
>  
> -int cil_gen_boolif(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, int tunableif)
> +int cil_gen_boolif(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, int tunableif)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -2902,7 +2902,7 @@ void cil_destroy_boolif(struct cil_booleanif *bif)
>  	free(bif);
>  }
>  
> -int cil_gen_tunif(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_tunif(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -2982,7 +2982,7 @@ void cil_destroy_tunif(struct cil_tunableif *tif)
>  	free(tif);
>  }
>  
> -int cil_gen_condblock(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, enum cil_flavor flavor)
> +int cil_gen_condblock(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, enum cil_flavor flavor)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -3034,7 +3034,7 @@ void cil_destroy_condblock(struct cil_condblock *cb)
>  	free(cb);
>  }
>  
> -int cil_gen_alias(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, enum cil_flavor flavor)
> +int cil_gen_alias(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, enum cil_flavor flavor)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -3098,7 +3098,7 @@ void cil_destroy_alias(struct cil_alias *alias)
>  	free(alias);
>  }
>  
> -int cil_gen_aliasactual(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, enum cil_flavor flavor)
> +int cil_gen_aliasactual(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, enum cil_flavor flavor)
>  {
>  	int rc = SEPOL_ERR;
>  	enum cil_syntax syntax[] = {
> @@ -3152,7 +3152,7 @@ void cil_destroy_aliasactual(struct cil_aliasactual *aliasactual)
>  	free(aliasactual);
>  }
>  
> -int cil_gen_typeattributeset(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_typeattributeset(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -3205,7 +3205,7 @@ void cil_destroy_typeattributeset(struct cil_typeattributeset *attrset)
>  	free(attrset);
>  }
>  
> -int cil_gen_typepermissive(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_typepermissive(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -3250,7 +3250,7 @@ void cil_destroy_typepermissive(struct cil_typepermissive *typeperm)
>  	free(typeperm);
>  }
>  
> -int cil_gen_typetransition(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_typetransition(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	int rc = SEPOL_ERR;
>  	enum cil_syntax syntax[] = {
> @@ -3343,7 +3343,7 @@ void cil_destroy_typetransition(struct cil_nametypetransition *nametypetrans)
>  	free(nametypetrans);
>  }
>  
> -int cil_gen_rangetransition(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_rangetransition(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -3410,7 +3410,7 @@ void cil_destroy_rangetransition(struct cil_rangetransition *rangetrans)
>  	free(rangetrans);
>  }
>  
> -int cil_gen_sensitivity(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_sensitivity(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -3463,7 +3463,7 @@ void cil_destroy_sensitivity(struct cil_sens *sens)
>  	free(sens);
>  }
>  
> -int cil_gen_category(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_category(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -3513,7 +3513,7 @@ void cil_destroy_category(struct cil_cat *cat)
>  	free(cat);
>  }
>  
> -int cil_gen_catset(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_catset(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -3572,7 +3572,7 @@ void cil_destroy_catset(struct cil_catset *catset)
>  	free(catset);
>  }
>  
> -int cil_gen_catorder(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_catorder(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -3633,7 +3633,7 @@ void cil_destroy_catorder(struct cil_catorder *catorder)
>  	free(catorder);
>  }
>  
> -int cil_gen_sensitivityorder(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_sensitivityorder(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -3694,7 +3694,7 @@ void cil_destroy_sensitivityorder(struct cil_sensorder *sensorder)
>  	free(sensorder);
>  }
>  
> -int cil_gen_senscat(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_senscat(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -3747,7 +3747,7 @@ void cil_destroy_senscat(struct cil_senscat *senscat)
>  	free(senscat);
>  }
>  
> -int cil_gen_level(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_level(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -3854,7 +3854,7 @@ exit:
>  	return rc;
>  }
>  
> -int cil_gen_levelrange(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_levelrange(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -3919,7 +3919,7 @@ void cil_destroy_levelrange(struct cil_levelrange *lvlrange)
>  	free(lvlrange);
>  }
>  
> -int cil_gen_constrain(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, enum cil_flavor flavor)
> +int cil_gen_constrain(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, enum cil_flavor flavor)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -3977,7 +3977,7 @@ void cil_destroy_constrain(struct cil_constrain *cons)
>  	free(cons);
>  }
>  
> -int cil_gen_validatetrans(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, enum cil_flavor flavor)
> +int cil_gen_validatetrans(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, enum cil_flavor flavor)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -4079,7 +4079,7 @@ exit:
>  	return rc;
>  }
>  
> -int cil_gen_context(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_context(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -4140,7 +4140,7 @@ void cil_destroy_context(struct cil_context *context)
>  	free(context);
>  }
>  
> -int cil_gen_filecon(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_filecon(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -4231,7 +4231,7 @@ void cil_destroy_filecon(struct cil_filecon *filecon)
>  	free(filecon);
>  }
>  
> -int cil_gen_portcon(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_portcon(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -4330,7 +4330,7 @@ void cil_destroy_portcon(struct cil_portcon *portcon)
>  	free(portcon);
>  }
>  
> -int cil_gen_nodecon(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_nodecon(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -4420,7 +4420,7 @@ void cil_destroy_nodecon(struct cil_nodecon *nodecon)
>  	free(nodecon);
>  }
>  
> -int cil_gen_genfscon(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_genfscon(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -4484,7 +4484,7 @@ void cil_destroy_genfscon(struct cil_genfscon *genfscon)
>  }
>  
>  
> -int cil_gen_netifcon(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_netifcon(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -4561,7 +4561,7 @@ void cil_destroy_netifcon(struct cil_netifcon *netifcon)
>  	free(netifcon);
>  }
>  
> -int cil_gen_pirqcon(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_pirqcon(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -4625,7 +4625,7 @@ void cil_destroy_pirqcon(struct cil_pirqcon *pirqcon)
>  	free(pirqcon);
>  }
>  
> -int cil_gen_iomemcon(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_iomemcon(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -4711,7 +4711,7 @@ void cil_destroy_iomemcon(struct cil_iomemcon *iomemcon)
>  	free(iomemcon);
>  }
>  
> -int cil_gen_ioportcon(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_ioportcon(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -4797,7 +4797,7 @@ void cil_destroy_ioportcon(struct cil_ioportcon *ioportcon)
>  	free(ioportcon);
>  }
>  
> -int cil_gen_pcidevicecon(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_pcidevicecon(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -4861,7 +4861,7 @@ void cil_destroy_pcidevicecon(struct cil_pcidevicecon *pcidevicecon)
>  	free(pcidevicecon);
>  }
>  
> -int cil_gen_devicetreecon(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_devicetreecon(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -4922,7 +4922,7 @@ void cil_destroy_devicetreecon(struct cil_devicetreecon *devicetreecon)
>  	free(devicetreecon);
>  }
>  
> -int cil_gen_fsuse(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_fsuse(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -5007,7 +5007,7 @@ void cil_destroy_param(struct cil_param *param)
>  	free(param);
>  }
>  
> -int cil_gen_macro(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_macro(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	int rc = SEPOL_ERR;
>  	char *key = NULL;
> @@ -5160,7 +5160,7 @@ void cil_destroy_macro(struct cil_macro *macro)
>  	free(macro);
>  }
>  
> -int cil_gen_call(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_call(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -5266,7 +5266,7 @@ void cil_destroy_args(struct cil_args *args)
>  	free(args);
>  }
>  
> -int cil_gen_optional(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_optional(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -5316,7 +5316,7 @@ void cil_destroy_optional(struct cil_optional *optional)
>  	free(optional);
>  }
>  
> -int cil_gen_policycap(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_policycap(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -5365,7 +5365,7 @@ void cil_destroy_policycap(struct cil_policycap *polcap)
>  	free(polcap);
>  }
>  
> -int cil_gen_ipaddr(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_ipaddr(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -5564,7 +5564,7 @@ void cil_destroy_cats(struct cil_cats *cats)
>  
>  	free(cats);
>  }
> -int cil_gen_bounds(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, enum cil_flavor flavor)
> +int cil_gen_bounds(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, enum cil_flavor flavor)
>  {
>  	enum cil_syntax syntax[] = {
>  		CIL_SYN_STRING,
> @@ -6329,7 +6329,7 @@ exit:
>  	return rc;
>  }
>  
> -int cil_build_ast(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_tree, struct cil_tree_node *ast)
> +int cil_build_ast(struct cil_db *db, struct cil_tree_node *parse_tree, struct cil_tree_node *ast)
>  {
>  	int rc = SEPOL_ERR;
>  	struct cil_args_build extra_args;
> diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
> index f49364c56c58..0be1ddaab705 100644
> --- a/libsepol/cil/src/cil_copy_ast.c
> +++ b/libsepol/cil/src/cil_copy_ast.c
> @@ -789,7 +789,7 @@ void cil_copy_fill_permissionx(struct cil_db *db, struct cil_permissionx *orig,
>  	cil_copy_expr(db, orig->expr_str, &new->expr_str);
>  }
>  
> -int cil_copy_avrule(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
> +int cil_copy_avrule(struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
>  {
>  	struct cil_avrule *orig = data;
>  	struct cil_avrule *new = NULL;
> diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> index 547397c17b28..a694b3399e6b 100644
> --- a/libsepol/cil/src/cil_post.c
> +++ b/libsepol/cil/src/cil_post.c
> @@ -426,7 +426,7 @@ static int __cil_post_db_count_helper(struct cil_tree_node *node, uint32_t *fini
>  	return SEPOL_OK;
>  }
>  
> -static int __cil_post_db_array_helper(struct cil_tree_node *node, __attribute__((unused)) uint32_t *finished, void *extra_args)
> +static int __cil_post_db_array_helper(struct cil_tree_node *node, uint32_t *finished, void *extra_args)
>  {
>  	struct cil_db *db = extra_args;
>  
> @@ -1186,7 +1186,7 @@ exit:
>  	return SEPOL_ERR;
>  }
>  
> -static int __cil_post_db_attr_helper(struct cil_tree_node *node, __attribute__((unused)) uint32_t *finished, void *extra_args)
> +static int __cil_post_db_attr_helper(struct cil_tree_node *node, uint32_t *finished, void *extra_args)
>  {
>  	int rc = SEPOL_ERR;
>  	struct cil_db *db = extra_args;
> @@ -1286,7 +1286,7 @@ exit:
>  	return SEPOL_ERR;
>  }
>  
> -static int __cil_post_db_roletype_helper(struct cil_tree_node *node, __attribute__((unused)) uint32_t *finished, void *extra_args)
> +static int __cil_post_db_roletype_helper(struct cil_tree_node *node, uint32_t *finished, void *extra_args)
>  {
>  	int rc = SEPOL_ERR;
>  	struct cil_db *db = extra_args;
> @@ -1376,7 +1376,7 @@ exit:
>  	return SEPOL_ERR;
>  }
>  
> -static int __cil_post_db_userrole_helper(struct cil_tree_node *node, __attribute__((unused)) uint32_t *finished, void *extra_args)
> +static int __cil_post_db_userrole_helper(struct cil_tree_node *node, uint32_t *finished, void *extra_args)
>  {
>  	int rc = SEPOL_ERR;
>  	struct cil_db *db = extra_args;
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index 14a9c75da7f9..1489680bc319 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -3576,7 +3576,7 @@ exit:
>  	return rc;
>  }
>  
> -int __cil_resolve_ast_node_helper(struct cil_tree_node *node, __attribute__((unused)) uint32_t *finished, void *extra_args)
> +int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished, void *extra_args)
>  {
>  	int rc = SEPOL_ERR;
>  	struct cil_args_resolve *args = extra_args;
> diff --git a/libsepol/src/booleans.c b/libsepol/src/booleans.c
> index 03f8c9862341..c914a286e2bf 100644
> --- a/libsepol/src/booleans.c
> +++ b/libsepol/src/booleans.c
> @@ -110,7 +110,6 @@ int sepol_bool_count(sepol_handle_t * handle __attribute__ ((unused)),
>  	const policydb_t *policydb = &p->p;
>  	*response = policydb->p_bools.nprim;
>  
> -	handle = NULL;
>  	return STATUS_SUCCESS;
>  }
>  
> diff --git a/libsepol/src/debug.c b/libsepol/src/debug.c
> index 51918fd7e824..db57090fafd0 100644
> --- a/libsepol/src/debug.c
> +++ b/libsepol/src/debug.c
> @@ -69,8 +69,6 @@ void hidden sepol_msg_default_handler(void *varg __attribute__ ((unused)),
>  	va_end(ap);
>  
>  	fprintf(stream, "\n");
> -
> -	varg = NULL;
>  }
>  
>  extern void sepol_msg_set_callback(sepol_handle_t * handle,
> diff --git a/libsepol/src/hierarchy.c b/libsepol/src/hierarchy.c
> index f6c5fae95b40..6f731957217f 100644
> --- a/libsepol/src/hierarchy.c
> +++ b/libsepol/src/hierarchy.c
> @@ -549,7 +549,7 @@ exit:
>  /* The role bounds is defined as: a child role cannot have a type that
>   * its parent doesn't have.
>   */
> -static int bounds_check_role_callback(hashtab_key_t k __attribute__ ((unused)),
> +static int bounds_check_role_callback(hashtab_key_t k,
>  				      hashtab_datum_t d, void *args)
>  {
>  	struct bounds_args *a = (struct bounds_args *)args;
> @@ -592,7 +592,7 @@ int bounds_check_roles(sepol_handle_t *handle, policydb_t *p)
>  /* The user bounds is defined as: a child user cannot have a role that
>   * its parent doesn't have.
>   */
> -static int bounds_check_user_callback(hashtab_key_t k __attribute__ ((unused)),
> +static int bounds_check_user_callback(hashtab_key_t k,
>  				      hashtab_datum_t d, void *args)
>  {
>  	struct bounds_args *a = (struct bounds_args *)args;
> diff --git a/libsepol/src/interfaces.c b/libsepol/src/interfaces.c
> index b82d0f3a279c..f371d0bfdf7e 100644
> --- a/libsepol/src/interfaces.c
> +++ b/libsepol/src/interfaces.c
> @@ -126,7 +126,6 @@ int sepol_iface_exists(sepol_handle_t * handle __attribute__ ((unused)),
>  	}
>  	*response = 0;
>  
> -	handle = NULL;
>  	return STATUS_SUCCESS;
>  }
>  
> @@ -230,7 +229,6 @@ extern int sepol_iface_count(sepol_handle_t * handle __attribute__ ((unused)),
>  
>  	*response = count;
>  
> -	handle = NULL;
>  	return STATUS_SUCCESS;
>  }
>  
> diff --git a/libsepol/src/nodes.c b/libsepol/src/nodes.c
> index ebf5f1d22f37..50cf21d3155f 100644
> --- a/libsepol/src/nodes.c
> +++ b/libsepol/src/nodes.c
> @@ -162,7 +162,6 @@ extern int sepol_node_count(sepol_handle_t * handle __attribute__ ((unused)),
>  
>  	*response = count;
>  
> -	handle = NULL;
>  	return STATUS_SUCCESS;
>  }
>  
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 665f7a982795..6a80f94b5305 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -2179,9 +2179,7 @@ static int class_read(policydb_t * p, hashtab_t h, struct policy_file *fp)
>  	return -1;
>  }
>  
> -static int role_read(policydb_t * p
> -		     __attribute__ ((unused)), hashtab_t h,
> -		     struct policy_file *fp)
> +static int role_read(policydb_t * p, hashtab_t h, struct policy_file *fp)
>  {
>  	char *key = 0;
>  	role_datum_t *role;
> @@ -2257,9 +2255,7 @@ static int role_read(policydb_t * p
>  	return -1;
>  }
>  
> -static int type_read(policydb_t * p
> -		     __attribute__ ((unused)), hashtab_t h,
> -		     struct policy_file *fp)
> +static int type_read(policydb_t * p, hashtab_t h, struct policy_file *fp)
>  {
>  	char *key = 0;
>  	type_datum_t *typdatum;
> diff --git a/libsepol/src/ports.c b/libsepol/src/ports.c
> index cbf2a0ba686d..607a629f226e 100644
> --- a/libsepol/src/ports.c
> +++ b/libsepol/src/ports.c
> @@ -154,7 +154,6 @@ extern int sepol_port_count(sepol_handle_t * handle __attribute__ ((unused)),
>  
>  	*response = count;
>  
> -	handle = NULL;
>  	return STATUS_SUCCESS;
>  }
>  
> diff --git a/libsepol/src/roles.c b/libsepol/src/roles.c
> index 419a3b209aca..713d834df3f9 100644
> --- a/libsepol/src/roles.c
> +++ b/libsepol/src/roles.c
> @@ -16,7 +16,6 @@ int sepol_role_exists(sepol_handle_t * handle __attribute__ ((unused)),
>  	*response = (hashtab_search(policydb->p_roles.table,
>  				    (const hashtab_key_t)role) != NULL);
>  
> -	handle = NULL;
>  	return STATUS_SUCCESS;
>  }
>  
> diff --git a/libsepol/src/users.c b/libsepol/src/users.c
> index 693210d2f4f8..ce54c2ba8306 100644
> --- a/libsepol/src/users.c
> +++ b/libsepol/src/users.c
> @@ -297,7 +297,6 @@ int sepol_user_exists(sepol_handle_t * handle __attribute__ ((unused)),
>  	*response = (hashtab_search(policydb->p_users.table,
>  				    (const hashtab_key_t)cname) != NULL);
>  
> -	handle = NULL;
>  	return STATUS_SUCCESS;
>  }
>  
> @@ -308,7 +307,6 @@ int sepol_user_count(sepol_handle_t * handle __attribute__ ((unused)),
>  	const policydb_t *policydb = &p->p;
>  	*response = policydb->p_users.nprim;
>  
> -	handle = NULL;
>  	return STATUS_SUCCESS;
>  }
>  
> 
