Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25216C64EC7
	for <selinux@archiver.kernel.org>; Tue, 14 Feb 2023 21:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbjBNV76 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Feb 2023 16:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjBNV74 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Feb 2023 16:59:56 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C986683F2
        for <selinux@vger.kernel.org>; Tue, 14 Feb 2023 13:59:54 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id s20so11262986pfe.2
        for <selinux@vger.kernel.org>; Tue, 14 Feb 2023 13:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0q4aQX1yKf+7yz3UNvdDM4P25hDwV1GvoXUzXe+ItEw=;
        b=CGAIBaaAxZpqJZLbPtUqSDTUhhbbPHblJ5AjW5f7AyIIhSpmrEX9amm19CCFA3oNF3
         y6MAnkqMQKX8R77GIHKFVNoEH98+FeSaqBwzb5GvFCX4AY114aUWHWHW+60/gI8WfLwc
         h6aID3Zey3Sv748KjSkYx10NF01CojpDC05BYgqyeCwWDccYfCwhbtJRiF6dG4Iu5gnF
         PFne1V+8aYqsEzUGXpoMiV346J6fqvvqgxVp66gR+IpKWCMsqZ1gYh7hD7bsnEurTAVI
         JidXRTETClXcXmbOC4YnoXCCBGM+y8g7faOHzHdYPBurynPXp5aN/ftEEiGe09CkDD19
         1fQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0q4aQX1yKf+7yz3UNvdDM4P25hDwV1GvoXUzXe+ItEw=;
        b=mhMeqnbawE2U7kMYkr1+wBuTTfHeAjQTBZ2XRQekuGeQKhyLu0bkIfW8ixUZDALVJA
         N+5hF4tWd/jmRkW9yyFUtemLph3gODm/usx7VRTETPKf+t+RR2QA43qiMYVl1gdEODDm
         MbF8S790f7lwjq4p0KKH2aFEUYZZAV9hepWH8guCv/EoNLqjdkbzXItUCNusl+6GWpEu
         yBUr2gS1XtEHcCh85kstVBJ7IhDqmALvHGL3fxYPUtLR4E0/osR1tnCVgja+aDVoNue6
         2hctkitdBxqLJwFXKYxbaXIjs6M9BCDkeIV9G4ZZYLsEIzxpihpce38iGmw6bDlMgNWs
         LkmA==
X-Gm-Message-State: AO0yUKWoEX2O81dT3SmMcwFaQyzxFgdRIngvogkkRW2zzN5iJLdEEE7Q
        4SGH1BusC8fwFOkNywyuCPKetCoCfrS8hyGxeeNbv6LJ8i7M
X-Google-Smtp-Source: AK7set9WOGsxKP0xm9ZOKkMAcrZZ9fJiSHkfJq5gZysYfXnEHszGHRCmTAA1yfu59SUNVD5GcCVZJz2UNLa/ZcPZtJ4=
X-Received: by 2002:a63:bf41:0:b0:4fb:ba53:1c60 with SMTP id
 i1-20020a63bf41000000b004fbba531c60mr548880pgo.125.1676411994030; Tue, 14 Feb
 2023 13:59:54 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhRT0d-XWkw8uLGOmXsaQFpA4MMP6+sL5kfONbf-Mz8UJg@mail.gmail.com>
 <CAFqZXNuv780r04wsLyGvi+CmBFp_v=m1KCNA=ycPRwy5J0YQ9g@mail.gmail.com>
 <CAHC9VhSpC8Fsj6e1fn=KgbjasTvD=8TDN0XV9YhN0+a4A6t8zA@mail.gmail.com> <CAHC9VhT8YNfhcP_h1iNaTPyM02C4Eo2U88yLV9-GHHtL0_P8Kg@mail.gmail.com>
