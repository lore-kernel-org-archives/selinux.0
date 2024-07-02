Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A382E1BC067
	for <selinux@vger.kernel.org>; Tue,  2 Jul 2024 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719935813; cv=none; b=csGw5j6eoao5hSmtpryCZpzjLKjiRWlFuaFezr3r/cwerFcl16LsCH9SDZuPgb9mP+fFhvEUPztIcbL/rPHuZnDlbe4ycvSoljrP0L/PRZNtnQalak0rVAo38m3T2096Etc4x6QYqNc3Qe/ekoUlIJfKjjr6W+OaOdEULHONDmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719935813; c=relaxed/simple;
	bh=8ner41gRskw+GSfgxISqqxmCp4VWSYH/4KdQPpuLGM0=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=C9p6wXTEYA9ewohC1gwPyWRUXip6PIq54wGa/T4VRCkdOE+mzyetwyDMdMc8PSPIDThs21znmjcPMBOSj8JiTyfBkUidBQ80uzN3NPKO+995WIp8+jIDVqXvrU38Gmk3+x2NM7F5cYBzDNBOpJDH2OPE2vvv6jpUdg1E14yM/u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cozWUnlm; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cozWUnlm"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b42574830fso20086866d6.2
        for <selinux@vger.kernel.org>; Tue, 02 Jul 2024 08:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1719935809; x=1720540609; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FB8UHDOaIKLrgIWEE8g4mg51WR8c0nOJoFegB46Qoig=;
        b=cozWUnlmfWxoQ4IxgusiFt3R70S1Q5Q1L5rX1VNTvO2ckMWFW+SrWmJILBcizGo7yi
         UaD7sbtTaGxIkOPC+AMzcRuBZuRRqaPhrllVoKODDuQGmAZyuQxvlnNSI2A0tdMvFeVi
         HErL97dxR3z34ThGYBTeEUhRExQUzGX8p1PlxA7AMrm1f9wXd4F17vOCVEdesHKrHg3K
         E8CL5eOx241hTcxzLcxAz5HN5x1PoETA9ym/aWleTpVWrYcZEh7qwhQFYWcj4yC7odzm
         SsC/fNhVoVo8gKT7QhwAhIOHGgIOtjwmXSNjrvUNGdlRVlbMwkvSQHu8VreI3yhjG76O
         L3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719935809; x=1720540609;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FB8UHDOaIKLrgIWEE8g4mg51WR8c0nOJoFegB46Qoig=;
        b=SJzJGBkNIQk/F1TzgxYFzZ2iNDLIpecANekte6D6UlIZe3Zepf3qN7IqQfLUs7P39E
         L8kduYLosAvQmwW/q4T+9oOt6Nhogdp5SXE6YFFs3ncSEij1UiV+vp8evKk5o6CmqfGg
         1I4J4m/0xgHwRW+6XUlPX8k7OcJ/Tu7mJbQNCHzsUJSo5r1vAdpUKuzWHZk4S7sL6XfU
         Hv+h4RI/2V7S1KLegwHmpb9MPieyYJ1/ghi6zaxEMc14NbIdTBx82onKosnkFybnx/bM
         u8DxROAFqbmqsRUse/eY12hIpWLOwbv4kwcHKN6yfUSTHFjOrNh9joRqpggDIXi9gzvr
         jldg==
X-Forwarded-Encrypted: i=1; AJvYcCVK7fftLmvCUSDqocqU8u1fZlN2KIbMBAI6VR6zotMl1OeYE/EHyoyhO4x2s3f+xMVKnywZglJFd3WLQcRze3Gwx2YZGRqFkw==
X-Gm-Message-State: AOJu0Yz5sP1e53b5H38Yy2o9V8XTz/xC7MKsgOJzEOl1kxDMhIJ1WJeO
	Lyh5GGinBQCChrPAA4hqDOugiJRTA+ypoRGfP+j5Dh8IouwAJEnbHIuYHF5ejA==
