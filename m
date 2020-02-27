Return-Path: <SRS0=cYHv=4P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD667C4BA24
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 08:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9C3222C2
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 08:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QWdQUsdQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgB0Ibm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Feb 2020 03:31:42 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23267 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbgB0Ibl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Feb 2020 03:31:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582792299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZqowFMhlgZTBOJnzKULiSj/uOrhco013FIX+x7Xyygg=;
        b=QWdQUsdQbeVABe/2gCFyj3Bv9tVH0n3UCsdEl+T4yJlyBVE95T1Nmt9FDTLFs0spvCHGPv
        VltiX+ps/O3nDwukjQSr+00/IY4TKNEKUr6KXnEaqiGBOWmglcuUjdcKzw34AMFtztFfoc
        aRWsrbjRpbFAf20kKRXnZP6+O7zZdqM=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-qLk_ZnJpNFeDLXqU29ZD4w-1; Thu, 27 Feb 2020 03:31:38 -0500
X-MC-Unique: qLk_ZnJpNFeDLXqU29ZD4w-1
Received: by mail-ot1-f71.google.com with SMTP id z20so1212544otm.3
        for <selinux@vger.kernel.org>; Thu, 27 Feb 2020 00:31:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZqowFMhlgZTBOJnzKULiSj/uOrhco013FIX+x7Xyygg=;
        b=rr1uNIAKS+4gDceclbWL4IiAYVz1xHHHHtP9lQuVOkZ9MEU7o89bpIE/8QMcdjrOjh
         7qmm31iBuuksJhb7xw+7m66E28XdMC/CJXSfteMEhkmMGKtqBup0IOj12JAqswERtU6n
         728eAIsqdMVywxQp3OEZpB/xQMo0kKnrWznhLbmYgWqu8gkuZ7bxPtjqEI5oK2gw+FcE
         HXAP1POStEM+drSEGaTFwa8LnnVnc4nB85wmPKhadH7WRk9Gt3/+2FQHNJo7/p9BgKC1
         XF+Oowdys07nuFd4FFRC2QEeBjCUfa4k3EgrEciOpwVrJGNGe/R9VYIuCk4Iaam6u/qF
         kr1A==
X-Gm-Message-State: APjAAAVaaWGCtNNHFFyhAUCmAMqWLg2u05x9aCouBnPd4SupinffjrKX
        Q1NTIiyhQTQv0IWAOngPvWRjRFbOrBHd4avUEAnZZL+gT1FCcD2d/jleskE5Yx4WSPQvoGp/r3F
        Jrs06uaeCp6Tjz6Pzd6DE3MKI1wjH40aV8w==
X-Received: by 2002:aca:c3c2:: with SMTP id t185mr2466310oif.26.1582792296922;
        Thu, 27 Feb 2020 00:31:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqyHnbRQ6b4oLdpQVu1WDe/h00WWfIaDR7I1RGhprxIZqpyalUb0JYYsAqGnAqawdFKgnkCCW1XxxSH5Nz7vzg8=
X-Received: by 2002:aca:c3c2:: with SMTP id t185mr2466290oif.26.1582792296516;
 Thu, 27 Feb 2020 00:31:36 -0800 (PST)
MIME-Version: 1.0
References: <20200226191659.6552-1-jwcart2@gmail.com>
In-Reply-To: <20200226191659.6552-1-jwcart2@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 27 Feb 2020 09:31:26 +0100
Message-ID: <CAFqZXNukDbprW41R_Hhb2HTXdunDq47eQikBt7FaygFHuz-63w@mail.gmail.com>
Subject: Re: [PATCH V2] libsepol: Create the macro ebitmap_is_empty() and use
 it where needed
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 26, 2020 at 8:17 PM James Carter <jwcart2@gmail.com> wrote:
> Create the macro ebitmap_is_empty() to check if an ebitmap is empty.
> Use ebitmap_is_empty(), instead of ebitmap_cardinality() or
> ebitmap_length(), to check whether or not an ebitmap is empty.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

Thank you!

