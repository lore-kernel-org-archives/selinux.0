Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBA9C00140
	for <selinux@archiver.kernel.org>; Mon,  8 Aug 2022 17:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbiHHRPW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Aug 2022 13:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiHHRPV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Aug 2022 13:15:21 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6B3112F
        for <selinux@vger.kernel.org>; Mon,  8 Aug 2022 10:15:18 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-10ea9ef5838so11252679fac.3
        for <selinux@vger.kernel.org>; Mon, 08 Aug 2022 10:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=uLNz/bncjnUtK9TIgtvs4pkHVS0UdbW8wv6Y4mxeU3c=;
        b=YioYF4Ba7ZjXmse6pHPVjof2igCDmNNBXtz6KZhyrTzCZxrTlgRsSBC6WQ725qweFj
         Po0Q/oy93/AV9j4xnjhnbxvCO/3i6427RavPfGF17FD4qKq8Q0twbStx5CtLrjdG+Xmi
         1vLiRfIPDuinUsaK3OSPYZ9jwc3aC9PRfQWR5HT0Goyk5IerR+uTmT9WBRCGDOSELkoZ
         f0F2ojWZFP05mBGByOKXUY6UjHNnWDexx03y/ukiuqVJmQiw1GqRQYAIyhlQWNXs3RKH
         GJ9wNptiJSdb/TpZS6sgMb5f8wQdEWWMAfDFV785tK6Sr+n8xW9RdUt7pxAclRREttXX
         9MJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=uLNz/bncjnUtK9TIgtvs4pkHVS0UdbW8wv6Y4mxeU3c=;
        b=eYFRFLD1QCQhM4KGALIUGy+kcLZwzoqxKOiyMbnaMbVJD3k71pmy1ds/8hOWYpnD+L
         G9wpYGPnDpKrn5lZ/3y0rBR7kBm2Vf20sRloxWjJH1Mj8+dQLTPoS1mX2acgUXBi0T46
         yY/dRuQMoNxHmnLtg6d4Q2Dr1cBuxdZ8LGSaI4bFGXh1tGXIyTxxqsVqmRfoVXGg6GIU
         IrxAz2Xx3nbhKB/hy94w3aAJnWfv65wP4HjtKO30bOVzUTkF+Ys0CDJrF3Eq0QZlZnZD
         XaF32ACJxJXmqjiQg5yUT56w/4FN8vLhvyvMkLrCsl2ZJyNXZhdopd8rF3tf//aLwAv9
         gGHA==
X-Gm-Message-State: ACgBeo35s/FEXDhwQc05CfErHPwTK6ryTHljnhASh6aMluZRmyYtYx2z
        s0ytnyP2sw+iSq40VcAubJ7l0wvcaXwemrSStyyXTQcB
X-Google-Smtp-Source: AA6agR5OshJnQup/gGDwbxrqWxYxDMTdP/4+EOOg6JI2NrRLVwyPd/+mwZNf/zW9ZxDNUhkHomHIm2Xq7v7q6DjluCs=
X-Received: by 2002:a05:6870:c0c5:b0:10d:5f5c:9ab1 with SMTP id
 e5-20020a056870c0c500b0010d5f5c9ab1mr13058214oad.156.1659978917353; Mon, 08
 Aug 2022 10:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220721150515.19843-1-cgzones@googlemail.com> <20220721150515.19843-6-cgzones@googlemail.com>
In-Reply-To: <20220721150515.19843-6-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 8 Aug 2022 13:15:06 -0400
Message-ID: <CAP+JOzTUCFmvCdAGKXaGy1oh_gRkijR2jjFMuwuvpT-VYZ7kiQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] libsepol/cil: add support for segregate attributes
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 21, 2022 at 11:11 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Support the compile time constraint with the following syntax:
>
>     (segregateattributes (attr1 attr2 [...]))

Not a list. The vast majority of the cases are going to be that a type
can be either one or another.

(typesdisjoint attr1 attr2)

Keep it simple.

