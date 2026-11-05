Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914656;
	b=DYSDMBSZ0ecG0ue1JFNPsBAH0/16feB6Ug9qNFGy3A8eGAUr7kCO1XFM3U0yJsjSI7xP
	 QB2xWMBYDC51mJgQdHLbrjoXq+SOqpnr2BsqmA/z3tK35Z2yAvfepV9RuatFQ+4vGBO3a
	 t9rG04Dq3/TdllLW14blW11bNfHSvuBFinIqgG8KorWM8vokKl+xJGKgCQQZrbQ18277X
	 AB3/050fvT3F5oEivM4MRyacXd5QcfSR6GFIWIZY7RAopv4dpvp6SIC4RR5rJOC4ONhO3
	 v7k9hCs8ldpxvzCiGDuPnSh9+xzGV9GNnDG+7/KjEV4n9IIoS2AT5v8Oy9szsxGXWAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914656;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Vd//lQBUSBXZy1erTGxE30LtNkb0vhkHufGqo478wD8=;
	b=pAITp+tZelY/TBA70GnkJC8LewNVagE+nYSJfFf6DSctdpObhk+UoydFdHhdLxW6sZ3l
	 zi347ylR2UqedvwGMdmFt3qefI9jQMkBPGPRibms0mpV7fN4Bc/g2u2KAB8Gy+N/f0RcL
	 DBt9daf+o0TV0AmD+Zzg0yyv7zt8PYRlCvZfcroy+RPuB/8NHWOa2DGknDspdrpufzyVc
	 KYTfQhbU4oX3W7L8a7X7AYe++hhNdd0JEGWhPISsVoDIzhm1Xb7rK3FLxbWcWbQUuhdt+
	 N6sVyeRFKhIcUOL1qH7muW3ACM7pTjEZQ8iMbSYgZM6n77Mq6SeWDK2ujY3yRNE4TVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gn2tB2zP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1078F606A32E;
	Thu,  5 Nov 2026 21:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gn2tB2zP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00271F008A2;
	Thu,  5 Nov 2026 21:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914655;
	bh=Vd//lQBUSBXZy1erTGxE30LtNkb0vhkHufGqo478wD8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gn2tB2zPulMuXt6X/EwO7o6zVO3ifIP6M8FgJviOLCEplj+8jme5RpV4DZc+vl5AG
	 2GJjVXzVgLov1jXy71azODg9s+Vj8q+rF5QbgUyNySZJ+Ykc17gRRTsvRTA/qR+eL+
	 815/0gVeC5vjd/O8FO2LRwUUBS2nN0Xh3dvQB775a+wyLxayex3PM5YNe2MXvN3Kvz
	 B2an8EyVSK+szWjyv7xT+Lk9lVEpOB0jSoAf+OfAlpEVC7AxMcqiWZKzn4jVPNWgNR
	 nGT/vKjdubHxmQZd+XLuJTbfsW3CsxMQuXFQUhrxXg3gdOhk1jkjP4n+6IX40/Hb07
	 jVmowDToV3UTQ==
Message-ID: <sashiko-outbox-200243@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/13] mm/rmap: convert remaining VMA flag tests to use
 vma_flags_t
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: damon@lists.linux.dev, linux-perf-users@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261105-late-2026-vma-flags-v1-3-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-3-0d3cd15ab75f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:37:35 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> Replace the remaining uses of the legacy vm_flags_t flags in the rmap log=
ic
> with vma_flags_t values.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-late-2026-=
vma-flags-v1-0-0d3cd15ab75f@kernel.org?part=3D3

