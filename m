Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EB8C433F5
	for <selinux@archiver.kernel.org>; Thu, 23 Sep 2021 19:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACB9560EE2
	for <selinux@archiver.kernel.org>; Thu, 23 Sep 2021 19:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240613AbhIWTGm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Sep 2021 15:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237009AbhIWTGm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Sep 2021 15:06:42 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C3DC061756
        for <selinux@vger.kernel.org>; Thu, 23 Sep 2021 12:05:10 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id s17so8021314edd.8
        for <selinux@vger.kernel.org>; Thu, 23 Sep 2021 12:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OjGxRsmvhBr+CbesjOE8elj38YLwWo4P0P9yao9FiD8=;
        b=H/AHtvZvMHkO6/utAvgHSi7p0xOS0Q+BhIhtFi/Sa19WrstOooYz6XsOLYrhjKIztR
         xD0CLgj70ZpgIAl1E8j/FBTm3hbKpxL6FO2Z8aiBFmFOjnCPZj1CUsBO7L1WaoopKvY4
         F3RRQjprY4ZuWA1wOX1L8NsjHbb1lOTxiknyTAI7ZuHx7CplR3H1wTrH6niPSGdeZG79
         +ktVNEfFgppSZwSPS0iyIOWyn/HJnDpS6naX6PuNUUPMRWnBM8ADU2xCoS0FpcvoerpO
         h0UOZsKZlv5TrXZpICxPS5Dj0Ok5AbZ+vgooG/v51jxXVogvz095zI6Kib0faZEPIrzH
         K+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OjGxRsmvhBr+CbesjOE8elj38YLwWo4P0P9yao9FiD8=;
        b=BreyjDy+uPRPm0+26MMDtG5OYFS1wUh5g66Bx8ACECiXt2iMcykMSUJpLVZSK7kuLI
         VDgebs9Ubt+pWps4otziL1Oa0YSOECQ/6kqj95aDrUhppRQV2ELzL13DDtL/eqvz0D0P
         50uXj+txVb0knsjYT6iUsE//HtH2uB4+DLXI1Fro1N5FBaJ1qjGlKypNTKdkBe5razrb
         7fSb8wjtv8LLyHlkH78IfsaKodA8A7ucdhFXVgk+EFVwwPi1g5Z/eWNYMSnRzFIsHlzW
         j0vyMJmU2RaHEXc3xAFObWDd7zQUsTdwEaKDzLTtOXk/8R0ss4DchoAF7hORCxKvvwsh
         8LFA==
X-Gm-Message-State: AOAM531aY1dWyEvE5nprmba63vh71q7HSM/mqqNU+wSYbqUJiDQGv5/c
        iw6JIN25tbhWM9DVMDW4srRKZnHPQ8kuHmvR0GE/YrRCVg==
X-Google-Smtp-Source: ABdhPJyu0+RaGzwyRtqEYj+VVmV3ZqftmctY8HBILM8gWQKza5UlAIzxdwHlaYwx2giGkpleQ+7J+MdgzyGduvki5ws=
X-Received: by 2002:a05:6402:1607:: with SMTP id f7mr373302edv.187.1632423908791;
 Thu, 23 Sep 2021 12:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <163241206546.71956.16494958077958683533.stgit@olly>
In-Reply-To: <163241206546.71956.16494958077958683533.stgit@olly>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 23 Sep 2021 15:04:57 -0400
Message-ID: <CAHC9VhR_Cnmxd95n8Y3jnNvOZJXvw3RzqMeVK0Ei=uA7OOoOsg@mail.gmail.com>
Subject: Re: [PATCH] selinux,smack: fix subjective/objective credential use mixups
To:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jannh@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 23, 2021 at 11:47 AM Paul Moore <paul@paul-moore.com> wrote:
>
> Jann Horn reported a problem with commit eb1231f73c4d ("selinux:
> clarify task subjective and objective credentials") where some LSM
> hooks were attempting to access the subjective credentials of a task
> other than the current task.  Generally speaking, it is not safe to
> access another task's subjective credentials and doing so can cause
> a number of problems.
>
> Further, while looking into the problem, I realized that Smack was
> suffering from a similar problem brought about by a similar commit
> 1fb057dcde11 ("smack: differentiate between subjective and objective
> task credentials").
>
> This patch addresses this problem by restoring the use of the task's
> objective credentials in those cases where the task is other than the
> current executing task.  Not only does this resolve the problem
> reported by Jann, it is arguably the correct thing to do in these
> cases.
>
> Cc: stable@vger.kernel.org
> Fixes: eb1231f73c4d ("selinux: clarify task subjective and objective credentials")
> Fixes: 1fb057dcde11 ("smack: differentiate between subjective and objective task credentials")
> Reported-by: Jann Horn <jannh@google.com>
> Acked-by: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c   |    4 ++--
>  security/smack/smack_lsm.c |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

FYI, I just merged this into selinux/stable-5.15.

-- 
paul moore
www.paul-moore.com
