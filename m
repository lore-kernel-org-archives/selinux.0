Return-Path: <SRS0=jqI3=4O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C6AC4BA10
	for <selinux@archiver.kernel.org>; Wed, 26 Feb 2020 13:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729C621927
	for <selinux@archiver.kernel.org>; Wed, 26 Feb 2020 13:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HMTuqkjJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgBZNXn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Feb 2020 08:23:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28588 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726277AbgBZNXm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Feb 2020 08:23:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582723420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KNPEb11xJfH4nHIe7kKQM7BdYayDf30tmRAyfnYvS4M=;
        b=HMTuqkjJwu2qSFyA+IHZ2uPdEt8DnJSt46O/ZcOgtQLr7AGWlxrX8GiPQuj3LvKbb5azHz
        CYSmm1BNRt5fsmSTUwftiBwW3iqu1FhjpZxtOadRdVkEE/SdkHPxDhbGlXdSuYbo0TMMR9
        WPzgETTODuo1gy6K352uAj6J2pVGJWM=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-Vok2BmF0N_-Rzesekz7Uuw-1; Wed, 26 Feb 2020 08:23:35 -0500
X-MC-Unique: Vok2BmF0N_-Rzesekz7Uuw-1
Received: by mail-oi1-f200.google.com with SMTP id c22so1384641oic.20
        for <selinux@vger.kernel.org>; Wed, 26 Feb 2020 05:23:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KNPEb11xJfH4nHIe7kKQM7BdYayDf30tmRAyfnYvS4M=;
        b=BVpNwei6JcyhmNyi1W8qOTRjr/nmqRtbMoi3cYDr1aB0sKRwRCSXYoBg5q12sBWvg+
         NId96TWvDyJpaAx6K6uwCe7kkb8oVnynt8mVd3DYWbXtPh/HdNloNoptvJYhMfrObx5q
         ZSl88ePEdKBqWNzPk/Ww9FYZ1y72YDXks8QsCck0YkqTsgS0msN/7xKEUznP4ea9Dji9
         Loa/MAkR122hCkCFqX7NaFWwtqPXpqNJCHSVdFpdR1VrB2NfYDeRxeie0xxzib8p1uuA
         fQfdiFYHLdKniH1pY0vf7+C/PxKx+2E3ZlHolN8Y7XnGmBPlRwRI4kly8aFtqGAIzJEm
         ghQQ==
X-Gm-Message-State: APjAAAVoIuNpmJoLUk50zTEfqFkRLJ1envYIDC0AVJYEDjC9M+y/aJXL
        Yuc2+WCdGsUtiJn9ohd3CnYiTEjdAXoSfXr9iwRKJR/enTnujD6qgDIJ+JzaHZBuujyYvZZb2mU
        JJJP6z7pi00v0UmkwUEsBO9ARDaDEKWA5fA==
X-Received: by 2002:a9d:729c:: with SMTP id t28mr2988931otj.66.1582723414044;
        Wed, 26 Feb 2020 05:23:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqzC2pE+lt4IFgBjh+ohbVKXNPRYIjB00UajvJJ7uPYsH5LaMbbFkk3gubQcMmOMlwYcerQAYIbiTFj5f6t2PrY=
X-Received: by 2002:a9d:729c:: with SMTP id t28mr2988907otj.66.1582723413740;
 Wed, 26 Feb 2020 05:23:33 -0800 (PST)
MIME-Version: 1.0
References: <20200213133959.14217-1-omosnace@redhat.com> <CAFqZXNuxHYN_cMY1+PfUFrwu6dQyG5qc7LGPU8VbUAyTXRF_Wg@mail.gmail.com>
 <7d80365c-d2ea-f167-0757-6038becdb5fc@tycho.nsa.gov> <CAFqZXNuvL1KQwahXPJKngr_p7sON0SNM=5Mecao0QhAGfRTN2g@mail.gmail.com>
 <CAJfZ7==_-vg1e3LV-Wbf94PjFu86pxc3-J6BqJ_Qa73uaj+pkw@mail.gmail.com> <CAFftDdrEqVV-q-nJZmPUEYwr56YPPGPjv3WE2400QkTqyTo-rQ@mail.gmail.com>
