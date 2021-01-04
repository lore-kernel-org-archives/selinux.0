Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DE3C433DB
	for <selinux@archiver.kernel.org>; Mon,  4 Jan 2021 18:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B81F21D1B
	for <selinux@archiver.kernel.org>; Mon,  4 Jan 2021 18:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbhADSSP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Jan 2021 13:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbhADSSP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Jan 2021 13:18:15 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC22FC061794
        for <selinux@vger.kernel.org>; Mon,  4 Jan 2021 10:17:34 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id q25so33097924oij.10
        for <selinux@vger.kernel.org>; Mon, 04 Jan 2021 10:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z+pNX4ZMawM+sYKu3Re6gP6+wefe41hBLIV8CZOEHV4=;
        b=WheUrIlVRFpOGqNbbDW1hPIUcE+fMIfHxgdwGnRekMlVjQP+QYRS/nc2Nt7L6HGqfu
         +c+maDaFp/lywEcvG6JW2mlzeJ5k0ric3THGn12n/iRC3XwEIYrS5bHx5bByNkNfLmVk
         /YAth03FNy7PT75IN1j9Qwj3chyG7qDZtS48dKytX6u7EHkYmJK79VU3GGCm647hWIrS
         9isTVnhi21RhG7bjLwJ/wl+vBhU2Txm2/xfacRKxr/2v+sYIMtC2kcne+AH2UbKdM4sC
         OoKvwSMH213Ey2torQBRdYrCTWNM4Y12sxjZyLjBcwYpt70bVeugkNWJbmI59nJ4bzIz
         +j1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z+pNX4ZMawM+sYKu3Re6gP6+wefe41hBLIV8CZOEHV4=;
        b=hLfA3oEg9dXBVEckyleI70iW/mF9kPCiMZUDX5FeX7QSR1z6u5tKAhFgtKAmuhJAde
         HfJfHDr2YOc6VXli8PH2ZJkz6lhBLumqFr/rlngsHspaSjOeZjtaIjP064TJ3wzOvs0m
         Btjm+KdDs8bBLKOHDVCzWYRibvzVNyiA4eDuT6/mS9cWqiG3cm/6ck0dIkaV9Tt/eyr2
         HNYb3+o1LE1ULZSXZ4IA/nfSQ4CDIB6VeQgVQhFkz+8ZrfOp8GaruD0XAQf6mpQ/K5jZ
         vawH5SV8sJ5voUz/uD0CEKCRBI+TfcGyc39miwkNLbaZt3tsKuUJwECVMllAyvFijiSs
         gSrQ==
X-Gm-Message-State: AOAM531H7Xxyd/I6JJUg5aqDuICDsMizQVCtLKOZHmPPL3uk+NGiUvDQ
        7X0rqVy1ckTOwp5POGqzHhDojtUfszWQG2j/8RaalxGirCQ=
X-Google-Smtp-Source: ABdhPJxMBnryamLIowFa//FL4oKS0yRqf0WGrdRQgKCesimNd3kkBkfOZsE38YMLkmdblcEgsF+6tWAO/LrybEAouTs=
X-Received: by 2002:a05:6808:49:: with SMTP id v9mr123438oic.138.1609784254336;
 Mon, 04 Jan 2021 10:17:34 -0800 (PST)
MIME-Version: 1.0
References: <20201230100746.2549568-1-nicolas.iooss@m4x.org> <20201230100746.2549568-5-nicolas.iooss@m4x.org>
In-Reply-To: <20201230100746.2549568-5-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 4 Jan 2021 13:17:23 -0500
Message-ID: <CAP+JOzQ0g_3vQxfhK02hbFKtqVSE89HrD__LJcxESGux-UsMKQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] libsepol/cil: fix out-of-bound read in cil_print_recursive_blockinherit
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 30, 2020 at 5:09 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> OSS-Fuzz found a heap buffer overflow (out-of-bound reads) when the CIL
> compiler tries to report a recursive blockinherit with an optional
> block:
>
>     $ echo '(block b (optional o (blockinherit b)))' > tmp.cil
>     $ secilc tmp.cil
>     Segmentation fault (core dumped)
>
> This is because cil_print_recursive_blockinherit() assumes that all
> nodes are either CIL_BLOCK or CIL_BLOCKINHERIT. Add support for other
> block kinds, using cil_node_to_string() to show them.
>
> Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28462
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_resolve_ast.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index f6deb1002fbd..ecd05dfa5dab 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -2343,11 +2343,13 @@ void cil_print_recursive_blockinherit(struct cil_tree_node *bi_node, struct cil_
>         for (curr = bi_node; curr != terminating_node; curr = curr->parent) {
>                 if (curr->flavor == CIL_BLOCK) {
>                         cil_list_prepend(trace, CIL_NODE, curr);
> -               } else {
> +               } else if (curr->flavor == CIL_BLOCKINHERIT) {
>                         if (curr != bi_node) {
>                                 cil_list_prepend(trace, CIL_NODE, NODE(((struct cil_blockinherit *)curr->data)->block));
>                         }
>                         cil_list_prepend(trace, CIL_NODE, curr);
> +               } else {
> +                       cil_list_prepend(trace, CIL_NODE, curr);
>                 }
>         }
>         cil_list_prepend(trace, CIL_NODE, terminating_node);
> @@ -2356,8 +2358,12 @@ void cil_print_recursive_blockinherit(struct cil_tree_node *bi_node, struct cil_
>                 curr = item->data;
>                 if (curr->flavor == CIL_BLOCK) {
>                         cil_tree_log(curr, CIL_ERR, "block %s", DATUM(curr->data)->name);
> -               } else {
> +               } else if (curr->flavor == CIL_BLOCKINHERIT) {
>                         cil_tree_log(curr, CIL_ERR, "blockinherit %s", ((struct cil_blockinherit *)curr->data)->block_str);
> +               } else if (curr->flavor == CIL_OPTIONAL) {
> +                       cil_tree_log(curr, CIL_ERR, "optional %s", DATUM(curr->data)->name);
> +               } else {
> +                       cil_tree_log(curr, CIL_ERR, "%s", cil_node_to_string(curr));
>                 }
>         }
>
> --
> 2.29.2
>
