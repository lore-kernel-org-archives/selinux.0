Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700713515DD
	for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787683597; cv=none; b=jPQl7E3yfwhBv5gwNgszp1FUo5vOazpqBaJL/Dvcr0+f2Z3jaiud5dpna5K+i6phpALDBaPpweADro/ocXeQ+FJ8sub0+xuSmGRcteweqPrSw4gF1pJq1dbt0xIzrVFgLQ+806/Nt8aIjAnDbUmsIvaNOf0qiOji6GmlZsBFpMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787683597; c=relaxed/simple;
	bh=cg3FsdzV4twTVRa3kUPAkV9gzT8Lw0v8iA8opHZHhQM=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gDt9jWvtKysx3sUbR0sgTB6iWawNk1FPedvn3NB6AwLkRVlBrv6byiC7w72XjWE07ufWv8h9/L9tocgdtpvNB2NtcQ5gw+1asoYoZbc03HfvUILvSlJPd+Iy2E/OPP4gvzqP2ipsGNwXXXwW1hSKPN8dQGGf97VUq8kcYGX8Gzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkB81ljV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkB81ljV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10141F000E9
	for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 18:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787683596;
	bh=cg3FsdzV4twTVRa3kUPAkV9gzT8Lw0v8iA8opHZHhQM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=bkB81ljVDTmTuKXEIVZFFVGiuKEjxUTdw0ZR7azDXNIizMrpjgFIjE1akBOQRyg56
	 psqIyjIi81861fDEAKZB4WGZtgJotEWnLybwK2x95HzOB51aMglSWN1/repsiztHmh
	 wtjTzsBjwsMmyUqu5LHZRBgpLLaGAbo3Pskz++8R5y9x5tQg9XpTKsWqs6JjZ0erXO
	 xwCpYXfDfXSKEtZfvL0bEGwLRJY38n3SmAAnIc7iEh7h8HbFzyXro/j5+aPZMy/ba+
	 bsk5sLT2NWt7uMH9rrivI5Lm2bmb2xIj26AB0OQqAUAkjEMsOubbk1A3yITso+DAgU
	 3w7lU4agXt+NA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] proc: refactor /proc/$pid/mem to use struct as
 private_data
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260825-selinux-pokemem-v2-1-b46bc64916d8@google.com>
References: <20260825-selinux-pokemem-v2-0-b46bc64916d8@google.com>
 <20260825-selinux-pokemem-v2-1-b46bc64916d8@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 18:46:35 +0000
Message-Id: <20260825184635.F10141F000E9@smtp.kernel.org>
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
> Reviewed-by: Jan Kara <jack@suse.cz>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: Jann Horn <jannh@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825-selinux-po=
kemem-v2-0-b46bc64916d8@google.com?part=3D1

