Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DAA1FF7D7
	for <selinux@vger.kernel.org>; Tue,  2 Sep 2025 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832520; cv=none; b=pLSIBHP7p+dDfZt2GakW4s4CQaWSi0kOAlYSa2/0n0NVE5nLStHJqT4Hdx7wZW2wbQkeaytlqNOqjVncQNOSZcGkpOM9kBKwqPL9IzRpJRqw4Rl0I3UYiiSRf+3DISbZRJY5AESF6yPMsW6Ujly2o/3QyK2H4S+8GHhiEzzV8Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832520; c=relaxed/simple;
	bh=NwIWKNw/5jiBCx2CrkiO2hhg6NJ4TT4b8fQoW/ybtAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=swySWqjKhQp47QwJl4741eP15AwJLfUQ4OgdBgPkeVGGYrR5XPD6b4Gv8jEnBFNeqNifOe1mbS32AXpBDWqsRESX5skyuO7x3Dnpys7m9E6UsqiUZYr/Am6itpxH1WmSaQOPPwPE/I47x4iE52iixdW/1AesYCLJTV/8bs93g9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=WUaBGuvk; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="WUaBGuvk"
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8AA7D3F291
	for <selinux@vger.kernel.org>; Tue,  2 Sep 2025 17:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1756832516;
	bh=2F4UbyQVUATe6BQ0le4XbS3c98G+ZeBrhSOCYXPNPF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=WUaBGuvkHKi8OYRZE1cilK40zMeJZazsSBNm6iQXO6OXRSKR+/8m9xUogvxoTfA+l
	 Fj5D8uEfUH3pa/ErnHw78RzBCGOfnZsVhpB/jzoxxrZCanwUafWH9FfvqM4jx03MsW
	 kJfJM3y6kXJHtpUv5zgrv4F1krXPQ4iUAJUiK6g60jZDTsLHSacbcmGvEq5RFaoNmX
	 7/3Je912RNyhbO4fEAaqJBtUVXGN3Ugr9SjhGwLyWg8ow843KOpKaHRLjGzuOH2vrO
	 VTa6erfsIxDwmE1EMx1kwRQRZ0qeDh9CLx8K3qUbzNN+CiMzE+4kjcFdkHbv0PzOvg
	 IdCPNsphxNdxw==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-244582bc5e4so69023115ad.2
        for <selinux@vger.kernel.org>; Tue, 02 Sep 2025 10:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756832515; x=1757437315;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2F4UbyQVUATe6BQ0le4XbS3c98G+ZeBrhSOCYXPNPF4=;
        b=TC/3kGBkyMxaCGxCjDbaQZr1bl+p165Lc8VdeNZuEWfUEWkN+vo+Sf6BH/Vf+VmYET
         gVHKH7BoZiSgvMhofb4AWRUZK1H+A7Pz3PfYByCPtqdFJpN78VHNWmVEHLGz4NmeUWTa
         pc0c35BOH+JCUfMsalFelBZb/S+PG4468ro5aCt0/AspxpVsWAYS6JjsMxEnSOcMQsgU
         LxMSEQ/iDt2SaohdHwe6rw9V6DreWHyXruXi+4455wvPGVWGa0uae4zdROI1O3qN9W1I
         oJafwChXBGB1Z35gQ+yiEXCukgAxifV6jqbI2B+NPDmiZlvFb/hPj/ohjviDvg8YH+Q1
         T9vg==
X-Forwarded-Encrypted: i=1; AJvYcCUs558tkRtQlLiXIKW8r7BWBdwY/qMUvO2NUYi4DKDRf/PAtpBM6U0PIBLzKm5E3QxHUYrEPrKp@vger.kernel.org
X-Gm-Message-State: AOJu0YynKyzR5M/huCtoPAaB0GcTLJoQk0b3pxst7fGHgTeZkpRI+TW2
	1ojiufZV3+ZD+J3/S3cccAgtyH3OdfT0yRwV6ILgGs6N2zR/AT1m1YSgWtEII8EvabnSSozIGSE
	gMB7UB6p5SENyICKS/Eoh3BuT+/8lMUydXrNo5CHLwPSI0YsKisC/WkP14ZTjkBgSkhjMxFkVK5
	8=
