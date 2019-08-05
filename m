Return-Path: <SRS0=PMFh=WB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AE8C0650F
	for <selinux@archiver.kernel.org>; Mon,  5 Aug 2019 20:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7F92086D
	for <selinux@archiver.kernel.org>; Mon,  5 Aug 2019 20:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="BzRZEOi2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfHEUtN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 5 Aug 2019 16:49:13 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39812 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfHEUtN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 5 Aug 2019 16:49:13 -0400
Received: by mail-lf1-f66.google.com with SMTP id x3so5336268lfn.6
        for <selinux@vger.kernel.org>; Mon, 05 Aug 2019 13:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=40Emo+Ql5TsNg02VFZ4Ovs+vHDRL3yLyCVrIck00Oy8=;
        b=BzRZEOi2hYlsF9s+qXoWelT9x1n/rJKadLFYiWj1CyrG5oDZzn3mS1JZlaxg66O9ms
         Bf9i/lsKSUXht9yHNNWORK2SeO26tqUuVwcJXYU7JF5wZP1FgX9fVfrRgHimxkzqbOxP
         GZz2R7Pu+PL9RtM/QG+uPqAFpxpMMgL8uGiPdA5zPrm7Hh1WY4K/pN8pVbTNFYpJUzFg
         VCsotd/JRBk+4c8uuP0BaPDgzx2RfvF5urr1q2ot06Z3hALSp0qnbYaoFkzN8F7gar/h
         EilBk4qwqIjXt1ks5jfyVfxv8NbYqdodFCRWgGx5osYeAuEiWRtpwkXxk/qxbTl1darp
         ubTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=40Emo+Ql5TsNg02VFZ4Ovs+vHDRL3yLyCVrIck00Oy8=;
        b=pQMN3THbIyFIW9rFOlmrL6eO7ugNm5AmEc5vZ5n0d63WAEKxCFKwscBkVfwZtVDFwy
         NezzEbxxfZwYsionVJnuPdR2KUUVFYAgVpZRbFyB/KTCzEpbTJUU59cdRH+d487Ipt5X
         Jn7Wz+WLFMElWNR1y+ilx9fphbeJURSZmm3rotrM8URyWVi37rZOMU4bMGrvCgtCdQLV
         78lwjxSXlducjSipnR8fJ7A9ZUqWK2YMi1apN+aY1pYU9XrpVHu9ljEuyX3Ggi+M/I1v
         8ubaFsOcyYX0cCWOR0SXRvM4V7/MVZTzTnoe/0XI8U0dEofkQ/2TWEIoSDwF+H6S2bLE
         yWbA==
X-Gm-Message-State: APjAAAUgnX6W6iJ8q6N+FGUwd0K5b16dLYf8TTHhUB0rmGTsaBLxWZAj
        EYH3xia80D6K1PdhNFojC3XcKx2kBl5IrlO/Bw==
X-Google-Smtp-Source: APXvYqyR4Vh5J8MDSbScHFtna5TyLN7xjqeCmaClNE1CYqLuJolD1WIcHzzNcxLGeamAqpxA05a+e/HtOssE2GCj6PU=
X-Received: by 2002:ac2:4644:: with SMTP id s4mr35956655lfo.158.1565038151063;
 Mon, 05 Aug 2019 13:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190729084117.18677-1-omosnace@redhat.com> <20190729084117.18677-4-omosnace@redhat.com>
In-Reply-To: <20190729084117.18677-4-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 5 Aug 2019 16:49:00 -0400
Message-ID: <CAHC9VhTB0VKNiPnAG76hGMvBqCu2jS0Wa8=7rih2r-si9TAxdQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selinux: policydb - rename type_val_to_struct_array
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 29, 2019 at 4:41 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> The name is overly long and inconsistent with the other *_val_to_struct
> members. Dropping the "_array" prefix makes the code easier to read and
> gets rid of one line over 80 characters warning.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/policydb.c | 14 +++++++-------
>  security/selinux/ss/policydb.h |  2 +-
>  security/selinux/ss/services.c |  6 +++---
>  3 files changed, 11 insertions(+), 11 deletions(-)

Merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
