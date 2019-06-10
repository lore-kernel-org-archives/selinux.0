Return-Path: <SRS0=W683=UJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54CDC43218
	for <selinux@archiver.kernel.org>; Mon, 10 Jun 2019 20:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9543A20820
	for <selinux@archiver.kernel.org>; Mon, 10 Jun 2019 20:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="saZqork8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfFJUUm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 Jun 2019 16:20:42 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43228 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728317AbfFJUUm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 Jun 2019 16:20:42 -0400
Received: by mail-lf1-f67.google.com with SMTP id j29so7562415lfk.10
        for <selinux@vger.kernel.org>; Mon, 10 Jun 2019 13:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9M6F3AKPv7OG6y2K7bhRRjnT8UdjtXCgz4Y9EEYL+yE=;
        b=saZqork8B9+QM+f2nCfCrj8rlM59XPvq319ftaCyyiSzVlXueddIYsFl1oFOnoNHFM
         n0AF32FIdOPtpWRwUDR0aAqA5HtgbdAmdTn91dQADsTaS168kCRS3nSIu6NssjwXamcx
         o32tTM08DZGbBdZHIWl7VPJj+hvXJjegP1tRpW9ZjXONIohOHmzbE16SV2BqeldVXGk5
         lTV7I6BCBpdqSxixsI4A2KZZVEySXl+5ULVAnFyY2xKZhBYNYIJgoYJTh7lBxgcetWqd
         rQPDEQXjgYy/yB7xj8+VVCTVFcsDRyyhhRl/Tv61GQGEJBOlxYBPJjU3FlWP1wgTFE/T
         JQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9M6F3AKPv7OG6y2K7bhRRjnT8UdjtXCgz4Y9EEYL+yE=;
        b=uMuxoaXK/fl7L4jly4aMhzhyVJgRra8i91Y5/prd8V3R00y4IjPlm2sObbtJIDaZy/
         sCS0A4KRF4C++b1mmqiPP6i3+uQfJgsAHUIxhbzSU8acHGqbjxffpFpDwvpfx8kCkHsh
         vafhjqxhsAWbzDA9e+TbTph74FGWQKQ6QvxveUpT2WcqG2i46yjplLWdVhKBkcE3oCqe
         OnVQuB0S0sUh7zLAEqFwoRwywWujFNtExJcgYouBTwnwYN0c5IOgKqocguWMYweTpow9
         TacorxIeD4Ob0MG+zp/oZOiUAw0voOyfRSu/M9jA5yvQFPhhX4BUWTcGmsPZfSlUzKYd
         +5Gw==
X-Gm-Message-State: APjAAAU5V5rQnzg9G7QMfxiOnm07gPrhacKL3s9hmQLQvMd7Rm5xmJFh
        msz8BNe0d++67MGXO+UZ+DbjDZ2d94UtgKE3gfWv
X-Google-Smtp-Source: APXvYqwwPuL2qotjbCVzlbt1SrW9wOBZt+K0jOXzvsil8EjXgCBDxYdewKxbzFBLnmMhZHg9PaXFTk/Q4SP8A69hMpA=
X-Received: by 2002:ac2:410a:: with SMTP id b10mr18751609lfi.175.1560198039673;
 Mon, 10 Jun 2019 13:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190606085524.GA21119@zhanggen-UX430UQ> <CAFqZXNvM94T2reUsn6Mwuz6GNGNCR=wUNBE8w4tcjNuhJ6rCeQ@mail.gmail.com>
In-Reply-To: <CAFqZXNvM94T2reUsn6Mwuz6GNGNCR=wUNBE8w4tcjNuhJ6rCeQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 Jun 2019 16:20:28 -0400
Message-ID: <CAHC9VhT+e2Z+4=5P0g4B4F1g0w2SkQjwUnhQkmu5V+HvuZi8Cg@mail.gmail.com>
Subject: Re: [PATCH v4] selinux: lsm: fix a missing-check bug in
 selinux_sb_eat_lsm_o pts()
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Gen Zhang <blackgod016574@gmail.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 7, 2019 at 4:41 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Thu, Jun 6, 2019 at 10:55 AM Gen Zhang <blackgod016574@gmail.com> wrote:
> > In selinux_sb_eat_lsm_opts(), 'arg' is allocated by kmemdup_nul(). It
> > returns NULL when fails. So 'arg' should be checked. And 'mnt_opts'
> > should be freed when error.
> >
> > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > Fixes: 99dbbb593fe6 ("selinux: rewrite selinux_sb_eat_lsm_opts()")
>
> My comments about the subject and an empty line before label apply
> here as well, but Paul can fix both easily when applying ...

Since we've been discussing general best practices for submitting
patches in this thread (and the other related thread), I wanted to
(re)clarify my thoughts around maintainers fixing patches when merging
them upstream.

When in doubt, do not ever rely on the upstream maintainer fixing your
patch while merging it, and if problems do arise during review, it is
best to not ask the maintainer to fix them for you, but for you to fix
them instead (you are the patch author after all!).  Similarly, making
comments along the lines of "X can fix both easily when applying", is
also a bad thing to say when reviewing patches.  It's the patch
author's responsibility to fix the patch by address review comments,
not the maintainer.  I'll typically let you know if you don't need to
rework a patch(set).

That said, there are times when the maintainer will change the patch
during merging, most of which are due to resolving merge
conflicts/fuzz with changes already in the tree (that *is* the
maintainer's responsibility).  Speaking for myself, sometimes I will
also make some minor changes if the patch author is away, or
unreliable, or if there is a hard deadline near and I'm worried that
the updated patch might not be ready in time.  I'll also sometimes
make the changes directly if the patch is holding up a larger, more
important patch(set), but that is really rare.  I'm sure I've made
changes for other reasons in the past, and I'm sure I'll make changes
for other reasons in the future, but hopefully this will give you a
better idea of how the process works :)

-- 
paul moore
www.paul-moore.com
