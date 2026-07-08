Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EF41B87C9
	for <selinux@vger.kernel.org>; Wed,  8 Jul 2026 00:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783470681; cv=pass; b=gw9EGqZeMTUOWZOGvLNVxyMdGNX6h+2lllLA7s/+7RDn2KYINqdjoVeEtSIJaGMcbuWRCXtsBnbpX4nDy5h9dxgp5umFpJ3pJME2R4WHe0aNzU79tBH+aSD03vNjJu1s38Ne36Tv5SGLBVDxVm77OmyOwl82JnS2nv0QhojVcZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783470681; c=relaxed/simple;
	bh=3GQy5XeGx5dlqKdbk+YAzFV9pAUtw+CAm7QkZ9oa7K4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Usi5wTw5GvPp5jEdnE73F+2ak/DLU0s0B23yaEez9fb65d8aNtdrS00eK5Vw6zqqYw+egi4bKUh+RaHUNcFIxYd9Lg5taP2fFB1C6OmdlipuneU2IOGutsqQnzVtZ8dN6akt0lo+bkyOh+pBSjULB4/+9y8ZmNOXwk36XXUU49Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnWeCk4C; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnWeCk4C"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ef1dc934d1so881466d6.0
        for <selinux@vger.kernel.org>; Tue, 07 Jul 2026 17:31:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783470678; cv=none;
        d=google.com; s=arc-20260327;
        b=UoV4zabLdHlpu5YSap62sIZDc82qJ+4e5x5WAJmH0Ww8uMQ+p2pwEKBpUc30vXziOZ
         v8hXpLdVzTG8dWdcHgv8VOF2utCEesGwmFV3KakcjeCATVyOY71UOsaW8AF45asF/TN2
         k/5ud11HpUUmnvCfURr4jFSOHr7Hf4V6GRGaLoFSxaQ3iXwQKBinKRbhcE6I9aLY/iOg
         oZM/6easgEkiwgTxOETuZ6Bi4JAv2wPJgaO6pwAkcmsiLWaxNOq1+vFubEsbgaCljQMA
         342iZBbdUbNs1Mmq6nWn8vITJPZZLoPSjzP8zifn925YCk6t1YWuqVy1igimhs8+vibh
         gbgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7NuRayk8ACZHpU4jrCHbSE1b606laboR4aTU0FVg8Pw=;
        fh=9j3xEhedVJ77Wa0UZQAuaY8jliRZyL1ov+bfsPPad/Y=;
        b=N8v0DvaOfoOqGiHtPXXXWWMpVj0KHhuokIO79IqOTdBLXwuW7UfhXPRuiobvpnL+JI
         grh3wxPlbV1STQ8cSRT0dDcdnvkPX0EiS/67ABBYIcxqQnSVSJ98ZiWK26PawVuZNA57
         hxX/VnAlYM2Y8Onr3qHZU9almVAi+CuuxOPOdOB4PHccpy7CO8AzJ0h5DhTDqrGTHFNu
         c/7AvYRJXXIoJJMPGHKc26hGwC7sPSw2nQEeymp0Emc/lowxNyFFpXllVh5Uk1OEs2Iw
         h7bvdRJkm/sXwVnfjbhWi5V+BDc0Nfj1Gth1vKEGGvPCGfd6upaZ6wvZxHq+6+l5uNoA
         fgYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783470678; x=1784075478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NuRayk8ACZHpU4jrCHbSE1b606laboR4aTU0FVg8Pw=;
        b=hnWeCk4CLRCcyna84m2gJp6bz6KUTKNIHmGru2Ew1h5QUPXMhGR9Emu1g0IaCIlL5+
         Y+uxtS/pjs8uQAWF7M77ymQG+61p1v5bU0ckwlx+7mt2+INiA9ZIVe+cE41a+PVPnwzK
         j+qJPrY+Ywjx/8a5k+KHsMxQhSCW9F0AbtpV+sCHGgPy0rGC22HBGS84w3DxrQE2qUv5
         8dLPf5rv9ws8je2eqATR8H7cguYgRcweujYrTVyKZCnBfX1pykNdRuo7WgiHP9etePTl
         sBYbW7JAlCoFmiLVshbrQAU8LAXf5j5LXuhzD0FXpK8DnW5v1RbxzJ+YYXm82DytcY4F
         ufxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783470678; x=1784075478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7NuRayk8ACZHpU4jrCHbSE1b606laboR4aTU0FVg8Pw=;
        b=puWLX14pwv0yiTnwtwtNIMt6OYB7H8VUi3Dj7kFKuKYuLQiFTsVBL9J4hSrgNOE0Tm
         SqFvCHYHWlg/bQpH/eBg4RbrD9zEpmr5ciUNyLDN1O3dGqaPEsH+ju0+U+9H/EEVxgm9
         mmejEjq6c/YsjWGv04X7YP9QNqyj7OsBrhYtYCh31nE8W9DLMkmj7+wWWeiTgfBnU64Z
         0HvgZej4K/llZrpygtZ/7Aq4iLEvHna4sjn1Abl833Jd5v+KMbl1DCGMI4zQavp0tX/8
         j2v/gs046arF3/HZ2ZmgRlSmT7P7MoEM5ThGyiZ4vONggFU4kkX1UldT4wle2Nww31CM
         ifhA==
