Return-Path: <SRS0=m7/L=SN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73468C10F13
	for <selinux@archiver.kernel.org>; Thu, 11 Apr 2019 22:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA4A20693
	for <selinux@archiver.kernel.org>; Thu, 11 Apr 2019 22:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="zpGOZwom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfDKWHu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:07:50 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33408 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfDKWHu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Apr 2019 18:07:50 -0400
Received: by mail-lf1-f68.google.com with SMTP id j11so5912563lfm.0
        for <selinux@vger.kernel.org>; Thu, 11 Apr 2019 15:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2QXMZYbUfxUrJw5jZOzMcd3e0b5hEVGXYj+yOA3JAcc=;
        b=zpGOZwomrP8/FKIPT0PCFLtUmrDy3CfVf0bK+q74VN8FXod3FzGIumQcVM+qYvpllL
         uQ7Kc5CljV3zTqJNS1BvBDlam1MABmpzvzOp1Sxv/A+jsZttvEb3wXrrJ+aIbOjlDpdC
         aPoGArTgDZ5709xAQPoZRpCYthTVesc2TxqyhqEQ09PzwAVKV1IFmdBXnnCfEeXOKF1j
         n7hsrUE5ZXYUek5VgkwLCpN14HGBVdB+tIww/9apK3l0nzVm/F8c3Sa2ClTOaVxzku4v
         /ONMXzFVC7XKGo8T/Ny5b6kNLa5he9C7/ry3n4G3bxa94lM/+an/ms97FWPcM+EVDNll
         PlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2QXMZYbUfxUrJw5jZOzMcd3e0b5hEVGXYj+yOA3JAcc=;
        b=l67xEBAe/y0DI3+kP1SsTGhLUWt7Nax5np2JC1GYzkWx+h6o+6SLYtHYgGfmcueYae
         8N+fiN0/Kk7pt3u/3q04NUA0MgVbVIBUBVzrKa7nuAKloxXMgQvgljJlzFGePYyfQkBF
         FCM5qfk6B0UWbY6/TtLChiTqAzgDF4zgL6KDid4k3R8NKn/DR7+PBLeEXX72jr5z8jm/
         4bsC2Iwfe9lY1bEueQt+bao4iwyVqpxg4ngP7nL6olH75FHPW6kY9duq2RMp/bWlLbE4
         kfgFdGE/17CGGvORmiBahWwkxQhl5Tm9hKN5lFTSdevRGu1P5l30rah5GV7+85phWVnk
         L70w==
X-Gm-Message-State: APjAAAUTK6FoYpl0bm1/KIBNT3tp2+W+4cDt/J0hUBxMN46MYF5wR6Eq
        jdHuTCAFgNAYgIsPE3SlEd1KDEqMreonJZbmzPJG
X-Google-Smtp-Source: APXvYqyY/KwwWXxX7IV+xp74CMs/MHkNMJLxSGOCFc/FZY/tkpcGtJctbCt9PBdnalLXUSz8/JRMxAN2GA1NMM8gPAk=
X-Received: by 2002:ac2:592b:: with SMTP id v11mr5619202lfi.85.1555020467165;
 Thu, 11 Apr 2019 15:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190403122611.6543-1-richard_c_haines@btinternet.com>
 <CAHC9VhTTeetqR03+zaV0d_2rdHr4r6eKnqKNrXO6k9O7+tz=gQ@mail.gmail.com>
 <a1869fe6f41148a956ff902d7077356fc729b28b.camel@btinternet.com>
 <CAHC9VhRXgNk0qMS+-=wUt3wYoteauCv3UdPuPrYPyTEV8zXcHw@mail.gmail.com> <2ef270d1e0ce2edbbddc07fba754cb99f2b093d4.camel@btinternet.com>
