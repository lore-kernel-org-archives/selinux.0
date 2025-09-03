Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B872ECD37
	for <selinux@vger.kernel.org>; Wed,  3 Sep 2025 08:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888859; cv=none; b=bWq942vP8suEDORR5yc4AtdNQcDSDFOyvosn6V0Af0//qejUOOXBc8P61zxysWB6HjZSngpIeVHKbQMBiq0DGMaaN7msYqdWvExhVfQ3vjWhlS5CpHAPPlPr/ToZTP6Q+M3C8ttNmD9mLUM/D5jViS4TwmxjvezQJ96QZPKnRyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888859; c=relaxed/simple;
	bh=lZdJUZM4SYf2G0uAFaJks17zzrJdjcjx8J3mWKckKas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=obABUVBQlMNg/z7HYov0kmSxOQ7yJUy0gcArpO+WEFbzgNcXyaco+X39VrmPkuUfOSz2W6MgFLdTnA8HzZgf/nBS+C3OZo1z8jWYYbdQc8E+qpH7gqMU8bVjpvl0wl6xRx8PqMow9XIbtwzeGBQ+INW7tM9ZmF3FPqKlUUcHk3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=vzIFLuj5; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="vzIFLuj5"
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 668083F679
	for <selinux@vger.kernel.org>; Wed,  3 Sep 2025 08:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1756888855;
	bh=Jzi4I2Gx/T1OYLe9a5Qvk9pcPPJKirKtX/JuorRdRbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=vzIFLuj5UwoMAoAUu45ZfhzLpdUE2+BiS0EZunfL3CJaWmSk0B6SoV8AzoJGhROnF
	 2PbnkjdaI+5yE7NXFBGfcIx0Tk3UXAu8Z6jv5PpJTAfA/8NnQphjsjwfyxnZZpNwi3
	 h1GamCOflFKUwfI789lttUuXx65GY7hH2XwQBDpjEEB00dsHiP+3NRLvZzEiNnSmW2
	 07MHPxvd0uvPybFWC8DbjBKrshMmP9ivzj/YbyTDappOMJEbQdi1uKcldYzUslZK73
	 zVg4wky2Ko7HUlw59HHSJxJtmhytDHgJRWGMexjSK/NLMrUFdag9DB6tU8WM+2qD67
	 txVN4x0pUxklQ==
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7724046c346so3606027b3a.1
        for <selinux@vger.kernel.org>; Wed, 03 Sep 2025 01:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756888854; x=1757493654;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jzi4I2Gx/T1OYLe9a5Qvk9pcPPJKirKtX/JuorRdRbE=;
        b=P8Zwodk1rt2YaHMQ7VtCKpKzu2Bmu3fVeN91ICl+vlm8aOIfiPaX3ZcYghMeza9VRF
         5u2U33nU/o1oUXWYWVC0PVxCZhyQpuYgHBzUI+qtAE2SHKj02AwVfIJ4lM3yOa9vcgdv
         0BslXQkgE4Z/B4f1BHxBdbs5q4z32jrIJrazxNdvdwaivozeNQfuDzxBTx5pR2hcFycn
         pGMNq5FUjMsILnlJU4q1xXX9hnRU6jhkaeqSAm+ZfjicEnN+OGiQ5PimUTg12Gdm/Qb1
         yTowfVG5QBZENu9vp5L39vAj2shBn6et6H7SQcdaZOPFPBO5MjllaSHez+1BPU0SkXkK
         cFPA==
X-Forwarded-Encrypted: i=1; AJvYcCXi4c+3c2KUPoyUWPFAdV13Lc5PAnasHlMddn5yk84gC0MbEnzccuK9tDwJ9GNx1YdHEK16TMiy@vger.kernel.org
X-Gm-Message-State: AOJu0YypZkt9bwsrTbGPywI92DgvmW9SRuxnk7t6SdTZ63fLDEbSC2BD
	xIh1rQHD8ugRjGhhugzAAsQdEga/e8WvbmD+6dI4aOL96R03fXDFM9HONlBFceprazhlh0HtgKX
	m0pYrs0omyIB3C0mCIbwSW1vsZnK16gTWEhq8lSzkCTLvmxNLBdPDJxIDmiLAPTHqra8w3OCrgd
	E9V2lVIyYmoA==
