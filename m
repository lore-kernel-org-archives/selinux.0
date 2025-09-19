Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9D031283B
	for <selinux@vger.kernel.org>; Fri, 19 Sep 2025 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758290315; cv=none; b=nqLnvYvBr3RjsmkgAe+t2Vhq+Z7ip+YGHotm1MLrqkSUtEjvgOS4/3Q11whZOB6RC12pS5bGSriouHo2NyhUb5I2ox8boCMdeX0wBZp6x3fJEfwHEoMLFgXN4QKUJk+J3wXMrn5VwzF7bQpnlw9xHs6ZgR/Q3D/nxTJ0cy4kFNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758290315; c=relaxed/simple;
	bh=zzBQfxgIGk+ADio/cR9p0xhf8OMbEEBSGLRLx/I+A3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oNzQ3z9jq6/IMTFq/IYgbDAfek+eZVAz6aQ3134vygnJ8klo3W0fIbVC3IfSHcrQvgPcSrJjwmUNCZdmenXKbFo1YXTS/A+G6aqWYWtIfiaLdSIaA9kpS9JsWQ4sQ/smWu1XCITliWOwqI64LPyGbkDzbzCekuSjCM5BfiLsvWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqr7+TUe; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqr7+TUe"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-32e64d54508so2573388a91.0
        for <selinux@vger.kernel.org>; Fri, 19 Sep 2025 06:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758290313; x=1758895113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuUe70WfNg6ldoZOZQiDDXOaWMGQTXz5TzMSlNjVTNE=;
        b=mqr7+TUe7I48rjKEyfUYSGWqE1FwOzcJEOKvXIet8wOoXfnoRMUb6sNs9YeDTO/Fta
         jCikA4Bl9PqMnO76BiMjL/2AyST/9dDu1YnW3C+0YX8sOQurIt77YB1Z84GNyr+BAT61
         xZ1fwETmR20fx4Dx+bKOkqS8w5Rkwq3Vf15jUHPM7iGQZduOPWLoNtOQRIpmhpLZ/cpi
         vw7R/MJFv+H594IB++on20khrs6GpDf55ltbTpuPWOlP9Mv8e+/NdTIGm9QfMfsRqDni
         s0tm0a4d8QEqzOPobSq1nz20/EQrytvQ2JHqzsP7pNJnWX4jEVJXjBK9QQfbtRrpkbHW
         529g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758290313; x=1758895113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DuUe70WfNg6ldoZOZQiDDXOaWMGQTXz5TzMSlNjVTNE=;
        b=cDSjK7wIIEIr9dEft+gVF8TXFJ4n1LCoS7y8hCPXcV9vP7JVInC1XXHUFTdfsZ/kFb
         WjGJCKYR/RPbJhTIfbGVWWEKwAkj1/JNOary/X06NsOP9sPAcjshIINn4zJRFJy67aGw
         mGuIMMe5/QqHryZlJeOxsHrh3pc704QQM9ZJc/FJvRZnJgbmDcK5rWoA0hqwP5qqGz7/
         jz4SPlv+mDe3004yLwU29DulSdJo9P3BYGww+4Akne9/nE4tVZl7jlM9brGSJVVMbQhS
         n15iik3/4nlQ6WyhsuhGPssw75mobRcO+A5kFcA6UW/K9KtaQPLEzbjsmVG974m7j9yV
         oEWw==
X-Forwarded-Encrypted: i=1; AJvYcCVSpLLTXbdBDwFGhJRMmDZ6iTjIRcu7Yu6AzrqIen/ubjdLtTkuHumxVa55Agjo2vu1xZYSLyFv@vger.kernel.org
X-Gm-Message-State: AOJu0YzQVbt5Y/ovtjKJz0l3d/0gyJ+cXwCW8L7IKuovcJFxhYJbHroc
	IefmkmZN050md3OMsU5n3wMNobGIQokCXB7p5FReGXgP1g34/9dwO8LS
X-Gm-Gg: ASbGncvpMf/IQ4gvmbX4vnjzstfzcgi30si98A4iZSMiJHb8DI6vedqro4Ad7agsQsZ
	CipD0AJF7mpdBFGqvgq0rwyAnuanLEOAK+K+aKwcpSueATW6XWno2tYsshfJ4NXZ0FWiSc2qjA7
	57vUtY/muJ+QrmLzc4zQdbDQhnBQFynol/JpFTDzPUxscCuRbPmeFPfdw/9L04sbJwwLwF4lMuZ
	ArxZTjM7xSx2M+aUJbA5g+rV8YgySgMhF8w4EkmXjXEZPAmGxmpJ0WHmY3SNIPC7SnZKXL6kyoJ
	RvgmGkJCxpGJ1Qiw3JNUjPZNwKK6HP8pGSOJG9zoa1vyh5WhYUMRUsDHq/0BBGJdPLaPIsJHo1V
	wy/+VhNgp75FeTSKXIk2gyyKoau5kkf1Cy/2v0BlHTzGg2o088DkcHnbb1DVD/g==
