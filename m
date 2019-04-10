Return-Path: <SRS0=bkjU=SM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF90C10F14
	for <selinux@archiver.kernel.org>; Wed, 10 Apr 2019 23:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0812082A
	for <selinux@archiver.kernel.org>; Wed, 10 Apr 2019 23:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="pGLdWpCF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfDJXnt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:43:49 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46118 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfDJXni (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Apr 2019 19:43:38 -0400
Received: by mail-lf1-f65.google.com with SMTP id r25so3114199lfn.13
        for <selinux@vger.kernel.org>; Wed, 10 Apr 2019 16:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VznT5BxP9z8PghGGZZBY2VatcuO1qOnWn5myKhGR5c4=;
        b=pGLdWpCFdBjlfjuBLJrtD/+6W7zWookTykueOzNObYGyd0TqjjMKWQTzfrUYgYyD9A
         laX4chtfCjPMI59WnKnsv/BjQ/Nj/3jCOCj5TtLPKINlkOL/ph5+ZsJiEW6I6JDtRm6B
         6kQCtPAayY67204IY2yBEPpRNW1uZBNEdQnpSS5VfMSZPmdgGR/sE0SVaKKsg7XsRAR2
         JlZGweXtqq+XtdfeweuZw75Zyt7tEYb0mw/dV75r7KOhPUruaAZ/JNpzVUiiw3z3MeXf
         NRraNkX9zilAJpKZ3PTH8kRLInQcg/ijKBLdZoXSid8nBxRVy19mGOr/rgF2W38rExET
         YI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VznT5BxP9z8PghGGZZBY2VatcuO1qOnWn5myKhGR5c4=;
        b=ahvBXflTLtDk8cEk82bvHngvLbUu48gx4Z4Kie6LyrbGMZ1CeKbMTqpKr/BKmRHyPp
         yAHFKsF5E9YI+qciXJSEN5L6en6fXphJuZAxQDecGLJkfar0KFKNONfkwseMxhKn1uPi
         GBsW5wy07dyg1i/vrXrO8COMnemtf0rey7njK9Q4Z+EnQawQ9IddPdtUE1Zb/Wi0Ov0D
         uwKgO+88e2FgGYPKYafFjEQqudZG141Ty/fI/wQmBPo0LsWgJlRkTKyoUPNzSNCiez15
         14vItuI+G22PPSDiRKTtUY8gGtDet6wRTcwP32NrB/9qqX4NIa+ubUAzpsVQ8W81f57f
         v+Pw==
X-Gm-Message-State: APjAAAXQa5tXXkrvbGEF2yITeEVZiCTq9ANYFXpMxpKQrxbzdSd74D1s
        UzDjMdcMbf70u2gUIiSCnQ1AQ6dePJmuekSP6iPZ
X-Google-Smtp-Source: APXvYqx7CTwuj9bayCo6F/UXjvwg5LqMHUvtTSyYiuvInQmCFJGzDq801dKP5wL+tw7hkpukRPzbYVFjWUtcM+HcaBQ=
X-Received: by 2002:ac2:592b:: with SMTP id v11mr2419473lfi.85.1554939816046;
 Wed, 10 Apr 2019 16:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190403122611.6543-1-richard_c_haines@btinternet.com>
 <CAHC9VhTTeetqR03+zaV0d_2rdHr4r6eKnqKNrXO6k9O7+tz=gQ@mail.gmail.com> <a1869fe6f41148a956ff902d7077356fc729b28b.camel@btinternet.com>
