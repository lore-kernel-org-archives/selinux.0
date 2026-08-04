Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4720A46AA8A
	for <selinux@vger.kernel.org>; Tue,  4 Aug 2026 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852502; cv=pass; b=TGF9n6RbmRz9ymdGxd6KZn4Kxywa5uHrEisQjHtQSPfQUh7Lueg7KJQqo7663hzGpPiM1CPWymAFnSl9Qbv8Q9T6qskEFFDeF/hXEvlnyuu1A8TeuKlq6HWBR/6nYhdRF9DmJUOzPdbPQciXgPzUyipR8XFISwPPNbErEHeGqwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852502; c=relaxed/simple;
	bh=rHrQjw+x2Rf/S8DrC1bp8MY57mue7A49MndhDYwvcgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CkR7NPzI1S+PC0Kz8anRsxJXMcRb8U66N/PG6GXAHn715ba8PS/llED5H/HGM4uQk4a/6LEMgVKI9fZZ4JAEApWvR5ZKMVnv3d3q49rc1EaOLH8tPb0Pnyvka1+CGHoV/N9snr3r+P+0axDvt/VcDoHOupGRee3a7WIav1+0kho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wq9WPYNd; arc=pass smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wq9WPYNd"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6aaea785032so2781893eaf.2
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2026 07:08:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785852500; cv=none;
        d=google.com; s=arc-20260327;
        b=jqj4L4MzG2n0OBQzXMWB2joYGnWZyFkoagNREoztzfoAkBgeykf7pFl8BVDWnJ2TDH
         3xsAbhpD9N0lodEQk+V4QCbtYD+HIOlZ7yQtA0Lhg4crw+7BuDrAtmF/EyR5RZg/GamQ
         PuacRhxc8e48V/ei6S12hrIAMSCRoUItt+9MmiSZw2XDMXNDmrymM7wrygNUIduq7aQM
         ETwyBXXSypmrHq2Rb9oI7tQL7EOvfXEWOmYiuwS2V/U6jVzFZUVLkrUj0JCNEGOUQ3VQ
         82G+kjAx0I6pgbDkf2Wja3qbNk7xaJWPABGIBNSNXrEpx4oCm+z6GM2Xg0rrcFEhhGA6
         b0uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GGAGetfDjtKcCX+5YEJqapD+KoJu0LU2oLGk3AOUYOw=;
        fh=n4lKbBuAMrZm30RIl+nmHd+m9roBE3t77JZX+sid+8g=;
        b=iSQQ6ItOEfweWcwM80lnS6VUsOc8ocLVdUWLdbg5HOpIFjUcmU5Mzh/z716Cijbzdj
         GdB1dydGiEu8eB+nGrCsupkGcmVa86XBOmdcHAwXWGSpJ6i6xJ4HXNz4lnnBn4xpQw4r
         KcUiuGxKTSnkfwJt7/EjF1wInjunA4TAwdoIHy55/owS1JVflNdnEsueCq9YUEC+DhI4
         eN96oXYbb4XibVOCooDSK8yJcfFvLdpHa9pTv+lUuW6IAMwXCyGLufnmt2oJj0KA0pXK
         cTlkltxx5Dl5R5uZ58i6Um5PLiANxPzawM5NXsmEmdeVuJrDlaINPf6z1OwHWp9pqCQY
         /X/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785852500; x=1786457300; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GGAGetfDjtKcCX+5YEJqapD+KoJu0LU2oLGk3AOUYOw=;
        b=Wq9WPYNdXoQZFIlLKt4ukvwmOeG26oimNF8NHxlLv1cZnPTkwIn5ysx/qSxJUtCCw+
         qpylGWzwp3jNuh8AlKPWlxNpPmrJIu91B6tGa7HOIGstp3BEAMSAjbMW0ZshygqhdHnS
         LscEgWX9MiMpU5S56aZwJmSlnOAuPXFm6jB4QTc+CPATFgZtrkvoz2fqqt79zkGJYEJl
         WErrQ/HfUO1QkcEiOgo6P1mAyB1e4DsxDMWa2up2fOictgkkm0ki8YYvKH/+e1qzt07O
         Al7aib5YKuD+K+1KooGnfwxwY36Uk7TjGsS0RNn7XFEAIkI/AoMf/Xkr8frnaI/m5283
         X1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785852500; x=1786457300;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GGAGetfDjtKcCX+5YEJqapD+KoJu0LU2oLGk3AOUYOw=;
        b=W2ugzUO7Bu8sURGV9aiTGlgKqzxJmdW3bnQFPegnDPbHbKKOi85ShSXaOUEhRk2+WX
         0pamY22KBpRDWpKE2nxnK+ebb5L7PQmlhFGvxcg545oRQOAgfScltIZZ6D6MoKQBnPQW
         DJv29O1+laVdv9XYOr+qVEw1crf2w1tTbndUxFRAkxUkhkRW9RKBI27YDishaKY7m4Tp
         85IVMiRTcEurznFRsQQ0leamClVe9caVonl9xR+6+tefqPszuxbqSWxo8gQpBt3NS292
         ISeqHrOW8Tf/jktiIR+sj9xl+9UU/l34s7CQD4ovma1JzvHWyn6DSxgKNhYAnQEIcbBv
         pj6A==
