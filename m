Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C88C77B7E
	for <selinux@archiver.kernel.org>; Thu,  1 Jun 2023 21:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjFAVBC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Jun 2023 17:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbjFAVA7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Jun 2023 17:00:59 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCEC1A4
        for <selinux@vger.kernel.org>; Thu,  1 Jun 2023 14:00:55 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2af2602848aso19045641fa.2
        for <selinux@vger.kernel.org>; Thu, 01 Jun 2023 14:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685653254; x=1688245254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWOe9VMJrMG6U7XWjKCkEn4zGdFAwvzc7AQ3Uya88U4=;
        b=ABrVMohgF754ww4zRFgjZyKZ5zj5n5IOD9CbyYhSQoQT4XCYvUxwu77baq9NaC58r6
         q/0IltZD/ehZLC6ridEfxVNtP59p06kOu1vvWd3TAQ5nH1K/UnKXlLAT/P6DBNhoeKEc
         9rdJzKWM9M0QfRvqXTLyeAQiIABWJ8n/o1dsZpEhMlSztHcYBEZl4348QMeiXz7MttTs
         p96lnwmmZjdVjJ85O/THbggJnycy/UFfkCrLwtuJIfLqGJ2ne39APeJKeH0iC+55/eZq
         jcwOFtEofhMkiPf/2VWo3d8Oi6NdwuxY8CREnEs7sTkV1zRM1npZIbj9pYe4qRV8CSLz
         G+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685653254; x=1688245254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWOe9VMJrMG6U7XWjKCkEn4zGdFAwvzc7AQ3Uya88U4=;
        b=W9q9Pavs3Cgyn7oG839/YB6ocpyYg5gQXBRRGYZS0yvn2f6g8co6BB1hygLEwSaA3h
         K/5WSLXwYQvcr/A9/BwduVd0txpHjgP0XWZA2pFLK47f8boKmxVmpATGahISs2z+uxG9
         ZCAviDT2gIHFAFKl7wmkQTLEWZLsE8F6j1mU4+RM7iBcQeIp3K8HX9uix5FJ2YfUoOuP
         G8GHxwRNQ+9PI/YlOTkOcZbLJw/fSYPYL8DDUR/Zl2g5d19xoh1wFNsiWHQH/FR4zqJF
         LYn7ktrwU7CSQ1evLJl5JGT0NXxJRLlCmfYxqeqjeCVn93FVb11Vy9qraSvnE1sK+snw
         me9Q==
X-Gm-Message-State: AC+VfDzMrcjsd3JelAw3JW8dGucU895WLUXq8T55GffL8cdIXYN5TTgU
        6GlTNLE8nWOnl9cyHc0N0faFK7pxrP07F0R9dqQ=
X-Google-Smtp-Source: ACHHUZ7LsMyPOKB7Y7RybfdH7hlh59kipMHSIoUKkmI3LalVsmL4WsamJ09ir1Cf5I59cfo6rXa/hfQ3N0ki+/EDpSw=
X-Received: by 2002:a2e:351a:0:b0:2ac:7ffb:6bda with SMTP id
 z26-20020a2e351a000000b002ac7ffb6bdamr456172ljz.2.1685653253430; Thu, 01 Jun
 2023 14:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230531114914.2237609-1-juraj@jurajmarcin.com> <20230531114914.2237609-9-juraj@jurajmarcin.com>
In-Reply-To: <20230531114914.2237609-9-juraj@jurajmarcin.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 1 Jun 2023 17:00:42 -0400
Message-ID: <CAP+JOzRAGwD0fjuZsim4vgqz+dgOiOtn2vg1uc02_mgXJMULyQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] libsepol/cil: add support for prefix/suffix filename
 transtions to CIL
To:     Juraj Marcin <juraj@jurajmarcin.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 31, 2023 at 7:51=E2=80=AFAM Juraj Marcin <juraj@jurajmarcin.com=
> wrote:
>
> This patch implements the support for prefix/suffix filename transitions
> in CIL structures as well as to CIL policy parser.
>

As for the checkpolicy patch, I would like to see some examples of the
new syntax here.

> Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
> Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
> ---
>  libsepol/cil/src/cil.c             |  8 ++++++++
>  libsepol/cil/src/cil_binary.c      |  8 ++++----
>  libsepol/cil/src/cil_build_ast.c   | 25 +++++++++++++++++++------
>  libsepol/cil/src/cil_copy_ast.c    |  1 +
>  libsepol/cil/src/cil_internal.h    |  5 +++++
>  libsepol/cil/src/cil_policy.c      | 17 ++++++++++++++++-
>  libsepol/cil/src/cil_resolve_ast.c | 10 ++++++++++
>  libsepol/cil/src/cil_write_ast.c   |  2 ++
>  8 files changed, 65 insertions(+), 11 deletions(-)
>
> diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> index 38edcf8e..3b086de9 100644
> --- a/libsepol/cil/src/cil.c
> +++ b/libsepol/cil/src/cil.c
> @@ -95,6 +95,9 @@ char *CIL_KEY_TUNABLEIF;
>  char *CIL_KEY_ALLOW;
>  char *CIL_KEY_DONTAUDIT;
>  char *CIL_KEY_TYPETRANSITION;
> +char *CIL_KEY_MATCH_EXACT;
> +char *CIL_KEY_MATCH_PREFIX;
> +char *CIL_KEY_MATCH_SUFFIX;
>  char *CIL_KEY_TYPECHANGE;
>  char *CIL_KEY_CALL;
>  char *CIL_KEY_TUNABLE;
> @@ -264,6 +267,9 @@ static void cil_init_keys(void)
>         CIL_KEY_ALLOW =3D cil_strpool_add("allow");
>         CIL_KEY_DONTAUDIT =3D cil_strpool_add("dontaudit");
>         CIL_KEY_TYPETRANSITION =3D cil_strpool_add("typetransition");
> +       CIL_KEY_MATCH_EXACT =3D cil_strpool_add("match_exact");
> +       CIL_KEY_MATCH_PREFIX =3D cil_strpool_add("match_prefix");
> +       CIL_KEY_MATCH_SUFFIX =3D cil_strpool_add("match_suffix");

Also, like the checkpolicy patch, I would prefer "exact", "prefix",
and "suffix" unless using those keywords will cause problems.

Thanks,
Jim


