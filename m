Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D65C433E0
	for <selinux@archiver.kernel.org>; Sat,  2 Jan 2021 11:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C60722241
	for <selinux@archiver.kernel.org>; Sat,  2 Jan 2021 11:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbhABLNz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 2 Jan 2021 06:13:55 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:33301 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbhABLNz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 2 Jan 2021 06:13:55 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 1D299561256
        for <selinux@vger.kernel.org>; Sat,  2 Jan 2021 12:13:12 +0100 (CET)
Received: by mail-ot1-f41.google.com with SMTP id n42so21691594ota.12
        for <selinux@vger.kernel.org>; Sat, 02 Jan 2021 03:13:12 -0800 (PST)
X-Gm-Message-State: AOAM532ABxbe3pqelvYjdYqq0Lxayfgffb4IJT7Jbcx+piEJ0SgKrnWE
        OL6rJTKZkYplj3ob6lrY/5Lx9SAmAHdo3FncbVk=
X-Google-Smtp-Source: ABdhPJyKF7IURp6pEi/lc82eoDHHyT8WsCTTWTrhmzoI8dR2PkKu3E1xb1aDjTBgJmlpGqXcRR7cnnS7R3Xjn0JSJi4=
X-Received: by 2002:a05:6830:1e62:: with SMTP id m2mr46514986otr.279.1609585990973;
 Sat, 02 Jan 2021 03:13:10 -0800 (PST)
MIME-Version: 1.0
References: <20201230100746.2549568-1-nicolas.iooss@m4x.org>
 <20201230100746.2549568-4-nicolas.iooss@m4x.org> <CAFftDdoohaTHhQCXrYPWg1B6AbQ4157eoOOy1Tp_qnYFCwE1cw@mail.gmail.com>
In-Reply-To: <CAFftDdoohaTHhQCXrYPWg1B6AbQ4157eoOOy1Tp_qnYFCwE1cw@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 2 Jan 2021 12:13:00 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=n5va_a9c3Z3QKxaDSZBk4Q5VT98C28VbuXaOYkwUy31A@mail.gmail.com>
Message-ID: <CAJfZ7=n5va_a9c3Z3QKxaDSZBk4Q5VT98C28VbuXaOYkwUy31A@mail.gmail.com>
Subject: Re: [PATCH 4/6] libsepol/cil: fix NULL pointer dereference when
 parsing an improper integer
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jan  2 12:13:12 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 31, 2020 at 4:04 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Wed, Dec 30, 2020 at 4:09 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > OSS-Fuzz found a NULL pointer dereference when the CIL compiler tries to
> > compile a policy with an invalid integer:
> >
> >     $ echo '(ioportcon(2())n)' > tmp.cil
> >     $ secilc tmp.cil
> >     Segmentation fault (core dumped)
> >
> > This is because strtol() is called with a NULL pointer, in
> > cil_fill_integer().
> >
> > Fix this by checking that int_node->data is not NULL. While at it, use
> > strtoul() instead of strtol() to parse an unsigned integer.
> >
> > Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28456
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > ---
> >  libsepol/cil/src/cil_build_ast.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> > index 67801def0dc0..0c9015cef578 100644
> > --- a/libsepol/cil/src/cil_build_ast.c
> > +++ b/libsepol/cil/src/cil_build_ast.c
> > @@ -5566,15 +5566,15 @@ int cil_fill_integer(struct cil_tree_node *int_node, uint32_t *integer, int base
> >  {
> >         int rc = SEPOL_ERR;
> >         char *endptr = NULL;
> > -       int val;
> > +       unsigned long val;
> >
> > -       if (int_node == NULL || integer == NULL) {
> > +       if (int_node == NULL || int_node->data == NULL || integer == NULL) {
> >                 goto exit;
> >         }
> >
> >         errno = 0;
> > -       val = strtol(int_node->data, &endptr, base);
> > -       if (errno != 0 || endptr == int_node->data || *endptr != '\0') {
> > +       val = strtoul(int_node->data, &endptr, base);
> > +       if (errno != 0 || endptr == int_node->data || *endptr != '\0' || val > UINT32_MAX) {
>
> I wonder if compilers/static analysis tools will balk on this as
> strtoul's return, an unsigned long,
> on a 32 bit machine will be 32 bits, so this could have a dead
> expression as val > UINT32_MAX
> will always be false. Perhaps use the strtoull variant to always have 64 bits?

In my humble opinion, a compiler or a static analyzer which warn about
the fact that "comparing an unsigned long value to UINT32_MAX is
always true" have an issue, because this seems to be the most natural
way of checking that a potentially-64-bit number can be safely
downcasted to 32 bits.

I find the suggestion of using strtoull to get a 32-bit integer to be
very hackish, considering that on 32-bit systems, strtoul does the job
fine (returning with errno = ERANGE when the value is too large) and
64-bit integers are using pairs of registers to be stored. If this
code ever causes issues with some compilers, some preprocessor logic
(such as "#if ULONG_MAX > UINT32_MAX") could be added to hide "val >
UINT32_MAX" from 32-bit compilers. Nevertheless in an effort to keep
the amount of preprocessor code as low as possible, I do not want to
include such logic right now.

In short, I am not willing to change this patch unless someone reports
a regression due to "val > UINT32_MAX".

Thanks for your review!
Nicolas

> >                 rc = SEPOL_ERR;
> >                 goto exit;
> >         }
> > @@ -5594,7 +5594,7 @@ int cil_fill_integer64(struct cil_tree_node *int_node, uint64_t *integer, int ba
> >         char *endptr = NULL;
> >         uint64_t val;
> >
> > -       if (int_node == NULL || integer == NULL) {
> > +       if (int_node == NULL || int_node->data == NULL || integer == NULL) {
> >                 goto exit;
> >         }
> >
> > --
> > 2.29.2
> >

