Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF1CC433DB
	for <selinux@archiver.kernel.org>; Wed, 17 Mar 2021 09:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBA4964F3C
	for <selinux@archiver.kernel.org>; Wed, 17 Mar 2021 09:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhCQJbk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Mar 2021 05:31:40 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:35909 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhCQJbQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Mar 2021 05:31:16 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 56EA9564EE8
        for <selinux@vger.kernel.org>; Wed, 17 Mar 2021 10:31:14 +0100 (CET)
Received: by mail-pf1-f170.google.com with SMTP id c204so701491pfc.4
        for <selinux@vger.kernel.org>; Wed, 17 Mar 2021 02:31:14 -0700 (PDT)
X-Gm-Message-State: AOAM532quSv8W9Hc8/PDb3yx7BwG2qHdlHDhWhEPpGUQRY0B2VJVJUid
        5uLP+ZZFLHnd1WpUkYcjrJQr0ungqvHRmvK3PsA=
X-Google-Smtp-Source: ABdhPJxjqmNgArtwgLf+bkNUYidKgBBpbTT3Ny7qIs+VI76iQsPp4TwgRZe+MFBr3BgXe+GaG0x13c41tyyuDngsRzQ=
X-Received: by 2002:a63:494b:: with SMTP id y11mr1844305pgk.99.1615973473114;
 Wed, 17 Mar 2021 02:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210316204646.52060-1-jwcart2@gmail.com>
In-Reply-To: <20210316204646.52060-1-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 17 Mar 2021 10:31:02 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mcDaTQCtz0isuGzwmTtMZtxUTrvj2Qnm93XSjTSQcveA@mail.gmail.com>
Message-ID: <CAJfZ7=mcDaTQCtz0isuGzwmTtMZtxUTrvj2Qnm93XSjTSQcveA@mail.gmail.com>
Subject: Re: [PATCH 1/4] libsepol/cil: Allow lists in constraint expressions
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Mar 17 10:31:14 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 16, 2021 at 9:49 PM James Carter <jwcart2@gmail.com> wrote:
>
> The expectation in CIL was to use user, role, or type attributes in
> constraint expressions. The problem is that neither user nor role
> attributes are part of the kernel binary policy, so when converting
> from a kernel policy to CIL, that would require the creation of a
> role or user attribute. The better solution is to just allow a list
> to be used. In fact, the only thing preventing a list to be used
> is a check in cil_verify_constraint_leaf_expr_syntax().
>
> Remove the check and allow lists in constraint expressions.
>
> The following is now allowed:
>   (constrain (CLASS1 (PERM1)) (eq r1 (ROLE1 ROLE2 ROLE_ATTR3)))
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

For these 4 patches:
Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Before merging, the patch that I sent to fix an issue with some gcc
optimizations (https://lore.kernel.org/selinux/20210316222313.19793-1-nicolas.iooss@m4x.org/)
should be reviewed and applied.

Nicolas

> ---
>  libsepol/cil/src/cil_verify.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
> index 6706e219..09e3daf9 100644
> --- a/libsepol/cil/src/cil_verify.c
> +++ b/libsepol/cil/src/cil_verify.c
> @@ -225,9 +225,6 @@ int cil_verify_constraint_leaf_expr_syntax(enum cil_flavor l_flavor, enum cil_fl
>                                 cil_log(CIL_ERR, "u3, r3, and t3 can only be used with (mls)validatetrans rules\n");
>                                 goto exit;
>                         }
> -               } else if (r_flavor == CIL_LIST) {
> -                       cil_log(CIL_ERR, "t1, t2, r1, r2, u1, u2 cannot be used on the left side with a list on the right side\n");
> -                       goto exit;
>                 }
>         } else {
>                 if (r_flavor == CIL_CONS_U2) {
> --
> 2.26.2
>

