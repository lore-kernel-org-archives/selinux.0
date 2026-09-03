Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBD93D0900
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 06:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788416156; cv=none; b=VTXBattdHn4eZ8mSBcGVGTuropB6u29JiFmRhALyP9aUtqKEU7nkA1G6YlsU4uelvL5tl+haFToubgJkIDwGX2iQiEeIQpS3F1+H+WP8nAEjgOMcHzTIe46zbc07S3ZdUnzl6yVvVMejrTTeG/zqjf1sOk/uLc1SAjcSWEUgnuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788416156; c=relaxed/simple;
	bh=wpl9wKkbJFGy3u71BuJLHaA4TN3RjLmyXn7wBnE/sZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tSs+RGGCduYU+CWw9ns89uLZAinHwLyO2yLjWM9DN01LLrCgyC0+6c13whZTWr2BPa89vlS+RxVVHRE6WGCgD4LzfpKfxEbyY2fkmfjxaFtdbbz5WJTXST6Nzh8/FB5bVyRKlCMuaTZhbcopLndZLi6pKRCQSVs+GGnsF9HcDq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=CWveD9Ei; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="CWveD9Ei"
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 17A513F8B2
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 06:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1788416151;
	bh=KUWZRyqFeEf4s3ueoyPuRgRthTlv7fXXCaa5u+oHG9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=CWveD9EiNBCrYyOTQYcrC4UhijWm+YW80NCPxVXFWm39SkItRMfgYMchzR/sELLjc
	 yKFSVq3XT7e36B+8MckbWqjKOIWskX0iFR4GXS/Xheql0qhqEUu1y1uK6E6DPaavP9
	 0OIe2Qs0Ffj32fdYs0e7jiaFM+IF/faPG+Ab/1yDMZSpXQJtHSDC3JKIcGlNtQ0Leg
	 Ujym704xWrKyIv1IjcbCxiJuHV73jIeyzW1yMBZE89gp92jWItXlscDshx+trA9ybr
	 X0nxzjv62AQkYVlE42eLtiUkDpIewBKqCmpNMhv4mQk7hX4eYpw/tGWTvplROwc831
	 HuLNW2Ntrp4UJT/UIVCj8lVYiLtyiRLEBEo1EOsLElfZlmuJQmUDqJX0vyywi3+717
	 vCXWf70VH+wUptCDxgfTwORZFHCaR1rXg2XevE/dgbG17HkkJBwx7gT4hzJkplajEx
	 ECmijjTsJRLsJsjAOvWktHk6Hk12Bol9Zsio7QNOIorsGw4kesfvvysw0iJBnsz0un
	 PtlSCSlh1R7v3GJRDQZnP4vVFfz3XXp/bm1/gsQSk+yIG3P5qy38dMyETk1uGVWEUt
	 bYworYPJMRrn1nb0HkAPC7jeKnpz/GHYQoekHrVLe4dsfEnaSe6HjDcxRVrIuzHfYD
	 htXKprw9MyofYCDrAOyaDDiM=
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1b8088203so2476598a12.3
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 23:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788416149; x=1789020949;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KUWZRyqFeEf4s3ueoyPuRgRthTlv7fXXCaa5u+oHG9Q=;
        b=mQqEqLsAz65f3DQksUUM4gSeGiObQMgUyqhByPc6LPX7ZL8jn299aOXoc8opo5jGei
         zPwA0sVNAEssd5HidOx+4wCiDBhUOTmu4HikDuyeezBFxIRnuVJN1j2gSfsVZ6vah8nY
         jPA/SFs0kqzGa34YKk6ttcD2FK/ynFI7Wu+CLwjGGL3yDd8RgbyK3drGGaUay2HtKckQ
         GIEltZ7wkjVOa22vTjIYipb6uACdK/330vJjxJ/Gylr0vKl6Vi+7gjdRy91PK9Yo9KX9
         iVeJyNbFltOXkb+gIx8CV+Cp/9ZaznRi81W4zX0PChaNvA7ENtEfXhbaP8pUSOK7cjus
         nkug==
X-Forwarded-Encrypted: i=1; AKwUvBwKzX2pWLmKQuCG+oNy0YE+0yn7Q1YoAskq42W+M9ahgYbpW3YE3y2V2zuo6TpybjYi3fDho+Kl@vger.kernel.org
X-Gm-Message-State: AFuF++n9MHig/L4Abbs41fDo6SF6WYb/+tqC7Cj5lZYHw8575+K3lDz4
	1Ff1YOHZaEyXG7nXxjGw2arqQj48ds/IeRt4uSiEWTUKb94L3A8JCN8MLulxzmDtR7lI2DNRHWt
	SjEdpx+1tdFF3QDjKCiwcAU9mc7/MOD/6ZH3wacIiiIZ9qZgzIB+loUpzEMNbrHb74yxOtvNMey
	Y=
