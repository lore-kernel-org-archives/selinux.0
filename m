Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAAFC433E0
	for <selinux@archiver.kernel.org>; Sun,  3 Jan 2021 18:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6585F207FB
	for <selinux@archiver.kernel.org>; Sun,  3 Jan 2021 18:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbhACSdL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 3 Jan 2021 13:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbhACSdJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 3 Jan 2021 13:33:09 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB043C061573
        for <selinux@vger.kernel.org>; Sun,  3 Jan 2021 10:32:29 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id 75so23285431ilv.13
        for <selinux@vger.kernel.org>; Sun, 03 Jan 2021 10:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AKndQHQxCaS4VRitp+yxbRxXPQnFuh5fHxVImsEu0vM=;
        b=D8krd/Rd7T777ZMho5aL1saIOOPx9HX2JSId6OZKPkk/7hzlW5rBcur6+5wsellxtV
         h+HcqASnDZG+cgMKHwIgYc/+9va0znjvTRnloZmuP3IftPc8O1KF3bxoA/QIUriOJL4T
         a3AebLX3GfPuFqJ50IelIZEDc312E390TFDQ6oC21wz5msg1r0TX5LFik7kI+i0cOsQ4
         mwSZpF5E5vcD0jB/potzfkP98Y5UIXYqF/6M7YhZ8hfP8wabBzIM9PTQ6PRvTvFcxufi
         yTqn3G2jxG4RWJTYUSSUUcCSDesTj8Mhhwo/inFDYY8nXvCuX6Wf1fjGIUTYZpYhKQ4U
         TOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AKndQHQxCaS4VRitp+yxbRxXPQnFuh5fHxVImsEu0vM=;
        b=ipExUDvKYs0VDcMGDWe+cSED6+3BEaUDpHZ4ykx8HBQ/oLqFLQtMDzuwwUCzzY7pvV
         eVmiY53y2Q7qaZPnqq4bkRmTzUOSl3TaztInK5DTPgf8jzFQ/WUO4zxbTrF3eRkJfTHl
         HQOIVRSKP3P/VmyA3heX+kbzV7Wm5hnkAXAUT+HJZ87/3tIADVn8bzHhznwOpuY/V8Tm
         jl8oT32jxPPoX65yqG4rAmDvnkFTukeWdh9W/U7Z2Vo2pcrKmHxcZdmhOS4nLOaJpmx/
         bMSR+xCZPmEwo+LP1d2Rh0ydYV83cUrTRBR8lvdKpf5Ag4BfSuadFl9NlF6v41wJlRep
         uVsA==
X-Gm-Message-State: AOAM5305VSaKPUQLzEZPsRIqN3PNgm/Hp+R6B8WTKS9U0NF2r1SIH0Yx
        hRLe5dDAGQZPoR8jPWyGr0bhlVEaesgTH7Vhsbkjj280HDE=
X-Google-Smtp-Source: ABdhPJwxYkBlmrN76fCUAgLi3ZgOZE23W8qRIRbrFF5XGbOOZPXQyFjMtb9Qur1t0xcBmadDzq+poKaBxKbZqiC+05A=
X-Received: by 2002:a05:6e02:1b8a:: with SMTP id h10mr68943498ili.141.1609698748795;
 Sun, 03 Jan 2021 10:32:28 -0800 (PST)
MIME-Version: 1.0
References: <20201230100746.2549568-1-nicolas.iooss@m4x.org>
 <20201230100746.2549568-4-nicolas.iooss@m4x.org> <CAFftDdoohaTHhQCXrYPWg1B6AbQ4157eoOOy1Tp_qnYFCwE1cw@mail.gmail.com>
 <CAJfZ7=n5va_a9c3Z3QKxaDSZBk4Q5VT98C28VbuXaOYkwUy31A@mail.gmail.com>
