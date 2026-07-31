Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAA4415F1D;
	Fri, 31 Jul 2026 00:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785456003; cv=none; b=ToZJJEM0KkalGBCyQ8ziJLGmDSh2QzzYuEMvoEJXXz7S+vmxXVO8m+6KJnXGUqUriccIj2xFO4gBFzQoDO+sbUGfky/WsiL0oRLWg0faUxNxJpIsJsDnUEW9/xktNJY31qjHpN17nkHyy7Od/LBakDHziHxVR2HNo5n4AwFMTO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785456003; c=relaxed/simple;
	bh=XWZfmUqBlmZIv+Cc4+NkDTwkqL0Bl67aH8g6GVZ5ShI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wy0aVLPfgQAwOGZpJxIydD0ECMhXElmF7m8gzNNHlpDJNapkPuyQYRfv66Cnq9/H25wzfYCniZE8GmoGGyExUif1d6tdSORezpyExVJE4rCRAG8oI8RNyx3Jjm2Ooi1e5Wx3GBzZHZ4OYy0pYO9dO8YuVcxEGIs4WavIBjezqGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkKtQ27L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkKtQ27L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576791F000E9;
	Fri, 31 Jul 2026 00:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785456002;
	bh=973DWxHnldpIeidO3QnYB0kn6LB8ZXOP+kfVfsDlnKY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LkKtQ27LOFzJpgMFDUrBzZBh5aAFfgbcVhxehaglJqFVNOO/Y8p/YoQdlAD9LLelj
	 DH6JTHv0kgzHULQAZvxhEQhg71WixYTvUNIS5Oys3Ndvp7JvvAUcfcG9LjrP4Wv8vM
	 2JJ4Y5cgRDY3U6bhsb856mW4VPd+dVwv9hK5JXRFgxtwA1DOE5zwJ0ioYrQvXyETTb
	 UVWWc5vZrFxA3C+zQ4gOpEGjVCzmCFl2omlmCkld3TcKcjodfFfDAZhHVzaSS18ATr
	 VFoALddERNRqIbBjaCXHpksAJDXjt7/dgfYpHI04Wt3s0jI4BCqa900Ibvhm8Lu9ee
	 NU8XFPwkJ3hRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 bpf-next 2/4] security: add security_lsmxattr_add()
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Windsor" <dwindsor@gmail.com>
Cc: bpf@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20260730234533.1912709-3-dwindsor@gmail.com>
References: <20260730234533.1912709-1-dwindsor@gmail.com>
 <20260730234533.1912709-3-dwindsor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 00:00:01 +0000
Message-Id: <20260731000002.576791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The dynamically allocated `xattr->name` pointer is used after bein=
g freed by `security_inode_init_security()` in the ocfs2 filesystem.
--

--- Patch [2]: [PATCH v6 bpf-next 2/4] security: add security_lsmxattr_add(=
) ---
commit cefa37d110516b84cf53133f4f60bba93ba53641
Author: David Windsor <dwindsor@gmail.com>

security: add security_lsmxattr_add()
   =20
This commit adds security_lsmxattr_add(), which claims a slot in the
inode_init_security xattr array on behalf of the calling LSM. It fills the
slot with a dynamically allocated copy of the given name and value.

> diff --git a/security/security.c b/security/security.c
> index 2ad7f09c1a611..ae72102cd29b8 100644
> --- a/security/security.c
> +++ b/security/security.c
[ ... ]
> @@ -1376,6 +1377,101 @@ int security_inode_init_security(struct inode *in=
ode, struct inode *dir,
[ ... ]
> +int security_lsmxattr_add(struct lsm_xattrs *xattrs, u64 lsm_id,
> +			  const char *name_extra, const void *value,
> +			  size_t value_len)
> +{
[ ... ]
> +	/* Combine xattr value + name into one allocation. */
> +	xattr_value =3D kmalloc(value_len + name_len + 1, GFP_NOWAIT);
> +	if (!xattr_value)
> +		return -ENOMEM;
> +
> +	memcpy(xattr_value, value, value_len);
> +	memcpy(xattr_value + value_len, suffix, suffix_len);
> +	if (extra_len)
> +		memcpy(xattr_value + value_len + suffix_len, name_extra,
> +		       extra_len);
> +	((char *)xattr_value)[value_len + name_len] =3D '\0';
> +
> +	xattr =3D lsm_get_xattr_slot(xattrs);
> +	if (!xattr) {
> +		kfree(xattr_value);
> +		return -ENOSPC;
> +	}
> +
> +	xattr->value =3D xattr_value;
> +	xattr->name =3D (const char *)xattr_value + value_len;

[Severity: High]
Does this code cause a use-after-free for filesystems like ocfs2?

Looking at ocfs2, the ocfs2_initxattrs() callback saves the xattr->name
pointer directly into si->name, assuming it has a static lifetime (which
was true for SELinux and Smack):

fs/ocfs2/xattr.c:ocfs2_initxattrs() {
    ...
    si->name =3D xattr_array->name;
    ...
}

But here xattr->name points inside the dynamically allocated xattr->value
block. When security_inode_init_security() completes, it frees
xattr->value:

security/security.c:security_inode_init_security() {
    ...
    ret =3D initxattrs(inode, xattrs.xattrs, fs_data);
out:
    for (; xattrs.xattr_count > 0; xattrs.xattr_count--)
        kfree(xattrs.xattrs[xattrs.xattr_count - 1].value);
    ...
}

After this free, ocfs2_mknod() will call ocfs2_calc_xattr_init(), which
dereferences the now-dangling si->name pointer:

fs/ocfs2/xattr.c:ocfs2_calc_xattr_init() {
    ...
    s_size =3D ocfs2_xattr_entry_real_size(strlen(si->name),
                                         si->value_len);
    ...
}

Could the dynamically allocated name trigger a use-after-free here?

> +	xattr->value_len =3D value_len;
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730234533.1912=
709-1-dwindsor@gmail.com?part=3D2
