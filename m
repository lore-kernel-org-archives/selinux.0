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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAD8C433E0
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 14:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6F7464E01
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 14:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhCROQB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Mar 2021 10:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhCROPa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Mar 2021 10:15:30 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B53C06174A
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 07:15:30 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id n6-20020a4ac7060000b02901b50acc169fso1453532ooq.12
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 07:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RCycaR+WM1psiZ3i3+JWb31Twynz35u3ZvYsEd/4QkI=;
        b=cyIchR56G+vGpRjBW14pVP2DV4YeJt7AP69Vc2d5hE4Iw/5ZExh4HunCWH2J2s6Nww
         hxRHCeAVazdzpoZutm0rQWa0VPw2aVRPvON5ncMmhTKtmjaaey6bk0yG5RRX+5kinGXf
         8B0LjGsy2TI7k5doNmjM+ytIH2WW8k07nd9qUHDVE9lUEl3ILxV+wYHgXyLhUUsqt14T
         CpJf8iCSa2xA4cKL1ZQEuflvNGeTkYhBZGB7zqfa39+H++8iRlS4tqRMXei4u3sBHY97
         0YhjB+BvIOFBOGOszLnVyZY3RqLpqZjpZuttF9w7pOmt0GdvYUZZjmi+EMPcCl7+K2wH
         IlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RCycaR+WM1psiZ3i3+JWb31Twynz35u3ZvYsEd/4QkI=;
        b=TtIrM+jwvEDvPB1Ng64M+ZMsuoQZedW04w8/PUS6u2t9/mAVsIxkwlqkAt9RPyYM7T
         A0+fvQ7t9/11TSPGoUTLA+2zBb+sKb+XM4gIkO0OcHuAG27N4ozyNyUML9+84DYBDBlp
         sw1Cqg4BK0NAf6u23+3xm4659DRYjgKJAK4DVtPh47DaNcx7GUv627FlF1QE6VKUhgaC
         Ht1n0CPmn/MoHMmKhmus6WtiygQEJei1DNu0T7UffEFZjfglTSPESliD77zi4qFXLEfi
         8Mp5cLtsU0j1NhtIx1Cn0hQtgaHPkWC7g/HaiXthQh1bRpfd4wkMSsIqagG+iYHrcWWY
         2dxg==
X-Gm-Message-State: AOAM532c/Lk8hMpWIVYL/AigbNarXpPv6QQVGvyiWcaTLaY9xSKeSVKL
        71yXFU81uW9JCIShzuQMdI3o0280a/6u2rYie6axkqP6d8U=
X-Google-Smtp-Source: ABdhPJztDxU6QoojaR5duQ4s8AwQO9EbaAdY0RUenEdRjQLfRWGiaIeiBp3eC0nBqIptg2lT9qIaEENMYs1pjevLz4I=
X-Received: by 2002:a4a:8c0d:: with SMTP id u13mr4518468ooj.59.1616076929511;
 Thu, 18 Mar 2021 07:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210316204646.52060-1-jwcart2@gmail.com> <CAJfZ7=mcDaTQCtz0isuGzwmTtMZtxUTrvj2Qnm93XSjTSQcveA@mail.gmail.com>
In-Reply-To: <CAJfZ7=mcDaTQCtz0isuGzwmTtMZtxUTrvj2Qnm93XSjTSQcveA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 18 Mar 2021 10:15:18 -0400
Message-ID: <CAP+JOzRUwECtq3gAB21nezwnnam57aw8dEtF7cFU6O42F81-3g@mail.gmail.com>
Subject: Re: [PATCH 1/4] libsepol/cil: Allow lists in constraint expressions
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 17, 2021 at 5:31 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Tue, Mar 16, 2021 at 9:49 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > The expectation in CIL was to use user, role, or type attributes in
> > constraint expressions. The problem is that neither user nor role
> > attributes are part of the kernel binary policy, so when converting
> > from a kernel policy to CIL, that would require the creation of a
> > role or user attribute. The better solution is to just allow a list
> > to be used. In fact, the only thing preventing a list to be used
> > is a check in cil_verify_constraint_leaf_expr_syntax().
> >
> > Remove the check and allow lists in constraint expressions.
> >
> > The following is now allowed:
> >   (constrain (CLASS1 (PERM1)) (eq r1 (ROLE1 ROLE2 ROLE_ATTR3)))
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> For these 4 patches:
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>

These four patches have been merged (the patch below was merged as well).
Thanks,
Jim

> Before merging, the patch that I sent to fix an issue with some gcc
> optimizations (https://lore.kernel.org/selinux/20210316222313.19793-1-nicolas.iooss@m4x.org/)
> should be reviewed and applied.
>
> Nicolas
>
> > ---
> >  libsepol/cil/src/cil_verify.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
> > index 6706e219..09e3daf9 100644
> > --- a/libsepol/cil/src/cil_verify.c
> > +++ b/libsepol/cil/src/cil_verify.c
> > @@ -225,9 +225,6 @@ int cil_verify_constraint_leaf_expr_syntax(enum cil_flavor l_flavor, enum cil_fl
> >                                 cil_log(CIL_ERR, "u3, r3, and t3 can only be used with (mls)validatetrans rules\n");
> >                                 goto exit;
> >                         }
> > -               } else if (r_flavor == CIL_LIST) {
> > -                       cil_log(CIL_ERR, "t1, t2, r1, r2, u1, u2 cannot be used on the left side with a list on the right side\n");
> > -                       goto exit;
> >                 }
> >         } else {
> >                 if (r_flavor == CIL_CONS_U2) {
> > --
> > 2.26.2
> >
>
