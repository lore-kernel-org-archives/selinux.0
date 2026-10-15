Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684DF51D539;
	Thu, 15 Oct 2026 12:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067986; cv=none; b=hYYGg+nHnDDys4Ajy132/8Z7G8lYfsmJTJDka7AaZJXD/wmKcUpYuLPJ7m/pEJAeIJIsKqBn+2gxrFoQfltKOG7eqvX36eHMHAb2MyDTBZY6FV5QYMd6EPm0kFeGqmOMY6eWWaMr4Zvc0RqQ7G9c6sximhzUDu+SSQDEVPKjzkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067986; c=relaxed/simple;
	bh=mYI7C2qHnQrVEdzfV07xv1/LWRfZh0C70vmCrOtU/js=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ehevufoxtcTn92xe4BpDjsq462epSn829Y6Z2Sj1QF0FCZ3OrdeUDF2erSGKFPnMDmhxyYYts3XIbr4MtJgtWyCN0ce2PcKkFsw6pM5ZFt7KKFFngPw38kF4nXWuheX3xWZAGOw4S2GGFSp1rybxc5b0RT4dXkS/0odRKJLEL2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2gVFhUq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2gVFhUq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2291F000C4;
	Thu, 15 Oct 2026 12:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792067985;
	bh=1OOskbVnZNPfbtJP03tbo/by23AVL/lRjwCMmuK9avA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=K2gVFhUqnVVDKe5OaURrpndfU8tuQtZOhM/AE0NHWHUuHQ89bA8e+6NU0W44SZ7m2
	 IYoqkg1t6Z3UBWmngI9FrVdrUaPzkxCJFIKaG2UVM5POMjgqf6XA7flPFNX3y1fiB7
	 afxJUIXX7vqqK2O051muBemKpmgn8KNIPJ3A8U2S19SyK7a5x9CPibFJzHHCL+OSqL
	 BN4nwUYZNa18shDYjNc/NIP42P32vs3YckyZkKkEfKJpXywF0BgdP2fP3nzMV9THZG
	 zJqquvrh4ZZ7YSeNtAqk8l1GCLO2jkiKzxWFPGdCJ+peTxdTy5Ys5eC+2af1NGC+kJ
	 /aBBWq9YboBAA==
Message-ID: <sashiko-outbox-172822@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 -next 12/18] LSM: rename the inode xattr hooks to
 path_xattr hooks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261015125425.3246251-13-caixinchen1@huawei.com>
References: <20261015125425.3246251-1-caixinchen1@huawei.com>
 <20261015125425.3246251-13-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 12:39:44 +0000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> The inode_setxattr, inode_getxattr, inode_listxattr and
> inode_removexattr hooks receive a struct path, so rename them to
> path_setxattr, path_getxattr, path_listxattr and path_removexattr to
> follow the path_* naming convention used for the other hooks that
> take a struct path (path_chmod, path_chown, ...).  Rename the
> security_inode_*xattr() inline wrappers to security_path_*xattr()
> and the SELinux, Smack, EVM, IMA and Landlock implementations
> accordingly.  The inode_post_setxattr and inode_post_removexattr
> notification hooks still take a dentry and keep their names.
>=20
> BPF programs attach to LSM hooks by name ("lsm/inode_getxattr",
> "lsm.s/inode_setxattr", ...), so update the BPF selftests to the new
> names.
>=20
> Assisted-by: opencode: glm-5.3
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015125425.3246=
251-1-caixinchen1@huawei.com?part=3D12

