Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792683861;
	b=MWR31OmdrqDTf9EuwdB6EPNRzna9qXi2GYqm52RUgb36xg1CekQ1yCyQ5Fwx8zT+z7T/
	 HQerCUmKmijqQGLYiG4ODvoUz4hIy0s6cZ4cHGftjRCaOvOQBb9HBzFAZZc9tUVnRZ3b2
	 uocrK8HNbSrdf7Djxy6JRjhmoMbjWpAT4agpwU9Vg31qESy9arpIOTp/MIUwsDBrxZx9g
	 u33VNIHBlBXtKYsG2qlZWGKE4mFyeDgvIQqZKGfKdJ23S8SDU4ke7Lo7h8B0tfBFpmLOR
	 x2Yq4x+bRYT1c2AoNUuIpMlZ5fzKMJMIZ7+gQC1g1wr1h1BEzg4s05P4H9CCL0TXc3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792683861;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A0iuHox5PQ8i696HvFHaxkvD5I4IjoGvfVkG5CIPx7I=;
	b=lUkVV9WOcoij4CPyA+dQSVcgjEX94CdEvZ6vpBBkp0dGVkyl5iGTZ+9pj77+vnS9glSl
	 NxDnj+tLdfKuwNkbpIT1Es6bdsM3/7J42wdZL+Z++7hTwUoHSoAufHorP4FcDjvmQWGoT
	 +IPqJYDQ04SgcasrDEQ/mKh/mEWn+17KAUQhN3YAgvP2om2trG5p64Ymuazj1DcfsMHZD
	 w34GPF7uojvYHM5xsMX2EW2+GpFDBlLVTAhIco7PQaUcmInp4G2gDm1Asj06CikW5QJoi
	 p07PlOGBq85cauON8oo1GNGYyIMo7j93OyMrIZOSrYyl1UjS6kmeoHsmgaCXIhziA0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T94g6fGA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FE5606A32F;
	Thu, 22 Oct 2026 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T94g6fGA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7A61F01825;
	Thu, 22 Oct 2026 15:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792683860;
	bh=A0iuHox5PQ8i696HvFHaxkvD5I4IjoGvfVkG5CIPx7I=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=T94g6fGAizrCmjCJnAfdhSDXdJsK4dOCfNQjJkzw/E1ctUD2IX6aA9nQk+rFEnyed
	 6YMO5c+TuB3t9adqo1IBBTobtbtKCobjxmKp5DJqpi1FtUkdBvn+baW5SqnIWmVr61
	 BXqduIaQBp2e6gPj0IegcGU10NnWsWVNrEyNAMdcy4ybQLY0d+9podeO8aIpkPzR04
	 vUr61kVp4gWhGTkzj00xZBbtUokQX2xeVUpLvd/gHXN+AV1tkgmViWLsKzR0CpZXcx
	 MWUMq/s5d67Prwdjyy3IaFgxrIAbiWG1zg+jZV/0iZUS30kVfZXLmlm/YLkKjsLSMe
	 /8fP3cN/s8ytA==
Message-ID: <sashiko-outbox-181721@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 5/8] selinux: Restrict cross-cgroup dma-buf
 charging
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261021-v2_20230123_tjmercier_google_com-v2-5-ef6ee2dd8c5c@redhat.com>
References: <20261021-v2_20230123_tjmercier_google_com-v2-0-ef6ee2dd8c5c@redhat.com>
 <20261021-v2_20230123_tjmercier_google_com-v2-5-ef6ee2dd8c5c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 15:44:19 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> The security_dma_buf_charge_task() hook allows security modules
> to control which processes may charge dma-buf allocations
> to another process's cgroup via the charge_fd field of
> DMA_HEAP_IOCTL_ALLOC. Without a policy implementation, the
> hook is a no-op and the restriction is not enforced.
>=20
> On SELinux-managed systems any domain with access to a
> dma-heap device node can therefore exhaust another cgroup's
> memory budget without restriction.
>=20
> Implement selinux_dma_buf_charge_task() using avc_has_perm() with
> a new dma_buf object class and a charge_task permission. Policy
> authors can then grant cross-cgroup charging selectively,
> for example:
>=20
>   allow allocator_app_t client_app_t:dma_buf charge_task;
>=20
> Signed-off-by: Albert Esteve <aesteve@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-v2_2023012=
3_tjmercier_google_com-v2-0-ef6ee2dd8c5c@redhat.com?part=3D5