In-Reply-To: <CAJfZ7=n5va_a9c3Z3QKxaDSZBk4Q5VT98C28VbuXaOYkwUy31A@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Sun, 3 Jan 2021 12:32:17 -0600
Message-ID: <CAFftDdrGoQezmVSOnrFrPKaOnS3pejQXzYpfjwQ+QBHH_Pv02w@mail.gmail.com>
Subject: Re: [PATCH 4/6] libsepol/cil: fix NULL pointer dereference when
 parsing an improper integer
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Jan 2, 2021 at 5:13 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Thu, Dec 31, 2020 at 4:04 PM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> >
> > On Wed, Dec 30, 2020 at 4:09 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> > >
> > > OSS-Fuzz found a NULL pointer dereference when the CIL compiler tries to
> > > compile a policy with an invalid integer:
> > >
> > >     $ echo '(ioportcon(2())n)' > tmp.cil
> > >     $ secilc tmp.cil
> > >     Segmentation fault (core dumped)
> > >
> > > This is because strtol() is called with a NULL pointer, in
> > > cil_fill_integer().
> > >
> > > Fix this by checking that int_node->data is not NULL. While at it, use
> > > strtoul() instead of strtol() to parse an unsigned integer.
> > >
> > > Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28456
> > > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > > ---
> > >  libsepol/cil/src/cil_build_ast.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> > > index 67801def0dc0..0c9015cef578 100644
> > > --- a/libsepol/cil/src/cil_build_ast.c
> > > +++ b/libsepol/cil/src/cil_build_ast.c
> > > @@ -5566,15 +5566,15 @@ int cil_fill_integer(struct cil_tree_node *int_node, uint32_t *integer, int base
> > >  {
> > >         int rc = SEPOL_ERR;
> > >         char *endptr = NULL;
> > > -       int val;
> > > +       unsigned long val;
> > >
> > > -       if (int_node == NULL || integer == NULL) {
> > > +       if (int_node == NULL || int_node->data == NULL || integer == NULL) {
> > >                 goto exit;
> > >         }
> > >
> > >         errno = 0;
> > > -       val = strtol(int_node->data, &endptr, base);
> > > -       if (errno != 0 || endptr == int_node->data || *endptr != '\0') {
> > > +       val = strtoul(int_node->data, &endptr, base);
> > > +       if (errno != 0 || endptr == int_node->data || *endptr != '\0' || val > UINT32_MAX) {
> >
> > I wonder if compilers/static analysis tools will balk on this as
> > strtoul's return, an unsigned long,
> > on a 32 bit machine will be 32 bits, so this could have a dead
> > expression as val > UINT32_MAX
> > will always be false. Perhaps use the strtoull variant to always have 64 bits?
>
> In my humble opinion, a compiler or a static analyzer which warn about
> the fact that "comparing an unsigned long value to UINT32_MAX is
> always true" have an issue, because this seems to be the most natural
> way of checking that a potentially-64-bit number can be safely
> downcasted to 32 bits.
>
> I find the suggestion of using strtoull to get a 32-bit integer to be
> very hackish, considering that on 32-bit systems, strtoul does the job
> fine (returning with errno = ERANGE when the value is too large) and
> 64-bit integers are using pairs of registers to be stored. If this
> code ever causes issues with some compilers, some preprocessor logic
> (such as "#if ULONG_MAX > UINT32_MAX") could be added to hide "val >
> UINT32_MAX" from 32-bit compilers. Nevertheless in an effort to keep
> the amount of preprocessor code as low as possible, I do not want to
> include such logic right now.

The reason I bring this up, is that I've personally encountered this
on Android when porting
libraries before. But these we're with much older GCC/CLANG variants.
When Android's
build went from gcc to clang, I remember clang being extra noisy and
these -Wtype-limits
warnings being a constant battle when trying to enable -Wextra.

t really boils down to the warning (per the man page):
-Wtype-limits
Warn if a comparison is always true or always false due to the limited
range of the data type, but do not warn for constant expressions. For
example, warn if an unsigned variable is compared against zero with <
or >=. This warning is also enabled by -Wextra.

But I tested this with an arm32v7 Docker Container running Ubuntu 20.04 using:
- GCC 9.3.0
- CLANG 10.0

as well as the NDK clang version Android (6454773 based on r365631c2)
clang version 9.0.8
cross compiling from x86_64 machine and it doesn't reproduce.

I wonder if they changed the behavior a bit because of having to
deal with this error all the time, and it was no fun. What's more
perplexing is that the uint8_t and uint16_t cases
trigger the warning and the uint32_t and uint64_t cases do not. I can
understand skipping the warning on
the unsigned long because of the word length changing from 8 to 4
bytes, and the 4 byte check
ending up being always false and harmless, but in the fixed width
case... I wonder why the compiler gods chose so.

        uint8_t y = (uint8_t)argc;
        if(y > UINT8_MAX) { printf("foo: %u\n", y); }  // always false

        uint16_t w = (uint16_t)argc;
        if(w > UINT16_MAX) { printf("foo: %u\n", w); }  // always false

        uint32_t q = (uint32_t)argc;
        if(q > UINT32_MAX) { printf("foo: %u\n", q); }  // always false

        uint64_t z = (uint64_t)argc;
        if(z > UINT64_MAX) { printf("foo: %llu\n", z); }  // always false

a.c:23:7: warning: comparison is always false due to limited range of
data type [-Wtype-limits]
   23 |  if(y > UINT8_MAX) { printf("foo: %u\n", y); }  // always false

>
> In short, I am not willing to change this patch unless someone reports
> a regression due to "val > UINT32_MAX".

Based on my tests with modern versions of toolchains, I think we're
fine. I don't know why
we're fine, but we appear so.

>
> Thanks for your review!
> Nicolas

ack for the whole series since this was my only worry.

>
> > >                 rc = SEPOL_ERR;
> > >                 goto exit;
> > >         }
> > > @@ -5594,7 +5594,7 @@ int cil_fill_integer64(struct cil_tree_node *int_node, uint64_t *integer, int ba
> > >         char *endptr = NULL;
> > >         uint64_t val;
> > >
> > > -       if (int_node == NULL || integer == NULL) {
> > > +       if (int_node == NULL || int_node->data == NULL || integer == NULL) {
> > >                 goto exit;
> > >         }
> > >
> > > --
> > > 2.29.2
> > >
>
