Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6959E313E0D
	for <selinux@vger.kernel.org>; Fri, 19 Sep 2025 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758292415; cv=none; b=c+FaEoFaQhz1NEBv8aVZ4BCdloqO7oI1n9lrZ57zAqr8NS/mBINd2grNPW0yOKNOMGI4smzFdUJ1Qh5sTy4QtzEVsqT3ffv8P0FFifTw/krpmxI9XMT0UjvghfSLxQ7jIsW5Cq0lqtaXH/6ZXhuIdq5+rkZcENggjKhw3kd0PlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758292415; c=relaxed/simple;
	bh=qgYCemReTB8Py51vMht0sTo5gg4ywV1RMgsGRqQygTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qgeG3KDf896Ie0t3yt/EC+VUFgBfeKWoXR3zI8O1gyIyWtdUFsyqQFOpZbSY+dfCd3znzdn4WBlRmzgOeJHAMBZSTWd9y4sHbrPmhsK+4DCnoJyUm+VUq54LJ6O+wRd3tC2lfU6IGV/AgNO4j5Ce6o7ZBINEmyiNweGnKLNHUn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EB7wUMsS; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EB7wUMsS"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-329b760080fso1757628a91.1
        for <selinux@vger.kernel.org>; Fri, 19 Sep 2025 07:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758292413; x=1758897213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nv0VRvH+2z+eOsBA/kWhf8wYjWcXeptQmY40IaARc+8=;
        b=EB7wUMsSrwI+58nU4xc+TdF6mVl/IIdox3s1F4ZVTIevyy7vFI5JF96fGpxUojpZjK
         dUmi7dIdAELWdzoPbjrzGpIBwlMba+muZqKWDMvd8cKvKGYGQCvk1OzOWmO1YX2tzD4g
         xe+0SrxHUUsChHYDZwlfok1lNz8EM2r0pAj1sGcwVJT8FV+JAzdbc/65WdhpRWsu2ba0
         DG0zZHobF2SDgbQQu41gW6st2luBHVxItNvjefNa8ICQooPIa6GTIS49+GFDO3b9mpJC
         iYzi0PKed3K8xRczbkQweNjVnJNPuVYaJP6Y/LXa6tpMo012rJ/USjhRISPvNmKJGqXm
         4TPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758292413; x=1758897213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nv0VRvH+2z+eOsBA/kWhf8wYjWcXeptQmY40IaARc+8=;
        b=ef7gvjctoeUWl1i7rAT8X2Xb/1RKBsAWOu6yggFhEfXyslH7VXEsCHBs+/wk8vQ1D7
         mScXbbgshIyrxokP71Z6k8u+LCiBSKQJssXEx+nxg/DKwPyT6ZzVTq5yg2jY1taeMrCF
         DxO1Jlc1srwFGbc+Ir4SnyBHLA9ZqaFhXiiPGzZ4hihWQokkuNzj7XwPCg1pl8IbOZqx
         SZuMeRL2cMUCNilVAlVYNQowzIZrRRp7VXv1t9KPfiN14mYP6JB7ZYL6xwiYZJxTyzJR
         sZ8MG08hD9qQrc769rdZJfIS09VrghCcFvGjzezYIAUFZbxsXeOTMXr06Z02aGm3Y9c8
         maMw==
X-Forwarded-Encrypted: i=1; AJvYcCWxqFEJe/Y/aeVCCke/4FknY1G8kNSri+VoobQM5Eli4T9bFgcefXxQwQxSZT1DLgP31Axfnc/r@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgj5tzp1HUTp5Z+WHy+dbg0IVB+jiWGjpXLBoNdPPsPRtyh3aF
	Qs+7pd+u+EOIXhmFjlUGxizWw6aCdiw4VjZOO2861CkqrSrnYv9fEIa1QKtfvH0Ou79Oua4wWyP
	P7vtLQZQE88sO7JgOQ/Ic8DG+pkTk/so=
X-Gm-Gg: ASbGncujdae/tYx1cEO3oSkMcOzMlskTGl2XYHSMPIc7XlWsfMFHS52Y1Eb6xffI+PZ
	ORd9tnheGLTKk7z4jN7Y8qW5mAK0/IkZW1OhmGL6C6HCd0fyDb99qoqU/ecuNC7JZyL8NEJK1Yv
	ZbpwxKJlziRS+FaQNL8ccuFs+DLicNFzpBjJdycaBp0alYxCbkKJ+0btzpQkvK9Mb9mL2irKHSs
	/siGJA=
X-Google-Smtp-Source: AGHT+IFmZHTSN2yZAg/Ty+Re3o4YJGVBq+ASNKj76DqB4hM4bLVZNcdMHBtG93fOj9zpBsN040GJk8Bru5Q2E/8KtU0=
X-Received: by 2002:a17:90a:c10f:b0:32b:d183:facf with SMTP id
 98e67ed59e1d1-3309837a720mr4023276a91.28.1758292413429; Fri, 19 Sep 2025
 07:33:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ72UfNaPC0QXW61ENzCYLRUuYQCXeVxir4UFj4eP4PROg@mail.gmail.com>
 <20250919135803.556437-1-zhanghongru@xiaomi.com>
