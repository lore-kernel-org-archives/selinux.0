Return-Path: <SRS0=MVxc=RY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AD1C43381
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 09:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C3C20850
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 09:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfCUJuy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:50:54 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42738 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfCUJuy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Mar 2019 05:50:54 -0400
Received: by mail-ot1-f68.google.com with SMTP id 103so4856046otd.9
        for <selinux@vger.kernel.org>; Thu, 21 Mar 2019 02:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=32NVB9FtxCQjrESLv16qL0VmNywIOphSS2hV22yYrY4=;
        b=nWPcpdSH91wsxIVFS9DOBjewLGfHscTJC8AlDgAT4NAcmsnEerLPDd2wqmSY3SMhXZ
         yPfwZe1weCzoLMUQ8UjrO/qow6059QpWAcJJscccpw4oyeMtbQYyE2kYLv+7HvYE/C3y
         DijhBBSOM4s8Sa/NQc486l9aw60l3+kqdC+VX1P93lCJ6YZlY3kELhSyOzafS8AVMcOs
         pOispGd6/OULlemJKZd6Ab9CIXd9cGdbCzA24Uhz2O/leiRR4osjUr4wb6GwQOiNeQdD
         BVeW8Ys2hLaCR1+8lItKQqVX97TMGiA+skAahomOscD5LKWCE+l+JFHeOGgPGsUlzjxZ
         G7Gg==
X-Gm-Message-State: APjAAAVCEd4wKnqpuZeyt4BvVhhICNMy25mu/dyku+DbW1Xe9MNb38XK
        7ZJ2nwCyGzQ+ByR6zcbX/JmxxQeZn4dPL1BrXhM14g==
X-Google-Smtp-Source: APXvYqyInuBBn7r4RbAHQRwfMJ42VbM3qaV3P6kaVWnSVp8vciBPpHaR4pyS0jB2JdEdfUkeGD8FdgcCy2HMDFRLiIA=
X-Received: by 2002:a9d:6306:: with SMTP id q6mr1772225otk.86.1553161853973;
 Thu, 21 Mar 2019 02:50:53 -0700 (PDT)
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
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 21 Mar 2019 10:50:42 +0100
Message-ID: <CAFqZXNv6N9YWOr13=+PfjUWa1QJ=GBJUbkBtxbqif1VgOUpNKA@mail.gmail.com>
Subject: Re: v5.1-rc1 binder_alloc_do_buffer_copy() BUG_ON triggered by selinux-testsuite
To:     Todd Kjos <tkjos@google.com>
Cc:     Paul Moore <paul@paul-moore.com>, Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        selinux@vger.kernel.org,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 21, 2019 at 12:26 AM Todd Kjos <tkjos@google.com> wrote:
> I can send you a patch tomorrow (I won't be able to test it though).

So, I was a bit quicker than you and I think I managed to fix the test myself :)

See:
https://github.com/SELinuxProject/selinux-testsuite/pull/50/commits/b559c3f54eae6130cb9e79c295b0f94db26e09e4

It seems the problem was indeed in the offsets array handling as you
discovered. With the above commit included the PR#50 version of the
binder test no longer fails for me.

Thanks,

>
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
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
