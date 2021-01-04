Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFB0C433E6
	for <selinux@archiver.kernel.org>; Tue,  5 Jan 2021 00:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7606B22573
	for <selinux@archiver.kernel.org>; Tue,  5 Jan 2021 00:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbhAEAWL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Jan 2021 19:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbhAEAWL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Jan 2021 19:22:11 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DE0C061574
        for <selinux@vger.kernel.org>; Mon,  4 Jan 2021 16:21:27 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id v67so27705885ybi.1
        for <selinux@vger.kernel.org>; Mon, 04 Jan 2021 16:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2a4XIglO4RGbHBjJ+IZZHWPlae6RxSmZoo8b2NFo6HM=;
        b=Ifdz3Yu9wxfN/gF3gbh4OpQYzbh2LvRyDvBmNeGaiQaKFOp/GfYzsykXEtWRFCXwZ9
         9RKmFiWxA1n+U17y1tbeL4BwmriMp8LR61EWPwuktx1nhRnRIviWQCLbUQa1DNhVdeiX
         /B4SX1tzyKntAFL8srZIv67zYBJF86y07YDhRlvu/TMhThmbQ+v/SYTZVMGPCTV6Z6vB
         GlXCEFc3PtV7powAgH21yEhVDqroqto5NDr3uHfxIA0sqcaotmS/YEksGGE9pzj73OhD
         zS9awYanJydys/xNxv9Zvq84SpHGzpoG0havhxXUuJRgDoEl5R/MnANZRvRLIOgkrRmZ
         JrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2a4XIglO4RGbHBjJ+IZZHWPlae6RxSmZoo8b2NFo6HM=;
        b=jY7e7SoqwwhZkn7sWOaXmVwiDfwMUFUGWLkZDd0EHKXwa5i0OBoYVlO0zRhxIHhhIc
         F0Et/zsNRyjQkicqGHo1D1nuF0rgmUW5q6ck0AO6EZISLYWNLrD3tdJxQRqdw54OcEZY
         uBqmKx2fvRyKMQHpHu86c06KKJeTiGmKfJafEPz25Z0L6PJszT3zYnDkmJ3z3QZoOUjl
         SX85xUuQbkDG6qTENkmazX1Gr5yfL+rjCLltVX8WRedhTF35JjSon87XB5vNY6m2UG8H
         kWqRHLnwwYWyj8rI1ZTkYJqdXESLs4lCBP/TDZFItVrPt5vWbtopClMw27RRZu++BwJF
         RwSA==
X-Gm-Message-State: AOAM530oa4C+LPlrJ0gLxjvPEdJGWBZXt87WgZ/0JmOECogskwevW6AH
        SRveh0tiUUFC6zAtdfTxNzKYLjshFg4bEF1EqLm4jOMW
X-Google-Smtp-Source: ABdhPJz4zySDVeluuwdzITTOq6Gd236EdX2QFN3XRuMMLQeyUUessWC/hCwBM3qEl6j08BgHhHPfe23qjC6nsYnnXxk=
X-Received: by 2002:a05:6830:1385:: with SMTP id d5mr25649649otq.295.1609794953406;
 Mon, 04 Jan 2021 13:15:53 -0800 (PST)
MIME-Version: 1.0
References: <20201230201141.3455302-1-nicolas.iooss@m4x.org>
 <20201230201141.3455302-4-nicolas.iooss@m4x.org> <CAFftDdpcDv4L6m1n2=EvDVSx8POLcFXrxJbpPtkX9usu_FryHQ@mail.gmail.com>
In-Reply-To: <CAFftDdpcDv4L6m1n2=EvDVSx8POLcFXrxJbpPtkX9usu_FryHQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 4 Jan 2021 16:15:42 -0500
Message-ID: <CAP+JOzSeRiSMvU=GHCPS4QAwYzEqbMTvbnuYr6XhDdZup45xew@mail.gmail.com>
Subject: Re: [PATCH 4/4] libsepol/cil: propagate failure of cil_fill_list()
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 31, 2020 at 10:29 AM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Wed, Dec 30, 2020 at 2:13 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > OSS-Fuzz found a Null-dereference READ in the CIL compiler when trying
> > to compile the following policy:
> >
> >     (optional o (validatetrans x (eq t3 (a ()))))
> >
> > With some logs, secilc reports:
> >
> >     Invalid syntax
> >     Destroying Parse Tree
> >     Resolving AST
> >     Failed to resolve validatetrans statement at fuzz:1
> >     Disabling optional 'o' at tmp.cil:1
> >
> > So there is an "Invalid syntax" error, but the compilation continues.
> > Fix this issue by stopping the compilation when cil_fill_list() reports
> > an error:
> >
> >     Invalid syntax
> >     Bad expression tree for constraint
> >     Bad validatetrans declaration at tmp.cil:1
> >
> > Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=29061
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > ---
> >  libsepol/cil/src/cil_build_ast.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> > index 4caff3cb3c98..0ea90cf92186 100644
> > --- a/libsepol/cil/src/cil_build_ast.c
> > +++ b/libsepol/cil/src/cil_build_ast.c
> > @@ -2713,7 +2713,11 @@ static int __cil_fill_constraint_leaf_expr(struct cil_tree_node *current, enum c
> >                 cil_list_append(*leaf_expr, CIL_STRING, current->next->next->data);
> >         } else if (r_flavor == CIL_LIST) {
> >                 struct cil_list *sub_list;
> > -               cil_fill_list(current->next->next->cl_head, leaf_expr_flavor, &sub_list);
> > +               rc = cil_fill_list(current->next->next->cl_head, leaf_expr_flavor, &sub_list);
> > +               if (rc != SEPOL_OK) {
> > +                       cil_list_destroy(leaf_expr, CIL_TRUE);
> > +                       goto exit;
> > +               }
> >                 cil_list_append(*leaf_expr, CIL_LIST, sub_list);
> >         } else {
> >                 cil_list_append(*leaf_expr, CIL_CONS_OPERAND, (void *)r_flavor);
> > --
> > 2.29.2
> >
>
> ack for the series.

I've applied this series.

Thanks,
Jim
