Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8F3C07E95
	for <selinux@archiver.kernel.org>; Tue, 13 Jul 2021 19:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EB9160200
	for <selinux@archiver.kernel.org>; Tue, 13 Jul 2021 19:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhGMUCa convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Jul 2021 16:02:30 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:36973 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbhGMUCa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Jul 2021 16:02:30 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 831F1564774
        for <selinux@vger.kernel.org>; Tue, 13 Jul 2021 21:59:38 +0200 (CEST)
Received: by mail-io1-f47.google.com with SMTP id y16so5671575iol.12
        for <selinux@vger.kernel.org>; Tue, 13 Jul 2021 12:59:38 -0700 (PDT)
X-Gm-Message-State: AOAM533L/kHOdFi3utOBPUgshyOuTRUlYWuVgTka/pPJ0H6pfLahNMlf
        zTs8j6THeuip59LNNr8PXJShpWlFt4JfCJyzNDo=
X-Google-Smtp-Source: ABdhPJzE5k+bwR8PQpc1aOxhi8uwYoJ6d4EyQVU94GsAw8vGWeZrfrP7CAJqixP0eTii4FTJXnzea/6bi6LNZBShEbk=
X-Received: by 2002:a05:6638:289:: with SMTP id c9mr5622331jaq.14.1626206377579;
 Tue, 13 Jul 2021 12:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210608155912.32047-5-cgzones@googlemail.com>
 <20210701180622.119708-1-cgzones@googlemail.com> <CAJfZ7=nVF8grKSGop67d4sPXHDZgP6QLChWsROcrGudJiWb=_A@mail.gmail.com>
In-Reply-To: <CAJfZ7=nVF8grKSGop67d4sPXHDZgP6QLChWsROcrGudJiWb=_A@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 13 Jul 2021 21:59:26 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=k-F1SJUH7s7RTE-3_KnEegFq9TLOueUhD_jTiaChPjVw@mail.gmail.com>
Message-ID: <CAJfZ7=k-F1SJUH7s7RTE-3_KnEegFq9TLOueUhD_jTiaChPjVw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] libsepol: ignore UBSAN false-positives
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Jul 13 21:59:38 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 12, 2021 at 9:34 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Thu, Jul 1, 2021 at 8:06 PM Christian Göttsche
> <cgzones@googlemail.com> wrote:
> >
> > Unsigned integer overflow is well-defined and not undefined behavior.
> > But it is still useful to enable undefined behavior sanitizer checks on
> > unsigned arithmetic to detect possible issues on counters or variables
> > with similar purpose.
> >
> > Annotate functions, in which unsigned overflows are expected to happen,
> > with the respective Clang function attribute[1].
> > GCC does not support sanitizing unsigned integer arithmetic[2].
> >
> >     avtab.c:76:2: runtime error: unsigned integer overflow: 6 * 3432918353 cannot be represented in type 'unsigned int'
> >     policydb.c:795:42: runtime error: unsigned integer overflow: 8160943042179512010 * 11 cannot be represented in type 'unsigned long'
> >     symtab.c:25:12: runtime error: left shift of 1766601759 by 4 places cannot be represented in type 'unsigned int'
> >
> > [1]: https://clang.llvm.org/docs/AttributeReference.html#no-sanitize
> > [2]: https://gcc.gnu.org/onlinedocs/gcc/Instrumentation-Options.html
> >
> > Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Thanks,
> Nicolas

Merged.
Thanks!
Nicolas

> > ---
> > v2:
> >   - use a common macro as suggested by Ondrej Mosnacek
> >   - mention that GCC does not support unsigned integer sanitation
> >
> >  libsepol/src/avtab.c    |  1 +
> >  libsepol/src/policydb.c |  1 +
> >  libsepol/src/private.h  | 11 +++++++++++
> >  libsepol/src/symtab.c   |  4 ++++
> >  4 files changed, 17 insertions(+)
> >
> > diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
> > index 88e9d510..37e8af07 100644
> > --- a/libsepol/src/avtab.c
> > +++ b/libsepol/src/avtab.c
> > @@ -52,6 +52,7 @@
> >  /* Based on MurmurHash3, written by Austin Appleby and placed in the
> >   * public domain.
> >   */
> > +ignore_unsigned_overflow_
> >  static inline int avtab_hash(struct avtab_key *keyp, uint32_t mask)
> >  {
> >         static const uint32_t c1 = 0xcc9e2d51;
> > diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> > index ef2217c2..0721c81e 100644
> > --- a/libsepol/src/policydb.c
> > +++ b/libsepol/src/policydb.c
> > @@ -789,6 +789,7 @@ static int roles_init(policydb_t * p)
> >         goto out;
> >  }
> >
> > +ignore_unsigned_overflow_
> >  static inline unsigned long
> >  partial_name_hash(unsigned long c, unsigned long prevhash)
> >  {
> > diff --git a/libsepol/src/private.h b/libsepol/src/private.h
> > index 72f21262..e54cefdb 100644
> > --- a/libsepol/src/private.h
> > +++ b/libsepol/src/private.h
> > @@ -47,6 +47,17 @@
> >  #define is_saturated(x) (x == (typeof(x))-1)
> >  #define zero_or_saturated(x) ((x == 0) || is_saturated(x))
> >
> > +/* Use to ignore intentional unsigned under- and overflows while running under UBSAN. */
> > +#if defined(__clang__) && defined(__clang_major__) && (__clang_major__ >= 4)
> > +#if (__clang_major__ >= 12)
> > +#define ignore_unsigned_overflow_        __attribute__((no_sanitize("unsigned-integer-overflow", "unsigned-shift-base")))
> > +#else
> > +#define ignore_unsigned_overflow_        __attribute__((no_sanitize("unsigned-integer-overflow")))
> > +#endif
> > +#else
> > +#define ignore_unsigned_overflow_
> > +#endif
> > +
> >  /* Policy compatibility information. */
> >  struct policydb_compat_info {
> >         unsigned int type;
> > diff --git a/libsepol/src/symtab.c b/libsepol/src/symtab.c
> > index 9a417ca2..a6061851 100644
> > --- a/libsepol/src/symtab.c
> > +++ b/libsepol/src/symtab.c
> > @@ -8,9 +8,13 @@
> >   */
> >
> >  #include <string.h>
> > +
> > +#include "private.h"
> > +
> >  #include <sepol/policydb/hashtab.h>
> >  #include <sepol/policydb/symtab.h>
> >
> > +ignore_unsigned_overflow_
> >  static unsigned int symhash(hashtab_t h, const_hashtab_key_t key)
> >  {
> >         const char *p, *keyp;
> > --
> > 2.32.0
> >

