Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794238959;
	b=qgpF/Nj2XU7CG2JldP0AA1MTFlHzxr3g8W1baIbHX5R5w/0b9XgkIMrBve+B0Lq7q45N
	 GGN0KJ6vE4ZyXF4+Z8eb0Va2mw97fHss/RTgs8Sa60v6Ga/j34LIgBqBFAOyh+mpxEqFw
	 84ctyLXFxhRr0a2RSygWuEqfW3mee81gs9UHmdeqsqcJvp38r9WcrFVndO5x4K9NaZUGk
	 EGC5zwQggeCs7xBL+S/KeXgRweaW2AcPAqhFOjRlxIJru8fFBVnHFw5Z7Rihpm9cDDTPN
	 hR7SfDFyTdBXvZmOC8Io8xvca16/W9gk+Ou83qctmMtZ2c6iqgRrxNA4dIRCB+sgPLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238959;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GR7m3SMLSalIL9HwwQx10qZ53E0cPneODotPrJ6wTys=;
	b=oSPXZe2Ny82GrgEok9RWoVAdLGNqRfYfSQKl/z0JUA7XMTUePQZBJ+b9SYP9ExyD33xN
	 Fh8ZjVeCWnjPujD9vF7TAtRzMdCU2YiNAlVh0e8iAjTCo8Tx5xU5APk4eX29htYNDMOLM
	 Gqz78fue6TEcvLkrtAfpODWdA4EDhars20r4+YS69qUr8V3BF6rsXEkxYFG4HXh2rQQ/g
	 NrWspDJRaBdZrHVoz9AJGuR1jVDhqzyEZO/VdQj17VdXTv5veGIZa6pBWFh6mfP5V0KI4
	 lqlVt+uZ/PeIZV6lq3xZ9iQOVLjiLnFhyKOuz4QXTTExhJf2XY1leFMGTcx9YaQx4bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CJEXgPjU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00916606A31C
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CJEXgPjU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740651F0089F
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 15:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794238958;
	bh=GR7m3SMLSalIL9HwwQx10qZ53E0cPneODotPrJ6wTys=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=CJEXgPjU7TnvG5VLbBlOp9L9sPHZF1oZXqWV+bIQLTEf2Ofa5f5GWu5joeBU7Ojc8
	 7tdPmn+eGs6YBDmukMefXBmIO1991fpkYLJPV5VaTBdEBZI0EY+/9y+FKtOHAtSywL
	 ahxdkRHehzW9xnNSJ5eAldxXfuAZ8TtGj/f6yjP28VbR8nfxLgjnzJxJa/YX2nfrAR
	 J+VDK2jI++HUz+X0g5N11PFnYHNZvmwIA5BfXQj/McEDIVmbTPFFrf9lwEDrLS0ayp
	 f4NOaxLaQ9WSSFkzppjtvEiR51dLcf5WaYJSIvwkZR4R5C1lyZeMjR6nxP4sYRTHQK
	 fhsOuibTlSpaA==
Message-ID: <sashiko-outbox-205168@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] selinux: zero-initialize permission name array
 in masked av dump
Reply-To: sashiko-reviews@lists.linux.dev
To: selinux@vger.kernel.org
In-Reply-To: <20261109153802.76176-5-cgoettsche@seltendoof.de>
References: <20261109153802.76176-1-cgoettsche@seltendoof.de>
 <20261109153802.76176-5-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 15:42:38 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>=20
> security_dump_masked_av() declares an on-stack array
>=20
> 	char *permission_names[SEL_VEC_MAX];
>=20
> and only fills the entries that correspond to permissions actually
> defined for the target class (and its common) via hashtab_map() and
> dump_masked_av_helper().  It then walks the set bits of the masked
> access vector and logs, for each bit, permission_names[index] or the
> "????" fallback when the slot is NULL.
>=20
> The array is never initialized, so any set bit whose index has no
> defined permission for the class reads an uninitialized stack pointer,
> which is then passed to audit_log_format("%s").
>=20
> Zero-initialize the array so undefined slots are NULL and are reported
> as "????", exactly as the existing fallback intends.  Rejecting such AV
> rules at load time is deliberately not done here: it would break
> policies that older toolchains legitimately produced.
>=20
> Fixes: 44c2d9bdd702 ("Add audit messages on type boundary violations")
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109153802.7617=
6-5-cgoettsche@seltendoof.de?part=3D1

