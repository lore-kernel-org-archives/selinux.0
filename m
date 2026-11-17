Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927944;
	b=HekAB/FcQ+JiX6ELkDrNFfvwy9FffZXtxGYSsg5OYVWdA+SRVClZIOJY6hTZeUqoHbqO
	 f+IZhZDZZtwe8HYjbv2ZZ44gPNoE1AoALAxZKl+3BGZkKLEpxG3F0tz1/urRbhATT8sNx
	 aSLVMAuEIZ+0yQoHFSo8f9wpG5knfReGpg3+mwkXPSBK7uXiKlUsMp6hGy3Jw1NK21N60
	 ycmbMGcxgAtj6U7sUesI2J2ZEDB6prqxa9AnLUHXNJYXBwR4uDXES5SDkTM3cFjG+D2Hg
	 PP/+Rr78vBdFJJ36vUzRZTL1400nJdXbnIZGcBmXSGvgBbNzNi0BYv5b5nHZ4TyRe6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927944;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OhxDv+C/fCWBtxcKn7L9ytg6N6mWGuNH5AhRTS/+eQg=;
	b=PObFr7ZKRc/5Wc7yeEM7/Z5bDnrAlkjxV9cC6zK0yROKbQJQdFCjw1hJ2gj12Oh/hbnW
	 Tol4e+8irBkwTr+vvdJKTPdmtEDQL1dXpKiluVRUazoQvLl7KyuRSFe8eV20ouLfvpxzD
	 u3fo6xWDrbsi/OHeZhyMggsJshjY38sseWUn6SDvyipMHT2s8nkAuZDGx819cPn/FY+fP
	 h/5QUfUZhECk/kZ2+zcfI30v9wsiGlKkS2NZNUHDT8uyNkzFaU6KVnCk5AQyQ/4GPKtEs
	 dVa+ou34nBo6i3KCda55krhZzyXmkAz2fBZXAgZaVMO6Ysel66muPHPaoznWtLOiu4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iDjERmkz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76899606A31C;
	Tue, 17 Nov 2026 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iDjERmkz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FFA1F000C5;
	Tue, 17 Nov 2026 15:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794927944;
	bh=OhxDv+C/fCWBtxcKn7L9ytg6N6mWGuNH5AhRTS/+eQg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=iDjERmkz3BGNZV06NhYJIZjnFkzTldd8SQQoQYgiD0pcVeyPkgY1yvN5uef5dpxK8
	 671LN8PfXWqBDJ674XUM3c+dsEeB0yEYHRjgQOQEW0Bae7fM1lIbsKR5I8YxNTYDfi
	 l3PXEBEgIPWJ3DAqMu/MkNwAi2/ZFlmxvXz5T/t5obevvjgWufUcfSpSHDjIS0LV8K
	 ElbqSMWNB3rLoZ4a8iM5oxQ8f8mPh0BaptL5LPQhuk5AVZF0iq7zcC3AsaTX00y6Jo
	 MT+ROftFFyjrDQJfvdIlohOL/u4MafsazWUM9L7yixAJVnw+W+kqgpKIMr562u+v1O
	 HDkufmckLt7Ng==
Message-ID: <sashiko-outbox-219015@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next -v4 17/17] Documentation: Update landlock doc for
 metadata rights
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261117150542.1169451-18-caixinchen1@huawei.com>
References: <20261117150542.1169451-1-caixinchen1@huawei.com>
 <20261117150542.1169451-18-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 15:05:43 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> Document the two new access rights: add them to the example ruleset and
> to the ABI fallback switch, and describe their semantics in a new "File
> metadata" section, including the open-time semantic, the exclusion of
> implicit changes and the chown(2) special case, and the warning that
> READ_METADATA usually needs to be granted together with READ_FILE and
> READ_DIR.
>=20
> Also rename the "Bind mounts and OverlayFS" section to "Bind mounts and
> stacking filesystems" and describe how eCryptfs forwards attribute
> changes under the caller's credentials, which causes the lower path to be
> checked as well, and extend the blockers list in
> Documentation/admin-guide/LSM/landlock.rst.
>=20
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117150542.1169=
451-1-caixinchen1@huawei.com?part=3D17

