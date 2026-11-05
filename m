Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915149;
	b=ijIvjbZfEM6l3RXX2dzIBCtRbRViklotjZDrXknDDnRYkzcf1IezBuFjb6JkSfm0MmSj
	 ceniGUYSTRfApg9y1hklcc+WC0ef7IWi4njdQBvenj8TOXUT6AWbGJSgCHaP4HyJxlNUM
	 HDmobmxhcHhHXCW0ktZvo8vrinb8TAESKqqQHUbBkPXbC6SW31bxRj4K2mFtI+t81zYXS
	 bqciiePil2mKOZhryhX0z815mfJGQAsXxhecpT9OZC+74bojrqXzTizVR3BrsMAQpMdTw
	 0mEnCfwMYcX9tSozuDd07XNCAs+L71ZJyUY80Bb7QbqFjPsDuvDqWReguN1WDG0Rncg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915149;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EnENGUXZCW28/ZqMmMI7lu/CvUlHzsN+n0Y+BmLQkK0=;
	b=LjlMmVojKtaF69/bxSotO3o202xANSlygzD6tuPIRreSt98LX5Stj66NkgyHb7DfVWbK
	 IP5jWC7IVJ6zx/a/RAMtXYyC3Z90c1ujI/29Sna3tHdWuP7g5pv+m+NwOSubrbI3WUbi5
	 UhJy/qSqtColIQB5PXk2E4ndIsb/yNxc10HZgEK7nDgXZ1SPvwUYhcxNqvzop+aKGWO4e
	 uSokCVsyCXhZRQ3GcHe4AD35ZfFfvgJlNqxQ9mRjrx7nvstw7aoGPvfpNrL8tKpu96Yo0
	 h7S87nDy7Q5achGIJVOG5Ss1EbAJ0i7MSyS+AuC/UTbgC0P2DB8IL7nNjpDlo5YH6mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PmXdXGs3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A414A606A32C;
	Thu,  5 Nov 2026 21:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PmXdXGs3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1C01F0089F;
	Thu,  5 Nov 2026 21:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793915148;
	bh=EnENGUXZCW28/ZqMmMI7lu/CvUlHzsN+n0Y+BmLQkK0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PmXdXGs3/mqQI7rlSSvnLraDVswQUrGHhVEz+Tamy1IuY9Cs0n1yQ7MCywt42CBEC
	 uq58w43hY+ebt7dpi51HCTcMvtoIBSr/eBtgkyQJaoI0gqTVVIPrfQuRDT57dho75f
	 XmrCdPilK+aFt3FI/+UP8E8veNEnSeUZxF1M0OfwsTbR1ji9O4V3FwBhlyXplORhrW
	 q7TEFLZpf2rP9z141KVrLXnHE/J7tY/JjKX6ox4EaZPxFX2wCgDnqRriuVmA1BCPzW
	 d8Y6W8fDrqjkeww3IDOWD6Pmf4p8coQiaKU2t3O18mNj57ROLlnNMAE3I+Id0Gab1+
	 fmG9OaLR3Wfmg==
Message-ID: <sashiko-outbox-200266@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/13] fs/proc/task_mmu: convert VMA flag tests to use
 vma_flags_t
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: damon@lists.linux.dev, linux-perf-users@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261105-late-2026-vma-flags-v1-9-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-9-0d3cd15ab75f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:45:47 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> Replace use of the legacy vm_flags_t flags with vma_flags_t values where
> VMA flags are tested directly in /proc/$pid/[s]maps, pagemap, clear_refs
> and PROCMAP_QUERY.
>=20
> In replacing vm_flags_clear() (which takes the VMA write lock) with
> vma_clear_flags() (which does not) in clear_refs_write(), we explicitly
> write lock the VMA. The mmap write lock is already held at this point.
>=20
> The show_vma_header_prefix() and show_smap_vma_flags() output functions a=
nd
> the thp_vma_allowable_orders() call continue to use legacy flags for the
> time being.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-late-2026-=
vma-flags-v1-0-0d3cd15ab75f@kernel.org?part=3D9