X-Gm-Message-State: AOJu0Yz1V1qxHd31Rp6OzlARKl33HUrE2N4XtQcpAostWjx/B1jTXXXy
	t09sGFPa1c1VBaQiIUSkGTGLAiZQn0a16JwvcJ6+zNCKIQYFgwY+ZqvtGhhDIOYECrmT+dBRGjT
	epQanZTk6vy6fiE/GQC+c+PXV0l8hVpqHA9Jx8lE=
X-Gm-Gg: AfdE7ckW7RQGr2khJwZuzRosiTi/FZdNSo82Pb1uaIW+uYCemFQn9JxB24D8sIT+6Jq
	aUHLQ0CsjN4f3JtGtRxJ7a3ZPLRqUwvY0DihckNTurddXJUvFhdQuo7kHNygrdAgTurJJR48jmP
	SC9vhf1yqmCle/HjFHQnxcaJemXgbOw8rRn4bMDXs5gt+Mod5/M/z7g/EOVozJI4wU3eDmDmcbu
	fUgUlSsCLGuUPdoKKPtsxqut1P35JwcHVF2bxvtvefBrIQWLdV8TgX1VADhSVetIpsADwiPgh0Y
	I4mcQ3gnCVYUL6/advp6lDPq9Q0=
X-Received: by 2002:a05:6214:554a:b0:8ef:8533:9651 with SMTP id
 6a1803df08f44-8fd3d111ae4mr65102316d6.36.1783470678614; Tue, 07 Jul 2026
 17:31:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708000956.46138-1-dwindsor@gmail.com> <20260708000956.46138-2-dwindsor@gmail.com>
 <20260708002030.53D9A1F000E9@smtp.kernel.org>
In-Reply-To: <20260708002030.53D9A1F000E9@smtp.kernel.org>
From: David Windsor <dwindsor@gmail.com>
Date: Tue, 7 Jul 2026 20:31:07 -0400
X-Gm-Features: AVVi8Cfeu7iTLKV4sdczNvssWGTRJZ9W34OAQImna28tK2X9fG0WUboNzUfP1yk
Message-ID: <CAEXv5_hyXHEKTfFCb9sSi=Z6B3W-PEue=x07sh_-Y56M7V=esA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 1/3] security: rework inode_init_security
 xattr handling
