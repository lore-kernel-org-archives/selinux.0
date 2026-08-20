Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7373812E1
	for <selinux@vger.kernel.org>; Thu, 20 Aug 2026 06:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787206857; cv=none; b=bNKGZH3rqxx2qiIkIXloQBT2nsNiOQ8Cqq6o9fMCumDLWMDASj9kBIJAKVmfe9ce0AjSh5KhqPTY/UQHAnlYfk7seuHTLYjvpTgZlh2SwPRWPuAwD9Eaz1DGS4IwQyRofMa/9LcqVJflLiqBrpEBjs/S1y4OyCNeCRsFzqKlrxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787206857; c=relaxed/simple;
	bh=JebF7KwHzR0CC3E6gRKhW8A9acwtzzQjAqdUis2M5qQ=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jM+MKcR2IAf6ZYj1bKtlk6d/l/97Z0iipybvHk5cFt/hvnXItOL73GO+JRdTNt7pT9hVtaENy8YNrVN6G9UDt92qz2jk5elLi3Hli1sCOETRl3i+KzrD+DeCwd9LNWtFaOgrGzVP3vsS8UJPDK/3knSF3ohSoao8jxfSRDrycjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2DAZKzw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2DAZKzw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DF11F000E9
	for <selinux@vger.kernel.org>; Thu, 20 Aug 2026 06:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787206855;
	bh=OG2kcbb/t0umTY9xaNtsq5juT816RhJchLV05byG5fk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=J2DAZKzw13E4Nrg/fKmGSCjAGoyg5bIBGuGOhJcsI25O3qCeHVUHvfcpWe9N/F63o
	 DEAjaoAUZVbyMitMBFmruPsrzNZteAXdOvF6p9vxhOjALBajfwISZVX4vwFseM4ct1
	 AO6FONY+2ZSdwcTdydtKNxvCpfv5ZbeNqGEvSQ+FwAHAxwLk7kNG/8XjoAROms3kV2
	 anTbKvRs9pOWPUbnZBmPS8QSr2IclXCO4ZD42e+zT0HwUeIUiUeFPqghdLDZhY8uHm
	 YxE5JLwtteu+jL1xVnuWRGhKsojDrctTTHgPr7WfBcyx47QMEPmpL204P1hASF9pTe
	 Gxmc9ny/isR/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selinux: preserve user SID across nested backing files
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260820061349.10542-1-kmehltretter@gmail.com>
References: <20260820061349.10542-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 06:20:55 +0000
Message-Id: <20260820062055.B0DF11F000E9@smtp.kernel.org>
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
> Fixes: 82544d36b172 ("selinux: fix overlayfs mmap() and mprotect() access=
 checks")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820061349.1054=
2-1-kmehltretter@gmail.com?part=3D1

