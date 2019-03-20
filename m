Return-Path: <SRS0=9nrh=RX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90D9C43381
	for <selinux@archiver.kernel.org>; Wed, 20 Mar 2019 15:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3762183E
	for <selinux@archiver.kernel.org>; Wed, 20 Mar 2019 15:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SBcV0WfO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbfCTPyO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:54:14 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]:37089 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbfCTPyO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Mar 2019 11:54:14 -0400
Received: by mail-qk1-f175.google.com with SMTP id c1so14432467qkk.4
        for <selinux@vger.kernel.org>; Wed, 20 Mar 2019 08:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XKkVlpahxGrudLWHvGGq8ccBAqDCLB7j0AYAVZDGq8k=;
        b=SBcV0WfOzvHu5T2mc+Qb/lVX98DBhfMpa75MpOMiASNbgVmH5Cn3EvbJYjO4WrxK0U
         DGbcXcmN1NFj+ts1KuiPr3Mq89kKNHWiuN9n12yq0idqzrPkbxGRObsoLJXLIzuZaRDj
         hldjAIMq+NKHc4ZXdfuYBmH0yByzEIzr1VXuEOV/AEj2tXW3pTzU1QmpLpzyjHsrCVfr
         cew5HOwarsOB+Jcv72KsBzejNUItOhpQqRdKFlBwswKSXhvV0TIenhOS+6+3rExWjC1k
         IboiawUyXApTmH2EWlFjqLM85ennvYU0+V2Z5BUickFUQOY/SOGA6cojOjh0fTnoUXMV
         oxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XKkVlpahxGrudLWHvGGq8ccBAqDCLB7j0AYAVZDGq8k=;
        b=pmNf64Az2ahOM/INrEiEnyHZ0Q6eEjtVKxwSvuznxngjHlxe1522IrUH864GYcfQhn
         Ct8nqJBiUZYy66O00oQyaXq9moHetmbxfBwB3118sv87+SkWbD+OvMeMOvKIeib6VRq/
         OzOhl40zjG6j/jBL4S7sCOYAbSF32GkJGJbhs9/W3VJswEo/hhCffLFjooG4MQfyjtXh
         wXPDH1VOu1EAdT85D+oZQ++5Wphm9NBEi7kHRrQzsmkMnxuDbExsbjBMQO24u9VQz5/N
         6qzzZhHpoKkBFVJbXiy5h7eppSJUtPSG4H40+RoeYzApRcZM6HXaF8+b3eOEsbI6Fdpv
         n+jQ==
X-Gm-Message-State: APjAAAVfAA99mpSfmFhpSQfcHpy1OKVKYfgUtLufF/tjXIIMrS3zAwXE
        0UEKmjR6XLMlCr7g4VB3HmjMezAUV9PPsDBfoRGEgQ==
X-Google-Smtp-Source: APXvYqyKYZxOuHmRWr/86q72dEqfXrGdMIKt6xlOQ+jz2d0je9laontvplhfSvRlOSjfNOamsXGSqar4jpq7EnKBtew=
X-Received: by 2002:ae9:f010:: with SMTP id l16mr6984522qkg.240.1553097253066;
 Wed, 20 Mar 2019 08:54:13 -0700 (PDT)
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
 <CAHRSSEyKaV5a6C5fBV8NDm02Cxu2DfVsA7YbbEE8CDkn68KtzA@mail.gmail.com> <CAHC9VhTDNspsA7ht=hkTbQZVmGKJWLoDEF-46kxFKvdMwA4hKw@mail.gmail.com>
In-Reply-To: <CAHC9VhTDNspsA7ht=hkTbQZVmGKJWLoDEF-46kxFKvdMwA4hKw@mail.gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Wed, 20 Mar 2019 08:54:01 -0700
Message-ID: <CAHRSSEwm8F1tKbsG6Tyjbwidg0Nwk-oFHt8hYox9gB0TARNgcg@mail.gmail.com>
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

