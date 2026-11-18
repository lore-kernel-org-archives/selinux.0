Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795014038;
	b=cEoId2UbDOuZLc5pHl6pDknIcHYmrEad0CYm9CWS2FqwdL4bXrdBiR5A56oeGfAFxmpL
	 +mYbX13QLz4ZmG8/KWgtrgbrVjYGD3E1I+xEH8jhL5BYdfoiR3ZLHDOqDBGAqOS88joDd
	 v6pcTjhXgVE78gsVwTucpl/tCKKhlVEtQ7lvySjqp6N/OD4v3aGji7zkLriaRpvJkApvH
	 p0SO+3RuRpj9vYlY4SxReab48rjFJH5CY6qaTIZCyIt5F63F2+E42TS6P/wvJhMBOFHPq
	 Uy8sBcjWXZCQAZ+CqyzR5WjDHTKloStMW7610a2ElS9HSief8Pmaxk2K7BlQfeL6z5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795014038;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ezpm6tnkNrVLJ/9C9tRQrJbTJ2IOv0u9LpdAmkC0xJE=;
	b=Tfa/diwBVy35JCAuOPJw5GWg2tZgJYqgHYNVekwYBhMrSAj1bSOiS6GfRR+LKeiT0+Cc
	 mkog7AKAAbYl/q9oWc9Z33Rp1uU9434LfjhikrjVnz6PSFzBLdQseW63QwdFQf8lCahN/
	 Lgc0/nT3nMMpBjzsGxRrMySWYNUpjYcfg5SeR8iccPNFDeH9JWpSph/uE2mSUWBxtXDwr
	 0Kp6aj+xFWLypSHw2YXCO6Di0OTxUkrTPUadWHmccgJIGIFvzRVUdoKMBlH5WTGN/+ISB
	 9YE82QhB9irNmkKjAXP+suh/eHHloUIOm28JxED3N9CZnbNV5bF5abs6kylXd2yu91w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FXnK3ahs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0615A606A31C;
	Wed, 18 Nov 2026 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FXnK3ahs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEB01F000C4;
	Wed, 18 Nov 2026 15:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795014037;
	bh=ezpm6tnkNrVLJ/9C9tRQrJbTJ2IOv0u9LpdAmkC0xJE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=FXnK3ahsjhO5CDuOUckreO2//gZlQXA91xFKhqRoEbDyJ9Pd3ixNKdyx5OrL87V6m
	 E7NgfsC7CEf5Dy2ogiG9WkYpz9PAf3BJvDZCtSaKvkT6H/vmUFA0XHwmZx3gPPzKD/
	 RvXelWyW44rCzq4CeGox1563xVfWr0QgzjmC9wyztGh+orZaUDc5fX+7B+rsEI8DCS
	 SYd6Ka47fLmquLKNyXRpnhQLrlJiYZyj8aDBOrgtFelUKFVcw3ifY54p3YUsWoFC9B
	 LeA/KwXfldS8yZhKaCgeTulhGnOuLqttVQlhdMNUwk4HybGaaSqHongsRjj982jH1+
	 wg6EoRisblezQ==
Message-ID: <sashiko-outbox-221278@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] capabilities: Check PR_SET_SECUREBITS with
 ns_capable()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261118145431.2551578-2-mic@digikod.net>
References: <20261118145431.2551578-1-mic@digikod.net>
 <20261118145431.2551578-2-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 15:00:37 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118145431.2551=
578-1-mic@digikod.net?part=3D1

