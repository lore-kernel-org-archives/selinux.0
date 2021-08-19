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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B13C4338F
	for <selinux@archiver.kernel.org>; Thu, 19 Aug 2021 19:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 082CC6056B
	for <selinux@archiver.kernel.org>; Thu, 19 Aug 2021 19:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbhHSTVP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Aug 2021 15:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbhHSTVO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Aug 2021 15:21:14 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D143C061575
        for <selinux@vger.kernel.org>; Thu, 19 Aug 2021 12:20:38 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id r26so9918917oij.2
        for <selinux@vger.kernel.org>; Thu, 19 Aug 2021 12:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bLwByC7BGaVevrVFtomE8pULrW13VxfSrNSZHQzlggA=;
        b=eyvnyWRGppAZnhyt+wYiB4+NUJejAKEufSAz+Vo14PjQ8aNpzHYbTER4b3vcqzspTw
         hzYrCr2zsVA2dPPWVeTE/c/c3O56EsHX/aSZOfQ8j7EZWiPvoqqf6CwPhQBJ/qphwxVY
         w/xpYeuHjX6ElOAiKArutCDzRn/pBUO18iQDMaZ39mxQksMHeIWKKJoIbmhcT/3GC42Y
         U+D4uMoedt5mY0tWJhdCbesda4CWzN02SFVK1jKe2+cMTm4xhtBfGHdmlN24ypbwYT/6
         96f7nfaLuX4LtKeIpDW3l5r8Nctwa7pwMthszMNdB0PqxUixhC/g2z6T4Kfgl+6x03us
         H+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bLwByC7BGaVevrVFtomE8pULrW13VxfSrNSZHQzlggA=;
        b=Djq5QryUxaLj1LWTmpfDTJe5dTEj/9I1fiDZj5ABKdkOAdJ6JRmAI33soC8jCwBl00
         rERz+FJKSRJQE7gfNMEKoat/5ed7OakTLQo1ueRKISdBraxvv5Cs/oyGBlMQPFa4qtS7
         LosbWS+4KCZiaEwjlsBhOowCSaf+IyiWpxGMqT/zCDhxoaxfnls7qxtgaib0hCDSsjxo
         G0WpiTyT5b20gbRhUd90OTwmi8eXhHeFftG63Ez3mrYhv6fG5PbaRPLW2yF+E2ZJbiCh
         5sBS9CVZxMQQt88gYlFu9R4PC6F7HKVy0wmeloCfWPcNhS/6TYbm9VQDXeztkFSUN+BN
         ImIg==
X-Gm-Message-State: AOAM532q/22xg+C1mrfpLg+j7NXenb+YvLZmusfUvvwA7pl4hWIJAvw2
        z8Z9Tneqr4nrmRvcrfnpvjWs/bfX8FC/hF6ZmkY=
X-Google-Smtp-Source: ABdhPJwK1iFImOklHFgEOdEhdpnuxTssz9A27yQLJWkKXyhXPBF9bsTlwyw4bHcDJfiprT9WWsqEfggAEM24Z7EqkhM=
X-Received: by 2002:aca:4b49:: with SMTP id y70mr250800oia.16.1629400837655;
 Thu, 19 Aug 2021 12:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210816195752.923028-1-jwcart2@gmail.com> <CAJfZ7=nn9pNt=nXZsQ=gPaLULGDy=wVvZV3GCywvLvmx3RQmEA@mail.gmail.com>
 <CAP+JOzQ2Ao_i9tAQb9Yr1C2G=9BE+iLMLESS_+rn0HQnys3S0g@mail.gmail.com> <CAJfZ7=my7UiXD9R-0e8vi-=waZX-dAsTTk=9C6YQbMbcpdZJow@mail.gmail.com>
In-Reply-To: <CAJfZ7=my7UiXD9R-0e8vi-=waZX-dAsTTk=9C6YQbMbcpdZJow@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 19 Aug 2021 15:20:26 -0400
Message-ID: <CAP+JOzQAjat1JFXAuWFmS3bVoSMmQfJZkzJe2itOcuKLoMddHQ@mail.gmail.com>
Subject: Re: [PATCH 0/7 v2] libsepol/cil: Line mark cleanup and fix
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 17, 2021 at 4:43 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Tue, Aug 17, 2021 at 10:15 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > On Tue, Aug 17, 2021 at 3:34 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> > >
> > > On Mon, Aug 16, 2021 at 9:57 PM James Carter <jwcart2@gmail.com> wrote:
> > > >
> > > > Patches 1-5 cleanup minor issues with CIL's line marks.
> > > >
> > > > Patches 6-7 fix the way line mark works so that the correct line
> > > > numbers will be given for nested line marks.
> > > >
> > > > Patch 8 writes out line mark information when writing out the AST.
> > >
> > > Hello,
> > > Patch 8 is missing from the v2 (the series only contains 7 patches).
> > > Should the previous patch 8 ("libsepol/cil: When writing AST use line
> > > marks for src_info nodes") be also considered for review?
> > >
> >
> > Yes, I got caught up in correcting patch 7 that I never applied patch
> > 8 when updating. There are no changes to that patch.
> > Thanks,
> > Jim
>
> OK. For all 8 patches:
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>

Merged.
Thanks,
Jim

> Thanks,
> Nicolas
>
> > > > Changes in v2
> > > > In patch 6, use cil_strpool_add("1") instead of "1"
> > > > In patch 7, fix confusing usage of pre_hll_expand and pre_hll_offset; initialize pre_hll_offset, change format specifiers in cil_tree.c to use %u instead of %d.
> > > >
> > > > James Carter (7):
> > > >   libsepol/cil: Check syntax of src_info statement
> > > >   libsepol/cil: Check the token type after getting the next token
> > > >   libsepol/cil: Check for valid line mark type immediately
> > > >   libsepol/cil: Push line mark state first when processing a line mark
> > > >   libsepol/cil: Create common string-to-unsigned-integer functions
> > > >   libsepol/cil: Add line mark kind and line number to src info
> > > >   libsepol/cil: Report correct high-level language line numbers
> > > >
> > > >  libsepol/cil/src/cil.c           |  70 ++++++++++++++++-
> > > >  libsepol/cil/src/cil_binary.c    |   9 ++-
> > > >  libsepol/cil/src/cil_build_ast.c |  77 ++++++++++--------
> > > >  libsepol/cil/src/cil_copy_ast.c  |   5 +-
> > > >  libsepol/cil/src/cil_internal.h  |   9 ++-
> > > >  libsepol/cil/src/cil_parser.c    | 129 +++++++++++++++----------------
> > > >  libsepol/cil/src/cil_tree.c      |  57 +++++++++-----
> > > >  libsepol/cil/src/cil_tree.h      |   4 +-
> > > >  8 files changed, 226 insertions(+), 134 deletions(-)
> > > >
> > > > --
> > > > 2.31.1
> > > >
> > >
>
