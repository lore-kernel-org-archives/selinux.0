Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D0FC433EF
	for <selinux@archiver.kernel.org>; Tue,  9 Nov 2021 18:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A57FC61179
	for <selinux@archiver.kernel.org>; Tue,  9 Nov 2021 18:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242526AbhKISmA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Nov 2021 13:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238608AbhKISl7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Nov 2021 13:41:59 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFC0C061764
        for <selinux@vger.kernel.org>; Tue,  9 Nov 2021 10:39:13 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id q124so373188oig.3
        for <selinux@vger.kernel.org>; Tue, 09 Nov 2021 10:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bnH0Qn0PEzWmJEuW1j4uM2rsWT8XMDwIdaLjysL5dtQ=;
        b=Y+58C9cYpl1UfjvWp9+3xVHE10sKAMWTafQXeB4hFufwGkSNn+JLSpvbBxnC2XbV7Z
         vPH0SR/EJX0Yup7ofz2Hll2H7qQqIWY7R8PsA7SpxdpLlQNgCWDIOheN5w5QORXuAXrA
         6o+hmian53HBWJK30ujNVpzN+mQhOnUF+8Q7GN93KXP3Y6yj0XuJJyfDppW/JA9HJa3b
         4Z41x+Mon6xqMW12fQc0NgcskXpeAi/87YayLjsip2/w8tZviahy9Np/Uv/sWJ+6GiFR
         86tSzIt/MpvEnIZuy4EwXyB02LhFDsSgUMLu4WnQthHFUfMfd9x2t7auVhgf9JH9ozPl
         L7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bnH0Qn0PEzWmJEuW1j4uM2rsWT8XMDwIdaLjysL5dtQ=;
        b=gDp3GTqK8b7HlMPzlyTiE+D8uez7lhnEkT8hBgxJOOOCpEDhXOncx1qN3UHwpxWdz+
         W+yfSidMlqysjqKftgtCrqJkzLaq24NdB1KOZPyrjNN0y6jLn5NxlFsDuWavF/eIehK0
         tfZIarSogDYjHe1UwmGTdgvhNKY6eUHK4DQzCR5w/7qOEPXedGaJ1aXFG6ZdFdiEmt4L
         7GWMAaEL/hjbmqlOtfA8wa2M2sDgYIcM2cNZqbFyv8YTZxkvkWRodN0zLX/DNpaUH2Sk
         OUNoSVLC9YxImhdAcyvIlrLCtX11J2O0FyG0pWVkT8c30X/11Hegdb8COzRaM79uTDVX
         +LMg==
X-Gm-Message-State: AOAM533lM1KHBvsdCyJ9URVQzxEAbdgAn8Skq2dYGeuosZRaUehLqP3E
        c9Hxggg2hFjsFmrk0P81w7QVQDwy0gDm4wO14h8=
X-Google-Smtp-Source: ABdhPJxz32xMMvJWaG+N/pyDmbbrL9z7lQHgTmZdg41q+sXh3dW5kJa+XL6qJJeR3Jrrqn7tKwwDdLomHo8rWrObSZQ=
X-Received: by 2002:aca:3152:: with SMTP id x79mr7771960oix.128.1636483152900;
 Tue, 09 Nov 2021 10:39:12 -0800 (PST)
MIME-Version: 1.0
References: <7d775f7f-1377-edde-8474-ba2126256852@linux.microsoft.com>
 <CAP+JOzQ8V2r8Dzh7xoWYwq3nhwW7KciMoB5EoTiuvjEwJHGQwQ@mail.gmail.com>
 <3e770d7e-945e-1a41-fe9e-c220d3550ca9@linux.microsoft.com>
 <CA+EEuAhzFYQhLMXKgAOy_bzhdJV3a0Rqp9YSSot16+e32Vhv6Q@mail.gmail.com> <33962ce0-24a6-7041-ea4c-8b63fe44a4ea@linux.microsoft.com>
