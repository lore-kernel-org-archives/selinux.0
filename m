Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118B327F4CB
	for <selinux@vger.kernel.org>; Thu, 24 Apr 2025 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509227; cv=none; b=fnEJnqXext9Rn3PKdNDGucoPip2HYx0f/Sm5BgSNpa6BKaUbVkjcZM21ktojQM1RdFzlxDO1dPML1CEoXQR7qGRn440mQH9vymqmMXh02dpuil5S46ZY4LBRAbJlMAh4rJyOT5DHb8hKgh0c7KYGdOuIyiA5Z5eWoC3NwBo7YVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509227; c=relaxed/simple;
	bh=2kU4zcvrL7YbCjnkq7n+jO3UxoN5TmVVEjgW6RQAS3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=m+/zPeCL5R8/IoWL7d7JGmXTHRCrGAxOc6tpCOcjaZ+HMw9kblVdZgsDBLTCrlEn3ntoQrSbkfvtg3VEPbn/y/7g93ZXJThctnqYdAfjYus9niquyud6+cZx0ozf6bnsQNxzvyAQ0za1tsZU7cpEBJVe2huVqXRkeVkaBZj8oMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMBwdwf6; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMBwdwf6"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736bfa487c3so957537b3a.1
        for <selinux@vger.kernel.org>; Thu, 24 Apr 2025 08:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745509224; x=1746114024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pElVRnbM8O/DhK/o5KfXpu3krpqXcfDKNkQNvTEfW/E=;
        b=LMBwdwf6eKrFzDglb1kzXnPXxONx0B/bqXqb5AQebsMxlyWDJLC1QQh7JwHqsg+1t+
         B3LTZJ4E5Ia5M2o6cpbd9VoJBm8mQHcyqxNZoRC4848OodgC6pPxRli5wFm7ZPMjc+/N
         9CJO9z5a5OjiWdSM8Yb9rQ4XdZuJ/DxRrL+VY2jsTqVlPiBqusITYXJ9u/o/gwGHnkAm
         +aSh5SUueUsAnzNCs76db2sQXfY2VB3EuJ0M5yyr8cVXFMPpGyJGtvAcszZhhUvROCNd
         k1u6CWZAA3Ng+U4DnsPFu+FF/yx8uPUO+V3YKpXVtFvCdFcSlRtzo/PTzaTakI4T+6x/
         RbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745509224; x=1746114024;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pElVRnbM8O/DhK/o5KfXpu3krpqXcfDKNkQNvTEfW/E=;
        b=ioFvvnORXjjSqkYq8YMLq4wItG+yZhMXMWJJtHUR6ZvnAmZunWhvCvH/sG0PxK1AOD
         i9vxbCp0ruTAEmePWz3mlSs0XSi5YJ4eVfTH4Qcval1nRK1GU9oMMAbuwJDGP7lLUOF/
         KCG2fl01kqfLt32sHHcrNmiwxGfOtgPz1oLQ5fZAOrrrjw3mHh3s3Zoam40c23EMUTB1
         BRNJrTD2I8eJj5sGuy5QdlzdtSANYLnn2tdnMdVV0ZMkdG9vWlMFNDo8Phvwt1k9yOSZ
         ykNgIWk/JriWbUDZx8CtDUTU+9nkw7gFstg6CJdzsdmV9/7tmE4uvII/ZXzDBFwMnWVo
         S9dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs/hPg109EwjYb1u3eE2J7G+utEq4Eu3XPD3VVdwuEtTJCCdu+qA2KJeezWNkIXD5cAPQcILVD@vger.kernel.org
X-Gm-Message-State: AOJu0Yznpu8QlKshBqnRXCBf+205ei4XyesyH/wrt2mmVQCpw954Zjie
	C5gvSV2Wdb0IQoETnr3X39W9gqeslR2t/UHQ3VEpyeT2KLRLfc5ITghlVDOM7+y8r0k3T3sdDEt
	v3b5/gufoz2GndDZ91B3YLbBsJzA=
X-Gm-Gg: ASbGncu+Uv8ywBtLviNqW9eRuTyUuveBl2ssdrB4AtjWz6DWzWOl7yV/W5yE59Gs9Cw
	Y1LhdsDfr2kMgjdNvpVvyBE6NSx4gZHWHjtNKkRBCp+YJtUQFJxgS3pJf6dRWLn2KFiyiplrt78
	b0MkTHClJ/KulNdx+WC1RMEg==
