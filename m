Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04DE345753
	for <selinux@vger.kernel.org>; Tue,  2 Sep 2025 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756835418; cv=none; b=nrpYcDe44fO+9clxr4XHm6J2L/bXcLt6PQ/nG1K4dePendtj8UVLKcboLNX95OUeKqPzPbwU7ITol34DZJA4NjAJBQ/vu8vrVBQR0C8zNoU5fr5KHoO9DSuN/VY+8GrJzWEBC6bPhbL5BRWUJ7gpk6U5om4okq2QZ7WCWcHfaNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756835418; c=relaxed/simple;
	bh=3Fv2/ufI8jD64LFiiiXr2/Eg7U3G44CQj24F9Ui5UsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MD7GJgfwkLtaD49spY7KVLKehpylqZQCQTADcSkEF45edfS7wPt+oWDCeSQNnreJrwUdpHisJKQAnsa1a+I22PgZ77CKNOzeebKwE8hhFghiPO82FtTVRTdRKtE8DGUPiUOopjlWeCYpOGvFd1j2J846KhNQQ2tQX3HL3BAMrjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Z2WfQry5; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Z2WfQry5"
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CA24E3F2A9
	for <selinux@vger.kernel.org>; Tue,  2 Sep 2025 17:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1756835413;
	bh=iwmgmAj/BeE2RuRtMZKCssemPgG4PZtfQ6IHtBailGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=Z2WfQry5dThWkmUzfICSL9x56eKd2Eorxn5VftG7nDOWrp1+qOpdTKzrr8LW/U2w9
	 Ol6W+trxT01M/nVpLDCbziLxgW50ihCERik5RxJCKby9NYN3nV8sbBpA0vzORnA6Qz
	 O8E2l0sKU1Rp/jtr+U21Hn64lV4+B/P05fM3+bwZJ7TGUxmuIxhYvZFrcX9//Q+aQ5
	 hESlo8Rsf00ctXvkD9w+CYkJqhun4KYmc3lDZKF/aQ3CrxGjGdpEygNj0f8pN7Qvec
	 9YWc5DSdCjuY8vlyKwFe3az4Hxd8qtSiUi+NZx/RdhmZjLm0TEarj/Al0BDwg/pvGz
	 fMto+MI1fhgtg==
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b49da7c3ff6so3366580a12.0
        for <selinux@vger.kernel.org>; Tue, 02 Sep 2025 10:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756835412; x=1757440212;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwmgmAj/BeE2RuRtMZKCssemPgG4PZtfQ6IHtBailGM=;
        b=BGIU56snxF1RHQPmQziRiVqHvjclweQioLrr+gCtpiNP6MwfNULRDWPNoH7cdmc0x3
         Wh4ILcZSKuyw+C7d52EcAqu+sIOmYTZIb2SE/Pvq+a4CSIljoer9L5XcvSM6oDWTG3sy
         7HCQifHQ3PiibT+L+LWghB/exoXO+YPP9ZNVVsK3I7J4UjbqV+64Z+pZ2PnliiK1AksU
         eijxAwJaIIh8IpRGgB0KqZvxQ03LDg+HwVoxcG6/Ctr/1Zr/lq6UbDhlxi7xz4N+AIOg
         k3ayOjD+CWH18xRUdISeK/H7p0K95SgdluM/7tSiCUCIz9Hk/zOYSE4c5aeNW1YidvI0
         +8SA==
X-Forwarded-Encrypted: i=1; AJvYcCUGypbURHnDV/jsAXTffgZSfNSXywrdqMFyTyiWAOmsgltzyf9YMXVyclJicNdDWhUqtyOSiW0f@vger.kernel.org
X-Gm-Message-State: AOJu0YzDUT/RaEcIBU/wq7GKvPoYqSieo3DrvH3BSNraCOX/kmKHwT+M
	ih56u65xrDJcNwo2AwjbXX8uL4+Zh0esgZCsUF9QPGxMMGZqQzogZ3f0SPjBnXMc/+KN1mm7bkq
	oXczYPnvDCyf2+c7DJ+b+A0DOdU9E+fSuhRtCH1rqXO9nvyb05R95kMRqdmcfwCAI5TSQZuggqF
	I=