In-Reply-To: <33962ce0-24a6-7041-ea4c-8b63fe44a4ea@linux.microsoft.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 9 Nov 2021 13:39:01 -0500
Message-ID: <CAP+JOzScXOxXnUStypqCEUxnVroW+SGVzoFb7BcAj2C_Nu87GQ@mail.gmail.com>
Subject: Re: [RFC] Cascade: a high level SELinux policy language
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     Karl MacMillan <karl@bigbadwolfsecurity.com>,
        SElinux list <selinux@vger.kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        Chris PeBenito <pebenito@ieee.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 9, 2021 at 1:16 PM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
>
> On 11/9/2021 11:03 AM, Karl MacMillan wrote:
> > Daniel,

> >
> >
> >     In terms of optional blocks, Chris and I have argued about optional a
> >     few times, and part of the reason there's nothing about optional so far
> >     is because we'd like to solicit community feedback there.  My personal
> >     view is that explicitly marking statements as optional is tedious and
> >     error prone.  But I don't have a really slam dunk "clearly better"
> >     solution to propose yet at this point.  I have a few ideas, but they
> >     all
> >     need to be more thoroughly thought out and there are some holes and
> >     issues to address.  I viewed this feature as non-essential for an
> >     initial proof of concept, and am glad that we can have design
> >     discussions about it in the open.
> >
> >     So in short, yes, I think the ability to differentiate that certain
> >     rules are required for a module to work and others are optional is
> >     definitely needed.  But I'm not yet set on what the best way to do that
> >     is.  One key goal here is that a developer of a component should be
> >     able
> >     to add policy with fairly minimal knowledge of SELinux.  I'd prefer it
> >     if most of the time they could do the right thing without knowing about
> >     optional, but I'm not yet sure what the best/cleanest way to achieve
> >     that will be.
> >
> >
> > Optional blocks have, in practice, been a huge source of errors I
> > believe.
>  > [snip]
>
> I agree pretty much 100% with everything you've said here about the
> usage and historical limitations of optional.  Thanks for the added
> historical context from before my time.
>

I am not a fan of optionals either. Disabling optionals has been a
source of many bugs in CIL, but it would have been hard to make
translating binary modules to CIL work without them.

> On the topic of packaging, I'll admit that I'm sparse on details without
> an actual implementation at this point, so the packaging aspect of
> Cascade is currently vaporware, but my hope is that an integrated
> packaging and build system framework, inspired by rust's cargo can solve
> a lot of the packaging problems much more cleanly (by inserting optional
> blocks for install order problems during compilation rather than in
> source for example).
>
> I like the suggestion of a question mark operator for optional policy
> quite a bit.  Although I'm really interested in exploring whether it's
> possible to just treat the entirety of it as a policy level dependency
> resolution problem.  Basically annotate with modules a particular module
> depends on vs which are optional - the distinction being that the
> optional marking is done at the module level rather than the
> rule/interface call level.  That might be less heavy-weight and error
> prone to use while still providing the needed flexibility.
>

99% of the time optionals are used as a way of including rules when a
module is present without causing an error when it is not, so this
should provide everything that is needed.

Since you have a lot of freedom, I would recommend a system like that
rather than optionals.

Jim


> > Anyway - forgive me crashing in with all of my opinions. I hope my
> > background on the problems of optionals might at least be helpful.
>
> Opinions are what I'm seeking. :)  And yes, I think all of your thoughts
> here are quite helpful.  I think the attributes concern is a good one
> that we aimed to address, and can continue to refine as needed, and the
> optional thoughts are extremely helpful, since as I mentioned in my
> prior e-mail, the overall support for differentiating which policy is
> required and which is optional is a must-have in my view, but how
> exactly to specify it in a way that is clear is somewhat challenging and
> subjective.  Added info on historical context and use cases is a
> valuable input to that discussion.
>
> -Daniel
