Return-Path: <SRS0=9nrh=RX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE08C43381
	for <selinux@archiver.kernel.org>; Wed, 20 Mar 2019 03:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F2B20857
	for <selinux@archiver.kernel.org>; Wed, 20 Mar 2019 03:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="S1HlFkw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfCTDEZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Mar 2019 23:04:25 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36173 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfCTDEZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Mar 2019 23:04:25 -0400
Received: by mail-lf1-f68.google.com with SMTP id d18so733295lfn.3
        for <selinux@vger.kernel.org>; Tue, 19 Mar 2019 20:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/xEOuSpnnny7FwBzjVz+RjkjMXqJRhko2R+TldFWB+Q=;
        b=S1HlFkw9z8YPMrfP2dpxcQ6ei1DH9dONBAveqorvNk90rUMEZGhoAtubcv9uS7eP/b
         vT2Oo9/KKUVOGjOTy9wNV4dgXk865Wj79rb2n6mYublW9rMQfL9GZuvEjTtetHw/DEMq
         yLapGv/0QTMbkSe287sn+o7+iDYjiB9A+tm/jae7xJbGbmWLcc7Ds86KfgZSpQx68f7/
         GR77k0434UMRbPWtgukrpsAH/SaybpMGJ0DyFF0jEwFazEx0MSieIK7I51MljzJt+A5C
         0JSAdqD2shQBCJRHob/XgVPpmfLTsh8oSYWHBQqh0ddeRAVVts+blrD4vAVntKuAlVbs
         9YSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/xEOuSpnnny7FwBzjVz+RjkjMXqJRhko2R+TldFWB+Q=;
        b=RrV0NnFtwketeqWnz1v575D0dFs6Mtnc9JZwpaGBNH8vSqICuXrwfe9ha9bsRRR3Zv
         lX3khPLQ7euuj8wFNqtoilWQTkvIXtDMmdjhws3WtZiAMY3xqTUKFnpQiCu9FCDpJ8k2
         WRpAfLnxclz88WBUHLwzhT0FxG9mU3SjYsH4PBpDWXJ7e3m0eVvHKfRuGCiCHlZ8QGVF
         udPlDspplv/J5/6E44z2PnXX7GAxhlMbJJEV+h+FBZ/hjcRPeK1+UsxGWMN+DLsjGH6t
         ihPvwazzM3j1o3Vj2ePaZ/qsQJhCsLBssTEYOIjPxUg78M+oVPGfAOUmk4Txea29juKo
         /dUw==
X-Gm-Message-State: APjAAAXlAHTPeM1KgDnoUgPhIlgBD35GwU25gdP5ANhpvqPdiuZIg4rN
        P8AR7i8eqtC9DIoA1KAEgbRnKvWtj6z80Q1jaAZQ
X-Google-Smtp-Source: APXvYqxjWaG/aT+U2KkHoHEIZNQLZ2wUY+414SxZIjbO0mvkjh0IIrj01/MEJf39hXeurwqQ95nH7jHdKKhvjN5YllU=
X-Received: by 2002:a19:ee11:: with SMTP id g17mr5937436lfb.117.1553051062605;
 Tue, 19 Mar 2019 20:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhS1vRJuxxdzVsvkBVVVzt-3g9Q3qHSeeVPB9=JH+nNXbg@mail.gmail.com>
 <CAHRSSEwoR2-=pTRw1crXTXt-uOHe52UPof3hLcbZoVPDV5N4yw@mail.gmail.com>
 <CAHC9VhSwoCEDd8BgQ6_D8TRuVXJFNTavkAjyjFEAneVxBAwJ2Q@mail.gmail.com>
 <CAHRSSEzWFQi4PO3qBLziAVcsqe3O_u4LK9hJHa0Pyq3UZLW=BQ@mail.gmail.com>
 <CAHC9VhRcrNBRxkLxd5-biRJRqhby5hEOWHkv8hrsU87QOjpXGA@mail.gmail.com>
 <CAHC9VhTzj7gNj6jJ13pquP5im+kqG--qfYn2O0=xB=n5sB7s3w@mail.gmail.com>
 <CAHRSSEzt_d=8r34PJuyu5u6DWm461XXGhEVYignfktvj8pWSgg@mail.gmail.com>
 <CAHC9VhT_OWOU97C2NeDq8TWQzsu74V7maLWSXPhBFUKwrTvtCA@mail.gmail.com>
 <CAHRSSEwM+XXxzxabmiPBEt=t80Jes16yjJhHhsOtGy4meYu2mw@mail.gmail.com> <CAHRSSEyKaV5a6C5fBV8NDm02Cxu2DfVsA7YbbEE8CDkn68KtzA@mail.gmail.com>
