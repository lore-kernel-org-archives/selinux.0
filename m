Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64C92D592D;
	Mon, 29 Jun 2026 06:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782715945; cv=none; b=upU+9srPw/duZCaoI7X47oS63id0NXaR5OgBp6y6vNfTerO1AcGscWVrw32ucAiPL0B0dQO6VnnHsBmwTJELYk2/dqX0o+kteRB1CMhSPjlhKD2XRdzqyDWFGCvUnaMHso4l4olVv274msFtixS0+mfbQsvqyTTdE5FHE2+qSd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782715945; c=relaxed/simple;
	bh=nIXfyxsuG4SJfJyp80sZM61XrofJ8xoU+1agKGBxhHs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eJAutRkncbLyMcv8jGfdl3iVRphNRbtks5OIZVtW/y+n9sXvfJGOU2AVic1AXs6iT8B1Ccg1AfH5FLQ9Wh/3TsMTZEW66rh9MaL5DjomIDo0YnzAPoZivg4WQXBvhQ9D93sixPrZz+OeGehuhVKSyrA8m3qS4jc0MdVeAGthVlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8701F000E9;
	Mon, 29 Jun 2026 06:52:24 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable/linux-5.10.y 5/7] fs: prepare for adding LSM blob
 to backing_file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: selinux@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260629070653.580879-6-caixinchen1@huawei.com>
References: <20260629070653.580879-1-caixinchen1@huawei.com>
 <20260629070653.580879-6-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 06:52:21 +0000
Message-Id: <20260629065224.2D8701F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Slab allocator corruption and kernel panic when security_file_allo=
c() fails during backing file initialization.
--

commit 5ea328a29bcb61b7c30ea4dc685a4910998da08f
Author: Amir Goldstein <amir73il@gmail.com>

fs: prepare for adding LSM blob to backing_file

In preparation to adding LSM blob to backing_file struct, factor out
helpers init_backing_file() and backing_file_free().

> diff --git a/fs/file_table.c b/fs/file_table.c
> index 6daef2e2b2ada..6792d0bce2461 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c

[ ... ]

> @@ -231,7 +242,14 @@ struct file *alloc_empty_backing_file(int flags, con=
st struct cred *cred)
>  	if (unlikely(error))
>  		return ERR_PTR(error);
> =20
> +	/* The f_mode flags must be set before fput(). */
>  	ff->file.f_mode |=3D FMODE_BACKING | FMODE_NOACCOUNT;

[Severity: High]
Can this lead to slab corruption if init_file() fails?

In alloc_empty_backing_file(), the backing_file is allocated via kzalloc():

fs/file_table.c:alloc_empty_backing_file() {
    ...
	ff =3D kzalloc(sizeof(struct backing_file), GFP_KERNEL);
	if (unlikely(!ff))
		return ERR_PTR(-ENOMEM);

	error =3D init_file(&ff->file, flags, cred);
    ...
}

If security_file_alloc() fails inside init_file(), it triggers the cleanup
path using file_free_rcu():

fs/file_table.c:init_file() {
    ...
	error =3D security_file_alloc(f);
	if (unlikely(error)) {
		file_free_rcu(&f->f_u.fu_rcuhead);
		return error;
	}
    ...
}

Because FMODE_BACKING is not set until after init_file() returns,
file_free_rcu() will take the else branch and attempt to free the kzalloc'd
pointer into the filp_cachep kmem cache:

fs/file_table.c:file_free_rcu() {
    ...
	if (unlikely(f->f_mode & FMODE_BACKING))
		kfree(backing_file(f));
	else
		kmem_cache_free(filp_cachep, f);
}

Should FMODE_BACKING be set before calling init_file(), or is there a
different way this cleanup should be handled?

> +	error =3D init_backing_file(ff);
> +	if (unlikely(error)) {
> +		fput(&ff->file);
> +		return ERR_PTR(error);
> +	}
> +
>  	return &ff->file;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629070653.5808=
79-1-caixinchen1@huawei.com?part=3D5
