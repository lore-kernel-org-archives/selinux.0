Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343554;
	b=H0phdylz8uDtspq6YMgOWpsdyat2BimqYyimLxGgkNAEsU9NzMx8f10qXzD2+wOSqNVR
	 V7En8STv2cIHtxJN5Eb29eelF/aR2ZeKLD7tzFyoQM/70Uzz7OnVBkhCEssYTZV70RxNl
	 WE4pQowpPJwon+cJeOmwXJTPdyEoSECyVI2gRcTEXVuTzkJfXoYXx2lqxcTQo5/Ady6Zx
	 /kBdI+EjbvSRx6FhX2+6IaVfxAioVBLSl+avx8yaM5JKy7N6JCETbrG+Wm1GrIFP61vYy
	 C6kb8W8vp9K0mHSln9feZmsssL7gRp1wpip8TTt1NG2znsLyyvNHEfIpD0w0O4GCMSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343554;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zAelen4zzRAcWFc8BhXuMetO6mv8knWmBj93nbWeMbs=;
	b=z44zj3fQ/KZGrZPJA3JLj+iY3Rk1JgGgUIJWjicjDulMGJwTZQtuQmZLnVmlYAB+wC5f
	 hyDLmdW1PtEPbvDGkTPGWZQ7lo7nr5Oid8dU7jG0ImsQZMLYSayvEFlnRcXy6bIWvGaWW
	 7SlTHbgvMHYS/nZgKdr3ypwu/gLFsH6aGSe2hrDdwAZPcRO+9e65t7hoCGrzdSP50xYwW
	 //lUzxxoqwv+vgxSv6eVtsEorx6DsO5VfQ6JE+8R9kKUmjIELuWF8R9ys05xQnfKvVOdW
	 YnTh49SoWjdWf8VQGgb4v114RKFKo9O0TAxzg8U/e6taHQvOvogDh/Cg8Gxq8+GsHuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hRxUUwBa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD31606A31C;
	Tue, 10 Nov 2026 20:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hRxUUwBa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2DC1F0089F;
	Tue, 10 Nov 2026 20:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794343554;
	bh=zAelen4zzRAcWFc8BhXuMetO6mv8knWmBj93nbWeMbs=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=hRxUUwBadTGdt1QMFvHA2ign9ubLGTG6UQ/hg4U5Bfv3CQs620ExqZuICjQGNab5D
	 x3rlwOomfY+yrdFcc8ZWeBH6iof8Fp4BnAMt8C8fSO44plTbatG6xFSlmUHPXl0rnF
	 +0lh0ZgXJXqEyYfbF7vAfFKs0BtQEEuS3kkxeI4kkd7BE83r9hWkY/05bC2zbGSBI/
	 ZhC1rBFgbeP5vkq/I+PtLwMj33OxoRrH9qMaE6GH4x68CbaXXSm9LcRnrk5zdL9L49
	 Mxe445X8nv1EbTZPkREkQctDZ8k/9sKCdKgyiBZL2MlSTEYG1D8qEfzLrFAyrEM4SE
	 sxf26Hm0FpRqg==
Message-ID: <sashiko-outbox-207727@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] smack: Use security_capable_lsm() for privilege
 checks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261110203042.2410140-5-mic@digikod.net>
References: <20261110203042.2410140-1-mic@digikod.net>
 <20261110203042.2410140-5-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 20:45:52 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> smack_privileged_cred() checks the capabilities that guard Smack policy
> (CAP_MAC_ADMIN to change it, CAP_MAC_OVERRIDE to bypass it, and
> CAP_SYS_PTRACE for the ptrace rule) with cap_capable() instead of
> capable(), so that other stacked LSMs are not asked (see commit
> f28e783ff668 ("Smack: Use cap_capable in privilege check")).  This also
> lets a process in a Landlock domain that denies these capabilities
> manage or bypass Smack policy.
>=20
> Switch this check to security_capable_lsm(), as for AppArmor in the
> previous commit.  The onlycap rule still applies.
> smack_privileged_cred() may check another task's credentials (the
> tracer's for the ptrace rule, the SIGIO recipient's), and may run in
> interrupt context for SIGIO delivery, which the capable_lsm hook allows.
>=20
> Smack passes CAP_OPT_NONE everywhere, so Landlock logs every denial of
> these capabilities like any other capability denial.  This includes the
> checks that some Smack hooks make before their label rules (e.g.
> smack_syslog(), smack_unix_may_send()): the override is denied, and the
> label rules then decide.
>=20
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110203042.2410=
140-1-mic@digikod.net?part=3D4

