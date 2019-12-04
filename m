Return-Path: <SRS0=lyW+=Z2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18A3C2D0BE
	for <selinux@archiver.kernel.org>; Wed,  4 Dec 2019 23:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40342077B
	for <selinux@archiver.kernel.org>; Wed,  4 Dec 2019 23:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="UyR9JWeB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfLDXwf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Dec 2019 18:52:35 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33419 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbfLDXwf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Dec 2019 18:52:35 -0500
Received: by mail-lj1-f195.google.com with SMTP id 21so1375697ljr.0
        for <selinux@vger.kernel.org>; Wed, 04 Dec 2019 15:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BgY37x/+7Cql9NNZG79hPhxCQjhuFiHviwcms4LCaiM=;
        b=UyR9JWeB9nrCzdLV2qA4dvotgBdtU8xShtqsd77nv/IRUQLcA7GyHe+DlMZmP0BWfS
         soHdg6DlaDpqiq3n4hNv5bo39scYknTSYYjpOgJB+23tKJGgxODHrrQrxavcDa0qinhy
         ne6IViJAWrUByRqpbZbHZjNaGDOB45pNjKDoBhqrDp97nK2bSAaBK+AmfM0Bx8PP+a6t
         MUZuqT+GsVCls9CgX7zLFRXh6mdcyyiuK95A6K0EHUXXgI5siHN6g9/W6b7PPShH3m+S
         hyBHVgtvi0z6/vGEjq9A04cTjoqb0lpvhFn3pRoSpM0w+a8Ko62l39IcL/Q8naGiVjDa
         UGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BgY37x/+7Cql9NNZG79hPhxCQjhuFiHviwcms4LCaiM=;
        b=DpQB0ucz7KWtLzN1OBhUPrm32tq0qFntr35+Z+zyHQfs1Lh8TTrpEswvBld8k0gQyQ
         9SFb1VvyWiL41xh5IzmupSnb9NPK0n8tUJi4V7edfP9duS4T58PkzxwpOE2pyGdtEBO9
         qf1Gff22p+sTauKN82cnVTh6FCG1+5PSrtvwhSrcWzJL7hsTZCPNHuD+tMsA6n8TQrC+
         nsfXa15nv/P/C4AVJFSdA/ifgjLlMNnonE1q+/I3M3XD9w9h38lrniFg1jGcJViSaJhw
         /9CSxC/7CRJMydeqU5OufyvoSFuVh4AbHy4YXwg9cssazOv985mWbkFLFj2tQe1hViPn
         ue1g==
X-Gm-Message-State: APjAAAVzMHTaLkzWYhLkGa3TOorxPl1iQxzZ3uLHdm4RnokeobyKTVnJ
        JN06lSqN+jPCYVWf1eYsN/cKMt73Tp7fzd/K3uxaVaM=
X-Google-Smtp-Source: APXvYqwWgpKbHYRC+2VdIQJLVcuDlKqBe+8g7wH4TyCAyQQ/homvy4q0HI54Q3UL8Bh+GTmuJpRjD8QIR446kh5G35U=
X-Received: by 2002:a2e:9d9a:: with SMTP id c26mr3670252ljj.225.1575503552423;
 Wed, 04 Dec 2019 15:52:32 -0800 (PST)
MIME-Version: 1.0
References: <20191122093306.17335-1-jeffv@google.com> <CAHC9VhQ-piMePyfOeLsrAtgSCG5iWjk9xFbjOvURe3WLD-z89g@mail.gmail.com>
 <CAFqZXNun_-aWx19UKUMfiYuQuttxCgMOoAczBAddDv3yaCZyxw@mail.gmail.com>
In-Reply-To: <CAFqZXNun_-aWx19UKUMfiYuQuttxCgMOoAczBAddDv3yaCZyxw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 4 Dec 2019 18:52:21 -0500
Message-ID: <CAHC9VhTwct8daQoXFg4JpHkWUhijQFn8D0Tq=VX989mq3TVfvg@mail.gmail.com>
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

On Wed, Dec 4, 2019 at 4:11 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Tue, Dec 3, 2019 at 1:33 AM Paul Moore <paul@paul-moore.com> wrote:
> > Thanks Jeff, as well as everyone else who contributed reviews and feedback.
> >
> > I've pulled this into a working branch and I'll be merging it with the
> > other sidtab patches before posting it to a "next-queue" branch for
> > review later this week.  When done, I'll send a note to the list, as
> > well as the relevant patch authors; your help in reviewing the merge
> > would be greatly appreciated.
>
> I tried doing the merge on my own here [1], you can use it as a sanity
> check if we came to the same/similar result. I based it off your
> existing next-queue, which contains only Jeff's patch at the time of
> writing. I only build-tested it so far.

Thanks, that was a good sanity check.  There are some minor diffs from
what I ended up with, but nothing substantive that I can see.

Although I'll be honest, the merge wasn't as bad as I thought it would
be; most of the fuzz was simply due shuffling and renaming of data
structures, which generally isn't too bad.  Although I'm still
building the kernel to test it, so let's see if that statement still
holds (although it looks like it passed Stephen's testing). ;)

If you haven't noticed already, the merge currently lives in the
selinux/next-queue branch; if you notice anything off, feel free to
send a fixup patch.

> Note that there are two whitespace cleanups included in the string
> cache commit that I intuitively did while resolving the merge
> conflicts. You might want to move those to the first commit or just
> ignore them.

When looking at the combined diff between the two sidtab patches and
comparing it to your merge I did make a few additional small cosmetic
tweaks.  Assuming the testing goes well, I'll probably go over
everything one more time to make sure the style looks okay, but today
I was focusing more on the correctness.

> [1] https://gitlab.com/omos/linux-public/compare/selinux-next...rebase-selinux-sidtab-string-cache

-- 
paul moore
www.paul-moore.com