X-Google-Smtp-Source: AGHT+IHiggGEuUWb722ssbrQ8vLMtLIv/PW3fXZWofoHoZq3zydPi70GRA28J7rytJ1ZfqD9WsK01A==
X-Received: by 2002:a17:90b:1dce:b0:32d:db5b:7636 with SMTP id 98e67ed59e1d1-3309836b22fmr4266789a91.27.1758290312804;
        Fri, 19 Sep 2025 06:58:32 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed26857a0sm8550049a91.2.2025.09.19.06.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 06:58:32 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: stephen.smalley.work@gmail.com
Cc: linux-kernel@vger.kernel.org,
	omosnace@redhat.com,
	paul@paul-moore.com,
	selinux@vger.kernel.org,
	zhanghongru06@gmail.com,
	zhanghongru@xiaomi.com
Subject: Re: [PATCH] selinux: Make avc cache slot size configurable during boot
Date: Fri, 19 Sep 2025 21:58:03 +0800
Message-ID: <20250919135803.556437-1-zhanghongru@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAEjxPJ72UfNaPC0QXW61ENzCYLRUuYQCXeVxir4UFj4eP4PROg@mail.gmail.com>
References: <CAEjxPJ72UfNaPC0QXW61ENzCYLRUuYQCXeVxir4UFj4eP4PROg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > Baseline: 512 nodes, 512 buckets, original avc_hash
> > A: 512 nodes, 512 buckets
> > B: 8192 nodes, 8192 buckets
> > C: 8192 nodes, 8192 buckets, original avc_hash
> > D: 8192 nodes, 4096 buckets ("large number" of nodes in limited buckets)
> >
> > 1. /sys/fs/selinux/avc/hash_stats
> >         a. assess the effectiveness of the optimized algorithm based on A, B
> >                 and Baseline. Expect bucket utilization rate: A ~= B > Baseline.
> > 2. total latency of hash operation and table lookup
> >         a. A vs Baseline: expect A is no obvious latency increasing
> >         b. B vs A: expect B is close to A
> >         c. C vs B: expect B is no worse than C
> >         c. D vs C: see if we can save some memory with no obvious latency increasing
>
> Thank you, looking forward to the results. Fun fact: the current
> avc_hash() function logic hasn't been changed since SELinux was first
> merged into Linux 2.6.0-test3.

Yes, I also noticed that. I tried MurmurHash3 and another algorithm (refered to as Muladd below),
it seems performance of Muladd > MurmurHash3 > current algorithm. How
about using Muladd?

Implementation of Muladd:
static inline u32 avc_hash(u32 ssid, u32 tsid, u16 tclass)
{
	return (ssid * 0x9E3779B9 + tsid * 0x85EBCA77 + tclass * 0xC2B2AE35) & (avc_cache_slots - 1);
}

Note: all test results are based on patch "selinux: Make avc cache slot size configurable during boot"

Here are the results:
1. Bucket utilization rate and length of longest chain
+--------------------------+-----------------------------------------+
|                          | Bucket utilization rate / longest chain |
|                          +------------+---------------+------------+
|                          |  original  |  MurmurHash3  |   Muladd   |
+--------------------------+------------+---------------+------------+
|  512 nodes,  512 buckets | 52.5%/7.5  |   60.2%/5.7 * | 58.2%/6.2 *|
+--------------------------+------------+---------------+------------+
| 1024 nodes,  512 buckets | 68.9%/12.1 |   80.2%/9.7   | 82.4%/8.9  |
+--------------------------+------------+---------------+------------+
| 2048 nodes,  512 buckets | 83.7%/19.4 |   93.4%/16.3  | 94.8%/15.2 |
+--------------------------+------------+---------------+------------+
| 8192 nodes, 8192 buckets | 49.5%/11.4 |   60.3%/7.4   | 61.9%/6.6  |
+--------------------------+------------+---------------+------------+

2. avc_search_node latency (total latency of hash operation and table lookup)
+--------------------------+-----------------------------------------+
|                          |   latency of function avc_search_node   |
|                          +------------+---------------+------------+
|                          |  original  |  MurmurHash3  |   Muladd   |
+--------------------------+------------+---------------+------------+
|  512 nodes,  512 buckets |    87ns    |      84ns *   |    79ns *  |
+--------------------------+------------+---------------+------------+
| 1024 nodes,  512 buckets |    97ns    |      96ns     |    91ns    |
+--------------------------+------------+---------------+------------+
| 2048 nodes,  512 buckets |   118ns    |     113ns     |   110ns    |
+--------------------------+------------+---------------+------------+
| 8192 nodes, 8192 buckets |   106ns    |      99ns     |    94ns    |
+--------------------------+------------+---------------+------------+

The values in the starred cells could be because MurmurHash3 has greater
overhead than Muladd.

Details:
url: https://gist.github.com/zhr250/198717da076a808b5cc78762f27be77e
