Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F2AC05027
	for <selinux@archiver.kernel.org>; Fri, 10 Feb 2023 16:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjBJQ5w (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Feb 2023 11:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbjBJQ5t (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Feb 2023 11:57:49 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F17379B19
        for <selinux@vger.kernel.org>; Fri, 10 Feb 2023 08:57:23 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id o13so5787082pjg.2
        for <selinux@vger.kernel.org>; Fri, 10 Feb 2023 08:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1676048242;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvysVoKN4He4coDEn4e6hMDGavyjr4wSj3J/VDZdZkM=;
        b=Wf+4EV4jFIon/kzzVYrzWaVorUnUXenDXnFkcpBYGrsAoJ/5EHUS4Ik0A0KfPkytVk
         IXFsJaQBNo0HIABZoS4uSMz7dFF8e1vUUiZduxdqsYzvQxmuhj3DnkCxxu7jSzko6ekl
         7ETngVVOL1Aon2ZHMTYo2dG/Gqkp/ejFmyLdJ3Wu1XkmYeeGMwQA6jrtuiaPJ9PxS/UX
         FDj39H1gBFbhTuPsSDKc1FEvL2xCufUc1g+McLf8EUZ5dQgI9FaIkA+GulN4m1z+Kvxu
         6hggTA0OcjEDJknmYZZXVcpuSbL9k+8ZACXaDqGvxp+I1GxG9gpibCobJFO1//jkACue
         TCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676048242;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZvysVoKN4He4coDEn4e6hMDGavyjr4wSj3J/VDZdZkM=;
        b=uneVtAU9l7A4urARDP1lRLCoQjem3YXPsYkcf9kDbv2WVeCJ0nXYYn3uqQxt5msEUT
         do4tJGg2ww/Q9KiQdzxM6hMjmeAvW5e5qBfq3cJs2SDT8ePybKNI10AgefZVQToOa+y2
         3UQ3w12X7a03DFs/3taMXUjlKrTCPYwqGaarTKEMHpbOl8ROpWjfiBltKJyRPk9NPwez
         bRKn0jF5FiAZvEuzRDXxhohzggOUi9w16jYN3IMyUwF7p23xdF3MYh5opwiEWMDPzVKm
         yFPRnDziRdq+GGrZ11xuwe4Fx9llIYgsQ8M1Lp0RGwPyXXGy+0Ml535Gmd6HYSnjnREo
         FjQg==
X-Gm-Message-State: AO0yUKUOOpGK/920dLyOYjUW0QZzPxo3hEkgY7qEEE61T/zPp5hoCr30
        wS+uFv4YpK6jUIkTn1tQUMGmPY79Zhbspoh8Tsf1TY/yAZ1pEG4=
X-Google-Smtp-Source: AK7set/+B/TC11Q2bvI7v9UpMumztFKL3WBqL9DlnYZoJXvN6Ensz3O9cbg4+ZdN4YtqNZGkeZk3Rn3N8HyLKftlHjg=
X-Received: by 2002:a17:902:8f8a:b0:196:8a80:4da8 with SMTP id
 z10-20020a1709028f8a00b001968a804da8mr3889785plo.20.1676048241784; Fri, 10
 Feb 2023 08:57:21 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhRT0d-XWkw8uLGOmXsaQFpA4MMP6+sL5kfONbf-Mz8UJg@mail.gmail.com>
 <CAFqZXNuv780r04wsLyGvi+CmBFp_v=m1KCNA=ycPRwy5J0YQ9g@mail.gmail.com>
In-Reply-To: <CAFqZXNuv780r04wsLyGvi+CmBFp_v=m1KCNA=ycPRwy5J0YQ9g@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Feb 2023 11:57:10 -0500
Message-ID: <CAHC9VhSpC8Fsj6e1fn=KgbjasTvD=8TDN0XV9YhN0+a4A6t8zA@mail.gmail.com>
Subject: Re: selinux-testsuite failures, CONFIG_LEGACY_TIOCSTI, and recent
 Rawhide builds
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 10, 2023 at 3:36 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Thu, Feb 9, 2023 at 11:09 PM Paul Moore <paul@paul-moore.com> wrote:
> > Hi all,
> >
> > I just noticed a selinux-testsuite failure in the tests/file test:
> >
> > # Test 8 got: "512" (file/test at line 103)
> > #   Expected: "0"
> > #  file/test line 103 is: ok( $result, 0 );
> > file/test ................... Failed 1/16 subtests
> >
> > Digging into this a bit more it looks like the the fnctl(TIOCSTI) call
> > in test_sigiotask.c is failing due to a recent Rawhide change to
> > undefine CONFIG_LEGACY_TIOCSTI, disabling TIOCSTI.  Upstream kernel
> > commit 83efeeeb3d04 ("tty: Allow TIOCSTI to be disabled") has more
> > information on the Kconfig option.
> >
> > I'm not going to argue for reenabling CONFIG_LEGACY_TIOCSTI, I think
> > turning it off is a good idea, but it does mean we need to adjust the
> > selinux-testsuite.
>
> I noticed that in our CI yesterday and had a brief look. Unfortunately
> I don't (yet) fully understand the terminal device voodoo being done
> in test_sigiotask.c and I don't have any idea how to make it work
> without TIOCSTI. So the best fix for now seems to be to use the
> dev.tty.legacy_tiocsti sysctl (see the Kconfig). However, it seems to
> be broken currently:
>
> # sysctl dev.tty.legacy_tiocsti
> # sysctl -w dev.tty.legacy_tiocsti=1
> sysctl: setting key "/proc/sys/dev/tty/legacy_tiocsti": Invalid argument
> #

Yep, I got to that point last night and had to leave for the evening
so I fired off that email figuring you might get a chance to look into
it before I could.

Ultimately I think we'll probably still need to find some alternative
to using TIOCSTI, but I'll admit to not having spent much time at all
looking into how to do that.

> I will look into fixing it...

Thanks for getting to the root cause and posting the fix.

> > Also, as a note to the Fedora folks who will see this, maybe don't
> > tweak the Kconfig knobs when the kernel is at -rc7?  Seeing kernel
> > test failures late in the -rc7 stage doesn't do wonders for my sanity
> > ;)
>
> When new configs are added upstream, AFAIK, they are set to the
> default value in the Fedora configs and marked as "pending". The
> Fedora kernel maintainer (Justin Forbes) then at some point goes
> through all pending configs and sets them to a value he deems best.
> This time it happened around -rc7; I'm not going to speculate why or
> if it's the usual practice. I recommend raising this on
> kernel@lists.fedoraproject.org - Justin is always open to suggestions
> and he might be able to accomodate this expectation.

Thanks, I'll send a note.

-- 
paul-moore.com
