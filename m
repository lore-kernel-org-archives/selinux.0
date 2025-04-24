Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E5A21B908
	for <selinux@vger.kernel.org>; Thu, 24 Apr 2025 22:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745533115; cv=none; b=cU/GVq25y/Ko1F/+xx7NHYyCw7vWCu1bCrnqbBvK9b7VqmVLG0O3A5jhzDQnFj7HTkhm04vFSPIIqf3ft0ayMlCDLlD9yetuOLmrGxbuTg5u0vyH7h5axjJoTsmrj3OI/wlAiAw0jdkJFr/LpwEw4qiXRuN/AbDO4Y5O9OtoxK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745533115; c=relaxed/simple;
	bh=w6LlIf28NyGBFtutNuc3GI4ql9DOzl5pnXCFXvIoaBo=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=atmciWhLGBgRC62j1gQE46W8YYoKLjB6rsL5oOFiixNo5jnA7XMsfbfXkyHQS02f4ts+n0oIw3iTadFojp3n3Q0koy1INd/oQNkf2zFdyTI1q0+bXlbYUAxm9l0WrWDOtOfP9X++euC1sBzU937aqYr9cyKuDPTaY4jfvHadRGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MBxCA2bI; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MBxCA2bI"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4769aef457bso22770761cf.2
        for <selinux@vger.kernel.org>; Thu, 24 Apr 2025 15:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745533112; x=1746137912; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cDD9yFwsvgkEFtZxZyeicpTkbPdB1oQ+j/wziWiSwI8=;
        b=MBxCA2bItPsPob9u0o8EBGhOsAhxlVxo+kz2s2V0nCXdfDARVjg9LRIDIyEKmNZt2y
         Wd9qCgezgSPWnSz6lKNsjMUGZR6AlS/3UAwInpNh4SznGocQ+Y8TS3ZjixUqhzVgoo6y
         9iqs5mze4I8Zx03UgLcLAksuWDuAcgXkv0H+McXjTqcj0hbtunwiziKa1SHuMPsx9OzR
         y/aJ/2mnaVnUjNZiZd22QiECQPGqN2+OfoZ1IaOBPQ3JMZrZrCKbxlIdq7zYdS/ssibD
         0rL0o8B60fzQrJMIUnPKsdWDJ+j+6edJ2nKhWBNfkODYhYUL8XxuRYWVBuSgs4s2RepI
         dlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745533112; x=1746137912;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cDD9yFwsvgkEFtZxZyeicpTkbPdB1oQ+j/wziWiSwI8=;
        b=P+6oZZYJLr91Nq5M6A8pqmbqm4T63d6oGQdQ3RsqREqZcpOpH6wkG/T2RY01MUtXtv
         JPbXb8LKjcrPODiJau4FwhPvFI3LmepHRZYvv26jtH32K9AvL5coAc2tPkehAPaflrNf
         5A6Lh9/cMuq/rjviWGYV4d4r9JlKJvqXzoWhtYSKR3K8JQuk6xtI52aJbleb/K8be8gt
         4xpsb7sOcAuuZ3aSGdjo7JlrnKSaFsL0fx0RWMLWeGFajlx37NTsgIELA+xZZXbGb2AL
         f71lph8Mx0xSF+syjcW18LSf+IDgJPs3C8tq7JN9A0wqvgrBnoPYNCTVvzMUu8Ma0zgi
         33GA==
X-Forwarded-Encrypted: i=1; AJvYcCXEIOBNFNprns7N+Eu8sGWA5+GTUqC5LEWbRvPgzxb6gRLFw41qurI0FgnmdU0RnKT0+ePgrzgj@vger.kernel.org
X-Gm-Message-State: AOJu0YwcUcU3cjaJnsGdtURsjTN6O7aT3ZuJmvrth7PsObnSwtp0/3uK
	Zmyt9vlTt0Fa5iNv12wbHHcUMbrCyBdFcx9YtYDMUWnzdmgfkGaNIjFgACukKw==
