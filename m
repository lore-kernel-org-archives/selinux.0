Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343659;
	b=eI/bneoXAlaSFvE3eVO0hJBVZWvoq24MXGQ3LX8t2RV1KtQTSy3sUxNBbXkn8OJ1kiKM
	 1OX9O9BeFly4Trz/ftS+zlqy/34R1l7U52+fqZTrweQb0oSz0GZiaVsYtfHpwlqnaqsmI
	 H776/15pcSoxyFe1VxP2OADqkw39xJNmBKw6U0vvFXG7gpXRoJtZFIqoNGfQBe1m0OtKM
	 +9r73gmGdZw+2/mDSY00aqEOV0zTAwPPfCRHQf4kaqYbFL+nqHsrDgpLBpJa3xjxj8yH+
	 OUh3rRNggwmWFG4nHeyqPNJZjUhmtYgY8h6BiovSXq+pPxfw8qQLEmmglfWB7VTAQJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343659;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qwLRpa3+R7tCN7W2HXX9gisRsDDTZVTowzQkJiP2Xzo=;
	b=xJwVtF7JLCnSZZE11rDKAndosg14Ic/xxV0Vsshgkzs7Uxopr0EVAs+ImXB0cD5P3sqJ
	 jqS/IQt/LqeOceKwkv/MiociFKGS73n1IAG+Ddiqnx+qIZ5Rh4rP5sV3LIGylR5mA2Ppw
	 f0BxdAv6myd7Db0so8ZrweOU55L5SQhQ5KQ7jo6ku7W6Jj2DL8S6twWw48zGxT7c4NwmR
	 lBvmbO89tBAZwhV5/Wb+ulA4Ec9im+VwqCOb+5l9ueinOoUQ6D4bemYciZEoV0gSB+cWP
	 ObGH5qWauWcCUAfSau1uCeLta4jB5fFtVxaPKHYMmUXrcvYcaUpMtPKEiCgTf/Kuwjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oLzpkZ6D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09718606A31C;
	Tue, 10 Nov 2026 20:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oLzpkZ6D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816BE1F0089F;
	Tue, 10 Nov 2026 20:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794343658;
	bh=qwLRpa3+R7tCN7W2HXX9gisRsDDTZVTowzQkJiP2Xzo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=oLzpkZ6DHLI5gTnQJOJW69cSz7q6+emMy9Mk70pO1w28iLPRyw6DysoZSXh3wxS6t
	 TREa/IhjK1K2yhgYkVlWKdRyYBnHH2kgaXw98DMU/zgJPo95yq/qJTl3cBGwabnFy1
	 LxpXEySV+08SYTqGKuDnnsGNOZqAV1cglQiQrf+6YrcmsReN7gAJlZ3vJRUz8d/VJN
	 wcHQxuTWblJMH+GsnCwTnjhp5WGshKx12D2IhfMyV1IQeZ4yOBBSr88RSDZ1E2hSZy
	 qlDMFtXEsUgBNj6H2Y0CKSrvVw3nwFDwNntj+KX+mNkeO2dNCospkAcCqfADJDvyc6
	 m1rx3HCgNNjLA==
Message-ID: <sashiko-outbox-207729@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] selinux: Use security_capable_lsm() for
 CAP_MAC_ADMIN checks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261110203042.2410140-6-mic@digikod.net>
References: <20261110203042.2410140-1-mic@digikod.net>
 <20261110203042.2410140-6-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 20:47:38 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> has_cap_mac_admin() checks CAP_MAC_ADMIN with cap_capable() and then
> with SELinux's own check, so that other stacked LSMs do not have to
> authorize it (see commit db59000ab760 ("selinux: only invoke
> capabilities and selinux for CAP_MAC_ADMIN checks")).  This also lets a
> process in a Landlock domain that denies CAP_MAC_ADMIN get or set
> security contexts unknown to the loaded policy.
>=20
> Switch this check to security_capable_lsm(), as for AppArmor and Smack
> in the previous commits.  The cred_has_capability() check is kept.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110203042.2410=
140-1-mic@digikod.net?part=3D5

