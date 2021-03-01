Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27360C433E0
	for <selinux@archiver.kernel.org>; Mon,  1 Mar 2021 14:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED84B6146D
	for <selinux@archiver.kernel.org>; Mon,  1 Mar 2021 14:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbhCAOrm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Mar 2021 09:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236572AbhCAOrb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Mar 2021 09:47:31 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875B3C061788
        for <selinux@vger.kernel.org>; Mon,  1 Mar 2021 06:46:51 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id c6so21110209ede.0
        for <selinux@vger.kernel.org>; Mon, 01 Mar 2021 06:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7q+mlCvX3/pDQmjawa4HxUYY1JkrjzmEirQ4/5j15Ow=;
        b=eYmyUbYvOsfaji1DNZ/wsnitj6tXGIt1A0XlXJ/EkmN4vXQuV7P/MLpaf8TFJgSIjF
         AJdgLPZs23pUS2QglxF2reAnV+IhaunF0e3z+YAp5e1fA3mokKrBcu0NnamJgGPepf6e
         Wcbg8rK38kmNZHcmViT/lS71FYHJ0aph5Ce0/g7OwQGkZeKKUAAy8j8/MrW5sCa+SUlf
         sw08eDaVK/g2UmhwBFRTJ9re5NQCTQcNWBvbIiaED3cs530jP7RQw0Z6KlGj+zhUiIfZ
         /VY9L408ZiE5JOTLK6RxcT929/htE33GiRtx8vSCIg/z7O8MWfVXwbAOd4f3ZVumDb73
         HR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7q+mlCvX3/pDQmjawa4HxUYY1JkrjzmEirQ4/5j15Ow=;
        b=SjgqwbcMVag85pFS76Lc0HvimrAm8U1sLY0zH9yqEVrhmet8qJv7T5dgRmkvGn9grl
         hP27R4+r5+rGH8AaIt8CQeBE0d+3KL5bnqKWMfxPbQpgPDABBO7MhZ7Tk7+IkiR3RgHm
         Nr1lzRZzjsWl2oGS+XW8B334aNAW0fQbetk2yJ+5mwkzM/2P6u4t2Cudbyu6H7v3tTo1
         dFUfKJd1hU7FNqeySDK3cP6kI9vPoeUCzna2tA+/iDORGkX8/GDKZ5OLeRbpUcdDqwHE
         RzDbm2EQQrXLqX5+hQQc+lH6ybmhHSfO8JW0rDLDAHpUcUKKuvWFQZa7CHKV8FeuHa39
         A3+g==
X-Gm-Message-State: AOAM531GAfUjIJDx4essA3kHT7CJJrf9YMgrN9OpULnmfYfsbpiy78wO
        tO17bXTHSKRnGw9o7dtMAmnhpvqRV1N+3rhs08/S
X-Google-Smtp-Source: ABdhPJwIeOeT+ESgy3Q0A+x07kCtv9VqTcbaoIAVBOJ6NjHraW4vD/sXgxuNLPft3AQKHPHswIOQ9XIQyjoTzAz8Z54=
X-Received: by 2002:aa7:db4f:: with SMTP id n15mr9452781edt.12.1614610010144;
 Mon, 01 Mar 2021 06:46:50 -0800 (PST)
MIME-Version: 1.0
References: <20210223214346.GB6000@sequoia> <20210223215054.GC6000@sequoia>
 <20210223223652.GD6000@sequoia> <CAFqZXNvfux46_f8gnvVvRYMKoes24nwm2n3sPbMjrB8vKTW00g@mail.gmail.com>
 <CAHC9VhSaU-3_fs83kEA5bxBf9xMsE29B_O5nXFpROk4=y9kgXw@mail.gmail.com>
 <CAFqZXNu8s5edDbSZuSutetTsy58i08vPuP2h-n9=kT34HcPc4w@mail.gmail.com>
 <CAHC9VhSCs17LEW=QZ2WLeD3-GVzv2RpUJaw7qQNSFWgfEWjkbg@mail.gmail.com> <CAFqZXNufVGD0Sf-K3dKFmJyDOKGPg5jdJ_FPbQz__T8jAHhgYw@mail.gmail.com>
In-Reply-To: <CAFqZXNufVGD0Sf-K3dKFmJyDOKGPg5jdJ_FPbQz__T8jAHhgYw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 1 Mar 2021 09:46:39 -0500
Message-ID: <CAHC9VhQ_oS-uGxhWBOCf3QBLpKD2_0--9nFOqANL1ykfbaA3Jw@mail.gmail.com>
Subject: Re: [BUG] Race between policy reload sidtab conversion and live conversion
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 1, 2021 at 5:36 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Sun, Feb 28, 2021 at 8:21 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Fri, Feb 26, 2021 at 6:12 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > On Fri, Feb 26, 2021 at 2:07 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Wed, Feb 24, 2021 at 4:35 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:

...

> > Ah, yes, you're right.  I was only thinking about the problem of
> > adding an entry to the old sidtab, and not the (much more likely case)
> > of an entry being added to the new sidtab.  Bummer.
> >
> > Thinking aloud for a moment - what if we simply refused to add new
> > sidtab entries if the task's sidtab pointer is "old"?  Common sense
> > would tell us that this scenario should be very rare at present, and I
> > believe the testing mentioned in this thread adds some weight to that
> > claim.  After all, this only affects tasks which entered into their
> > RCU protected session prior to the policy load RCU sync *AND* are
> > attempting to add a new entry to the sidtab.  That *has* to be a
> > really low percentage, especially on a system that has been up and
> > running for some time.  My gut feeling is this should be safe as well;
> > all of the calling code should have the necessary error handling in
> > place as there are plenty of reasons why we could normally fail to add
> > an entry to the sidtab; memory allocation failures being the most
> > obvious failure point I would suspect.  This obvious downside to such
> > an approach is that those operations which do meet this criteria would
> > fail - and we should likely emit an error in this case - but is this
> > failure really worse than any other transient kernel failure,
>
> No, I don't like this approach at all. Before the sidtab refactor, it
> had been done exactly this way ...

I recognize I probably haven't made my feelings about reverts clear,
or if I have, I haven't done so recently.  Let me fix that now: I
*hate* them.  Further I hate reverts with a deep, passionate hatred
that I reserve for very few things.  Maybe we have to revert this
change, even though I *hate* reverts they do remain an option; you
just need to be 99% sure you've exhausted all the other options first.

> Perhaps it wasn't clear from what I wrote, but I certainly don't want
> to abandon it completely. Just to revert to a safe state until we
> figure out how to do the RCU policy reload safely. The solution with
> two-way conversion seems doable, it's just not a quick and easy fix.

I suggest pursuing this before the revert to see what it looks like
and we can discuss it further during review.

-- 
paul moore
www.paul-moore.com
