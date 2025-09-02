Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFC82E4241
	for <selinux@vger.kernel.org>; Tue,  2 Sep 2025 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832032; cv=none; b=TOl0PpwdLKRQubjZQm3SCVdxZUmrflv8myc2I8rD12RQjEv98mbFxL1QwIA3xYyZ3VgXX9e94SP0NCkZRprakmAYRjDHzIC5iVaQoZ/YZpLsBh2tHtDq2oEIwr4qDwO+7QELid5ZZxTgJ3wQ9m7wjbVwIxOSgBXBb9Iooi75mY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832032; c=relaxed/simple;
	bh=30XQ6tkc1YhEQ6UZWGp9RGftrfvqpn/DxIVuoenzK38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cje9a9QGE0VfJjoHpjoWrBmmnd/VsNp7mafQtKlyb+BERPLZbxEE4Mqy/u7b8oWH10jqd0LvS5ue6btRJa6fwIVtq07gBeUsaCWosKcy/nTveZJ4EJkGApMo6WrDM8kUPm2wpWRFIpZHuwEJ+G0pNYTLW5oqQi5Il0CUhzTJbx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=vlXaI+pB; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="vlXaI+pB"
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A28CB3F52A
	for <selinux@vger.kernel.org>; Tue,  2 Sep 2025 16:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1756832028;
	bh=T+7jN7cEM1G09nGFPNHBEb1kKweKEUGK2LzUhIAIkyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=vlXaI+pB5ZzCfvW+VwQyUW4baLko5r7jVqj/AkhnC5z4XYUVPzCk/jBZ1kOJOXy6D
	 lfTd8cn36KJqNWNpRLQjLLOe8Y3z1xKCOJRZB04oUIqqoieeo/Jr0nMRQOMYWWiMGH
	 DBRc7mJbeP2GEEOA+u0YzwvhxtvoxGoMYNNqLDagkpAQ1diDs9tKzxx3tCDsitgcpa
	 gxDNnBEdsgPDzIE0e22KzQiuSUsXAjAfqadX/S18fsezqg6JoMTowL4hBusDxPcJXm
	 5FqUpdyt5Cs9o8tjnXbiV4K3Yn8c+LyLyonQsLD7XCSzZgmVZ+TeX3yRtZfBZy7+wj
	 dS/+u2YVbzFBQ==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-244570600a1so804125ad.1
        for <selinux@vger.kernel.org>; Tue, 02 Sep 2025 09:53:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756832027; x=1757436827;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+7jN7cEM1G09nGFPNHBEb1kKweKEUGK2LzUhIAIkyQ=;
        b=ptTR9IPfwCQPQsH95FMoTIkuCbQ6abLiH90P5p7hpIwQqtsGGEawFPZ3kjhpYyLAlt
         BxhIxRj30A20DKnbI/b31j8UvdMaZUwJHH+QJbzj1cz6HZB8tHF8Thvg+9MjzQ+ITzHp
         bik01u4zpRiU9z5NC8KYGEiLw3GQLSyrlJ3kTCE/YITWNfnE82r0wkD2MIWaLsgXOw+V
         gsR3gU76xMVt0WWRGiE7dn5+IpZwQ4+ZGq/izSXjwlGECtcf0s5iNjrlJ3k2NtvAaO05
         TpjGvQPYRiVuQoe+v47zaP1bm+ruLJPhpY1GIBeqc+3hoG8qlmPiID009yhdp/7fA3aD
         xqqg==
X-Forwarded-Encrypted: i=1; AJvYcCUy3Qw+p40FB/0mURrpxtW21uu5XL40k1HJagThtvuAcDXMpMyZOMHUUHVgr8RKf9OiDjHFptne@vger.kernel.org
X-Gm-Message-State: AOJu0YwhcSYemjWYOnzhJrpY1aXkZewRBKciBknu9nEupqhpOPD03g89
	Bc5HHfHYg4t9zTIR7vqEwdPkWZ6BtNFb76wEQSftkIaZySbXphkAh4YIgj3lTBq0hlTutOHxaiS
	N4homUsWZz+jKOyzLeu7Hd8PgSmrdp/O2gvwhOiE28rZ9lIrPYIgbK5SIRj4srDjZLblpls3e67
	E=
