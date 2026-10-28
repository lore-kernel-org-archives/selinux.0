Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793199877;
	b=0NM0PyUIAUUJvEv8SATsFXSScUS41QRpFavhKo/48JwS36vwaOH8AvI3xhGl3uWYhY3q
	 6bLOZ/GH2aQ1XBMRQafUTCMjT1INzTO1MVDUWDPKB84w4MMn5OyYYSCfHfOHLP1baXzMq
	 KJkU/FC3MO3QHTrzV+oHZPU9fPrTCJNbS9s0my1/btyNpPILzepI4sIGHy3fHUm7/qA1R
	 nNH0tz+QerAzOYZ2IQ9UQmSHjgY1zCdEqoUMw+21/1A/p25ID59d6N4hhtCD9Ta39vIVe
	 SVPVhFF0lWyHXqCqXsnn/UTq8zY+7j3FRPRvlcglFxEto3XSeI9oQgFi60pnnL5IF1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199877;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3f2Dr45h7PNcfHjvnX+ri3NLUvOB3uUWK9u5izND67s=;
	b=uWGwOpGN6QKev+hh/nGpiMY5xyrk/paayThPV+/u5Xls5p4CUTgIoJiJagBOk6QihRaU
	 Q+6b0B90l5QJfKZ4qkt1JFEM3SOIN4mlWmeI4K8tOPV4D6BVfMe+W4lB1dZRyfi6glSaL
	 q0h6FMNGI5pLU+ddndZ2LpWTtJ2JmZDI9Q/X7GOgEWx4lFd+1zUV97wLqjZE9eoEMZL+w
	 th0ZgQqBNV82Pzu/GmIPDM4ma2hE8/8aa4Y2SpkYyXMVz8Hk9ezXYY1qb1H9VqdGFa/ct
	 kJGe7/lSNwwFZCjsCQvVOnbDFhjNUf/tWZjHc8zRuxHTsbvpx4BZ46jo9chtlILJKbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fSiI8rlS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97DE606A325;
	Wed, 28 Oct 2026 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fSiI8rlS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6835F1F01825;
	Wed, 28 Oct 2026 15:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793199876;
	bh=3f2Dr45h7PNcfHjvnX+ri3NLUvOB3uUWK9u5izND67s=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=fSiI8rlSaeEt5ShBG9V9NiRMF0KZaU088WR8FpEBadtx6E0vkUwQTiTmmw9kCn1bB
	 RqKjlgSoew+tN2ALrmjwmPb5v2Omv8oyw6LfFf3ODi495Xx99FnJLf0bTRz8H0Io+Y
	 TirmEOKloUog6kxaNIJKUBO9Xzq4HxDMW4sebRGkhiAl8zP8XbqUkMqE1EGcRIddkG
	 xGq+gr36dZkNBOFKOppnXGZY00ZfplIvcnCIxTstFLWOXYm8apyaFzRm4uudnyOkFB
	 HvgVNBqSeYPHOhQlNwwBn/unkcprdtw3AaVs1VDiG+HT+IYOiDaG0U00riQdG8WsUG
	 vfmvU2YjP4TYA==
Message-ID: <sashiko-outbox-188029@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/8] security: dma-buf: Add dma_buf_charge_cgroup LSM
 hook
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261027-v2_20230123_tjmercier_google_com-v3-4-78d2c4cb8647@redhat.com>
References: <20261027-v2_20230123_tjmercier_google_com-v3-0-78d2c4cb8647@redhat.com>
 <20261027-v2_20230123_tjmercier_google_com-v3-4-78d2c4cb8647@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 15:04:36 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-v2_2023012=
3_tjmercier_google_com-v3-0-78d2c4cb8647@redhat.com?part=3D4