In-Reply-To: <CAHRSSEyKaV5a6C5fBV8NDm02Cxu2DfVsA7YbbEE8CDkn68KtzA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 Mar 2019 23:04:11 -0400
Message-ID: <CAHC9VhTDNspsA7ht=hkTbQZVmGKJWLoDEF-46kxFKvdMwA4hKw@mail.gmail.com>
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

On Tue, Mar 19, 2019 at 9:08 PM Todd Kjos <tkjos@google.com> wrote:
> Paul,
>
> Looking at a snippet of the test output:
>
>     Service Provider read_consumed: 8
>     Service Provider command: BR_NOOP
>     Service Provider command: BR_FAILED_REPLY  <-------------- the txn
> failed as expected.
>     Manager read_consumed: 8
>     Manager command: BR_NOOP
>     Manager command: BR_TRANSACTION_COMPLETE
>     not ok 3
>         <--------- but for some reason didn't exit(103)
>     #   Failed test at ./test line 56.
>
> It looks like the test script expects test_binder to fail with
> exit(103) after processing the Server Provider commands. It's not
> clear why it didn't, since the return of a BR_FAILED_REPLY for that
> transaction should have executed this code (line 392 of
> test_binder.c):
>
>     if (cmd == BR_FAILED_REPLY ||
>         cmd == BR_DEAD_REPLY ||
>         cmd == BR_DEAD_BINDER) {
>         fprintf(stderr,
>                   "Failed response from Service Provider using Managers FD\n");
>         exit(103);
>     }
>
> Could this be an issue with the test? At least it doesn't look like a
> transaction is succeeding when it shouldn't.

Hi Todd,

Thanks for looking into this further.  Look a bit more at the test, it
appears that the code above (line 392) only comes into play if the
service provider is handling a BR_REPLY, but looking at the test
output it doesn't appear that this is the case.

# runcon -t test_binder_provider_no_im_t ./test_binder -v -r 2 provider
Service Provider PID: 2095 Process context:
       unconfined_u:unconfined_r:test_binder_provider_no_im_t:s0-s0:c0.c1023
Service Provider sending transaction to Manager - ADD_TEST_SERVICE
Service Provider read_consumed: 48
Service Provider command: BR_NOOP
Service Provider command: BR_INCREFS
Service Provider command: BR_ACQUIRE
Service Provider command: BR_TRANSACTION_COMPLETE

Service Provider read_consumed: 8
Service Provider command: BR_NOOP
Service Provider command: BR_FAILED_REPLY

However, things get weird.  In the course of writing this email I
booted into my 5.0.0-1.1.secnext kernel (which passed the binder test
earlier) and now that kernel is failing in the same way (the test
hasn't changed).  This test system is a Fedora Rawhide system which is
updated before I make a test run and I'm wondering if there is some
other userspace component which may be affecting this ... ?  I've now
tried this on two different, current Rawhide VMs, hosted on two
different systems and I'm seeing the same thing, so I don't think it's
a *bad* system/VM?

> On Tue, Mar 19, 2019 at 5:15 PM Todd Kjos <tkjos@google.com> wrote:
> >
> > [...]
> >
> > > > Is there a public dashboard where I can take a look at those binder failures?
> > >
> > > Not really.  I send test results to a not-yet-publicized mailing list,
> > > but there is more detail in the GitHub issue below (my last comment
> > > has the verbose test output):
> > >
> > > * https://github.com/SELinuxProject/selinux-kernel/issues/46
> > >
> >
> > Ok, so it looks like something was introduced that causes binder to be
> > too permissive (test 3 transaction succeeded when failure is
> > expected). I don't know of any recent binder changes that could have
> > caused that.
> >
> > It will take me a while to set up this test environment. Is this easy
> > for you to run? Any chance of bisecting or at least trying a few
> > versions to narrow it down? Here's a list of the recent patchset -- it
> > would be useful to know which caused it (or if none of them did):
> >
> > 9e98c678c2d6a Linux 5.1-rc1
> > ...
> > 26528be6720bb binder: fix handling of misaligned binder object
> > bde4a19fc04f5 binder: use userspace pointer as base of buffer space
> > c41358a5f5217 binder: remove user_buffer_offset
> > db6b0b810bf94 binder: avoid kernel vm_area for buffer fixups
> > 7a67a39320dfb binder: add function to copy binder object from buffer
> > 8ced0c6231ead binder: add functions to copy to/from binder buffers
> > 1a7c3d9bb7a92 binder: create userspace-to-binder-buffer copy function
> > ...
> > 1c163f4c7b3f6 (tag: v5.0) Linux 5.0
> >
> > Thanks,
> >
> > -Todd



--
paul moore
www.paul-moore.com
