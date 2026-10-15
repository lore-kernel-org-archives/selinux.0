Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7C4509F19;
	Thu, 15 Oct 2026 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067463; cv=none; b=H1vSdfSF9W1XJVMFEomrh7Yo0coGonn5pSbMStynOftEqPgsg5XSXBtae/TVgkcrYfIOZ4HWVvRZ5M1tSaVsd2+Z49JYR1rTNBqR/6cMIeP9+6+7fvoXkH44OumFiQyisd2e3WhDx8/NEGxSvEAnQP9IXRrIliqNNLTk+H+Vv0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067463; c=relaxed/simple;
	bh=nNvy7wkk2HW+Y99sljF6GyiaEv+vOn8a/MFYV9rDv7o=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qXS6I+xzWrQZiRCYxTRnZPdHEilH21OQX8ZC7matwGU1LXw72GzuNPrJL3VHBtP73qz69tc1FrCBRpy4U/UQVn0mXmwUnrDudUtMTCERKuMJG7mEB9lbncTbJpUkFphFDZT6BkxeiEz747Zk6gG3YyQFz5XxeRXhzOpaQ5Chh9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jj9recPx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jj9recPx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B76A1F000C5;
	Thu, 15 Oct 2026 12:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792067462;
	bh=f5/sNwiqgPuMO1nMzL0+WK9Qk3595CHETVKOaPvVBUk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=jj9recPxsWshJXZbo5lwkDfC6c20MEboFGT5QGyJdrYq8QlDjyaVT3p6iAJpTFjA2
	 8Zv1xEloRWgvIrEG99VKXMpJ5ELR78U82lI3fXp2ZxIwj35LeD4vuSiRcYPlNYr7sl
	 YrX2OZsG9I3lUaGxN4HcH/IzyztkH7qaRfB0jCnTAvKXxlvGsWB3ww8duBHZx9QFRG
	 61YDKMyWJYil4g7QFQtrL7riIo2s2bvICwe/lTa5aqq0o2K7cyPYB65zCVZfEUOT1W
	 vMdBIDHIAhkh+SwT+OhMQvi5TaNK0EYlmJKtXwiu29r/xbGVUvWVoSCJcudWEoYx+R
	 3Zu/5wwwibMMw==
Message-ID: <sashiko-outbox-172801@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 -next 07/18] LSM: pass struct path to the inode posix
 acl hooks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261015125425.3246251-8-caixinchen1@huawei.com>
References: <20261015125425.3246251-1-caixinchen1@huawei.com>
 <20261015125425.3246251-8-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 12:31:02 +0000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> The inode_set_acl, inode_get_acl and inode_remove_acl hooks are
> called from fs/posix_acl.c, whose helpers now hold a struct path and
> used to derive the idmap and dentry from it just for the hook calls.
>=20
> Convert the hooks and their SELinux, Smack, EVM and IMA
> implementations to take a const struct path.  The implementations
> derive the idmap and dentry they still need from the path, so this
> is a purely mechanical change with no behavior change.
>=20
> Assisted-by: opencode: glm-5.3
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015125425.3246=
251-1-caixinchen1@huawei.com?part=3D7

