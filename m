Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794238990;
	b=bXv3VPI8pyWrj/wMICmeAE4tUfG2vLvbriECy6W1vxIS3rjN61sp+1aHZOGuBwnfvjaY
	 nkxiWvuUPNFEHdQtoNZ5s08REWQKl8iQfNovxJEhy+pcCMJLn56eovqzEBr96oMTxyz2k
	 KmPGhwgSFj6P0rjVW708PI6Hq5+a5tgd0tW7yz0yd64iJloZMROsREeA8JwD1HAN8tWHs
	 +onSVCu2gqk+xtt92I8mDcAQycads8twPbKbQhFo/7ndKvfddoToSp2CkyQaW4bJ+cu3E
	 6FSS1QE7xPCoSRO3bXxQ6pssl39lwGNlSnHw5meAwpuNeZeeVG8+vaxIvnfGvTJPq+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238990;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bihVS8QPyaCg10UM/+4V/ozgn44NGfV4WwxWfUjU3hs=;
	b=LNHRWntY16nS6xq1CO1WENlhyR6g2qwzAnxdbT3VEEQ4Vhx9jgnsNJCMCZXj5dk4HHPK
	 CAHLmAgDWughkpCczm8PHyDVLst6mHKeK8PjGLsOVXUIHVzI+RI5K6hiXfJFP4fq3Uoja
	 dy4F5keCe+dPKd2wpRul/BJ9zcHJWhZhRzPXpZJDHINbBvduDi1I6Aed6164zOvWc17pr
	 3Mr/HXL8NJszxjH0V8NmfTW8s4PeXkw7If3CZMWNijFQLeusy/MjqWdH9Y1Q52G6Z/5Ls
	 zDQ3JxGZ+mxavgzCvda7wtauf1/Anba/UbJSZQyVcbPATBzEXeNogu5BYeHowM7emPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TS+T2QU7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9573F606A321
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TS+T2QU7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF8D1F0089F
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 15:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794238990;
	bh=bihVS8QPyaCg10UM/+4V/ozgn44NGfV4WwxWfUjU3hs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=TS+T2QU7lOXjObHbBzJ81yOleeB+7S3l6IJBVRTSU4+A7rn9oOV+rUyAHtdlHeX57
	 xnaChI7XGbAH724TuiDgm3gJPSLDtJAoADqXO2oozbkeQTeI3ZX6jn4C0So6e/690v
	 CeZ2SkMgDYiBHf1qGX+2lGxIlpgebYd8HRuSL8kZFXxYJ5z5mRb9gdkKnyaem41YdY
	 b94KStzSwEU3GgjHpvivq9/ruDpMJ5JBIjXdQ62RZJbvIQ3Am0h0zIzWy3kTRnapNh
	 vJf21iDvg7QS8XBFy/QFyobn9lrxMWnOPQccMQIoAg+U04iEpUgUz+3bMTcclV4Ahw
	 J5oM2J3g2bUYA==
Message-ID: <sashiko-outbox-205170@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] selinux: restore the context string on -ESTALE
 retry
Reply-To: sashiko-reviews@lists.linux.dev
To: selinux@vger.kernel.org
In-Reply-To: <20261109153802.76176-1-cgoettsche@seltendoof.de>
References: <20261109153802.76176-1-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 15:43:08 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>=20
> security_context_to_sid_core() retries the conversion when
> sidtab_context_to_sid() returns -ESTALE because a policy reload froze
> the sidtab in the meantime.  The retry passes scontext2 to
> string_to_context_struct() again, but that function mutates its input:
> it replaces the ':' separators with NUL bytes while parsing.  On the
> second pass the user field is followed by a NUL instead of a ':', so the
> parse fails with -EINVAL for any context, including a perfectly valid
> one.
>=20
> Without force this makes the caller see -EINVAL for a valid context.
> With force the (pristine) saved copy gets stored as an uninterpreted,
> unmapped context, so a valid context is treated as unlabeled until the
> next policy reload.
>=20
> Restore scontext2 from the caller's buffer before retrying, as
> services_convert_context() already does for the same reason.  The
> buffer was allocated by kmemdup_nul() with scontext_len + 1 bytes and
> the parser never writes past the terminating NUL, so copying
> scontext_len bytes restores it exactly.
>=20
> Fixes: 9ad6e9cb39c6 ("selinux: fix race between old and new sidtab")
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109153802.7617=
6-5-cgoettsche@seltendoof.de?part=3D2

