Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA605C433E0
	for <selinux@archiver.kernel.org>; Thu, 31 Dec 2020 14:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F83A223E8
	for <selinux@archiver.kernel.org>; Thu, 31 Dec 2020 14:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgLaOqp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Dec 2020 09:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgLaOqp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Dec 2020 09:46:45 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B05C061573
        for <selinux@vger.kernel.org>; Thu, 31 Dec 2020 06:46:05 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id d9so17325947iob.6
        for <selinux@vger.kernel.org>; Thu, 31 Dec 2020 06:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q09e2xRyuSfvXtnOiYjBL+Mh/fSB/3KPylqia1+fqvU=;
        b=WQCuYkFUBt52oa7gxIJjdfGIYbOZz3TS93JCRjaSxmsyMgZBh8tqHpxrPugd31oxFC
         +CgSX/R2eFGgg5iCBUf53W5nqj3s+Vz/WigKyjyz/ohF2A/ptr4a4LZYj1VjwYiWaefl
         3GV5rpNd7NsTRv7i8aca5F2zVQVs1Bl73jlYLy8AN2ihzBG9ziJuyqGH7EahgXUqPcDq
         Ticoqwy9OnrmpF72pOMCffgk2Rxsbl0x0iziyNY0PkmlMf7u7c51x55cTOLtdd0emyNA
         owZM7i0PV/g+6L4ZS8sd7kKV5Rht8Y4tB3pYyv63FO+S2/BdtKgjUAbBCrMpn+cslCAh
         Xe4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q09e2xRyuSfvXtnOiYjBL+Mh/fSB/3KPylqia1+fqvU=;
        b=ZqMgbIpXY8fTPFaCiQco31Gaibi8WZgHPnP0wXni/mhGKHupMZX7jrazGUns874sWS
         9IiV1RZ9txDCQ9niF3w2CfPJVgWay1v+xRsuhAmCE2JC7+6Vp2gO9rWKb7bACF615Hae
         Hxn1fpXI+Kn2xCfLXctx02qvabWz7pSsF1T8HpFY9hDEY36iy4vbM+Tg8dvgE6J019Ls
         z7e/kXKAyZB/T6onjrc3ZVgOf3eNcrX5XTPvA115WSFSY3wwBAZgTfO7UKn4OdJUd/Dv
         SKlS/rCfrrRd6rhUHRm8qWx9hxW59N+XGvgzfZ22NMvEmD/M1mz7O7coXkROoqbQJjLy
         KZqg==
X-Gm-Message-State: AOAM530MAOaRozurix+peww9qXiakAzhdK6KfonhuNsWDJOwd4W6Sl/z
        Rsf5JhFI2W8iKoqRJriCpq4i77pDym/9EoG6vh4=
X-Google-Smtp-Source: ABdhPJyZqwDVepjJBnDgeqOUi7N6JUCbWrkqXALdLtZswf0dGZouMziKCrRPpSbwEIP4V+BQvGJrV5P2TbUUFVE+svQ=
X-Received: by 2002:a05:6602:150b:: with SMTP id g11mr46744482iow.88.1609425964445;
 Thu, 31 Dec 2020 06:46:04 -0800 (PST)
MIME-Version: 1.0
References: <20201230201141.3455302-1-nicolas.iooss@m4x.org> <20201230201141.3455302-4-nicolas.iooss@m4x.org>
In-Reply-To: <20201230201141.3455302-4-nicolas.iooss@m4x.org>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 31 Dec 2020 08:45:53 -0600
Message-ID: <CAFftDdpcDv4L6m1n2=EvDVSx8POLcFXrxJbpPtkX9usu_FryHQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] libsepol/cil: propagate failure of cil_fill_list()
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 30, 2020 at 2:13 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> OSS-Fuzz found a Null-dereference READ in the CIL compiler when trying
> to compile the following policy:
>
>     (optional o (validatetrans x (eq t3 (a ()))))
>
> With some logs, secilc reports:
>
>     Invalid syntax
>     Destroying Parse Tree
>     Resolving AST
>     Failed to resolve validatetrans statement at fuzz:1
>     Disabling optional 'o' at tmp.cil:1
>
> So there is an "Invalid syntax" error, but the compilation continues.
> Fix this issue by stopping the compilation when cil_fill_list() reports
> an error:
>
>     Invalid syntax
>     Bad expression tree for constraint
>     Bad validatetrans declaration at tmp.cil:1
>
> Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=29061
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsepol/cil/src/cil_build_ast.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> index 4caff3cb3c98..0ea90cf92186 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -2713,7 +2713,11 @@ static int __cil_fill_constraint_leaf_expr(struct cil_tree_node *current, enum c
>                 cil_list_append(*leaf_expr, CIL_STRING, current->next->next->data);
>         } else if (r_flavor == CIL_LIST) {
>                 struct cil_list *sub_list;
> -               cil_fill_list(current->next->next->cl_head, leaf_expr_flavor, &sub_list);
> +               rc = cil_fill_list(current->next->next->cl_head, leaf_expr_flavor, &sub_list);
> +               if (rc != SEPOL_OK) {
> +                       cil_list_destroy(leaf_expr, CIL_TRUE);
> +                       goto exit;
> +               }
>                 cil_list_append(*leaf_expr, CIL_LIST, sub_list);
>         } else {
>                 cil_list_append(*leaf_expr, CIL_CONS_OPERAND, (void *)r_flavor);
> --
> 2.29.2
>

ack for the series.
