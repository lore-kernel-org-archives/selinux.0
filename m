Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317022FBE1F
	for <selinux@vger.kernel.org>; Tue,  4 Aug 2026 00:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785802610; cv=pass; b=hvuS/RuyATeF8xjHHXSv9c5e5G5kpygKGzvdLB+WCL4Hyp31RG5pOdrjggvYZ7XasvvOXSYy55cuszFsOiOydUpYILjClKc9pGhelcC56+txl5RC/VSkhI+hRHlal4fEs3YcLpFMI2HhFfpzvNHK1S+eLAD0uX73s7LVNqTnDAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785802610; c=relaxed/simple;
	bh=xByEsDq77aq1mjC+sE081lytrYyrGP6yec4SyBZ96/w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TGi0CtWUzwqaJPL9ZANiPCIlrDZyrroriimXF3sgoUIASOTuPnw7Pz/7MyLvxSZRrteILwj9+8uP8InR3XlNhhW1nvtdh1ZtaZsxqo5A8yL/nvNxtFedMZfVf2cGEG/MzAYul37JSstBKY2KT+/LHN+9XprmImikUYHANurtvHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZtmQFmQU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g9MG87D5; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZtmQFmQU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9MG87D5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785802605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5xAa6RBMhwgEch+Pl7oGtOo9pFaryzhZJe7EILEPh1o=;
	b=ZtmQFmQUwxwj16mbpQrIBLpZ3U99mJ1SK3tmw7z6PHn1e3eeAli4Rds24q1A0jc7x0L+v9
	lobYRK+OUrSEgjyBOC6ot3zqstF0FHYzwEhgc8LXmXLZYq+QrZNnDiCrosqMUPLjHwYIMN
	NqHed3esXZEpZv8KciRF+lYoBoPuPgg=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-QYXcdazyOlKiNerWa0eNvg-1; Mon, 03 Aug 2026 20:16:43 -0400
X-MC-Unique: QYXcdazyOlKiNerWa0eNvg-1
X-Mimecast-MFC-AGG-ID: QYXcdazyOlKiNerWa0eNvg_1785802603
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-81f8ba7885eso19184957b3.2
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2026 17:16:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785802603; cv=none;
        d=google.com; s=arc-20260327;
        b=eHFkp2tBo56ZEaXyUz5nRe/jiurl0MwcrOQ4Y1abNmgr/Txd/CH4bnOvviSxOw2TNZ
         zLZ1E04LpYyvUX3Mi135lyipLrOInEfzHiERr0CDeRaKXavkRwiDg7ONoWFUv8Gohs6e
         NYtCB6Q4QVvkYpgV3w+/Gr0yc4FkEJO+Q/kfq/KdqISz1AMJGeVTdQB2cGzrkX2HxS9l
         7iHXy3FnClSOn9FGAvcFrPj6UHxfh3hZxl5y8aolnJ+UrtH79lqoDnQfDnfR6PoFahLi
         zww2T0Q5z3lqWwfwHROY7WQl2XN8WKgcfdKAGdlcnOdjKa2xdSwCYh+V00Rz6RFKkAsX
         oSxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=5xAa6RBMhwgEch+Pl7oGtOo9pFaryzhZJe7EILEPh1o=;
        fh=dhWc+LojCyoYDfXKYN+MfAQ8516lyn8QIWtL0Gy+du8=;
        b=BdNrdzyTNgjfrqaSSiV7je1RcNrIpYeN36bLCh9QXdLd3T3bAGTmxZvSWswcUx9/F2
         BfXEm1TDOb4K2WnnFHDszGIP+OynNE4gRsWUPPLQTylEmIS1cwJtOHTNfzY9kVOITPy3
         PDv71lF07P5zcgcFNWB5QrcbFoRPJSEO6h6slKlsfvftNWd4f2/a9rpLsfaAQvMao50F
         7dLkFx0o5KSlCinBkHNApxH6GGJ76jcKc/W6SuJjFf2THKrP5PB7kdM5kBK5XBrlF6uf
         YCR5dw7dJjV8a5fUchynRe0RYG01SaNHnSjlcLwZ+7mWklQ7WI6lBOYD0wW2Q/Wdf2xu
         F/Nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785802603; x=1786407403; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5xAa6RBMhwgEch+Pl7oGtOo9pFaryzhZJe7EILEPh1o=;
        b=g9MG87D5bSH6fmCqUP0T1fIGf6LHHLba2mYKhYAmoE3ZjNPM311vbbRoIxZpOM+qVo
         FaxLf3BxilawoisnVuzqaeHiYINfSwX2xXwcZuCaETfxocNtLLIKxbGlEl0KXvFzRKKQ
         GBvGMOZ/2JituY5dkg/r3VaVdLvylH/sH6s9/MI1x9+r1DuVP6HJbXdKOCT5PkpgXpHq
         3bhiNxXvL1MsWIlzwwQwVj0FB/EsdZ0IcpJkRbKIGIt7IC+0q+sU765QYiS1gDFuZuE0
         rd4YEMzRmS1/31+vIHbH7X0snaWeHc4rHft9zq63eGK54jjKAwUnTf0dR0nGkUMyrMsm
         X8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785802603; x=1786407403;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5xAa6RBMhwgEch+Pl7oGtOo9pFaryzhZJe7EILEPh1o=;
        b=gfs+Hxyzmg4Ka+pFnB+mE6RWyjeG7WDy5jw8ejtTt5FSIk2VszYn2ZW8Uvnl8qeH+x
         HZiBC0a0eFA7CQ0O5EZCN8sj3LIh5+xoJa9YsRmWbeNh7lqkperOEZYnue2K8kAmm5Mm
         sAThyCpZPMxXh4Y7F1z46PhGr2sUEqhhsjZnIHwhAhiREao8JyvYoWNtW/NpVT3wjeK7
         251NZU+QVj5Y2nZmeMDymfWfSSDK2ez3cqwOWK39OFjBmL1H7SbUyB8/FYRRsEe784al
         FzFzj9te01nD2sXBs3JU1YduKvewy9j24sB/79MfTAZTHeMxnJWvHfk0JqpOPC3kJScI
         oJiQ==
