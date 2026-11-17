Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911817;
	b=QwBWVwAKTYfdYJ4PoH2l8ICNGZ3H7Q0N8flc10FpjPmCiUzzuDJ3oFvjE5tnirP30Aa6
	 s70VHKTocLZrbw+w4xspt0nAL8pHbQ0jDa5uMiwRoGJgv3zXdJZZZuSPEFALqCZ/Bp9dB
	 AbaYRCORu54rnJ9bzlRo6xV6QiHXFSjT8HLJvIlF27nMJgwFsoku7z63YKCMazGfm9eBV
	 4E/oNVRd8dXt/gxpF2TsBow1IXHuIJQeQ+jvUjZ1gV9qP92uBaXLYC5CZxHqagpSd7hTV
	 FVUoGMeDu4NASAH2kl0Wpn8xOF+po/5Wh7PZKcpXV/TjrpboKah3j2LmZKuFU/IGr6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911817;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FT9Ac+4iibdLNjyqu7ySYPgkp9EFWTg8N6l1BZsQlaA=;
	b=H2xWyiK3pbyQK5qd0gbdMXkFATxOsOwd+aOZLyjTrYDVfogIWWU1O1+SINpR3iuybsyV
	 1elb44wIfXc2kJBh2omZ6EInsOxudr2VNx7OF1vxJliYPPO3Z8phwWmA+nzwNDVdMjmZt
	 aRQ5n4yktUJr0ZVslx/Qww2UmxiB9+1bGXRjk+8rIVuxrlty0YSBTv45m3+CtWECbXdO7
	 tqPRme4HeRCIozqsUIjpCx5fb0usvuirp95hgOLAO1VOpWAHtjFUKeWXAQTF8CRLS0LQY
	 pZWKU2boc6p2kxrl6kLjqPH9GJE1hAivM/ckkr4/v5zzhc0ORt7VwbtoCUC5AvpoSRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hWWR0bcT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004C2606A33D;
	Tue, 17 Nov 2026 10:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hWWR0bcT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7DB1F000C4;
	Tue, 17 Nov 2026 10:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794911816;
	bh=FT9Ac+4iibdLNjyqu7ySYPgkp9EFWTg8N6l1BZsQlaA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=hWWR0bcTfABpXKfNUIDe0cBVxwDS+HJ1CYOYc7utSn4n0ODMsMXsul+xSFQYFo3GK
	 ebyh1Tl6U2zkqqihCrceY+zDqCTBIVg1rrw56+5nevIXxSmyu0GZxabMFeiuTSwxXO
	 o+KaHnwmKJ2rETf4kdR94Ta9VU5EyFCC2KA6QwN67PtM8CPScsYm2rO9lfHkUrKLKb
	 vuVvdJD+ndOBAqT5jk+AaGFIYE3p7ktGN0w5FZYoCGDB/BLLdobPCzWHIw/Vjz2O9c
	 WK7fhH5N8szpf4dQfp6G6TirrP4ZWr59zYBIdJm9OOF9PcM9XiyDZsvYhsKELlp8oP
	 odVGlPdX0aK0A==
Message-ID: <sashiko-outbox-218639@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] selinux: Use security_capable_lsm() for
 CAP_MAC_ADMIN checks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261117101845.2523770-6-mic@digikod.net>
References: <20261117101845.2523770-1-mic@digikod.net>
 <20261117101845.2523770-6-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 10:36:56 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117101845.2523=
770-1-mic@digikod.net?part=3D5

