Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4D736605E;
	Thu, 30 Jul 2026 18:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785435508; cv=none; b=mXKUTUH/9ZdWTuEu0rti3yeFDw+gxd4OYTk2ADYHcSPqawy78Bb3H2tnYsmQGSJV+h0oeuvfFAbaQWJyBkHOcKHLviDz/7PJyAhnep9gUr3gESQ5gcM8taVanmw87l3nxXGIK3sj/9E2FEttuHGVRCIJRe8lo+BWoaXik5yNJtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785435508; c=relaxed/simple;
	bh=g21BCUnfcPJ6PlZic7POMmwQtovZ/fNeHsQIbrQyS04=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F1L7T9PWhWPKnXbRHVJEXvkxzrHjWzouBk+eZR382utJlKgfwUaEH7/Ur/QNz9QAt1g7/nFFjalrULSAwwNNNhd7pBXc/EsgPDRvM3As7K1d1/3dw03vUVjiL4GWNnexpnupKEsZchL/SC8B1LWXIl7cOZ0wtp950nBZXzWWJvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htHoX1Sf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htHoX1Sf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A5F1F000E9;
	Thu, 30 Jul 2026 18:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785435506;
	bh=g21BCUnfcPJ6PlZic7POMmwQtovZ/fNeHsQIbrQyS04=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=htHoX1SfesqKizW53OdoJr+3YqLtjEuxjvaRJWAYO8dsYMkOzjIKzVFmPWHH0QUTR
	 ZYtO6oSKVG670vELPa45qtIwI473T8VhYwfTtUuQFpRBsUoqeZpxvoa1EPxT4u+81h
	 eM9zLNms21EBaiP6CDmkZ61/p7NodkLFwbgoj0HBdOp/KCYe4ZnKneH1xSUFFoDYN8
	 igt1NF5r2B4EbAKKHvJlOsbAlZHUTEF3h1XZn8L4X+5QKoADxQlcdlr1g7rX+++/K8
	 WjJzKQ5AsVAKHjjxDJGL6NWF2KsnEFZ95v4TbmDzJsCfaVimsZSgDzSkGBVRclN3dv
	 FNeLIelCArtFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selinux: bpf: check SBLABEL_MNT before isec init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Carlos Llamas" <cmllamas@google.com>
Cc: selinux@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260730181008.3654413-1-cmllamas@google.com>
References: <01421d53-c379-4044-9da3-5990186303ef@iogearbox.net>
 <20260730181008.3654413-1-cmllamas@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 18:18:26 +0000
Message-Id: <20260730181826.96A5F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> selinux_inode_init_security() marks the isec as initialized before
> checking if mount labeling is supported (SBLABEL_MNT). This was fine
> until commit 9722955b5430 ("bpf: Add simple xattr support to bpffs"),
> where genfscon bpffs mounts fail the SBLABEL_MNT check as expected (no
> xattrs) and yet leave the isec->initialized. This breaks subsequent
> calls to inode_doinit_with_dentry().
>=20
> Do the SBLABEL_MNT check before the inode security is initialized.
>=20
> Cc: stable@vger.kernel.org
> Closes: https://lore.kernel.org/all/akWdcp6P0FkNDzBk@google.com/
> Fixes: 9722955b5430 ("bpf: Add simple xattr support to bpffs")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730181008.3654=
413-1-cmllamas@google.com?part=3D1

