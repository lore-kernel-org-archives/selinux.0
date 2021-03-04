Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D12C433E6
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 21:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 987B764FF0
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 21:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbhCDVd5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Mar 2021 16:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbhCDVdq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Mar 2021 16:33:46 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC4EC06175F
        for <selinux@vger.kernel.org>; Thu,  4 Mar 2021 13:33:05 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id l12so36908179edt.3
        for <selinux@vger.kernel.org>; Thu, 04 Mar 2021 13:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0qROWWTNz36x2w3xcMbLyxyZ1xmwI8HYrEV2dBDfDzY=;
        b=0CwLBLNiLo1fwP/msdddCOm2cYa8rCYq+oioL39s+Ms2gEcWumQYr6RHjPmlol2qeP
         2nFi9aY60gAzKw6DdGMiElgkFSUlJImhpqX2AWYL9Gu+0NUz3ausXJ+EH0VeU4/UcIFr
         t4V3y3rstumz/CmV6XfGE6pD7hYZeirlPf5f3tJaoKB/2q0xA7fFheimMomFlcGVteQK
         pKXkVWWHVW+/Irc5dzzHPgLeYvW+Dwe6v69wHNXQ5L87aPBEodOgrB6cd8wTaAKNlYN2
         o4YQq92KLZ3GNRLO3FL3Bebp2WLws+zAWXQ3oQDqAswonyuJgx5FsxMMoY45jSWBsclo
         7zbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0qROWWTNz36x2w3xcMbLyxyZ1xmwI8HYrEV2dBDfDzY=;
        b=CZWJiiM/KaDuOFhp6AEgXwark2OrQAH4rcKODE6JVyFILWVpY51ahryXFU26PrLl7Z
         zUXwleQrz33nut5hBdYE5fhr/IJ5hYgvhvVyt8a4IUiY2CI/0EifzsxgtJeYqhGps/3u
         NE2vYLD9D+EggEKZbGOBDincfun/P8gT2DHUilykXvMX0X4o6g7lNyESjjmTbk8f0m2h
         oF5nTymurFR31xupmkE5yuXs6yOwVqZPXvbxsEmUq7tNGSg3Cfo5N6+pImHHdOFfTrxo
         Oha4DyofdT/R6Pt09TcR7t1LwkeUFhSVEukmV81R5gQZ8eST3fs9X9prdgi+yxYu+mQE
         rFDQ==
X-Gm-Message-State: AOAM531juHv6fArZkmMVpn5Pvem42Xhx/UFQPjjoS+K5A5BfKCRK+FpW
        6NoM4cn5E3fRwNMirHRGFD/W4UA09T3k5Wy5bm8r
X-Google-Smtp-Source: ABdhPJzy4UbgOeVcYyn5pg7jcVZivwdX/+HaoAbCbn+pN9b29g6mYvb4yXwZjhuGJ7rLq53LL8NlW7vQ6Lj3YqLwJKU=
X-Received: by 2002:a05:6402:3c7:: with SMTP id t7mr6651176edw.196.1614893584307;
 Thu, 04 Mar 2021 13:33:04 -0800 (PST)
MIME-Version: 1.0
References: <161489339182.63157.2775083878484465675.stgit@olly>
In-Reply-To: <161489339182.63157.2775083878484465675.stgit@olly>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 4 Mar 2021 16:32:53 -0500
Message-ID: <CAHC9VhQuNf-PjxdHj2CkfVCZwFfucR_+5Xvr=OahkfXNPKgTmQ@mail.gmail.com>
Subject: Re: [PATCH] cipso,calipso: resolve a number of problems with the DOI refcounts
To:     netdev@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 4, 2021 at 4:29 PM Paul Moore <paul@paul-moore.com> wrote:
>
> The current CIPSO and CALIPSO refcounting scheme for the DOI
> definitions is a bit flawed in that we:
>
> 1. Don't correctly match gets/puts in netlbl_cipsov4_list().
> 2. Decrement the refcount on each attempt to remove the DOI from the
>    DOI list, only removing it from the list once the refcount drops
>    to zero.
>
> This patch fixes these problems by adding the missing "puts" to
> netlbl_cipsov4_list() and introduces a more conventional, i.e.
> not-buggy, refcounting mechanism to the DOI definitions.  Upon the
> addition of a DOI to the DOI list, it is initialized with a refcount
> of one, removing a DOI from the list removes it from the list and
> drops the refcount by one; "gets" and "puts" behave as expected with
> respect to refcounts, increasing and decreasing the DOI's refcount by
> one.
>
> Fixes: b1edeb102397 ("netlabel: Replace protocol/NetLabel linking with refrerence counts")
> Fixes: d7cce01504a0 ("netlabel: Add support for removing a CALIPSO DOI.")
> Reported-by: syzbot+9ec037722d2603a9f52e@syzkaller.appspotmail.com
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  net/ipv4/cipso_ipv4.c            |   11 +----------
>  net/ipv6/calipso.c               |   14 +++++---------
>  net/netlabel/netlabel_cipso_v4.c |    3 +++
>  3 files changed, 9 insertions(+), 19 deletions(-)

As a FYI, this patch has been tested by looping through a number of
NetLabel/CALIPSO/CIPSO tests overnight, a reproducer from one of the
syzbot reports (multiple times), and the selinux-testsuite tests;
everything looked good at the end of the testing.

Thanks to syzbot and Dmitry for finding and reporting the bug.

-- 
paul moore
www.paul-moore.com
