Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14A3C43461
	for <selinux@archiver.kernel.org>; Thu, 15 Apr 2021 20:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B483613BB
	for <selinux@archiver.kernel.org>; Thu, 15 Apr 2021 20:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbhDOUoQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Apr 2021 16:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbhDOUoP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Apr 2021 16:44:15 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8A0C061574
        for <selinux@vger.kernel.org>; Thu, 15 Apr 2021 13:43:51 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id c12-20020a4ae24c0000b02901bad05f40e4so5678057oot.4
        for <selinux@vger.kernel.org>; Thu, 15 Apr 2021 13:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=pEM9zn7hCqq9I/q96AYpQa83fQpxz/w9Us/EMcmXzGg=;
        b=EMGvw/a8Mtl273VWiQaOeE76F68tfym+5p260mMiUXXkLFTJgll7ePCgdMHIvKJYJJ
         cbQa8hSQ3SfS3qo89OKAsIT0aHC8NW/1LPLqydOdA5FvWmzysQjNA4ATFLyxJrnOqpmL
         bJWt6W0SmwTS9nLIed+f93Kwk81OUGtYzdkaYPlqVDxNIUOaPQPn0j39vxFDkH3SZ2a3
         mlClzW4y5ybHlL4LmjheZe0F4a2YkjyC1I6sIEcev/ypT0wXlFrQTJCSHQMPxyFiDdec
         m/CdR6jgBpuXQZgn1WALwcK5RH9VGw8ZQNzRC7wspx0QtkHTEsU5FrtjL5rDEqcDgzmw
         Bkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=pEM9zn7hCqq9I/q96AYpQa83fQpxz/w9Us/EMcmXzGg=;
        b=mw0p/i4TmgWwVxHeaZIaSDyBOugJd+Rxy9EGb/asPSOIN7+rGmxdHkuDISBnSNbsdu
         J/3OOL6jnQ0GmIXZsHkRlVeX6JEd9ax9zZ5Q9AfEV5Xa/aLSKGBjsd8JOUodK90hggtC
         hz+K/dZeiBABS8due5z737urzIEqFymSoUhj7HuMcaHT8hNiKx+Fi6VZqUO9A3GfxCvB
         KxTTLkeNNW0IrfEiFCu/zD/hq9UF6qNAUMr9gV071xyAQLyAHvkHzXGqVaH9n59LaYVi
         LTM74yW/QADOeXssgGBzH23ajoiZO5YtK2jNYjzG7YXGG8C0MUjtoXy9QqCgHTEoLUnm
         uFSg==
X-Gm-Message-State: AOAM531nt7F1U3gOhiEXEb0MTNink950yPeuwKNoi2TWPJlhnumnBwb6
        e0BwLIZ4PCgG7zwvFJ1xHvjy8fNY1YrW4g3OcPS6K2TsLU4=
X-Google-Smtp-Source: ABdhPJyKTTlLZ+Ktrky5IycVRY8U/UA7cWsMZunqbqNAJnHDHTh1I5qY4/84nzIYF8QqdJju3bquxLGbrXs+73jYxIo=
X-Received: by 2002:a4a:a389:: with SMTP id s9mr742205ool.1.1618519428755;
 Thu, 15 Apr 2021 13:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210330173920.281531-1-jwcart2@gmail.com>
In-Reply-To: <20210330173920.281531-1-jwcart2@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 15 Apr 2021 16:43:37 -0400
Message-ID: <CAP+JOzT4WA7U1TZqgOjUqZj=K1ZR-LiJgXQKS_zQALLbnj1gcQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] Update checks for invalid rules in blocks
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 30, 2021 at 1:39 PM James Carter <jwcart2@gmail.com> wrote:
>
> Looking into a bug that OSS-Fuzz found led to patch 7, Check for
> statements not allowed in optional blocks, which is the most important
> patch in this series. Working on patch 7 led to fixing some other
> problems with the checks for invalid rules, cleaning up some of the code,
> and improving the CIL documentation.
>
> Patches 1, 2, 4, 5, and 10 are doing various cleanups.
> Patch 3 fixes a bug that prevents the first rule in a block from being checked.
> Patches 6, 7, 8, and 9 update the checks for invalid rules.
> Patch 11 fixes a bug that prevented some error messages from being displayed.
> Patch 12 updates the CIL documentation.
>
> There is still work to do in this area. I am not sure why sensitivity and
> category statements are not allowed in blocks, but everything else is. That
> is why I didn't add those checks when building the AST. It is not clear if
> mls, handleunknown, defaultuser, defaultrole, defaulttype, defaultrange,
> and policycap should be restricted to the global namespace.
>
> James Carter (12):
>   libsepol/cil: Reorder checks for invalid rules when building AST
>   libsepol/cil: Cleanup build AST helper functions
>   libsepol/cil: Create new first child helper function for building AST
>   libsepol/cil: Use AST to track blocks and optionals when resolving
>   libsepol/cil: Reorder checks for invalid rules when resolving AST
>   libsepol/cil: Sync checks for invalid rules in booleanifs
>   libsepol/cil: Check for statements not allowed in optional blocks
>   libsepol/cil: Sync checks for invalid rules in macros
>   libsepol/cil: Do not allow tunable declarations in in-statements
>   libsepol/cil: Make invalid statement error messages consistent
>   libsepol/cil: Use CIL_ERR for error messages in cil_compile()
>   secilc/docs: Update the CIL documentation for various blocks
>
>  libsepol/cil/src/cil.c                    |   8 +-
>  libsepol/cil/src/cil_build_ast.c          | 193 ++++++++++++----------
>  libsepol/cil/src/cil_resolve_ast.c        | 174 ++++++++-----------
>  secilc/docs/cil_call_macro_statements.md  |   2 +
>  secilc/docs/cil_conditional_statements.md |   6 +
>  secilc/docs/cil_container_statements.md   |  28 ++--
>  6 files changed, 205 insertions(+), 206 deletions(-)
>
> --
> 2.26.3
>

There hasn't been any comments on this patch set. I am planning on
merging it next week.

Jim
