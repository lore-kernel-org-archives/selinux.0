Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991262;
	b=tfEJ++UOI8KSVAe2uSHS1EWbbxNl10HQFqhzTARtLk20MUwBgv3USonf3g2j6clhghTZ
	 5cZqz3MQ0y5ZClHt0WdOX7Z8aEuvAv+hyMeRGdd17zep5yo1n1Lvq+I7sFd6WKc+vdxSB
	 IrAEHrbKTZX5GhFHf2nl1x5lcl/LlKEZDN33v60vK9HeuN/KaNKaBB5b+kYUlwyMLDnIT
	 /3aufqgt0KQQvCy/FkqD2l9VGbFWud4hClDHzZwZKcAU7lfmyVn9dp3FFnnz1WHOBIc4v
	 eL8+N+zNhqR2WnIwVsendnqPZDXPXgepo06fa3onU0GyyrzIMgGS4gUINIBRYwb/+zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991262;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UjHXyQJq5/ueiwoW4ueJG8/2VIFt9a9nsRD1yhQAknY=;
	b=bJ9bqLnLQE9mpT5Di/8TyWuzlUJykiP6Hx68+UO6swOZjY06xH5PqxetGvEHEZ6LCCHY
	 L8M5f5gz24KcV+Z5zxbo1luK2+BLJM3uIgsVUjdylzn/Mzwh81LEnAbvTRIYsS4XCHycl
	 5hipBx8+a5NUxcn5aCLcGkLW/FQ/ivZo0rd0DxNarW+cYrnn8ZemKoUBNPKR1NU9neBc5
	 xnq+0K9CH/GEhDnze7NSVZVpw9qKK+SBrcXkAYI5L8GANPKf9yjG3XtcrND2RNqBlJUVv
	 mQSECgvSzrrwTSfTNBhoWN+uu3qu4b5EAmeya9APTGGxUBhHnIR9jlzqq4Ar4wNXtSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZFT/D+iw";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6103C606A334;
	Wed, 18 Nov 2026 08:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZFT/D+iw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE2B1F000C5;
	Wed, 18 Nov 2026 08:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794991262;
	bh=UjHXyQJq5/ueiwoW4ueJG8/2VIFt9a9nsRD1yhQAknY=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ZFT/D+iwqWAdPYDfgFpkulxbYoREgiOA6MOvJljWx6stopgcM2pndrN6QrYyYQgku
	 sBec+z64UpX0mJ/hgSjVZYcamTHe2YZGzggKaAuc7R/XRIjpfx9I9vw+xrqyGYIaVR
	 nH4MJUmJDNqjUiWPy+piqL33pkJVB5jF/TYos1iIDoJJHVDdfL5teVvpq/fQ6I7nss
	 2R58afsNLMjKWmqLR3hFddF2euNjxGZ4PIYmYkEtOh6GtwcLEfHa3KMFCqrRbD9odU
	 RJt+gBkjZ6Y1Y97KCX5NyNeOgmg6VsA/slN8DLjQG0wlaGB9Htp8kRRFZdemElYJLe
	 VSU0LGbUFHTQw==
Message-ID: <sashiko-outbox-220469@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/8] dma-buf: transfer objcg charges via
 DMA_BUF_IOCTL_XFER_CHARGE
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261117-v2_20230123_tjmercier_google_com-v5-3-1ce975f2a9ad@redhat.com>
References: <20261117-v2_20230123_tjmercier_google_com-v5-0-1ce975f2a9ad@redhat.com>
 <20261117-v2_20230123_tjmercier_google_com-v5-3-1ce975f2a9ad@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 08:41:01 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> dma-heap already supports charging a specific cgroup at allocation
> time via charge_fd in DMA_HEAP_IOCTL_ALLOC. However, dma-bufs can
> originate from any exporter (DRM, V4L2, etc.), and the allocator may
> not know the final owner at allocation time.
>=20
> Add DMA_BUF_IOCTL_XFER_CHARGE to transfer a dma-buf's objcg charge
> to a different cgroup after allocation. The target is identified by
> charge_fd, which may be a cgroupfd or a pidfd.
>=20
> The transfer charges the new cgroup before uncharging the old one,
> preserving the original charge on failure. Concurrent transfers are
> serialized by the dma-buf reservation lock, so lockdep covers the
> locking order of the charge path early. The transfer implementation
> is generic (obj_cgroup_transfer_charge) and not dma-buf specific, so
> it can be reused by other subsystems.
> [ ... ]
>   /* charge now on app1's cgroup */
>   close(cg_fd);
>=20
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-v2_2023012=
3_tjmercier_google_com-v5-0-1ce975f2a9ad@redhat.com?part=3D3

