Return-Path: <SRS0=RO9B=6P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3ABDC47253
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 19:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0BB72173E
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 19:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="oq5HWHKt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbgEATFA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 May 2020 15:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729839AbgEATFA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 May 2020 15:05:00 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FEEC061A0C
        for <selinux@vger.kernel.org>; Fri,  1 May 2020 12:04:59 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w2so7987727edx.4
        for <selinux@vger.kernel.org>; Fri, 01 May 2020 12:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=utiKFhMFXax2OSf9CMAz2YObyOkSwIwuAyj2ZKdulc4=;
        b=oq5HWHKtpvZhq9Q4KlwOYZdn3kapwhhlYk3Z8d+VY1HjYiKGJfLvL4rMXUOmjCiOi2
         rEzT3m6v7K/GH4BM0xHlQEJa0i/UzAZ9YJbTmvTgOWqKg+7MeF6PR4SXC7EOdV9Lq1zJ
         48FYnYBrAjn+i2iMOJJihvDTfAFIXdX+joUTLsUYvgkpZhhH6m7Trb++ErRMxGAmt9tM
         8ViPwEkD1aHDaR25v3rdHlxgiRINkjXYwztVpkicEyDKDMg78wSoAUY2AxqVJSgAdodt
         vvqbk1sLQkTkDayB/suEffQjLEWfcA7vRQgpUo3uetmMHt4OpbgFXII6BcMCj5Y86mq7
         aqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=utiKFhMFXax2OSf9CMAz2YObyOkSwIwuAyj2ZKdulc4=;
        b=qvz0sGeNPh69A8dQZOfZ8un2/4W42z9hpw6HrW/sYusXuPHfZICqD0o+WUr4C1PnS9
         G5koh+u60UWSl0JV6tV5t/IbpKHMMvOM2458IPmLf9cc5P7mTOwj2zMgRy5p4xLvVmFJ
         Eda1x5OKQIlhRDxR9ax0XO7BsUr6UTc8Odp4Tdlhv0y7EyvKWbyVXgJDd76ySi+BQ+SN
         OlbPWUntzRUsGQdeVk9AI8mUT/xU/6fNEWD+xY0M5Uci/EXPQPBeSnkEUBwTaha/0x1i
         LJ7VN4kCCWxsd/gegzM7CWASOee/RyGMmegw2YZpIaKYf5gQu92GxEvwJ5P27t/080X/
         0goA==
X-Gm-Message-State: AGi0PuY0Lni6lY1kJpCVN+lyXBowZr8LsD6r2GDucC5rqAKkR6pLdaVQ
        JtmIBwH82gFiBdCRpfgNEZ7CWWVUqQOaXyRHTYx+
X-Google-Smtp-Source: APiQypISLqBVM6kAdnC7efBpEr9zhjdt95eJNwvxrlblEIgNTRzv6tN3iMIHWIcLkDLNQdSTsdwnZhFXbUB63kTupMk=
X-Received: by 2002:aa7:cd59:: with SMTP id v25mr4497234edw.135.1588359898382;
 Fri, 01 May 2020 12:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200429073053.83660-1-weiyongjun1@huawei.com>
In-Reply-To: <20200429073053.83660-1-weiyongjun1@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 1 May 2020 15:04:47 -0400
Message-ID: <CAHC9VhTEHJiRm-9zkic1mUyVJ6WNLL8AhzRsbq+bf7q2GDdCgA@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: fix error return code in policydb_read()
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        selinux@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 29, 2020 at 3:29 AM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> Fix to return negative error code -ENOMEM from the kvcalloc() error
> handling case instead of 0, as done elsewhere in this function.
>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  security/selinux/ss/policydb.c | 1 +
>  1 file changed, 1 insertion(+)

Regardless of the other error, this patch fixes a legitimate problem
so I've merged it into selinux/next with the appropriate fixes tag.
Thanks.

-- 
paul moore
www.paul-moore.com
