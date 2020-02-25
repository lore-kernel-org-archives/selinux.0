Return-Path: <SRS0=F/Jq=4N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC6CC4BA01
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 21:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE1622464
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 21:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQr57kNq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgBYV5I (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Feb 2020 16:57:08 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:43982 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgBYV5I (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Feb 2020 16:57:08 -0500
Received: by mail-il1-f193.google.com with SMTP id p78so528424ilb.10
        for <selinux@vger.kernel.org>; Tue, 25 Feb 2020 13:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qjvsVBF0Ew/1ekJJv8+tW4ajsf5hp8WvAy2VFs/5SeM=;
        b=eQr57kNq6N+wPITcb6g8LTKacNhd9JbF6YN5ipaDuDXdLUZg61oFnTQmnsk7kkWiAo
         cHrGVg7soacb/S/tGBgmmlIn+9Za+3ud3CsIO623Vyk52InHLK1MsBUaHG4dxSIwpcej
         daHZYdCVGX3qvnNCWCm7v1IAqbYvHzUO/YT41pbKHI9SinXQOBQ6dhJaPo5VUHP81uDs
         nOtATd96zQRuxRhg4fjDo4Jt2jM4oB2u5+hxIONh6AopjGSSYGKx7aYCnp2KzvSVBSMF
         dfdHoas7VFoACRdmtSIQZcupnIJzmjhWhamRShUVet5DFmi5EfnLMVxA1yMfZWP8mOC7
         t96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qjvsVBF0Ew/1ekJJv8+tW4ajsf5hp8WvAy2VFs/5SeM=;
        b=nb9qRiEXHMlI7qfTOwIhh+xIksIpH05ABTbAfiGifNaylIa0wtxdC4vGcBET40FkLb
         tt/c4OBTNgevlXrrBWrql6VOtxWu9oS0BUupKI0liQWz2bvIbITAKRzG7N/jXACoQUoA
         WrvTBrywfqwz/yOSnj82h1+cqVG2E+XjBAo64EhRMmyWzyb3eDMcRovjVrHRvpxEEu1w
         n/Ol+Jhe+3Tyr3TSnbYWQkXLNTBIvyZyM2mqA+YJNs3exKemcHc/y7H3LoftdfL3E11w
         AKKr2wfKD13vLtkg6jbNyG5Sr3eX0j0EDCdh+VCNNHomFyPsSLE6nJ4BObcaTaAiC2r4
         Q4Mg==
X-Gm-Message-State: APjAAAVdD67k+1Ls1aP8VCvDleq1RgkNN4PQVq7cECPxgC5sq8lmGb4H
        JDDSPWuWCmLH4bzNWJNI0zRpVjiUppERA+LDUfA=
X-Google-Smtp-Source: APXvYqwXf36fHMDHeQ/uaBzIZ5UGFveTqEyk+hSFGR3l9TWFeDnOar7cfz7eLA1oKnhTMymj+W+6TO6LYWo2pLdMy0s=
X-Received: by 2002:a92:8c54:: with SMTP id o81mr751175ild.163.1582667825537;
 Tue, 25 Feb 2020 13:57:05 -0800 (PST)
MIME-Version: 1.0
References: <20200213133959.14217-1-omosnace@redhat.com> <CAFqZXNuxHYN_cMY1+PfUFrwu6dQyG5qc7LGPU8VbUAyTXRF_Wg@mail.gmail.com>
 <7d80365c-d2ea-f167-0757-6038becdb5fc@tycho.nsa.gov> <CAFqZXNuvL1KQwahXPJKngr_p7sON0SNM=5Mecao0QhAGfRTN2g@mail.gmail.com>
 <CAJfZ7==_-vg1e3LV-Wbf94PjFu86pxc3-J6BqJ_Qa73uaj+pkw@mail.gmail.com>
In-Reply-To: <CAJfZ7==_-vg1e3LV-Wbf94PjFu86pxc3-J6BqJ_Qa73uaj+pkw@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Tue, 25 Feb 2020 15:56:54 -0600
Message-ID: <CAFftDdrEqVV-q-nJZmPUEYwr56YPPGPjv3WE2400QkTqyTo-rQ@mail.gmail.com>
Subject: Re: [PATCH userspace v2] libsepol: cache ebitmap cardinality value
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 25, 2020 at 3:33 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Tue, Feb 18, 2020 at 5:01 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Tue, Feb 18, 2020 at 4:40 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > On 2/18/20 10:22 AM, Ondrej Mosnacek wrote:
> > > > On Thu, Feb 13, 2020 at 2:40 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > >> According to profiling of semodule -BN, ebitmap_cardinality() is called
> > > >> quite often and contributes a lot to the total runtime. Cache its result
> > > >> in the ebitmap struct to reduce this overhead. The cached value is
> > > >> invalidated on most modifying operations, but ebitmap_cardinality() is
> > > >> usually called once the ebitmap doesn't change any more.
> > > >>
> > > >> After this patch, the time to do 'semodule -BN' on Fedora Rawhide has
> > > >> decreased from ~14.6s to ~12.4s (2.2s saved).
> > > >
> > > > I have no idea why, but I'm now getting completely different times
> > > > (10.9s vs. 8.9s) with the same builds on the same setup... I can no
> > > > longer reproduce the slower times anywhere (F31/locally/...) so I have
> > > > to assume it was some kind of glitch. Since the numbers show a similar
> > > > magnitude of speed-up (and they depend on a bunch of HW/SW factors
> > > > anyway), I'm not going to do another respin. The applying person (most
> > > > likely Stephen) is free to fix the numbers when applying if they wish
> > > > to do so.
> > >
> > > Thanks, applied with fixed times (although I don't really think it
> > > matters very much).  Maybe you're also picking up the difference from
> > > the "libsepol/cil: remove unnecessary hash tables" change.
> >
> > No, that was actually the reason for the first correction.
>
> Hello,
> About performance issues, the current implementation of
> ebitmap_cardinality() is quadratic:
>
> for (i=ebitmap_startbit(e1); i < ebitmap_length(e1); i++)
>     if (ebitmap_get_bit(e1, i))
>         count++;
>
> ... because ebitmap_get_bit() browse the bitmap:
>
> while (n && (n->startbit <= bit)) {
>    if ((n->startbit + MAPSIZE) > bit) {
>       /*... */
>
> A few years ago, I tried modifying this function to make it linear in
> the bitmap size:
>
> unsigned int ebitmap_cardinality(ebitmap_t *e1)
> {
>     unsigned int count = 0;
>     ebitmap_node_t *n;
>
>    for (n = e1->node; n; n = n->next) {
>         count += __builtin_popcountll(n->map);
>     }
>     return count;
> }
>
> ... but never actually sent a patch for this, because I wanted to
> assess how __builtin_popcountll() was supported by several compilers
> beforehand. Would this be helpful to gain even more performance gain?

Every architecture I've used has an instruction it boils down to:
x86 - POPCNT
ARM (neon): vcnt

For others, (do they even matter at this point) I would imagine GCC
does something relatively sane.

>
> Cheers,
> Nicolas
>
