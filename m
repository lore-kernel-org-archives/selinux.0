Return-Path: <SRS0=TNfp=Z4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87DDC2BD09
	for <selinux@archiver.kernel.org>; Fri,  6 Dec 2019 15:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6A924673
	for <selinux@archiver.kernel.org>; Fri,  6 Dec 2019 15:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="UbThqBv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfLFPIr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 6 Dec 2019 10:08:47 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41252 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfLFPIr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 6 Dec 2019 10:08:47 -0500
Received: by mail-lf1-f68.google.com with SMTP id m30so5501153lfp.8
        for <selinux@vger.kernel.org>; Fri, 06 Dec 2019 07:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tDpR9HC0N0LylNs7IQ0staMtQmWQ/+07ieameKSy+BU=;
        b=UbThqBv0yZmZtyIEKsxCOzqk7hboUOD/OYaUUtZ3TA/d5v0YeDh3ObW9TWy2J0uJos
         zrekA6/1LYgXyqtu+C5Fv3zWeYG57g6cTcp66wbJ4GsiKm7ZBdSHcmgoWZatSL4uonAG
         02bcTHUPPEQeMS3XmP8Hh+obGu252d5CE2AR8uwyulCtGpXPGnGg+nU0SUCC6YyBQpx7
         YtNAcKYHjSl+7MPC9IQI5Gv0y8IU50EPQkmOrBOps/zxI27N6knSsUyVWrmS5iKJb8t7
         QFs8wBTi5ErjXn9SNdYLNav1K7PPir6xNVr99KlNPn/W9bSG/ohjiGT/ZbTaIl34f58t
         Gsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tDpR9HC0N0LylNs7IQ0staMtQmWQ/+07ieameKSy+BU=;
        b=ddw6DZt5TApxMpP1TsikeIt5KgPNhhCY4zohuOr2i5/U4yinVIWw6LL7ZniPM3gyWi
         srwYoDvusYU9weG4uJuEai6su5LYgF0XSdqH+Q0Wd3iz5SZwtYGdN1cHm0Wdk8iBBE3+
         JCjcUZkgiZJ40HqxkyYSSzzyLNL6eFZ3t4YN2NaEJxrXggHAaeFeck6s4MxoTFoA8Lh/
         OalhVoHIfkDVv4dYR/erToh+aQy96Py3rtOmVA8gGBzIEWc+DujbTfnTnYp6NNeTywWx
         dnPXdKAYZwozFhf4dlDsgAEwLHIOyAH61KITyoEgqS2HupmN8h6OE7HMS69s2CVIrJFT
         Wxjg==
X-Gm-Message-State: APjAAAWLQsOcfuoVkV5AdDG0hWfIWP9MUCQBUb9MF0L6tBHjwmY7iTWT
        GHCgT7+aPZXcuhTDllhIF/UeG2aQFMdk6F9VkP6i
X-Google-Smtp-Source: APXvYqyHuAf1U6B3Ez7ghdYr9OxWS0HPk1oGXvEPsi/mt9SJ+Vm2vIv8UKN1swaZR7yrZn9ikiGxfgVudfm3pwgUv7A=
X-Received: by 2002:a19:f514:: with SMTP id j20mr7762466lfb.31.1575644924413;
 Fri, 06 Dec 2019 07:08:44 -0800 (PST)
MIME-Version: 1.0
References: <20191122093306.17335-1-jeffv@google.com> <CAHC9VhQ-piMePyfOeLsrAtgSCG5iWjk9xFbjOvURe3WLD-z89g@mail.gmail.com>
 <CAFqZXNun_-aWx19UKUMfiYuQuttxCgMOoAczBAddDv3yaCZyxw@mail.gmail.com>
 <CAHC9VhTwct8daQoXFg4JpHkWUhijQFn8D0Tq=VX989mq3TVfvg@mail.gmail.com>
 <CAFqZXNvQV+syzOE0CGczzTvi9g65AUT8bdsG0YN6NcHzd5GVHQ@mail.gmail.com>
 <CAHC9VhSVsmu6hjmUAi2wM6wAkkQnUDx7MM1G8Ln9OLAzwFmz6A@mail.gmail.com>
 <CAHC9VhR+hYnLoMkAPuRNJygk+dOoNyhooNuz3Ma=F07b9gh=rA@mail.gmail.com>
 <8257410c-025a-7250-fa78-944289e378bd@tycho.nsa.gov> <CAHC9VhREL17FH0XOUkvegY4yGeQu5p1qLdWEdnwvPw1W+bLfRA@mail.gmail.com>
 <CAHC9VhQOb5skqQofnrESFuAqfRE1+xq9OD48JcYzq77v0XJsog@mail.gmail.com> <4257992a-e4d8-eff4-3421-61da3376d930@tycho.nsa.gov>
