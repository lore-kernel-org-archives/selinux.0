Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915052;
	b=JwzUStjBF9hR4XlHwhr5WA22C11/jTtI0/kwKKxaYnGWj2kW9RlFmeRleunZ21PHIOkP
	 v2SHR/8q+DU4wpiUQ4VGr4gp+jv3LwxmZMFRMmHGLmM/e8RUrd7vGtEw33rTq9J6EGai8
	 jIR16jwo/8dugpZ0OLgKwv7IRkp9lN8+NidcUlafLEbW4XSMbXK55kcYP6hISYAEgPU4T
	 pmME8qRrd9nchPpN5jB7TT/PBHpooUCc3W8OTpEEkLKHX53yFCQtMtM5ytCXeZVUb03Qn
	 Xf2ZnEBnnheurnKLorw8bUDoYvgaOUc5YjuXbb7krWpJCpL+ff5FAO/bk9jFhwBdPPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915052;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZYwa6G1jAu1ucuCy6jCegJ3KvdrKIFINCc09U9DLQ/Y=;
	b=WFB6FPqPKeFWpWSsAJLhfz/bGinzYXqQ3PsTthDOjevvYDVDbAV7YzAIMoC945vMw6nV
	 TrHdPJM32c+cuy3q6ntOD/JQsAsJm6cHzEOXjhJ4G6RHQRL+EI6NgdfoLMM3zgCypfn0j
	 XYafI8XO4L3PUlIW6nqCoh57MjlIR3AVOh9tTyWaLmiftME/vUm0+BRHy+qYtgjX0rlbA
	 YnlLHcEaxF/2JkfLTxfX5HGymaQnJShvIjckcHeBUpq6Xj8u5MstPpwbIXegMkY7ExGKl
	 m/monOW/IY512cAak4VyARz5m0E+CERaPaxoguHAcQRTszgC3thpzK3pT5J+/yzVFnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RaXRSPi9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CA0606A328;
	Thu,  5 Nov 2026 21:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RaXRSPi9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F45D1F0089F;
	Thu,  5 Nov 2026 21:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793915051;
	bh=ZYwa6G1jAu1ucuCy6jCegJ3KvdrKIFINCc09U9DLQ/Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RaXRSPi9AAm3CtFs44Sl0QdnAI2yUlnhiqcHUkHt8nz//gmsnmJ4PmSEkEAF4oanY
	 pIM3IHoFxx+I9zf8Pt2DKPUxHlwkeJsLeEAyET8/4avg+gZWruOtBbCc/grqaqLOqa
	 zA7qgIOCHtJqsF8AbV/2IRkmh+yJuPboC8Jixjz7WdD5AqYJ6oMFL/BCPBCcS72ZzH
	 1QeHoJ9FTmidpWpxmrpV+TFno6N542WCJHHFWIgObPz6hcoE0Vd0O/a2CxUKHQRKOA
	 25UZlXAZ8H7IB6CX6muS1zstf0kVNimEsNdKxmuGQRZhDGcmf+IhJ5XKA6qp6lqnMg
	 ZHtjE43OCOPwQ==
Message-ID: <sashiko-outbox-200262@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/13] fs/coredump: convert vma_dump_size() to use
 vma_flags_t
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: damon@lists.linux.dev, linux-perf-users@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261105-late-2026-vma-flags-v1-10-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-10-0d3cd15ab75f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:44:10 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> Replace use of the legacy vm_flags_t flags with vma_flags_t values when
> determining how much of a VMA to dump.
>=20
> The flags copied into struct core_vma_metadata remain legacy flags as they
> are consumed by the binfmt handlers.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-late-2026-=
vma-flags-v1-0-0d3cd15ab75f@kernel.org?part=3D10

