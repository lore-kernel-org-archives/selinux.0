Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCF62750E6
	for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 19:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777489899; cv=none; b=n342Tz9GPcr4ikdNnbTfN7FLYAh3A7a7POhNvpxyBpmfswDvhOHXwZTkys0R5tF+Lk1jKXyQIrleWHpETtrQA3QmuHJlOX7vM/m9M8lX73RiOa55/vbZtkcGkwTdV4y0kL7m97AyZvjnhRSq8G1W9s9po+Zq9UkCRmadEExA8aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777489899; c=relaxed/simple;
	bh=0R499dufOxn8mn8mws91NdEQ04udL73Vd6UmYTiirrc=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=LIrzoIb7QeMoRilTA+SryC2BGNPkjLqbh32a4wcaV+5AJhQxKtnYjvwRAfuJVbpVXhm9wFVgyUj+5wyU1DE1zZxWXEKQ89TqUAu07bdGwb+P4CHJzqRMLdH77wt1YpQlbzRSe1IYOszZFqnae+sLF/owGjySCbKzPtkAFj5Jlx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BWPny4Z3; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BWPny4Z3"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50faeb8317bso462371cf.2
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 12:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777489896; x=1778094696; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=caoS64WocHkHy1J3z4QbwX3GHQHJuukSrcUKA4VOjUY=;
        b=BWPny4Z3Y+2jbql3xBdl4KY/GUZkvmCmpPPiDc76+v0ZtXeY9lV8xaPyZS8Urw3smg
         P+Nm2mtvBl7jF0bHiuDaBDCD2snli+eBcJuT0dERBEbpLwzSVBO7U/J57jHdz+0sFX5d
         mArSqnA7cdVu0HrNITrM3FAaMMEi8ZTOOQOxI4moPNADAu3CckALmzwhnA/d3XjnD84y
         2KdpVo5Nk7V1TXnpHdPMMwzJTLbTemiNIYrticZ4ryrXrpXiiAPFuU9O4Vr2RiXgOlvm
         kyvwvJb8ZEyFlQjf3HLDKOW5FfdM+Bxd5UmUgl4p6de2LVW0fN5SBIXO505zOO5jmve/
         pE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777489896; x=1778094696;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=caoS64WocHkHy1J3z4QbwX3GHQHJuukSrcUKA4VOjUY=;
        b=Wh/AM8Ri6KD0Q+jbRXvl3s9dJStZ8Zla66j0aq9Sthi4ls2yZJzVUuqsGOg39kkv3Y
         GjGKtwgnkfoXWbkdFB+yDs2g6R64UsXWfZPPY2QwgeppGM8k2nmzYFDSraSxjgsfa1CB
         pQ/Ie4pFj4QaqLPaR67eT5FBx1Tp+gofT+eJ+XdqF2jmnk+wXiPWygu5yzBv7JFeYIOY
         2M+x/QGgro0FAH3xEY9NbjZFy3nhiVhERya6upjcPOR820a0ufOMa7uFNkHms6drmC3v
         inOXH6AjCse49nRkkjuDTvhkHqiI3SQl1KrVAq7r9mxbZgHJq09xQnf5+vOSJt7ToczR
         GWLg==
X-Forwarded-Encrypted: i=1; AFNElJ93OL/RHrDUQIK7V3NfoqsFj/nQ7MrfDO7Jax0xaX7fbtrZlpau/nfFjnyKHJQ4ntOcSoPwCwZF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/DObleTkYF380lMhwaHr5T9dD3ta1nvdUZBTCT+MQjICmyNOB
	L+sSWOrO3cQmu9nRwfDKNjt3XTDKkIi8nRMDMLwP+170Er+uEDz8wwlUsEd5aVPOBNIOVXrd2Yb
	tjME=
X-Gm-Gg: AeBDieupQAMtkri95kQDRegOtWOnSluB4c0QMoX1dbHxfoHVUzs/89DAEClNPu+zw0N
	hdzAzX2uHq/LFMAHGeTqbIs4Ulo2532SZOdbG89ciHsF6F/qE+JJNIJmDvJV8mTXhkeAouZnNDN
	j7noaHBEC7GlR2Zx1a5mAAi6zSZz34yhknWqBHmaSP1RlJsD7Z2mmzufmI2OQLcnjSCjBLhOlhL
	q79kfsgiWYL2bftRc/qD1IoVeq7ho6FKfr76Jj55tRleTQ99G3bTqDGYiCMNNLFPHjHj3RnDFAr
	j8NFnoG09CcGvpjajdOdvntTNj67Ffpjd0ik7lYsaw2QU8JfdLgrIBFok4vpnklErmNKTQ8GDWx
	Ah8cL+XWx7lyPGZTZbzwIg7RP1+SlUv3s0hnnyoNauznRthvQ6Kw4KoyiLPI6uUbvI7yTYf8g6S
	rhTm2mQaKGTG2bqtQK/VQKdUtJEGkV3h1IRdKO338vI7vmv09NdW4RruzuNCQqvqzy7fElDeOBI
	7w0GCM=
X-Received: by 2002:a05:622a:349:b0:50d:860a:8fb0 with SMTP id d75a77b69052e-5100e12eceemr109367431cf.21.1777489896287;
        Wed, 29 Apr 2026 12:11:36 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5101acdd42dsm24112871cf.11.2026.04.29.12.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 12:11:35 -0700 (PDT)
Date: Wed, 29 Apr 2026 15:11:34 -0400
Message-ID: <7f221205afebe80352e0139aecdce214@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260428_1810/pstg-lib:20260429_1506/pstg-pwork:20260428_1810
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnace@redhat.com, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH] selinux: fix sel_kill_sb()
References: <20260429181531.5566-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260429181531.5566-1-stephen.smalley.work@gmail.com>

On Apr 29, 2026 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> Fix the order in sel_kill_sb() to match other pseudo filesystems.
> This does not currently matter for selinuxfs per se but could
> in the future, e.g. with SELinux namespaces and multiple selinuxfs
> instances.
> 
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/selinuxfs.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Merged into selinux/dev, thanks.

--
paul-moore.com
