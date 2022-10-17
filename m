Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1322C4332F
	for <selinux@archiver.kernel.org>; Mon, 17 Oct 2022 20:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiJQUR7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Oct 2022 16:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiJQURp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Oct 2022 16:17:45 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD961FCDE
        for <selinux@vger.kernel.org>; Mon, 17 Oct 2022 13:17:31 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id e62so14606628yba.6
        for <selinux@vger.kernel.org>; Mon, 17 Oct 2022 13:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NCEMOr5AuVzxHuiVDwv9toAJ144hGU2z+B9Rrhw2k4U=;
        b=GPWrsx0zl5lEZkF4aF67E2yZIruza6UXkLH0dSXe9yaRvzv/D/GxPprtdMpAc2OGYn
         p7/3Iaa0zpYw4hZ0HkDkxrV8Gph1Q0XuJ3VarwnfBAT0RtzRH4ybHn7PcbznxgJY/86v
         TPJfiW7efup3bVKyJ9ZHbCxgz9NwC7xO4Hmnd+NrKVjhbtuRtGbr3kTogZHY6gFENXln
         NpcM8QFRCmgxfndRm7WDaYA4j45oFpYdiqhgUfv5alSyUjYWXAUAKpWfvXUIh4bIEWZr
         S7rf0nP1z0xMPWu7GmdQg8cwhLISNcIy8fssWcdTv2eQITwj1Wab/CR6T4COkSkkreaR
         wPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NCEMOr5AuVzxHuiVDwv9toAJ144hGU2z+B9Rrhw2k4U=;
        b=nYnwDX4fW9f5N3kZxBeDYy1AuCPGLd0rF18EzKfCvc1yKcRvfMcFBQGDq1SgFTKitS
         sqxdqTSHR32qySf77CP6Rpg9MgKMVCnUHw61iZM+MjSPgL66yrD1xV1/8ioW6y4Hmabp
         znymwqYyiYgu3j0OhYl05srKRPpEFqBxFy7TAUXsID5/UoBx1l8UTJM4j3O+ob5l4189
         kcBdzQvB5QIKBt2+Ub27hJWPIXozlWINBFnowkFuGLiYsnRf3okjBZxWqtMXZ0e4iTZ+
         pE0SB97Su4esOgykK9NEZ81Zkjx/jqOl0y3Js+QZLhN7y9bM4nHNpAKCM0g/DlPQaiU2
         SDWg==
X-Gm-Message-State: ACrzQf1GMWqz7hchryvWUhaaF9CWl3XJOPS7JQnXs8Jm7y07vDPN2Dl3
        PzRyzbXx3LZyHaLeZ5Dokg6o+ZhE2ikug8ZEY6PFQP9T+A==
X-Google-Smtp-Source: AMsMyM6Ff0gtLuqQuHyHnqNLJhAUWdQUg04KePfKS3aNAt249DrRtcqbzRcAesPzmEPyhIU3ha+sDekWqFZkmx+HBOY=
X-Received: by 2002:a05:6902:124d:b0:66d:5ce6:5924 with SMTP id
 t13-20020a056902124d00b0066d5ce65924mr10902254ybu.320.1666037820517; Mon, 17
 Oct 2022 13:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <166389782245.2164705.1324707815130435654.stgit@olly> <CAHC9VhQRNxoCg9BKQ9t1wLuxq51yoqEPEZbswbg7dwGC-22y=Q@mail.gmail.com>
In-Reply-To: <CAHC9VhQRNxoCg9BKQ9t1wLuxq51yoqEPEZbswbg7dwGC-22y=Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Oct 2022 16:16:49 -0400
Message-ID: <CAHC9VhSA=cGxFACHXaOpLtpsV9ikRvEKqLw4io5covjdDOgREg@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: increase the deprecation sleep for
 checkreqprot and runtime disable
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 22, 2022 at 9:51 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Sep 22, 2022 at 9:50 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > Further the checkreqprot and runtime disable deprecation efforts by
> > increasing the sleep time from 5 to 15 seconds to help make this more
> > noticeable for any users who are still using these knobs.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/selinux/selinuxfs.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> As a FYI, assuming no objections, this would be merged into
> selinux/next *after* the upcoming merge window closes.

I just merged this into selinux/next.

-- 
paul-moore.com
