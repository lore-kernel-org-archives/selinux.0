Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A1A37F732;
	Sat, 27 Jun 2026 04:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782533499; cv=none; b=QjcD9bDnPaqoql6xRTKERoLyz6L0WrPjChSGGjBRl88Ff7oBqDZziGiyF3A1/z6Gve4sfhYkxqk41TcJXSfRpLh+qxkG8M0VkDlKYzrK93V8fvf7sEP9aM7Xf6/z6ggRIe4cUjdi8sGknRd8yMUL8l473dp9zS0iatQ4Bb7y/vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782533499; c=relaxed/simple;
	bh=Keir75L4IfYJon1YbHqCosGWteKxoKi2xUwJW0xuCoc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kp0qkR6RYc2axYFeqUPe4mky4/6cVm+roUpUj5PQU24HR4Kg6Gx3QiR7OcC7ef5TlLuLOP9rzUGhaExmabSA4T64uM7V/MYVRGIopd6L72SSYZTFCTXKghqqnlsIG5tzKkjZ9vcbqqiJJdl24+h/29k28cEaNufy/RPFI/zqTF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+anXnBm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+anXnBm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58EA1F000E9;
	Sat, 27 Jun 2026 04:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782533497;
	bh=mFlh2FBRnToL/LnFid1WPnFsqJ4xwa5Ybq/v70E/yNE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X+anXnBmPueiJVEhBIUDql9dw1ML9Q0NvgOlpZZnuS/HY6J7Q9F0LUyX68eQ3JL4A
	 +oqnJMbfgCCUsLYJhd1aoJkkKV9RzKwBIO6soOlcI7Ol2wy07T11Tto6Xg4FVEQgjC
	 Tc36VPA/+gsqqI1/pYmnT1+JqVVMPmze4uKiMp4axXSt4zlpIeLvyS2c4ZbvkTIsAe
	 JCZmAh7eoBUNRWw6mxxMO3Pg8ThUuPD5W6QKCxaq+v30umZox1wsHOizofvwdCovvU
	 pusdCiUoN5QvPJ/SlKBU2eirNPLUfRZJGndFwXjQh6ydzFjHLK3bUFiRGw0+Nax1Wo
	 PZCQVHIaklP7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 stable/linux-6.12.y 1/2] lsm: add backing_file LSM
 hooks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20260627042835.1492435-2-caixinchen1@huawei.com>
References: <20260627042835.1492435-1-caixinchen1@huawei.com>
 <20260627042835.1492435-2-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 04:11:37 +0000
Message-Id: <20260627041137.A58EA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The replacement of `file_user_path()` with direct access to `user_=
file->f_path` breaks the propagation of the outermost user path in stacked =
overlayfs setups, leading to an information leak.
- [Medium] Error path in `alloc_empty_backing_file()` causes `security_back=
ing_file_free()` to be invoked twice or improperly, leading to double-free =
or NULL pointer dereference in LSM modules.
--

commit 6e1e1e772cca04db297cfab245de902e298ac493
Author: Paul Moore <paul@paul-moore.com>

lsm: add backing_file LSM hooks

Stacked filesystems such as overlayfs do not currently provide the
necessary mechanisms for LSMs to properly enforce access controls on the
mmap() and mprotect() operations. In order to resolve this gap, a LSM
security blob is being added to the backing_file struct.

Cc: stable@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-unionfs@vger.kernel.org
Cc: linux-erofs@lists.ozlabs.org

> diff --git a/fs/backing-file.c b/fs/backing-file.c
> index 09a9be945d45e..389cfe3ed509d 100644
> --- a/fs/backing-file.c
> +++ b/fs/backing-file.c
> @@ -29,14 +30,15 @@
>   * returned file into a container structure that also stores the stacked
>   * file's path, which can be retrieved using backing_file_user_path().
>   */
> -struct file *backing_file_open(const struct path *user_path, int flags,
> +struct file *backing_file_open(const struct file *user_file, int flags,
>  			       const struct path *real_path,
>  			       const struct cred *cred)
>  {
> +	const struct path *user_path =3D &user_file->f_path;

[Severity: High]
Does this break the propagation of the outermost user path in stacked
overlayfs setups?

By unconditionally using direct access to user_file->f_path, it appears that
intermediate mount paths (such as overlayfs lower/upper directories) might =
be
exposed to user space through /proc/<pid>/maps, bypassing overlayfs path
hiding.

>  	struct file *f;
>  	int error;
> =20
> -	f =3D alloc_empty_backing_file(flags, cred);
> +	f =3D alloc_empty_backing_file(flags, cred, user_file);

[ ... ]

> @@ -52,15 +54,16 @@ struct file *backing_file_open(const struct path *use=
r_path, int flags,
>  }
>  EXPORT_SYMBOL_GPL(backing_file_open);
> =20
> -struct file *backing_tmpfile_open(const struct path *user_path, int flag=
s,
> +struct file *backing_tmpfile_open(const struct file *user_file, int flag=
s,
>  				  const struct path *real_parentpath,
>  				  umode_t mode, const struct cred *cred)
>  {
>  	struct mnt_idmap *real_idmap =3D mnt_idmap(real_parentpath->mnt);
> +	const struct path *user_path =3D &user_file->f_path;

[Severity: High]
Could this similarly break path propagation for temporary files?

>  	struct file *f;
>  	int error;
> =20
> -	f =3D alloc_empty_backing_file(flags, cred);
> +	f =3D alloc_empty_backing_file(flags, cred, user_file);

[ ... ]

> diff --git a/fs/file_table.c b/fs/file_table.c
> index 2a08bc93b0b9c..a771be30eb43d 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c

[ ... ]

> @@ -289,7 +308,7 @@ struct file *alloc_empty_backing_file(int flags, cons=
t struct cred *cred)
> =20
>  	/* The f_mode flags must be set before fput(). */
>  	ff->file.f_mode |=3D FMODE_BACKING | FMODE_NOACCOUNT;
> -	error =3D init_backing_file(ff);
> +	error =3D init_backing_file(ff, user_file);
>  	if (unlikely(error)) {
>  		fput(&ff->file);

[Severity: Medium]
Will calling fput() here lead to a double-free or NULL pointer dereference
in the LSM module?

When init_backing_file() fails due to security_backing_file_alloc()
returning an error, the LSM hook already cleans up its own state:

security/security.c:security_backing_file_alloc() {
	rc =3D call_int_hook(backing_file_alloc, backing_file, user_file);
	if (unlikely(rc))
		security_backing_file_free(backing_file);
...

However, because FMODE_BACKING is already set before init_backing_file() is
called, the subsequent fput() triggers the destruction path via file_free()
which eventually calls backing_file_free() and executes
security_backing_file_free() a second time on the same file.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627042835.1492=
435-1-caixinchen1@huawei.com?part=3D1
