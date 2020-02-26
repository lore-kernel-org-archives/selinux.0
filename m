Return-Path: <SRS0=jqI3=4O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC232C4BA13
	for <selinux@archiver.kernel.org>; Wed, 26 Feb 2020 15:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A753624684
	for <selinux@archiver.kernel.org>; Wed, 26 Feb 2020 15:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgpvzLbM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgBZPkE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Feb 2020 10:40:04 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:35325 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgBZPkE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Feb 2020 10:40:04 -0500
Received: by mail-il1-f196.google.com with SMTP id g126so2758880ilh.2
        for <selinux@vger.kernel.org>; Wed, 26 Feb 2020 07:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bx8s61jlVI9flCa0ozX+NDISvk+/JY4e01BLokoJMLY=;
        b=AgpvzLbM2vfjB1RCJbHj4Fel4+Kvjd/65qGcoxFYDObi5nKG/sVh4P32rIsPb7Ee4x
         +UB6+g7eHrwnuOEZAgb3mXx9g9Qyc2T9C73hWYl1WVLuS0KgvW+hxPZC/ZIqm3VmExWh
         sDbtMiRE1j0oso6bFK+wWLkzSaQao4QJ6IWJGKUIJe8jbvBojKvKyhuvb0lU3D5mHUk5
         aRI5HqlfK9OxsqPnxgMcBj9Bq7SgzVT40VUBlDWbh6ir6P+l23wZUXFJClpkN8WtYkta
         CtmC3edp+i6DyfehI1DcVPacslbqncsj2UzNvpin63R7HkQFKla6eXOD+vL5cFUXd91+
         oOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bx8s61jlVI9flCa0ozX+NDISvk+/JY4e01BLokoJMLY=;
        b=UYbygtz/MTSJCsrVRqy9JQYPGhX1A8jvVkdQ2RLkl8X0NCqEPxEtDknyaUQ5WOgpPc
         sRYuTMsRnKpL5s8Zs7MS3G74Lkkr9/P5KtDtQCFGyN8RL4Pm7ts/T11QyFULsdywh4Bo
         JjlRVqpWqaIry2uaV5HtDDnC2KRRqQ90P8zUbvnfH6rF2TFRERjShM5oOJTw9oNau88z
         EPkFqBqWz0h9CGSIwJBe/bw/zN/qL4p3NSVVf50QbrwarN5wXqiCrMI7vYaPOAwGh+4i
         izzeLtBIhgA/ILoxj/UYMRL4jCSDIAxbB9zL4QPWpbrRGSUn7xk+pJXZBoXVU4G8lTec
         dVSg==
X-Gm-Message-State: APjAAAWia16netDLBZiPQcIBzPRO8pRmb/YAkB5f405ssrHiHCQ23I/r
        nfGufXszCX3jvQZBa6yXPnQFaPBreY+FI+7EFZfhmg==
X-Google-Smtp-Source: APXvYqxJ4cEdc2FA9CbQsEp8Ka0kWALx+MUjUR06LJXzQwqn/bpezYNJAhTwefR+ex09lsI0T80mdGm23eb2RJXINF0=
X-Received: by 2002:a92:9ad3:: with SMTP id c80mr5823284ill.141.1582731603041;
 Wed, 26 Feb 2020 07:40:03 -0800 (PST)
MIME-Version: 1.0
References: <20200213133959.14217-1-omosnace@redhat.com> <CAFqZXNuxHYN_cMY1+PfUFrwu6dQyG5qc7LGPU8VbUAyTXRF_Wg@mail.gmail.com>
 <7d80365c-d2ea-f167-0757-6038becdb5fc@tycho.nsa.gov> <CAFqZXNuvL1KQwahXPJKngr_p7sON0SNM=5Mecao0QhAGfRTN2g@mail.gmail.com>
 <CAJfZ7==_-vg1e3LV-Wbf94PjFu86pxc3-J6BqJ_Qa73uaj+pkw@mail.gmail.com>
 <CAFftDdrEqVV-q-nJZmPUEYwr56YPPGPjv3WE2400QkTqyTo-rQ@mail.gmail.com> <CAFqZXNvaA7QA7SQryU-nm8Az72MDOxg69S8MpkiidND0FFR0-w@mail.gmail.com>
