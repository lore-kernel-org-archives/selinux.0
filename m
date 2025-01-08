Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9C91993B1
	for <selinux@vger.kernel.org>; Wed,  8 Jan 2025 03:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736305205; cv=none; b=Oaq25ZYCn3NH/lLTQ0LklBPOCfWsloWpTj7RkkI6ahmiyhK8yQ5pJSqeHxKn1ApM8t16IXRb0FSQvs62o6NVC7Bot1GQpq/+D4Vllf4qdXD6epvxevJN9GGSqvIVEV/PGFyw7szXjIzbZaMm0fbTeSZ+EFojKDLPVemnyNKcxoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736305205; c=relaxed/simple;
	bh=69dz34IdLIqLQT3UgEpRCau5EC1HjbOWvj4mF7yxFV4=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=fdYhiKBJSB/ZElOiMk0BSFgRNY5zvuqQla+w7Z4Yk38sQmcycdcJhK+zaOCpaa9IoYtmOi6tKQvJEYpfmGqZEE0+DYI34MmXzu6EXxyo+Tx3AbujJ3bpu+iPk6ZgSH9hPWG3IeA9lSDIX/yXCwX+/k0EWci43gTsNG6HfWFzQP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cZG+qAEg; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cZG+qAEg"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b6fc5bf609so1260481785a.1
        for <selinux@vger.kernel.org>; Tue, 07 Jan 2025 19:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736305202; x=1736910002; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NvMVeu3O/Rrbai9L7v0w6uGtmvETU8SXM9vFjK6RCPw=;
        b=cZG+qAEgrfqQmjcuvySiv3Irf11CFYhe4TirUz4p6gQ6nl0yxJhbrwOsMqsvkDMTw4
         /xRK45rAQL9mYCQNrtVdLA222ZzPV6G8va7Ep3RVChStCTta9cr0GiwNGcpzKCN75zg3
         hJVpg6U8ZzL3aIJX/YLpdOI/Gl375kT/xlZoVeFg+FI8CSO9tt+wRGXpSWAMgwPJQYfN
         ZqHtWVfZxbb4joLOQW42mIHhHeTVbO/yOOtBwuP8n6l2A9RXwtluOZmoAVYEsdx4rn7c
         oWSZnobUKMYqhr2lnHIoiunjvJSoI/wM1b+nbmCAUTnqolTDzIMS4bw7hbUagky+r8V6
         ZVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736305202; x=1736910002;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NvMVeu3O/Rrbai9L7v0w6uGtmvETU8SXM9vFjK6RCPw=;
        b=AcpUK3SMdwuu5ZJv6VPzOGxaqCk+jMYuW3axWhS3T7RiFgukum5mQNG0hEEMuKFqJ/
         XTLhjWHT6p5lomeq7EiR9NEm7iOWMf4ylxaxWe4CB1JIpA/gRdc0dRSANpnFYj4eB3ep
         59pUPfRFmuulYNjb6E33lstEWu9bgM28iNrH3suzEpZUABn/2/KuDdmBz7VF43GLle1O
         bj7BsHMSaS/3jMMLl2BTgEntpZYgQVPk/Wjc/OKBW0pkl/oW4uJgyPSgjlaTRh9v6fSQ
         FzwSdGjwKBn339+s5Oi1s1HVaIt+KrA7RhXouyD/omdkuXkl2RPDYs8x/RS2VyxNaQcm
         //zw==
X-Forwarded-Encrypted: i=1; AJvYcCXbLfASOVviAhlCTtCbH+GK1ZCZx287G/4X+FwlujoZ7hgkV5C2OVvANsmA5yAhlbjteL+iNQwi@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/KnRazNBCij28XP+A+5wXK2nrxo0Pj4XG67DUy19SDsgOgmX2
	OO4CQMb3lmwuVZBnPprW64/p4wZHXOy196poFQeCTx4lUvywgTgz6AdDRKe5SQ==
X-Gm-Gg: ASbGnctJVESWsOy5enecfDBFjS4NR0aE2/WO3oP8lkd1WhAq96f8OlSnwI+ySsrZPuG
	IQBXaKM9VozbCVzKJJpE1tb93UmnraBa7E5pqTYpIiIbkRzjAYs1aQTM79cVWSgecBBkBZW9p2R
	kkeg0YGPLNJnCpZRNKV6FH6dD5xdDxG7g1AIX291KTEy5l3N4Rgy8BgjyctC8u/8awZ+ptfMxv5
	mKLbSclV9nDhKh2s1qfWVEqFl0f48bDgGkDQ8lSoUtvKc+Xo5k=
X-Google-Smtp-Source: AGHT+IE3tRjGPVkRuvsNe3q0WL+6uyZrJjkZzTaKRe75QWatS+285NESIcw8YdF9xcgdUJvGdfPLoQ==
X-Received: by 2002:a05:620a:298f:b0:7b6:d88e:f187 with SMTP id af79cd13be357-7bcd978938bmr158285385a.35.1736305202282;
        Tue, 07 Jan 2025 19:00:02 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm191470191cf.58.2025.01.07.19.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 19:00:01 -0800 (PST)
Date: Tue, 07 Jan 2025 22:00:01 -0500
Message-ID: <fdcd22493d49521390d09a2f8a464d20@paul-moore.com>
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
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>, =?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>, Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, Eric Suen <ericsu@linux.microsoft.com>, Canfeng Guo <guocanfeng@uniontech.com>
Subject: Re: [PATCH RFC v2 7/22] selinux: use known type instead of void  pointer
References: <20241216164055.96267-7-cgoettsche@seltendoof.de>
In-Reply-To: <20241216164055.96267-7-cgoettsche@seltendoof.de>

On Dec 16, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Improve type safety and readability by using the known type.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v2:
>  - move one little diff from subsequent patch to this one
>  - reorder struct definition in policydb.h as suggested by Daniel
> ---
>  security/selinux/ss/avtab.c       |  8 +--
>  security/selinux/ss/avtab.h       |  9 +--
>  security/selinux/ss/conditional.c | 12 ++--
>  security/selinux/ss/conditional.h |  6 +-
>  security/selinux/ss/ebitmap.c     |  4 +-
>  security/selinux/ss/ebitmap.h     |  5 +-
>  security/selinux/ss/policydb.c    | 91 ++++++++++++++++---------------
>  security/selinux/ss/policydb.h    | 16 +++---
>  8 files changed, 77 insertions(+), 74 deletions(-)

Merged into selinux/dev, thanks.

--
paul-moore.com
