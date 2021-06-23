Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A162C4743C
	for <selinux@archiver.kernel.org>; Wed, 23 Jun 2021 19:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA1566115A
	for <selinux@archiver.kernel.org>; Wed, 23 Jun 2021 19:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhFWTkY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 23 Jun 2021 15:40:24 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:46267 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbhFWTkX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 23 Jun 2021 15:40:23 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jun 2021 15:40:22 EDT
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id F2FF4565A93
        for <selinux@vger.kernel.org>; Wed, 23 Jun 2021 21:32:52 +0200 (CEST)
Received: by mail-pl1-f180.google.com with SMTP id m17so1697512plx.7
        for <selinux@vger.kernel.org>; Wed, 23 Jun 2021 12:32:52 -0700 (PDT)
X-Gm-Message-State: AOAM530VSA0Il20mNoNWTmwZ9UwH6ZYhG8DCJo2JmtN6+0GD1pTYLYKC
        Jq7wdr3EhQbGQoHVffR5fLK3yTUDxfcvDH49p0g=
X-Google-Smtp-Source: ABdhPJzvl1jKSigRIb1WpVwiC4HsS1mUtj/eBUUzzhwmEva1hKwNdaG2rE9NM5V0IMIP79PZ0/Ht7q5IQ65d1XrhI3A=
X-Received: by 2002:a17:90b:4b0f:: with SMTP id lx15mr1332881pjb.34.1624476771669;
 Wed, 23 Jun 2021 12:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210621191833.282874-1-jwcart2@gmail.com>
In-Reply-To: <20210621191833.282874-1-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 23 Jun 2021 21:32:40 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=moLtL4fneXKXFRe_nuy4i4wXDjwUAhwG3jDsvSN2HDTQ@mail.gmail.com>
Message-ID: <CAJfZ7=moLtL4fneXKXFRe_nuy4i4wXDjwUAhwG3jDsvSN2HDTQ@mail.gmail.com>
Subject: Re: [PATCH 0/5 v2] Another round of secilc-fuzzer problems fixed
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Jun 23 21:32:53 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 21, 2021 at 9:18 PM James Carter <jwcart2@gmail.com> wrote:
>
> Patch 1 fixes the check for self-referential loops that didn't work in all cases
> Patches 2 and 3 fix a couple of bugs
> Patches 4 and 5 make it harder to create small policies that expand into large
> policies that consume all of a system's memory.
>
> Only patches 2 and 5 are changed in v2.
>
> James Carter (5):
>   libsepol/cil: Properly check for loops in sets
>   libsepol/cil: Fix syntax checking of defaultrange rule
>   libsepol/cil: Check for empty list when marking neverallow attributes
>   libsepol/cil: Reduce the initial symtab sizes for blocks
>   libsepol/cil: Improve degenerate inheritance check
>
>  libsepol/cil/src/cil.c             |   2 +-
>  libsepol/cil/src/cil_build_ast.c   |  10 ++
>  libsepol/cil/src/cil_internal.h    |   5 +-
>  libsepol/cil/src/cil_post.c        |   4 +
>  libsepol/cil/src/cil_resolve_ast.c | 226 +++++++++++++++++++----------
>  libsepol/cil/src/cil_verify.c      |  48 ++++--
>  6 files changed, 198 insertions(+), 97 deletions(-)
>
> --
> 2.26.3

Hello,

These patches look good to me:

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks!
Nicolas