In-Reply-To: <a1869fe6f41148a956ff902d7077356fc729b28b.camel@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 10 Apr 2019 19:43:24 -0400
Message-ID: <CAHC9VhRXgNk0qMS+-=wUt3wYoteauCv3UdPuPrYPyTEV8zXcHw@mail.gmail.com>
Subject: Re: [PATCH 1/1] selinux-testsuite: Update binder test applications
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org, tkjos@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 10, 2019 at 1:04 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Wed, 2019-04-10 at 11:35 -0400, Paul Moore wrote:
> > On Wed, Apr 3, 2019 at 8:43 AM Richard Haines
> > <richard_c_haines@btinternet.com> wrote:
> > > Replace binder_test.c with separate manager, client and service
> > > provider.
> > > This works in the same way as a service provider/client interacts
> > > with a service manager in the Android world. It passes the service
> > > providers binder file descriptor to the client for the impersonate
> > > permission check.
> > >
> > > Also added tests for Dynamically Allocated Binder Devices and
> > > passing
> > > the sender SELinux security context on binder transactions.
> > >
> > > Note that the tests require a minimum kernel of 4.16, else some
> > > tests may
> > > fail. To run successfully the "binder: Add thread->process_todo
> > > flag"
> > > patch may be required that is available from:
> > > https://lore.kernel.org/patchwork/patch/851324/
> > > This patch has been backported to some earlier kernels.
> > >
> > > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > > ---
> > >  defconfig                       |   3 +
> > >  policy/test_binder.te           | 176 ++++----
> > >  tests/binder/.gitignore         |   6 +-
> > >  tests/binder/Makefile           |  13 +-
> > >  tests/binder/binder_common.c    | 155 +++++++
> > >  tests/binder/binder_common.h    |  37 ++
> > >  tests/binder/check_binder.c     |  27 +-
> > >  tests/binder/check_binderfs.c   |  53 +++
> > >  tests/binder/client.c           | 450 ++++++++++++++++++++
> > >  tests/binder/manager.c          | 362 ++++++++++++++++
> > >  tests/binder/service_provider.c | 404 ++++++++++++++++++
> > >  tests/binder/test               | 257 ++++++++++--
> > >  tests/binder/test_binder.c      | 705 ----------------------------
> > > ----
> > >  13 files changed, 1785 insertions(+), 863 deletions(-)
> > >  create mode 100644 tests/binder/binder_common.c
> > >  create mode 100644 tests/binder/binder_common.h
> > >  create mode 100644 tests/binder/check_binderfs.c
> > >  create mode 100644 tests/binder/client.c
> > >  create mode 100644 tests/binder/manager.c
> > >  create mode 100644 tests/binder/service_provider.c
> > >  delete mode 100644 tests/binder/test_binder.c
> >
> > Hi Richard,
> >
> > Welcome back :)
> >
> > I had hoped to spend some time reading up on Binder so I could give
> > this a proper review, but that hasn't happened so I'm inclined to
> > merge it, assuming it works on my test system.  However, considering
> > your comment about this not working on kernel's older than 4.16, I
> > think we should probably add some checks to only run this test on
> > systems with the appropriate kernel support.
> >
> > If you look at tests/Makefile you will see a number of distro
> > specific
> > test list modifications, and there is even an example of checking the
> > kernel version (search for "kvercmp" in the Makefile).  I would
> > suggest a simple check to make sure the kernel is at least v4.16, and
> > if we find distro specific support (e.g. a particular distro
> > backported the listed patch) we can always add an exception for that
> > distro.
> >
> > How does that sound?
>
> There are tests for the OS in the 'test' script already. I guess you
> need to check if these are okay, as I check if < 4.16 and if so print
> message saying if fail check for the patch.

Ah ha, yes you did, and I missed it.  Sorry about that.  I checked the
Makefiles, didn't see any checks, and wrongly assumed they were not
there.

Looking quickly at the check it seems reasonable, if I notice any
problems when testing I'll let you know.

> I'm not sure this will get to the list as I appear to be black-balled.
> I did send a cover letter with this patch + another one regarding
> running SCTP on < 4.20.17. I sent email to
> owner-selinux@vger.kernel.org but not heard anything yet.

Hmm, that's not good.  FWIW, the original patch obviously made it, but
yes I'm not seeing your response in the list archives.  Did you get
any sort of majordomo hate mail back on your posts, or is is just
silently dropping your messages?

> Cover Letter:
> Subject: [PATCH 0/1] selinux-testsuite: Update binder test applications
>
> The Binder tests have been rewritten to support the new Dynamically
> Allocated Binder Devices and passing the sender SELinux security
> context on binder transactions.
>
> They have been tested on f29 and rawhide with the following kernels
> from kernel.org:
> mainline: 5.1-rc3
> longterm: 4.19.32
> longterm: 4.14.109
>
> As noted in the main patch, the tests require a minimum kernel of 4.16,
> else some tests may fail (tests 4 & 7). To run successfully the
> 4.14.109 kernel was patched with: "binder: Add thread->process_todo
> flag" available from:
> https://lore.kernel.org/patchwork/patch/851324/
>
> I found that on slow systems using 4.14.109, all tests would pass,
> however when testing on a faster system they would fail. Once patched,
> worked fine.
>
> Any testing feedback gratefully received.
>
> Richard

-- 
paul moore
www.paul-moore.com
