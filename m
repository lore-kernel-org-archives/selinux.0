Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7CC39657D;
	Mon, 29 Jun 2026 08:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723310; cv=none; b=bTKpS2yalWo4+apSF7Alvip648GiCie/XXnA7EHqUPTtNBCZr4wj5n5pvPAmZlid6TKwaZMF7AmLreruSNSsBuuZhNndxr0NlZpuj0kYrAjz0ko3LkPXPYIbBPIEHFB1MecETFcYVhuYGa1m7j6MMSvdVNtT4uBqDt8UfkZkEMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723310; c=relaxed/simple;
	bh=3XUwill7/pl5/veNAx1KZD3C0a7ZQw+EeLUCuIHJYfw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b1j2EXfpTdrzY29epWDnbyQarYR6BlSDFDZzXtQouVSuqeKWM0mPtthB0rjvKS4Zp/uzW7zZwvxJA1qADPx4ny+LSaXq/FvP2CXXCnGxfWuOhuqgqcClyuaDgG874hLnEo+J0epeVtGNeC79tdvjh/UyvQES4LKoJw0SUZMiCyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKMIogsu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKMIogsu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C5C1F000E9;
	Mon, 29 Jun 2026 08:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782723308;
	bh=3XUwill7/pl5/veNAx1KZD3C0a7ZQw+EeLUCuIHJYfw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EKMIogsu8uWSTVrF+ltRr5epYsuFxWPkg8O7W3DB3Ozq6zxLJ1YHHqe1M03SGjT8H
	 YoqBxhakMnbDDg5VdxdzUuunFvQGEAcsoQRctKU38lyl6RtvASTjdojn+aMjnqSqzt
	 4Efp2a4NTqpc/o9BvEtmWiwQe+fCm8JVdxbX2MzJsXkHl0tiZOb+Jy6EW9+fVb/f1C
	 7uZ56mBYtbcKdU57DRF2djl8505yNvqmPlo8Hh/i6Lsav5BdDvilVlnPZW5Cofqv2/
	 WCIC27DQRimnBbNgHwC6zLWYKTsbSyQiw0Engrs1e9oxIxnT1SAEZcajSPCtipE+/U
	 oMsyF+yKglEuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable/linux-5.10.y 1/7] ovl: pass layer mnt to
 ovl_open_realfile()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20260629070653.580879-2-caixinchen1@huawei.com>
References: <20260629070653.580879-1-caixinchen1@huawei.com>
 <20260629070653.580879-2-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 08:55:08 +0000
Message-Id: <20260629085508.94C5C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> From: Amir Goldstein <amir73il@gmail.com>
>=20
> [ Upstream commit 1248ea4b91bcdafefdb025087e67d58382cfc9eb ]
>=20
> Ensure that ovl_open_realfile() takes the mount's idmapping into
> account. We add a new helper ovl_path_realdata() that can be used to
> easily retrieve the relevant path which we can pass down. This is needed
> to support idmapped base layers with overlay.
>=20
> Cc: <linux-unionfs@vger.kernel.org>
> Tested-by: Giuseppe Scrivano <gscrivan@redhat.com>
> Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629070653.5808=
79-1-caixinchen1@huawei.com?part=3D1

