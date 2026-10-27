Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793105333;
	b=WzA/+gleUIUBaDnQM/JB/VQmEhKRo1lgng8NE8d3zA8kK4r+NbA2cEd+k/45uq+cLOoh
	 8MjMEXe6QgqrddeDfBCQdKb0pe8BR52cHlpXd4WHb7ZhAcLFNDSdNmJtc/95/RHT3/Den
	 EOFbEYtzd0r5irlp0xMwFS4OEYNeKaqS+KekehEEPkYxUTpzmInjJa8whKTXBzJ/CxV+E
	 CObN6mYvYqrr2AfitCONLKMSXDUIq2EGrRnycGXRbPNOhFOkn4t0FRZuuzeyfv+bPDsQZ
	 oV0DOp9Lp6ieV8JbdCSgp0FTpT4wxKo0IsQ+3XHuVOEGnsJAgptp4bAin2FKJJgbJyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105333;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8bvY4zpWy0LbpfZP1wRlrsQsbNLar5dcO6RtuiNDUYM=;
	b=nuGcvkjJHUW3Juzy5mJXhiiio2b7RQzvnkLj6ZIM6ri58xbtBlC7nmaGMfbSfy5ho++A
	 +WuHNJSfpseRyF/ild9YX/togT9fhRRblZc55SyUiGDX9kac8IdJ4Mrhr0RTcYLYbUoqs
	 Mg09JwsvXS8AenqhumWIG4/A77KvpzBCmhHCdCMJEiB3zCosf5Z5je9aF7gDzkgq7Df5l
	 zo5IOElzK/bonFMMVR2wUD4sWH/4ovhpLCOyXbUebfmspR9O1czsVjE2CNtLOqiWB2PwC
	 g79dJn2agsaXqTq7L1WC74zqMb4PG5mP8cAFfosIraOgsjtWCBM/cosyztK87TKOduw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cYZC6dVy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992DE606A31A;
	Tue, 27 Oct 2026 12:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cYZC6dVy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99B21F01825;
	Tue, 27 Oct 2026 12:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793105332;
	bh=8bvY4zpWy0LbpfZP1wRlrsQsbNLar5dcO6RtuiNDUYM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cYZC6dVy7hODflVuc+CTPIGJNXkfRtzd3tO0VmGb0XmBdeRXc5ldKxIWtlaj6mrgh
	 HxVva+lQpjc4Vvp/SckYU1DaNqKmfQvFB+GKyf+DlbkdcbxYDsdS77ly8/I3RrTfqV
	 Uz2z79kmFj0Gr7EynR1erMxVzj6+t3YOZtDPSC7I2ckTSF66ShDEG4PM3egUixrfx7
	 NcuRaT8QHezAV+Cp7Do8Mq67vNI6EEpxUJgz+hB1rW4VtKtbjeLsq51JjvkPqqp79w
	 TA8hN5Ihe3kNYg89X9vJ5FXrJeXI3jNUCCrg1xOga2UeOYX5YsrreBU6sqp/SP6B10
	 PcxEXl9Hxgpvg==
Message-ID: <sashiko-outbox-186584@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 -next 05/18] LSM: pass struct path and struct file to
 the inode_setattr hook
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org, dsterba@suse.cz, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261027121151.1887650-6-caixinchen1@huawei.com>
References: <20261027121151.1887650-1-caixinchen1@huawei.com>
 <20261027121151.1887650-6-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 12:48:51 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] vfs: do_fchmodat(), do_fchownat(), and do_utimes_path() reject O_P=
ATH fds
- [High] lsm: missing __nullable on file parameter of inode_setattr hook
- [High] fs: AT_EMPTY_PATH regressions in do_utimes_path(), do_fchmodat(), =
and do_fchownat()
- [Medium] lsm: untrusted path->dentry breaks bpf_lsm_inode_setattr() dentr=
y kfuncs
--

commit 5205e882fa7eb32587d3ca77d8a0f86441ec4e69
Author: Cai Xinchen <caixinchen1@huawei.com>

LSM: pass struct path and struct file to the inode_setattr hook

This commit updates the inode_setattr LSM hook and its callers to pass a
struct path and an optional struct file alongside the mnt_idmap. It also
dispatches AT_EMPTY_PATH operations in do_fchmodat(), do_fchownat(), and
do_utimes_path() to the file descriptor-based helpers so the struct file can
be threaded through notify_change().

