Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228223876A4
	for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 21:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789508671; cv=none; b=mcnQ+XPi9ikvmYkK7cvzTh0N4AxBDeQxN7V4uHZa80tzbago4aZ3N/gXVB30xw9FqWQYF+LVcfz3MEZYXSqSuhJ97zXzEw/3uBkyu8yPHDqfHpUvMwqLY9e6kZjlY5vJvZd4CWReDG/2o4ER5/K651Q2GbCGvQ92ZOS2FT7EJn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789508671; c=relaxed/simple;
	bh=hHs4+H/qr3eP6IrR0AESrkEy6lOM1ZHEPUrK7Km3O2k=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kQaUeAe+BP3FNfjnSpEjAjcMpmYQyx0O20CEq747LnuSztccrmYepF8aX7b4eGJKBLBl0POHgkxfHCbt81lEUcc5CjGTNcVufKCvXnN4wHfeYh6MHa0pbGxls9U+0Mt5+tc8GiRWsrFdQOcWhPZpP2MS42k8N/pLInEGEkCa1gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEih4DPq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEih4DPq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEDB1F000FF
	for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 21:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789508669;
	bh=pHgHHnmSocFh1+E2T9Rw2EjOfaMrRshoMSBbZE+0o8U=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=LEih4DPqojTK7/oQ7K6MzYeij83ZkIQi/lHJdsisTfQTU0RUK+2AwFlOhQSCK6ZO5
	 h5w3o+Ps0oknJ4Rc1Giu2f6nVXKwMm5ZcRaNwptCpb4MAkVSgniuOYIdGq5bIZA2dX
	 SurT6aJ3kBS5oRaBV7QIryRyEmOxYWQenMJK1+Z8Kcn5trtbsfTKSfDWhbWPAmkFPI
	 wkyeEvi5bbdMgPX+QO8e0VEf/CSWLD9rAo99H/SUxDJt3/h6NH02LLrwj8TUBEjRTs
	 8SaI+HgK/GhspYu2rZ7g1sEp8NnRER13D7QQeF2hMH/B/xU4l2KncxiwFesUxcyJoh
	 mx4rPBobTkHJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selinux: avoid 64-bit division of inode numbers
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260915213807.481355-2-paul@paul-moore.com>
References: <20260915213807.481355-2-paul@paul-moore.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 21:44:29 +0000
Message-Id: <20260915214429.CCEDB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> As reported by Arnd, a previous change to convert the selinuxfs inode
> numbers to u64 to match the rest of the kernel caused a problem on 32-bit
> systems:
>=20
>   arm-linux-gnueabi-ld: .../selinuxfs.o: in function `sel_read_class':
>    selinuxfs.c:(.text+0xdcc): undefined reference to `__aeabi_uldivmod'
>   arm-linux-gnueabi-ld: .../selinuxfs.o: in function `sel_read_perm':
>    selinuxfs.c:(.text+0xed0): undefined reference to `__aeabi_uldivmod'
>=20
> Since we don't currently use more than 24-bits in the selinuxfs inodes
> (see SEL_INO_MASK), fix this by applying the SEL_INO_MASK to the
> selinuxfs inode numbers and casting to a u32 before performing any
> division operations.
>=20
> Fixes: fc68b6a45f16 ("selinux: convert selinuxfs inode numbers from unsig=
ned long to u64")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915213807.4813=
55-2-paul@paul-moore.com?part=3D1

