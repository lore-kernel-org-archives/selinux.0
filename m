Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266AB199252
	for <selinux@vger.kernel.org>; Tue,  2 Sep 2025 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756836764; cv=none; b=H5EvcCWE67sJE6zMwOT15QHGK48J+hr+U/ijWZ9ZSQ01L/JYj2TaP6gsi/fm0wGDEaNJ5Eu46VAdCQEIwqjU4obJLodlJsDDcRH19gAv0cQ+fedO2J9NHLI4glfjY412oFlhr+L5bvOniUylM5XhwWflarDQMdqsW7MghHZ2LCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756836764; c=relaxed/simple;
	bh=f7TN2CQmOnPT2S/vKWYBIFNSNrRP1xZMe31zy41NQ88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PS29ntFOvnOkSYUU9W7nSbZ1zN2RMBNLHF2DG34peQZzzWSVgmvj1c6GyYgE4K9BUxXFPva1ySrtS/ogqxcLicJX+yerH3gFHmcroztRRjIBQGs813jah95LRVSXOOz13KvMivA5h2ODGeEq//VE7Y/7/+FLhB88X0cmbmDwr5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=u9bv+Ob6; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="u9bv+Ob6"
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6C2A53F078
	for <selinux@vger.kernel.org>; Tue,  2 Sep 2025 18:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1756836761;
	bh=8OAG1bVjL9CPCRwt3wdW7B2gPYUDizNhwd31HwbHaV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=u9bv+Ob6UCpS1VUlRRAfUlwW+g15m6mi1CfsW9+7R5elxLl8n/Ap/2lRw0xjRtaE7
	 OTSOR81feDiDykswBLyDIX4BzAdVY5CzoF/+l7Fvfg3Q99Yyy6eSur2U6EwFTnGoI0
	 TyXnEC8iK0adjLie8GP7DxdsNzD78GwV17l+sV+abMQgkd7wMhIQr/utyVnjIFHQ0+
	 2OYxO+J4JQQjCgce6NSbm174cxTicQE6ozcSH8bcP8g8RdJABdGgI6wZGhqoggLhw7
	 l3eh7pDTL+9BBBehp/+XCFYJ4XrTD5PO+Teyl/KyYHfVlU6uM+1Y8bDjU8je1CpglS
	 g31HuoZxRg/lQ==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-248f7745075so84541935ad.3
        for <selinux@vger.kernel.org>; Tue, 02 Sep 2025 11:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756836760; x=1757441560;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OAG1bVjL9CPCRwt3wdW7B2gPYUDizNhwd31HwbHaV0=;
        b=iINvSMPa5uh87O7tkepcIjakV3yWHDfea47k/qyZte1UNw1+FDHzJmBMVmWYs+oFEk
         7pWzu+RkE3mEdYM5x1tDLgVzfN7ylmePeFhQxp5RF4cWOpQie7hYVtgCSThi5u3noiIy
         7juTbj1XbVhxLHA45S2uZCnSZTws2hY39mWTr2wXhv9Et7438Z6guHDtbm3Wl+EBKgmU
         3VD6QvqGP+MJ/nZGilHCYeYvmn9nF1+R9/NKKcFqapBDq5bDpYGktaYe8SGsds+xrUrR
         VXcK+zYCAYfsRGMkacE5gS2qpA+xfaMmpiRcl2Yx72FQjKkfsVhAMGfqQ1lkGH78aLA3
         pnyg==
X-Forwarded-Encrypted: i=1; AJvYcCWuTdwXkp9TcRfa/qiIJxOeBymfM3Zv/umYUysP7Y59AuILcGq9wwDnFL+APMtMwXM9aMK3mjM5@vger.kernel.org
X-Gm-Message-State: AOJu0YxuJNLFcusmei5ff7TtDv9ZkwDLazGL5y0GVDuNCIhAbYbXe94M
	umVqX5+JxzL25rOsE+4RZIqllZAAx2zsghYiC/1UUzHJdWYb/hBhO2eR5uxLsImsNz0Qld/i/NP
	G2pwfzLwUIvrTdaH+ePJzBQsqwr/44NJfRaCX0OsPaKuvOXwzOhKa5MiIVxgKx6NYYoXqy0VVNk
	4=
X-Gm-Gg: ASbGncsk4W4abGDsxdpqYJrMTT9hYf6IpcqeuleLU273eUmvpJqLzxDUd9Fsy32Tm9k
	TtvxwJQEti7Vyc5PRFF6Wa2q5lFmFkkqgCThBZDcRE4X1RF/crTcKskAVTOb93x9OSzVpBfD4Is
	fLIqisxmqECHoZC0a/q7giKKrwU65MfdWH77UXzEvejZXcRmo1drmyGBuvzZ20Fhlgqk7MPAz3c
	Lc1G4opgMAw0UDMjE1q1XtiRbiNx3/YrHmg/VRceG1MC1IpzTeVezx5f7YsGrg7rYibWBm3lX6A
	ed84TDwy6tzdeczYhyfDpRfnQUKtvGUxWsyGB/DqCVfU1dHxsnE3kA==
X-Received: by 2002:a17:902:f546:b0:24a:b0cf:5f97 with SMTP id d9443c01a7336-24ab0cf62acmr128840235ad.40.1756836760053;
        Tue, 02 Sep 2025 11:12:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6Z9QhsV1kVBWLUb6ZoH49fJe8Nd9tqX0yzW3Pc4kIIhcm2JnpybbkEkhFkr2ftwqOdAbiTA==
X-Received: by 2002:a17:902:f546:b0:24a:b0cf:5f97 with SMTP id d9443c01a7336-24ab0cf62acmr128839895ad.40.1756836759618;
        Tue, 02 Sep 2025 11:12:39 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-24906390b6bsm138497285ad.99.2025.09.02.11.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 11:12:39 -0700 (PDT)
Message-ID: <d2a5494c-bdf6-4fb6-9a03-9f46fab9ad81@canonical.com>
Date: Tue, 2 Sep 2025 11:12:38 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 30/34] lockdown: move initcalls to the LSM framework
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
 <20250814225159.275901-66-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250814225159.275901-66-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 15:50, Paul Moore wrote:
> Reviewed-by: Kees Cook <kees@kernel.org>
> Acked-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/lockdown/lockdown.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 4813f168ff93..8d46886d2cca 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -161,8 +161,6 @@ static int __init lockdown_secfs_init(void)
>   	return PTR_ERR_OR_ZERO(dentry);
>   }
>   
> -core_initcall(lockdown_secfs_init);
> -
>   #ifdef CONFIG_SECURITY_LOCKDOWN_LSM_EARLY
>   DEFINE_EARLY_LSM(lockdown) = {
>   #else
> @@ -170,4 +168,5 @@ DEFINE_LSM(lockdown) = {
>   #endif
>   	.id = &lockdown_lsmid,
>   	.init = lockdown_lsm_init,
> +	.initcall_core = lockdown_secfs_init,
>   };

