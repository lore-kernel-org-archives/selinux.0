Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A3DC433E9
	for <selinux@archiver.kernel.org>; Mon, 15 Mar 2021 21:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6EB064E99
	for <selinux@archiver.kernel.org>; Mon, 15 Mar 2021 21:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhCOVD7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Mar 2021 17:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbhCOVD5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Mar 2021 17:03:57 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3693FC06174A
        for <selinux@vger.kernel.org>; Mon, 15 Mar 2021 14:03:57 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id x78so35942989oix.1
        for <selinux@vger.kernel.org>; Mon, 15 Mar 2021 14:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hcn6916ejwWkNP2AqnJUGCkoZ87lJVs6DSg94nabiY8=;
        b=rRzIq2IVOVx3Qg7xSbl+GMcolKpkwDkwKourruUd+E3e1CmW1B4cneZys5c7rZ8xzk
         /RVo9Do5Z1sYDtrIsssYSR8IS0SZ8bDPUkL+Bc1M88jmKHi6s4K6V5d7d6ovxO7oeEvU
         6/BM4UOXgLTTrO9CfKK2TJ6YqRdhbGeJtZv1zGHK6y4rKUDPmLbfh2BC2Bqax86dT8uj
         jkxBsfWrGkS5aDw6LEqpzGsfC+wpNaVvhuvxWezQ+Npdiz1QRsapJjJW3sA13pC36F1O
         3mI1F1J8TN1QK3N9TLzFg0ch7cUWJywVc4ye+7SeVJJUVvJH9ZpuKbYW5sQbjSlz4iPU
         5vQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hcn6916ejwWkNP2AqnJUGCkoZ87lJVs6DSg94nabiY8=;
        b=bpN+iJ5B2N5BRQchtbWnwcjr3Ajthg+M+3+gQBGY1ChKuTpEhc4IysE6iz6h/mbVhS
         +xF67DGqOxkzeVx4Gqoj9ze0PnSRlwhJqAg4LJ1rMze24oYOko6zZjU8IA5tj1K/oSe/
         VuBD/X5GlFPUPA7aeE+jDnW6Oxq/jwyw+ReQjbmpIGQVjVr2S4TBc1skuPkV5UPznbjl
         +I4mBR0vOyLHZzSGUKbgkXqHvSo+DU6Njhyd4asmVrknH/BsY3fpvJBhFrHMPjZmKGhi
         LtCBltvsveGao59UBS/y9QjEbnM6aYbKzHmDPuNsqBUpFDwdj190GUAgiUfl1d36G8Li
         J+FA==
X-Gm-Message-State: AOAM532/NuAUMfhrUsSEE0ykNOlujEcRJZU3wWM1ZmXYAYS1t5UcApJA
        EANeucTO+qRCEQT3HnupRd8DuiirJlYQBKM0nYYNRGQ0uIs=
X-Google-Smtp-Source: ABdhPJzf9WL5Zk3cs7WmBN/PR2RIZy0FAil/JmSTVKVUpFHljVln1oX+4pRsiPH2PWHxoZIVopjWe8sHSCUsmjrf/x8=
X-Received: by 2002:a05:6808:14d5:: with SMTP id f21mr780354oiw.16.1615842236703;
 Mon, 15 Mar 2021 14:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210314201651.474432-1-nicolas.iooss@m4x.org> <20210314201651.474432-3-nicolas.iooss@m4x.org>
In-Reply-To: <20210314201651.474432-3-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 15 Mar 2021 17:03:45 -0400
Message-ID: <CAP+JOzRd=zVaEnE1vTfjqen-rRYwDUUWyO=K=FYhe+TzHc+KhQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] libsepol/cil: remove stray printf
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Mar 14, 2021 at 4:22 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> printf("%i\n", node->flavor); looks very much like a statement which was
> added for debugging purpose and was unintentionally left.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_resolve_ast.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index 0e07856133e5..47cdf0e7c0b9 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -1088,7 +1088,6 @@ int cil_resolve_roletransition(struct cil_tree_node *current, void *extra_args)
>         node = NODE(result_datum);
>         if (node->flavor != CIL_ROLE) {
>                 rc = SEPOL_ERR;
> -               printf("%i\n", node->flavor);
>                 cil_log(CIL_ERR, "roletransition must result in a role, but %s is a %s\n", roletrans->result_str, cil_node_to_string(node));
>                 goto exit;
>         }
> --
> 2.30.2
>
