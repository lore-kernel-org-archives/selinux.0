Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112573;
	b=m1ayz8rawkJyAWg/naysz9Q20uIXE6hGBdHaEr1JT5b4xf4LsvFl6E6kttvJn9lxFz/h
	 QL68JVgviAFK+Y8aQZi21d1Ui9uhb4j6skA4AnolJ7rtgWseqiCT7GPfqk7XUiMJs57KZ
	 1eL1VFsJsF8DlHkumihoaMquQ6kD8TRwNyyR3G7ttOdyxp0hpmj2XQs8JGbx2/vOdC7RN
	 UfUgYsksOS19AIZZQpdlgaB8D0URUY7+h/g/h70Az/EvL8LBbRTY/vOrH/oVs5gUat2ZS
	 IxEc4M72Aci/wgY19VpawEc66uX4UTrErJ9BkPKci7hO8Ytw2g0XuP9m1XBW5mWTApQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112573;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=W/8wkjuXUaxQBi9FIunmH+nQRSTuPQutF4GUQqiAULY=;
	b=zOi/rmxd2ASkCrNdhlQ3fK/iZhTbI9/DBzEaVgZs94BmTi6g98snBJupqGNkK+tknq8t
	 ENFBu9qgqsLQobWFr/eLSk2G40Vx4l2NKqn0hDrQXAZJQ87IgEVuT5qnSs2niJyAqBxGS
	 +0RZH50jzXo1x/W6PWcZrUQOToLmbKg5/R5Nla5fnb1etM7g44hKPaEDj/n/3SEQ3XLZ/
	 grjXyDTfsotFQ4teli4aC/t8oyCkurVjT/afMFaDgUAhV599yFS1S11MCreGa3Z8xa+RA
	 BFhXPcK7sO+syzJNohi5RJbbVWNH7zktJ+ZSpCFmQ9FAom/MV0mlyaWQND4pFHpZ9Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=isBBl2oc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE32606A31F;
	Tue, 27 Oct 2026 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=isBBl2oc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C971F01825;
	Tue, 27 Oct 2026 14:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793112572;
	bh=W/8wkjuXUaxQBi9FIunmH+nQRSTuPQutF4GUQqiAULY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=isBBl2ocQtsR/MEqdHJtQ8tQa0LNFzfmiVt0OjJwGMbYxxwtndz85UrxH4nmDf2++
	 ME2DMMMJrRyS0Cd+mPZvOrPfgi+pZiTjAMlOtR2pEo96sEXqmBX0lDUD2K78/xaq8R
	 KOmkWv2lvBeoiA0hcDAYJoBQ7tEncx1h7nbRhFhxP0DdB0BilmBFxMRypOu4w67mMx
	 IbevUCVeHA0dLBhqWUV5I/sRmgBnORw8mTe8s2nuLShDYK4qlyAISXu9l3h+kUDFqt
	 ZqGnj+FxawTg8cqXdA9U2pzLse4Fn7vnec5t6YB9dRvi6BoLAtfyPHvehXYWjvNPOA
	 lDTmBYAfJg+ow==
Message-ID: <sashiko-outbox-186764@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 -next 15/18] landlock: Add READ_METADATA and
 WRITE_METADATA access rights
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org, dsterba@suse.cz, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261027121151.1887650-16-caixinchen1@huawei.com>
References: <20261027121151.1887650-1-caixinchen1@huawei.com>
 <20261027121151.1887650-16-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 14:49:31 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] landlock: missing ATTR_KILL_PRIV check in hook_path_setattr()
- [Medium] landlock: hook_path_getattr() misses file check in io_statx() AT=
_EMPTY_PATH
- [Medium] landlock: unguarded second metadata hook check on ecryptfs lower=
_path
--

commit c5b94acf0094997d0231e58b264ebd0f262e2631
Author: Cai Xinchen <caixinchen1@huawei.com>

landlock: Add READ_METADATA and WRITE_METADATA access rights

This commit introduces the LANDLOCK_ACCESS_FS_READ_METADATA and
LANDLOCK_ACCESS_FS_WRITE_METADATA filesystem access rights to control
reading and modifying file and directory metadata through path and file
LSM hooks, bumping the Landlock ABI version to 13.

> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 2ab67bcad1983..73c6353ecbf85 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c

[ ... ]

