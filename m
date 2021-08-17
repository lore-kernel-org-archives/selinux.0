Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1816CC4338F
	for <selinux@archiver.kernel.org>; Tue, 17 Aug 2021 19:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB7EE6023F
	for <selinux@archiver.kernel.org>; Tue, 17 Aug 2021 19:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhHQTfV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Aug 2021 15:35:21 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:56576 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbhHQTfV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Aug 2021 15:35:21 -0400
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id B6537564810
        for <selinux@vger.kernel.org>; Tue, 17 Aug 2021 21:34:39 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id n5so778109pjt.4
        for <selinux@vger.kernel.org>; Tue, 17 Aug 2021 12:34:39 -0700 (PDT)
X-Gm-Message-State: AOAM532CBcS0WXDsUMEkYx5ojsI8SuZbz2QnqbVQw2wMmIH7UwC9QpNW
        CIoe8BSKwyqcQnABNS3jwxeecwo8R6puAdtphw8=
X-Google-Smtp-Source: ABdhPJyLUTwNTe3E0rnv0PKZmG69M1xJ+mRxwZlTD6caTG3otQUjk2k1gcXw8Mky6YlXw8lCwwAo/rpQX3qvZibdRHY=
X-Received: by 2002:a63:3244:: with SMTP id y65mr4988242pgy.210.1629228878272;
 Tue, 17 Aug 2021 12:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210816195752.923028-1-jwcart2@gmail.com>
In-Reply-To: <20210816195752.923028-1-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 17 Aug 2021 21:34:27 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=nn9pNt=nXZsQ=gPaLULGDy=wVvZV3GCywvLvmx3RQmEA@mail.gmail.com>
Message-ID: <CAJfZ7=nn9pNt=nXZsQ=gPaLULGDy=wVvZV3GCywvLvmx3RQmEA@mail.gmail.com>
Subject: Re: [PATCH 0/7 v2] libsepol/cil: Line mark cleanup and fix
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Aug 17 21:34:40 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 16, 2021 at 9:57 PM James Carter <jwcart2@gmail.com> wrote:
>
> Patches 1-5 cleanup minor issues with CIL's line marks.
>
> Patches 6-7 fix the way line mark works so that the correct line
> numbers will be given for nested line marks.
>
> Patch 8 writes out line mark information when writing out the AST.

Hello,
Patch 8 is missing from the v2 (the series only contains 7 patches).
Should the previous patch 8 ("libsepol/cil: When writing AST use line
marks for src_info nodes") be also considered for review?

Thanks,
Nicolas

> Changes in v2
> In patch 6, use cil_strpool_add("1") instead of "1"
> In patch 7, fix confusing usage of pre_hll_expand and pre_hll_offset; initialize pre_hll_offset, change format specifiers in cil_tree.c to use %u instead of %d.
>
> James Carter (7):
>   libsepol/cil: Check syntax of src_info statement
>   libsepol/cil: Check the token type after getting the next token
>   libsepol/cil: Check for valid line mark type immediately
>   libsepol/cil: Push line mark state first when processing a line mark
>   libsepol/cil: Create common string-to-unsigned-integer functions
>   libsepol/cil: Add line mark kind and line number to src info
>   libsepol/cil: Report correct high-level language line numbers
>
>  libsepol/cil/src/cil.c           |  70 ++++++++++++++++-
>  libsepol/cil/src/cil_binary.c    |   9 ++-
>  libsepol/cil/src/cil_build_ast.c |  77 ++++++++++--------
>  libsepol/cil/src/cil_copy_ast.c  |   5 +-
>  libsepol/cil/src/cil_internal.h  |   9 ++-
>  libsepol/cil/src/cil_parser.c    | 129 +++++++++++++++----------------
>  libsepol/cil/src/cil_tree.c      |  57 +++++++++-----
>  libsepol/cil/src/cil_tree.h      |   4 +-
>  8 files changed, 226 insertions(+), 134 deletions(-)
>
> --
> 2.31.1
>

