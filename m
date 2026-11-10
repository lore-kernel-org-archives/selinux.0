Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342980;
	b=eKeeZ8J1raXVok9KUV9eOULvGLCc5W5D/zVXHftjQEq4M5QInhplRbRA5dTr/JinPAlv
	 qVtEXDUFVXmdQGy+Mw2ioRotHRPt9kjQjSvu9onTOhyOj33OjqZGfFJLX7BUic25LK1Kw
	 c8Q3u2uCqIpXoNXSRBTsScSoXg5SM812dkw9/Se6VTgYCH+SCGqGHePDG1zh1/7Ibq4mO
	 plw4L4B+gwvfNfHnNj7vPlm+q/+a7hShLBjIeFssE8FxucfTIROTyRwCmZfnVjIniTMeV
	 nvvsIxR4FYYFfqS2p7ig5g2yWMzx4+kU7NUh5FP7ngHzjUILO8b53EbhFyjXu7FLLYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342980;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aHcFVPMKGkZorqBiEZh4YTVCUsxbNuEF+G7Ag3ifQgs=;
	b=FJeslqz0jt6gxpBOqABLxqQ69jsunZTGcewEHoouSe5Pc9HZkwQUm1N4yofvmdxuEFJh
	 8ZoYWDhs0Bal25Mp5i34UuNMcx4symM1LlBxvvgba0O9TjJz/QLcMwgJaUtoHNW2Z8ebV
	 wF9tgHMQJ//bB93g7xsFEfrf29IUfSBJDHBFLPdTMbhzVISyYxGyc7eInN9dHIr6BTMP+
	 /uOLCVc9jfejQmDOFE358cF3MNFAygZ5niJc90ZAsdSWefHXdsZ+UzFTq7tK+bZ9qhaGT
	 jMjAfDVoBYkJYUqfZWN5GlGm/CHYxmtoQy0JYr0eRme3LbtzMPgKVuD0gDuMlk7NUFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PRavbNGb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E4A606A320;
	Tue, 10 Nov 2026 20:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PRavbNGb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370D91F008A7;
	Tue, 10 Nov 2026 20:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794342979;
	bh=aHcFVPMKGkZorqBiEZh4YTVCUsxbNuEF+G7Ag3ifQgs=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=PRavbNGbuyXT7aS/5P9vmr3q+eCuupv6xSIPguI5MdTXFUv744VUfysvTnVsbxwqP
	 vA4/p4k77bTZzkJdqLMopizoUJpTYEUKBFbroNVhmJ9N4AzeVeUNBvjX0ZJ4BwVdav
	 z2MZL1Ki4s5tMvjWdqtuTutfJjDD6nU89O7s5uivZ4yuGQtUHlZ54pGZ6bPTGDOECd
	 OIRBrrPtZYJaVwa8H+YZ0icq+nfPGak/QZ0k1YlREUvlNEFrOUTCYXdJESc4R2sb9r
	 AzBEJg4RnslsvwDbtDv0NAbjRjE1M3MDy0VFl5e2xDo3MCBDmRkR1RqrHjd3mJXV6n
	 Soy3yxYfzXZ2g==
Message-ID: <sashiko-outbox-207716@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] lsm: Add a capable_lsm hook for capabilities
 guarding an LSM's policy
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261110203042.2410140-2-mic@digikod.net>
References: <20261110203042.2410140-1-mic@digikod.net>
 <20261110203042.2410140-2-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 20:36:18 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> AppArmor, Smack and SELinux check the capabilities that guard their own
> policy (e.g. CAP_MAC_ADMIN, CAP_MAC_OVERRIDE, or CAP_SYS_PTRACE for
> Smack's ptrace rule) with cap_capable(), usually followed by their own
> internal check.  They use cap_capable() instead of capable() on purpose:
> other stacked LSMs should not have to authorize these capabilities,
> which may mean something else for their security model.  This also hides
> these capability uses from LSMs that restrict capability use in general:
> a Landlock domain that denies CAP_MAC_ADMIN does not prevent a process
> from managing AppArmor policy.
>=20
> Add security_capable_lsm() for these checks, and a capable_lsm hook that
> it calls after cap_capable().  Only LSMs that implement this new hook
> see these checks, so LSMs that only implement the capable hook are still
> not asked about another LSM's policy, and the calling LSM's own capable
> hook is not called.  The hook gets the LSM_ID_* of the LSM whose policy
> [ ... ]
> Cc: Matt Bobrowski <matt@bobrowski.net>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110203042.2410=
140-1-mic@digikod.net?part=3D1

