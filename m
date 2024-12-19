Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0245222612
	for <selinux@vger.kernel.org>; Thu, 19 Dec 2024 20:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734641146; cv=none; b=tkPSPl0pLzW4QEQHkTHxliDviAiorPab2ifhDcEnUvaaMtPXIa6K+sMNx6og/bbzi6BPJY8UhOKOYLSNLZjQtYc8RI0ZLE7jMZha2TBI3Hu8L3zxhpN54+0osx2wL4tcZtj7O2NCLuHAKAai0a7YH1PUcdKXwWoOsYEgLwxPjxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734641146; c=relaxed/simple;
	bh=EXHvnoGK4LzozmsS1APMYygdmEh4PtL1Gw6DZu1bVxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jY5eBxWIdJAqLKEbdH3AIXVvrWLy4ZhiIkREDx83zYXfoX+DUzfb6oMcm8h6txDgxus62EuuV5GZOTOM++CJezuBD/CnImez1P255I4799vWdWYawMRLEUNvP26Qh2R92w3iit6ziYnGKIfGvG8EcZov2++mNv7OpXlV+HwTetc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=herbTaDF; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="herbTaDF"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a9628d20f0so8149275ab.2
        for <selinux@vger.kernel.org>; Thu, 19 Dec 2024 12:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734641143; x=1735245943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wRdYDdHbyZXzcPCpB7wABkwUTOuxolmnucq278Cp6Tc=;
        b=herbTaDFSF+fLrp05YktrbfUY99QMKq8ATHfKlZqAq9rNjJC6BuvR9+L1FOH8l0nX9
         z8CiZ7DHm4LFa1zTg2fUicA2f95uM9Pv72Tryk5Zn8BNAKyAe1sjtfOzlNOGh8bsrc77
         uDC7Rf5Mkm6ms5EM9lAL801GogxvJslyw12f3cr1VZjvHteMZhyIvpa1i5B12AuL19Ok
         9lbnT/GgMZOjJnffCpiP30vcfD0hG81C1BWFxZCXmaKWSXzjYrsX8cDexB6/BSssFy5t
         GxC8dnyn2B+bSoGOlEN+f5q9tJVqQDn/l8PGOPRJv7IEqH5hZaIzsafLk4Dz30DClD6r
         dE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734641143; x=1735245943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wRdYDdHbyZXzcPCpB7wABkwUTOuxolmnucq278Cp6Tc=;
        b=XpnUcdysmqecF6rUhbZrHP2cqirzaPGkH0zKQHX4JWM+EwSlV2zbvbPWgg7D/VRbc0
         gUZzdBM96OGe3Gn8r3D0WwoTrDIVLmeJGBnGxmpwU7XIFj6CQjeu1+ez/N9TF3iCfIdi
         wHF6neiOc/j6Q+VWYUTvSV6jdDkXf7VvsF6eWXzHWCjRxyntbIzRcjGuVFVOHS7Jlybw
         cxpXUqoICqaHdmwHzILlaCXOeDATMurEHrlZAghYnrYWphhv1pDft4lTnPU37xXS6BZ+
         xZJECV6o0u5+3384q+7CK7Zgwlb3z6gjYsJW13gUsMiz1KM+K3hDCCcPaXBOybozrlLb
         Zq8A==
X-Forwarded-Encrypted: i=1; AJvYcCUdbxjDeeEErp00Q/hWXgUkIzcRSD/+9U921OnHFnkPk5wGY06vzsw/SRmLHAh0YpPF6Z2QeF4n@vger.kernel.org
X-Gm-Message-State: AOJu0YxQfqcQqOGJEL0zag4r69sGaCxvNoDKxPcpI69q6Tc0R2bmVgRC
	nwMJvzgZWmyJBMEqDkMauEpON/X8ThrIZ/v8DGex27A+w90Nz45cpH50pH3bJjk=
X-Gm-Gg: ASbGncu/PIWCl5AFJ1rP8+hd4dB5TLMHA6ktgDCmI4sWE31+v2vzo8a36piy4hwfAEF
	BEUd6wPSpFIzDJb1O1kLvf9xoj1Z3YxRl2aurfqJu94ebe7shiAv1q8B5PSO4laYMHZ4pHg+416
	fPN2ZVm0CrvqYSFom9q2jp8OdvivaDRlJVQPTuIMIqXh+Ol6+dJuXYkyoPm5Cgz2mR76FHEV9h/
	TWTYWmnQAMuwtIw2coANtG/wIjktmnT5c4wPQ6OJGLywBFSAhEs
X-Google-Smtp-Source: AGHT+IFxSutrUvWsiAV11hP3721+cW/ZW7QVXOWP5b/gzeaAb8Kzg89614qhyJXX7v9wmOje6hR6ow==
X-Received: by 2002:a05:6e02:19cc:b0:3a7:6e97:9877 with SMTP id e9e14a558f8ab-3c2d5a27dd7mr5124115ab.24.1734641143213;
        Thu, 19 Dec 2024 12:45:43 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf7ed01sm457933173.66.2024.12.19.12.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 12:45:42 -0800 (PST)
Message-ID: <f72a3036-fe4f-4a94-963a-b994d946d5af@kernel.dk>
Date: Thu, 19 Dec 2024 13:45:41 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm,io_uring: add LSM hooks for io_uring_setup()
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
 linux-security-module@vger.kernel.org, io-uring@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Pavel Begunkov
 <asml.silence@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?=
 <tweek@google.com>, Masahiro Yamada <masahiroy@kernel.org>,
 =?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>,
 linux-kernel@vger.kernel.org, selinux@vger.kernel.org
References: <20241219204143.74736-1-hamzamahfooz@linux.microsoft.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241219204143.74736-1-hamzamahfooz@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/24 1:41 PM, Hamza Mahfooz wrote:
> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> index 06ff41484e29..0922bb0724c0 100644
> --- a/io_uring/io_uring.c
> +++ b/io_uring/io_uring.c
> @@ -3806,29 +3806,36 @@ static long io_uring_setup(u32 entries, struct io_uring_params __user *params)
>  	return io_uring_create(entries, &p, params);
>  }
>  
> -static inline bool io_uring_allowed(void)
> +static inline int io_uring_allowed(void)
>  {
>  	int disabled = READ_ONCE(sysctl_io_uring_disabled);
>  	kgid_t io_uring_group;
>  
>  	if (disabled == 2)
> -		return false;
> +		return -EPERM;
>  
>  	if (disabled == 0 || capable(CAP_SYS_ADMIN))
> -		return true;
> +		goto allowed_lsm;
>  
>  	io_uring_group = make_kgid(&init_user_ns, sysctl_io_uring_group);
>  	if (!gid_valid(io_uring_group))
> -		return false;
> +		return -EPERM;
> +
> +	if (!in_group_p(io_uring_group))
> +		return -EPERM;
>  
> -	return in_group_p(io_uring_group);
> +allowed_lsm:
> +	return security_uring_allowed();
>  }
>  
>  SYSCALL_DEFINE2(io_uring_setup, u32, entries,
>  		struct io_uring_params __user *, params)
>  {
> -	if (!io_uring_allowed())
> -		return -EPERM;
> +	int ret;
> +
> +	ret = io_uring_allowed();
> +	if (ret)
> +		return ret;
>  
>  	return io_uring_setup(entries, params);
>  }

Please do a prep patch that makes io_uring_allowed() return the actual
error rather than true/false, then the rest of your patch can stand
alone.

-- 
Jens Axboe