>
> and reports like:
>
>     ...
>     Qualifying Names
>     Compile post process
>     Building policy binary
>     Checking Neverallows
>     Checking Segregate Attributes
>     Segregate Attributes violation, type test_type associated with attrib=
utes attr1 attr2
>     Checking User Bounds
>     Checking Role Bounds
>     Checking Type Bounds
>     Failed to generate binary
>     Failed to build policydb
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/cil/src/cil.c             | 17 +++++++
>  libsepol/cil/src/cil_binary.c      | 75 ++++++++++++++++++++++++++++++
>  libsepol/cil/src/cil_build_ast.c   | 58 +++++++++++++++++++++++
>  libsepol/cil/src/cil_build_ast.h   |  2 +
>  libsepol/cil/src/cil_copy_ast.c    | 18 +++++++
>  libsepol/cil/src/cil_flavor.h      |  1 +
>  libsepol/cil/src/cil_internal.h    |  8 ++++
>  libsepol/cil/src/cil_policy.c      | 26 +++++++++++
>  libsepol/cil/src/cil_reset_ast.c   |  8 ++++
>  libsepol/cil/src/cil_resolve_ast.c | 38 +++++++++++++++
>  libsepol/cil/src/cil_resolve_ast.h |  1 +
>  libsepol/cil/src/cil_write_ast.c   | 11 +++++
>  libsepol/src/kernel_to_cil.c       | 32 +++++++++++++
>  secilc/docs/README.md              |  1 +
>  secilc/docs/cil_type_statements.md | 50 ++++++++++++++++++++
>  15 files changed, 346 insertions(+)
>
> diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> index 38edcf8e..cc6adb90 100644
> --- a/libsepol/cil/src/cil.c
> +++ b/libsepol/cil/src/cil.c
> @@ -225,6 +225,7 @@ char *CIL_KEY_SRC_CIL;
>  char *CIL_KEY_SRC_HLL_LMS;
>  char *CIL_KEY_SRC_HLL_LMX;
>  char *CIL_KEY_SRC_HLL_LME;
> +char *CIL_KEY_SEGREGATEATTRIBUTES;
>
>  static void cil_init_keys(void)
>  {
> @@ -394,6 +395,7 @@ static void cil_init_keys(void)
>         CIL_KEY_SRC_HLL_LMS =3D cil_strpool_add("lms");
>         CIL_KEY_SRC_HLL_LMX =3D cil_strpool_add("lmx");
>         CIL_KEY_SRC_HLL_LME =3D cil_strpool_add("lme");
> +       CIL_KEY_SEGREGATEATTRIBUTES =3D cil_strpool_add("segregateattribu=
tes");
>  }
>
>  void cil_db_init(struct cil_db **db)
> @@ -426,6 +428,7 @@ void cil_db_init(struct cil_db **db)
>         cil_list_init(&(*db)->userprefixes, CIL_LIST_ITEM);
>         cil_list_init(&(*db)->selinuxusers, CIL_LIST_ITEM);
>         cil_list_init(&(*db)->names, CIL_LIST_ITEM);
> +       cil_list_init(&(*db)->segregateattributes, CIL_LIST_ITEM);
>
>         cil_type_init(&(*db)->selftype);
>         (*db)->selftype->datum.name =3D CIL_KEY_SELF;
> @@ -481,6 +484,7 @@ void cil_db_destroy(struct cil_db **db)
>         cil_list_destroy(&(*db)->userprefixes, CIL_FALSE);
>         cil_list_destroy(&(*db)->selinuxusers, CIL_FALSE);
>         cil_list_destroy(&(*db)->names, CIL_TRUE);
> +       cil_list_destroy(&(*db)->segregateattributes, CIL_FALSE);
>
>         cil_destroy_type((*db)->selftype);
>
> @@ -1005,6 +1009,9 @@ void cil_destroy_data(void **data, enum cil_flavor =
flavor)
>         case CIL_SRC_INFO:
>                 cil_destroy_src_info(*data);
>                 break;
> +       case CIL_SEGREGATEATTRIBUTES:
> +               cil_destroy_segregateattributes(*data);
> +               break;
>         case CIL_OP:
>         case CIL_CONS_OPERAND:
>                 break;
> @@ -1413,6 +1420,8 @@ const char * cil_node_to_string(struct cil_tree_nod=
e *node)
>                 return CIL_KEY_CONS_H1;
>         case CIL_CONS_H2:
>                 return CIL_KEY_CONS_H2;
> +       case CIL_SEGREGATEATTRIBUTES:
> +               return CIL_KEY_SEGREGATEATTRIBUTES;
>
>         default:
>                 break;
> @@ -2904,3 +2913,11 @@ void cil_src_info_init(struct cil_src_info **info)
>         (*info)->hll_line =3D 0;
>         (*info)->path =3D NULL;
>  }
> +
> +void cil_segregateattributes_init(struct cil_segregateattributes **sattr=
s)
> +{
> +       *sattrs =3D cil_malloc(sizeof(**sattrs));
> +
> +       (*sattrs)->str_expr =3D NULL;
> +       (*sattrs)->datum_expr =3D NULL;
> +}
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.=
c
> index 40615db2..0301d739 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -3818,6 +3818,38 @@ exit:
>         return SEPOL_ERR;
>  }
>
> +static int cil_segregateattributes_to_policydb(policydb_t *pdb, const st=
ruct cil_segregateattributes *sattrs)
> +{
> +       segregate_attributes_rule_t *sattr;
> +       struct cil_list_item *curr;
> +       type_datum_t *sepol_type;
> +       int rc =3D SEPOL_ERR;
> +
> +       sattr =3D cil_malloc(sizeof(segregate_attributes_rule_t));
> +       ebitmap_init(&sattr->attrs);
> +
> +       cil_list_for_each(curr, sattrs->datum_expr) {
> +               rc =3D __cil_get_sepol_type_datum(pdb, DATUM(curr->data),=
 &sepol_type);
> +               if (rc !=3D SEPOL_OK) goto exit;
> +
> +               if (ebitmap_set_bit(&sattr->attrs, sepol_type->s.value - =
1, 1)) {
> +                       goto exit;
> +               }
> +       }
> +
> +       sattr->next =3D pdb->segregate_attributes;
> +       pdb->segregate_attributes =3D sattr;
> +
> +       return SEPOL_OK;
> +
> +exit:
> +       if (sattr) {
> +               ebitmap_destroy(&sattr->attrs);
> +               free(sattr);
> +       }
> +       return rc;
> +}
> +
>  static int __cil_node_to_policydb(struct cil_tree_node *node, void *extr=
a_args)
>  {
>         int rc =3D SEPOL_OK;
> @@ -3960,6 +3992,9 @@ static int __cil_node_to_policydb(struct cil_tree_n=
ode *node, void *extra_args)
>                 case CIL_DEFAULTRANGE:
>                         rc =3D cil_defaultrange_to_policydb(pdb, node->da=
ta);
>                         break;
> +               case CIL_SEGREGATEATTRIBUTES:
> +                       rc =3D cil_segregateattributes_to_policydb(pdb, n=
ode->data);
> +                       break;
>                 default:
>                         break;
>                 }
> @@ -4890,6 +4925,42 @@ exit:
>         return rc;
>  }
>
> +static int cil_check_segregateattributes(const policydb_t *pdb, int *vio=
lation)
> +{
> +       const segregate_attributes_rule_t *sattr;
> +
> +       for (sattr =3D pdb->segregate_attributes; sattr; sattr =3D sattr-=
>next) {
> +               ebitmap_node_t *first_node;
> +               unsigned int first_bit;
> +
> +               ebitmap_for_each_positive_bit(&sattr->attrs, first_node, =
first_bit) {
> +                       ebitmap_node_t *second_node;
> +                       unsigned int second_bit;
> +
> +                       ebitmap_for_each_positive_bit_after(&sattr->attrs=
, second_node, second_bit, first_node, first_bit) {
> +                               ebitmap_t attr_union;
> +                               ebitmap_node_t *type_node;
> +                               unsigned int type_bit;
> +
> +                               if (ebitmap_and(&attr_union, &pdb->attr_t=
ype_map[first_bit], &pdb->attr_type_map[second_bit]))
> +                                       return SEPOL_ERR;
> +
> +                               ebitmap_for_each_positive_bit(&attr_union=
, type_node, type_bit) {
> +                                       cil_log(CIL_ERR, "Segregate Attri=
butes violation, type %s associated with attributes %s and %s\n",
> +                                                        pdb->p_type_val_=
to_name[type_bit],
> +                                                        pdb->p_type_val_=
to_name[first_bit],
> +                                                        pdb->p_type_val_=
to_name[second_bit]);
> +                                       *violation =3D CIL_TRUE;

It needs to report the file and linenumber of the violation. This is
the case for checkpolicy as well. There is a reason that we carry that
information for neverallow rules.

Thanks,
Jim


> +                               }
> +
> +                               ebitmap_destroy(&attr_union);
> +                       }
> +               }
> +       }
> +
> +       return SEPOL_OK;
> +}
> +
>  static struct cil_list *cil_classperms_from_sepol(policydb_t *pdb, uint1=
6_t class, uint32_t data, struct cil_class *class_value_to_cil[], struct ci=
l_perm **perm_value_to_cil[])
>  {
>         struct cil_classperms *cp;
> @@ -5160,6 +5231,10 @@ int cil_binary_create_allocated_pdb(const struct c=
il_db *db, sepol_policydb_t *p
>                 rc =3D cil_check_neverallows(db, pdb, neverallows, &viola=
tion);
>                 if (rc !=3D SEPOL_OK) goto exit;
>
> +               cil_log(CIL_INFO, "Checking Segregate Attributes\n");
> +               rc =3D cil_check_segregateattributes(pdb, &violation);
> +               if (rc !=3D SEPOL_OK) goto exit;
> +
>                 cil_log(CIL_INFO, "Checking User Bounds\n");
>                 rc =3D bounds_check_users(NULL, pdb);
>                 if (rc) {
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_buil=
d_ast.c
> index 4177c9f6..611aade8 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -6164,6 +6164,62 @@ void cil_destroy_src_info(struct cil_src_info *inf=
o)
>         free(info);
>  }
>
> +int cil_gen_segregateattributes(struct cil_db *db, struct cil_tree_node =
*parse_current, struct cil_tree_node *ast_node)
> +{
> +       enum cil_syntax syntax[] =3D {
> +               CIL_SYN_STRING,
> +               CIL_SYN_LIST,
> +               CIL_SYN_END
> +       };
> +       size_t syntax_len =3D sizeof(syntax)/sizeof(*syntax);
> +       struct cil_segregateattributes *sattrs =3D NULL;
> +       int rc =3D SEPOL_ERR;
> +
> +       if (db =3D=3D NULL || parse_current =3D=3D NULL || ast_node =3D=
=3D NULL) {
> +               goto exit;
> +       }
> +
> +       rc =3D __cil_verify_syntax(parse_current, syntax, syntax_len);
> +       if (rc !=3D SEPOL_OK) {
> +               goto exit;
> +       }
> +
> +       cil_segregateattributes_init(&sattrs);
> +
> +       rc =3D cil_gen_expr(parse_current->next, CIL_TYPEATTRIBUTE, &satt=
rs->str_expr);
> +       if (rc !=3D SEPOL_OK) {
> +               goto exit;
> +       }
> +
> +       /* require at least two attributes */
> +       if (sattrs->str_expr->head =3D=3D sattrs->str_expr->tail) {
> +               rc =3D SEPOL_ERR;
> +               goto exit;
> +       }
> +
> +       ast_node->data =3D sattrs;
> +       ast_node->flavor =3D CIL_SEGREGATEATTRIBUTES;
> +
> +       return SEPOL_OK;
> +
> +exit:
> +       cil_tree_log(parse_current, CIL_ERR, "Bad segregate attributes de=
claration");
> +       cil_destroy_segregateattributes(sattrs);
> +       return rc;
> +}
> +
> +void cil_destroy_segregateattributes(struct cil_segregateattributes *sat=
trs)
> +{
> +       if (sattrs =3D=3D NULL) {
> +               return;
> +       }
> +
> +       cil_list_destroy(&sattrs->str_expr, CIL_TRUE);
> +       cil_list_destroy(&sattrs->datum_expr, CIL_FALSE);
> +
> +       free(sattrs);
> +}
> +
>  static int check_for_illegal_statement(struct cil_tree_node *parse_curre=
nt, struct cil_args_build *args)
>  {
>         if (args->tunif !=3D NULL) {
> @@ -6455,6 +6511,8 @@ static struct cil_tree_node * parse_statement(struc=
t cil_db *db, struct cil_tree
>                 rc =3D cil_gen_mls(parse_current, new_ast_node);
>         } else if (parse_current->data =3D=3D CIL_KEY_SRC_INFO) {
>                 rc =3D cil_gen_src_info(parse_current, new_ast_node);
> +       } else if (parse_current->data =3D=3D CIL_KEY_SEGREGATEATTRIBUTES=
) {
> +               rc =3D cil_gen_segregateattributes(db, parse_current, new=
_ast_node);
>         } else {
>                 cil_log(CIL_ERR, "Error: Unknown keyword %s\n", (char *)p=
arse_current->data);
>                 rc =3D SEPOL_ERR;
> diff --git a/libsepol/cil/src/cil_build_ast.h b/libsepol/cil/src/cil_buil=
d_ast.h
> index fd9053ce..d815a22f 100644
> --- a/libsepol/cil/src/cil_build_ast.h
> +++ b/libsepol/cil/src/cil_build_ast.h
> @@ -225,6 +225,8 @@ int cil_gen_defaultrange(struct cil_tree_node *parse_=
current, struct cil_tree_no
>  void cil_destroy_defaultrange(struct cil_defaultrange *def);
>  int cil_gen_src_info(struct cil_tree_node *parse_current, struct cil_tre=
e_node *ast_node);
>  void cil_destroy_src_info(struct cil_src_info *info);
> +int cil_gen_segregateattributes(struct cil_db *db, struct cil_tree_node =
*parse_current, struct cil_tree_node *ast_node);
> +void cil_destroy_segregateattributes(struct cil_segregateattributes *sat=
trs);
>
>  int cil_fill_cats(struct cil_tree_node *curr, struct cil_cats **cats);
>  void cil_destroy_cats(struct cil_cats *cats);
> diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_=
ast.c
> index 17f05021..e0f3ba4f 100644
> --- a/libsepol/cil/src/cil_copy_ast.c
> +++ b/libsepol/cil/src/cil_copy_ast.c
> @@ -1697,6 +1697,21 @@ static int cil_copy_src_info(__attribute__((unused=
)) struct cil_db *db, void *da
>         return SEPOL_OK;
>  }
>
> +static int cil_copy_segregateattributes(__attribute__((unused)) struct c=
il_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symta=
b)
> +{
> +       struct cil_segregateattributes *orig =3D data;
> +       struct cil_segregateattributes *new =3D NULL;
> +
> +       cil_segregateattributes_init(&new);
> +
> +       cil_copy_expr(db, orig->str_expr, &new->str_expr);
> +       cil_copy_expr(db, orig->datum_expr, &new->datum_expr);
> +
> +       *copy =3D new;
> +
> +       return SEPOL_OK;
> +}
> +
>  static int __cil_copy_node_helper(struct cil_tree_node *orig, uint32_t *=
finished, void *extra_args)
>  {
>         int rc =3D SEPOL_ERR;
> @@ -1990,6 +2005,9 @@ static int __cil_copy_node_helper(struct cil_tree_n=
ode *orig, uint32_t *finished
>         case CIL_SRC_INFO:
>                 copy_func =3D &cil_copy_src_info;
>                 break;
> +       case CIL_SEGREGATEATTRIBUTES:
> +               copy_func =3D &cil_copy_segregateattributes;
> +               break;
>         default:
>                 goto exit;
>         }
> diff --git a/libsepol/cil/src/cil_flavor.h b/libsepol/cil/src/cil_flavor.=
h
> index c2f0cee7..ffbd5877 100644
> --- a/libsepol/cil/src/cil_flavor.h
> +++ b/libsepol/cil/src/cil_flavor.h
> @@ -115,6 +115,7 @@ enum cil_flavor {
>         CIL_SRC_INFO,
>         CIL_IBPKEYCON,
>         CIL_IBENDPORTCON,
> +       CIL_SEGREGATEATTRIBUTES,
>
>  /*
>   *          boolean  constraint  set  catset
> diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_inter=
nal.h
> index a7604762..e22c2f87 100644
> --- a/libsepol/cil/src/cil_internal.h
> +++ b/libsepol/cil/src/cil_internal.h
> @@ -242,6 +242,7 @@ extern char *CIL_KEY_SRC_CIL;
>  extern char *CIL_KEY_SRC_HLL_LMS;
>  extern char *CIL_KEY_SRC_HLL_LMX;
>  extern char *CIL_KEY_SRC_HLL_LME;
> +extern char *CIL_KEY_SEGREGATEATTRIBUTES;
>
>  /*
>         Symbol Table Array Indices
> @@ -309,6 +310,7 @@ struct cil_db {
>         struct cil_list *userprefixes;
>         struct cil_list *selinuxusers;
>         struct cil_list *names;
> +       struct cil_list *segregateattributes;
>         int num_types_and_attrs;
>         int num_classes;
>         int num_cats;
> @@ -975,6 +977,11 @@ struct cil_src_info {
>         char *path;
>  };
>
> +struct cil_segregateattributes {
> +       struct cil_list *str_expr;
> +       struct cil_list *datum_expr;
> +};
> +
>  void cil_db_init(struct cil_db **db);
>  void cil_db_destroy(struct cil_db **db);
>
> @@ -1085,5 +1092,6 @@ void cil_mls_init(struct cil_mls **mls);
>  void cil_src_info_init(struct cil_src_info **info);
>  void cil_userattribute_init(struct cil_userattribute **attribute);
>  void cil_userattributeset_init(struct cil_userattributeset **attrset);
> +void cil_segregateattributes_init(struct cil_segregateattributes **sattr=
s);
>
>  #endif
> diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.=
c
> index 7c543c47..36f6780d 100644
> --- a/libsepol/cil/src/cil_policy.c
> +++ b/libsepol/cil/src/cil_policy.c
> @@ -69,6 +69,7 @@ enum cil_statement_list {
>         CIL_LIST_USER,
>         CIL_LIST_CONSTRAINT,
>         CIL_LIST_VALIDATETRANS,
> +       CIL_LIST_SEGREGATEATTRIBUTES,
>         CIL_LIST_NUM_LISTS
>  };
>
> @@ -168,6 +169,9 @@ static int __cil_gather_statements_helper(struct cil_=
tree_node *node, uint32_t *
>         case CIL_VALIDATETRANS:
>                 kind =3D CIL_LIST_VALIDATETRANS;
>                 break;
> +       case CIL_SEGREGATEATTRIBUTES:
> +               kind =3D CIL_LIST_SEGREGATEATTRIBUTES;
> +               break;
>         default:
>                 break;
>         }
> @@ -1911,6 +1915,27 @@ static void cil_devicetreecons_to_policy(FILE *out=
, struct cil_sort *devicetreec
>         }
>  }
>
> +static void cil_segregateattributes_to_policy(FILE *out, struct cil_list=
 *sattrs_list)
> +{
> +       struct cil_list_item *curr_sattrs, *curr_attr;
> +       struct cil_segregateattributes *sattrs;
> +       int first =3D 1;
> +
> +       cil_list_for_each(curr_sattrs, sattrs_list) {
> +               sattrs =3D curr_sattrs->data;
> +               fprintf(out, "segregate_attriutes ");
> +               cil_list_for_each(curr_attr, sattrs->datum_expr) {
> +                       if (!first) {
> +                               first =3D 0;
> +                       } else {
> +                               fprintf(out, ", ");
> +                       }
> +                       fprintf(out, "%s", DATUM(curr_attr->data)->fqn);
> +               }
> +               fprintf(out, ";\n");
> +       }
> +}
> +
>  void cil_gen_policy(FILE *out, struct cil_db *db)
>  {
>         unsigned i;
> @@ -1956,6 +1981,7 @@ void cil_gen_policy(FILE *out, struct cil_db *db)
>         cil_typebounds_to_policy(out, lists[CIL_LIST_TYPE]);
>         cil_typeattributes_to_policy(out, lists[CIL_LIST_TYPE], lists[CIL=
_LIST_TYPEATTRIBUTE]);
>         cil_te_rules_to_policy(out, head, db->mls);
> +       cil_segregateattributes_to_policy(out, db->segregateattributes);
>
>         cil_roles_to_policy(out, lists[CIL_LIST_ROLE]);
>         cil_role_types_to_policy(out, lists[CIL_LIST_ROLE], lists[CIL_LIS=
T_TYPE]);
> diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_rese=
t_ast.c
> index 0864d7ef..c5ac83c8 100644
> --- a/libsepol/cil/src/cil_reset_ast.c
> +++ b/libsepol/cil/src/cil_reset_ast.c
> @@ -475,6 +475,11 @@ static void cil_reset_booleanif(struct cil_booleanif=
 *bif)
>         cil_list_destroy(&bif->datum_expr, CIL_FALSE);
>  }
>
> +static void cil_reset_segregateattributes(struct cil_segregateattributes=
 *sattrs)
> +{
> +       cil_list_destroy(&sattrs->datum_expr, CIL_FALSE);
> +}
> +
>  static int __cil_reset_node(struct cil_tree_node *node,  __attribute__((=
unused)) uint32_t *finished, __attribute__((unused)) void *extra_args)
>  {
>         switch (node->flavor) {
> @@ -630,6 +635,9 @@ static int __cil_reset_node(struct cil_tree_node *nod=
e,  __attribute__((unused))
>         case CIL_BOOLEANIF:
>                 cil_reset_booleanif(node->data);
>                 break;
> +       case CIL_SEGREGATEATTRIBUTES:
> +               cil_reset_segregateattributes(node->data);
> +               break;
>         case CIL_TUNABLEIF:
>         case CIL_CALL:
>                 break; /* Not effected by optional block disabling */
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_re=
solve_ast.c
> index f5e22c97..36a96199 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -3265,6 +3265,7 @@ int cil_resolve_expr(enum cil_flavor expr_type, str=
uct cil_list *str_expr, struc
>                 sym_index =3D CIL_SYM_TUNABLES;
>                 break;
>         case CIL_TYPE:
> +       case CIL_TYPEATTRIBUTE:
>                 sym_index =3D CIL_SYM_TYPES;
>                 break;
>         case CIL_ROLE:
> @@ -3312,6 +3313,13 @@ int cil_resolve_expr(enum cil_flavor expr_type, st=
ruct cil_list *str_expr, struc
>                         } else {
>                                 if (sym_index =3D=3D CIL_SYM_TYPES && (ex=
pr_type =3D=3D CIL_CONSTRAIN || expr_type =3D=3D CIL_VALIDATETRANS)) {
>                                         cil_type_used(res_datum, CIL_ATTR=
_CONSTRAINT);
> +                               } else if (expr_type =3D=3D CIL_SEGREGATE=
ATTRIBUTES) {
> +                                       if (FLAVOR(res_datum) !=3D CIL_TY=
PEATTRIBUTE) {
> +                                               cil_tree_log(parent, CIL_=
ERR, "Type or type alias not supported in segregate attributes declaration"=
);
> +                                               rc =3D SEPOL_ERR;
> +                                               goto exit;
> +                                       }
> +                                       cil_type_used(res_datum, CIL_ATTR=
_NEVERALLOW);
>                                 }
>                                 cil_list_append(*datum_expr, CIL_DATUM, r=
es_datum);
>                         }
> @@ -3508,6 +3516,33 @@ exit:
>         return rc;
>  }
>
> +int cil_resolve_segregateattributes(struct cil_tree_node *current, void =
*extra_args)
> +{
> +       struct cil_segregateattributes *sattrs =3D current->data;
> +       struct cil_list_item *first, *second;
> +       int rc;
> +
> +       rc =3D cil_resolve_expr(CIL_SEGREGATEATTRIBUTES, sattrs->str_expr=
, &sattrs->datum_expr, current, extra_args);
> +       if (rc !=3D SEPOL_OK) {
> +               goto exit;
> +       }
> +
> +       cil_list_for_each(first, sattrs->datum_expr) {
> +               for (second =3D first->next; second; second =3D second->n=
ext) {
> +                       if (first->data =3D=3D second->data) {
> +                               cil_tree_log(current, CIL_ERR, "Repeated =
attribute in segregate attributes declaration");
> +                               rc =3D SEPOL_ERR;
> +                               goto exit;
> +                       }
> +               }
> +       }
> +
> +       return SEPOL_OK;
> +
> +exit:
> +       return rc;
> +}
> +
>  /*
>   * Degenerate inheritance leads to exponential growth of the policy
>   * It can take many forms, but here is one example.
> @@ -3888,6 +3923,9 @@ static int __cil_resolve_ast_node(struct cil_tree_n=
ode *node, void *extra_args)
>                 case CIL_USERATTRIBUTESET:
>                         rc =3D cil_resolve_userattributeset(node, args);
>                         break;
> +               case CIL_SEGREGATEATTRIBUTES:
> +                       rc =3D cil_resolve_segregateattributes(node, args=
);
> +                       break;
>                 default:
>                         break;
>                 }
> diff --git a/libsepol/cil/src/cil_resolve_ast.h b/libsepol/cil/src/cil_re=
solve_ast.h
> index 1d971fd6..31594954 100644
> --- a/libsepol/cil/src/cil_resolve_ast.h
> +++ b/libsepol/cil/src/cil_resolve_ast.h
> @@ -96,6 +96,7 @@ int cil_resolve_expr(enum cil_flavor expr_type, struct =
cil_list *str_expr, struc
>  int cil_resolve_boolif(struct cil_tree_node *current, void *extra_args);
>  int cil_evaluate_expr(struct cil_list *datum_expr, uint16_t *result);
>  int cil_resolve_tunif(struct cil_tree_node *current, void *extra_args);
> +int cil_resolve_segregateattributes(struct cil_tree_node *current, void =
*extra_args);
>
>  int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current);
>  int cil_resolve_name(struct cil_tree_node *ast_node, char *name, enum ci=
l_sym_index sym_index, void *extra_args, struct cil_symtab_datum **datum);
> diff --git a/libsepol/cil/src/cil_write_ast.c b/libsepol/cil/src/cil_writ=
e_ast.c
> index b75784ef..d0fb555b 100644
> --- a/libsepol/cil/src/cil_write_ast.c
> +++ b/libsepol/cil/src/cil_write_ast.c
> @@ -1474,7 +1474,18 @@ void cil_write_ast_node(FILE *out, struct cil_tree=
_node *node)
>                 fprintf(out, "(ipaddr %s %s)\n", datum_to_str(&ipaddr->da=
tum), buf);
>                 break;
>         }
> +       case CIL_SEGREGATEATTRIBUTES: {
> +               struct cil_segregateattributes *sattrs =3D node->data;
> +               fprintf(out, "(segregateattributes ");
> +               if (sattrs->datum_expr)
> +                       write_expr(out, sattrs->datum_expr);
> +               else
> +                       write_expr(out, sattrs->str_expr);
> +               fprintf(out, ")\n");
> +               break;
> +       }
>         default :
> +               cil_log(CIL_ERR, "Unsupported flavor: %d\n", node->flavor=
);
>                 fprintf(out, "(<?RULE:%s>)\n", cil_node_to_string(node));
>                 break;
>         }
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index 9128ac55..4b99208d 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -1906,6 +1906,33 @@ static int map_filename_trans_to_str(hashtab_key_t=
 key, void *data, void *arg)
>         return 0;
>  }
>
> +static int write_segregate_attributes_to_cil(FILE *out, const struct pol=
icydb *pdb)
> +{
> +       const segregate_attributes_rule_t *sattr;
> +
> +       for (sattr =3D pdb->segregate_attributes; sattr; sattr =3D sattr-=
>next) {
> +               struct ebitmap_node *node;
> +               unsigned int bit;
> +               int first =3D 1;
> +
> +               sepol_printf(out, "(segregateattributes (");
> +
> +               ebitmap_for_each_positive_bit(&sattr->attrs, node, bit) {
> +                       if (first) {
> +                               first =3D 0;
> +                       } else {
> +                               sepol_printf(out, " ");
> +                       }
> +
> +                       sepol_printf(out, "%s", pdb->p_type_val_to_name[b=
it - 1]);
> +               }
> +
> +               sepol_printf(out, "))\n");
> +       }
> +
> +       return 0;
> +}
> +
>  static int write_filename_trans_rules_to_cil(FILE *out, struct policydb =
*pdb)
>  {
>         struct map_filename_trans_args args;
> @@ -3329,6 +3356,11 @@ int sepol_kernel_policydb_to_cil(FILE *out, struct=
 policydb *pdb)
>                 goto exit;
>         }
>
> +       rc =3D write_segregate_attributes_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
>         rc =3D write_filename_trans_rules_to_cil(out, pdb);
>         if (rc !=3D 0) {
>                 goto exit;
> diff --git a/secilc/docs/README.md b/secilc/docs/README.md
> index efab2a71..8f584019 100644
> --- a/secilc/docs/README.md
> +++ b/secilc/docs/README.md
> @@ -132,6 +132,7 @@ CIL (Common Intermediate Language)
>    * [typemember](cil_type_statements.md#typemember)
>    * [typetransition](cil_type_statements.md#typetransition)
>    * [typepermissive](cil_type_statements.md#typepermissive)
> +  * [segregateattributes](cil_type_statements.md#segregateattributes)
>
>  * [User Statements](cil_user_statements.md#user-statements)
>    * [user](cil_user_statements.md#user)
> diff --git a/secilc/docs/cil_type_statements.md b/secilc/docs/cil_type_st=
atements.md
> index 19438417..56533eea 100644
> --- a/secilc/docs/cil_type_statements.md
> +++ b/secilc/docs/cil_type_statements.md
> @@ -601,3 +601,53 @@ This example will allow SELinux to run the `healthd.=
process` domain in permissiv
>          (allow ...)
>      )
>  ```
> +
> +segregateattributes
> +-------------------
> +
> +Libsepol and secilc version 3.5 introduced the segregateattributes state=
ment
> +to mark two or more type attributes mutual exclusive. This is a compiler
> +enforced action that will stop compilation until the offending associati=
ons
> +are modified.
> +
> +Note that these constraints can be over-ridden by the CIL compiler comma=
nd
> +line parameter `-N` or `--disable-neverallow` flags.
> +
> +**Statement definition:**
> +
> +```secil
> +    (segregateattributes (typeattribute_id typeattribute_id...))
> +```
> +
> +**Where:**
> +
> +<table>
> +<colgroup>
> +<col width=3D"27%" />
> +<col width=3D"72%" />
> +</colgroup>
> +<tbody>
> +<tr class=3D"odd">
> +<td align=3D"left"><p><code>segregateattributes</code></p></td>
> +<td align=3D"left"><p>The <code>segregateattributes</code> keyword.</p><=
/td>
> +</tr>
> +<tr class=3D"even">
> +<td align=3D"left"><p><code>typeattribute_id</code></p></td>
> +<td align=3D"left"><p>At least two previously declared <code>typeattribu=
te</code> identifier.</p>
> +<p>Note that the same <code>typeattribute</code> identifier must not be =
repeated.</p></td>
> +</tr>
> +</tbody>
> +</table>
> +
> +**Example:**
> +
> +This example will not compile as `type_1` is associated with type attrib=
utes `attr_1` and `attr_2`:
> +
> +```secil
> +    (type type_1)
> +    (typeattribute attr_1)
> +    (typeattribute attr_2)
> +    (typeattributeset attr_1 (type_1))
> +    (typeattributeset attr_2 (type_1))
> +    (segregateattributes (attr_1 attr_2))
> +```
> --
> 2.36.1
>