X-Google-Smtp-Source: AGHT+IGjBlHimts/oaQ3Af8rs53H92WprPl+hFmtp0WMpy+HhR/2A4KlwlRph0QRmPf5uT43vkBHAw==
X-Received: by 2002:a05:6214:2422:b0:6b0:763c:e069 with SMTP id 6a1803df08f44-6b5b7098a37mr126280576d6.18.1719935809612;
        Tue, 02 Jul 2024 08:56:49 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5a705bc83sm41082046d6.131.2024.07.02.08.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 08:56:49 -0700 (PDT)
Date: Tue, 02 Jul 2024 11:56:48 -0400
Message-ID: <0c6a49b11150cb088f3be6a8e49fdd02@paul-moore.com>
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
To: Canfeng Guo <guocanfeng@uniontech.com>
Cc: stephen.smalley.work@gmail.com, omosnace@redhat.com, selinux@vger.kernel.org, linux-kernel@vger.kernel.org, Canfeng Guo <guocanfeng@uniontech.com>
Subject: Re: [PATCH] selinux: Streamline type determination in  security_compute_sid
References: <20240629041124.156720-1-guocanfeng@uniontech.com>
In-Reply-To: <20240629041124.156720-1-guocanfeng@uniontech.com>

On Jun 29, 2024 Canfeng Guo <guocanfeng@uniontech.com> wrote:
> 
> Simplifies the logic for determining the security context type in
> security_compute_sid, enhancing readability and efficiency.
> 
> Consolidates default type assignment logic next to type transition
> checks, removing redundancy and improving code flow.
> 
> Signed-off-by: Canfeng Guo <guocanfeng@uniontech.com>
> ---
>  security/selinux/ss/services.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index e33e55384b75..0c07ebf0b1e7 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1804,21 +1804,7 @@ static int security_compute_sid(u32 ssid,
>  			newcontext.role = OBJECT_R_VAL;
>  	}
>  
> -	/* Set the type to default values. */
> -	if (cladatum && cladatum->default_type == DEFAULT_SOURCE) {
> -		newcontext.type = scontext->type;
> -	} else if (cladatum && cladatum->default_type == DEFAULT_TARGET) {
> -		newcontext.type = tcontext->type;
> -	} else {
> -		if ((tclass == policydb->process_class) || sock) {
> -			/* Use the type of process. */
> -			newcontext.type = scontext->type;
> -		} else {
> -			/* Use the type of the related object. */
> -			newcontext.type = tcontext->type;
> -		}
> -	}
> -
> +	/* Set the type. */
>  	/* Look for a type transition/member/change rule. */
>  	avkey.source_type = scontext->type;
>  	avkey.target_type = tcontext->type;
> @@ -1837,9 +1823,23 @@ static int security_compute_sid(u32 ssid,
>  		}
>  	}
>  
> +	/* If a permanent rule is found, use the type from */
> +	/* the type transition/member/change rule. Otherwise, */
> +	/* set the type to its default values. */

In general this patch looks fine with the exception of the comment
block above, you can either follow the multi-line comment used elsewhere
in this source file, example:

 /* line one
    line two
    line three */

... or you can follow the generally accepted style for multi-line
comments in the Linux kernel:

 /* line one
  * line two
  * line three
  */

See the link below for more information:

* https://docs.kernel.org/process/coding-style.html#commenting

>  	if (avnode) {
> -		/* Use the type from the type transition/member/change rule. */
>  		newcontext.type = avnode->datum.u.data;
> +	} else if (cladatum && cladatum->default_type == DEFAULT_SOURCE) {
> +		newcontext.type = scontext->type;
> +	} else if (cladatum && cladatum->default_type == DEFAULT_TARGET) {
> +		newcontext.type = tcontext->type;
> +	} else {
> +		if ((tclass == policydb->process_class) || sock) {
> +			/* Use the type of process. */
> +			newcontext.type = scontext->type;
> +		} else {
> +			/* Use the type of the related object. */
> +			newcontext.type = tcontext->type;
> +		}
>  	}
>  
>  	/* if we have a objname this is a file trans check so check those rules */
> -- 
> 2.20.1

--
paul-moore.com
