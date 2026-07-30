Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4A93911AF;
	Thu, 30 Jul 2026 22:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785450213; cv=none; b=WOPLHYWkTTl6dZBBnGA7o64qG8Tdc1+hVMguO4H7R3mKKrdP7nSLHwrPePaj11kvGweDD9HQon+frw4q555GjFiwe8EybI9BqvU3QVUcmDy1QmHhPyXihWcEQcYfhLrclJwKjrHlKTiZ49tU0OSrLZI9y4CBBq5RbTpFSo45bIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785450213; c=relaxed/simple;
	bh=Z9ffcRUQuyB6asFA4VqUJPW5+F5R91idjW3uLuovDrw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k9EnLBklQ1CXcUpeD81ToXbd62LVcHhtdxSus2V8/cWX4SaR7zbkYhSynNO3KSq6fOjzZ2nRHyHJFZULolWBz3iSPaR7CgGs1SlHgM90HmdZe7fRZlCAW4lyxKtrzm3Q8NKAeqzH/Qh1uZKbR4CM5Pgj9S36Y0yrrLXXVcEUgto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwOYiogu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwOYiogu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DBD1F000E9;
	Thu, 30 Jul 2026 22:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785450212;
	bh=Z9ffcRUQuyB6asFA4VqUJPW5+F5R91idjW3uLuovDrw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HwOYioguliWo6RQGM4tE9lqe8BLgjGWJ0HaoTe4le+5DuJQxx2dOcgbIKKDVbz7nv
	 VPj5dW8MIU4TFu6S8pAV/ToOftj6TKDhf+CfEZq7qamzzo7s1ZuY0PBhTvSU7Ev/qW
	 26UzoifjbEKG23QBCUBgMkhLV7hrFZbJJY+M8lvKdUe4OzALhbXfC9xMoME8AEsmOR
	 qAPvEQDy9mKhOfyrUONJfql0vXn3U+y9dDtQb+bRjKxHI9whUVJ8h9BX5RRHnvv67G
	 nYbGAAqQeFqLY8lcfZ8cKnWwCGUO3+QWGzQBuW9J38tjn+9CuRWFx1Sk6w7hF0EMWl
	 7k0d+rOutMJEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] selinux: bpf: check SBLABEL_MNT before isec init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Carlos Llamas" <cmllamas@google.com>
Cc: selinux@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260730221508.3846409-1-cmllamas@google.com>
References: <db6fe5d2d4081f20f85abc6020b831fd@paul-moore.com>
 <20260730221508.3846409-1-cmllamas@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 22:23:31 +0000
Message-Id: <20260730222331.E1DBD1F000E9@smtp.kernel.org>
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
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730221508.3846=
409-1-cmllamas@google.com?part=3D1

