Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BDCC433E0
	for <selinux@archiver.kernel.org>; Fri, 22 Jan 2021 22:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31B3C23A5C
	for <selinux@archiver.kernel.org>; Fri, 22 Jan 2021 22:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbhAVWWW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Jan 2021 17:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728403AbhAVWV7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Jan 2021 17:21:59 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D7DC061786
        for <selinux@vger.kernel.org>; Fri, 22 Jan 2021 14:21:12 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id gx5so9836878ejb.7
        for <selinux@vger.kernel.org>; Fri, 22 Jan 2021 14:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RH+Eo2ct5V9B8+8733/q5dHaXfoHH1pdajDIgXyh2tU=;
        b=ImzvoqZ6X9+Bda/c0Kw6eDUcINIz3Hync/FOAUCOf3m7x8Y6BA85/ZSlJT9Gfj6nTm
         YY7jHZguPERewYszRO6C22x2DQCM86fUIbKBnXUYSCCC4/LCoYhcM5KY2qA/4Q21zJMS
         hlTQJUxF2MhfBMpj5TEOTfsSwZ8sEV0ugEe8mHU3UXmx3UY2DN+Y9JcvF2ubpzO+JWSx
         xui6v4ZFIV/h8wZL78xcEppvgl/hDw3LqACLSRL/1GSD8lHApIeFy9IdshucY+bL29X3
         ap7c9WXys+MPoAVFcFXtnXmygrhlPt/g6w94tNwRiAJQKJlus8goWkuvTdypymYSqB7Z
         Xwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RH+Eo2ct5V9B8+8733/q5dHaXfoHH1pdajDIgXyh2tU=;
        b=ppkEBhskIUC0jTetN9WL+Lcg7dS3IK9a+mYO7lYOzzCf8M5PEtgfz4f9ZXLu6cJhLK
         5oJNyWrOaPpHqzbkOu4jLhKTB7SAOjtH4+RuPsZjzVTV/JlMnCKs8kICUZSPGMdCGulG
         HoiuW+sf8EXTNbkkHRyKXyHR7tpOwTMr/kSqe4STWnDhqvu+3nAlzzYkYnUnxR5s+Vy7
         66I6Bf1z6fyOlYA5HlECQEWndqaiQUvt4OE6ctsqwujwf9TzjaG/vpmsktyT628yFnEu
         2myi+cQdlWwOxHFJsUObrFfvXW1zEI45tPwkDqq2IxyfmOS9Hl08UpVUczzYgxSgoLXc
         R7TQ==
X-Gm-Message-State: AOAM531VJvx/SVQvLGqshLE+5WsJG755ToFezJNHT6vRKpMS0FjsaQm/
        Ojtc4wP5w5Pgj6rkJWErJXHdNt+zm0u42pJUxd35CHlMbw==
X-Google-Smtp-Source: ABdhPJwuoTmxkmxFRvKGJZPTc9+FZSKtPb0dI4Bx6UOSxsoTRkLpupP/p4d6q2bbpUujtrZMe9P6TqbCuCopPgX3kNw=
X-Received: by 2002:a17:906:95cf:: with SMTP id n15mr340975ejy.178.1611354070637;
 Fri, 22 Jan 2021 14:21:10 -0800 (PST)
MIME-Version: 1.0
References: <20210119105747.9680-1-richard_c_haines@btinternet.com>
 <20210119105747.9680-2-richard_c_haines@btinternet.com> <ypjleeihm5e0.fsf@defensec.nl>
 <8776cbb2687a09ed5b4e5b3cf0c50ade6c018fa6.camel@btinternet.com>
In-Reply-To: <8776cbb2687a09ed5b4e5b3cf0c50ade6c018fa6.camel@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 22 Jan 2021 17:20:59 -0500
Message-ID: <CAHC9VhRXyA-g929Z+eam-gmYpzD=LeJV2W548_3GkHRyrZY0vw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] selinux-notebook: Add new section for Embedded Systems
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 20, 2021 at 7:37 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Tue, 2021-01-19 at 14:18 +0100, Dominick Grift wrote:
> > Richard Haines <richard_c_haines@btinternet.com> writes:
> >
> > > Add a new section and supporting examples for embedded systems.
> >
> > Nice initiative, thanks. Looks pretty solid for a first iteration.
> >
> > I wrote a document for OpenWrt here [1]. Basically the instructions
> > needed
> > to assemble OpenWrt from modules applicable to a particular system,
> > but also how
> > to build on top of it, or now to just fork it so that you can use it
> > as
> > a base for your own policy.
> >
> > [1]
> > https://github.com/doverride/openwrt-selinux-policy/blob/master/README.md
> >
> > I am currently pretty happy with the results so far (its a work in
> > progress, and there are known loose ends)
> >
> > One of the differences compared with android is that SELinux is not
> > tightly integrated in OpenWrt, and so most of the tough aspects are
> > addressed in policy
> > rather than adding selinux-awareness all over. SELinux in OpenWrt is
> > therefore
> > fairly self-contained and considering the challenges fairly robust.
> >
>
> Thanks, I've worked these comments into the next version.

I just wanted to check and make sure this next version hasn't been
posted to the list yet?  Sometimes the list eats things and I wanted
to make sure that wasn't the case here.

-- 
paul moore
www.paul-moore.com
