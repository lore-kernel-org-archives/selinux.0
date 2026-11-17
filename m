Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927555;
	b=4XpdLRBnRxRRoEseWlz4vboCMXJYbeKkGdXpk2KtNafp7EGXNZHkrYO11e9a9VzY7yS0
	 mTb/UG/R7cSHPphcdHbP8OFFhy6j81HGzFvOZ/qMytTxYxYhfMpJANC1f5bn1hF44ecI+
	 cpjkrks/8E3AJOn1MUt+msa7mhpYIMogPIAguNntdtM6v6zrjtdFx69Oz/dJYSyCTEFBs
	 T1nGVgisNMU7MSP/N3WKk8WJxrxVZHE12LIug1WosD3MaJ5UvLjnuUzBnTy+3G4UPXcFh
	 J21Nu9YFSukli3yEuW1756GGtXWXkPCb1NPVYTSZuUktDKcxCfKSPcH9VQVmGoXiwCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927555;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4jfh4m9j43/9ksQB9D7PMT5we7v6VnG84qBimT28Ej8=;
	b=xTaLl5RHG+pL1VMkw5vQpTfblIE41c07Qv0SGhugn0IoqjNtYUEOyW6OpAXHivtoGHEP
	 DHNWarmMX4hM7Bvxb4Z8B4jcevybP77NqjydIRZHLbKapyEMyL+jzFZRp77G4mmfXRljK
	 4j3sLCHgGKI9/GumAV6u4h7LZ/bMot1v7ivakD8su/YiX6UawNgsyigxyXCOrxIJHuX0u
	 HTno5pzwVPwtr2cdviF0uK+hIf9LVsgPeNuXZ76LVbhsyZXkExTDOrGQTFDBPMmmFeo4z
	 bxIsIY2PvD2FbFmkAQqRCHA2V7Nt/OdAo4bEprQUScjSfmry2ktM1Y/kSXBiP81mSgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CN9G1LUB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3321C606A31C;
	Tue, 17 Nov 2026 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CN9G1LUB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1E91F000C5;
	Tue, 17 Nov 2026 14:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794927555;
	bh=4jfh4m9j43/9ksQB9D7PMT5we7v6VnG84qBimT28Ej8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CN9G1LUBjr+lJ7NU9iXR3BpsMRnu+rx5EYLPTpIAYwDmyMq1jrW/TfKwCBxd1KARG
	 zOZ0BOtkxHcjD2Xz5FIQP6FlxfTwP8MRlaJdiHdJYvt2cDqz8cdIeA8DQP/w148NUr
	 pqb6P9ZXatRGz43B6ktnNELL8L175cAu/0VlVTHAANJNyma8OfvHdXYRFp29atssWm
	 4+xEoUAaNyOqhh13v8AMsucxWmeru89K9ieknf+kdm9t4cxeTxA+PYD+1xtPpSPrks
	 dAdZVDsP7NYvmV9k+RH9JM+pSa7amSYmL8cAlFeJvv+zM5Une1w7OXswsjNsiZEcN8
	 B1xNLwe12usfw==
Message-ID: <sashiko-outbox-219006@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next -v4 03/17] fs: pass struct path to xattr helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org, dsterba@suse.cz, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261117150542.1169451-4-caixinchen1@huawei.com>
References: <20261117150542.1169451-1-caixinchen1@huawei.com>
 <20261117150542.1169451-4-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:59:14 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] ksmbd: dotdot mount walk in
  ksmbd_populate_dot_dotdot_entries() escapes share_root
- [Low] nfsd: reverse Christmas tree order violated in nfsd_getxattr()
  and nfsd_listxattr()
--

commit 659e941625d287aa476faa3056e5fd5cc15c2d66
Author: Cai Xinchen <caixinchen1@huawei.com>

fs: pass struct path to xattr helpers

This commit updates vfs_setxattr(), vfs_getxattr(), vfs_listxattr(),
vfs_removexattr(), and the __vfs_*_locked() helpers along with their
callers in ksmbd, nfsd, overlayfs, cachefiles, ecryptfs, and LSMs to
pass a struct path instead of a struct dentry.

> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 1c686b82e70a0..aef4097e9ef37 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
[ ... ]
> @@ -2676,23 +2678,24 @@ __be32
>  nfsd_getxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name,
>  	      void **bufp, int *lenp)
>  {
> +	struct path path;
> +	struct inode *inode;
> +	char *buf;
>  	ssize_t len;
>  	__be32 err;
> -	char *buf;
> -	struct inode *inode;
> -	struct dentry *dentry;
[ ... ]
> @@ -2749,23 +2752,24 @@ __be32
>  nfsd_listxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char **bufp,
>  	       int *lenp)
>  {
> +	struct path path;
> +	struct inode *inode;
> +	char *buf;
>  	ssize_t len;
>  	__be32 err;
> -	char *buf;
> -	struct inode *inode;
> -	struct dentry *dentry;

[Severity: Low]
This isn't a bug, but NFSD keeps local variable declarations in reverse
Christmas tree order, so struct inode *inode; should come before struct
path path; in both nfsd_getxattr() and nfsd_listxattr().

> diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
> index e7a987af64ba5..a6da27a7d7cbb 100644
> --- a/fs/smb/server/smb_common.c
> +++ b/fs/smb/server/smb_common.c
> @@ -467,37 +467,82 @@ int ksmbd_populate_dot_dotdot_entries(struct ksmbd_=
work *work, int info_level,
>  {
>  	int i, rc =3D 0;
>  	struct ksmbd_conn *conn =3D work->conn;
> -	const struct mnt_idmap *idmap =3D file_mnt_idmap(dir->filp);
> +	const struct path *const share_root =3D &work->tcon->share_conf->vfs_pa=
th;
> =20
>  	for (i =3D 0; i < 2; i++) {
>  		struct kstat kstat;
>  		struct ksmbd_kstat ksmbd_kstat;
> -		struct dentry *dentry;
> +		struct path path =3D dir->filp->f_path;
> +		const struct mnt_idmap *idmap;
> +		struct dentry *parent;
> =20
>  		if (!dir->dot_dotdot[i]) { /* fill dot entry info */
>  			if (i =3D=3D 0) {
>  				d_info->name =3D ".";
>  				d_info->name_len =3D 1;
> -				dentry =3D dget(dir->filp->f_path.dentry);
> +				path_get(&path);
>  			} else {
>  				d_info->name =3D "..";
>  				d_info->name_len =3D 2;
> -				dentry =3D dget_parent(dir->filp->f_path.dentry);
> +				path_get(&path);
> +				/*
> +				 * A ".." entry must not walk above the
> +				 * share root, so it designates the share
> +				 * root itself in that case.
> +				 */
> +				if (!path_equal(&path, share_root)) {
> +					/*
> +					 * The parent of a mount root dentry
> +					 * is not covered by the same mount,
> +					 * so follow the mount stack up like
> +					 * a ".." path walk would, to keep
> +					 * the path valid.
> +					 */
> +					while (path.dentry =3D=3D path.mnt->mnt_root &&
> +					       follow_up(&path))
> +						;
> +					if (path.dentry =3D=3D path.mnt->mnt_root) {
> +						/*
> +						 * The mount is detached, for
> +						 * example after a lazy umount
> +						 * which the open file pins
> +						 * down, so the parent would
> +						 * not be covered by path.mnt:
> +						 * report the share root
> +						 * instead, as for any other
> +						 * ".." above the share root.
> +						 */
> +						path_put(&path);
> +						path_get(share_root);
> +						path =3D *share_root;
> +					} else {
> +						parent =3D dget_parent(path.dentry);
> +						dput(path.dentry);
> +						path.dentry =3D parent;
> +					}
> +				}
>  			}

[Severity: Medium]
Can the ".." resolution walk above share_root when a mount is stacked on
top of share_root?

If a submount is mounted on share_root and entered via follow_down() when
KSMBD_SHARE_FLAG_CROSSMNT is enabled, dir->filp->f_path is the submount
root, so the initial path_equal(&path, share_root) check is false.
follow_up(&path) then steps onto share_root, but neither the while loop
nor the dget_parent() branch rechecks path_equal(&path, share_root).
If share_root is itself a mountpoint, the loop continues calling
follow_up(&path) into the parent mount; otherwise the else branch calls
dget_parent(path.dentry) and steps to the parent directory of share_root,
exposing host directory attributes and xattrs outside the share to the
SMB client via ksmbd_vfs_fill_dentry_attrs().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117150542.1169=
451-1-caixinchen1@huawei.com?part=3D3
