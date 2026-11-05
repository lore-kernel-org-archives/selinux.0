Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914858;
	b=COKu46ZH57EmxBjKYXDZgY7Fqkzp3OkLuIIhLFxIT6se6wZxCdXHZ8UBAp95/IoyaCMc
	 EuHPTTfA9IKvJRSO7EJGDVXT2p4TIcDjRt+g9vX1v4KMeVn1GM9Mcqx9ifq43jVNWpGQm
	 pImEmOddTHnm2DdyXZYkbNGftD6Z/KWDabXp41WTEmeCweN/E6IKK1uM8+Wa4it0AOZqB
	 Mx6yOnATF3daUNuJOlxUhXu8oCy7B5BhRWHSGS3d7KPWvB3yMaf7y1XAmsbxZZvptsedw
	 CmbL7mV7r8r7jOxkiw7UTOEQ4et5jJpvgAcQjHmLcywxjGitwd8f+P7QosOpABQ6Tow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914858;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=B5F9CU4qk68h10QWjCWXHpfIyhS6gtlFnDZjnLVpfKM=;
	b=RmU4Hx36gNVxkj1vJh/nbH76OdwlGpFZAvWP9W8awIl1KpFTqcdDRMM24ev4vkafENNf
	 ZF1dxElxSLNOHuY2LyxFWEKlfYG/d2Zi/JzKxO+oim0ACV5yCW4dOGDjXEy4ZWbVWkfKR
	 BYK1PapJVyL0XstjJGwrzEVjzHa9DZu7fxF8CGkWWX8cLbqrzSuTB7W7Tb44RD8+VmvkV
	 26Bjzq9iDDur+p8UYUg/RkFb+jzqDTQnvD5sneo4PtK1ICrncUnFscAj02sDDDoJzl8MA
	 SOm9cSBLxgkkSjHZuD+krdFUwDF2yzl3/k+EmM/fHW7BwEMH5sW4UWa5zGauUh7lXgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ciJduEXS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7560606A329;
	Thu,  5 Nov 2026 21:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ciJduEXS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3F31F008A1;
	Thu,  5 Nov 2026 21:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914858;
	bh=B5F9CU4qk68h10QWjCWXHpfIyhS6gtlFnDZjnLVpfKM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ciJduEXSQ6eKsD6gHjuJ3FkiXWuVXaai6UEI86oD92ZKCj4t5aMVQYB+GzYdzK+tK
	 4d7V6glm9MQpEv53+TmqUPDQAxiqZpfg6n9lgwwUw/+b4NpX5IffkKwK1F4p92a5WS
	 mOTlL4EaIDzZVINF47joMianFf6smpsk44s7LXH0tOL28DzwGgm8R0a9T0dxR8ZPvD
	 X3pfv7vQmXbcPj4yOSdCbbLvz0Zj92BVZXRXsbaqLwANdyyDjUC3yan10Al3JffvWn
	 c273f894qnT3/MoLqSispROjzce1HAvKmCsYUS0Zm2MeQ0t0C/9SByRl75Lt50GvTB
	 QcpTC7Ga2iIUA==
Message-ID: <sashiko-outbox-200255@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/13] mm/ksm: convert VMA flag tests to use vma_flags_t
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: damon@lists.linux.dev, linux-perf-users@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261105-late-2026-vma-flags-v1-6-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-6-0d3cd15ab75f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:40:57 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> Replace use of the legacy vm_flags_t flags with vma_flags_t values where
> KSM tests VMA flags directly.
>=20
> The ksm_madvise() interface continues to take legacy flags for the time
> being.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-late-2026-=
vma-flags-v1-0-0d3cd15ab75f@kernel.org?part=3D6