On Tue, Mar 19, 2019 at 8:04 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Tue, Mar 19, 2019 at 9:08 PM Todd Kjos <tkjos@google.com> wrote:
> > Paul,
> >
> > Looking at a snippet of the test output:
> >
> >     Service Provider read_consumed: 8
> >     Service Provider command: BR_NOOP
> >     Service Provider command: BR_FAILED_REPLY  <-------------- the txn
> > failed as expected.
> >     Manager read_consumed: 8
> >     Manager command: BR_NOOP
> >     Manager command: BR_TRANSACTION_COMPLETE
> >     not ok 3
> >         <--------- but for some reason didn't exit(103)
> >     #   Failed test at ./test line 56.
> >
> > It looks like the test script expects test_binder to fail with
> > exit(103) after processing the Server Provider commands. It's not
> > clear why it didn't, since the return of a BR_FAILED_REPLY for that
> > transaction should have executed this code (line 392 of
> > test_binder.c):
> >
> >     if (cmd == BR_FAILED_REPLY ||
> >         cmd == BR_DEAD_REPLY ||
> >         cmd == BR_DEAD_BINDER) {
> >         fprintf(stderr,
> >                   "Failed response from Service Provider using Managers FD\n");
> >         exit(103);
> >     }
> >
> > Could this be an issue with the test? At least it doesn't look like a
> > transaction is succeeding when it shouldn't.
>
> Hi Todd,
>
> Thanks for looking into this further.  Look a bit more at the test, it
> appears that the code above (line 392) only comes into play if the
> service provider is handling a BR_REPLY, but looking at the test
> output it doesn't appear that this is the case.
>
> # runcon -t test_binder_provider_no_im_t ./test_binder -v -r 2 provider
> Service Provider PID: 2095 Process context:
>        unconfined_u:unconfined_r:test_binder_provider_no_im_t:s0-s0:c0.c1023
> Service Provider sending transaction to Manager - ADD_TEST_SERVICE
> Service Provider read_consumed: 48
> Service Provider command: BR_NOOP
> Service Provider command: BR_INCREFS
> Service Provider command: BR_ACQUIRE
> Service Provider command: BR_TRANSACTION_COMPLETE
>
> Service Provider read_consumed: 8
> Service Provider command: BR_NOOP
> Service Provider command: BR_FAILED_REPLY

So, then it sounds like the test is not running properly and not
really testing what it intends to test (which I guess is consistent
with the fact that it triggered that BUG_ON -- the transaction is
malformed and failing early). It doesn't look like there is a
successful transaction that should have failed due to selinux policy
-- it looks like there is an invalid transaction that probably fails
earlier and doesn't return 103 (it probably returns 8 -- it would be
useful if the test script displayed the exit value that was detected
as a failure).

I don't think there is much I can do on this now given the apparent
flakiness, but I'm happy to help when there is a stable issue. I'll
look a little more at the test code to see if I can spot what is wrong
with the transaction.

Can I add a "Tested-by: Paul Moore <paul@paul-moore.com>" on my patch
submission to fix the BUG_ON (the exact patch you tested) ?

-Todd


>
> However, things get weird.  In the course of writing this email I
> booted into my 5.0.0-1.1.secnext kernel (which passed the binder test
> earlier) and now that kernel is failing in the same way (the test
> hasn't changed).  This test system is a Fedora Rawhide system which is
> updated before I make a test run and I'm wondering if there is some
> other userspace component which may be affecting this ... ?  I've now
> tried this on two different, current Rawhide VMs, hosted on two
> different systems and I'm seeing the same thing, so I don't think it's
> a *bad* system/VM?
>
> > On Tue, Mar 19, 2019 at 5:15 PM Todd Kjos <tkjos@google.com> wrote:
> > >
> > > [...]
> > >
> > > > > Is there a public dashboard where I can take a look at those binder failures?
> > > >
> > > > Not really.  I send test results to a not-yet-publicized mailing list,
> > > > but there is more detail in the GitHub issue below (my last comment
> > > > has the verbose test output):
> > > >
> > > > * https://github.com/SELinuxProject/selinux-kernel/issues/46
> > > >
> > >
> > > Ok, so it looks like something was introduced that causes binder to be
> > > too permissive (test 3 transaction succeeded when failure is
> > > expected). I don't know of any recent binder changes that could have
> > > caused that.
> > >
> > > It will take me a while to set up this test environment. Is this easy
> > > for you to run? Any chance of bisecting or at least trying a few
> > > versions to narrow it down? Here's a list of the recent patchset -- it
> > > would be useful to know which caused it (or if none of them did):
> > >
> > > 9e98c678c2d6a Linux 5.1-rc1
> > > ...
> > > 26528be6720bb binder: fix handling of misaligned binder object
> > > bde4a19fc04f5 binder: use userspace pointer as base of buffer space
> > > c41358a5f5217 binder: remove user_buffer_offset
> > > db6b0b810bf94 binder: avoid kernel vm_area for buffer fixups
> > > 7a67a39320dfb binder: add function to copy binder object from buffer
> > > 8ced0c6231ead binder: add functions to copy to/from binder buffers
> > > 1a7c3d9bb7a92 binder: create userspace-to-binder-buffer copy function
> > > ...
> > > 1c163f4c7b3f6 (tag: v5.0) Linux 5.0
> > >
> > > Thanks,
> > >
> > > -Todd
>
>
>
> --
> paul moore
> www.paul-moore.com
