Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F3C231A3B
	for <selinux@vger.kernel.org>; Wed,  6 Aug 2025 22:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754517979; cv=none; b=hBuvNxHNj0KFtNZY/0jNUM+N2v/1xvm1iYdzzht5laxlQESAixkkn2hqMBJAxYaAcKyr/aa5i72ddTIH1fJgUSOE9cyoS1paSN5Tp85xxfPZ6iV0KI7d7DRxXxloqUBj0xJyqY/fYnAr9mC7X+EXkYmopTnL6FcN+lyffPo614o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754517979; c=relaxed/simple;
	bh=1+1mh2UTW8nha3AlApBzYw9ktnvsRC6MZw3w/Q+Tgrw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=HxQmdxoAlYwFY+84HxMqtHvgU4lHr2Lmidb6Q2eRoCeM2P5BCW5V73D9/iJbp1z+K2qAwNJl13sQygDpZJyq+ozupndLaYvh3G49tJZgjpbNzr+yQm9aKiRSxLyObENtWD4FyNi3T/QZ49IZJPHDkgodrgxgdWXcxj/A4Zi3g8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UN2lAX0J; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UN2lAX0J"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e7f940a386so24705985a.3
        for <selinux@vger.kernel.org>; Wed, 06 Aug 2025 15:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754517975; x=1755122775; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DqrwiDX753cPr23iwZVrIBxXM8laVdcIlzxoK8+/Djg=;
        b=UN2lAX0JPKYfTsmw6yYvEazlw1xr0dfkYp7DzLKdCpwg8mN+u9KBbeo/cUBoOHbttS
         iJrnGu56gwMS3zn/S5/SMt0GuOoBvJ/h+GeBZtxc7YJUJUxqmoyvcRZv2YnIqSN5Qiv5
         n/PDUmkOCzbs+VVWeSYuM3/2J/vJPbzW//hw/m3nmpG0w/WHLBTYKKIA1jheBm27jy/T
         2wpFlWRb9eTKUZlvMhgat+VIy+EOsoXdeq7z/H2ZG/0mdQQu14uZ8+OugY0UpmzDkz+4
         lDlbxMU1J+zbX2+NnF8DmIioyS7gam9PNkc+p23jI1KvZNqq0rAdKBJj9/R/qs+BFPi4
         NiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754517975; x=1755122775;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DqrwiDX753cPr23iwZVrIBxXM8laVdcIlzxoK8+/Djg=;
        b=VOxodbWpFCL7nO32C8oAmBFCM86F4Qd36l+EMlIq89vBbXMCrOYiX1gnhh9Uuq69VH
         IRz1odSTkQQefDJ8OMBi9MBA2PMew6CTELlfym9aGAoGQnUv+4Gj+KoeI62MV5Y4Pnl4
         Y7HFKkLLF/A+ufKxWAiDAN+BHLwJ17FueaNQyg+wNxX4cHlX/Vdhy26uowDxJjsN4/sS
         au4HznsQQ4lDHHXxSp73WrTrz/zW9uiG4K0ULUsvL1GLTBGIl4x/3lJ2DJrdG/c6Goo7
         zbKI9cK76Bkvyu6VEx3kNZc8vgyptyjOPrfRfIonseLgiTnRZv+ddLocOvfxpwuqQaUU
         lvgw==
X-Forwarded-Encrypted: i=1; AJvYcCWqj2UkfuqT/afJ/cUF4Nd2Nt2ZJvFBk1lJoAE18tIhlhHJwYR/Cl/JG+yKhnEFIxoQ05GjrSLG@vger.kernel.org
X-Gm-Message-State: AOJu0YzWOygjRBPIH33A6nhLvN8lr/2WdRiXbTg/XIt6Rgist/ETfd6u
	/I82ihac7VOTVd84HcE0u2bJlwAurcA1gzvHkAP7h5IpGeSjrirU3QAGtwvJvu+fQg==
X-Gm-Gg: ASbGncuDr6USZtfWN1KoAlFqVrrYpLPJirnlreXsSeIJMlmMbDMivRK+5JZi8yFbpyT
	0cHPurfu759s4z1MoB3YI+sVjI70aHu6ysrfi0gQ8xP/0KraQqM/qOZPmOs2szuuVYoIagtqlTV
	3dHBNwo0jILBemlbQhOFW7cBdm+c9Z8NHTLeNOSFmp+t3IZs+hxkqwaG48QBQeGumQ9VNWA0Er9
	YVpmTndkvHPnIPMhQK+gyH9hRY1QBGINYBrbmjgaPFqbiZN1Vocp8Aa1UfX/csSU0gBS2oeeBzS
	FD2SToCiWuOpkJDsZvHhAAcMjzAaYnMQ/LvUEDbAJZfUD2AucWwffq0SGDwU03TwHIl8tme93p7
	IhsTXC7UcF8AINYVa8nhFGeRdvwwTBBgiBj1SDZJughBEUOWmk2jMenCyfp4EcWtQGen3qHa1Z2
	ZG6w==
