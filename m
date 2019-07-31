Return-Path: <SRS0=SQk1=V4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBF3C32751
	for <selinux@archiver.kernel.org>; Wed, 31 Jul 2019 21:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40D02067D
	for <selinux@archiver.kernel.org>; Wed, 31 Jul 2019 21:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Q4X+9cy3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfGaVK1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 Jul 2019 17:10:27 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35188 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfGaVK1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 Jul 2019 17:10:27 -0400
Received: by mail-lj1-f194.google.com with SMTP id x25so67158490ljh.2
        for <selinux@vger.kernel.org>; Wed, 31 Jul 2019 14:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yjWmOGw6LrGeClMDY6M2mpYvb0Wvxr8l5w1NWCCdnJk=;
        b=Q4X+9cy3/73RaY8GPz92ZJsfu83AGujFg74lCXSiKBETORRhjA8R1yk3xTbSpDSBHu
         7XHHD6TR41SjRqqdjAts0L18guWfGf8zGYaomiNnKGoipcVLllVFpKRw1akESS/WrsUQ
         6RYGg/38zPrJtZimfePBt7jkpZvTUvvh93BuaOOzc43sTSgj6n0jaozEYZeJf5iA6Q79
         7bYntAaqD6b2eOjqFYYlZvb4R9s18ZaC415vajJqZwrnQUOOStxwSUrBfrTgGE2QrMpP
         KYIaCBSmfwe6+315rWqFthvbtDtlsy9jDgXIaL9lbYWOrR71JHNZSyBnDLLmtunHfIfp
         6p/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yjWmOGw6LrGeClMDY6M2mpYvb0Wvxr8l5w1NWCCdnJk=;
        b=hPt+QLL9KOXnjSHzuLwR/WjPZNRWKux/7uTyLosXRAvMguu2Xlh7ZLUFVb69tHmvsb
         K7xcE3jKi2bVx0SWoZR2ns5GT2osw5ddLbDKseREeMbiBXCI6OvJuPhdS5K/gy8p61D6
         yjX6HEDIJfqrJ1pdMKkedvnUmgc0AlXhFhnO0TEZHNBd/4Pk1rsSZMuzDU3V5quegBDp
         XCRN4cXkDv4NnOTwJpEPGKL/ALS5KwC2J4Lj6wAsf8i2uwWXp9+PgLJpt3hPuwoY1+OX
         0zycWshwmOc0gYJtcEHIu/08DoeXjyLL5WogC7h6TK1TWibAUHnw1u0H79QBYvqJU2xz
         hotQ==
X-Gm-Message-State: APjAAAXqiNrKbpromCZSPvfKqAS21RVEcXOGgTtirvO04dS1JbCHJ637
        0/VIa1Xa7Z5ziybm3NXpcRqkUfrNY6BmLmilmw==
X-Google-Smtp-Source: APXvYqwZGgjloKOJUsp5UY3K+rs7FvEEscGVrNBbLvtctkNeRAO6Mp3jk6yvv5sLecAEKjblhpnUiJbzyc9+RIrgB8Q=
X-Received: by 2002:a2e:9858:: with SMTP id e24mr41639379ljj.91.1564607424835;
 Wed, 31 Jul 2019 14:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190725105243.28404-1-omosnace@redhat.com>
In-Reply-To: <20190725105243.28404-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 31 Jul 2019 17:10:13 -0400
Message-ID: <CAHC9VhSvWFcwevzYALkAcbGgJCRsXv_gQ=WXWgpi6y0nHNkGdQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix memory leak in policydb_init()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        syzbot+fee3a14d4cdf92646287@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 25, 2019 at 6:52 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Since roles_init() adds some entries to the role hash table, we need to
> destroy also its keys/values on error, otherwise we get a memory leak in
> the error path.
>
> Reported-by: syzbot+fee3a14d4cdf92646287@syzkaller.appspotmail.com
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/policydb.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

As discussed in the v2 thread, I've gone ahead and merge this patch
into selinux/stable-5.3.  Assuming all is well I'll send this to Linus
later this week.

-- 
paul moore
www.paul-moore.com
