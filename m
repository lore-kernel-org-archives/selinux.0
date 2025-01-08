Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6E019DF8C
	for <selinux@vger.kernel.org>; Wed,  8 Jan 2025 03:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736305205; cv=none; b=FeMSGVTAmCwbrUGulnZfZY3HpTjmIHsPu0e4aVhTebhEfP4D+7Ek+Ke/2jL1R+EI4HPLD6CMAhqlcNY3YKGuDaQAHUIw6y8Jz7vNaHdl+ZrhkVNvKHw1awo/rX2R5DbBEdHHuzbjtkUqNE/FEldVBSvO/ct8wyRS6y/VID3WtSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736305205; c=relaxed/simple;
	bh=ltYRfQ14IXRN/9cdcB7PbclWptNjlsSoFOAk3QU4B+c=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=bQkCEOnT85xOI/ZX5YLqH3lxbVx5p0VyX8Fe4Hck8WaqOBxNiuDIr14sJxQ84twUl9mzW4tM1544gKq3X6RWPumyFKcKWIJvehaTUafT7I5KmIhcKP1X4dwO5/GtcmQZGeODjr+53jzo/ek5Wzzyi3++xxWpl2wGTnyGm2uyMW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=O7ufKjEg; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="O7ufKjEg"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d8e8cb8605so88837266d6.0
        for <selinux@vger.kernel.org>; Tue, 07 Jan 2025 19:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736305201; x=1736910001; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I0yNzl+As4oGuKhNOdOmE4BiHYZh0IMFBDUxXXCUSc0=;
        b=O7ufKjEg/SmQLDAmbwmkwmA4zPvKAvWcSkxC9Og5kfmcVpUh+S8HJxr0WIOvN+XM8H
         HzZKE4dKh2Fx5Ini4nMLhTumWiU5OW60vve8ZkQf2vXws+C152dshaDzWwGIcX2sHLvn
         uOcfVnamuMM/GORGdjUL40umm0rjZG0q0gg+w7nI08HjE+kKp9t7Na7V8s+GPxFpIL45
         RoKalMjh2PIEDNEe3Txg/HmjnHJoLE3zm2e5nRRiZJrEt+4IGc00oJQxTA1t/2LsmYZB
         yCvnUORbtnbg5gJ7f5heHbqFD/jrRfuwKBjODlLwzzjtXRBXpBRP0qD0mGPtmlrZylpi
         op3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736305201; x=1736910001;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I0yNzl+As4oGuKhNOdOmE4BiHYZh0IMFBDUxXXCUSc0=;
        b=mgCc5daXQH7cQwg+Yg6udkONx/Mo1yddd/jd48gDuWUEGOyOb834R60C5kSNf/l7k0
         a2O97BQ1vrlVPrUIzsJBcBwuQkHBymfU6rRu71bEFdKpyRN0gQhQUVMN5IKLWnu6L8hJ
         DUBX/aGodCiKcAek0ua6plltmoGcluFXLeh9Z6qZPSYQlZQ7zcR4amrIeF/e31+K+8Nf
         sDqaY9ksYdwtArjoMPOm75NdbG70ORQ6dklRP4gVoyx6tFHwmrx140qTmLXKg7xSTTgm
         7yukgcobiEHLLHqOTScbL39DIsZzN6C6wLwP+sCPMnRqYlKhLQXLRQmDurHeUk4ZEtPe
         2XTg==
X-Forwarded-Encrypted: i=1; AJvYcCWrOpVXoIzWKElJQulIEhSqa/49vgQB2IWu7GFISbE+Go+fbVWxah0ovyTLk6zFdOKh2gJSW3fy@vger.kernel.org
X-Gm-Message-State: AOJu0YxKjx+hnpfUYvmvLoyVr89jXWRZWRqwR2SKrYjkOtqAmR9S8htm
	Io5ZNeN6SaNxMpM/xVW+hIl5BJ/R88bDHSbPNSOBdWJFMPqjf0jbq90lTy124g==
X-Gm-Gg: ASbGncuMevdUwMLHzH+7Dn/cqSDRtEu+wEmmmLLUw0pPQnFO0dyEvWJiHZTwelHXLFq
	i0eAD0jy6Z99N3xVzkclTV3B3XpQ+2Cmq3gk9xxeThhRA3gB0OY0jGSTVA8LrYhsqfSYf41bbuL
	WKGrjKgs1YgLcamhpqkFUdwgbCnUYbktFh/M8GJHnL9Q+rj+QtRigxYUloAYNK3JFrMoIt6dvsk
	wLoqpIwBMO6KFCW7th5tniI4hNB/mMz7fTXFcLY7gSWugX6S9E=
X-Google-Smtp-Source: AGHT+IH+lwLZatyrqBOAesKhjOzKJVM17yEjBRrEj+xPvxjf5inNNnkNWCoZJzQPT55oBOmsCDchJw==
X-Received: by 2002:a05:6214:124a:b0:6d8:a486:e87c with SMTP id 6a1803df08f44-6df9b1d28c3mr21249606d6.4.1736305201066;
        Tue, 07 Jan 2025 19:00:01 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd1813900bsm186960706d6.67.2025.01.07.19.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 19:00:00 -0800 (PST)
Date: Tue, 07 Jan 2025 22:00:00 -0500
Message-ID: <56fbfb30cc249b4bb98354ffb449dae3@paul-moore.com>
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
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>, =?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>, Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, Eric Suen <ericsu@linux.microsoft.com>, Canfeng Guo <guocanfeng@uniontech.com>, Casey Schaufler <casey@schaufler-ca.com>, GUO Zihua <guozihua@huawei.com>
Subject: Re: [PATCH RFC v2 6/22] selinux: rename comparison functions for  clarity
References: <20241216164055.96267-6-cgoettsche@seltendoof.de>
In-Reply-To: <20241216164055.96267-6-cgoettsche@seltendoof.de>

On Dec 16, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> The functions context_cmp(), mls_context_cmp() and ebitmap_cmp() are not
> traditional C style compare functions returning -1, 0, and 1 for less
> than, equal, and greater than; they only return whether their arguments
> are equal.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v2: also convert ebitmap_cmp() as suggested by Daniel
> ---
>  security/selinux/ss/context.c   |  2 +-
>  security/selinux/ss/context.h   | 14 +++++++-------
>  security/selinux/ss/ebitmap.c   |  8 ++++----
>  security/selinux/ss/ebitmap.h   |  2 +-
>  security/selinux/ss/mls_types.h |  2 +-
>  security/selinux/ss/services.c  |  2 +-
>  security/selinux/ss/sidtab.c    |  2 +-
>  7 files changed, 16 insertions(+), 16 deletions(-)

Merged into selinux/dev, thanks.

--
paul-moore.com
