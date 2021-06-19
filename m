Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E30C2B9F4
	for <selinux@archiver.kernel.org>; Sat, 19 Jun 2021 14:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A05D1610CD
	for <selinux@archiver.kernel.org>; Sat, 19 Jun 2021 14:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbhFSOYh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 19 Jun 2021 10:24:37 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:56401 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbhFSOYg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 19 Jun 2021 10:24:36 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 19FA45611E2
        for <selinux@vger.kernel.org>; Sat, 19 Jun 2021 16:22:24 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id i4so2445105plt.12
        for <selinux@vger.kernel.org>; Sat, 19 Jun 2021 07:22:24 -0700 (PDT)
X-Gm-Message-State: AOAM532rDwsfbe4f5bcJEvsf+Oy8skgJnOvoTpuSlazPIxmirY8hE3eU
        bNhZy0RHXJPmA0MJK0esOrJRXRVKAhYKJHNLehc=
X-Google-Smtp-Source: ABdhPJzooGY7nDb88LZmkVbJNwSDgn3zcAG7kkB9ly75m7ID8XRGfKJIt8nMncqozUWjBBFLTWbB44y1lD/R0PMUd6A=
X-Received: by 2002:a17:902:b717:b029:11a:fae3:ba7c with SMTP id
 d23-20020a170902b717b029011afae3ba7cmr9437365pls.28.1624112542997; Sat, 19
 Jun 2021 07:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210614150546.512001-1-jwcart2@gmail.com> <20210614150546.512001-5-jwcart2@gmail.com>
In-Reply-To: <20210614150546.512001-5-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 19 Jun 2021 16:22:12 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=n9bi1NO92z41a5OunZik2YVy6sfDxA+aHddpbma6CyDg@mail.gmail.com>
Message-ID: <CAJfZ7=n9bi1NO92z41a5OunZik2YVy6sfDxA+aHddpbma6CyDg@mail.gmail.com>
Subject: Re: [PATCH 4/5] libsepol/cil: Reduce the initial symtab sizes for blocks
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jun 19 16:22:24 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 14, 2021 at 5:05 PM James Carter <jwcart2@gmail.com> wrote:
>
> It is possible to create bad behaving policy that can consume all
> of a system's memory (one way is through the use of inheritance).
> Analyzing these policies shows that most of the memory usage is for
> the block symtabs.
>
> Most of the nineteen symtabs will most likely never be used, so give
> these symtabs an initial size of 1. The others are given more
> appropriate sizes.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

For this patch:

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks!

> ---
>  libsepol/cil/src/cil.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> index 0d351b49..c6674fc1 100644
> --- a/libsepol/cil/src/cil.c
> +++ b/libsepol/cil/src/cil.c
> @@ -54,7 +54,7 @@
>
>  int cil_sym_sizes[CIL_SYM_ARRAY_NUM][CIL_SYM_NUM] = {
>         {64, 64, 64, 1 << 13, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64},
> -       {64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64},
> +       {8, 8, 8, 32, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
>         {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
>         {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
>         {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
> --
> 2.26.3
>

