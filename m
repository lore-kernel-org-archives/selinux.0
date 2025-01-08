Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EAC198A17
	for <selinux@vger.kernel.org>; Wed,  8 Jan 2025 02:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736305198; cv=none; b=DbyU6yvmoTPmamco9cjK7Fy7nSYD5dSJXcym8Sb7YTVDB7sC3X3cD3sj5+xqpA/9nIW5AIVPXhPnZfoC4PJ//mMHM1IfzFNZ0b1Xztk3L3ok0bf9s/0NGc9RJQmcJby6EjD0W/Ygd1W0glqB430VV0F3+PWEienrqK5G9XYoM7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736305198; c=relaxed/simple;
	bh=C/ZHYIyY3SZv7cvhFXdzRTbZhaNsjCv+TbLGC3G9X7I=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=hJSyh3CKWffP9sWn9au+n2t3n3optfu7xSB/t9aGBRE8KV2LthIV1Zy89hRxD5zYwQXGmf2JUx1tfJBsJjeThSiP02W5mZVxWXaYOHWWFB/9z94F1iVPw5frugJt38g/aBhAmW9+Tr7186FYmpXiHYJgejisMEJilYkJEVzimbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MmrvpNNL; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MmrvpNNL"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-467918c35easo60121361cf.2
        for <selinux@vger.kernel.org>; Tue, 07 Jan 2025 18:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736305195; x=1736909995; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3tz22nuryVbOFmn+oYqrauvaNZiy7Fik4w1VGFcXWlE=;
        b=MmrvpNNLKlwDF7r/+xYZtIeax/jBBW5guSIo9X+fsj4bzJHODMx3cBNqswftyyql/N
         BdGqpL3mvRv2LvBTslRBz//P/fBiZSGb69C1bnXRJ8OkD1I0epJXMyfv39WKYQRyrZab
         w6HuR+LYnWdYNBXIRkCZ8n7Tq5BCHDJkjJyrmOzlhp4Am5KFnP9ohjsM7nBjM0PwTz/s
         ICS119lTQp5z0cWaCl4zbbiBRi2pEwhfQPqEVKsYxV07AGJSJ9oipdU37GitAAhjvMTS
         1ialALGbL3L1NVAWVF1iKoSBKBF7IomhRtnNRFXsz2JHMc2BebbkEjW6DebThbv+CUgP
         NLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736305195; x=1736909995;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3tz22nuryVbOFmn+oYqrauvaNZiy7Fik4w1VGFcXWlE=;
        b=nswsMUzP5GHKFT1p3UFMOAyp45fToRbgOQymCLZOpDT6KvWoBCFGzGtt76ncV0TLJZ
         cWd+YG5fz3l9PCxVudsEVgtu+KqUSF+k5YOhBHQxQgOmIfAiKOdQ4bQcUE2xer6IZGjC
         rEZXT7UBSm+POPwTUZVgPabY6WpqYTPQ1uOGVoXz+ivWz8fGZ09jNYCCiqtCtLkVXUGQ
         JpueF5cxg6gf8Cc4Z/srHZ5o+6Dgp04PJ4YulaICrOJtXbNkx9Zfg5W+2Mpbm5B7myky
         X+43rp85/kqlwwDJreVwYbYxUZkodvse2xZNf+8ePM55jhIzkiZoSjuR6IdaGekCvUpl
         ZvWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOssJ5m5zMi4qCRXfZkF1QdzdQs7Cy4YJrpyUFtlSwO/qaNkwzrc8wfJkR6nwmJJOTKcWe1Mus@vger.kernel.org
X-Gm-Message-State: AOJu0YyhUIE7P43qAsE0j7z4kQSNBQbxeiMnsEKwfiel3h6vOJo2i2bW
	WhMtiJHkgiW+4LSDLi6L+LJH5mi9ptlMo0yQLTf8zncwJNz2jcsUJprSKw5gMA==
X-Gm-Gg: ASbGnctvrNog7EaV7NhbsnVIcVuuIIzR/oBaO6bleT+0GthL6ROk9qaA/bTyN7u4wu5
	eEx5aiSVIgIVafuTszOvHdMdXgdLaDFBQb+LbsLFo7m1/K8iIhF1VAIR6scuuTvSPBScTCd0Ymo
	KBWthfUrouVWA7BSU4yjSfdSUjHwq0I3ddQgDpVXD3NgGaqDcrf+V2q/Sg5nRhdxqBxmso+c37B
	k8KVXfazb/FSmpuFZNVS5smEU2DGT8hATtN3BOVdC4i0VK5ipQ=
X-Google-Smtp-Source: AGHT+IG/qZatNsIQPUIMGpi/gDD5LuQycIfXktP/17Ciff+gHXaJdBEJVnCXiT5bnSst3fW/DC2oRA==
X-Received: by 2002:a05:622a:144e:b0:467:6fa1:9e2a with SMTP id d75a77b69052e-46c7107e0bfmr18520211cf.40.1736305195538;
        Tue, 07 Jan 2025 18:59:55 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb5cacfsm191575531cf.89.2025.01.07.18.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 18:59:54 -0800 (PST)
Date: Tue, 07 Jan 2025 21:59:54 -0500
Message-ID: <0ac6d10bcba40994814d5c4d400d86cd@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250107_1610/pstg-lib:20250107_1603/pstg-pwork:20250107_1610
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>, =?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>, Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH RFC v2 1/22] selinux: supply missing field initializers
References: <20241216164055.96267-1-cgoettsche@seltendoof.de>
In-Reply-To: <20241216164055.96267-1-cgoettsche@seltendoof.de>

On Dec 16, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Please clang by supplying the missing field initializes:
> 
>     security/selinux/selinuxfs.c:2004:21: warning: missing field 'ops' initializer [-Wmissing-field-initializers]
>      2004 |                 /* last one */ {""}
>           |                                   ^
>     ./security/selinux/include/classmap.h:182:9: warning: missing field 'perms' initializer [-Wmissing-field-initializers]
>       182 |         { NULL }
>           |                ^
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/include/classmap.h | 2 +-
>  security/selinux/selinuxfs.c        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Merged into selinux/dev, thanks.

In the future, please try to write the commit descriptions such that
they display without line wraps when using 'git log' on an 80-char wide
terminal.

--
paul-moore.com
