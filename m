Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0CBC433E0
	for <selinux@archiver.kernel.org>; Tue, 12 Jan 2021 14:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83080221EC
	for <selinux@archiver.kernel.org>; Tue, 12 Jan 2021 14:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbhALOz5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Jan 2021 09:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbhALOz4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Jan 2021 09:55:56 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F555C061786
        for <selinux@vger.kernel.org>; Tue, 12 Jan 2021 06:55:16 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id by27so2390540edb.10
        for <selinux@vger.kernel.org>; Tue, 12 Jan 2021 06:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eyDQsFIAxQKLmaNojjI+nD1ighyViukxTF7pV16L56c=;
        b=LHAKFpJcKNY5J9TMAsUB2+Y2/OIRmYuGZRwh5+JO6qFUR103SNnA/2y5sN+uarnyAI
         YHEDBCbmh77rauVAisZc7YWEL6bfcOLmazrODUTEPqyTXo7MQhtpcWSD2JCbatYKyN7x
         3SzuZ9vTVb78to2NQiW+AilAQiAbCuC2x5Sut8TOLlxHz+5L5D0NgBYL8hhMeVNweFD4
         xrCsnpooNvOX3pvilfflwZ6RY9WIHBY8wnW7O4RxxUAI9oTv0dK19qyJAYYpEbryNqb0
         V036VNjHISLwXqxoefwCyB8K+XsMPogYcXYqi8W+bm4ZOBQYuAFXZW+HrrgdL1ZH7c40
         5ddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eyDQsFIAxQKLmaNojjI+nD1ighyViukxTF7pV16L56c=;
        b=miKe2NPuaJ57w7BFXV6fwHzsdc8Xr4PsV8/qIIgHqYtOIPZBBOKv1NVtUhSYdJsFsJ
         qv6bllnAO7HYKBKowDiNkIUIpudiE0/tXLcdZvqPMZdDF985CTOqUzBk083Y2tYxqL3M
         NZjm5wDOzHVZocZ7Cm1PFuBH2TMRqOynkcKiSfhkcrnAJDzrOFPZ9DurfeXcmm/yOYv3
         WPK9UZvg40XP6aAArmDnYDpmWa8BfQO9B9rMsnTF84Ux3qSBTRgyM1jVJmwkLuh6VURK
         mJPv5gBDbZ8ykddUuGCGkFnuKp5VAZNNKy9OlCP9hCD+l6XXoIFO23j9DX4ZPKqYnCFC
         5InA==
X-Gm-Message-State: AOAM531ltvurQeKZoC1M7zgiLlRh8GIf9LWiC1d+8Nb3WNiZAiHfBMNh
        aLdrLm+FJQ7GymrErbVNeLPJn9UX6rnkH8Pw3ltD7o4MkA==
X-Google-Smtp-Source: ABdhPJwyKwlJeYovQPKlUHY5O/MIh7bie0hQ3KFGzCztimYGa0fRt/vl+6WVAG5i5q/a1reJA3gyAMo+qidUoP856Ho=
X-Received: by 2002:a05:6402:1593:: with SMTP id c19mr3823121edv.269.1610463315031;
 Tue, 12 Jan 2021 06:55:15 -0800 (PST)
MIME-Version: 1.0
References: <20210106132622.1122033-1-omosnace@redhat.com> <20210106132622.1122033-3-omosnace@redhat.com>
In-Reply-To: <20210106132622.1122033-3-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Jan 2021 09:55:04 -0500
Message-ID: <CAHC9VhS5xTvq-JgC6v-gOL821_Q1=y5L1Of9eqSx9mW81rRphQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] selinux: drop the unnecessary aurule_callback variable
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 6, 2021 at 8:26 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Its value is actually not changed anywhere, so it can be substituted for
> a direct call to audit_update_lsm_rules().
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/services.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)

Merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
