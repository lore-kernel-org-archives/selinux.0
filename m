Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D135C420868;
	Wed,  8 Jul 2026 00:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783470013; cv=none; b=LiRiV8l610r8/KfEpA81i+EmRZJpJ3o7pr7OU/d+yVHcuACjCVQudH8PrRiiqGmHs19Rl5wYZ6n3R4AfN9F75Dlb5JjakpCbElYukuzq8+sAfEDBwlGdh13hx2YpFrcAkXuM5tgucEt3uL1Qcopt1XnkXmZdp0YtFD7HE/1okXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783470013; c=relaxed/simple;
	bh=EcgLOyd0v2z524kOcdrWGqBbIJFrO5GhCVB8Afy/taU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rWTZfr2D7UTXzIBOirT8f6t46uFE4T1x9A93RJwKItLSY8Z0fjQJCC6jMHTX5yDUNxcUXH7yJs7TXLzBc52MM4czEHhKEOUaMTL2YTVdh3N8YQCH9cBC5IkB85m6ML+sjocNh6gqya15NWNFL8vAi20ucUDgmLrxcrlh31UZXh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkP/t5Uo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkP/t5Uo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B68C1F000E9;
	Wed,  8 Jul 2026 00:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783470012;
	bh=EcgLOyd0v2z524kOcdrWGqBbIJFrO5GhCVB8Afy/taU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YkP/t5Uo2Aw94ThND+KyMSR3wGYgRKUQ7j61OKjOCPNoaBRo4dGtndVkM+8QcmCdY
	 wAEV9sLh9YKq8yg1yG0n3cByVJwWKQYXbpMmXCuX6kN3L7QewZv7geYt5XBExKOxuI
	 fBufsjwcasV5xTn0cOWmwIfScg5Fzj7m1on1AcbZ86lEGKDXJfgpnJUYc4PS/fHPD3
	 uIiQxK+2I4ecVe+dOHDC65MQIHsZ1tHBQinnymCUM5QISnKcA5dTMT8vUuzg5EC7R3
	 gyOpyZNPwy3Utvd0XlqNuPoNtWJATSnadnQK2vKqvOGuEL9n1w2dFDaYXAbCkS+6U4
	 7deNymLMdsaYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 bpf-next 2/3] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Windsor" <dwindsor@gmail.com>
Cc: selinux@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260708000956.46138-3-dwindsor@gmail.com>
References: <20260708000956.46138-1-dwindsor@gmail.com>
 <20260708000956.46138-3-dwindsor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 00:20:11 +0000
Message-Id: <20260708002012.3B68C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically set
> xattrs via the inode_init_security hook using security_lsmxattr_add().
> The hook now passes its xattr state as a single struct lsm_xattrs
> object, which the kfunc takes directly.
>=20
> This kfunc is only callable from inode_init_security; the verifier
> rejects attempts to call it elsewhere.
>=20
> A previous attempt [1] required a kmalloc string output protocol for
> the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSMs to
> provide xattrs for inode_init_security hook") [2], the xattr name is no
> longer allocated; it is a static constant.
>=20
> Link: https://kernsec.org/pipermail/linux-security-module-archive/2022-Oc=
tober/034878.html [1]
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D6bcdfd2cac55 [2]
> Suggested-by: Song Liu <song@kernel.org>
> Signed-off-by: David Windsor <dwindsor@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708000956.4613=
8-1-dwindsor@gmail.com?part=3D2

