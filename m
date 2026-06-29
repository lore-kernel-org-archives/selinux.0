Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CFC3A7F66;
	Mon, 29 Jun 2026 06:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716095; cv=none; b=Jl5P7edphwRvkZrIx7TmC8A3K9lhmVdhrnLCGltEw+fnvAZUA/6ZBnnSD916BMmEy4TeiBOMwI7uxPCjpZijutkPPoEbIoXGZf6lpwuTkjDrhrSzNsUVvY076MqGB83cN+TUf19jGSq+rOfRmr80MIzczE1mzIM5VY6nja6x8nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716095; c=relaxed/simple;
	bh=NvQHN/seDGH2KBpotIFNnMLPKLJO0VYT2Ulh+Yo0jKc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LggKGyTZzEb7oy/aKcsDSX1DwBSI5ayOSAO+0JlfxZvw2TCAUHru4IYvDW0vm/J5F1BhdmZiZt/HYdcpcnBspGVbRTuVeVlKBbwPN6dCsOV8ZKEm2Q3zj/WT5ro/RBHezK9qcTUwvxMAsAPhcB8fbQzdZc7P4D4MPSKCy0fZ2hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHoXuxBW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHoXuxBW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1F11F000E9;
	Mon, 29 Jun 2026 06:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782716094;
	bh=bGJHQKttC3MjNhj6RyL+inwW0xO1HHUc7d/X7Fd0IcE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cHoXuxBW/Ahfw2QosX/XkHdm2Pcc+B8HvBmwAnrutnoFN8BB+U/di1s6Sx8wuDCf1
	 914FZ1y2i4e/6ayQrMUg6qgs1FMH2BKRiGNZwDJ1uRxN9y2uQ1cpOGqx/3Gsd7dBAz
	 pcWqWFQAnm8QAkId1RXq4pCqTYyi+MZtywtDefx/7Nc13DcEIrC/LSdl+T8z3f7Ml6
	 FH4RWV8UGvULWa3weG3mDc2UY3cfuvkMXKoW+7yj64QEOOfm6e6elM0K8ZYo2GZS8f
	 YFWzPrWHxil0hRUV9jx3EKQwktSJZIjbrdsyn3IihHsfXcltvIvuMYd8IYPcQ4Jgve
	 McVK/RTZFkQ4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable/linux-5.10.y 3/7] fs: use backing_file container
 for internal files with "fake" f_path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20260629070653.580879-4-caixinchen1@huawei.com>
References: <20260629070653.580879-1-caixinchen1@huawei.com>
 <20260629070653.580879-4-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 06:54:53 +0000
Message-Id: <20260629065453.CF1F11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] If `init_file()` fails in `alloc_empty_backing_file()`, the `kzall=
oc`'d memory is incorrectly freed to `filp_cachep`, causing SLUB corruption.
- [Medium] The `backing_file` container allocation lacks `__GFP_ACCOUNT`, b=
ypassing memcg memory accounting.
--

commit 253dd7739e2dba161f4b1907e20e7723d9f6a637
Author: Amir Goldstein <amir73il@gmail.com>

fs: use backing_file container for internal files with "fake" f_path

Overlayfs uses open_with_fake_path() to allocate internal kernel files.
This commit introduces a backing_file container to hold the fake ovl path
along with the real path.

> diff --git a/fs/file_table.c b/fs/file_table.c
> index be24d724b4075..6daef2e2b2ada 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
[ ... ]
> @@ -189,6 +211,30 @@ struct file *alloc_empty_file_noaccount(int flags, c=
onst struct cred *cred)
>  	return f;
>  }
> =20
> +/*
> + * Variant of alloc_empty_file() that allocates a backing_file container
> + * and doesn't check and modify nr_files.
> + *
> + * This is only for kernel internal use, and the allocate file must not =
be
> + * installed into file tables or such.
> + */
> +struct file *alloc_empty_backing_file(int flags, const struct cred *cred)
> +{
> +	struct backing_file *ff;
> +	int error;
> +
> +	ff =3D kzalloc(sizeof(struct backing_file), GFP_KERNEL);

[Severity: Medium]
Since this replaces an allocation that previously came from the filp_cachep
slab cache (which uses SLAB_ACCOUNT), should this kzalloc() include the
__GFP_ACCOUNT flag?

Without __GFP_ACCOUNT, this memory might bypass memcg accounting, allowing a
container to allocate kernel memory without being charged against its limit.

> +	if (unlikely(!ff))
> +		return ERR_PTR(-ENOMEM);
> +
> +	error =3D init_file(&ff->file, flags, cred);

[Severity: High]
If init_file() fails (for example, due to an error in security_file_alloc()=
),
it calls file_free_rcu().

Because FMODE_BACKING has not been set in f_mode yet, file_free_rcu() will
evaluate (f->f_mode & FMODE_BACKING) as false:

fs/file_table.c:file_free_rcu() {
    ...
    if (unlikely(f->f_mode & FMODE_BACKING))
        kfree(backing_file(f));
    else
        kmem_cache_free(filp_cachep, f);
}

Will this cause the kzalloc'd ff pointer to be incorrectly freed into the
filp_cachep slab cache, leading to SLUB corruption?

> +	if (unlikely(error))
> +		return ERR_PTR(error);
> +
> +	ff->file.f_mode |=3D FMODE_BACKING | FMODE_NOACCOUNT;
> +	return &ff->file;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629070653.5808=
79-1-caixinchen1@huawei.com?part=3D3
