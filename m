Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17892147E6
	for <selinux@vger.kernel.org>; Tue,  2 Sep 2025 18:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756836512; cv=none; b=PKMMlg172ZPVVfQVGUVTORbyVRn2RtuOP7F9U+wsZ9v1DKMXZ80382NhQJlI4FIb6p3xpDMqOb0wn3ZZQA5R2QUGyZo//yeu/bNTytwlDXKvPaj/VE8A2EVSENGGxeG3M2doJEqcDAZe26N1s3jeohrf8UchKkOAkTNGqhVad3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756836512; c=relaxed/simple;
	bh=LCkuQxw0O3LJLI2guRNlZla2Yw4xfKlsjGN1RmPH258=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZdZmZIJNapbZlgRJXaQAqusg/fDKhzpJvJoxlNgHj2l8NfwPCsGoY/5dP3wSDjWRBmvs7u3E6fLI86kBswoZZTf6Woqmvq/JJDms6qvWvbbsBtu8hKZHNn/zg28kniVJ7Q6vbD571V2tUdBwrTWE9B2ShD6IzFiwCXrNC6aPdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=k/9F/gp/; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="k/9F/gp/"
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 45FDD3F52D
	for <selinux@vger.kernel.org>; Tue,  2 Sep 2025 18:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1756836508;
	bh=3TBrtHuk0TY7zWp/lt3fO0m6u8z48b4sX1HaKeehm08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=k/9F/gp/Gq4GnNbbiphpN/ymcYEMZB7QZEZFyFWdyFRAHoHQJo3g1DOPcE72apRfm
	 pAR8pioWc9QFJYZ9jIKa2j53CLgK/y3kidDf5g/uup3po6+scgs3NHMVoPd9N3h/bQ
	 oxUS9+j1gEAodB/QTRistxu3+VCkf/i1AseUjISmmyvjnoq2RluAXWf6OQA2hnXEKk
	 l7/MavWNZHta8iDDORe9f/mFAP+4jPXG8HMpXa1Xm8ZZYLo+E0JIcMQPFdaZQb7hmg
	 lorh0Cp4UuZSkrXddoRdQv0L/5pHpd6jYkV7NCk9AJTtaKrEhdzl/DccKvxxFmdFyP
	 LM9gE0meuyJGA==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-329dca88b5aso151569a91.1
        for <selinux@vger.kernel.org>; Tue, 02 Sep 2025 11:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756836507; x=1757441307;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TBrtHuk0TY7zWp/lt3fO0m6u8z48b4sX1HaKeehm08=;
        b=Ouybe0D5sSz0geJTDaDhgrHyMaU1LjWAk40PcMtXQOxpBiMDuGWBbSQjccHBZF/J1G
         fO0LUamhTk84eZ2FXlQRBBeRXDJOOOxlauFc6fW+xTRH3Oa7VoMXGSI/jZ+93/WFIgSv
         Bs0ezMPx1n6udT7XMoATM9I3Q5qZaOaNc0BHyX6C6AaHQos94iF36TbmBJ+z3+AtD1uG
         o6pzMObcbnqzZjhdivBtOZLhjXbbhI1OgwWxi3m36WahlysVBBda25XY8bjH7iqjWkVP
         IHiXWW+WskJRLKGKOhZ10y9wzZTFIo8CogCUKyiWcpx14wfRrhuL9xOhsZ6NQjoDt4X5
         YCbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXX6mHT4nPlsASgYuceQ/kFoJF42Q+lsdXo8ly8ZoaKZ2dlZi6smCtUUQGEg8DnlIuUN4Dtghfw@vger.kernel.org
X-Gm-Message-State: AOJu0YxB3NYB2v+jdSAavHMbZVMcUmNv/1OS2bH6RX9dL5yohGBvVjh5
	wFPiB+I2yS7UxPHVy516JTV8qojwXz63KeB7x+VXovjBT39vb0UbdZrTUsIyY/7aBkz3V2czKFd
	GqXY2+G8Zy9wPFcVaUrTHDHWzBzpuFaz5FEiamq6N2WTUYMCS3MbUSNNYhzWeditWn2qyV7E4Be
	A=
X-Gm-Gg: ASbGncuO+/kbVfEMWgQ1RiGVG7EerGk71LCaNDtZzSZuZskPq6jtL2RPU81jRCMADVm
	6MOaA6KUuppe5qnqIZ17i+g+JKdItuhx3nwMdRU/eI0pdIvPfVhkr+Blu1dfM0NK5isvE28NCzJ
	WVw9w/a7+NWuo+zckqj8xOHrID+lBdTV1sewgS9HGhBZfIDtT1kRrFou5HqXURNg/f5n6L3XIk2
	jl698d5620M8v4sjCriLI+3llrCtlPQUDXPqeISuZYCxRZUkXjgq/QVyAZWDatPLWqane29utK1
	M5W1FH+JRMhkUn+O7VblKs7p+yK2ghjnyPhS4i+Iort1RaOx8Z9MpQ==