> @@ -1676,6 +1678,192 @@ static int hook_path_truncate(const struct path *=
const path)
>  	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
>  }
> =20
> +static int check_access_file(const struct file *const file,
> +			     const access_mask_t access)
> +{

[ ... ]

> +}
> +
> +static int check_access_path_or_file(const struct path *const path,
> +				     const struct file *const file,
> +				     const access_mask_t access)
> +{
> +	if (file)
> +		return check_access_file(file, access);
> +
> +	return current_check_access_path(path, access);
> +}

[Severity: Medium]
How does check_access_path_or_file() interact with eCryptfs when forwarding
metadata operations to the lower filesystem?

Unlike overlayfs, eCryptfs forwards operations under current_cred(). While
ecryptfs_getattr(), ecryptfs_getxattr(), ecryptfs_listxattr(),
ecryptfs_removexattr(), ecryptfs_fileattr_get(), and ecryptfs_fileattr_set()
call unchecked VFS helpers so the LSM hooks run only once on the upper path,
four operations in fs/ecryptfs/inode.c call LSM-checked VFS helpers on
lower_path with file set to NULL:

fs/ecryptfs/inode.c:ecryptfs_setattr()
	notify_change(&nop_mnt_idmap, &lower_path, &lower_ia, NULL, NULL);

fs/ecryptfs/inode.c:ecryptfs_setxattr()
	__vfs_setxattr_locked(&nop_mnt_idmap, &lower_path, name, value,
			      size, flags, NULL, NULL);

fs/ecryptfs/inode.c:ecryptfs_get_acl()
	vfs_get_acl(idmap, &lower_path, posix_acl_xattr_name(type), NULL);

fs/ecryptfs/inode.c:ecryptfs_set_acl()
	vfs_set_acl(&nop_mnt_idmap, &lower_path,
		    posix_acl_xattr_name(type), acl, NULL);

When a sandboxed task invokes fchmod(), fchown(), futimens(), fsetxattr(),
or POSIX ACL operations on an eCryptfs file descriptor opened before
landlock_restrict_self(), the upper check succeeds via check_access_file(),
but the internal forward reaches hook_path_setattr(), hook_path_setxattr(),
hook_path_get_acl(), or hook_path_set_acl() with file =3D=3D NULL and evalu=
ates
current_check_access_path(&lower_path, access) against the current domain.
Path-based chmod(), chown(), utimensat(), setxattr(), and ACL operations
allowed by a Landlock rule on the upper eCryptfs mount point also fail with
-EACCES unless the current domain additionally grants metadata rights on
the underlying lower path.

> +
> +static int hook_path_getattr(const struct path *const path,
> +			     struct file *const file)
> +{
> +	return check_access_path_or_file(path, file,
> +					 LANDLOCK_ACCESS_FS_READ_METADATA);
> +}

[Severity: Medium]
When IORING_OP_STATX is submitted with AT_EMPTY_PATH and an empty pathname
string on an open file descriptor, will hook_path_getattr() check the
current task's domain instead of the file's open-time access rights?

For the statx() syscall, sys_statx() uses filename_maybe_null, which turns
an empty string with AT_EMPTY_PATH into name =3D=3D NULL and dispatches to
do_statx_fd() -> vfs_statx_fd(), passing the struct file to
vfs_statx_path() -> security_path_getattr().

In contrast, io_uring's io_statx_prep() calls delayed_getname_uflags() ->
do_getname() with LOOKUP_EMPTY, producing a non-NULL struct filename where
name->name[0] =3D=3D '\0', and io_statx() then calls do_statx() -> vfs_stat=
x():

io_uring/statx.c:io_statx()
	ret =3D do_statx(sx->dfd, name, sx->flags, sx->mask, sx->buffer);

fs/stat.c:vfs_statx()
	error =3D filename_lookup(dfd, filename, lookup_flags, &path, NULL);
	if (error)
		return error;
	error =3D vfs_statx_path(&path, flags, stat, request_mask, NULL);

Because file is passed as NULL to vfs_statx_path(), hook_path_getattr()
falls back to current_check_access_path() instead of check_access_file().
Wouldn't this allow a file descriptor opened without
LANDLOCK_ACCESS_FS_READ_METADATA to leak metadata when passed to an
unrestricted process that uses IORING_OP_STATX with AT_EMPTY_PATH, while
rejecting IORING_OP_STATX with AT_EMPTY_PATH in a sandboxed process using
a file descriptor opened before sandboxing?

