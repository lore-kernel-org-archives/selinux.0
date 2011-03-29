From: Kohei Kaigai <Kohei.Kaigai@EU.NEC.COM>
To: Eric Paris <eparis@redhat.com>,
        "selinux@tycho.nsa.gov"
	<selinux@tycho.nsa.gov>
CC: "method@manicmethod.com" <method@manicmethod.com>,
        "sds@tycho.nsa.gov"
	<sds@tycho.nsa.gov>
Date: Tue, 29 Mar 2011 10:28:47 +0100
Subject: RE: [PATCH] checkpolicy: add support for using last path component
 in type transition rules
Message-ID: <A9F5079BABDEE646AEBDB6831725762C52B55492E0@EUEXCLU01.EU.NEC.COM>
References: <1301335220.14296.27.camel@localhost.localdomain>
In-Reply-To: <1301335220.14296.27.camel@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> This patch adds support for using the last path component as part of the
> information in making labeling decisions for new objects.  A example
> rule looks like so:
>
> type_transition unconfined_t etc_t:file system_conf_t eric;
>
> This rule says if unconfined_t creates a file in a directory labeled
> etc_t and the last path component is "eric" (no globbing, no matching
> magic, just exact strcmp) it should be labeled system_conf_t.
>
It seems to me quite useful for my project also.
(Sorry, I overlooked your proposition on the December.)

Similarly, we might use these rules like:

Type_transition unconfined_t sepgsql_db_t:db_schema sepgsql_temp_schema_t pg_temp;

This rule says if unconfined_t tries to create a schema object in a database
labelled sepgsql_db_t and the name component is "pg_temp" that means a schema
to store temporary objects.

We need to modify userspace interface to support this new feature, don't we?

Probably, it has the following prototype,

  int security_compute_create_name(const security_context_t *scontext,
                                   const security_context_t *tcontext,
                                   security_class_t tclass,
                                   security_context_t *newcon,
                                   const char *object_name);

And, selinuxfs needs to accept the fourth argument optionally on /selinux/create.

> The kernel and policy representation does not have support for such
> rules in conditionals, and thus policy explicitly notes that fact if
> such a rule is added to a conditional.
>
Does it has technically difficulties? Or, just a current limitation?

Thanks,
--
NEC Europe Ltd, Global Competence Center
KaiGai Kohei <kohei.kaigai@eu.nec.com>


> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of Eric Paris
> Sent: 28. März 2011 19:00
> To: selinux@tycho.nsa.gov
> Cc: method@manicmethod.com; sds@tycho.nsa.gov
> Subject: [PATCH] checkpolicy: add support for using last path component in
> type transition rules
>
> This patch adds support for using the last path component as part of the
> information in making labeling decisions for new objects.  A example
> rule looks like so:
>
> type_transition unconfined_t etc_t:file system_conf_t eric;
>
> This rule says if unconfined_t creates a file in a directory labeled
> etc_t and the last path component is "eric" (no globbing, no matching
> magic, just exact strcmp) it should be labeled system_conf_t.
>
> The kernel and policy representation does not have support for such
> rules in conditionals, and thus policy explicitly notes that fact if
> such a rule is added to a conditional.
>
> Signed-off-by: Eric Paris <eparis@redhat.com>
> ---
>
> diff -up checkpolicy-2.0.23/module_compiler.c.eparis2
> checkpolicy-2.0.23/module_compiler.c
> --- checkpolicy-2.0.23/module_compiler.c.eparis2      2010-12-21
> 16:35:45.000000000 -0500
> +++ checkpolicy-2.0.23/module_compiler.c      2011-03-23 14:19:51.152530839
> -0400
> @@ -1313,6 +1313,18 @@ void append_role_allow(role_allow_rule_t
>  }
>
>  /* this doesn't actually append, but really prepends it */
> +void append_filename_trans(filename_trans_rule_t * filename_trans_rules)
> +{
> +     avrule_decl_t *decl = stack_top->decl;
> +
> +     /* filename transitions are not allowed within conditionals */
> +     assert(stack_top->type == 1);
> +
> +     filename_trans_rules->next = decl->filename_trans_rules;
> +     decl->filename_trans_rules = filename_trans_rules;
> +}
> +
> +/* this doesn't actually append, but really prepends it */
>  void append_range_trans(range_trans_rule_t * range_tr_rules)
>  {
>       avrule_decl_t *decl = stack_top->decl;
> diff -up checkpolicy-2.0.23/module_compiler.h.eparis2
> checkpolicy-2.0.23/module_compiler.h
> --- checkpolicy-2.0.23/module_compiler.h.eparis2      2010-12-21
> 16:35:45.000000000 -0500
> +++ checkpolicy-2.0.23/module_compiler.h      2011-03-23 14:19:51.154531123
> -0400
> @@ -80,6 +80,7 @@ void append_avrule(avrule_t * avrule);
>  void append_role_trans(role_trans_rule_t * role_tr_rules);
>  void append_role_allow(role_allow_rule_t * role_allow_rules);
>  void append_range_trans(range_trans_rule_t * range_tr_rules);
> +void append_filename_trans(filename_trans_rule_t * filename_trans_rules);
>
>  /* Create a new optional block and add it to the global policy.
>   * During the second pass resolve the block's requirements.  Return 0
> diff -up checkpolicy-2.0.23/policy_define.c.eparis2
> checkpolicy-2.0.23/policy_define.c
> --- checkpolicy-2.0.23/policy_define.c.eparis2        2010-12-21
> 16:35:45.000000000 -0500
> +++ checkpolicy-2.0.23/policy_define.c        2011-03-28 13:50:57.667710915
> -0400
> @@ -2196,6 +2196,190 @@ int define_role_allow(void)
>       return 0;
>  }
>
> +avrule_t *define_cond_filename_trans(void)
> +{
> +     yyerror("type transitions with a filename not allowed inside "
> +             "conditionals\n");
> +     return COND_ERR;
> +}
> +
> +int define_filename_trans(void)
> +{
> +     char *id, *name = NULL;
> +     type_set_t stypes, ttypes;
> +     ebitmap_t e_stypes, e_ttypes;
> +     ebitmap_t e_tclasses;
> +     ebitmap_node_t *snode, *tnode, *cnode;
> +     filename_trans_t *ft;
> +     filename_trans_rule_t *ftr;
> +     class_datum_t *cladatum;
> +     type_datum_t *typdatum;
> +     uint32_t otype;
> +     unsigned int c, s, t;
> +     int add;
> +
> +     if (pass == 1) {
> +             /* stype */
> +             while ((id = queue_remove(id_queue)))
> +                     free(id);
> +             /* ttype */
> +             while ((id = queue_remove(id_queue)))
> +                     free(id);
> +             /* tclass */
> +             while ((id = queue_remove(id_queue)))
> +                     free(id);
> +             /* otype */
> +             id = queue_remove(id_queue);
> +             free(id);
> +             /* name */
> +             id = queue_remove(id_queue);
> +             free(id);
> +             return 0;
> +     }
> +
> +
> +     add = 1;
> +     type_set_init(&stypes);
> +     while ((id = queue_remove(id_queue))) {
> +             if (set_types(&stypes, id, &add, 0))
> +                     goto bad;
> +     }
> +
> +     add =1;
> +     type_set_init(&ttypes);
> +     while ((id = queue_remove(id_queue))) {
> +             if (set_types(&ttypes, id, &add, 0))
> +                     goto bad;
> +     }
> +
> +     ebitmap_init(&e_tclasses);
> +     while ((id = queue_remove(id_queue))) {
> +             if (!is_id_in_scope(SYM_CLASSES, id)) {
> +                     yyerror2("class %s is not within scope", id);
> +                     free(id);
> +                     goto bad;
> +             }
> +             cladatum = hashtab_search(policydbp->p_classes.table, id);
> +             if (!cladatum) {
> +                     yyerror2("unknown class %s", id);
> +                     goto bad;
> +             }
> +             if (ebitmap_set_bit(&e_tclasses, cladatum->s.value - 1,
> TRUE)) {
> +                     yyerror("Out of memory");
> +                     goto bad;
> +             }
> +             free(id);
> +     }
> +
> +     id = (char *)queue_remove(id_queue);
> +     if (!id) {
> +             yyerror("no otype in transition definition?");
> +             goto bad;
> +     }
> +     if (!is_id_in_scope(SYM_TYPES, id)) {
> +             yyerror2("type %s is not within scope", id);
> +             free(id);
> +             goto bad;
> +     }
> +     typdatum = hashtab_search(policydbp->p_types.table, id);
> +     if (!typdatum) {
> +             yyerror2("unknown type %s used in transition definition",
> id);
> +             goto bad;
> +     }
> +     free(id);
> +     otype = typdatum->s.value;
> +
> +     name = queue_remove(id_queue);
> +     if (!name) {
> +             yyerror("no pathname specified in filename_trans
> definition?");
> +             goto bad;
> +     }
> +
> +     /* We expand the class set into seperate rules.  We expand the types
> +      * just to make sure there are not duplicates.  They will get turned
> +      * into seperate rules later */
> +     ebitmap_init(&e_stypes);
> +     if (type_set_expand(&stypes, &e_stypes, policydbp, 1))
> +             goto bad;
> +
> +     ebitmap_init(&e_ttypes);
> +     if (type_set_expand(&ttypes, &e_ttypes, policydbp, 1))
> +             goto bad;
> +
> +     ebitmap_for_each_bit(&e_tclasses, cnode, c) {
> +             if (!ebitmap_node_get_bit(cnode, c))
> +                     continue;
> +             ebitmap_for_each_bit(&e_stypes, snode, s) {
> +                     if (!ebitmap_node_get_bit(snode, s))
> +                             continue;
> +                     ebitmap_for_each_bit(&e_ttypes, tnode, t) {
> +                             if (!ebitmap_node_get_bit(tnode, t))
> +                                     continue;
> +
> +                             for (ft = policydbp->filename_trans; ft;
> ft = ft->next) {
> +                                     if (ft->stype == (s + 1) &&
> +                                         ft->ttype == (t + 1) &&
> +                                         ft->tclass == (c + 1) &&
> +                                         !strcmp(ft->name, name)) {
> +                                             yyerror2("duplicate
> filename transition for: filename_trans %s %s %s:%s",
> +                                                      name,
> +
> policydbp->p_type_val_to_name[s],
> +
> policydbp->p_type_val_to_name[t],
> +
> policydbp->p_class_val_to_name[c]);
> +                                             goto bad;
> +                                     }
> +                             }
> +
> +                             ft = malloc(sizeof(*ft));
> +                             if (!ft) {
> +                                     yyerror("out of memory");
> +                                     goto bad;
> +                             }
> +                             memset(ft, 0, sizeof(*ft));
> +
> +                             ft->next = policydbp->filename_trans;
> +                             policydbp->filename_trans = ft;
> +
> +                             ft->name = strdup(name);
> +                             if (!ft->name) {
> +                                     yyerror("out of memory");
> +                                     goto bad;
> +                             }
> +                             ft->stype = s + 1;
> +                             ft->ttype = t + 1;
> +                             ft->tclass = c + 1;
> +                             ft->otype = otype;
> +                     }
> +             }
> +
> +             /* Now add the real rule since we didn't find any duplicates
> */
> +             ftr = malloc(sizeof(*ftr));
> +             if (!ftr) {
> +                     yyerror("out of memory");
> +                     goto bad;
> +             }
> +             filename_trans_rule_init(ftr);
> +             append_filename_trans(ftr);
> +
> +             ftr->name = strdup(name);
> +             ftr->stypes = stypes;
> +             ftr->ttypes = ttypes;
> +             ftr->tclass = c + 1;
> +             ftr->otype = otype;
> +     }
> +
> +     free(name);
> +     ebitmap_destroy(&e_stypes);
> +     ebitmap_destroy(&e_ttypes);
> +     ebitmap_destroy(&e_tclasses);
> +
> +     return 0;
> +
> +bad:
> +     free(name);
> +     return -1;
> +}
> +
>  static constraint_expr_t *constraint_expr_clone(constraint_expr_t * expr)
>  {
>       constraint_expr_t *h = NULL, *l = NULL, *e, *newe;
> diff -up checkpolicy-2.0.23/policy_define.h.eparis2
> checkpolicy-2.0.23/policy_define.h
> --- checkpolicy-2.0.23/policy_define.h.eparis2        2010-12-21
> 16:35:45.000000000 -0500
> +++ checkpolicy-2.0.23/policy_define.h        2011-03-28 13:50:05.489297128
> -0400
> @@ -16,6 +16,7 @@
>  avrule_t *define_cond_compute_type(int which);
>  avrule_t *define_cond_pol_list(avrule_t *avlist, avrule_t *stmt);
>  avrule_t *define_cond_te_avtab(int which);
> +avrule_t *define_cond_filename_trans(void);
>  cond_expr_t *define_cond_expr(uint32_t expr_type, void *arg1, void* arg2);
>  int define_attrib(void);
>  int define_av_perms(int inherits);
> @@ -47,6 +48,7 @@ int define_range_trans(int class_specifi
>  int define_role_allow(void);
>  int define_role_trans(void);
>  int define_role_types(void);
> +int define_filename_trans(void);
>  int define_sens(void);
>  int define_te_avtab(int which);
>  int define_typealias(void);
> diff -up checkpolicy-2.0.23/policy_parse.y.eparis2
> checkpolicy-2.0.23/policy_parse.y
> --- checkpolicy-2.0.23/policy_parse.y.eparis2 2011-03-23
> 14:19:51.133528148 -0400
> +++ checkpolicy-2.0.23/policy_parse.y 2011-03-28 13:49:03.489482156
> -0400
> @@ -342,7 +342,10 @@ cond_rule_def           : cond_transitio
>                       | require_block
>                       { $$ = NULL; }
>                          ;
> -cond_transition_def  : TYPE_TRANSITION names names ':' names identifier
> ';'
> +cond_transition_def  : TYPE_TRANSITION names names ':' names identifier
> identifier ';'
> +                        { $$ = define_cond_filename_trans() ;
> +                          if ($$ == COND_ERR) return -1;}
> +                     | TYPE_TRANSITION names names ':' names identifier
> ';'
>                          { $$ =
> define_cond_compute_type(AVRULE_TRANSITION) ;
>                            if ($$ == COND_ERR) return -1;}
>                          | TYPE_MEMBER names names ':' names identifier ';'
> @@ -377,7 +380,10 @@ cond_dontaudit_def       : DONTAUDIT names nam
>                       { $$ = define_cond_te_avtab(AVRULE_DONTAUDIT);
>                            if ($$ == COND_ERR) return -1; }
>                       ;
> -transition_def               : TYPE_TRANSITION names names ':' names identifier
> ';'
> +                     ;
> +transition_def               : TYPE_TRANSITION  names names ':' names identifier
> identifier ';'
> +                     {if (define_filename_trans()) return -1; }
> +                     | TYPE_TRANSITION names names ':' names identifier
> ';'
>                          {if (define_compute_type(AVRULE_TRANSITION))
> return -1;}
>                          | TYPE_MEMBER names names ':' names identifier ';'
>                          {if (define_compute_type(AVRULE_MEMBER)) return
> -1;}
> diff -up checkpolicy-2.0.23/test/dismod.c.eparis2
> checkpolicy-2.0.23/test/dismod.c
> --- checkpolicy-2.0.23/test/dismod.c.eparis2  2011-03-23
> 14:19:51.142529423 -0400
> +++ checkpolicy-2.0.23/test/dismod.c  2011-03-23 14:19:51.160531973
> -0400
> @@ -52,6 +52,7 @@
>  #define DISPLAY_AVBLOCK_ROLE_ALLOW   4
>  #define DISPLAY_AVBLOCK_REQUIRES     5
>  #define DISPLAY_AVBLOCK_DECLARES     6
> +#define DISPLAY_AVBLOCK_FILENAME_TRANS       7
>
>  static policydb_t policydb;
>  extern unsigned int ss_initialized;
> @@ -480,6 +481,18 @@ void display_role_allow(role_allow_rule_
>       }
>  }
>
> +void display_filename_trans(filename_trans_rule_t * tr, policydb_t * p, FILE
> * fp)
> +{
> +     for (; tr; tr = tr->next) {
> +             fprintf(fp, "filename transition %s", tr->name);
> +             display_type_set(&tr->stypes, 0, p, fp);
> +             display_type_set(&tr->ttypes, 0, p, fp);
> +             display_id(p, fp, SYM_CLASSES, tr->tclass - 1, ":");
> +             display_id(p, fp, SYM_TYPES, tr->otype - 1, "");
> +             fprintf(fp, "\n");
> +     }
> +}
> +
>  int role_display_callback(hashtab_key_t key, hashtab_datum_t datum, void
> *data)
>  {
>       role_datum_t *role;
> @@ -647,6 +660,11 @@ int display_avdecl(avrule_decl_t * decl,
>                       }
>                       break;
>               }
> +     case DISPLAY_AVBLOCK_FILENAME_TRANS:
> +             display_filename_trans(decl->filename_trans_rules,
> policy,
> +                                    out_fp);
> +                     return -1;
> +             break;
>       default:{
>                       assert(0);
>               }
> @@ -812,6 +830,7 @@ int menu()
>       printf("c)  Display policy capabilities\n");
>       printf("l)  Link in a module\n");
>       printf("u)  Display the unknown handling setting\n");
> +     printf("F)  Display filename_trans rules\n");
>       printf("\n");
>       printf("f)  set output file\n");
>       printf("m)  display menu\n");
> @@ -947,6 +966,11 @@ int main(int argc, char **argv)
>                       if (out_fp != stdout)
>                               printf("\nOutput to file: %s\n",
> OutfileName);
>                       break;
> +             case 'F':
> +                     fprintf(out_fp, "filename_trans rules:\n");
> +                     display_avblock(DISPLAY_AVBLOCK_FILENAME_TRANS,
> +                                     0, &policydb, out_fp);
> +                     break;
>               case 'l':
>                       link_module(&policydb, out_fp);
>                       break;
> diff -up checkpolicy-2.0.23/test/dispol.c.eparis2
> checkpolicy-2.0.23/test/dispol.c
> --- checkpolicy-2.0.23/test/dispol.c.eparis2  2010-12-21
> 16:35:45.000000000 -0500
> +++ checkpolicy-2.0.23/test/dispol.c  2011-03-23 14:19:51.162532256
> -0400
> @@ -341,6 +341,21 @@ static void display_permissive(policydb_
>       }
>  }
>
> +static void display_filename_trans(policydb_t *p, FILE *fp)
> +{
> +     filename_trans_t *ft;
> +
> +     fprintf(fp, "filename_trans rules:\n");
> +     for (ft = p->filename_trans; ft; ft = ft->next) {
> +             fprintf(fp, "%s\n", ft->name);
> +             display_id(p, fp, SYM_TYPES, ft->stype - 1, "");
> +             display_id(p, fp, SYM_TYPES, ft->ttype - 1, "");
> +             display_id(p, fp, SYM_CLASSES, ft->tclass - 1, ":");
> +             display_id(p, fp, SYM_TYPES, ft->otype - 1, "");
> +             fprintf(fp, "\n");
> +     }
> +}
> +
>  int menu()
>  {
>       printf("\nSelect a command:\n");
> @@ -355,6 +370,8 @@ int menu()
>       printf("c)  display policy capabilities\n");
>       printf("p)  display the list of permissive types\n");
>       printf("u)  display unknown handling setting\n");
> +     printf("F)  display filename_trans rules\n");
> +     printf("\n");
>       printf("f)  set output file\n");
>       printf("m)  display menu\n");
>       printf("q)  quit\n");
> @@ -492,6 +509,9 @@ int main(int argc, char **argv)
>                       if (out_fp != stdout)
>                               printf("\nOutput to file: %s\n",
> OutfileName);
>                       break;
> +             case 'F':
> +                     display_filename_trans(&policydb, out_fp);
> +                     break;
>               case 'q':
>                       policydb_destroy(&policydb);
>                       exit(0);
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>
>
>  Click
> https://www.mailcontrol.com/sr/5jPLEbCyJS7TndxI!oX7UlEvFrFJ1EkCf!VcU6Gcvz
> z3ej9D!FP2EWnZ9OOh!frND2OX8tvfK1ylpYdScFxEUA==  to report this email as
> spam.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
