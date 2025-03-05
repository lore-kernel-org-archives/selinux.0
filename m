Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355AC130AC8
	for <selinux@vger.kernel.org>; Wed,  5 Mar 2025 02:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741140891; cv=none; b=lVbIgTNECLE0xfSCDth4cT6rTWQhHVduH5KpQG++1EDPciwLAnAstbiylD4OwkiYb/Bvq00dDOfYtJqfl5tewn20u5Pq5X27OCq+tQD5YL/EQVmxxWjAdj0MoBigP9xy7UnHhoNVBxU3Mx0wCgQ/+HMj/lyUBcwwMOp/myBtWUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741140891; c=relaxed/simple;
	bh=qQ7kaU1aXWa368p5QkZafRlvPh4Fd0DUTFztungHHGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMRyt6GTDgSQRoxzu1Ax7TxkWDPw1WPouj4JXHLH4ZiAY9qmBhVRABtXkV0nz1U0MiILTFujgZY4xgn/SUwvMtlRY+RtBmGlfjfVv/9Fucpno+KjbjXmgjwaqExUO9TwDBv0KNh+rkemoZHidblWVvP/I9HZbFlDeuaWsrboSbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HvgnQkLF; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HvgnQkLF"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e3978c00a5aso4607605276.1
        for <selinux@vger.kernel.org>; Tue, 04 Mar 2025 18:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741140889; x=1741745689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdHvaBKg4GleexXjKKoUyEO9pX5GSxnW4KE6dqvkU54=;
        b=HvgnQkLFwLcFLN4ZPi2E9d9WKKyDc6LC+vLKHcTJjkm4MgWYNtfSRnmZvkZ+ONpDog
         zSI6yu69Lul/YwLMxM82+pJ9XhQnJsbzF29fGYrTvf78PCci05yYK5z3rczvgGFtC1AP
         XJTbPZXmlOMgHxvRXsUlEyXZlCWlSG4yX0d94YypbUjbJUNsorCJnIPR/XQWrOdvuIZ5
         eufCuoFmoepsQGlDuHfAcARmPP+r2OIqiQQBbrzPj1JKmk1skk9Bl/YVsnU5Pa8TwsWu
         5G5N/rDRqNe9Hz15dFNo4GobJjW1vuiy4Ij94xzOJv+iMNWx78QRt9jdtjmHbNyEjIGH
         aRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741140889; x=1741745689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdHvaBKg4GleexXjKKoUyEO9pX5GSxnW4KE6dqvkU54=;
        b=a1lf0jLAz4gUek30wXGOtmAbL6f6U0Ic0QANCv5aG7NxnYHb4NPR6i7/Nk9VS/E3LJ
         HUqm3U7SvPhrfw9VwO1Cdoz/DT1PiH5oJfxKm5ymYB6iTBHIgVYO8wWKslZe13hLPOQK
         xKHREXE+ZubQbKiJ4OjcEudH6Hy9rPfhc1fdsZsU8kOOI4vnqDen6NXZ7Qzy+KGnCee5
         75wb9WN0TbRV52qiV7Dt4W4inNcE8/VgYGSLoZf2PxJCnXZakL70YnS79810G003Tx3B
         hxTLB3oqBIeTLccw3O2us6UuRdYeDN81aS4U8q4j52ZyGaLvNGo89BtTjDCY4YyBWlGX
         hwlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC0ph59ECOxmVNRhP1PDD6v4MdWshfsMeKnm7XAZlArCt/ID6MB06+2uJ1zzHh93/q4BbHAowW@vger.kernel.org
X-Gm-Message-State: AOJu0YxvMj+U6OhAUfc7QONQI46kMnQ8vomsXPL9wsg4Aa0QjMa3by3j
	IJ++qmLNinjXBF2lFD3xkBmfTpj6sVb5+JuoEF5Iq+c5+ggKSmoEPyjge6GBXHh0jV4kR6gjb5s
	fQcOpv8XztnWIEiFerNodlDMQI0vBfzb7c3im
