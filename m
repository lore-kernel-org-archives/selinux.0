Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6C63B1EC0;
	Mon, 29 Jun 2026 07:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716804; cv=none; b=Pga8N4oE74y6XeRaPmJfzMvHTS79jeip6tBHnjLKeVJ/QTN56a/IBOZ/H72Vj7GDt4Wdtt19guNHdX5TJMtjc+s/2js8Hie23TEapB9Goski8JU9QROQPvWkkPrOgOrMPwVeIC9zxG0oVaHrkxSqFxeXzeO/8+ksziZq2xNmVJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716804; c=relaxed/simple;
	bh=eFX6PDN1Y0EA0WOVfB3e/+lI66tLEOvVri9NrmhyOaw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nxjYJZuO2/Oc3K2tK3YxM1H4IgLYGZF5UsmJFRRu0fBJ3tohWJyjY50Deh3DIQRr+aXdSEahf1QBue3AAu/QhZePx8sw8i6r+lCk5C7j4gZY6qm55uiF2E8tBaIAVGAtkQa82aD5HHqsfGMNrVFg1PGUgMK4gKbd0Z71AdE11Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D261F000E9;
	Mon, 29 Jun 2026 07:06:43 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 stable/linux-6.12.y 2/3] lsm: add backing_file LSM
 hooks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: selinux@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260629070338.578858-3-caixinchen1@huawei.com>
References: <20260629070338.578858-1-caixinchen1@huawei.com>
 <20260629070338.578858-3-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 07:06:42 +0000
Message-Id: <20260629070643.86D261F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Double execution of LSM backing_file_free hooks on alloc error p=
ath
--

commit 2db824f4a305b633b1d25658a509035f0230ff7f
Author: Paul Moore <paul@paul-moore.com>

lsm: add backing_file LSM hooks

This commit adds a security blob to the backing_file struct to allow stacked
filesystems to provide the necessary mechanisms for LSMs to properly enforce
access controls on mmap() and mprotect() operations. Three new LSM hooks are
introduced to manage the lifecycle and access control of the backing file b=
lob.

> diff --git a/fs/file_table.c b/fs/file_table.c
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
[ ... ]
> @@ -293,7 +311,7 @@ struct file *alloc_empty_backing_file(int flags, cons=
t struct cred *cred)
> =20
>  	/* The f_mode flags must be set before fput(). */
>  	ff->file.f_mode |=3D FMODE_BACKING | FMODE_NOACCOUNT;
> -	error =3D init_backing_file(ff);
> +	error =3D init_backing_file(ff, user_file);
>  	if (unlikely(error)) {
>  		fput(&ff->file);

[Severity: Medium]
Does this error path trigger a double execution of the LSM backing_file_free
hooks?

If security_backing_file_alloc() fails (e.g., due to an LSM hook returning =
an
error), it already cleans up its own state by calling
security_backing_file_free().

This propagates the error up here, where fput() is called to clean up the
partially initialized file structure.

Calling fput() eventually results in a call to file_free(), which calls
backing_file_free() and invokes security_backing_file_free() a second time.

While the second call safely ignores the NULL blob, it still unconditionally
executes call_void_hook(backing_file_free, backing_file):

void security_backing_file_free(struct file *backing_file)
{
        void *blob =3D backing_file_security(backing_file);

        call_void_hook(backing_file_free, backing_file);
        ...
}

Could this break the LSM lifecycle contract for future LSMs that might track
backing file state by executing the free hooks twice on the same file?

>  		return ERR_PTR(error);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629070338.5788=
58-1-caixinchen1@huawei.com?part=3D2
