Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A91B221FB6
	for <selinux@vger.kernel.org>; Tue,  5 Aug 2025 19:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754422756; cv=none; b=deDesQz5qYwUhOUg+afruxHEPR5vJLOUvfwRLOu2vyFpDRxU5Jt97wgpjtOpuILwGZvPZYt9MgkLd5u2OiOjhGjVh0EqbrdbtrJ+3GNTHq9upUMyeYM3NgICdWn9IZXaEiNQtyperOMRmu/XrXrVLUYMXE167Z+DO/914qZiDJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754422756; c=relaxed/simple;
	bh=hrWShkwoLgpiXECNmA7ue8Ad2qXssEeiJhCjKxFwpUw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=HZFuOxLwHZyUNQrUxBI2XYuUnT1nks2xzhW8HRLuVm5tGGY7IYCSK0uzlQLCM3QFL2f2ELKIpWCuDsWn3U5knnefywtYXQfRKcgbiwwcqy0kEQykHpef1nHWMXDplSwYqcp2HNl0fDCbOzPGPfoQCB/mEczI5cqNKj0v9aq0CqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AdgEqdVx; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AdgEqdVx"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-7073075c767so68646856d6.3
        for <selinux@vger.kernel.org>; Tue, 05 Aug 2025 12:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754422754; x=1755027554; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fBazbWpOs6DnsY5hjuc5EgI1FanuICFKa6JiwIf4Boc=;
        b=AdgEqdVxp+p3aCgMQklEJoqYqxtp3hq7CHD70lHatl48iYNUfqs4J6ioXr1JDcaSy2
         D4cDsSNeSsWU8YrTTqI2HmzntGW50i2nVttSP2SU5zi8bdGHm8ZreaiZfdT+0ILIFmPt
         ENjn6X7E+DC24x1/Xp1PQ/JllxFrDUw+v6bXyDEIMLn7AvpPvCKG48xKGJwYdobqgu3q
         Q3MuCQ15mQAPFq+aAgAiRbjoqOEbMtNcJAU5Io4X140zmfrDY0LXEF83+SgsLmtxF3Ql
         6zZJ8LEkasEMCLGlub5mrif7b6bJ7+R6t/yWSD3yGJjf+TcdV1Yg81t79kdRQw0F+4sC
         QXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754422754; x=1755027554;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fBazbWpOs6DnsY5hjuc5EgI1FanuICFKa6JiwIf4Boc=;
        b=rF9JHWb+gklMn4YyKl2y9Jb4dhCVX9fIApkl1hxzMERuErmka5Bf0ZmYrKIdNH57DO
         s93yLaWlMO2s7UalNobC0S3zwNeSYkwYEd2o8D0jbBU+h/Dl17Vj0IFzxTzh5D+hrLQt
         YYevqI7sv+kGhu0iCq25Ub4S6FrxHAV107PiGxslRdZzP1P7O4EZOZrsi2eVnfKtfgy3
         J6scj1DvVAQmaJ9+zFNCVsFjtwVAq8K5B+IhwtftuZ7o+LYt/Fos32IYTarKb9nBRxrf
         YteggoMZ5m8Fjpmsf7uirCO+OqrNsk1ca+28hz4QYUDJFCdvP/yg2o4uYW2VFEzQQGB6
         e7tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDAxEdixF/+XvVZFr3yVoixpSU7+vi4VAChJnwx9K1NZbjL2yWQxXw4RGd9C/gSZHDW7ZgGSWV@vger.kernel.org
X-Gm-Message-State: AOJu0YzLM0ka2K+FbXg+2rzAJV+f3OCiPKqRlVFlogImE7M1w9xWv/R2
	PH/5hEIctaK734rlhLxqMSkb+TtCvREidNL85NH+52trhRpanA5OA/IlsEe1w+PuFQ==
X-Gm-Gg: ASbGncvIr4YUt0TNQrSYgGU0oBFIBoV5WP78wU5v5Uafoy0uwBt3V728t3Or5X3rnr7
	MhgvcXt25CGsfgdQ5ruaQIEq5wojpTuv8/BoRfyoyh7W0bYFN0SpRHYlAYl+QfRCZbWvxhdBN92
	b85b9hpE1MJqaS7CVOCo2qV/omqvPufs/7TNCV+dgdCJ+x2HieBplGsg0Dm3QzmXl2CW9ra+rkw
	HT5vjRrkj+fBcRzZp6UPyAw8nKhCBXxSmkaP/jv+tpewTs3V8ERivlR6vv/TDN0uIheTl4LRVPi
	BwCBFXd1xCwtIIWA/wL/4f4MoyM/I54pMhVwZuCN6/tT9uFF94RIgG7Beq4Hi0Ia8z9SBOZVxuC
	DhHOb95yCaCNpcWZ2ntO0CmuWyR4051NVkz6mK7ZBrqRYiATq2+IaxoYyAy+x2HKNg94=
X-Google-Smtp-Source: AGHT+IE+HthgC1i47sqQa2UGVUpX+LBzsQmL7EJldwFkiqkyAsWUvz71mh0r1BVzJ+awOI6xE6jKGw==
X-Received: by 2002:a05:6214:2a4c:b0:707:5c4f:f0c9 with SMTP id 6a1803df08f44-70979523ac7mr9246676d6.16.1754422754256;
        Tue, 05 Aug 2025 12:39:14 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7077ca464acsm76152926d6.36.2025.08.05.12.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 12:39:12 -0700 (PDT)
Date: Tue, 05 Aug 2025 15:39:12 -0400
Message-ID: <d5f0d7a5edea8511ab4467e0fb225b8b@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250805_1248/pstg-lib:20250804_1752/pstg-pwork:20250805_1248
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v5 4/5] Audit: Fix indentation in audit_log_exit
References: <20250716212731.31628-5-casey@schaufler-ca.com>
In-Reply-To: <20250716212731.31628-5-casey@schaufler-ca.com>

On Jul 16, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Fix two indentation errors in audit_log_exit().
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  kernel/auditsc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

As this is indepdendent of all the other changes in this patchset, I'm
going to merge this into audit/dev-staging now and audit/dev later when
the merge window is closed.

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 322d4e27f28e..84173d234d4a 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1780,15 +1780,16 @@ static void audit_log_exit(void)
>  						  axs->target_sessionid[i],
>  						  &axs->target_ref[i],
>  						  axs->target_comm[i]))
> -				call_panic = 1;
> +			call_panic = 1;
>  	}
>  
>  	if (context->target_pid &&
>  	    audit_log_pid_context(context, context->target_pid,
>  				  context->target_auid, context->target_uid,
>  				  context->target_sessionid,
> -				  &context->target_ref, context->target_comm))
> -			call_panic = 1;
> +				  &context->target_ref,
> +				  context->target_comm))
> +		call_panic = 1;
>  
>  	if (context->pwd.dentry && context->pwd.mnt) {
>  		ab = audit_log_start(context, GFP_KERNEL, AUDIT_CWD);
> -- 
> 2.50.1

--
paul-moore.com
