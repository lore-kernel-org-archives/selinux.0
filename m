Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB9354FAC
	for <selinux@vger.kernel.org>; Wed, 27 Mar 2024 20:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711572279; cv=none; b=uUP8YTt7+20pOO8PSR9vWxUYbjtZuiema5v7KHuc853O74gd/Hy/spKossTuJNZeMeAsYnvx6cDJdFB+92Ucoi2gNQ0pZH1Lair6BG734KNeF8foaXtQvkVF0e73+LJxakROtQim6SBnsfx4OUYSQ4av4KaUDAP/mtPjKlEuwlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711572279; c=relaxed/simple;
	bh=6ScnvqoMMhF+PP+719t3hAiTDjLc6357upB6aWrYqE4=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=SMfm/K1A2Gnbo7VebF+sXN9JkSg4V+MH/BSCVLC9A1sia/5x6a1Nd0Nv4CGybUUymD6BFtSWarRspw3d2WhOZUc3EqNw3xvbPR0i2tjSXhvz9N++nL2ocCwaU0PrOJr4wtcvHi/9sG1oC2327EH9ImriyBM3+0fxkkt5gsNjbeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=O3+Ly0GE; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="O3+Ly0GE"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78a2290b48eso11889085a.3
        for <selinux@vger.kernel.org>; Wed, 27 Mar 2024 13:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711572275; x=1712177075; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2jCfKCs2TVxRXu0y/D61x9yaJi+1GBRLV8wPFDNW2tw=;
        b=O3+Ly0GEJHG0whCIHNXxYEfdlXbe2PiuV81yY5QQahtSaHsKEiUNjx7NeQm0Ap0hUl
         mwhhdF3h0b/sVk4OxQo5hnf0QwBNODLJNaTKKtWMPP/74J/9eH4RppzH0M3WPYvKz2wz
         ZJiYPtgVdDO1auelDoJTKqrhf7tmjwMjlaztqvYIRj3bZ8Y4JZKrAuYwXeq27l72xQYL
         OvhHFQ/jm7OpvDpeDASXS2ItQpAGHGvCzObXpkiN5UXTy70YLacU2TKtJCMoVOsubG57
         60Wm+5+rkdTCT0fqcUnqB7pJjixQ4q3UaCmwbyThPGsYrnqYuYcICQqW4CQi+zngjOX4
         rPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711572275; x=1712177075;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2jCfKCs2TVxRXu0y/D61x9yaJi+1GBRLV8wPFDNW2tw=;
        b=RyyTvxqlIZJXjwio5CkEfqrjsQgxBCQL7FPMm2woBwcHMEqyXOrmRvyE7g/EYu+hzV
         EWLcmFavntb0vwteDSLfPc+RXMxgewi4Z/xak6hlRcT98LK+JwBEhc6IZvLtbBMSQfBO
         tJU2xHqFWyz8yveX7TyhvzeYEDku84cK5gKj3VTK8gaW9soQxl4LIkUfztz6iP1vVnSP
         1dM6vxYyGZdlUtKWbmt6zL35cKFOHuaE61KIUx8W3jivpUgkOPUHupttAZ6TYyKQLLfJ
         msYPVX4R5FJVkfT0thfurVUIujnDFAV96XwTto6jxOkSBayMiP/fC5qlXANUyfNDmPxN
         FTGg==
X-Forwarded-Encrypted: i=1; AJvYcCWNSx8TPVxxicYeEg2+qQUs7r66gYqwnHtZF/1CTmj1x+J5u/zyWGfpIN5m+dD6yT49XuxTrd8hrVutD9TdlRsZ98+ePFNNhw==
X-Gm-Message-State: AOJu0YxQ69HK/jnGvGzWyaejL9Tfb90ltvrtDabI6/5FEOyCW9EK8HjU
	chIwzcU5TvEsp4wWBimtaedv48Yk/f8/40UXBO8OT6eQ8VkKv5X6KWu3MGVgsQ==
X-Google-Smtp-Source: AGHT+IGpGgahcUfwfjvTIFCt1RKnkg/VfQvnMtCVnooymXRPZgeohapoCJX3onyY6aRJ3cj/4blsNQ==
X-Received: by 2002:a05:622a:24b:b0:431:5bf9:269f with SMTP id c11-20020a05622a024b00b004315bf9269fmr987815qtx.18.1711572275019;
        Wed, 27 Mar 2024 13:44:35 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id a5-20020ac87205000000b00430bd60afa5sm5127883qtp.48.2024.03.27.13.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 13:44:34 -0700 (PDT)
Date: Wed, 27 Mar 2024 16:44:34 -0400
Message-ID: <5675d29575dca282e538ddd67ab344cf@paul-moore.com>
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
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] selinux: update numeric format specifiers for ebitmaps
References: <20240327192557.505937-1-cgoettsche@seltendoof.de>
In-Reply-To: <20240327192557.505937-1-cgoettsche@seltendoof.de>

On Mar 27, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Use the correct, according to Documentation/core-api/printk-formats.rst,
> format specifiers for numeric arguments in string formatting.
> The general bit type is u32 thus use %u, EBITMAP_SIZE is a constant
> computed via sizeof() thus use %zu.
> 
> Fixes: 0142c56682fb ("selinux: reject invalid ebitmaps")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/linux-next/20240327131044.2c629921@canb.auug.org.au/
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/ebitmap.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Looks good, thanks.  Merged into selinux/dev.

--
paul-moore.com
