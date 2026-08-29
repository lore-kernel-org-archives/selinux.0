Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5A741D23A
	for <selinux@vger.kernel.org>; Sat, 29 Aug 2026 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788039695; cv=none; b=QCik1wNmYDUOpSFUvBZ+ZSEr8Tki1Vp719r4yk/wGcFya29M8qtzmKzU2MDGmFacFJ2B5nhEEY1iJnzKkDizkiEaEI49z1twu9O8/J1M1klx4p4Og2FiYRgtOhT1nH3keHgjaQnASkohfbH9Q+8iGAJ4nHxR3VtOBzO/zpacDd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788039695; c=relaxed/simple;
	bh=wl3eyWjGqnTCBBd3eec7GDkDu+TU6LfXAcX4SrrpdNk=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hOODnWmLPIhBflOPaU1m6FQEFmrYbP5BT6XzQyRVlMynllDkLC29Ga69n8Jko0wZVUvp5ISYqQpl/v3xOVbcDUL/5jpoHseBqLcVBT030BtEgclb9QjAdKTfeliXi6mpEbWRZwc2hEvqZjGROMR1p+drBTqVJRprtkSAX2abECA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNlgWEE0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNlgWEE0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28C51F000E9
	for <selinux@vger.kernel.org>; Sat, 29 Aug 2026 21:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788039694;
	bh=SWfFCteKgshnLHF0ul/hIgIvnUh1DNL8rtdCskjCJ+g=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=NNlgWEE0ShEr7aPIGcxl2FePArKb1h4sLScjGJpZ6G1T/5K1CiHo8mXbmAy5aK/3z
	 HbXDwzYN9/oFWhr6k66oZATpQe+DUZENi3lFK0fX1eiMU/v5kLVoxUV1SgPH8e4ZkQ
	 qnAcFFPPhqKma25rKvee2AQlSVYy1xdN+XOS6HlJUr0WDLJS2LhVfzsqkglx+sdcTm
	 RsMclcQVwof8HC49TCbjZyqxm3n+vm+3dMQP2zsPcI3O2OwLLhF6+7Pxd2SmzO1PLl
	 AXcxutiWJZ6Sk4PuYpm992qDm+96wb5/KGbXJ6rHpcf8PU3TReJqgQHO3ppmADGS6N
	 AfsYVPdWf6lTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] selinux: recheck intermediate backing files on
 mprotect
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260829213256.51527-3-kmehltretter@gmail.com>
References: <20260829213256.51527-1-kmehltretter@gmail.com>
 <20260829213256.51527-3-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 21:41:33 +0000
Message-Id: <20260829214133.F28C51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> mprotect() can be used to bypass the SELinux checks that mmap() performs
> against the intermediate layers of a stacked filesystem.
>=20
> mmap() checks every backing layer as the request descends through the
> stack.  mprotect() only has the lowest backing file in vma->vm_file, so it
> rechecks the top-level user and the lowest mounter, but skips the mounters
> of every layer in between.  With two nested overlayfs mounts and a policy
> denying mounter_t -> middle_file_t:file { execute }, a direct
> mmap(PROT_EXEC) is denied:
>=20
>   avc:  denied  { execute } for  pid=3D71 comm=3D"nested_exec"
>     path=3D"/payload" dev=3D"overlay" ino=3D9
>     scontext=3Duser_u:base_r:mounter_t
>     tcontext=3Duser_u:object_r:middle_file_t tclass=3Dfile permissive=3D0
>=20
> [ ... ]
>=20
> Fixes: 82544d36b172 ("selinux: fix overlayfs mmap() and mprotect() access=
 checks")
> Cc: <stable@vger.kernel.org>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260829213256.5152=
7-1-kmehltretter@gmail.com?part=3D2

