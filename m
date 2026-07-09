Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD783D45D4
	for <selinux@vger.kernel.org>; Thu,  9 Jul 2026 06:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579053; cv=none; b=hJnoSBiPPcRvwhiSPWDPtAbwDXi7qJ6hWPbUsQm4hPwdJjEJL06hf5Z/CjkmD8oObK6XNUGf4wySHtIP0GNrEch4269dCIDnKgYtQA/VyLNyeTnoyziRnKeXfN8D1s8XHSIHQPxI8JBPC+/Zrj+tivvTTIinIh/tilgknvVwYPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579053; c=relaxed/simple;
	bh=7TLRfCoYW8+3Sz1X7jiWXsnb1aa8fuDbP0wL793eNMw=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XPlLaD1L1Oxb9fvZ2vggU/xHFspWRwfRIpx02YZOafTsWcOnDSY7tHOn85GSkXcX5FIVhTONvrLheQogWyv94cWw0ZcLtTqZ4LlLWIkI2BojSfoZxEcaMPHSogAlwZ1CZdjh1PvpHW/abFrPNqLivjtOUImFLb/vJltR3exxWok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmFvOhAg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmFvOhAg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B9E1F00A3A
	for <selinux@vger.kernel.org>; Thu,  9 Jul 2026 06:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783579049;
	bh=ctPU9TsajIVEmzE8iAcEWDxwBMy9skYdsuI3lJLywzo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=KmFvOhAgTInWVajP9broSrPLIvRuP3Fbbwf5wzT85O5D2tBkAiNazXvFWJYf4UaIl
	 QWCIn2EvUk9XAw67vU2GWqjjw98wSRo5UtHzOkIoCY7xH6Qi46s/a6MbxwbbWXpo3c
	 rv4L9lI30tfV/ZWvs3jinqm/isAuEnoWzX11nc1ppHp+jcbuk2/WvPs2dH9TcC+uWt
	 jxmTRmPT3f/2zLs0+0ApJCwbX87Dpb4x4OKTzIXj+e+50wfJgGsbRREjuqFsLCUTPV
	 paV8bK7kxY7zeHSZOO+bb8kSeYc6vD9TPf8QJozVFsuMVFMoHtSoh07qU1Qg36+JuG
	 3LJMZX9bSbaSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] selinux: suppress warning flood for retired DCCP
 netlink messages
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260709063128.75873-1-laoar.shao@gmail.com>
References: <20260709063128.75873-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 06:37:28 +0000
Message-Id: <20260709063729.04B9E1F00A3A@smtp.kernel.org>
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
> Use pr_warn_once() for the retired DCCPDIAG_GETSOCK to prevent message
> flooding.
>=20
> Link: https://github.com/iproute2/iproute2/blob/main/misc/ss.c#L3901 [0]
> Fixes: 2a63dd0edf38 ("net: Retire DCCP socket.")
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709063128.7587=
3-1-laoar.shao@gmail.com?part=3D1

