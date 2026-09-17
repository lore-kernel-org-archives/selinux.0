Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3D558B6D6
	for <selinux@vger.kernel.org>; Thu, 17 Sep 2026 14:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655210; cv=none; b=V9D+sda0TglUlv4cgYHmPHr3Vei+/2O/gdW3FD39MMITMstLDnbmOecWPPoLbQRk4Wx34Zb7wv4Vtm9flvOn9djt0Mis+S010n/cBN2zW1B8VUbSGa6o4+E9E3+qjReriS0kME3lc1poUzpDf4AOaHTDxH97un9R+zzNTeNsq3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655210; c=relaxed/simple;
	bh=WlX3wdTaw0GBCFfyP+iuD4dxHv/5HM439qaR5Gug4ys=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A0umyzEgE6aD4FP64u6P+NgphiMEPZqKOTCszH/6RApWzlY3AiOZ+r51bbjdI1hYq1c7V3FibXl5HPoPPcBxDJ/uMKDV0jftwb485VMbk1/jdNSDkFT9fUjGDVll65B58waGEg7LVOo3NQzZXW+WynRkRkXOvWKnaFrbsL559qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDNHpSvX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDNHpSvX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D6F1F00893
	for <selinux@vger.kernel.org>; Thu, 17 Sep 2026 14:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789655209;
	bh=WlX3wdTaw0GBCFfyP+iuD4dxHv/5HM439qaR5Gug4ys=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=JDNHpSvXyGRJ5CNtnF5YmoFu6Z/usYrwAHExJ0WtJSD7Y+F8cef320MsoQcKrG6zu
	 O+owZbCGYvkNu8+kKgxw/p1fMt0hNH7hOXse4lyUdLYbFgZT070oux9+/R9kubZreK
	 mlz4+IcahLLqd/3s+4HIb07dNDLW0dHyiMyo/sa6kPd516cWjlING+Npzkdp13T7Yi
	 ghxcgzj2RPp5KEaAANMmqCaE30hy4/6BXmuoJMyCBS8FkDOi0XdMbt4c8Cj//Fq43Y
	 E58hG0oFpuuarlDHIwG7keBJSEXzf3Z6V2y2mMXevVkdEqXe9DhUBxacqYbbt5XSUI
	 TcOBkyUpPXniQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selinux: constify avc function parameters
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260917141317.54719-1-cgoettsche@seltendoof.de>
References: <20260917141317.54719-1-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 14:26:49 +0000
Message-Id: <20260917142649.76D6F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>=20
> Constify read-only decision structs to ease reasoning where decisions
> are actually modified, and where only processed.
>=20
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917141317.5471=
9-1-cgoettsche@seltendoof.de?part=3D1

