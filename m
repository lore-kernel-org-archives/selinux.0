Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793877121;
	b=hOYr0qxGEMEIs9bfjsDXEFKctrllF8wT4SonhZ/1ec0wC6MRy+t+cIAWJ+0BNls/YKXf
	 2Q3w4FNx+0vMD/omliUV4u18HQ0uGGP6z2g5QjHkQABBJHrmEtLGZGfNOeeT2eKOJhgr2
	 enJ78rM5NPhu5rKO+o0N19QxnzQlXaccP/p074D33cUXH++4Jh+H+bOuOXa6q9H4g9WVn
	 fcGdMjuWq0I4vaP6tA3XX8Nsfu7xXF+c5mK/PoTF9BMSG7UZiR/g2XJv5aJ14RchIQkDL
	 4Q16NDLULVDsjg0X/a70yPW0jgf40l+oZQe6bvHuieoqAeSm8l3Mz23RzcdNzHGv/Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877121;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hWl89WsNtHGMISmYOPuNJlVm7M056W4dG2Ab7v2U/4c=;
	b=AMTnVxpq7BUSY3MFqVWzxAkXFDi1rw7vZeyDrTTxv0kuEFIqgbmBqeL4PuOFV3jYIc73
	 hR9K+GxLz/JmGwq2KKpBlcfeWLA9u5IsrEqQajCKpYb/N5dzJ4jRl2LQyNHPyd2zU9v+r
	 BnY6V3j91S5UBXcjiLfr2cvndLlfvaXL5kN9S15VHd9jJV3CQ4d6EIrDlXGbUJHBuz3o0
	 C5opHgjhaB5Yz1d501BF64uUoItbQ5G/th5DCunGD+fs7YK4lygx5ajfc8WUVUN5WC/mx
	 A40QyMaacdygdklq1jGnTkjW04f5sqfuKyWbABTnh4m0nQHO9eO2NjNa4YKfNSPHxyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9FmAgCr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA8B6082BD0;
	Thu,  5 Nov 2026 11:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9FmAgCr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163AC1F00A17;
	Thu,  5 Nov 2026 11:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793877121;
	bh=hWl89WsNtHGMISmYOPuNJlVm7M056W4dG2Ab7v2U/4c=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=d9FmAgCr4ToXkCghoQayPcgSuNta6AjlA4D6T8ijVJjpHCzCbtsIZVpXu5xdWztcF
	 Ka4YEyMiZxr9rTE9Ba8f81TFXCoZoxbvjd73FqC0AS41a7qocqdmBiADLMuwrI/bI7
	 dv4lSpHnFE9jGZ8+dGJDiolPJUwUt1OvzJIbLPAF3BGkBXfZrTVlLtpCr3zWAvfuMo
	 cRRaF28l3EGzZGkwo1bMyWi34pyu/I7/0XzvLy/UAzHLaygo/tuY0lZSZiYyM6zEpL
	 kLzor0+caDMtoMtCr7H6s0D4r5SXba8ljfT3UMSVqITQwTP3btsT2sqFwqnHpBE9E6
	 3Ll41p5jYhsGQ==
Message-ID: <sashiko-outbox-198920@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/8] security: dma-buf: Add dma_buf_charge_cgroup LSM
 hook
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261104-v2_20230123_tjmercier_google_com-v4-5-1819a017000b@redhat.com>
References: <20261104-v2_20230123_tjmercier_google_com-v4-0-1819a017000b@redhat.com>
 <20261104-v2_20230123_tjmercier_google_com-v4-5-1819a017000b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 11:12:00 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> Similar to how security_dma_buf_charge_task adds an
> access-control point for pidfd for the charge_fd of a
> DMA_HEAP_IOCTL_ALLOC ioctl, we need a new access-control
> point for the case where charge_fd represents a cgroupfd.
>=20
> Add security_dma_buf_charge_cgroup(), called in
> mem_cgroup_get_from_fd() when charge_fd refers to a cgroup.
> The hook receives the credentials of the requesting process (cred)
> and the target cgroup to charge (cgrp), giving security modules
> a controlled enforcement point for cross-cgroup dma-buf attribution
> policy.
>=20
> When CONFIG_SECURITY is not set the hook compiles to an inline
> returning 0, adding no overhead to the fast path.
>=20
> Signed-off-by: Albert Esteve <aesteve@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-v2_2023012=
3_tjmercier_google_com-v4-0-1819a017000b@redhat.com?part=3D5

