Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FB128935D
	for <selinux@vger.kernel.org>; Thu, 24 Apr 2025 22:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745533117; cv=none; b=YV26O+HCZTjAmiEosrMwwIRqm1u5IuWeRYyF5/1UKZdP5403cT7n0hxUvmDoxsm9j2TFySvvhbPXmULTt6ThEXLVROVmnhGbwXB680Y08L8fN4j0unBYl3z8F38X5GHgrkNSXNqX9RcLjg8cIXQIDRjo9hktKoiWkHMbyJeSDK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745533117; c=relaxed/simple;
	bh=h7bS8t6pLBwRLFNubDUutpACHo61OxsUV8u730LTnig=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=MtZLfMVy7Bg1H1CpGrWl0KEdkl3Sru/TcfRffp+9LE28xy0hQwQxzhyVWpWCDwoSdWl5m9ClUWCi1uXogN5sq/SCZneGvHx/u5FEewetNLXq5D8zt1BZ9gcmGZjgxWowj5/Uj1/SUvYy6vEtv7WIceQbzaQoXiJyTisCasmi+8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WuL+ZVmF; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WuL+ZVmF"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e8efefec89so16049366d6.3
        for <selinux@vger.kernel.org>; Thu, 24 Apr 2025 15:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745533114; x=1746137914; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hAjyXB+CyDav4k4P6PubMcZjSZyXZYM+TboJS0Fnb7s=;
        b=WuL+ZVmFB3eGhyW1vpV1hiagAKqGRt34rxaY37woXQl6y2AJJQ42uty6YuYkOQdhuR
         TYSvY5oo1bmaP3V4aXdl8wCoZhs08vDnw46tqTm1Znm+Y860XC+UFXmaVZRtjKKk9Dqo
         8LOpa7w/tVe4teV//GfSpzdriWNK91pKHsDph6e9JgNub3lRWWyrUDDiOZL5NK81NnRr
         On0wCjVpf1NkFUexqskbDEmEM2Yg7TjfTjvgPQkdWPJE8pF4auz/0ajEPZD8IAWRn6kL
         UJ6+w0uOVCk7xbyY/tsRv7jbVscQ5xtbpN1RRowvKH13sbFToTzmwWTfd2aVLmzknJrW
         C/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745533114; x=1746137914;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hAjyXB+CyDav4k4P6PubMcZjSZyXZYM+TboJS0Fnb7s=;
        b=SgAkt9AlZuxPqs1PxLU0NwMGXOSH+vRRepXA1bNrjT+Lo5vuyjRCniNrYK4a1sKylE
         H3RXpROLvetEbTB1WpkFw7O2RDtl8CtpKfs+HiK/YDg9rNS/kBR/eyw9dW7X9Uox2i1V
         ppZLVXpDGpkqYX4ktvFXUTGyzvr0gSgj7IQwALB5mUgsA771m6FZW1uw5xmpW6xsIt5a
         pywXPmrfnoelC3vRBUD6MaEPdVKllx0DYcZw83S2Ye0oRbdg4MTZbn4U/DuZC0PsBA2G
         EfJ0wwqh5Ma4N5udOUlBsK6jox7gRSovmkcfKpb9hWEqDVTuPtXI3dSSTOQL467xTo+i
         qZzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+CI57yLM00hXFLLCrSzTIJokKFD38cRZ9Ac5uv0M7fMe0/0CU6twD4xJi3yqT2SOfML08GQJE@vger.kernel.org
X-Gm-Message-State: AOJu0YylhJhDLoPjOyfn+vTj/0mcj8KHQDyvM/yRB1Jd7pySzDmbkYKI
	61xxRB4qS6ZJy5LcepahBc2Kvc8GFEYY1EfaPhrfqh/CL+p7NJ7PwzTMVXGwlQ==
X-Gm-Gg: ASbGncupKE1ySgeQvqA4BRHaVcHW1T9KaPbTBEsAcqq3ukBFIX2xRoT/OrdX67bLy2e
	uz8nLa9LwQsxt829o0hfnzw8J3a39a7Y27S0Xkj29o2N8m6ypV3/KQ2+FWRaHPV8p/LOz63zWcE
	PP18MSMv0jNLFebacSBBY+G9PuVk7Jb8YEy68jR2l6J5BKEIn6Qc/QG9oOA2S2ybPmemsxdA7Ty
	3Uepv0dPOj+d64j2z94D3tzogiX9iKPMOZZcl5Bwgw4lNGCBACgvrmiwxwMfhk2VNFUVVr3Wt9O
	SJ8LdTmNUy78o2sxVBdLP4lKvEEBGMLNhkdX2j5pZqD1kZuHRBEZXFpQFTXS2nIPD2q7ZjZ0Id+
	83dEzM4HwMQ==
X-Google-Smtp-Source: AGHT+IGXqCgssDpLUT5Km+2/uYfoayGN7KEZy1Sw7rm2oXTApNyBMkE2ly+T0vaDsF3ffw6xOmoIag==
X-Received: by 2002:a05:6214:242d:b0:6d8:ada3:26c9 with SMTP id 6a1803df08f44-6f4cbcb37femr1511986d6.10.1745533114161;
        Thu, 24 Apr 2025 15:18:34 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f4c0a7433bsm14465726d6.93.2025.04.24.15.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 15:18:33 -0700 (PDT)
Date: Thu, 24 Apr 2025 18:18:33 -0400
Message-ID: <0211e4c6561bf2eabbad2bf75a760e03@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250424_1707/pstg-lib:20250424_1742/pstg-pwork:20250424_1707
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v3 4/5] Audit: multiple subject lsm values for netlabel
References: <20250319222744.17576-5-casey@schaufler-ca.com>
In-Reply-To: <20250319222744.17576-5-casey@schaufler-ca.com>

On Mar 19, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Refactor audit_log_task_context(), creating a new audit_log_subj_ctx().
> This is used in netlabel auditing to provide multiple subject security
> contexts as necessary.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/audit.h        |  7 +++++++
>  kernel/audit.c               | 28 +++++++++++++++++++++-------
>  net/netlabel/netlabel_user.c |  9 +--------
>  3 files changed, 29 insertions(+), 15 deletions(-)

Other than moving to the subject count supplied by the LSM
initialization patchset previously mentioned, this looks fine to me.

--
paul-moore.com
