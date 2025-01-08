Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D1F19B5A7
	for <selinux@vger.kernel.org>; Wed,  8 Jan 2025 02:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736305202; cv=none; b=kyFMaC5T8UerWrqbTmMcU2OxwltHt7ngtgb/lHx1y8VfpJMfj10bE8rTb/u+NClQE3LwXbeNQ13hKsU9MgBRNPcWE8WXGFld0OgujaZEoE4MtWs660avs4ah00rwxJzGcmi+a+Kbp0DR9QR+j1pc3tBs185p/xuF+8umHKnBDQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736305202; c=relaxed/simple;
	bh=mCGrJ9w5jYhzkvrMtMVnrjGpgTQEY9PcNzgxPvwS5so=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=MXKMufpoSKjB8qYt1HMr/ajRSJKen/oKfHqNb0MpN6GUe9AgWatqAAywdM5IGgQE9TknsqkjocwBtRsXp13CpjAQoyyx3bu1X/KRK9rQfirIkP+Vv9oG/+dr1UOrfFjx9f4YiLyG6nyczym4/n+i/9MQTBlwqW1DyVnrrPCcUf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FDqTm4bs; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FDqTm4bs"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d888fc8300so80108276d6.3
        for <selinux@vger.kernel.org>; Tue, 07 Jan 2025 18:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736305198; x=1736909998; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QIXJVCIS8DfcCstGykVKJfPorx6LhUEdkQ8NsNCAgOk=;
        b=FDqTm4bsjKeYXsaAzyfYBOqIUG/oUA02LlrwPZrgXzDX3Wq4mEcMNITRjcsNwciVjj
         5XHMTuxmvsV2fO9qg1q/zEjfQ2br3v4jAtKSGZqG88fVDMKNuJ5ez5JKbtTyipDtKKAZ
         zYcMeJn+9rs3kViTfG2Q53I99yYaG65N4HyXkzm+6tmzG71S5UjB4EKPEVajLjn43tS+
         H25NDg3RukgvRKiIUkga1ReQaM4nCFf2W/tGIkBt5v2YZuHQoB9SWFHkd6eJee/wgQz+
         hlRK5w2He50GUqGrf5JaDgCxblmiAG0Kw+gGnK0JAdCHngm+6phvvtc69t0nqJzPinMP
         9CVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736305198; x=1736909998;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QIXJVCIS8DfcCstGykVKJfPorx6LhUEdkQ8NsNCAgOk=;
        b=rZmMlYoIyDyxnt+m7uRfuUFFhapRNshZAy9USF4H0gHFZCsiJqNRAnssEgBtGyYnh8
         pDfHkFgMv5dvrpE1wrhMFHnRUgSHZCKd7CK0ekZJuQe7mOqHkxcfTC6FuszoURpwR3zq
         MKnZvfpWN85nYvWnFgKmd7Gv2Ua6lIT2oJ0g3jVlo8JD3ENML6kRD76dAOUa3yPUGVeL
         GFzU3Ll3/6nbuEPxI6EPlLz9or4LqVMWj67AB+e0bo4fsLviLGi7BDFTkgwRtRSyXv/R
         mBrnR+10xXNP+6Mn7/WEAH+xVhYUs3bS0rQ6NkFkLTm1I6//mWMqzCPiA8aOP2kIQRxo
         s25Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOkKbeARm0Wd8NSswR4K+gFYClwyZTEcbU1fPYLRc2f62lBXXBaI6WeuSe3uf7c0qA1gU/diZt@vger.kernel.org
X-Gm-Message-State: AOJu0YxWn6NNYbdnj4gpjyrLhuwibm5Ix22gJx2wrcWXH/FhiZ+/OxKC
	3s/vMadvlBu7gn1OH13PnhK0US/xYucnqCdKIGx968PGjjnrjWmWTR5BuzymKlQ5z13SwhYQp20
	=
X-Gm-Gg: ASbGncuRozMVT2s6hNfRItsfdQP7Dq2WNQ9qu6fAjV+0QrOb1lZmopwtBBeL9nn4J3E
	oCa7tFjrEjDs6IHhrs4UCkqrlwWYxzdUNxBa5o34XELaEvrI4A1ss0SQb8hGWLWkV5Yv2XZv/YQ
	XcgoGmOXALl+q9ygEQ3Kbg8FSUNqQRtrqfAlNz2FOdPDhGX/ZXGtdJlR2RfYy6HJx8+bB5b8Jkj
	mQB00I3SoiGK4iNv2tfoHBRjOo+pT19vp5uMPi2g2RU5HYyIhs=
X-Google-Smtp-Source: AGHT+IFpYCc0tjOwUQ5yZY3mSaoFRtDcQMBYeoAYHiU4H5ZdQilgu/HQagMJIkV1QvqZLDg3EzGOOw==
X-Received: by 2002:a05:6214:21e1:b0:6d8:8a60:ef2c with SMTP id 6a1803df08f44-6df9b1d2299mr26806426d6.2.1736305197802;
        Tue, 07 Jan 2025 18:59:57 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181373f6sm186933336d6.62.2025.01.07.18.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 18:59:57 -0800 (PST)
Date: Tue, 07 Jan 2025 21:59:56 -0500
Message-ID: <b63ec305ef9e7e3eb4baa298ce60e1ec@paul-moore.com>
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
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>, =?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>, Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, Casey Schaufler <casey@schaufler-ca.com>, Mimi Zohar <zohar@linux.ibm.com>, Canfeng Guo <guocanfeng@uniontech.com>, GUO Zihua <guozihua@huawei.com>
Subject: Re: [PATCH RFC v2 3/22] selinux: align and constify functions
References: <20241216164055.96267-3-cgoettsche@seltendoof.de>
In-Reply-To: <20241216164055.96267-3-cgoettsche@seltendoof.de>

On Dec 16, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Align the parameter names between declarations and definitions, and
> constify read-only parameters.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/include/conditional.h | 2 +-
>  security/selinux/include/security.h    | 4 ++--
>  security/selinux/ss/avtab.h            | 2 +-
>  security/selinux/ss/services.c         | 4 ++--
>  4 files changed, 6 insertions(+), 6 deletions(-)

Merged into selinux/dev, thanks.

--
paul-moore.com
