Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914765;
	b=J0U/n/QUY+fLCptRohh68YLXqVQnd+zvEPj9iPMSwt84S8BguZ6oY7BF7KPiJvr16Tez
	 HLEZMo0WV0VNDyrFKR3rwKA121b/yQ6Y05hVaqtyLRGqHnPU0G2LuDzFvs1sEUxw53MRN
	 pjNJc0A6RNUIXeS1Oy6KjGgPuo4IockwZDvKBZ/q/Je/jsY4POm9TGjQBac7B62jjhhEu
	 XdwtTZIYWpTY33wayJppF8Fv26kj0zxNKRJ7UXzFUlMC2kMOGutD79Dh+UXALrDuixPPN
	 SZudi0U3ag5uLyov5RPsy87SSNRJApFfMDEn4Jq0gWYZjCsFU+TG5uWHFxhHjKCHGpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914765;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JTpiJ9Hx6bH2s7DX99mLQj0l+RTHEk4py36qs0ElKZI=;
	b=MD8i2oQuinQN1UnUYG272NU6b5HVKi/k9UnisQe14h7Qtsl7j0Y2jDP02xGWf92oP+yo
	 WFaoYWukhW70KNPP2YBMJmbrq5wUM9gA4dXbD92Ir4wN3zJna/i1PsmJtQQW9ufo/83R5
	 E74BZCiXox7yKCwl0MJHAykl0f3AfMLNZ70ywzkLgF1/R6D+FdxCnEByunfSgVxY6szDo
	 MiuuX/x67gRZpjf6k8LYfR4GdYEvo8y+JxbwGoOd5gpjVYnpuAoJUyXIkDNDhkhoHiQGX
	 jqCW+KZVdQri6pW9MWNVvdlIbdXCvLWEqvQ6Vs9R2lwe7k3iicc6UxaMp7mol9ZJHzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CKxKkBue;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A5C606A332;
	Thu,  5 Nov 2026 21:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CKxKkBue
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D15D1F008A4;
	Thu,  5 Nov 2026 21:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914764;
	bh=JTpiJ9Hx6bH2s7DX99mLQj0l+RTHEk4py36qs0ElKZI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CKxKkBueMbD7SZDoEYYsjSSOmnQMVN4cJD1Q1yvDo3po3K8+n77iXQmji17tW5kbV
	 hC2wG9roY9o5xX7HxiLaAaHRmExo8kD3tLud5fxFwFA1uTJHP95Ljlb0zVQR/O1LiZ
	 Y1gRNEvYT/dbAQrgyQJfjRpKaFSrHy35Ru/DlWONacb4RetXu/o7hzJ5ZpIoZStXL0
	 v83vphJS7wsvUy4aRqrUSrx9nGvXFXPx5NRqUlseHhoFqWGbmVqtbnEXFBQq5ZZeEb
	 0KximvzlDyHDV7GGh3D2sWqGDzR4W3tmg0l/KR4wALf/SizlkqwdliRTJwPXJOFGoX
	 RtLHrcDJqNY5Q==
Message-ID: <sashiko-outbox-200249@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/13] mm/migrate: convert VMA flag tests to use
 vma_flags_t
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: damon@lists.linux.dev, linux-perf-users@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261105-late-2026-vma-flags-v1-4-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-4-0d3cd15ab75f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:39:24 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
> migration logic.
>=20
> We retain the READ_ONCE() of vma->vm_flags in remove_migration_pte(), as
> there is no vma_flags_t equivalent, and arch_make_huge_pte() continues to
> take legacy flags for the time being.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-late-2026-=
vma-flags-v1-0-0d3cd15ab75f@kernel.org?part=3D4