X-Gm-Gg: ASbGncsrDj6t8FTGAmjDqtYXoiAHdihH1wG+0s3MDq6lKHiZWjq3QvHgtw+iMtIUrA8
	RUc8ajkhWpvQhgxxa/ZMJDmAz6D0Tu2/pE23EeurssfM908VG0IPoRzxWiytKrEn9ZeL+a25YIH
	M+CmNtOA3W7h/ybsT62B7kDD0JkgrT+mgmjov1rEEhjZq+QWN6875qCyzO3EC7UAiOjF4C435ve
	zlT9yhMfGbzfW0AOKD77WqBh+r2cvmLI+pfhsfZHMtraSTV7owYBAFeND5bF9WXJT7Ay7XQOfDX
	ed8ojlA+KIkf+WemLoVuHGAP5ABdNKHuW5qdLfiA3OFajAQPpOsZcQ==
X-Received: by 2002:a05:6a20:9146:b0:243:a373:a9f9 with SMTP id adf61e73a8af0-243d6f02e94mr21612030637.38.1756888853979;
        Wed, 03 Sep 2025 01:40:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8ulIBk3PR2CIgucMqN8+ivgz2lv4LI5tYTQmusPowPlM+HF3GtIPEIWw5Rut3dFB9Klbheg==
X-Received: by 2002:a05:6a20:9146:b0:243:a373:a9f9 with SMTP id adf61e73a8af0-243d6f02e94mr21612010637.38.1756888853527;
        Wed, 03 Sep 2025 01:40:53 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-77256a0f916sm9001146b3a.63.2025.09.03.01.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 01:40:52 -0700 (PDT)
Message-ID: <b51e4a38-31d4-443b-8f7d-744b8efc2fb8@canonical.com>
Date: Wed, 3 Sep 2025 01:40:51 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/34] lsm: rename/rework ordered_lsm_parse() to
 lsm_order_parse()
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
 <20250814225159.275901-51-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250814225159.275901-51-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 15:50, Paul Moore wrote:
