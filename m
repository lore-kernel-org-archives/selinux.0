Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416089;
	b=2nncOutKUEIitlWkSV4ZXFtbzDDN4se6pEmKJHMqJP7vf3a0nM+BoxXgDH1kM00ju27a
	 7DW2LAYIa34rMILqX56pxJLrnfVchXtdUsKRMzOf7AErcKEGh/4zAbW/svcnwrEq20kjH
	 7ataJ5ou9Y4Je2FIROXnSfeoR90UQkR/lt38AdAzVpJG3YpgS0ipPTMAD4A3/9buZb/lc
	 ckZdRquXaCzEToagOGK7tQo6A7MYwkkJUbRgF8Sr2o/BSkdKACsunRXOVnb0lBWZBDjnd
	 BP0FWqGPwAtUhs7iXYINFDv3KHqaPif/w+zRFIwfZXkr2MdTmmsvkPdo2e+epTU1Ekw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416089;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=o7e5a3iYb/7SZYqBLx3IDoaGlBICGwaDdMboMFs5Anw=;
	b=He45Irf/ir1CwQNBDGURwo/xdiAcYzFgTtMiphZMuZ3LJ1/m/YEDSCDhQ1hDX/lcR/5e
	 ddHORpGfCJS+L6DtxKGs7FoouoI6/e+EU07jjr0Pvq1m/Z07HeXjMZiPv91Kz+RlpZUxA
	 zUz45Z91XXXT+a8X7lD7bIL6WdolywSYtlGuaAjSvc9w7oSPlyFTrodI0E4aLW96Cq0Cb
	 1bj8w0yO6EmLvtegJCMnL+y9CsMu0ZH7N6ZKdWTXRUOjafPnxSipuGi54hDNKn1+H+A1z
	 1ueyYCN0JHt//Gxp4h3I0W121NKjr0BAGlJRqYo226dMM+d/jJ7ebECmdc4EB/lFQnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FedD36ny;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28079606A321
	for <selinux@vger.kernel.org>; Wed, 11 Nov 2026 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FedD36ny
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D982B1F00A05
	for <selinux@vger.kernel.org>; Wed, 11 Nov 2026 16:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794416089;
	bh=o7e5a3iYb/7SZYqBLx3IDoaGlBICGwaDdMboMFs5Anw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=FedD36nyzCdUf1+RttmUmQpXLm8WEspYZSQ4RIrSJZoiJCnWrxnd6SHbx+URdrx/S
	 aV1MvA1PKNWFMQoztTk7UfzXlyWOSgTf0ibvOGCq2kPYiuLnx3+aH4p+5FeGBV2tiO
	 hUPAf1uvfMQEgwvcfhAC6OSvOLc1qlyD3HfYASV3HZqluIs5JtBKykmAyof6p9vR+B
	 WPtylKTS2+Tc6p6mHQCb8TWCJ852mLzK5XyKG4Zt1l9nx/PuncKn/AFkSMt63GDRr2
	 j0JbTvGqJ2tEdhVhWPKgrVyzkY0oIc26uQ63RsYQ2QaG4Y45s1Eh5TNLx2kssUpOz+
	 tDj292hzmMYUg==
Message-ID: <sashiko-outbox-209338@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND] selinux: use isdigit() in
 selinux_genfs_get_sid()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20261111164040.77543-2-blum@kernel.org>
References: <20261111164040.77543-2-blum@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 16:54:48 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> Use isdigit() to replace the open-coded implementation.
>=20
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111164040.7754=
3-2-blum@kernel.org?part=3D1

