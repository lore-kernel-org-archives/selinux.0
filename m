Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FD519C54E;
	Thu, 13 Aug 2026 00:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786581389; cv=none; b=e+RwgTcYqjpYFGq2VFggu54WkMC82zZ/kA24y2Hyan3QekkVCxcGeZiyiaE5Yf5pIDuSB6oDiw1l7vVQNCeDhQ0SQjR8XFKcUnI7uecU+Cyeeza0NrlXf0y25MWH9Owqj+zF6Z5o7M19cAb4YaI1fVPv7hE/JF/Ipkb+F1GpweM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786581389; c=relaxed/simple;
	bh=Hp939UJOOy1VgOLQeW0u7EkYZCuBGdfOUlV3nia657g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rs9jk3sKLkJak1M1tjbi4iARbmZL3EgCjbsipL2VwK9epe2RwNGZdDDiG/znLWXFM4aiQ8BJXAJGtvemyT6x711f8BI8UIqDCSy1HNA/jZby4+sOp/H3dOoumLsv+uf73MtM+HaJtrXkgRE5C1UJ23pMRoasMUw2sYX5HoeetqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ij1wx2Y0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ij1wx2Y0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D221F000E9;
	Thu, 13 Aug 2026 00:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786581387;
	bh=yf4dFIO77Lv6vWOgdxj4KVyvfbMHC0VfaztlNxNjG+8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ij1wx2Y0zy1V3KYhvcCO2gFOvy5xbH8RqYmYpiTLrkZp4G8ZnM/xIIKdj6yw5tswe
	 YjLy64fhH2tVogDMNLhRt4XFMP0SqNxeoz22SJTe0WnOf+pR+aLDKM8QVHzRdtE2vS
	 q+24CYTe4sXk9TaG8nlEAX/27l/ZcEBTwMS3A6BVowDLjbgPA7cl13Ipml52vUNpWE
	 64RliHPAAiv0boB8MiTtGjX/fM9j9I4g2XlLOlnKG8ti5fBH1daU2RBKvxrGEmWObw
	 +b8NzhXGiV9HST0ZYeBp5gB4yNa5tznRGPLTdGmK35lXPZh41rmqB42FdBgIKpJqz/
	 e/fAF2RzvbWRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/5] fs/kernel_read_file,selinux: Add
 BPF_LOADER constant
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhpw6liYXVkIFdla3N0ZWVu?= <tweek@google.com>
Cc: bpf@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20260813002618.3755631-2-tweek@google.com>
References: <20260813002618.3755631-1-tweek@google.com>
 <20260813002618.3755631-2-tweek@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 00:36:27 +0000
Message-Id: <20260813003627.95D221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The newly added enum variants `READING_BPF_LOADER` and `LOADING_BP=
F_LOADER` are not handled in the switch statements of the IPE (Integrity Po=
licy Enforcement) LSM hooks. This will cause a kernel warning and default t=
o an invalid policy operation.
--

--- Patch [1]: [PATCH bpf-next 1/5] fs/kernel_read_file,selinux: Add BPF_LO=
ADER constant ---
commit 2c2b2df398b783718511b45e4ea8aa7251362d31
Author: Thi=C3=A9baud Weksteen <tweek@google.com>

fs/kernel_read_file,selinux: Add BPF_LOADER constant

This commit adds a new BPF_LOADER constant for kernel_read_file_id and
kernel_load_data_id. It also updates the SELinux policy to handle the new
loading constants.

> diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read=
_file.h
> index d613a7b4dd35a..fbcaf41c1b734 100644
> --- a/include/linux/kernel_read_file.h
> +++ b/include/linux/kernel_read_file.h
> @@ -15,6 +15,7 @@
>  	id(POLICY, security-policy)		\
>  	id(X509_CERTIFICATE, x509-certificate)	\
>  	id(MODULE_COMPRESSED, kernel-module-compressed) \
> +	id(BPF_LOADER, bpf-loader) \

[Severity: High]
Should the Integrity Policy Enforcement (IPE) LSM hooks be updated to handle
these new constants as well?

If READING_BPF_LOADER is passed to ipe_kernel_read_file(), it will fall
through to the default case since there is no matching rule setup:

security/ipe/hooks.c:ipe_kernel_read_file() {
    ...
    switch (id) {
    ...
    default:
        op =3D IPE_OP_INVALID;
        WARN(1, "no rule setup for kernel_read_file enum %d", id);
    }
}

This will trigger a kernel warning and default to an invalid policy operati=
on,
which may incorrectly deny the BPF loader. The same unhandled switch case
exists for LOADING_BPF_LOADER in ipe_kernel_load_data().

>  	id(MAX_ID, )
> =20
>  #define __fid_enumify(ENUM, dummy) READING_ ## ENUM,

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813002618.3755=
631-1-tweek@google.com?part=3D1