In-Reply-To: <2ef270d1e0ce2edbbddc07fba754cb99f2b093d4.camel@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 11 Apr 2019 18:07:35 -0400
Message-ID: <CAHC9VhQujkY+Cbkb=ge10JXYyCmftphNOzCCeBaHXLXGMa6_ig@mail.gmail.com>
Subject: Re: [PATCH 1/1] selinux-testsuite: Update binder test applications
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org, tkjos@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 11, 2019 at 7:48 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Wed, 2019-04-10 at 19:43 -0400, Paul Moore wrote:
> > On Wed, Apr 10, 2019 at 1:04 PM Richard Haines
> > <richard_c_haines@btinternet.com> wrote:
> > > On Wed, 2019-04-10 at 11:35 -0400, Paul Moore wrote:
> > > > On Wed, Apr 3, 2019 at 8:43 AM Richard Haines
> > > > <richard_c_haines@btinternet.com> wrote:
> > > > > Replace binder_test.c with separate manager, client and service
> > > > > provider.
> > > > > This works in the same way as a service provider/client
> > > > > interacts
> > > > > with a service manager in the Android world. It passes the
> > > > > service
> > > > > providers binder file descriptor to the client for the
> > > > > impersonate
> > > > > permission check.
> > > > >
> > > > > Also added tests for Dynamically Allocated Binder Devices and
> > > > > passing
> > > > > the sender SELinux security context on binder transactions.
> > > > >
> > > > > Note that the tests require a minimum kernel of 4.16, else some
> > > > > tests may
> > > > > fail. To run successfully the "binder: Add thread->process_todo
> > > > > flag"
> > > > > patch may be required that is available from:
> > > > > https://lore.kernel.org/patchwork/patch/851324/
> > > > > This patch has been backported to some earlier kernels.
> > > > >
> > > > > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > > > > ---
> > > > >  defconfig                       |   3 +
> > > > >  policy/test_binder.te           | 176 ++++----
> > > > >  tests/binder/.gitignore         |   6 +-
> > > > >  tests/binder/Makefile           |  13 +-
> > > > >  tests/binder/binder_common.c    | 155 +++++++
> > > > >  tests/binder/binder_common.h    |  37 ++
> > > > >  tests/binder/check_binder.c     |  27 +-
> > > > >  tests/binder/check_binderfs.c   |  53 +++
> > > > >  tests/binder/client.c           | 450 ++++++++++++++++++++
> > > > >  tests/binder/manager.c          | 362 ++++++++++++++++
> > > > >  tests/binder/service_provider.c | 404 ++++++++++++++++++
> > > > >  tests/binder/test               | 257 ++++++++++--
> > > > >  tests/binder/test_binder.c      | 705 ------------------------
> > > > > ----
> > > > > ----
> > > > >  13 files changed, 1785 insertions(+), 863 deletions(-)
> > > > >  create mode 100644 tests/binder/binder_common.c
> > > > >  create mode 100644 tests/binder/binder_common.h
> > > > >  create mode 100644 tests/binder/check_binderfs.c
> > > > >  create mode 100644 tests/binder/client.c
> > > > >  create mode 100644 tests/binder/manager.c
> > > > >  create mode 100644 tests/binder/service_provider.c
> > > > >  delete mode 100644 tests/binder/test_binder.c
> > > >
> > > > Hi Richard,
> > > >
> > > > Welcome back :)
> > > >
> > > > I had hoped to spend some time reading up on Binder so I could
> > > > give
> > > > this a proper review, but that hasn't happened so I'm inclined to
> > > > merge it, assuming it works on my test system.  However,
> > > > considering
> > > > your comment about this not working on kernel's older than 4.16,
> > > > I
> > > > think we should probably add some checks to only run this test on
> > > > systems with the appropriate kernel support.
> > > >
> > > > If you look at tests/Makefile you will see a number of distro
> > > > specific
> > > > test list modifications, and there is even an example of checking
> > > > the
> > > > kernel version (search for "kvercmp" in the Makefile).  I would
> > > > suggest a simple check to make sure the kernel is at least v4.16,
> > > > and
> > > > if we find distro specific support (e.g. a particular distro
> > > > backported the listed patch) we can always add an exception for
> > > > that
> > > > distro.
> > > >
> > > > How does that sound?
> > >
> > > There are tests for the OS in the 'test' script already. I guess
> > > you
> > > need to check if these are okay, as I check if < 4.16 and if so
> > > print
> > > message saying if fail check for the patch.
> >
> > Ah ha, yes you did, and I missed it.  Sorry about that.  I checked
> > the
> > Makefiles, didn't see any checks, and wrongly assumed they were not
> > there.
> >
> > Looking quickly at the check it seems reasonable, if I notice any
> > problems when testing I'll let you know.
> >
> > > I'm not sure this will get to the list as I appear to be black-
> > > balled.
> > > I did send a cover letter with this patch + another one regarding
> > > running SCTP on < 4.20.17. I sent email to
> > > owner-selinux@vger.kernel.org but not heard anything yet.
> >
> > Hmm, that's not good.  FWIW, the original patch obviously made it,
> > but
> > yes I'm not seeing your response in the list archives.  Did you get
> > any sort of majordomo hate mail back on your posts, or is is just
> > silently dropping your messages?
>
> Just silently dropping messages. I had thought to remove from list then
> add again, however it might smell a rat so left until owner-selinux
> returns. I can only repeat what Julius Caesar muttered "Infamy! Infamy!
> They've all got it in for me!" (well in Carry On Cleo any way).

I got the brexit jump label gag, but you lost me on the "Carry on
Cleo"; thankfully good ol' Google came to the rescue on that one ;)

On the plus side, your posts seem to be coming through to the list now.

On the negative side I realized when playing with your test changes
that I wasn't building BINDERFS in my test kernels - oops.  I'm fixing
that now, but I might not get a chance to do another test until
tomorrow; at least I can verify that your BINDERFS testing logic works
:)

-- 
paul moore
www.paul-moore.com
