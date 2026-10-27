Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106605;
	b=mxci6NG4Fzuhz9ohD1oqLd7fBitnc/we/i74QhZpS+p3S+aWyLy2N4kotqe2YgfY4NL8
	 HpVG1HDtTjljx17kp9isaOFjOO+rilvLQX58FJRAFoaCnJ2aFDB/WG5jusqceP1pe1Brx
	 dIyBcB/VO7r4GlfyA9PKaf40xsDvYsi/Ye5LcWDaocqWvSVicGZJAF1vXLnKHWJ//CubH
	 Oxwcp24LxXBLwDhsgEJ0qoHrtgGN7Ps80FGuCRHWuL7/7faF/NDVWp2TlDrq9YNTYEBUt
	 WAl4wTE7iWYxoY6ujv0fA3msh7lY1fwI7g4C7U0dFU7pCYUVvk2VTlHtHClAPbAeaLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106605;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cnckmvKB6NTwJYaz/sp2bU205+IFU3Bw2Lc5OSR+Uuo=;
	b=q/9N3NunsBRWMJ+4e8X7Pdz94CQzFBVWWbFIcNf8pItv5vAfI39YIikph7VDCgPlra+0
	 fzqqh9ILH3Wr1KzY7FiruEoil67iO7z0W+u1eVdW8LV8RKPcupOj9hoV+Sd9EGNhGiYUe
	 YNttDBUOej16hIqtWp6JshtHXc9NusJMz2LEPdurEBM3O9OotmE3PzKLAIsRGNoyRDase
	 wvf0GCC/8bfBvQesxgAwoi+07vaukD5G5N25yNpjsOY9OZb1PS4ntxFprF9JUaJVpjboa
	 az7yFIcA1hA0GzzCpBYQY9gB4z2cns3+38a4iLU3vub8MIi9BnKDKGHW7CRToreJVwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MRYA6Y3O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FF1606A320;
	Tue, 27 Oct 2026 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MRYA6Y3O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A621F01825;
	Tue, 27 Oct 2026 13:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793106605;
	bh=cnckmvKB6NTwJYaz/sp2bU205+IFU3Bw2Lc5OSR+Uuo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=MRYA6Y3OB2R3l9V1j3fqdEyTPePuLSz2QoeS7J68+Y5QFqTcXDg3DgIqvWKWw9Nwp
	 bGrJCScEsuZentPBJsUEEMqxrCTx1ZC4pYl9oRTObhbmUrxq07g050vJtbRqI4SK3m
	 tQ50MHtUL9lcFHDt/CCrpXJQhR6lnR9KiHZbgCYh0SWkXoQN/mnPiOOmM/KXX11XDu
	 3snBDIN+Q/0OjwUyECQKGU8KKeohkAfOKKT58Da5FbWezqTWp5gu7er9NbrFz6Wd8D
	 UN990sgeL9DxQFEkSAz6rGXnwODDMrQSuisVdi1B/pbFbnxXw96luYv4fEm1ORZSNL
	 Ks4d9q4PAG3ww==
Message-ID: <sashiko-outbox-186605@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 -next 07/18] LSM: pass struct path and struct file to
 the inode posix acl hooks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261027121151.1887650-8-caixinchen1@huawei.com>
References: <20261027121151.1887650-1-caixinchen1@huawei.com>
 <20261027121151.1887650-8-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 13:10:04 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> The inode_set_acl, inode_get_acl and inode_remove_acl hooks are
> called from fs/posix_acl.c, whose helpers now hold a struct path and
> used to derive the dentry from it just for the hook calls.
>=20
> Convert the hooks and their SELinux, Smack, EVM and IMA
> implementations to take a const struct path, keeping the idmap as a
> separate argument.  The implementations derive the dentry they still
> need from the path, so this is a purely mechanical change with no
> behavior change.
>=20
> Also pass the struct file through which a posix acl operation is
> requested, when there is one, so that LSMs can later authorize
> file descriptor-based operations (fsetxattr(2), fgetxattr(2) and
> fremovexattr(2) on the system.posix_acl_access and
> system.posix_acl_default names, the *xattrat(2) syscalls with
> AT_EMPTY_PATH, and io_uring's IORING_OP_FSETXATTR and
> IORING_OP_FGETXATTR) with the rights available at open(2) time.
> The file is threaded through vfs_set_acl(), vfs_get_acl(),
> vfs_remove_acl(), do_set_acl() and do_get_acl(), and set to NULL
> for path-based operations and for in-kernel users: overlayfs,
> ecryptfs and the SMB server.  No implementation uses the file yet,
> so this part is a purely mechanical change with no behavior change
> either.
>=20
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027121151.1887=
650-1-caixinchen1@huawei.com?part=3D7

