Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC7C3469E4
	for <selinux@vger.kernel.org>; Tue,  2 Sep 2025 18:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756836553; cv=none; b=aBlwcTeDyTFgPs/tS6bsaXV3bVVgtp0V06x2/4qxQsqmSgUvLo078VmltV4CUDtxP+z9RdTHUfX+vOckXFhO5/s7Z+Gm4NprBwBSwzwGUmdn3o9gdZwO00bXSCKu+2GerEZlNzHTFqR6A9m3HFJynUFjRAUsEYkgv501tGSEBhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756836553; c=relaxed/simple;
	bh=p6CVWu6DNUAbPiauCgm5nLeQC5frLxwLDGRHHz8QAF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LW2tVJt6G/B2OeEPpIevbwjEDhIilYwJjhVWlp1avSHR8OOaRUQetfYEoLioIt04KenZMGCIKMaY6Rr4IksbgKfTRhVeMtwMwdvNcPZW1z28GBX1CKab4nMwP4lSG9flLD2rHyag+g4YLkArat3VgUtfZrMQV8D86LfQEpvPE60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=uDrNFqQt; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="uDrNFqQt"
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E2FE23F078
	for <selinux@vger.kernel.org>; Tue,  2 Sep 2025 18:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1756836550;
	bh=gut242FNzqQvCbcBa+2mDwx9DOvk43Mv7SLcnnjnX18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=uDrNFqQt2t/XMPdAJwdIFDGvE2xjXGZkceUNeqqVbGANPBwp0YDKtlids61k0w/yj
	 QTKsXeFRL3FXntN5CP+O6procL4FWMgcLwM/wtlHckABDJf8VHJymuGJggl5kQHm9R
	 zdXsgHxjJzzTIH+lO7VhscqYAPbFbbz+HgUs1Em7xYvJ9bVQqpJk8FGmuLO3SBZDOf
	 tLz0loy0dUm7rDGMxLVTkLC4H3zm69iXoVqqk+Y6nwhaGl8WZywLkFlq/fABVzQ9wZ
	 LfAbuLXHs+b0SsdvjcRutj096H9nCMzafT4tJRLEGrRNOgHgLD64HWrOb7dMPNv7m4
	 DY04o7Zj309fQ==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-329e55e686dso1175202a91.3
        for <selinux@vger.kernel.org>; Tue, 02 Sep 2025 11:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756836549; x=1757441349;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gut242FNzqQvCbcBa+2mDwx9DOvk43Mv7SLcnnjnX18=;
        b=ghUOD49e7IFJ8LYVLbYysefwehLVDatVWsLcB7/LXWto1YtY7eNLGzahJl63bYZHKg
         W3F4MNNpA/r/6hxKNbBr0LU30QbgWYJ+YaqrQNSOUIsVC8g+j52G1sbapZpgD34vDBVM
         9wprwxR471pagiimDT6VyWosnsfiRxPlZQaDyaCtfEOK1ZzXZLOY3hXWpryKcferBljU
         9yRO4OTJeaVjPctP0LHhFirhw2OWg9Ly9MQxhn3NeKYKP8gE7EazZGYgzEbVISNMcGqT
         XDiVt4pe3Q6Ne5CLjCwIpt7shyQZ0jNpYIEN4w++fyAN1W9QPWUN9KgbSRXQLvMTWf5J
         Ks6A==
X-Forwarded-Encrypted: i=1; AJvYcCVtpTEoyZ7srnOneaxRmn3hpwVrSWoeNcIw96Vxv7zHaMveR7LLy9iK04L5QXhstIehHvCOR+cm@vger.kernel.org
X-Gm-Message-State: AOJu0YwwTFhq2sBgyxqTKiFej++fsNNuPnysOot8y+izIJ7MpWgEf9cN
	osz2cjTqn8SKZITZK0l/hYk29HcSzYIa56qIkl9iFO895n3QG54JdKMjORPkJIPaEWMC51z2Mcw
	7msJ2V7yCuK/pWfDyMNoOqmqg+4W3ivhXuN8xR3fCieTyZsCtCb9IL68CpKdmrH1vAcuQSD+CmG
	0=
