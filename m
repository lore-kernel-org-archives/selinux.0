Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C58F51DAE7;
	Thu, 15 Oct 2026 12:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067499; cv=none; b=Sdl1cObcB0yXmUBsLpxqN/s3th+EsxkI0NC5OiKt+9g9HhxxrCfSgksePuefNNGz1/Q42w0Z0snSchZAqdsW6u/2tPgOe7hbbipMgfxDGBRrJOt2aGS3P/ZfC2jgtRDiQFRcAd8kJmbmW2jFnyTihGM1yHNf4Ag2zAl01TBOFBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067499; c=relaxed/simple;
	bh=g+/0H7iE6O0CVy78hLilqnCiEsgi2Eouf3UP4A6LpP4=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=X5xYGX9jn9Ziop08cjxlgoyKJmcty6PJC+61r1T7Ogp7njyVPaG/xNtpZ9eXUZtlDCfChaVmvNq0yEi4FafWrE6wYvZ1zX3r4Xr3UkjPFlk7Sxhq4rZbabdK2gy6VkcfJbYkIKU/Xxr5Km/0ydHvN9MHWt3HoZrxGtClxqUhH4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tr3IlT2U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tr3IlT2U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BFF1F000C4;
	Thu, 15 Oct 2026 12:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792067498;
	bh=MHQhylC/e/bPSXDtzw/nb0hCc/b+odSzs1bTljWX2Qo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Tr3IlT2UsFcs+8kVVAUOEORoPHjPb7+uBrzKd239ZjDqNL3h/iZSWQDje3QtIFm8/
	 MAh2OvbnakzvJE1KOBZJdUKZ6xaXTaI1ghUiaXPBGkonQNRy4Ld6ZHMXR60Bps+dPK
	 nPDpChCAf7IS/PPPZUxBXTJS/GQ35xGdTVlV9hk+dTtvmW9+1q+7Fx0RBMlkUGPFHc
	 m3OCMCuATXPcazp1hvBJH8xpVwIslhRuJkLpp66Cbmley3eYdh4xVZwdLUnv7wjdk0
	 QHwWTFMYCk8w+imER5706pY3zEaN1bYUhzXwHwgCm3gY9pKle8F8R+k0BluAhle2Bt
	 8MGg2oq6+aEGQ==
Message-ID: <sashiko-outbox-172802@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 -next 01/18] fs: pass struct path to notify_change()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261015125425.3246251-2-caixinchen1@huawei.com>
References: <20261015125425.3246251-1-caixinchen1@huawei.com>
 <20261015125425.3246251-2-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 12:31:37 +0000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> notify_change() takes a struct mnt_idmap and a struct dentry even
> though all of its callers either already hold a struct path (or a
> struct file) or have to pass &nop_mnt_idmap because no idmapped
> mount is involved.  Switch the helper and its declaration to take a
> struct path instead and derive the idmap and dentry from it.
>=20
> The ntfs named stream support applies metadata changes shared with a
> stream to the base inode's anonymous dentry, for which no struct path
> exists.  Add a __notify_change() variant without the LSM hook call,
> following the __vfs_setxattr_noperm() and __vfs_fileattr_set()
> precedents, and use it for that internal forward: the user-facing
> operation on the stream was already checked by the surrounding
> notify_change() call, so the base inode does not need a second
> security_inode_setattr() check.
>=20
> The security_inode_setattr() call within notify_change() keeps taking
> the idmap and dentry for now; it will be converted together with
> the LSM hook itself in a separate patch.
>=20
> Assisted-by: opencode: glm-5.3
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015125425.3246=
251-1-caixinchen1@huawei.com?part=3D1

