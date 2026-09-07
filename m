Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096E43BF68F
	for <selinux@vger.kernel.org>; Mon,  7 Sep 2026 21:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788815288; cv=none; b=DkrnfJrXkQ+KvCYtVo3SF3+q5FZ4H1V5ONXk8yX/OAf1uRFK3UT1zxB5GcnycbsxKZHGALrQ8fmL7aMPL3kzbjMw37MyWlzuSfCGR/goKGu+62nL18bDjXAKWKs0CqTzSif7EDjNUb8BsOUQgyHsRLo0MC7kvNNXdP37OoMVS8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788815288; c=relaxed/simple;
	bh=8Z6MdFV/n0PwJ5ZtnxHSMYj17rU5aBPil9s1B7bUb8U=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NgGcQkMW1tx6tWZI8ivUhd2Mf2zjhlTGqbxzXcJRKLaFqpv0ee9e42PwQ5XREZlbyXQCrguGzkBGcnXfh16VbRkklkhE82X8UHNd479XWjKn20yjv0JW7qqFE7Jhws3avCyqXFHHZ+O7sfdbD9aVjZr6LXsxTi969RKZ5qyhEcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhuUoMQW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhuUoMQW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82221F00A3A
	for <selinux@vger.kernel.org>; Mon,  7 Sep 2026 21:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788815286;
	bh=8Z6MdFV/n0PwJ5ZtnxHSMYj17rU5aBPil9s1B7bUb8U=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=DhuUoMQW5sZjib3zHOuvqTqwiNLE106HrxKiW5Pi904dtkl6MmV3jM4mtazgCtISR
	 qZev5q7KKGfv3pm/jKU7mPrDIs6+Txkl5mFmoJgTnQP/HHUDPgggGCSpgkYtHyOMQf
	 P1ca6f18tvtxTogSFwijBgGdRd7G2iS9ahqXFNoTeOmppPZEOqy54Wac/wiZwvPBYT
	 2LGbB0Ax6zL6X2d2lCCRXenNBuh28cN2qFN4gRJRVO2jb5C0r8H4K5uMflEEE3UfPZ
	 05N05Kam15IbuKgEd7QC1rIt5lAbQ9cZwVCuWOV4BjgEZ0p0R9g5pmHzKUyfIvLWIH
	 D6XmbxUykW5yQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] selinux: require PROCESS__PTRACE for FOLL_FORCE
 introspection
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260907-selinux-pokemem-v3-3-0bafbaeafe50@google.com>
References: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com>
 <20260907-selinux-pokemem-v3-3-0bafbaeafe50@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 21:08:06 +0000
Message-Id: <20260907210806.C82221F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> On systems configured with PROC_MEM_FORCE_ALWAYS, ensure that a process c=
an
> only create anonymous executable memory via /proc/self/mem if it has
> PROCESS__PTRACE (like when using /proc/$pid/mem of another process).
>=20
> This closes a hole in code integrity enforcement that Project Zero has us=
ed
> in a remote Android exploit chain:
> It was possible to use a memory corruption bug in a service without
> EXECMEM/EXECMOD/PTRACE permission to overwrite executable code via
> /proc/self/mem, which made it possible to load and run shellcode containi=
ng
> a kernel exploit.
>=20
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: Jann Horn <jannh@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-selinux-po=
kemem-v3-0-0bafbaeafe50@google.com?part=3D3