X-Gm-Gg: ASbGncse5IGJsFrO19bhV8AlLPMj1Y8hmDJ/69R/uqCjeeyM3TzIRQ56Wnk9HGqfu50
	r+F6KVwLcsV111AmX7WNraMik01uSof2dEs4q1oGlAf0DSOHyh40fx/eiikWN1hhSgdO1gmEwB4
	zd0yIEz1KSEJoDswpOEw6ROSw5z/KFumGxJkProEKdeg7zLayHhFd8DWDmH8rxUFMpxq+hDmhev
	bchL8AwzAazd8BhzvnmWPbngFmHboRWBziE9uivgzIGDOJH5gqsxvEADO58ccLfFtAeyVUb3g99
	AHIdwCfGmb99qlsagSt1UgcDXvvx0F26Vb+BUk71D+Y+cp1cKAuY+w==
X-Received: by 2002:a05:6a20:748c:b0:245:fdeb:d261 with SMTP id adf61e73a8af0-245fdebd578mr3388497637.54.1756835411689;
        Tue, 02 Sep 2025 10:50:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEteBjyJgXg/M0oTnGVsnzvByLgONeS7SioVUYoAi9FUokotGbiolqG4x7REqXP/mM8qQJN/w==
X-Received: by 2002:a05:6a20:748c:b0:245:fdeb:d261 with SMTP id adf61e73a8af0-245fdebd578mr3388466637.54.1756835411290;
        Tue, 02 Sep 2025 10:50:11 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7722a2d7c42sm14348033b3a.39.2025.09.02.10.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 10:50:10 -0700 (PDT)
Message-ID: <62165696-1b23-4f9b-82c9-650b49de04ae@canonical.com>
Date: Tue, 2 Sep 2025 10:50:09 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 23/34] lsm: introduce an initcall mechanism into the
 LSM framework
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
 <20250814225159.275901-59-paul@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250814225159.275901-59-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 15:50, Paul Moore wrote:
