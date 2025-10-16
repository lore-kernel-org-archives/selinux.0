Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7305341C71
	for <selinux@vger.kernel.org>; Thu, 16 Oct 2025 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760649542; cv=none; b=hCA7Z5p8V9WgGh/yWf9eEx+44xuroHXZ1NvnPGCqCAA9ivWrevI9PWXkamn/k5J2ORVFQKg+sHZhi8tBjbZdoYoFR7Bv6IVfqNy3jksbBB3KK5QyXUAfRH3aYcyJN3J9A/dAsA527zyDeLW+lmEMRhA8fFSozPGynBGCbNCSKlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760649542; c=relaxed/simple;
	bh=Xc6Ma2BJ4rIJwOkFan2uQDZX9PCmX1NfiSFI3iHPhIY=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=pH70uopUPsGUn2lx3tQ9DMZXVTR22FFB7tJ11V0pfoGco2J+vhBzoDuAlaD55mmhCgDQuL5HJaEGjI8Ovh/fwPff+3DuETFRig2sWPe5NrmDdYQQ5q9D/dUCbKwe7YodXxyc1P3HTVl8kGhH1xhkUVlQ3WKJJUQBYgXxdoBWdkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NdVUtxqo; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NdVUtxqo"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-88e456972d5so233565485a.3
        for <selinux@vger.kernel.org>; Thu, 16 Oct 2025 14:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760649539; x=1761254339; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRxspZB6n0Ost1maui+Aw2s6FnuDB+lZ6WB2dbmokFg=;
        b=NdVUtxqoXrhbDcP+anD39EMsA4HbtozBFtqg8rIMEgZUVFIjGPX7D/hG0reQkFc72I
         6OLVgq3WCEyWpRGDOVYp1upbjb1X4C5wu0dKYmTYOVxdhfiSjCuBTZIDXUVlIb6xAB/i
         x+thXHV8ngNkVk/dv+dPsrSHh4NLL0G1oVUuFCJZ32irNRndUuKJGSvCd7iFnEQoF/Vl
         Dk5cPI7+qBlJA3ZG+821uErYibGpy8H/y8zEy/TQRpJSMMkQWs88C1V5nD0bRGfe9p68
         hdEmPpDIvJ7dXa3MU/d/iRecOrdR6BS8KsMZG5DoOTYZiTOpHuMjTfQCdoaPMhaSXPuG
         F5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760649539; x=1761254339;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GRxspZB6n0Ost1maui+Aw2s6FnuDB+lZ6WB2dbmokFg=;
        b=iLvk6yzYQfFG/NNqCH53ann1jVQfXsRf0tG+LVQty6KqJMmWtop/xAjbAwK13UgqUb
         n7YZ71G+yG3vAwvCHZOY962ljUlcsfuRvoywepiNvSqVhsOCF6BrN5VxyMD6umaz4+8a
         qi332oYwmWFLsJNGaxv4ol7IRTOd37JlBvX597L7dFXtNbo3uR50SvKq7CmbVxOhkbd5
         REMCoyb6eH3p2PCHUJrrpaOwIC/GhXW+a0Ndfp+hGS5ssMu4z1OUKj5/crE+zb8RoVFP
         3H71YtHIcZqZiR8fZTRcr+hd1kvN7ZUe5X9Emir4wTMIVzUV81oP10y4qFTJQlzReV6M
         y0yA==
X-Forwarded-Encrypted: i=1; AJvYcCVC0SSl+2HsT/mwULU+bKeUasa4GvE6CYZx+PxnTUuPFlKt6GOuPluCcwOuLFy1OrQ194B9vbM8@vger.kernel.org
X-Gm-Message-State: AOJu0YyfHbNri3o4vnfafSAlIsvgtAiImMHj1GUf8Za6ow2JDh8jOoJj
	AUByXgSGhoOGuYGn4pCz55rdnGoFAcINaCEPx6AC6P7jNcQlDabQ+OA8Njz+hvHvNn8eBI09Ga8
	cFOkVyA==
X-Gm-Gg: ASbGnctA7cZzkBx3IPfBEL0DdOEOkH0IyLdQ4ElXfNiI3kP3sglo4QhjNppVan+BQpF
	vNHVWHf6QXbD1HbSgm4M14r3alakkjxmW1mcO7abvHu7KszZ53chWR80l1ytqFnXIYIhN0xtnMS
	EmtXpWAhmmfUUo6SUANUKrIPwfNdJxIiwKElEny9JiFVuBCP5fnwaIH01KET3TiLzirj6AGMeot
	VsMFD5aM1k3qL/u99qU2q0ZAaI/MhOQ0bh6lEG/K72gNoKZWiSKvkVFrXQFRKs+eokJPgkv59av
	qyBXzUzcR2DvzmixitwYz7mD1ZT9vv3scoyPmgotRctnAT3ulY3onUpxy4/HeCoBLW9tnAeXtQU
	QifIJ2jqz0NXpgGPTSWHKOGSaTgAZ5ZHVLUi6ucsvnD3UDoXM6ycwQt0Ai4AJBYy4+41nwHJ/JP
	Fm8UKWWvxyqjfpMW4pCNUPLtbjV2dtrZrj/3zyfHihiUv9Y/JIVGXGVXl+
