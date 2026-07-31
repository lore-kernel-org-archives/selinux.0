Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A9E2222AC
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 00:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785457854; cv=pass; b=jikrB5/cxa+gmXJou7rjxX2A8dU3VtesHcXgJs31DXtWidnn694bM5ybLkNJxEywX35tsgg4yQsqdqhEZys9yv1EAxxPsu/ufzNvnlA0qP7nea1A2lfIw+S0eWg8lxUobfllnJU/g/Be9ezpi1bmYesJRmg9TGHNbnbBvZizQ/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785457854; c=relaxed/simple;
	bh=kXfPPOebYPDWBl85UP8B8XOrtKMOHRhmU5KZ3uXt7Xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBdFZiDqQPIeYyHyxEkHqpnKPgR/w1lJ4nT4rmEY40anOOjsHZjUMFkeLg5P4Ze8QQVIC2T39rjC4ggfR0VLeovOc7++ah7azyl39dpAb67hPRXqWTig6tmLIMxHkSRlNZdw3PoPuAy9+zozdq8Ba2rKtsHxaRu1Kwm9YRlWDaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlQMF+Nb; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlQMF+Nb"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8ee43b3e5abso3613066d6.3
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 17:30:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785457852; cv=none;
        d=google.com; s=arc-20260327;
        b=YbUuy2axNDfi9YpVFvX9TtNhS/scIhuaYzl5SYDXl1ld7IiyaJwVZa2kBqeSI+75F4
         bElfJyhqLsiQnOl3BA5uwm3ne3HCDRdeS/j1T4czzvYwIOV3a5pxQrKPwaU/uuTupTkb
         Swoc5hIXchk//raPoDwBf39xFNBxNcOYMegZL9ciQOqxCf+ODqLoXrjta3smoiprjDoH
         ONFwMyzuYOHrsnbgPE6tRcz6tC5MlsSL3Yv/DGwC/8bshf2YLc6xo5hMvVk8t+xvq5Ez
         I+gccCMFk0S0XF6zS7a+554pltW7+tLX+g7uL1Uf6FTjPIprajDiJ+dHdkKIrDN/Ttvx
         +CxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BynZKIsVSQr3F1TFU0TVk73YY94J3F9HvqIoa9Y7ly8=;
        fh=nXNEyhxTK74vDYEygBbWOlHBSV7xBUaFXynM3xU6DpI=;
        b=lJoht893hWzU4+k8TFlgEn4WDmR3TzHn6D/nCbA08pq65l6gS25WC7gFAMp74gZDGI
         BZcjO733785wN3HSDxnnarJpAlX56j2d+DxKDO/g58P7FHo7grJ6R1VfFNmoXbpo+z3b
         XCvnWsu/ZUwjU4/OQeeiLKHqvFTTNOXzAyCYFraNtz2IMjdCLv4nIzBkyllXpxkIMfP3
         5qO4jSQiLmUczPOFgo/SLx0gXoxOhjWif47ARIOIsiXENsf71X0gOIp791IRRcfDvVK/
         6eRcvBCEbGw+nL1pimSfRA/gksJWXbb+T7zKOAplo5YIG2in14tLdXecJ0H0Gk8ZELnw
         yupw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785457852; x=1786062652; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BynZKIsVSQr3F1TFU0TVk73YY94J3F9HvqIoa9Y7ly8=;
        b=RlQMF+NbuVfQlwlrTknuL/DbLOi6ZU1MwIbd7k/2qwIlrGBNxcCpd2tsgOKVY53QB9
         RaOVQ/WTxJ22cA4J7KSMxse39A0L62ESJvdYGhA7h1unEfGjdnwTO4QCs4MUP7CY22wh
         lCpbwU1SJxlxXSLkrKbRnOK9xXwpnyANKdxhgvmuAImv0o4JaiKEW5wjyi4fG9wD2Z07
         2cEjGh83nZIyUD9OiM6tOr/jsy81U14ZkieiOFWVnfxWfcfpRgwbhmO9MY8nM3tWlgSL
         zf0m3NzfY4WwEyAF4rLQKqI4MKUDe9jRfsnVGiyojq+FDeZP29CiRivuE0I5Ffjtlytp
         +25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785457852; x=1786062652;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BynZKIsVSQr3F1TFU0TVk73YY94J3F9HvqIoa9Y7ly8=;
        b=UcmbFOik4d15YpdJOIB4E6M70uqC+NAT+M9oogAuAo+qlUwKFmoVBWpzh/PY9/RHFq
         YxHsHCzX2Oh8LsVzuhOFAXLSWAZrWq12qdb57DO1ffMKLc94030mMtq8O7bURVXrFoFq
         RC8A8soL5GmaZWZFOIQvy2xiSQLDSHjQHwgcPf3/9YxJM0Tjeg3hUgjaJNElOytg3Tbv
         m+AAVz2dtOHtLuK6eeSYysMBztmM8Mc4H8s5icNbIafTcQtKiNACFbn8jp8viFoajbJF
         M5LQ0OprudjE6GZwgiD8rnJHf8FXy6Xs+NI2ZHWCoPLfzu1gUEYjamJ/WQ2OSRINCPUH
         Xx6w==
