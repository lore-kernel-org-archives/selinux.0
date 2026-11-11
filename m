Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362793;
	b=LH1qajopfe4VyRkGcu5NEgg1hSEx02OdFIqiYAhIgbraQiKE9HLoIN1OCPkZAEC1s6g5
	 6mUOql8LSmTM0k0S7AxoY7zu5XDN1ovUbfbTc5+OVNOEOJsRT6AHNj+a49alBs/creD8Z
	 OQq/Wctouhg7N0DP86ASZYX58MAysl51Ezh3SQ725pyJTc38Nma5WFXEq9RQWGYiFKfLi
	 mY4Y+BVSnoh1yEnZnldrNTA2E2FjvzuosfqmEEdywyBqUv2YZ73SQAXb5Yie3NvWXsuat
	 zq9VokdGZbZXbwlBH6Id/ASuejdbbGeScvsVBmD99MrwD+tmog6acgzF88PvMDdXwTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362793;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wJS5vxw+eGUaWeOZHp6vv5M+wA6RCpUuc0QEcXw6JuU=;
	b=Sje417kn00QPx3ilxCP4MKL2KoSaFp6XXEJZIivkyf3ijDjCh/S353yC7bfrLDigqtZd
	 o/zuS1bv2mLr/HCUpbH+k7uo9Uzj44/Kw6Fh0aoTli9CDbdnJfqPixfiUdVg6b1Nop7jR
	 87kKVgxwLeet7OzLb1EVA9YkO4UnnGi1uOEgHmLXidta8ZL4zkR1mDeWmlDWiYD+HrRpF
	 Ksw+Zxcp8hdeY9w1QbHRq44Ylnl3mvR1hncMGkkjgUDAbSk7OTFlRJtjB8E3eeGRYe17o
	 IeDn+OUsy/rF/1QMZRGTZx9RcH1cNLHQ0RJ2srRYNfSwnUj0gbVQ3cLUUSByanWl8gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K6JZFjyU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18617606A31C;
	Wed, 11 Nov 2026 02:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K6JZFjyU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB1D1F0089F;
	Wed, 11 Nov 2026 02:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362792;
	bh=wJS5vxw+eGUaWeOZHp6vv5M+wA6RCpUuc0QEcXw6JuU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=K6JZFjyUhJ1QbqwKK+hRTubeWNYP2giUsRCSbCmcBteYSYtYDAtFR4hL2liowRq93
	 lkaHvmdE9mgffi930OFoouPtFHvtjmTBgggcVs/zTaoOGNey1ZFIII1u7LhoX0iD2+
	 wBa0SGSCB59ajvBrKaG8MsJo2EM+W4Ln+GAPqnpIvkZ78NXOny+tpTJHt/ZCQv+rvz
	 n03ThE2njdDqVz/dyOhojXOGAqaayLuR7VNZOpIRAOvRJzxNegwGIezutp9w6ohnAK
	 AK3LwGjK72lvb7peEruDTp0eWujgOXnIOjw8ND3uoUILbDiQYL8rwrCG/Wr2Lf+PVx
	 +t7rj7BXIK/MA==
Message-ID: <sashiko-outbox-208066@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] selftests/landlock: Test PR_SET_SECUREBITS
 mediation
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261110202811.2409395-3-mic@digikod.net>
References: <20261110202811.2409395-1-mic@digikod.net>
 <20261110202811.2409395-3-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 02:06:31 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> The preceding commoncap fix routes the CAP_SETPCAP check for privileged
> PR_SET_SECUREBITS requests through the ordinary capable hooks.  Add a
> focused Landlock regression test for this path.
>=20
> Keep CAP_SETPCAP effective to isolate Landlock mediation and run the
> audit case in a child domain.  A privileged change returns EPERM and
> emits an exact CAP_SETPCAP record, then an unprivileged-only change
> succeeds.  After the child exits, require the domain deallocation record
> to report exactly one denial; this proves that the second operation did
> not create a hidden denial without relying on an asynchronous no-record
> timeout.
>=20
> The existing check-exec securebits fixture already covers commoncap's
> privileged, unprivileged, locked, and user-namespace semantics.  Without
> the preceding fix, this Landlock audit test fails.
>=20
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110202811.2409=
395-1-mic@digikod.net?part=3D2

