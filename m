Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927843;
	b=YehXiUJTrEncZ44imfhcJDlNcUDhvmAy9PxHxFBDK/rvXT/Cq9ksl4PAwytgVaSxeq8L
	 IJVRcs8zbtpiADoG6LE/G+se6L/AspMUBNOTMGyTKYWpuNllGeUb2pOaPbBP4EKcIfdHa
	 e+G8Nkge3XMErQZg5SWLtxUajbuizwcM1x4/ZR3MuMrRVV0KbTQMQQXahGwdRiUuJtAcj
	 eqVihv5SdtROobAulN7PJHCSGsK2eX9dTMoPP5NkNa4t7p6ixDuKje46Uj0W5p5vvwxuJ
	 2JfxZTM5udADrKHhiSwcA46ycle8DX12N4OxJeFNP84zLfgaXvqsoTE34KE3esf5D5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927843;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=p4/Ozme7cdiG/SUmc0XuGorPbv7OAOe/IAUzAZpVxOg=;
	b=fX7LvN13MPEZlRgVhZ1PhFCG1bHcaDTyc9j+vE5HW3dLTsQ5xn6PAz+5mGjOqPnxp3zB
	 /hvZBsmAVq9Ss1QUi0QzFkp2y1RVyXc34WHxcvRE/tX/x8mEX6hjAFbjZp8cjAplqgZm6
	 N50uw43rxmTh7iwFD3gEGL9U4yL1bf/1fI6KvWzepNV0CO179zLXRYZrz2li+W5XrhJq9
	 RFiDkzxTZSTe6+A0X/ShaKWZwf3lSu4X6HaTFnLWU++Z+v965oBYA8g7nmsqBoWOiQw6H
	 B08M/CYtzGLxiZbxxGra38CaD1D+F+74TFWNzJ4rDmQri5KhP3eT91JQNXZtHQNYLXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LHX4PsEx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EFA606A31C;
	Tue, 17 Nov 2026 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LHX4PsEx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE251F000C5;
	Tue, 17 Nov 2026 15:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794927842;
	bh=p4/Ozme7cdiG/SUmc0XuGorPbv7OAOe/IAUzAZpVxOg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=LHX4PsExAayx5O6YnM6B9+P2hwgxzIix0BaK6gLdyLT238Lwkpc0JcLmN05Y5m1en
	 YSIgrsPl+0aY5xdRIuWAbNbJ76MenFNCd6nevVAiaerQDYNYpbf1MaRARRQEOD199o
	 n3RL4VQYLr7laK2AKmTmHoWSZgugIjbgn7adjRG2g8k8PE4gy1CfGLzgpLnpSg09pt
	 j1WOR1bOjVoHA5dxrLwatpg4gLWlvydB9V7SovoLrK+LhHb5i9AitA6jxp6cKrH8l7
	 S2fO8ETQQZ2rgwg8qhzcuqiWml0BwWL/NNxkb9WkFxYVM4RDIUaHWFapb+B9njfVU6
	 yO17AelviGDUg==
Message-ID: <sashiko-outbox-219013@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next -v4 16/17] samples/landlock: Add metadata rights
 to sandboxer
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261117150542.1169451-17-caixinchen1@huawei.com>
References: <20261117150542.1169451-1-caixinchen1@huawei.com>
 <20261117150542.1169451-17-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 15:04:01 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> Handle the two new access rights in the sandboxer: READ_METADATA joins
> the read-only set, WRITE_METADATA the read-write set, and both join
> ACCESS_FILE.  Bump LANDLOCK_ABI_LAST to 13 and remove the rights for
> ABI < 13 in the fallback switch.
>=20
> Update the trace example in events-landlock.rst accordingly.
>=20
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117150542.1169=
451-1-caixinchen1@huawei.com?part=3D16

