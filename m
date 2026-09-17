Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA315908A3
	for <selinux@vger.kernel.org>; Thu, 17 Sep 2026 14:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655185; cv=none; b=Y2XZ2yatpCNQw+bxq9k8EgMRbsA3AaekfSenDCgk4S9JBLiPJsAeCF62PjUCK6slUKOtDBAYwDVDuInv62HOZWgifHZJ2M5Qi5mS82eLj6ULJtzK7G//jXXQ9n7QomZPT8DEN/UJmso3977PqK0atG8KYZc17ReY/SxswkqXIaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655185; c=relaxed/simple;
	bh=Xq/rrMQ6b2hTZ2wDFQY+m/8VPJ2whrnvtdmCbKVjd/o=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sQNDKwtD4qNVkmG+MtIX5HKIA/c0MJoCAqFfwvXpui/9EwW3QGXb0PdtKhlni6c1XlGYbNr41ayQY5O5lKQ6DvspFdxlGthKTNnHtKd2CH09whAM8Nm/AcFhO7Bg6adBZzZ58vOwC+sr715RgYvkQIp5wVXVcwFaifFR4Px8ggc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgtY5qkb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgtY5qkb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9626A1F00893
	for <selinux@vger.kernel.org>; Thu, 17 Sep 2026 14:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789655183;
	bh=Xq/rrMQ6b2hTZ2wDFQY+m/8VPJ2whrnvtdmCbKVjd/o=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ZgtY5qkbLp6GyTzNB7EVsv7VBjE6YyxCuj/wovexo6vJFwwa34sT/p1/Xx7pQbQ5a
	 QhTP1yYh/pdc4d8gl+FbzLfEICAm5iPBbW9xQ5jwqp8cgwVoa4521JmsXSjwrOafHv
	 QQCcBBKx9psGeLarwjXg7pi9ZoufUKzR5JDXtNoESxKnJPv3RKzjJvQDknbHecARa9
	 bO5KUoJZ13dM4/OA5R/WH5ihEm1YicB2wsA6EOu1QIBsBIsZ3/hSBA0Q8AcK4EcVqX
	 3r8/UIa89fu0uxLduduZY9oS5Z1SP6EGtxKTeKD12pjgazHqoS3OHQe4hwDEaC1YOh
	 J8d016C0UQ96A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selinux: reject a policy that both rejects and allows
 unknown classes
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260917142038.60637-1-cgoettsche@seltendoof.de>
References: <20260917142038.60637-1-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 14:26:23 +0000
Message-Id: <20260917142623.9626A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>=20
> handle-unknown is a single three-valued choice - deny, reject or allow -
> but the policydb header spells it as two independent bits and
> policydb_read() takes any combination of them.
>=20
> libsepol writes exactly one of the three values
> (POLICYDB_CONFIG_UNKNOWN_MASK & p->handle_unknown), so no policy built by
> the reference toolchain carries this combination.
>=20
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917142038.6063=
7-1-cgoettsche@seltendoof.de?part=3D1

