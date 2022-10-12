Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAABAC4332F
	for <selinux@archiver.kernel.org>; Wed, 12 Oct 2022 22:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJLWHt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Oct 2022 18:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiJLWH2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Oct 2022 18:07:28 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506656381
        for <selinux@vger.kernel.org>; Wed, 12 Oct 2022 15:05:38 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id f23so137819plr.6
        for <selinux@vger.kernel.org>; Wed, 12 Oct 2022 15:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4pGHWCM3N3OUCM1ER+rKkscIwlNTBChe1kgAgXac27k=;
        b=ZxJoRoLe4ZBw6t/WVbwcJncoE0viTUu8WwUYo7HbCWwah3umOJMh7nIangr40Amqkq
         9W0ohHrMfNY+RUM2a81m+RD18ceXG+efXZmb0U/XCJCPPqQMUDOn4Ud9rbXn2edUNUgZ
         crmhtoIrm7mDYAljbxaMlHUxbJWvFs5GJQKj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pGHWCM3N3OUCM1ER+rKkscIwlNTBChe1kgAgXac27k=;
        b=VaabJmBHzp5YJMm0ojYHmCogHD3KJJUxi74edQW3ydLrVygVXgaNOnWvfu4XayMPCZ
         oP9O0/VmgepzDdNZAUCCYrU15MH9WQEhWALvdysU8pTfnw5FvonnIVLalSscv6uiMHOI
         XzWmfxvKMv61T9x6v2kZm5Se5Ljw0fC1c2fiFEZQr88TmC7jTtHIpd1zH2DZ0AI6ftdR
         M/Oyvbf4TuUNdXK3hgtYrn/XBy0HG8kg6vcPxKwsC7MDZUNQJZruAgTvHhrdxMQaOkrG
         HBXPusOdbdK1gTTj4AFAKYsha4G2+47tyzNnD4L9OfrjXNRFcUrlqlegIlnucpC7dTC/
         nmKg==
X-Gm-Message-State: ACrzQf3XhPjhHvGvZVSjU8vWj4E0NkL+5Qnc+OBf6qKEazIBKGBLFkUE
        Dl6wP7a3TTqPf73m1hW5Xm2mYQ==
X-Google-Smtp-Source: AMsMyM5qJXypLtEuI7LmQWOcC6PZlx4jhq65/txaKudvas3aDV4YoebnKIfrSMm8JqEgIT2QXo2a9Q==
X-Received: by 2002:a17:90b:400c:b0:20a:bb11:a0f3 with SMTP id ie12-20020a17090b400c00b0020abb11a0f3mr7423615pjb.166.1665612251178;
        Wed, 12 Oct 2022 15:04:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w133-20020a62828b000000b0052d4b0d0c74sm360959pfd.70.2022.10.12.15.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 15:04:10 -0700 (PDT)
Date:   Wed, 12 Oct 2022 15:04:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        jmorris@namei.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v38 39/39] LSM: Create lsm_module_list system call
Message-ID: <202210121459.00980C2@keescook>
References: <20220927195421.14713-1-casey@schaufler-ca.com>
 <20220927203155.15060-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927203155.15060-1-casey@schaufler-ca.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 27, 2022 at 01:31:55PM -0700, Casey Schaufler wrote:
> +SYSCALL_DEFINE3(lsm_module_list,
> +	       unsigned int __user *, ids,
> +	       size_t __user *, size,
> +	       int, flags)

Please make this unsigned int.

> +{
> +	unsigned int *interum;
> +	size_t total_size = lsm_id * sizeof(*interum);
> +	size_t usize;
> +	int rc;
> +	int i;

Please test that flags == 0 so it can be used in the future:

	if (flags)
		return -EINVAL;

> +
> +	if (get_user(usize, size))
> +		return -EFAULT;
> +
> +	if (usize < total_size) {
> +		if (put_user(total_size, size) != 0)
> +			return -EFAULT;
> +		return -E2BIG;
> +	}
> +
> +	interum = kzalloc(total_size, GFP_KERNEL);
> +	if (interum == NULL)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < lsm_id; i++)
> +		interum[i] = lsm_idlist[i]->id;
> +
> +	if (copy_to_user(ids, interum, total_size) != 0 ||
> +	    put_user(total_size, size) != 0)
> +		rc = -EFAULT;

No need to repeat this, if it is written first.

> +	else
> +		rc = lsm_id;
> +
> +	kfree(interum);
> +	return rc;

No need for the alloc/free. Here's what I would imagine for the whole
thing:

	if (flags)
		return -EINVAL;

	if (get_user(usize, size))
		return -EFAULT;

	if (put_user(total_size, size) != 0)
		return -EFAULT;

	if (usize < total_size)
		return -E2BIG;

	for (i = 0; i < lsm_id; i++)
		if (put_user(lsm_idlist[i]->id, id++))
			return -EFAULT;

	return lsm_id;

-- 
Kees Cook
