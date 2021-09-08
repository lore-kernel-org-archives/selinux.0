Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DE9C433F5
	for <selinux@archiver.kernel.org>; Wed,  8 Sep 2021 07:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 950036113D
	for <selinux@archiver.kernel.org>; Wed,  8 Sep 2021 07:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244941AbhIHHMB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Sep 2021 03:12:01 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:43460 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345429AbhIHHMB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Sep 2021 03:12:01 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 0E95A5605E1
        for <selinux@vger.kernel.org>; Wed,  8 Sep 2021 09:10:51 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id y17so1131233pfl.13
        for <selinux@vger.kernel.org>; Wed, 08 Sep 2021 00:10:50 -0700 (PDT)
X-Gm-Message-State: AOAM531cB4Ckqj/cRP/TAXLR6c1KLpm7VL/+8FM1YAbrzvJJQhpGRnYD
        hjFTgKwSxAZ5LTWgId5XSfgDUbNCHmLw+7/hypk=
X-Google-Smtp-Source: ABdhPJw8/SUwK3swH5xftSCZlUSCXducBHTzPeNEggg9lDoHHotJTX2/atq/NwZFoIq2wE89eTAKuHwq8Bq88OMr9Qw=
X-Received: by 2002:a63:3d4c:: with SMTP id k73mr2369211pga.44.1631085049612;
 Wed, 08 Sep 2021 00:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210907195845.809083-1-jwcart2@gmail.com> <20210907195845.809083-2-jwcart2@gmail.com>
In-Reply-To: <20210907195845.809083-2-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 8 Sep 2021 09:10:38 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=kkjvsTXYs0toWydn=s5C8JzX-pLo1xuTj3yoS5eXDUXg@mail.gmail.com>
Message-ID: <CAJfZ7=kkjvsTXYs0toWydn=s5C8JzX-pLo1xuTj3yoS5eXDUXg@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsepol/cil: Limit the number of active line marks
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Sep  8 09:10:51 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 7, 2021 at 9:58 PM James Carter <jwcart2@gmail.com> wrote:
>
> A line mark functions like an open parenthesis, so the number of
> active line marks should be limited like the number of open
> parenthesis.
>
> This issue was found by the secilc-fuzzer.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

For both patches:

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks,
Nicolas

> ---
>  libsepol/cil/src/cil_parser.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/libsepol/cil/src/cil_parser.c b/libsepol/cil/src/cil_parser.c
> index a967b9ed..5375d49a 100644
> --- a/libsepol/cil/src/cil_parser.c
> +++ b/libsepol/cil/src/cil_parser.c
> @@ -131,6 +131,10 @@ static int add_hll_linemark(struct cil_tree_node **current, uint32_t *hll_offset
>                 *current = (*current)->parent;
>         } else {
>                 push_hll_info(stack, *hll_offset, *hll_expand);
> +               if (cil_stack_number_of_items(stack) > CIL_PARSER_MAX_EXPR_DEPTH) {
> +                       cil_log(CIL_ERR, "Number of active line marks exceeds limit of %d\n", CIL_PARSER_MAX_EXPR_DEPTH);
> +                       goto exit;
> +               }
>
>                 create_node(&node, *current, tok.line, *hll_offset, NULL);
>                 insert_node(node, *current);
> --
> 2.31.1
>

