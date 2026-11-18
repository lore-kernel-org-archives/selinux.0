Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991264;
	b=CrBl8myf63xHC7JTtO3E+A6YzAQ5G8yfk5cVahc++fwTDV49rJtSmNy2aZacvX8pqxVG
	 40HQ0FJHNFqC+SBEAPq1hEeQ7mKOJbxMEn3BhS//hcXgfln3F4tWoWoXJR0WMmLIiq4ml
	 AOV7HcyZbL4GxviqnkzOndxpBxz/lRQGYbwBuSFrPbNIgRuCkp05RD0pAmn2REsWSJq1L
	 +fpCOYPcX1cFmTEs4OsRKkvE/ue0y6NrPOms8x4wuvAYke+0NwC07ZwEAegqRqK2hKGV7
	 uBV0AZk+bn7C90Q+xioot5r6LEAclv9HuGCiFFRaAza1QDmkFPcE2e7OyG2vK70vcFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991264;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Qsokom9VVU2ozFQCHlOpVYzXxyR7wYBA2EMpdEkchIE=;
	b=IwfhVgRkMr0uB3AyvdZko7Je3TwhzkrkvmImMcQNPOjQi+w3gWkhZpYok1yRjudyF1Vc
	 DkGLLvRs4CdfI0kPInwgGS4VMD7iC9SyuMlujdsDyoyvb4lhzIogM0NhcWQyU7YTt0vLk
	 kWaZ4JwKpY860QzUi2ZjP19kEs56uMZlxfQqhQJzj2oTqb822/uo9djzm5qaKFHAeFwo6
	 /yRRaJY8uW/mxWWgnYE9jt0W2IWpAu4RFfr6GyBhSL3J1JK6NAZwxPtvTs49JSZAyLsCK
	 0NH0c/1kSwnve3WypReIh/YHe+UolxasSTTHXo01xKrHancPF3ftbkQdUYoVCAFDTYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l5ugrMIu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5262F606A330;
	Wed, 18 Nov 2026 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l5ugrMIu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1AA1F000C4;
	Wed, 18 Nov 2026 08:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794991264;
	bh=Qsokom9VVU2ozFQCHlOpVYzXxyR7wYBA2EMpdEkchIE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=l5ugrMIua1k2CZV/n6u0GTdPTh7drAW84uuMWJtXnVPPAExBneTIGBohMQO+GwRxi
	 GEkR0mjAJvwuyJfIhxsvXHOZYztWQDiO1umNBKWViykP860od1vihPJkapjWZ/O1RV
	 k0C0exjrbcoFK3MjmSoQRSzmHsgxEoXw5lDsktUtyZXjGc7X2eu7ERhxInPLg8ao6B
	 UkEqE7UxJIqFnKPGymo+wERO3phwvqZhDGDAUvmj1WCpRJUCKzbB0g1YUjKUv6GMoY
	 zY8qN0BiiVY59yHOEwpB1fkWvM8V7g9bDgsbfgjiVTNOmBeuBsXp9I9ZrwhuC5BvRj
	 HS+VZrnNkSJKA==
Message-ID: <sashiko-outbox-220472@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/8] selinux: Restrict cross-cgroup memcg charging
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261117-v2_20230123_tjmercier_google_com-v5-6-1ce975f2a9ad@redhat.com>
References: <20261117-v2_20230123_tjmercier_google_com-v5-0-1ce975f2a9ad@redhat.com>
 <20261117-v2_20230123_tjmercier_google_com-v5-6-1ce975f2a9ad@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 08:41:03 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> The security_memcg_charge_task() hook allows security modules
> to control which processes may charge/transfer memcg
> memory to another process's cgroup outside their tree. Without
> a policy implementation, the hook is a no-op and the restriction
> is not enforced.
>=20
> On SELinux-managed systems the only limit is CAP_SYS_RESOURCE. A
> domain that holds both dma-heap access (today's only exporter that
> opts-in) and that capability, can charge memory to any cgroup outside
> its own subtree. Since the capability is all-or-nothing, SELinux
> policy cannot express which targets such a domain may charge to.
>=20
> Implement selinux_memcg_charge_task() using avc_has_perm() from
> the process2 object class and a new charge_to permission. Policy
> authors can then grant cross-cgroup charging selectively,
> for example:
>=20
>   allow allocator_app_t client_app_t:process2 charge_to;
>=20
> Signed-off-by: Albert Esteve <aesteve@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-v2_2023012=
3_tjmercier_google_com-v5-0-1ce975f2a9ad@redhat.com?part=3D6

