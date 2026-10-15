Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D497D51A726;
	Thu, 15 Oct 2026 12:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067798; cv=none; b=YB++eqXAVti23ULxQBw2qXWwLHr3KNt83TL17n1YzZi1d2s1z5smcZNBlRJGavDz20GzvwygzqOS8HDtrQG083ecEtXKlrVCvgt0ISuqDhjkrqUwUVKcjUuUjv/DZ0PmjM0B7Ut1amjqIdJqSnViXBHte6Fc2oe2s6AJLwQSvIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067798; c=relaxed/simple;
	bh=gKvpIiDDaeHADn7OQ3TMthVNsDakAlujpzzxJwfwhcI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=CuCDTAZeVDAIm10EdK5NcaYTKDw7MHNeMjn56GV3WwY7ZYstWMOwjy0lZIuNT8I6gWKLLGhtjCIoG/18wRNc4oKw+skPaKu7ev3Rox0sj78n4y2w/B7kzmejxo3zW5Y7QVT3U7pwPnuQV7h8l6M2A7m9iUHxgOEhhgUw9rnJSIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8KzP2MI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8KzP2MI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54EC11F000C4;
	Thu, 15 Oct 2026 12:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792067797;
	bh=MYcSYG1ibvu7FkI8K0YKju3o6DY9hk4s1acoywZx9CQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X8KzP2MIFE/KP/CJMZH2w8GClmSGLazMeh+7DvQxG1gFHoDxwZ3+zj56xjQJN5hTU
	 IIq90MgZqsmUUmTOHGrU+Wt+EMb8l4mDCvRRT4kK9XN/NqCdEF+/MhCMApdvEIEcgY
	 XB7DCpVzeONR0VA62gM0K6b49Mb7U+EO6/1Z+mM+SZ1qTwYxgJGIki9GcJCPdpkC9e
	 2jePsC2T2HmzCoG8R3bIL8M6CcHsyKAuehBy4qDKcCmaFpvkD/0ruh6j6eIvg02bMr
	 iBMgi2Xxc7TiKQNdEzO9A1aMkQkN/4PS0Hl1DNiRwTQneju/v+8mRDB1bly6yDzu6U
	 cXnpilHoHFj3w==
Message-ID: <sashiko-outbox-172813@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 -next 03/18] fs: pass struct path to xattr helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261015125425.3246251-4-caixinchen1@huawei.com>
References: <20261015125425.3246251-1-caixinchen1@huawei.com>
 <20261015125425.3246251-4-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 12:36:36 +0000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] ksmbd: Mismatched mount and dentry in ksmbd_vfs_fill_dentry_attrs(=
) causes incorrect ID mapping and kernel warnings
- [High] smb: UAF via lockless d_parent access in smb_inherit_dacl and dotd=
ot population
--

commit 9779da3303c8331c79c9d2b6c3b16ab94a463c50
Author: Cai Xinchen <caixinchen1@huawei.com>
Subject: fs: pass struct path to xattr helpers

This patch switches vfs_setxattr(), vfs_getxattr(), vfs_listxattr(), and
vfs_removexattr() to take a struct path instead of a struct dentry and
mnt_idmap. It updates various callers across the tree to pass the path
directly, reducing the need to manually derive the idmap and dentry from it.

> diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
> --- a/fs/smb/server/smb_common.c
> +++ b/fs/smb/server/smb_common.c
> @@ -493,7 +492,6 @@ int ksmbd_populate_dot_dotdot_entries(struct ksmbd_wo=
rk *work, int info_level,
> =20
>  			ksmbd_kstat.kstat =3D &kstat;
>  			rc =3D ksmbd_vfs_fill_dentry_attrs(work,
> -							 idmap,
>  							 dentry,
>  							 &ksmbd_kstat);

[Severity: High]
Can this sequence lead to a use-after-free on the parent directory?

In ksmbd_populate_dot_dotdot_entries(), the ".." entry is resolved lockless=
ly
via dir->filp->f_path.dentry->d_parent. This unpinned dentry is then passed=
=20
into ksmbd_vfs_fill_dentry_attrs().=20

Because this patch forces the helper to wrap the unpinned dentry into a new
struct path, if the parent is concurrently renamed and removed, passing it
into sleeping VFS helpers could access freed memory once the RCU grace peri=
od
expires.

[ ... ]

> diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
> --- a/fs/smb/server/smbacl.c
> +++ b/fs/smb/server/smbacl.c
> @@ -1199,8 +1199,8 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
>  	struct smb_acl *parent_pdacl;
>  	struct smb_ntsd *parent_pntsd =3D NULL;
>  	struct smb_sid owner_sid, group_sid;
> -	struct dentry *parent =3D path->dentry->d_parent;
> -	const struct mnt_idmap *idmap =3D mnt_idmap(path->mnt);
> +	struct path parent_path =3D { .mnt =3D path->mnt,
> +				    .dentry =3D path->dentry->d_parent };

[Severity: High]
Could this lockless d_parent access cause a use-after-free?

This code constructs a new struct path using path->dentry->d_parent without
acquiring a reference via dget_parent(). If the child dentry is concurrently
renamed and the old parent is removed, the unreferenced parent dentry could
be queued for RCU freeing.

Because this unpinned dentry is then passed to ksmbd_vfs_get_sd_xattr()
which can sleep, the RCU grace period might expire during use.

>  	int inherited_flags =3D 0, flags =3D 0, i, nt_size =3D 0, pdacl_size;
>  	int rc =3D 0, pntsd_type, ppntsd_size, acl_len, aces_size;
>  	unsigned int dacloffset;
> @@ -1209,8 +1209,8 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
>  	char *aces_base;
>  	bool is_dir =3D S_ISDIR(d_inode(path->dentry)->i_mode);
> =20
> -	ppntsd_size =3D ksmbd_vfs_get_sd_xattr(conn, idmap,
> -					    parent, &parent_pntsd);
> +	ppntsd_size =3D ksmbd_vfs_get_sd_xattr(conn, &parent_path,
> +					    &parent_pntsd);

[ ... ]

> diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
> --- a/fs/smb/server/vfs.c
> +++ b/fs/smb/server/vfs.c
> @@ -1913,7 +1896,7 @@ int ksmbd_vfs_fill_dentry_attrs(struct ksmbd_work *=
work,
>  				   KSMBD_SHARE_FLAG_STORE_DOS_ATTRS)) {
>  		struct xattr_dos_attrib da;
> =20
> -		rc =3D ksmbd_vfs_get_dos_attrib_xattr(idmap, dentry, &da);
> +		rc =3D ksmbd_vfs_get_dos_attrib_xattr(&path, &da);

[Severity: High]
Will this synthetic path construction cause VFS invariant warnings or
incorrect ID mapping?

The ksmbd_vfs_fill_dentry_attrs() helper internally constructs the path usi=
ng
the share root's mount (share_conf->vfs_path.mnt) and the caller-provided
dentry. If the dentry belongs to a nested mount within the share, the path
mount and dentry superblocks will mismatch.

When this mismatched path is passed down to vfs_getxattr(), mnt_idmap() will
extract the ID mapping of the share root instead of the nested submount,
causing incorrect permission checks. Underlying filesystems like OverlayFS
also enforce this invariant with a WARN_ON, which can panic systems.

Could we update the callers (like process_query_dir_entries) to pass down
their valid path instead of just the dentry?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015125425.3246=
251-1-caixinchen1@huawei.com?part=3D3