X-Gm-Gg: ASbGnct4pteN2ApWenzxBZDpyfwc1ETLgA9oh4eK0qM4+abDdQQ8vi7YjrxpvYvgH2y
	HncpvAVG/LDFaWoIBNc34aNqwCkyFzWuJhS7T3BZNDI4cVkqZS2cyUH8HlgGfNXZ7fB5kREEfN1
	1eXOv7pHL3HgtykgSxSg7HiwtKnQ==
X-Google-Smtp-Source: AGHT+IFJme71+h5rqacVhXNFVVflQX6fN8c82oiacs7z+wy8sz5kKm1uZj7SdqykCNgwPKPqL++9yJVZA6PUA9xV/X8=
X-Received: by 2002:a05:6902:120b:b0:e60:93c5:9b1f with SMTP id
 3f1490d57ef6-e611e19a06fmr1861920276.6.1741140889157; Tue, 04 Mar 2025
 18:14:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304203123.3935371-1-bboscaccy@linux.microsoft.com>
 <20250304203123.3935371-3-bboscaccy@linux.microsoft.com> <CAHC9VhS5Gnj98K4fBCq3hDXjmj1Zt9WWqoOiTrwH85CDSTGEYA@mail.gmail.com>
 <877c54jmjl.fsf@microsoft.com>
In-Reply-To: <877c54jmjl.fsf@microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 4 Mar 2025 21:14:38 -0500
X-Gm-Features: AQ5f1JphmYgOBnsZGxupPq2rhiEO06B4bjDitVWyy9PS-JrQ5h-eCAMlWkvCD6Y
Message-ID: <CAHC9VhQO_CVeg0sU_prvQ_Z8c9pSB02K3E5s84pngYN1RcxXGQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/2] selftests/bpf: Add is_kernel parameter to
 LSM/bpf test programs
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 8:26=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
> Paul Moore <paul@paul-moore.com> writes:
> > On Tue, Mar 4, 2025 at 3:31=E2=80=AFPM Blaise Boscaccy
> > <bboscaccy@linux.microsoft.com> wrote:
> >>
> >> The security_bpf LSM hook now contains a boolean parameter specifying
> >> whether an invocation of the bpf syscall originated from within the
> >> kernel. Here, we update the function signature of relevant test
> >> programs to include that new parameter.
> >>
> >> Signed-off-by: Blaise Boscaccy bboscaccy@linux.microsoft.com
> >> ---
> >>  tools/testing/selftests/bpf/progs/rcu_read_lock.c           | 3 ++-
> >>  tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c  | 4 ++--
> >>  tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c | 6 +++--=
-
> >>  tools/testing/selftests/bpf/progs/test_lookup_key.c         | 2 +-
> >>  tools/testing/selftests/bpf/progs/test_ptr_untrusted.c      | 2 +-
> >>  tools/testing/selftests/bpf/progs/test_task_under_cgroup.c  | 2 +-
> >>  tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c   | 2 +-
> >>  7 files changed, 11 insertions(+), 10 deletions(-)
> >
> > I see that Song requested that the changes in this patch be split out
> > back in the v3 revision, will that cause git bisect issues if patch
> > 1/2 is applied but patch 2/2 is not, or is there some BPF magic that
> > ensures that the selftests will still run properly?
> >
>
> So there isn't any type checking in the bpf program's function
> arguments against the LSM hook definitions, so it shouldn't cause any
> build issues. To the best of my knowledge, the new is_kernel boolean
> flag will end up living in r3. None of the current tests reference
> that parameter, so if we bisected and ended up on the previous commit,
> the bpf test programs would in a worst-case scenario simply clobber that
> register, which shouldn't effect any test outcomes unless a test program
> was somehow dependent on an uninitialized value in a scratch register.

Esh.  With that in mind, I'd argue that the two patches really should
just be one patch as you did before.  The patches are both pretty
small and obviously related so it really shouldn't be an issue.

However, since we need this patchset in order to properly implement
BPF signature verification I'm not going to make a fuss if Song feels
strongly that the selftest changes should be split into their own
patch.

--=20
paul-moore.com
