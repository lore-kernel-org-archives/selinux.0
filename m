Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793199877;
	b=Po4eRHMuigTwYp0B/UYSq3nIeJqZc93iTjedSOYRvXCJn2ml0IRH9EAJRY6l1kVdQTgI
	 A01MVPjHg7c+gvy++q8CnDpxqqoIF+Ir7BMhwmY48zFs1qqFRRUm7liQTx3DRN/J8J9tq
	 1z3SyI9WD+1CUw4kQ8rlJ1kHEMgu2BBUTMHMb3Z8NSDjEFKTDF+gBaG8M9bibTtMrilEZ
	 i74Lj+VFRXAdLM3hDm9P9habhFg9PXjoXu2R2tF0Xojb3cGUJMjwzRtZIp/KAfHOvsXg0
	 VQoUaXU1flht2gyybBo1Tyl88uU1Y4cWNMXp0ZvdYxjODmCtrqka6QLJ5zQVpK1z0fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199877;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=b+oFr/p0LzevC5MRmMI2nQRfeZjvUoqqZl+eRJ/wNM0=;
	b=zKvHnKwJAz2MMdYJIH2HRLjsvBqe1i6aRHcdxxCl78RyfsU+jTFjwU15Q0RkT3BD//Ii
	 WEoZYUJVAqCktvY66ha7mk2JPKtQSU1kORWd/iHXel4daUzFd1Z6J9HFoqFh9STivoEOd
	 u563C0nr2JJno5m3QBseYMiA4FTJjhGMojeAkHXAosu2x+nKHx2/66zRxgKhhwFlwwAnf
	 6tt3pBdRrHt68pf35JDVZlFUj4Fb17suVICW/VKDYS1PoAP9YakJPImfag0eTEm/xsY0d
	 457XIT8WEwBjlJHXUGlYwPTUvDnv0ZnxycXAhWRryccPVtzby6FW84fpAYWpoFEe9gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YAvb+yZ+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699F9606A32A;
	Wed, 28 Oct 2026 15:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YAvb+yZ+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BC61F01828;
	Wed, 28 Oct 2026 15:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793199877;
	bh=b+oFr/p0LzevC5MRmMI2nQRfeZjvUoqqZl+eRJ/wNM0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=YAvb+yZ+TX6gGjOoFFf4cYERMVlm8nFQVnRmk9yVhuwI+vuV3eOJQ5DyJa7FVLjJr
	 jJRqBC6ISFwAzx1qn5FIUmsfR9I85ucxHanPjvGvU7ScmB9XuqBl5phhgcWfYUdfvR
	 2bjt93zyv+0DIEVe1uM/DoqBhmzZZca+GzzVitrenKr2LP0Bkd62w5cYVt96V3iCs1
	 2tMMIog5gV+MztsoeeICFcRUreqV/UAi3k7HRHHmhdLI8yjkCJmGR2Q0cNOLDrUaHc
	 2lBns+g2JIwPPGgjy/tJSNAqWVtKqWkjZOLMdst/xKJtcq7eED9SqyyNi0XBQMF/dg
	 t86kKRU/S5zOA==
Message-ID: <sashiko-outbox-188030@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/8] selinux: Restrict cross-cgroup dma-buf charging
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261027-v2_20230123_tjmercier_google_com-v3-5-78d2c4cb8647@redhat.com>
References: <20261027-v2_20230123_tjmercier_google_com-v3-0-78d2c4cb8647@redhat.com>
 <20261027-v2_20230123_tjmercier_google_com-v3-5-78d2c4cb8647@redhat.com>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-v2_2023012=
3_tjmercier_google_com-v3-0-78d2c4cb8647@redhat.com?part=3D5

