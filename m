Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD5A26CE05
	for <selinux@vger.kernel.org>; Mon, 27 Apr 2026 22:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777328650; cv=none; b=qZYwPDQK0k8PVCmc9xBPPT0eZmQYZJUnOexEAmL/0vREx5cvvnIld9Gsb4mKs0K1EI3LstL4KZk2IQwZXFyT/7WaboGReg46aqTch947k4HCbVTDaG25KlryEucCHcZSELi/bKXLYjvwoJd4k69m0KOyyEPQUt+ACyjogF6T3O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777328650; c=relaxed/simple;
	bh=fkBhFSaTfOZt0+Y2HNLPKq3aDf0L7LqRsapHRqJebH8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=ljwUXBz5djj5pBm+GDmfk422FCrFKDv+fFD85TGSWJ2lmwIGTN/f8lhMlVNucRglFqI6A98k25Slz27eah1R9WN1cRi76ng/Kf8bPAhwFNKIt3S9viwbejcISJ2vSLJ9FnmsYAG7Y704pZYWp6SqOjG9hilzWplqxK7eiMupmYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KyeeFekw; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KyeeFekw"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8a016799d2cso118174676d6.1
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2026 15:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777328647; x=1777933447; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJFUnWE7fNzZGO1t3HTUL6y2hEPfYC2QrpMhK9FhHI8=;
        b=KyeeFekwNSM0wEEv2ByLpvFVcYzYNQWEgPH4syTvJ2M8gTwfsuHFkbGeRMS0Dx1O+o
         LXIDHKiRLxgflOk3UHawscHdjDXwZB1uX2AnTAa9qzs+ZWka5NYPPklFcbJSFYdqKX/O
         +kb5qe3YuUmfQlmQTA+rEG6Pv31n/FOS8NH3p/OcpopJt2ZlVU+vhhGq2i+V2Enil/HI
         MKenCMCYJw6jzh1MGDniwugTQSfHMBSru0adIeV5Vm8UNSfnY79DYxkaO1y9+Yv7MWfg
         uh+wgca20n/ez2csBWtYnXGQw2JBDYEdUX5IAXDFsScwi7zAJkH04oP8tVIxDwf/xndE
         u8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777328647; x=1777933447;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJFUnWE7fNzZGO1t3HTUL6y2hEPfYC2QrpMhK9FhHI8=;
        b=mDCToBNGyx/KqOhGtQQxHbSCIPy2lvxch2vQYikaOebzyL3OJkkjzEpIufTs5MM3VZ
         8mfktv980oYBgMyb6ItN/CCBqGiVi2W54j/JW/ttNGs5d44vch5aEjx/kKI1ObfU+LTn
         pI6E+9EFO35BRYF5ZsefhJvW6yv660GprP2zGNLo6CDDwZXMasZyz9YvE/xxAQb5S8Pf
         iUKn3Uk2QL2jUXeSiDRmfx/6lubu0/heG/lJQA9aNIP91p/Az/fnCQcotGFQKFIAzURg
         8gDj77q/4KGprJ4Zh2LIcfxFHZsRqoq3/ikQzMvzJTk8cEiBiYKW4ZdnMXLfOEZsfNd4
         7dJA==
X-Forwarded-Encrypted: i=1; AFNElJ/XyJvXHgQJeXG/LJv7RjSbbII3DPVIaY6DTGa3R2XENvGGmVK5ui4KOqKfGP+KJgunlbHwZBHT@vger.kernel.org
X-Gm-Message-State: AOJu0YzT0ItYTBvMkgFdZ7yY3BcWrzi8YpO0KT3gp2QaWBe6P5BYDb6T
	8EPmxBt7Y+TfUW3qLVKAH4qybmPVAFnzy9YQN65djIH6Bij8OkABugscjwZgS3iyyw==
X-Gm-Gg: AeBDiet/pwiEhXC9QzyTXCAOSptQxyucNtGTO+DWT5ejzmgSQNqB7OyBXs4BlJTc2dO
	RvL9v/SWfQVFrUZrskibCn98PtqlFfDW5F+kbH8DKvliFN1aKodKi0HlBBtpXLtHEZRIv2Eg0XI
	VuT+0NJ/859jfjozjhNEZZ9+guJmH/dVPlU8i59y5LhzxKpTj5njEbelvrV1+PmKLslX2BDezJU
	zE0pmGezRgymtvEpw7wHoqVkFAlYRCuKwJa+pGsB5GNl2dvASPRjrTrPBQm7cPy+CavS3qv5QCc
	p75yXXGEI1VWcQc6DHQRexFsKXYblI/GB/EMgGrIPK9+wSL0Pi0ePvmPyH23MPxcLhYeOFb8++Q
	pJGVd/RbvNjcDj6hNz0k/uFUFG8PdWUNPCULhE0PJKvT9ecw5X0fqHRmKJfdIemqDmPFoW1O263
	nFChnRSaVW+J4ng3ktpSwWuoiJTDzLB//QL77Rmap3akVUscCXOD+IkumSLc1SoYBbue5WYh+qn
	+EIeDE=
X-Received: by 2002:a05:6214:320d:b0:8ac:af40:53d5 with SMTP id 6a1803df08f44-8b3e31bed7cmr15006596d6.34.1777328647372;
        Mon, 27 Apr 2026 15:24:07 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3e299d76asm6325296d6.48.2026.04.27.15.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 15:24:06 -0700 (PDT)
Date: Mon, 27 Apr 2026 18:24:05 -0400
Message-ID: <3fa89f553526d4d68e1d5c0ba51a9664@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260427_1759/pstg-lib:20260427_ 820/pstg-pwork:20260427_1759
From: Paul Moore <paul@paul-moore.com>
To: Thorsten Blum <thorsten.blum@linux.dev>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selinux: use QSTR() instead of QSTR_INIT() in init_sel_fs
References: <20260422123104.100014-3-thorsten.blum@linux.dev>
In-Reply-To: <20260422123104.100014-3-thorsten.blum@linux.dev>

On Apr 22, 2026 Thorsten Blum <thorsten.blum@linux.dev> wrote:
> 
> Drop the length argument and use the simpler QSTR().
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  security/selinux/selinuxfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 83aa765a09f9..8c107af5140e 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -2107,8 +2107,7 @@ struct path selinux_null __ro_after_init;
>  
>  int __init init_sel_fs(void)
>  {
> -	struct qstr null_name = QSTR_INIT(NULL_FILE_NAME,
> -					  sizeof(NULL_FILE_NAME)-1);
> +	struct qstr null_name = QSTR(NULL_FILE_NAME);
>  	int err;
>  
>  	if (!selinux_enabled_boot)

Technically I imagine QSTR_INIT() would be slightly quicker since we use
sizeof() instead of strlen(), but the code is simpler and I can't we only
pay the performance hit once at boot.

Merged into selinux/dev, thanks.

--
paul-moore.com