> +
> +static int hook_path_file_getattr(const struct path *const path,
> +				  struct file_kattr *const fa,
> +				  struct file *const file)
> +{
> +	return check_access_path_or_file(path, file,
> +					 LANDLOCK_ACCESS_FS_READ_METADATA);
> +}
> +
> +static int hook_path_setattr(const struct mnt_idmap *const idmap,
> +			     const struct path *const path,
> +			     struct iattr *const attr,
> +			     struct file *const file)
> +{
> +	unsigned int ia_valid =3D attr->ia_valid;
> +
> +	/*
> +	 * Only explicit metadata changes are checked: implicit
> +	 * timestamp updates never go through notify_change(), and size
> +	 * changes (ATTR_SIZE) are governed by the truncate hooks
> +	 * instead.  See the "File metadata" section in the user space
> +	 * documentation for the full semantics.
> +	 *
> +	 * The setuid/setgid bit clearing that the kernel performs
> +	 * after write(2) or truncate(2) is an implicit change as
> +	 * well: it comes through __remove_privs() and do_truncate()
> +	 * with ATTR_FORCE set, and do_notify_change() then adds a
> +	 * synthesized ATTR_MODE (with these bits removed) before
> +	 * calling this hook.  As do_notify_change() makes it a bug for
> +	 * callers to pass ATTR_MODE together with a kill flag, an
> +	 * ATTR_MODE seen along with ATTR_FORCE is always
> +	 * kernel-synthesized and must not be checked.  An explicit
> +	 * chown(2) does not set ATTR_FORCE, so the same clearing
> +	 * requested through chown(2), including chown(2) with
> +	 * (-1, -1) on a privileged file, is still checked through the
> +	 * synthesized ATTR_MODE, matching the SELinux behavior.  A
> +	 * chown(2) that changes nothing (e.g. with (-1, -1) on a file
> +	 * without privilege bits) sets neither a changed attribute
> +	 * nor a synthesized ATTR_MODE, and is not checked.
> +	 */
> +	if (ia_valid & ATTR_FORCE)
> +		ia_valid &=3D ~(ATTR_KILL_SUID | ATTR_KILL_SGID | ATTR_MODE);
> +
> +	if (!(ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID |
> +			  ATTR_TIMES_SET | ATTR_TOUCH)))
> +		return 0;
> +
> +	return check_access_path_or_file(path, file,
> +					 LANDLOCK_ACCESS_FS_WRITE_METADATA);
> +}

[Severity: Medium]
What happens in hook_path_setattr() when chown(path, -1, -1) or
fchown(fd, -1, -1) is called on a file that has file capabilities
(security.capability) but neither S_ISUID nor S_ISGID set?

In chown_common(), when user =3D=3D -1 and group =3D=3D -1 on a non-directo=
ry,
newattrs.ia_valid is set to ATTR_CTIME | ATTR_KILL_SUID | ATTR_KILL_PRIV
(plus potentially ATTR_KILL_SGID) without ATTR_UID, ATTR_GID, or ATTR_FORCE:

fs/open.c:chown_common()
	if (!S_ISDIR(inode->i_mode))
		newattrs.ia_valid |=3D ATTR_KILL_SUID | ATTR_KILL_PRIV |
				     setattr_should_drop_sgid(idmap, inode);

In do_notify_change(), security_inode_need_killpriv() returns 1 when
security.capability is present, so ATTR_KILL_PRIV remains set in
attr->ia_valid, while ATTR_MODE is not synthesized because S_ISUID and
S_ISGID are not set:

fs/attr.c:do_notify_change()
	if (ia_valid & ATTR_KILL_PRIV) {
		error =3D security_inode_need_killpriv(dentry);
		if (error < 0)
			return error;
		if (error =3D=3D 0)
			ia_valid =3D attr->ia_valid &=3D ~ATTR_KILL_PRIV;
	}

When do_notify_change() then calls security_path_setattr() ->
hook_path_setattr(), ia_valid only contains ATTR_CTIME | ATTR_KILL_PRIV,
so hook_path_setattr() returns 0 without checking
LANDLOCK_ACCESS_FS_WRITE_METADATA. Execution then proceeds to
setattr_prepare(), which strips the security.capability xattr via
security_inode_killpriv() -> cap_inode_killpriv() -> __vfs_removexattr()
and updates inode ctime.

Should hook_path_setattr() also clear ATTR_KILL_PRIV when ATTR_FORCE is
set (for implicit capability removal during write() or truncate()) and
include ATTR_KILL_PRIV in the checked ia_valid mask alongside ATTR_MODE,
ATTR_UID, ATTR_GID, ATTR_TIMES_SET, and ATTR_TOUCH?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027121151.1887=
650-1-caixinchen1@huawei.com?part=3D15
