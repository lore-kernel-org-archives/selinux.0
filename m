Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C093BD22C;
	Mon, 29 Jun 2026 06:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716219; cv=none; b=TcOEByQ6IJEFmy3g+66MENfE/WBUnWTlY5AmbQfLjE1+dCgSIsw3+B4PJmqEtH02CT6lHgLmHSPucW+JXAliOI9yeDFC7QQ9VyjUVcTprcQFCJtVL/V7TpulawEiL52slC7UgQNF9FswjYnVPtueKp9wppzAPLWdyd7RN7hNckQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716219; c=relaxed/simple;
	bh=A388balnwsreQgnOFUoGPGQqHa16NefdAh/dMng7NFQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AollppLbhJlmm8oTu7hBpn5Cr4OHj5ASbhAYe8xJIHLHhLsA8AVcxEsV2QwRdpZ7xiva/ePmqJiEf8YRcMnyIBtIAjtlSp4uHIhCRqHEMDW8/11202RrXivG4gv52/XrSC+BkR7x2e+0xKjRsQh664mBI45dsGihocAdBgw/97Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385641F000E9;
	Mon, 29 Jun 2026 06:56:52 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable/linux-5.10.y 6/7] lsm: add backing_file LSM hooks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20260629070653.580879-7-caixinchen1@huawei.com>
References: <20260629070653.580879-1-caixinchen1@huawei.com>
 <20260629070653.580879-7-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 06:56:51 +0000
Message-Id: <20260629065652.385641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Permanent struct file reference count leak of 'realfile' when `sec=
urity_mmap_backing_file` fails in `ovl_mmap`.

Pre-existing issues:
- [High] Slab corruption when `init_file` fails in `alloc_empty_backing_fil=
e` due to a mismatch between `kzalloc` and `kmem_cache_free`.
--

commit d56daad1df4b9fc063314a1e9538b4eee20fd64d
Author: Paul Moore <paul@paul-moore.com>

lsm: add backing_file LSM hooks

Stacked filesystems such as overlayfs do not currently provide the
necessary mechanisms for LSMs to properly enforce access controls on the
mmap() and mprotect() operations. In order to resolve this gap, a LSM
security blob is being added to the backing_file struct and the following
new LSM hooks are being created.

> diff --git a/fs/file_table.c b/fs/file_table.c
> index 6792d0bce2461..829dfd35365c3 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
[ ... ]
> @@ -229,7 +244,8 @@ static int init_backing_file(struct backing_file *ff)
>   * This is only for kernel internal use, and the allocate file must not =
be
>   * installed into file tables or such.
>   */
> -struct file *alloc_empty_backing_file(int flags, const struct cred *cred)
> +struct file *alloc_empty_backing_file(int flags, const struct cred *cred,
> +				      const struct file *user_file)
>  {

[Severity: High]
This is a pre-existing issue, but does alloc_empty_backing_file() cause slab
corruption if init_file() fails?

In alloc_empty_backing_file(), we allocate a struct backing_file using
kzalloc(). Then we call init_file(&ff->file, flags, cred).

If init_file() fails (e.g., if security_file_alloc() returns -ENOMEM), it c=
leans
up by directly calling file_free_rcu():

fs/file_table.c:init_file() {
    ...
	error =3D security_file_alloc(f);
	if (unlikely(error)) {
		file_free_rcu(&f->f_u.fu_rcuhead);
		return error;
	}
    ...
}

Inside file_free_rcu(), it uses the FMODE_BACKING flag to decide how to fre=
e:

fs/file_table.c:file_free_rcu() {
    ...
	if (unlikely(f->f_mode & FMODE_BACKING))
		kfree(backing_file(f));
	else
		kmem_cache_free(filp_cachep, f);
}

Since FMODE_BACKING is only set after init_file() returns successfully, the
flag is missing during the error path, and we end up passing the kzalloc'd
pointer to kmem_cache_free(filp_cachep, f).

>  	struct backing_file *ff;
>  	int error;
[ ... ]
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 460748b638063..318ec1d99aa16 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
[ ... ]
> @@ -504,6 +505,11 @@ static int ovl_mmap(struct file *file, struct vm_are=
a_struct *vma)
>  	vma->vm_file =3D get_file(realfile);
> =20
>  	old_cred =3D ovl_override_creds(file_inode(file)->i_sb);
> +	ret =3D security_mmap_backing_file(vma, realfile, user_file);
> +	if (ret) {
> +		revert_creds(old_cred);
> +		return ret;

[Severity: High]
Does this code leak the realfile reference on error?

When security_mmap_backing_file() fails, we return early without dropping
the reference to realfile acquired just above via get_file(realfile) and
stored in vma->vm_file.

The caller (__mmap_region()) handles the error by clearing vma->vm_file =3D=
 NULL
and only drops the reference to the original user_file, which orphans the
reference to realfile.

> +	}
>  	ret =3D call_mmap(vma->vm_file, vma);
>  	revert_creds(old_cred);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629070653.5808=
79-1-caixinchen1@huawei.com?part=3D6
