Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94493F1047
	for <selinux@vger.kernel.org>; Sat, 29 Aug 2026 21:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788039635; cv=none; b=OZOFNE3iAUyHHFDv/oYWK7t1s8KVYXoJa4NIcpSBIwzh9CYTcWjA96Mmok5pP4YbaUZiyZDiiLCbjOMZojGNCkuLLNeuX/u2zjXndt9LiZeeV6NYdOCLvcRiSVjXb4VY9G2OD3jBB161GTvZXk5b3hzZD4ayTxtuPGK02pmVuQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788039635; c=relaxed/simple;
	bh=TPa0E88h1HM+ZVc98ymxi/DJAslwcssmpkeZCRp733M=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WpKzv4n6zf12zH74+GqFhmio297k+ZVx37nUGY3VLDqw7rtyYZTd3/HZiZKz17nCb8MLIApUMej3NTZBrENCBsniYL9mVH4ZG/diLCe0PsyI60RxW14zyk3r0Zj2E6rK15cQIQnvpIarQHDYRhxGFbhu1pX1yGN+zAXAGL4Fa8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBtWJZ2f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBtWJZ2f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686081F000E9
	for <selinux@vger.kernel.org>; Sat, 29 Aug 2026 21:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788039633;
	bh=JmD9Jyc51Y1yUb01eTcyYgJNpEPat2YDpMaks/V/wYs=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=UBtWJZ2fIu1e411BaHrydi0EmUGfrc0jetzL4zE1rOfqE+ACgFLkT3lYncaojBMw7
	 0Agss2HX2mC8qNv9xy6W8Lzh7oMMhS02ppJuo6Md0DsjDjBMOxcFs8usqCOjZjcOum
	 LeM/ZWzos5mAdwsUsnoDFXQgBm4Dimt3Z+ipEGN1+TmQd304jZvCFxBt9tQzY8lERH
	 aynsTpYj1FUlS92kx4qhEYWVkkLgaVVIf2g6sLY98TERNrw5ENGpJFimYtATLtTIY7
	 HtUPCVmanvGDfbTiqFhzTlmGhuxYsnwMxp4dIyzir8Zasx436G8de49QZX7q/28Xf/
	 Q2c/SrvjrghAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] selinux: preserve user SID across nested backing
 files
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260829213256.51527-2-kmehltretter@gmail.com>
References: <20260829213256.51527-1-kmehltretter@gmail.com>
 <20260829213256.51527-2-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 21:40:32 +0000
Message-Id: <20260829214033.686081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> SELinux saves the user file SID in a backing-file security blob so it
> remains available after mmap() replaces vma->vm_file with a backing file.
>=20
> For nested backing files (overlayfs over overlayfs, or FUSE passthrough
> backed by overlayfs), user_file may itself be a backing file.  Its
> fsec->sid is the SID of the mounter that opened it, rather than the user
> that opened the top-level file.  mprotect() then checks fd { use } against
> the mounter SID.  This can incorrectly deny access without a domain
> transition, or check the wrong target SID after one.
>=20
> Copy the saved user SID when user_file is a backing file.  Keep using the
> regular file SID for the first backing layer.
>=20
> With two nested overlayfs mounts and SELinux enforcing,
> mprotect(PROT_READ) returns EACCES with an fd { use } denial against the
> mounter SID.  With this change, mprotect() succeeds.
>=20
> Tested on arm64 QEMU with a small BusyBox initramfs and a purpose-built
> SELinux policy.  The original test was also repeated with Fedora Cloud
> Base 44 userspace and gave the same result.
>=20
> Fixes: 82544d36b172 ("selinux: fix overlayfs mmap() and mprotect() access=
 checks")
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260829213256.5152=
7-1-kmehltretter@gmail.com?part=3D1

