Return-Path: <SRS0=ySGb=CF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1DCC433DF
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 16:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1914A2087C
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 16:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZ6R2PuV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgH0Qe3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgH0Qe2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Aug 2020 12:34:28 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB406C061264
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2020 09:34:27 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id k20so4927713otr.1
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2020 09:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RxbN33CDXe6VqpCtXPhrGOWh0LLX64XyCrsG4eP5Yc4=;
        b=pZ6R2PuVjCAczt6FsxOjYPKpz+psMXXniby9wnhHbURhG32UWM6fezgqgVQaTOFfkE
         jjMoB1wryC8Cj13Wv7D5Jn1unKYBWGxvHs6n3snDhBTRwTMZpTJQfnhVOurn3Yb0Xx2a
         Nq3UtNIBljSVCH/QsMcEJXP0vCSEzGRoZrHlnOEvEGqwQ/zcrNm8rAsQ9r8xmNTrSzFQ
         NZUJn0PLTpH2XVsna6v7Biv6f1uT3wOk2IaKo3Mfi0ALPkmTJIa72OZ9ufF6doGOwGjB
         0HZWjSDdEtPLEmCryRrRjMyEMDmWSKYK62OLXtT6b9RsMjbhMw8OA8sqF/BR9wSGDTt9
         rM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RxbN33CDXe6VqpCtXPhrGOWh0LLX64XyCrsG4eP5Yc4=;
        b=Le5NRaBSDSINyX1+FTHFkB9yFYcNX5qnnqX9YqyoYm+68lc5ABZAq4Sja8oW5RzNY9
         xhx5BDsdyk1CgGEinvhcdB/L0WXLjIqNA7wUnRgCasLafCSPjkCvS2WQY30ssSGJKEwD
         vk3w7GcLnSqFjUgT24k12GZLmRY9rHcVC7g/Vv6LoZ4QiVpfukNrnROH1QlJwp82Ru8W
         aWXFuuy+WxEdQtDN6UXEQ+ma4thdFgU9nIk2pHliTaLoT+NlL79vPms6luli0CQHxiM5
         QrqKiuxJh3Yw4cqutF9xcGg5K6cB+obTaucu0JVCXJe846NDoayo+JnoJH4VYqScR/62
         1+Ow==
X-Gm-Message-State: AOAM530QW/UrKWAbxOMh0x6tOlsvaWH3R9qDB6JrfM306S1pDxE1soGw
        uHVFg00RKn/xp6RXljSO13OPiFkJSiyT1QdeDh4=
X-Google-Smtp-Source: ABdhPJwEYVhLBTV0VnXbjVYPLpym/adL9Q7zOBO82fiV2+ZO5abYgwbuIV0ntcp/DqKnqjT/1PYxW8do2cnFYDNsbr8=
X-Received: by 2002:a9d:25:: with SMTP id 34mr12022968ota.135.1598546067069;
 Thu, 27 Aug 2020 09:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200827162753.2089782-1-omosnace@redhat.com>
In-Reply-To: <20200827162753.2089782-1-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 27 Aug 2020 12:33:17 -0400
Message-ID: <CAEjxPJ6Yt5N=vPKp1NKL9vizOuqBgwEW6ZrHjdnBfEpymWF12A@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: simplify away security_policydb_len()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 27, 2020 at 12:28 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Remove the security_policydb_len() calls from sel_open_policy() and
> instead update the inode size from the size returned from
> security_read_policy().
>
> Since after this change security_policydb_len() is only called from
> security_load_policy(), remove it entirely and just open-code it there.
>
> Also, since security_load_policy() is always called with policy_mutex
> held, make it dereference the policy pointer directly and drop the
> unnecessary RCU locking.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
