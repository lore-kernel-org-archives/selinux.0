Return-Path: <SRS0=9nrh=RX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FFEC43381
	for <selinux@archiver.kernel.org>; Wed, 20 Mar 2019 23:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFDA2175B
	for <selinux@archiver.kernel.org>; Wed, 20 Mar 2019 23:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="cGvIbZr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfCTXfK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Mar 2019 19:35:10 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36092 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfCTXfK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Mar 2019 19:35:10 -0400
Received: by mail-lj1-f196.google.com with SMTP id v10so3802152lji.3
        for <selinux@vger.kernel.org>; Wed, 20 Mar 2019 16:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jitxw9GNuKwY1+M5hcM5YtK3cBdvbyNjS7QjcrPz+FI=;
        b=cGvIbZr4+z/VjdpPj55nI0MMCkcWtweZbtDHgWKQM7qpsJgv67kBdAbdKS2HbpEXAF
         BEmSC9xf8Ej4iqyIYmWSiX4J/66eBCLXEeP1TvBQcSREs9yAFpUb0qq6yl9vLIWV8D3n
         DFZKo6vXpOXgj/Ypl4MJDPsDN7dY0Q3joKDCz+0QoLkie4zr21WRcFFEhJHOJceOOemj
         gGlovHG1A/KFIlSzOxPmN2plWjCBe9YXSx/cncankpiV5SpNjmrCHcnYsNNa9urd/yIx
         uvcKBX/DypzOUQVyVTjolgKAao3c0hB692hQE2oYgQisjMuMl6PT9aV9VuCYmUnEhQD4
         lxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jitxw9GNuKwY1+M5hcM5YtK3cBdvbyNjS7QjcrPz+FI=;
        b=oUtvT8KAKxqmwiV468Gk+Zghzyw6vMzErtUmGtaSGBYdXKAGz3YL1Pyd22sNCWw1uv
         6PsOLepJKQTVu24GJ1V98o+J60w/OxZh7nrptcut9BJKngvEZzDmWeS9ghuc7mAUTUbP
         oyy8MhJupRf1uwaSk33vz8fUZOTldbzs1B3rIjJR04J7rJaI1JwJgGGjUfVUYX1hAkGr
         Wn4j7Xel/+qqXOoIuS72QpT+ace96/gIfdwiyXUkZFPiGQzz6Pc5y4rV+Bw9RypT2wYV
         9xnEYWBFt6BQWmalxsA/3am6vmd/o5f6GXkXvZHwyfy826OpdTvkPtQXFGs25mrSCPbB
         YVOw==
X-Gm-Message-State: APjAAAXVfH3p4plOklWrO5qopPNtdwpkiGIMkywT8d0TMMiTU0lidtZ5
        KHwNrLUFdHxiAtdbianDp2Dw68FWx5OmIUCUtQnd6Og=
X-Google-Smtp-Source: APXvYqwBg7U+XMSTFarRNGtefS5FbNnNbLZWLXwQSC2rKUyvO88to4DarUWltpqkJ0/AkreP0xkcuzqqG3tU9eJLeN8=
X-Received: by 2002:a2e:413:: with SMTP id 19mr331264lje.196.1553124908375;
 Wed, 20 Mar 2019 16:35:08 -0700 (PDT)
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
 <CAHRSSEz7GTS3NyHDf5r9qKM6NrCcnxh=U3tEyY+6JqS9=RH1QQ@mail.gmail.com>
 <CAHC9VhT406VM76XPqcBPN9-R1h_WTDnbdvwQk=X_bHC_Gvq=qQ@mail.gmail.com> <CAHRSSExzUeqBsu-wpGe_Y199mXOKm_oZpdmDby5s3hq528r4dA@mail.gmail.com>
In-Reply-To: <CAHRSSExzUeqBsu-wpGe_Y199mXOKm_oZpdmDby5s3hq528r4dA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 20 Mar 2019 19:34:57 -0400
Message-ID: <CAHC9VhQb37y_cCsxtDmtzgTV70igV9XKTE8v97r8piS77Ycevg@mail.gmail.com>
Subject: Re: v5.1-rc1 binder_alloc_do_buffer_copy() BUG_ON triggered by selinux-testsuite
To:     Todd Kjos <tkjos@google.com>
Cc:     Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        selinux@vger.kernel.org,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 20, 2019 at 7:26 PM Todd Kjos <tkjos@google.com> wrote:
> I can send you a patch tomorrow (I won't be able to test it though).

I may not know much about binder, but I do know how to run the test suite :)

Thanks Todd.

> On Wed, Mar 20, 2019 at 4:23 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Wed, Mar 20, 2019 at 3:50 PM Todd Kjos <tkjos@google.com> wrote:
> > >
> > > Paul,
> > >
> > > Looking at main() in test_binder.c...
> > >
> > > int main(int argc, char **argv)
> > > {
> > >
> > > [...]
> > >
> > >   // Line 493
> > >   struct binder_write_read bwr;
> > >   struct flat_binder_object obj;
> > >   struct {
> > >     uint32_t cmd;
> > >     struct binder_transaction_data txn;
> > >   } __attribute__((packed)) writebuf;
> > >   unsigned int readbuf[32];
> > >
> > > [...]
> > >   // Line 630
> > >   writebuf.txn.data.ptr.buffer = (uintptr_t)&obj;
> > >   writebuf.txn.data.ptr.offsets = (uintptr_t)&obj +   // [A]
> > >                                                  sizeof(struct
> > > flat_binder_object);
> > >
> > >   bwr.write_buffer = (uintptr_t)&writebuf;
> > >   bwr.write_size = sizeof(writebuf);
> > >
> > > It looks like bwr.txn.data.ptr.offsets points off the end of obj (see
> > > [A] above), which means the binder driver will read compiler-dependent
> > > stack data as the offset for the object. If it happens to be 0, then
> > > the test will work (read the object from offset 0). If it's not 0,
> > > then most likely offset > data_size (which is what found that BUG_ON
> > > case). With my patch applied, this will just cause an error to be
> > > returned (what you are seeing now).
> > >
> > > Same thing when you test with v5.0 -- if the offset happens to be 0,
> > > then the test will succeed. If not, then the test will fail because
> > > the transaction fails in an unexpected way.
> >
> > That might explain why the test used to work, but now fails - a
> > different compiler (I rebuild the test before each test run).
> >
> > Keeping in mind I'm really quite ignorant when it comes to binder, how
> > would you suggest fixing the test?
> >
> > --
> > paul moore
> > www.paul-moore.com



-- 
paul moore
www.paul-moore.com
