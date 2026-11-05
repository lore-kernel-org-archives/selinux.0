Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915083;
	b=jhEFsmcLeb6hCyQa+hVnp4WrQeEj8ZjfsA1Zxh9qY/IY3Dj5xpkGpGDXiZyqD0O9wxs2
	 xhptg24fNi2cMpPDofCP5KX2XrSOBIW4acr/tCzpS9zFeT6u/0ijrkVSC10l7zwtoE+uu
	 8C0udxob490Np5qu2vsKmPYZ1XgcRnxcp/9CS62LDGk0Ara89W+cW/epfIMsP6VQLhjQL
	 J+E2Yvp8bLKlMsKcqJ0Eyr73FIP2F/TCl4FwNZKv1JOEZs/L8dhQq1+jzOqz51BrgHOhs
	 oo1V3Zz+dLch25ujA4l5yCijtOA3bM9BPO9smLKOAHIs6Kn3FV+nzhKqSVVi4mPFlJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915083;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7fBR11NjQkC0kJgcunNPg0BoqXA8QbVby5YwCiGASjI=;
	b=M5KKW/JYTs/0BNw2On4fUI3zsKC0fM8A+SdsIhhHyAfpXHm6NmyGVBghcmOJK64oE+SX
	 MNJFtGMzaQGRBGa8EEpbvWYHfXiwwnbOgZtlNsdlDu/NKO8qcaais2htFptHWD3NqF8WO
	 7CSSjw0qdvAdNPg5Vim8grmEYftabB+dBBVAqc2ZIE1dXeZJNoeXNBWZxgDTJiO21k8GR
	 6peNUoKWICkhrm4LLmkO56BoK84UML+LL9PncSUM+nha2+UZUsAunbv5MNfmWMiqJffOk
	 fBqIJ+uQNbgn++kVn8TDhe08URDgrogDwsyljf3vlgJBxNLjZBVEox+yIjrvVdyZVng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k0rkHK6G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD83C606A31B;
	Thu,  5 Nov 2026 21:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k0rkHK6G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202F31F0089F;
	Thu,  5 Nov 2026 21:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793915082;
	bh=7fBR11NjQkC0kJgcunNPg0BoqXA8QbVby5YwCiGASjI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k0rkHK6GUgyt1uJGEI/Gi9eP+OZqhXDdlkwci0Dfd6YkpOsSEMr6YLmTtR6vqB9YW
	 QUtwGziXsEix/NsTNE775EEzwCk3VIMifDYwsc3/xsdXptdccEefsi1+Xzoi7H5tbK
	 LqCxt145SETIEOt8rjOlYmHn/Z3e8O5cGfO8pC4oa+bpx68/vB4VcPFMDtGSbOrvxU
	 ci/SA9ej9XS5wor9o6yoTlaiynOC7Y3qlEqKp97b1sIF3+Wqp0G5qsGmyL9GWDSsWL
	 wdv6zlpLowW1xzNXf/ttpiffp1v9Z1BDvRCXjUHB4BKi4GdzATwfIAyELQp1PULNdD
	 I2IlEZN2cTGVg==
Message-ID: <sashiko-outbox-200265@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/13] uprobes: convert VMA flag tests to use
 vma_flags_t
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: damon@lists.linux.dev, linux-perf-users@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261105-late-2026-vma-flags-v1-11-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-11-0d3cd15ab75f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:44:41 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
> uprobes VMA validity checks.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-late-2026-=
vma-flags-v1-0-0d3cd15ab75f@kernel.org?part=3D11