> Currently the individual LSMs register their own initcalls, and while
> this should be harmless, it can be wasteful in the case where a LSM
> is disabled at boot as the initcall will still be executed.  This
> patch introduces support for managing the initcalls in the LSM
> framework, and future patches will convert the existing LSMs over to
> this new mechanism.
> 
> Only initcall types which are used by the current in-tree LSMs are
> supported, additional initcall types can easily be added in the future
> if needed.
> 
> Reviewed-by: Kees Cook <kees@kernel.org>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   include/linux/lsm_hooks.h | 33 ++++++++++++---
>   security/lsm_init.c       | 89 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 117 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 86e457aa8809..b92008641242 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -151,13 +151,36 @@ enum lsm_order {
>   	LSM_ORDER_LAST = 1,	/* This is only for integrity. */
>   };
>   
> +/**
> + * struct lsm_info - Define an individual LSM for the LSM framework.
> + * @id: LSM name/ID info
> + * @order: ordering with respect to other LSMs, optional
> + * @flags: descriptive flags, optional
> + * @blobs: LSM blob sharing, optional
> + * @enabled: controlled by CONFIG_LSM, optional
> + * @init: LSM specific initialization routine
> + * @initcall_pure: LSM callback for initcall_pure() setup, optional
> + * @initcall_early: LSM callback for early_initcall setup, optional
> + * @initcall_core: LSM callback for core_initcall() setup, optional
> + * @initcall_subsys: LSM callback for subsys_initcall() setup, optional
> + * @initcall_fs: LSM callback for fs_initcall setup, optional
> + * @nitcall_device: LSM callback for device_initcall() setup, optional
> + * @initcall_late: LSM callback for late_initcall() setup, optional
> + */
>   struct lsm_info {
>   	const struct lsm_id *id;
> -	enum lsm_order order;	/* Optional: default is LSM_ORDER_MUTABLE */
> -	unsigned long flags;	/* Optional: flags describing LSM */
> -	int *enabled;		/* Optional: controlled by CONFIG_LSM */
> -	int (*init)(void);	/* Required. */
> -	struct lsm_blob_sizes *blobs; /* Optional: for blob sharing. */
> +	enum lsm_order order;
> +	unsigned long flags;
> +	struct lsm_blob_sizes *blobs;
> +	int *enabled;
> +	int (*init)(void);
> +	int (*initcall_pure)(void);
> +	int (*initcall_early)(void);
> +	int (*initcall_core)(void);
> +	int (*initcall_subsys)(void);
> +	int (*initcall_fs)(void);
> +	int (*initcall_device)(void);
> +	int (*initcall_late)(void);
>   };
>   
>   #define DEFINE_LSM(lsm)							\
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 363aac92a8da..697482a22a02 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -39,6 +39,27 @@ static __initdata struct lsm_info *lsm_exclusive;
>   	for ((iter) = __start_early_lsm_info;				\
>   	     (iter) < __end_early_lsm_info; (iter)++)
>   
> +#define lsm_initcall(level)						\
> +	({								\
> +		int _r, _rc = 0;					\
> +		struct lsm_info **_lp, *_l;				\
> +		lsm_order_for_each(_lp) {				\
> +			_l = *_lp;					\
> +			if (!_l->initcall_##level)			\
> +				continue;				\
> +			lsm_pr_dbg("running %s %s initcall",		\
> +				   _l->id->name, #level);		\
> +			_r = _l->initcall_##level();			\
> +			if (_r) {					\
> +				pr_warn("failed LSM %s %s initcall with errno %d\n", \
> +					_l->id->name, #level, _r);	\
> +				if (!_rc)				\
> +					_rc = _r;			\
> +			}						\
> +		}							\
> +		_rc;							\
> +	})
> +
>   /**
>    * lsm_choose_security - Legacy "major" LSM selection
>    * @str: kernel command line parameter
> @@ -461,3 +482,71 @@ int __init security_init(void)
>   
>   	return 0;
>   }
> +
> +/**
> + * security_initcall_pure - Run the LSM pure initcalls
> + */
> +static int __init security_initcall_pure(void)
> +{
> +	return lsm_initcall(pure);
> +}
> +pure_initcall(security_initcall_pure);
> +
> +/**
> + * security_initcall_early - Run the LSM early initcalls
> + */
> +static int __init security_initcall_early(void)
> +{
> +	return lsm_initcall(early);
> +}
> +early_initcall(security_initcall_early);
> +
> +/**
> + * security_initcall_core - Run the LSM core initcalls
> + */
> +static int __init security_initcall_core(void)
> +{
> +	return lsm_initcall(core);
> +}
> +core_initcall(security_initcall_core);
> +
> +/**
> + * security_initcall_subsys - Run the LSM subsys initcalls
> + */
> +static int __init security_initcall_subsys(void)
> +{
> +	return lsm_initcall(subsys);
> +}
> +subsys_initcall(security_initcall_subsys);
> +
> +/**
> + * security_initcall_fs - Run the LSM fs initcalls
> + */
> +static int __init security_initcall_fs(void)
> +{
> +	return lsm_initcall(fs);
> +}
> +fs_initcall(security_initcall_fs);
> +
> +/**
> + * security_initcall_device - Run the LSM device initcalls
> + */
> +static int __init security_initcall_device(void)
> +{
> +	return lsm_initcall(device);
> +}
> +device_initcall(security_initcall_device);
> +
> +/**
> + * security_initcall_late - Run the LSM late initcalls
> + */
> +static int __init security_initcall_late(void)
> +{
> +	int rc;
> +
> +	rc = lsm_initcall(late);
> +	lsm_pr_dbg("all enabled LSMs fully activated\n");
> +
> +	return rc;
> +}
> +late_initcall(security_initcall_late);

