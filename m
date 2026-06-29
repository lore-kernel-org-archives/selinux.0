Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB963ADB9A;
	Mon, 29 Jun 2026 06:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782715951; cv=none; b=K7/NARFps8KCpMC+Jcf373JBZS+8x5slsx/vbUeuWBWFAwtWTcf6dpnbJiTUCk2uzqHNUMNvgScrG+0u21sDUOrvgg7h9NvfR1CWW8f/q/8pQdRskkIcQBKzieQffG7kFn8BtVAvxKSaXU4TOhMugaHxlIvhZLzt5AKlXxfFl+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782715951; c=relaxed/simple;
	bh=UKicKqkr5olG+UJEoUu9+yNoHgUZAWV7jYcC1KWgb3s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S1gxzMCCYeslQPWfv093B3Ck57DVqtzIns57e8vlwK17aR5FD0aTtkNNY0h3yqOWrgQlRx3v/8bKliCHhw6OB4UcIpmjOKrv/SkM8p082i55/40nLXFpOKkbVV7FHjV5IJef+ESAj/Fj0cQ5748yfMAoGk2iDOSNuJQ5yRBbhlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kg/pH5zI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kg/pH5zI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7BE1F000E9;
	Mon, 29 Jun 2026 06:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782715949;
	bh=/0DCUZsK+Dh54D8cSinp9yU0f2VyQ7piyplD17NnsfY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kg/pH5zIFK1ICMrmjeh4OoySbW4OVAaTC1ysu6iJ1fCNjWOXY67ZYCUXOzIdoBJwN
	 +mJ+dEPx8LqzVWuRosryXhadsfvOj/lSSAzSNUued9/rU+pjzcjfn8JAKq+b1Oeacp
	 B3kpMW5qIEBbVJx4ZfD4uLtn9HeF1YHj9L+wsdd4j9yUsPIGFgJWDgfSeaN7oLWS2a
	 Mm+5Hca4ODOK4m0jZ0plzGEwnYuqGhi+dVjTclE1sNQZubxET28GViVMfig8EhOkTC
	 g994Q0yxkL5s/8SDzfRLvqWo77sIJMpDbHKocwWypRBNYQJ4MdKLX0oPNYUC8Yy/39
	 JCbfJmxxVd8Ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable/linux-5.10.y 2/7] fs: move kmem_cache_zalloc()
 into alloc_empty_file*() helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20260629070653.580879-3-caixinchen1@huawei.com>
References: <20260629070653.580879-1-caixinchen1@huawei.com>
 <20260629070653.580879-3-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 06:52:24 +0000
Message-Id: <20260629065229.2E7BE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] API trap leading to cross-allocator slab corruption when handling =
errors in `init_file()`.
--

commit 4291ff6cf97e536c82d7fa5b99705d5c988c0fac
Author: Amir Goldstein <amir73il@gmail.com>

fs: move kmem_cache_zalloc() into alloc_empty_file*() helpers

Use a common helper init_file() instead of __alloc_file() for
alloc_empty_file*() helpers and improrve the documentation.

This is needed for a follow up patch that allocates a backing_file
container.

> diff --git a/fs/file_table.c b/fs/file_table.c
> index 7a3b4a7f68086..be24d724b4075 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -93,20 +93,15 @@ int proc_nr_files(struct ctl_table *table, int write,
[ ... ]
> -static struct file *__alloc_file(int flags, const struct cred *cred)
> +static int init_file(struct file *f, int flags, const struct cred *cred)
>  {
> -	struct file *f;
>  	int error;
> =20
> -	f =3D kmem_cache_zalloc(filp_cachep, GFP_KERNEL);
> -	if (unlikely(!f))
> -		return ERR_PTR(-ENOMEM);
> -
>  	f->f_cred =3D get_cred(cred);
>  	error =3D security_file_alloc(f);
>  	if (unlikely(error)) {
>  		file_free_rcu(&f->f_u.fu_rcuhead);
> -		return ERR_PTR(error);
> +		return error;
>  	}

[Severity: High]
If a follow-up patch allocates a struct backing_file container using kzallo=
c()
and passes its file field to init_file(), could this error path lead to
cross-allocator slab corruption?

Because file_free_rcu() checks f->f_mode & FMODE_BACKING to decide whether =
to
use kfree() or kmem_cache_free(filp_cachep, ...), it seems FMODE_BACKING wo=
uld
need to be set before calling init_file() to ensure safe cleanup if
security_file_alloc() fails.

> =20
>  	atomic_long_set(&f->f_count, 1);
>  	rwlock_init(&f->f_owner.lock);
>  	spin_lock_init(&f->f_lock);
>  	mutex_init(&f->f_pos_lock);
>  	eventpoll_init_file(f);
>  	f->f_flags =3D flags;
>  	f->f_mode =3D OPEN_FMODE(flags);

[Severity: High]
However, since init_file() unconditionally overwrites f->f_mode here, the
caller cannot safely set FMODE_BACKING beforehand without it being
overwritten upon success.

Could this lead to kzalloc allocated memory being incorrectly freed to
filp_cachep if security_file_alloc() encounters an error (e.g., under
memory pressure or LSM denial)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629070653.5808=
79-1-caixinchen1@huawei.com?part=3D2
