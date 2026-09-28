Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49E32DA768
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614916; cv=none; b=r8hfGqnAkLrxsa05cRRgnXB7CALjDc3vBWapQ/Q0vREUL2TwIVarzHl6D+4C7K9+azECOa8mI62W3FkzVS8tIGvdNAYhbFvYcMw9UQip6DRObPSui6s7FRu0mUHXAZbW/ZGgHcaS3SBkcWh3v04i1QdGi51bDfggu3EPj7S/bY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614916; c=relaxed/simple;
	bh=nXX9ZOyAwY9WIxMwsB90gdjpErkozbsNRH5EuUMdskg=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ftcoxJPQKhI12m0vTSa4MN5ge2cqlmqUGIHbYztVqP/Iao9DpL3F9b6Z7XfouRkK/tnmPdxXLdvONfXWMukZ1pkJbTvXQRGjVLhXlPfaMWWlYWe8Zub29gnQ9h+yawlAT03lsMBOC1C+SL6hBJZT/lYhtM1cdpCnpoOa3RI+9Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRJrQlou; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRJrQlou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F5D1F000FF
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790614910;
	bh=nXX9ZOyAwY9WIxMwsB90gdjpErkozbsNRH5EuUMdskg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=BRJrQlouqihamYnxjdOSdCFuJ9rfnyyLJ0Kg2bustJ8maQlFmuUDdY6Z1VVaOnxhS
	 itwJeNNN8huPGxcI2GHL3MG1xe8h9tLdVpOtAEt2xVBGESb3/jwRg+TWJCaq1oxAEJ
	 8bVy1x+bJACqfKQ0PpzFLQXR9YSzhV6xXGJZ5V8uz+VFGtcQXYuDCtAiLmNBAOhlFD
	 6/+bnllikfHfrUm8VcyXPWmtD9K8RpIanqvBUJEmiH2LS0JpbZ5gbZhLg4MjaTI2d+
	 zhjBaqOqeXGRjI4zE7m4baGbdKeZzIGDXaQzCd0yQMKj5WZziZBQg9LXmE9bvAT0gu
	 ylZF9pTgulOYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] selinux: validate user MLS range and default
 level at load
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260928165253.2388012-1-cgoettsche@seltendoof.de>
References: <20260928165253.2388012-1-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 17:01:49 +0000
Message-Id: <20260928170149.F0F5D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>=20
> user_read() reads each user's MLS range and default level but, unlike
> range transitions and security contexts, never validates them.
> Validate usr->range and usr->dfltlevel in user_index_check() when MLS is
> enabled, once the level and category symbol tables are populated.
>=20
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928165253.2388=
012-3-cgoettsche@seltendoof.de?part=3D2

