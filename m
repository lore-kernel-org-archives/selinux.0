Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B2E47F2D3
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 11:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436365; cv=none; b=ihxyQGEx2eCoG439wvTu52ynu31bLlIdz7SGhqoiLlkAXzJmPjSYLOGp9PJDfvPnQXY5IBxsKdXVFlX5bq/y/Z32X1wLTzv0HmaMAeaFabzlF0fkAo+x5FDsqLXDXM+70rDznyNupzLLojk1jrX159SvYwYM+Z5uXYjAzsn0zCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436365; c=relaxed/simple;
	bh=5y90gRcwUyQbedu3AiYLKA6Qx32M3aH2SsfONMHm4Gg=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CV3wDSi1pjTUKNlHB8lJ9MkuW1bdCEjdUSifVJ1iH4/+/KIdFxxJcug0i1jBdKF4hb8ggyRB+iT/HZ6+xwk6S00yb0s2VVjePVXfbv29Xc3mtXuhLIOSq2EHE84USBZvQnYv029qAz1fWUAzvWMrhQYAqjcafyZnY4+nexyYcLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkBfvauS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkBfvauS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1B31F00A3A
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 11:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788436357;
	bh=5y90gRcwUyQbedu3AiYLKA6Qx32M3aH2SsfONMHm4Gg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=YkBfvauSj8MTKLwZnO6sLbsFN8PsChDuvjJFw4vM+QCrNT7EOU6iK6xhdMRgpvmWw
	 OhkYxE7JD4YTMuguMu7d3nGPvDVJU2MPsw8qWjlP7zBIdiLusr6ulIHt/oWStSQjbK
	 SQTGGBiwHHQ2oZ+0eQmhsGZLSRQ/nfh8ueHyrJ0kCFDvrfA9i/b2Y3usePYa+QP0x8
	 WhZ8pgFUhYzD+L89BmYiqKbKL2GM+n7wpjt2U4DoCkJ7sjrjPohl7mwtMfSJK1CrI8
	 z5IMdcWzXHY1CaIkWzmZMpgDsoWnpROqN44wrlXMep2sM91hobljtTn86cZ2X4rejX
	 ey7He0Ot1Nsqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] selinux: bounds-check filename transition source
 types at load
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260903113538.72942-1-cgoettsche@seltendoof.de>
References: <20260903113538.72942-1-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 11:52:37 +0000
Message-Id: <20260903115237.7C1B31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>=20
> filename_trans_read_helper() validates the target type, target class and
> each datum's otype, but the per-datum stypes ebitmap is read without any
> bound on its set bits.
> Reject a stypes bitmap whose highest set bit is not a defined type.
>=20
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903113538.7294=
2-1-cgoettsche@seltendoof.de?part=3D2

