Return-Path: <SRS0=qKou=WS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24919C3A5A1
	for <selinux@archiver.kernel.org>; Thu, 22 Aug 2019 16:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B6F23400
	for <selinux@archiver.kernel.org>; Thu, 22 Aug 2019 16:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="pi6XK9pe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733102AbfHVQcc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 22 Aug 2019 12:32:32 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37948 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732823AbfHVQcc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 22 Aug 2019 12:32:32 -0400
Received: by mail-lf1-f65.google.com with SMTP id f21so20123lfc.5
        for <selinux@vger.kernel.org>; Thu, 22 Aug 2019 09:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ujwYz/NxPt4KuZjfQpu/cnFqN0PKCiE0M+fWaEKXyzU=;
        b=pi6XK9pe93bWuyf6pKryFGG43zRe1ZCwwDleYSgufZv9Ci87EtNumSlh81D/RMBUB1
         SkpQVhfDqHWd+OvxONVKRfKsmHySwguPchGfTt+wRko0hWR9DVzcoHkWnhqNRVJLc463
         PiOXVl+YsmkFkn5w2u+TMtRHc6qyawh1xi+nxO6St0bc+jI1FT3TA/9k/+Vm2YIdcgGp
         EBYt5j1wQaaqWleGeWnb3Mw9+6lZSjsrpJAvvXLPTJFHmVqklBrovOL1hU02MgFGeiqX
         PC7aIX8nX/8P96zUM4rYaQG02bsss1BLzMdmXQ2sZU/WQaDv1/5fphkKSKBF1bFyqIJi
         4FmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ujwYz/NxPt4KuZjfQpu/cnFqN0PKCiE0M+fWaEKXyzU=;
        b=JWzESl1bZ2u6gPoocOWPjki4FMZjLlLeco9JFfwI39PIQ7Z7bOielqpz+7L0BNruBW
         WQ3Jm/Emb4F+mTxafp6rM7WndzV54myekROm8WuwnFIzN9PBLwCCSQMWA2GRaKTBNsUQ
         Rnmam20YR+Lo6xMNgsiUcNWwqurCiTGed/0XhiSoH4HwqfQCPL9gXeZYaCepBOJ3ZLW/
         BEPeR7rMR26Ys9ld0rbSWe7WprQ5QD66qLo+kYbejPGLlQ6B5Xig/QaBGhUgqioDQg7b
         3PC9jWUrmwK1Y9Oq5MxpA6TaXtFGFd57ShQFmhvZcdLbIZn0pC2y6wrSZRy7B9MudKnM
         v4PA==
X-Gm-Message-State: APjAAAXYEz504jbDZjBmTFMlPlQ/KzAV/BexqjuKts0BrXVZ3azSD1ns
        MLVL3mGCh9G4zFzwJEfJh6OQoNJdkiq9OwQX7l78
X-Google-Smtp-Source: APXvYqzz2n4ssNU9eUBLNHNiiN1igpCWk1mywwCx6WmTr0Wqj7FtpXsRl6ByHayPfeQfIrJhDa2FjRZ8pjDimCZFisc=
X-Received: by 2002:a19:4349:: with SMTP id m9mr35378lfj.64.1566491549775;
 Thu, 22 Aug 2019 09:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhSz1_KA1tCJtNjwK26BOkGhKGbPT7v1O82mWPduvWwd4A@mail.gmail.com>
 <20190822070358.GE20113@breakpoint.cc>
In-Reply-To: <20190822070358.GE20113@breakpoint.cc>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 22 Aug 2019 12:32:18 -0400
Message-ID: <CAHC9VhQ_+3ywPu0QRzP3cSgPH2i9Br994wJttp-yXy2GA4FrNg@mail.gmail.com>
Subject: Re: New skb extension for use by LSMs (skb "security blob")?
To:     Florian Westphal <fw@strlen.de>
Cc:     netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 22, 2019 at 3:03 AM Florian Westphal <fw@strlen.de> wrote:
> Paul Moore <paul@paul-moore.com> wrote:
> > Hello netdev,
> >
> > I was just made aware of the skb extension work, and it looks very
> > appealing from a LSM perspective.  As some of you probably remember,
> > we (the LSM folks) have wanted a proper security blob in the skb for
> > quite some time, but netdev has been resistant to this idea thus far.
>
> Is that "blob" in addition to skb->secmark, or a replacement?

That's a good question.  While I thought about that, I wasn't sure if
that was worth bringing up as previous attempts to trade the secmark
field for a void pointer met with failure.  Last time I played with it
I was able to take the additional 32-bits from holes in the skb, and
possibly even improve some of the cacheline groupings (but that is
always going to be a dependent on use case I think), but that wasn't
enough.

I think we could consider freeing up the secmark in the main skb, and
move it to a skb extension, but this would potentially increase the
chances that we would need to add an extension to a skb.  I don't have
any hard numbers, but based on discussions and questions I suspect
Secmark is more widely used than NetLabel and/or labeled IPsec;
although I'm confident it is still a minor percentage of the overall
Linux installed base.

For me the big question is what would it take for us to get a security
blob associated with the skb?  Would moving the secmark into the skb
extension be enough?  Something else?  Or is this simply never going
to happen?  I want to remain optimistic, but I've been trying for this
off-and-on for over a decade and keep running into a brick wall ;)

-- 
paul moore
www.paul-moore.com
