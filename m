Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B502EF67A;
	Fri, 26 Jun 2026 02:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782440842; cv=none; b=WbjJy/jb44wTzdsbdTirQTsfYLcaSu7yZXD2jktmS4Nw34gQ5VOdrx18ctbB3vD78xgKrzNsTkqi3sk7VvBknuAjsYPcenDC1EhGkm/4qnfOgrZ+BAYPjE6WxQ5W3fCSzTj4IQKHqQlDVaNJhgzY5yjxoJjVOe9lenpZaZxlZyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782440842; c=relaxed/simple;
	bh=qVqu0sFt61wgt09NIw8JN2rlV/60nvD353wFzU8etQI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gaYI6dBIexr5Z7ykMp21RWj7e7CNktk07QA3ZowTUYSDTc46CYr/odWI2y0hA2X7f+8kIsUXnU1enDTFDQcvAG5cW7Cel6/fVwtTM+3IqTb2RFk49W+OdkxiVnGOQMStUsHkK640KTxxcJUfc0apNw83wWgcnoHDMpYLKbkf9hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqvmGYqG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqvmGYqG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A541F000E9;
	Fri, 26 Jun 2026 02:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782440840;
	bh=kCyjxsIvxVAQSkQ4j5mFCwlecTI/zTrv6CalreKqk+4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dqvmGYqGgdPw1jP9y+xhedZuQ1IFgoNigfceymngeQuQF8d0CU4M543wc1Fc/vfyy
	 bNlT1q3gPpl6HpREBpuvfRGIVT6DPWcWp5RQ9d7tTlM693LRYcbSUnl88LnMj39CJP
	 zwVo16yL1M64hG3vsdTGF/zJpXQ/sAm5VSHWxMN/layLWN58znGkLUINjjDuRNAz7G
	 wpUaIJAAvjjHa8C5/QPiPx7j7Yz+fPkn+iWiTvT74fMuFjR0sRXUfR54OkGty1A3K0
	 nhRz1h/0JkZM7+h8Thw3cpJKZXIBbXX3NFqHxAq1zSzdNYU0LMS16P6ONTY6ancJVN
	 sWGYi7jsa1eGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 stable/linux-6.18.y 1/2] lsm: add backing_file LSM
 hooks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20260626024058.3149217-2-caixinchen1@huawei.com>
References: <20260626024058.3149217-1-caixinchen1@huawei.com>
 <20260626024058.3149217-2-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 02:27:19 +0000
Message-Id: <20260626022720.13A541F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Double execution of the `backing_file_free` LSM hook on allocati=
on failure, causing potential NULL pointer dereferences.
--

commit 1113cc3ed88cd48b759f67dff14b8460d0d07970
Author: Paul Moore <paul@paul-moore.com>

lsm: add backing_file LSM hooks

This commit adds a security blob to the backing_file struct and
introduces new LSM hooks (security_backing_file_alloc,
security_backing_file_free, and security_mmap_backing_file) to
allow LSMs to properly enforce access controls on mmap() and mprotect()
operations for stacked filesystems.

> diff --git a/fs/file_table.c b/fs/file_table.c
> index 762f03dcbcd77..987e01da99389 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
[ ... ]
> @@ -301,7 +319,8 @@ static int init_backing_file(struct backing_file *ff)
>   * This is only for kernel internal use, and the allocate file must not =
be
>   * installed into file tables or such.
>   */
> -struct file *alloc_empty_backing_file(int flags, const struct cred *cred)
> +struct file *alloc_empty_backing_file(int flags, const struct cred *cred,
> +				      const struct file *user_file)
>  {
>  	struct backing_file *ff;
>  	int error;
> @@ -318,7 +337,7 @@ struct file *alloc_empty_backing_file(int flags, cons=
t struct cred *cred)
> =20
>  	/* The f_mode flags must be set before fput(). */
>  	ff->file.f_mode |=3D FMODE_BACKING | FMODE_NOACCOUNT;
> -	error =3D init_backing_file(ff);
> +	error =3D init_backing_file(ff, user_file);
>  	if (unlikely(error)) {
>  		fput(&ff->file);

[Severity: Medium]
Will this lead to a double execution of the backing_file_free hook?

If security_backing_file_alloc() fails after successfully calling
lsm_backing_file_alloc(), it internally calls security_backing_file_free() =
to
clean up. It then returns an error back through init_backing_file() to here.

Because FMODE_BACKING is already set, this fput() triggers the VFS
teardown via __fput() -> file_free() -> backing_file_free() ->
security_backing_file_free(), which will call the free hook a second time.

>  		return ERR_PTR(error);
>  	}
[ ... ]
> diff --git a/security/security.c b/security/security.c
> index 603c3c6d5635d..9285909908ab8 100644
> --- a/security/security.c
> +++ b/security/security.c
[ ... ]
> @@ -2965,6 +2997,57 @@ void security_file_free(struct file *file)
>  	}
>  }
> =20
> +/**
> + * security_backing_file_alloc() - Allocate and setup a backing file blob
> + * @backing_file: the backing file
> + * @user_file: the associated user visible file
> + *
> + * Allocate a backing file LSM blob and perform any necessary initializa=
tion of
> + * the LSM blob.  There will be some operations where the LSM will not h=
ave
> + * access to @user_file after this point, so any important state associa=
ted
> + * with @user_file that is important to the LSM should be captured in the
> + * backing file's LSM blob.
> + *
> + * LSM's should avoid taking a reference to @user_file in this hook as i=
t will
> + * result in problems later when the system attempts to drop/put the file
> + * references due to a circular dependency.
> + *
> + * Return: Return 0 if the hook is successful, negative values otherwise.
> + */
> +int security_backing_file_alloc(struct file *backing_file,
> +				const struct file *user_file)
> +{
> +	int rc;
> +
> +	rc =3D lsm_backing_file_alloc(backing_file);
> +	if (rc)
> +		return rc;
> +	rc =3D call_int_hook(backing_file_alloc, backing_file, user_file);
> +	if (unlikely(rc))
> +		security_backing_file_free(backing_file);
> +
> +	return rc;
> +}
> +
> +/**
> + * security_backing_file_free() - Free a backing file blob
> + * @backing_file: the backing file
> + *
> + * Free any LSM state associate with a backing file's LSM blob, includin=
g the
> + * blob itself.
> + */
> +void security_backing_file_free(struct file *backing_file)
> +{
> +	void *blob =3D backing_file_security(backing_file);
> +
> +	call_void_hook(backing_file_free, backing_file);

[Severity: Medium]
If the free hook is called twice (as mentioned above), or called after
lsm_backing_file_alloc() returns ENOMEM without executing any alloc hooks,
"blob" will be NULL.

Could this cause a NULL pointer dereference if an LSM or BPF program
implements the free hook and attempts to access the security blob?

> +
> +	if (blob) {
> +		backing_file_set_security(backing_file, NULL);
> +		kmem_cache_free(lsm_backing_file_cache, blob);
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626024058.3149=
217-1-caixinchen1@huawei.com?part=3D1
