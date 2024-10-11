Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE491F4FD2
	for <selinux@vger.kernel.org>; Fri, 11 Oct 2024 03:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728616092; cv=none; b=tDSGkjkhoYqYRw+2mnEifAI6SwdAQNBr4wVuZZ0ool0oy+ZUyfsCX+g6B1p0G3VKIDtX/UJY5fQ6IyE/g5E3IKxg7reat4EuLzD2U/aw6gYe+PbTe/ChfTRfyAyLWbiqWp7qT48ukh/IxNQTJP0lh/nu1NFZUyFvxiRvpWYFNaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728616092; c=relaxed/simple;
	bh=IL7igmOQsGYJBy4KpEOHftd+UKI3cQZ0IgJYM6Rboz0=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=gVs8WCLmB7FpxPbUx61ypA3n1zqUwm0OZlueD/QdwGfuy1pyajWXy2yoI5/NMtcntnqPq11xxVBplzA0/mrunyqzhs2LA5KIT4SVR5lrelqsBeGBjjE4LeG+jomlTL/Tq8SMwW24gyb1/rl0os6Pi602X4s1wYNWFrIf9Fc40o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Zh6bh6Ji; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Zh6bh6Ji"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4604bd15be0so4048431cf.2
        for <selinux@vger.kernel.org>; Thu, 10 Oct 2024 20:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728616090; x=1729220890; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bql7Hz1mRskOVKGQIDesAVbYzG3D3zgxAMcvJarpKig=;
        b=Zh6bh6Ji0QygpXUy5kduSiEj+eh19grPlV0NT2jD8wTYG6akAkwder5S9OJMSGFCHj
         5H+mTh8RppljQA5O8LUDquujLf2GZJgO05p4dMdL3yVFHKu33tNxsK54jlzXbdKqpDUF
         PLCvNKm4tnrINDymUZrpSu4/W8mXwFUGlOJ2uAdF0enp8XcbioWRyN4Qz76DAw2d5zdN
         hcYAvqv1C+lDnLeJ1pw3pwBkTXYWmQijBuAQlZBkeUkpiA6aCa9b8++2ytwU+HqX77vu
         KBNmT4s77RcMlU4/RYvUIbM4ImHi82qEmOtoRRjmWgxmxPHjCMTv8YrPl3yGp2KtbVYy
         u4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728616090; x=1729220890;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bql7Hz1mRskOVKGQIDesAVbYzG3D3zgxAMcvJarpKig=;
        b=uB0PU6lCMA9qgMFgiZxNS++ax3FoOwb5KCjSln+7jF0O2eDnlJTmSv6rg5Iow0IJZg
         PHttELLBwQYx1nErcEAuN8h3qWwMNdknYPleGsFdX92mLaSIWwMHaKGPkg9v9cEyKYHm
         WfPsuvTIgQWY/J5PDnwyP+AqPB8wuybfKHnY2LUryr2YWn/VAw37jKX1jBFlQk0RUfo+
         I0fn0F34LclHMg2jeZ6yQ4eRP+riE/azc9xKJWNFKVc7FURIsPv07hTbdh60qvfic2Yy
         dNcBmGOK3EaMerq9nCul6uPwSZsAKMKEBfv2K25+gwjZ6HrxRUIuOkw/+Ltpj9fyron3
         d9dA==
X-Forwarded-Encrypted: i=1; AJvYcCW00iJYV21GsxDBCgR3VpbqLEMVq22GmBUBv85AxZCsk8X5A37oa2rAZCPTuDkDlGiPXz4IdF8R@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3/9egWdFuBcoYKFVuZuHtUJROSbZIuPL6p0yQQETdWlq+dK1m
	BUE+V7U49p/cEmLpsEE1RfS+NyB4iNQFsR6sSndDb3gejSo2e2SIDBODtiXOJA==
X-Google-Smtp-Source: AGHT+IEaIjOXJB2yE/W35POgXD3EuAW0kPMpCHoWUGBmkepeG6G3MXmQqRVk4uCXHnBJiCwDIEDNuA==
X-Received: by 2002:a05:622a:1a1e:b0:453:74cc:ce09 with SMTP id d75a77b69052e-4604bba3098mr21032511cf.8.1728616089705;
        Thu, 10 Oct 2024 20:08:09 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4604287df18sm11432531cf.78.2024.10.10.20.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 20:08:09 -0700 (PDT)
Date: Thu, 10 Oct 2024 23:08:08 -0400
Message-ID: <4e2669fc0be9b0f1ca15b17ca415a87d@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net
Subject: Re: [PATCH v4 4/13] Audit: maintain an lsm_prop in audit_context
References: <20241009173222.12219-5-casey@schaufler-ca.com>
In-Reply-To: <20241009173222.12219-5-casey@schaufler-ca.com>

On Oct  9, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace the secid value stored in struct audit_context with a struct
> lsm_prop. Change the code that uses this value to accommodate the
> change. security_audit_rule_match() expects a lsm_prop, so existing
> scaffolding can be removed. A call to security_secid_to_secctx()
> is changed to security_lsmprop_to_secctx().  The call to
> security_ipc_getsecid() is scaffolded.
> 
> A new function lsmprop_is_set() is introduced to identify whether
> an lsm_prop contains a non-zero value.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h | 24 ++++++++++++++++++++++++
>  kernel/audit.h           |  3 ++-
>  kernel/auditsc.c         | 19 ++++++++-----------
>  3 files changed, 34 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index f1c68e38b15d..5652baa4ca3c 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -291,6 +291,19 @@ static inline const char *kernel_load_data_id_str(enum kernel_load_data_id id)
>  
>  #ifdef CONFIG_SECURITY
>  
> +/**
> + * lsmprop_is_set - report if there is a value in the lsm_prop
> + * @prop: Pointer to the exported LSM data
> + *
> + * Returns true if there is a value set, false otherwise
> + */
> +static inline bool lsm_prop_is_set(struct lsm_prop *prop)
> +{
> +	const struct lsm_prop empty = {};
> +
> +	return !!memcmp(prop, &empty, sizeof(*prop));
> +}
> +
>  int call_blocking_lsm_notifier(enum lsm_event event, void *data);
>  int register_blocking_lsm_notifier(struct notifier_block *nb);
>  int unregister_blocking_lsm_notifier(struct notifier_block *nb);
> @@ -552,6 +565,17 @@ int security_bdev_setintegrity(struct block_device *bdev,
>  			       size_t size);
>  #else /* CONFIG_SECURITY */
>  
> +/**
> + * lsmprop_is_set - report if there is a value in the lsm_prop
> + * @prop: Pointer to the exported LSM data
> + *
> + * Returns true if there is a value set, false otherwise
> + */
> +static inline bool lsm_prop_is_set(struct lsm_prop *prop)
> +{
> +	return false;
> +}

If we're going to call this lsmprop_is_set() (see 5/13), we really should
name it that way to start in this patch.

Considering everything else in this patchset looks okay, if you want me
to fix this up during the merge let me know.

--
paul-moore.com
