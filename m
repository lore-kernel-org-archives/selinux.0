Return-Path: <SRS0=5MQ6=4I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0553EC11D0B
	for <selinux@archiver.kernel.org>; Thu, 20 Feb 2020 14:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D8B208C4
	for <selinux@archiver.kernel.org>; Thu, 20 Feb 2020 14:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTl83E1O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgBTOS2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:18:28 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25906 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727088AbgBTOS2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Feb 2020 09:18:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582208307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ac2g7hAD+AQr0gQciFmmqx38muA8AwHuAOSZEwQQ76c=;
        b=WTl83E1Oyob8BRD2Q3ih0W6NZz3UMBuX6lU3cBeZoMgqbtE0rGp4Gvgapy62p4DyHrrZaC
        5PLkjpcclxnjSq12tazI33f1dVwm7FVN0OXA32+YeKyiwdPeTLfnluO3th2orwzPfCHL5J
        DSFotMgoOpABk64UpKVpirPUVwOqikc=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-c5iDB357MZ2U4n4f3cdOgQ-1; Thu, 20 Feb 2020 09:18:25 -0500
X-MC-Unique: c5iDB357MZ2U4n4f3cdOgQ-1
Received: by mail-ot1-f72.google.com with SMTP id 39so2196549otb.8
        for <selinux@vger.kernel.org>; Thu, 20 Feb 2020 06:18:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ac2g7hAD+AQr0gQciFmmqx38muA8AwHuAOSZEwQQ76c=;
        b=hifEZ1sKjxBEejMRi0JjBz2DWKlH7xUPks6bg0aTqPB5RWxvOXf5ler21oKKUifKhs
         YQiAXhTWdtTfbAtz3fWtJ3gTglrQowVg4kULkU/Vlo6ZKlC8aELQcrvgeT75qJfirR+B
         kD6gkHFJyjoyZCSFKdj52pK6qUZ6YciteLSikoDeTZTk7eEV0Ai4Pkqp8u6Sge0kUuJ9
         TkE1G3jv4VYqw3eNA3sC7anIoeSksBRAo5cu/iyBTs8CAvLjOusZFih+C1VmgG3oVj6H
         G8jpI4hdNQ8yI/r1dsxlInnhWZKc876wfF9N6+hGX1YSVH2SkQWsyF6wd0gPZq12dnCU
         8oNg==
X-Gm-Message-State: APjAAAUCDLgsjGX8ztgvPhE8BK/XjXcRr17MtQTNKNbd4UKqqlTq1lEf
        aCIaZmZbxgGVZ2jrbdzghvYA17kImsnpETwydhWCOhEzDbJnaf0Qe7jJiqibo5uZNrFT4qX4gUJ
        7kMgC6n6VyeYLogFtZ4fDhrQY/wAF3zvEbg==
X-Received: by 2002:aca:1108:: with SMTP id 8mr2176411oir.127.1582208303911;
        Thu, 20 Feb 2020 06:18:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqynB2aAZBE8MYwTw1+Aqnk9PKvSypzpEk+nM45VQh0d/fWU6PdWtRNwCloI20meq/JOASMnEjC0uMmK9uczilA=
X-Received: by 2002:aca:1108:: with SMTP id 8mr2176387oir.127.1582208303575;
 Thu, 20 Feb 2020 06:18:23 -0800 (PST)
MIME-Version: 1.0
References: <20200219163625.19834-1-jwcart2@tycho.nsa.gov>
In-Reply-To: <20200219163625.19834-1-jwcart2@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 20 Feb 2020 15:18:12 +0100
Message-ID: <CAFqZXNus8XTpuUTLXVvsFzLEMELmHvgKFS9sk5Lgg7CsRDA8bg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Create the macro ebitmap_is_empty() and use it
 where needed
To:     James Carter <jwcart2@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 19, 2020 at 5:35 PM James Carter <jwcart2@tycho.nsa.gov> wrote:
> Create the macro ebitmap_is_empty() to check if an ebitmap is empty.
> Use ebitmap_is_empty(), instead of ebitmap_cardinality() or
> ebitmap_length(), to check whether or not an ebitmap is empty.
>
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
> ---
>  libsepol/include/sepol/policydb/ebitmap.h |  1 +
>  libsepol/src/assertion.c                  | 12 ++++++------
>  libsepol/src/expand.c                     |  2 +-
>  libsepol/src/kernel_to_cil.c              | 10 +++++-----
>  libsepol/src/kernel_to_conf.c             |  8 ++++----
>  libsepol/src/module_to_cil.c              | 22 +++++++++++-----------
>  6 files changed, 28 insertions(+), 27 deletions(-)
>
[...]
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index ca2e4a9b..f1618ff0 100644
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
> +               if (types && (!ebitmap_is_empty(types))) {

You can drop the extra parentheses here.

>                         rc = strs_init(&type_strs, pdb->p_types.nprim);
>                         if (rc != 0) {
>                                 goto exit;
> @@ -2373,7 +2373,7 @@ static int write_user_decl_rules_to_cil(FILE *out, struct policydb *pdb)
>                 }
>
>                 roles = &user->roles.roles;
> -               if (roles && (ebitmap_cardinality(roles) > 0)) {
> +               if (roles && (!ebitmap_is_empty(roles))) {

Same here.

>                         rc = strs_init(&role_strs, pdb->p_roles.nprim);
>                         if (rc != 0) {
>                                 goto exit;
[...]

Thanks,

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