>         CIL_KEY_TYPECHANGE =3D cil_strpool_add("typechange");
>         CIL_KEY_CALL =3D cil_strpool_add("call");
>         CIL_KEY_TUNABLE =3D cil_strpool_add("tunable");
> @@ -2387,6 +2393,8 @@ void cil_nametypetransition_init(struct cil_nametyp=
etransition **nametypetrans)
>         (*nametypetrans)->obj =3D NULL;
>         (*nametypetrans)->name_str =3D NULL;
>         (*nametypetrans)->name =3D NULL;
> +       (*nametypetrans)->name_match_str =3D NULL;
> +       (*nametypetrans)->name_match =3D NAME_TRANS_MATCH_EXACT;
>         (*nametypetrans)->result_str =3D NULL;
>         (*nametypetrans)->result =3D NULL;
>  }
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.=
c
> index ffa44be7..ea0cef32 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -1193,7 +1193,7 @@ static int __cil_typetransition_to_avtab_helper(pol=
icydb_t *pdb,
>                                                 type_datum_t *sepol_src,
>                                                 type_datum_t *sepol_tgt,
>                                                 struct cil_list *class_li=
st,
> -                                               char *name,
> +                                               char *name, uint8_t name_=
match,
>                                                 type_datum_t *sepol_resul=
t)
>  {
>         int rc;
> @@ -1211,7 +1211,7 @@ static int __cil_typetransition_to_avtab_helper(pol=
icydb_t *pdb,
>                 avt_key.target_type =3D sepol_tgt->s.value;
>                 avt_key.target_class =3D sepol_obj->s.value;
>                 rc =3D avtab_insert_filename_trans(&pdb->te_avtab, &avt_k=
ey,
> -                       sepol_result->s.value, name, NAME_TRANS_MATCH_EXA=
CT,
> +                       sepol_result->s.value, name, name_match,
>                         &otype);
>                 if (rc !=3D SEPOL_OK) {
>                         if (rc =3D=3D SEPOL_EEXIST) {
> @@ -1280,7 +1280,7 @@ static int __cil_typetransition_to_avtab(policydb_t=
 *pdb, const struct cil_db *d
>
>                         rc =3D __cil_typetransition_to_avtab_helper(
>                                 pdb, sepol_src, sepol_src, class_list,
> -                               name, sepol_result
> +                               name, typetrans->name_match, sepol_result
>                         );
>                         if (rc !=3D SEPOL_OK) goto exit;
>                 }
> @@ -1298,7 +1298,7 @@ static int __cil_typetransition_to_avtab(policydb_t=
 *pdb, const struct cil_db *d
>
>                                 rc =3D __cil_typetransition_to_avtab_help=
er(
>                                         pdb, sepol_src, sepol_tgt, class_=
list,
> -                                       name, sepol_result
> +                                       name, typetrans->name_match, sepo=
l_result
>                                 );
>                                 if (rc !=3D SEPOL_OK) goto exit;
>                         }
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_buil=
d_ast.c
> index 4177c9f6..47513f92 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -3334,10 +3334,11 @@ int cil_gen_typetransition(struct cil_db *db, str=
uct cil_tree_node *parse_curren
>                 CIL_SYN_STRING,
>                 CIL_SYN_STRING,
>                 CIL_SYN_STRING | CIL_SYN_END,
> -               CIL_SYN_END
> +               CIL_SYN_STRING | CIL_SYN_END,
> +               CIL_SYN_END,
>         };
>         size_t syntax_len =3D sizeof(syntax)/sizeof(*syntax);
> -       char *s1, *s2, *s3, *s4, *s5;
> +       char *s1, *s2, *s3, *s4, *s5, *s6;
>
>         if (db =3D=3D NULL || parse_current =3D=3D NULL || ast_node =3D=
=3D NULL ) {
>                 goto exit;
> @@ -3353,16 +3354,27 @@ int cil_gen_typetransition(struct cil_db *db, str=
uct cil_tree_node *parse_curren
>         s3 =3D parse_current->next->next->next->data;
>         s4 =3D parse_current->next->next->next->next->data;
>         s5 =3D NULL;
> +       s6 =3D NULL;
>
>         if (parse_current->next->next->next->next->next) {
>                 if (s4 =3D=3D CIL_KEY_STAR) {
> -                       s4 =3D parse_current->next->next->next->next->nex=
t->data;
> +                       if (parse_current->next->next->next->next->next->=
next) {
> +                               s4 =3D parse_current->next->next->next->n=
ext->next->next->data;
> +                       } else {
> +                               s4 =3D parse_current->next->next->next->n=
ext->next->data;
> +                       }
>                 } else {
> -                       s5 =3D parse_current->next->next->next->next->nex=
t->data;
> +                       if (parse_current->next->next->next->next->next->=
next) {
> +                               s5 =3D parse_current->next->next->next->n=
ext->next->data;
> +                               s6 =3D parse_current->next->next->next->n=
ext->next->next->data;
> +                       } else {
> +                               s5 =3D CIL_KEY_MATCH_EXACT;
> +                               s6 =3D parse_current->next->next->next->n=
ext->next->data;
> +                       }
>                 }
>         }
>
> -       if (s5) {
> +       if (s6) {
>                 struct cil_nametypetransition *nametypetrans =3D NULL;
>
>                 cil_nametypetransition_init(&nametypetrans);
> @@ -3370,8 +3382,9 @@ int cil_gen_typetransition(struct cil_db *db, struc=
t cil_tree_node *parse_curren
>                 nametypetrans->src_str =3D s1;
>                 nametypetrans->tgt_str =3D s2;
>                 nametypetrans->obj_str =3D s3;
> -               nametypetrans->result_str =3D s5;
> +               nametypetrans->result_str =3D s6;
>                 nametypetrans->name_str =3D s4;
> +               nametypetrans->name_match_str =3D s5;
>
>                 ast_node->data =3D nametypetrans;
>                 ast_node->flavor =3D CIL_NAMETYPETRANSITION;
> diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_=
ast.c
> index 17f05021..a2d2fe40 100644
> --- a/libsepol/cil/src/cil_copy_ast.c
> +++ b/libsepol/cil/src/cil_copy_ast.c
> @@ -726,6 +726,7 @@ int cil_copy_nametypetransition(__attribute__((unused=
)) struct cil_db *db, void
>         new->tgt_str =3D orig->tgt_str;
>         new->obj_str =3D orig->obj_str;
>         new->name_str =3D orig->name_str;
> +       new->name_match_str =3D orig->name_match_str;
>         new->result_str =3D orig->result_str;
>
>
> diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_inter=
nal.h
> index a7604762..f7a8d0f7 100644
> --- a/libsepol/cil/src/cil_internal.h
> +++ b/libsepol/cil/src/cil_internal.h
> @@ -112,6 +112,9 @@ extern char *CIL_KEY_TUNABLEIF;
>  extern char *CIL_KEY_ALLOW;
>  extern char *CIL_KEY_DONTAUDIT;
>  extern char *CIL_KEY_TYPETRANSITION;
> +extern char *CIL_KEY_MATCH_EXACT;
> +extern char *CIL_KEY_MATCH_PREFIX;
> +extern char *CIL_KEY_MATCH_SUFFIX;
>  extern char *CIL_KEY_TYPECHANGE;
>  extern char *CIL_KEY_CALL;
>  extern char *CIL_KEY_TUNABLE;
> @@ -575,6 +578,8 @@ struct cil_nametypetransition {
>         struct cil_class *obj;
>         char *name_str;
>         struct cil_name *name;
> +       char *name_match_str;
> +       uint8_t name_match;
>         char *result_str;
>         void *result; /* type or alias */
>
> diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.=
c
> index feb97868..c8253818 100644
> --- a/libsepol/cil/src/cil_policy.c
> +++ b/libsepol/cil/src/cil_policy.c
> @@ -1260,6 +1260,7 @@ static void cil_nametypetransition_to_policy(FILE *=
out, struct cil_nametypetrans
>         struct cil_name *name;
>         struct cil_list *class_list;
>         struct cil_list_item *i1;
> +       const char *name_match_str =3D "";
>
>         src =3D trans->src;
>         tgt =3D trans->tgt;
> @@ -1268,7 +1269,21 @@ static void cil_nametypetransition_to_policy(FILE =
*out, struct cil_nametypetrans
>
>         class_list =3D cil_expand_class(trans->obj);
>         cil_list_for_each(i1, class_list) {
> -               fprintf(out, "type_transition %s %s : %s %s \"%s\";\n", s=
rc->fqn, tgt->fqn, DATUM(i1->data)->fqn, res->fqn, name->datum.fqn);
> +               switch (trans->name_match) {
> +               case NAME_TRANS_MATCH_EXACT:
> +                       name_match_str =3D "";
> +                       break;
> +               case NAME_TRANS_MATCH_PREFIX:
> +                       name_match_str =3D " MATCH_PREFIX";
> +                       break;
> +               case NAME_TRANS_MATCH_SUFFIX:
> +                       name_match_str =3D " MATCH_SUFFIX";
> +                       break;
> +               default:
> +                       name_match_str =3D "???";
> +                       break;
> +               }
> +               fprintf(out, "type_transition %s %s : %s %s \"%s\"%s;\n",=
 src->fqn, tgt->fqn, DATUM(i1->data)->fqn, res->fqn, name->datum.fqn, name_=
match_str);
>         }
>         cil_list_destroy(&class_list, CIL_FALSE);
>  }
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_re=
solve_ast.c
> index d2bfdc81..fbb0fdcc 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -668,6 +668,16 @@ int cil_resolve_nametypetransition(struct cil_tree_n=
ode *current, void *extra_ar
>                 nametypetrans->name =3D (struct cil_name *)name_datum;
>         }
>
> +       if (nametypetrans->name_match_str =3D=3D CIL_KEY_MATCH_EXACT) {
> +               nametypetrans->name_match =3D NAME_TRANS_MATCH_EXACT;
> +       } else if (nametypetrans->name_match_str =3D=3D CIL_KEY_MATCH_PRE=
FIX) {
> +               nametypetrans->name_match =3D NAME_TRANS_MATCH_PREFIX;
> +       } else if (nametypetrans->name_match_str =3D=3D CIL_KEY_MATCH_SUF=
FIX) {
> +               nametypetrans->name_match =3D NAME_TRANS_MATCH_SUFFIX;
> +       } else {
> +               cil_tree_log(current, CIL_ERR, "Invalid name match type \=
"%s\"", nametypetrans->name_match_str);
> +       }
> +
>         rc =3D cil_resolve_name(current, nametypetrans->result_str, CIL_S=
YM_TYPES, extra_args, &result_datum);
>         if (rc !=3D SEPOL_OK) {
>                 goto exit;
> diff --git a/libsepol/cil/src/cil_write_ast.c b/libsepol/cil/src/cil_writ=
e_ast.c
> index b75784ef..d96f6c39 100644
> --- a/libsepol/cil/src/cil_write_ast.c
> +++ b/libsepol/cil/src/cil_write_ast.c
> @@ -1168,6 +1168,8 @@ void cil_write_ast_node(FILE *out, struct cil_tree_=
node *node)
>                 fprintf(out, "%s ", datum_or_str(DATUM(rule->tgt), rule->=
tgt_str));
>                 fprintf(out, "%s ", datum_or_str(DATUM(rule->obj), rule->=
obj_str));
>                 fprintf(out, "\"%s\" ", datum_or_str(DATUM(rule->name), r=
ule->name_str));
> +               if (rule->name_match !=3D NAME_TRANS_MATCH_EXACT)
> +                       fprintf(out, "%s ", rule->name_match_str);
>                 fprintf(out, "%s", datum_or_str(DATUM(rule->result), rule=
->result_str));
>                 fprintf(out, ")\n");
>                 break;
> --
> 2.40.0
>