X-Google-Smtp-Source: AGHT+IEQrlAQNLT9WdO6VwMIGCaqXQxPGX0ewn8Cl64BGagN9wv8L/9CzddXItLjrvM+oRV/1M94xQ==
X-Received: by 2002:a05:620a:2a0b:b0:7e8:1853:a40f with SMTP id af79cd13be357-7e81853a9eemr473495785a.58.1754517975107;
        Wed, 06 Aug 2025 15:06:15 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e67f594353sm856626185a.17.2025.08.06.15.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 15:06:13 -0700 (PDT)
Date: Wed, 06 Aug 2025 18:06:13 -0400
Message-ID: <f7e03785a79a0ac8f034cd38e263b84f@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250806_1659/pstg-lib:20250806_1657/pstg-pwork:20250806_1659
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 2/3] LSM: allocate mnt_opts blobs instead of module  specific data
References: <20250617210105.17479-3-casey@schaufler-ca.com>
In-Reply-To: <20250617210105.17479-3-casey@schaufler-ca.com>

On Jun 17, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace allocations of LSM specific mount data with the
> shared mnt_opts blob.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h  |  1 +
>  security/security.c        | 12 ++++++++++++
>  security/selinux/hooks.c   | 10 +++++++---
>  security/smack/smack_lsm.c |  4 ++--
>  4 files changed, 22 insertions(+), 5 deletions(-)

...

> diff --git a/security/security.c b/security/security.c
> index 8a4e0f70e49d..ec61fb7e6492 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -904,6 +904,18 @@ void security_sb_free(struct super_block *sb)
>  	sb->s_security = NULL;
>  }
>  
> +/**
> + * lsm_mnt_opts_alloc - allocate a mnt_opts blob
> + * @priority: memory allocation priority
> + *
> + * Returns a newly allocated mnt_opts blob or NULL if
> + * memory isn't available.
> + */
> +void *lsm_mnt_opts_alloc(gfp_t priority)
> +{
> +	return kzalloc(blob_sizes.lbs_mnt_opts, priority);
> +}

It's probably better to use lsm_blob_alloc() here so we have some
allocator consistency.

Also, make this private/static as we should just handle the blob
allocation in the LSM framework (see below) just like everything else,
unless you can explain why the mount options need to be handled
differently?

>  /**
>   * security_free_mnt_opts() - Free memory associated with mount options
>   * @mnt_opts: LSM processed mount options
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 88cd1d56081a..f7eda0cce68f 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2808,7 +2808,7 @@ static int selinux_fs_context_submount(struct fs_context *fc,
>  	if (!(sbsec->flags & (FSCONTEXT_MNT|CONTEXT_MNT|DEFCONTEXT_MNT)))
>  		return 0;
>  
> -	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
> +	opts = lsm_mnt_opts_alloc(GFP_KERNEL);

See above.

>  	if (!opts)
>  		return -ENOMEM;
>  
> @@ -2830,8 +2830,12 @@ static int selinux_fs_context_dup(struct fs_context *fc,
>  	if (!src)
>  		return 0;
>  
> -	fc->security = kmemdup(src, sizeof(*src), GFP_KERNEL);
> -	return fc->security ? 0 : -ENOMEM;
> +	fc->security = lsm_mnt_opts_alloc(GFP_KERNEL);
> +	if (!fc->security)
> +		return -ENOMEM;

Another case where we should do the allocation in the LSM framework.

> +	memcpy(fc->security, src, sizeof(*src));
> +	return 0;
>  }
>  
>  static const struct fs_parameter_spec selinux_fs_parameters[] = {
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 44bd92410425..1d456df40096 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -622,7 +622,7 @@ static int smack_fs_context_submount(struct fs_context *fc,
>  	struct smack_mnt_opts *ctx;
>  	struct inode_smack *isp;
>  
> -	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	ctx = lsm_mnt_opts_alloc(GFP_KERNEL);
>  	if (!ctx)
>  		return -ENOMEM;
>  	fc->security = ctx;
> @@ -673,7 +673,7 @@ static int smack_fs_context_dup(struct fs_context *fc,
>  	if (!src)
>  		return 0;
>  
> -	fc->security = kzalloc(sizeof(struct smack_mnt_opts), GFP_KERNEL);
> +	fc->security = lsm_mnt_opts_alloc(GFP_KERNEL);
>  	if (!fc->security)
>  		return -ENOMEM;

Same thing in Smack.

--
paul-moore.com
