Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F4C26B96A
	for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 08:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760688660; cv=none; b=u5MMbqiNTxz1w7BtE2xZL05xipkw1J5RMizpj5SwEZZrfdMpuQS3GNmLpzpmVPgM+rO0ZbFt/jEq4dkxYzrmaB2R3LKAYiI6Zlguqm0aZZUdPFmy6fGDQXlOhAh1V2qCzPnWDTsbDCOYZPW/P7vYVmZCIilJsX3WHSR5Zawf4k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760688660; c=relaxed/simple;
	bh=aVqGVrXm8lI5q8NS88Cip5M397ohWCh7BUCS+d3EHK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TsuJu02jA4dXi7pjJZWy5kU9+m4kCbFcNMFnjrP51Kq/o9GPR1c8FckebgEz4703mrqbSRU0EV7RzXC21hg/Wt2hRoq0hJbFxskAOcyjTwm5yQ3D1aMNAmMqHI23zreg/chRoitSLLj6j/W2LInVfdVm0V1N1KnnoX4QeEcjVZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPs9ZaMF; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPs9ZaMF"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-33ba5fc3359so1730481a91.3
        for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 01:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760688659; x=1761293459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+u625GDPaY8egfSZLucT0zHfuvwcK24gdRcqcnzy0vg=;
        b=JPs9ZaMFPYKQEEeRtXi7daus/r6oWmvQj1aoBzAUJbQXcwI+vgczLsVEbzYHUJfWhO
         poN/tCTBKftoZW5syC5JZZB8zmHAKP/d/ncw6crfIe2W6KuDBjYryOyAYmwyPR/pMQe+
         UQT7rzlQCjz+TDPsMle1XiRPNjMyvubeH5KTVe4a0BDsHxKSoT3AG4sRMBYYRZ/b86nK
         SfUV/1db56fqZtvb027smq/bbIBbEaURKPElr/azhXAGVUvgpM2d/bJeAH0bvYBcyo11
         GDNEy1c2zL8kA+NLgAmtjuL9S1YklXvQqZuCUM3fYgzwyU48d4PYixQINSCGgYAZjnea
         Vazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760688659; x=1761293459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+u625GDPaY8egfSZLucT0zHfuvwcK24gdRcqcnzy0vg=;
        b=k/ipffhoghNq5srCCd/YpnUoDC/paMZMx/NxvNw+HGJRwMurddfR5HLYD6a8tXWkQz
         6QRgLaZNBTF1I6dUC2vCo8HdFA7usCuHx5drxgHqqEAYhHia13iDdfFyibiDEnOkb2bh
         y6b/gnRtHXicB0hegap+xAe15+JymSsST3jhk1AxLssU4xCBn43Iv2ufkQrDpRykCW1D
         tYnIVtRAj+pf5R0lqg4+hSonw4zXGCjujmDxcV2UKDtB/Ixh5Lrd2IdMGsQhDtn6Incy
         3h4wvqpNr2NVdSyBN7K4h+u9vu/f3e55+zJgf7y/ghFnTtuOaH2mXqYk2A2rQOtz/s7u
         60sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr2qTQhI5EntQ5J+mNhdih0j7cztfXkiBVIo87DiEcLRkmAnRiOj7UFVJ0GA7zpFmBqKvbA+CJ@vger.kernel.org
X-Gm-Message-State: AOJu0YypNz1/hQ9uDGxqZMHhTYnoIhKQsBxrpyB+iU4MDJnA09VrnoQl
	Z166uFAdE2YeZWmPeuOTQvnHuLg8dRKLSHSiz5OyC3gYQmnOUGsBsqlzTEfPqTOD
X-Gm-Gg: ASbGncsyBeZr9Sef+RjHzRhuwlA+zS7u5ThCwUPdRl0pNnQKK5EMfNmS32MqucpGDnI
	9UGHJsXPNT3f7RvAiOcuR11CYR3JivgkRx8BB/EtNczTgYYUmLi2DfVmy+zZNLa5oLCLz3GSMs3
	lL4jfEPho/8OfHz84HUH6rrjZYLy6SOr/k/4/5fSZkTacsSIKTGKsWEEAl56nAVWDDBIV9IFxpG
	RGssbRxiPTnJnGgumtk8DjeOFsGHhfvE4rK8FiLbY0jrfjI8wHGqcgRWKgtt+hr3lFJAWLNbJmC
	HxtbT12Hmdec4bEoex2UKGWDlEKzthakyHbFV6eilrd2mudZSB8OmOCsF/CO/HI/RZaGSR5hTMe
	cSQcKNKtMFPhKtdICCLGv8m860GKYmN45hqcg0oV29gS4MoB/LVl5Tj95H7EAYGATgIGNhkccMY
	TJ1gh9kkK5Te5zmGZbWnXeWfOeGrLD/cQgYaMeFpI=
