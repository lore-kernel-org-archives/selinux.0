Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1CA3939D7;
	Wed,  1 Jul 2026 05:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782885207; cv=none; b=uEc+5iohG5AE3YVgVFhuUo56MagDHPwDtMqaXNJbENROVzN4Oe6lfa0b1ieHpXHXGBj0Mj3gxnrEg/iOEgMyA5CtxdQ/yEChux7GgSNqeN0uWUntJWHXnIFri1GAA1nCLKW6We1gdkWes9pFAW/sW4dZm9RwONxLoLFgsDJnT8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782885207; c=relaxed/simple;
	bh=U8pelea93PpPNcT0TI8OF5EF12FiHed2FfFcCUmfBY4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ga1hZZ3oBnQJF251xN+UWs+B+Id0X0Z3kYgrgBl3NyGYjfvhs0DnzE7iDAjJ1W8Wl6NcrLofY4sllv1U/UweM9n4PPfqLpNypNHzbNhWK2LAKsaJuR9zJCW63xrodPnPwAqa/9DZOnQ9W4lfnnVJVGINDAeE7b5I4s9HpHKRmx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkQrT7z9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkQrT7z9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109C71F000E9;
	Wed,  1 Jul 2026 05:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782885206;
	bh=zaPLb2kKXTu+MOnhSYwCTg6fU9GigEnSLmqsC2j7GPY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QkQrT7z9HV4RI1CsBgcSjhlmnK/Qjhoe9vAEdz3Og0RO1LBGnEMYPBQCaLchP3AwI
	 /ig7kJFJiriVy7jN2ulu6xSFZ+KprA12jig2IlUMjrgUTD68JjSHUyynTxC4gYLi1u
	 o1pjqmrAyBBDFTZe+hEYkI2wl+U/jyFU+CxbcITbBi/QKPhZMV8jYBFUWKYYyMO/Ri
	 ortGkhusaNdDPGZq1seWDo1CqbhrJ/6AW06lyUeLKbgpeDe7b+Dn8XF3ZYo+UE583s
	 bgC28EIqC1TZM6hMuRFHiWpwb64/pl5YD/22FvGjsA3KQk2HPUJ/odYAPmBjb43bff
	 jpc33lhCdl/Sg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf test amd ibs: avoid using executable heap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ondrej Mosnacek" <omosnace@redhat.com>
Cc: selinux@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260701054807.508994-1-omosnace@redhat.com>
References: <20260701054807.508994-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 05:53:25 +0000
Message-Id: <20260701055326.109C71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incorrect error check for mmap() return value leads to segmentat=
ion fault.
--

commit 40ff2c8c34df3809a114852f1d0dd5630a45771c
Author: Ondrej Mosnacek <omosnace@redhat.com>

perf test amd ibs: avoid using executable heap

This commit replaces the malloc() and mprotect() combination with a single
mmap() call for creating executable memory in the AMD IBS test. This change
avoids SELinux executable heap restrictions by directly creating an
anonymous rwx mapping.

> diff --git a/tools/perf/arch/x86/tests/amd-ibs-period.c b/tools/perf/arch=
/x86/tests/amd-ibs-period.c
> --- a/tools/perf/arch/x86/tests/amd-ibs-period.c
> +++ b/tools/perf/arch/x86/tests/amd-ibs-period.c
[ ... ]
> @@ -59,18 +58,11 @@ static int dummy_workload_1(unsigned long count)
> +	func =3D mmap(NULL, page_size, PROT_READ | PROT_WRITE | PROT_EXEC,
> +		    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	if (!func) {

[Severity: Medium]
Does this error check properly handle mmap() failures? mmap() returns
MAP_FAILED ((void *)-1) rather than NULL when it fails.

If mmap() fails (e.g., due to SELinux denying execmem), this check will
evaluate to false, and the code will fall through to memcpy() into an
invalid address, triggering a segmentation fault.

> +		pr_debug("mmap() failed. %m\n");
> +		return -1;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701054807.5089=
94-1-omosnace@redhat.com?part=3D1