X-Gm-Message-State: AOJu0YzhwIz/LI/b7QeZFC5Ti/C2GfRzPeadULwpR+Rt42kVFUcZ/mDO
	q8EQQriuV68AYYHChDUuwHHjXiuZXgiRDkJamHKwzMvHmDLW012jFHj4fwkashN5dfodPInkWaW
	ddSgZCJQXF/ZPbe6po3t1moN3JgWBDHc=
X-Gm-Gg: AR+sD13gZ3ilRW8bVrvBztWbAfQInAwsv3MEYE5F2mpH/QvNWX4E7egkV37toqzQsM6
	ppxwctWIkBjHyMPq0TNZZHbVIO5wJjV51An1eg27WNRv+pBKmfJjPGLUZ79nGiNmhynmdaXeMDv
	J9AsHt6vCy0zfMUZ5sL0ZMeNo4uURthfz8EqNjc8mqcIVuIMt1BW2IKYIhtIvb4Cy49/b9TfG/U
	kTMjUlCi7FLwdJQds8b+wLZOfl8OSmIia0dckAW0+4vadCrwRZi7xNNE8b9dKnADciTmpMdvjw2
	1k9nUEkuSDGYQVQVw8xxafZVojcbJk0T14Tdz31Qsji5
X-Received: by 2002:a05:6820:338e:10b0:6a1:77ce:1b09 with SMTP id
 006d021491bc7-6ae4317ba0emr15478298eaf.6.1785852499973; Tue, 04 Aug 2026
 07:08:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMgFczCi2Z011dNf84Amc0Q-qnTt0+VUjWY+Y7zPyXdaH35Jvw@mail.gmail.com>
In-Reply-To: <CAMgFczCi2Z011dNf84Amc0Q-qnTt0+VUjWY+Y7zPyXdaH35Jvw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 4 Aug 2026 10:08:08 -0400
X-Gm-Features: AUfX_mw3HU1op1eOeUEisujY4Qy8U6HBZBPlyvmGjA5z9EhXfEhUAxovCMnHzQE
Message-ID: <CAEjxPJ6mxnTnvvVYZRxe1OYArbCWeaO1VeC6qxu02F+rEKLckw@mail.gmail.com>
Subject: Re: Subject: [REGRESSION] selinux: ~90% throughput drop in System V
 IPC (msg) since commit 7edea6e8c8e8
