Return-Path: <SRS0=9nrh=RX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87252C43381
	for <selinux@archiver.kernel.org>; Wed, 20 Mar 2019 23:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9C72183E
	for <selinux@archiver.kernel.org>; Wed, 20 Mar 2019 23:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SRd0dgKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfCTX00 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Mar 2019 19:26:26 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42299 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfCTX00 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Mar 2019 19:26:26 -0400
Received: by mail-qt1-f194.google.com with SMTP id u7so4670336qtg.9
        for <selinux@vger.kernel.org>; Wed, 20 Mar 2019 16:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vJTnkjN7jkb9A8br4wzv8nKck4HLIvyiLbHaSwyLqTQ=;
        b=SRd0dgKoC3I30BZqcXJUwL3MvN06kfAiFwmGIiUU3v4E7zTKNu/UosRS28iWOL1d8s
         O890FOl2OGnhbTfCnUDNZYEMFYrdH0v5vKoCZp0y5aRZ2ubuod2Qr5dxJ8FbyJkJy9RI
         vGBw3slhe4GXFHEfQ0Sl6a7gxvTwMFG7Kt/IspW+XbcOfb57hZo922Cw/2J5Mb35dmIs
         z7evr3rtp0eMQ4MPS6HPPpF7hMDbsdoXFgbL9PKmKNaR4YfJ/TCAIeQcwlVVMtVTa696
         AVXLWo8E7GMgqUsbgYAF+/mhw1RXEx3wKKuGu0f6Mhh2ErTYY8BDnkGC5q7PXRzT6L1E
         Sb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vJTnkjN7jkb9A8br4wzv8nKck4HLIvyiLbHaSwyLqTQ=;
        b=qQKzgQuiDi9WOwiP/EAtCdyDhgpWP/MoGpo70seb6pzns9aj18cUVcBJRysGooiGz2
         E+nNKsVefKmIanIkb1cM4MlNkq2UMdmlgoB12TXxOrDJZiTnqlRIbXFrDTHKU0k3jV6c
         E7sAF2L36sG8Dfs25DydAbAW2RJDFtujED2fvt+aS4N0NMalgeSdTQv9ej+O3b81rwe4
         x25acNQ4Mis+awGpbVsnrsUVgKl3VTPdwDKaMNRQj8/cErz4b3M5X2UzAYSOykmzfk3u
         Cdql1i/FcE9m99DVk4Uh6tTwSugk4/vkaHiMv8BomdEqQ+E1DG9aMqLjkpJX5Q58Ud2l
         VSaA==
X-Gm-Message-State: APjAAAXYVfWHS1XK703HILcvdndCNe6/jcWqMM9StvbvysIPOkhsaI/q
        8iI7GuSRDVF/Lh4osJe8ZNRL22lPOU3DyOv6Omr5zQ==
