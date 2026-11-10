Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343340;
	b=XMUxyyFYhgVmGQchXZh828OyZgiN6AClXKqEY0s8WPGlB6Uj+pbGdVgbUWzIEE4LxAiP
	 Fl1YIX4UHesWK6l/kFy9XJ2Ma5iU6O+XiT/aS7FxcLbuTPiuV3bWfrNHdHP5GXeciwj0/
	 2ukuUqC6K7lCzOC/ew/7u2oPyEi8CkufX8HpjLHWXtK+st1FgSPbPgV0uAbIzEeo5Fw7I
	 BW+sk7fui4CwCMm9ssWU6K867Mt3uGN8PmkcI8RkYFSXau5NWKiQOaCS7owFvormuj6tG
	 p34u9mouSfzlbYVDNLLQ0W/CaUHD0o2WPKAME77xjtdapUd/Dhf16K18Xd/LYv8ltwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343340;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5UVc0Wo+RCm0pFgAVB1BYb0KXGrbWaYn1odVIgTHqZs=;
	b=fVv3lSMHYrC81rRKgEyuXrFFP9C4Uh0MC5NCM9hnJet5y198P9M3H4+EVJSB/Qw6kLsu
	 LQxyVUY+jRSmI5nbqgp/KWqPD6Bw9WuqBdypoPLxSPlfXm4e3D3s9fqLld1B9ZqaZUS2l
	 R/00S5h9kqzXJXHSCEapIvu3bxgMHGl4BMWceeVvY+03zkkNCvvjFh674foJL43dpE4wM
	 vuG4DcpI9z+XjtRNJ83Sy5BcQqkmP/7H3mX5+M4xGT6YhXcpehUFs70Dua1JsP8FKHWVa
	 l4kGa8PVw/EqNhmds07n1Y6+MmazWzR9bakNT7AZpbwx6ZsggFC1eLfok5sllnMnbug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YwPQXupP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00FA606A31C;
	Tue, 10 Nov 2026 20:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YwPQXupP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EDB1F0089F;
	Tue, 10 Nov 2026 20:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794343339;
	bh=5UVc0Wo+RCm0pFgAVB1BYb0KXGrbWaYn1odVIgTHqZs=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=YwPQXupPwjfbxSfP+noob2VzvCGh5E1bIgUX3V5w7R4u5L2Ee2zwWcumsMUjKTKyg
	 dGHIV6gXn+XUmKjIT+1Pb+zMMPSduOT70nGWt1HuaiNuKQRsEfaTFPJVE5dVwRY8yy
	 gz9Q+mcAq8V7pP2f/LqtNpMtm8f2zj9mDDbWpvMX8c+vuIYs19y3RnzdxHKUxtwSJl
	 yyFvNP1tHDzzpcamEp+0TllBpoTEMO1BDiXKm1VaFrY938DpwS5AgNxDLJKf4d9s2l
	 BQTCvtjTqhT2KAXFJD8QhfywXcwFp9Pqj1KaoWjZ9kK9eeWcoar/Gv3Fw1noDPX8YL
	 W75nFSca6PIKg==
Message-ID: <sashiko-outbox-207725@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] apparmor: Use security_capable_lsm() for policy
 capabilities
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261110203042.2410140-4-mic@digikod.net>
References: <20261110203042.2410140-1-mic@digikod.net>
 <20261110203042.2410140-4-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 20:42:19 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110203042.2410=
140-1-mic@digikod.net?part=3D3

