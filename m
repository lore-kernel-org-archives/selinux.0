Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1621C433EF
	for <selinux@archiver.kernel.org>; Wed,  8 Dec 2021 20:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240009AbhLHUOW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Dec 2021 15:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236644AbhLHUOW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Dec 2021 15:14:22 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB30C061746
        for <selinux@vger.kernel.org>; Wed,  8 Dec 2021 12:10:49 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id r25so12207462edq.7
        for <selinux@vger.kernel.org>; Wed, 08 Dec 2021 12:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ula0xQ3Xzq5axhOhDRdAiKgBJV1GPBBzL+Jb5LHdEec=;
        b=2a4y5pv2WObdvYThKPGjAfhkjDfJdoHQkIevvnw+U0kgPZghMwFDwuATN+lO1LYVaL
         zDpLaFD0Fe/y2fxxREmgH+NIFo/msTvw3x7iuXs14ykr4bWmMoUHM0+ByZkmu+f13Jch
         Attyio8e7/SOnks7FxLQUyGkgI+XsZbeTdJzMTi4ZozV9bKARz2WdtHw80QzM9tBuHJa
         M+xv54B0lJyXWPsc31ej1xAYsOtZLUTa0+Pr5EV2AzRCIYz6TefqW8P8tPUclW1/+dI5
         k7TmlRwhNfSFm6CENnwMmUa8ueoHZNVR6mAYm9OXjrcR01rNiDt65w8a5zoTHmdmdg2A
         ZBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ula0xQ3Xzq5axhOhDRdAiKgBJV1GPBBzL+Jb5LHdEec=;
        b=v6aNe7MSqKihuRcNvJVEP7J+9U7qu1xdlETLQngsEQmYqn71tWMJmsRCNExhD3NAY4
         w7ijBzHmd9BSbxzYQ9SLKVUnLe734fAwPG33oiAQ8gESkXtJpxStc1WQ7XKWFcAIfs0Y
         KS6iUKSJFpGw7bdK/Q5EKZpEEwjU+8c1NH9vaw+4tUIne8Uvwk4yACXJedVe2heEe4vX
         NVpbnWeqSllj3CWiZOTB5QlJe+Kxvv65/goZdrf6Jh82Xp7NETz4aHyr0R8xsoVuowG0
         wd2FVEyktM2A0sFkrsZp3dh6GcHopWg381UiyPAmppC7dHl87Gv+pQXzfsTqqQ67mcjw
         OYig==
X-Gm-Message-State: AOAM53126Zma5DLkSSf8xqNy2fOkfIz2FYDDHh0Plxj+Zb2MoteFBaX4
        RE+WrLDb31ZV5rcDdMsCJqb17ZtO4RKb/96eqf3F+guDHw==
X-Google-Smtp-Source: ABdhPJyLZ9Of4NePcphD7LRd1QcXVa1YCeyc9w51zCfK13Q7BG8RdsDV1wp0SJW1gVbKIsEqwsP9SAhweeAeSjclovY=
X-Received: by 2002:a05:6402:12d3:: with SMTP id k19mr22422272edx.244.1638994248497;
 Wed, 08 Dec 2021 12:10:48 -0800 (PST)
MIME-Version: 1.0
References: <20211208121654.7591-1-richard_c_haines@btinternet.com> <20211208121654.7591-4-richard_c_haines@btinternet.com>
In-Reply-To: <20211208121654.7591-4-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Dec 2021 15:10:37 -0500
Message-ID: <CAHC9VhRH5oBMcae3HbjzvVYpTDpUWjEd1mCUWdu_yJW-TLtu3Q@mail.gmail.com>
Subject: Re: [PATCH V2 3/7] object_classes_permissions.md: Deprecate lockdown class
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 8, 2021 at 7:17 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Add text regarding the removal of lockdown hooks from kernel 5.16.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  src/object_classes_permissions.md | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Merged, thank you.

-- 
paul moore
www.paul-moore.com
