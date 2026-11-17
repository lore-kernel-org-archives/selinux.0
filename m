Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911218;
	b=YbYoziSFqzU9l2+Eu/mtklLJoOB+iDRa0gSFAJRVoCjMjXYbPQJVkl9BvqYDyS0/ks4H
	 uDJgfNZ3L2jo6yLd+45MZYFumEmB5xdcJKsoxfD+vEz7qfc0zuUgVMkrlLDIB2IFbv71J
	 Gy+24J/ljo1phdTbzlKeP8YIcNhk6Zky0KTILr93iWkKGA/RosTj5ZpcMhS7m7BjI8Fu/
	 B7Gv1hK41vTt1D5hfn0qhCmILxN18foglNjKvtNBaV7mGQmSelpwyuOgQFgDV8s3M5M6K
	 33Inn9NNhN99K3/j5hRr+FHb4EoAJ4lpQgbf9rTsUcVy4yRZoPHTnTxVMegJIHlflSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911218;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gnj7C7NQo+0MkCW5ZOl5t8cZ58ZCVJKHjIkfNfZfDnE=;
	b=KRcW7unfF7v2GY56sz+s1RXyvAQf8LRiRrLPxNQzILCnsqBPGDS83M9Sp3shbpujvG4l
	 aqmblfeeMbH5IlYsi7MkhQ85Shq1lyMUwfKFgcA08aJ9qvQ6M8uvhjulLhLVdUhyia2Qi
	 jdW+v+Yn+u8/aVpsJrLL1peIdCiNNdWgdJTjodgMpH8CtzlHXqa/ZOwhiycbiBq8czwXF
	 b+KSio6NrfrPgtafqPVblCIMAI7jLAyb6SJbWHgnleKCJSOx7IQzoYTtXoiD5+N197LKp
	 YaaY6u/xCiHSbRBDhf4Xz/OtDUIOIP9bwY7uyKe9p9XslVpfDNpJZz468xE9sr+vsOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="G56/UjTt";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C84606A330;
	Tue, 17 Nov 2026 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G56/UjTt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5921F000C4;
	Tue, 17 Nov 2026 10:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794911218;
	bh=gnj7C7NQo+0MkCW5ZOl5t8cZ58ZCVJKHjIkfNfZfDnE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=G56/UjTtpBtJV5bSYyXmfJsP6ln/pmNF5dqwQ3vZ9Irqa647+J9tOLhRcysxL0rsf
	 Nz0+8mgBBEjOUgsDetiSFThBWSjdbYtnG0Fx2wBJWaQ0JUtKkZb6uayc5VIgIk3yJP
	 As8SOQdgSRm5cbO+1b2aaBxMqGcuMoXuZWV7duWhRot1PtFY6QHZV4BSzeDY5hl5Y1
	 oQrx9YVFrnoEXZxssU84RHoyQpG7I+M0JgEgFaim418ZTci4MPsLDfsITHa0Lvsf72
	 xbyvMhjbzXaRmY0mQwGJlNBCr2RMrX0RfplxeILAdT1HQCDzRysQPoQiqttzr6diqu
	 aCMjnwKYDEfKw==
Message-ID: <sashiko-outbox-218618@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] landlock: Restrict capabilities guarding other
 LSMs' policies
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261117101845.2523770-3-mic@digikod.net>
References: <20261117101845.2523770-1-mic@digikod.net>
 <20261117101845.2523770-3-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 10:26:57 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117101845.2523=
770-1-mic@digikod.net?part=3D2

