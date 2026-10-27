Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109844;
	b=HIMQKODSmdzZkes/hjuA+5XaLmI55WOIWUz2lhsMOR9G3gdJwiaB5gFP/uet/94DJXjr
	 cFvq2kp0j6bse0VrqYsjuRjvihZewAR2r1ieBJfmyPlBTk2iX8fANkQc+nVE7474H24MQ
	 y/tWJK63H8qN9wkfJBjKqjAqsS/lMclTUhu01eYFRjebNtT67JkOOYcSiw9FnyqSQNhXw
	 kihCtolkdcxeTF4dyIQDEPClAg4zgesuWMC2kXb3lLSniyC9kBgexnsjNPvpTPoF06+Oc
	 dfp+0sXS6VmlPuyEeANIdNGhHKUdAfvFfd60oUkNWWtZWFmfftA2/5niRuUCC/MHGXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109844;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bxTCgE8obW6Uunhynod2cje6FQRYoTpS71FhCyOicDk=;
	b=lLXwMOWND86sICPeyb/tkp3EeRYF4ylvXHwDjkAaW7akaZUXIXTCyfvYSFh1Q1WYr7Do
	 JpoMUi5Y5E3V/Y1zjV8CE2ls/In1V8wVvbZnccL865bYxVEqWBmlgNNm1V2slNCf08Ejx
	 52NJ5+vMVj30gHAHEOxtgzwHc3BDuG2aZHzDSEEZl6m9HsPBJ4l4+yTObBS1JBTZi1f7y
	 9Y4lMjpCJ0d/W+hvXoucEtd/mCBTu1S7nMdmpZ4yc0Nog8Zs3TUw0NT2wZnWGvPy2GRwR
	 Iz/Pv+8z4gkTP1C48hSMdU3dLJjl/Z7cuVf6Re7PjlQ/P1HUg1H/ZkmCLnvl/dbe16w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dczzqhda;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EDD606A31A;
	Tue, 27 Oct 2026 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dczzqhda
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416731F01828;
	Tue, 27 Oct 2026 14:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793109843;
	bh=bxTCgE8obW6Uunhynod2cje6FQRYoTpS71FhCyOicDk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=dczzqhdauAoSyF59M+Le66WRxmCMZEkhxxl7rbTYZeoSQ7e4ttp3sOlHz8G4pP+ba
	 /RDnTZfKv+9qDJmFaifDrY9GkF5c/xNnfBsxdlvrQzolSMDPRtkDIsILg8ZVa7E30W
	 Enr7K0zM/xgRw/R3yaF5g6gVLAJZZgymkYKmWQj9ey5wCz96iK/ETvwUem4m7vs6fB
	 z4L2VyRZoT33Pd0DzoBfPOVChaeszZr9PYbqOWuH9HhC2I+L8uxc8cX2bGTVaw+o/o
	 CEj8VUXxxe0Fi7iUi3SUq0Ef76+5rjp4uz736hApgcCNWNzaOtVMf0ErsRz6xP2hoy
	 sgnDtYO8LwH2g==
Message-ID: <sashiko-outbox-186688@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 -next 10/18] LSM: rename inode_setattr to
 path_setattr
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261027121151.1887650-11-caixinchen1@huawei.com>
References: <20261027121151.1887650-1-caixinchen1@huawei.com>
 <20261027121151.1887650-11-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 14:04:02 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> The inode_setattr hook receives a struct path, so rename it to
> path_setattr to follow the path_* naming convention used for the
> other hooks that take a struct path (path_chmod, path_chown, ...).
> Rename the security_inode_setattr() inline wrapper to
> security_path_setattr() and the SELinux, Smack and EVM
> implementations accordingly.
>=20
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027121151.1887=
650-1-caixinchen1@huawei.com?part=3D10