X-Google-Smtp-Source: AGHT+IECwF7FbZiJrx4qruCBvl4hn6IYvAgULKR8CrOlLlmi2Gc7wo9kcdTdR0bBbN18TCxqmD6XHg==
X-Received: by 2002:a05:622a:1917:b0:4b5:ea1f:77f4 with SMTP id d75a77b69052e-4e89d3a5ec6mr25065231cf.64.1760649539236;
        Thu, 16 Oct 2025 14:18:59 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e88db8b22dsm33512551cf.4.2025.10.16.14.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 14:18:58 -0700 (PDT)
Date: Thu, 16 Oct 2025 17:18:57 -0400
Message-ID: <b30e8d56703dfd84778fa73845eaa1ec@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251016_1653/pstg-lib:20251016_1653/pstg-pwork:20251016_1653
From: Paul Moore <paul@paul-moore.com>
To: Hongru Zhang <zhanghongru06@gmail.com>, stephen.smalley.work@gmail.com, omosnace@redhat.com
Cc: linux-kernel@vger.kernel.org, selinux@vger.kernel.org, zhanghongru@xiaomi.com
Subject: Re: [PATCH v3 1/2] selinux: Make avc cache slot size configurable  during boot
References: <d849e8a98bf88bd12fd13a8f6b6e84290dcaaf6e.1758859391.git.zhanghongru@xiaomi.com>
In-Reply-To: <d849e8a98bf88bd12fd13a8f6b6e84290dcaaf6e.1758859391.git.zhanghongru@xiaomi.com>

On Sep 26, 2025 Hongru Zhang <zhanghongru06@gmail.com> wrote:
> 
> On mobile device high-load situations, permission check can happen
> more than 90,000/s (8 core system). With default 512 cache nodes
> configuration, avc cache miss happens more often and occasionally
> leads to long time (>2ms) irqs off on both big and little cores,
> which decreases system real-time capability.
> 
> An actual call stack is as follows:
>  => avc_compute_av
>  => avc_perm_nonode
>  => avc_has_perm_noaudit
>  => selinux_capable
>  => security_capable
>  => capable
>  => __sched_setscheduler
>  => do_sched_setscheduler
>  => __arm64_sys_sched_setscheduler
>  => invoke_syscall
>  => el0_svc_common
>  => do_el0_svc
>  => el0_svc
>  => el0t_64_sync_handler
>  => el0t_64_sync
> 
> Although we can expand avc nodes through /sys/fs/selinux/cache_threshold
> to mitigate long time irqs off, hash conflicts make the bucket average
> length longer because of the fixed size of cache slots, leading to
> avc_search_node latency increase.
> 
> Make avc cache slot size also configurable, and with fine tuning, we can
> mitigate long time irqs off with slightly avc_search_node performance
> regression.
> 
> Theoretically, the main overhead is memory consumption.
> 
> avc_search_node avg latency test results (about 100,000,000 times) on
> Qcom SM8750, 6.6.30-android15-8:
> 
> Case 1:
> +---------+---------------------+------------------------+
> |         | no-patch (512/512)  | with-patch (512/512)   |
> +---------+---------------------+------------------------+
> | latency |        85 ns        |         87 ns          |
> +---------+---------------------+------------------------+
> 
> Case 2:
> +---------+---------------------+------------------------+
> |         | no-patch (8192/512) | with-patch (8192/8192) |
> +---------+---------------------+------------------------+
> | latency |        277 ns       |         106 ns         |
> +---------+---------------------+------------------------+
> 
> Case 1 shows 512 nodes configuration has ~2% performance regression
> with patch.
> Case 2 shows 8192 nodes configuration has ~61% latency benifit with
> patch.
> 
> Signed-off-by: Hongru Zhang <zhanghongru@xiaomi.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  4 ++
>  security/selinux/avc.c                        | 68 +++++++++++++------
>  2 files changed, 50 insertions(+), 22 deletions(-)

I would expect the number of active AVC nodes, and AVC churn in general,
to be very policy dependent; some policies and use cases simply result in
more AVC nodes than others.  With that in mind, I'm wondering if instead
of using a kernel command line parameter to specify the number of AVC
buckets, we should instead include an AVC size "hint" in the policy that
we can use to size the AVC when loading a new policy.

Thoughts?

I think it would be important to consider it strictly as a "hint" as
that would make life easier, e.g. if the previous policy hinted at a
larger AVC we may not want to bother with reducing the number of buckets.
I would suggest starting with an implementation that uses the hint as a
power of two for the number of AVC slots/buckets, with a value of '0'
indicating a default value (512 slots, e.g. '2^9').

--
paul-moore.com
