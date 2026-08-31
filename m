Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507683A7587
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 22:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788217076; cv=none; b=acOkuDx4McmqS9/QfoqDudipBQCoz5G17u1rV4OZ3dBSUiCNr4CobtP+QzLBlkt/VjqgPwRKzPznNMHeAdCGNG7W8sw24H3Ld4AQ3MJpBckoXk7OKmnve42CL6XWMFNO7fmpPBwpkefwrdwSKC4iJkE/DcB6EKHIEe3kr7xRB0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788217076; c=relaxed/simple;
	bh=s5oY56mOHcXcwDAXcpyg+9fHRp9DnfU5xKPuT+lOV4w=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XgP2MHFzHhhZJqAejgDkQW0zaFSDH61D31XDjDw8DCVwGNM6tREyjKZ9oiMAV/nhXIvE6VnZFp40el+PcQXRkR1J/isZGwP1IHYBx4WXi9ccnpdwxAsue4W6VtBM01XBRWSKTOfFwSKGa//eMRtUVGNRIV+acf6//wnWrju6DfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdMA0z6S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdMA0z6S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53861F000E9
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 22:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788217074;
	bh=s5oY56mOHcXcwDAXcpyg+9fHRp9DnfU5xKPuT+lOV4w=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=WdMA0z6SyL+glqkyIjO3ih/hKiUsBKx0fL9MbM1/6XEvsUqXWN88sgcHklOILDEz1
	 BmqNJnfpvezHuo8Tzfe4q0ZDf5oEL4qPD9asX1TO2oAbp+FCFTktOFcyIhnK5SOmEn
	 keG5KUB/e+E3+rfeSjq/nODYHZrrhd1Kj+cEdgDCgWuBBpbEjgswAtf/3nQhzcDHX1
	 3rdmgm57wKsTnchamO/DKdITpnDU9ffRlFVII3n45dgRgphh7s1skI8v8MTcKZDKpy
	 t0rBVsWpckFn3PIbMKfsckVkqZsmlzIZjlasVjOCLGTr32+QnxeFxkeFT5I8plpJIG
	 lOUFsCz+kuopw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] net, smack: Create a function to set secmarks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260831223748.4304-2-casey@schaufler-ca.com>
References: <20260831223748.4304-1-casey@schaufler-ca.com>
 <20260831223748.4304-2-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:57:54 +0000
Message-Id: <20260831225754.B53861F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> Rather than open coding assignments to skb->secmark, use a helper function
> secxa_set_secmark(). This allows for a case where assigning a secmark
> is more complex than a simple assignment. The version of the function
> here does the legacy simple assignment.
>=20
> Change the functions that currently assign values to skb->secmark to
> use this function.
>=20
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831223748.4304=
-1-casey@schaufler-ca.com?part=3D1

