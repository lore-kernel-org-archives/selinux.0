Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914988;
	b=uzrwMfMhfXV8YeCt6WMZkQVfzfvDgmlflAQ36FOtjRY7hy5MjuMGNDoenrN5hLxndOPz
	 alDAnYeJNhXLuncrJU73quVd89YZZgCIGErQLiVx/P9/r+VhDom0gCDMTJQ1Eh6rLdqB1
	 DnVdIonD3m86BXttmsc+eJ7OzLJLqil22O56+B1aStHOTclDXDOEVNb7k2mgrHmE2UAns
	 4r7O1SNg7WefrWXXRvnQ8MCXUYXEkED0OZQHRCg1HErE5IWNjmh2zvaqLy62gxG/I1E48
	 81YP4sKoLEv0nZjCCae/5Zkv1zNpb8I/GZOusJ0S2lypKfg5NKWPay3lpEeFVxMDBCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914988;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iWKwn2vPuv7lKrUeLGQ/4is3JBM9uTYHCDsQhM7rHkg=;
	b=K381QnG7qdPBuo5yMXcaPF/0YQxrf0MrZ+wasQwT8nOWlYqGpyhoq/dEeDah5W/pA5v5
	 /iymHPAOPm2skZpcwpY6ar99RlLBIwnnnjw+7CT+YvZg3Lk6JGzCFAhx4kBgJ+vc8UR1M
	 NwcydNDAtoxq7jZMhSucPbT8eI8LgI52fOmiWCGC6zIJj28d8VgGjnW/m47CrZF6jJfy8
	 iEOuiUgC9xZGqFyPzB4w5r5qj8nqwNso3JhKxVk8w7s6vPNbjMsSMTIDGhlX/660ZmwZ1
	 1slHUDfWIjvJ03bOO9rs2rro2snL7G8Ob22TLJXFAC7QzuF5ZROf06qngD5KVUUibkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="S/GPcMiT";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0AA606A31B;
	Thu,  5 Nov 2026 21:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S/GPcMiT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972B11F008AB;
	Thu,  5 Nov 2026 21:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914987;
	bh=iWKwn2vPuv7lKrUeLGQ/4is3JBM9uTYHCDsQhM7rHkg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S/GPcMiTA03Za5zvU/us5HoX22c0aILJnoL57rd3Lv/jo1t9pBLjVaHjaXog0yBpC
	 lfKiUS92YL+ePwIJyaqjOiVenqLOGHv+gevytY/elT5RRQOOujWym7MkU79Hz9P34a
	 nFgvSCYl273y8UB710YgGDVDWjhQLY88zeC5nohDZ4HMrDPBoRraSuD8zS9Zw486MB
	 0GyGoIDN0I3yMt3uuRDGIswDv2aTzJBmy0GOWN9v7LPmRE0iRFwaC2h2OaqjQNZ5rl
	 Ro9xmQXK0iDAmkMbAv2f8K6gbhQi8FUMQDSqb8Z62FHc4DrbryiRH512uQNVgw+5ql
	 DosqIiqzHtM3Q==
Message-ID: <sashiko-outbox-200259@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/13] mm: convert miscellaneous VMA flag tests to use
 vma_flags_t
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: damon@lists.linux.dev, linux-perf-users@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261105-late-2026-vma-flags-v1-8-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-8-0d3cd15ab75f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:43:04 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
> remaining straightforward VMA flag tests scattered throughout core mm, HMM
> (and its test module), DAMON and the OOM reaper.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-late-2026-=
vma-flags-v1-0-0d3cd15ab75f@kernel.org?part=3D8

