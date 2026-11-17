Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794930545;
	b=xY0Mjlw2AnI/aTiTORhKGRu0IhKYmdLETfnBft977l/F8ghivtByCLJAGto6LqIT+z/e
	 IYlpF9R9vxCIYlY9I4gYlb3bBHbMXltEDZznKHqZugKxZMR+lJ/79Z8s9250I/7rVTUnJ
	 AuuArRnrPfXtBVxHXLMTVukXS3kKkcEHNaetJNPKvUfuC+IQcSFjc/qA6n0zm0Dos4gkV
	 pybNsoXBi0IY2eGFNSnaNmIXK+VZUcs3svuSmyp2Bp/WhFHGT7HaRwBxKfoNMqPoAY3nF
	 AQixQjRMC31xDrRdQ7cKRr+nxnIKHQfe4+RFNXihdO53IuXjhG1935mx5enBwc0S8kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794930545;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4DJPkMczLaDQ70H15IFg1AlU5VteqCjp1AFarhCcIsI=;
	b=cZ2LEN2dOKJwX5n11pR8M6k9WJ0EjvLyH29nczKVz5KwkH9CdQVoMB00Eu5RbCsHnZFF
	 roM0gDJlUKl0EgPP9yCHWHRm1n348SBqkbpkuLmMpivmkHmuUwuMZ70+JTJU+Ejc6MVHU
	 r5vCo9xg8HZPWF9cQdBTgSPUFdv3f7uRkR3Q+QQUqIa278f9+ApgKqZwrrM7H61b7ecrv
	 Kse75ZRsyFh5Bk5l/EVt2jvJYWL9BsTUkxeT3lIla7RfT4+t0XyUSjdX6UG6iL2mipOAD
	 4PVUwkhZ2IsQHkkUzHR6jc/58Xg/KUP7Vpqm3s54NiwJqgg/KKactOLYIEPP6I2aoqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iH5Hcv5y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30740606A31C;
	Tue, 17 Nov 2026 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iH5Hcv5y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD411F000C6;
	Tue, 17 Nov 2026 15:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794930544;
	bh=4DJPkMczLaDQ70H15IFg1AlU5VteqCjp1AFarhCcIsI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iH5Hcv5y4mYAIi8SBXdqHq984QFBp4gSp0WabnNEFbyqTOJoa7OAijSfocOEp5lTH
	 srIt2Muir6hkAQBXsB35xRXR1hotY3C6Dw/As4pyyM5KXky9Y7DabLtnZ+2HCSb+c2
	 XMSDYMggJmxCUWZ36tMV0J4gLZjYYcnqU38EGclE51FE9xu7YKMfwT1odKWs6+fq7U
	 oMP2s3ZktzFzrFrUymiM/o/O5y9mumtmKRKuXDo3fCK13KSd0oP+suHVxzvXK/KUOJ
	 OcmwEm8RzqjdnvmJVLRLQ96/FsaCrqkGiF4oB5zrfgPPBi3frC4kLjJHVSJZy1tjcE
	 nQ/mWkRunJteA==
Message-ID: <sashiko-outbox-219110@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next -v4 14/17] landlock: Add READ_METADATA and
 WRITE_METADATA access rights
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org, dsterba@suse.cz, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261117150542.1169451-15-caixinchen1@huawei.com>
References: <20261117150542.1169451-1-caixinchen1@huawei.com>
 <20261117150542.1169451-15-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 15:49:03 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] landlock: open-fd setattr denied on NTFS streams in
  hook_path_setattr()
- [Medium] fs/stat: duplicate and broken audit_names entries in
  vfs_statx_fd()
- [Medium] selftests/landlock: audit_layout1 tests broken by
  READ_METADATA in ACCESS_FILE
--

commit 14db7d890cf459274a57d8c4bb2e8249b1cd4223
Author: Cai Xinchen <caixinchen1@huawei.com>

landlock: Add READ_METADATA and WRITE_METADATA access rights

This commit introduces the LANDLOCK_ACCESS_FS_READ_METADATA and
LANDLOCK_ACCESS_FS_WRITE_METADATA access rights and hooks the corresponding
VFS metadata paths to enforce them on paths and opened files.

> diff --git a/fs/stat.c b/fs/stat.c
> index e68dc17f23c46..a1a5bd83b5079 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -19,6 +19,7 @@
>  #include <linux/pagemap.h>
>  #include <linux/compat.h>
>  #include <linux/iversion.h>
> +#include <linux/audit.h>
> =20
>  #include <linux/uaccess.h>
>  #include <asm/unistd.h>
> @@ -361,6 +362,7 @@ static int vfs_statx_fd(int fd, int flags, struct kst=
at *stat,
>  	CLASS(fd_raw, f)(fd);
>  	if (fd_empty(f))
>  		return -EBADF;
> +	audit_file(fd_file(f));
>  	return vfs_statx_path(&fd_file(f)->f_path, flags, stat, request_mask,
>  			      fd_file(f));
>  }
> @@ -391,6 +393,18 @@ static int vfs_statx(int dfd, struct filename *filen=
ame, int flags,
>  		      AT_STATX_SYNC_TYPE))
>  		return -EINVAL;
> =20
> +	/*
> +	 * An empty pathname with AT_EMPTY_PATH refers to the file descriptor
> +	 * itself.  Resolve it as such so that the struct file is passed down
> +	 * to the LSM hooks, like sys_statx() does for a NULL pathname and
> +	 * unlike a plain path lookup from the file descriptor.  This branch
> +	 * replaces a path lookup, so vfs_statx_fd() keeps auditing the file
> +	 * descriptor as that lookup would have.
> +	 */
> +	if ((flags & AT_EMPTY_PATH) && dfd >=3D 0 && !IS_ERR_OR_NULL(filename) =
&&
> +	    !filename->name[0])
> +		return vfs_statx_fd(dfd, flags, stat, request_mask);

