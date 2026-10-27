Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108739;
	b=1iDmAolP75QMbx5f+2dawkIJy1MLsINLivepRcCvVqi9y002ul8yPB2k3SJggzxBdYVK
	 eCZx4cgBjRPGp/SqeSmlRAJgMesRWx9gHCuYM9UZm8m5Tbl1Pe8HTUl2EsmRXwV14Pgqo
	 NGEUfXLRfUk6YXpmlhKwVRk0kax1pNi3Lm/2I612Lk/t9qxqev20Ivenx/uvJnS/xUPO9
	 yV/6LMWzxj3DApcNZxaMRhAWOfS8W1npoYZ1j4Eqr9d4y8vgZwndB+coSpzF2RUpo/r7e
	 dwgAL2uLet+c9chyp8eNDNELMFQJyZ4pfoYmKkAfcSkaDBG/cgSJ331Y3CB9uh3Pprg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108739;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0xTTV2LlXzhh+YL+DnIceW8Od0RkrWLTRt8+p/f2sP8=;
	b=n77/jA8AP5U5dDLap46o7JfL9xAYUnRgztCkpGI2mNDtzRPXm98RM14jKHem2eaechQt
	 EVA28yWuxOi/q1J+RFOc1FPDyDlLD4qehAAsVCu8pw4UU500dz+AawQET00RgS2qiCVA3
	 FVtwGLvu4sL/Ors8/IaRyEoCKOWAtTHl+ZF/gRcZif/3/c0okI7nZ98zgpIWB0guEN8dZ
	 R3VntyYcyUKBbmp7yzlDyenCNuBJyY4Bzq0/c4LEQ4j0BcIrjLfMaYMWzdtKmIdIkKhqV
	 5aRIF6PWfYwUhpekJI0Pb+6p+AeHor1XGbU9EsLlLFxXP1g2GyzZchz2/gaX+U4rVeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oliOqBmk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D21606A31A;
	Tue, 27 Oct 2026 13:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oliOqBmk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADD01F01825;
	Tue, 27 Oct 2026 13:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793108738;
	bh=0xTTV2LlXzhh+YL+DnIceW8Od0RkrWLTRt8+p/f2sP8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oliOqBmk9jrj7oNPmH6X8wky8AOEwhzKXQdpbQFZQDJrs0jwI+nmjQOpT5hWkl6YP
	 HdfmzXXWEtzgFYFpw8Md+YOSjF7G5Yr04IdwhA/57fVpCZC9836M5Z62v/p2XMv+65
	 NrDkYTmqh7TP8EgRZKjZs21qB2goWWyAA4UuOuQ2DTLNJD+rj16SmUty6x7MQ4eTeF
	 3yFGcomi4JyL+zZvHa8ZBgzTxiGaWexd4wH95woxI77JMCV8oFmtK3OhZB2TxsHZ34
	 FDfHK7zlR3yPraOZ9jZenoaz/qwfayCJnQ07tFVHehWcLOeYZSun5KJuOmwCuWEeAn
	 W0vZ9SFvJZvfw==
Message-ID: <sashiko-outbox-186665@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 -next 08/18] LSM: pass struct path and struct file to
 the inode fileattr hooks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org, dsterba@suse.cz, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261027121151.1887650-9-caixinchen1@huawei.com>
References: <20261027121151.1887650-1-caixinchen1@huawei.com>
 <20261027121151.1887650-9-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 13:45:37 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] ovl: bypass of underlying LSM checks in ovl_real_fileattr_get() an=
d set
- [Medium] vfs: vfs_fileattr_get() runs LSM hook before checking i_op->file=
attr_get
--

commit 2d42ade8215536e97143b2105a207c59391b323b
Author: Cai Xinchen <caixinchen1@huawei.com>

LSM: pass struct path and struct file to the inode fileattr hooks

This commit updates vfs_fileattr_get(), vfs_fileattr_set(), and the
inode_file_getattr and inode_file_setattr security hooks to accept a
const struct path and struct file. It also introduces unchecked
__vfs_fileattr_get() and __vfs_fileattr_set() helpers and switches
ecryptfs, overlayfs, and nfsd internal fileattr calls to use them.

> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index fcb5b4de897e4..2b8daf21aea85 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -1077,7 +1077,7 @@ static int ecryptfs_removexattr(struct dentry *dent=
ry, struct inode *inode,
> =20
>  static int ecryptfs_fileattr_get(struct dentry *dentry, struct file_katt=
r *fa)
>  {
> -	return vfs_fileattr_get(ecryptfs_dentry_to_lower(dentry), fa);
> +	return __vfs_fileattr_get(ecryptfs_dentry_to_lower(dentry), fa);
>  }
> =20
>  static int ecryptfs_fileattr_set(const struct mnt_idmap *idmap,
> @@ -1086,7 +1086,7 @@ static int ecryptfs_fileattr_set(const struct mnt_i=
dmap *idmap,
>  	struct dentry *lower_dentry =3D ecryptfs_dentry_to_lower(dentry);
>  	int rc;
> =20
> -	rc =3D vfs_fileattr_set(&nop_mnt_idmap, lower_dentry, fa);
> +	rc =3D __vfs_fileattr_set(&nop_mnt_idmap, lower_dentry, fa);
>  	fsstack_copy_attr_all(d_inode(dentry), d_inode(lower_dentry));
> =20
>  	return rc;
> diff --git a/fs/file_attr.c b/fs/file_attr.c
> index 833e03810b24c..08b4cdbef9ffa 100644
> --- a/fs/file_attr.c
> +++ b/fs/file_attr.c
> @@ -75,27 +75,48 @@ void fileattr_fill_flags(struct file_kattr *fa, u32 f=
lags)
>  EXPORT_SYMBOL(fileattr_fill_flags);
> =20
>  /**
> - * vfs_fileattr_get - retrieve miscellaneous file attributes
> + * __vfs_fileattr_get - retrieve miscellaneous file attributes
>   * @dentry:	the object to retrieve from
>   * @fa:		fileattr pointer
>   *
> - * Call i_op->fileattr_get() callback, if exists.
> + * Call i_op->fileattr_get() callback, if exists.  Unlike
> + * vfs_fileattr_get(), no security hook is called: this is the variant to
> + * use for internal forwards, where the LSM checks were already performed
> + * on the user-facing path (e.g. by a stacking filesystem).
>   *
>   * Return: 0 on success, or a negative error on failure.
>   */
> -int vfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
> +int __vfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
>  {
>  	struct inode *inode =3D d_inode(dentry);
> -	int error;
> =20
>  	if (!inode->i_op->fileattr_get)
>  		return -ENOIOCTLCMD;
> =20
> -	error =3D security_inode_file_getattr(dentry, fa);
> +	return inode->i_op->fileattr_get(dentry, fa);
> +}
> +EXPORT_SYMBOL(__vfs_fileattr_get);
> +
> +/**
> + * vfs_fileattr_get - retrieve miscellaneous file attributes
> + * @path:	the object to retrieve from
> + * @fa:		fileattr pointer
> + * @file:	file through which the attributes are retrieved, if any
> + *
> + * Call i_op->fileattr_get() callback, if exists.
> + *
> + * Return: 0 on success, or a negative error on failure.
> + */
> +int vfs_fileattr_get(const struct path *path, struct file_kattr *fa,
> +		     struct file *file)
> +{
> +	int error;
> +
> +	error =3D security_inode_file_getattr(path, fa, file);
>  	if (error)
>  		return error;
> =20
> -	return inode->i_op->fileattr_get(dentry, fa);
> +	return __vfs_fileattr_get(path->dentry, fa);
>  }

[Severity: Medium]
Should vfs_fileattr_get() check whether inode->i_op->fileattr_get is
implemented before calling security_inode_file_getattr()?

Previously, vfs_fileattr_get() checked !inode->i_op->fileattr_get and
returned -ENOIOCTLCMD before invoking security_inode_file_getattr(), matchi=
ng
do_vfs_fileattr_set() in fs/file_attr.c:

    if (!inode->i_op->fileattr_set)
        return -ENOIOCTLCMD;

With the check moved into __vfs_fileattr_get(), calling vfs_fileattr_get() =
on
an inode whose filesystem does not implement i_op->fileattr_get (such as
tmpfs, procfs, sysfs, NFS, FUSE without fileattr_get, or special files) runs
security_inode_file_getattr() first.

If an LSM denies the hook, vfs_fileattr_get() returns -EACCES (and generates
audit denial records) instead of -ENOIOCTLCMD. Callers such as
do_vfs_ioctl() -> ioctl_getflags() / ioctl_fsgetxattr(), file_getattr(), and
ksmbd's smb2_get_info_filesystem(), ksmbd_vfs_get_compression(), and
__ksmbd_vfs_set_compression() rely on -ENOIOCTLCMD to fall back to
vfs_ioctl(), -EOPNOTSUPP, or default attributes:

fs/smb/server/smb2pdu.c:smb2_get_info_filesystem() {
    ...
    err =3D vfs_fileattr_get(&path, &fa, NULL);
    if (err && err !=3D -ENOIOCTLCMD && err !=3D -ENOTTY &&
        err !=3D -EINVAL && err !=3D -EOPNOTSUPP) {
        path_put(&path);
        return err;
    }
    ...
}

[ ... ]

> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index eb408284df082..4f1d3077735bd 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -608,47 +608,10 @@ static int ovl_fiemap(struct inode *inode, struct f=
iemap_extent_info *fieinfo,
>  		return realinode->i_op->fiemap(realinode, fieinfo, start, len);
>  }
> =20
> -/*
> - * Work around the fact that security_file_ioctl() takes a file argument.
> - * Introducing security_inode_fileattr_get/set() hooks would solve this =
issue
> - * properly.
> - */
> -static int ovl_security_fileattr(const struct path *realpath, struct fil=
e_kattr *fa,
> -				 bool set)
> -{
> -	struct file *file;
> -	unsigned int cmd;
> -	int err;
> -	unsigned int flags;
> -
> -	flags =3D O_RDONLY;
> -	if (force_o_largefile())
> -		flags |=3D O_LARGEFILE;
> -
> -	file =3D dentry_open(realpath, flags, current_cred());
> -	if (IS_ERR(file))
> -		return PTR_ERR(file);
> -
> -	if (set)
> -		cmd =3D fa->fsx_valid ? FS_IOC_FSSETXATTR : FS_IOC_SETFLAGS;
> -	else
> -		cmd =3D fa->fsx_valid ? FS_IOC_FSGETXATTR : FS_IOC_GETFLAGS;
> -
> -	err =3D security_file_ioctl(file, cmd, 0);
> -	fput(file);
> -
> -	return err;
> -}
> -
>  int ovl_real_fileattr_set(const struct path *realpath, struct file_kattr=
 *fa)
>  {
> -	int err;
> -
> -	err =3D ovl_security_fileattr(realpath, fa, true);
> -	if (err)
> -		return err;
> -
> -	return vfs_fileattr_set(mnt_idmap(realpath->mnt), realpath->dentry, fa);
> +	return __vfs_fileattr_set(mnt_idmap(realpath->mnt), realpath->dentry,
> +				  fa);
>  }
> =20
>  int ovl_fileattr_set(const struct mnt_idmap *idmap,
> @@ -718,11 +681,7 @@ int ovl_real_fileattr_get(const struct path *realpat=
h, struct file_kattr *fa)
>  {
>  	int err;
> =20
> -	err =3D ovl_security_fileattr(realpath, fa, false);
> -	if (err)
> -		return err;
> -
> -	err =3D vfs_fileattr_get(realpath->dentry, fa);
> +	err =3D __vfs_fileattr_get(realpath->dentry, fa);
>  	if (err =3D=3D -ENOIOCTLCMD)
>  		err =3D -ENOTTY;
>  	return err;

[Severity: High]
Won't removing ovl_security_fileattr() while also switching
ovl_real_fileattr_set() and ovl_real_fileattr_get() (as well as
ecryptfs_fileattr_get() and ecryptfs_fileattr_set() in fs/ecryptfs/inode.c)
to the unchecked __vfs_fileattr_set() and __vfs_fileattr_get() helpers bypa=
ss
mandatory access control checks on the underlying layer?

As described in Documentation/filesystems/overlayfs.rst ("Permission model"=
),
overlayfs performs two permission checks on each access:

 a) check if current task is allowed access based on local DAC (owner,
    group, mode and posix acl), as well as MAC checks

 b) check if stashed credentials would be allowed real operation on lower or
    upper layer based on underlying filesystem permissions, again including
    MAC checks

Other overlayfs metadata operations (such as ovl_do_notify_change(),
ovl_xattr_get(), ovl_do_setxattr(), ovl_do_removexattr(), ovl_get_acl_path(=
),
and ovl_do_set_acl()) invoke the hook-checked VFS helpers on the underlying
realpath under with_ovl_creds() to enforce the second check.

Commit 66dbfabf10d3 ("ovl: stack fileattr ops") added ovl_security_fileattr=
()
under the mounter's credentials to check the underlying realpath when
vfs_fileattr_get() and vfs_fileattr_set() lacked LSM hooks. Now that
vfs_fileattr_get() and vfs_fileattr_set() invoke the security hooks on a
struct path, using __vfs_fileattr_get() and __vfs_fileattr_set() in
ovl_real_fileattr_get() and ovl_real_fileattr_set() skips the second MAC
check on realpath altogether.

For example, when an unprivileged user namespace mounts overlayfs with a
context=3D mount option (or with override_creds) and calls path-based
file_getattr() or file_setattr() on an upper file, the first check only
evaluates the overlay mountpoint label, and __vfs_fileattr_get() /
__vfs_fileattr_set() bypass SELinux FILE__GETATTR and FILE__SETATTR checks =
on
the underlying inode. Similarly, in ecryptfs, the lower filesystem can have
per-file SELinux xattr labels distinct from the ecryptfs genfscon label, and
ecryptfs_setattr(), ecryptfs_setxattr(), and ecryptfs_set_acl() all call the
hook-checked VFS helpers on the lower dentry/path.

Should ovl_real_fileattr_get(), ovl_real_fileattr_set(),
ecryptfs_fileattr_get(), and ecryptfs_fileattr_set() call vfs_fileattr_get()
and vfs_fileattr_set() instead of the unchecked helpers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027121151.1887=
650-1-caixinchen1@huawei.com?part=3D8
