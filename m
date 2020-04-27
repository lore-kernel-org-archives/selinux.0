Return-Path: <SRS0=pnJ1=6L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23E0C81CFF
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 21:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7940F206D9
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 21:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="DfNsTuXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgD0V72 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Apr 2020 17:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726204AbgD0V71 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Apr 2020 17:59:27 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6914BC0610D5
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 14:59:27 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id r7so14749740edo.11
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 14:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KXsqXqLa3MNc3GseZAHL6+hrzDA6tgyahvdXcv6nuC0=;
        b=DfNsTuXejFM4GpdLngZ5Hng3iLMEOmw5AwCqh67++iv5lrN4p7mEwxK9X8c6M5PLNj
         iXbi579Rs0UuusLh+/qG92t2w7+cC4scewai7HDftHnRMvZIQKkxr1MkuqgjtEjlfpgw
         7MngMV8YM5JffLfokIPR0hl1VTQfgZ4V5kdLF8HEdB+nmNwASuOTjm53P5xzL+4G6w3p
         3FZdIm3XNqmVC0z+RSB5hCMSTliW4f8Md5StWC2EHPyVRx1NEkaGZwKAS7lgMDJhsnn/
         3MilaCQLcgRrHf9zcijHP9mD2eWnoEfC56SjjjNZn4mNET3vVMAdDTyw8+WwA4RsJktO
         QBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KXsqXqLa3MNc3GseZAHL6+hrzDA6tgyahvdXcv6nuC0=;
        b=cvPKC03efn4yfRZT+Im2AKrO+jAgltGEbFShXp2OR8gzlO0FhKR7FScD8OaQIgI+Qj
         NWZv2Jg9621KY6iuYWavVy6+qSvMQj+yQmM/31+sW8ihZ7dtyfZOcUZODkgtxsRqFkLn
         jDt0Kd8h1A0uUt9uvJzGeW36fB+YoUkhxfQZePk7N7iZrYtJS3+Ccdny7skEdcny6VSp
         bKqWRABl7jLmoR84zxIuI3VLih+cnipueT9V4v0FItgxwFc+vXzdRtcViSZA2FFA4IHU
         XAXFZUAQvJhDiU2/sYJzAEIfjj05YNr8tYtBLxHFsYf07PyYLT8vSIBEmx3QrhS9z9Ur
         YTRQ==
X-Gm-Message-State: AGi0PuZsFlK0z/vZ8vgIIs+4i0QEHmoP5ih8Z8tFv77PUeMPT9RG7YwV
        u4JjR65HJRRmhF4EMAhqnN4RK4gkX1WA6EDKjSb2
X-Google-Smtp-Source: APiQypL5eq/i30h0N49yhKX69dSyitlFFWBEuwUbGs/BB8DWlk7mSCwyYWLIumXrF+U8i72s44CbscVcJbUdGkIvmu0=
X-Received: by 2002:a05:6402:1215:: with SMTP id c21mr21043564edw.128.1588024766012;
 Mon, 27 Apr 2020 14:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200427124935.130432-1-weiyongjun1@huawei.com>
In-Reply-To: <20200427124935.130432-1-weiyongjun1@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 27 Apr 2020 17:59:14 -0400
Message-ID: <CAHC9VhQdoGgoQGio2_ezjDZe1-AiRAMmQ7Q9Tp8AVEYt2kkjMg@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: fix error return code in cond_read_list()
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, selinux@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 27, 2020 at 8:48 AM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> Fix to return negative error code -ENOMEM from the error handling
> case instead of 0, as done elsewhere in this function.
>
> Fixes: 60abd3181db2 ("selinux: convert cond_list to array")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  security/selinux/ss/conditional.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks good to me too, thanks for fixing this.  I've merge this into
selinux/stable-5.7 and I'll send it up to Linus later this week
assuming testing goes well.

> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index 939a74fd8fb4..da94a1b4bfda 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -429,7 +429,7 @@ int cond_read_list(struct policydb *p, void *fp)
>
>         p->cond_list = kcalloc(len, sizeof(*p->cond_list), GFP_KERNEL);
>         if (!p->cond_list)
> -               return rc;
> +               return -ENOMEM;
>
>         rc = avtab_alloc(&(p->te_cond_avtab), p->te_avtab.nel);
>         if (rc)
>

-- 
paul moore
www.paul-moore.com
