Return-Path: <SRS0=K0yT=Z3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE657C2D0C0
	for <selinux@archiver.kernel.org>; Thu,  5 Dec 2019 14:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27832464E
	for <selinux@archiver.kernel.org>; Thu,  5 Dec 2019 14:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="SGFY9Id7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbfLEOIy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Dec 2019 09:08:54 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37434 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729512AbfLEOIy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Dec 2019 09:08:54 -0500
Received: by mail-lf1-f65.google.com with SMTP id b15so2605449lfc.4
        for <selinux@vger.kernel.org>; Thu, 05 Dec 2019 06:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gmDcfySFu4cZhpLYljWttxXox5YE9OQcKuIq/LT/coc=;
        b=SGFY9Id7W6F+dnLbSC8iZmVwK44Feg5fPR3ZsA+QTXEEJf89ntnrSlRXx8AS+Z3TTD
         aAhVyosxwNRJc9CV6jKspldBKWJLgNqvorGB4Rgn0nBDLPMQo06Cm+Gd/gKrTVkHPSYT
         KYv3Ch8BCTlfqdI+h5ZRJxxcfl73B/AoEkbE0wkdCOTBX5KIEhX80uYosEW3isj+3GIk
         MUf6LQgeEuaeT6hXfR3JtfT1dpOD4k7kvOeLsDdgmuH3KoGLx439+rkCVRrrarsEoO5m
         81TvLqZZ96VnNq//6rWkSBw5Z/NNi4IDWkWJuvUuoP9+jGt0YYYxsor58v4As3bWRv/3
         1JNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gmDcfySFu4cZhpLYljWttxXox5YE9OQcKuIq/LT/coc=;
        b=L1xmMXPRQsa1xuh//4oOryeKNygpylwYgMG6VK+K0kvuQxTpHqH85u7bJykPAv+m20
         qcOuVWzTz6hCSuFK4z9uPzuR/Rz/q+6HD3Grl3qfReZLZXmwV+WYQj4dyQrFgqIkj1pe
         YZ1y56TO5fIw78RHUXOppT7EshX7t3Ee++37AUAw63Gg8c1XxuPrgjQ048kI+qpJBb9S
         AKf56D0FucE/ggbw7fnD6HSnpe0kifG/zAFNAD9SKQYSb7irNRo+jiMwXAX2594/rS4k
         yi9MpntUtc1X0GnnMaT6t8eJMpWCRVu3r/M2Uj+AmVRgKR5+9rk/goIC98ZK2bzMnsil
         a1nQ==
X-Gm-Message-State: APjAAAUb5puv414N9QwbLiWYqTUyp0MXbKjbJlmGZNRsinySkYjYw/AR
        kDNFamuKqUsHbm3KlZSRzACgroWuYX5o/FsyVbqUfv8=
X-Google-Smtp-Source: APXvYqxsmozelM1jQBbA3G59cIGm7jWU81K1xtvs8Sq8Y1dS9Yu6I1fHTZA8+YigfeK+zF7Hg//cW84+j6rBp+tzbtk=
X-Received: by 2002:ac2:428d:: with SMTP id m13mr5535498lfh.64.1575554930642;
 Thu, 05 Dec 2019 06:08:50 -0800 (PST)
MIME-Version: 1.0
References: <20191122093306.17335-1-jeffv@google.com> <CAHC9VhQ-piMePyfOeLsrAtgSCG5iWjk9xFbjOvURe3WLD-z89g@mail.gmail.com>
 <CAFqZXNun_-aWx19UKUMfiYuQuttxCgMOoAczBAddDv3yaCZyxw@mail.gmail.com>
 <CAHC9VhTwct8daQoXFg4JpHkWUhijQFn8D0Tq=VX989mq3TVfvg@mail.gmail.com> <CAFqZXNvQV+syzOE0CGczzTvi9g65AUT8bdsG0YN6NcHzd5GVHQ@mail.gmail.com>