X-Gm-Gg: AYBFou01JdV5VbIu1f/opqsxf5M9DJzwnUVNT//lPTi2sgQggxYn8Zch3mjFmlqsYHj
	cNwuImo7K+u5wp0uQV3GA+Js0XvUGeTD0SssUGadhN6S6q/0uDHPaozqXlmSwE4Zn4GN7Fyddnr
	Niym3w4UQ7OtYjRxwkBQVpWUZwZs/LdwF/ClHAr7r6uuIam2kiV79TL1vYkU99Yi55msyiZXo2Q
	n8uqVPTs9vi5Cptr4o0rYK8zLbBkJcWJ1MTr3fx0265zBvD6CeXp6B59RVReTg32i5nyeQ6I0NH
	NfM+Znv31fTVqKfnwmt/bsuYbM2YqKkLoSHw296vW8E5j/YlZMCvdEMZZoQB7HJy4AslVDCSHZ7
	UrV+w6iLuJy5J/ns=
X-Received: by 2002:a05:6a00:e08:b0:82f:2b0:2809 with SMTP id d2e1a72fcca58-85ed7158030mr14968914b3a.1.1788416149450;
        Wed, 02 Sep 2026 23:15:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:e08:b0:82f:2b0:2809 with SMTP id d2e1a72fcca58-85ed7158030mr14968878b3a.1.1788416149103;
        Wed, 02 Sep 2026 23:15:49 -0700 (PDT)
Received: from [192.168.192.72] ([50.47.147.90])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-85dc003a7d6sm2259856b3a.34.2026.09.02.23.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 23:15:48 -0700 (PDT)
Message-ID: <ac628baf-3c8d-4f8b-b410-0c10990bdd1d@canonical.com>
Date: Wed, 2 Sep 2026 23:15:47 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] Smack: hooks for secctx_to_lsmprop and
 update_lsmprop
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
 linux-security-module@vger.kernel.org, pablo@netfilter.org, fw@strlen.de,
 phil@nwl.cc
Cc: linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, jmorris@namei.org, serge@hallyn.com,
 keescook@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, selinux@vger.kernel.org
References: <20260902220150.18586-1-casey@schaufler-ca.com>
 <20260902220150.18586-6-casey@schaufler-ca.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20260902220150.18586-6-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/26 15:01, Casey Schaufler wrote:
> Implement these hooks.
> 
beyond the question from the previous patch, wanting more in the
description, and the quick double check question below.

This is looks right

> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   security/smack/smack_lsm.c | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index ff115068c5c0..fcfadd5d9994 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4909,6 +4909,37 @@ static int smack_lsmprop_to_secctx(struct lsm_prop *prop,
>   	return smack_to_secctx(prop->smack.skp, cp);
>   }
>   
> +/**
> + * smack_secctx_to_lsmprop - add the smack label to an lsmprop
> + * @secdata: smack label
> + * @seclen: how long label is
> + * @prop: where to put the result
> + *
> + * Exists for audit and networking code.
> + */
> +static int smack_secctx_to_lsmprop(const char *secdata, u32 seclen,
> +				   struct lsm_prop *prop)
> +{
> +	prop->smack.skp = smk_find_entry(secdata);

just double checking a null value here, looks to be okay, but just double
checking as I just did a quick skim of the code.


> +
> +	return 0;
> +}
> +
> +/**
> + * smack_update_lsmprop - set the smack label in an lsmprop
> + * @dest: destination properties
> + * @src: source properties
> + * @lsmid: which LSM is relevant.
> + *
> + * Set the Smack entry in the @dest if appropriate.
> + */
> +static void smack_update_lsmprop(struct lsm_prop *dest, struct lsm_prop *src,
> +				 int lsmid)
> +{
> +	if (lsmid == LSM_ID_SMACK || lsmid == LSM_ID_UNDEF)
> +		dest->smack.skp = src->smack.skp;
> +}
> +
>   /**
>    * smack_secctx_to_secid - return the secid for a smack label
>    * @secdata: smack label
> @@ -5269,6 +5300,8 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
>   	LSM_HOOK_INIT(secid_to_secctx, smack_secid_to_secctx),
>   	LSM_HOOK_INIT(lsmprop_to_secctx, smack_lsmprop_to_secctx),
>   	LSM_HOOK_INIT(secctx_to_secid, smack_secctx_to_secid),
> +	LSM_HOOK_INIT(secctx_to_lsmprop, smack_secctx_to_lsmprop),
> +	LSM_HOOK_INIT(update_lsmprop, smack_update_lsmprop),
>   	LSM_HOOK_INIT(inode_notifysecctx, smack_inode_notifysecctx),
>   	LSM_HOOK_INIT(inode_setsecctx, smack_inode_setsecctx),
>   	LSM_HOOK_INIT(inode_getsecctx, smack_inode_getsecctx),

