Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A99751DE02;
	Thu, 15 Oct 2026 12:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067800; cv=none; b=tbq9yEq59W+279PcCRBeq/q8Jg8rYuNWxYhoRVkTod47q6moEzf9dTtiyVW8oICg7g1w1YWeRldK2SCnR+5iT+KpUITf5AL/RMeZxlCFB8C7zPJfOjQdc/HLo5Vxbl5x2315eoXR6Fyv/39ZEgTmSroYwuDKijYb5Soo5cdaJrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067800; c=relaxed/simple;
	bh=OIgdu+RoJYmw7hQz/gZ9J9u5Dk7nmUY5Xusk4yjjVSQ=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Tkw1EzJIR2ubBHBn2AqlQYqrrI9bT8m2hZefOYmAkMdxL8ht+csrnmLNhysSfaz7/VTyw4KlpQz6Y13xVnJyqHuUek6NPS4XKP2YqkG3QyCaIpPrcfX89kDYQSCpD5zq3xYtwkHtE1z5VQooSFHp0aTXmDApcohfYyFmvZa9qnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NR54WZSu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NR54WZSu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893621F000C5;
	Thu, 15 Oct 2026 12:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792067799;
	bh=OIgdu+RoJYmw7hQz/gZ9J9u5Dk7nmUY5Xusk4yjjVSQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=NR54WZSuCBwR9c0jDhOs/whxDOyFpyT6pfJ3+hDLnZtdeen2tWoKDXgABY82xvxsg
	 9ACMMcs+ZyMgyede9WVvGrDufUdlfFgBVnA5Nug+OjC0kTZPF7Xz97wQ3JDPnJ/L0y
	 g9c+hyKyiYHmZxpiijXFXPPclHFzh6IiNu2GlBhDFvwPshruF3hMN+VEg4wCLgVogq
	 tUQfq3rexCg39YBjvjGg0LnRarmorrz8Jxf3mWosjp3Dy6C2BKCmyZb3R3Uog+khMF
	 OfTcnhUGuhh9Gz514EHccWRCsC2VKMkx+cYG9Y3ORwkSbB57TztB7wV+V4qdU7oFd2
	 fBK4z2Nbryj8Q==
Message-ID: <sashiko-outbox-172814@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 -next 17/18] samples/landlock: Add metadata rights to
 sandboxer
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261015125425.3246251-18-caixinchen1@huawei.com>
References: <20261015125425.3246251-1-caixinchen1@huawei.com>
 <20261015125425.3246251-18-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 12:36:37 +0000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> Handle the new LANDLOCK_ACCESS_FS_READ_METADATA and
> LANDLOCK_ACCESS_FS_WRITE_METADATA access rights in the sandboxer:
> READ_METADATA is added to the read-only set, WRITE_METADATA to the
> read-write set, and both to ACCESS_FILE.
>=20
> Update the ABI version fallback switch to remove the metadata rights
> for ABI < 13, and bump LANDLOCK_ABI_LAST to 13.
>=20
> Assisted-by: opencode: glm-5.3
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015125425.3246=
251-1-caixinchen1@huawei.com?part=3D17

