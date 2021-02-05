Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF033C433DB
	for <selinux@archiver.kernel.org>; Fri,  5 Feb 2021 09:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC3FB64FB7
	for <selinux@archiver.kernel.org>; Fri,  5 Feb 2021 09:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhBEJp3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Feb 2021 04:45:29 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:56603 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhBEJnW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Feb 2021 04:43:22 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 28894561276
        for <selinux@vger.kernel.org>; Fri,  5 Feb 2021 10:42:35 +0100 (CET)
Received: by mail-ot1-f43.google.com with SMTP id s107so6288057otb.8
        for <selinux@vger.kernel.org>; Fri, 05 Feb 2021 01:42:35 -0800 (PST)
X-Gm-Message-State: AOAM533BCkPszwO9q020BisT6GzINhAffXnT0XbIW2WduH4keYOkVMdZ
        AZQIqI13+9TRTvh8HEBGw/5RLDZoir4fjt74hfU=
X-Google-Smtp-Source: ABdhPJxPBsULFAWy3W7i2/kzCxGTA6MQqHgCyIaPGdAwHcOpb4bep5ggG2eqI23Ysj4oiwlPQHPulJ0dXYB+7Uz7jzA=
X-Received: by 2002:a9d:66da:: with SMTP id t26mr2701787otm.279.1612518154018;
 Fri, 05 Feb 2021 01:42:34 -0800 (PST)
MIME-Version: 1.0
References: <20210203085846.6680-1-nicolas.iooss@m4x.org> <20210203085846.6680-3-nicolas.iooss@m4x.org>
 <CAP+JOzSk62FAj=xP5=8S2NCzdspn23NyxaMEVE4b+LvKyms3dw@mail.gmail.com>
In-Reply-To: <CAP+JOzSk62FAj=xP5=8S2NCzdspn23NyxaMEVE4b+LvKyms3dw@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Fri, 5 Feb 2021 10:42:23 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=n+HRY_0ApPM8GAjt9vVe+yuUGjCitt73TqtbaVdo9DFQ@mail.gmail.com>
Message-ID: <CAJfZ7=n+HRY_0ApPM8GAjt9vVe+yuUGjCitt73TqtbaVdo9DFQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] libsepol: include header files in source files when
 matching declarations
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri Feb  5 10:42:35 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 4, 2021 at 8:22 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Feb 3, 2021 at 4:00 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > It is good practise in C to include the header file that specifies the
> > prototype of functions which are defined in the source file. Otherwise,
> > the function prototypes which be different, which could cause unexpected
> > issues.
> >
> > Add the include directives to do this.
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.
Nicolas