> Rename ordered_lsm_parse() to lsm_order_parse() for the sake of
> consistency with the other LSM initialization routines, and also
> do some minor rework of the function.  Aside from some minor style
> decisions, the majority of the rework involved shuffling the order
> of the LSM_FLAG_LEGACY and LSM_ORDER_FIRST code so that the
> LSM_FLAG_LEGACY checks are handled first; it is important to note
> that this doesn't affect the order in which the LSMs are registered.
> 
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/lsm_init.c | 82 ++++++++++++++++++++-------------------------
>   1 file changed, 37 insertions(+), 45 deletions(-)
> 
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index a314484d7c2f..7b2491120fc8 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -228,83 +228,75 @@ static void __init initialize_lsm(struct lsm_info *lsm)
>   	}
>   }
>   
> -/* Populate ordered LSMs list from comma-separated LSM name list. */
> -static void __init ordered_lsm_parse(const char *order, const char *origin)
> +/**
> + * lsm_order_parse - Parse the comma delimited LSM list
> + * @list: LSM list
> + * @src: source of the list
> + */
> +static void __init lsm_order_parse(const char *list, const char *src)
>   {
>   	struct lsm_info *lsm;
>   	char *sep, *name, *next;
>   
> -	/* LSM_ORDER_FIRST is always first. */
> -	lsm_for_each_raw(lsm) {
> -		if (lsm->order == LSM_ORDER_FIRST)
> -			lsm_order_append(lsm, "  first");
> -	}
> -
> -	/* Process "security=", if given. */
> +	/* Handle any Legacy LSM exclusions if one was specified. */
>   	if (lsm_order_legacy) {
> -		struct lsm_info *major;
> -
>   		/*
> -		 * To match the original "security=" behavior, this
> -		 * explicitly does NOT fallback to another Legacy Major
> -		 * if the selected one was separately disabled: disable
> -		 * all non-matching Legacy Major LSMs.
> +		 * To match the original "security=" behavior, this explicitly
> +		 * does NOT fallback to another Legacy Major if the selected
> +		 * one was separately disabled: disable all non-matching
> +		 * Legacy Major LSMs.
>   		 */
> -		lsm_for_each_raw(major) {
> -			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
> -			    strcmp(major->id->name, lsm_order_legacy) != 0) {
> -				lsm_enabled_set(major, false);
> +		lsm_for_each_raw(lsm) {
> +			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) &&
> +			     strcmp(lsm->id->name, lsm_order_legacy)) {
> +				lsm_enabled_set(lsm, false);
>   				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
> -					   lsm_order_legacy, major->id->name);
> +					   lsm_order_legacy, lsm->id->name);
>   			}
>   		}
>   	}
>   
> -	sep = kstrdup(order, GFP_KERNEL);
> +	/* LSM_ORDER_FIRST */
> +	lsm_for_each_raw(lsm) {
> +		if (lsm->order == LSM_ORDER_FIRST)
> +			lsm_order_append(lsm, "first");
> +	}
> +
> +	/* Normal or "mutable" LSMs */
> +	sep = kstrdup(list, GFP_KERNEL);
>   	next = sep;
>   	/* Walk the list, looking for matching LSMs. */
>   	while ((name = strsep(&next, ",")) != NULL) {
> -		bool found = false;
> -
>   		lsm_for_each_raw(lsm) {
> -			if (strcmp(lsm->id->name, name) == 0) {
> -				if (lsm->order == LSM_ORDER_MUTABLE)
> -					lsm_order_append(lsm, origin);
> -				found = true;
> -			}
> +			if (!strcmp(lsm->id->name, name) &&
> +			    lsm->order == LSM_ORDER_MUTABLE)
> +				lsm_order_append(lsm, src);
>   		}
> -
> -		if (!found)
> -			init_debug("%s ignored: %s (not built into kernel)\n",
> -				   origin, name);
>   	}
> +	kfree(sep);
>   
> -	/* Process "security=", if given. */
> +	/* Legacy LSM if specified. */
>   	if (lsm_order_legacy) {
>   		lsm_for_each_raw(lsm) {
> -			if (lsm_order_exists(lsm))
> -				continue;
> -			if (strcmp(lsm->id->name, lsm_order_legacy) == 0)
> -				lsm_order_append(lsm, "security=");
> +			if (!strcmp(lsm->id->name, lsm_order_legacy))
> +				lsm_order_append(lsm, src);
>   		}
>   	}
>   
> -	/* LSM_ORDER_LAST is always last. */
> +	/* LSM_ORDER_LAST */
>   	lsm_for_each_raw(lsm) {
>   		if (lsm->order == LSM_ORDER_LAST)
> -			lsm_order_append(lsm, "   last");
> +			lsm_order_append(lsm, "last");
>   	}
>   
> -	/* Disable all LSMs not in the ordered list. */
> +	/* Disable all LSMs not previously enabled. */
>   	lsm_for_each_raw(lsm) {
>   		if (lsm_order_exists(lsm))
>   			continue;
>   		lsm_enabled_set(lsm, false);
>   		init_debug("%s skipped: %s (not in requested order)\n",
> -			   origin, lsm->id->name);
> +			   src, lsm->id->name);
>   	}
> -
> -	kfree(sep);
>   }
>   
>   /**
> @@ -322,9 +314,9 @@ static void __init lsm_init_ordered(void)
>   				lsm_order_legacy, lsm_order_cmdline);
>   			lsm_order_legacy = NULL;
>   		}
> -		ordered_lsm_parse(lsm_order_cmdline, "cmdline");
> +		lsm_order_parse(lsm_order_cmdline, "cmdline");
>   	} else
> -		ordered_lsm_parse(lsm_order_builtin, "builtin");
> +		lsm_order_parse(lsm_order_builtin, "builtin");
>   
>   	lsm_order_for_each(lsm) {
>   		lsm_prepare(*lsm);

