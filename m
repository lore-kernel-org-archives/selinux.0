Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24DE481FCA
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436362; cv=none; b=t/eMKJ+VHPTaHLNPa7keCKEqbZi0irWwyDbcGEM9xT7XmeowwSPaXsmMkuaJPh0IUdlWCgAvS4DrJl9C4D+PZ2BLsc9lalKLPdOl7IUm0V2tKPauLZJw5gxfb536Cx5XQML9O2DMWCjGa2kT/OgYuYuxY4uW/EP700L/LNHrOA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436362; c=relaxed/simple;
	bh=INrwO+ivJeuztd/PVdhsI1gNTBx/2EuBmCdSvru0x7w=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uq8eryEodk41Iu8GelRtzSm2V4pWL/y9cnrkRXfkT8b5+PmMRcelDDRfMS0mZy2aDW/bpdkpNTczrbykvOYSzPqIHvVO8VpQe0aWNxXJ+mlg+/EIapa/DRk/8CCRTDyK7zlwdc800L6Udg3lqS4Kq3ImklCiLXPiqFuMTvfROrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZd2Z3c4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZd2Z3c4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF94F1F000E9
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 11:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788436356;
	bh=INrwO+ivJeuztd/PVdhsI1gNTBx/2EuBmCdSvru0x7w=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=IZd2Z3c4tjHzbdW0IBOtW3E216l2C+EaUH3nnxHGa8OjnQN57idRHIe1aKtycQG+2
	 a286cwpxQVow/lvKzwjX6TCuuYzdUgtURSe2qWrem8pEa86Qa+/wggwT2C2zlE+Nxn
	 lV045zlty8tOFnNYU57BQOxOLHRfGrIO8xxYzEldP5dStWHvq7Ad7nzy5Gne+CZ5bg
	 jxqmbzb9WjY4/nQpNP7yfaJo/JswuLdDFkX4W9R8dCHg7cGhz84ZbEvRE7XLPt2XTh
	 8RYaJxIgB3grCiP2TcWSb1oDcYm0PDFvhHlDtwIs1mS5Ds0aKxhy6kE094iFr31mil
	 uHbQh1DKG2zpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] selinux: validate user MLS range and default level
 at load
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260903113538.72942-3-cgoettsche@seltendoof.de>
References: <20260903113538.72942-1-cgoettsche@seltendoof.de>
 <20260903113538.72942-3-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 11:52:36 +0000
Message-Id: <20260903115236.BF94F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>=20
> user_read() reads each user's MLS range and default level but, unlike
> range transitions and security contexts, never validates them.
> Validate usr->range and usr->dfltlevel in user_index_check() when MLS is
> enabled, once the level and category symbol tables are populated.
>=20
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903113538.7294=
2-1-cgoettsche@seltendoof.de?part=3D4

