Return-Path: <SRS0=F/Jq=4N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E0AC35E15
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 21:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C387620838
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 21:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgBYVdi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Feb 2020 16:33:38 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:52549 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgBYVdi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Feb 2020 16:33:38 -0500
X-Greylist: delayed 503 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Feb 2020 16:33:37 EST
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 3502C564876
        for <selinux@vger.kernel.org>; Tue, 25 Feb 2020 22:25:10 +0100 (CET)
Received: by mail-oi1-f177.google.com with SMTP id q84so819877oic.4
        for <selinux@vger.kernel.org>; Tue, 25 Feb 2020 13:25:10 -0800 (PST)
X-Gm-Message-State: APjAAAXuJOrKtMweHUg2530hLNP8i5Yp7rdzNXisqvUvrCUndgCr+KA8
        TwAEdBegwXar+Sa8am+q/DPLXQzNOKIa2Px3CvA=
X-Google-Smtp-Source: APXvYqx9OFCTAa6bZYYdazoUtkPr1oh6ePsE69VE06GqHc8H4qQmxc9twGlbrABwNj2B4vI/j+vTdwkLt4HKMQYuiTQ=
X-Received: by 2002:aca:dc45:: with SMTP id t66mr710521oig.39.1582665908926;
 Tue, 25 Feb 2020 13:25:08 -0800 (PST)
MIME-Version: 1.0
References: <20200213133959.14217-1-omosnace@redhat.com> <CAFqZXNuxHYN_cMY1+PfUFrwu6dQyG5qc7LGPU8VbUAyTXRF_Wg@mail.gmail.com>
 <7d80365c-d2ea-f167-0757-6038becdb5fc@tycho.nsa.gov> <CAFqZXNuvL1KQwahXPJKngr_p7sON0SNM=5Mecao0QhAGfRTN2g@mail.gmail.com>
In-Reply-To: <CAFqZXNuvL1KQwahXPJKngr_p7sON0SNM=5Mecao0QhAGfRTN2g@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 25 Feb 2020 22:24:58 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==_-vg1e3LV-Wbf94PjFu86pxc3-J6BqJ_Qa73uaj+pkw@mail.gmail.com>
Message-ID: <CAJfZ7==_-vg1e3LV-Wbf94PjFu86pxc3-J6BqJ_Qa73uaj+pkw@mail.gmail.com>
Subject: Re: [PATCH userspace v2] libsepol: cache ebitmap cardinality value
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Feb 25 22:25:10 2020 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 18, 2020 at 5:01 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Tue, Feb 18, 2020 at 4:40 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On 2/18/20 10:22 AM, Ondrej Mosnacek wrote:
> > > On Thu, Feb 13, 2020 at 2:40 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >> According to profiling of semodule -BN, ebitmap_cardinality() is called
> > >> quite often and contributes a lot to the total runtime. Cache its result
> > >> in the ebitmap struct to reduce this overhead. The cached value is
> > >> invalidated on most modifying operations, but ebitmap_cardinality() is
> > >> usually called once the ebitmap doesn't change any more.
> > >>
> > >> After this patch, the time to do 'semodule -BN' on Fedora Rawhide has
> > >> decreased from ~14.6s to ~12.4s (2.2s saved).
> > >
> > > I have no idea why, but I'm now getting completely different times
> > > (10.9s vs. 8.9s) with the same builds on the same setup... I can no
> > > longer reproduce the slower times anywhere (F31/locally/...) so I have
> > > to assume it was some kind of glitch. Since the numbers show a similar
> > > magnitude of speed-up (and they depend on a bunch of HW/SW factors
> > > anyway), I'm not going to do another respin. The applying person (most
> > > likely Stephen) is free to fix the numbers when applying if they wish
> > > to do so.
> >
> > Thanks, applied with fixed times (although I don't really think it
> > matters very much).  Maybe you're also picking up the difference from
> > the "libsepol/cil: remove unnecessary hash tables" change.
>
> No, that was actually the reason for the first correction.

Hello,
About performance issues, the current implementation of
ebitmap_cardinality() is quadratic:

for (i=ebitmap_startbit(e1); i < ebitmap_length(e1); i++)
    if (ebitmap_get_bit(e1, i))
        count++;

... because ebitmap_get_bit() browse the bitmap:

while (n && (n->startbit <= bit)) {
   if ((n->startbit + MAPSIZE) > bit) {
      /*... */

A few years ago, I tried modifying this function to make it linear in
the bitmap size:

unsigned int ebitmap_cardinality(ebitmap_t *e1)
{
    unsigned int count = 0;
    ebitmap_node_t *n;

   for (n = e1->node; n; n = n->next) {
        count += __builtin_popcountll(n->map);
    }
    return count;
}

... but never actually sent a patch for this, because I wanted to
assess how __builtin_popcountll() was supported by several compilers
beforehand. Would this be helpful to gain even more performance gain?

Cheers,
Nicolas

