Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC0A39A06C
	for <selinux@vger.kernel.org>; Mon, 29 Jun 2026 06:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782715117; cv=none; b=iBHdO0939nXwm+uLU/h0L7qAzj99GTY0gVYyjJ4PD0xqXHz9J8MhIFilcFaP/UN4VHSJitpRDC/CIlANdzE0Zvv+JeDp7qAk+pdoWzgpcb1UV414wva8xDFFLOSD03yhEwlHNPYPX/HFgE71hpTFgiuWE3pHhNDhnkCAoi3A6hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782715117; c=relaxed/simple;
	bh=MRloOSIrSXVeIckeXef8BgjJ89OdJ+jixZ3QorqEhnk=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qEds/m7iyoTnTe+wcs8WGD7yq4wIci8qvQ7fKL7EJQd3zxc2njD7wChh5CQ77FhDz44MnDSnvRlaJRAt3z1cFhroJ5AhkUQBta6Q71e9kWO2j5Ix3eomT9tJ7camub4/AH0WeI+b4+p+IHdZ0herCvusgiV8inkzg8X4LaIOEz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSoNLM8y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSoNLM8y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE6E1F000E9
	for <selinux@vger.kernel.org>; Mon, 29 Jun 2026 06:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782715116;
	bh=nmTFr/9WkcrHQ+DXEy/Z+PfrBMt94HKlDYBiAMTpTIQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=gSoNLM8yO+OdiTmXxxl5rYp3glluFg6gB9SnSoSecx5LCphHOQ7Z7BItXqghA1XI8
	 WVcCoTCfCYHGR3I0sTQw+NeF8Hbi7LVjwEkZoAkL3pOHRMk26B7DezZoyuUD70b9SB
	 uR+O8l+An/eL8JFxyxpeqiuNr0ZQUaivv6dyDmT2OcRFcmYWkLtk5bin64/Z0/v+Tc
	 4Ew9vO1ZWgosF6n76qDDAhPV2ySqMsCzv8+NmV8N1D9pjG2KzWuG0regvqZnY938ut
	 T7/KSopwx6tDuQj9cDhTtBZpB9F+tg73/E9Yhaf+MLfOwBxQg9zH4nMrIRUcqxDhh6
	 3WHYZsNCTBGcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selinux: suppress warning flood for retired DCCP
 netlink messages
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260629063005.64700-1-laoar.shao@gmail.com>
References: <20260629063005.64700-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 06:38:35 +0000
Message-Id: <20260629063836.2AE6E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> When deploying linux-6.18.y stable kernel to production servers, we
> observed kernel dmesg being flooded with SELinux warnings when running
> `ss -l`:
>=20
>   SELinux: unrecognized netlink message: protocol=3D4 nlmsg_type=3D19 \
>     sclass=3Dnetlink_tcpdiag_socket pid=3D188945 comm=3Dss
>=20
> The root cause is that DCCP support was retired in
> commit 2a63dd0edf38 ("net: Retire DCCP socket."). Consequently,
> DCCPDIAG_GETSOCK was removed from nlmsg_tcpdiag_perms. This causes
> nlmsg_perm() to return -EINVAL, triggering the SELinux warning for every
> `ss -l` invocation [0].
>=20
> Since this is a retired feature rather than an invalid operation, return
> -ENOENT instead of -EINVAL. This suppresses the warning flood while maint=
aining
> correct error semantics for user space.
>=20
> Link: https://github.com/iproute2/iproute2/blob/main/misc/ss.c#L3901 [0]
> Fixes: 2a63dd0edf38 ("net: Retire DCCP socket.")
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629063005.6470=
0-1-laoar.shao@gmail.com?part=3D1