In-Reply-To: <20250919135803.556437-1-zhanghongru@xiaomi.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 19 Sep 2025 10:33:21 -0400
X-Gm-Features: AS18NWDjBmTl5whX_qOxidYSoN77QlptYsKPBo3zQkrciubZc41wi2czoHiX_iw
Message-ID: <CAEjxPJ5JFqSMGSg5KEYd40JhLkgUo6g0uykDkXdKW3q5F1JtjQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: Make avc cache slot size configurable during boot
To: Hongru Zhang <zhanghongru06@gmail.com>
Cc: linux-kernel@vger.kernel.org, omosnace@redhat.com, paul@paul-moore.com, 
	selinux@vger.kernel.org, zhanghongru@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 9:58=E2=80=AFAM Hongru Zhang <zhanghongru06@gmail.c=
om> wrote:
>
> > > Baseline: 512 nodes, 512 buckets, original avc_hash
> > > A: 512 nodes, 512 buckets
> > > B: 8192 nodes, 8192 buckets
> > > C: 8192 nodes, 8192 buckets, original avc_hash
> > > D: 8192 nodes, 4096 buckets ("large number" of nodes in limited bucke=
ts)
> > >
> > > 1. /sys/fs/selinux/avc/hash_stats
> > >         a. assess the effectiveness of the optimized algorithm based =
on A, B
> > >                 and Baseline. Expect bucket utilization rate: A ~=3D =
B > Baseline.
> > > 2. total latency of hash operation and table lookup
> > >         a. A vs Baseline: expect A is no obvious latency increasing
> > >         b. B vs A: expect B is close to A
> > >         c. C vs B: expect B is no worse than C
> > >         c. D vs C: see if we can save some memory with no obvious lat=
ency increasing
> >
> > Thank you, looking forward to the results. Fun fact: the current
> > avc_hash() function logic hasn't been changed since SELinux was first
> > merged into Linux 2.6.0-test3.
>
> Yes, I also noticed that. I tried MurmurHash3 and another algorithm (refe=
red to as Muladd below),
> it seems performance of Muladd > MurmurHash3 > current algorithm. How
> about using Muladd?
>
> Implementation of Muladd:
> static inline u32 avc_hash(u32 ssid, u32 tsid, u16 tclass)
> {
>         return (ssid * 0x9E3779B9 + tsid * 0x85EBCA77 + tclass * 0xC2B2AE=
35) & (avc_cache_slots - 1);
> }

Can you cite the source of this hash function? Is it public domain or
otherwise GPLv2-compatible?

>
> Note: all test results are based on patch "selinux: Make avc cache slot s=
ize configurable during boot"
>
> Here are the results:
> 1. Bucket utilization rate and length of longest chain
> +--------------------------+-----------------------------------------+
> |                          | Bucket utilization rate / longest chain |
> |                          +------------+---------------+------------+
> |                          |  original  |  MurmurHash3  |   Muladd   |
> +--------------------------+------------+---------------+------------+
> |  512 nodes,  512 buckets | 52.5%/7.5  |   60.2%/5.7 * | 58.2%/6.2 *|
> +--------------------------+------------+---------------+------------+
> | 1024 nodes,  512 buckets | 68.9%/12.1 |   80.2%/9.7   | 82.4%/8.9  |
> +--------------------------+------------+---------------+------------+
> | 2048 nodes,  512 buckets | 83.7%/19.4 |   93.4%/16.3  | 94.8%/15.2 |
> +--------------------------+------------+---------------+------------+
> | 8192 nodes, 8192 buckets | 49.5%/11.4 |   60.3%/7.4   | 61.9%/6.6  |
> +--------------------------+------------+---------------+------------+
>
> 2. avc_search_node latency (total latency of hash operation and table loo=
kup)
> +--------------------------+-----------------------------------------+
> |                          |   latency of function avc_search_node   |
> |                          +------------+---------------+------------+
> |                          |  original  |  MurmurHash3  |   Muladd   |
> +--------------------------+------------+---------------+------------+
> |  512 nodes,  512 buckets |    87ns    |      84ns *   |    79ns *  |
> +--------------------------+------------+---------------+------------+
> | 1024 nodes,  512 buckets |    97ns    |      96ns     |    91ns    |
> +--------------------------+------------+---------------+------------+
> | 2048 nodes,  512 buckets |   118ns    |     113ns     |   110ns    |
> +--------------------------+------------+---------------+------------+
> | 8192 nodes, 8192 buckets |   106ns    |      99ns     |    94ns    |
> +--------------------------+------------+---------------+------------+
>
> The values in the starred cells could be because MurmurHash3 has greater
> overhead than Muladd.
>
> Details:
> url: https://gist.github.com/zhr250/198717da076a808b5cc78762f27be77e
