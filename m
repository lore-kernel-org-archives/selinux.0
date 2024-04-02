Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3726DDB1
	for <selinux@vger.kernel.org>; Tue,  2 Apr 2024 02:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024165; cv=none; b=nztzWIuXPdD3rCupd4GYoSczUi3fP/Y6SO/P+JlUNHr716ItoM0wrAscQ6GoCBtsffmkceyr4O/VG6r30NWBg2xHFDP7oZGIxy3m1+p5H6tsP8UixUQkL0L3bjBEPjztOVYieEiPBdFRSBdtTsIqpl8TWC8KIZewmGyDZbXbMeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024165; c=relaxed/simple;
	bh=Ise0em1QzVlV37HTSlvgoGvqRbvNzrCyRiYl7O3dYxU=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=Sk4XQqFy4Y1BsxH6l7CK1V3+OKH+0YyRLucSfRZDg+c4CCvn8ma+M8IdzPXcet0/DActlY7U0scqKOhnFfSsWsppUWsKIri1EcmcEnyvPiISFx155tNgI8rPcyjvMCfxV2Z545EfQ3vfTifUTI5NhQsHEJYqDipIyvkgy6RBAUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OMFKcXCf; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OMFKcXCf"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78bd8068b0fso161310985a.1
        for <selinux@vger.kernel.org>; Mon, 01 Apr 2024 19:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712024160; x=1712628960; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3sPjzrbFXS33feaF/4mjLaS9XVCX/Lu4RxL6ndgqZ2c=;
        b=OMFKcXCfmxL6/USjBWOJg18gNryiLy63c54PPk6hDovt6fQuIpyMxf+5vkGSnzZ3H/
         hSMtnN1KDQoy0BGdA/dPyZRh0KMeaE7ak+gL2/ZwMf1ENbmcTQCDK4RGBfmDnvYtNj7M
         a37Jb60sIUcUckWMC4rxpqhoLVYeD48Szxx+/1DeYgNTjTsb8U9Uavg/dCY1ANOBJtFZ
         9dXksYlqk1gYU+3cex09uaF34Sf7iB7tRUznq701o3tO7EXkugNXR2FKhQd7x7yn0UM9
         Iqlox9Q7Zs/sIbE6PFlZtoLSzbvqADnDpvRK+EOBKHLzojRHapkjWVhpsTRi8xCxJ06g
         xVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712024160; x=1712628960;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3sPjzrbFXS33feaF/4mjLaS9XVCX/Lu4RxL6ndgqZ2c=;
        b=IXN8RD6t6aWb2RJjmiK4tMROlBxtGqHXqYYBF+jBZnePdJyDClubc+lATRz8eyEAvw
         z0Gnu0gMOxkPyA/Dz/b8XrGGh7pyjl3QdBvzYkk8jMfeXqQwk+zzpb+GT1usSlAoMc0V
         bqQNG00MEEAE93bK5dHVYOY5o93H+in8f+IZUthdgJhtFLPRltlr0Q1IWt+Kp7z4vzdh
         j+kjrWx2CNYFKAkGUIiW7uIar1R9MYl2FfBfyVWopIKRxQSiK3ncT2h26mUTadpr0HND
         hZ1or6ltRi1FTT2WCQVsjGnrAWl3kmS7OeHiJJ9AwedVtbVZKGhalXa1lUTe8dMufEtT
         82CA==
X-Forwarded-Encrypted: i=1; AJvYcCXEyIxJ44DIvssgFKTD4s57Y4G+Sq6lQCsc0h1Fr7U6LfQPcY79G5VH/C39moqJ/Uy60fYBfYBMqRF3WZAG7NZpKdmBycXoIA==
X-Gm-Message-State: AOJu0YxGCzbSPgxUP2BkjteSQsyS1LB4rC89UAEe1LI/i2L/NoxH64R0
	Bq+NmcIN1f3Nx0zWVqXpfOEqMQl0XRLb3TMjnO8ULJ3iqVtctFlsrd3ePzC5xA==
X-Google-Smtp-Source: AGHT+IFGymXRw50VAinFNng/4QFbvw+ow/LcELHr3JFzP9CMyf6HGwMZW1VbgFzti+/upQt+KmsY3Q==
X-Received: by 2002:a05:620a:842f:b0:789:fedb:4c0f with SMTP id pc47-20020a05620a842f00b00789fedb4c0fmr12045561qkn.18.1712024159747;
        Mon, 01 Apr 2024 19:15:59 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id oq15-20020a05620a610f00b00788618c8c3fsm3950859qkn.34.2024.04.01.19.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 19:15:59 -0700 (PDT)
Date: Mon, 01 Apr 2024 22:15:58 -0400
Message-ID: <e558bd2d49ab8485e7ca449849591999@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: Re: [PATCH] selinux: pre-allocate the status page
References: <20240328192042.211948-1-cgoettsche@seltendoof.de>
In-Reply-To: <20240328192042.211948-1-cgoettsche@seltendoof.de>

On Mar 28, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Since the status page is currently only allocated on first use, the
> sequence number of the initial policyload (i.e. 1) is not stored,
> leading to the observable sequence of 0, 2, 3, 4, ...
> 
> Pre-allocate the status page during the initialization of the selinuxfs,
> so selinux_status_update_policyload() will set the sequence number.
> 
> This brings the status page to return the actual sequence number for the
> initial policy load, which is also observable via the netlink socket.
> I could not find any occurrence where userspace depends on the actual
> value returned by selinux_status_policyload(3), thus the breakage should
> be unnoticed.
> 
> Reported-by: Milos Malik
> Closes: https://lore.kernel.org/selinux/87o7fmua12.fsf@redhat.com/
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/selinuxfs.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 7e9aa5d151b4..ad57b5ad5829 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -2131,6 +2131,7 @@ static int __init init_sel_fs(void)
>  {
>  	struct qstr null_name = QSTR_INIT(NULL_FILE_NAME,
>  					  sizeof(NULL_FILE_NAME)-1);
> +	struct page *status;
>  	int err;
>  
>  	if (!selinux_enabled_boot)
> @@ -2163,6 +2164,14 @@ static int __init init_sel_fs(void)
>  		return err;
>  	}
>  
> +	/*
> +	 * Pre-allocate the status page, so the sequence number of the initial
> +	 * policy load can be stored.
> +	 */
> +	status = selinux_kernel_status_page();
> +	if (!status)
> +		return -ENOMEM;

Thanks Christian.

I'm not sure we need to fail here, do we?  In the case where we can't
allocate the status page we will simply fall back to allocating it on
the next page read request.  Yes, this will mean that we go back to
missing the initial policy load sequence number of one/1, but that is
hardly reason to take the system down, right?

>  	return err;
>  }
>  
> -- 
> 2.43.0

--
paul-moore.com
