Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6861D31A0
	for <selinux@vger.kernel.org>; Mon,  7 Oct 2024 20:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728333591; cv=none; b=mazZIrOFSwnDIKLDgz06PH9CpdNV3f9681R6zyLQ1ipqtmWFl7J6X1ITjAGZMmaxLo3UrBkF7wmu2AdOJgBkQccOA/vzdLtwcaaV1wTwRFuhqarJdVObR0RCdCP6e6pb1no92UBjAiTsw7bjHlojRcHHuulPooULe8a7uGXMon8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728333591; c=relaxed/simple;
	bh=8j5DRmf3x0m7/p9oBAZK35vWfc1EJR29Hnlm6j9P2f0=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=BVU1psMdVf8sNoNXpJ01bdjWmlzhrEYLXC39aod5CP6OmTS/qSd9vZcrfo8wfZrZ1mYxHAJx/hqOfCiZyxe/MUYp97VickQ74auGgf58v5JkuEJINGdtLNulhFWl2H8Tcjb+4PuNFaagDQLKRJPxiY6Sy5rYhc7JXpKl9ij4VL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YvsagtwD; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YvsagtwD"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4581ec0e00eso36442491cf.3
        for <selinux@vger.kernel.org>; Mon, 07 Oct 2024 13:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728333588; x=1728938388; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zYCaTiO/50aIS7OuFdT9odRtyvbapJLnXozqsV1uEQc=;
        b=YvsagtwDaSqE2HNmtnz+nCGkPZjy5Em5r7HgYAz/J0rcHj5p1Aq9mX5N3Wg/xTWZ2r
         +JLzyboTdCitcQhNr+vZuelX6KHLK5Fpuvjy3dw7ivmQXF4WRTWNNNUNvXy/ZDjGMzK7
         o4uQh5gtHpZEoqoHj2t4ndylbx7drT0RgK6C1x0WtJgm0/2yMbz62ETojaUVP6bzobPU
         i+luV8yqNsz2LCoi1REZI6SYYj6Y9u4T0ViQdW5+68dyANBVtaS823og6x8RVQNutj9T
         8RCnpLhlzfGN9rKWBuiLua6v/yvit8cCDPlB3+jH5BBxrEHxCq58j0VuyCrklfqDB3/q
         Ixtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728333588; x=1728938388;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zYCaTiO/50aIS7OuFdT9odRtyvbapJLnXozqsV1uEQc=;
        b=g9a1L23x9N648O7hZFefjifXndHKtFAGU8lIkBLm1lH8A9R2wP5TnjxWq+bmApzt2j
         EBTYiOMzPWO1Yqq7XNC8kaR137EttNLnxSD1ZtlFs/sgHIY71/fc/Kj1GW49On2L8QZS
         KG0zV0n8Y7DGrtbCStUsRxqBciI54oJ4STw49dnt/yxKtSS5Gnf115CERZYQVnR1esHc
         CBf5nn4TK007ZLFdLZsOQXtk4GdW85nT2jgHkDvyVd41Wr0Dao5x0Tvqx1mt00m7qs23
         kKpRe/F10cMG9SzDHHExkQI6B2/Dt6WqEB/Z8KtWFAW6344vkhd7X1QrW4PdazoUd5bB
         7qQA==
X-Forwarded-Encrypted: i=1; AJvYcCVIHRMdB3p+tD90P+s30cQ6nhG7jymzHlWdRdGjSV9ZadoHWTxvtTDXg1iCrVHGgLUICcWD7qA6@vger.kernel.org
X-Gm-Message-State: AOJu0YyCXMbZLX4Qw2jLz1LovLQG3v8aGauiuMxGeYNoylKDMGc3nU9C
	90nfi1kfySp/fRnATuiWaD8lw0ul+wurDIWCVnh1xRz/CPLQQRMlVE42NSqaeYRREXH43RRcf9c
	=
X-Google-Smtp-Source: AGHT+IGcnLDkQbNkG30AqmDhWh5cwyBnDEzhb86LjlLvh8EchZRaN+PJG7BZuuAkelmUYQGdE/9vlw==
X-Received: by 2002:ac8:7f8a:0:b0:458:4fe5:b307 with SMTP id d75a77b69052e-45d9ba27ef0mr176017141cf.10.1728333588607;
        Mon, 07 Oct 2024 13:39:48 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae75761ee1sm289951685a.99.2024.10.07.13.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 13:39:48 -0700 (PDT)
Date: Mon, 07 Oct 2024 16:39:47 -0400
Message-ID: <e0e248fb03ce2e03b332c06d6f377715@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnace@redhat.com, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v2] selinux: Deprecate /sys/fs/selinux/user
References: <20241004172709.25165-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20241004172709.25165-1-stephen.smalley.work@gmail.com>

On Oct  4, 2024 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> The only known user of this interface was libselinux and its
> internal usage of this interface for get_ordered_context_list(3)
> was removed in Feb 2020, with a deprecation warning added to
> security_compute_user(3) at the same time. Add a deprecation
> warning to the kernel and schedule it for final removal in 2025.
> 
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 switches to pr_warn_ratelimited().
> 
>  Documentation/ABI/obsolete/sysfs-selinux-user | 12 ++++++++++++
>  security/selinux/selinuxfs.c                  |  4 ++++
>  2 files changed, 16 insertions(+)
>  create mode 100644 Documentation/ABI/obsolete/sysfs-selinux-user

Merged into selinux/dev, thanks!

--
paul-moore.com