X-Received: by 2002:a05:6a00:1c92:b0:736:34ca:deee with SMTP id
 d2e1a72fcca58-73e32fb2b6fmt232020b3a.7.1745509224234; Thu, 24 Apr 2025
 08:40:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424152822.2719-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20250424152822.2719-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 24 Apr 2025 11:40:13 -0400
X-Gm-Features: ATxdqUG3sr40DXPqU7DwPGb7IBjfQ5iQvZE5Wbb_bSEPGq081PqgLufaGeVqmLk
Message-ID: <CAEjxPJ6V8aApDHaiU2+8pfDzf7S-bpgdFO3X6UHjRdCNFUNhXw@mail.gmail.com>
Subject: Re: [PATCH] fs/xattr.c: fix simple_xattr_list to always include
 security.* xattrs
Cc: paul@paul-moore.com, omosnace@redhat.com, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 11:28=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The vfs has long had a fallback to obtain the security.* xattrs from the
> LSM when the filesystem does not implement its own listxattr, but
> shmem/tmpfs and kernfs later gained their own xattr handlers to support
> other xattrs. Unfortunately, as a side effect, tmpfs and kernfs-based
> filesystems like sysfs no longer return the synthetic security.* xattr
> names via listxattr unless they are explicitly set by userspace or
> initially set upon inode creation after policy load. coreutils has
> recently switched from unconditionally invoking getxattr for security.*
> for ls -Z via libselinux to only doing so if listxattr returns the xattr
> name, breaking ls -Z of such inodes.
>
> Before:
> $ getfattr -m.* /run/initramfs
> <no output>
> $ getfattr -m.* /sys/kernel/fscaps
> <no output>
> $ setfattr -n user.foo /run/initramfs
> $ getfattr -m.* /run/initramfs
> user.foo
>
> After:
> $ getfattr -m.* /run/initramfs
> security.selinux
> $ getfattr -m.* /sys/kernel/fscaps
> security.selinux
> $ setfattr -n user.foo /run/initramfs
> $ getfattr -m.* /run/initramfs
> security.selinux
> user.foo
>
> Link: https://lore.kernel.org/selinux/CAFqZXNtF8wDyQajPCdGn=3DiOawX4y77ph=
0EcfcqcUUj+T87FKyA@mail.gmail.com/
> Link: https://lore.kernel.org/selinux/20250423175728.3185-2-stephen.small=
ey.work@gmail.com/
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Fixes: b09e0fa4b4ea66266058ee ("tmpfs: implement generic xattr support")

> ---
>  fs/xattr.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 02bee149ad96..2fc314b27120 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -1428,6 +1428,15 @@ static bool xattr_is_trusted(const char *name)
>         return !strncmp(name, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_=
LEN);
>  }
>
> +static bool xattr_is_maclabel(const char *name)
> +{
> +       const char *suffix =3D name + XATTR_SECURITY_PREFIX_LEN;
> +
> +       return !strncmp(name, XATTR_SECURITY_PREFIX,
> +                       XATTR_SECURITY_PREFIX_LEN) &&
> +               security_ismaclabel(suffix);
> +}
> +
>  /**
>   * simple_xattr_list - list all xattr objects
>   * @inode: inode from which to get the xattrs
> @@ -1460,6 +1469,17 @@ ssize_t simple_xattr_list(struct inode *inode, str=
uct simple_xattrs *xattrs,
>         if (err)
>                 return err;
>
> +       err =3D security_inode_listsecurity(inode, buffer, remaining_size=
);
> +       if (err < 0)
> +               return err;
> +
> +       if (buffer) {
> +               if (remaining_size < err)
> +                       return -ERANGE;
> +               buffer +=3D err;
> +       }
> +       remaining_size -=3D err;
> +
>         read_lock(&xattrs->lock);
>         for (rbp =3D rb_first(&xattrs->rb_root); rbp; rbp =3D rb_next(rbp=
)) {
>                 xattr =3D rb_entry(rbp, struct simple_xattr, rb_node);
> @@ -1468,6 +1488,10 @@ ssize_t simple_xattr_list(struct inode *inode, str=
uct simple_xattrs *xattrs,
>                 if (!trusted && xattr_is_trusted(xattr->name))
>                         continue;
>
> +               /* skip MAC labels; these are provided by LSM above */
> +               if (xattr_is_maclabel(xattr->name))
> +                       continue;
> +
>                 err =3D xattr_list_one(&buffer, &remaining_size, xattr->n=
ame);
>                 if (err)
>                         break;
> --
> 2.49.0
>