X-Received: by 2002:a17:90b:3fd0:b0:325:65e7:5cc with SMTP id 98e67ed59e1d1-3280d2b7e5amr16455626a91.3.1756836506726;
        Tue, 02 Sep 2025 11:08:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZWbNIFP4v9NbAzJrvljDCKooZ4KEL9SOU7q9aLjz3H+Px1iu0ovrnW5QS5kfSdAwicJ/aSQ==
X-Received: by 2002:a17:90b:3fd0:b0:325:65e7:5cc with SMTP id 98e67ed59e1d1-3280d2b7e5amr16455594a91.3.1756836506282;
        Tue, 02 Sep 2025 11:08:26 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-32745900a2dsm11284604a91.4.2025.09.02.11.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 11:08:25 -0700 (PDT)
Message-ID: <e99bdc14-8dcc-478c-85b8-a4f596dfaa0c@canonical.com>
Date: Tue, 2 Sep 2025 11:08:24 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 26/34] smack: move initcalls to the LSM framework
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
 <20250814225159.275901-62-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250814225159.275901-62-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 15:50, Paul Moore wrote:
> As the LSM framework only supports one LSM initcall callback for each
> initcall type, the init_smk_fs() and smack_nf_ip_init() functions were
> wrapped with a new function, smack_initcall() that is registered with
> the LSM framework.
> 
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/smack/smack.h           | 14 ++++++++++++++
>   security/smack/smack_lsm.c       |  9 +++++++++
>   security/smack/smack_netfilter.c |  4 +---
>   security/smack/smackfs.c         |  4 +---
>   4 files changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index bf6a6ed3946c..c56e1e876f7c 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -275,6 +275,20 @@ struct smk_audit_info {
>   #endif
>   };
>   
> +/*
> + * Initialization
> + */
> +#if defined(CONFIG_SECURITY_SMACK_NETFILTER)
> +int smack_nf_ip_init(void);
> +#else
> +static inline int smack_nf_ip_init(void)
> +{
> +	return 0;
> +}
> +#endif
> +int init_smk_fs(void);
> +int smack_initcall(void);
> +
>   /*
>    * These functions are in smack_access.c
>    */
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index e09490c75f59..f14d536c516b 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -5270,6 +5270,14 @@ static __init int smack_init(void)
>   	return 0;
>   }
>   
> +int __init smack_initcall(void)
> +{
> +	int rc_fs = init_smk_fs();
> +	int rc_nf = smack_nf_ip_init();
> +
> +	return rc_fs ? rc_fs : rc_nf;
> +}
> +
>   /*
>    * Smack requires early initialization in order to label
>    * all processes and objects when they are created.
> @@ -5279,4 +5287,5 @@ DEFINE_LSM(smack) = {
>   	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
>   	.blobs = &smack_blob_sizes,
>   	.init = smack_init,
> +	.initcall_device = smack_initcall,
>   };
> diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
> index 8fd747b3653a..17ba578b1308 100644
> --- a/security/smack/smack_netfilter.c
> +++ b/security/smack/smack_netfilter.c
> @@ -68,7 +68,7 @@ static struct pernet_operations smack_net_ops = {
>   	.exit = smack_nf_unregister,
>   };
>   
> -static int __init smack_nf_ip_init(void)
> +int __init smack_nf_ip_init(void)
>   {
>   	if (smack_enabled == 0)
>   		return 0;
> @@ -76,5 +76,3 @@ static int __init smack_nf_ip_init(void)
>   	printk(KERN_DEBUG "Smack: Registering netfilter hooks\n");
>   	return register_pernet_subsys(&smack_net_ops);
>   }
> -
> -__initcall(smack_nf_ip_init);
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index b1e5e62f5cbd..405ace6db109 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -2978,7 +2978,7 @@ static struct vfsmount *smackfs_mount;
>    * Returns true if we were not chosen on boot or if
>    * we were chosen and filesystem registration succeeded.
>    */
> -static int __init init_smk_fs(void)
> +int __init init_smk_fs(void)
>   {
>   	int err;
>   	int rc;
> @@ -3021,5 +3021,3 @@ static int __init init_smk_fs(void)
>   
>   	return err;
>   }
> -
> -__initcall(init_smk_fs);