> diff --git a/fs/open.c b/fs/open.c
> index 294d0ea7488e6..882985d4008bf 100644
> --- a/fs/open.c
> +++ b/fs/open.c
[ ... ]
> @@ -724,12 +729,22 @@ static int do_fchmodat(int dfd, const char __user *=
filename, umode_t mode,
>  	if (unlikely(flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)))
>  		return -EINVAL;
> =20
> +	CLASS(filename_maybe_null, name)(filename, flags);
> +
> +	if (!name && dfd >=3D 0) {
> +		CLASS(fd, f)(dfd);
> +
> +		if (fd_empty(f))
> +			return -EBADF;
> +
> +		return vfs_fchmod(fd_file(f), mode);
> +	}
[ ... ]
> @@ -844,14 +860,24 @@ int do_fchownat(int dfd, const char __user *filenam=
e, uid_t user, gid_t group,
>  	if ((flag & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) !=3D 0)
>  		return -EINVAL;
> =20
> +	CLASS(filename_maybe_null, name)(filename, flag);
> +
> +	if (!name && dfd >=3D 0) {
> +		CLASS(fd, f)(dfd);
> +
> +		if (fd_empty(f))
> +			return -EBADF;
> +
> +		return vfs_fchown(fd_file(f), user, group);
> +	}

[Severity: High]
Does using CLASS(fd, f)(dfd) here and in do_fchmodat() and do_utimes_path()
break AT_EMPTY_PATH on O_PATH file descriptors?

Previously, an empty path with AT_EMPTY_PATH went through
filename_lookup() -> path_lookupat() -> path_init(), which looks up nd->dfd
using CLASS(fd_raw, f)(nd->dfd) (just as vfs_fstat() does for vfs_fstatat()=
):

fs/namei.c:path_init() {
	...
		CLASS(fd_raw, f)(nd->dfd);
		struct dentry *dentry;

		if (fd_empty(f))
			return ERR_PTR(-EBADF);
	...
}

Supporting O_PATH file descriptors without /proc/self/fd was the reason
AT_EMPTY_PATH was added to fchmodat2(2) in commit 5daeb41a6fc9 ("fchmodat2:
add support for AT_EMPTY_PATH"), and is documented UAPI for fchownat(2) and
utimensat(2), since fchmod(2), fchown(2), and futimens(3) reject O_PATH
descriptors with EBADF.

By switching to CLASS(fd, f)(dfd), which calls fdget(dfd) ->
__fget_light(dfd, FMODE_PATH), fd_empty(f) is true whenever FMODE_PATH is
set, causing fchmodat2(dfd, "", mode, AT_EMPTY_PATH),
fchownat(dfd, "", user, group, AT_EMPTY_PATH), and
utimensat(dfd, "", times, AT_EMPTY_PATH) on an O_PATH fd to fail with -EBAD=
F.

In addition, in do_dentry_open(), O_PATH files return before
security_file_open() is called:

fs/open.c:do_dentry_open() {
	...
	if (unlikely(f->f_flags & O_PATH)) {
		f->f_mode =3D FMODE_PATH | FMODE_OPENED;
		file_set_fsnotify_mode(f, FMODE_NONOTIFY);
		f->f_op =3D &empty_fops;
		return 0;
	}
	...
}

Because an O_PATH struct file was never authorized at open(2) time, should
these callers use CLASS(fd_raw, f)(dfd) and ensure that LSMs checking the
struct file in security_inode_setattr() do not treat an FMODE_PATH file as
carrying open-time permissions?

> diff --git a/fs/utimes.c b/fs/utimes.c
> index 5193d504d289f..6021c481e742f 100644
> --- a/fs/utimes.c
> +++ b/fs/utimes.c
[ ... ]
> @@ -88,15 +89,25 @@ static int do_utimes_path(int dfd, const char __user =
*filename,
>  	if (flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH))
>  		return -EINVAL;
> =20
> +	CLASS(filename_maybe_null, name)(filename, flags);
> +
> +	if (!name && dfd >=3D 0) {
> +		CLASS(fd, f)(dfd);
> +
> +		if (fd_empty(f))
> +			return -EBADF;
> +
> +		return vfs_utimes(&fd_file(f)->f_path, times, fd_file(f));
> +	}

[Severity: High]
Beyond the CLASS(fd, f)(dfd) issue with O_PATH file descriptors (which also
makes the FMODE_PATH check for hook_path_setattr in commit "landlock: Add
READ_METADATA and WRITE_METADATA access rights" unreachable), can switching
do_utimes_path() from CLASS(filename_uflags, name) to
CLASS(filename_maybe_null, name) cause utimensat(AT_FDCWD, NULL, times,
AT_EMPTY_PATH) to modify the current working directory instead of returning
-EFAULT?

In do_utimes(), a NULL filename with dfd !=3D AT_FDCWD is routed to
do_utimes_fd() (which rejects non-zero flags like AT_EMPTY_PATH with -EINVA=
L),
whereas dfd =3D=3D AT_FDCWD is routed to do_utimes_path():

fs/utimes.c:do_utimes() {
	if (filename =3D=3D NULL && dfd !=3D AT_FDCWD)
		return do_utimes_fd(dfd, times, flags);
	return do_utimes_path(dfd, filename, times, flags);
}

When filename =3D=3D NULL, dfd =3D=3D AT_FDCWD, and flags =3D=3D AT_EMPTY_P=
ATH,
CLASS(filename_uflags, name) previously returned ERR_PTR(-EFAULT). With
CLASS(filename_maybe_null, name), name is NULL, the (!name && dfd >=3D 0) c=
heck
is skipped because AT_FDCWD < 0, and filename_lookup(AT_FDCWD, NULL, ...)
treats NULL as an empty path and updates the current working directory.

Also, when (!name && dfd >=3D 0) is taken in do_utimes_path(), it bypasses
filename_lookup() (which called audit_inode()) and calls vfs_utimes(). Unli=
ke
vfs_fchmod() and vfs_fchown(), vfs_utimes() does not call audit_file().
Should audit_file(fd_file(f)) be called before vfs_utimes() on the fd paths?

> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 539525648b303..ea6e0fbaa3b9c 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -141,8 +141,16 @@ LSM_HOOK(int, 0, inode_follow_link, struct dentry *d=
entry, struct inode *inode,
>  	 bool rcu)
>  LSM_HOOK(int, 0, inode_permission, const struct mnt_idmap *idmap,
>  	 struct inode *inode, int mask)
> -LSM_HOOK(int, 0, inode_setattr, const struct mnt_idmap *idmap, struct de=
ntry *dentry,
> -	 struct iattr *attr)
> +/*
> + * For the hooks that pass a struct path: the VFS only sanctions
> + * passing the path to VFS helpers taking a struct path (e.g.,
> + * notify_change(), the *xattr() helpers); it makes no guarantees
> + * with regard to path->mnt, whose layout and implementation details
> + * are subject to change.  Implementations must not rely on its
> + * properties.
> + */
> +LSM_HOOK(int, 0, inode_setattr, const struct mnt_idmap *idmap,
> +	 const struct path *path, struct iattr *attr, struct file *file)

[Severity: High]
Could omitting a __nullable annotation on the struct file *file parameter of
inode_setattr allow a BPF LSM program to trigger a kernel NULL pointer
dereference when notify_change() is called with file =3D=3D NULL?

All path-based and internal callers of notify_change() (such as
chmod_common(), chown_common(), vfs_utimes(), do_truncate(), and
__remove_privs()) pass file =3D=3D NULL, which do_notify_change() forwards =
to
security_inode_setattr(idmap, path, attr, NULL).

In btf_ctx_access(), arguments of trusted BPF LSM hooks are marked
PTR_TO_BTF_ID | PTR_TRUSTED, and PTR_MAYBE_NULL is only added if the parame=
ter
name ends with __nullable:

kernel/bpf/btf.c:btf_ctx_access() {
	...
	info->reg_type =3D PTR_TO_BTF_ID;
	if (prog_args_trusted(prog))
		info->reg_type |=3D PTR_TRUSTED;

	if (btf_param_match_suffix(btf, &args[arg], "__nullable"))
		info->reg_type |=3D PTR_MAYBE_NULL;
	...
}

Without __nullable (either in lsm_hook_defs.h or via a strong override in
kernel/bpf/bpf_lsm_proto.c like bpf_lsm_mmap_file()), the BPF verifier trea=
ts
file as a non-NULL trusted pointer and permits passing it without a NULL
check to kfuncs such as bpf_get_file_xattr() or bpf_real_data_inode(), which
immediately dereference file->f_path.dentry.

[Severity: Medium]
Does replacing struct dentry *dentry with const struct path *path in
inode_setattr also break sleepable BPF LSM programs that pass the dentry to
bpf_get_dentry_xattr(), bpf_set_dentry_xattr(), or bpf_remove_dentry_xattr(=
)?

bpf_lsm_inode_setattr is listed in d_inode_locked_hooks in
fs/bpf_fs_kfuncs.c specifically so sleepable BPF LSM programs attached to
inode_setattr can call those dentry xattr kfuncs:

fs/bpf_fs_kfuncs.c {
	BTF_SET_START(d_inode_locked_hooks)
	...
	BTF_ID(func, bpf_lsm_inode_setattr)
	...
	BTF_SET_END(d_inode_locked_hooks)
}

However, struct path is not listed in BTF_TYPE_SAFE_TRUSTED in
type_is_trusted() in kernel/bpf/verifier.c. When a BPF program walks
path->dentry, check_ptr_to_btf_access() marks the resulting dentry pointer =
as
PTR_UNTRUSTED, causing the BPF verifier to reject calls to the dentry xattr
kfuncs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027121151.1887=
650-1-caixinchen1@huawei.com?part=3D5
