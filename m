Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v45L2T35009513
 for <selinux@tycho.nsa.gov>; Fri, 5 May 2017 17:02:30 -0400
Received: by mail-it0-f52.google.com with SMTP id o5so37536341ith.1
 for <selinux@tycho.nsa.gov>; Fri, 05 May 2017 14:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20170504213649.29165-1-jeffv@google.com>
 <f456511a-435e-e4d0-6770-d96db196fcc1@tycho.nsa.gov>
In-Reply-To: <f456511a-435e-e4d0-6770-d96db196fcc1@tycho.nsa.gov>
From: Jeffrey Vander Stoep <jeffv@google.com>
Date: Fri, 05 May 2017 21:02:14 +0000
Message-ID: <CABXk95B=oc2soHxjsOFH+uKJxFcCpYeALqVBvKgCGvy648aU5A@mail.gmail.com>
Subject: Re: [PATCH] Add attribute expansion options
To: James Carter <jwcart2@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=f403045fb73cd1a5d2054ecd34e9
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--f403045fb73cd1a5d2054ecd34e9
Content-Type: text/plain; charset=UTF-8

Yes, we are generating CIL from policy.conf files.

On Fri, May 5, 2017 at 1:28 PM James Carter <jwcart2@tycho.nsa.gov> wrote:

