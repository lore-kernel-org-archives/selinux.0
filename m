Return-Path: <SRS0=MVxc=RY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0748EC43381
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 15:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC646218A5
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 15:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cn3ElQij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfCUPse (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:48:34 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35311 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbfCUPsd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Mar 2019 11:48:33 -0400
Received: by mail-qt1-f196.google.com with SMTP id h39so7152941qte.2
        for <selinux@vger.kernel.org>; Thu, 21 Mar 2019 08:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JadG8oqJAnJ8Gf/zANzTNMuo6+PgBu1RXKCtEUj2w94=;
        b=cn3ElQijGSk0rfQH4CMal0pivXyhU2uat2bgrtOR4ayQVwpJk1o5aKn0OpEl4ieBnX
         ac/x2DpCiK7+TysBo0oNWyNAAB6cD9wf5yiyXjTO7EXu/fiNSVLsJ45/AM5MZGR6YJTy
         /cz5smB9GxGAfZPkgU0TvTPbmlJ6SiIAtpmk36yHcPNBrkT5MSc1VOic3fgxd38d/+fW
         Z7mVKZjk5CMEEOeSnGYzNQMIrxLmY7bFzzvTYEMUt1DoxYOYxK5WRIUBDlzRTOJdq1kW
         37cumgcPfFsag3wVTGOYRydZmdW8KF/ij2jFgC7a3uehYyXeqFt3sZ1wyjXfzs+86TYQ
         4WrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JadG8oqJAnJ8Gf/zANzTNMuo6+PgBu1RXKCtEUj2w94=;
        b=qtt4qajzdbb9AG5LUYWe42LqHBDGvv9Zkt6YHnb1UBUYKyl4Vhpo8yeomXOM+eVQvK
         ubWiugcgdEOtE5eDwOTbIBxenbpqv8bNIEDO25OwlGYqDCxBX15yDaJkaXvW/mFZA2Fa
         lKSX5XYvrSodtHNYyN/+nYRtgsgSJlgKn0y8a7YTNYD8uGgZoAOO+iQf/luRQnJPmw46
         iOuRURX3DsfR7dKp6AQH4NEemMVZJH7UHo+fEN8SdfmfDrMOVig5f/kpaIxi7iLnrZ+g
         LKAoJsZ3Ucx326PRw0HBk/cksNThXZiaBD3th9uJut46y6GXD9PTWz/QquJNAxy4x6u1
         bJAA==
X-Gm-Message-State: APjAAAXoiFDH/s/1YSAnBJTZFtjCfgQhjqvYI2eJX9mwA9XEEPGzExHm
        Uc+2Wogbjv+n8OcHrJs/+FQwSKZgrnA4RK/01kLNTg==
X-Google-Smtp-Source: APXvYqxNGMtwTvDG7w/zhyCGU5gGhnq9Fz4aMP4bk3AkSMeSVwN0Sd0A6fvMHOcuW9Aa4Yu/NzbMHEhe7YARYDSyu+o=
X-Received: by 2002:ac8:28e4:: with SMTP id j33mr3629956qtj.349.1553183311444;
 Thu, 21 Mar 2019 08:48:31 -0700 (PDT)
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
 <CAHC9VhT406VM76XPqcBPN9-R1h_WTDnbdvwQk=X_bHC_Gvq=qQ@mail.gmail.com>
 <CAHRSSExzUeqBsu-wpGe_Y199mXOKm_oZpdmDby5s3hq528r4dA@mail.gmail.com> <CAFqZXNv6N9YWOr13=+PfjUWa1QJ=GBJUbkBtxbqif1VgOUpNKA@mail.gmail.com>
In-Reply-To: <CAFqZXNv6N9YWOr13=+PfjUWa1QJ=GBJUbkBtxbqif1VgOUpNKA@mail.gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Thu, 21 Mar 2019 08:48:18 -0700
Message-ID: <CAHRSSEzktyn5uWdGobUKdkWLn8cwyQCbSo7C2vvn92EQvKciqw@mail.gmail.com>
Subject: Re: v5.1-rc1 binder_alloc_do_buffer_copy() BUG_ON triggered by selinux-testsuite
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        selinux@vger.kernel.org,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 21, 2019 at 2:50 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Thu, Mar 21, 2019 at 12:26 AM Todd Kjos <tkjos@google.com> wrote:
> > I can send you a patch tomorrow (I won't be able to test it though).
>
> So, I was a bit quicker than you and I think I managed to fix the test myself :)
>
> See:
> https://github.com/SELinuxProject/selinux-testsuite/pull/50/commits/b559c3f54eae6130cb9e79c295b0f94db26e09e4

Looks good. Thanks!

>
> It seems the problem was indeed in the offsets array handling as you
> discovered. With the above commit included the PR#50 version of the
> binder test no longer fails for me.
>
> Thanks,
>
> >
> > On Wed, Mar 20, 2019 at 4:23 PM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > On Wed, Mar 20, 2019 at 3:50 PM Todd Kjos <tkjos@google.com> wrote:
> > > >
> > > > Paul,
> > > >
> > > > Looking at main() in test_binder.c...
> > > >
> > > > int main(int argc, char **argv)
> > > > {
> > > >
> > > > [...]
> > > >
> > > >   // Line 493
> > > >   struct binder_write_read bwr;
> > > >   struct flat_binder_object obj;
> > > >   struct {
> > > >     uint32_t cmd;
> > > >     struct binder_transaction_data txn;
> > > >   } __attribute__((packed)) writebuf;
> > > >   unsigned int readbuf[32];
> > > >
> > > > [...]
> > > >   // Line 630
> > > >   writebuf.txn.data.ptr.buffer = (uintptr_t)&obj;
> > > >   writebuf.txn.data.ptr.offsets = (uintptr_t)&obj +   // [A]
> > > >                                                  sizeof(struct
> > > > flat_binder_object);
> > > >
> > > >   bwr.write_buffer = (uintptr_t)&writebuf;
> > > >   bwr.write_size = sizeof(writebuf);
> > > >
> > > > It looks like bwr.txn.data.ptr.offsets points off the end of obj (see
> > > > [A] above), which means the binder driver will read compiler-dependent
> > > > stack data as the offset for the object. If it happens to be 0, then
> > > > the test will work (read the object from offset 0). If it's not 0,
> > > > then most likely offset > data_size (which is what found that BUG_ON
> > > > case). With my patch applied, this will just cause an error to be
> > > > returned (what you are seeing now).
> > > >
> > > > Same thing when you test with v5.0 -- if the offset happens to be 0,
> > > > then the test will succeed. If not, then the test will fail because
> > > > the transaction fails in an unexpected way.
> > >
> > > That might explain why the test used to work, but now fails - a
> > > different compiler (I rebuild the test before each test run).
> > >
> > > Keeping in mind I'm really quite ignorant when it comes to binder, how
> > > would you suggest fixing the test?
> > >
> > > --
> > > paul moore
> > > www.paul-moore.com
>
>
>
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Software Engineer, Security Technologies
> Red Hat, Inc.