X-Gm-Gg: ASbGncu5UdAWBBXk/PDUOANT5nUKKdV0IDNStYrjiCRb8T0C1jyHnTVeTP7HrCw6uKv
	LxrAnwo622AiT5ztgpJa+5diu8H+DbT8fJ6eNfwI7yapiP3uiHd1xFGJgstE0o07tv4kumMLoEF
	7CKn7yKG+xn213lXLSDfIwHUVZRdUZxT1yGfDhn0O47pEMWvQ8Na+IN6ORKZl1aLdriUhhMnnh4
	BFy5WwV5XHsKzgYBqi8DO1nlYzkriGtKeDzVdsNRvFjVZd55QuKcHGBm0DA8NJ/zpZhWciAYpce
	5ncZQwiZxlXXxT+uyF3vHDc6tAX4ks2kEeG77IYxbKaeHOzKWAlgBXnQ6AZoVemtZynhQAUbUo/
	+pzwu35CsnQ==
X-Google-Smtp-Source: AGHT+IEHD12ufMOYwnkTSyFoER3memBLGPBgeX0kZrL8caC70GLQkKQCwxWZrvj3Wif6jPcsY3zXRg==
X-Received: by 2002:ac8:5911:0:b0:477:ea0:1b27 with SMTP id d75a77b69052e-4801d049f45mr1896491cf.26.1745533112047;
        Thu, 24 Apr 2025 15:18:32 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47ea2299710sm17345031cf.81.2025.04.24.15.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 15:18:31 -0700 (PDT)
Date: Thu, 24 Apr 2025 18:18:31 -0400
Message-ID: <b515a68481217f0dee0424464d56955a@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250424_1707/pstg-lib:20250424_1742/pstg-pwork:20250424_1707
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v3 2/5] LSM: security_lsmblob_to_secctx module selection
References: <20250319222744.17576-3-casey@schaufler-ca.com>
In-Reply-To: <20250319222744.17576-3-casey@schaufler-ca.com>

On Mar 19, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Add a parameter lsmid to security_lsmblob_to_secctx() to identify which
> of the security modules that may be active should provide the security
> context. If the value of lsmid is LSM_ID_UNDEF the first LSM providing
> a hook is used. security_secid_to_secctx() is unchanged, and will
> always report the first LSM providing a hook.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Tested-by: Fan Wu <wufan@kernel.org>
> ---
>  include/linux/security.h     |  6 ++++--
>  kernel/audit.c               |  4 ++--
>  kernel/auditsc.c             |  8 +++++---
>  net/netlabel/netlabel_user.c |  3 ++-
>  security/security.c          | 13 +++++++++++--
>  5 files changed, 24 insertions(+), 10 deletions(-)

...

> diff --git a/security/security.c b/security/security.c
> index 143561ebc3e8..55f9c7ad3f89 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4312,6 +4312,7 @@ EXPORT_SYMBOL(security_ismaclabel);
>   * security_secid_to_secctx() - Convert a secid to a secctx
>   * @secid: secid
>   * @cp: the LSM context
> + * @lsmid: which security module to report
>   *
>   * Convert secid to security context.  If @cp is NULL the length of the
>   * result will be returned, but no data will be returned.  This
> @@ -4338,9 +4339,17 @@ EXPORT_SYMBOL(security_secid_to_secctx);
>   *
>   * Return: Return length of data on success, error on failure.
>   */
> -int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp)
> +int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp,
> +			       int lsmid)
>  {
> -	return call_int_hook(lsmprop_to_secctx, prop, cp);
> +	struct lsm_static_call *scall;
> +
> +	lsm_for_each_hook(scall, lsmprop_to_secctx) {
> +		if (lsmid != 0 && lsmid != scall->hl->lsmid->id)
> +			continue;

As mentioned in the v2 review:

 "Let's use LSM_ID_UNDEF instead of 0 here to add some clarity on
  how an undefined ID is handled.  The function header comment
  should also explain the special handling when LSM_ID_UNDEF is
  specified."

https://lore.kernel.org/audit/5838489ecd5186900315f8f6c6e02f22@paul-moore.com/

> +		return scall->hl->hook.lsmprop_to_secctx(prop, cp);
> +	}
> +	return LSM_RET_DEFAULT(lsmprop_to_secctx);
>  }
>  EXPORT_SYMBOL(security_lsmprop_to_secctx);
>  
> -- 
> 2.47.0

--
paul-moore.com