> > ---
> >  libsepol/cil/src/cil_find.c      | 1 +
> >  libsepol/cil/src/cil_fqn.c       | 1 +
> >  libsepol/cil/src/cil_mem.c       | 1 +
> >  libsepol/cil/src/cil_parser.c    | 1 +
> >  libsepol/cil/src/cil_policy.c    | 1 +
> >  libsepol/cil/src/cil_reset_ast.c | 1 +
> >  libsepol/src/kernel_to_cil.c     | 1 +
> >  libsepol/src/kernel_to_conf.c    | 1 +
> >  libsepol/src/services.c          | 1 +
> >  9 files changed, 9 insertions(+)
> >
> > diff --git a/libsepol/cil/src/cil_find.c b/libsepol/cil/src/cil_find.c
> > index 638b675db826..3898725f18d5 100644
> > --- a/libsepol/cil/src/cil_find.c
> > +++ b/libsepol/cil/src/cil_find.c
> > @@ -30,6 +30,7 @@
> >  #include <sepol/policydb/ebitmap.h>
> >
> >  #include "cil_internal.h"
> > +#include "cil_find.h"
> >  #include "cil_flavor.h"
> >  #include "cil_list.h"
> >  #include "cil_log.h"
> > diff --git a/libsepol/cil/src/cil_fqn.c b/libsepol/cil/src/cil_fqn.c
> > index 2e76f8737754..097222a83da9 100644
> > --- a/libsepol/cil/src/cil_fqn.c
> > +++ b/libsepol/cil/src/cil_fqn.c
> > @@ -31,6 +31,7 @@
> >  #include <stdio.h>
> >  #include <string.h>
> >
> > +#include "cil_fqn.h"
> >  #include "cil_internal.h"
> >  #include "cil_log.h"
> >  #include "cil_strpool.h"
> > diff --git a/libsepol/cil/src/cil_mem.c b/libsepol/cil/src/cil_mem.c
> > index f73021b58d50..8e4a1d246f2c 100644
> > --- a/libsepol/cil/src/cil_mem.c
> > +++ b/libsepol/cil/src/cil_mem.c
> > @@ -33,6 +33,7 @@
> >  #include <string.h>
> >
> >  #include "cil_log.h"
> > +#include "cil_mem.h"
> >
> >  void *cil_malloc(size_t size)
> >  {
> > diff --git a/libsepol/cil/src/cil_parser.c b/libsepol/cil/src/cil_parser.c
> > index b62043b95806..0038eed6dd1b 100644
> > --- a/libsepol/cil/src/cil_parser.c
> > +++ b/libsepol/cil/src/cil_parser.c
> > @@ -38,6 +38,7 @@
> >  #include "cil_mem.h"
> >  #include "cil_tree.h"
> >  #include "cil_lexer.h"
> > +#include "cil_parser.h"
> >  #include "cil_strpool.h"
> >  #include "cil_stack.h"
> >
> > diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
> > index 06d7d74e54c3..74edb34575ea 100644
> > --- a/libsepol/cil/src/cil_policy.c
> > +++ b/libsepol/cil/src/cil_policy.c
> > @@ -41,6 +41,7 @@
> >  #include "cil_flavor.h"
> >  #include "cil_find.h"
> >  #include "cil_mem.h"
> > +#include "cil_policy.h"
> >  #include "cil_tree.h"
> >  #include "cil_list.h"
> >  #include "cil_symtab.h"
> > diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
> > index 52e5f64011d2..3da1b9a64167 100644
> > --- a/libsepol/cil/src/cil_reset_ast.c
> > +++ b/libsepol/cil/src/cil_reset_ast.c
> > @@ -2,6 +2,7 @@
> >  #include "cil_internal.h"
> >  #include "cil_log.h"
> >  #include "cil_list.h"
> > +#include "cil_reset_ast.h"
> >  #include "cil_symtab.h"
> >
> >  static inline void cil_reset_classperms_list(struct cil_list *cp_list);
> > diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> > index c247b32f9e75..a146ac514018 100644
> > --- a/libsepol/src/kernel_to_cil.c
> > +++ b/libsepol/src/kernel_to_cil.c
> > @@ -16,6 +16,7 @@
> >  #define IPPROTO_SCTP 132
> >  #endif
> >
> > +#include <sepol/kernel_to_cil.h>
> >  #include <sepol/policydb/avtab.h>
> >  #include <sepol/policydb/conditional.h>
> >  #include <sepol/policydb/hashtab.h>
> > diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
> > index 62bf706c1aa0..a22f196df9e9 100644
> > --- a/libsepol/src/kernel_to_conf.c
> > +++ b/libsepol/src/kernel_to_conf.c
> > @@ -15,6 +15,7 @@
> >  #define IPPROTO_SCTP 132
> >  #endif
> >
> > +#include <sepol/kernel_to_conf.h>
> >  #include <sepol/policydb/avtab.h>
> >  #include <sepol/policydb/conditional.h>
> >  #include <sepol/policydb/hashtab.h>
> > diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> > index 72b39657cd2e..6596431c38e2 100644
> > --- a/libsepol/src/services.c
> > +++ b/libsepol/src/services.c
> > @@ -59,6 +59,7 @@
> >  #include <sepol/policydb/services.h>
> >  #include <sepol/policydb/conditional.h>
> >  #include <sepol/policydb/util.h>
> > +#include <sepol/sepol.h>
> >
> >  #include "debug.h"
> >  #include "private.h"
> > --
> > 2.30.0
> >