To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 8:20=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Heap buffer overflow in `security_lsmxattr_add()` due to xattr q=
uota bypass by BPF programs.
> - [Medium] `security_lsmxattr_add()` incorrectly returns `-EINVAL` instea=
d of `-EOPNOTSUPP` when the xattr array is not allocated.
> --
>
> --- Patch [1]: [PATCH v5 bpf-next 1/3] security: rework inode_init_securi=
ty xattr handling ---
> commit 871b3020e8c69372708886992716ee08d2e36bc2
> Author: David Windsor <dwindsor@gmail.com>
>
> security: rework inode_init_security xattr handling
>
> In preparation for bpf_init_inode_xattr(), a kfunc that lets bpf LSM
> programs atomically label new inodes, rework how inode_init_security
> xattrs are managed.
>
> > diff --git a/security/security.c b/security/security.c
> > --- a/security/security.c
> > +++ b/security/security.c
>
> [ ... ]
>
> > +/**
> > + * security_lsmxattr_add() - Add an xattr during inode_init_security
> > + * @xattrs: xattr state shared by inode_init_security hooks
> > + * @lsm_id: LSM_ID_* value identifying the calling LSM
> > + * @name: xattr name suffix
> > + * @value: xattr value
> > + * @value_len: length of @value
> > + *
> > + * Claim an xattr slot in @xattrs on behalf of the LSM identified by
> > + * @lsm_id and fill it with a copy of @name and @value. Callers can in=
voke
> > + * this function from non-sleepable context.
> > + *
> > + * Return: Returns 0 on success, -ENOSPC if the calling LSM's slot bud=
get
> > + *         is exhausted, negative values on other errors.
> > + */
> > +int security_lsmxattr_add(struct lsm_xattrs *xattrs, u64 lsm_id,
> > +                       const char *name, const void *value,
> > +                       size_t value_len)
> > +{
> > +     struct xattr *xattr;
> > +     void *xattr_value;
> > +     size_t name_len;
> > +
> > +     if (!xattrs || !xattrs->xattrs || !name || !value)
> > +             return -EINVAL;
>
> [Severity: Medium]
> Should this return -EOPNOTSUPP instead of -EINVAL when the xattrs array
> is not allocated?
>
> During file creation on filesystems without xattr support,
> security_inode_init_security() is called with initxattrs =3D=3D NULL,
> deliberately leaving xattrs.xattrs unallocated.
>
> If a BPF program then calls security_lsmxattr_add(), it will receive
> -EINVAL. If the BPF program propagates this error, it will abort the
> inode creation entirely because security_inode_init_security() only
> treats -EOPNOTSUPP as a graceful fallback.
>
> > +
> > +     name_len =3D strlen(name);
> > +     if (name_len =3D=3D 0 || name_len > XATTR_NAME_MAX)
> > +             return -EINVAL;
> > +     if (value_len =3D=3D 0 || value_len > XATTR_SIZE_MAX)
> > +             return -EINVAL;
> > +
> > +     switch (lsm_id) {
> > +#ifdef CONFIG_BPF_LSM
> > +     case LSM_ID_BPF:
> > +             if (lsm_xattrs_used(xattrs, XATTR_BPF_LSM_SUFFIX) >=3D
> > +                 BPF_LSM_INODE_INIT_XATTRS)
> > +                     return -ENOSPC;
>
> [Severity: High]
> Can this limit check be bypassed, leading to a heap buffer overflow?
>
> If a BPF program repeatedly calls security_lsmxattr_add() with a name
> that does not begin with XATTR_BPF_LSM_SUFFIX, lsm_xattrs_used() will
> not count them.
>

Sorry, all paths to calling this function are guaranteed to have
XATTR_BPF_LSM_SUFFIX.

> This allows bypassing the BPF_LSM_INODE_INIT_XATTRS limit. Since
> lsm_get_xattr_slot() does not check against the actual allocated heap
> size, it will increment ctx->xattr_count and return out-of-bounds
> pointers:
>
> include/linux/lsm_hooks.h:lsm_get_xattr_slot() {
>     ...
>     return &ctx->xattrs[ctx->xattr_count++];
> }
>
> Could this cause out-of-bounds writes when assigning xattr->value and
> xattr->name further down in this function?
>
> > +             break;
> > +#endif /* CONFIG_BPF_LSM */
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* Combine xattr value + name into one allocation. */
> > +     xattr_value =3D kmalloc(value_len + name_len + 1, GFP_NOWAIT);
> > +     if (!xattr_value)
> > +             return -ENOMEM;
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708000956.46=
138-1-dwindsor@gmail.com?part=3D1