In-Reply-To: <4257992a-e4d8-eff4-3421-61da3376d930@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 6 Dec 2019 10:08:33 -0500
Message-ID: <CAHC9VhQF_FzbtwF+9Q_u4EiEnNQHc2KkaoPYOCkGnB3F4Xd2JQ@mail.gmail.com>
Subject: Re: [PATCH v9] selinux: sidtab: reverse lookup hash table
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Jovana Knezevic <jovanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 6, 2019 at 8:45 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/5/19 7:50 PM, Paul Moore wrote:
> > On Thu, Dec 5, 2019 at 1:14 PM Paul Moore <paul@paul-moore.com> wrote:
> >> On Thu, Dec 5, 2019 at 1:10 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >>> On 12/5/19 12:41 PM, Paul Moore wrote:
> >>>> Hmm.  I haven't done any debugging yet, but the BPF tests are failing
> >>>> (they pass with kernel-5.5.0-0.rc0.git5.1.2.secnext.fc32.x86_64):
> >
> > ...
> >
> >>> They all pass for me (with your next-queue branch, using the
> >>> selinux-testsuite defconfig fragment merged with the Fedora config).
> >>
> >> Oh goodie, I'm special :/
> >>
> >> FWIW, my current test kernel is the next-queue branch rebased on top
> >> of Linus' current tree, using the latest config from the secnext
> >> kernel builds (Fedora Rawhide + stuff for the test suite).
> >>
> >>> The error above doesn't look SELinux-related; it looks like your kernel
> >>> is rejecting the trivial bpf program used in the test code as being
> >>> invalid for some reason.
> >>
> >> That's where I'm at as well, I'm building an instrumented kernel right
> >> now to try and track down the source.  I'm sure it is something silly
> >> like a messed up kernel config or something, but I'd like to
> >> understand *why*.
> >
> > I traced the "./bpf_test -p" failure down to a BTF check in the BPF
> > verifier, there is a comment in that code block which helpfully reads:
> > "Either gcc or pahole or kernel are broken.".
> >
> >   :/
> >
> > The relevant commit is 8580ac9404f6 ("bpf: Process in-kernel BTF"),
> > and it appears to be new for v5.5; it isn't present in selinux/next or
> > selinux/next-queue.  Recompiling with CONFIG_DEBUG_INFO_BTF disabled
> > does allow "./bpf_test -p" to succeed, but I hit other BPF test
> > failures further along.  For reasons I don't understand, the secnext
> > kernel builds (which should have this code, and have
> > CONFIG_DEBUG_INFO_BTF enabled) are not hitting this problem, but that
> > may be due to differences in the build tools on the two systems
> > (although they *should* be the same).
> >
> > Given that we haven't hit -rc1 yet, and everyone else's builds are
> > working just fine, I'm going to leave this alone for now.  Whatever
> > the problems may be, they definitely don't appear to be SELinux
> > related.
>
> I re-based next-queue on top of -linus, enabled CONFIG_DEBUG_INFO_BTF,
> rebuilt and booted new kernel, did a git clean -fdx in the
> selinux-testsuite directory, and built/ran the testsuite; bpf tests
> still passed for me.  This was on F31.

Thanks.  If I had another day to spend on this I'm reasonably
confident it would end up being the result of some oddity/difference
in the Rawhide toolchains, or ghosts.  Either way, this seems to be
both unrelated to the SELinux changes and not something anyone else is
seeing despite a number of different scenarios.  I still need to go
through the two patches and cleanup some of the whitespace issues we
talked about earlier, but barring anything weird happening (see the
previous ghost comment) I'll merge both of these patches into
selinux/next when the merge window closes this weekend.

-- 
paul moore
www.paul-moore.com
