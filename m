Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716D6426689
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785520229; cv=none; b=dUCbmE8tUxoK6ku1+oYV7kS65boFPXb2I/9z/EhigZUUB5+hrR70fgmdxAYh36GRMeR7IM7Jyb+KXMwWs31x8SYq3FOP3bQcZjxzF6jm9IXAhMk1Qv0GDltPrpotC1zY4YDBdYbCqLVJwcTR3raXcWVGoKI5UVdjddN7b4YdfwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785520229; c=relaxed/simple;
	bh=1tyLA9I+SqE7Du0BBoA3YL4AYttIryUFwWjOINYg0sM=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pw1d6R8/XldbvJ00NG5RuWFf023KPkvoVUO0tdm7YHhqGyXWQ6QgnrOh8kCVSqk1DxIObLKMZITImWCjvEGt6bHZj16n3oZPqZNSfT3jnkkB5GQuLieLYmK6cLoHWvECUN2KjwV94L/JjCXm2VUYtlLoz/ez3AwIXHJBkOJuUKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2MLp/Kc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2MLp/Kc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DA81F00AC4
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 17:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785520228;
	bh=1tyLA9I+SqE7Du0BBoA3YL4AYttIryUFwWjOINYg0sM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Z2MLp/KcaTm4uD1mG6PhHQNPGBT97N8C1Y2arIh/5S0jFU25txx82/RulQnyYXx4w
	 yM6ztja4vUPG6aJxCs7++PniHpOLsM+HQV1KEj70Rb8bwHfX12H7pN6IzaJBWQjuMv
	 82Qmt1DGbwpabRgC2m+U5Rvz3eyCaOX2G3OZPCkmmd6JCGBQPks1OT8DfKqtOWkItg
	 n1VTyhQiuc2MuTlN/cTCf5b8RYUjOxmzmWmYTxXH148vOGqhB6Rkig6Sk/pq1i6cT6
	 Ir6SOPopFvmmRuQYuMuTeTUCOu0t3Xk4feWfE0boF6ed1hpFizxqUFz2c1Hv43BI9x
	 1BQ5aXU84nF6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] selinux: require a class's permission values to
 cover its permission count
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260731-b4-disp-d32e997b-v1-2-0341d038ee47@proton.me>
References: <20260731-b4-disp-d32e997b-v1-0-0341d038ee47@proton.me>
 <20260731-b4-disp-d32e997b-v1-2-0341d038ee47@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 17:50:27 +0000
Message-Id: <20260731175027.F2DA81F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> From: Bryam Vargas <hexlabsecurity@proton.me>
>=20
> security_get_permissions() sizes an array by the class's permissions.nprim
> and fills it at value - 1, from the inherited common's permission table a=
nd
> then the class's own. A value no permission defines leaves a NULL that
> sel_make_perm_files() passes to d_alloc_name(), an oops inside
> sel_write_load() that strands selinux_state.policy_mutex and leaves every
> later load in uninterruptible sleep; two permissions sharing a value
> overwrite the first kstrdup(). Bounding each value by nprim catches
> neither, and neither would a count: the symbol table is keyed on the
> permission name, so duplicates pass.
>=20
> Track the values each permission table claims and require them to cover
> exactly what its count declares, rejecting a count no value can reach.
> Conforming policies are unaffected.
>=20
> Fixes: 55fcf09b3fe4 ("selinux: add support for querying object classes an=
d permissions from the running policy")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-b4-disp-d3=
2e997b-v1-0-0341d038ee47@proton.me?part=3D2

