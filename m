Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793102850;
	b=G36RzLEWWLYGEoPRpf5Se/n3dbgGfuSgdS8uou8kOHE3uL6QTBa6Ec6pZsvLM4zJBZ7C
	 Gg08gmRBx0IZ4WflNPeZJYHvyezWTWwtV9oBzQLlNK72+haWr3YGNAYmJhH3OqKfw4yqa
	 VhA2+IXC/dCu9Y85nW0eFjTZ0w4hElk+MkHVK0S4tkFhUbTphyUNOQCXOzuH3EdnuNiMO
	 QtyAJHMmvrCBo8Q4kJVeC/dds3ukCuO826zAGx3/2kJIv/d6/bavMdVdpyPIC1FlmgBCd
	 3PPxeChQ2l6UOydbtFVEH39PPxdXLT3RvTExGU7c0DBEWXl4HwnyAHX+2Iog5Tb5++g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793102850;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XuAqvW/17/K4S72P6BveYIRMwFq7nJ4rumTZEaNiaZo=;
	b=vpKpD62UjQKgHGSTxpTgVtWfUPhi7s4x7P/o+spoO/Bk1Jul2gnClgXaVJtIuOZaIAIm
	 49Wnu/ENNCQa679SkxftqGUPIn1TwlVJvUyP3v4ZZAN5/ReFhnv94rbjDkJ/bErrGaw72
	 +tL73/CW5mcbJBgYR0nuoFVRoUonQh0q6YMg4z71TyuIYs+Xu41Dq9fNcWF/42RJEAUPn
	 cQOj7tVpAt4kfOv5hvxGV0k7U9vMaJUi+9j28M8YV1wA7fN1nxAMtitdFqn+j5SfJWAB7
	 AntQdEYcRqIKMi2iY+gaP6FvZ8wLrnP0wPc+Y872GdLxYBDJ5mMaccPryopgj3hXXdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aepiy6Pr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F4F606A320;
	Tue, 27 Oct 2026 12:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aepiy6Pr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E471F031E1;
	Tue, 27 Oct 2026 12:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793102849;
	bh=XuAqvW/17/K4S72P6BveYIRMwFq7nJ4rumTZEaNiaZo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Aepiy6PrXjWdKUfE1o3JOEWJ7QmDYyGMp0xIKeaRQaEYFFNU92l9eHWmpaMPc8Ih/
	 DA5ZKcUt2BtnnUjrwlLYkVXwDhpKkO+Al0REzcpyIChrmEhBfe2Ll6TGsRRG2bD/vI
	 Z2AgSZxCxN1PgBF63gUcbSsQzWohxYoPp4mShCuJdsHDzcHrUxWa61Y4iU/efFP8sg
	 FpLtK9TcNBpnPr+VNIX4ABCaGtIRa8NJIdIQiNzPKhCq5nBY3UGMFqedBs3a6agh9f
	 kGinMsLibqXunAF+WpYhUlIdxSASW5ndy23WeVEZv5sId0RHUhPRCIAr+nsI83yLK8
	 MiAdek65P3GcQ==
Message-ID: <sashiko-outbox-186508@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 -next 01/18] fs: pass struct path to notify_change()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org, dsterba@suse.cz, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261027121151.1887650-2-caixinchen1@huawei.com>
References: <20261027121151.1887650-1-caixinchen1@huawei.com>
 <20261027121151.1887650-2-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 12:07:28 +0000
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
- [High] fs: __notify_change() in ntfs_stream_setattr_common() bypasses bas=
e inode LSM checks
- [Low] nfsd: stale @dentry kernel-doc parameter in nfsd4_deleg_getattr_con=
flict()
--

commit 205fb5135661a50181cb638aff919af8443d55ff
Author: Cai Xinchen <caixinchen1@huawei.com>

fs: pass struct path to notify_change()

This commit updates notify_change() and do_truncate() to accept a struct pa=
th
pointer instead of a struct dentry pointer alongside the mount idmap. It al=
so
introduces __notify_change() without the security_inode_setattr() check and
uses it in ntfs_stream_setattr_common() when forwarding attribute updates to
the base inode.

> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 1de6c6d757c3e..3a08c56a27c60 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c

