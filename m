Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F463F076B
	for <selinux@vger.kernel.org>; Tue, 30 Jun 2026 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782815341; cv=none; b=kEOtVOXJAYIwwAv/vSWZHjMqOwk15wD3pvT0J6VojEv/Zu0G9PTLGwI9jTbcZz5lUQEduUJwqc+uG092bwDVeoPIiI3HKMZD+eVuXI1nXYuc1z5wbW9nyt8/HH+Yv2mz0wTFasVpFnOdZ0ho7rcY5bkv18cN5Oos8jYkBIla2Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782815341; c=relaxed/simple;
	bh=bOq0ysknmPPyWr2By3B/GX6dB/RuWSBHuU80rg4ysbA=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k7pFAhBB/svaQt59dVC6KxG3CEZCBG70kKhZquSrrOO7zbOZSzSPsRw0GquqmUByMi2uFR7zTItcLRJ0rn+9m7tr9tc8zQEON3dzsk/5lXIP7+5ZsCM0jz/wla0jJ01RnWGrC6pOQfKapLNYsInbySzGPMi8qL1P4Z5RdWXtn5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNcB+RWW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNcB+RWW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587C61F000E9
	for <selinux@vger.kernel.org>; Tue, 30 Jun 2026 10:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782815340;
	bh=bOq0ysknmPPyWr2By3B/GX6dB/RuWSBHuU80rg4ysbA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=QNcB+RWW9t0hNrCV9hf/Aw1eEOsUGtqJ2MUNVlB7ED3YadtMnYjvwqBy17Addmjwi
	 QTQx+Id1xLVz18u5y4jQJzZYHI1o2XBtXV8PGwin/tswhGdVnRW9ZeZgchQLrUd5qq
	 czkDf8OLaMGQXLMUZuTrrMoBJ0c0QaQQPSMPx5L/TnzVqrq36E9YBROTE0gMZ6zFy2
	 ByeXQskfJyDd3mYoLoFgseDNQzI8k8DKvJEUMP/JAFwiuj9t5acHbfGGDfieS0qhSg
	 agPY3gbHWaqegtYKM7CSTVg+bFNPyNea1hjzhJxDRDHRSDSKLF9iYZp50ojJM4n6iL
	 NPkAti0T3TQSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] selinux: hooks: use kmalloc() to allocate path
 buffer
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260630-security-v2-1-560d33c13ee6@kernel.org>
References: <20260630-security-v2-1-560d33c13ee6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 10:28:59 +0000
Message-Id: <20260630102900.587C61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> selinux_genfs_get_sid() allocates memory for a path with __get_free_page(=
).
>=20
> Such usage does not require a "page" and the size of the buffer should
> actually be PATH_MAX which may be less than PAGE_SIZE on some
> architectures.
>=20
> Replace __get_free_page() for allocation of a path buffer with kmalloc()
> and make it explicit that the buffer size is PATH_MAX.
>=20
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630-security-v=
2-1-560d33c13ee6@kernel.org?part=3D1

