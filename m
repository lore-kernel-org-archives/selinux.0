Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABE535A398;
	Fri, 26 Jun 2026 07:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782459218; cv=none; b=pOYBNHEjR20Z7O41gIy+pAstNVWVYB7K4WYpXdY8u9q6s9KuPi1PUkGetX7nOV9prEoHfEMAQhqzTuxEW9zAXLYlKJErPJUq+VaHteQO2eHuuUFdg1/tiF83cALmRv9Ji44Vl5ACZbMbT5x8bvJDXTKPoyAhlS/TSWFXgR/wT90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782459218; c=relaxed/simple;
	bh=B4jF10FPEroBdeQMJo53/o84uwqJathAaUNTfHjfSz8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DhQ7hy6gUl6qdtoSEsrAwc1kudnNBJmQnHhWehGykASRbQ9gZOXYaqaihpSiGrfdGqU1hRnpAi11ktOL6mYVRnSzkyBZxA5YWJyKsR7B9CpWXVcPWGuBr39F0Sqv0j2U659WI5iI5sckF62ScAwsnD++lNW8/gyQLVCOA0WFsO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcPRXwzE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcPRXwzE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD191F000E9;
	Fri, 26 Jun 2026 07:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782459217;
	bh=BzlmznrWWLjG9lTZxSuog5JrkNC8pk/9Lgw4AA3dz7k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hcPRXwzESVLFQ/Pc9NqjLUD/xjoGNWs1D9Rcs5712ywP6tzIoh3P3Qd61EEzc0BJT
	 0wu869Sq46QOLDTOmDtcXRpqbECag8Jp1xRWUpilIbQ0d/nymrZaAYsl/SYEM9OuEL
	 3YtSCP5xgyEojbf+EwLbCpiZ4C++KcTqtoQFd/ICC7x1+YUgD/wvdLIngMZz4vnuDY
	 VH77m8IWwoaZOqPMxipALoEbkDGgC6XdLR7qYDlEsD/7dJB6kHDREnq03rBuIlL0Ic
	 u+sU2F+uIT98/3SyoKuluKDTzLF80xeh8tW8U00FN/8Par6ISClgbh8C6uz/UYpKji
	 PlcP5S1WQLI/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 stable/linux-6.18.y 1/2] lsm: add backing_file LSM
 hooks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: selinux@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260626075035.143419-2-caixinchen1@huawei.com>
References: <20260626075035.143419-1-caixinchen1@huawei.com>
 <20260626075035.143419-2-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 07:33:36 +0000
Message-Id: <20260626073336.EFD191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The error path in alloc_empty_backing_file() triggers a double e=
xecution of the backing_file_free LSM hooks with a NULL security blob, viol=
ating the LSM API contract.
--

commit 5c2fdae294837ef2192abffb715e055fefb686b4
Author: Paul Moore <paul@paul-moore.com>

lsm: add backing_file LSM hooks

This commit adds a security blob to the backing_file struct and new LSM hoo=
ks
(security_backing_file_alloc, security_backing_file_free, and
security_mmap_backing_file). This provides the necessary mechanisms for LSMs
to enforce access controls on the mmap() and mprotect() operations in stack=
ed
filesystems.

> diff --git a/fs/file_table.c b/fs/file_table.c
> index 762f03dcbcd77..987e01da99389 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
[ ... ]
> @@ -318,7 +337,7 @@ struct file *alloc_empty_backing_file(int flags, cons=
t struct cred *cred)
> =20
>  	/* The f_mode flags must be set before fput(). */
>  	ff->file.f_mode |=3D FMODE_BACKING | FMODE_NOACCOUNT;
> -	error =3D init_backing_file(ff);
> +	error =3D init_backing_file(ff, user_file);
>  	if (unlikely(error)) {
>  		fput(&ff->file);
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

[Severity: Medium]
Does this error path lead to a double execution of the free hooks?

If call_int_hook() fails, security_backing_file_alloc() cleans up by calling
security_backing_file_free().

The error then propagates back to init_backing_file(), and then to
alloc_empty_backing_file(), which calls fput() on the error path.

The fput() call initiates the VFS teardown path, which eventually calls
backing_file_free() and executes security_backing_file_free() for a second
time.

Similarly, if lsm_backing_file_alloc() fails with -ENOMEM, it returns an er=
ror
without calling any hooks, but the subsequent fput() will still execute the
free hook without the alloc hook ever running.

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

Because call_void_hook() is executed unconditionally even if blob is NULL,
could this cause state corruption for BPF LSM programs tracking file lifecy=
cles,
or a NULL pointer dereference in future LSMs implementing the free hook?

> +
> +	if (blob) {
> +		backing_file_set_security(backing_file, NULL);
> +		kmem_cache_free(lsm_backing_file_cache, blob);
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626075035.1434=
19-1-caixinchen1@huawei.com?part=3D1