X-Google-Smtp-Source: AGHT+IFb1xzeA4iwH7dUCFyW/gzXhzYPaHqzzeShAhltFnJsMN4gL8vw81sdZypacG+2Ury9TB1kNg==
X-Received: by 2002:a17:90b:3144:b0:335:2b86:f319 with SMTP id 98e67ed59e1d1-33bcf919094mr3305776a91.35.1760688658577;
        Fri, 17 Oct 2025 01:10:58 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bae353b1csm2033245a91.6.2025.10.17.01.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 01:10:58 -0700 (PDT)
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
Date: Fri, 17 Oct 2025 16:10:50 +0800
Message-ID: <20251017081050.1171969-1-zhanghongru@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <b30e8d56703dfd84778fa73845eaa1ec@paul-moore.com>
References: <b30e8d56703dfd84778fa73845eaa1ec@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Sep 26, 2025 Hongru Zhang <zhanghongru06@gmail.com> wrote:
> > 
> > On mobile device high-load situations, permission check can happen
> > more than 90,000/s (8 core system). With default 512 cache nodes
> > configuration, avc cache miss happens more often and occasionally
> > leads to long time (>2ms) irqs off on both big and little cores,
> > which decreases system real-time capability.
> > 
> > An actual call stack is as follows:
> >  => avc_compute_av
> >  => avc_perm_nonode
> >  => avc_has_perm_noaudit
> >  => selinux_capable
> >  => security_capable
> >  => capable
> >  => __sched_setscheduler
> >  => do_sched_setscheduler
> >  => __arm64_sys_sched_setscheduler
> >  => invoke_syscall
> >  => el0_svc_common
> >  => do_el0_svc
> >  => el0_svc
> >  => el0t_64_sync_handler
> >  => el0t_64_sync
> > 
> > Although we can expand avc nodes through /sys/fs/selinux/cache_threshold
> > to mitigate long time irqs off, hash conflicts make the bucket average
> > length longer because of the fixed size of cache slots, leading to
> > avc_search_node latency increase.
> > 
> > Make avc cache slot size also configurable, and with fine tuning, we can
> > mitigate long time irqs off with slightly avc_search_node performance
> > regression.
> > 
> > Theoretically, the main overhead is memory consumption.
> > 
> > avc_search_node avg latency test results (about 100,000,000 times) on
> > Qcom SM8750, 6.6.30-android15-8:
> > 
> > Case 1:
> > +---------+---------------------+------------------------+
> > |         | no-patch (512/512)  | with-patch (512/512)   |
> > +---------+---------------------+------------------------+
> > | latency |        85 ns        |         87 ns          |
> > +---------+---------------------+------------------------+
> > 
> > Case 2:
> > +---------+---------------------+------------------------+
> > |         | no-patch (8192/512) | with-patch (8192/8192) |
> > +---------+---------------------+------------------------+
> > | latency |        277 ns       |         106 ns         |
> > +---------+---------------------+------------------------+
> > 
> > Case 1 shows 512 nodes configuration has ~2% performance regression
> > with patch.
> > Case 2 shows 8192 nodes configuration has ~61% latency benifit with
> > patch.
> > 
> > Signed-off-by: Hongru Zhang <zhanghongru@xiaomi.com>
> > Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  .../admin-guide/kernel-parameters.txt         |  4 ++
> >  security/selinux/avc.c                        | 68 +++++++++++++------
> >  2 files changed, 50 insertions(+), 22 deletions(-)
> 
> I would expect the number of active AVC nodes, and AVC churn in general,
> to be very policy dependent; some policies and use cases simply result in
> more AVC nodes than others.  With that in mind, I'm wondering if instead
> of using a kernel command line parameter to specify the number of AVC
> buckets, we should instead include an AVC size "hint" in the policy that
> we can use to size the AVC when loading a new policy.
> 
> Thoughts?

I previously considered supporting dynamic adjustment of slot size during
runtime, but this seems to introduce code complexity and overhead. Every
time avc_lookup() or avc_insert() happens, we would need to check if the
table exists. Adjusting slot size and accessing a specific slot might
occur simultaneously, potentially requiring additional lock protection.

When increasing slot size, we could directly copy the contents from the
old table. When decreasing slot size, nodes exceeding the new slot size
would need to be re-hashed and attached to appropriate positions.

On my Android device, policies are fixed before system image release and
don't change or load dynamically during system running. Using kernel
parameters for adjustment ensures no additional locks or checks are needed
during runtime table access, maintaining simplicity and efficiency of the
lookup code.

If this is necessary, I would appreciate some assistance and need time
to think and develop it. I'm not a senior developer in this field and
lack sufficient knowledge in this area.

To support this, I think I need to:
1. Update the relevant specifications to add descriptions for this new
    field;
2. Modify the compiler to support this new field while ensuring
    compatibility in the generated policy file;
3. Modify the kernel to parse this field and adjust the slot size
    accordingly based on its value.

I'm unsure if this is correct and comprehensive. I would be very grateful
for any guidance.

> I think it would be important to consider it strictly as a "hint" as
> that would make life easier, e.g. if the previous policy hinted at a
> larger AVC we may not want to bother with reducing the number of buckets.
> I would suggest starting with an implementation that uses the hint as a
> power of two for the number of AVC slots/buckets, with a value of '0'
> indicating a default value (512 slots, e.g. '2^9').

Would this approach lead to slot size monotonically increasing, always 
remaining at the maximum size? This could potentially cause some memory
waste, though the total amount might not be very large.

