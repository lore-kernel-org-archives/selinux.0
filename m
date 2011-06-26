Message-ID: <SNT139-w2511F70A377AB0CBF2D5DAB540@phx.gbl>
Content-Type: multipart/mixed;
	boundary="_fc2d5afd-0b58-411b-a89f-2a978a0a4d8e_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: lawrence steve <slawrence@tresys.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Stephen Smalley
	<sds@tycho.nsa.gov>, <method@manicmethod.com>,
        <jmorris@namei.org>, <eparis@parisplace.org>,
        selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: RE: [v2 PATCH 1/6] Add role attribute support when compiling
 modules.
Date: Sun, 26 Jun 2011 14:11:05 +0000
In-Reply-To: <4E04E73C.7050803@tresys.com>
References: <1306918677-3657-1-git-send-email-qingtao.cao@windriver.com>
 <1306918677-3657-2-git-send-email-qingtao.cao@windriver.com>,<4E04E73C.7050803@tresys.com>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_fc2d5afd-0b58-411b-a89f-2a978a0a4d8e_
Content-Type: multipart/alternative;
	boundary="_45c32a0d-c0db-419d-bad2-5f337157ad98_"

--_45c32a0d-c0db-419d-bad2-5f337157ad98_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Steve,

> Date: Fri, 24 Jun 2011 15:36:28 -0400
> From: slawrence@tresys.com
> To: qingtao.cao@windriver.com
> CC: cpebenito@tresys.com; sds@tycho.nsa.gov; method@manicmethod.com; jmorris@namei.org; eparis@parisplace.org; selinux@tycho.nsa.gov
> Subject: Re: [v2 PATCH 1/6] Add role attribute support when compiling modules.
> 
> On 06/01/2011 04:57 AM, Harry Ciao wrote:
> > 1. Add a uint32_t "flavor" field and an ebitmap "roles" to the
> > role_datum_t structure;
> > 
> > 2. Add a new "attribute_role" statement and its handler to declare
> > a role attribute;
> > 
> > 3. Modify declare_role() to setup role_datum_t.flavor according
> > to the isattr argument;
> > 
> > 4. Add a new "roleattribute" rule and its handler, which will record
> > the regular role's (policy value - 1) into the role attribute's
> > role_datum_t.roles ebitmap;
> > 
> > 5. Modify the syntax for the role-types rule only to define the
> > role-type associations;
> > 
> > 6. Add a new role-attr rule to support the declaration of a single
> > role, and optionally the role attribute that the role belongs to;
> > 
> > 7. Check if the new_role used in role-transition rule is a regular role;
> > 
> > 8. Support to require a role attribute;
> > 
> > Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
> > ---
> >  checkpolicy/module_compiler.c              |   67 ++++++++++++-
> >  checkpolicy/module_compiler.h              |    4 +-
> >  checkpolicy/policy_define.c                |  152 +++++++++++++++++++++++++++-
> >  checkpolicy/policy_define.h                |    3 +
> >  checkpolicy/policy_parse.y                 |   18 +++-
> >  checkpolicy/policy_scan.l                  |    4 +
> >  libsepol/include/sepol/policydb/policydb.h |    4 +
> >  libsepol/src/policydb.c                    |    2 +
> >  8 files changed, 246 insertions(+), 8 deletions(-)
> > 
> > diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
> > index 0946ff6..1c1d1d5 100644
> > --- a/checkpolicy/module_compiler.c
> > +++ b/checkpolicy/module_compiler.c
> > @@ -200,7 +200,7 @@ static int role_implicit_bounds(hashtab_t roles_tab,
> >  	return 0;
> >  }
> >  
> > -role_datum_t *declare_role(void)
> > +role_datum_t *declare_role(unsigned char isattr)
> 
> I'm still looking at this patchset, but noticed some issue with this
> function:
> 
> The declare_role function allows a role to be defined multiple times,
> which is correct. However, if a role_attribute was defined with the same
> name as a role, this function would not error, which I believe it should.
> 
> Also, attribute_role's should not be allowed to be defined twice (the
> same restriction is applied to normal attributes).


Right, I've got your point, so far the role_copy_callback() function in the link stage could catch the error that a same name is defined twice in two different modules: once as a role attribute but then as a regular role. However, if such error is within a single module, or one role attribute is declared more than once in one single module, these errors can't be caught in the compile time.

Fortunately,  these errors could be detected by the symtab_insert() function, please refer to the attached v3 version for the 0001 patch, while the rest patches in the patchset remain the same so far.

Thanks!

Best regards,
Harry


