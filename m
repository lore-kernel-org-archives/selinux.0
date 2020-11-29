Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B557C3E8C5
	for <selinux@archiver.kernel.org>; Sun, 29 Nov 2020 19:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C970206CA
	for <selinux@archiver.kernel.org>; Sun, 29 Nov 2020 19:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgK2Tgs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 29 Nov 2020 14:36:48 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:40588 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgK2Tgs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 29 Nov 2020 14:36:48 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 5C2675651A1
        for <selinux@vger.kernel.org>; Sun, 29 Nov 2020 20:36:05 +0100 (CET)
Received: by mail-ot1-f50.google.com with SMTP id z24so9390407oto.6
        for <selinux@vger.kernel.org>; Sun, 29 Nov 2020 11:36:05 -0800 (PST)
X-Gm-Message-State: AOAM530SAgIFB7PMy0ItC6XoQk9a2yNB0ErgoR8/xEucCl9jyIW/194y
        e3gbnNtDoQPs+hTGOyrMmMJzF5LlMbtDJLqX6fI=
X-Google-Smtp-Source: ABdhPJzFBblEzaRO1B2ULdFXH7N9lpFkoI7baYQzqLA7Ohz0b4SVdzBR6TgmwOW93s3dQlg3VWsC9T9yEJzBaBvJtfE=
X-Received: by 2002:a05:6830:1dc4:: with SMTP id a4mr13618090otj.361.1606678564230;
 Sun, 29 Nov 2020 11:36:04 -0800 (PST)
MIME-Version: 1.0
References: <20201116220702.174765-1-jwcart2@gmail.com> <CAJfZ7=n1=rMSAYDbX++Nwn4OrF5E11CzAaK5+pjto4e8u5yV+A@mail.gmail.com>
In-Reply-To: <CAJfZ7=n1=rMSAYDbX++Nwn4OrF5E11CzAaK5+pjto4e8u5yV+A@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 29 Nov 2020 20:35:53 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==W1oGWjsDC-z9eqBAGdG5sR5v0V8F8u_MD1=i0iJyqmw@mail.gmail.com>
Message-ID: <CAJfZ7==W1oGWjsDC-z9eqBAGdG5sR5v0V8F8u_MD1=i0iJyqmw@mail.gmail.com>
Subject: Re: [PATCH 0/6] libsepol/cil: Various CIL cleanups
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Nov 29 20:36:05 2020 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 24, 2020 at 8:25 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Mon, Nov 16, 2020 at 11:07 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > Cleaning up the CIL codebase a bit. No changes to how CIL works.
> >
> > James Carter (6):
> >   libsepol/cil: cil_tree_walk() helpers should use CIL_TREE_SKIP_*
> >   libsepol/cil: Git rid of unnecessary check in cil_gen_node()
> >   libsepol/cil: Remove unused field from struct cil_args_resolve
> >   libsepol/cil: Remove unnecessary assignment in
> >     cil_resolve_name_keep_aliases()
> >   libsepol/cil: Use the macro NODE() whenever possible
> >   libspepol/cil: Use the macro FLAVOR() whenever possible
> >
> >  libsepol/cil/src/cil.c             |  2 +-
> >  libsepol/cil/src/cil_binary.c      | 12 +++----
> >  libsepol/cil/src/cil_build_ast.c   |  6 ++--
> >  libsepol/cil/src/cil_find.c        | 10 +++---
> >  libsepol/cil/src/cil_post.c        |  2 +-
> >  libsepol/cil/src/cil_resolve_ast.c | 55 +++++++++++++-----------------
> >  libsepol/cil/src/cil_tree.c        |  2 +-
> >  7 files changed, 41 insertions(+), 48 deletions(-)
> >
> > --
> > 2.25.4
> >
>
> Hello,
> The content of these patches look good but there are two misspellings
> in the commit messages:
>
> * Patch 2 : "libsepol/cil: Git rid of unnecessary check in
> cil_gen_node()" -> "Get" instead of "Git"
> * Patch 6 : "libspepol/cil: Use the macro FLAVOR() whenever possible"
> -> "libsepol"
>
> With these changes:
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Feel free to apply the patches yourself, with the misspellings fixes.

Merged, with the two spelling fixes.
Thanks,
Nicolas

