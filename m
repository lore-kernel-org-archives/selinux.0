Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991265;
	b=i9u9fZSTe6SCOIJuCE5v5i7TvgdPIRtFjh+A+Z8ALPj/LuPOXuC2bCJkmLLtJ6GKYOVC
	 oZBEctCuuwLHjt5A7I8xAezh3PGRufZCUYnyU8LkCMaci838Voib9mfQ0SHF8Iok+F/F7
	 gnDZc6Zu22y2y0utzsh2tSoQaRpsbswC3D7UzU/yUi5lDfNN19D86gKMdklGJSzybTT5e
	 A+DDClH9RkaBi4wyZ6AArMZDwjVe0Gk5QQYUcQkFrwV++EkR1f4HDgNt/Vnyn6ZG4l0Zw
	 M2XU9aJWkF0Ni3b5dNEpkjCEIpHWOjUVKmh5YobxzlgjhSMTnQsHggzVEhjOXEeMR6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991265;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dHyRlSdkltqcZeMf1jrUcxCAJ6NVVXTQAnWbc5asGFU=;
	b=Wa1V6hLgC1JaOvj7DV/IBpSBt74MEh4R5vWjXIxMjSF83q+sJs1IvQy9kZAEJ+tT8357
	 sHv1PLTLBUbITPteuOwlE5Y8V3iLn/biLI2hBEcXoXuO4sk2QwpPGvlslc2Dzsb1NSbFU
	 6HvLx0/nRPv47pLM0Do3RQdQYmLv0HyLpR+Td5O8q8qRJyai57x5ZIXFitxD1BAfLujpm
	 Q4rISheTvaFYensxPa0aiSJjDWsCn85lgT5SqmE+AG9yJNY3onP99miAuBDPHLXT5garZ
	 1DzOwa9WkYfQBLKhC4GXC43wnKwjM7IcuErLXH3MvYdAopZbr2jfCumoY/KKBxBbcAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c01sl7Oc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98B4606A32C;
	Wed, 18 Nov 2026 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c01sl7Oc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C981F000C4;
	Wed, 18 Nov 2026 08:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794991264;
	bh=dHyRlSdkltqcZeMf1jrUcxCAJ6NVVXTQAnWbc5asGFU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=c01sl7OcESMWPKtmEKD/19B1/NOwQUnQQY0Pt5NdSRofsYPWYxyVhxhYkNuPBolV/
	 UR6xDV1Ji8Uz58N6WHRQ9tNrfWvViBNFAAYU/IAAqNahcPtv+0eyb3g8zmVaINyW2Q
	 JAQ6dJR3g9xX9djLrPL2e6pZq1hTt4g59lbo9+WnMWSEYeuSLaMqgfEvmxpE1m3Be8
	 37u477rfWwjJBjcxKLCQl6jjB7viHueIdYSck3CBiGbpduLFNJWb5LiLrPfhSvjWw6
	 S7DuTRiYW+JLhu2Tf96avL0rNAlzF+rqVgtnyExA5GHhazKWFiL66tELked/dqhgi2
	 YtiNostyrqSAA==
Message-ID: <sashiko-outbox-220473@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/8] selinux: Restrict memcg charging to a cgroupfd
 target
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261117-v2_20230123_tjmercier_google_com-v5-7-1ce975f2a9ad@redhat.com>
References: <20261117-v2_20230123_tjmercier_google_com-v5-0-1ce975f2a9ad@redhat.com>
 <20261117-v2_20230123_tjmercier_google_com-v5-7-1ce975f2a9ad@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 08:41:04 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> The security_memcg_charge_cgroup() hook allows security modules to
> control which processes may charge memcg memory to an arbitrary cgroup
> named by a cgroupfd passed in charge_fd. Without a policy
> implementation, the hook is a no-op, so a domain that has both
> dma-heap access and CAP_SYS_RESOURCE can charge any cgroup outside
> its own subtree, and SELinux cannot say which targets are acceptable.
>=20
> Implement selinux_memcg_charge_cgroup() using avc_has_perm() with a
> new cgroup object class and a charge_to permission. This is the
> counterpart of the process2 charge_to permission used for the pidfd
> path.
>=20
> The target SID is the SID of the inode of the cgroup directory the
> cgroupfd refers to, so access control follows the cgroup filesystem
> labeling. Policy authors can then grant cross-cgroup charging selectively,
> for example:
>=20
>   allow allocator_app_t cgroup_t:cgroup charge_to;
>=20
> Signed-off-by: Albert Esteve <aesteve@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-v2_2023012=
3_tjmercier_google_com-v5-0-1ce975f2a9ad@redhat.com?part=3D7

