Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96676C48BC2
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 20:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F2E46108E
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 20:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFUU7M (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jun 2021 16:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhFUU7M (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Jun 2021 16:59:12 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12BAC061574
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 13:56:57 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id d19so21373985oic.7
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 13:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jfv0Sn7gTaNSfKvuluP2ulz9VHEy/9MyjmV/l1y0fbE=;
        b=dVJDuhXwPKCDw0KHj3BAs2usbRP4VUqc27EVRpK5iJMMIhS9Q+gJSmpA07S8SZlHyh
         yhPZe/kivVmHo8Wl2ADEQ882C+4f/LHNsG5NlVQTpXw9wjL3GSM/xLUuAVgtvmq6LKuT
         p0WIByUwpfATfvgAjbZ2jm6AlIW2OlzIZo7iE5B0Ml/gfraE4PyRBLaZk6Q1Cf4qTgRX
         1jB5GcIjxV90cMKaZsM8wdqPPp8qdPDeBpmtd3ywgmZIiM0vwzvXRZ7DRLoxN/WD7rI8
         rAf6mmcZmQUJ97PPuCsM2i97Bq3/T0rRYwu7cyQE5F4iRS/zYsRgBXx3+Dic3OfcljUN
         Mf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jfv0Sn7gTaNSfKvuluP2ulz9VHEy/9MyjmV/l1y0fbE=;
        b=a6895tVUd2JAMN83HEoZeHyeA8mUktRMhiyPI3wltY88ozRS+s9zYCw5iNAjHaob87
         PNNkvRH99mKeGgxwuuIgkqJ/sNRuVz3Pkhx5+Nss4ZMQdiNfLHko3M3I5Xk0tJtgsjno
         Tyw+8Ytt6bu7APdDEfc7jATj6vEOBKqwA8WciGDXWJ++EbReEovLOgdA1KmvVJguoW0u
         CzzAGoWSvG3u3JSWYQORAmRYU54KKM6hA50gueOVnI7X6PgV8ThAKA7m1uTy3KrPx5eh
         ujtNvfEdVXnHF0MwgxDnG/3HV+rDrxTN4oYz6DEEBpccd2A9iygjcYjpAkO2Phagf4SC
         X6ow==
X-Gm-Message-State: AOAM533g2wt7po7DO5IwqCLWHyfLlRfGaTTJftyI2y8RWbqFzbB6oybS
        HLMh6i8PNeHLdY9VxL8C93JjvQzwGeIUvst3LvQ=
X-Google-Smtp-Source: ABdhPJxcmhrQBgQn1lxaI5YTnHF1Lat+gtzTBf35NbJo0kJ7bYuRHBlcGCjMHm74P3Lva7OKkUuGJEDW8OFy/dmFA9k=
X-Received: by 2002:aca:1c0d:: with SMTP id c13mr288721oic.128.1624309017035;
 Mon, 21 Jun 2021 13:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210608155912.32047-1-cgzones@googlemail.com> <20210608155912.32047-9-cgzones@googlemail.com>
In-Reply-To: <20210608155912.32047-9-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 21 Jun 2021 16:56:46 -0400
Message-ID: <CAP+JOzRpK_CXtqvGSdu0WmGH56pjBaVK2hibcRmvnzkHx0xu8A@mail.gmail.com>
Subject: Re: [PATCH 08/23] libsepol/cil: follow declaration-after-statement
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 8, 2021 at 12:01 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Follow the project style of no declaration after statement.
>
> Found by the gcc warning -Wdeclaration-after-statement
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_binary.c      | 5 +++--
>  libsepol/cil/src/cil_build_ast.c   | 5 +++--
>  libsepol/cil/src/cil_fqn.c         | 3 ++-
>  libsepol/cil/src/cil_list.c        | 7 ++++---
>  libsepol/cil/src/cil_post.c        | 2 +-
>  libsepol/cil/src/cil_resolve_ast.c | 6 +++---
>  libsepol/cil/src/cil_strpool.c     | 3 ++-
>  7 files changed, 18 insertions(+), 13 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.=
c
> index 18532aad..85094b01 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -593,11 +593,11 @@ exit:
>  int __cil_typeattr_bitmap_init(policydb_t *pdb)
>  {
>         int rc =3D SEPOL_ERR;
> +       uint32_t i;
>
>         pdb->type_attr_map =3D cil_malloc(pdb->p_types.nprim * sizeof(ebi=
tmap_t));
>         pdb->attr_type_map =3D cil_malloc(pdb->p_types.nprim * sizeof(ebi=
tmap_t));
>
> -       uint32_t i =3D 0;
>         for (i =3D 0; i < pdb->p_types.nprim; i++) {
>                 ebitmap_init(&pdb->type_attr_map[i]);
>                 ebitmap_init(&pdb->attr_type_map[i]);
> @@ -2657,6 +2657,7 @@ int __cil_constrain_expr_to_sepol_expr_helper(polic=
ydb_t *pdb, const struct cil_
>         int rc =3D SEPOL_ERR;
>         struct cil_list_item *item;
>         enum cil_flavor flavor;
> +       enum cil_flavor cil_op;
>         constraint_expr_t *op, *h1, *h2, *t1, *t2;
>         int is_leaf =3D CIL_FALSE;
>
> @@ -2673,7 +2674,7 @@ int __cil_constrain_expr_to_sepol_expr_helper(polic=
ydb_t *pdb, const struct cil_
>                 goto exit;
>         }
>
> -       enum cil_flavor cil_op =3D (enum cil_flavor)(uintptr_t)item->data=
;
> +       cil_op =3D (enum cil_flavor)(uintptr_t)item->data;
>         switch (cil_op) {
>         case CIL_NOT:
>                 op->expr_type =3D CEXPR_NOT;
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_buil=
d_ast.c
> index 42d10c87..9a9bc598 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -5173,6 +5173,7 @@ int cil_gen_macro(struct cil_db *db, struct cil_tre=
e_node *parse_current, struct
>         char *key =3D NULL;
>         struct cil_macro *macro =3D NULL;
>         struct cil_tree_node *macro_content =3D NULL;
> +       struct cil_tree_node *current_item;
>         enum cil_syntax syntax[] =3D {
>                 CIL_SYN_STRING,
>                 CIL_SYN_STRING,
> @@ -5195,7 +5196,7 @@ int cil_gen_macro(struct cil_db *db, struct cil_tre=
e_node *parse_current, struct
>
>         key =3D parse_current->next->data;
>
> -       struct cil_tree_node *current_item =3D parse_current->next->next-=
>cl_head;
> +       current_item =3D parse_current->next->next->cl_head;
>         while (current_item !=3D NULL) {
>                 enum cil_syntax param_syntax[] =3D {
>                         CIL_SYN_STRING,
> @@ -5205,6 +5206,7 @@ int cil_gen_macro(struct cil_db *db, struct cil_tre=
e_node *parse_current, struct
>                 int param_syntax_len =3D sizeof(param_syntax)/sizeof(*par=
am_syntax);
>                 char *kind =3D NULL;
>                 struct cil_param *param =3D NULL;
> +               struct cil_list_item *curr_param;
>
>                 rc =3D__cil_verify_syntax(current_item->cl_head, param_sy=
ntax, param_syntax_len);
>                 if (rc !=3D SEPOL_OK) {
> @@ -5263,7 +5265,6 @@ int cil_gen_macro(struct cil_db *db, struct cil_tre=
e_node *parse_current, struct
>                 }
>
>                 //walk current list and check for duplicate parameters
> -               struct cil_list_item *curr_param;
>                 cil_list_for_each(curr_param, macro->params) {
>                         if (param->str =3D=3D ((struct cil_param*)curr_pa=
ram->data)->str) {
>                                 cil_log(CIL_ERR, "Duplicate parameter\n")=
;
> diff --git a/libsepol/cil/src/cil_fqn.c b/libsepol/cil/src/cil_fqn.c
> index 097222a8..46db069b 100644
> --- a/libsepol/cil/src/cil_fqn.c
> +++ b/libsepol/cil/src/cil_fqn.c
> @@ -78,12 +78,13 @@ static int __cil_fqn_qualify_blocks(__attribute__((un=
used)) hashtab_key_t k, has
>         struct cil_tree_node *node =3D NODE(datum);
>         int i;
>         int rc =3D SEPOL_OK;
> +       int newlen;
>
>         if (node->flavor !=3D CIL_BLOCK) {
>                 goto exit;
>         }
>
> -       int newlen =3D fqn_args->len + strlen(datum->name) + 1;
> +       newlen =3D fqn_args->len + strlen(datum->name) + 1;
>         if (newlen >=3D CIL_MAX_NAME_LENGTH) {
>                 cil_log(CIL_INFO, "Fully qualified name for block %s is t=
oo long\n", datum->name);
>                 rc =3D SEPOL_ERR;
> diff --git a/libsepol/cil/src/cil_list.c b/libsepol/cil/src/cil_list.c
> index 4e7843cb..8a426f1f 100644
> --- a/libsepol/cil/src/cil_list.c
> +++ b/libsepol/cil/src/cil_list.c
> @@ -55,15 +55,16 @@ void cil_list_init(struct cil_list **list, enum cil_f=
lavor flavor)
>
>  void cil_list_destroy(struct cil_list **list, unsigned destroy_data)
>  {
> +       struct cil_list_item *item;
> +
>         if (*list =3D=3D NULL) {
>                 return;
>         }
>
> -       struct cil_list_item *item =3D (*list)->head;
> -       struct cil_list_item *next =3D NULL;
> +       item =3D (*list)->head;
>         while (item !=3D NULL)
>         {
> -               next =3D item->next;
> +               struct cil_list_item *next =3D item->next;
>                 if (item->flavor =3D=3D CIL_LIST) {
>                         cil_list_destroy((struct cil_list**)&(item->data)=
, destroy_data);
>                         free(item);
> diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> index 05842b64..7bca0834 100644
> --- a/libsepol/cil/src/cil_post.c
> +++ b/libsepol/cil/src/cil_post.c
> @@ -213,8 +213,8 @@ int cil_post_filecon_compare(const void *a, const voi=
d *b)
>         struct fc_data *a_data =3D cil_malloc(sizeof(*a_data));
>         struct fc_data *b_data =3D cil_malloc(sizeof(*b_data));
>         char *a_path =3D cil_malloc(strlen(a_filecon->path_str) + 1);
> -       a_path[0] =3D '\0';
>         char *b_path =3D cil_malloc(strlen(b_filecon->path_str) + 1);
> +       a_path[0] =3D '\0';
>         b_path[0] =3D '\0';
>         strcat(a_path, a_filecon->path_str);
>         strcat(b_path, b_filecon->path_str);
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_re=
solve_ast.c
> index d8481002..a322b1b7 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -3949,10 +3949,10 @@ int __cil_resolve_ast_node_helper(struct cil_tree=
_node *node, uint32_t *finished
>                 enum cil_log_level lvl =3D CIL_ERR;
>
>                 if (optional !=3D NULL) {
> -                       lvl =3D CIL_INFO;
> -
>                         struct cil_optional *opt =3D (struct cil_optional=
 *)optional->data;
> -                       struct cil_tree_node *opt_node =3D NODE(opt);;
> +                       struct cil_tree_node *opt_node =3D NODE(opt);
> +
> +                       lvl =3D CIL_INFO;
>                         /* disable an optional if something failed to res=
olve */
>                         opt->enabled =3D CIL_FALSE;
>                         cil_tree_log(node, lvl, "Failed to resolve %s sta=
tement", cil_node_to_string(node));
> diff --git a/libsepol/cil/src/cil_strpool.c b/libsepol/cil/src/cil_strpoo=
l.c
> index 2598bbf3..70bca363 100644
> --- a/libsepol/cil/src/cil_strpool.c
> +++ b/libsepol/cil/src/cil_strpool.c
> @@ -75,9 +75,10 @@ char *cil_strpool_add(const char *str)
>
>         strpool_ref =3D hashtab_search(cil_strpool_tab, (hashtab_key_t)st=
r);
>         if (strpool_ref =3D=3D NULL) {
> +               int rc;
>                 strpool_ref =3D cil_malloc(sizeof(*strpool_ref));
>                 strpool_ref->str =3D cil_strdup(str);
> -               int rc =3D hashtab_insert(cil_strpool_tab, (hashtab_key_t=
)strpool_ref->str, strpool_ref);
> +               rc =3D hashtab_insert(cil_strpool_tab, (hashtab_key_t)str=
pool_ref->str, strpool_ref);
>                 if (rc !=3D SEPOL_OK) {
>                         pthread_mutex_unlock(&cil_strpool_mutex);
>                         cil_log(CIL_ERR, "Failed to allocate memory\n");
> --
> 2.32.0
>