X-Google-Smtp-Source: APXvYqwOl6tWlrLekPEVp3SLLmX+xaxfG6IWHNKqa5Po+jcAds4Dv92KjrYi6WPKt8vnGwC9kzNevPrhLV1GXYZW2UY=
X-Received: by 2002:ac8:30ea:: with SMTP id w39mr397668qta.351.1553124385111;
 Wed, 20 Mar 2019 16:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhS1vRJuxxdzVsvkBVVVzt-3g9Q3qHSeeVPB9=JH+nNXbg@mail.gmail.com>
 <CAHRSSEwoR2-=pTRw1crXTXt-uOHe52UPof3hLcbZoVPDV5N4yw@mail.gmail.com>
 <CAHC9VhSwoCEDd8BgQ6_D8TRuVXJFNTavkAjyjFEAneVxBAwJ2Q@mail.gmail.com>
 <CAHRSSEzWFQi4PO3qBLziAVcsqe3O_u4LK9hJHa0Pyq3UZLW=BQ@mail.gmail.com>
 <CAHC9VhRcrNBRxkLxd5-biRJRqhby5hEOWHkv8hrsU87QOjpXGA@mail.gmail.com>
 <CAHC9VhTzj7gNj6jJ13pquP5im+kqG--qfYn2O0=xB=n5sB7s3w@mail.gmail.com>
 <CAHRSSEzt_d=8r34PJuyu5u6DWm461XXGhEVYignfktvj8pWSgg@mail.gmail.com>
 <CAHC9VhT_OWOU97C2NeDq8TWQzsu74V7maLWSXPhBFUKwrTvtCA@mail.gmail.com>
 <CAHRSSEwM+XXxzxabmiPBEt=t80Jes16yjJhHhsOtGy4meYu2mw@mail.gmail.com>
 <CAHRSSEyKaV5a6C5fBV8NDm02Cxu2DfVsA7YbbEE8CDkn68KtzA@mail.gmail.com>
 <CAHC9VhTDNspsA7ht=hkTbQZVmGKJWLoDEF-46kxFKvdMwA4hKw@mail.gmail.com>
 <CAHRSSEwm8F1tKbsG6Tyjbwidg0Nwk-oFHt8hYox9gB0TARNgcg@mail.gmail.com>
 <CAHRSSEz7GTS3NyHDf5r9qKM6NrCcnxh=U3tEyY+6JqS9=RH1QQ@mail.gmail.com> <CAHC9VhT406VM76XPqcBPN9-R1h_WTDnbdvwQk=X_bHC_Gvq=qQ@mail.gmail.com>
In-Reply-To: <CAHC9VhT406VM76XPqcBPN9-R1h_WTDnbdvwQk=X_bHC_Gvq=qQ@mail.gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Wed, 20 Mar 2019 16:26:13 -0700
Message-ID: <CAHRSSExzUeqBsu-wpGe_Y199mXOKm_oZpdmDby5s3hq528r4dA@mail.gmail.com>
Subject: Re: v5.1-rc1 binder_alloc_do_buffer_copy() BUG_ON triggered by selinux-testsuite
To:     Paul Moore <paul@paul-moore.com>
Cc:     Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        selinux@vger.kernel.org,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I can send you a patch tomorrow (I won't be able to test it though).

On Wed, Mar 20, 2019 at 4:23 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Wed, Mar 20, 2019 at 3:50 PM Todd Kjos <tkjos@google.com> wrote:
> >
> > Paul,
> >
> > Looking at main() in test_binder.c...
> >
> > int main(int argc, char **argv)
> > {
> >
> > [...]
> >
> >   // Line 493
> >   struct binder_write_read bwr;
> >   struct flat_binder_object obj;
> >   struct {
> >     uint32_t cmd;
> >     struct binder_transaction_data txn;
> >   } __attribute__((packed)) writebuf;
> >   unsigned int readbuf[32];
> >
> > [...]
> >   // Line 630
> >   writebuf.txn.data.ptr.buffer = (uintptr_t)&obj;
> >   writebuf.txn.data.ptr.offsets = (uintptr_t)&obj +   // [A]
> >                                                  sizeof(struct
> > flat_binder_object);
> >
> >   bwr.write_buffer = (uintptr_t)&writebuf;
> >   bwr.write_size = sizeof(writebuf);
> >
> > It looks like bwr.txn.data.ptr.offsets points off the end of obj (see
> > [A] above), which means the binder driver will read compiler-dependent
> > stack data as the offset for the object. If it happens to be 0, then
> > the test will work (read the object from offset 0). If it's not 0,
> > then most likely offset > data_size (which is what found that BUG_ON
> > case). With my patch applied, this will just cause an error to be
> > returned (what you are seeing now).
> >
> > Same thing when you test with v5.0 -- if the offset happens to be 0,
> > then the test will succeed. If not, then the test will fail because
> > the transaction fails in an unexpected way.
>
> That might explain why the test used to work, but now fails - a
> different compiler (I rebuild the test before each test run).
>
> Keeping in mind I'm really quite ignorant when it comes to binder, how
> would you suggest fixing the test?
>
> --
> paul moore
> www.paul-moore.com