> ---
> V2: Removed unnecessary parentheses
>
>  libsepol/include/sepol/policydb/ebitmap.h |  1 +
>  libsepol/src/assertion.c                  | 12 ++++++------
>  libsepol/src/expand.c                     |  2 +-
>  libsepol/src/kernel_to_cil.c              | 10 +++++-----
>  libsepol/src/kernel_to_conf.c             |  8 ++++----
>  libsepol/src/module_to_cil.c              | 22 +++++++++++-----------
>  6 files changed, 28 insertions(+), 27 deletions(-)
>
> diff --git a/libsepol/include/sepol/policydb/ebitmap.h b/libsepol/include/sepol/policydb/ebitmap.h
> index 53fafdaa..1abfdd71 100644
> --- a/libsepol/include/sepol/policydb/ebitmap.h
> +++ b/libsepol/include/sepol/policydb/ebitmap.h
> @@ -40,6 +40,7 @@ typedef struct ebitmap {
>         unsigned int cardinality;       /* cached value of cardinality */
>  } ebitmap_t;
>
> +#define ebitmap_is_empty(e) (((e)->highbit) == 0)
>  #define ebitmap_length(e) ((e)->highbit)
>  #define ebitmap_startbit(e) ((e)->node ? (e)->node->startbit : 0)
>  #define ebitmap_startnode(e) ((e)->node)
> diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
> index 1181edc2..266f67d7 100644
> --- a/libsepol/src/assertion.c
> +++ b/libsepol/src/assertion.c
> @@ -234,7 +234,7 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
>         if (rc)
>                 goto oom;
>
> -       if (ebitmap_length(&src_matches) == 0)
> +       if (ebitmap_is_empty(&src_matches))
>                 goto exit;
>
>         rc = ebitmap_and(&tgt_matches, &avrule->ttypes.types, &p->attr_type_map[k->target_type -1]);
> @@ -249,14 +249,14 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
>                 if (rc)
>                         goto oom;
>
> -               if (ebitmap_length(&self_matches) > 0) {
> +               if (!ebitmap_is_empty(&self_matches)) {
>                         rc = ebitmap_union(&tgt_matches, &self_matches);
>                         if (rc)
>                                 goto oom;
>                 }
>         }
>
> -       if (ebitmap_length(&tgt_matches) == 0)
> +       if (ebitmap_is_empty(&tgt_matches))
>                 goto exit;
>
>         for (cp = avrule->perms; cp; cp = cp->next) {
> @@ -394,7 +394,7 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
>         if (rc)
>                 goto oom;
>
> -       if (ebitmap_length(&src_matches) == 0)
> +       if (ebitmap_is_empty(&src_matches))
>                 goto exit;
>
>         rc = ebitmap_and(&tgt_matches, &avrule->ttypes.types,
> @@ -411,14 +411,14 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
>                 if (rc)
>                         goto oom;
>
> -               if (ebitmap_length(&self_matches) > 0) {
> +               if (!ebitmap_is_empty(&self_matches)) {
>                         rc = ebitmap_union(&tgt_matches, &self_matches);
>                         if (rc)
>                                 goto oom;
>                 }
>         }
>
> -       if (ebitmap_length(&tgt_matches) == 0)
> +       if (ebitmap_is_empty(&tgt_matches))
>                 goto exit;
>
>         for (cp = avrule->perms; cp; cp = cp->next) {
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 5738b598..529e1d35 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -2504,7 +2504,7 @@ int type_set_expand(type_set_t * set, ebitmap_t * t, policydb_t * p,
>         unsigned int i;
>         ebitmap_t types, neg_types;
>         ebitmap_node_t *tnode;
> -       unsigned char expand = alwaysexpand || ebitmap_length(&set->negset) || set->flags;
> +       unsigned char expand = alwaysexpand || !ebitmap_is_empty(&set->negset) || set->flags;
>         type_datum_t *type;
>         int rc =-1;
>
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index ca2e4a9b..89933807 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -1101,7 +1101,7 @@ static int write_sensitivitycategory_rules_to_cil(FILE *out, struct policydb *pd
>                 }
>                 if (level->isalias) continue;
>
> -               if (ebitmap_cardinality(&level->level->cat) > 0) {
> +               if (!ebitmap_is_empty(&level->level->cat)) {
>                         cats = cats_ebitmap_to_str(&level->level->cat, pdb->p_cat_val_to_name);
>                         sepol_printf(out, "(sensitivitycategory %s %s)\n", name, cats);
>                         free(cats);
> @@ -1502,7 +1502,7 @@ static int write_type_attribute_sets_to_cil(FILE *out, struct policydb *pdb)
>                 if (attr->flavor != TYPE_ATTRIB) continue;
>                 name = pdb->p_type_val_to_name[i];
>                 typemap = &pdb->attr_type_map[i];
> -               if (ebitmap_cardinality(typemap) == 0) continue;
> +               if (ebitmap_is_empty(typemap)) continue;
>                 types = ebitmap_to_str(typemap, pdb->p_type_val_to_name, 1);
>                 if (!types) {
>                         rc = -1;
> @@ -1879,7 +1879,7 @@ static char *level_to_str(struct policydb *pdb, struct mls_level *level)
>         char *sens_str = pdb->p_sens_val_to_name[level->sens - 1];
>         char *cats_str;
>
> -       if (ebitmap_cardinality(cats) > 0) {
> +       if (!ebitmap_is_empty(cats)) {
>                 cats_str = cats_ebitmap_to_str(cats, pdb->p_cat_val_to_name);
>                 level_str = create_str("(%s %s)", 2, sens_str, cats_str);
>                 free(cats_str);
> @@ -2188,7 +2188,7 @@ static int write_role_decl_rules_to_cil(FILE *out, struct policydb *pdb)
>                         goto exit;
>                 }
>                 types = &role->types.types;
> -               if (types && (ebitmap_cardinality(types) > 0)) {
> +               if (types && !ebitmap_is_empty(types)) {
>                         rc = strs_init(&type_strs, pdb->p_types.nprim);
>                         if (rc != 0) {
>                                 goto exit;
> @@ -2373,7 +2373,7 @@ static int write_user_decl_rules_to_cil(FILE *out, struct policydb *pdb)
>                 }
>
>                 roles = &user->roles.roles;
> -               if (roles && (ebitmap_cardinality(roles) > 0)) {
> +               if (roles && !ebitmap_is_empty(roles)) {
>                         rc = strs_init(&role_strs, pdb->p_roles.nprim);
>                         if (rc != 0) {
>                                 goto exit;
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
> index b4966162..b96a9b76 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -1090,7 +1090,7 @@ static int write_level_rules_to_conf(FILE *out, struct policydb *pdb)
>                 }
>                 if (level->isalias) continue;
>
> -               if (ebitmap_cardinality(&level->level->cat) > 0) {
> +               if (!ebitmap_is_empty(&level->level->cat)) {
>                         cats = cats_ebitmap_to_str(&level->level->cat, pdb->p_cat_val_to_name);
>                         sepol_printf(out, "level %s:%s;\n", name, cats);
>                         free(cats);
> @@ -1859,7 +1859,7 @@ static char *level_to_str(struct policydb *pdb, struct mls_level *level)
>         char *sens_str = pdb->p_sens_val_to_name[level->sens - 1];
>         char *cats_str;
>
> -       if (ebitmap_cardinality(cats) > 0) {
> +       if (!ebitmap_is_empty(cats)) {
>                 cats_str = cats_ebitmap_to_str(cats, pdb->p_cat_val_to_name);
>                 level_str = create_str("%s:%s", 2, sens_str, cats_str);
>                 free(cats_str);
> @@ -2145,7 +2145,7 @@ static int write_role_decl_rules_to_conf(FILE *out, struct policydb *pdb)
>                         rc = -1;
>                         goto exit;
>                 }
> -               if (ebitmap_cardinality(&role->types.types) == 0) continue;
> +               if (ebitmap_is_empty(&role->types.types)) continue;
>                 types = ebitmap_to_str(&role->types.types, pdb->p_type_val_to_name, 1);
>                 if (!types) {
>                         rc = -1;
> @@ -2298,7 +2298,7 @@ static int write_user_decl_rules_to_conf(FILE *out, struct policydb *pdb)
>                 }
>                 sepol_printf(out, "user %s", name);
>
> -               if (ebitmap_cardinality(&user->roles.roles) > 0) {
> +               if (!ebitmap_is_empty(&user->roles.roles)) {
>                         roles = ebitmap_to_str(&user->roles.roles,
>                                                pdb->p_role_val_to_name, 1);
>                         if (!roles) {
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index e20c3d44..6fe7d336 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -829,8 +829,8 @@ static int cil_print_attr_strs(int indent, struct policydb *pdb, int is_type, vo
>                 pos = &ts->types;
>                 neg = &ts->negset;
>                 flags = ts->flags;
> -               has_positive = pos && (ebitmap_length(pos) > 0);
> -               has_negative = neg && (ebitmap_length(neg) > 0);
> +               has_positive = pos && !ebitmap_is_empty(pos);
> +               has_negative = neg && !ebitmap_is_empty(neg);
>         } else {
>                 kind = "role";
>                 val_to_name = pdb->p_role_val_to_name;
> @@ -838,7 +838,7 @@ static int cil_print_attr_strs(int indent, struct policydb *pdb, int is_type, vo
>                 pos = &rs->roles;
>                 neg = NULL;
>                 flags = rs->flags;
> -               has_positive = pos && (ebitmap_length(pos) > 0);
> +               has_positive = pos && !ebitmap_is_empty(pos);
>                 has_negative = 0;
>         }
>
> @@ -1056,7 +1056,7 @@ static int process_typeset(struct policydb *pdb, struct type_set *ts, struct lis
>         *names = NULL;
>         *num_names = 0;
>
> -       if (ebitmap_length(&ts->negset) > 0 || ts->flags != 0) {
> +       if (!ebitmap_is_empty(&ts->negset) || ts->flags != 0) {
>                 rc = set_to_names(pdb, 1, ts, attr_list, names, num_names);
>                 if (rc != 0) {
>                         goto exit;
> @@ -2069,7 +2069,7 @@ static int class_order_to_cil(int indent, struct policydb *pdb, struct ebitmap o
>         struct ebitmap_node *node;
>         uint32_t i;
>
> -       if (ebitmap_cardinality(&order) == 0) {
> +       if (ebitmap_is_empty(&order)) {
>                 return 0;
>         }
>
> @@ -2175,7 +2175,7 @@ static int role_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
>                         cil_println(indent, "(roleattribute %s)", key);
>                 }
>
> -               if (ebitmap_cardinality(&role->roles) > 0) {
> +               if (!ebitmap_is_empty(&role->roles)) {
>                         cil_indent(indent);
>                         cil_printf("(roleattributeset %s (", key);
>                         ebitmap_for_each_positive_bit(&role->roles, node, i) {
> @@ -2269,7 +2269,7 @@ static int type_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
>                         cil_printf(")\n");
>                 }
>
> -               if (ebitmap_cardinality(&type->types) > 0) {
> +               if (!ebitmap_is_empty(&type->types)) {
>                         cil_indent(indent);
>                         cil_printf("(typeattributeset %s (", key);
>                         ebitmap_to_cil(pdb, &type->types, SYM_TYPES);
> @@ -2372,7 +2372,7 @@ static int sens_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
>                 }
>         }
>
> -       if (ebitmap_cardinality(&level->level->cat) > 0) {
> +       if (!ebitmap_is_empty(&level->level->cat)) {
>                 cil_indent(indent);
>                 cil_printf("(sensitivitycategory %s (", key);
>                 ebitmap_to_cil(pdb, &level->level->cat, SYM_CATS);
> @@ -2387,7 +2387,7 @@ static int sens_order_to_cil(int indent, struct policydb *pdb, struct ebitmap or
>         struct ebitmap_node *node;
>         uint32_t i;
>
> -       if (ebitmap_cardinality(&order) == 0) {
> +       if (ebitmap_is_empty(&order)) {
>                 return 0;
>         }
>
> @@ -2427,7 +2427,7 @@ static int cat_order_to_cil(int indent, struct policydb *pdb, struct ebitmap ord
>         struct ebitmap_node *node;
>         uint32_t i;
>
> -       if (ebitmap_cardinality(&order) == 0) {
> +       if (ebitmap_is_empty(&order)) {
>                 rc = 0;
>                 goto exit;
>         }
> @@ -2478,7 +2478,7 @@ static int level_to_cil(struct policydb *pdb, struct mls_level *level)
>
>         cil_printf("(%s", pdb->p_sens_val_to_name[level->sens - 1]);
>
> -       if (ebitmap_cardinality(map) > 0) {
> +       if (!ebitmap_is_empty(map)) {
>                 cil_printf("(");
>                 ebitmap_to_cil(pdb, map, SYM_CATS);
>                 cil_printf(")");
> --
> 2.17.1

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

