Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991263;
	b=JhTBNFAYwxMUg8E3yKSNsjDioQv0Df2a5TmCBRIzUcqst/8ODIezytOkPDp+GNa29gV+
	 DYCdCgEUXt6+6AXnS7GOpRYOI3/gzFrsXB7bdftfWX8nVgxwRML4LYJrNnlF2XqvLc5/O
	 wuEIBuVv8ILTE6oHJkwIBRXb1rbht6vQqRNItnmQqL+32UwQjyD1hLlanlPf1fJijo6GB
	 f8s1tCR4/ovL/2tWZahxDBFSDtfM1M4A27YEVhjCNMzScrgybmLpTTbqzRRpdjLspSk/Z
	 tlqP/2GELIDH65kLjA/3uob+8H93oUqpTT4glaS8dMJgjmlZgBJc9EokR242nR2UsAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991263;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=F29z9e7KF0F4Jh3CCcCzRf0cVZh+UsUwjiXdxNtgO4M=;
	b=s9MVwQuK+0gu+Tq/E8QAT72SONGKUlAwQl1IHAKoLDE8vVp8Rg5blG8/n8VNmJj1Rfxw
	 YGFUnhuoqMmoiJU4CAgvEcj08TkQAJypiwSc83oREUXuyKyz9pviaPwSrcSc2jRrHFwaf
	 RjD02MGXLtoXdFZslqJsmbZBROq8rDIw9frVIgl7trQ2/yaVflkJ6ugjrQhH6ckIT6KTX
	 JeSMr9i7ZnAymLPneqe/435LYQ31bgKQ+wOp4hBAR6plQp3/dH6f3bFCNMKDxMWia+p6C
	 XKRdkmwZkI7PwRXtE5917uW5kB9Wx/zW6XI5YlFeJjLIOgGo6ew9ANQM1p52FiZy/pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EuDn3K1C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34493606A32C;
	Wed, 18 Nov 2026 08:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EuDn3K1C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B411B1F000C5;
	Wed, 18 Nov 2026 08:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794991262;
	bh=F29z9e7KF0F4Jh3CCcCzRf0cVZh+UsUwjiXdxNtgO4M=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=EuDn3K1C/u5OajpNSicfvH+l91PjwQBIqQUpEClzr4vfO9YiHIZ6ACpEbW4vFwkb3
	 +2jBa4zTPS5AyHSfLfEpu4YjXIwIcB4fs6zaoWsV0wPDpjzPLj5/RI5sOicn/m1vVA
	 ozDhUxGP0RhPCZkeEj20romQZincJdATpLLD7e1FVXIwEF6os+WLixWlVYKEmzxOdS
	 k9Rs5TYu9wMyAFdUo6IzINp0Gt0iqdOu0kTmYS5gRW9O4jWydzc8HAh3eSiSTSaRKA
	 hI9N5RalRBQMuPLNxKR4WNeUrR7+cVIcpYMZnNbSWy0OEA7gRlaYQDz0Z7SNyPI0XO
	 dMNV2kjWg2HtQ==
Message-ID: <sashiko-outbox-220470@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/8] lsm: Add memcg_charge_task LSM hook
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261117-v2_20230123_tjmercier_google_com-v5-4-1ce975f2a9ad@redhat.com>
References: <20261117-v2_20230123_tjmercier_google_com-v5-0-1ce975f2a9ad@redhat.com>
 <20261117-v2_20230123_tjmercier_google_com-v5-4-1ce975f2a9ad@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 08:41:02 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> Both DMA_HEAP_IOCTL_ALLOC and the new DMA_BUF_IOCTL_XFER_CHARGE ioctl
> accept a charge_fd field that, when set, causes the allocation to be
> charged to an arbitrary process's cgroup rather than the caller's.
>=20
> Charging is currently limited to the caller's own memcg subtree unless
> the caller holds CAP_SYS_RESOURCE. But the capability is all-or-nothing.
> A process holding it, along with a dma-heap device node or a dma-buf
> fd can charge unlimited memory to any other process's cgroup, potentially
> exhausting that cgroup's limit and triggering OOM kills independent of
> the victim's own activity or privileges.
>=20
> Add security_memcg_charge_task(), called in get_obj_cgroup_from_fd()
> when charge_fd refers to another process. The hook receives
> the credentials of the allocating process (from) and the credentials
> of the process whose cgroup will be charged (to), giving security
> modules a controlled enforcement point for cross-cgroup objcg
> attribution policy.
>=20
> When CONFIG_SECURITY is not set the hook compiles to an inline
> returning 0, adding no overhead to the fast path.
>=20
> Signed-off-by: Albert Esteve <aesteve@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-v2_2023012=
3_tjmercier_google_com-v5-0-1ce975f2a9ad@redhat.com?part=3D4

