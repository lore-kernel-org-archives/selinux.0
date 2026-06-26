Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC4C2EB5A6
	for <selinux@vger.kernel.org>; Fri, 26 Jun 2026 01:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782438340; cv=none; b=k8U152BYDeivZYczs+L9ozbYB4als5vvIqR3rsKAzYrQr3rmIjCzg4ZZ0ffFJPClz7tnY2Q3qCJ+KUYX7rEiF4mVyPMUOB5rEPJAvnfISYGS28mfArT08Ne1fy9dGEGsrrR+1jluRmz7e8TpSSVJF19B4K11ryWHMtSINJM5AIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782438340; c=relaxed/simple;
	bh=9ZuJsvqJoUnP8hcby6m8wbMovOTBt3L/JcltUzwj5U4=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IHrvPMVp+y+W5v+/edTQl/Lm+46fl4+taHUd35rQuIHeFo8HwQI4m+zx2KS60cyocaSBAotO24Q0na8H5udYHZ/m4QDEebss1P6T/PaSH3PCAbhZm85XNsCA4eKHqk+XO+znuOYHKDkpHrwBnuF9WN1vPWkeNumW0CuwhlRkcCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0eFZlus; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0eFZlus"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04ED41F00A3D
	for <selinux@vger.kernel.org>; Fri, 26 Jun 2026 01:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782438339;
	bh=oKz8Su6uJACJFAtcgvZg4UHBxQ2ixH6mloEMmSDEgZg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=i0eFZlusrTJd53jccIopf8U6c593EyCvKj4zcJqYJ4h6RKjO/f+1DRFai01+eO7E/
	 fMblRQNiISxu7TGcyMjkKzgwOftEAXxJq3fTW7I8GEfTIUC8judy+19rohoMfsntmC
	 LEjrDL8+23evSw4KkAD6sxKcZkJR1ysU1rW7gJ5Ml0pPHsDvY2qEQomCu8b12tusNI
	 KaRsT1I33CiTO3ECx6P/7CMlZy6SUNFXDPzVGCkNQXS7LvyaEfB5QL95rJvS9ozV/5
	 giXTCMiWBAGDLGaeCrsBYWai5rAwbGOwlu/KaD1eNwK7Fk5Hmz8zqvLJ5WGMpXkt4O
	 ijxo6KTjszwiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next 2/2] security: Fix call security_backing_file_free
 second time
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260626011720.1144213-3-caixinchen1@huawei.com>
References: <20260626011720.1144213-1-caixinchen1@huawei.com>
 <20260626011720.1144213-3-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 01:45:38 +0000
Message-Id: <20260626014539.04ED41F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> I found the following path:
>=20
> alloc_empty_backing-file
>     init_file(&ff->file, xxx)
>         -> file_ref_init(&f->f_ref, 1); // only 1
>     error =3D init_backing_file
>         -> security_backing_file_alloc
>         -> rc =3D call_int_hook(backing_file_alloc, ...)
>            if (unlikely(rc))
>            	security_backing_file_free(backing_file); // first call
>     if (unlikely(error)) {
>         fput(&ff->file);
>          -> if (unlikely(file_ref_put(&file->f_ref))) // zero
>                 __fput_deferred(file);
>                  -> ____fput -> __fput -> file_free(file);
>                  -> backing_file_free(backing_file(f));
>                  -> security_backing_file_free(&ff->file); // second call
>=20
> Currently, only SELinux has the lsm backing_file_alloc hook, and the
> backing_file_free hook is not set. When security_backing_file_free is
> called for the first time, the blobs pointer is set to NULL. Therefore,
> double free will not occur in the code.
>=20
> Fixes: 6af36aeb147a ("lsm: add backing_file LSM hooks")
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626011720.1144=
213-1-caixinchen1@huawei.com?part=3D2