In-Reply-To: <CAFftDdrEqVV-q-nJZmPUEYwr56YPPGPjv3WE2400QkTqyTo-rQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 26 Feb 2020 14:23:22 +0100
Message-ID: <CAFqZXNvaA7QA7SQryU-nm8Az72MDOxg69S8MpkiidND0FFR0-w@mail.gmail.com>
Subject: Re: [PATCH userspace v2] libsepol: cache ebitmap cardinality value
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 25, 2020 at 10:57 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Tue, Feb 25, 2020 at 3:33 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > On Tue, Feb 18, 2020 at 5:01 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > On Tue, Feb 18, 2020 at 4:40 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > > On 2/18/20 10:22 AM, Ondrej Mosnacek wrote:
> > > > > On Thu, Feb 13, 2020 at 2:40 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > >> According to profiling of semodule -BN, ebitmap_cardinality() is called
> > > > >> quite often and contributes a lot to the total runtime. Cache its result
> > > > >> in the ebitmap struct to reduce this overhead. The cached value is
> > > > >> invalidated on most modifying operations, but ebitmap_cardinality() is
> > > > >> usually called once the ebitmap doesn't change any more.
> > > > >>
> > > > >> After this patch, the time to do 'semodule -BN' on Fedora Rawhide has
> > > > >> decreased from ~14.6s to ~12.4s (2.2s saved).
> > > > >
> > > > > I have no idea why, but I'm now getting completely different times
> > > > > (10.9s vs. 8.9s) with the same builds on the same setup... I can no
> > > > > longer reproduce the slower times anywhere (F31/locally/...) so I have
> > > > > to assume it was some kind of glitch. Since the numbers show a similar
> > > > > magnitude of speed-up (and they depend on a bunch of HW/SW factors
> > > > > anyway), I'm not going to do another respin. The applying person (most
> > > > > likely Stephen) is free to fix the numbers when applying if they wish
> > > > > to do so.
> > > >
> > > > Thanks, applied with fixed times (although I don't really think it
> > > > matters very much).  Maybe you're also picking up the difference from
> > > > the "libsepol/cil: remove unnecessary hash tables" change.
> > >
> > > No, that was actually the reason for the first correction.
> >
> > Hello,
> > About performance issues, the current implementation of
> > ebitmap_cardinality() is quadratic:
> >
> > for (i=ebitmap_startbit(e1); i < ebitmap_length(e1); i++)
> >     if (ebitmap_get_bit(e1, i))
> >         count++;
> >
> > ... because ebitmap_get_bit() browse the bitmap:
> >
> > while (n && (n->startbit <= bit)) {
> >    if ((n->startbit + MAPSIZE) > bit) {
> >       /*... */

Hm... I didn't realize that the function is actually quadratic.

> >
> > A few years ago, I tried modifying this function to make it linear in
> > the bitmap size:
> >
> > unsigned int ebitmap_cardinality(ebitmap_t *e1)
> > {
> >     unsigned int count = 0;
> >     ebitmap_node_t *n;
> >
> >    for (n = e1->node; n; n = n->next) {
> >         count += __builtin_popcountll(n->map);
> >     }
> >     return count;
> > }
> >
> > ... but never actually sent a patch for this, because I wanted to
> > assess how __builtin_popcountll() was supported by several compilers
> > beforehand. Would this be helpful to gain even more performance gain?
>
> Every architecture I've used has an instruction it boils down to:
> x86 - POPCNT
> ARM (neon): vcnt

Note that the compiler will only emit these instructions if you
compile with the right target platform (-mpopcnt or something that
includes it on x86_64). Portable generic builds will usually not use
it. Still, even without the special instruction __builtin_popcountll()
should generate more optimal code than the naive
add-each-bit-one-by-one approach. For example, I came up with this
pure C implementation of 64-bit popcount [1] that both GCC and Clang
can compile down to ~36 instructions. The generic version of
__builtin_popcountll() likely does something similar. (Actually, here
is what Clang seems to use [2], which is pretty close.)

FWIW, I tested the __builtin_popcountll() version with the caching
patch reverted (built without popcnt support) and it actually
performed even better than the old code + caching (it went down to
~0.11% of semodule -B running time). A naive popcount implementation
without caching didn't perform as good (was slower than the old code +
caching).

So... we could just open-code some good generic C implementation
(cleanly written and properly commented, of course) and then we
wouldn't have to rely on the compiler builtin. OTOH, the SELinux
userspace already uses non-standard compiler extensions
(__attribute__(...)), so maybe sticking to pure C is not worth it...
Either way I think we should revert the caching patch along with
switching to an optimized implementation (it would no longer be worth
the added complexity IMO).

[1] https://gcc.godbolt.org/z/39W7qa
[2] https://github.com/llvm-mirror/compiler-rt/blob/master/lib/builtins/popcountdi2.c

>
> For others, (do they even matter at this point) I would imagine GCC
> does something relatively sane.
>
> >
> > Cheers,
> > Nicolas
> >
>
--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

