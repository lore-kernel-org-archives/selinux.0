Return-Path: <SRS0=fPvm=D2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URI_HEX autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925D3C43467
	for <selinux@archiver.kernel.org>; Mon, 19 Oct 2020 21:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AB2322370
	for <selinux@archiver.kernel.org>; Mon, 19 Oct 2020 21:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733259AbgJSViB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Oct 2020 17:38:01 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:44075 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729382AbgJSViB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Oct 2020 17:38:01 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 7B64A564C52
        for <selinux@vger.kernel.org>; Mon, 19 Oct 2020 23:29:00 +0200 (CEST)
Received: by mail-oi1-f180.google.com with SMTP id l4so1609653oii.13
        for <selinux@vger.kernel.org>; Mon, 19 Oct 2020 14:29:00 -0700 (PDT)
X-Gm-Message-State: AOAM5315HEHvwDu9kyZXhRf3i7/mWwHLpWf9Z5WnDaV80hULG+lrZ6HW
        wmoWExFLxzKoYaCS87EMfkoJ9+v2xWvSFmlygg4=
X-Google-Smtp-Source: ABdhPJxa5JyGlWB8yVp1icduHqa0XXFW+EY7TdzCmUnrbz5QuujdndwovegYyylCmBAZ8HHI7FDzthY+S+ztBkGMy3Q=
X-Received: by 2002:a54:4482:: with SMTP id v2mr966539oiv.20.1603142939234;
 Mon, 19 Oct 2020 14:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201003193957.1876526-1-nicolas.iooss@m4x.org> <CAP+JOzQVGvB2CJN+DF8dn1Y=EwJQErh9UThEmoec_=X6_ye6CQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQVGvB2CJN+DF8dn1Y=EwJQErh9UThEmoec_=X6_ye6CQ@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 19 Oct 2020 23:28:48 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=kX2hTp3CRd9X+5WdqtVOUdffbMb6zwhGgKo+EGFsCQ=g@mail.gmail.com>
Message-ID: <CAJfZ7=kX2hTp3CRd9X+5WdqtVOUdffbMb6zwhGgKo+EGFsCQ=g@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol: drop confusing BUG_ON macro
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Oct 19 23:29:00 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 15, 2020 at 7:00 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Sat, Oct 3, 2020 at 3:40 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > Contrary to Linux kernel, BUG_ON() does not halt the execution, in
> > libsepol/src/services.c. Instead it displays an error message and
> > continues the execution.
> >
> > This means that this code does not prevent an out-of-bound write from
> > happening:
> >
> >     case CEXPR_AND:
> >         BUG_ON(sp < 1);
> >         sp--;
> >         s[sp] &= s[sp + 1];
> >
> > Use if(...){BUG();rc=-EINVAL;goto out;} constructions instead, to make
> > sure that the array access is always in-bound.
> >
> > This issue has been found using clang's static analyzer:
> > https://558-118970575-gh.circle-artifacts.com/0/output-scan-build/2020-10-02-065849-6375-1/report-50a861.html#EndPath
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Thanks. Merged.

Nicolas
>
> > ---
> >  libsepol/src/services.c | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> >
> > diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> > index 90da1f4efef3..beb0711f6680 100644
> > --- a/libsepol/src/services.c
> > +++ b/libsepol/src/services.c
> > @@ -67,7 +67,6 @@
> >  #include "flask.h"
> >
> >  #define BUG() do { ERR(NULL, "Badness at %s:%d", __FILE__, __LINE__); } while (0)
> > -#define BUG_ON(x) do { if (x) ERR(NULL, "Badness at %s:%d", __FILE__, __LINE__); } while (0)
> >
> >  static int selinux_enforcing = 1;
> >
> > @@ -469,18 +468,30 @@ static int constraint_expr_eval_reason(context_struct_t *scontext,
> >                 /* Now process each expression of the constraint */
> >                 switch (e->expr_type) {
> >                 case CEXPR_NOT:
> > -                       BUG_ON(sp < 0);
> > +                       if (sp < 0) {
> > +                               BUG();
> > +                               rc = -EINVAL;
> > +                               goto out;
> > +                       }
> >                         s[sp] = !s[sp];
> >                         cat_expr_buf(expr_list[expr_counter], "not");
> >                         break;
> >                 case CEXPR_AND:
> > -                       BUG_ON(sp < 1);
> > +                       if (sp < 1) {
> > +                               BUG();
> > +                               rc = -EINVAL;
> > +                               goto out;
> > +                       }
> >                         sp--;
> >                         s[sp] &= s[sp + 1];
> >                         cat_expr_buf(expr_list[expr_counter], "and");
> >                         break;
> >                 case CEXPR_OR:
> > -                       BUG_ON(sp < 1);
> > +                       if (sp < 1) {
> > +                               BUG();
> > +                               rc = -EINVAL;
> > +                               goto out;
> > +                       }
> >                         sp--;
> >                         s[sp] |= s[sp + 1];
> >                         cat_expr_buf(expr_list[expr_counter], "or");
> > --
> > 2.28.0
> >