X-Gm-Gg: ASbGncvDcnDPlxkxHyG81ohDHXAwOozNcM0i7YZgWN/2Dzu3Gj5/K88stqknNdvB6ao
	q+FYTWhn4xX4dmtfgyecuxjsdRx55qJb0BGWvmvTiPjmpV7hggUw7L8U8BXxb5V1GW4WAqrSUGl
	89fveI6wuVP4Z4pubplHdTdhA8O28YpgiuQHn9JR65nlZ+muAs41HfFaF3AXnQUhe7yfK51Q3TK
	Uc1apYZRV1dPSFUyeNwgrZMYENeyZd81Ie16NkN7DVlWxOmggH42IGt+isoOym9MDTe4UDdaE9F
	gaN5yWb+TpOlBS8YS6wFBOjDE9SdUtEFTylizG2skiTCWYNJXzEnkw==
X-Received: by 2002:a17:903:1af0:b0:248:a26f:e25 with SMTP id d9443c01a7336-24944afad40mr158929225ad.52.1756832514921;
        Tue, 02 Sep 2025 10:01:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcqd3PvE4AFoctKfcg1Dv6U2QwThYCZAupMtA3lBkx++RkqMdMPa0xV/kPgmZqKNwsipnYZw==
X-Received: by 2002:a17:903:1af0:b0:248:a26f:e25 with SMTP id d9443c01a7336-24944afad40mr158928605ad.52.1756832514356;
        Tue, 02 Sep 2025 10:01:54 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-24903705b91sm138298065ad.12.2025.09.02.10.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 10:01:53 -0700 (PDT)
Message-ID: <e3dc2b31-940b-4fa1-b868-91b36c0d0c57@canonical.com>
Date: Tue, 2 Sep 2025 10:01:51 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/34] lsm: rework lsm_active_cnt and lsm_idlist[]
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
 <20250814225159.275901-46-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250814225159.275901-46-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 15:50, Paul Moore wrote:
> Move the LSM active count and lsm_id list declarations out of a header
> that is visible across the kernel and into a header that is limited to
> the LSM framework.  This not only helps keep the include/linux headers
> smaller and cleaner, it helps prevent misuse of these variables.
> 
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   include/linux/security.h | 2 --
>   security/lsm.h           | 5 +++++
>   security/lsm_init.c      | 6 ------
>   security/lsm_syscalls.c  | 2 ++
>   security/security.c      | 3 +++
>   5 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 521bcb5b9717..8560c50edd2e 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -167,8 +167,6 @@ struct lsm_prop {
>   };
>   
>   extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
> -extern u32 lsm_active_cnt;
> -extern const struct lsm_id *lsm_idlist[];
>   
>   /* These functions are in security/commoncap.c */
>   extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
> diff --git a/security/lsm.h b/security/lsm.h
> index 0e1731bad4a7..dbe755c45e57 100644
> --- a/security/lsm.h
> +++ b/security/lsm.h
> @@ -7,6 +7,11 @@
>   #define _LSM_H_
>   
>   #include <linux/lsm_hooks.h>
> +#include <linux/lsm_count.h>
> +
> +/* List of configured LSMs */
> +extern unsigned int lsm_active_cnt;
> +extern const struct lsm_id *lsm_idlist[];
>   
>   /* LSM blob configuration */
>   extern struct lsm_blob_sizes blob_sizes;
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 2e76cefb1585..9e495a36a332 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -217,12 +217,6 @@ static void __init initialize_lsm(struct lsm_info *lsm)
>   	}
>   }
>   
> -/*
> - * Current index to use while initializing the lsm id list.
> - */
> -u32 lsm_active_cnt __ro_after_init;
> -const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
> -
>   /* Populate ordered LSMs list from comma-separated LSM name list. */
>   static void __init ordered_lsm_parse(const char *order, const char *origin)
>   {
> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> index 8440948a690c..5648b1f0ce9c 100644
> --- a/security/lsm_syscalls.c
> +++ b/security/lsm_syscalls.c
> @@ -17,6 +17,8 @@
>   #include <linux/lsm_hooks.h>
>   #include <uapi/linux/lsm.h>
>   
> +#include "lsm.h"
> +
>   /**
>    * lsm_name_to_attr - map an LSM attribute name to its ID
>    * @name: name of the attribute
> diff --git a/security/security.c b/security/security.c
> index ff6da6735e2a..add46073af0c 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -73,6 +73,9 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
>   	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>   };
>   
> +unsigned int lsm_active_cnt __ro_after_init;
> +const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
> +
>   struct lsm_blob_sizes blob_sizes;
>   
>   struct kmem_cache *lsm_file_cache;

