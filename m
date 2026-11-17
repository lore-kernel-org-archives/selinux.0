Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911435;
	b=fHnl8BGLUgOCWHgpUJhvKXGjLScvGijEjU4MyfSGs5thq7uhiWnTyDGXORGPqCGhqiu6
	 d5OV8e+c4UKZ+zQN6aA3tMvsDJDqYOgCrpt0dvthlpJ//XNH3ssFs5utiA3itK1YkDjlY
	 OcQJNeMVONkCKqzpynHnI28oQSIa6RhnoU+H5UMwhDx9brxU+bzhv206AStpiMyafr/Em
	 q+GorZ+bQeg8DVv3NJzdZgOWywoj27DPoo/mvtrw4EPjhEcBvd6kIo6FYisNeuT83cB7y
	 w7kMsOsoMx3HQlysmEOY22svx5HJJaJe2T+VZqDEO470UYnI1Mhk8+i1nA89UV7+6iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911435;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cHK20Wcs9ZxStHlc+SS6z4Vur0TX8QusgJbBOmVtKt0=;
	b=1vXz9WP8b3U8owqINqPMPFZcFprMi0CuTLfzW2gy5h7bP3xEn6mWQ5120qldiLMzKV8i
	 GxPU+93RtZ0yJ2BQ86ZpCaJojidL7VGTXHBCJdeF7rT2kmk1ZawB0obdIoWE8CtQcg9nS
	 tDiGvYPeoC+UyOqYI3W9vc4jxcGHG+gSyGvkvkA1abXm/fNvadh1133NNtwCFG3hssAcs
	 60VUjCmHRBgXL0wAW/uPfPN+/Yv8nfuETthigxfQgcHyuUDePzMCOwLW++obhQHqwgFuQ
	 ZcsKXm85PGrRft+C5g2aaa6fVDiuJU/7N45iauZGNGS1HrtOQ/StG4icalHOpIMc5Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BTVY2/6V";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61335606A32C;
	Tue, 17 Nov 2026 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BTVY2/6V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203F81F000C6;
	Tue, 17 Nov 2026 10:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794911435;
	bh=cHK20Wcs9ZxStHlc+SS6z4Vur0TX8QusgJbBOmVtKt0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=BTVY2/6Vadww62pOJyHI4mpDF9D1Nzji5gBMEPaFTjHqlFrSkeLl/5H+358bX6mbl
	 mUgBp0TsCanAyk1xuUhFpvmsBZHZBGgQIcDs+6Wn2AxpZ+JOaJf0AlqnwnvOZQB4be
	 FGniVZ4m+weWSrBj0O0Xt7x82J2HtBqmZjgaSwar6C6wwYtnQbGBNsIYzgc4CGUC+4
	 8jXWgClbIuBcLQ7nPQw/+FMKgIFGZIlmJ7NhZ9q7SQzwlmNr16YHT4i1oBgr4TiAmh
	 Veexlvg02zsfq0QnMkud1nhZBPkjEq7gGb0H5Px4P13EGzcYKD+wBeHllELoeFFI6f
	 85SnUyk8RH4pg==
Message-ID: <sashiko-outbox-218624@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] apparmor: Use security_capable_lsm() for policy
 capabilities
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261117101845.2523770-4-mic@digikod.net>
References: <20261117101845.2523770-1-mic@digikod.net>
 <20261117101845.2523770-4-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 10:30:34 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> AppArmor checks CAP_MAC_ADMIN for policy management and CAP_MAC_OVERRIDE
> for unconfined stacking with cap_capable() instead of capable(), so that
> other stacked LSMs do not have to authorize them.  This also lets a
> process in a Landlock domain that denies CAP_MAC_ADMIN manage AppArmor
> policy, and one that denies CAP_MAC_OVERRIDE avoid the stacking
> restriction on unconfined profile changes.
>=20
> Commit 31ec99e13346 ("apparmor: switch to apparmor to internal capable
> check for policy management") made this choice for CAP_MAC_ADMIN.
>=20
> Switch these checks to security_capable_lsm(), which keeps this choice
> for LSMs that only implement the capable hook.  policy_ns_capable()
> still makes its own aa_capable() check.  Update the comments that
> described these checks.
>=20
> Cc: Georgia Garcia <georgia.garcia@canonical.com>
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: John Johansen <john.johansen@canonical.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117101845.2523=
770-1-mic@digikod.net?part=3D3

