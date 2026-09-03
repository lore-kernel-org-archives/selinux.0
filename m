Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5188348033C
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 11:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436653; cv=none; b=bt9ovhz9w5nLvPeEFgCSA7+hxAkVtS3oNpSPJb6FV5/f7rO8XK9+JA1lcQEg1w3WuYU2IEaTyaSr0auhgxSoOcukg1G1iZXKK4y+BvPPRtSdE1nSjvswU46QGlSqwA+SVPmLXH/nDn/yD8BnGBY6VCExhdVUL/HvyMc0ztdY0sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436653; c=relaxed/simple;
	bh=d/DssX41ytoVtzm6PwqkF0tkjDRKHJekYHe2acBk9jM=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G9fDNyLYYGQ6yfev1FRoJa1j6BEQ0Ms7HHS1oD4Czq9QA4im3ihZI3ODOxsiNdYQQTpBsK/n5tnGaDZ8XQritPrQsp/+rcnMCi/VqCjxokS/AaJr4bYwQh/9r/nJNRMMrcCEKIZTQ5ounSMMBZzBGM1geCtVAdHV/Z2d8GTBbAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgZKje7a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgZKje7a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99F11F000E9
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 11:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788436649;
	bh=d/DssX41ytoVtzm6PwqkF0tkjDRKHJekYHe2acBk9jM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=kgZKje7aTFZWo9LIH/Hiks3ha5pYEbfsqeWlErN+MfNvj6CLFvbNZeboHt3fA/0fj
	 RfAe3dIF0cvbrGwlWYIBFgK5D9XCaXo7QP5eWI+jSMJhkFmYnh8Dj4R4vEU77IqnYk
	 DQEbJ+idbeo8Qg+LNe8Nk2a+PAdZ2gGkhSwVIhxK8cfYiLM9OtdZVN14z9dsUifUFO
	 LUWNNkRq+ZFFIXNVCEl5EwhrOev6GZ3wVEa1uJc+rK2gNzo57EMEpIjTqNIX2WYUk3
	 yzNgLUOZOwr5ui7tW3B2XE3Fo7klblJkq0H8yV8SH+WzZGEAkyHFc4YADml4ymdGZB
	 fcVfkvT0vrCEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] selinux: reject duplicate symbol values during
 policy load
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260903113538.72942-5-cgoettsche@seltendoof.de>
References: <20260903113538.72942-1-cgoettsche@seltendoof.de>
 <20260903113538.72942-5-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 11:57:28 +0000
Message-Id: <20260903115728.E99F11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>=20
> The symbol index functions assign unconditionally, so two symbols that
> share a value silently overwrite each other and leave another value with
> no entry.
> Reject a value whose slot is already populated, for commons, classes,
> roles, types, users, sensitivities and categories;
> booleans already have their own "declared but not defined" check.
>=20
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903113538.7294=
2-1-cgoettsche@seltendoof.de?part=3D1

