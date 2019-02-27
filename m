Return-Path: <SRS0=n8ca=RC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D2DC43381
	for <selinux@archiver.kernel.org>; Wed, 27 Feb 2019 17:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5270520C01
	for <selinux@archiver.kernel.org>; Wed, 27 Feb 2019 17:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="jAnCG1uA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfB0RgE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:36:04 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35429 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfB0RgD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Feb 2019 12:36:03 -0500
Received: by mail-lf1-f65.google.com with SMTP id m73so7554286lfa.2
        for <selinux@vger.kernel.org>; Wed, 27 Feb 2019 09:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FXhFvSUaOGKRux93w926Uz6bO3eUcw3ePXw5u6qiuVs=;
        b=jAnCG1uAewa6rABzUgw1pZzm1594hi4Z0w7TsIlXKS4J3fTC7sgSYP2B+PbWdgWiKV
         f7is70So84NEimuGzxNMGeMAJEzb4pBQiBE03WSZK7hW+4hVQMbKhWrY347glIpVQxx0
         ZPVY63Oi7ZTrciImpfDDogr8XCyOZEWBwOi/o4Foy4MwfCVir9Dah8zkITwEL0jfUwpf
         NpYUzK/I4RR93d9y5CfL4rQ41UaFA+1A6Zgrh+HOPFpcKpYeZcnd+EQh3KpQqLDE/qIQ
         sAZHgEKgKq+YFqbEBTIG4X7oTW7xmEbgI1tSEWQk+eK8JagMg9Xz75d2Nv/n0tkL9NHZ
         mHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXhFvSUaOGKRux93w926Uz6bO3eUcw3ePXw5u6qiuVs=;
        b=OOhbM1SRZSWvL0kqgRQIb2tQ6mDw/2Px//Az6SW8k4u4ZJjxoxTiqtSOY9OsVjvx9T
         80rrc7HOrEmuXODUuRTIoUkjQEYtjKnQt6e86UVbmZWy18gSIljw5fe+f3K3lhyTjjO+
         LhLoH5eNOsYH2W6KkoUTL/fce5EgsB4AlcAMe4CEh2EBgY2wPep/yhv2t7Nv/RNM/Sy/
         n/r8MrO5Ydf8vC+hTnT0aL1irkNxusIfHS8Ad/Cx1anH/kQoOFmYPiffWI2w2GhqcZ9b
         MnHL+Rj6yCvvQvOcUpn3+18ChoRIu7v6uHoqAfb3QNVG6owf6SlDL4PpuFrzIWU+Lmg3
         Wp8Q==
X-Gm-Message-State: AHQUAuaJcjJGeQjZtcjARHONotHZLoe88dsBfkxBJw3Lbt2H18LCTnl2
        0iZ4v4VO1/oedosCs6gG9WVMNJLWeYIXtbCzF2ExNQs=
X-Google-Smtp-Source: AHgI3IYlQnE68jnMDnJnbD0zEttAvT8xBmElTC2I7hfUlUqLHZFZ87Tj3yi4MiZ56dRp6SEA6+dSNjYzsqTXQ9nHtTE=
X-Received: by 2002:a19:8c56:: with SMTP id i22mr1570280lfj.79.1551288961293;
 Wed, 27 Feb 2019 09:36:01 -0800 (PST)
MIME-Version: 1.0
References: <20190225005528.28371-1-paulo@paulo.ac> <87y36170y2.fsf@paulo.ac>
In-Reply-To: <87y36170y2.fsf@paulo.ac>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 27 Feb 2019 12:35:50 -0500
Message-ID: <CAHC9VhSaMcD232ZzXuS16usQL2DHSZRy5JqtFZWkjV+h6eUztw@mail.gmail.com>
Subject: Re: [PATCH] selinux: use kernel linux/socket.h definitions for PF_MAX
To:     Paulo Alcantara <paulo@paulo.ac>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 27, 2019 at 12:07 PM Paulo Alcantara <paulo@paulo.ac> wrote:
> Paulo Alcantara <paulo@paulo.ac> writes:
> > When compiling genheaders and mdp from a newer host kernel, the
> > following error happens:
> >
> >     In file included from scripts/selinux/genheaders/genheaders.c:18:
> >     ./security/selinux/include/classmap.h:238:2: error: #error New
> >     address family defined, please update secclass_map.  #error New
> >     address family defined, please update secclass_map.  ^~~~~
> >     make[3]: *** [scripts/Makefile.host:107:
> >     scripts/selinux/genheaders/genheaders] Error 1 make[2]: ***
> >     [scripts/Makefile.build:599: scripts/selinux/genheaders] Error 2
> >     make[1]: *** [scripts/Makefile.build:599: scripts/selinux] Error 2
> >     make[1]: *** Waiting for unfinished jobs....
> >
> > Instead of relying on the host definition, include linux/socket.h in
> > classmap.h to have PF_MAX.
> >
> > Signed-off-by: Paulo Alcantara <paulo@paulo.ac>
> > ---
> >  scripts/selinux/genheaders/genheaders.c | 1 -
> >  scripts/selinux/mdp/mdp.c               | 1 -
> >  security/selinux/include/classmap.h     | 1 +
> >  3 files changed, 1 insertion(+), 2 deletions(-)
>
> Ping?
>
> Could someone please take a look at this issue?

It looks fine to me, but I typically don't merge patches this late in
the development window (we are at -rc8), unless it is a serious bug
fix.

> It's quite easy to reproduce on my host (4.20+) when building an
> unpatched 4.14 kernel ...

While this is a good patch that does fix a real but, the fact that it
has been broken for several releases tells me this is not a serious
bug and not likely worth the risk for the upcoming merge window
(however small it may be).  There has been a lot of good work put into
mdp very recently, and I expect to merge that, as well as your fix,
once the upcoming merge window closes.

-- 
paul moore
www.paul-moore.com
