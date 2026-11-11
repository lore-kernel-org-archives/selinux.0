Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362315;
	b=wWIb7tGCjBLq/phWCKNsllutkCy6G5iqh4c/qFmNNBpaG0Lu6BTznQIkrokaYYD3Us7X
	 yNmkvJ4g1SpJOAawg4FZzQlyYR1CdSqHLuDdFEP2QUPYbBUhssHTK+pcL1vQXVkMn720C
	 +Q7peh+ARhx28rlp7S/bWe2lkDB8lokzflOeZFow5ir6+hxztuyQEEz/ZCmbHA6yD1VT6
	 X1I7SOa4qfbEWRGKraPNjqKbZOaE0uiSWPQ8eHS6T7YhyrCRIS3FS/Sk47QBtZIsorWUP
	 M38G2jjUKrqPKZkO1wMZUxsSQ9osYeOINuQXxev4OdTA9RC2/9+r8x/fYx5KZalDvvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362315;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kvCJOy58fNvfSG1kPSX5WdPQGylv7GwLupRo9Uurt4A=;
	b=ivyT54lroAAzTo0lsIjUBFzhqm68T4YKg/OskQjhQ7LzeA09aOVQpXEPHx8z6XSaZrjv
	 M7Y4oPmEG5vVW8Na2Ff3rv4/L8zr/8MPnjpXqxUis+OHO7MP8LmQu7BFOBPcivHlnstyb
	 jSlKNnFgqD92AC+7MIaqNwtbEx/wQ7tLzGYESPJ9sQEyoR3vXojP+ZzfcrAJxMn+tbkNa
	 cJDFY1w3Tt4rFNTvHY+hNxo4TJUWpZdiTAGh1bqyQccfwSc+5eV8GmHFan8zlZgsnflH8
	 XkdvnTefS4d8l240ZEaR+H46C1CDkXoIku/sHILKWzuK4C5ReybKenPzlTjamtPfiEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BAK1wa/R";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70667606A31C;
	Wed, 11 Nov 2026 01:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BAK1wa/R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262DD1F0089F;
	Wed, 11 Nov 2026 01:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362315;
	bh=kvCJOy58fNvfSG1kPSX5WdPQGylv7GwLupRo9Uurt4A=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=BAK1wa/RmpyqYcA9GoYt0bOYC60A3jy2tPvscxYb73tTz1ZFkGhHQhB9SuH2es2oa
	 xBhyDhcOx7ILPrHmetpNtBAEEqdTGAxzOYISxw+WY9YBdwi3p+kz2PZjcZRVUq+bE+
	 vVIAl3juAdFncgt2MPju8SAdSttxtFBGmTGkaeggFubsa4JIw4Y2MyoM96w/iKIHHE
	 6GNhXwDi6+R9O1NNhYwlMyyu8JyEjzrjKuItxTU4E2X0ecRDRAeX7rkcYeqAVB64to
	 zAN7v+r/MiR9vKZek36zIPm5T69FDYcYwqNuRMMJtGDAu0EKyJOuPblhl2xtfu2NbT
	 7dvJRKBeXIjxQ==
Message-ID: <sashiko-outbox-208061@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] capabilities: Check PR_SET_SECUREBITS with
 ns_capable()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261110202811.2409395-2-mic@digikod.net>
References: <20261110202811.2409395-1-mic@digikod.net>
 <20261110202811.2409395-2-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 01:58:34 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> Per-process securebits were introduced with a direct cap_capable() check
> for CAP_SETPCAP.  The capable LSM hook and SELinux capability policy
> already existed, and SELinux forwarded task_prctl operations to
> commoncap.  The direct call therefore bypassed SELinux policy from the
> start.  It now also bypasses AppArmor, Landlock, and BPF LSM programs
> attached to the capable hook.
>=20
> A task with CAP_SETPCAP in its effective set can consequently change
> privileged securebits despite an LSM denial.  This can alter how its
> capabilities evolve across UID and execution transitions without the
> expected LSM denial or audit record.
>=20
> Use ns_capable(), as cap_prctl_drop() already does for PR_CAPBSET_DROP.
> Call it only for a no-op, which requires privilege for legacy reasons,
> or when a privileged bit changes.  Changes limited to
> [ ... ]
> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> Cc: stable@vger.kernel.org
> Reported-by: Ada Smith <adasmithgt@gmail.com>
> Fixes: 3898b1b4ebff ("capabilities: implement per-process securebits")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110202811.2409=
395-1-mic@digikod.net?part=3D1