X-Gm-Message-State: AOJu0Yzv1yEWBmCCGj7yRXcg47AY1I4CS7O406hvnK8Ra3trhgDZ684o
	VrcSpFvLZ5iVwt66XoKIrMPaI1CBtyunWCIvtZ4pjpWBpXD0Ds7qN8Lz7xKiKnseZd2w6Ooxy+T
	gBTdncMO5F6GS+6PYcfBAyaWn8SEnYoik1aofjInw8+xZHbvokSJ+J98ZwpoCtUrzt0LAxanVUM
	dHVT9j8GI/oa5PPcKumm5ruiA2YmtzSH09bEbPmVZt6g==
X-Gm-Gg: AR+sD11DQhalEuYDY83DpAy9k58h24Xow7nm968x4AjgHvkPc5Srqc7YgYO4e8IeXhc
	UyKNbYLhSXYudhj+qMx5jYV20Zg9EmWAEhlTMS3MqSuMWDIXU+Gw2QWZznU/hGkTNODDCwfN7/A
	TI3W4/OM6UfmJD9C2PsW9drZXh7l3a4atvK7qSGghSd0UzGald9McNrBye05P/KI34tPwD4xcJk
	+6tx0lhIald3I9NKg==
X-Received: by 2002:a05:690c:ecf:b0:81e:695b:585c with SMTP id 00721157ae682-81fd49cbfb5mr165889597b3.4.1785802603032;
        Mon, 03 Aug 2026 17:16:43 -0700 (PDT)
X-Received: by 2002:a05:690c:ecf:b0:81e:695b:585c with SMTP id
 00721157ae682-81fd49cbfb5mr165889257b3.4.1785802602583; Mon, 03 Aug 2026
 17:16:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jiri Vozar <jvozar@redhat.com>
