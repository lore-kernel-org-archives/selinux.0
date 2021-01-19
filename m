Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAD0C18E17
	for <selinux@archiver.kernel.org>; Tue, 19 Jan 2021 18:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A95422C9E
	for <selinux@archiver.kernel.org>; Tue, 19 Jan 2021 18:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731595AbhASQhX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Jan 2021 11:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731473AbhASQhQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Jan 2021 11:37:16 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3191AC061573
        for <selinux@vger.kernel.org>; Tue, 19 Jan 2021 08:36:36 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a10so12766326ejg.10
        for <selinux@vger.kernel.org>; Tue, 19 Jan 2021 08:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hgazaJ2bwFq8Of6mjsHVpAwchw/GBKCCWu2J4PLix9M=;
        b=HB/2VQDPCo0Ieghgfu1wfDyNrtTWZC1uqAbjdCjPpJLlKluEgRddIjhIRQd0cVGkr4
         /JcuA7u2ovGbY66ssVpvnCZ+pHinxP1Vvyfj2Mav6Xczkbv64TEH3kRevuCJfmoZyvyU
         hPKL/m2WttRbS0ES1aJckiT96JjLvXOxJdDiu/eTFq2vYcRRZ1YbKbwxDMAQiR93dVVc
         bLQA6CrvQcoqCRGZuLhSloqgXesTEdgCgxinXaeMWjHQJSwkqXWYrA7uH1dPSa4Fa0Nj
         Y/LEeM5//mignMQQPv2RWr6Zj9uTA8hpY4/d41MTSVj2fMHcNYU3xVGCdSGQQvRPe+dq
         xpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hgazaJ2bwFq8Of6mjsHVpAwchw/GBKCCWu2J4PLix9M=;
        b=l6ALqDiA7FwOspyq9XUfv7085lbB6Y96E7mhvIHuxSo1kl9qOe1FnhdL0KsusvYfYf
         rybRAmtzCfDPyp5iBS93YrQ46tiL1jyv8t3YQKuiv+FCNhgnglTKSF93ArF1vVUScKNK
         LsiO7/Dm3AY1oxMsV8rntlUdJtpyA0WtSVqozCmQr82rJ4ln/7WO5lTzM3W1ua2BUsFd
         yBUgJR8UEGqr33KHd2NStpYOtIRUwnVI4byGGDjDJAGDYXkLjEVBdJu+LKTSA9HYHret
         2Inhj3qF7Q6QJqBLzMpHIVWvm0iTxcw+m13i8LeEtDffiwUnpgEEpeeTp90Z/Hf3CSyc
         4zLA==
X-Gm-Message-State: AOAM531EvJWqm3cVYnso8YwCc/6AUfQ6vjQLH2Re6sAn6fZfwaFoZdNy
        0PfzSIMbLjQn+AL1fj9BEELNb5LLgSHz9lkjBkVt
X-Google-Smtp-Source: ABdhPJwzZleEzqE07rmNw8+Qt5EjtwT1nsvWwg7G8Z+1nFr61LD48AuFccoPQDaJ54k7m2lCa/33cJcTTL7A9ywGfgY=
X-Received: by 2002:a17:907:c01:: with SMTP id ga1mr3413505ejc.488.1611074194393;
 Tue, 19 Jan 2021 08:36:34 -0800 (PST)
MIME-Version: 1.0
References: <20210119090651.321390-1-omosnace@redhat.com> <CAHC9VhQtOGREKfh2hSJGnzDzEzNdusWJTb31TkyMnM+5MM2dqg@mail.gmail.com>
 <CAFqZXNtwkrtvcG_OAHOEXh2yczxMvHZ47EX_oAWzwTRA7Zowiw@mail.gmail.com>
In-Reply-To: <CAFqZXNtwkrtvcG_OAHOEXh2yczxMvHZ47EX_oAWzwTRA7Zowiw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 Jan 2021 11:36:23 -0500
Message-ID: <CAHC9VhT5Z0HjbTa7Gci73cLOvQST7is91F8PE5voXy3eUQTEow@mail.gmail.com>
Subject: Re: [PATCH testsuite] Makefile: unload policy when testsuite fails
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 19, 2021 at 11:25 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Tue, Jan 19, 2021 at 5:10 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Jan 19, 2021 at 8:24 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > Make sure that the test policy is properly unloaded when `make test`
> > > fails, to prevent it from accidentally lingering on the system after a
> > > failed test.
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  Makefile | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index 9081406..8efe15c 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -5,7 +5,11 @@ all:
> > >
> > >  test:
> > >         make -C policy load
> > > -       make -C tests test
> > > +       make -C tests test || { \
> > > +               res=$$?; \
> > > +               make -C policy unload; \
> > > +               exit $$res; \
> > > +       }
> > >         make -C policy unload
> >
> > Why not just do '-make -C tests test' instead?
>
> Then the exit code would be 0 regardless of whether the tests passed or failed.

Good point ;)

-- 
paul moore
www.paul-moore.com