X-Forwarded-Encrypted: i=1; AHgh+Ro1A5gFX8dMCriDxsI/1k8MQYT02nbtHwRDPjc24oyVH0n9htw/eC8cl2JOfxZrZ6DkzXordTQZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyoBhje3zzqvROfnLUoeJMAvxvXoU9EKtWxAPLyXSvwgO/cIojz
	5NSBhFO5fLrwB68AZKeibwdNo2D1pqN7uKKiwaCD0gXvXZAZ5w5MCoj3ixHCKVpbEeqPbWAzDsP
	J3z2RavBfguWBxRBDSLegiUgqs7FX/Go=
X-Gm-Gg: AR+sD13anmXtT1AFhEb2TVAIL4vW+hj4rsYNVOaPOCcGYAJzc0VZySfAcRXF3HZKY07
	1V7G9LLpd0kt6g7VoOXDL3Ngx5OMV/wlmSAvVoW6PBJFlcSj7KuPs4VGiQ+R7DHZdhchf1Y/XmM
	ZywuY7Gq7JLIkT0UYuxTJDWSa0Rzd4tSmyAqzrXp+lejR8t8C/Aa8Lgx5VTYQMWkjkwT0FYV8qp
	PigquSgaAu2i6ujVs3nBRX2JkExT2faskoiG/C0jWHrklhXanrud8EFRGo7pTXAgzDKn2woHpUM
	RwdluYEKV9PBBL88wiGfBf4UlNP4JYPL8tQxI3GrU1KpWfXPziHM7RNChkCl71ABcEgN/s9pU0w
	=
X-Received: by 2002:a05:6214:ac2:b0:8fd:6de3:dd78 with SMTP id
 6a1803df08f44-90842411b43mr799656d6.58.1785457852231; Thu, 30 Jul 2026
 17:30:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-3-dwindsor@gmail.com>
 <20260731000002.576791F000E9@smtp.kernel.org>
In-Reply-To: <20260731000002.576791F000E9@smtp.kernel.org>
From: David Windsor <dwindsor@gmail.com>
Date: Thu, 30 Jul 2026 20:30:40 -0400
X-Gm-Features: AUfX_mxUC87VovUpF6S3n0z22UxNvx0DUvlrhBrcBBLnihCTSSPd1G8mlTOLx6g
Message-ID: <CAEXv5_gTJcP5BkSysZujLxiUcjbbBNi_NNbAnOJsQQVLyO9HoQ@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 2/4] security: add security_lsmxattr_add()
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 8:00=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> > +int security_lsmxattr_add(struct lsm_xattrs *xattrs, u64 lsm_id,
> > +                       const char *name_extra, const void *value,
> > +                       size_t value_len)
> > +{
> [ ... ]
> > +     /* Combine xattr value + name into one allocation. */
> > +     xattr_value =3D kmalloc(value_len + name_len + 1, GFP_NOWAIT);
> > +     if (!xattr_value)
> > +             return -ENOMEM;
> > +
> > +     memcpy(xattr_value, value, value_len);
> > +     memcpy(xattr_value + value_len, suffix, suffix_len);
> > +     if (extra_len)
> > +             memcpy(xattr_value + value_len + suffix_len, name_extra,
> > +                    extra_len);
> > +     ((char *)xattr_value)[value_len + name_len] =3D '\0';
> > +
> > +     xattr =3D lsm_get_xattr_slot(xattrs);
> > +     if (!xattr) {
> > +             kfree(xattr_value);
> > +             return -ENOSPC;
> > +     }
> > +
> > +     xattr->value =3D xattr_value;
> > +     xattr->name =3D (const char *)xattr_value + value_len;
>
> [Severity: High]
> Does this code cause a use-after-free for filesystems like ocfs2?
>
> Looking at ocfs2, the ocfs2_initxattrs() callback saves the xattr->name
> pointer directly into si->name, assuming it has a static lifetime (which
> was true for SELinux and Smack):
>
> fs/ocfs2/xattr.c:ocfs2_initxattrs() {
>     ...
>     si->name =3D xattr_array->name;
>     ...
> }
>
> But here xattr->name points inside the dynamically allocated xattr->value
> block. When security_inode_init_security() completes, it frees
> xattr->value:
>
> security/security.c:security_inode_init_security() {
>     ...
>     ret =3D initxattrs(inode, xattrs.xattrs, fs_data);
> out:
>     for (; xattrs.xattr_count > 0; xattrs.xattr_count--)
>         kfree(xattrs.xattrs[xattrs.xattr_count - 1].value);
>     ...
> }
>
> After this free, ocfs2_mknod() will call ocfs2_calc_xattr_init(), which
> dereferences the now-dangling si->name pointer:
>
> fs/ocfs2/xattr.c:ocfs2_calc_xattr_init() {
>     ...
>     s_size =3D ocfs2_xattr_entry_real_size(strlen(si->name),
>                                          si->value_len);
>     ...
> }
>
> Could the dynamically allocated name trigger a use-after-free here?
>

This is real. ocfs stashes the name pointer beyond the call; it's the
only fs who does so. We can special-case ocfs and be done with it.
Will do this in v7.

> > +     xattr->value_len =3D value_len;
> > +
> > +     return 0;
> > +}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730234533.19=
12709-1-dwindsor@gmail.com?part=3D2
