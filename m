Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639232EBDEA
	for <selinux@vger.kernel.org>; Wed,  3 Sep 2025 08:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889380; cv=none; b=M42m4L7+ChZcKyL8sqvgDQjs60kXShveJ2NyypagYFjnkD51YaqNzpGePk3A2GxhSq3kdJbOE/8jx/yJz7NUWCaCP2P6qoc+6VDVVXhuzQuQCH8zJrsrOc58rr1i7me3lDBUZ+0SxYulzdbiwxO2Vy6HrnMHhqIb7Bvqgnir5mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889380; c=relaxed/simple;
	bh=gnH3fp2wRxYJUQXuaIn6rCwe44XriHxBG5TJoIF4EQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uemyine0SiYYqiCzOs+3oe8NkBxa14G5YZJlO9a7a9wzPsdnko89bPF5HVK95UufJdMaSWuQ7wECIJS0KQvdKG2Nry4Rp3s+J3A0fxPB12i1L+/OsIARNExN5Rq8xaiGHUvBFizGGRzShIqILivT+T76UA4C9Civ/O9KWWNbWOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=rqCKdZAw; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="rqCKdZAw"
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 16D183F67E
	for <selinux@vger.kernel.org>; Wed,  3 Sep 2025 08:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1756889378;
	bh=GvF6W7qQl2KeCzW4pVON6GD0QXJ+Di6g1Uch/jB1tAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=rqCKdZAwdNdew9DFJepEiNFkk1Dpn7L3rGDLiOZYoikWv8hD9Df2GdsEj6PZgVs4I
	 xAOSrFsLSOOARgRrel1fYG9EO/60mCtOY4isDqQXFTen06t1TtF4PAGDmk51NP9CwO
	 T9SigpHh7aeXk3WEjb+fpPX9r007rEzfH3wMoCzhvKCIZSn1BKtbu3cpJ1bIyxXnQ6
	 n/qQLBKxitr4DiQQZeAmqdUV+QIIAu0x8KgFcrwj2PM4x1eagt4980zU47A+pgI6Fy
	 ih5ij8uOW7CTNGRda+r1shEwmnTqeRsFEObY0tPclYkTU8u5KVBSenJpv5Fza9nTNR
	 MaqnR8H8KFiwQ==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3278bb34a68so5833750a91.0
        for <selinux@vger.kernel.org>; Wed, 03 Sep 2025 01:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756889376; x=1757494176;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvF6W7qQl2KeCzW4pVON6GD0QXJ+Di6g1Uch/jB1tAo=;
        b=Yl0KKLnfmhsrrwIpkgIJu9PRPeV9ON6OyhAdanfGpNtdgbDZvU5CiRFJ42rRzg26D4
         AiDrm+SbISIQXrPYZ/Hu7NgpcAMG60qPqdPH4XOkCUAK3DCKizMtnoMKswwqS9RGbX33
         xa15iWQehh7OPuD2I++qSu6jGu1khEVxUZKg0m8nZXA4m9Grt/W4pWq0c6LXOVoq+9xQ
         0PR8JNJMaahc4QsIg7B5NiHue/IEvRETlH0LH29S1xqiuD8BNPx8FGLmEBIrunVjunXG
         5C8Gxqk8d01fj13C8efxIBcdoJNobu1WAmP8b7y6SXIEiiL/lLLgCpSK7s4+ZUx96RM1
         9YgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYIQNPT7dsYJFvH0kheZjfCWx/DVy3unF7voT1HsSu2tfsNmlzQ7lW5Tf6qWjSh7zOArQ/HdCs@vger.kernel.org
X-Gm-Message-State: AOJu0YwLH96byBoYKJUqBwNkkx/OEyHTuc3rgwAioy2tvkHyBILOqjSG
	6ijfne+20R7opGsJrMpA/D4NH9nx7x2oB82/3xgjMOJAj3+ROOjIGSD33LN5Fy997LpyvINOGhR
	apPWhUsRyrR1kTKek6s7e4jVDz9EFbzXopPyiPkU1sB0JtB4QOJSWuecY01CwxtjY/KqXxY1SqP
	U=