[ ... ]

> @@ -10531,7 +10533,7 @@ static int cb_getattr_update_times(struct dentry =
*dentry, struct nfs4_delegation
>   * caller must put the reference.
>   */
>  __be32
> -nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dent=
ry,
> +nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, const struct path *=
path,
>  			     struct nfs4_delegation **pdp)

[Severity: Low]
Since the second parameter of nfsd4_deleg_getattr_conflict() in
fs/nfsd/nfs4state.c was changed from dentry to path, should the kernel-doc
comment right above it also be updated from @dentry to @path to avoid
scripts/kernel-doc warnings when building with W=3D1 or htmldocs?

[ ... ]

> diff --git a/fs/ntfs/named_stream.c b/fs/ntfs/named_stream.c
> index 95a3c05f98211..f0b577a6f7c3e 100644
> --- a/fs/ntfs/named_stream.c
> +++ b/fs/ntfs/named_stream.c
> @@ -897,7 +897,7 @@ static int ntfs_stream_setattr_common(const struct mn=
t_idmap *idmap,
>  			goto out;
>  		}
>  		if (base_attr.ia_valid)
> -			err =3D notify_change(idmap, base_dentry, &base_attr,
> +			err =3D __notify_change(idmap, base_dentry, &base_attr,
>  					NULL);
>  		else
>  			err =3D 0;

[Severity: High]
Does switching to __notify_change() in ntfs_stream_setattr_common() skip
required LSM and EVM checks on the base inode when a user calls chmod, chow=
n,
or utimensat on an NTFS named stream?

The stream inode (vi) and the base inode (base_vi) are separate struct inode
objects with distinct security state and potentially different file types.

First, NTFS permits named data streams on directories, and
ntfs_stream_setattr_common() preserves base_vi's S_IFMT when forwarding mode
changes:

    else if (base_attr.ia_valid & ATTR_MODE)
        base_attr.ia_mode =3D (base_attr.ia_mode & ~S_IFMT) |
                (base_vi->i_mode & S_IFMT);

However, ntfs_read_locked_attr_inode() and ntfs_stream_inode_refresh() alwa=
ys
force the stream inode's mode to S_IFREG:

    base_vi =3D VFS_I(ni->ext.base_ntfs_ino);
    vi->i_uid =3D base_vi->i_uid;
    vi->i_gid =3D base_vi->i_gid;
    vi->i_mode =3D (base_vi->i_mode & ~S_IFMT) | S_IFREG;

In SELinux, the initial notify_change() on the stream dentry checks the
stream inode with sclass SECCLASS_FILE, whereas base_vi has sclass
SECCLASS_DIR. Skipping security_inode_setattr() on base_dentry via
__notify_change() allows a caller with file setattr permission (but not dir
setattr permission) to modify the base directory's mode, ownership, or
timestamps through a directory stream.

Second, ntfs_setxattr() rejects stream inodes with -EOPNOTSUPP while allowi=
ng
security.* xattr changes on base_vi. If base_vi is relabeled via setxattr()
while a stream inode is cached in memory (such as via an open stream file
descriptor), security_inode_post_setxattr() (including
selinux_inode_post_setxattr(), smack_inode_post_setxattr(), and
evm_reset_status()) only updates base_vi's security state, leaving the stre=
am
inode's cached label and EVM status stale.

Furthermore, in fs/attr.c, do_notify_change() skips security_inode_setattr()
when path is NULL, but still runs security_inode_post_setattr() at the end:

    if (path) {
        error =3D security_inode_setattr(idmap, dentry, attr);
        if (error)
            return error;
    }
    ...
    if (!error) {
        fsnotify_change(dentry, ia_valid);
        security_inode_post_setattr(idmap, dentry, ia_valid);
    }

Wouldn't calling __notify_change() on base_dentry bypass
selinux_inode_setattr(), smack_inode_setattr(), and evm_inode_setattr() on
base_dentry while still invoking evm_inode_post_setattr(), causing EVM to
write a new valid security.evm HMAC onto base_dentry without prior integrity
verification on base_dentry?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027121151.1887=
650-1-caixinchen1@huawei.com?part=3D1
