Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343089;
	b=4RJae63Wc48lfo9XkmPYiHYH0YzKo8uVWV3AsxkhbIrXnE//tSP6xHQSHQndlTwK5Pxx
	 hK0IvqCwUWtWjKN7fLxfYfRSe/Dnn8XYlvVuaTDqoyOPqxU080OBXUT6YsQcL0l/Co0Jt
	 aQKL4A7N/FpXz5JAXBa89Ww3BYDMomOMdevs/YB+zUByIu9B9s83RAkUK7swDS22Xn+s2
	 CgWn2N5002eXD0XPoC1IOyPINILoGNbKCBkNmob1BEDBxddAq/KBNrpFk+DipsZH3XQfu
	 KNdZz7A3Xb+XSjOCh3Hx1SMp9f6arYjHPH5Och8YWOZ0Y0h1Nr8HsP6w0jPSj/GnXqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343089;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1nI+oq1qxs876JTOppFdE309Wiuh75q8PbkVxdU7v38=;
	b=wufgwlzR6nEeDO1gRqqHvfUZCKN5ipx+wMCf1syA4Jd4xf+CbgdmsmThqhe3/1A5OMyk
	 sVqYD6TyvJJTVmarqUT+SX/X82sg0pxXN+QSYIUKh3julbkFq4iZuox/H6ovaVNagG90o
	 bdMbq8y8EL0rzrHYFm0ibOsESYFzLxOQeLsQIoP2fjgFA8o4qhhFfYtzY34755o5NdStA
	 izuv5Je06sPvbXMADdvqCq9FlYSQ+3m1kDYDZLKoNiUJbL/p0uaGUr4VfSP0OCZFs+nso
	 sp6l4lDsjePt9ecM1Oja7rvCwOUtvPbF0rqMbL+xUCy/fs2zAddVh6P8fLWP+b+Wfeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ap3Of0zr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD14606A31C;
	Tue, 10 Nov 2026 20:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ap3Of0zr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25511F008A5;
	Tue, 10 Nov 2026 20:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794343088;
	bh=1nI+oq1qxs876JTOppFdE309Wiuh75q8PbkVxdU7v38=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Ap3Of0zr42buWsOQBF+1rkFv6H6eJ2NkPBEvwSS03QmkXAVo59/9tS+cXJB3+k345
	 aEh2tz+HRFY+EKSoH7Qra6OZQP3ZGUbqlCLzqlv4PUu/qFFHkF9mr11rxVIy5yPHbW
	 Pdqsnt7lGr4EAEMuB0OaGPU245f8i+kSZ6joN9ESrzU/UV2rtDbQfUDTF2RIpx1DM4
	 FVEaK9NGC4CXMoOjjPFF+wcZUs/+yMzYiVsyEw3IvjbcrXeVe5uddd2zTKpj22cy4S
	 CZ8/9fZRplI8xFLhhu4OAIgo9XDZ0MsUwOiOoLkgPdTezRcCnjcBdQm6ex26dKcOTu
	 wqjm6a+BXLHVA==
Message-ID: <sashiko-outbox-207719@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] landlock: Restrict capabilities guarding other
 LSMs' policies
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261110203042.2410140-3-mic@digikod.net>
References: <20261110203042.2410140-1-mic@digikod.net>
 <20261110203042.2410140-3-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 20:38:08 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> A process in a domain that denies CAP_MAC_ADMIN or CAP_MAC_OVERRIDE
> could still use them for AppArmor, Smack or SELinux policy, and
> CAP_SYS_PTRACE for Smack's ptrace rule, because these LSMs check them
> with cap_capable() instead of capable().
>=20
> Implement the capable_lsm hook with the same check as the capable hook,
> so that such capability uses are restricted like any other.  The
> following commits switch these LSMs to security_capable_lsm().
>=20
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110203042.2410=
140-1-mic@digikod.net?part=3D2

