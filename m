Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABB319CC29
	for <selinux@vger.kernel.org>; Wed,  8 Jan 2025 03:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736305203; cv=none; b=Ctd5ZsSz44JLH61Z+UUdVAN9rLk4U0Oc/V1cHgz0/9YiiRzmy/91Fp+dSrVx3dUEVXz1yVHrnWWOm4MDa5h7mu/qKt5Zc+IfmvvvfyIHXo0JqzjZEZgtBGxU9sosfwQLSLAdtgo+oHZG+BK/cB26voGrfbWF3eRNlEA4ypgX2ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736305203; c=relaxed/simple;
	bh=OATGo8aQcNYDw+H5AEmX2rtqICBX8uTSu1nPaZDpsng=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=Fc2ZqEA4CSabfl2WLZI+zldcacU5S63KOLRhn3lMHONhODMmQjQro1C74fYvKah19hbcDBjyl44sDczMCYWD4rUQjhtv+oMRxYPv6A7gVqKQK+ULLpJUdoUTem6mU5UQBIiTpOvGc6TkC9eL8W93y+jiwsyLHRLS6GgitrWHCaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=N8N7u72Z; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="N8N7u72Z"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4679eacf2c5so153318391cf.0
        for <selinux@vger.kernel.org>; Tue, 07 Jan 2025 19:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736305200; x=1736910000; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mDJSexMwGrVR6YaQuKuB48uyMoRezKWjJmWZhA1XR24=;
        b=N8N7u72ZTjLjtqTAixMc4Hh7ICuUHlPws23AUYi7Kzy2tCm+YnJ8e2FWBYDmEgWGKy
         E6cc2U1Dw+Uq2o6zzLy9YXDZ+ANVPecovaD/F530DP/7ExkYI3/xgZ+QaEGpPFHIn5eM
         FqN09wIRFnvHwM4SPZj4XuDTpkh+a+0zqs7ZkIIonjeAfI9HvGHd7IUcmRPsml2sU5Ez
         Yc/M8/mruws6E0yIWsaXX9cnvLqCeY0IbhTmUFZwRYmsPtTL+zyQveYiWDHVRVamrSfB
         3UfrWwzoQHGPPysVfcGK1QWP6h7VCfs8E+Kd0NNJMku+9OuWPj36uhdE73WTBCU0nWu3
         9+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736305200; x=1736910000;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mDJSexMwGrVR6YaQuKuB48uyMoRezKWjJmWZhA1XR24=;
        b=rD4oZ9Ok+VN0DZ6Jw7e27aYv+VD8Xnmx8z6kZ2vNEfHS4drmMC5e3MxOt7NNn1ggkC
         EXFqVmr9BDRh/tnARYP4OTq/2Echfbd4g6F2WNGpXNMf/+wxbbHA7wYS9Zqo059lzeFe
         nJU0R0r/D46VgLcmiKO/BarOD8THHnQSQzIM71/3Q1/mm37o4ZZKmM3+yU+vGY7njQWv
         y6nSIqnAVapaPtpFDOJ/DHN9DPULcZ8UppmSAvCnammrOlfb/nspqyqdNbvmJrR0q1r3
         h1wzhgrKtAF7o3PT2SST9+rBjw/Zud7upwNA12wNYJvi/e0ri9BOIqGJ18CZBddbYiQa
         47bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP3k9JjyQs+/rxD17cxXEnnMSv4k+mM3VpgnmYof6RxvU3SbsnbzGmeTK3Yo2mGNi3ohDA8dzl@vger.kernel.org
X-Gm-Message-State: AOJu0YzYaSEwoGULEbWv74Hpoeo/22PpQRBpDRNE6x07TYzjyik70oOz
	P+6aIAq3jy7q8/uH03ZYVToDPmv8+5tXUFdSSmv3r8L2vyT/TURFLSsfoS/7cA==
X-Gm-Gg: ASbGncvua9l3SkAZSbisxVPkilCM1e7TZz/R+HNsOqZ9UmTkUocpW/RmMhdfbaI3KFq
	U1/38peEk9H0O7g1bUDgfQ+Ba+SpUJMg6c0K6CmZ0r3Ty52v2TCnH1KoE/N7A+zW2N7dDl7difJ
	HE1KudaS7hVANR9NQ9gebyc6/fIgbfSwXWCtM0vKtRlJdIGDpWFgzHw1fZ6VMU29o9kpLZvg7Ld
	n3O6/i6BA7dGUPvXSZpdtByzAELfnQBjZ6dAsK9CciVqIJwvv0=
X-Google-Smtp-Source: AGHT+IEvu01NUR0GRR179mj45ii+bvHS1vbr47fBw9MkS6Z//pM+fOXYZIIfnSnV6RMGYeOm49gVMQ==
X-Received: by 2002:ac8:58cf:0:b0:460:8f80:909a with SMTP id d75a77b69052e-46c710314ccmr23177491cf.32.1736305200113;
        Tue, 07 Jan 2025 19:00:00 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3e653893sm191974381cf.1.2025.01.07.18.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 18:59:59 -0800 (PST)
Date: Tue, 07 Jan 2025 21:59:59 -0500
Message-ID: <01df64ed8f6eb9e6f2780b5b0aa3be5c@paul-moore.com>
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
Subject: Re: [PATCH RFC v2 5/22] selinux: avoid nontransitive comparison
References: <20241216164055.96267-5-cgoettsche@seltendoof.de>
In-Reply-To: <20241216164055.96267-5-cgoettsche@seltendoof.de>

On Dec 16, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Avoid using nontransitive comparison to prevent unexpected sorting
> results due to (well-defined) overflows.
> See https://www.qualys.com/2024/01/30/qsort.txt for a related issue in
> glibc's qsort(3).
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/policydb.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 3ba5506a3fff..eb944582d7a6 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -37,6 +37,8 @@
>  #include "mls.h"
>  #include "services.h"
>  
> +#define spaceship_cmp(a, b) (((a) > (b)) - ((a) < (b)))

I'll admit that it took me a while to figure out why you decided to
name this macro "spaceship_cmp", and then I had a little laugh when
I realized why it was called the "spaceship" operator :)

Anyway, while the spaceship operator is likely familiar to people who
have a Perl background, the kernel is still mostly a C project so I
don't think we can expect a base understanding of Perl, especially
these days as Perl isn't as popular as in the past.  Can we rename
this to something else that makes more sense in the context of C?

--
paul-moore.com
