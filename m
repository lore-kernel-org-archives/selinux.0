Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794912243;
	b=hbVb123+WtDX8hjSTipRqNEXb34ZVIRVNYlANVDJS85EIOyjeUsx3oS0K/GC07t2X0CW
	 nTx/ElnJ77NYHNa/b5V/zeX3qRqgZkbtziuse/64aXmyhn93snkeQXOMvqKc+BerJ/Wks
	 CLznnHcZnFfbvK8eoru4F2mrmgcQU6+GxqTqixnKPFjCvLU4Xv+59Nw3QdyUA8uUTQcIn
	 eiboIyvAkMb180dwz8rRedvi6Dmtzr3/B0b9ZE26DbVAaeSVkIFrPx+Kcn41PJmXPAUWd
	 TciSdhpFAyMODnxteS8RxjUZgsKqhzOt/+g6Zv1lty0X8mAUVnJrZWXu+Iyo8MZKHaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794912243;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fXbeSSN4vyavoCQQ3NAN/AMCnB48rep94hV2g4bGavc=;
	b=dawF8Lymcp4SirvuPtmWo+IFeJJtVeNZuVfw7x9Ug/JGFskGxqzyXbW44ZM/CeQNds7P
	 JKE8ihcIg2qkicPXtHSrybdR3ckSnemTGhF4g6XKKyC5TO4uGf+XGAvmG+2WOgfI6nRgu
	 LxCM8VGOhiQgwJ/yqFuEWr9FEf80kV9amF138kLTmJH+xKHCptDNTpGs9PXXWAki7nfg0
	 U8AYJYpV80nmhP22WQwJgaCIB2qa3kSXZsxOBgQLNn63y9tYYZxmp0zMwEuaM5w1Yq1xe
	 AxpP0LFZFDyT1Sq44BDlqPig+e/e/X8MwUeU6wGBrtbs0TrfmDugztxUaugC56+sXEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W4mYsnxP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EF5606A333;
	Tue, 17 Nov 2026 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W4mYsnxP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B801F000CB;
	Tue, 17 Nov 2026 10:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794912242;
	bh=fXbeSSN4vyavoCQQ3NAN/AMCnB48rep94hV2g4bGavc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=W4mYsnxP7bhpWICp97lD0Wyp3J0VhoXkKrxRi557B7x4uC9vOmz/Kx/8w15nkfFwK
	 FZK0hFYlFU9fSweOkS6/m+zNDZC6dsBJO8/qM4L4FlBC3o+WFecb4VE3L2MEMCyDvs
	 rP1lFsGqc+SchSpfowidoVDGkvPPRGGNv0ThkyZOaLCI2VM1lemr6K+ntmbPO6ROGP
	 xSZX2A4BBPbN/g18U6AmmJg+dcF3HMs1wfBl6buOzmELX+uRSjnIi3CyS7N/Gu9yBV
	 rXRCDaoMuxYFty6FKFuAinNrF4I4Uh/UvfBmF+P9gJcPBlVxUT04UvBSWoIc+1kv1W
	 +I7Zv2DGdg7ew==
Message-ID: <sashiko-outbox-218667@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] selftests/landlock: Test capabilities guarding
 other LSMs' policies
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261117101845.2523770-7-mic@digikod.net>
References: <20261117101845.2523770-1-mic@digikod.net>
 <20261117101845.2523770-7-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 10:44:01 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> Check that a domain denying CAP_MAC_ADMIN prevents a process from
> changing a file's Smack label and from loading AppArmor policy.  Also
> check that denying CAP_MAC_OVERRIDE prevents a process from bypassing
> Smack rules between sockets with distinct labels.  The allowed,
> unhandled and unsandboxed variants retain each capability, and an audit
> test checks both Smack denials.
>=20
> Smack and AppArmor are optional and are not added to the test
> configuration: each test is skipped if its LSM is not active according
> to lsm_list_modules(2), and fails if this syscall fails.  The default
> test configuration has no other LSM, so these tests skip there and the
> capable_lsm hook is not exercised.
>=20
> The cap_other_hooks fixture now covers more than commoncap's checks, so
> update its description, and add CAP_MAC_ADMIN and CAP_MAC_OVERRIDE to
> the capabilities that the tests may raise.
>=20
> Without the previous commits, the denied variants and the audit test
> fail with Smack (boot with lsm=3Dlandlock,smack), and the denied variants
> fail with AppArmor (lsm=3Dlandlock,apparmor).
>=20
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: John Johansen <john.johansen@canonical.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117101845.2523=
770-1-mic@digikod.net?part=3D6

