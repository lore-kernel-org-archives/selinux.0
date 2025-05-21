Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B41922F763
	for <selinux@vger.kernel.org>; Wed, 21 May 2025 04:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747800790; cv=none; b=mAtQVA2984yv+n9I+noJqnvGLOJJbIsX7QT3zJhj4bQdo6yLy+FopVjWJPcO5eepcACoW8X8cflBEvsup/BO+JFPCoWL1mByb2zHyvS8SKXsSPMXBzLHf5wDydI2jfdZFgTkDqg3qPifmvI274msiliidoqDj2dEAaZS2hzsxls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747800790; c=relaxed/simple;
	bh=CzZplifB4yM9E8aHgw+DcCEuudnsO+hd8IgPL+dvMFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtIY56UygdBptKnRNw6OXOneE+dv6PHN/SMBT3jsKmXq+TEn+4hH39wBv7s4y7qsiipCXSBCa87Nx7QUywwkhhLCarqk2XI8cpLbuGlXiNjLhmNWDcGewvUJzMYG0DmP7Xo1XkUihblp+MGQhfkEcCMwg0an+lNS3wP/Vuhe4d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vJeMBgbI; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vJeMBgbI"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-231f61dc510so934885ad.0
        for <selinux@vger.kernel.org>; Tue, 20 May 2025 21:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747800788; x=1748405588; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0KXv+Ko44cUZ/uyfsrxurypyzmWgliBU+Xqfak3IgNs=;
        b=vJeMBgbIDUjoMk8WV+GeAeDtczqdYt2ij1K91uXNqX8G/PBmtDW3CAalL0YuqpIDyJ
         DYoygFip8oVlnkVFJnz8fVWDKFnp9jh8h8JHH2+eKC1nBHFULqye7efNuD6bu+EH8MQ+
         3nzTrV0PZqFS4g+BxDq1UISGMGfnM9RRh9W/nkxWwwH9l+g0sAI3tl1QdyTddpMgBtxu
         dq6qDx/bhdyMGWGecOGswFLQCNvRDvFaMzbGeBZhnJhOtp8in2bmiz77uQTNw9TGlfyz
         fohzslr72KgBXez014CdxdnvtuSTdKLMFWFOuBIY+Cnc8pV2jcxZvBubZ8UtvWUlVgsM
         HIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747800788; x=1748405588;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0KXv+Ko44cUZ/uyfsrxurypyzmWgliBU+Xqfak3IgNs=;
        b=JQn1lof4dbslaxy/YPEHFfMYjcWRzkgxwDoKBYdkg4k2f3+49RkNnv4NLtvYfi2e3Z
         jIuJKQGw0GDQUzdGePuq+GKwiZknhOnP7IMGz+s/+cvkwEnZyYxNiLFA7z6d6Ffsv1xS
         GknT47NG1PMAJ6FZAnjlzVq9JO5QMZM3qkrWkQ416gy9TFK8QhVs4Zl5MmFa13UmioJH
         IualvkZR26okDkKq8LJ2dMY9ACm+TC4KlZ+eBYBnCBzHDrqtcxsgXIXPB6S6kqFX0dIM
         wsCh4OqxRGfmjL0PvhjgOOMg7+aHc7JqH8Wt5LTQVSC33pRyPQ+jWOr+Cr9DVOVLfWAS
         GPDg==
X-Forwarded-Encrypted: i=1; AJvYcCVDdnCfGJxwFnLN6SjgvWDjjRtGzrfkySup9cUGLvQO3bObgSNgEglnxUVoPxAx2OaMtKkUgdUm@vger.kernel.org
X-Gm-Message-State: AOJu0YxN+mS6SZ/1OxY1Y+mJR8L7KWCPhckd22fK40RhaSSZ3Mnx1ADl
	lN8XdeEuRAVTgjHz34hEng5ZDW6baoAwI+OuEpBpkLdhl4/ykRxbw5j8BDiQtLcVQA==