[Severity: Medium]
Does dropping filename when redirecting to vfs_statx_fd() produce duplicate
and incomplete AUDIT_PATH records for IORING_OP_STATX with AT_EMPTY_PATH and
an empty string?

io_statx_prep() and io_statx() allocate filename via delayed_getname_uflags=
()
and complete_getname(), which calls audit_getname() and attaches an
unpopulated audit_names entry (filename->aname) to the audit context.
Previously, filename_lookup() called audit_inode(filename, path.dentry, 0) =
to
populate filename->aname in place.  With this change, vfs_statx_fd() calls
audit_file() instead, which passes name =3D NULL to __audit_inode():

kernel/auditsc.c:__audit_inode() {
    ...
	if (!name)
		goto out_alloc;

	/*
	 * If we have a pointer to an audit_names entry already, then we can
	 * just use it directly if the type is correct.
	 */
	n =3D name->aname;
    ...
}

Because name is NULL, __audit_inode() allocates a second audit_names entry
with name=3D(null) and nametype=3DNORMAL while leaving filename->aname
unpopulated with nametype=3DUNKNOWN.

> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 2ab67bcad1983..7d0e539b4cda7 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
[ ... ]
> +static int hook_path_setattr(const struct mnt_idmap *const idmap,
> +			     const struct path *const path,
> +			     struct dentry *const dentry,
> +			     struct iattr *const attr,
> +			     struct file *const file)
> +{
> +	unsigned int ia_valid =3D attr->ia_valid;
> +
[ ... ]
> +	if (ia_valid & ATTR_FORCE)
> +		ia_valid &=3D ~(ATTR_KILL_SUID | ATTR_KILL_SGID |
> +			      ATTR_KILL_PRIV | ATTR_MODE);
> +
> +	if (!(ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID |
> +			  ATTR_TIMES_SET | ATTR_TOUCH | ATTR_KILL_PRIV)))
> +		return 0;
> +
> +	return check_access_path_or_file(path, file,
> +					 LANDLOCK_ACCESS_FS_WRITE_METADATA);
> +}

[Severity: Medium]
Can hook_path_setattr() reject fchmod(), fchown(), or futimens() on an
already-opened NTFS named stream file descriptor with -EACCES when the
calling thread's current domain denies LANDLOCK_ACCESS_FS_WRITE_METADATA?

When notify_change() is called with a non-NULL file, the outer
do_notify_change() call authorizes the operation against
landlock_file(file)->allowed_access, stores only path in attr->ia_path, and
invokes inode->i_op->setattr().  On NTFS named streams,
ntfs_stream_setattr_common() then propagates shared attribute changes to the
base inode without a file pointer:

fs/ntfs/named_stream.c:ntfs_stream_setattr_common() {
    ...
			err =3D notify_change_target(idmap, attr->ia_path,
						   base_dentry, &base_attr,
						   NULL, NULL);
    ...
}

That second do_notify_change() call invokes hook_path_setattr() with
path =3D attr->ia_path, dentry =3D base_dentry, and file =3D NULL, causing
check_access_path_or_file() to check attr->ia_path against current_cred()
instead of the open file's credentials and emit a false audit denial.

> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/s=
elftests/landlock/fs_test.c
> index 48c1f896dc9a0..2593db7ef25c1 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -571,11 +571,13 @@ TEST_F_FORK(layout1, inval)
>  	LANDLOCK_ACCESS_FS_EXECUTE | \
>  	LANDLOCK_ACCESS_FS_WRITE_FILE | \
>  	LANDLOCK_ACCESS_FS_READ_FILE | \
> +	LANDLOCK_ACCESS_FS_READ_METADATA | \
> +	LANDLOCK_ACCESS_FS_WRITE_METADATA | \
>  	LANDLOCK_ACCESS_FS_TRUNCATE | \
>  	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
>  	LANDLOCK_ACCESS_FS_RESOLVE_UNIX)

[Severity: Medium]
Does adding LANDLOCK_ACCESS_FS_READ_METADATA to ACCESS_FILE (and therefore
ACCESS_ALL) break the audit_layout1 tests in fs_test.c?

Tests in audit_layout1 such as execute_read, write_file, and read_file call
enforce_fs(_metadata, ACCESS_ALL, NULL) with no allow rules, and then call
matches_log_fs() or matches_log_fs_extra() from the same sandboxed process:

tools/testing/selftests/landlock/fs_test.c:matches_log_fs_extra() {
    ...
	absolute_path =3D realpath(path, NULL);
	if (!absolute_path)
		return -errno;
    ...
}

Because LANDLOCK_ACCESS_FS_READ_METADATA is now denied by ACCESS_ALL, the
stat calls inside realpath() fail with EACCES and generate unexpected
fs.read_metadata audit records, causing those 18 audit_layout1 tests to fai=
l.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117150542.1169=
451-1-caixinchen1@huawei.com?part=3D14
