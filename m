Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793199872;
	b=xNQ1I5XFJFa/EnAdTXKZSW6BFF3HGBzAurCbG47sLVAuAoxzeubithhSIqN/5NHiB7pw
	 YOX8T4JOoH/lFLoC/C7RrTRLnsVte+nvDurQI9ZFN0GfS10G6DwMAp0+OMcCCVVIaFAuk
	 LklMcsxkgUJIaEpUPcaYaXCSsTPPH3AGTmKn3DIY94V1aUgbgPuDw2D5Ic4QMEYWmXY4m
	 9zLf4Fchjx7kAKHlQeuyTVijVgwUyMcT+R3Ska91SIjkP61mY4a/F7P2OyLyjO89eoSbf
	 jLiCHx7q5fke9YiaC5wrhYjAe7Ctb2Jfi5gtydMw8+pqLZDz7TgOoWNSfNvcXFoJTEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199872;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FpCeRky5DMnh+epc7ip1fLCap+41uXvq5Gv7cq9cO/E=;
	b=bMW7wswQQlLtCTcJ1CaxPMdRBtrrcPTlQprnOuy3bpCd3zTzs7mZZU6c4stnXM6FdPHB
	 A1K4uGBheukfV4nirTvuufX0hsxr6+PpoOSi/W0hOpgWhzbFaAN45E2WRV3mikakSyy4i
	 LQ7RBTq204IfVDydJUni3a/fAHszmOBI2AHVMcP/DrePipQUByMibOq5r+PJwe5VZVWKc
	 gBGsZPDJzr7yaEiGwh+S0M3ERkKYApbALohh7oRgcdVZ+XDMs9KGLEyd0lXO4rMvchyJU
	 TeJiGpJslbZYLVOXSxhXdNv0HN+R+4ECND0hHKHr5XqLEYH7W0yVP5R8heDLqBumDtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FMqWpsEO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA93606A334;
	Wed, 28 Oct 2026 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FMqWpsEO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94771F031E3;
	Wed, 28 Oct 2026 15:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793199871;
	bh=FpCeRky5DMnh+epc7ip1fLCap+41uXvq5Gv7cq9cO/E=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=FMqWpsEOJ3b2alHVmwwCF2VrBW8rXmUnu0pg1SKxl7nTmJZKdZirLwoURm8Wds1V7
	 tGOXYkwkPaNUobZl/JEtuuEKxnzec4EH/0GeNSjwzMYhiVZg2bUAfANu/Z5LqA4IAb
	 AG4HaUAFLdYe4DHUffPjCky2gNIhoOuiUsYh6WXp6D6LEudvpe67VEnS4j953TJtJD
	 RhtfhxYKCWVy2WmxU8mftoag4RbTAMWmHKbduqtP294j+XzdO0NmTVRHIrAQdp9TiZ
	 hZX5YFbwZV/aZQYKJIbu0lLNc1OCMAPIySeDXWydh1sMnEdkLA48cmlaQd3VhTPvGK
	 ZhQodrLz7B0rw==
Message-ID: <sashiko-outbox-188026@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/8] memcg: Add MEMCG_DMABUF accounting
 infrastructure
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261027-v2_20230123_tjmercier_google_com-v3-1-78d2c4cb8647@redhat.com>
References: <20261027-v2_20230123_tjmercier_google_com-v3-0-78d2c4cb8647@redhat.com>
 <20261027-v2_20230123_tjmercier_google_com-v3-1-78d2c4cb8647@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 15:04:31 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> From: "T.J. Mercier" <tjmercier@google.com>
>=20
> Introduce a MEMCG_DMABUF stat counter and helpers for
> reserve/commit/cancel and uncharging dma-buf memory against a
> memory cgroup:
>=20
> The charge is tracked on struct dma_buf via a new memcg pointer. The
> page count is derived internally from PAGE_ALIGN(dmabuf->size), and
> the memcg reference is stored into (or cleared from) dmabuf->memcg by
> the helpers themselves, removing the need for callers to manage those
> details. The release path in dma_buf_release() is reduced to a single
> mem_cgroup_uncharge_dmabuf() call.
>=20
> This decouples accounting from the backing page allocator, avoiding the
> need for every exporter to pass __GFP_ACCOUNT and enabling cross-cgroup
> charge transfer, which is impractical with page-level accounting.
>=20
> The next patch wires up the charging policy in the dma-heap ioctl.
>=20
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-v2_2023012=
3_tjmercier_google_com-v3-0-78d2c4cb8647@redhat.com?part=3D1

