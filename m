Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991259;
	b=UWeYuy54dyfpyWIF/We84hQuv+Gfgf8p4ujsOshpzC+pHSW/qCzQwq0gSU1xei6QwEls
	 Z74Jy5en/ieDQmyqCq2arm0038XIpzdC754wzvmJbCu01ps3rPZH8gcrM7fL1cwHjEzKS
	 RkK9JPP2PcDqgOo9Q1oI9VsPjvq9NkA1Q54f8Jcnj6M3FQ2fO2V7/99NU/RqGuq+YaS+l
	 LVzvXKkp8l4ukkBMAlNoGrxUIEDxgqkxFoher4edz2ijvYBYtCdEK6Tz8xg5D12JGEPuJ
	 NzueiEH0EAc5sY68oxhiF3MBDc/vLusoRzCXBRQExhtnblkfQEL0/gW91fbP53Gm6Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991259;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0yAQvr+WSyYa/0N7oGo+OtcVMt1v5AqR9KXDvs4kdJc=;
	b=InE0Y4eJS085GNsnTy7hhqFl+O61RweAusoOl/czXocaMUmvpz/pbUmAj72PLGIPHVSs
	 nFUBV2ZLMk9EptaP3XJDFzJP6zbB4uofqZQRHsZbobPPv5NWnRPFhYdMGLDpXM+X3H7uq
	 GTI57T5oeOCH0sppYTOVYPj+7BeT+ZKfJB9+xPHERgtGPcWaV8xEDOLQofT1SwGl+bexO
	 1Uq8dDdOr8NGypYEq13oUCLApwX3BU73wW7U63HF2r1yXbS6sI4LsWfp78rsxFDs1nicf
	 G58BJxZciOExKA0CoJJkkV5Evk3+Tl3oIZW4FVNcf6alUb5uZTc0h9UgbFHX+ALWbsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IOLWVkLT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC12606A325;
	Wed, 18 Nov 2026 08:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IOLWVkLT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC8B1F000C4;
	Wed, 18 Nov 2026 08:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794991259;
	bh=0yAQvr+WSyYa/0N7oGo+OtcVMt1v5AqR9KXDvs4kdJc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=IOLWVkLTuDLjUhqxCEPoZm4YLwms6my01bRYlTUtmQvB44pKbyL8MAtiDNd5gI7Pn
	 W7emgTmcJeI/iLvFMeek3BAbolul1IDAn40wyKJQaSSbAzPDSSdZ+FICDx12CrcXNI
	 nBkA6I9fWJPBLK5JUn10270XP84XgoM4wgv1/UYDyxzUYdxKdCvNu7m9YAPW4LICjs
	 kEBjHX0EHCvuHnTTWbTQ2UWHUDuI+XqPjUQKcRKBkUpPPhPAr37cJyrEonduvLv0cl
	 h9cqC5ogrJ9TPmPskjzHfZN5/o/92kUc5aOi+Q7vBimqIcZKJUwiSjonf2OXY9ms/D
	 1aSniSAVa55xg==
Message-ID: <sashiko-outbox-220467@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/8] memcg: Add MEMCG_DMABUF accounting
 infrastructure
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261117-v2_20230123_tjmercier_google_com-v5-1-1ce975f2a9ad@redhat.com>
References: <20261117-v2_20230123_tjmercier_google_com-v5-0-1ce975f2a9ad@redhat.com>
 <20261117-v2_20230123_tjmercier_google_com-v5-1-1ce975f2a9ad@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 08:40:58 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> From: "T.J. Mercier" <tjmercier@google.com>
>=20
> Introduce a MEMCG_DMABUF stat counter and helpers for charging,
> cancelling, and uncharging dma-buf memory against a memory cgroup.
>=20
> The charge is tracked on struct dma_buf via a new objcg pointer.
> The object cgroup reference is stored into (or cleared from)
> dmabuf->objcg by the helpers, removing the need for callers to manage
> those details. The release path in dma_buf_release() is reduced to a
> single mem_cgroup_uncharge_dmabuf() call.
>=20
> obj_cgroup_reserve_dmabuf() takes nr_pages as unsigned long and
> rejects values above INT_MAX. This differs from the rest of memcg
> API. Specifically, dma-buf sizes can be userspace-controlled
> and long-sized (size_t), while memcg charge and stat updates are
> int-sized. Charges that pass the reservation are therefore safe
> to handle as unsigned int in the export, transfer, and uncharge
> paths.
>=20
> Rather than charging at the page level via __GFP_ACCOUNT, which
> would require exporters to expose their backing pages for
> cross-cgroup transfer via new dma_buf_ops, charges are tracked
> externally on struct dma_buf through a single accounting path.
>=20
> The next patch wires up the charging policy in the dma-heap ioctl.
>=20
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-v2_2023012=
3_tjmercier_google_com-v5-0-1ce975f2a9ad@redhat.com?part=3D1