To: Jiri Vozar <jvozar@redhat.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jirka Hladky <jhladky@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 8:17=E2=80=AFPM Jiri Vozar <jvozar@redhat.com> wrote=
:
>
> Hi,
>
> Commit 7edea6e8c8e8 ("selinux: beef up isvalid checks") introduces a new
> loop in mls_level_isvalid() that causes ~89-94% throughput regression in
> System V IPC message queue operations (msgsnd/msgrcv).
>
> The regression affects all architectures (x86_64, aarch64, ppc64le) and
> is independent of SELinux enforcement mode (enforcing vs permissive).
>
> Upstream commit:
> https://github.com/torvalds/linux/commit/7edea6e8c8e8944e060da6b0b81d66db=
8d5fffcc
> Merge commit:    https://github.com/torvalds/linux/commit/231e9d447ea9
> (selinux-pr-20260615)
> First affected:  v7.2-rc1
>
> ## Regression data
>
> Measured with stress-ng msg stressor across multiple machines and
> architectures. The percentage is throughput change vs a v6.12 baseline:
>
>   NUMA config | Max drop | Avg drop | Hosts affected
>   ------------|----------|----------|-------------------
>   1 NUMA      |  -94%    |  -91.5%  | aarch64 5/5, ppc64le 3/3, x86_64 6/=
21
>   2 NUMA      |  -94%    |  -92%    | x86_64 5 hosts
>   4 NUMA      |  -94%    |  -90%    | x86_64 4 hosts
>   8 NUMA      |  -89%    |  -89%    | x86_64 1 host
>
> Architecture-independent =E2=80=94 confirms the regression is in the kern=
el code
> path, not hardware-specific.
>
> ## Root cause
>
> The new loop in security/selinux/ss/mls.c mls_level_isvalid():
>
>     ebitmap_for_each_positive_bit(&levdatum->level.cat, node, bit) {
>         if (!sym_name(p, SYM_CATS, bit))
>             return false;
>     }
>
> iterates over every set bit in the category bitmap (~1024 bits in
> standard MCS policy with c0.c1023 range). Each iteration calls
> _find_next_bit() + sym_name() (array dereference into
> p->sym_val_to_name[SYM_CATS]).
>
> The function is called on every IPC operation via:
>
>     msgsnd() -> security_msg_msg_alloc() -> selinux_msg_msg_alloc_securit=
y()
>       -> security_context_to_sid_core() -> mls_context_isvalid()
>         -> mls_range_isvalid() -> mls_level_isvalid() (x2 per range)
>
> This adds ~2048 iterations of bitmap scanning + array lookups per IPC
> operation. SELinux permissive mode does not help (~0.6% difference)
> because the overhead is in the validation path, not the enforcement
> decision.
>
> ## Perf profile evidence
>
> Single-threaded stress-ng --msg 1 -t 60 on x86_64:
>   - Baseline (v6.12): ~67,000 msg ops/sec
>   - Regressed (v7.2-rc4): ~7,400 msg ops/sec (-89%)
>
> perf top on the regressed kernel shows _find_next_bit and sym_name
> dominating kernel CPU time during the msg workload.
>
> ## How to reproduce
>
> On any machine with kernel >=3D v7.2 and SELinux enabled:
>
>     # Install stress-ng
>     dnf install -y stress-ng
>
>     # Run the msg stressor
>     stress-ng --msg 1 -t 60 --metrics-brief
>
>     # Compare with SELinux disabled (requires reboot with selinux=3D0):
>     stress-ng --msg 1 -t 60 --metrics-brief
>
> Expected: ~67,000 bogo-ops/sec (as on v6.12)
> Actual:   ~7,400 bogo-ops/sec (on v7.2) =E2=80=94 approximately 89% drop
>
> The regression affects any workload that uses System V IPC message queues
> at high frequency. Other IPC stressors (sem, shm) may also be affected
> to a lesser degree.
>
> ## Suggested fix
>
> The ebitmap_for_each_positive_bit loop validates that every category bit
> has a corresponding name in the policy symbol table. This is a property
> of the policy itself and does not change at runtime. The validation
> should be moved to policy load time in
> security/selinux/ss/policydb_validate.c (e.g. in validate_level()) and
> removed from the hot path in mls_level_isvalid().

Thanks for the report, should be fixed by:
https://lore.kernel.org/selinux/20260804135700.3713-1-stephen.smalley.work@=
gmail.com/
