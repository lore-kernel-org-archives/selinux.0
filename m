Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3C1C433E6
	for <selinux@archiver.kernel.org>; Tue, 12 Jan 2021 15:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2886A23131
	for <selinux@archiver.kernel.org>; Tue, 12 Jan 2021 15:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732422AbhALPLT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Jan 2021 10:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbhALPLT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Jan 2021 10:11:19 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E50C061786
        for <selinux@vger.kernel.org>; Tue, 12 Jan 2021 07:10:39 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id jx16so3962881ejb.10
        for <selinux@vger.kernel.org>; Tue, 12 Jan 2021 07:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HhHfoM7zZH3YrJqmQ/QO29Rc5q6tQSSrq+wYdxBcVhM=;
        b=jqD3iIoy6FBHJIXnHTmQdQr95Lqt+b06BNn8rl1Bo17uKPP3aubj4yzPcPyV6zYwj6
         IuCy/RMmOxKQDCSux5yHJJGyi/+1vsSqiKE69+lxSySOsj2uzbCZcy0y7IUVgL3ibqks
         WULuFR/13EkzNzY1sJwISze6ev7gP2hQqTK8MyufIKaJq+HH+AFYbxRlof+ZOl4TcGak
         NwgOcFBspBqUqN9N7/dNN45suaHICi5v8z9ipTf3P8IImf67y0JZgkggMVoHbr21flu+
         +7S3/pIi7D3VHtvxZE482ItZ74QXVBiyXTwZPPBCsaGropZ+fbZfrwMfEayp6oVTOScv
         +zmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HhHfoM7zZH3YrJqmQ/QO29Rc5q6tQSSrq+wYdxBcVhM=;
        b=sbj7rNddVuwVwGLjW2I++6RuVW6z24+ay9qGd4R6OgQ8Zv+8ChhHybWgWMe9VS65X9
         fCtyoFuurGavmNmpzuwHD+KsoNf5WTWUYmTCSC0P3Qh9kiDLG0ek0l5Ez4CLv3bIawJJ
         /6LSKJFwkD4b7p2r8skw+SrYqaUKmpkt8+oGku7vKbDWMtcWTUnZFFwrHEQCkhiNysyT
         ykqBLHXHGXwjsyy73bBXn01v53KD9gHGu0iYWvXaUUvVABmiPpSgbqrgPyohS1emkQ7J
         SrhCVA3SjfGAO64mhX5ccRx5CxsvJfGBD0WWDgr+9m50YPnuPAyjg7eFA+oJC4B6FGzr
         XczA==
X-Gm-Message-State: AOAM533bLE3Q0o4Tnw7lnUfaNqZNoROkSfVBmzHzZoOkd8rF8VB+NJYT
        eR6gMzE+NMmj6D7N26keyOvbUJUhWmutdIZe8SAZRZtX+g==
X-Google-Smtp-Source: ABdhPJz6MxMsNFt1bd1cizDlY6zBlFvcjtqtvvHnoylTTIEnvs09usw/uRcSuV3Z15NyMis2fdTJE/B6IXV8vN9Z350=
X-Received: by 2002:a17:906:1393:: with SMTP id f19mr3493400ejc.431.1610464237791;
 Tue, 12 Jan 2021 07:10:37 -0800 (PST)
MIME-Version: 1.0
References: <20210106132622.1122033-1-omosnace@redhat.com> <20210106132622.1122033-5-omosnace@redhat.com>
In-Reply-To: <20210106132622.1122033-5-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Jan 2021 10:10:27 -0500
Message-ID: <CAHC9VhTngHCeuLsqZ9qWgAh81Fk6Op5HTre0gwWb7r6Aeidk2Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] selinux: mark some global variables __ro_after_init
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 6, 2021 at 8:26 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> All of these are never modified outside initcalls, so they can be
> __ro_after_init.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/avc.c        | 10 +++++-----
>  security/selinux/netlink.c    |  2 +-
>  security/selinux/selinuxfs.c  |  4 ++--
>  security/selinux/ss/avtab.c   |  4 ++--
>  security/selinux/ss/ebitmap.c |  2 +-
>  security/selinux/ss/hashtab.c |  2 +-
>  6 files changed, 12 insertions(+), 12 deletions(-)

Merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
