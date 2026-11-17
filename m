Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911027;
	b=V6B9lFBDnzbdv6Q49sluqbkkD/z1rPt1ScyduVZNvVIhiwuuQdRNXBKQM7viKqsQ1b9i
	 QuvLRHCQcihxMT395B0HxQYDLF9tiZnQgn0U4EHcnHsu8KZNghohSxX3gDY7oRscLOtCe
	 dpmpv02E3oRl6c0O0KT3yGv8k7WMfJkzPV0Z7FL9xFgTjXqXQkFpfZaAXGUy6KblZLbZc
	 FiqegkYDF3zJ8Iu3uMseXzVTH/XXw5YNUE0Pii7R8SNeHqRNRa5JNhLLnPDHV9/AIFJK9
	 WyM6Y74EyVTnFh5gFyvKaSbTeelejbQjD387Pu8ffJws04D3yn+5zIn8rbIj4QkjfLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911027;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gxBH6ENvLE/QuPEZfQsc07PyhrOj30PqkebmAIrRk5Y=;
	b=OQhJk7QaY1khETXoAP+5QnTdJEnbRYVo032KI18uuiFa9pvrPTdhPwAWHc04FH1WRAhO
	 WDUAZNQyM2Fq7/UdMzr3rslcVRfWGb18htIbs1BwgtGqH/rtei9Hz6mVYdKBiigBiVLFd
	 4haIyCSQQW2qlu2kNjQBs9JLIF9mzBrZKpjnzBIYHpof6aTY0rqFvZyv2aGv/Qz43z/Lh
	 KParckacvcySdv3ukQrESHHDICFZc5a/UzH0gl4pxqyPGOuAIzYpP3iGaXl97ZmsAkDTT
	 LkA+inUH8s7yt1NisTZPGXxlh52d97r0yr4cSEFaHGzWcttqTABCpXJekbCaF/a4ybA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zwiyp6wB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D79606A329;
	Tue, 17 Nov 2026 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zwiyp6wB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DD41F000C4;
	Tue, 17 Nov 2026 10:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794911026;
	bh=gxBH6ENvLE/QuPEZfQsc07PyhrOj30PqkebmAIrRk5Y=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Zwiyp6wBzFnuDTVCNeIDD5J9fK/8oJMWvqqiXiB0+3WMSQRmHtOhQl/ncj1BHWW7U
	 U5nQJKMFRMbUmKrzfPO+0/wLHdl5rd7aRlLrO8PxriSEG4ivM4atod4hHNgHNvTd8K
	 dhalLLm9CjrkBRaYUQdJL2QNzDa++6bOIa+LvzbLg6W6pKB79et6viZ1hh12Dlyv8D
	 B9IOtMcAIUQDkVceLesvvxeSyZPRFAqi0Ehu4HUbBYUrNJsllRHfvuTVqrSbQ/WbxP
	 bcgLtlrRKBLkKb5rc48HR5VEO2HOEdeE7YeyFCEWG9Bmb6fuhwQA1y0LbhtOfvQas8
	 l3lw0AHQIehgQ==
Message-ID: <sashiko-outbox-218605@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] capabilities: Check PR_SET_SECUREBITS with
 ns_capable()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261117101738.2523492-2-mic@digikod.net>
References: <20261117101738.2523492-1-mic@digikod.net>
 <20261117101738.2523492-2-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 10:23:46 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> PR_SET_SECUREBITS checks CAP_SETPCAP with cap_capable(), which skips the
> LSM capable hooks, so a task can change privileged securebits despite an
> LSM denial.
>=20
> Use ns_capable() instead, as PR_CAPBSET_DROP already does.  Move the
> check to a helper that only requires CAP_SETPCAP when needed, so that
> changes limited to the unprivileged securebits still do not reach the
> LSMs or set PF_SUPERPRIV.
>=20
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: John Johansen <john.johansen@canonical.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Matt Bobrowski <matt@bobrowski.net>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> Cc: stable@vger.kernel.org
> Reviewed-by: Serge Hallyn (AMD) <sergeh@kernel.org>
> Fixes: 3898b1b4ebff ("capabilities: implement per-process securebits")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117101738.2523=
492-1-mic@digikod.net?part=3D1

