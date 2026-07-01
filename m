Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915D235AC3C;
	Wed,  1 Jul 2026 06:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782887600; cv=none; b=m3zLXsjgpXny8aziQ3d3TLTu0dPK48w0pyg/c9602+43VvSbPAIGauKABLwT7uH4qjiBidQHpqmIlYplKW7kVFAxS3VTwch/HOS59fmfQAAZEOtlDajwrV9F4DviC184eclm4X3tLz94Zg9WB0dUJWKYBw8ne77laT7RKMMVvSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782887600; c=relaxed/simple;
	bh=FKTUpeVmt7s9Ty70PbwkqNC8dgIuce76A6zU6TAlU3M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f++B2PJqXMU7Uv2OVgzhfde47sqiJp+M2PKNoogPCRNQRF5HueVwO8MMqGza0rT9fd8vwhbCFwYR9GksFL3bRwiprs8q+x5WWEVMgRrR32mqHfWE0tVr0oVS18YnhelN7Zz0CdTiTBP+GaF8YTJPrURG7104ssN561YTPCj4XvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gnit70k6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gnit70k6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C14D1F000E9;
	Wed,  1 Jul 2026 06:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782887598;
	bh=FKTUpeVmt7s9Ty70PbwkqNC8dgIuce76A6zU6TAlU3M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gnit70k6TR836qf7nkEsHFVUhnO13Ls6q/MuzGio0qlioX1ZFpKjP6edmcu9W32gW
	 D/4sRyvy3k1rngzt/R6fuZmRNE7ppPA9PNEwcSlZ0J/AEmJJFFjIaQgx6rh6DWl5zV
	 X8xdI80GKSPMMpV2OJRaXBAyuf8M5sn76ydfHVjjW65RjePSoz6Y2vbxa+SEm7ju3Z
	 2UVYgxYoQb46rYQwDkaHV3hWLveQcwxrrgyUCYqgDCIrqeL02ZZN+sJ1EKJFHIW1Rz
	 kqSwC/P1wyoZ2lcEjkmdNjGXXVmPgx0wymJdfwWZbKGvPAsAHrODGnuMo3cNFSasJp
	 TAQQ03k904Y4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf test amd ibs: avoid using executable heap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ondrej Mosnacek" <omosnace@redhat.com>
Cc: selinux@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260701062321.517351-1-omosnace@redhat.com>
References: <20260701062321.517351-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 06:33:17 +0000
Message-Id: <20260701063318.0C14D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> Making [parts of] the heap executable is dangerous and is blocked by
> SELinux on Fedora/RHEL even for an unconfined user. Replace the malloc()
> + mprotect() combo with just mmap(), creating a private anonymous rwx
> mapping, which only requires the more commonly allowed "execmem"
> permission under SELinux (things like JIT or regex compilation need it
> as well). mmap() with MAP_ANONYMOUS will give us a zeroed mapping that
> begins on a page boundary, so the result is equivalent to the original
> code even without a memset() or the page-alignment dance.
>=20
> Verified that the test still passes on a machine with an AMD CPU that
> has the "ibs" CPU flag.
>=20
> Fixes: 35db59fa8ea2 ("perf test amd ibs: Add sample period unit test")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701062321.5173=
51-1-omosnace@redhat.com?part=3D1

