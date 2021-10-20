Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1434CC433F5
	for <selinux@archiver.kernel.org>; Wed, 20 Oct 2021 12:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9B4C60F22
	for <selinux@archiver.kernel.org>; Wed, 20 Oct 2021 12:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhJTMYf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Oct 2021 08:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJTMYf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Oct 2021 08:24:35 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A72C06161C
        for <selinux@vger.kernel.org>; Wed, 20 Oct 2021 05:22:20 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w19so25532619edd.2
        for <selinux@vger.kernel.org>; Wed, 20 Oct 2021 05:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/VX3a1CS0DQ/Fjf+suupbSpgSZnpEJ8uMVKe62sTJik=;
        b=GBsuF5ShrNTAiw+Z9wBu5g6bqk6j5Awu6YJ/Axz+LymveGgd1QalvS7dr6PcHKwwlE
         yRUE7ND8lIh4qF4qJbUShADR30FTTihKRUDbPdqlUMEOdzujwzkdurqsoxfy5auoQ/sA
         /D7lgqA+M3lsKBnoJyA1q8XNlAbPH6DQW6zOL5fbHyDcMF1WvXaqbuwnjfyw0XmjxAUt
         h4oXoa2cLWo3zR0WFBtVftEp/x/xLPTTnv3nDaQKQXxHjRHntG8iSFJcZKukOiVls5Mp
         5qqQuYQmbEgG0aGhJB1e96luaaVDrJnkGFMWafMduElMFqZLVkvn4N45Ob13YYnblo2O
         6Hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/VX3a1CS0DQ/Fjf+suupbSpgSZnpEJ8uMVKe62sTJik=;
        b=xuOrujDlqQvznoFS81k1+oM77SbYNNOeO51Oqh3JCC5ZVawJ1XgF2hUCeQDg2Jtgfu
         jkX81e5upDrWEsnPlFm0ITjQ4iWR7QE+Xs+xEJ14E3NjpXoeMAvLB+lZrK5ln3kn2Po5
         ktgRQjvi3D7SXmTybaZ91C7ne1/5WoAa+AGE/xoTE6Jr8O+8HiVSmlSJ0NwLPDaT8Tsa
         vqzBZIkfeKQe1jfsMB7dtES1vszYcnJ9/lB6dg35RpyL8HbDOVu0H0FZY2Ak0sFMw6SN
         UJHOzCfnxI/hA0uhX3rR9kOgo5QRjftq8OdiDI+WGJSuNTtrlquZr3X+xFxj0U6N239h
         LQ9g==
X-Gm-Message-State: AOAM530EofiJdPDBn/YsdQ+7/sduIcdYX3f9HAfq4jz/fDTYMyZH4wn1
        xXXv58g74AgDp1mHn7/16+0lAd1eY5MV/Y+amLKj+1qKpg==
X-Google-Smtp-Source: ABdhPJyCW/82f0YVz7tcIfRZo+fbwcD+fIrdMznmcVWkRrljAAu0khh2rZT4iM98N9/8vJY3g6xPpQH0YE0jDQEKtBA=
X-Received: by 2002:a05:6402:5112:: with SMTP id m18mr61196273edd.101.1634732533355;
 Wed, 20 Oct 2021 05:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <163466736648.20044.16531188246866586566.stgit@olly>
In-Reply-To: <163466736648.20044.16531188246866586566.stgit@olly>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 20 Oct 2021 08:22:02 -0400
Message-ID: <CAHC9VhSZCXfdpm+AeMjP3==qZEOsiT6+bUijNogRiLXhJzdyPw@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix a sock regression in selinux_ip_postroute_compat()
To:     selinux@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 19, 2021 at 2:16 PM Paul Moore <paul@paul-moore.com> wrote:
>
> Unfortunately we can't rely on nf_hook_state->sk being the proper
> originating socket so revert to using skb_to_full_sk(skb).
>
> Fixes: 1d1e1ded1356 ("1d1e1ded13568be81a0e19d228e310a48997bec8")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Suggested-by: Florian Westphal <fw@strlen.de>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Merged into selinux/next, with the corrected Fixes line that Ondrej pointed out.

-- 
paul moore
www.paul-moore.com
