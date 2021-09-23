Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF16C433EF
	for <selinux@archiver.kernel.org>; Thu, 23 Sep 2021 17:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 737B861090
	for <selinux@archiver.kernel.org>; Thu, 23 Sep 2021 17:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242596AbhIWRbC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Sep 2021 13:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242595AbhIWRbB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Sep 2021 13:31:01 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107D0C061574
        for <selinux@vger.kernel.org>; Thu, 23 Sep 2021 10:29:30 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id c33so3160414ljr.8
        for <selinux@vger.kernel.org>; Thu, 23 Sep 2021 10:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VQuTJey0iMtFxxij1vWY7f+IsNf90JqLBU1/x3EQ76g=;
        b=dd7OfGhC56pTTDuQth+ikUEBmfb6QqKkOcSH2YKjdZCzAmJ4R0z070ECo7ON9fy2dh
         hmHfzta9/fcjr7K0XwOLjpmNW/HWCXRI0ipXrA2Zf/JToqKC6R3uVeNvFoZlGMismyE8
         0S2o3rpDlSx4lFlbDpKhSwrIDEsQ2vNz2j6ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQuTJey0iMtFxxij1vWY7f+IsNf90JqLBU1/x3EQ76g=;
        b=YW/jbLVoANOvot5X6dGDwgfG2rAh5DJgcGuDu99JHkh1RIcDJTq4r2APOqFbCKQnE1
         LZZQzQEc2JxBd2o3YoXyP932sR9mMbV9FJrVFQcip7kLkuxiw+9REd0qrTWMlTysJjbX
         4KyoD/nTpZUUcJ7lqvuKoW36Kjoch+OowIwZKkJSS1zaj+NCc20iOyXv2KffcEee/U8b
         4essr2ONg63ywHTZDiVQxNMD7qEn44sCI6C+zM3suGdra8iYCrKiUbe4/P3AKI7Ivcr9
         PRPlEqD4kqMrvHX1YkNa/O1Q553OrVUNKBRZWm9MzoXNo451EmWvohq6Nw8i/FuAWZAP
         731Q==
X-Gm-Message-State: AOAM533a8WAvTHovhQ70wa/r+tKA0kRsdNwpZFmQJwTpoYoNY9h1q5n4
        YjLXu18INe2JvvRf/hRxGo8KIbHQsZ9/Z6sGZ7I=
X-Google-Smtp-Source: ABdhPJwqBeW3aH587I2Pb4uhKSlAScudmfON5ER7gZ0bnDIvMGZ6DyUmo1rB8uz4tJ9q1Jabj2mGEg==
X-Received: by 2002:a2e:6f1d:: with SMTP id k29mr4152234ljc.209.1632418167321;
        Thu, 23 Sep 2021 10:29:27 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id e17sm655956ljk.133.2021.09.23.10.29.25
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 10:29:25 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id o21so687844ljp.7
        for <selinux@vger.kernel.org>; Thu, 23 Sep 2021 10:29:25 -0700 (PDT)
X-Received: by 2002:a2e:5815:: with SMTP id m21mr6222470ljb.95.1632418165461;
 Thu, 23 Sep 2021 10:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhQcxm=Zhe2XEesx3UsBgr8H6H=BtJc92roqeF8o+DK+XQ@mail.gmail.com>
 <CAHC9VhSu=ZWymS3RHa7jakQOU8gujGQ=PKO1BTcrNAM9-P4bmQ@mail.gmail.com>
 <CAHk-=wj=ADdpVjsKGuOyKDT2eO2UwfgW+cGsKAkxvTkP7=1Osg@mail.gmail.com>
 <CAHk-=winh0gLMqnQipt7VpbsxBL1frJQ-hJpRpe=kbR3U+DRHg@mail.gmail.com>
 <CAHC9VhSZp1-Qi7ApoQHauaFXDgoNaFTwFEieEFFuBtdPqAtXQg@mail.gmail.com>
 <CAHk-=whoExoB6xGD0as0kpfwr38B=W7GRkO2NXWDRW-tmQS6Qw@mail.gmail.com>
 <CAHC9VhTtz_aNY6MOCM6ypbz+SHvS30hx42PWjXJhG1Z=t5jpBw@mail.gmail.com>
 <CAHk-=wivxthY49NPyPG0QG302dmH_hrioE7NdDKMR1Fus0GHow@mail.gmail.com> <CAHC9VhSgG9wRJk9pyUnz90Th8MLfJ9LAMsFKyFMZMjK097+ZXw@mail.gmail.com>
In-Reply-To: <CAHC9VhSgG9wRJk9pyUnz90Th8MLfJ9LAMsFKyFMZMjK097+ZXw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Sep 2021 10:29:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj09_XNBKQZ-735yum5h1xT9i2AgC793HjChBnwoWJ+jQ@mail.gmail.com>
Message-ID: <CAHk-=wj09_XNBKQZ-735yum5h1xT9i2AgC793HjChBnwoWJ+jQ@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux fixes for v5.15 (#1)
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 23, 2021 at 10:13 AM Paul Moore <paul@paul-moore.com> wrote:
>
> It's become clear you *really* don't like passing the cred pointer
> here, presumably based on a very specific security model for lockdown.

Not just that. I'm sensitive about the cred pointer because of the
timing, but I'm also sensitive about just looking at code and saying
"that makes no sense".

Having callers do pointless things that make no sense to the callers
is a bad thing. Having a patch where 59 out of 63 callers just
mindlessly pass in "current_cred()", and then remaining three callers
pass in NULL for NO DISCERNIBLE REASON is a sign of just a bad
interface.

And I realize that to you, these interfaces are what you do.

To everybody else, it's completely mindless noise that makes no sense
at all, because there's no _logic_ to it. It's random LSM calls in
random contexts that have no clear reason for them, because the
"reason" is hidden in some odd SELinux rule that no kernel developer
even knows about.

You can't even grep for the use of it, because there is none. It's
literally randomness. Which means that it _has_ to make conceptual
sense to be at all maintainable.

So when I see a diffstat where basically 90% of the patch has
ABSOLUTELY NOTHING to do with SElinux or anything you maintain, and
that 90% makes absolutely no sense to begin with, guess what? I think
that patch is bad.

When I then look closer, and see that the _reason_ for the patch is
that SElinux - yet again - incorrectly accessed process credentials in
random contexts, I just do "this is not just a bad patch, this is
actually a fundamental problem with SELinux".

See where I'm coming from? The "specific security model for lockdown"
is just the high-level view of what made sense. You violated that view
for bad reasons, with a bad patch, and with bad timing.

This isn't _just_ a SElinux problem. I think it's a LSM problem in
general. Lots of those random callbacks are completely
incomprehensible, have odd rules, and the LSM people aren't even
trying to have them make sense.

As long as the oddity is contained, that's one thing. But when it is
made this obvious and affects random code in strange places in the
kernel, and it's for a feature that had a lot of discussion even when
it got merged, I'm putting my foot down.

             Linus
