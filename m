Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5346AC433DB
	for <selinux@archiver.kernel.org>; Thu, 21 Jan 2021 21:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2254E23381
	for <selinux@archiver.kernel.org>; Thu, 21 Jan 2021 21:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbhAUV02 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Jan 2021 16:26:28 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:41566 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbhAUV0K (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Jan 2021 16:26:10 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 46894564A06
        for <selinux@vger.kernel.org>; Thu, 21 Jan 2021 22:25:27 +0100 (CET)
Received: by mail-ot1-f44.google.com with SMTP id h14so3088436otr.4
        for <selinux@vger.kernel.org>; Thu, 21 Jan 2021 13:25:27 -0800 (PST)
X-Gm-Message-State: AOAM532sI7iG7DlIu290dDv0JLFdtdGXZgzyL0S9qjtOZU5Ng2onFcfD
        Ha2sYb54bcCYoeHiMroogvT/BZOAO9moDF6/Kqw=
X-Google-Smtp-Source: ABdhPJytoKcgAnQ+n05LEldxdR23eRn4XnrI+en14lNqjMmH8DjvuL/yX6EanE+S1gUiucX+Y67zkghIz9R/2BqQB8c=
X-Received: by 2002:a9d:66da:: with SMTP id t26mr836846otm.279.1611264326244;
 Thu, 21 Jan 2021 13:25:26 -0800 (PST)
MIME-Version: 1.0
References: <20210106184326.272726-1-jwcart2@gmail.com> <20210106184326.272726-2-jwcart2@gmail.com>
 <CAJfZ7=mG_f48C5vfDQ-zNXJOxdsg01Vc=cjS+8-G+avuHRHv3g@mail.gmail.com>
In-Reply-To: <CAJfZ7=mG_f48C5vfDQ-zNXJOxdsg01Vc=cjS+8-G+avuHRHv3g@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 21 Jan 2021 22:25:15 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=nrUtr1YaByyFxD9s0+U+kaZoGej0u3_rnPM3XfvYmJVQ@mail.gmail.com>
Message-ID: <CAJfZ7=nrUtr1YaByyFxD9s0+U+kaZoGej0u3_rnPM3XfvYmJVQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsepol/cil: Fix heap-use-after-free in __class_reset_perm_values()
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Jan 21 22:25:27 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 20, 2021 at 5:09 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Wed, Jan 6, 2021 at 7:43 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > Nicolas Iooss reports:
> >   A few weeks ago, OSS-Fuzz got configured in order to fuzz the CIL
> >   policy compiler (cf.
> >   https://github.com/SELinuxProject/selinux/issues/215 and
> >   https://github.com/google/oss-fuzz/pull/4790). It reported a bunch of
> >   simple issues, for which I will submit patches. There are also more
> >   subtle bugs, like the one triggered by this CIL policy:
> >
> >   (class CLASS (PERM))
> >   (classorder (CLASS))
> >   (sid SID)
> >   (sidorder (SID))
> >   (sensitivity SENS)
> >   (sensitivityorder (SENS))
> >   (type TYPE)
> >   (allow TYPE self (CLASS (PERM)))
> >
> >   (block b
> >       (optional o
> >           (sensitivitycategory SENS (C)) ; Non-existing category
> >   triggers disabling the optional
> >           (common COMMON (PERM1))
> >           (classcommon CLASS COMMON)
> >           (allow TYPE self (CLASS (PERM1)))
> >       )
> >   )
> >
> >   On my computer, secilc manages to build this policy fine, but when
> >   clang's Address Sanitizer is enabled, running secilc leads to the
> >   following report:
> >
> >   $ make -C libsepol/src CC=clang CFLAGS='-g -fsanitize=address' libsepol.a
> >   $ clang -g -fsanitize=address secilc/secilc.c libsepol/src/libsepol.a
> >   -o my_secilc
> >   $ ./my_secilc -vv testcase.cil
> >   Parsing testcase.cil
> >   Building AST from Parse Tree
> >   Destroying Parse Tree
> >   Resolving AST
> >   Failed to resolve sensitivitycategory statement at testcase.cil:12
> >   Disabling optional 'o' at testcase.cil:11
> >   Resetting declarations
> >   =================================================================
> >   ==181743==ERROR: AddressSanitizer: heap-use-after-free on address
> >   0x6070000000c0 at pc 0x55ff7e445d24 bp 0x7ffe7eecfba0 sp
> >   0x7ffe7eecfb98
> >   READ of size 4 at 0x6070000000c0 thread T0
> >       #0 0x55ff7e445d23 in __class_reset_perm_values
> >   /git/selinux-userspace/libsepol/src/../cil/src/cil_reset_ast.c:17:17
> >
> > The problem is that the optional branch is destroyed when it is disabled,
> > so the common has already been destroyed when the reset code tries to
> > access the number of common permissions, so that it can change the
> > value of the class permissions back to their original values.
> >
> > The solution is to count the number of class permissions and then
> > calculate the number of common permissions.
> >
> > Reported-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/cil/src/cil_reset_ast.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
> > index 43e6b88e..52e5f640 100644
> > --- a/libsepol/cil/src/cil_reset_ast.c
> > +++ b/libsepol/cil/src/cil_reset_ast.c
> > @@ -22,11 +22,12 @@ static int __class_reset_perm_values(__attribute__((unused)) hashtab_key_t k, ha
> >  static void cil_reset_class(struct cil_class *class)
> >  {
> >         if (class->common != NULL) {
> > -               struct cil_class *common = class->common;
> > -               cil_symtab_map(&class->perms, __class_reset_perm_values, &common->num_perms);
> > +               /* Must assume that the common has been destroyed */
> > +               int num_common_perms = class->num_perms - class->perms.nprim;
> > +               cil_symtab_map(&class->perms, __class_reset_perm_values, &num_common_perms);
> >                 /* during a re-resolve, we need to reset the common, so a classcommon
> >                  * statement isn't seen as a duplicate */
> > -               class->num_perms -= common->num_perms;
> > +               class->num_perms = class->perms.nprim;
> >                 class->common = NULL; /* Must make this NULL or there will be an error when re-resolving */
> >         }
> >         class->ordered = CIL_FALSE;
> > --
> > 2.25.4
> >
>
> For the 2 patches: Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org> (I
> also tested them and they work fine)
>
> Thanks!
> Nicolas

Merged. Thanks!
Nicolas

