Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A861C4743D
	for <selinux@archiver.kernel.org>; Fri,  4 Jun 2021 16:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09B6C613B4
	for <selinux@archiver.kernel.org>; Fri,  4 Jun 2021 16:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhFDRBZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Jun 2021 13:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhFDRBZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Jun 2021 13:01:25 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1161BC061766
        for <selinux@vger.kernel.org>; Fri,  4 Jun 2021 09:59:23 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so9675768otc.12
        for <selinux@vger.kernel.org>; Fri, 04 Jun 2021 09:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ewCPOWq7oQwmP7b8Hg+kvFDKfyr8fyL6aLRpENSaWBg=;
        b=kso3u06rTaqWBfmqoGwko+7LHDQfgHUTbxqQm1fuLJmvGs51VA6jaUQpHfGSzqqHWw
         tG48mVkZ/weDouXHwmPtAxtew+kOJ7/7h2mvvyzC/351l8zQ/R54XhQ8qNPpqiMkrBhh
         GKOl8xIOZCXvkWfgujxeLPkX2HeUQK8w+Cf40YJsdWPKoRQ19Qg5iBZabGmnw6bg09vz
         6OtKtTkalh4fE5I5Fny/kBa4nMgblQtTYCppqo7SmhVcNzzAvKz0Bi4gDVMT9FVPr62c
         as/4w10MlxgQLbmVg62jLFKqdOiSQfoTjut158ZhWNyTsKx6euMxPQSuQuKdNN/Gkvw0
         PPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ewCPOWq7oQwmP7b8Hg+kvFDKfyr8fyL6aLRpENSaWBg=;
        b=RvfkypMeG/3CHx3X9Mic5CkRu8NUKeKQiNE2TfYDGKFuiBkDvyoiqtfvADgyFQ1ZIF
         +vcPfgVXvoeGlRV3qKvvJOUvHImXZBg9iMBlpNLik8qGNGpDLG5TfYpLWYuO63IiC+7I
         o/UNM01K/vz/LdQkJ3bqHb4yUv1RdqV/KriBLwm6d51Ojt29KbT9/FxaMcjK1xWV2Iev
         /eBZVLUIxbfAJ9RUlvqdtr2KS537bZ+xZKyBTxy39G4F/Slr3a7r6sUjI2U0uMbg5Tj0
         grGlENdjUCeBeicPByAQIudmUBw9GFpCJlPn43Xh8OFL+bnaJLRFIuAtAClN7E9yu21I
         XnfQ==
X-Gm-Message-State: AOAM530JXKWeU5K7QnP0wqxAlTocphb9h1IQ92mP/JeYF45bQrYxdmVL
        CTKbou1ThAnjSp7xltxNmve2kv5MBYMbXZOlOq9JIL8f
X-Google-Smtp-Source: ABdhPJzAK5BmFGCa+2ocd9f0L+hv2fEAyYX1XwS/EcaWnrt19praN4qx+BEnx1RjgbKYMuPksN/+E49eEcqDI9/CzAg=
X-Received: by 2002:a05:6830:16c7:: with SMTP id l7mr4542870otr.196.1622825962334;
 Fri, 04 Jun 2021 09:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210511200301.407855-1-jwcart2@gmail.com> <CAP+JOzS83Foo1eeXYcaLs2TxgoJRzh_ednHrn2+B-PrM97CU2Q@mail.gmail.com>
In-Reply-To: <CAP+JOzS83Foo1eeXYcaLs2TxgoJRzh_ednHrn2+B-PrM97CU2Q@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 4 Jun 2021 12:59:11 -0400
Message-ID: <CAP+JOzREpiUJEG+Nw1QLxXzeR-MutQm76HBCgeosq6Mqwi-BdQ@mail.gmail.com>
Subject: Re: [PATCH 0/5 v2] secilc/cil: Fix name resolution for macro calls
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 3, 2021 at 1:06 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, May 11, 2021 at 4:03 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > This patch series fixes name resolution within expanded macro calls and
> > with call arguments.
> >
> > The first patch is same as in v1.
> > Patches 2-4 replace patch 2 in v1. The original way of fixing name
> > resolution of call arguments did not work if a disabled optional
> > forced a reset.
> > Patch 5 is the same as patch 3 in v1.
> >
> > James Carter (5):
> >   libsepol/cil: Make name resolution in macros work as documented
> >   libsepol/cil: Do not add NULL node when inserting key into symtab
> >   libsepo/cil: Refactor macro call resolution
> >   libsepol/cil: Do not resolve arguments to declarations in the call
> >   secilc/docs: Relocate and reword macro call name resolution order
> >
> >  libsepol/cil/src/cil_internal.h          |   1 -
> >  libsepol/cil/src/cil_resolve_ast.c       | 635 ++++++++++++-----------
> >  libsepol/cil/src/cil_symtab.c            |   8 +-
> >  secilc/docs/cil_call_macro_statements.md |  24 +-
> >  4 files changed, 354 insertions(+), 314 deletions(-)
> >
> > --
> > 2.26.3
> >
>
> There hasn't been any comments on this series, and it has been more
> than three weeks since I sent it, so I plan on merging it tomorrow.
> Jim

This series has been merged.
Jim