X-Gm-Gg: ASbGncsz+LlFlODJOmZjedjAG+TGA4BZ8AWMY42nVQM3Bz7JRcMpVWgjllgP4tbCnq/
	Y0/zpKRAd0XTTP/dFd2vv3jD+nAwn8jeY1iy7TJc0BdCARqK/xVeq9RO9aIvZn55bQD6xVDUq9N
	E0HhQ2+7GQEof7DdmTZpvBS6KgYoWaZMn2ZqXfgByAb1hTDy9WVS/GcoJOyjWxU0FR1viEj5jvT
	2WaEYsuFrzxo3/iNjJMcxOhdXi0fG5GJF8sO2MHxSYMc878kIvO92Fmg+9Fnf3hURmKcNt8OvNP
	f5HtuKJbjPBaPp7IIVzHyiwabFR64mI17VHpTzsGiy4ZHz6alA06CZ0GujCvC26AVER6eQVr/tk
	BAP/jyDnQyNCjn2/WRA0=
X-Google-Smtp-Source: AGHT+IEqOpF5edfEWArOiOQhVink5JvyoS5B9Tf3hRBGfOIcPhNGaN33iWUyuNmrSOLpeFbUNtsvcA==
X-Received: by 2002:a17:902:d54f:b0:231:d0ef:e8fb with SMTP id d9443c01a7336-231ffd0e311mr9558595ad.10.1747800787099;
        Tue, 20 May 2025 21:13:07 -0700 (PDT)
Received: from google.com (3.32.125.34.bc.googleusercontent.com. [34.125.32.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0a032esm8594503a12.65.2025.05.20.21.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 21:13:06 -0700 (PDT)
Date: Wed, 21 May 2025 04:13:01 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Li Li <dualli@chromium.org>, dualli@google.com, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, donald.hunter@gmail.com,
	gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
	surenb@google.com, omosnace@redhat.com, shuah@kernel.org,
	arnd@arndb.de, masahiroy@kernel.org, bagasdotme@gmail.com,
	horms@kernel.org, tweek@google.com, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
	hridya@google.com, smoreland@google.com, ynaffit@google.com,
	kernel-team@android.com
Subject: Re: [PATCH v17 1/3] lsm, selinux: Add setup_report permission to
 binder
Message-ID: <aC1SzdCwT90j1ajv@google.com>
References: <20250417002005.2306284-2-dualli@chromium.org>
 <eb68761b5a2d53702f4d6b80fe2a6457@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb68761b5a2d53702f4d6b80fe2a6457@paul-moore.com>

On Tue, May 20, 2025 at 05:15:59PM -0400, Paul Moore wrote:
> On Apr 16, 2025 Li Li <dualli@chromium.org> wrote:
> > 
> > Introduce a new permission "setup_report" to the "binder" class.
> > This persmission controls the ability to set up the binder generic
> > netlink driver to report certain binder transactions.
> > 
> > Signed-off-by: Thiébaud Weksteen <tweek@google.com>
> > Signed-off-by: Li Li <dualli@google.com>
> > ---
> >  include/linux/lsm_hook_defs.h       |  1 +
> >  include/linux/security.h            |  6 ++++++
> >  security/security.c                 | 13 +++++++++++++
> >  security/selinux/hooks.c            |  7 +++++++
> >  security/selinux/include/classmap.h |  3 ++-
> >  5 files changed, 29 insertions(+), 1 deletion(-)
> 
> When possible, it is helpful to include at least one caller in the patch
> which adds a new LSM hook as it helps put the hook in context.  With that
> in mind, I think it would be best to reorder this patchset so that patch
> 2/3 comes first and this patch comes second, with this patch including
> the change to binder_nl_report_setup_doit() which adds the call to the
> new LSM hook.

Ok, I can take care for this. I'll be taking over Li's patchset now, so
next version I'll reorder the series and add the caller. Thanks!

--
Carlos Llamas
