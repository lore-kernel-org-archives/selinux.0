Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC0C43CE45
	for <selinux@vger.kernel.org>; Thu, 27 Aug 2026 15:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787843911; cv=none; b=qdEKXbKBYOMz+PD4FMkDlKiZmDtRjbkq1rHBV8hETcSCly90mXD+UHBVxESOdV4rXiJePCMxjBekpT2Lpx1pnz68OeEKp7AtVvizNbBrVyalcu5fbryDW+FFxCiAzy51RmpNix4y32IzDMQtvJI+cq1SIscPWvqpB13r7LNWyhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787843911; c=relaxed/simple;
	bh=jBI7mktB817g4ibw7SUueBszAS2VqI/0ILVp8OIbd0w=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z+r2r8iiYdUjqsGKQCyz1FRmR9vEYP+/ZxR+SJaLtI9sKMM0ykrOuitTygFyDhbfSLYFIDR0fhfexl/uw5k+mPzA0TI8KZp+uZosMwISVMa3b6kubZTBrqj2ugiVRSdP5XXeTYw31mlsbmrgiofBYfV3rRS1sIVfObm5cjxeuMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etUn80w6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etUn80w6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848511F000E9
	for <selinux@vger.kernel.org>; Thu, 27 Aug 2026 15:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787843905;
	bh=CG9hnyR93As2VFh26mIfSlljVV9/RdTp3LSLgFAXdG4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=etUn80w66B/mF2gmMGo3SGkFQZfuF09QgAYILne9+Ir0INxCPBpNXnFGK+O8OMtGc
	 V0NePotv9H9RrR0RMVddMC/Hhcnv+pGmTXkQU0pkWWC9imXq2OeX+ghu5A4mRnwP63
	 Tj0UgHXkBbS1YI22xj+8e3gsuDgqBkFY4pXXXlFZHQkNDygDBqJLPhYUnX915FKMLP
	 SZD4/LzRc/HXAWdlyp3rlObeJkLnvBMrG5QkEBjoXAR1DnIY0/+4MGhZNcmQSlk3TI
	 y5Dtpq4BWfsx+KbS+V125gSl0Vdm2e8+JcoWxYt39HLB9zdwIce/nVBfpfimkbTVFY
	 /cC6xivQfBJ6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selinux: fix BPF token permission checks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260827151126.107545-2-paul@paul-moore.com>
References: <20260827151126.107545-2-paul@paul-moore.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 15:18:25 +0000
Message-Id: <20260827151825.848511F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> Avoid multiple lookups of the bpffs creator SID using the token's file
> descriptor when the same information can be found via the resolved
> path/dentry (in selinux_bpf_token_create()) or the token itself (in
> selinux_bpf_map_create() and selinux_bpf_prog_load()).  Not only does
> this simplify the code, it avoids potential TOCTOU issues if the user
> changes the token file descriptor passed into the kernel.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 5473a722f782 ("selinux: add support for BPF token access control")
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827151126.1075=
45-2-paul@paul-moore.com?part=3D1

