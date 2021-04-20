Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59700C433B4
	for <selinux@archiver.kernel.org>; Tue, 20 Apr 2021 07:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BF9961008
	for <selinux@archiver.kernel.org>; Tue, 20 Apr 2021 07:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhDTHyQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 20 Apr 2021 03:54:16 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:48044 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhDTHyJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 20 Apr 2021 03:54:09 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 4B5F0564DAA
        for <selinux@vger.kernel.org>; Tue, 20 Apr 2021 09:53:30 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id gq23-20020a17090b1057b0290151869af68bso294138pjb.4
        for <selinux@vger.kernel.org>; Tue, 20 Apr 2021 00:53:30 -0700 (PDT)
X-Gm-Message-State: AOAM533+xI1ZJ4sBKSO/V3a/bY8q7pHr4vTvqELRXSTakymplVMfmJiv
        XpBMQ+KNgpJQaeR/VcgRX6Leu2KUu4Wbbj+0pbE=
X-Google-Smtp-Source: ABdhPJyAt58GGN47lLNGGQ8tFqByAv71KGZFDgesaRNHD5dZz9UiBDM3wk58mDmOTMQiz1kKVqhWjkMyzOzOgPNBhBw=
X-Received: by 2002:a17:90b:34c:: with SMTP id fh12mr3507715pjb.114.1618905208909;
 Tue, 20 Apr 2021 00:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210330173920.281531-1-jwcart2@gmail.com> <CAP+JOzSE5w8595W75-FP0LW1W8LGW3XQ9G7sP1amnnXzMWs4tw@mail.gmail.com>
In-Reply-To: <CAP+JOzSE5w8595W75-FP0LW1W8LGW3XQ9G7sP1amnnXzMWs4tw@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 20 Apr 2021 09:53:17 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==1Y1L_u92XX1QQNWfuCO8SF-46+7EXr+x06d-1mEiQCg@mail.gmail.com>
Message-ID: <CAJfZ7==1Y1L_u92XX1QQNWfuCO8SF-46+7EXr+x06d-1mEiQCg@mail.gmail.com>
Subject: Re: [PATCH 00/12] Update checks for invalid rules in blocks
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Apr 20 09:53:30 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 19, 2021 at 8:26 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, Mar 30, 2021 at 1:39 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > Looking into a bug that OSS-Fuzz found led to patch 7, Check for
> > statements not allowed in optional blocks, which is the most important
> > patch in this series. Working on patch 7 led to fixing some other
> > problems with the checks for invalid rules, cleaning up some of the code,
> > and improving the CIL documentation.
> >
> > Patches 1, 2, 4, 5, and 10 are doing various cleanups.
> > Patch 3 fixes a bug that prevents the first rule in a block from being checked.
> > Patches 6, 7, 8, and 9 update the checks for invalid rules.
> > Patch 11 fixes a bug that prevented some error messages from being displayed.
> > Patch 12 updates the CIL documentation.
> >
> > There is still work to do in this area. I am not sure why sensitivity and
> > category statements are not allowed in blocks, but everything else is. That
> > is why I didn't add those checks when building the AST. It is not clear if
> > mls, handleunknown, defaultuser, defaultrole, defaulttype, defaultrange,
> > and policycap should be restricted to the global namespace.
> >
> > James Carter (12):
> >   libsepol/cil: Reorder checks for invalid rules when building AST
> >   libsepol/cil: Cleanup build AST helper functions
> >   libsepol/cil: Create new first child helper function for building AST
> >   libsepol/cil: Use AST to track blocks and optionals when resolving
> >   libsepol/cil: Reorder checks for invalid rules when resolving AST
> >   libsepol/cil: Sync checks for invalid rules in booleanifs
> >   libsepol/cil: Check for statements not allowed in optional blocks
> >   libsepol/cil: Sync checks for invalid rules in macros
> >   libsepol/cil: Do not allow tunable declarations in in-statements
> >   libsepol/cil: Make invalid statement error messages consistent
> >   libsepol/cil: Use CIL_ERR for error messages in cil_compile()
> >   secilc/docs: Update the CIL documentation for various blocks
> >
> >  libsepol/cil/src/cil.c                    |   8 +-
> >  libsepol/cil/src/cil_build_ast.c          | 193 ++++++++++++----------
> >  libsepol/cil/src/cil_resolve_ast.c        | 174 ++++++++-----------
> >  secilc/docs/cil_call_macro_statements.md  |   2 +
> >  secilc/docs/cil_conditional_statements.md |   6 +
> >  secilc/docs/cil_container_statements.md   |  28 ++--
> >  6 files changed, 205 insertions(+), 206 deletions(-)
> >
> > --
> > 2.26.3
> >
>
> This has been applied (with the whitespace error in the last patch fixed).
> Jim

Hi,
Thanks for these patches! I was on holiday in the past few weeks and
just got back. The applied patches look good to me. Moreover when I
run secilc on all the OSSFuzz reproducers I have studied so far, there
is no longer any crash :)

Nicolas