Date: Tue, 4 Aug 2026 02:16:14 +0200
X-Gm-Features: AUfX_mzTp9xEoeY1jgKdDtVsQZjCnRf1n_drXzmhsKQh3-QCRgmptscpHaU-KQU
Message-ID: <CAMgFczCi2Z011dNf84Amc0Q-qnTt0+VUjWY+Y7zPyXdaH35Jvw@mail.gmail.com>
Subject: Subject: [REGRESSION] selinux: ~90% throughput drop in System V IPC
 (msg) since commit 7edea6e8c8e8
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jirka Hladky <jhladky@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Commit 7edea6e8c8e8 ("selinux: beef up isvalid checks") introduces a new
loop in mls_level_isvalid() that causes ~89-94% throughput regression in
System V IPC message queue operations (msgsnd/msgrcv).

The regression affects all architectures (x86_64, aarch64, ppc64le) and
is independent of SELinux enforcement mode (enforcing vs permissive).

Upstream commit:
https://github.com/torvalds/linux/commit/7edea6e8c8e8944e060da6b0b81d66db8d=
5fffcc
Merge commit:    https://github.com/torvalds/linux/commit/231e9d447ea9
(selinux-pr-20260615)
First affected:  v7.2-rc1

## Regression data

Measured with stress-ng msg stressor across multiple machines and
architectures. The percentage is throughput change vs a v6.12 baseline:

  NUMA config | Max drop | Avg drop | Hosts affected
  ------------|----------|----------|-------------------
  1 NUMA      |  -94%    |  -91.5%  | aarch64 5/5, ppc64le 3/3, x86_64 6/21
  2 NUMA      |  -94%    |  -92%    | x86_64 5 hosts
  4 NUMA      |  -94%    |  -90%    | x86_64 4 hosts
  8 NUMA      |  -89%    |  -89%    | x86_64 1 host

Architecture-independent =E2=80=94 confirms the regression is in the kernel=
 code
path, not hardware-specific.

## Root cause

The new loop in security/selinux/ss/mls.c mls_level_isvalid():

    ebitmap_for_each_positive_bit(&levdatum->level.cat, node, bit) {
        if (!sym_name(p, SYM_CATS, bit))
            return false;
    }

iterates over every set bit in the category bitmap (~1024 bits in
standard MCS policy with c0.c1023 range). Each iteration calls
_find_next_bit() + sym_name() (array dereference into
p->sym_val_to_name[SYM_CATS]).

The function is called on every IPC operation via:

    msgsnd() -> security_msg_msg_alloc() -> selinux_msg_msg_alloc_security(=
)
      -> security_context_to_sid_core() -> mls_context_isvalid()
        -> mls_range_isvalid() -> mls_level_isvalid() (x2 per range)

This adds ~2048 iterations of bitmap scanning + array lookups per IPC
operation. SELinux permissive mode does not help (~0.6% difference)
because the overhead is in the validation path, not the enforcement
decision.

## Perf profile evidence

Single-threaded stress-ng --msg 1 -t 60 on x86_64:
  - Baseline (v6.12): ~67,000 msg ops/sec
  - Regressed (v7.2-rc4): ~7,400 msg ops/sec (-89%)

perf top on the regressed kernel shows _find_next_bit and sym_name
dominating kernel CPU time during the msg workload.

## How to reproduce

On any machine with kernel >=3D v7.2 and SELinux enabled:

    # Install stress-ng
    dnf install -y stress-ng

    # Run the msg stressor
    stress-ng --msg 1 -t 60 --metrics-brief

    # Compare with SELinux disabled (requires reboot with selinux=3D0):
    stress-ng --msg 1 -t 60 --metrics-brief

Expected: ~67,000 bogo-ops/sec (as on v6.12)
Actual:   ~7,400 bogo-ops/sec (on v7.2) =E2=80=94 approximately 89% drop

The regression affects any workload that uses System V IPC message queues
at high frequency. Other IPC stressors (sem, shm) may also be affected
to a lesser degree.

## Suggested fix

The ebitmap_for_each_positive_bit loop validates that every category bit
has a corresponding name in the policy symbol table. This is a property
of the policy itself and does not change at runtime. The validation
should be moved to policy load time in
security/selinux/ss/policydb_validate.c (e.g. in validate_level()) and
removed from the hot path in mls_level_isvalid().

Thanks,
Jiri Vozar