In-Reply-To: <CAFqZXNvQV+syzOE0CGczzTvi9g65AUT8bdsG0YN6NcHzd5GVHQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 5 Dec 2019 09:08:38 -0500
Message-ID: <CAHC9VhSVsmu6hjmUAi2wM6wAkkQnUDx7MM1G8Ln9OLAzwFmz6A@mail.gmail.com>
Subject: Re: [PATCH v9] selinux: sidtab: reverse lookup hash table
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Jeff Vander Stoep <jeffv@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Jovana Knezevic <jovanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 5, 2019 at 6:47 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Thu, Dec 5, 2019 at 12:52 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Dec 4, 2019 at 4:11 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > On Tue, Dec 3, 2019 at 1:33 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > Thanks Jeff, as well as everyone else who contributed reviews and feedback.
> > > >
> > > > I've pulled this into a working branch and I'll be merging it with the
> > > > other sidtab patches before posting it to a "next-queue" branch for
> > > > review later this week.  When done, I'll send a note to the list, as
> > > > well as the relevant patch authors; your help in reviewing the merge
> > > > would be greatly appreciated.
> > >
> > > I tried doing the merge on my own here [1], you can use it as a sanity
> > > check if we came to the same/similar result. I based it off your
> > > existing next-queue, which contains only Jeff's patch at the time of
> > > writing. I only build-tested it so far.
> >
> > Thanks, that was a good sanity check.  There are some minor diffs from
> > what I ended up with, but nothing substantive that I can see.
> >
> > Although I'll be honest, the merge wasn't as bad as I thought it would
> > be; most of the fuzz was simply due shuffling and renaming of data
> > structures, which generally isn't too bad.  Although I'm still
> > building the kernel to test it, so let's see if that statement still
> > holds (although it looks like it passed Stephen's testing). ;)
> >
> > If you haven't noticed already, the merge currently lives in the
> > selinux/next-queue branch; if you notice anything off, feel free to
> > send a fixup patch.
>
> It looks OK semantically when compared to my merge. I only see
> reordering/comment/whitespace differences.

Thanks for the double check.  Unfortunately my kernel build locks my
test VM in early boot; it appears to be non-SELinux related and since
the test build is based on selinux/next+patches (which is based off
v5.4-rc1) I imagine there might be some unrelated problems in the
build.  I'm going to rebase my test build to Linus' current and try
this again.

> > > Note that there are two whitespace cleanups included in the string
> > > cache commit that I intuitively did while resolving the merge
> > > conflicts. You might want to move those to the first commit or just
> > > ignore them.
> >
> > When looking at the combined diff between the two sidtab patches and
> > comparing it to your merge I did make a few additional small cosmetic
> > tweaks.  Assuming the testing goes well, I'll probably go over
> > everything one more time to make sure the style looks okay, but today
> > I was focusing more on the correctness.
>
> The whitespace misalignment introduced by Jeff's patch is still there
> in your branch. Personally, I'd prefer that we fix them now rather
> than deferring it to a future patch, because it seems that no one ever
> has time to bother sending whitespace fixup patches :) But I'll
> understand it if you prefer not to touch it more than necessary, so I
> won't fight about this further.

Like I said, I only quickly scanned the combined diff for style
problems so it doesn't surprise me that there are still some issues.
I'll give it a closer look once I can get a kernel build passing all
the tests.

As an aside, I keep debating doing a big style-fix patch (likely
automated via astyle or similar, likely with some additional fixes by
hand, and passed through checkpatch.pl) after one of the -rc1 rebases
to clean up all these little things that have crept into the code over
the years.  I dislike the idea of the churn that would likely bring,
but it should make life a little bit better, and help cut down on the
trivial "checkpatch patches" we get from time to time (although that
really hasn't been too bad of an issue).

-- 
paul moore
www.paul-moore.com