In-Reply-To: <CAHC9VhT8YNfhcP_h1iNaTPyM02C4Eo2U88yLV9-GHHtL0_P8Kg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 14 Feb 2023 16:59:42 -0500
Message-ID: <CAHC9VhQwrjwdW27+ktcT_9q-N7AmuUK8GYgoYbPXGVAcjwA4nQ@mail.gmail.com>
Subject: Re: selinux-testsuite failures, CONFIG_LEGACY_TIOCSTI, and recent
 Rawhide builds
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 10, 2023 at 12:30 PM Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Feb 10, 2023 at 11:57 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Fri, Feb 10, 2023 at 3:36 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > On Thu, Feb 9, 2023 at 11:09 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > Hi all,
> > > >
> > > > I just noticed a selinux-testsuite failure in the tests/file test:
> > > >
> > > > # Test 8 got: "512" (file/test at line 103)
> > > > #   Expected: "0"
> > > > #  file/test line 103 is: ok( $result, 0 );
> > > > file/test ................... Failed 1/16 subtests
> > > >
> > > > Digging into this a bit more it looks like the the fnctl(TIOCSTI) call
> > > > in test_sigiotask.c is failing due to a recent Rawhide change to
> > > > undefine CONFIG_LEGACY_TIOCSTI, disabling TIOCSTI.  Upstream kernel
> > > > commit 83efeeeb3d04 ("tty: Allow TIOCSTI to be disabled") has more
> > > > information on the Kconfig option.
> > > >
> > > > I'm not going to argue for reenabling CONFIG_LEGACY_TIOCSTI, I think
> > > > turning it off is a good idea, but it does mean we need to adjust the
> > > > selinux-testsuite.
> > >
> > > I noticed that in our CI yesterday and had a brief look. Unfortunately
> > > I don't (yet) fully understand the terminal device voodoo being done
> > > in test_sigiotask.c and I don't have any idea how to make it work
> > > without TIOCSTI. So the best fix for now seems to be to use the
> > > dev.tty.legacy_tiocsti sysctl (see the Kconfig). However, it seems to
> > > be broken currently:
> > >
> > > # sysctl dev.tty.legacy_tiocsti
> > > # sysctl -w dev.tty.legacy_tiocsti=1
> > > sysctl: setting key "/proc/sys/dev/tty/legacy_tiocsti": Invalid argument
> > > #
> >
> > Yep, I got to that point last night and had to leave for the evening
> > so I fired off that email figuring you might get a chance to look into
> > it before I could.
> >
> > Ultimately I think we'll probably still need to find some alternative
> > to using TIOCSTI, but I'll admit to not having spent much time at all
> > looking into how to do that.
> >
> > > I will look into fixing it...
> >
> > Thanks for getting to the root cause and posting the fix.
> >
> > > > Also, as a note to the Fedora folks who will see this, maybe don't
> > > > tweak the Kconfig knobs when the kernel is at -rc7?  Seeing kernel
> > > > test failures late in the -rc7 stage doesn't do wonders for my sanity
> > > > ;)
> > >
> > > When new configs are added upstream, AFAIK, they are set to the
> > > default value in the Fedora configs and marked as "pending". The
> > > Fedora kernel maintainer (Justin Forbes) then at some point goes
> > > through all pending configs and sets them to a value he deems best.
> > > This time it happened around -rc7; I'm not going to speculate why or
> > > if it's the usual practice. I recommend raising this on
> > > kernel@lists.fedoraproject.org - Justin is always open to suggestions
> > > and he might be able to accomodate this expectation.
> >
> > Thanks, I'll send a note.
>
> FWIW, it looks like the current Rawhide build is back to enabling
> CONFIG_LEGACY_TIOCSTI.  My testing is back to running clean with
> kernel 6.2.0-0.rc7.20230210git38c1e0c6.54.1.secnext.fc38.

That proved to be short lived.

Ondrej, would it be possible to disable the failing test until your
patch lands upstream and ends up in Rawhide?

-- 
paul-moore.com
