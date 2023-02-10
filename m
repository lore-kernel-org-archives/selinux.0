Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DE8C636CD
	for <selinux@archiver.kernel.org>; Fri, 10 Feb 2023 17:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjBJRaT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Feb 2023 12:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbjBJRaS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Feb 2023 12:30:18 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45157359C
        for <selinux@vger.kernel.org>; Fri, 10 Feb 2023 09:30:14 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id nn4-20020a17090b38c400b00233a6f118d0so3520786pjb.2
        for <selinux@vger.kernel.org>; Fri, 10 Feb 2023 09:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1UhPRr+S0mCrPkJT3/E3V39J9W7AiiTni6cg57/i3rs=;
        b=P5NzGE5w0cLWnJJQ70RgFNVOOvV4kJtR52qkpWeN+bDiZC9LhK8ipd1dMLoDmNjSRr
         GK0WbjzlcrAAPg6NlO6SYFr6dc0Tc4ljeZpuHHEOA2KoOIHX9lUAiw+3Xm80CD4wF2NF
         BBI0rCf/EMp6ac/U2QLGfcP2hCCqRDt6zWtfxKkFna6kBuoqCWYGey9Nakk+8XEEbQ7+
         m8wpIkaSyZrK3YaI66UPt2WEuY6bsStu6nAyOuJ0Vxt2yr1VizObhBhhLCUdkRHnPhjW
         yWMng6mDm8ilM4ZzVgYY6GOWeQ+3uVakg8pf3WTwTnGYeA5xKuiAFV3m2aUncG114VDB
         vn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1UhPRr+S0mCrPkJT3/E3V39J9W7AiiTni6cg57/i3rs=;
        b=YpSvsX7K0+NjWltHwt//ajlNjTTk7G5WNuZzNgXk1mD+1/onulDN8PKZbmfLhVa/hE
         Fkcny4gZBluP7n8eQ7DmLrHsCiELH6s0N8rLdMU8iHffLizzuXGtKTShaWBSzHYynswV
         4E+r01ff+1wBObuAprS4rXt4vgBjHeb66WYGZXvgsKN8kEjVP4ecvKFI0t1W2FpNSHf3
         FcGkbHCDJFuPTiQ290q0cAB8ge8rX2MMJoT1+RwmeaexwLyiH8exJuIWSNoOEfSalE6g
         5tbW3fP8u9otiK06UL1mNdCg/OjczgSO9KG8dKMOTJuUeergeHTXSmaAgU3f+29YbOkZ
         eR+g==
X-Gm-Message-State: AO0yUKUoY5FTXwFyYMPuxHkuZkT9Kf1sSP2SysJBjhrkmsqSzwPnbXAw
        CsNn1DJy07UmjY4sN7iqrKmnoq90uMJHvOIJdRa+zJX+ZgbYu9s=
X-Google-Smtp-Source: AK7set9eOzIAQ2pJzzytSPB+Xj7Rz2mDNXgBAGPtWi9VzTnaoxp/kmEdQfbImbQ4VHizHNvaoh5bHTz+Tx5AEYDuPdo=
X-Received: by 2002:a17:90a:2946:b0:230:2889:ec8b with SMTP id
 x6-20020a17090a294600b002302889ec8bmr2495191pjf.121.1676050213823; Fri, 10
 Feb 2023 09:30:13 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhRT0d-XWkw8uLGOmXsaQFpA4MMP6+sL5kfONbf-Mz8UJg@mail.gmail.com>
 <CAFqZXNuv780r04wsLyGvi+CmBFp_v=m1KCNA=ycPRwy5J0YQ9g@mail.gmail.com> <CAHC9VhSpC8Fsj6e1fn=KgbjasTvD=8TDN0XV9YhN0+a4A6t8zA@mail.gmail.com>
In-Reply-To: <CAHC9VhSpC8Fsj6e1fn=KgbjasTvD=8TDN0XV9YhN0+a4A6t8zA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Feb 2023 12:30:02 -0500
Message-ID: <CAHC9VhT8YNfhcP_h1iNaTPyM02C4Eo2U88yLV9-GHHtL0_P8Kg@mail.gmail.com>
Subject: Re: selinux-testsuite failures, CONFIG_LEGACY_TIOCSTI, and recent
 Rawhide builds
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 10, 2023 at 11:57 AM Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Feb 10, 2023 at 3:36 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Thu, Feb 9, 2023 at 11:09 PM Paul Moore <paul@paul-moore.com> wrote:
> > > Hi all,
> > >
> > > I just noticed a selinux-testsuite failure in the tests/file test:
> > >
> > > # Test 8 got: "512" (file/test at line 103)
> > > #   Expected: "0"
> > > #  file/test line 103 is: ok( $result, 0 );
> > > file/test ................... Failed 1/16 subtests
> > >
> > > Digging into this a bit more it looks like the the fnctl(TIOCSTI) call
> > > in test_sigiotask.c is failing due to a recent Rawhide change to
> > > undefine CONFIG_LEGACY_TIOCSTI, disabling TIOCSTI.  Upstream kernel
> > > commit 83efeeeb3d04 ("tty: Allow TIOCSTI to be disabled") has more
> > > information on the Kconfig option.
> > >
> > > I'm not going to argue for reenabling CONFIG_LEGACY_TIOCSTI, I think
> > > turning it off is a good idea, but it does mean we need to adjust the
> > > selinux-testsuite.
> >
> > I noticed that in our CI yesterday and had a brief look. Unfortunately
> > I don't (yet) fully understand the terminal device voodoo being done
> > in test_sigiotask.c and I don't have any idea how to make it work
> > without TIOCSTI. So the best fix for now seems to be to use the
> > dev.tty.legacy_tiocsti sysctl (see the Kconfig). However, it seems to
> > be broken currently:
> >
> > # sysctl dev.tty.legacy_tiocsti
> > # sysctl -w dev.tty.legacy_tiocsti=1
> > sysctl: setting key "/proc/sys/dev/tty/legacy_tiocsti": Invalid argument
> > #
>
> Yep, I got to that point last night and had to leave for the evening
> so I fired off that email figuring you might get a chance to look into
> it before I could.
>
> Ultimately I think we'll probably still need to find some alternative
> to using TIOCSTI, but I'll admit to not having spent much time at all
> looking into how to do that.
>
> > I will look into fixing it...
>
> Thanks for getting to the root cause and posting the fix.
>
> > > Also, as a note to the Fedora folks who will see this, maybe don't
> > > tweak the Kconfig knobs when the kernel is at -rc7?  Seeing kernel
> > > test failures late in the -rc7 stage doesn't do wonders for my sanity
> > > ;)
> >
> > When new configs are added upstream, AFAIK, they are set to the
> > default value in the Fedora configs and marked as "pending". The
> > Fedora kernel maintainer (Justin Forbes) then at some point goes
> > through all pending configs and sets them to a value he deems best.
> > This time it happened around -rc7; I'm not going to speculate why or
> > if it's the usual practice. I recommend raising this on
> > kernel@lists.fedoraproject.org - Justin is always open to suggestions
> > and he might be able to accomodate this expectation.
>
> Thanks, I'll send a note.

FWIW, it looks like the current Rawhide build is back to enabling
CONFIG_LEGACY_TIOCSTI.  My testing is back to running clean with
kernel 6.2.0-0.rc7.20230210git38c1e0c6.54.1.secnext.fc38.

--
paul-moore.com
