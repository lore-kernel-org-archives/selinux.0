Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749E81F30A9
	for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 23:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823499; cv=none; b=L6dDrR2eYBZXmXqojA9ACTKIAtCz2WVTFf11MzfSABHSzZGKQedsTSRRSucWTrx9S2CZVOWEEyhnHwpB8hBCn0UGw/oSO8BWa1PmhLhSCmJ7jUkz1NE99DFNngXVC3aA+Zh+61YXX2p+hmoVbbOCDwteosfyATznT81TUg/mCyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823499; c=relaxed/simple;
	bh=Ut8mJ3k+V5R8KikZm3AWOWmMzt+8Gms0zA9wZlAf0DA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=Vz3WeEzY/BTMSvrO8pFO3u8ndgXNsUUhBcI2FjU5xxrNF8MKcqrDbQQAblFU0BEECLJFKdaiuUhA5oxvLDL2DAqSIeo+W4JHC1bo2STfKPw+KEgof8amfZHPp6DVFyvOHxGafTEN82Ypu6WbfgauJgcWVxoY/Ydul10DJuhyuo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=J/MYX0CG; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="J/MYX0CG"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c0848d475cso41929385a.2
        for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 16:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741823496; x=1742428296; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vi6U+/B8XHKyRS0Jmev6UCKkajT85JqRoKosOZ0orgU=;
        b=J/MYX0CGKllQKkUk3OLXjuLN8WJ5ZUiunVH/BBYM9VQI2i4Wylg2tEt2o9w+I+sMI/
         a2hN7YKA4uOkHbmeWJ0XAcUfyyn2v3odG14IlXSwz/l4+Eo7lxJfhKmgyieCeSjBgZhu
         dfDSqb+NLWQInF9Y7fZBPCoa+uwj05SpOOhvUfJl0d3cdVRNRG1pYa3JNe4Rj66z1WYb
         w5SytroKKtxYsLydCVozB9U8YmainI7fmkk0Zq2z1rTsBRx7/DeoALnbozOGmyRV5zJ8
         SIdi4R/RYdgwCopKJuxDksGQYcmxrRrZBNfQ93DAS6HJOfQCHgfY9iPt/i/yqqX0zowM
         NTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741823496; x=1742428296;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vi6U+/B8XHKyRS0Jmev6UCKkajT85JqRoKosOZ0orgU=;
        b=lhGafXDBbc/NcF10Wp/xzkxwjRDcvr3KqIJpc4ygQq3PHmMp598XEmAoZde/6F3ya9
         yIyDPvAC1Ek9XK0KVBKhKV3Ch+J4Tua4DYuW37wtq+4o+RTRxgiZV+9jJ6KX8li5p1yS
         dYVE0mFY8AdgzGjDe0YvUtEz5Z29mtL5q6R4dezXlnTopMPi22QjRyKuAeBQ8HO5qcja
         33bgLsc1rrweFcmyDvmB4uVE5L9JxVI6/od7KsGpxymKfsed3UF2qo1By5nQLzedxIl4
         m/w9ZDY8iMRkO4JncjuztXNN+V2D6ljdCfYbCRUIcTKtb1HsIdVlWHHSz+QXdk1fEngf
         Ui6A==
X-Forwarded-Encrypted: i=1; AJvYcCVfZou5ea4psCUzhIh+pRpWG1+GtM7vgXd4wl4mi6kHZ7GBT/JYEGQiJUAwLPoOzzAbJAb+OvcH@vger.kernel.org
X-Gm-Message-State: AOJu0YyHFh2MLH2kLa/TQpPSDsdokFGEIDu/SjruSg3KIRvSqXuCdEc1
	2k03V5CFtjVaZrsBoYZJRKEngDSlUExA0AUahkvSTzIXOTHjOgd/XLo+HxAbvB8ncFDv3kgerPk
	=
X-Gm-Gg: ASbGnct+KVKd2+KpNJuHKy8De2e6/aGzzbLA8X1b9dPNMnyueuE7vn50AG3ifi7cWIf
	G491Y+aiC36RvGGUKV2nYPy4WZNfVtcBitshe68UbsdA51MuagaFuctgx02djitnr11fTa6hHjt
	/jgJdV1B/4kJ4fCByS+qoN+W97VrMaC7usU24jy+xskcwv1RFA9zHK5II/L61kbzj3rHIFp4457
	phV4Ck4VACWNSfRInQ65XQKq3YY9nxwD3pmMVkOpnQt5LDWL0eVC5qmFjm+9sEMBjLjzoMLf1Dl
	sR1UYB4ZtCu8xoXrGqIqsp7+QIlEzpSrrKw8mn4zGQbD4HlY4Qn35WcXUdPBk0acc4WJOCtQMrI
	wgBQvMODKuf3VDg==
X-Google-Smtp-Source: AGHT+IFz+Ql5l9a0k7whlaB+u7Ab1OaGXxcSzFd8PxxyofE58NI5fVrN685DtdC5WBfCUDuiBPqKlg==
X-Received: by 2002:a05:620a:2b89:b0:7c5:47c6:b888 with SMTP id af79cd13be357-7c547c6bc04mr2824280285a.40.1741823496118;
        Wed, 12 Mar 2025 16:51:36 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573c4f731sm19255585a.13.2025.03.12.16.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 16:51:35 -0700 (PDT)
Date: Wed, 12 Mar 2025 19:51:35 -0400
Message-ID: <5838489ecd5186900315f8f6c6e02f22@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250312_1930/pstg-lib:20250312_1930/pstg-pwork:20250312_1930
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v2 3/6] LSM: security_lsmblob_to_secctx module selection
References: <20250307183701.16970-4-casey@schaufler-ca.com>
In-Reply-To: <20250307183701.16970-4-casey@schaufler-ca.com>

On Mar  7, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Add a parameter lsmid to security_lsmblob_to_secctx() to identify which
> of the security modules that may be active should provide the security
> context. If the value of lsmid is LSM_ID_UNDEF the first LSM providing
> a hook is used. security_secid_to_secctx() is unchanged, and will
> always report the first LSM providing a hook.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h     |  6 ++++--
>  kernel/audit.c               |  4 ++--
>  kernel/auditsc.c             |  8 +++++---
>  net/netlabel/netlabel_user.c |  3 ++-
>  security/security.c          | 13 +++++++++++--
>  5 files changed, 24 insertions(+), 10 deletions(-)

...

> diff --git a/security/security.c b/security/security.c
> index 143561ebc3e8..55f9c7ad3f89 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4338,9 +4339,17 @@ EXPORT_SYMBOL(security_secid_to_secctx);
>   *
>   * Return: Return length of data on success, error on failure.
>   */
> -int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp)
> +int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp,
> +			       int lsmid)
>  {
> -	return call_int_hook(lsmprop_to_secctx, prop, cp);
> +	struct lsm_static_call *scall;
> +
> +	lsm_for_each_hook(scall, lsmprop_to_secctx) {
> +		if (lsmid != 0 && lsmid != scall->hl->lsmid->id)

Let's use LSM_ID_UNDEF instead of 0 here to add some clarity on how an
undefined ID is handled.  The function header comment should also
explain the special handling when LSM_ID_UNDEF is specified.

--
paul-moore.com
