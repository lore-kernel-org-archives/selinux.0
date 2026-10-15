Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B782751DAE7;
	Thu, 15 Oct 2026 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067547; cv=none; b=O7C5OtkZhEwwpJj/uvFKY77aM0jCVfrAjqj3mK5yk3DYddcZ3ovp/QwOsBwqx3BexdkeIN2xVvtiaWSkmO+5O7TbIEurZdOdCxJCITH5klS6EopSAyVgbI/bG3w3/4IyM5/2fDIOFW96EyPFpW4Tx4mwRv6/d29XTovmHGJVl0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067547; c=relaxed/simple;
	bh=qYy2QF5K59xvKrM+F4DHAoYDJ9e/KpODyEaW+wz6ymY=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Zhmq8sPm7FgqQ/EmxDj+duzw9v51eXLz5QM1XpgYxETPcPBOMTPnXkmRn7Lr9KNWlCuQ2Ie3hlgggNt23FlTNT9vuAuYfD++bZp//Zcup9K5rgo1oRjsO+wGSh+SueZWuEObs7izy7sMSpLIWi5RDiFaOQYNGKApt15PrQHdWaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUPVkXfX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUPVkXfX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F71C1F000C5;
	Thu, 15 Oct 2026 12:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792067546;
	bh=jRSkfKtR+ZPFEICO6Knap/N5m855jLToSTS285htF4w=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=PUPVkXfXKXIntAEHKBkUeuDD3Ylgrvij9ePDBqEIYVP7JyPXt1wMqCTB/n98atUiN
	 rTro5LR1l+GyHhIn6Hmi0kZknqrkv4PcxDiigveQweGIhrlrxu8XmPAjqgI3oy7Q+n
	 31sGusg5Sw9xJQNOvezdy6mG5uPPAf7iUuiaEyGnbakJ+su3/8BirTJS2MdXYA9XBk
	 2ZmPktXo3whAXkT0mMaRGCk25eTjcVuExn5YbTDtxrWeeUxSm+NsuVppxTrRu9FiPu
	 pAY5h23aRgPp2SHUZXVCet0I17N8BUZ3Ajnd5QlXz/7NBocFa6qhn7gy9zAfkAxB4H
	 ADk4brpM0zt1Q==
Message-ID: <sashiko-outbox-172806@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 -next 06/18] LSM: pass struct path to the inode xattr
 hooks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261015125425.3246251-7-caixinchen1@huawei.com>
References: <20261015125425.3246251-1-caixinchen1@huawei.com>
 <20261015125425.3246251-7-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 12:32:26 +0000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> The inode_setxattr, inode_getxattr, inode_listxattr and
> inode_removexattr hooks are called from fs/xattr.c, whose helpers
> now hold a struct path and used to derive the idmap and dentry from
> it just for the hook calls.
>=20
> Convert the hooks and their commoncap, SELinux, Smack, EVM and IMA
> implementations to take a const struct path.  The implementations
> derive the idmap and dentry they still need from the path, so this
> is a purely mechanical change with no behavior change.
>=20
> Also update the BPF selftest programs that attach to the changed
> hooks (test_get_xattr.c, test_set_remove_xattr.c and
> verifier_lsm_init_xattr.c) to the new signatures, passing
> path->dentry to the dentry xattr kfuncs.  The bpf_lsm_* attach
> stubs themselves are generated from lsm_hook_defs.h and need no
> changes.
>=20
> Assisted-by: opencode: glm-5.3
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015125425.3246=
251-1-caixinchen1@huawei.com?part=3D6

