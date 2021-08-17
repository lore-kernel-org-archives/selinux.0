Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEBCC4338F
	for <selinux@archiver.kernel.org>; Tue, 17 Aug 2021 20:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B767604D7
	for <selinux@archiver.kernel.org>; Tue, 17 Aug 2021 20:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbhHQUVT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Aug 2021 16:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbhHQUVB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Aug 2021 16:21:01 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68118C0604C6
        for <selinux@vger.kernel.org>; Tue, 17 Aug 2021 13:15:45 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id bf25so891803oib.10
        for <selinux@vger.kernel.org>; Tue, 17 Aug 2021 13:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K+ty+RIpeJ8eT7i2fbodvbo5Uh1GLJILdT/vx9dwNzI=;
        b=VcMm7d4Hq/RGFfovWCs7wrH5twZehXqpI6PwgDie6at3jTCCNL4vQfcQGFQW94x3jB
         0GgN5sjIm05GA8H3GB57dEqXjQg3xER1H35Gldcp1O8lJ+N+31D2GlQlSdgBpqGXFf7B
         XVPwdI6x5HtJQqgYBXUVAIHh1Veo8XoAIrH/KKGgAZ9MZLdqX+KsmdYPnIP07GM1XroG
         SkMpvK4zh1BAWa2bvO5D++fNvsFAxmcN04yIswUNBVwweSoxlGeBNFH9K0Iq6N4N+q1T
         TTRL20KWguQyAXr3gCff7aPxnEWcwiusaEf7ERqFJuv+VqvoT8FHn9VG6eNY+fLy2bWR
         V8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K+ty+RIpeJ8eT7i2fbodvbo5Uh1GLJILdT/vx9dwNzI=;
        b=TN3qlU30F5KD01eiDEz4TCzP/FgGMTLqfm0gDy0u1ltJs6bDQigzwGrNWfOwg6AEy1
         MIiUzZoYeN/Jk3Z3fF/v3lthp08AmFDEHy+4eOC7qudK8PcJNVip6Zf5YF1NIkJWftST
         FoUJhvcXCkFCf+ukymF9l556HC4pLpCCF0VIrhG7uj3GlQ2a2pg35c5lN2TBrg5YHvvw
         RhbsXLE0GIVCQhths5eYJAi+S5X+mmq9Hs0WK5Na6VbxYSq/bMp5ZMR7bxthpFa4/EyS
         UciylTJoSgA2Mdu9V+ZrLyvQCniJQAyliLslpDMv1gHG1jf5P0RPDJBvGyqX+Ms1ZPz2
         7LrQ==
X-Gm-Message-State: AOAM531V+bdjbAkbJsCeZemkLMiCOq/I9y98LHuDRIYNumgNlHDqtNBt
        DXurqZ68dpdr7mvipwj1clBXns6BPuiSHukrMJ4jYGVj65k=
X-Google-Smtp-Source: ABdhPJz56YCldc9m4C5yoJrWGuz++neyF/fvgexRMu11OAnDb9GJHjgMni5FHmUoyHEsYpXUzEQO0voU1F7CZ3YBHWE=
X-Received: by 2002:a05:6808:13c7:: with SMTP id d7mr3990748oiw.138.1629231344090;
 Tue, 17 Aug 2021 13:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210816195752.923028-1-jwcart2@gmail.com> <CAJfZ7=nn9pNt=nXZsQ=gPaLULGDy=wVvZV3GCywvLvmx3RQmEA@mail.gmail.com>
In-Reply-To: <CAJfZ7=nn9pNt=nXZsQ=gPaLULGDy=wVvZV3GCywvLvmx3RQmEA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 17 Aug 2021 16:15:33 -0400
Message-ID: <CAP+JOzQ2Ao_i9tAQb9Yr1C2G=9BE+iLMLESS_+rn0HQnys3S0g@mail.gmail.com>
Subject: Re: [PATCH 0/7 v2] libsepol/cil: Line mark cleanup and fix
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 17, 2021 at 3:34 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Mon, Aug 16, 2021 at 9:57 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > Patches 1-5 cleanup minor issues with CIL's line marks.
> >
> > Patches 6-7 fix the way line mark works so that the correct line
> > numbers will be given for nested line marks.
> >
> > Patch 8 writes out line mark information when writing out the AST.
>
> Hello,
> Patch 8 is missing from the v2 (the series only contains 7 patches).
> Should the previous patch 8 ("libsepol/cil: When writing AST use line
> marks for src_info nodes") be also considered for review?
>

Yes, I got caught up in correcting patch 7 that I never applied patch
8 when updating. There are no changes to that patch.
Thanks,
Jim

> Thanks,
> Nicolas
>
> > Changes in v2
> > In patch 6, use cil_strpool_add("1") instead of "1"
> > In patch 7, fix confusing usage of pre_hll_expand and pre_hll_offset; initialize pre_hll_offset, change format specifiers in cil_tree.c to use %u instead of %d.
> >
> > James Carter (7):
> >   libsepol/cil: Check syntax of src_info statement
> >   libsepol/cil: Check the token type after getting the next token
> >   libsepol/cil: Check for valid line mark type immediately
> >   libsepol/cil: Push line mark state first when processing a line mark
> >   libsepol/cil: Create common string-to-unsigned-integer functions
> >   libsepol/cil: Add line mark kind and line number to src info
> >   libsepol/cil: Report correct high-level language line numbers
> >
> >  libsepol/cil/src/cil.c           |  70 ++++++++++++++++-
> >  libsepol/cil/src/cil_binary.c    |   9 ++-
> >  libsepol/cil/src/cil_build_ast.c |  77 ++++++++++--------
> >  libsepol/cil/src/cil_copy_ast.c  |   5 +-
> >  libsepol/cil/src/cil_internal.h  |   9 ++-
> >  libsepol/cil/src/cil_parser.c    | 129 +++++++++++++++----------------
> >  libsepol/cil/src/cil_tree.c      |  57 +++++++++-----
> >  libsepol/cil/src/cil_tree.h      |   4 +-
> >  8 files changed, 226 insertions(+), 134 deletions(-)
> >
> > --
> > 2.31.1
> >
>