X-Gm-Gg: ASbGncvMJYn3/T9I3zh4mUiLl+NiNO83RLWnT3UFuDxpSrGO3OWgmFcy+XUjVbZ3vrZ
	ofWKxnNKxcF1YmvRjOsyJ8D77mR+C6ZlcX92pwqnCrZ0IDaBLioCW9cFt4QLVZptS5V0Pshh7dA
	FBdUf1LDlqAARQYklZB8zGzAKFd/Hvi3VOFW4PkaQUV4h5JX5E6ilHRe2kkmxC0W4jYxRClF5d6
	YOkAGYbl9xz+L3tNwHMQRpTXhq+M9UDGNwbfSGFCHedkRPjuBhc8dhtY0vPoNXKhOrVolhFf+0+
	QgrELqVovtHwM/3XZJWbedFzvhwtkjG9XOLPdv2P6w/PCqHAdsQeEw==
X-Received: by 2002:a17:90b:4f8c:b0:327:fd72:bd6a with SMTP id 98e67ed59e1d1-328156e2dd2mr14344777a91.29.1756836549492;
        Tue, 02 Sep 2025 11:09:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyPVnP+4wmsTAMgV3o6IqyTLkZ5QGrhqOcGlnnJB0mrKXgi5Dwl9XXonao20L1u55WhoIMLw==
X-Received: by 2002:a17:90b:4f8c:b0:327:fd72:bd6a with SMTP id 98e67ed59e1d1-328156e2dd2mr14344744a91.29.1756836548910;
        Tue, 02 Sep 2025 11:09:08 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3276fcd6232sm20459303a91.16.2025.09.02.11.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 11:09:08 -0700 (PDT)
Message-ID: <e97f2f08-7bf3-434b-a9b6-d2729161f738@canonical.com>
Date: Tue, 2 Sep 2025 11:09:07 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 27/34] tomoyo: move initcalls to the LSM framework
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
 <20250814225159.275901-63-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250814225159.275901-63-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 15:50, Paul Moore wrote:
> Reviewed-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/tomoyo/common.h        | 2 ++
>   security/tomoyo/securityfs_if.c | 4 +---
>   security/tomoyo/tomoyo.c        | 1 +
>   3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
> index 0e8e2e959aef..3b2a97d10a5d 100644
> --- a/security/tomoyo/common.h
> +++ b/security/tomoyo/common.h
> @@ -924,6 +924,8 @@ struct tomoyo_task {
>   
>   /********** Function prototypes. **********/
>   
> +int tomoyo_interface_init(void);
> +
>   bool tomoyo_address_matches_group(const bool is_ipv6, const __be32 *address,
>   				  const struct tomoyo_group *group);
>   bool tomoyo_compare_number_union(const unsigned long value,
> diff --git a/security/tomoyo/securityfs_if.c b/security/tomoyo/securityfs_if.c
> index 7e69747b2f77..33933645f5b9 100644
> --- a/security/tomoyo/securityfs_if.c
> +++ b/security/tomoyo/securityfs_if.c
> @@ -233,7 +233,7 @@ static void __init tomoyo_create_entry(const char *name, const umode_t mode,
>    *
>    * Returns 0.
>    */
> -static int __init tomoyo_interface_init(void)
> +int __init tomoyo_interface_init(void)
>   {
>   	struct tomoyo_domain_info *domain;
>   	struct dentry *tomoyo_dir;
> @@ -269,5 +269,3 @@ static int __init tomoyo_interface_init(void)
>   	tomoyo_load_builtin_policy();
>   	return 0;
>   }
> -
> -fs_initcall(tomoyo_interface_init);
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index ed0f7b052a85..a015cf0c4a00 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -617,4 +617,5 @@ DEFINE_LSM(tomoyo) = {
>   	.flags = LSM_FLAG_LEGACY_MAJOR,
>   	.blobs = &tomoyo_blob_sizes,
>   	.init = tomoyo_init,
> +	.initcall_fs = tomoyo_interface_init,
>   };

