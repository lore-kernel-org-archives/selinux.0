Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117D815687D
	for <selinux@vger.kernel.org>; Wed, 22 Oct 2025 02:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761101357; cv=none; b=ZH13lLqpqubWM28LE/zca68l94oy52TEOJa4zZ3IvsZiQTX2/hzgujeS8YNWYVUN+2Pbdmq2nhezhndbrHV3H9xZtx9lwRRIeri8vFvxf5fHvhLTuPkA9I5nFMd+xiELjEhv5EPpQYDT8Ih2gW8uUM2kjvsUUZMdgdguT2Z78wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761101357; c=relaxed/simple;
	bh=hg8htel78kb1z0kG4s/8pGMbqRLpRj3h1qbTxut7SLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VgTFBmReqY1vUiRBnRvW39zzazW66iagtBFpPzXg1U5pOjk6LZnAd+5efwYuqVgtufQP9sMhNX5arIHm66KeHqL/scl8jf8PXl6nYA4a3xBprvOTey9qmz36+s/KlLXzulH7FU0AerxlWG2tHPodnuj7oq55Rb8ELN6T5XRFeXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnVo6JyN; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnVo6JyN"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-28a5b8b12a1so64037395ad.0
        for <selinux@vger.kernel.org>; Tue, 21 Oct 2025 19:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761101355; x=1761706155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCP3+njcCxAGRdxjG7v79kpTJ5io9Ph9CBSeZe4EXQE=;
        b=jnVo6JyNr9DqE3ulcPzJfikax0BKGv8RQAuSRtw0ygzmx5wjyVQRQXp4nhHLivOfVp
         tiUobR28hlnDCprT09Tatfikee8dxl6+urnTh24FORjGNBsxk+dBgg1MGWN0UyanaICr
         PtTMKWt0Q9TZAff3Xtq+XgbYY/9pUmUM+Hy6pu9WxsXLxh030tusMvZyqcM5uu7X2M6A
         MiUdJLF9n1ba5ctpMd3qRKPXJkmBAHwUvTPif9hd8AbpOICly2pZncSccB9BdJQihiFf
         EncIowYBf50xIpS2nmq/dSJt48hJ0s5Zjn6smq4wWJFYLNfIYnmxXpRJC2sBj8FD0ESw
         6IQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761101355; x=1761706155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCP3+njcCxAGRdxjG7v79kpTJ5io9Ph9CBSeZe4EXQE=;
        b=iKMYF4Df9Ai+69y7Jxn8rwk8VdEfN7GeRVpiubY4I9HKbLAHFL/FnUZlb7k9BR5iDh
         LPgGKcTlSf2OFUnTpjOq0y+UjZXwRow+I29uWkB+fRoPRJXl14HsOtX7JVluBxGKJ9nT
         h+fpMy0nnkF4fLUlPgF3iH/yCDMQ4agD5csF3bYXeyS+T3y0Is06IQkQx4r1hPaE+eIY
         UvN4FuS45Uwz/8OZzqgpvZtq1kwgKsP3arbU65+1ic0HaBJpDKdkjGCuYeh2iPyidA/v
         OFJ9JfCN2A3O08ZAiQbHxdoNVXWC6tH2mR5+AJ5PknUWiCWYYI01/4SamIw3q2/0e0IW
         6n+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWV/j8/meotBgOWLm3anGCfBFp4m5o2VQaoDsyxzqtleHMNOp2nobpeM5yhtbaDTjUdR1czWGCp@vger.kernel.org
X-Gm-Message-State: AOJu0YzXgA7ycY1wVNiOLoQhqzcKa8UJmd9WLgOIRuiX3++NxPYJ/J0U
	hMZ7mR5LJhTV5XfK4nSHQEbrbOwaFUyh16zffMZTjJFRM5ill3atkLoV
X-Gm-Gg: ASbGncsvWWrGvvUFKBtbj3Im2fHWnnBzqJREpdTNYr09hM+HA7jMv1O9DEOo89tCT0b
	kiDGiW7r0Gm113Pbj3wmgkZwgFP/pTZERQtajK5DPR7HBUKigZ9sdC1n0tz3/aJiP/bpETgmEmQ
	i3y2x81bAFfuqnJD78RNDpTqj0C8sha2HPlQ9E874BwEKs7RfLaeqNd5THGTj/PqxPQc8e3Kwav
	LJdQ85g8FcKDrSn+aB9wVcwh1j9rNFzewAzv92igPeX9fOFhKrHI6ibobfuNRa3oh5pX9VGPgyR
	7NxgEdsNmKZiEWrPrLunzlgrXwSdXA8oni2kp8Kz4qgQBmm5pbU0Wl4gYC1ci1azIrv1wSBanDJ
	XXfMG9ArgsDIR2PKaPVFREgUhp5378buRBCZIJIzVJhaNgln5GxYO7I7M4t1SBlDL+wartWfBWx
	h4JyMHgcsoncoS6vcof9HnA7R7iu1r16v9XEN67M8=
X-Google-Smtp-Source: AGHT+IGPjfFw1MU49mZpNz6VxSCw+rw8IqPrOY86qqu1rvh7XI6a+FbsC1wlESQ+K5NmC8PEdzU7PQ==
X-Received: by 2002:a17:902:c946:b0:235:ed02:288b with SMTP id d9443c01a7336-290cba4efa6mr275302665ad.30.1761101355307;
        Tue, 21 Oct 2025 19:49:15 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebcde4sm124950945ad.5.2025.10.21.19.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 19:49:14 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: paul@paul-moore.com
Cc: linux-kernel@vger.kernel.org,
	omosnace@redhat.com,
	selinux@vger.kernel.org,
	stephen.smalley.work@gmail.com,
	zhanghongru06@gmail.com,
	zhanghongru@xiaomi.com
Subject: Re: [PATCH v3 1/2] selinux: Make avc cache slot size configurable during boot
Date: Wed, 22 Oct 2025 10:49:06 +0800
Message-ID: <20251022024906.87974-1-zhanghongru@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAHC9VhQeW7fFtB5uGRJhU7882MsSLazHmOZ0UKj=pX6PKiwz8A@mail.gmail.com>
References: <CAHC9VhQeW7fFtB5uGRJhU7882MsSLazHmOZ0UKj=pX6PKiwz8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> That seems reasonable.  I'm sure you've seen it already, but you'll
> likely need to modify AVC_DEF_CACHE_THRESHOLD as well ... or honestly
> just remove it in favor of AVC_CACHE_SLOTS, it's only used to set an
> initial value for the cache threshold.

How about this?

#define AVC_DEF_CACHE_THRESHOLD AVC_CACHE_SLOTS

We can preserve the original semantics this way.

> 
> > I will try to submit the final version in Q1 2026 based on the discussion
> > (Because I have some planned Q4 work that hasn't been completed yet).
> 
> No worries, thank you!

