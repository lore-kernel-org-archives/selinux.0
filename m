Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915170;
	b=rHgcdm5TN66rVIF5HLC67YrNczgpvyEKdllFFDjovAtG7TnR/OjIuNvpdjykV73MjwfA
	 twPnhC9BK6UpNLi+gEQ7+79JHT3fG8sVtdkf3aVTgc51WafcKYTO+vLMGnk8Tp/kbOi92
	 kaII8kiWKZ/LUUp/xYAwjeIJhw9qF0M5BNzywqADwNBpmU41loXsnam3ITdFSo2Sg5uxw
	 p87KwI6HHnILuaook0or0WnXpn64D1bKmW2tJybacVuRlilqf5haucJKTgz493TURgo8t
	 0/E7BZExoJ8nmv7nOVTnYRDwIyv1ao2ev2f+TTDTel09g4112DSj9T48NX+XrBXORNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915170;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HAnypg2ePZTiLv7/Jl9SkeZ/eZm4TOIYK0zJGERQWRs=;
	b=3ya/lxU+C0as12DRCm3JblHaeM3IsIZmnqyWHODfFN27E6wP6zsDmBU/tLf8IlmMOzp+
	 U75y8Rf5+Jxm5lLpVOHnSu53UYx3W1s7IA8ot2IwNPzT/6FwOE60wLpNcp9e0zFCRQ6iX
	 Z0CuoQrYS69KYIUKSrACNXQDxfYGpd/wcMU/13eB2LLUKSTk54sYUxBkz+mwc/F3HcxP0
	 TFyDWqbBeW+QnfS6oMXvsu44s/6eG7PSHheV3siQ1EXyeeHGImH3f16UfbORUbIQ0N2ku
	 of/pg9ncSQeifoIlT8y17hpcdU9d6gAcXsJYJThC7wBlsL84lX8WRxtSfkuIBoFlSYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X8thfaNZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C56B606A338;
	Thu,  5 Nov 2026 21:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X8thfaNZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C051F0089F;
	Thu,  5 Nov 2026 21:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793915170;
	bh=HAnypg2ePZTiLv7/Jl9SkeZ/eZm4TOIYK0zJGERQWRs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X8thfaNZCkDGiE5X+8Z5gCVlwt1JyHx6aPPVn37/mpOzTsgtfFQc635aM7/YhPgKD
	 5g/ZeeXL7oDsKwj0mfQUCrE3jPY1lvxWYwW0+XgWRSDcZBSem4wQk4FzNnNLA9hUWy
	 CXSqlO96ZhzvyDYPmqh5tnUs0svpDDnw7MBa8N8XiuZGaeWO8j6X1nazAl8HtAHwKP
	 ws96jesJnPw4VtF0NDfkfOl1z3Sv3GpJWU+K9z8BUPhk/NmhCwgT68LrMhyzXHo2fW
	 nbshj9rrUWmEGKZhk7jkeBcVHR0ct4UX7pQxoNPsMyQjLkay4n9jmHHrJ4ds12nRut
	 QoBuiEDTeQXOg==
Message-ID: <sashiko-outbox-200268@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/13] perf: convert VMA flag tests to use vma_flags_t
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: damon@lists.linux.dev, linux-perf-users@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261105-late-2026-vma-flags-v1-12-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-12-0d3cd15ab75f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:46:09 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
> perf mmap and mmap event logic.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-late-2026-=
vma-flags-v1-0-0d3cd15ab75f@kernel.org?part=3D12

