Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5B7C433E0
	for <selinux@archiver.kernel.org>; Fri,  5 Feb 2021 09:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52C3760241
	for <selinux@archiver.kernel.org>; Fri,  5 Feb 2021 09:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhBEJp2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Feb 2021 04:45:28 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:46579 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhBEJnW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Feb 2021 04:43:22 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id F0ED356126A
        for <selinux@vger.kernel.org>; Fri,  5 Feb 2021 10:42:21 +0100 (CET)
Received: by mail-oi1-f172.google.com with SMTP id u66so4907283oig.9
        for <selinux@vger.kernel.org>; Fri, 05 Feb 2021 01:42:21 -0800 (PST)
X-Gm-Message-State: AOAM533xqFHsNfHow3u2CTEFVRN8WVCraUgIcC7H6AcnBS1ZVj5hjWcV
        Gw4HQYR70irZOjsmoLkC/pWthDx7sFBmnigWdbI=
X-Google-Smtp-Source: ABdhPJyALT0xx+pXVnqTgcD6QiDFl9pqKJwei6s98ibkdBjaaoaJaAO//b5P4ciuYmBzipEr4JR52FGn/jUyX74JuvU=
X-Received: by 2002:aca:744:: with SMTP id 65mr2408373oih.153.1612518141034;
 Fri, 05 Feb 2021 01:42:21 -0800 (PST)
MIME-Version: 1.0
References: <20210203085846.6680-1-nicolas.iooss@m4x.org> <20210203085846.6680-2-nicolas.iooss@m4x.org>
 <CAP+JOzRUB6YWwTK1vx6hUuCw7SmPYa2vJQ1PA8mWbEN+8GLBqQ@mail.gmail.com>
In-Reply-To: <CAP+JOzRUB6YWwTK1vx6hUuCw7SmPYa2vJQ1PA8mWbEN+8GLBqQ@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Fri, 5 Feb 2021 10:42:09 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=kfUTQhE0wvYEuJcW2t5ZWLVwBrn8MmLcdi=EWkzDPaTw@mail.gmail.com>
Message-ID: <CAJfZ7=kfUTQhE0wvYEuJcW2t5ZWLVwBrn8MmLcdi=EWkzDPaTw@mail.gmail.com>
Subject: Re: [PATCH 2/3] libsepol: uniformize prototypes of sepol_mls_contains
 and sepol_mls_check
To:     James Carter <jwcart2@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri Feb  5 10:42:22 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 4, 2021 at 8:21 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Feb 3, 2021 at 4:00 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > In libsepol/src/mls.c, functions sepol_mls_contains and sepol_mls_check
> > used "sepol_policydb_t * policydb" even though
> > libsepol/include/sepol/context.h used "const sepol_policydb_t *
> > policydb".
> >
> > Add const qualifiers in mls.c in order to match the header file. Detect
> > such mismatching error at compile time by including the header file in
> > mls.c.
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.
Nicolas

> > ---
> >  libsepol/src/mls.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/libsepol/src/mls.c b/libsepol/src/mls.c
> > index 1ee90cf8dee1..366a1114ce96 100644
> > --- a/libsepol/src/mls.c
> > +++ b/libsepol/src/mls.c
> > @@ -27,6 +27,7 @@
> >   * Implementation of the multi-level security (MLS) policy.
> >   */
> >
> > +#include <sepol/context.h>
> >  #include <sepol/policydb/policydb.h>
> >  #include <sepol/policydb/services.h>
> >  #include <sepol/policydb/context.h>
> > @@ -664,7 +665,7 @@ int mls_compute_sid(policydb_t * policydb,
> >  }
> >
> >  int sepol_mls_contains(sepol_handle_t * handle,
> > -                      sepol_policydb_t * policydb,
> > +                      const sepol_policydb_t * policydb,
> >                        const char *mls1, const char *mls2, int *response)
> >  {
> >
> > @@ -703,7 +704,7 @@ int sepol_mls_contains(sepol_handle_t * handle,
> >  }
> >
> >  int sepol_mls_check(sepol_handle_t * handle,
> > -                   sepol_policydb_t * policydb, const char *mls)
> > +                   const sepol_policydb_t * policydb, const char *mls)
> >  {
> >
> >         int ret;
> > --
> > 2.30.0
> >