> On 05/04/2017 05:36 PM, Jeff Vander Stoep wrote:
> > This commit adds attribute expansion statements to the policy
> > language allowing compiler defaults to be overridden.
> >
> > Always expands an attribute example:
> > expandattribute { foo } true;
> > CIL example:
> > (expandtypeattribute (foo) true)
> >
> > Never expand an attribute example:
> > expandattribute { bar } false;
> > CIL example:
> > (expandtypeattribute (bar) false)
> >
>
> It works for secilc and for checkpolicy -C (which outputs CIL), but the
> expandattribute rules are ignored when building the kernel policy from a
> policy.conf. Are you generating CIL from policy.conf files? If not, then it
> might make sense to only have this feature in CIL.
>
> Jim
>
> > Adding the annotations directly to policy was chosen over other
> > methods as it is consistent with how targeted runtime optimizations
> > are specified in other languages. For example, in C the "inline"
> > command.
> >
> > Motivation
> >
> > expandattribute true:
> > Android has been moving away from a monolithic policy binary to
> > a two part split policy representing the Android platform and the
> > underlying vendor-provided hardware interface. The goal is a stable
> > API allowing these two parts to be updated independently of each
> > other. Attributes provide an important mechanism for compatibility.
> > For example, when the vendor provides a HAL for the platform,
> > permissions needed by clients of the HAL can be granted to an
> > attribute. Clients need only be assigned the attribute and do not
> > need to be aware of the underlying types and permissions being
> > granted.
> >
> > Inheriting permissions via attribute creates a convenient mechanism
> > for independence between vendor and platform policy, but results
> > in the creation of many attributes, and the potential for performance
> > issues when processes are clients of many HALs. [1] Annotating these
> > attributes for expansion at compile time allows us to retain the
> > compatibility benefits of using attributes without the performance
> > costs. [2]
> >
> > expandattribute false:
> > Commit 0be23c3f15fd added the capability to aggresively remove unused
> > attributes. This is generally useful as too many attributes assigned
> > to a type results in lengthy policy look up times when there is a
> > cache miss. However, removing attributes can also result in loss of
> > information used in external tests. On Android, we're considering
> > stripping neverallow rules from on-device policy. This is consistent
> > with the kernel policy binary which also did not contain neverallows.
> > Removing neverallow rules results in a 5-10% decrease in on-device
> > policy build and load and a policy size decrease of ~250k. Neverallow
> > rules are still asserted at build time and during device
> > certification (CTS). If neverallow rules are absent when secilc is
> > run, some attributes are being stripped from policy and neverallow
> > tests in CTS may be violated. [3] This change retains the aggressive
> > attribute stripping behavior but adds an override mechanism to
> > preserve attributes marked as necessary.
> >
> > [1] https://github.com/SELinuxProject/cil/issues/9
> > [2] Annotating all HAL client attributes for expansion resulted in
> >      system_server's dropping from 19 attributes to 8. Because these
> >      attributes were not widely applied to other types, the final
> >      policy size change was negligible.
> > [3] data_file_type and service_manager_type are stripped from AOSP
> >      policy when using secilc's -G option. This impacts 11 neverallow
> >      tests in CTS.
> >
> > Test: Build and boot Marlin with all hal_*_client attributes marked
> >      for expansion. Verify (using seinfo and sesearch) that permissions
> >      are correctly expanded from attributes to types.
> > Test: Mark types being stripped by secilc with "preserve" and verify
> >      that they are retained in policy and applied to the same types.
> >
> > Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> > ---
> >   checkpolicy/policy_define.c                | 82
> ++++++++++++++++++++++++++++++
> >   checkpolicy/policy_define.h                |  1 +
> >   checkpolicy/policy_parse.y                 |  5 ++
> >   checkpolicy/policy_scan.l                  |  2 +
> >   libsepol/cil/src/cil.c                     | 15 ++++++
> >   libsepol/cil/src/cil_build_ast.c           | 72
> ++++++++++++++++++++++++++
> >   libsepol/cil/src/cil_build_ast.h           |  2 +
> >   libsepol/cil/src/cil_copy_ast.c            | 26 ++++++++++
> >   libsepol/cil/src/cil_flavor.h              |  1 +
> >   libsepol/cil/src/cil_internal.h            | 16 ++++--
> >   libsepol/cil/src/cil_post.c                |  8 +++
> >   libsepol/cil/src/cil_reset_ast.c           |  1 +
> >   libsepol/cil/src/cil_resolve_ast.c         | 53 ++++++++++++++++++-
> >   libsepol/cil/src/cil_tree.c                | 11 ++++
> >   libsepol/include/sepol/policydb/policydb.h |  6 ++-
> >   libsepol/src/module_to_cil.c               | 11 ++++
> >   16 files changed, 307 insertions(+), 5 deletions(-)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index 949ca711..63e3c53f 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -1139,6 +1139,88 @@ int define_attrib(void)
> >       return 0;
> >   }
> >
> > +int expand_attrib(void)
> > +{
> > +     char *id;
> > +     ebitmap_t attrs;
> > +     type_datum_t *attr;
> > +     ebitmap_node_t *node;
> > +     uint32_t i;
> > +     int rc = -1;
> > +     int flags = 0;
> > +
> > +     if (pass == 1) {
> > +             for (i = 0; i < 2; i++) {
> > +                     while ((id = queue_remove(id_queue))) {
> > +                             free(id);
> > +                     }
> > +             }
> > +             return 0;
> > +     }
> > +
> > +     ebitmap_init(&attrs);
> > +     while ((id = queue_remove(id_queue))) {
> > +             if (!id) {
> > +                     yyerror("No attribute name for expandattribute
> statement?");
> > +                     goto exit;
> > +             }
> > +
> > +             if (!is_id_in_scope(SYM_TYPES, id)) {
> > +                     yyerror2("attribute %s is not within scope", id);
> > +                     goto exit;
> > +             }
> > +
> > +             attr = hashtab_search(policydbp->p_types.table, id);
> > +             if (!attr) {
> > +                     yyerror2("attribute %s is not declared", id);
> > +                     goto exit;
> > +             }
> > +
> > +             if (attr->flavor != TYPE_ATTRIB) {
> > +                     yyerror2("%s is a type, not an attribute", id);
> > +                     goto exit;
> > +             }
> > +
> > +             if (attr->flags & TYPE_FLAGS_EXPAND_ATTR) {
> > +                     yyerror2("%s already has the expandattribute
> option specified", id);
> > +                     goto exit;
> > +             }
> > +             if (ebitmap_set_bit(&attrs, attr->s.value - 1, TRUE)) {
> > +                     yyerror("Out of memory!");
> > +                     goto exit;
> > +             }
> > +
> > +             free(id);
> > +     }
> > +
> > +     id = (char *) queue_remove(id_queue);
> > +     if (!id) {
> > +             yyerror("No option specified for attribute expansion.");
> > +             goto exit;
> > +     }
> > +
> > +     if (!strcmp(id, "T")) {
> > +             flags = TYPE_FLAGS_EXPAND_ATTR_TRUE;
> > +     } else {
> > +             flags = TYPE_FLAGS_EXPAND_ATTR_FALSE;
> > +     }
> > +
> > +     ebitmap_for_each_bit(&attrs, node, i) {
> > +             if (!ebitmap_node_get_bit(node, i)){
> > +                     continue;
> > +             }
> > +             attr = hashtab_search(policydbp->p_types.table,
> > +                             policydbp->sym_val_to_name[SYM_TYPES][i]);
> > +             attr->flags |= flags;
> > +     }
> > +
> > +     rc = 0;
> > +exit:
> > +     ebitmap_destroy(&attrs);
> > +     free(id);
> > +     return rc;
> > +}
> > +
> >   static int add_aliases_to_type(type_datum_t * type)
> >   {
> >       char *id;
> > diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
> > index 964baae0..9f4b6d0d 100644
> > --- a/checkpolicy/policy_define.h
> > +++ b/checkpolicy/policy_define.h
> > @@ -65,6 +65,7 @@ int define_typebounds(void);
> >   int define_type(int alias);
> >   int define_user(void);
> >   int define_validatetrans(constraint_expr_t *expr);
> > +int expand_attrib(void);
> >   int insert_id(const char *id,int push);
> >   int insert_separator(int push);
> >   role_datum_t *define_role_dom(role_datum_t *r);
> > diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
> > index 3b6a2f86..1ac1c96b 100644
> > --- a/checkpolicy/policy_parse.y
> > +++ b/checkpolicy/policy_parse.y
> > @@ -103,6 +103,7 @@ typedef int (* require_func_t)(int pass);
> >   %token TYPES
> >   %token ALIAS
> >   %token ATTRIBUTE
> > +%token EXPANDATTRIBUTE
> >   %token BOOL
> >   %token TUNABLE
> >   %token IF
> > @@ -314,6 +315,7 @@ rbac_decl         : attribute_role_def
> >                       | role_attr_def
> >                       ;
> >   te_decl                     : attribute_def
> > +                        | expandattribute_def
> >                           | type_def
> >                           | typealias_def
> >                           | typeattribute_def
> > @@ -328,6 +330,9 @@ te_decl                   : attribute_def
> >   attribute_def           : ATTRIBUTE identifier ';'
> >                           { if (define_attrib()) return -1;}
> >                           ;
> > +expandattribute_def     : EXPANDATTRIBUTE names bool_val ';'
> > +                        { if (expand_attrib()) return -1;}
> > +                        ;
> >   type_def            : TYPE identifier alias_def opt_attr_list ';'
> >                           {if (define_type(1)) return -1;}
> >                       | TYPE identifier opt_attr_list ';'
> > diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> > index 2f7f2216..028bd25e 100644
> > --- a/checkpolicy/policy_scan.l
> > +++ b/checkpolicy/policy_scan.l
> > @@ -106,6 +106,8 @@ ALIAS |
> >   alias                               { return(ALIAS); }
> >   ATTRIBUTE |
> >   attribute                   { return(ATTRIBUTE); }
> > +EXPANDATTRIBUTE |
> > +expandattribute                 { return(EXPANDATTRIBUTE); }
> >   TYPE_TRANSITION |
> >   type_transition                     { return(TYPE_TRANSITION); }
> >   TYPE_MEMBER |
> > diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> > index a64c5284..9b9ccc36 100644
> > --- a/libsepol/cil/src/cil.c
> > +++ b/libsepol/cil/src/cil.c
> > @@ -159,6 +159,7 @@ static void cil_init_keys(void)
> >       CIL_KEY_SELINUXUSERDEFAULT = cil_strpool_add("selinuxuserdefault");
> >       CIL_KEY_TYPEATTRIBUTE = cil_strpool_add("typeattribute");
> >       CIL_KEY_TYPEATTRIBUTESET = cil_strpool_add("typeattributeset");
> > +     CIL_KEY_EXPANDTYPEATTRIBUTE =
> cil_strpool_add("expandtypeattribute");
> >       CIL_KEY_TYPEALIAS = cil_strpool_add("typealias");
> >       CIL_KEY_TYPEALIASACTUAL = cil_strpool_add("typealiasactual");
> >       CIL_KEY_TYPEBOUNDS = cil_strpool_add("typebounds");
> > @@ -623,6 +624,9 @@ void cil_destroy_data(void **data, enum cil_flavor
> flavor)
> >       case CIL_TYPEATTRIBUTESET:
> >               cil_destroy_typeattributeset(*data);
> >               break;
> > +     case CIL_EXPANDTYPEATTRIBUTE:
> > +             cil_destroy_expandtypeattribute(*data);
> > +             break;
> >       case CIL_TYPEALIASACTUAL:
> >               cil_destroy_aliasactual(*data);
> >               break;
> > @@ -987,6 +991,8 @@ const char * cil_node_to_string(struct cil_tree_node
> *node)
> >               return CIL_KEY_TYPEALIAS;
> >       case CIL_TYPEATTRIBUTESET:
> >               return CIL_KEY_TYPEATTRIBUTESET;
> > +     case CIL_EXPANDTYPEATTRIBUTE:
> > +             return CIL_KEY_EXPANDTYPEATTRIBUTE;
> >       case CIL_TYPEALIASACTUAL:
> >               return CIL_KEY_TYPEALIASACTUAL;
> >       case CIL_TYPEBOUNDS:
> > @@ -2038,6 +2044,15 @@ void cil_typeattributeset_init(struct
> cil_typeattributeset **attrset)
> >       (*attrset)->datum_expr = NULL;
> >   }
> >
> > +void cil_expandtypeattribute_init(struct cil_expandtypeattribute
> **expandattr)
> > +{
> > +     *expandattr = cil_malloc(sizeof(**expandattr));
> > +
> > +     (*expandattr)->attr_strs = NULL;
> > +     (*expandattr)->attr_datums = NULL;
> > +     (*expandattr)->expand = 0;
> > +}
> > +
> >   void cil_alias_init(struct cil_alias **alias)
> >   {
> >       *alias = cil_malloc(sizeof(**alias));
> > diff --git a/libsepol/cil/src/cil_build_ast.c
> b/libsepol/cil/src/cil_build_ast.c
> > index 4b03dc35..36cc6735 100644
> > --- a/libsepol/cil/src/cil_build_ast.c
> > +++ b/libsepol/cil/src/cil_build_ast.c
> > @@ -3176,6 +3176,75 @@ void cil_destroy_typeattributeset(struct
> cil_typeattributeset *attrset)
> >       free(attrset);
> >   }
> >
> > +int cil_gen_expandtypeattribute(struct cil_db *db, struct cil_tree_node
> *parse_current, struct cil_tree_node *ast_node)
> > +{
> > +     enum cil_syntax syntax[] = {
> > +             CIL_SYN_STRING,
> > +             CIL_SYN_STRING | CIL_SYN_LIST,
> > +             CIL_SYN_STRING,
> > +             CIL_SYN_END
> > +     };
> > +     char *expand_str;
> > +     int syntax_len = sizeof(syntax)/sizeof(*syntax);
> > +     struct cil_expandtypeattribute *expandattr = NULL;
> > +     int rc = SEPOL_ERR;
> > +
> > +     if (db == NULL || parse_current == NULL || ast_node == NULL) {
> > +             goto exit;
> > +     }
> > +
> > +     rc = __cil_verify_syntax(parse_current, syntax, syntax_len);
> > +     if (rc != SEPOL_OK) {
> > +             goto exit;
> > +     }
> > +
> > +     cil_expandtypeattribute_init(&expandattr);
> > +
> > +     if (parse_current->next->cl_head == NULL) {
> > +             cil_list_init(&expandattr->attr_strs, CIL_TYPE);
> > +             cil_list_append(expandattr->attr_strs, CIL_STRING,
> parse_current->next->data);
> > +     } else {
> > +             rc = cil_fill_list(parse_current->next->cl_head, CIL_TYPE,
> &expandattr->attr_strs);
> > +             if (rc != SEPOL_OK) {
> > +                     goto exit;
> > +             }
> > +     }
> > +
> > +     expand_str = parse_current->next->next->data;
> > +
> > +     if (expand_str == CIL_KEY_CONDTRUE) {
> > +             expandattr->expand = CIL_TRUE;
> > +     } else if (expand_str == CIL_KEY_CONDFALSE) {
> > +             expandattr->expand = CIL_FALSE;
> > +     } else {
> > +             cil_log(CIL_ERR, "Value must be either \'true\' or
> \'false\'");
> > +             goto exit;
> > +     }
> > +
> > +     ast_node->data = expandattr;
> > +     ast_node->flavor = CIL_EXPANDTYPEATTRIBUTE;
> > +
> > +     return SEPOL_OK;
> > +
> > +exit:
> > +     cil_tree_log(parse_current, CIL_ERR, "Bad expandtypeattribute
> statement");
> > +     cil_destroy_expandtypeattribute(expandattr);
> > +     return rc;
> > +}
> > +
> > +void cil_destroy_expandtypeattribute(struct cil_expandtypeattribute
> *expandattr)
> > +{
> > +     if (expandattr == NULL) {
> > +             return;
> > +     }
> > +
> > +     cil_list_destroy(&expandattr->attr_strs, CIL_TRUE);
> > +
> > +     cil_list_destroy(&expandattr->attr_datums, CIL_FALSE);
> > +
> > +     free(expandattr);
> > +}
> > +
> >   int cil_gen_typepermissive(struct cil_db *db, struct cil_tree_node
> *parse_current, struct cil_tree_node *ast_node)
> >   {
> >       enum cil_syntax syntax[] = {
> > @@ -6013,6 +6082,9 @@ int __cil_build_ast_node_helper(struct
> cil_tree_node *parse_current, uint32_t *f
> >       } else if (parse_current->data == CIL_KEY_TYPEATTRIBUTESET) {
> >               rc = cil_gen_typeattributeset(db, parse_current, ast_node);
> >               *finished = CIL_TREE_SKIP_NEXT;
> > +     } else if (parse_current->data == CIL_KEY_EXPANDTYPEATTRIBUTE) {
> > +             rc = cil_gen_expandtypeattribute(db, parse_current,
> ast_node);
> > +             *finished = CIL_TREE_SKIP_NEXT;
> >       } else if (parse_current->data == CIL_KEY_TYPEALIAS) {
> >               rc = cil_gen_alias(db, parse_current, ast_node,
> CIL_TYPEALIAS);
> >       } else if (parse_current->data == CIL_KEY_TYPEALIASACTUAL) {
> > diff --git a/libsepol/cil/src/cil_build_ast.h
> b/libsepol/cil/src/cil_build_ast.h
> > index 54662035..33bae997 100644
> > --- a/libsepol/cil/src/cil_build_ast.h
> > +++ b/libsepol/cil/src/cil_build_ast.h
> > @@ -138,6 +138,8 @@ int cil_gen_aliasactual(struct cil_db *db, struct
> cil_tree_node *parse_current,
> >   void cil_destroy_aliasactual(struct cil_aliasactual *aliasactual);
> >   int cil_gen_typeattributeset(struct cil_db *db, struct cil_tree_node
> *parse_current, struct cil_tree_node *ast_node);
> >   void cil_destroy_typeattributeset(struct cil_typeattributeset
> *attrtypes);
> > +int cil_gen_expandtypeattribute(struct cil_db *db, struct cil_tree_node
> *parse_current, struct cil_tree_node *ast_node);
> > +void cil_destroy_expandtypeattribute(struct cil_expandtypeattribute
> *expandattr);
> >   int cil_gen_typebounds(struct cil_db *db, struct cil_tree_node
> *parse_current, struct cil_tree_node *ast_node);
> >   int cil_gen_typepermissive(struct cil_db *db, struct cil_tree_node
> *parse_current, struct cil_tree_node *ast_node);
> >   void cil_destroy_typepermissive(struct cil_typepermissive *typeperm);
> > diff --git a/libsepol/cil/src/cil_copy_ast.c
> b/libsepol/cil/src/cil_copy_ast.c
> > index 2d085dd7..d6685050 100644
> > --- a/libsepol/cil/src/cil_copy_ast.c
> > +++ b/libsepol/cil/src/cil_copy_ast.c
> > @@ -648,6 +648,29 @@ int cil_copy_typeattributeset(struct cil_db *db,
> void *data, void **copy, __attr
> >       return SEPOL_OK;
> >   }
> >
> > +int cil_copy_expandtypeattribute(__attribute__((unused)) struct cil_db
> *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
> > +{
> > +     struct cil_expandtypeattribute *orig = data;
> > +     struct cil_expandtypeattribute *new = NULL;
> > +
> > +     fprintf(stderr, "%s %u\n", __func__, __LINE__);
> > +     cil_expandtypeattribute_init(&new);
> > +
> > +     if (orig->attr_strs != NULL) {
> > +             cil_copy_list(orig->attr_strs, &new->attr_strs);
> > +     }
> > +
> > +     if (orig->attr_datums != NULL) {
> > +             cil_copy_list(orig->attr_datums, &new->attr_datums);
> > +     }
> > +
> > +     new->expand = orig->expand;
> > +
> > +     *copy = new;
> > +
> > +     return SEPOL_OK;
> > +}
> > +
> >   int cil_copy_alias(__attribute__((unused)) struct cil_db *db, void
> *data, void **copy, symtab_t *symtab)
> >   {
> >       struct cil_alias *orig = data;
> > @@ -1808,6 +1831,9 @@ int __cil_copy_node_helper(struct cil_tree_node
> *orig, __attribute__((unused)) u
> >       case CIL_TYPEATTRIBUTESET:
> >               copy_func = &cil_copy_typeattributeset;
> >               break;
> > +     case CIL_EXPANDTYPEATTRIBUTE:
> > +             copy_func = &cil_copy_expandtypeattribute;
> > +             break;
> >       case CIL_TYPEALIAS:
> >               copy_func = &cil_copy_alias;
> >               break;
> > diff --git a/libsepol/cil/src/cil_flavor.h
> b/libsepol/cil/src/cil_flavor.h
> > index cd08b972..c01f967a 100644
> > --- a/libsepol/cil/src/cil_flavor.h
> > +++ b/libsepol/cil/src/cil_flavor.h
> > @@ -73,6 +73,7 @@ enum cil_flavor {
> >       CIL_ROLETYPE,
> >       CIL_ROLEBOUNDS,
> >       CIL_TYPEATTRIBUTESET,
> > +     CIL_EXPANDTYPEATTRIBUTE,
> >       CIL_TYPEALIASACTUAL,
> >       CIL_TYPEBOUNDS,
> >       CIL_TYPEPERMISSIVE,
> > diff --git a/libsepol/cil/src/cil_internal.h
> b/libsepol/cil/src/cil_internal.h
> > index efa2cd6e..aee3f00c 100644
> > --- a/libsepol/cil/src/cil_internal.h
> > +++ b/libsepol/cil/src/cil_internal.h
> > @@ -174,6 +174,7 @@ char *CIL_KEY_SELINUXUSER;
> >   char *CIL_KEY_SELINUXUSERDEFAULT;
> >   char *CIL_KEY_TYPEATTRIBUTE;
> >   char *CIL_KEY_TYPEATTRIBUTESET;
> > +char *CIL_KEY_EXPANDTYPEATTRIBUTE;
> >   char *CIL_KEY_TYPEALIAS;
> >   char *CIL_KEY_TYPEALIASACTUAL;
> >   char *CIL_KEY_TYPEBOUNDS;
> > @@ -515,9 +516,11 @@ struct cil_type  {
> >       int value;
> >   };
> >
> > -#define CIL_ATTR_AVRULE     0x01
> > -#define CIL_ATTR_NEVERALLOW 0x02
> > -#define CIL_ATTR_CONSTRAINT 0x04
> > +#define CIL_ATTR_AVRULE              (1 << 0)
> > +#define CIL_ATTR_NEVERALLOW  (1 << 1)
> > +#define CIL_ATTR_CONSTRAINT  (1 << 2)
> > +#define CIL_ATTR_EXPAND_TRUE (1 << 3)
> > +#define CIL_ATTR_EXPAND_FALSE        (1 << 4)
> >   struct cil_typeattribute {
> >       struct cil_symtab_datum datum;
> >       struct cil_list *expr_list;
> > @@ -531,6 +534,12 @@ struct cil_typeattributeset {
> >       struct cil_list *datum_expr;
> >   };
> >
> > +struct cil_expandtypeattribute {
> > +     struct cil_list *attr_strs;
> > +     struct cil_list *attr_datums;
> > +     int expand;
> > +};
> > +
> >   struct cil_typepermissive {
> >       char *type_str;
> >       void *type; /* type or alias */
> > @@ -977,6 +986,7 @@ void cil_roleattributeset_init(struct
> cil_roleattributeset **attrset);
> >   void cil_roletype_init(struct cil_roletype **roletype);
> >   void cil_typeattribute_init(struct cil_typeattribute **attribute);
> >   void cil_typeattributeset_init(struct cil_typeattributeset **attrset);
> > +void cil_expandtypeattribute_init(struct cil_expandtypeattribute
> **expandattr);
> >   void cil_alias_init(struct cil_alias **alias);
> >   void cil_aliasactual_init(struct cil_aliasactual **aliasactual);
> >   void cil_typepermissive_init(struct cil_typepermissive **typeperm);
> > diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> > index e32a8fc9..1941fab3 100644
> > --- a/libsepol/cil/src/cil_post.c
> > +++ b/libsepol/cil/src/cil_post.c
> > @@ -1194,6 +1194,14 @@ static int cil_typeattribute_used(struct
> cil_typeattribute *attr, struct cil_db
> >               return CIL_FALSE;
> >       }
> >
> > +     if (attr->used & CIL_ATTR_EXPAND_FALSE) {
> > +             return CIL_TRUE;
> > +     }
> > +
> > +     if (attr->used & CIL_ATTR_EXPAND_TRUE) {
> > +             return CIL_FALSE;
> > +     }
> > +
> >       if (attr->used & CIL_ATTR_CONSTRAINT) {
> >               return CIL_TRUE;
> >       }
> > diff --git a/libsepol/cil/src/cil_reset_ast.c
> b/libsepol/cil/src/cil_reset_ast.c
> > index de00679e..676e156e 100644
> > --- a/libsepol/cil/src/cil_reset_ast.c
> > +++ b/libsepol/cil/src/cil_reset_ast.c
> > @@ -549,6 +549,7 @@ int __cil_reset_node(struct cil_tree_node *node,
> __attribute__((unused)) uint32
> >       case CIL_CLASSORDER:
> >       case CIL_CATORDER:
> >       case CIL_SENSITIVITYORDER:
> > +     case CIL_EXPANDTYPEATTRIBUTE:
> >               break; /* Nothing to reset */
> >       default:
> >               break;
> > diff --git a/libsepol/cil/src/cil_resolve_ast.c
> b/libsepol/cil/src/cil_resolve_ast.c
> > index 6da44ba1..8925b271 100644
> > --- a/libsepol/cil/src/cil_resolve_ast.c
> > +++ b/libsepol/cil/src/cil_resolve_ast.c
> > @@ -271,14 +271,24 @@ exit:
> >
> >   int cil_type_used(struct cil_symtab_datum *datum, int used)
> >   {
> > +     int rc = SEPOL_ERR;
> >       struct cil_typeattribute *attr = NULL;
> >
> >       if (FLAVOR(datum) == CIL_TYPEATTRIBUTE) {
> >               attr = (struct cil_typeattribute*)datum;
> >               attr->used |= used;
> > +             if ((attr->used & CIL_ATTR_EXPAND_TRUE) &&
> > +                             (attr->used & CIL_ATTR_EXPAND_FALSE)) {
> > +                     cil_log(CIL_ERR, "Conflicting use of
> expandtypeattribute. "
> > +                                     "Expandtypeattribute may be set to
> true or false "
> > +                                     "but not both. \n");
> > +                     goto exit;
> > +             }
> >       }
> >
> > -     return 0;
> > +     return SEPOL_OK;
> > +exit:
> > +     return rc;
> >   }
> >
> >   int cil_resolve_permissionx(struct cil_tree_node *current, struct
> cil_permissionx *permx, void *extra_args)
> > @@ -453,6 +463,44 @@ exit:
> >       return rc;
> >   }
> >
> > +int cil_resolve_expandtypeattribute(struct cil_tree_node *current, void
> *extra_args)
> > +{
> > +     struct cil_expandtypeattribute *expandattr = current->data;
> > +     struct cil_symtab_datum *attr_datum = NULL;
> > +     struct cil_tree_node *attr_node = NULL;
> > +     struct cil_list_item *curr;
> > +     int used;
> > +     int rc = SEPOL_ERR;
> > +
> > +     cil_list_init(&expandattr->attr_datums, CIL_TYPE);
> > +
> > +     cil_list_for_each(curr, expandattr->attr_strs) {
> > +             rc = cil_resolve_name(current, (char *)curr->data,
> CIL_SYM_TYPES, extra_args, &attr_datum);
> > +             if (rc != SEPOL_OK) {
> > +                     goto exit;
> > +             }
> > +
> > +             attr_node = attr_datum->nodes->head->data;
> > +
> > +             if (attr_node->flavor != CIL_TYPEATTRIBUTE) {
> > +                     rc = SEPOL_ERR;
> > +                     cil_log(CIL_ERR, "Attribute type not an
> attribute\n");
> > +                     goto exit;
> > +             }
> > +             used = expandattr->expand ? CIL_ATTR_EXPAND_TRUE :
> CIL_ATTR_EXPAND_FALSE;
> > +             rc = cil_type_used(attr_datum, used);
> > +             if (rc != SEPOL_OK) {
> > +                     goto exit;
> > +             }
> > +
> > +             cil_list_append(expandattr->attr_datums, CIL_TYPE,
> attr_datum);
> > +     }
> > +
> > +     return SEPOL_OK;
> > +exit:
> > +     return rc;
> > +}
> > +
> >   int cil_resolve_aliasactual(struct cil_tree_node *current, void
> *extra_args, enum cil_flavor flavor, enum cil_flavor alias_flavor)
> >   {
> >       int rc = SEPOL_ERR;
> > @@ -3432,6 +3480,9 @@ int __cil_resolve_ast_node(struct cil_tree_node
> *node, void *extra_args)
> >               case CIL_TYPEATTRIBUTESET:
> >                       rc = cil_resolve_typeattributeset(node, args);
> >                       break;
> > +             case CIL_EXPANDTYPEATTRIBUTE:
> > +                     rc = cil_resolve_expandtypeattribute(node, args);
> > +                     break;
> >               case CIL_TYPEBOUNDS:
> >                       rc = cil_resolve_bounds(node, args, CIL_TYPE,
> CIL_TYPEATTRIBUTE);
> >                       break;
> > diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
> > index 9ff9d4b4..2cc2744a 100644
> > --- a/libsepol/cil/src/cil_tree.c
> > +++ b/libsepol/cil/src/cil_tree.c
> > @@ -703,6 +703,17 @@ void cil_tree_print_node(struct cil_tree_node *node)
> >                       cil_log(CIL_INFO, "TYPE: %s\n", type->datum.name);
> >                       return;
> >               }
> > +             case CIL_EXPANDTYPEATTRIBUTE: {
> > +                     struct cil_expandtypeattribute *attr = node->data;
> > +
> > +                     fprintf(stderr, "%s %u\n", __func__, __LINE__);
> > +                     cil_log(CIL_INFO, "(EXPANDTYPEATTRIBUTE ");
> > +                     cil_tree_print_expr(attr->attr_datums,
> attr->attr_strs);
> > +                     cil_log(CIL_INFO, "%s)\n",attr->expand ?
> > +                                     CIL_KEY_CONDTRUE :
> CIL_KEY_CONDFALSE);
> > +
> > +                     return;
> > +             }
> >               case CIL_TYPEATTRIBUTESET: {
> >                       struct cil_typeattributeset *attr = node->data;
> >
> > diff --git a/libsepol/include/sepol/policydb/policydb.h
> b/libsepol/include/sepol/policydb/policydb.h
> > index 4336a3f2..37e0c9e5 100644
> > --- a/libsepol/include/sepol/policydb/policydb.h
> > +++ b/libsepol/include/sepol/policydb/policydb.h
> > @@ -178,7 +178,11 @@ typedef struct type_datum {
> >   #define TYPE_ALIAS 2                /* alias in modular policy */
> >       uint32_t flavor;
> >       ebitmap_t types;        /* types with this attribute */
> > -#define TYPE_FLAGS_PERMISSIVE        0x01
> > +#define TYPE_FLAGS_PERMISSIVE                (1 << 0)
> > +#define TYPE_FLAGS_EXPAND_ATTR_TRUE  (1 << 1)
> > +#define TYPE_FLAGS_EXPAND_ATTR_FALSE (1 << 2)
> > +#define TYPE_FLAGS_EXPAND_ATTR (TYPE_FLAGS_EXPAND_ATTR_TRUE | \
> > +                             TYPE_FLAGS_EXPAND_ATTR_FALSE)
> >       uint32_t flags;
> >       uint32_t bounds;        /* bounds type, if exist */
> >   } type_datum_t;
> > diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> > index ac095c30..7d8eb204 100644
> > --- a/libsepol/src/module_to_cil.c
> > +++ b/libsepol/src/module_to_cil.c
> > @@ -2244,6 +2244,17 @@ static int type_to_cil(int indent, struct
> policydb *pdb, struct avrule_block *UN
> >                       cil_println(indent, "(typeattribute %s)", key);
> >               }
> >
> > +             if (type->flags & TYPE_FLAGS_EXPAND_ATTR) {
> > +                     cil_indent(indent);
> > +                     cil_printf("(expandtypeattribute (%s) ", key);
> > +                     if (type->flags & TYPE_FLAGS_EXPAND_ATTR_TRUE) {
> > +                             cil_printf("true");
> > +                     } else if (type->flags &
> TYPE_FLAGS_EXPAND_ATTR_FALSE) {
> > +                             cil_printf("false");
> > +                     }
> > +                     cil_printf(")\n");
> > +             }
> > +
> >               if (ebitmap_cardinality(&type->types) > 0) {
> >                       cil_indent(indent);
> >                       cil_printf("(typeattributeset %s (", key);
> >
>
>
> --
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency
>

--f403045fb73cd1a5d2054ecd34e9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Yes, we are generating CIL from policy.conf files.</div><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri, May 5, 2017 at 1:28 P=
M James Carter &lt;<a href=3D"mailto:jwcart2@tycho.nsa.gov">jwcart2@tycho.n=
sa.gov</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 05/04/2017=
 05:36 PM, Jeff Vander Stoep wrote:<br>
&gt; This commit adds attribute expansion statements to the policy<br>
&gt; language allowing compiler defaults to be overridden.<br>
&gt;<br>
&gt; Always expands an attribute example:<br>
&gt; expandattribute { foo } true;<br>
&gt; CIL example:<br>
&gt; (expandtypeattribute (foo) true)<br>
&gt;<br>
&gt; Never expand an attribute example:<br>
&gt; expandattribute { bar } false;<br>
&gt; CIL example:<br>
&gt; (expandtypeattribute (bar) false)<br>
&gt;<br>
<br>
It works for secilc and for checkpolicy -C (which outputs CIL), but the<br>
expandattribute rules are ignored when building the kernel policy from a<br=
>
policy.conf. Are you generating CIL from policy.conf files? If not, then it=
<br>
might make sense to only have this feature in CIL.<br>
<br>
Jim<br>
<br>
&gt; Adding the annotations directly to policy was chosen over other<br>
&gt; methods as it is consistent with how targeted runtime optimizations<br=
>
&gt; are specified in other languages. For example, in C the &quot;inline&q=
uot;<br>
&gt; command.<br>
&gt;<br>
&gt; Motivation<br>
&gt;<br>
&gt; expandattribute true:<br>
&gt; Android has been moving away from a monolithic policy binary to<br>
&gt; a two part split policy representing the Android platform and the<br>
&gt; underlying vendor-provided hardware interface. The goal is a stable<br=
>
&gt; API allowing these two parts to be updated independently of each<br>
&gt; other. Attributes provide an important mechanism for compatibility.<br=
>
&gt; For example, when the vendor provides a HAL for the platform,<br>
&gt; permissions needed by clients of the HAL can be granted to an<br>
&gt; attribute. Clients need only be assigned the attribute and do not<br>
&gt; need to be aware of the underlying types and permissions being<br>
&gt; granted.<br>
&gt;<br>
&gt; Inheriting permissions via attribute creates a convenient mechanism<br=
>
&gt; for independence between vendor and platform policy, but results<br>
&gt; in the creation of many attributes, and the potential for performance<=
br>
&gt; issues when processes are clients of many HALs. [1] Annotating these<b=
r>
&gt; attributes for expansion at compile time allows us to retain the<br>
&gt; compatibility benefits of using attributes without the performance<br>
&gt; costs. [2]<br>
&gt;<br>
&gt; expandattribute false:<br>
&gt; Commit 0be23c3f15fd added the capability to aggresively remove unused<=
br>
&gt; attributes. This is generally useful as too many attributes assigned<b=
r>
&gt; to a type results in lengthy policy look up times when there is a<br>
&gt; cache miss. However, removing attributes can also result in loss of<br=
>
&gt; information used in external tests. On Android, we&#39;re considering<=
br>
&gt; stripping neverallow rules from on-device policy. This is consistent<b=
r>
&gt; with the kernel policy binary which also did not contain neverallows.<=
br>
&gt; Removing neverallow rules results in a 5-10% decrease in on-device<br>
&gt; policy build and load and a policy size decrease of ~250k. Neverallow<=
br>
&gt; rules are still asserted at build time and during device<br>
&gt; certification (CTS). If neverallow rules are absent when secilc is<br>
&gt; run, some attributes are being stripped from policy and neverallow<br>
&gt; tests in CTS may be violated. [3] This change retains the aggressive<b=
r>
&gt; attribute stripping behavior but adds an override mechanism to<br>
&gt; preserve attributes marked as necessary.<br>
&gt;<br>
&gt; [1] <a href=3D"https://github.com/SELinuxProject/cil/issues/9" rel=3D"=
noreferrer" target=3D"_blank">https://github.com/SELinuxProject/cil/issues/=
9</a><br>
&gt; [2] Annotating all HAL client attributes for expansion resulted in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 system_server&#39;s dropping from 19 attributes to=
 8. Because these<br>
&gt;=C2=A0 =C2=A0 =C2=A0 attributes were not widely applied to other types,=
 the final<br>
&gt;=C2=A0 =C2=A0 =C2=A0 policy size change was negligible.<br>
&gt; [3] data_file_type and service_manager_type are stripped from AOSP<br>
&gt;=C2=A0 =C2=A0 =C2=A0 policy when using secilc&#39;s -G option. This imp=
acts 11 neverallow<br>
&gt;=C2=A0 =C2=A0 =C2=A0 tests in CTS.<br>
&gt;<br>
&gt; Test: Build and boot Marlin with all hal_*_client attributes marked<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 for expansion. Verify (using seinfo and sesearch) =
that permissions<br>
&gt;=C2=A0 =C2=A0 =C2=A0 are correctly expanded from attributes to types.<b=
r>
&gt; Test: Mark types being stripped by secilc with &quot;preserve&quot; an=
d verify<br>
&gt;=C2=A0 =C2=A0 =C2=A0 that they are retained in policy and applied to th=
e same types.<br>
&gt;<br>
&gt; Signed-off-by: Jeff Vander Stoep &lt;<a href=3D"mailto:jeffv@google.co=
m" target=3D"_blank">jeffv@google.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0checkpolicy/policy_define.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 82 ++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0checkpolicy/policy_define.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0checkpolicy/policy_parse.y=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 5 ++<br>
&gt;=C2=A0 =C2=A0checkpolicy/policy_scan.l=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +<br>
&gt;=C2=A0 =C2=A0libsepol/cil/src/cil.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 15 ++++++<br>
&gt;=C2=A0 =C2=A0libsepol/cil/src/cil_build_ast.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 72 ++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0libsepol/cil/src/cil_build_ast.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 2 +<br>
&gt;=C2=A0 =C2=A0libsepol/cil/src/cil_copy_ast.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | 26 ++++++++++<br>
&gt;=C2=A0 =C2=A0libsepol/cil/src/cil_flavor.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0libsepol/cil/src/cil_internal.h=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | 16 ++++--<br>
&gt;=C2=A0 =C2=A0libsepol/cil/src/cil_post.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 +++<br>
&gt;=C2=A0 =C2=A0libsepol/cil/src/cil_reset_ast.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0libsepol/cil/src/cil_resolve_ast.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| 53 ++++++++++++++++++-<br>
&gt;=C2=A0 =C2=A0libsepol/cil/src/cil_tree.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 11 ++++<br>
&gt;=C2=A0 =C2=A0libsepol/include/sepol/policydb/policydb.h |=C2=A0 6 ++-<b=
r>
&gt;=C2=A0 =C2=A0libsepol/src/module_to_cil.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 11 ++++<br>
&gt;=C2=A0 =C2=A016 files changed, 307 insertions(+), 5 deletions(-)<br>
&gt;<br>
&gt; diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c=
<br>
&gt; index 949ca711..63e3c53f 100644<br>
&gt; --- a/checkpolicy/policy_define.c<br>
&gt; +++ b/checkpolicy/policy_define.c<br>
&gt; @@ -1139,6 +1139,88 @@ int define_attrib(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;<br>
&gt; +int expand_attrib(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0char *id;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ebitmap_t attrs;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0type_datum_t *attr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ebitmap_node_t *node;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0uint32_t i;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int rc =3D -1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int flags =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (pass =3D=3D 1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; =
2; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0while ((id =3D queue_remove(id_queue))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(id);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ebitmap_init(&amp;attrs);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0while ((id =3D queue_remove(id_queue))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!id) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0yyerror(&quot;No attribute name for expandattribute statement?&quot;=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0goto exit;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!is_id_in_scope(S=
YM_TYPES, id)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0yyerror2(&quot;attribute %s is not within scope&quot;, id);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0goto exit;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0attr =3D hashtab_sear=
ch(policydbp-&gt;p_types.table, id);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!attr) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0yyerror2(&quot;attribute %s is not declared&quot;, id);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0goto exit;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (attr-&gt;flavor !=
=3D TYPE_ATTRIB) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0yyerror2(&quot;%s is a type, not an attribute&quot;, id);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0goto exit;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (attr-&gt;flags &a=
mp; TYPE_FLAGS_EXPAND_ATTR) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0yyerror2(&quot;%s already has the expandattribute option specified&q=
uot;, id);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0goto exit;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ebitmap_set_bit(&=
amp;attrs, attr-&gt;s.value - 1, TRUE)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0yyerror(&quot;Out of memory!&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0goto exit;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(id);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0id =3D (char *) queue_remove(id_queue);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!id) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0yyerror(&quot;No opti=
on specified for attribute expansion.&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto exit;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!strcmp(id, &quot;T&quot;)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flags =3D TYPE_FLAGS_=
EXPAND_ATTR_TRUE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flags =3D TYPE_FLAGS_=
EXPAND_ATTR_FALSE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ebitmap_for_each_bit(&amp;attrs, node, i) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ebitmap_node_get=
_bit(node, i)){<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0attr =3D hashtab_sear=
ch(policydbp-&gt;p_types.table,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0policydbp-&gt;sym_val_to_name[SYM_TYPES]=
[i]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0attr-&gt;flags |=3D f=
lags;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0rc =3D 0;<br>
&gt; +exit:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ebitmap_destroy(&amp;attrs);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0free(id);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return rc;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0static int add_aliases_to_type(type_datum_t * type)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0char *id;<br>
&gt; diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h=
<br>
&gt; index 964baae0..9f4b6d0d 100644<br>
&gt; --- a/checkpolicy/policy_define.h<br>
&gt; +++ b/checkpolicy/policy_define.h<br>
&gt; @@ -65,6 +65,7 @@ int define_typebounds(void);<br>
&gt;=C2=A0 =C2=A0int define_type(int alias);<br>
&gt;=C2=A0 =C2=A0int define_user(void);<br>
&gt;=C2=A0 =C2=A0int define_validatetrans(constraint_expr_t *expr);<br>
&gt; +int expand_attrib(void);<br>
&gt;=C2=A0 =C2=A0int insert_id(const char *id,int push);<br>
&gt;=C2=A0 =C2=A0int insert_separator(int push);<br>
&gt;=C2=A0 =C2=A0role_datum_t *define_role_dom(role_datum_t *r);<br>
&gt; diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y<b=
r>
&gt; index 3b6a2f86..1ac1c96b 100644<br>
&gt; --- a/checkpolicy/policy_parse.y<br>
&gt; +++ b/checkpolicy/policy_parse.y<br>
&gt; @@ -103,6 +103,7 @@ typedef int (* require_func_t)(int pass);<br>
&gt;=C2=A0 =C2=A0%token TYPES<br>
&gt;=C2=A0 =C2=A0%token ALIAS<br>
&gt;=C2=A0 =C2=A0%token ATTRIBUTE<br>
&gt; +%token EXPANDATTRIBUTE<br>
&gt;=C2=A0 =C2=A0%token BOOL<br>
&gt;=C2=A0 =C2=A0%token TUNABLE<br>
&gt;=C2=A0 =C2=A0%token IF<br>
&gt; @@ -314,6 +315,7 @@ rbac_decl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: attri=
bute_role_def<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| role_attr_def<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0;<br>
&gt;=C2=A0 =C2=A0te_decl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0: attribute_def<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | expandattribute_def<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| type_def<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| typealias_def<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| typeattribute_def<br>
&gt; @@ -328,6 +330,9 @@ te_decl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0: attribute_def<br>
&gt;=C2=A0 =C2=A0attribute_def=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: AT=
TRIBUTE identifier &#39;;&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0{ if (define_attrib()) return -1;}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0;<br>
&gt; +expandattribute_def=C2=A0 =C2=A0 =C2=A0: EXPANDATTRIBUTE names bool_v=
al &#39;;&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 { if (expand_attrib()) return -1;}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 ;<br>
&gt;=C2=A0 =C2=A0type_def=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : TYPE i=
dentifier alias_def opt_attr_list &#39;;&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0{if (define_type(1)) return -1;}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| TYPE identifier opt_attr_list &#39;;&#39;<br>
&gt; diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l<br>
&gt; index 2f7f2216..028bd25e 100644<br>
&gt; --- a/checkpolicy/policy_scan.l<br>
&gt; +++ b/checkpolicy/policy_scan.l<br>
&gt; @@ -106,6 +106,8 @@ ALIAS |<br>
&gt;=C2=A0 =C2=A0alias=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ return(ALIAS);=
 }<br>
&gt;=C2=A0 =C2=A0ATTRIBUTE |<br>
&gt;=C2=A0 =C2=A0attribute=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0{ return(ATTRIBUTE); }<br>
&gt; +EXPANDATTRIBUTE |<br>
&gt; +expandattribute=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0{ return(EXPANDATTRIBUTE); }<br>
&gt;=C2=A0 =C2=A0TYPE_TRANSITION |<br>
&gt;=C2=A0 =C2=A0type_transition=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ return(TYPE_TRANSITION); }<br>
&gt;=C2=A0 =C2=A0TYPE_MEMBER |<br>
&gt; diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c<br>
&gt; index a64c5284..9b9ccc36 100644<br>
&gt; --- a/libsepol/cil/src/cil.c<br>
&gt; +++ b/libsepol/cil/src/cil.c<br>
&gt; @@ -159,6 +159,7 @@ static void cil_init_keys(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0CIL_KEY_SELINUXUSERDEFAULT =3D cil_strpool_a=
dd(&quot;selinuxuserdefault&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0CIL_KEY_TYPEATTRIBUTE =3D cil_strpool_add(&q=
uot;typeattribute&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0CIL_KEY_TYPEATTRIBUTESET =3D cil_strpool_add=
(&quot;typeattributeset&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0CIL_KEY_EXPANDTYPEATTRIBUTE =3D cil_strpool_add(&=
quot;expandtypeattribute&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0CIL_KEY_TYPEALIAS =3D cil_strpool_add(&quot;=
typealias&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0CIL_KEY_TYPEALIASACTUAL =3D cil_strpool_add(=
&quot;typealiasactual&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0CIL_KEY_TYPEBOUNDS =3D cil_strpool_add(&quot=
;typebounds&quot;);<br>
&gt; @@ -623,6 +624,9 @@ void cil_destroy_data(void **data, enum cil_flavor=
 flavor)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case CIL_TYPEATTRIBUTESET:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cil_destroy_type=
attributeset(*data);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case CIL_EXPANDTYPEATTRIBUTE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cil_destroy_expandtyp=
eattribute(*data);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case CIL_TYPEALIASACTUAL:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cil_destroy_alia=
sactual(*data);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; @@ -987,6 +991,8 @@ const char * cil_node_to_string(struct cil_tree_no=
de *node)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CIL_KEY_T=
YPEALIAS;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case CIL_TYPEATTRIBUTESET:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CIL_KEY_T=
YPEATTRIBUTESET;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case CIL_EXPANDTYPEATTRIBUTE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CIL_KEY_EXPAND=
TYPEATTRIBUTE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case CIL_TYPEALIASACTUAL:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CIL_KEY_T=
YPEALIASACTUAL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case CIL_TYPEBOUNDS:<br>
&gt; @@ -2038,6 +2044,15 @@ void cil_typeattributeset_init(struct cil_typea=
ttributeset **attrset)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0(*attrset)-&gt;datum_expr =3D NULL;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;<br>
&gt; +void cil_expandtypeattribute_init(struct cil_expandtypeattribute **ex=
pandattr)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*expandattr =3D cil_malloc(sizeof(**expandattr));=
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0(*expandattr)-&gt;attr_strs =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0(*expandattr)-&gt;attr_datums =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0(*expandattr)-&gt;expand =3D 0;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0void cil_alias_init(struct cil_alias **alias)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*alias =3D cil_malloc(sizeof(**alias));<br>
&gt; diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_b=
uild_ast.c<br>
&gt; index 4b03dc35..36cc6735 100644<br>
&gt; --- a/libsepol/cil/src/cil_build_ast.c<br>
&gt; +++ b/libsepol/cil/src/cil_build_ast.c<br>
&gt; @@ -3176,6 +3176,75 @@ void cil_destroy_typeattributeset(struct cil_ty=
peattributeset *attrset)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0free(attrset);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;<br>
&gt; +int cil_gen_expandtypeattribute(struct cil_db *db, struct cil_tree_no=
de *parse_current, struct cil_tree_node *ast_node)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0enum cil_syntax syntax[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CIL_SYN_STRING,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CIL_SYN_STRING | CIL_=
SYN_LIST,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CIL_SYN_STRING,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CIL_SYN_END<br>
&gt; +=C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0char *expand_str;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int syntax_len =3D sizeof(syntax)/sizeof(*syntax)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct cil_expandtypeattribute *expandattr =3D NU=
LL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int rc =3D SEPOL_ERR;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (db =3D=3D NULL || parse_current =3D=3D NULL |=
| ast_node =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto exit;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0rc =3D __cil_verify_syntax(parse_current, syntax,=
 syntax_len);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (rc !=3D SEPOL_OK) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto exit;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cil_expandtypeattribute_init(&amp;expandattr);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (parse_current-&gt;next-&gt;cl_head =3D=3D NUL=
L) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cil_list_init(&amp;ex=
pandattr-&gt;attr_strs, CIL_TYPE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cil_list_append(expan=
dattr-&gt;attr_strs, CIL_STRING, parse_current-&gt;next-&gt;data);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D cil_fill_list(=
parse_current-&gt;next-&gt;cl_head, CIL_TYPE, &amp;expandattr-&gt;attr_strs=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc !=3D SEPOL_OK)=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0goto exit;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0expand_str =3D parse_current-&gt;next-&gt;next-&g=
t;data;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (expand_str =3D=3D CIL_KEY_CONDTRUE) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0expandattr-&gt;expand=
 =3D CIL_TRUE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0} else if (expand_str =3D=3D CIL_KEY_CONDFALSE) {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0expandattr-&gt;expand=
 =3D CIL_FALSE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cil_log(CIL_ERR, &quo=
t;Value must be either \&#39;true\&#39; or \&#39;false\&#39;&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto exit;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ast_node-&gt;data =3D expandattr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ast_node-&gt;flavor =3D CIL_EXPANDTYPEATTRIBUTE;<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return SEPOL_OK;<br>
&gt; +<br>
&gt; +exit:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cil_tree_log(parse_current, CIL_ERR, &quot;Bad ex=
pandtypeattribute statement&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cil_destroy_expandtypeattribute(expandattr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return rc;<br>
&gt; +}<br>
&gt; +<br>
&gt; +void cil_destroy_expandtypeattribute(struct cil_expandtypeattribute *=
expandattr)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (expandattr =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cil_list_destroy(&amp;expandattr-&gt;attr_strs, C=
IL_TRUE);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cil_list_destroy(&amp;expandattr-&gt;attr_datums,=
 CIL_FALSE);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0free(expandattr);<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0int cil_gen_typepermissive(struct cil_db *db, struct cil_t=
ree_node *parse_current, struct cil_tree_node *ast_node)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0enum cil_syntax syntax[] =3D {<br>
&gt; @@ -6013,6 +6082,9 @@ int __cil_build_ast_node_helper(struct cil_tree_=
node *parse_current, uint32_t *f<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (parse_current-&gt;data =3D=3D CIL=
_KEY_TYPEATTRIBUTESET) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D cil_gen_t=
ypeattributeset(db, parse_current, ast_node);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*finished =3D CI=
L_TREE_SKIP_NEXT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0} else if (parse_current-&gt;data =3D=3D CIL_KEY_=
EXPANDTYPEATTRIBUTE) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D cil_gen_expand=
typeattribute(db, parse_current, ast_node);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*finished =3D CIL_TRE=
E_SKIP_NEXT;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (parse_current-&gt;data =3D=3D CIL=
_KEY_TYPEALIAS) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D cil_gen_a=
lias(db, parse_current, ast_node, CIL_TYPEALIAS);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (parse_current-&gt;data =3D=3D CIL=
_KEY_TYPEALIASACTUAL) {<br>
&gt; diff --git a/libsepol/cil/src/cil_build_ast.h b/libsepol/cil/src/cil_b=
uild_ast.h<br>
&gt; index 54662035..33bae997 100644<br>
&gt; --- a/libsepol/cil/src/cil_build_ast.h<br>
&gt; +++ b/libsepol/cil/src/cil_build_ast.h<br>
&gt; @@ -138,6 +138,8 @@ int cil_gen_aliasactual(struct cil_db *db, struct =
cil_tree_node *parse_current,<br>
&gt;=C2=A0 =C2=A0void cil_destroy_aliasactual(struct cil_aliasactual *alias=
actual);<br>
&gt;=C2=A0 =C2=A0int cil_gen_typeattributeset(struct cil_db *db, struct cil=
_tree_node *parse_current, struct cil_tree_node *ast_node);<br>
&gt;=C2=A0 =C2=A0void cil_destroy_typeattributeset(struct cil_typeattribute=
set *attrtypes);<br>
&gt; +int cil_gen_expandtypeattribute(struct cil_db *db, struct cil_tree_no=
de *parse_current, struct cil_tree_node *ast_node);<br>
&gt; +void cil_destroy_expandtypeattribute(struct cil_expandtypeattribute *=
expandattr);<br>
&gt;=C2=A0 =C2=A0int cil_gen_typebounds(struct cil_db *db, struct cil_tree_=
node *parse_current, struct cil_tree_node *ast_node);<br>
&gt;=C2=A0 =C2=A0int cil_gen_typepermissive(struct cil_db *db, struct cil_t=
ree_node *parse_current, struct cil_tree_node *ast_node);<br>
&gt;=C2=A0 =C2=A0void cil_destroy_typepermissive(struct cil_typepermissive =
*typeperm);<br>
&gt; diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_co=
py_ast.c<br>
&gt; index 2d085dd7..d6685050 100644<br>
&gt; --- a/libsepol/cil/src/cil_copy_ast.c<br>
&gt; +++ b/libsepol/cil/src/cil_copy_ast.c<br>
&gt; @@ -648,6 +648,29 @@ int cil_copy_typeattributeset(struct cil_db *db, =
void *data, void **copy, __attr<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return SEPOL_OK;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;<br>
&gt; +int cil_copy_expandtypeattribute(__attribute__((unused)) struct cil_d=
b *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct cil_expandtypeattribute *orig =3D data;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0struct cil_expandtypeattribute *new =3D NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;%s %u\n&quot;, __func__, __=
LINE__);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cil_expandtypeattribute_init(&amp;new);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (orig-&gt;attr_strs !=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cil_copy_list(orig-&g=
t;attr_strs, &amp;new-&gt;attr_strs);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (orig-&gt;attr_datums !=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cil_copy_list(orig-&g=
t;attr_datums, &amp;new-&gt;attr_datums);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0new-&gt;expand =3D orig-&gt;expand;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*copy =3D new;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return SEPOL_OK;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0int cil_copy_alias(__attribute__((unused)) struct cil_db *=
db, void *data, void **copy, symtab_t *symtab)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct cil_alias *orig =3D data;<br>
&gt; @@ -1808,6 +1831,9 @@ int __cil_copy_node_helper(struct cil_tree_node =
*orig, __attribute__((unused)) u<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case CIL_TYPEATTRIBUTESET:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0copy_func =3D &a=
mp;cil_copy_typeattributeset;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case CIL_EXPANDTYPEATTRIBUTE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0copy_func =3D &amp;ci=
l_copy_expandtypeattribute;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case CIL_TYPEALIAS:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0copy_func =3D &a=
mp;cil_copy_alias;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; diff --git a/libsepol/cil/src/cil_flavor.h b/libsepol/cil/src/cil_flav=
or.h<br>
&gt; index cd08b972..c01f967a 100644<br>
&gt; --- a/libsepol/cil/src/cil_flavor.h<br>
&gt; +++ b/libsepol/cil/src/cil_flavor.h<br>
&gt; @@ -73,6 +73,7 @@ enum cil_flavor {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0CIL_ROLETYPE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0CIL_ROLEBOUNDS,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0CIL_TYPEATTRIBUTESET,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0CIL_EXPANDTYPEATTRIBUTE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0CIL_TYPEALIASACTUAL,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0CIL_TYPEBOUNDS,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0CIL_TYPEPERMISSIVE,<br>
&gt; diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_in=
ternal.h<br>
&gt; index efa2cd6e..aee3f00c 100644<br>
&gt; --- a/libsepol/cil/src/cil_internal.h<br>
&gt; +++ b/libsepol/cil/src/cil_internal.h<br>
&gt; @@ -174,6 +174,7 @@ char *CIL_KEY_SELINUXUSER;<br>
&gt;=C2=A0 =C2=A0char *CIL_KEY_SELINUXUSERDEFAULT;<br>
&gt;=C2=A0 =C2=A0char *CIL_KEY_TYPEATTRIBUTE;<br>
&gt;=C2=A0 =C2=A0char *CIL_KEY_TYPEATTRIBUTESET;<br>
&gt; +char *CIL_KEY_EXPANDTYPEATTRIBUTE;<br>
&gt;=C2=A0 =C2=A0char *CIL_KEY_TYPEALIAS;<br>
&gt;=C2=A0 =C2=A0char *CIL_KEY_TYPEALIASACTUAL;<br>
&gt;=C2=A0 =C2=A0char *CIL_KEY_TYPEBOUNDS;<br>
&gt; @@ -515,9 +516,11 @@ struct cil_type=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int value;<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;<br>
&gt; -#define CIL_ATTR_AVRULE=C2=A0 =C2=A0 =C2=A00x01<br>
&gt; -#define CIL_ATTR_NEVERALLOW 0x02<br>
&gt; -#define CIL_ATTR_CONSTRAINT 0x04<br>
&gt; +#define CIL_ATTR_AVRULE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (1 &lt;&lt; 0)<br>
&gt; +#define CIL_ATTR_NEVERALLOW=C2=A0 (1 &lt;&lt; 1)<br>
&gt; +#define CIL_ATTR_CONSTRAINT=C2=A0 (1 &lt;&lt; 2)<br>
&gt; +#define CIL_ATTR_EXPAND_TRUE (1 &lt;&lt; 3)<br>
&gt; +#define CIL_ATTR_EXPAND_FALSE=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; =
4)<br>
&gt;=C2=A0 =C2=A0struct cil_typeattribute {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct cil_symtab_datum datum;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct cil_list *expr_list;<br>
&gt; @@ -531,6 +534,12 @@ struct cil_typeattributeset {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct cil_list *datum_expr;<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;<br>
&gt; +struct cil_expandtypeattribute {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct cil_list *attr_strs;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct cil_list *attr_datums;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int expand;<br>
&gt; +};<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0struct cil_typepermissive {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0char *type_str;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0void *type; /* type or alias */<br>
&gt; @@ -977,6 +986,7 @@ void cil_roleattributeset_init(struct cil_roleattr=
ibuteset **attrset);<br>
&gt;=C2=A0 =C2=A0void cil_roletype_init(struct cil_roletype **roletype);<br=
>
&gt;=C2=A0 =C2=A0void cil_typeattribute_init(struct cil_typeattribute **att=
ribute);<br>
&gt;=C2=A0 =C2=A0void cil_typeattributeset_init(struct cil_typeattributeset=
 **attrset);<br>
&gt; +void cil_expandtypeattribute_init(struct cil_expandtypeattribute **ex=
pandattr);<br>
&gt;=C2=A0 =C2=A0void cil_alias_init(struct cil_alias **alias);<br>
&gt;=C2=A0 =C2=A0void cil_aliasactual_init(struct cil_aliasactual **aliasac=
tual);<br>
&gt;=C2=A0 =C2=A0void cil_typepermissive_init(struct cil_typepermissive **t=
ypeperm);<br>
&gt; diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c=
<br>
&gt; index e32a8fc9..1941fab3 100644<br>
&gt; --- a/libsepol/cil/src/cil_post.c<br>
&gt; +++ b/libsepol/cil/src/cil_post.c<br>
&gt; @@ -1194,6 +1194,14 @@ static int cil_typeattribute_used(struct cil_ty=
peattribute *attr, struct cil_db<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CIL_FALSE=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (attr-&gt;used &amp; CIL_ATTR_EXPAND_FALSE) {<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CIL_TRUE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (attr-&gt;used &amp; CIL_ATTR_EXPAND_TRUE) {<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CIL_FALSE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (attr-&gt;used &amp; CIL_ATTR_CONSTRAINT)=
 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CIL_TRUE;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_r=
eset_ast.c<br>
&gt; index de00679e..676e156e 100644<br>
&gt; --- a/libsepol/cil/src/cil_reset_ast.c<br>
&gt; +++ b/libsepol/cil/src/cil_reset_ast.c<br>
&gt; @@ -549,6 +549,7 @@ int __cil_reset_node(struct cil_tree_node *node,=
=C2=A0 __attribute__((unused)) uint32<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case CIL_CLASSORDER:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case CIL_CATORDER:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case CIL_SENSITIVITYORDER:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case CIL_EXPANDTYPEATTRIBUTE:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break; /* Nothin=
g to reset */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil=
_resolve_ast.c<br>
&gt; index 6da44ba1..8925b271 100644<br>
&gt; --- a/libsepol/cil/src/cil_resolve_ast.c<br>
&gt; +++ b/libsepol/cil/src/cil_resolve_ast.c<br>
&gt; @@ -271,14 +271,24 @@ exit:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0int cil_type_used(struct cil_symtab_datum *datum, int used=
)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int rc =3D SEPOL_ERR;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct cil_typeattribute *attr =3D NULL;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (FLAVOR(datum) =3D=3D CIL_TYPEATTRIBUTE) =
{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0attr =3D (struct=
 cil_typeattribute*)datum;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0attr-&gt;used |=
=3D used;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((attr-&gt;used &a=
mp; CIL_ATTR_EXPAND_TRUE) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(attr-&gt;used &amp; CIL_ATTR_EXPAND_FAL=
SE)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0cil_log(CIL_ERR, &quot;Conflicting use of expandtypeattribute. &quot=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Expand=
typeattribute may be set to true or false &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;but no=
t both. \n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0goto exit;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return SEPOL_OK;<br>
&gt; +exit:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return rc;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0int cil_resolve_permissionx(struct cil_tree_node *current,=
 struct cil_permissionx *permx, void *extra_args)<br>
&gt; @@ -453,6 +463,44 @@ exit:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return rc;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;<br>
&gt; +int cil_resolve_expandtypeattribute(struct cil_tree_node *current, vo=
id *extra_args)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct cil_expandtypeattribute *expandattr =3D cu=
rrent-&gt;data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct cil_symtab_datum *attr_datum =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct cil_tree_node *attr_node =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct cil_list_item *curr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int used;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int rc =3D SEPOL_ERR;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cil_list_init(&amp;expandattr-&gt;attr_datums, CI=
L_TYPE);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cil_list_for_each(curr, expandattr-&gt;attr_strs)=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D cil_resolve_na=
me(current, (char *)curr-&gt;data, CIL_SYM_TYPES, extra_args, &amp;attr_dat=
um);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc !=3D SEPOL_OK)=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0goto exit;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0attr_node =3D attr_da=
tum-&gt;nodes-&gt;head-&gt;data;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (attr_node-&gt;fla=
vor !=3D CIL_TYPEATTRIBUTE) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0rc =3D SEPOL_ERR;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0cil_log(CIL_ERR, &quot;Attribute type not an attribute\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0goto exit;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0used =3D expandattr-&=
gt;expand ? CIL_ATTR_EXPAND_TRUE : CIL_ATTR_EXPAND_FALSE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D cil_type_used(=
attr_datum, used);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc !=3D SEPOL_OK)=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0goto exit;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cil_list_append(expan=
dattr-&gt;attr_datums, CIL_TYPE, attr_datum);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return SEPOL_OK;<br>
&gt; +exit:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return rc;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0int cil_resolve_aliasactual(struct cil_tree_node *current,=
 void *extra_args, enum cil_flavor flavor, enum cil_flavor alias_flavor)<br=
>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int rc =3D SEPOL_ERR;<br>
&gt; @@ -3432,6 +3480,9 @@ int __cil_resolve_ast_node(struct cil_tree_node =
*node, void *extra_args)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case CIL_TYPEATT=
RIBUTESET:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0rc =3D cil_resolve_typeattributeset(node, args);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case CIL_EXPANDTYPEAT=
TRIBUTE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0rc =3D cil_resolve_expandtypeattribute(node, args);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case CIL_TYPEBOU=
NDS:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0rc =3D cil_resolve_bounds(node, args, CIL_TYPE, CIL_TYPEATTRIB=
UTE);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>
&gt; diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c=
<br>
&gt; index 9ff9d4b4..2cc2744a 100644<br>
&gt; --- a/libsepol/cil/src/cil_tree.c<br>
&gt; +++ b/libsepol/cil/src/cil_tree.c<br>
&gt; @@ -703,6 +703,17 @@ void cil_tree_print_node(struct cil_tree_node *no=
de)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0cil_log(CIL_INFO, &quot;TYPE: %s\n&quot;, type-&gt;<a href=3D"=
http://datum.name" rel=3D"noreferrer" target=3D"_blank">datum.name</a>);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case CIL_EXPANDTYPEAT=
TRIBUTE: {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0struct cil_expandtypeattribute *attr =3D node-&gt;data;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0fprintf(stderr, &quot;%s %u\n&quot;, __func__, __LINE__);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0cil_log(CIL_INFO, &quot;(EXPANDTYPEATTRIBUTE &quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0cil_tree_print_expr(attr-&gt;attr_datums, attr-&gt;attr_strs);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0cil_log(CIL_INFO, &quot;%s)\n&quot;,attr-&gt;expand ?<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CIL_KEY_COND=
TRUE : CIL_KEY_CONDFALSE);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case CIL_TYPEATT=
RIBUTESET: {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0struct cil_typeattributeset *attr =3D node-&gt;data;<br>
&gt;<br>
&gt; diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/inc=
lude/sepol/policydb/policydb.h<br>
&gt; index 4336a3f2..37e0c9e5 100644<br>
&gt; --- a/libsepol/include/sepol/policydb/policydb.h<br>
&gt; +++ b/libsepol/include/sepol/policydb/policydb.h<br>
&gt; @@ -178,7 +178,11 @@ typedef struct type_datum {<br>
&gt;=C2=A0 =C2=A0#define TYPE_ALIAS 2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 /* alias in modular policy */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t flavor;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ebitmap_t types;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
/* types with this attribute */<br>
&gt; -#define TYPE_FLAGS_PERMISSIVE=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x01<br>
&gt; +#define TYPE_FLAGS_PERMISSIVE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 0)<br>
&gt; +#define TYPE_FLAGS_EXPAND_ATTR_TRUE=C2=A0 (1 &lt;&lt; 1)<br>
&gt; +#define TYPE_FLAGS_EXPAND_ATTR_FALSE (1 &lt;&lt; 2)<br>
&gt; +#define TYPE_FLAGS_EXPAND_ATTR (TYPE_FLAGS_EXPAND_ATTR_TRUE | \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_FLAGS_EXPAND_ATTR_FALSE)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t flags;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t bounds;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
/* bounds type, if exist */<br>
&gt;=C2=A0 =C2=A0} type_datum_t;<br>
&gt; diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil=
.c<br>
&gt; index ac095c30..7d8eb204 100644<br>
&gt; --- a/libsepol/src/module_to_cil.c<br>
&gt; +++ b/libsepol/src/module_to_cil.c<br>
&gt; @@ -2244,6 +2244,17 @@ static int type_to_cil(int indent, struct polic=
ydb *pdb, struct avrule_block *UN<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0cil_println(indent, &quot;(typeattribute %s)&quot;, key);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (type-&gt;flags &a=
mp; TYPE_FLAGS_EXPAND_ATTR) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0cil_indent(indent);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0cil_printf(&quot;(expandtypeattribute (%s) &quot;, key);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (type-&gt;flags &amp; TYPE_FLAGS_EXPAND_ATTR_TRUE) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cil_printf(&quot;true&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0} else if (type-&gt;flags &amp; TYPE_FLAGS_EXPAND_ATTR_FALSE) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cil_printf(&quot;false&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0cil_printf(&quot;)\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ebitmap_card=
inality(&amp;type-&gt;types) &gt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0cil_indent(indent);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0cil_printf(&quot;(typeattributeset %s (&quot;, key);<br>
&gt;<br>
<br>
<br>
--<br>
James Carter &lt;<a href=3D"mailto:jwcart2@tycho.nsa.gov" target=3D"_blank"=
>jwcart2@tycho.nsa.gov</a>&gt;<br>
National Security Agency<br>
</blockquote></div>

--f403045fb73cd1a5d2054ecd34e9--
