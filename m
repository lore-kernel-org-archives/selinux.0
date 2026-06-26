Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F0C3BD241
	for <selinux@vger.kernel.org>; Fri, 26 Jun 2026 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782489825; cv=none; b=WSiwjS2kaeDK5EZVx2INRVNqQz/0BzbXaOJKKSzPBZ+H8jk4s83dpdIeez1isf3X/WytAJvdIV4NnxEabVDJSLrcJdU+WZnMKrYkI0IOboqXlQLeDVIwT4A0sN8EKDDgCB94y6QrqFuruxiKk5OssZX5sPnNMXU595niu+kDcvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782489825; c=relaxed/simple;
	bh=eCx1fT/vmgav//vDxemO+s6jqHdygE8PM5jlORwiu9Q=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PFJJ1JYDE4reefD6+7Zt0LQR1Z/yy1rIM6LBdyZ/q24NQrMMdr/LLtXe6OBRFGMXFawvdtWPhvlrYMX1qx7tesapCJ61kbo6eKN41Cgku2IRpNxokwaPEZs86IbZCyGhzGFNIvbtuyV69KgEDHLR47E10pzY17jqpBEP4VCG7ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agFCtuDw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agFCtuDw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFC91F00A3A
	for <selinux@vger.kernel.org>; Fri, 26 Jun 2026 16:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782489822;
	bh=eCx1fT/vmgav//vDxemO+s6jqHdygE8PM5jlORwiu9Q=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=agFCtuDwpyA2JKwEAMgHc8doLK/QOuD4hXNVYjEGOKRLSIRTpjB1lFlTPRa79Na4o
	 GvqK69lfk1OnCz6f81OgC/Rw1pXlRfidL4gdaAN4yP9qUYnbXaeLeo/wZj0rqWWx8P
	 QOck7mBsvC1pmzthlvU3v+x2wsbMC3hwqyyOMf9as508vl5lU71TuHiEvZdI/ZkSDs
	 W/LhdAxNB7CxJG8GgSHepkspOXjQy6RFhm0+vA2N8AK5tO3fxSViFu5Ren6d1aM0Zp
	 sLm0aHSouuWKt9/Lp9Xt9HZ4mPzOdx4PmmrSOTCVX5I2oRiW3o4Nm/IABITpKwihBO
	 /6qKGTD83+euA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] selinux: replace strlcat() with seq_buf in
 selinux_ima_collect_state()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <aj6hVjECikvYtnED@dev>
References: <aj6hVjECikvYtnED@dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 16:03:41 +0000
Message-Id: <20260626160341.CFFC91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> In preparation for removing the deprecated strlcat() API[1], replace the
> strscpy()/strlcat() chain in selinux_ima_collect_state() with a struct
> seq_buf, which tracks the write position and remaining space internally.
>=20
> Each field is written with seq_buf_printf() using a "=3D%d;" format, which
> removes the open-coded "=3D1;"/"=3D0;" constants. The seven per-append
> WARN_ON(rc >=3D buf_len) truncation checks are replaced by a single
> seq_buf_has_overflowed() check after the string is built.
>=20
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Ian Bridges <icb@fastmail.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/aj6hVjECikvYtnED@de=
v?part=3D1