X-Gm-Gg: ASbGncsOMv8JKfnYrXiQQ7dfNi+Oe2l3QPWS8LKH659pIc7rA/uPQOZDnGoL5up1cjb
	HtrfyWjR8uIYBC4Ao3hR00SZDygQcA793e+q3tYvfBxMhWDdnQEW4U1rftrYRL30NZ91Roe/ybY
	NxjxqjGI6dmcg+5J/4Y6WbL9vDLJ5ui/EBRy1fKEioH7VwlrpT/y0mAcLqkHq8XGb6iBGesWgRn
	2ncYAeASio29gGY9dfzmKbn+uYipJkQxpbTTWsjTjti4tcDTXe7JjYoWeaX1H9Xn1S2e2IljOes
	7i/qIrKp/yId0CI42aEBTyBwEh35kcoRhcQxCSliJtAqHKK8XFX/gw==
X-Received: by 2002:a17:902:c945:b0:24a:b06e:f814 with SMTP id d9443c01a7336-24ab06efee6mr112020215ad.12.1756832027116;
        Tue, 02 Sep 2025 09:53:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJRhxCp5UPNj8Y+BWmMbFgfZTYKNYOe1kOAFS3XfBptXI28wng/yTH0b8iccEaONmGWl4Ytg==
X-Received: by 2002:a17:902:c945:b0:24a:b06e:f814 with SMTP id d9443c01a7336-24ab06efee6mr112019895ad.12.1756832026696;
        Tue, 02 Sep 2025 09:53:46 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-249037022d9sm138103805ad.23.2025.09.02.09.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 09:53:46 -0700 (PDT)
Message-ID: <e1e26c8b-5f8e-42ce-9044-59c57032ee5a@canonical.com>
Date: Tue, 2 Sep 2025 09:53:45 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/34] lsm: integrate report_lsm_order() code into
 caller
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
 <20250814225159.275901-41-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250814225159.275901-41-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 15:50, Paul Moore wrote:
> With only one caller of report_lsm_order(), insert the function's code
> directly into the caller and ger rid of report_lsm_order().
> 
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>


Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/lsm_init.c | 33 ++++++++++++---------------------
>   1 file changed, 12 insertions(+), 21 deletions(-)
> 
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 18828a65c364..09afa7ad719e 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -291,26 +291,6 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>   	kfree(sep);
>   }
>   
> -static void __init report_lsm_order(void)
> -{
> -	struct lsm_info **lsm, *early;
> -	int first = 0;
> -
> -	pr_info("initializing lsm=");
> -
> -	/* Report each enabled LSM name, comma separated. */
> -	lsm_early_for_each_raw(early) {
> -		if (is_enabled(early))
> -			pr_cont("%s%s", first++ == 0 ? "" : ",", early->name);
> -	}
> -	lsm_order_for_each(lsm) {
> -		if (is_enabled(*lsm))
> -			pr_cont("%s%s", first++ == 0 ? "" : ",", (*lsm)->name);
> -	}
> -
> -	pr_cont("\n");
> -}
> -
>   /**
>    * lsm_early_cred - during initialization allocate a composite cred blob
>    * @cred: the cred that needs a blob
> @@ -341,7 +321,9 @@ static void __init lsm_early_task(struct task_struct *task)
>   
>   static void __init ordered_lsm_init(void)
>   {
> +	unsigned int first = 0;
>   	struct lsm_info **lsm;
> +	struct lsm_info *early;
>   
>   	if (chosen_lsm_order) {
>   		if (chosen_major_lsm) {
> @@ -357,7 +339,16 @@ static void __init ordered_lsm_init(void)
>   		lsm_prepare(*lsm);
>   	}
>   
> -	report_lsm_order();
> +	pr_info("initializing lsm=");
> +	lsm_early_for_each_raw(early) {
> +		if (is_enabled(early))
> +			pr_cont("%s%s", first++ == 0 ? "" : ",", early->name);
> +	}
> +	lsm_order_for_each(lsm) {
> +		if (is_enabled(*lsm))
> +			pr_cont("%s%s", first++ == 0 ? "" : ",", (*lsm)->name);
> +	}
> +	pr_cont("\n");
>   
>   	init_debug("cred blob size       = %d\n", blob_sizes.lbs_cred);
>   	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);