X-Gm-Gg: ASbGncsfLry/vbUEh6kqeP8pzzxpHoSW7+df6zFzHZQRR6vnf60ZcKs888WUTgJs125
	t0+my2vkzXW8nsTXJrtOE2mSmsqZ2fjbGdviTXG3xcybENNn3nSJwXwMiQgDp1fiT3FE8AruKWo
	itqYJnnvaycEmQynIfs3W0sE/T+payycIiWm6kyuWO9zrziAqpm3W5Q6278jeSoN86/FsNEbZ4n
	Hcu4z91csneoN6DFoyAfLVWa0z8DUmI32LYIZTvNfURbyic6klnUlV9B5LFCDGbnyHtIFxXGw7g
	rH2zLf2KA5qwmKyxZX+Gu0guV43hcyMLRevWN7qq9ffWgXBunteLPQ==
X-Received: by 2002:a17:90b:38c5:b0:327:c207:b3fb with SMTP id 98e67ed59e1d1-328156cc954mr17092861a91.25.1756889376230;
        Wed, 03 Sep 2025 01:49:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYj+FFd0wyzW1cRqd6nve5AQ/3cx07H8SkzipAJ7wMHb+/tWGv7dd7z6uG8ytH/+qNLV9HPg==
X-Received: by 2002:a17:90b:38c5:b0:327:c207:b3fb with SMTP id 98e67ed59e1d1-328156cc954mr17092832a91.25.1756889375842;
        Wed, 03 Sep 2025 01:49:35 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-329d08a36b3sm5701942a91.25.2025.09.03.01.49.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 01:49:35 -0700 (PDT)
Message-ID: <d099f11d-b34b-4491-bffe-f0e76b6b23a7@canonical.com>
Date: Wed, 3 Sep 2025 01:49:34 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/34] lsm: output available LSMs when debugging
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
 <20250814225159.275901-57-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250814225159.275901-57-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 15:50, Paul Moore wrote:
> This will display all of the LSMs built into the kernel, regardless
> of if they are enabled or not.
> 
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/lsm_init.c | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 2f7ae26fca0f..c6aea57a01e6 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -363,6 +363,8 @@ int __init early_security_init(void)
>   {
>   	struct lsm_info *lsm;
>   
> +	/* NOTE: lsm_pr_dbg() doesn't work here as lsm_debug is not yet set */
> +
>   	lsm_early_for_each_raw(lsm) {
>   		lsm_enabled_set(lsm, true);
>   		lsm_order_append(lsm, "early");
> @@ -385,9 +387,24 @@ int __init security_init(void)
>   	struct lsm_info **lsm;
>   
>   	if (lsm_debug) {
> -		lsm_pr("built-in LSM list: %s\n", lsm_order_builtin);
> +		struct lsm_info *i;
> +
> +		cnt = 0;
> +		lsm_pr("available LSMs: ");
> +		lsm_early_for_each_raw(i)
> +			lsm_pr_cont("%s%s(E)", (cnt++ ? "," : ""), i->id->name);
> +		lsm_for_each_raw(i)
> +			lsm_pr_cont("%s%s", (cnt++ ? "," : ""), i->id->name);
> +		lsm_pr_cont("\n");
> +
> +		lsm_pr("built-in LSM config: %s\n", lsm_order_builtin);
> +
>   		lsm_pr("legacy LSM parameter: %s\n", lsm_order_legacy);
>   		lsm_pr("boot LSM parameter: %s\n", lsm_order_cmdline);
> +
> +		/* see the note about lsm_pr_dbg() in early_security_init() */
> +		lsm_early_for_each_raw(i)
> +			lsm_pr("enabled LSM early:%s\n", i->id->name);
>   	}
>   
>   	if (lsm_order_cmdline) {

