Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C4EC433B4
	for <selinux@archiver.kernel.org>; Fri, 30 Apr 2021 19:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80A076146D
	for <selinux@archiver.kernel.org>; Fri, 30 Apr 2021 19:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhD3TZX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Apr 2021 15:25:23 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:39384 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbhD3TZW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Apr 2021 15:25:22 -0400
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 4B629564E59
        for <selinux@vger.kernel.org>; Fri, 30 Apr 2021 21:24:25 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id p2so34625388pgh.4
        for <selinux@vger.kernel.org>; Fri, 30 Apr 2021 12:24:25 -0700 (PDT)
X-Gm-Message-State: AOAM532Ub0No2tZJfF9Mf5Q0ZpBjWUtM3gLgR68tzvyT8oFI8JPawYrm
        1ihoP3pU4Ur3q/Oqs1nDEmlH5juBrNG+NMc8TAY=
X-Google-Smtp-Source: ABdhPJwJf3dw328pGpx7TA5IbwV4FmjQx7pldHdjcKt+HhhYc74CQJf3sXNUvTeW5u9eCQwTXXdvfDTj/C9EfdBBU68=
X-Received: by 2002:a05:6a00:162c:b029:27d:a3d:4afc with SMTP id
 e12-20020a056a00162cb029027d0a3d4afcmr6073694pfc.11.1619810663917; Fri, 30
 Apr 2021 12:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210422064604.270374-1-nicolas.iooss@m4x.org> <CAP+JOzRS4Q684v+y-Q0hAb_AsoQQqKi1XG0bncOWdSt2L+iRsg@mail.gmail.com>
In-Reply-To: <CAP+JOzRS4Q684v+y-Q0hAb_AsoQQqKi1XG0bncOWdSt2L+iRsg@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Fri, 30 Apr 2021 21:24:12 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=mHWBuy+u7V0U2tF+nwg=-YT57Cm3idvdkaXkdKFJfGSg@mail.gmail.com>
Message-ID: <CAJfZ7=mHWBuy+u7V0U2tF+nwg=-YT57Cm3idvdkaXkdKFJfGSg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: use checked arithmetic builtin to perform safe addition
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri Apr 30 21:24:25 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 29, 2021 at 10:24 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Thu, Apr 22, 2021 at 2:46 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > Checking whether an overflow occurred after adding two values can be
> > achieved using checked arithmetic builtin functions such as:
> >
> >     bool __builtin_add_overflow(type1 x, type2 y, type3 *sum);
> >
> > This function is available at least in clang
> > (at least since clang 3.8.0,
> > https://releases.llvm.org/3.8.0/tools/clang/docs/LanguageExtensions.html#checked-arithmetic-builtins)
> > and gcc
> > (https://gcc.gnu.org/onlinedocs/gcc/Integer-Overflow-Builtins.html,
> > since gcc 5 according to https://gcc.gnu.org/gcc-5/changes.html)
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Applied.

Thanks,
Nicolas
> > ---
> >  libsepol/src/context_record.c | 29 ++++++-----------------------
> >  libsepol/src/module_to_cil.c  |  6 ++----
> >  2 files changed, 8 insertions(+), 27 deletions(-)
> >
> > diff --git a/libsepol/src/context_record.c b/libsepol/src/context_record.c
> > index 317a42133884..435f788058c4 100644
> > --- a/libsepol/src/context_record.c
> > +++ b/libsepol/src/context_record.c
> > @@ -267,31 +267,13 @@ int sepol_context_from_string(sepol_handle_t * handle,
> >         return STATUS_ERR;
> >  }
> >
> > -
> > -static inline int safe_sum(size_t *sum, const size_t augends[], const size_t cnt) {
> > -
> > -       size_t a, i;
> > -
> > -       *sum = 0;
> > -       for(i=0; i < cnt; i++) {
> > -               /* sum should not be smaller than the addend */
> > -               a = augends[i];
> > -               *sum += a;
> > -               if (*sum < a) {
> > -                       return i;
> > -               }
> > -       }
> > -
> > -       return 0;
> > -}
> > -
> >  int sepol_context_to_string(sepol_handle_t * handle,
> >                             const sepol_context_t * con, char **str_ptr)
> >  {
> >
> >         int rc;
> >         char *str = NULL;
> > -       size_t total_sz, err;
> > +       size_t total_sz = 0, i;
> >         const size_t sizes[] = {
> >                         strlen(con->user),                 /* user length */
> >                         strlen(con->role),                 /* role length */
> > @@ -300,10 +282,11 @@ int sepol_context_to_string(sepol_handle_t * handle,
> >                         ((con->mls) ? 3 : 2) + 1           /* mls has extra ":" also null byte */
> >         };
> >
> > -       err = safe_sum(&total_sz, sizes, ARRAY_SIZE(sizes));
> > -       if (err) {
> > -               ERR(handle, "invalid size, overflow at position: %zu", err);
> > -               goto err;
> > +       for (i = 0; i < ARRAY_SIZE(sizes); i++) {
> > +               if (__builtin_add_overflow(total_sz, sizes[i], &total_sz)) {
> > +                       ERR(handle, "invalid size, overflow at position: %zu", i);
> > +                       goto err;
> > +               }
> >         }
> >
> >         str = (char *)malloc(total_sz);
> > diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> > index 58df0d4f6d77..496693f4616e 100644
> > --- a/libsepol/src/module_to_cil.c
> > +++ b/libsepol/src/module_to_cil.c
> > @@ -1134,16 +1134,14 @@ static int name_list_to_string(char **names, unsigned int num_names, char **stri
> >         char *strpos;
> >
> >         for (i = 0; i < num_names; i++) {
> > -               len += strlen(names[i]);
> > -               if (len < strlen(names[i])) {
> > +               if (__builtin_add_overflow(len, strlen(names[i]), &len)) {
> >                         log_err("Overflow");
> >                         return -1;
> >                 }
> >         }
> >
> >         // add spaces + null terminator
> > -       len += num_names;
> > -       if (len < (size_t)num_names) {
> > +       if (__builtin_add_overflow(len, (size_t)num_names, &len)) {
> >                 log_err("Overflow");
> >                 return -1;
> >         }
> > --
> > 2.31.0
> >

