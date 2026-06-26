Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27C023394B
	for <selinux@vger.kernel.org>; Fri, 26 Jun 2026 01:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782437745; cv=none; b=WzgqwDAm+8PuJM3HkBayAN1z/Y6bfRNeg0SpK3aOY9dDQ4+up+H0ZYQik7UnobyU1r0BCV7StZgE0N80X48TktNPNVV+DnezqFgWg/f9k8PTpOLRmE9NO3jaL4VU27dMLdPUhAE2syQ5xvvIxyoEhRfKvCZWsMuOjNFA/ZT+HRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782437745; c=relaxed/simple;
	bh=i8w+2Sk3UUkDBo6hPaTR1YVnQtzk4Z02pZ5TlWoEvmM=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DgGOICOa9C05Rvr0qaltMfjc7makd8+PJMExhQM/ddBSPj+zwkg84LzHhkkPBDprJZg6bcX8/a8bbj3rhNxXEavobVgGz53+SqJtangYcoyKFCMMKYg7KJPU6Z8uzh4kzIzL+n5ZYiIqEIEbcCge+izoSFIiY21u0diGxkFR2yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEhGiL6l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEhGiL6l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4141F000E9
	for <selinux@vger.kernel.org>; Fri, 26 Jun 2026 01:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782437744;
	bh=i8w+2Sk3UUkDBo6hPaTR1YVnQtzk4Z02pZ5TlWoEvmM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=KEhGiL6lD2+V7eQH0jLh6xaCkptO7PZqBnOwhZhIDsjBCXkBN3slDt9Pl2FaxD1dq
	 nc4rmEC2sdacib7cDopq2veodeVR6HVWsV7IxTW1+WEs4QQqcfiXTsct4b91GmanHC
	 UZJnLhhEZOGF6R+HW1s4RST6CaRZJynGqzbFsnREy3jnmuLtpss0UVJtcp3gT96knp
	 RrXryXMWttncHqPi8u++4VEF2L6jgq8tTr2Vt0AH2Hhf86wHyqS+kXLDwO58mhA0vb
	 D2r0FLH8iG7NMqLFHE9D8egZP9elzRLiTttcWPut+eOPT7+qahvpU5vsTqXEANGW5K
	 dHNi08HNf1QGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next 1/2] security: Some cleanup code
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260626011720.1144213-2-caixinchen1@huawei.com>
References: <20260626011720.1144213-1-caixinchen1@huawei.com>
 <20260626011720.1144213-2-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 01:35:43 +0000
Message-Id: <20260626013544.3E4141F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> Delete an unnecessary blank line and a blobs variable with
> duplicate assignment.
>=20
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626011720.1144=
213-1-caixinchen1@huawei.com?part=3D1

