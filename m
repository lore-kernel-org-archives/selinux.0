Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0262EC433E0
	for <selinux@archiver.kernel.org>; Wed, 17 Mar 2021 08:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C631C64E42
	for <selinux@archiver.kernel.org>; Wed, 17 Mar 2021 08:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbhCQIj1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Mar 2021 04:39:27 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:57623 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhCQIjR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Mar 2021 04:39:17 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id A71A95600AC
        for <selinux@vger.kernel.org>; Wed, 17 Mar 2021 09:39:15 +0100 (CET)
Received: by mail-pl1-f179.google.com with SMTP id 30so427377ple.4
        for <selinux@vger.kernel.org>; Wed, 17 Mar 2021 01:39:15 -0700 (PDT)
X-Gm-Message-State: AOAM532RCdOJ05WLPLlcemSuUhlxtrK4INVLe0D+hTVgRinaoQQswN0t
        LKm6p1c6oxzvgtD4GmBffnRT1owXc9vs8/u2kwg=
X-Google-Smtp-Source: ABdhPJyAO9wy2R0b+FGJiRBKvxkW5Yr0AbGinCeDl/25x+tqAUec4YnK/TysnadSv+wKCiVLVhkVeNgIU7IH2sDTEWc=
X-Received: by 2002:a17:902:b781:b029:e4:545d:77 with SMTP id
 e1-20020a170902b781b02900e4545d0077mr3521745pls.59.1615970354341; Wed, 17 Mar
 2021 01:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210314201651.474432-1-nicolas.iooss@m4x.org>
 <20210314201651.474432-2-nicolas.iooss@m4x.org> <CAP+JOzTEmNNqx_ajLh7SO3F9D1rz+h00KgtzdgrqGAAPz17xjA@mail.gmail.com>
In-Reply-To: <CAP+JOzTEmNNqx_ajLh7SO3F9D1rz+h00KgtzdgrqGAAPz17xjA@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 17 Mar 2021 09:39:03 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mPFY=f54Q7c1Poo+zxtw6QLDHMzto2rgF8xTXPyuW91g@mail.gmail.com>
Message-ID: <CAJfZ7=mPFY=f54Q7c1Poo+zxtw6QLDHMzto2rgF8xTXPyuW91g@mail.gmail.com>
Subject: Re: [PATCH 2/6] libsepol/cil: make cil_post_fc_fill_data static
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Mar 17 09:39:16 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 15, 2021 at 10:03 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Sun, Mar 14, 2021 at 4:22 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > cil_post_fc_fill_data() is not used outside of cil_post.c, and is not
> > exported in libsepol.so. Make it static, in order to ease the analysis
> > of static analyzers.
> >
> > While at it, make its path argument "const char*" and the fields of
> > "struct fc_data" "unsigned int" or "size_t", in order to make the types
> > better match the values.
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Acked-by: James Carter <jwcart2@gmail.com>

I merged patches 2 to 6 of this series. Patch 1 still has discussions.

Thanks,
Nicolas

> > ---
> >  libsepol/cil/src/cil_post.c | 11 +++++++++--
> >  libsepol/cil/src/cil_post.h |  7 -------
> >  2 files changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> > index 5f9cf4efd242..783929e50df8 100644
> > --- a/libsepol/cil/src/cil_post.c
> > +++ b/libsepol/cil/src/cil_post.c
> > @@ -27,6 +27,7 @@
> >   * either expressed or implied, of Tresys Technology, LLC.
> >   */
> >
> > +#include <stddef.h>
> >  #include <stdlib.h>
> >  #include <stdio.h>
> >  #include <string.h>
> > @@ -50,6 +51,12 @@
> >  #define GEN_REQUIRE_ATTR "cil_gen_require" /* Also in libsepol/src/module_to_cil.c */
> >  #define TYPEATTR_INFIX "_typeattr_"        /* Also in libsepol/src/module_to_cil.c */
> >
> > +struct fc_data {
> > +       unsigned int meta;
> > +       size_t stem_len;
> > +       size_t str_len;
> > +};
> > +
> >  static int __cil_expr_to_bitmap(struct cil_list *expr, ebitmap_t *out, int max, struct cil_db *db);
> >  static int __cil_expr_list_to_bitmap(struct cil_list *expr_list, ebitmap_t *out, int max, struct cil_db *db);
> >
> > @@ -156,9 +163,9 @@ static int cil_verify_is_list(struct cil_list *list, enum cil_flavor flavor)
> >         return CIL_TRUE;
> >  }
> >
> > -void cil_post_fc_fill_data(struct fc_data *fc, char *path)
> > +static void cil_post_fc_fill_data(struct fc_data *fc, const char *path)
> >  {
> > -       int c = 0;
> > +       size_t c = 0;
> >         fc->meta = 0;
> >         fc->stem_len = 0;
> >         fc->str_len = 0;
> > diff --git a/libsepol/cil/src/cil_post.h b/libsepol/cil/src/cil_post.h
> > index 3d5415486b77..b1d2206f9ef6 100644
> > --- a/libsepol/cil/src/cil_post.h
> > +++ b/libsepol/cil/src/cil_post.h
> > @@ -30,13 +30,6 @@
> >  #ifndef CIL_POST_H_
> >  #define CIL_POST_H_
> >
> > -struct fc_data {
> > -       int meta;
> > -       int stem_len;
> > -       int str_len;
> > -};
> > -
> > -void cil_post_fc_fill_data(struct fc_data *fc, char *path);
> >  int cil_post_filecon_compare(const void *a, const void *b);
> >  int cil_post_ibpkeycon_compare(const void *a, const void *b);
> >  int cil_post_portcon_compare(const void *a, const void *b);
> > --
> > 2.30.2
> >

