Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C005DC197A0
	for <selinux@archiver.kernel.org>; Thu, 16 Nov 2023 17:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjKPR5N (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Nov 2023 12:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKPR5M (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Nov 2023 12:57:12 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D15126
        for <selinux@vger.kernel.org>; Thu, 16 Nov 2023 09:57:08 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507a29c7eefso1588629e87.1
        for <selinux@vger.kernel.org>; Thu, 16 Nov 2023 09:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700157427; x=1700762227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcjoNt47AVsaWxUt5c4M6FMdjOF7pm4+duFTaV5uwFs=;
        b=PjM86DbysDHiPEzv4etDa4UNfE1aj1ZUamtEJFPTEfi4tZSgCF006FllMyCYwdGQjg
         MKl9MKjLKLcR/hU4eF0JTI24R9ejnFTTTkQRj0I+HasB/TB71GkQNo8EAsjSlvkPwNwL
         kuhxmBQoHBs0HrmtIidVXmsxgvPAEIWD6nswTu+6wkvKstYOO/m04qbCFs1swfSw5weP
         zlrRw6CE4+9xotDycecCfNBRJJkUVV8w3Yg7RTJgtyg5Oc6+cJCCykysH9j6F2O3z1bF
         EVQwe3v3WjX2QmqrjI+J6WzbkX80HGUP1rnHY7+gLDuWUZAhe98LPunrXztl69NeaYYL
         npBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700157427; x=1700762227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcjoNt47AVsaWxUt5c4M6FMdjOF7pm4+duFTaV5uwFs=;
        b=apQxFIdFz1tECJttDjKiPC40q8dQT53jpA/gYhwrRgNQ2mBRSsAw10tKssmkCiE6nx
         6jtCWK2UIvWrwx6bLaGnnD7UInVEERooYnr0HdqCDryVUElaQHe3cRLlHR+pFJo2U5ln
         BORMu/SW8VpAnYpXIlPfu4EGj0LtDugKNuIblEtB2R9b1FEanmgRiDDiBJvXvfh3oVJ0
         opfHS5KftLI9ASNte4LTapn80I3SHjTwciEI1CfQfKNF18AlqUzER0DrvM2qLB+POaWl
         mENZb8QlruKP4QQcUp1b8nnS2Ks64DpK87zt2r8hBhA6pRunAByPpQXtZFg/eldIayHS
         410Q==
X-Gm-Message-State: AOJu0YxzBs4bEyTPUtXhv53EyGLGC7U6/4Kl0eb6iKL4E1KrChi4hUvH
        INvixs8wyZKWHMtlq30BhI+oi8JaxdMT9bWvXf/9ex7bvKt5dQ==
X-Google-Smtp-Source: AGHT+IF2irJKJAStY3byDq9T4FArhyvSbFtbKke/rnPv1kqN6/FMDavmC5gJmJ7tnxk3xQwbERzXB1OZ7Y5QRW6ICG4=
X-Received: by 2002:a05:6512:3142:b0:505:7371:ec83 with SMTP id
 s2-20020a056512314200b005057371ec83mr11166379lfi.48.1700157426441; Thu, 16
 Nov 2023 09:57:06 -0800 (PST)
MIME-Version: 1.0
References: <20231115233207.51845-1-luhuaxin1@huawei.com>
In-Reply-To: <20231115233207.51845-1-luhuaxin1@huawei.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 16 Nov 2023 12:56:55 -0500
Message-ID: <CAP+JOzQUYrXWZjRKxBCdQdVZYsA9kCaXGUwhBCAoCfMfig6dQw@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: add check for category value before printing
To:     luhuaxin1@huawei.com
Cc:     selinux@vger.kernel.org, fangxiuning@huawei.com,
        zhujianwei7@huawei.com, shenyining@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 15, 2023 at 9:04=E2=80=AFPM <luhuaxin1@huawei.com> wrote:
>
> From: Huaxin Lu <luhuaxin1@huawei.com>
>
> In mls_semantic_level_expand(), there is a explicitly determine
> whether category is 0, which may cause an potential integer
> overflow in error branch.
>
> Signed-off-by: Huaxin Lu <luhuaxin1@huawei.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/expand.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index ee5f9185..9ed22bfd 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -945,8 +945,8 @@ int mls_semantic_level_expand(mls_semantic_level_t * =
sl, mls_level_t * l,
>         for (cat =3D sl->cat; cat; cat =3D cat->next) {
>                 if (!cat->low || cat->low > cat->high) {
>                         ERR(h, "Category range is not valid %s.%s",
> -                           p->p_cat_val_to_name[cat->low - 1],
> -                           p->p_cat_val_to_name[cat->high - 1]);
> +                           cat->low > 0 ? p->p_cat_val_to_name[cat->low =
- 1] : "Invalid",
> +                           cat->high > 0 ? p->p_cat_val_to_name[cat->hig=
h - 1] : "Invalid");
>                         return -1;
>                 }
>                 for (i =3D cat->low - 1; i < cat->high; i++) {
> --
> 2.33.0
>
