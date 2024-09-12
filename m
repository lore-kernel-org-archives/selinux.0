Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B611C2333
	for <selinux@vger.kernel.org>; Thu, 12 Sep 2024 21:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726176496; cv=none; b=pWZPHfFx00t6tWDgxN0HxAQWMoOHYKWZ1CTlfrMpbkrW6u24wj6NPYZMMEdLKrJ51YXDt+pABr3wnxWeFTMKvOJm0zuy1pY+ZFS/a+xaBFQOfrGsSZpNl0G8Y9mOPzFumwWrWwy0yo5z5KaYf19CID1UQPxoXIBuAPKZnd3uZCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726176496; c=relaxed/simple;
	bh=5JkxikacpkxMhEfI8RHLq4pR2MZVCxlyp/YT3slkSRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1o4NX2bhTAOeIQXIQ6tlhVNsPNrSrye+Ld3mBu8EOE/ogOs/BmDIgp3ERxQf8ghhMGlJrVOwgoLluwdNTUvmSGL9xKDYAi+d8/T8CdVIet+nqlbZ7zCmNo1AtYG2jSgEuMOmulHx5r7E0DX+yHW+f9wBkKILHeKBdcKHW7bQos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hBuSp432; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hBuSp432"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3e033e66a31so796438b6e.0
        for <selinux@vger.kernel.org>; Thu, 12 Sep 2024 14:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726176493; x=1726781293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EVBoJCNLRR8X5TrQ/I9maABRhanYWycmzMG9wsr9TFk=;
        b=hBuSp432GHht2giE25DmEt4Cf4MyyXdMBywe3F91wAfmdryRhF9JH9NgXeB+Jb8/Hn
         9DsHN3jfCJstrCsyAqCDCQD1h8qXEl62enET1NHGmaByruOye1ktTAjCdxSUIYXs+ud4
         6g7VRGrd1kwY70V8jYR7TvuKzKUh5rf67Z+NNvo9eU9+85QbSvQ9mXpBNmBNc3p3rW3c
         SFO0lfubi4hqca9oBKQ13fQxopWMeO+pZN1BrKVodc/537N+w6BdrdBH9hSPp7Vef5x1
         5bDOy9iFf09EB55g2Xn2RGkr7x5yWDBmj+TmTk1V3S/Cmc26w1ao1KyACatjWEKRDEoY
         EV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726176493; x=1726781293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVBoJCNLRR8X5TrQ/I9maABRhanYWycmzMG9wsr9TFk=;
        b=pjPak4ou123POxyUHAy0MpvkZBWG6+sKF1lmF5hDQVsEZ/pZZZTYwbpc5OjBqhbN8/
         S24Q6+nqBqPXxbyXQNaQPnb6JitxPabAUCO7FQMtEAw0jYIBsM7QOu2GfkPSfkrAUY2o
         cc2bMY5OMYAtbsu8zcbheXshefeCUvDkTMQqvrFvv0fTYTskjD1306z7V9gdJoF8AwuV
         BCaGJ4SV8HADkelZabB/H/gRUwQE66PrU5ZeUtA22M/M3WxLslZCa+SqtNskxtnVoxmg
         N4IdEBk26ul6CDYPtOcKE1m4AN7Fir4Kf3a52iG/ljhAJc4WkSTB+FqIMP3OQbXzBfBT
         bOQA==
X-Forwarded-Encrypted: i=1; AJvYcCXPesNi9glPqkCV5JBkXXEJHAIaTAnavskLRJF+6WgovT2MzfE7hu8WS7K6NgFdfPhDA9u/Yq5E@vger.kernel.org
X-Gm-Message-State: AOJu0YzbsAxS8kIufQT0HuG6dwFSXB2MG3+KezLtyPAaEXmgq6cmiXp8
	i4zm0XLeyWXaiV1JGSqv7nNERqOC+SDEOlU1qLeIC4CEW01kOR2HJ7Tqxn7RDg==
X-Google-Smtp-Source: AGHT+IE+PplQfr1wmi1rPq6cfJUOVee5axfQ/fpUSWcQDWuQhtkqeGRwdyj65KxYO5B4v8hXLcmStg==
X-Received: by 2002:a05:6808:10c1:b0:3e0:6809:ab18 with SMTP id 5614622812f47-3e071a8f33emr2960910b6e.13.1726176493194;
        Thu, 12 Sep 2024 14:28:13 -0700 (PDT)
Received: from google.com (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e039c05857sm2544147b6e.45.2024.09.12.14.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 14:28:12 -0700 (PDT)
Date: Thu, 12 Sep 2024 14:28:10 -0700
From: Justin Stitt <justinstitt@google.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, 
	alx@kernel.org, ebiederm@xmission.com, alexei.starovoitov@gmail.com, 
	rostedt@goodmis.org, catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>
Subject: Re: [PATCH v8 8/8] drm: Replace strcpy() with strscpy()
Message-ID: <qqpiar6nlyuill6eng7safauo2xzzpx46cv6wku4xe42qsw47m@rirhsxrdzm2z>
References: <20240828030321.20688-1-laoar.shao@gmail.com>
 <20240828030321.20688-9-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828030321.20688-9-laoar.shao@gmail.com>

Hi,

On Wed, Aug 28, 2024 at 11:03:21AM GMT, Yafang Shao wrote:
> To prevent erros from occurring when the src string is longer than the
> dst string in strcpy(), we should use strscpy() instead. This
> approach also facilitates future extensions to the task comm.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> ---
>  drivers/gpu/drm/drm_framebuffer.c     | 2 +-
>  drivers/gpu/drm/i915/i915_gpu_error.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
> index 888aadb6a4ac..2d6993539474 100644
> --- a/drivers/gpu/drm/drm_framebuffer.c
> +++ b/drivers/gpu/drm/drm_framebuffer.c
> @@ -868,7 +868,7 @@ int drm_framebuffer_init(struct drm_device *dev, struct drm_framebuffer *fb,
>  	INIT_LIST_HEAD(&fb->filp_head);
>  
>  	fb->funcs = funcs;
> -	strcpy(fb->comm, current->comm);
> +	strscpy(fb->comm, current->comm);
>  
>  	ret = __drm_mode_object_add(dev, &fb->base, DRM_MODE_OBJECT_FB,
>  				    false, drm_framebuffer_free);
> diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i915/i915_gpu_error.c

There are other strcpy() in this file but it seems all control paths to
the copies themselves stem from string literals, so it is probably fine
not to also change those ones. But, if a v9 is required and you're
feeling up to it, we should probably replace them too, as per [1].


> index 96c6cafd5b9e..afa9dae39378 100644
> --- a/drivers/gpu/drm/i915/i915_gpu_error.c
> +++ b/drivers/gpu/drm/i915/i915_gpu_error.c
> @@ -1412,7 +1412,7 @@ static bool record_context(struct i915_gem_context_coredump *e,
>  	rcu_read_lock();
>  	task = pid_task(ctx->pid, PIDTYPE_PID);
>  	if (task) {
> -		strcpy(e->comm, task->comm);
> +		strscpy(e->comm, task->comm);
>  		e->pid = task->pid;
>  	}
>  	rcu_read_unlock();
> -- 
> 2.43.5
> 
>


Reviewed-by: Justin Stitt <justinstitt@google.com>

[1]: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy

Thanks
Justin