> 
> >  {
> >  	char *id = queue_remove(id_queue), *dest_id = NULL;
> >  	role_datum_t *role = NULL, *dest_role = NULL;
> > @@ -217,7 +217,7 @@ role_datum_t *declare_role(void)
> >  		return NULL;
> >  	}
> >  	role_datum_init(role);
> > -
> > +	role->flavor = isattr ? ROLE_ATTRIB : ROLE_ROLE;
> >  	retval =
> >  	    declare_symbol(SYM_ROLES, id, (hashtab_datum_t *) role, &value,
> >  			   &value);
> > @@ -254,6 +254,7 @@ role_datum_t *declare_role(void)
> >  			}
> >  			role_datum_init(dest_role);
> >  			dest_role->s.value = value;
> > +			dest_role->flavor = isattr ? ROLE_ATTRIB : ROLE_ROLE;
> >  			if (role_implicit_bounds(roles_tab, dest_id, dest_role)) {
> >  				free(dest_id);
> >  				role_datum_destroy(dest_role);
> > @@ -548,6 +549,55 @@ type_datum_t *get_local_type(char *id, uint32_t value, unsigned char isattr)
> >  	return dest_typdatum;
> >  }
> >  
> > +/* Return a role_datum_t for the local avrule_decl with the given ID.
> > + * If it does not exist, create one with the same value as 'value'.
> > + * This function assumes that the ID is within scope.  c.f.,
> > + * is_id_in_scope().
> > + *
> > + * NOTE: this function usurps ownership of id afterwards.  The caller
> > + * shall not reference it nor free() it afterwards.
> > + */
> > +role_datum_t *get_local_role(char *id, uint32_t value, unsigned char isattr)
> > +{
> > +	role_datum_t *dest_roledatum;
> > +	hashtab_t roles_tab;
> > +
> > +	assert(stack_top->type == 1);
> > +
> > +	if (stack_top->parent == NULL) {
> > +		/* in global, so use global symbol table */
> > +		roles_tab = policydbp->p_roles.table;
> > +	} else {
> > +		roles_tab = stack_top->decl->p_roles.table;
> > +	}
> > +
> > +	dest_roledatum = hashtab_search(roles_tab, id);
> > +	if (!dest_roledatum) {
> > +		dest_roledatum = (role_datum_t *)malloc(sizeof(role_datum_t));
> > +		if (dest_roledatum == NULL) {
> > +			free(id);
> > +			return NULL;
> > +		}
> > +
> > +		role_datum_init(dest_roledatum);
> > +		dest_roledatum->s.value = value;
> > +		dest_roledatum->flavor = isattr ? ROLE_ATTRIB : ROLE_ROLE;
> > +
> > +		if (hashtab_insert(roles_tab, id, dest_roledatum)) {
> > +			free(id);
> > +			role_datum_destroy(dest_roledatum);
> > +			free(dest_roledatum);
> > +			return NULL;
> > +		}
> > +	} else {
> > +		free(id);
> > +		if (dest_roledatum->flavor != isattr ? ROLE_ATTRIB : ROLE_ROLE)
> > +			return NULL;
> > +	}
> > +	
> > +	return dest_roledatum;
> > +}
> > +
> >  /* Given the current parse stack, returns 1 if a requirement would be
> >   * allowed here or 0 if not.  For example, the ELSE branch may never
> >   * have its own requirements.
> > @@ -812,7 +862,7 @@ int require_class(int pass)
> >  	return -1;
> >  }
> >  
> > -int require_role(int pass)
> > +static int require_role_or_attribute(int pass, unsigned char isattr)
> >  {
> >  	char *id = queue_remove(id_queue);
> >  	role_datum_t *role = NULL;
> > @@ -831,6 +881,7 @@ int require_role(int pass)
> >  		return -1;
> >  	}
> >  	role_datum_init(role);
> > +	role->flavor = isattr ? ROLE_ATTRIB : ROLE_ROLE;
> >  	retval =
> >  	    require_symbol(SYM_ROLES, id, (hashtab_datum_t *) role,
> >  			   &role->s.value, &role->s.value);
> > @@ -870,6 +921,16 @@ int require_role(int pass)
> >  	}
> >  }
> >  
> > +int require_role(int pass)
> > +{
> > +	return require_role_or_attribute(pass, 0);
> > +}
> > +
> > +int require_attribute_role(int pass)
> > +{
> > +	return require_role_or_attribute(pass, 1);
> > +}
> > +
> >  static int require_type_or_attribute(int pass, unsigned char isattr)
> >  {
> >  	char *id = queue_remove(id_queue);
> > diff --git a/checkpolicy/module_compiler.h b/checkpolicy/module_compiler.h
> > index ae33753..45a21cd 100644
> > --- a/checkpolicy/module_compiler.h
> > +++ b/checkpolicy/module_compiler.h
> > @@ -30,11 +30,12 @@ int declare_symbol(uint32_t symbol_type,
> >  		   hashtab_key_t key, hashtab_datum_t datum,
> >  		   uint32_t * dest_value, uint32_t * datum_value);
> >  
> > -role_datum_t *declare_role(void);
> > +role_datum_t *declare_role(unsigned char isattr);
> >  type_datum_t *declare_type(unsigned char primary, unsigned char isattr);
> >  user_datum_t *declare_user(void);
> >  
> >  type_datum_t *get_local_type(char *id, uint32_t value, unsigned char isattr);
> > +role_datum_t *get_local_role(char *id, uint32_t value, unsigned char isattr);
> >  
> >  /* Add a symbol to the current avrule_block's require section.  Note
> >   * that a module may not both declare and require the same symbol.
> > @@ -54,6 +55,7 @@ int require_class(int pass);
> >  int require_role(int pass);
> >  int require_type(int pass);
> >  int require_attribute(int pass);
> > +int require_attribute_role(int pass);
> >  int require_user(int pass);
> >  int require_bool(int pass);
> >  int require_sens(int pass);
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index f75a682..92646a0 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -1774,6 +1774,9 @@ int define_te_avtab(int which)
> >  	return 0;
> >  }
> >  
> > +/* The role-types rule is no longer used to declare regular role or
> > + * role attribute, but solely aimed for declaring role-types associations.
> > + */
> >  int define_role_types(void)
> >  {
> >  	role_datum_t *role;
> > @@ -1786,9 +1789,25 @@ int define_role_types(void)
> >  		return 0;
> >  	}
> >  
> > -	if ((role = declare_role()) == NULL) {
> > +	id = (char *)queue_remove(id_queue);
> > +	if (!id) {
> > +		yyerror("no role name for role-types rule?");
> > +		return -1;
> > +	}
> > +
> > +	if (!is_id_in_scope(SYM_ROLES, id)) {
> > +		yyerror2("role %s is not within scope", id);
> > +		free(id);
> > +		return -1;
> > +	}
> > +
> > +	role = hashtab_search(policydbp->p_roles.table, id);
> > +	if (!role) {
> > +		yyerror2("unknown role %s", id);
> > +		free(id);
> >  		return -1;
> >  	}
> > +
> >  	while ((id = queue_remove(id_queue))) {
> >  		if (set_types(&role->types, id, &add, 0))
> >  			return -1;
> > @@ -1797,6 +1816,132 @@ int define_role_types(void)
> >  	return 0;
> >  }
> >  
> > +int define_attrib_role(void)
> > +{
> > +	if (pass == 2) {
> > +		free(queue_remove(id_queue));
> > +		return 0;
> > +	}
> > +
> > +	/* Declare a role attribute */
> > +	if (declare_role(TRUE) == NULL)
> > +		return -1;
> > +
> > +	return 0;
> > +}
> > +
> > +int define_role_attr(void)
> > +{
> > +	char *id;
> > +	role_datum_t *r, *attr;
> > +
> > +	if (pass == 2) {
> > +		while ((id = queue_remove(id_queue)))
> > +			free(id);
> > +		return 0;
> > +	}
> > +	
> > +	/* Declare a regular role */
> > +	if ((r = declare_role(FALSE)) == NULL)
> > +		return -1;
> > +
> > +	while ((id = queue_remove(id_queue))) {
> > +		if (!is_id_in_scope(SYM_ROLES, id)) {
> > +			yyerror2("attribute %s is not within scope", id);
> > +			free(id);
> > +			return -1;
> > +		}
> > +		attr = hashtab_search(policydbp->p_roles.table, id);
> > +		if (!attr) {
> > +			/* treat it as a fatal error */
> > +			yyerror2("role attribute %s is not declared", id);
> > +			free(id);
> > +			return -1;
> > +		}
> > +
> > +		if (attr->flavor != ROLE_ATTRIB) {
> > +			yyerror2("%s is a regular role, not an attribute", id);
> > +			free(id);
> > +			return -1;
> > +		}
> > +
> > +		if ((attr = get_local_role(id, attr->s.value, 1)) == NULL) {
> > +			yyerror("Out of memory!");
> > +			return -1;
> > +		}
> > +
> > +		if (ebitmap_set_bit(&attr->roles, (r->s.value - 1), TRUE)) {
> > +			yyerror("out of memory");
> > +			return -1;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +int define_roleattribute(void)
> > +{
> > +	char *id;
> > +	role_datum_t *r, *attr;
> > +
> > +	if (pass == 2) {
> > +		while ((id = queue_remove(id_queue)))
> > +			free(id);
> > +		return 0;
> > +	}
> > +
> > +	id = (char *)queue_remove(id_queue);
> > +	if (!id) {
> > +		yyerror("no role name for roleattribute definition?");
> > +		return -1;
> > +	}
> > +
> > +	if (!is_id_in_scope(SYM_ROLES, id)) {
> > +		yyerror2("role %s is not within scope", id);
> > +		free(id);
> > +		return -1;
> > +	}
> > +	r = hashtab_search(policydbp->p_roles.table, id);
> > +	if (!r || r->flavor != ROLE_ROLE) {
> > +		yyerror2("unknown role %s, or not a regular role", id);
> > +		free(id);
> > +		return -1;
> > +	}
> > +
> > +	while ((id = queue_remove(id_queue))) {
> > +		if (!is_id_in_scope(SYM_ROLES, id)) {
> > +			yyerror2("attribute %s is not within scope", id);
> > +			free(id);
> > +			return -1;
> > +		}
> > +		attr = hashtab_search(policydbp->p_roles.table, id);
> > +		if (!attr) {
> > +			/* treat it as a fatal error */
> > +			yyerror2("role attribute %s is not declared", id);
> > +			free(id);
> > +			return -1;
> > +		}
> > +
> > +		if (attr->flavor != ROLE_ATTRIB) {
> > +			yyerror2("%s is a regular role, not an attribute", id);
> > +			free(id);
> > +			return -1;
> > +		}
> > +
> > +		if ((attr = get_local_role(id, attr->s.value, 1)) == NULL) {
> > +			yyerror("Out of memory!");
> > +			return -1;
> > +		}
> > +
> > +		if (ebitmap_set_bit(&attr->roles, (r->s.value - 1), TRUE)) {
> > +			yyerror("out of memory");
> > +			return -1;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  role_datum_t *merge_roles_dom(role_datum_t * r1, role_datum_t * r2)
> >  {
> >  	role_datum_t *new;
> > @@ -2138,6 +2283,11 @@ int define_role_trans(int class_specified)
> >  		goto bad;
> >  	}
> >  
> > +	if (role->flavor != ROLE_ROLE) {
> > +		yyerror2("the new role %s must be a regular role", id);
> > +		goto bad;
> > +	}
> > +
> >  	/* This ebitmap business is just to ensure that there are not conflicting role_trans rules */
> >  	if (role_set_expand(&roles, &e_roles, policydbp, NULL))
> >  		goto bad;
> > diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
> > index 890a6af..fc8cd4d 100644
> > --- a/checkpolicy/policy_define.h
> > +++ b/checkpolicy/policy_define.h
> > @@ -19,6 +19,7 @@ avrule_t *define_cond_te_avtab(int which);
> >  avrule_t *define_cond_filename_trans(void);
> >  cond_expr_t *define_cond_expr(uint32_t expr_type, void *arg1, void* arg2);
> >  int define_attrib(void);
> > +int define_attrib_role(void);
> >  int define_av_perms(int inherits);
> >  int define_bool(void);
> >  int define_category(void);
> > @@ -48,6 +49,8 @@ int define_range_trans(int class_specified);
> >  int define_role_allow(void);
> >  int define_role_trans(int class_specified);
> >  int define_role_types(void);
> > +int define_role_attr(void);
> > +int define_roleattribute(void);
> >  int define_filename_trans(void);
> >  int define_sens(void);
> >  int define_te_avtab(int which);
> > diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
> > index 8274d36..d4cc18e 100644
> > --- a/checkpolicy/policy_parse.y
> > +++ b/checkpolicy/policy_parse.y
> > @@ -90,6 +90,8 @@ typedef int (* require_func_t)();
> >  %token INHERITS
> >  %token SID
> >  %token ROLE
> > +%token ROLEATTRIBUTE
> > +%token ATTRIBUTE_ROLE
> >  %token ROLES
> >  %token TYPEALIAS
> >  %token TYPEATTRIBUTE
> > @@ -252,10 +254,13 @@ te_rbac_decl		: te_decl
> >  			| policycap_def
> >  			| ';'
> >                          ;
> > -rbac_decl		: role_type_def
> > +rbac_decl		: attribute_role_def
> > +			| role_type_def
> >                          | role_dominance
> >                          | role_trans_def
> >   			| role_allow_def
> > +			| roleattribute_def
> > +			| role_attr_def
> >  			;
> >  te_decl			: attribute_def
> >                          | type_def
> > @@ -415,10 +420,13 @@ dontaudit_def		: DONTAUDIT names names ':' names names ';'
> >  neverallow_def		: NEVERALLOW names names ':' names names  ';'
> >  			{if (define_te_avtab(AVRULE_NEVERALLOW)) return -1; }
> >  		        ;
> > +attribute_role_def	: ATTRIBUTE_ROLE identifier ';'
> > +			{if (define_attrib_role()) return -1; }
> >  role_type_def		: ROLE identifier TYPES names ';'
> >  			{if (define_role_types()) return -1;}
> > - 			| ROLE identifier';'
> > - 			{if (define_role_types()) return -1;}
> > +			;
> > +role_attr_def		: ROLE identifier opt_attr_list ';'
> > + 			{if (define_role_attr()) return -1;}
> >                          ;
> >  role_dominance		: DOMINANCE '{' roles '}'
> >  			;
> > @@ -440,6 +448,9 @@ role_def		: ROLE identifier_push ';'
> >  			| ROLE identifier_push '{' roles '}'
> >                          {$$ = define_role_dom((role_datum_t*)$4); if ($$ == 0) return -1;}
> >  			;
> > +roleattribute_def	: ROLEATTRIBUTE identifier id_comma_list ';'
> > +			{if (define_roleattribute()) return -1;}
> > +			;
> >  opt_constraints         : constraints
> >                          |
> >                          ;
> > @@ -804,6 +815,7 @@ require_class           : CLASS identifier names
> >  require_decl_def        : ROLE        { $$ = require_role; }
> >                          | TYPE        { $$ = require_type; }
> >                          | ATTRIBUTE   { $$ = require_attribute; }
> > +                        | ATTRIBUTE_ROLE   { $$ = require_attribute_role; }
> >                          | USER        { $$ = require_user; }
> >                          | BOOL        { $$ = require_bool; }
> >                          | SENSITIVITY { $$ = require_sens; }
> > diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> > index 427c189..b24a087 100644
> > --- a/checkpolicy/policy_scan.l
> > +++ b/checkpolicy/policy_scan.l
> > @@ -76,6 +76,10 @@ ROLE |
> >  role				{ return(ROLE); }
> >  ROLES |
> >  roles				{ return(ROLES); }
> > +ROLEATTRIBUTE |
> > +roleattribute			{ return(ROLEATTRIBUTE);}
> > +ATTRIBUTE_ROLE |
> > +attribute_role			{ return(ATTRIBUTE_ROLE);}
> >  TYPES |
> >  types				{ return(TYPES); }
> >  TYPEALIAS |
> > diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
> > index eebf1a9..b59ab2e 100644
> > --- a/libsepol/include/sepol/policydb/policydb.h
> > +++ b/libsepol/include/sepol/policydb/policydb.h
> > @@ -120,6 +120,10 @@ typedef struct role_datum {
> >  	type_set_t types;	/* set of authorized types for role */
> >  	ebitmap_t cache;	/* This is an expanded set used for context validation during parsing */
> >  	uint32_t bounds;	/* bounds role, if exist */
> > +#define ROLE_ROLE 0		/* regular role in kernel policies */
> > +#define ROLE_ATTRIB 1		/* attribute */
> > +	uint32_t flavor;
> > +	ebitmap_t roles;	/* roles with this attribute */
> >  } role_datum_t;
> >  
> >  typedef struct role_trans {
> > diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> > index 6d8ff91..feb35ae 100644
> > --- a/libsepol/src/policydb.c
> > +++ b/libsepol/src/policydb.c
> > @@ -350,6 +350,7 @@ void role_datum_init(role_datum_t * x)
> >  	ebitmap_init(&x->dominates);
> >  	type_set_init(&x->types);
> >  	ebitmap_init(&x->cache);
> > +	ebitmap_init(&x->roles);
> >  }
> >  
> >  void role_datum_destroy(role_datum_t * x)
> > @@ -358,6 +359,7 @@ void role_datum_destroy(role_datum_t * x)
> >  		ebitmap_destroy(&x->dominates);
> >  		type_set_destroy(&x->types);
> >  		ebitmap_destroy(&x->cache);
> > +		ebitmap_destroy(&x->roles);
> >  	}
> >  }
> >  
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
--_45c32a0d-c0db-419d-bad2-5f337157ad98_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Î¢ÈíÑÅºÚ
}
--></style>
</head>
<body class='hmmessage'><div dir='ltr'>
Hi Steve,<br><br><div>&gt; Date: Fri, 24 Jun 2011 15:36:28 -0400<br>&gt; From: slawrence@tresys.com<br>&gt; To: qingtao.cao@windriver.com<br>&gt; CC: cpebenito@tresys.com; sds@tycho.nsa.gov; method@manicmethod.com; jmorris@namei.org; eparis@parisplace.org; selinux@tycho.nsa.gov<br>&gt; Subject: Re: [v2 PATCH 1/6] Add role attribute support when compiling modules.<br>&gt; <br>&gt; On 06/01/2011 04:57 AM, Harry Ciao wrote:<br>&gt; &gt; 1. Add a uint32_t "flavor" field and an ebitmap "roles" to the<br>&gt; &gt; role_datum_t structure;<br>&gt; &gt; <br>&gt; &gt; 2. Add a new "attribute_role" statement and its handler to declare<br>&gt; &gt; a role attribute;<br>&gt; &gt; <br>&gt; &gt; 3. Modify declare_role() to setup role_datum_t.flavor according<br>&gt; &gt; to the isattr argument;<br>&gt; &gt; <br>&gt; &gt; 4. Add a new "roleattribute" rule and its handler, which will record<br>&gt; &gt; the regular role's (policy value - 1) into the role attribute's<br>&gt; &gt; role_datum_t!
 .roles ebitmap;<br>&gt; &gt; <br>&gt; &gt; 5. Modify the syntax for the role-types rule only to define the<br>&gt; &gt; role-type associations;<br>&gt; &gt; <br>&gt; &gt; 6. Add a new role-attr rule to support the declaration of a single<br>&gt; &gt; role, and optionally the role attribute that the role belongs to;<br>&gt; &gt; <br>&gt; &gt; 7. Check if the new_role used in role-transition rule is a regular role;<br>&gt; &gt; <br>&gt; &gt; 8. Support to require a role attribute;<br>&gt; &gt; <br>&gt; &gt; Signed-off-by: Harry Ciao &lt;qingtao.cao@windriver.com&gt;<br>&gt; &gt; ---<br>&gt; &gt;  checkpolicy/module_compiler.c              |   67 ++++++++++++-<br>&gt; &gt;  checkpolicy/module_compiler.h              |    4 +-<br>&gt; &gt;  checkpolicy/policy_define.c                |  152 +++++++++++++++++++++++++++-<br>&gt; &gt;  checkpolicy/policy_define.h                |    3 +<br>&gt; &gt;  checkpolicy/policy_parse.y                 |   18 +++-<br>&gt; &gt;  checkpolicy/p!
 olicy_scan.l                  |    4 +<br>&gt; &gt;  libsepol/include/
sepol/policydb/policydb.h |    4 +<br>&gt; &gt;  libsepol/src/policydb.c                    |    2 +<br>&gt; &gt;  8 files changed, 246 insertions(+), 8 deletions(-)<br>&gt; &gt; <br>&gt; &gt; diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c<br>&gt; &gt; index 0946ff6..1c1d1d5 100644<br>&gt; &gt; --- a/checkpolicy/module_compiler.c<br>&gt; &gt; +++ b/checkpolicy/module_compiler.c<br>&gt; &gt; @@ -200,7 +200,7 @@ static int role_implicit_bounds(hashtab_t roles_tab,<br>&gt; &gt;  	return 0;<br>&gt; &gt;  }<br>&gt; &gt;  <br>&gt; &gt; -role_datum_t *declare_role(void)<br>&gt; &gt; +role_datum_t *declare_role(unsigned char isattr)<br>&gt; <br>&gt; I'm still looking at this patchset, but noticed some issue with this<br>&gt; function:<br>&gt; <br>&gt; The declare_role function allows a role to be defined multiple times,<br>&gt; which is correct. However, if a role_attribute was defined with the same<br>&gt; name as a role, this function would not error, w!
 hich I believe it should.<br>&gt; <br>&gt; Also, attribute_role's should not be allowed to be defined twice (the<br>&gt; same restriction is applied to normal attributes).<br><br><br>Right, I've got your point, so far the role_copy_callback() function in the link stage could catch the error that a same name is defined twice in two different modules: once as a role attribute but then as a regular role. However, if such error is within a single module, or one role attribute is declared more than once in one single module, these errors can't be caught in the compile time.<br><br>Fortunately,&nbsp; these errors could be detected by the symtab_insert() function, please refer to the attached v3 version for the 0001 patch, while the rest patches in the patchset remain the same so far.<br><br>Thanks!<br><br>Best regards,<br>Harry<br><br><br>&gt; <br>&gt; &gt;  {<br>&gt; &gt;  	char *id = queue_remove(id_queue), *dest_id = NULL;<br>&gt; &gt;  	role_datum_t *role = NULL, *dest_role =!
  NULL;<br>&gt; &gt; @@ -217,7 +217,7 @@ role_datum_t *declare_role(voi
d)<br>&gt; &gt;  		return NULL;<br>&gt; &gt;  	}<br>&gt; &gt;  	role_datum_init(role);<br>&gt; &gt; -<br>&gt; &gt; +	role-&gt;flavor = isattr ? ROLE_ATTRIB : ROLE_ROLE;<br>&gt; &gt;  	retval =<br>&gt; &gt;  	    declare_symbol(SYM_ROLES, id, (hashtab_datum_t *) role, &amp;value,<br>&gt; &gt;  			   &amp;value);<br>&gt; &gt; @@ -254,6 +254,7 @@ role_datum_t *declare_role(void)<br>&gt; &gt;  			}<br>&gt; &gt;  			role_datum_init(dest_role);<br>&gt; &gt;  			dest_role-&gt;s.value = value;<br>&gt; &gt; +			dest_role-&gt;flavor = isattr ? ROLE_ATTRIB : ROLE_ROLE;<br>&gt; &gt;  			if (role_implicit_bounds(roles_tab, dest_id, dest_role)) {<br>&gt; &gt;  				free(dest_id);<br>&gt; &gt;  				role_datum_destroy(dest_role);<br>&gt; &gt; @@ -548,6 +549,55 @@ type_datum_t *get_local_type(char *id, uint32_t value, unsigned char isattr)<br>&gt; &gt;  	return dest_typdatum;<br>&gt; &gt;  }<br>&gt; &gt;  <br>&gt; &gt; +/* Return a role_datum_t for the local avrule_decl with the given ID.<br>!
 &gt; &gt; + * If it does not exist, create one with the same value as 'value'.<br>&gt; &gt; + * This function assumes that the ID is within scope.  c.f.,<br>&gt; &gt; + * is_id_in_scope().<br>&gt; &gt; + *<br>&gt; &gt; + * NOTE: this function usurps ownership of id afterwards.  The caller<br>&gt; &gt; + * shall not reference it nor free() it afterwards.<br>&gt; &gt; + */<br>&gt; &gt; +role_datum_t *get_local_role(char *id, uint32_t value, unsigned char isattr)<br>&gt; &gt; +{<br>&gt; &gt; +	role_datum_t *dest_roledatum;<br>&gt; &gt; +	hashtab_t roles_tab;<br>&gt; &gt; +<br>&gt; &gt; +	assert(stack_top-&gt;type == 1);<br>&gt; &gt; +<br>&gt; &gt; +	if (stack_top-&gt;parent == NULL) {<br>&gt; &gt; +		/* in global, so use global symbol table */<br>&gt; &gt; +		roles_tab = policydbp-&gt;p_roles.table;<br>&gt; &gt; +	} else {<br>&gt; &gt; +		roles_tab = stack_top-&gt;decl-&gt;p_roles.table;<br>&gt; &gt; +	}<br>&gt; &gt; +<br>&gt; &gt; +	dest_roledatum = hashtab_search(roles_tab, !
 id);<br>&gt; &gt; +	if (!dest_roledatum) {<br>&gt; &gt; +		dest_roleda
tum = (role_datum_t *)malloc(sizeof(role_datum_t));<br>&gt; &gt; +		if (dest_roledatum == NULL) {<br>&gt; &gt; +			free(id);<br>&gt; &gt; +			return NULL;<br>&gt; &gt; +		}<br>&gt; &gt; +<br>&gt; &gt; +		role_datum_init(dest_roledatum);<br>&gt; &gt; +		dest_roledatum-&gt;s.value = value;<br>&gt; &gt; +		dest_roledatum-&gt;flavor = isattr ? ROLE_ATTRIB : ROLE_ROLE;<br>&gt; &gt; +<br>&gt; &gt; +		if (hashtab_insert(roles_tab, id, dest_roledatum)) {<br>&gt; &gt; +			free(id);<br>&gt; &gt; +			role_datum_destroy(dest_roledatum);<br>&gt; &gt; +			free(dest_roledatum);<br>&gt; &gt; +			return NULL;<br>&gt; &gt; +		}<br>&gt; &gt; +	} else {<br>&gt; &gt; +		free(id);<br>&gt; &gt; +		if (dest_roledatum-&gt;flavor != isattr ? ROLE_ATTRIB : ROLE_ROLE)<br>&gt; &gt; +			return NULL;<br>&gt; &gt; +	}<br>&gt; &gt; +	<br>&gt; &gt; +	return dest_roledatum;<br>&gt; &gt; +}<br>&gt; &gt; +<br>&gt; &gt;  /* Given the current parse stack, returns 1 if a requirement would be<br>&gt; &gt;   * allow!
 ed here or 0 if not.  For example, the ELSE branch may never<br>&gt; &gt;   * have its own requirements.<br>&gt; &gt; @@ -812,7 +862,7 @@ int require_class(int pass)<br>&gt; &gt;  	return -1;<br>&gt; &gt;  }<br>&gt; &gt;  <br>&gt; &gt; -int require_role(int pass)<br>&gt; &gt; +static int require_role_or_attribute(int pass, unsigned char isattr)<br>&gt; &gt;  {<br>&gt; &gt;  	char *id = queue_remove(id_queue);<br>&gt; &gt;  	role_datum_t *role = NULL;<br>&gt; &gt; @@ -831,6 +881,7 @@ int require_role(int pass)<br>&gt; &gt;  		return -1;<br>&gt; &gt;  	}<br>&gt; &gt;  	role_datum_init(role);<br>&gt; &gt; +	role-&gt;flavor = isattr ? ROLE_ATTRIB : ROLE_ROLE;<br>&gt; &gt;  	retval =<br>&gt; &gt;  	    require_symbol(SYM_ROLES, id, (hashtab_datum_t *) role,<br>&gt; &gt;  			   &amp;role-&gt;s.value, &amp;role-&gt;s.value);<br>&gt; &gt; @@ -870,6 +921,16 @@ int require_role(int pass)<br>&gt; &gt;  	}<br>&gt; &gt;  }<br>&gt; &gt;  <br>&gt; &gt; +int require_role(int pass)<br>&gt; !
 &gt; +{<br>&gt; &gt; +	return require_role_or_attribute(pass, 0);<br>&
gt; &gt; +}<br>&gt; &gt; +<br>&gt; &gt; +int require_attribute_role(int pass)<br>&gt; &gt; +{<br>&gt; &gt; +	return require_role_or_attribute(pass, 1);<br>&gt; &gt; +}<br>&gt; &gt; +<br>&gt; &gt;  static int require_type_or_attribute(int pass, unsigned char isattr)<br>&gt; &gt;  {<br>&gt; &gt;  	char *id = queue_remove(id_queue);<br>&gt; &gt; diff --git a/checkpolicy/module_compiler.h b/checkpolicy/module_compiler.h<br>&gt; &gt; index ae33753..45a21cd 100644<br>&gt; &gt; --- a/checkpolicy/module_compiler.h<br>&gt; &gt; +++ b/checkpolicy/module_compiler.h<br>&gt; &gt; @@ -30,11 +30,12 @@ int declare_symbol(uint32_t symbol_type,<br>&gt; &gt;  		   hashtab_key_t key, hashtab_datum_t datum,<br>&gt; &gt;  		   uint32_t * dest_value, uint32_t * datum_value);<br>&gt; &gt;  <br>&gt; &gt; -role_datum_t *declare_role(void);<br>&gt; &gt; +role_datum_t *declare_role(unsigned char isattr);<br>&gt; &gt;  type_datum_t *declare_type(unsigned char primary, unsigned char isattr);<br>&gt; &gt;!
   user_datum_t *declare_user(void);<br>&gt; &gt;  <br>&gt; &gt;  type_datum_t *get_local_type(char *id, uint32_t value, unsigned char isattr);<br>&gt; &gt; +role_datum_t *get_local_role(char *id, uint32_t value, unsigned char isattr);<br>&gt; &gt;  <br>&gt; &gt;  /* Add a symbol to the current avrule_block's require section.  Note<br>&gt; &gt;   * that a module may not both declare and require the same symbol.<br>&gt; &gt; @@ -54,6 +55,7 @@ int require_class(int pass);<br>&gt; &gt;  int require_role(int pass);<br>&gt; &gt;  int require_type(int pass);<br>&gt; &gt;  int require_attribute(int pass);<br>&gt; &gt; +int require_attribute_role(int pass);<br>&gt; &gt;  int require_user(int pass);<br>&gt; &gt;  int require_bool(int pass);<br>&gt; &gt;  int require_sens(int pass);<br>&gt; &gt; diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c<br>&gt; &gt; index f75a682..92646a0 100644<br>&gt; &gt; --- a/checkpolicy/policy_define.c<br>&gt; &gt; +++ b/checkpolicy/!
 policy_define.c<br>&gt; &gt; @@ -1774,6 +1774,9 @@ int define_te_avtab
(int which)<br>&gt; &gt;  	return 0;<br>&gt; &gt;  }<br>&gt; &gt;  <br>&gt; &gt; +/* The role-types rule is no longer used to declare regular role or<br>&gt; &gt; + * role attribute, but solely aimed for declaring role-types associations.<br>&gt; &gt; + */<br>&gt; &gt;  int define_role_types(void)<br>&gt; &gt;  {<br>&gt; &gt;  	role_datum_t *role;<br>&gt; &gt; @@ -1786,9 +1789,25 @@ int define_role_types(void)<br>&gt; &gt;  		return 0;<br>&gt; &gt;  	}<br>&gt; &gt;  <br>&gt; &gt; -	if ((role = declare_role()) == NULL) {<br>&gt; &gt; +	id = (char *)queue_remove(id_queue);<br>&gt; &gt; +	if (!id) {<br>&gt; &gt; +		yyerror("no role name for role-types rule?");<br>&gt; &gt; +		return -1;<br>&gt; &gt; +	}<br>&gt; &gt; +<br>&gt; &gt; +	if (!is_id_in_scope(SYM_ROLES, id)) {<br>&gt; &gt; +		yyerror2("role %s is not within scope", id);<br>&gt; &gt; +		free(id);<br>&gt; &gt; +		return -1;<br>&gt; &gt; +	}<br>&gt; &gt; +<br>&gt; &gt; +	role = hashtab_search(policydbp-&gt;p_roles.table,!
  id);<br>&gt; &gt; +	if (!role) {<br>&gt; &gt; +		yyerror2("unknown role %s", id);<br>&gt; &gt; +		free(id);<br>&gt; &gt;  		return -1;<br>&gt; &gt;  	}<br>&gt; &gt; +<br>&gt; &gt;  	while ((id = queue_remove(id_queue))) {<br>&gt; &gt;  		if (set_types(&amp;role-&gt;types, id, &amp;add, 0))<br>&gt; &gt;  			return -1;<br>&gt; &gt; @@ -1797,6 +1816,132 @@ int define_role_types(void)<br>&gt; &gt;  	return 0;<br>&gt; &gt;  }<br>&gt; &gt;  <br>&gt; &gt; +int define_attrib_role(void)<br>&gt; &gt; +{<br>&gt; &gt; +	if (pass == 2) {<br>&gt; &gt; +		free(queue_remove(id_queue));<br>&gt; &gt; +		return 0;<br>&gt; &gt; +	}<br>&gt; &gt; +<br>&gt; &gt; +	/* Declare a role attribute */<br>&gt; &gt; +	if (declare_role(TRUE) == NULL)<br>&gt; &gt; +		return -1;<br>&gt; &gt; +<br>&gt; &gt; +	return 0;<br>&gt; &gt; +}<br>&gt; &gt; +<br>&gt; &gt; +int define_role_attr(void)<br>&gt; &gt; +{<br>&gt; &gt; +	char *id;<br>&gt; &gt; +	role_datum_t *r, *attr;<br>&gt; &gt; +<br>&gt; &gt; +	if (pass =!
 = 2) {<br>&gt; &gt; +		while ((id = queue_remove(id_queue)))<br>&gt; &
gt; +			free(id);<br>&gt; &gt; +		return 0;<br>&gt; &gt; +	}<br>&gt; &gt; +	<br>&gt; &gt; +	/* Declare a regular role */<br>&gt; &gt; +	if ((r = declare_role(FALSE)) == NULL)<br>&gt; &gt; +		return -1;<br>&gt; &gt; +<br>&gt; &gt; +	while ((id = queue_remove(id_queue))) {<br>&gt; &gt; +		if (!is_id_in_scope(SYM_ROLES, id)) {<br>&gt; &gt; +			yyerror2("attribute %s is not within scope", id);<br>&gt; &gt; +			free(id);<br>&gt; &gt; +			return -1;<br>&gt; &gt; +		}<br>&gt; &gt; +		attr = hashtab_search(policydbp-&gt;p_roles.table, id);<br>&gt; &gt; +		if (!attr) {<br>&gt; &gt; +			/* treat it as a fatal error */<br>&gt; &gt; +			yyerror2("role attribute %s is not declared", id);<br>&gt; &gt; +			free(id);<br>&gt; &gt; +			return -1;<br>&gt; &gt; +		}<br>&gt; &gt; +<br>&gt; &gt; +		if (attr-&gt;flavor != ROLE_ATTRIB) {<br>&gt; &gt; +			yyerror2("%s is a regular role, not an attribute", id);<br>&gt; &gt; +			free(id);<br>&gt; &gt; +			return -1;<br>&gt; &gt; +		}<br>&gt; &gt; +<br!
 >&gt; &gt; +		if ((attr = get_local_role(id, attr-&gt;s.value, 1)) == NULL) {<br>&gt; &gt; +			yyerror("Out of memory!");<br>&gt; &gt; +			return -1;<br>&gt; &gt; +		}<br>&gt; &gt; +<br>&gt; &gt; +		if (ebitmap_set_bit(&amp;attr-&gt;roles, (r-&gt;s.value - 1), TRUE)) {<br>&gt; &gt; +			yyerror("out of memory");<br>&gt; &gt; +			return -1;<br>&gt; &gt; +		}<br>&gt; &gt; +	}<br>&gt; &gt; +<br>&gt; &gt; +	return 0;<br>&gt; &gt; +}<br>&gt; &gt; +<br>&gt; &gt; +int define_roleattribute(void)<br>&gt; &gt; +{<br>&gt; &gt; +	char *id;<br>&gt; &gt; +	role_datum_t *r, *attr;<br>&gt; &gt; +<br>&gt; &gt; +	if (pass == 2) {<br>&gt; &gt; +		while ((id = queue_remove(id_queue)))<br>&gt; &gt; +			free(id);<br>&gt; &gt; +		return 0;<br>&gt; &gt; +	}<br>&gt; &gt; +<br>&gt; &gt; +	id = (char *)queue_remove(id_queue);<br>&gt; &gt; +	if (!id) {<br>&gt; &gt; +		yyerror("no role name for roleattribute definition?");<br>&gt; &gt; +		return -1;<br>&gt; &gt; +	}<br>&gt; &gt; +<br>&gt; &gt; +	if (!is!
 _id_in_scope(SYM_ROLES, id)) {<br>&gt; &gt; +		yyerror2("role %s is no
t within scope", id);<br>&gt; &gt; +		free(id);<br>&gt; &gt; +		return -1;<br>&gt; &gt; +	}<br>&gt; &gt; +	r = hashtab_search(policydbp-&gt;p_roles.table, id);<br>&gt; &gt; +	if (!r || r-&gt;flavor != ROLE_ROLE) {<br>&gt; &gt; +		yyerror2("unknown role %s, or not a regular role", id);<br>&gt; &gt; +		free(id);<br>&gt; &gt; +		return -1;<br>&gt; &gt; +	}<br>&gt; &gt; +<br>&gt; &gt; +	while ((id = queue_remove(id_queue))) {<br>&gt; &gt; +		if (!is_id_in_scope(SYM_ROLES, id)) {<br>&gt; &gt; +			yyerror2("attribute %s is not within scope", id);<br>&gt; &gt; +			free(id);<br>&gt; &gt; +			return -1;<br>&gt; &gt; +		}<br>&gt; &gt; +		attr = hashtab_search(policydbp-&gt;p_roles.table, id);<br>&gt; &gt; +		if (!attr) {<br>&gt; &gt; +			/* treat it as a fatal error */<br>&gt; &gt; +			yyerror2("role attribute %s is not declared", id);<br>&gt; &gt; +			free(id);<br>&gt; &gt; +			return -1;<br>&gt; &gt; +		}<br>&gt; &gt; +<br>&gt; &gt; +		if (attr-&gt;flavor != ROLE_ATTRIB) {<br>&gt; &!
 gt; +			yyerror2("%s is a regular role, not an attribute", id);<br>&gt; &gt; +			free(id);<br>&gt; &gt; +			return -1;<br>&gt; &gt; +		}<br>&gt; &gt; +<br>&gt; &gt; +		if ((attr = get_local_role(id, attr-&gt;s.value, 1)) == NULL) {<br>&gt; &gt; +			yyerror("Out of memory!");<br>&gt; &gt; +			return -1;<br>&gt; &gt; +		}<br>&gt; &gt; +<br>&gt; &gt; +		if (ebitmap_set_bit(&amp;attr-&gt;roles, (r-&gt;s.value - 1), TRUE)) {<br>&gt; &gt; +			yyerror("out of memory");<br>&gt; &gt; +			return -1;<br>&gt; &gt; +		}<br>&gt; &gt; +	}<br>&gt; &gt; +<br>&gt; &gt; +	return 0;<br>&gt; &gt; +}<br>&gt; &gt; +<br>&gt; &gt;  role_datum_t *merge_roles_dom(role_datum_t * r1, role_datum_t * r2)<br>&gt; &gt;  {<br>&gt; &gt;  	role_datum_t *new;<br>&gt; &gt; @@ -2138,6 +2283,11 @@ int define_role_trans(int class_specified)<br>&gt; &gt;  		goto bad;<br>&gt; &gt;  	}<br>&gt; &gt;  <br>&gt; &gt; +	if (role-&gt;flavor != ROLE_ROLE) {<br>&gt; &gt; +		yyerror2("the new role %s must be a regular role", !
 id);<br>&gt; &gt; +		goto bad;<br>&gt; &gt; +	}<br>&gt; &gt; +<br>&gt;
 &gt;  	/* This ebitmap business is just to ensure that there are not conflicting role_trans rules */<br>&gt; &gt;  	if (role_set_expand(&amp;roles, &amp;e_roles, policydbp, NULL))<br>&gt; &gt;  		goto bad;<br>&gt; &gt; diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h<br>&gt; &gt; index 890a6af..fc8cd4d 100644<br>&gt; &gt; --- a/checkpolicy/policy_define.h<br>&gt; &gt; +++ b/checkpolicy/policy_define.h<br>&gt; &gt; @@ -19,6 +19,7 @@ avrule_t *define_cond_te_avtab(int which);<br>&gt; &gt;  avrule_t *define_cond_filename_trans(void);<br>&gt; &gt;  cond_expr_t *define_cond_expr(uint32_t expr_type, void *arg1, void* arg2);<br>&gt; &gt;  int define_attrib(void);<br>&gt; &gt; +int define_attrib_role(void);<br>&gt; &gt;  int define_av_perms(int inherits);<br>&gt; &gt;  int define_bool(void);<br>&gt; &gt;  int define_category(void);<br>&gt; &gt; @@ -48,6 +49,8 @@ int define_range_trans(int class_specified);<br>&gt; &gt;  int define_role_allow(void);<br>&gt; &gt!
 ;  int define_role_trans(int class_specified);<br>&gt; &gt;  int define_role_types(void);<br>&gt; &gt; +int define_role_attr(void);<br>&gt; &gt; +int define_roleattribute(void);<br>&gt; &gt;  int define_filename_trans(void);<br>&gt; &gt;  int define_sens(void);<br>&gt; &gt;  int define_te_avtab(int which);<br>&gt; &gt; diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y<br>&gt; &gt; index 8274d36..d4cc18e 100644<br>&gt; &gt; --- a/checkpolicy/policy_parse.y<br>&gt; &gt; +++ b/checkpolicy/policy_parse.y<br>&gt; &gt; @@ -90,6 +90,8 @@ typedef int (* require_func_t)();<br>&gt; &gt;  %token INHERITS<br>&gt; &gt;  %token SID<br>&gt; &gt;  %token ROLE<br>&gt; &gt; +%token ROLEATTRIBUTE<br>&gt; &gt; +%token ATTRIBUTE_ROLE<br>&gt; &gt;  %token ROLES<br>&gt; &gt;  %token TYPEALIAS<br>&gt; &gt;  %token TYPEATTRIBUTE<br>&gt; &gt; @@ -252,10 +254,13 @@ te_rbac_decl		: te_decl<br>&gt; &gt;  			| policycap_def<br>&gt; &gt;  			| ';'<br>&gt; &gt;                          !
 ;<br>&gt; &gt; -rbac_decl		: role_type_def<br>&gt; &gt; +rbac_decl		: 
attribute_role_def<br>&gt; &gt; +			| role_type_def<br>&gt; &gt;                          | role_dominance<br>&gt; &gt;                          | role_trans_def<br>&gt; &gt;   			| role_allow_def<br>&gt; &gt; +			| roleattribute_def<br>&gt; &gt; +			| role_attr_def<br>&gt; &gt;  			;<br>&gt; &gt;  te_decl			: attribute_def<br>&gt; &gt;                          | type_def<br>&gt; &gt; @@ -415,10 +420,13 @@ dontaudit_def		: DONTAUDIT names names ':' names names ';'<br>&gt; &gt;  neverallow_def		: NEVERALLOW names names ':' names names  ';'<br>&gt; &gt;  			{if (define_te_avtab(AVRULE_NEVERALLOW)) return -1; }<br>&gt; &gt;  		        ;<br>&gt; &gt; +attribute_role_def	: ATTRIBUTE_ROLE identifier ';'<br>&gt; &gt; +			{if (define_attrib_role()) return -1; }<br>&gt; &gt;  role_type_def		: ROLE identifier TYPES names ';'<br>&gt; &gt;  			{if (define_role_types()) return -1;}<br>&gt; &gt; - 			| ROLE identifier';'<br>&gt; &gt; - 			{if (define_role_types()) return -1;}<br>&gt; &gt;!
  +			;<br>&gt; &gt; +role_attr_def		: ROLE identifier opt_attr_list ';'<br>&gt; &gt; + 			{if (define_role_attr()) return -1;}<br>&gt; &gt;                          ;<br>&gt; &gt;  role_dominance		: DOMINANCE '{' roles '}'<br>&gt; &gt;  			;<br>&gt; &gt; @@ -440,6 +448,9 @@ role_def		: ROLE identifier_push ';'<br>&gt; &gt;  			| ROLE identifier_push '{' roles '}'<br>&gt; &gt;                          {$$ = define_role_dom((role_datum_t*)$4); if ($$ == 0) return -1;}<br>&gt; &gt;  			;<br>&gt; &gt; +roleattribute_def	: ROLEATTRIBUTE identifier id_comma_list ';'<br>&gt; &gt; +			{if (define_roleattribute()) return -1;}<br>&gt; &gt; +			;<br>&gt; &gt;  opt_constraints         : constraints<br>&gt; &gt;                          |<br>&gt; &gt;                          ;<br>&gt; &gt; @@ -804,6 +815,7 @@ require_class           : CLASS identifier names<br>&gt; &gt;  require_decl_def        : ROLE        { $$ = require_role; }<br>&gt; &gt;                          | TYPE        { $!
 $ = require_type; }<br>&gt; &gt;                          | ATTRIBUTE 
  { $$ = require_attribute; }<br>&gt; &gt; +                        | ATTRIBUTE_ROLE   { $$ = require_attribute_role; }<br>&gt; &gt;                          | USER        { $$ = require_user; }<br>&gt; &gt;                          | BOOL        { $$ = require_bool; }<br>&gt; &gt;                          | SENSITIVITY { $$ = require_sens; }<br>&gt; &gt; diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l<br>&gt; &gt; index 427c189..b24a087 100644<br>&gt; &gt; --- a/checkpolicy/policy_scan.l<br>&gt; &gt; +++ b/checkpolicy/policy_scan.l<br>&gt; &gt; @@ -76,6 +76,10 @@ ROLE |<br>&gt; &gt;  role				{ return(ROLE); }<br>&gt; &gt;  ROLES |<br>&gt; &gt;  roles				{ return(ROLES); }<br>&gt; &gt; +ROLEATTRIBUTE |<br>&gt; &gt; +roleattribute			{ return(ROLEATTRIBUTE);}<br>&gt; &gt; +ATTRIBUTE_ROLE |<br>&gt; &gt; +attribute_role			{ return(ATTRIBUTE_ROLE);}<br>&gt; &gt;  TYPES |<br>&gt; &gt;  types				{ return(TYPES); }<br>&gt; &gt;  TYPEALIAS |<br>&gt; &gt; diff --git!
  a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h<br>&gt; &gt; index eebf1a9..b59ab2e 100644<br>&gt; &gt; --- a/libsepol/include/sepol/policydb/policydb.h<br>&gt; &gt; +++ b/libsepol/include/sepol/policydb/policydb.h<br>&gt; &gt; @@ -120,6 +120,10 @@ typedef struct role_datum {<br>&gt; &gt;  	type_set_t types;	/* set of authorized types for role */<br>&gt; &gt;  	ebitmap_t cache;	/* This is an expanded set used for context validation during parsing */<br>&gt; &gt;  	uint32_t bounds;	/* bounds role, if exist */<br>&gt; &gt; +#define ROLE_ROLE 0		/* regular role in kernel policies */<br>&gt; &gt; +#define ROLE_ATTRIB 1		/* attribute */<br>&gt; &gt; +	uint32_t flavor;<br>&gt; &gt; +	ebitmap_t roles;	/* roles with this attribute */<br>&gt; &gt;  } role_datum_t;<br>&gt; &gt;  <br>&gt; &gt;  typedef struct role_trans {<br>&gt; &gt; diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c<br>&gt; &gt; index 6d8ff91..feb35ae 100644<br>!
 &gt; &gt; --- a/libsepol/src/policydb.c<br>&gt; &gt; +++ b/libsepol/sr
c/policydb.c<br>&gt; &gt; @@ -350,6 +350,7 @@ void role_datum_init(role_datum_t * x)<br>&gt; &gt;  	ebitmap_init(&amp;x-&gt;dominates);<br>&gt; &gt;  	type_set_init(&amp;x-&gt;types);<br>&gt; &gt;  	ebitmap_init(&amp;x-&gt;cache);<br>&gt; &gt; +	ebitmap_init(&amp;x-&gt;roles);<br>&gt; &gt;  }<br>&gt; &gt;  <br>&gt; &gt;  void role_datum_destroy(role_datum_t * x)<br>&gt; &gt; @@ -358,6 +359,7 @@ void role_datum_destroy(role_datum_t * x)<br>&gt; &gt;  		ebitmap_destroy(&amp;x-&gt;dominates);<br>&gt; &gt;  		type_set_destroy(&amp;x-&gt;types);<br>&gt; &gt;  		ebitmap_destroy(&amp;x-&gt;cache);<br>&gt; &gt; +		ebitmap_destroy(&amp;x-&gt;roles);<br>&gt; &gt;  	}<br>&gt; &gt;  }<br>&gt; &gt;  <br>&gt; <br>&gt; <br>&gt; --<br>&gt; This message was distributed to subscribers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br></div> 		 	   		  </di!
 v></body>
</html>
--_45c32a0d-c0db-419d-bad2-5f337157ad98_--

--_fc2d5afd-0b58-411b-a89f-2a978a0a4d8e_
Content-Type: text/x-patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="v3-0001-Add-role-attribute-support-when-compiling-modules.patch"

RnJvbSAyNjU3Y2Q3MmQ1NTY5ZjNiMGNiNGMzZjgyYmQyZjUzZmVlZGRmY2M5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYXJyeSBDaWFvIDxxaW5ndGFvLmNhb0B3aW5kcml2ZXIuY29t
PgpEYXRlOiBTYXQsIDIxIE1heSAyMDExIDA5OjM2OjAzICswODAwClN1YmplY3Q6IFt2MyBQQVRD
SCAxLzZdIEFkZCByb2xlIGF0dHJpYnV0ZSBzdXBwb3J0IHdoZW4gY29tcGlsaW5nIG1vZHVsZXMu
CgoxLiBBZGQgYSB1aW50MzJfdCAiZmxhdm9yIiBmaWVsZCBhbmQgYW4gZWJpdG1hcCAicm9sZXMi
IHRvIHRoZQpyb2xlX2RhdHVtX3Qgc3RydWN0dXJlOwoKMi4gQWRkIGEgbmV3ICJhdHRyaWJ1dGVf
cm9sZSIgc3RhdGVtZW50IGFuZCBpdHMgaGFuZGxlciB0byBkZWNsYXJlCmEgcm9sZSBhdHRyaWJ1
dGU7CgozLiBNb2RpZnkgZGVjbGFyZV9yb2xlKCkgdG8gc2V0dXAgcm9sZV9kYXR1bV90LmZsYXZv
ciBhY2NvcmRpbmcKdG8gdGhlIGlzYXR0ciBhcmd1bWVudDsKCjQuIEFkZCBhIG5ldyAicm9sZWF0
dHJpYnV0ZSIgcnVsZSBhbmQgaXRzIGhhbmRsZXIsIHdoaWNoIHdpbGwgcmVjb3JkCnRoZSByZWd1
bGFyIHJvbGUncyAocG9saWN5IHZhbHVlIC0gMSkgaW50byB0aGUgcm9sZSBhdHRyaWJ1dGUncwpy
b2xlX2RhdHVtX3Qucm9sZXMgZWJpdG1hcDsKCjUuIE1vZGlmeSB0aGUgc3ludGF4IGZvciB0aGUg
cm9sZS10eXBlcyBydWxlIG9ubHkgdG8gZGVmaW5lIHRoZQpyb2xlLXR5cGUgYXNzb2NpYXRpb25z
OwoKNi4gQWRkIGEgbmV3IHJvbGUtYXR0ciBydWxlIHRvIHN1cHBvcnQgdGhlIGRlY2xhcmF0aW9u
IG9mIGEgc2luZ2xlCnJvbGUsIGFuZCBvcHRpb25hbGx5IHRoZSByb2xlIGF0dHJpYnV0ZSB0aGF0
IHRoZSByb2xlIGJlbG9uZ3MgdG87Cgo3LiBDaGVjayBpZiB0aGUgbmV3X3JvbGUgdXNlZCBpbiBy
b2xlLXRyYW5zaXRpb24gcnVsZSBpcyBhIHJlZ3VsYXIgcm9sZTsKCjguIFN1cHBvcnQgdG8gcmVx
dWlyZSBhIHJvbGUgYXR0cmlidXRlOwoKOS4gTW9kaWZ5IHN5bXRhYl9pbnNlcnQoKSB0byBhbGxv
dyBtdWx0aXBsZSBkZWNsYXJhdGlvbnMgb25seSBmb3IKdGhlIHJlZ3VsYXIgcm9sZSwgd2hpbGUg
YSByb2xlIGF0dHJpYnV0ZSBjYW4ndCBiZSBkZWNsYXJlZCBtb3JlIHRoYW4gb25jZQphbmQgY2Fu
J3Qgc2hhcmUgYSBzYW1lIG5hbWUgd2l0aCBhbm90aGVyIHJlZ3VsYXIgcm9sZS4KClNpZ25lZC1v
ZmYtYnk6IEhhcnJ5IENpYW8gPHFpbmd0YW8uY2FvQHdpbmRyaXZlci5jb20+Ci0tLQogY2hlY2tw
b2xpY3kvbW9kdWxlX2NvbXBpbGVyLmMgICAgICAgICAgICAgIHwgICA2NyArKysrKysrKysrKyst
CiBjaGVja3BvbGljeS9tb2R1bGVfY29tcGlsZXIuaCAgICAgICAgICAgICAgfCAgICA0ICstCiBj
aGVja3BvbGljeS9wb2xpY3lfZGVmaW5lLmMgICAgICAgICAgICAgICAgfCAgMTUyICsrKysrKysr
KysrKysrKysrKysrKysrKysrKy0KIGNoZWNrcG9saWN5L3BvbGljeV9kZWZpbmUuaCAgICAgICAg
ICAgICAgICB8ICAgIDMgKwogY2hlY2twb2xpY3kvcG9saWN5X3BhcnNlLnkgICAgICAgICAgICAg
ICAgIHwgICAxOCArKystCiBjaGVja3BvbGljeS9wb2xpY3lfc2Nhbi5sICAgICAgICAgICAgICAg
ICAgfCAgICA0ICsKIGxpYnNlcG9sL2luY2x1ZGUvc2Vwb2wvcG9saWN5ZGIvcG9saWN5ZGIuaCB8
ICAgIDQgKwogbGlic2Vwb2wvc3JjL3BvbGljeWRiLmMgICAgICAgICAgICAgICAgICAgIHwgICAy
MSArKysrCiA4IGZpbGVzIGNoYW5nZWQsIDI2NSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2NoZWNrcG9saWN5L21vZHVsZV9jb21waWxlci5jIGIvY2hlY2twb2xp
Y3kvbW9kdWxlX2NvbXBpbGVyLmMKaW5kZXggMDk0NmZmNi4uMWMxZDFkNSAxMDA2NDQKLS0tIGEv
Y2hlY2twb2xpY3kvbW9kdWxlX2NvbXBpbGVyLmMKKysrIGIvY2hlY2twb2xpY3kvbW9kdWxlX2Nv
bXBpbGVyLmMKQEAgLTIwMCw3ICsyMDAsNyBAQCBzdGF0aWMgaW50IHJvbGVfaW1wbGljaXRfYm91
bmRzKGhhc2h0YWJfdCByb2xlc190YWIsCiAJcmV0dXJuIDA7CiB9CiAKLXJvbGVfZGF0dW1fdCAq
ZGVjbGFyZV9yb2xlKHZvaWQpCityb2xlX2RhdHVtX3QgKmRlY2xhcmVfcm9sZSh1bnNpZ25lZCBj
aGFyIGlzYXR0cikKIHsKIAljaGFyICppZCA9IHF1ZXVlX3JlbW92ZShpZF9xdWV1ZSksICpkZXN0
X2lkID0gTlVMTDsKIAlyb2xlX2RhdHVtX3QgKnJvbGUgPSBOVUxMLCAqZGVzdF9yb2xlID0gTlVM
TDsKQEAgLTIxNyw3ICsyMTcsNyBAQCByb2xlX2RhdHVtX3QgKmRlY2xhcmVfcm9sZSh2b2lkKQog
CQlyZXR1cm4gTlVMTDsKIAl9CiAJcm9sZV9kYXR1bV9pbml0KHJvbGUpOwotCisJcm9sZS0+Zmxh
dm9yID0gaXNhdHRyID8gUk9MRV9BVFRSSUIgOiBST0xFX1JPTEU7CiAJcmV0dmFsID0KIAkgICAg
ZGVjbGFyZV9zeW1ib2woU1lNX1JPTEVTLCBpZCwgKGhhc2h0YWJfZGF0dW1fdCAqKSByb2xlLCAm
dmFsdWUsCiAJCQkgICAmdmFsdWUpOwpAQCAtMjU0LDYgKzI1NCw3IEBAIHJvbGVfZGF0dW1fdCAq
ZGVjbGFyZV9yb2xlKHZvaWQpCiAJCQl9CiAJCQlyb2xlX2RhdHVtX2luaXQoZGVzdF9yb2xlKTsK
IAkJCWRlc3Rfcm9sZS0+cy52YWx1ZSA9IHZhbHVlOworCQkJZGVzdF9yb2xlLT5mbGF2b3IgPSBp
c2F0dHIgPyBST0xFX0FUVFJJQiA6IFJPTEVfUk9MRTsKIAkJCWlmIChyb2xlX2ltcGxpY2l0X2Jv
dW5kcyhyb2xlc190YWIsIGRlc3RfaWQsIGRlc3Rfcm9sZSkpIHsKIAkJCQlmcmVlKGRlc3RfaWQp
OwogCQkJCXJvbGVfZGF0dW1fZGVzdHJveShkZXN0X3JvbGUpOwpAQCAtNTQ4LDYgKzU0OSw1NSBA
QCB0eXBlX2RhdHVtX3QgKmdldF9sb2NhbF90eXBlKGNoYXIgKmlkLCB1aW50MzJfdCB2YWx1ZSwg
dW5zaWduZWQgY2hhciBpc2F0dHIpCiAJcmV0dXJuIGRlc3RfdHlwZGF0dW07CiB9CiAKKy8qIFJl
dHVybiBhIHJvbGVfZGF0dW1fdCBmb3IgdGhlIGxvY2FsIGF2cnVsZV9kZWNsIHdpdGggdGhlIGdp
dmVuIElELgorICogSWYgaXQgZG9lcyBub3QgZXhpc3QsIGNyZWF0ZSBvbmUgd2l0aCB0aGUgc2Ft
ZSB2YWx1ZSBhcyAndmFsdWUnLgorICogVGhpcyBmdW5jdGlvbiBhc3N1bWVzIHRoYXQgdGhlIElE
IGlzIHdpdGhpbiBzY29wZS4gIGMuZi4sCisgKiBpc19pZF9pbl9zY29wZSgpLgorICoKKyAqIE5P
VEU6IHRoaXMgZnVuY3Rpb24gdXN1cnBzIG93bmVyc2hpcCBvZiBpZCBhZnRlcndhcmRzLiAgVGhl
IGNhbGxlcgorICogc2hhbGwgbm90IHJlZmVyZW5jZSBpdCBub3IgZnJlZSgpIGl0IGFmdGVyd2Fy
ZHMuCisgKi8KK3JvbGVfZGF0dW1fdCAqZ2V0X2xvY2FsX3JvbGUoY2hhciAqaWQsIHVpbnQzMl90
IHZhbHVlLCB1bnNpZ25lZCBjaGFyIGlzYXR0cikKK3sKKwlyb2xlX2RhdHVtX3QgKmRlc3Rfcm9s
ZWRhdHVtOworCWhhc2h0YWJfdCByb2xlc190YWI7CisKKwlhc3NlcnQoc3RhY2tfdG9wLT50eXBl
ID09IDEpOworCisJaWYgKHN0YWNrX3RvcC0+cGFyZW50ID09IE5VTEwpIHsKKwkJLyogaW4gZ2xv
YmFsLCBzbyB1c2UgZ2xvYmFsIHN5bWJvbCB0YWJsZSAqLworCQlyb2xlc190YWIgPSBwb2xpY3lk
YnAtPnBfcm9sZXMudGFibGU7CisJfSBlbHNlIHsKKwkJcm9sZXNfdGFiID0gc3RhY2tfdG9wLT5k
ZWNsLT5wX3JvbGVzLnRhYmxlOworCX0KKworCWRlc3Rfcm9sZWRhdHVtID0gaGFzaHRhYl9zZWFy
Y2gocm9sZXNfdGFiLCBpZCk7CisJaWYgKCFkZXN0X3JvbGVkYXR1bSkgeworCQlkZXN0X3JvbGVk
YXR1bSA9IChyb2xlX2RhdHVtX3QgKiltYWxsb2Moc2l6ZW9mKHJvbGVfZGF0dW1fdCkpOworCQlp
ZiAoZGVzdF9yb2xlZGF0dW0gPT0gTlVMTCkgeworCQkJZnJlZShpZCk7CisJCQlyZXR1cm4gTlVM
TDsKKwkJfQorCisJCXJvbGVfZGF0dW1faW5pdChkZXN0X3JvbGVkYXR1bSk7CisJCWRlc3Rfcm9s
ZWRhdHVtLT5zLnZhbHVlID0gdmFsdWU7CisJCWRlc3Rfcm9sZWRhdHVtLT5mbGF2b3IgPSBpc2F0
dHIgPyBST0xFX0FUVFJJQiA6IFJPTEVfUk9MRTsKKworCQlpZiAoaGFzaHRhYl9pbnNlcnQocm9s
ZXNfdGFiLCBpZCwgZGVzdF9yb2xlZGF0dW0pKSB7CisJCQlmcmVlKGlkKTsKKwkJCXJvbGVfZGF0
dW1fZGVzdHJveShkZXN0X3JvbGVkYXR1bSk7CisJCQlmcmVlKGRlc3Rfcm9sZWRhdHVtKTsKKwkJ
CXJldHVybiBOVUxMOworCQl9CisJfSBlbHNlIHsKKwkJZnJlZShpZCk7CisJCWlmIChkZXN0X3Jv
bGVkYXR1bS0+Zmxhdm9yICE9IGlzYXR0ciA/IFJPTEVfQVRUUklCIDogUk9MRV9ST0xFKQorCQkJ
cmV0dXJuIE5VTEw7CisJfQorCQorCXJldHVybiBkZXN0X3JvbGVkYXR1bTsKK30KKwogLyogR2l2
ZW4gdGhlIGN1cnJlbnQgcGFyc2Ugc3RhY2ssIHJldHVybnMgMSBpZiBhIHJlcXVpcmVtZW50IHdv
dWxkIGJlCiAgKiBhbGxvd2VkIGhlcmUgb3IgMCBpZiBub3QuICBGb3IgZXhhbXBsZSwgdGhlIEVM
U0UgYnJhbmNoIG1heSBuZXZlcgogICogaGF2ZSBpdHMgb3duIHJlcXVpcmVtZW50cy4KQEAgLTgx
Miw3ICs4NjIsNyBAQCBpbnQgcmVxdWlyZV9jbGFzcyhpbnQgcGFzcykKIAlyZXR1cm4gLTE7CiB9
CiAKLWludCByZXF1aXJlX3JvbGUoaW50IHBhc3MpCitzdGF0aWMgaW50IHJlcXVpcmVfcm9sZV9v
cl9hdHRyaWJ1dGUoaW50IHBhc3MsIHVuc2lnbmVkIGNoYXIgaXNhdHRyKQogewogCWNoYXIgKmlk
ID0gcXVldWVfcmVtb3ZlKGlkX3F1ZXVlKTsKIAlyb2xlX2RhdHVtX3QgKnJvbGUgPSBOVUxMOwpA
QCAtODMxLDYgKzg4MSw3IEBAIGludCByZXF1aXJlX3JvbGUoaW50IHBhc3MpCiAJCXJldHVybiAt
MTsKIAl9CiAJcm9sZV9kYXR1bV9pbml0KHJvbGUpOworCXJvbGUtPmZsYXZvciA9IGlzYXR0ciA/
IFJPTEVfQVRUUklCIDogUk9MRV9ST0xFOwogCXJldHZhbCA9CiAJICAgIHJlcXVpcmVfc3ltYm9s
KFNZTV9ST0xFUywgaWQsIChoYXNodGFiX2RhdHVtX3QgKikgcm9sZSwKIAkJCSAgICZyb2xlLT5z
LnZhbHVlLCAmcm9sZS0+cy52YWx1ZSk7CkBAIC04NzAsNiArOTIxLDE2IEBAIGludCByZXF1aXJl
X3JvbGUoaW50IHBhc3MpCiAJfQogfQogCitpbnQgcmVxdWlyZV9yb2xlKGludCBwYXNzKQorewor
CXJldHVybiByZXF1aXJlX3JvbGVfb3JfYXR0cmlidXRlKHBhc3MsIDApOworfQorCitpbnQgcmVx
dWlyZV9hdHRyaWJ1dGVfcm9sZShpbnQgcGFzcykKK3sKKwlyZXR1cm4gcmVxdWlyZV9yb2xlX29y
X2F0dHJpYnV0ZShwYXNzLCAxKTsKK30KKwogc3RhdGljIGludCByZXF1aXJlX3R5cGVfb3JfYXR0
cmlidXRlKGludCBwYXNzLCB1bnNpZ25lZCBjaGFyIGlzYXR0cikKIHsKIAljaGFyICppZCA9IHF1
ZXVlX3JlbW92ZShpZF9xdWV1ZSk7CmRpZmYgLS1naXQgYS9jaGVja3BvbGljeS9tb2R1bGVfY29t
cGlsZXIuaCBiL2NoZWNrcG9saWN5L21vZHVsZV9jb21waWxlci5oCmluZGV4IGFlMzM3NTMuLjQ1
YTIxY2QgMTAwNjQ0Ci0tLSBhL2NoZWNrcG9saWN5L21vZHVsZV9jb21waWxlci5oCisrKyBiL2No
ZWNrcG9saWN5L21vZHVsZV9jb21waWxlci5oCkBAIC0zMCwxMSArMzAsMTIgQEAgaW50IGRlY2xh
cmVfc3ltYm9sKHVpbnQzMl90IHN5bWJvbF90eXBlLAogCQkgICBoYXNodGFiX2tleV90IGtleSwg
aGFzaHRhYl9kYXR1bV90IGRhdHVtLAogCQkgICB1aW50MzJfdCAqIGRlc3RfdmFsdWUsIHVpbnQz
Ml90ICogZGF0dW1fdmFsdWUpOwogCi1yb2xlX2RhdHVtX3QgKmRlY2xhcmVfcm9sZSh2b2lkKTsK
K3JvbGVfZGF0dW1fdCAqZGVjbGFyZV9yb2xlKHVuc2lnbmVkIGNoYXIgaXNhdHRyKTsKIHR5cGVf
ZGF0dW1fdCAqZGVjbGFyZV90eXBlKHVuc2lnbmVkIGNoYXIgcHJpbWFyeSwgdW5zaWduZWQgY2hh
ciBpc2F0dHIpOwogdXNlcl9kYXR1bV90ICpkZWNsYXJlX3VzZXIodm9pZCk7CiAKIHR5cGVfZGF0
dW1fdCAqZ2V0X2xvY2FsX3R5cGUoY2hhciAqaWQsIHVpbnQzMl90IHZhbHVlLCB1bnNpZ25lZCBj
aGFyIGlzYXR0cik7Cityb2xlX2RhdHVtX3QgKmdldF9sb2NhbF9yb2xlKGNoYXIgKmlkLCB1aW50
MzJfdCB2YWx1ZSwgdW5zaWduZWQgY2hhciBpc2F0dHIpOwogCiAvKiBBZGQgYSBzeW1ib2wgdG8g
dGhlIGN1cnJlbnQgYXZydWxlX2Jsb2NrJ3MgcmVxdWlyZSBzZWN0aW9uLiAgTm90ZQogICogdGhh
dCBhIG1vZHVsZSBtYXkgbm90IGJvdGggZGVjbGFyZSBhbmQgcmVxdWlyZSB0aGUgc2FtZSBzeW1i
b2wuCkBAIC01NCw2ICs1NSw3IEBAIGludCByZXF1aXJlX2NsYXNzKGludCBwYXNzKTsKIGludCBy
ZXF1aXJlX3JvbGUoaW50IHBhc3MpOwogaW50IHJlcXVpcmVfdHlwZShpbnQgcGFzcyk7CiBpbnQg
cmVxdWlyZV9hdHRyaWJ1dGUoaW50IHBhc3MpOworaW50IHJlcXVpcmVfYXR0cmlidXRlX3JvbGUo
aW50IHBhc3MpOwogaW50IHJlcXVpcmVfdXNlcihpbnQgcGFzcyk7CiBpbnQgcmVxdWlyZV9ib29s
KGludCBwYXNzKTsKIGludCByZXF1aXJlX3NlbnMoaW50IHBhc3MpOwpkaWZmIC0tZ2l0IGEvY2hl
Y2twb2xpY3kvcG9saWN5X2RlZmluZS5jIGIvY2hlY2twb2xpY3kvcG9saWN5X2RlZmluZS5jCmlu
ZGV4IGY3NWE2ODIuLjkyNjQ2YTAgMTAwNjQ0Ci0tLSBhL2NoZWNrcG9saWN5L3BvbGljeV9kZWZp
bmUuYworKysgYi9jaGVja3BvbGljeS9wb2xpY3lfZGVmaW5lLmMKQEAgLTE3NzQsNiArMTc3NCw5
IEBAIGludCBkZWZpbmVfdGVfYXZ0YWIoaW50IHdoaWNoKQogCXJldHVybiAwOwogfQogCisvKiBU
aGUgcm9sZS10eXBlcyBydWxlIGlzIG5vIGxvbmdlciB1c2VkIHRvIGRlY2xhcmUgcmVndWxhciBy
b2xlIG9yCisgKiByb2xlIGF0dHJpYnV0ZSwgYnV0IHNvbGVseSBhaW1lZCBmb3IgZGVjbGFyaW5n
IHJvbGUtdHlwZXMgYXNzb2NpYXRpb25zLgorICovCiBpbnQgZGVmaW5lX3JvbGVfdHlwZXModm9p
ZCkKIHsKIAlyb2xlX2RhdHVtX3QgKnJvbGU7CkBAIC0xNzg2LDkgKzE3ODksMjUgQEAgaW50IGRl
ZmluZV9yb2xlX3R5cGVzKHZvaWQpCiAJCXJldHVybiAwOwogCX0KIAotCWlmICgocm9sZSA9IGRl
Y2xhcmVfcm9sZSgpKSA9PSBOVUxMKSB7CisJaWQgPSAoY2hhciAqKXF1ZXVlX3JlbW92ZShpZF9x
dWV1ZSk7CisJaWYgKCFpZCkgeworCQl5eWVycm9yKCJubyByb2xlIG5hbWUgZm9yIHJvbGUtdHlw
ZXMgcnVsZT8iKTsKKwkJcmV0dXJuIC0xOworCX0KKworCWlmICghaXNfaWRfaW5fc2NvcGUoU1lN
X1JPTEVTLCBpZCkpIHsKKwkJeXllcnJvcjIoInJvbGUgJXMgaXMgbm90IHdpdGhpbiBzY29wZSIs
IGlkKTsKKwkJZnJlZShpZCk7CisJCXJldHVybiAtMTsKKwl9CisKKwlyb2xlID0gaGFzaHRhYl9z
ZWFyY2gocG9saWN5ZGJwLT5wX3JvbGVzLnRhYmxlLCBpZCk7CisJaWYgKCFyb2xlKSB7CisJCXl5
ZXJyb3IyKCJ1bmtub3duIHJvbGUgJXMiLCBpZCk7CisJCWZyZWUoaWQpOwogCQlyZXR1cm4gLTE7
CiAJfQorCiAJd2hpbGUgKChpZCA9IHF1ZXVlX3JlbW92ZShpZF9xdWV1ZSkpKSB7CiAJCWlmIChz
ZXRfdHlwZXMoJnJvbGUtPnR5cGVzLCBpZCwgJmFkZCwgMCkpCiAJCQlyZXR1cm4gLTE7CkBAIC0x
Nzk3LDYgKzE4MTYsMTMyIEBAIGludCBkZWZpbmVfcm9sZV90eXBlcyh2b2lkKQogCXJldHVybiAw
OwogfQogCitpbnQgZGVmaW5lX2F0dHJpYl9yb2xlKHZvaWQpCit7CisJaWYgKHBhc3MgPT0gMikg
eworCQlmcmVlKHF1ZXVlX3JlbW92ZShpZF9xdWV1ZSkpOworCQlyZXR1cm4gMDsKKwl9CisKKwkv
KiBEZWNsYXJlIGEgcm9sZSBhdHRyaWJ1dGUgKi8KKwlpZiAoZGVjbGFyZV9yb2xlKFRSVUUpID09
IE5VTEwpCisJCXJldHVybiAtMTsKKworCXJldHVybiAwOworfQorCitpbnQgZGVmaW5lX3JvbGVf
YXR0cih2b2lkKQoreworCWNoYXIgKmlkOworCXJvbGVfZGF0dW1fdCAqciwgKmF0dHI7CisKKwlp
ZiAocGFzcyA9PSAyKSB7CisJCXdoaWxlICgoaWQgPSBxdWV1ZV9yZW1vdmUoaWRfcXVldWUpKSkK
KwkJCWZyZWUoaWQpOworCQlyZXR1cm4gMDsKKwl9CisJCisJLyogRGVjbGFyZSBhIHJlZ3VsYXIg
cm9sZSAqLworCWlmICgociA9IGRlY2xhcmVfcm9sZShGQUxTRSkpID09IE5VTEwpCisJCXJldHVy
biAtMTsKKworCXdoaWxlICgoaWQgPSBxdWV1ZV9yZW1vdmUoaWRfcXVldWUpKSkgeworCQlpZiAo
IWlzX2lkX2luX3Njb3BlKFNZTV9ST0xFUywgaWQpKSB7CisJCQl5eWVycm9yMigiYXR0cmlidXRl
ICVzIGlzIG5vdCB3aXRoaW4gc2NvcGUiLCBpZCk7CisJCQlmcmVlKGlkKTsKKwkJCXJldHVybiAt
MTsKKwkJfQorCQlhdHRyID0gaGFzaHRhYl9zZWFyY2gocG9saWN5ZGJwLT5wX3JvbGVzLnRhYmxl
LCBpZCk7CisJCWlmICghYXR0cikgeworCQkJLyogdHJlYXQgaXQgYXMgYSBmYXRhbCBlcnJvciAq
LworCQkJeXllcnJvcjIoInJvbGUgYXR0cmlidXRlICVzIGlzIG5vdCBkZWNsYXJlZCIsIGlkKTsK
KwkJCWZyZWUoaWQpOworCQkJcmV0dXJuIC0xOworCQl9CisKKwkJaWYgKGF0dHItPmZsYXZvciAh
PSBST0xFX0FUVFJJQikgeworCQkJeXllcnJvcjIoIiVzIGlzIGEgcmVndWxhciByb2xlLCBub3Qg
YW4gYXR0cmlidXRlIiwgaWQpOworCQkJZnJlZShpZCk7CisJCQlyZXR1cm4gLTE7CisJCX0KKwor
CQlpZiAoKGF0dHIgPSBnZXRfbG9jYWxfcm9sZShpZCwgYXR0ci0+cy52YWx1ZSwgMSkpID09IE5V
TEwpIHsKKwkJCXl5ZXJyb3IoIk91dCBvZiBtZW1vcnkhIik7CisJCQlyZXR1cm4gLTE7CisJCX0K
KworCQlpZiAoZWJpdG1hcF9zZXRfYml0KCZhdHRyLT5yb2xlcywgKHItPnMudmFsdWUgLSAxKSwg
VFJVRSkpIHsKKwkJCXl5ZXJyb3IoIm91dCBvZiBtZW1vcnkiKTsKKwkJCXJldHVybiAtMTsKKwkJ
fQorCX0KKworCXJldHVybiAwOworfQorCitpbnQgZGVmaW5lX3JvbGVhdHRyaWJ1dGUodm9pZCkK
K3sKKwljaGFyICppZDsKKwlyb2xlX2RhdHVtX3QgKnIsICphdHRyOworCisJaWYgKHBhc3MgPT0g
MikgeworCQl3aGlsZSAoKGlkID0gcXVldWVfcmVtb3ZlKGlkX3F1ZXVlKSkpCisJCQlmcmVlKGlk
KTsKKwkJcmV0dXJuIDA7CisJfQorCisJaWQgPSAoY2hhciAqKXF1ZXVlX3JlbW92ZShpZF9xdWV1
ZSk7CisJaWYgKCFpZCkgeworCQl5eWVycm9yKCJubyByb2xlIG5hbWUgZm9yIHJvbGVhdHRyaWJ1
dGUgZGVmaW5pdGlvbj8iKTsKKwkJcmV0dXJuIC0xOworCX0KKworCWlmICghaXNfaWRfaW5fc2Nv
cGUoU1lNX1JPTEVTLCBpZCkpIHsKKwkJeXllcnJvcjIoInJvbGUgJXMgaXMgbm90IHdpdGhpbiBz
Y29wZSIsIGlkKTsKKwkJZnJlZShpZCk7CisJCXJldHVybiAtMTsKKwl9CisJciA9IGhhc2h0YWJf
c2VhcmNoKHBvbGljeWRicC0+cF9yb2xlcy50YWJsZSwgaWQpOworCWlmICghciB8fCByLT5mbGF2
b3IgIT0gUk9MRV9ST0xFKSB7CisJCXl5ZXJyb3IyKCJ1bmtub3duIHJvbGUgJXMsIG9yIG5vdCBh
IHJlZ3VsYXIgcm9sZSIsIGlkKTsKKwkJZnJlZShpZCk7CisJCXJldHVybiAtMTsKKwl9CisKKwl3
aGlsZSAoKGlkID0gcXVldWVfcmVtb3ZlKGlkX3F1ZXVlKSkpIHsKKwkJaWYgKCFpc19pZF9pbl9z
Y29wZShTWU1fUk9MRVMsIGlkKSkgeworCQkJeXllcnJvcjIoImF0dHJpYnV0ZSAlcyBpcyBub3Qg
d2l0aGluIHNjb3BlIiwgaWQpOworCQkJZnJlZShpZCk7CisJCQlyZXR1cm4gLTE7CisJCX0KKwkJ
YXR0ciA9IGhhc2h0YWJfc2VhcmNoKHBvbGljeWRicC0+cF9yb2xlcy50YWJsZSwgaWQpOworCQlp
ZiAoIWF0dHIpIHsKKwkJCS8qIHRyZWF0IGl0IGFzIGEgZmF0YWwgZXJyb3IgKi8KKwkJCXl5ZXJy
b3IyKCJyb2xlIGF0dHJpYnV0ZSAlcyBpcyBub3QgZGVjbGFyZWQiLCBpZCk7CisJCQlmcmVlKGlk
KTsKKwkJCXJldHVybiAtMTsKKwkJfQorCisJCWlmIChhdHRyLT5mbGF2b3IgIT0gUk9MRV9BVFRS
SUIpIHsKKwkJCXl5ZXJyb3IyKCIlcyBpcyBhIHJlZ3VsYXIgcm9sZSwgbm90IGFuIGF0dHJpYnV0
ZSIsIGlkKTsKKwkJCWZyZWUoaWQpOworCQkJcmV0dXJuIC0xOworCQl9CisKKwkJaWYgKChhdHRy
ID0gZ2V0X2xvY2FsX3JvbGUoaWQsIGF0dHItPnMudmFsdWUsIDEpKSA9PSBOVUxMKSB7CisJCQl5
eWVycm9yKCJPdXQgb2YgbWVtb3J5ISIpOworCQkJcmV0dXJuIC0xOworCQl9CisKKwkJaWYgKGVi
aXRtYXBfc2V0X2JpdCgmYXR0ci0+cm9sZXMsIChyLT5zLnZhbHVlIC0gMSksIFRSVUUpKSB7CisJ
CQl5eWVycm9yKCJvdXQgb2YgbWVtb3J5Iik7CisJCQlyZXR1cm4gLTE7CisJCX0KKwl9CisKKwly
ZXR1cm4gMDsKK30KKwogcm9sZV9kYXR1bV90ICptZXJnZV9yb2xlc19kb20ocm9sZV9kYXR1bV90
ICogcjEsIHJvbGVfZGF0dW1fdCAqIHIyKQogewogCXJvbGVfZGF0dW1fdCAqbmV3OwpAQCAtMjEz
OCw2ICsyMjgzLDExIEBAIGludCBkZWZpbmVfcm9sZV90cmFucyhpbnQgY2xhc3Nfc3BlY2lmaWVk
KQogCQlnb3RvIGJhZDsKIAl9CiAKKwlpZiAocm9sZS0+Zmxhdm9yICE9IFJPTEVfUk9MRSkgewor
CQl5eWVycm9yMigidGhlIG5ldyByb2xlICVzIG11c3QgYmUgYSByZWd1bGFyIHJvbGUiLCBpZCk7
CisJCWdvdG8gYmFkOworCX0KKwogCS8qIFRoaXMgZWJpdG1hcCBidXNpbmVzcyBpcyBqdXN0IHRv
IGVuc3VyZSB0aGF0IHRoZXJlIGFyZSBub3QgY29uZmxpY3Rpbmcgcm9sZV90cmFucyBydWxlcyAq
LwogCWlmIChyb2xlX3NldF9leHBhbmQoJnJvbGVzLCAmZV9yb2xlcywgcG9saWN5ZGJwLCBOVUxM
KSkKIAkJZ290byBiYWQ7CmRpZmYgLS1naXQgYS9jaGVja3BvbGljeS9wb2xpY3lfZGVmaW5lLmgg
Yi9jaGVja3BvbGljeS9wb2xpY3lfZGVmaW5lLmgKaW5kZXggODkwYTZhZi4uZmM4Y2Q0ZCAxMDA2
NDQKLS0tIGEvY2hlY2twb2xpY3kvcG9saWN5X2RlZmluZS5oCisrKyBiL2NoZWNrcG9saWN5L3Bv
bGljeV9kZWZpbmUuaApAQCAtMTksNiArMTksNyBAQCBhdnJ1bGVfdCAqZGVmaW5lX2NvbmRfdGVf
YXZ0YWIoaW50IHdoaWNoKTsKIGF2cnVsZV90ICpkZWZpbmVfY29uZF9maWxlbmFtZV90cmFucyh2
b2lkKTsKIGNvbmRfZXhwcl90ICpkZWZpbmVfY29uZF9leHByKHVpbnQzMl90IGV4cHJfdHlwZSwg
dm9pZCAqYXJnMSwgdm9pZCogYXJnMik7CiBpbnQgZGVmaW5lX2F0dHJpYih2b2lkKTsKK2ludCBk
ZWZpbmVfYXR0cmliX3JvbGUodm9pZCk7CiBpbnQgZGVmaW5lX2F2X3Blcm1zKGludCBpbmhlcml0
cyk7CiBpbnQgZGVmaW5lX2Jvb2wodm9pZCk7CiBpbnQgZGVmaW5lX2NhdGVnb3J5KHZvaWQpOwpA
QCAtNDgsNiArNDksOCBAQCBpbnQgZGVmaW5lX3JhbmdlX3RyYW5zKGludCBjbGFzc19zcGVjaWZp
ZWQpOwogaW50IGRlZmluZV9yb2xlX2FsbG93KHZvaWQpOwogaW50IGRlZmluZV9yb2xlX3RyYW5z
KGludCBjbGFzc19zcGVjaWZpZWQpOwogaW50IGRlZmluZV9yb2xlX3R5cGVzKHZvaWQpOworaW50
IGRlZmluZV9yb2xlX2F0dHIodm9pZCk7CitpbnQgZGVmaW5lX3JvbGVhdHRyaWJ1dGUodm9pZCk7
CiBpbnQgZGVmaW5lX2ZpbGVuYW1lX3RyYW5zKHZvaWQpOwogaW50IGRlZmluZV9zZW5zKHZvaWQp
OwogaW50IGRlZmluZV90ZV9hdnRhYihpbnQgd2hpY2gpOwpkaWZmIC0tZ2l0IGEvY2hlY2twb2xp
Y3kvcG9saWN5X3BhcnNlLnkgYi9jaGVja3BvbGljeS9wb2xpY3lfcGFyc2UueQppbmRleCA1MzA1
YWM2Li42NTY3MzY5IDEwMDY0NAotLS0gYS9jaGVja3BvbGljeS9wb2xpY3lfcGFyc2UueQorKysg
Yi9jaGVja3BvbGljeS9wb2xpY3lfcGFyc2UueQpAQCAtOTAsNiArOTAsOCBAQCB0eXBlZGVmIGlu
dCAoKiByZXF1aXJlX2Z1bmNfdCkoKTsKICV0b2tlbiBJTkhFUklUUwogJXRva2VuIFNJRAogJXRv
a2VuIFJPTEUKKyV0b2tlbiBST0xFQVRUUklCVVRFCisldG9rZW4gQVRUUklCVVRFX1JPTEUKICV0
b2tlbiBST0xFUwogJXRva2VuIFRZUEVBTElBUwogJXRva2VuIFRZUEVBVFRSSUJVVEUKQEAgLTI1
MywxMCArMjU1LDEzIEBAIHRlX3JiYWNfZGVjbAkJOiB0ZV9kZWNsCiAJCQl8IHBvbGljeWNhcF9k
ZWYKIAkJCXwgJzsnCiAgICAgICAgICAgICAgICAgICAgICAgICA7Ci1yYmFjX2RlY2wJCTogcm9s
ZV90eXBlX2RlZgorcmJhY19kZWNsCQk6IGF0dHJpYnV0ZV9yb2xlX2RlZgorCQkJfCByb2xlX3R5
cGVfZGVmCiAgICAgICAgICAgICAgICAgICAgICAgICB8IHJvbGVfZG9taW5hbmNlCiAgICAgICAg
ICAgICAgICAgICAgICAgICB8IHJvbGVfdHJhbnNfZGVmCiAgCQkJfCByb2xlX2FsbG93X2RlZgor
CQkJfCByb2xlYXR0cmlidXRlX2RlZgorCQkJfCByb2xlX2F0dHJfZGVmCiAJCQk7CiB0ZV9kZWNs
CQkJOiBhdHRyaWJ1dGVfZGVmCiAgICAgICAgICAgICAgICAgICAgICAgICB8IHR5cGVfZGVmCkBA
IC00MTcsMTAgKzQyMiwxMyBAQCBkb250YXVkaXRfZGVmCQk6IERPTlRBVURJVCBuYW1lcyBuYW1l
cyAnOicgbmFtZXMgbmFtZXMgJzsnCiBuZXZlcmFsbG93X2RlZgkJOiBORVZFUkFMTE9XIG5hbWVz
IG5hbWVzICc6JyBuYW1lcyBuYW1lcyAgJzsnCiAJCQl7aWYgKGRlZmluZV90ZV9hdnRhYihBVlJV
TEVfTkVWRVJBTExPVykpIHJldHVybiAtMTsgfQogCQkgICAgICAgIDsKK2F0dHJpYnV0ZV9yb2xl
X2RlZgk6IEFUVFJJQlVURV9ST0xFIGlkZW50aWZpZXIgJzsnCisJCQl7aWYgKGRlZmluZV9hdHRy
aWJfcm9sZSgpKSByZXR1cm4gLTE7IH0KIHJvbGVfdHlwZV9kZWYJCTogUk9MRSBpZGVudGlmaWVy
IFRZUEVTIG5hbWVzICc7JwogCQkJe2lmIChkZWZpbmVfcm9sZV90eXBlcygpKSByZXR1cm4gLTE7
fQotIAkJCXwgUk9MRSBpZGVudGlmaWVyJzsnCi0gCQkJe2lmIChkZWZpbmVfcm9sZV90eXBlcygp
KSByZXR1cm4gLTE7fQorCQkJOworcm9sZV9hdHRyX2RlZgkJOiBST0xFIGlkZW50aWZpZXIgb3B0
X2F0dHJfbGlzdCAnOycKKyAJCQl7aWYgKGRlZmluZV9yb2xlX2F0dHIoKSkgcmV0dXJuIC0xO30K
ICAgICAgICAgICAgICAgICAgICAgICAgIDsKIHJvbGVfZG9taW5hbmNlCQk6IERPTUlOQU5DRSAn
eycgcm9sZXMgJ30nCiAJCQk7CkBAIC00NDIsNiArNDUwLDkgQEAgcm9sZV9kZWYJCTogUk9MRSBp
ZGVudGlmaWVyX3B1c2ggJzsnCiAJCQl8IFJPTEUgaWRlbnRpZmllcl9wdXNoICd7JyByb2xlcyAn
fScKICAgICAgICAgICAgICAgICAgICAgICAgIHskJCA9IGRlZmluZV9yb2xlX2RvbSgocm9sZV9k
YXR1bV90KikkNCk7IGlmICgkJCA9PSAwKSByZXR1cm4gLTE7fQogCQkJOworcm9sZWF0dHJpYnV0
ZV9kZWYJOiBST0xFQVRUUklCVVRFIGlkZW50aWZpZXIgaWRfY29tbWFfbGlzdCAnOycKKwkJCXtp
ZiAoZGVmaW5lX3JvbGVhdHRyaWJ1dGUoKSkgcmV0dXJuIC0xO30KKwkJCTsKIG9wdF9jb25zdHJh
aW50cyAgICAgICAgIDogY29uc3RyYWludHMKICAgICAgICAgICAgICAgICAgICAgICAgIHwKICAg
ICAgICAgICAgICAgICAgICAgICAgIDsKQEAgLTgwMyw2ICs4MTQsNyBAQCByZXF1aXJlX2NsYXNz
ICAgICAgICAgICA6IENMQVNTIGlkZW50aWZpZXIgbmFtZXMKIHJlcXVpcmVfZGVjbF9kZWYgICAg
ICAgIDogUk9MRSAgICAgICAgeyAkJCA9IHJlcXVpcmVfcm9sZTsgfQogICAgICAgICAgICAgICAg
ICAgICAgICAgfCBUWVBFICAgICAgICB7ICQkID0gcmVxdWlyZV90eXBlOyB9CiAgICAgICAgICAg
ICAgICAgICAgICAgICB8IEFUVFJJQlVURSAgIHsgJCQgPSByZXF1aXJlX2F0dHJpYnV0ZTsgfQor
ICAgICAgICAgICAgICAgICAgICAgICAgfCBBVFRSSUJVVEVfUk9MRSAgIHsgJCQgPSByZXF1aXJl
X2F0dHJpYnV0ZV9yb2xlOyB9CiAgICAgICAgICAgICAgICAgICAgICAgICB8IFVTRVIgICAgICAg
IHsgJCQgPSByZXF1aXJlX3VzZXI7IH0KICAgICAgICAgICAgICAgICAgICAgICAgIHwgQk9PTCAg
ICAgICAgeyAkJCA9IHJlcXVpcmVfYm9vbDsgfQogICAgICAgICAgICAgICAgICAgICAgICAgfCBT
RU5TSVRJVklUWSB7ICQkID0gcmVxdWlyZV9zZW5zOyB9CmRpZmYgLS1naXQgYS9jaGVja3BvbGlj
eS9wb2xpY3lfc2Nhbi5sIGIvY2hlY2twb2xpY3kvcG9saWN5X3NjYW4ubAppbmRleCAxZTdlNTY3
Li44YWJjNGQ5IDEwMDY0NAotLS0gYS9jaGVja3BvbGljeS9wb2xpY3lfc2Nhbi5sCisrKyBiL2No
ZWNrcG9saWN5L3BvbGljeV9zY2FuLmwKQEAgLTc2LDYgKzc2LDEwIEBAIFJPTEUgfAogcm9sZQkJ
CQl7IHJldHVybihST0xFKTsgfQogUk9MRVMgfAogcm9sZXMJCQkJeyByZXR1cm4oUk9MRVMpOyB9
CitST0xFQVRUUklCVVRFIHwKK3JvbGVhdHRyaWJ1dGUJCQl7IHJldHVybihST0xFQVRUUklCVVRF
KTt9CitBVFRSSUJVVEVfUk9MRSB8CithdHRyaWJ1dGVfcm9sZQkJCXsgcmV0dXJuKEFUVFJJQlVU
RV9ST0xFKTt9CiBUWVBFUyB8CiB0eXBlcwkJCQl7IHJldHVybihUWVBFUyk7IH0KIFRZUEVBTElB
UyB8CmRpZmYgLS1naXQgYS9saWJzZXBvbC9pbmNsdWRlL3NlcG9sL3BvbGljeWRiL3BvbGljeWRi
LmggYi9saWJzZXBvbC9pbmNsdWRlL3NlcG9sL3BvbGljeWRiL3BvbGljeWRiLmgKaW5kZXggZWVi
ZjFhOS4uYjU5YWIyZSAxMDA2NDQKLS0tIGEvbGlic2Vwb2wvaW5jbHVkZS9zZXBvbC9wb2xpY3lk
Yi9wb2xpY3lkYi5oCisrKyBiL2xpYnNlcG9sL2luY2x1ZGUvc2Vwb2wvcG9saWN5ZGIvcG9saWN5
ZGIuaApAQCAtMTIwLDYgKzEyMCwxMCBAQCB0eXBlZGVmIHN0cnVjdCByb2xlX2RhdHVtIHsKIAl0
eXBlX3NldF90IHR5cGVzOwkvKiBzZXQgb2YgYXV0aG9yaXplZCB0eXBlcyBmb3Igcm9sZSAqLwog
CWViaXRtYXBfdCBjYWNoZTsJLyogVGhpcyBpcyBhbiBleHBhbmRlZCBzZXQgdXNlZCBmb3IgY29u
dGV4dCB2YWxpZGF0aW9uIGR1cmluZyBwYXJzaW5nICovCiAJdWludDMyX3QgYm91bmRzOwkvKiBi
b3VuZHMgcm9sZSwgaWYgZXhpc3QgKi8KKyNkZWZpbmUgUk9MRV9ST0xFIDAJCS8qIHJlZ3VsYXIg
cm9sZSBpbiBrZXJuZWwgcG9saWNpZXMgKi8KKyNkZWZpbmUgUk9MRV9BVFRSSUIgMQkJLyogYXR0
cmlidXRlICovCisJdWludDMyX3QgZmxhdm9yOworCWViaXRtYXBfdCByb2xlczsJLyogcm9sZXMg
d2l0aCB0aGlzIGF0dHJpYnV0ZSAqLwogfSByb2xlX2RhdHVtX3Q7CiAKIHR5cGVkZWYgc3RydWN0
IHJvbGVfdHJhbnMgewpkaWZmIC0tZ2l0IGEvbGlic2Vwb2wvc3JjL3BvbGljeWRiLmMgYi9saWJz
ZXBvbC9zcmMvcG9saWN5ZGIuYwppbmRleCA2ZDhmZjkxLi5lYjZkNTkwIDEwMDY0NAotLS0gYS9s
aWJzZXBvbC9zcmMvcG9saWN5ZGIuYworKysgYi9saWJzZXBvbC9zcmMvcG9saWN5ZGIuYwpAQCAt
MzUwLDYgKzM1MCw3IEBAIHZvaWQgcm9sZV9kYXR1bV9pbml0KHJvbGVfZGF0dW1fdCAqIHgpCiAJ
ZWJpdG1hcF9pbml0KCZ4LT5kb21pbmF0ZXMpOwogCXR5cGVfc2V0X2luaXQoJngtPnR5cGVzKTsK
IAllYml0bWFwX2luaXQoJngtPmNhY2hlKTsKKwllYml0bWFwX2luaXQoJngtPnJvbGVzKTsKIH0K
IAogdm9pZCByb2xlX2RhdHVtX2Rlc3Ryb3kocm9sZV9kYXR1bV90ICogeCkKQEAgLTM1OCw2ICsz
NTksNyBAQCB2b2lkIHJvbGVfZGF0dW1fZGVzdHJveShyb2xlX2RhdHVtX3QgKiB4KQogCQllYml0
bWFwX2Rlc3Ryb3koJngtPmRvbWluYXRlcyk7CiAJCXR5cGVfc2V0X2Rlc3Ryb3koJngtPnR5cGVz
KTsKIAkJZWJpdG1hcF9kZXN0cm95KCZ4LT5jYWNoZSk7CisJCWViaXRtYXBfZGVzdHJveSgmeC0+
cm9sZXMpOwogCX0KIH0KIApAQCAtMTQyOSw2ICsxNDMxLDI1IEBAIGludCBzeW10YWJfaW5zZXJ0
KHBvbGljeWRiX3QgKiBwb2wsIHVpbnQzMl90IHN5bSwKIAkJaWYgKHN5bSAhPSBTWU1fUk9MRVMg
JiYgc3ltICE9IFNZTV9VU0VSUykgewogCQkJcmV0dXJuIC0yOwogCQl9CisJCS8qIEZ1cnRoZXIg
Y29uZmluZSB0aGF0IGEgcm9sZSBhdHRyaWJ1dGUgY2FuJ3QgaGF2ZSB0aGUgc2FtZQorCQkgKiBu
YW1lIGFzIGFub3RoZXIgcmVndWxhciByb2xlLCBhbmQgYSByb2xlIGF0dHJpYnV0ZSBjYW4ndAor
CQkgKiBiZSBkZWNsYXJlZCBtb3JlIHRoYW4gb25jZS4gKi8KKwkJaWYgKHN5bSA9PSBTWU1fUk9M
RVMpIHsKKwkJCXJvbGVfZGF0dW1fdCAqYmFzZV9yb2xlOworCQkJcm9sZV9kYXR1bV90ICpjdXJf
cm9sZSA9IChyb2xlX2RhdHVtX3QgKilkYXR1bTsKKwkJCisJCQliYXNlX3JvbGUgPSAocm9sZV9k
YXR1bV90ICopCisJCQkJCWhhc2h0YWJfc2VhcmNoKHBvbC0+c3ltdGFiW3N5bV0udGFibGUsCisJ
CQkJCQkgICAgICAga2V5KTsKKwkJCWFzc2VydChiYXNlX3JvbGUgIT0gTlVMTCk7CisKKwkJCWlm
ICghKChiYXNlX3JvbGUtPmZsYXZvciA9PSBST0xFX1JPTEUpICYmCisJCQkgICAgKGN1cl9yb2xl
LT5mbGF2b3IgPT0gUk9MRV9ST0xFKSkpIHsKKwkJCQkvKiBPbmx5IHJlZ3VsYXIgcm9sZXMgYXJl
IGFsbG93ZWQgdG8gaGF2ZQorCQkJCSAqIG11bHRpcGxlIGRlY2xhcmF0aW9ucy4gKi8KKwkJCQly
ZXR1cm4gLTI7CisJCQl9CisJCX0KIAl9IGVsc2UgaWYgKHNjb3BlX2RhdHVtLT5zY29wZSA9PSBT
Q09QRV9SRVEgJiYgc2NvcGUgPT0gU0NPUEVfREVDTCkgewogCQlzY29wZV9kYXR1bS0+c2NvcGUg
PSBTQ09QRV9ERUNMOwogCX0gZWxzZSBpZiAoc2NvcGVfZGF0dW0tPnNjb3BlICE9IHNjb3BlKSB7
Ci0tIAoxLjcuMC40Cgo=

--_fc2d5afd-0b58-411b-a89f-2a978a0a4d8e_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
