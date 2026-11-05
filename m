Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914817;
	b=S6q0TuPOr+kKocEVmFTi2niMq/Rn0N/afgeirL5/JcxVwkJo5n64KFvZgCo+P2B9U03s
	 3ltGn54OB4NgrGqy39190WXyq611pp4rlz7gJQVaWMhf8oUtgOuhFEshvuzsJnbdvTl1W
	 lSqepLF26HhiBVHRKGVP3QQeFjBzTBHPtIe0801TR//zlPrIcwJeXn3XhTfDQCO30qx5c
	 gWhzcG5prpLDvQI1ud7bp6buFMt5Y3fbD93UbmvzN9cTGErLOS9SoZ7rZzPqDk1Y8rHqz
	 GEJIHBWMUzvczyhYQR0ij30T0WsfPnHWcW7E1g4j1QsJqV0u1ql18/38Kfwr8IBp15A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914817;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=I5ZbK11ExVAE4v3QfleeRKxYEDdW/5tPyP3a98PUwMQ=;
	b=UhbRVycR/SWZN/Q1lZ/KCm/PGfXb3qo0QrNnLQjK3EPQ8emuMEr9tMDUn2qaEkTA5HO5
	 JhH4BXpkJMNZlkrddycKA3SdGPj15CAdmK3bREralUCnIAoKnMCSUGXEDhqA4wDMRSOez
	 Q2D68aiavUJqNcHl28i/NqpJuXjPxEUMM82nskX8l6Ljsr7qe9n5AFNFjIML5WDPdC5D6
	 AA4iaK/IkB9VA/CxQg7MFa2sCChbwuhny5QJeSq6yeMlChdIg3wiEkwnSSJ+lxKUbQMCq
	 pT3tB58trcYtjI6ALDqgWEPUk0ptfEXDMlPyPbLd5xmJoBF1kh2FavPak0utnItGurA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iySj4IsP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431A0606A31B;
	Thu,  5 Nov 2026 21:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iySj4IsP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960491F0089F;
	Thu,  5 Nov 2026 21:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914816;
	bh=I5ZbK11ExVAE4v3QfleeRKxYEDdW/5tPyP3a98PUwMQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iySj4IsPBkTSNapH7oKBlF7bZZGp8jeWgldqxoYumoVjLo16RHv/ufkJQ0YZF+QJ7
	 +vCoSMbZoHWeGI1ScWZfaOw3qzp9ZozdtZ/ngRI0mdRvpoxAXxncyjtf5JGxYxGlWe
	 f1Yd5hfQkpW++rPXtFln3Bv5alMNhXcv6WSYhgFekv1iMl9Gkbj59DZjE+heow/kNh
	 2HFwy0QIFojySaA4qpui9KnqnMqaikpwz5Jhg8U3GYJF4wKyPQ+Mxbze+cPgMwoWOn
	 GH7O7aS/ZrDt1bBrtmk3rdDxum5xP8rUhjEzPwIfr2JJ5xOYnnzKWccso+zU4jBBQT
	 Hpd9oyiYshMuw==
Message-ID: <sashiko-outbox-200253@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/13] mm: convert THP VMA flag tests to use vma_flags_t
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: damon@lists.linux.dev, linux-perf-users@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261105-late-2026-vma-flags-v1-5-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-5-0d3cd15ab75f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:40:16 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> Replace use of the legacy vm_flags_t flags with vma_flags_t values where
> VMA flags are tested directly in the THP and khugepaged logic.
>=20
> The thp_vma_allowable_orders() family of functions, hugepage_madvise() and
> khugepaged_enter_vma() continue to take legacy flags for the time being.
>=20
> Also update BUG_ON()'s to VM_WARN_ON_ONCE() while here.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-late-2026-=
vma-flags-v1-0-0d3cd15ab75f@kernel.org?part=3D5