In-Reply-To: <CAFqZXNvaA7QA7SQryU-nm8Az72MDOxg69S8MpkiidND0FFR0-w@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 26 Feb 2020 09:39:52 -0600
Message-ID: <CAFftDdoJQ+V-Lz=c+RO3BXQ1KXOj84j8Vbebf3So2+XhoP51gA@mail.gmail.com>
Subject: Re: [PATCH userspace v2] libsepol: cache ebitmap cardinality value
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 26, 2020 at 7:23 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Tue, Feb 25, 2020 at 10:57 PM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> > On Tue, Feb 25, 2020 at 3:33 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> > >
> > > On Tue, Feb 18, 2020 at 5:01 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > >
> > > > On Tue, Feb 18, 2020 at 4:40 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > > > On 2/18/20 10:22 AM, Ondrej Mosnacek wrote:
> > > > > > On Thu, Feb 13, 2020 at 2:40 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > > >> According to profiling of semodule -BN, ebitmap_cardinality() is called
> > > > > >> quite often and contributes a lot to the total runtime. Cache its result
> > > > > >> in the ebitmap struct to reduce this overhead. The cached value is
> > > > > >> invalidated on most modifying operations, but ebitmap_cardinality() is
> > > > > >> usually called once the ebitmap doesn't change any more.
> > > > > >>
> > > > > >> After this patch, the time to do 'semodule -BN' on Fedora Rawhide has
> > > > > >> decreased from ~14.6s to ~12.4s (2.2s saved).
> > > > > >
> > > > > > I have no idea why, but I'm now getting completely different times
> > > > > > (10.9s vs. 8.9s) with the same builds on the same setup... I can no
> > > > > > longer reproduce the slower times anywhere (F31/locally/...) so I have
> > > > > > to assume it was some kind of glitch. Since the numbers show a similar
> > > > > > magnitude of speed-up (and they depend on a bunch of HW/SW factors
> > > > > > anyway), I'm not going to do another respin. The applying person (most
> > > > > > likely Stephen) is free to fix the numbers when applying if they wish
> > > > > > to do so.
> > > > >
> > > > > Thanks, applied with fixed times (although I don't really think it
> > > > > matters very much).  Maybe you're also picking up the difference from
> > > > > the "libsepol/cil: remove unnecessary hash tables" change.
> > > >
> > > > No, that was actually the reason for the first correction.
> > >
> > > Hello,
> > > About performance issues, the current implementation of
> > > ebitmap_cardinality() is quadratic:
> > >
> > > for (i=ebitmap_startbit(e1); i < ebitmap_length(e1); i++)
> > >     if (ebitmap_get_bit(e1, i))
> > >         count++;
> > >
> > > ... because ebitmap_get_bit() browse the bitmap:
> > >
> > > while (n && (n->startbit <= bit)) {
> > >    if ((n->startbit + MAPSIZE) > bit) {
> > >       /*... */
>
> Hm... I didn't realize that the function is actually quadratic.
>
> > >
> > > A few years ago, I tried modifying this function to make it linear in
> > > the bitmap size:
> > >
> > > unsigned int ebitmap_cardinality(ebitmap_t *e1)
> > > {
> > >     unsigned int count = 0;
> > >     ebitmap_node_t *n;
> > >
> > >    for (n = e1->node; n; n = n->next) {
> > >         count += __builtin_popcountll(n->map);
> > >     }
> > >     return count;
> > > }
> > >
> > > ... but never actually sent a patch for this, because I wanted to
> > > assess how __builtin_popcountll() was supported by several compilers
> > > beforehand. Would this be helpful to gain even more performance gain?
> >
> > Every architecture I've used has an instruction it boils down to:
> > x86 - POPCNT
> > ARM (neon): vcnt
>
> Note that the compiler will only emit these instructions if you
> compile with the right target platform (-mpopcnt or something that
> includes it on x86_64). Portable generic builds will usually not use
> it. Still, even without the special instruction __builtin_popcountll()
> should generate more optimal code than the naive
> add-each-bit-one-by-one approach. For example, I came up with this
> pure C implementation of 64-bit popcount [1] that both GCC and Clang
> can compile down to ~36 instructions. The generic version of
> __builtin_popcountll() likely does something similar. (Actually, here
> is what Clang seems to use [2], which is pretty close.)
>
> FWIW, I tested the __builtin_popcountll() version with the caching
> patch reverted (built without popcnt support) and it actually
> performed even better than the old code + caching (it went down to
> ~0.11% of semodule -B running time). A naive popcount implementation
> without caching didn't perform as good (was slower than the old code +
> caching).
>
> So... we could just open-code some good generic C implementation
> (cleanly written and properly commented, of course) and then we
> wouldn't have to rely on the compiler builtin. OTOH, the SELinux
> userspace already uses non-standard compiler extensions
> (__attribute__(...)), so maybe sticking to pure C is not worth it...
> Either way I think we should revert the caching patch along with
> switching to an optimized implementation (it would no longer be worth
> the added complexity IMO).

+2 using the compiler intrinsic. In all reality, for libselinux
targets, their are
two compilers, gcc and clang and they have full support for this.

>
> [1] https://gcc.godbolt.org/z/39W7qa
> [2] https://github.com/llvm-mirror/compiler-rt/blob/master/lib/builtins/popcountdi2.c
>
> >
> > For others, (do they even matter at this point) I would imagine GCC
> > does something relatively sane.
> >
> > >
> > > Cheers,
> > > Nicolas
> > >
> >
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Software Engineer, Security Technologies
> Red Hat, Inc.
>
