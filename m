Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8FBC11F65
	for <selinux@archiver.kernel.org>; Wed, 30 Jun 2021 19:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CD6D61474
	for <selinux@archiver.kernel.org>; Wed, 30 Jun 2021 19:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbhF3TsU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Jun 2021 15:48:20 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:57147 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbhF3TsU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Jun 2021 15:48:20 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 714C656128D
        for <selinux@vger.kernel.org>; Wed, 30 Jun 2021 21:45:49 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id d12so3403150pgd.9
        for <selinux@vger.kernel.org>; Wed, 30 Jun 2021 12:45:49 -0700 (PDT)
X-Gm-Message-State: AOAM532ywR2oe+1g+hxSBeEWwnjoxLMqrLkBflr47/vf737svRO1Vh6f
        zo0EfCijQ21W7zuwhV8H1tIxlS+v232eS2ZMr/k=
X-Google-Smtp-Source: ABdhPJxzofeie2AsiG8mzgYAgvSYbuEvWfqxB2kWGTel6u2JlkcBqRHEfGukpK2EkzoVPoP7VFZBcnpS7H7GHuVlNE8=
X-Received: by 2002:a65:60d3:: with SMTP id r19mr6424410pgv.94.1625082348100;
 Wed, 30 Jun 2021 12:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210626123443.12149-1-nicolas.iooss@m4x.org> <CAP+JOzS4XPRfBj+uiisUyjthKcR1vWMhL0_6++yNxM7LRnRmuw@mail.gmail.com>
In-Reply-To: <CAP+JOzS4XPRfBj+uiisUyjthKcR1vWMhL0_6++yNxM7LRnRmuw@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 30 Jun 2021 21:45:37 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=kSg6kRQvbPiRVuvMFNhLg-TvjujVjRPYUPxO0AiYjD-A@mail.gmail.com>
Message-ID: <CAJfZ7=kSg6kRQvbPiRVuvMFNhLg-TvjujVjRPYUPxO0AiYjD-A@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: make array cil_sym_sizes const
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Jun 30 21:45:49 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 28, 2021 at 10:23 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Sat, Jun 26, 2021 at 8:35 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > The values of this table are never modified.
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Applied. Thanks!

Nicolas

> > ---
> >  libsepol/cil/src/cil.c          | 4 ++--
> >  libsepol/cil/src/cil_internal.h | 4 ++--
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> > index 9d5038d91add..32e8b3cf419e 100644
> > --- a/libsepol/cil/src/cil.c
> > +++ b/libsepol/cil/src/cil.c
> > @@ -52,7 +52,7 @@
> >  #include "cil_strpool.h"
> >  #include "cil_write_ast.h"
> >
> > -int cil_sym_sizes[CIL_SYM_ARRAY_NUM][CIL_SYM_NUM] = {
> > +const int cil_sym_sizes[CIL_SYM_ARRAY_NUM][CIL_SYM_NUM] = {
> >         {64, 64, 64, 1 << 13, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64},
> >         {8, 8, 8, 32, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
> >         {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
> > @@ -1882,7 +1882,7 @@ void cil_set_policy_version(struct cil_db *db, int policy_version)
> >         db->policy_version = policy_version;
> >  }
> >
> > -void cil_symtab_array_init(symtab_t symtab[], int symtab_sizes[CIL_SYM_NUM])
> > +void cil_symtab_array_init(symtab_t symtab[], const int symtab_sizes[CIL_SYM_NUM])
> >  {
> >         uint32_t i = 0;
> >         for (i = 0; i < CIL_SYM_NUM; i++) {
> > diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
> > index 8b9aeabf66e4..3211fc355ec9 100644
> > --- a/libsepol/cil/src/cil_internal.h
> > +++ b/libsepol/cil/src/cil_internal.h
> > @@ -275,7 +275,7 @@ enum cil_sym_array {
> >         CIL_SYM_ARRAY_NUM
> >  };
> >
> > -extern int cil_sym_sizes[CIL_SYM_ARRAY_NUM][CIL_SYM_NUM];
> > +extern const int cil_sym_sizes[CIL_SYM_ARRAY_NUM][CIL_SYM_NUM];
> >
> >  #define CIL_CLASS_SYM_SIZE     256
> >  #define CIL_PERMS_PER_CLASS (sizeof(sepol_access_vector_t) * 8)
> > @@ -981,7 +981,7 @@ int cil_userprefixes_to_string(struct cil_db *db, char **out, size_t *size);
> >  int cil_selinuxusers_to_string(struct cil_db *db, char **out, size_t *size);
> >  int cil_filecons_to_string(struct cil_db *db, char **out, size_t *size);
> >
> > -void cil_symtab_array_init(symtab_t symtab[], int symtab_sizes[CIL_SYM_NUM]);
> > +void cil_symtab_array_init(symtab_t symtab[], const int symtab_sizes[CIL_SYM_NUM]);
> >  void cil_symtab_array_destroy(symtab_t symtab[]);
> >  void cil_destroy_ast_symtabs(struct cil_tree_node *root);
> >  int cil_get_symtab(struct cil_tree_node *ast_node, symtab_t **symtab, enum cil_sym_index sym_index);
> > --
> > 2.32.0
> >

