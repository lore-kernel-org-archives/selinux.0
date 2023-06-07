Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A907C7EE29
	for <selinux@archiver.kernel.org>; Wed,  7 Jun 2023 22:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjFGWdF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Jun 2023 18:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjFGWdD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Jun 2023 18:33:03 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62013198B
        for <selinux@vger.kernel.org>; Wed,  7 Jun 2023 15:33:01 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3f9b8f1c2fdso12441111cf.2
        for <selinux@vger.kernel.org>; Wed, 07 Jun 2023 15:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1686177180; x=1688769180;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8llCPG+vVtkPUwjQtiWJ3WQx6JiHNRGSvHVuzeIpYl8=;
        b=Teys5iOPggBuB4MwMYC4fYT40I07CnWHKp2KVP33MNp7LzhrMhIh6ZjObVDrpqopU6
         S65i4AlM1ZRe6MI3inCaIuujJqtHY3mpfIHpgYcW3A2moxi69m94sezvmvs3B/NcLx+7
         iU+VVrAlgQt2E7JKi5S6PiaNiVlghFzKR/ARm11fVjxDlhrC+EKlyw5njk6unuVZY8MW
         EqRLzYpdwLrMOAVx5/6LqgWGEftbBGDSRQ73BGXA1yS4lh7PHIgetQguKtqN2iwwYQrl
         rwvddBBAltGZgnSQjwVhbs9jpRJ5MjhJTCZCQ/GMvIcTgN17Ae8n/+YiEOm36PPooY7e
         LhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686177180; x=1688769180;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8llCPG+vVtkPUwjQtiWJ3WQx6JiHNRGSvHVuzeIpYl8=;
        b=k//G+t36wZ/IqB8xYrUaDxUNrMwwyDEVJUHg44OLFjhUyJsKFcJZLhTHNXL6m7pQjT
         rqHW8UfUep4AcjGBVR6J2vXb03ijT7jNSLYJ2BwN72w/fKiRJu9AtmbJjyCGBKH4DZr/
         ysfZkyIscQcles5ssLk7bhLwguRAmHDTyOtvv9Gq4w1dy9CEdGlqAbxPRCR0Hx8s0z+0
         tZqR15ddBM8IhGB1e0HDMEU7o5hd3IDvO3eoE0SXqfBfxfaKIPxM6qw75AYxA82eU6JY
         CZtFCrTSDiVK7TzQrogBQkcI3r9UIKKE4uiCWUaetz8B0JdQQuJ3uoE9ddeM/kj+0U4b
         eWFg==
X-Gm-Message-State: AC+VfDy4aAaDpRTA7vp0imtutOqbgBC+DKP17tdwYi8ASI0pSY+MSWmf
        jHAr0gmA1Y3+VkWnDHSWqpIN
X-Google-Smtp-Source: ACHHUZ6HuJH98YyEK9wHunJsZWtU8xAgmefz01BAYcD2rGExrmEEa1OcsJqKl5/Lpuv7iYuO62ZykQ==
X-Received: by 2002:ac8:7f81:0:b0:3f8:6cc0:d663 with SMTP id z1-20020ac87f81000000b003f86cc0d663mr5296197qtj.17.1686177180421;
        Wed, 07 Jun 2023 15:33:00 -0700 (PDT)
Received: from localhost (static-96-237-115-254.bstnma.fios.verizon.net. [96.237.115.254])
        by smtp.gmail.com with ESMTPSA id g4-20020ac80704000000b003ef33e02eb9sm230021qth.83.2023.06.07.15.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 15:33:00 -0700 (PDT)
Date:   Wed, 07 Jun 2023 18:32:59 -0400
Message-ID: <b09b591926e0f297fe0a3e9d8fcf3a6a.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net, selinux@vger.kernel.org
Subject: Re: [PATCH v10 10/11] SELinux: Add selfattr hooks
References: <20230428203417.159874-11-casey@schaufler-ca.com>
In-Reply-To: <20230428203417.159874-11-casey@schaufler-ca.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Apr 28, 2023 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Add hooks for setselfattr and getselfattr. These hooks are not very
> different from their setprocattr and getprocattr equivalents, and
> much of the code is shared.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: selinux@vger.kernel.org
> Cc: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c | 154 +++++++++++++++++++++++++++++++--------
>  1 file changed, 124 insertions(+), 30 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 2ee92d3fb79d..e78b955e04f8 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6542,6 +6559,81 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
>  	return error;
>  }
>  
> +static int selinux_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
> +			       size_t *size, u32 flags)
> +{
> +	char *value;
> +	size_t total_len;
> +	int len;
> +	int rc;
> +
> +	len = selinux_lsm_getattr(attr, current, &value);
> +	if (len < 0)
> +		return len;
> +
> +	total_len = ALIGN(struct_size(ctx, ctx, len), 8);
> +
> +	if (total_len > *size)
> +		rc = -E2BIG;

Hmm.  Since we need to calculate the aligned @total_len value in the
LSM specific code, perhaps it doesn't make sense to also do the
alignment in lsm_fill_user_ctx().  My apologies, I know I was the one
who suggested doing the alignment in a common place previously.

> +	else if (ctx)
> +		rc = lsm_fill_user_ctx(ctx, value, len, LSM_ID_SELINUX, 0);
> +	else
> +		rc = 1;
> +
> +	*size = total_len;
> +	if (rc < 0)
> +		return rc;
> +	return 1;
> +}

--
paul-moore.com
