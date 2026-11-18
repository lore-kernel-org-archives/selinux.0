Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013996;
	b=i06BDoxkqgEnoeZzfuKm1ZmQE8tVVK6dcTLCRVlDE6emBm/vD+Og+U4RziFNR6GwKhov
	 NEDiA/eaaqTr1h52iHeTdsne8DqBR9Fy+hA7bG+vAqqcbywQVo8sU52htTWMqbgnpG7Zc
	 GKW3XTI7A8VJd+q/ISPySQ3N9y/OLLtPjN3yTI7bq7rq9K0Wzq+YRrTvBJ9Eb/fJ40yiw
	 A4sCb6V1LrK7O8Y4qAv6cc3YtfaESQxjdVKOvkyjs9gzG3oi9yvRBTi+gs/nSLoCRRC/o
	 ebQmliOp39X4o0QjiVGDpQTjV1jfqhZrrZHV6q4//ZMI1HG4e9wZu53nGx0PDIdsEEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013996;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=n0lluPQxxJoybcaJYqkYk+uONUmMvbqkCKk8g2TIUFk=;
	b=tQAzEgbs6wdYIX1R5R2Fflct6+pBauK7LZd67MEElu7+tk+zrYlm1fs0f93y+chfxBEN
	 DrJzvzCsXxR6Ezg1qoDPJ8JTUJ77ETvWUMqOHbvM0bIZ7K2smKH2uZqvwlgckDWMkfKio
	 toRWKnuIgl8bDgphEqgG6vOYNFNieoSt5YPniNkrqZ4uyhX0RkfhyIwj39MVsg/CnSoPB
	 VsZhoks2p2h0CnWTcMQBznRByWqaVeskISEBykSrq/KYC7cfLp2RgvhWxnwMqgWgSm/GR
	 Vw1xr88Gb4lu11EITACA4rFF1foBfDGgMzdam0gxno3EYf3amp44db2i6+sMzZoPLqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bkdzx6Qi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A1C606A334;
	Wed, 18 Nov 2026 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bkdzx6Qi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977B91F000C9;
	Wed, 18 Nov 2026 14:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795013996;
	bh=n0lluPQxxJoybcaJYqkYk+uONUmMvbqkCKk8g2TIUFk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=bkdzx6QiqRnBIBH/2zLP3T2Cg9ocvbfMJ/5HIk/stqZOkmlUKn1xjsnloVmCsu5nT
	 D34fZIUHG6VCMMKz6JEUlujxyd61gDUls1jKiVG+mJcUs1juY+E4YbLF5ZWRgC1EA/
	 kZRGiSwJWyIvT2OzPB7PbTF7dwWEnG1WbvCD3xN1ZL2tQYuFx+kpmPbfo0YFB5Go8e
	 36RDb6+xk2wCivjM3ZaJpJ+lO9u23WDpzuJNfy6Qt3WhdTNXCsi7lThbMuybPcN57z
	 PWQfmV+Bxflsm/mZ7N05+PoJegmfwyMcXZKmk2tVAuQ4NJOlkNP1j5ujVeQtWzg8xL
	 1UsDWc1+D2Jyg==
Message-ID: <sashiko-outbox-221277@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] selftests/landlock: Test PR_SET_SECUREBITS
 mediation
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261118145431.2551578-3-mic@digikod.net>
References: <20261118145431.2551578-1-mic@digikod.net>
 <20261118145431.2551578-3-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 14:59:56 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> Test that Landlock denies and logs a privileged PR_SET_SECUREBITS
> change, now that the previous commit routes its CAP_SETPCAP check
> through the capable hooks, and that an unprivileged change still
> succeeds.  The domain deallocation record must then report exactly one
> denial, which proves that the unprivileged change was not denied,
> without relying on a no-record timeout.
>=20
> The check-exec selftests already cover commoncap's securebits semantics.
> Without the previous commit, this test fails.
>=20
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118145431.2551=
578-1-mic@digikod.net?part=3D2

