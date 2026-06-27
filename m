Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183AF373C00;
	Sat, 27 Jun 2026 06:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782542479; cv=none; b=ghekjqC7oP8HJeJcFZ2R6jB4G9F4uabIVAFNUuZLRib2s2UhDTPwRHlABpWUsLRnhQmv3Gv5FKdyZ2hWArAsiSthPnAvvg4orTPWN7CYxvTuasQ70BYmE9lYONWlEbOPuFguMknBqT1/BiuFOXYFS6srgbM+7Lm4aiSLNY7fuPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782542479; c=relaxed/simple;
	bh=Y1/uu8u443X+WS42fhQ8TXu1tO3v+v5eof0lzASIStc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SmTyUFqdtO/PWHULEKBZ0LrAuQy6MuRDlqb5xQdjqdveS9gYYjAGHTX8MapwKa8jA6RU5joYKtFlo/bLU7DzLzGk8TTYYPNJXpYF7NKFJ/J8bDrNBoVKRwmLRfF1V2zdXZOsyl/fggqmjYDp5gkoi8xdaoXcxnmDrdIbugp8bZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGGWC2Iu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGGWC2Iu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B151F000E9;
	Sat, 27 Jun 2026 06:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782542477;
	bh=fh4jGq879Z0oZT46xuuKWYIAmJlpJrkSheUhZRfbsN0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mGGWC2IuP4GMn8ULLhhcGInBFAKuLu01Lq7wA9UF6fvc11o/EOuFPFoFJM2VsmcbX
	 OgUSbtoKJ3qPE4xcsydBRr5zqpLCt4rq/nIE3Vhee7sodEc9to4QAFNqYsjk/UuM51
	 KzgyI2AhUJRkknKC65gqZ4L3NHdpujPoYMNimJvg8fBolygXm+ob9+1hQ1hgpTcE9h
	 8EeDHCJXfs1mEDw3yPtqqmUgG+N8LYf+bh+nPAYEBKHpGPNDCyWNgU73wZIRQmlyS/
	 hrZEIqR4wFkIkqIlCohETqLmLYntIcJ4Cy47NqUYmZ5Jtk6MIgzYGqjt6XW6huPmhR
	 yASzL9z0f6jeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 stable/linux-6.6.y 2/3] lsm: add backing_file LSM
 hooks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20260627065720.1945589-3-caixinchen1@huawei.com>
References: <20260627065720.1945589-1-caixinchen1@huawei.com>
 <20260627065720.1945589-3-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 06:41:17 +0000
Message-Id: <20260627064117.A8B151F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> From: Paul Moore <paul@paul-moore.com>
>=20
> [ Upstream commit 6af36aeb147a06dea47c49859cd6ca5659aeb987 ]
>=20
> Stacked filesystems such as overlayfs do not currently provide the
> necessary mechanisms for LSMs to properly enforce access controls on the
> mmap() and mprotect() operations.  In order to resolve this gap, a LSM
> security blob is being added to the backing_file struct and the following
> new LSM hooks are being created:
>=20
>  security_backing_file_alloc()
>  security_backing_file_free()
>  security_mmap_backing_file()
>=20
> The first two hooks are to manage the lifecycle of the LSM security blob
> [ ... ]
> are dropped in the 6.6 LTS backport.
>=20
> 4. Use macro backing_file to replace inline function to eliminate the
> const warning.]
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627065720.1945=
589-1-caixinchen1@huawei.com?part=3D2

