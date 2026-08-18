Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3B126F288
	for <selinux@vger.kernel.org>; Tue, 18 Aug 2026 19:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787083125; cv=none; b=PiGNUspdoYZeuXFhf56lV/1as5T9SNv2HZTKRzX+mhPibXyrKPwC+Q1HeYZXtAyGg/iOY7HsYFw5kmHpODkuBaJgJlmTbSvCqCba3NG/DtEhbLulMWHibatttOGDSvvHXl9geneaixIlkNickfG2HGqLI5melfxTf25iQ5mVSwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787083125; c=relaxed/simple;
	bh=rcgHa/OwAWRZY75RUTRzwwzWITTTbc9/FQ8By1QSGJI=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OdBJunViMkNq55Pj4LNLG7lqGxLZxTKEBV74E32t2wkgdl/JGZGGLJ5Cnfw7NhVzuOgBBib9IO+6jHN72DcgNJUM03VIvCbBk18XtImNxbr67zhkKPTfLTnCyEQnlgQW4Esa1cHiPSAcYrRUB2rMQIAitbdT+J5tr+7zfqqY3iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXGbkRFA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXGbkRFA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B311F00A3A
	for <selinux@vger.kernel.org>; Tue, 18 Aug 2026 19:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787083123;
	bh=rcgHa/OwAWRZY75RUTRzwwzWITTTbc9/FQ8By1QSGJI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=eXGbkRFAh1tvg1fyVad3bFRA/mlH9VOlOTT8rt1pJyXY7GP1C2rtYNM7k7Fbm5v67
	 9xA/s9CQO6SWgY6V/dITR78xtjaPPG7dgxOdxFqrtCjXjteMVDsdflim98rMtXrP4p
	 xCRVkLfIg/3BR4GIRJ5UEbLOfgpactGkHRrUbR/GozOp8k+x/U89oj5OhlVkW89oq4
	 jWfGD8DEENKlHaOqLenkLJ98O1o9tQGpifiST44yKxS/h0mtQPiigfB8GKR1en779K
	 aVT5iPeKYAW7mmXK6ZN823D95k2QiMCAJ2Y659KLPQ1/NluGeDpwnJAkoo17M3rCBC
	 vNLiNtpGcs41g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] proc: refactor /proc/$pid/mem to use struct as
 private_data
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260818-selinux-pokemem-v1-1-90cd2357ee05@google.com>
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-1-90cd2357ee05@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 19:58:43 +0000
Message-Id: <20260818195843.A5B311F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> Refactor the handlers for proc_mem_operations to use the new struct
> mem_private as ->private_data, rather than directly storing an mm_struct*
> in ->private_data.
>=20
> This is in preparation for adding more state in mem_private in the next
> commit.
>=20
> Signed-off-by: Jann Horn <jannh@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-selinux-po=
kemem-v1-0-90cd2357ee05@google.com?part=3D1

