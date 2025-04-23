Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43D02701A3
	for <selinux@vger.kernel.org>; Wed, 23 Apr 2025 22:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745447522; cv=none; b=rsld+OIFc+3vdbsTDH7qc+tUceACqmbXcEjOt4l6fXxkw2sl1fGitD1JStKFsEbDmEb8W/uIIVqoQ1SxtF9ezcwXCyddiKxkL2wTcJBe/g8Jx1uoqoVQ4ds3FWdiYrIlyX5kFYVmnmS/UzbnEOU8XO7W6IjdSzjgoaPIBCHfNzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745447522; c=relaxed/simple;
	bh=Or46tWiGL9r3Ns5JzF0cRMTU4w+eg1+TMR0AvK+hVe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGBZHzm416oB8BjObln36Ses3U1YsEoBqfiznfICW7AekkMCRUWpdqvXKeWP8HPKlCz5NO9kNMwylodnF8WitjcU5fK4I6b8bfGKc7A6SudS7gOvpP3/cevjdIVoLlrKD4g8SNCjsPFYOcxqBPHMaBeJDdQMXGb6D0b+y3q+3M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZPoHSJ2f; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZPoHSJ2f"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e717c3dab43so269482276.2
        for <selinux@vger.kernel.org>; Wed, 23 Apr 2025 15:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745447519; x=1746052319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVvfgcg0+5bOqkFRLPAAjP4TQkpuocYoEtwbkSrmtpA=;
        b=ZPoHSJ2feaoMfRrqhab7CX+A/hrlT1/Nj09jt/jwgsBMiG/I5A7yzfGN8jcQnGqZPu
         /Ft+EsLQ2GRmYMlQZF8v5tIE1mI/9EGCi6Q4zFN53h7ejH4GS7SCseTh1unK7WRBdTkC
         avgDeeH0z2+4WGr9gq5lDGPD/Ls1lT8y1wP6HEleQQsqHeUOd51ufrJuQjSeYUO3wifD
         xp+m13nbcQfOhlqc3SiGYykEndNDbAzXM11LGRnhfz+NWlZ4xdLg/KR4tAKRVFyOG7xe
         a6y+yB9sXtCTk3oQV3B4k59QB+2iqnw7u1bHseMi1RT5A03gOs3jPjQkigrcUPpZeoI7
         ub2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745447519; x=1746052319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVvfgcg0+5bOqkFRLPAAjP4TQkpuocYoEtwbkSrmtpA=;
        b=QYWmFObvgKAYJ4UBZ7LxM0IC84k+o9j/FtDUtNb4Gzzun2a7DxfxGHrsk1ks+ORYnO
         LbzQMoqHZk8ubfcKk1C43+1cCVc5pYdI11wunFS/5QQP9RnTQSs/5Vr6qyRsHhi7G4L+
         IVsiyApl+BmM13P/VmkXR+0QrhUXLCeJXoPpjFu9Cmg4DMDsYrVz2OD/Ptsqr+Tg9qpT
         GUQxK3NzU43RvpCiKejbtCX/Bq+KbrHJZwJg8FNv+cj5JOubwa4iFRshK0tfIheJAKXG
         3bEzTnBzFBASVlDgLl5vpo7iKzO6ZIrO2fngXSoQWjI+L4vXIzevOYuyTN4TNpoxIAWD
         uUWw==
X-Gm-Message-State: AOJu0YxuO/PTl89MHW/H3pShv5JmyOkRphQRymT26fbapjUz+OcdL8Sl
	xSm59wqIk99iI5y62Dyzy2lxXMKH1qWy6KPT9WNqsVf583OlWR84Ec5XSJZ+ByXO9DlODwMe+un
	zCg0TIvqymvfe72cVUl2ayRUMD+uTwBS/BP4D
X-Gm-Gg: ASbGncsvhcGTfyJXEfJYn49kPZEPENcAFeQZRMrFsA2a//Egi6xb/Hh01yVfts3nUjp
	rUKVskZg1ohFmgLpvWLl7guXhSL1+0ZacJTvi8jjvzcxuidroioZ2XqCMUPpLKjbaFsbvHbJLzH
	FkSD3ls+RstCbVxkO3keku8Q==
X-Google-Smtp-Source: AGHT+IEdHa4CdrVL7HTwU8DWPF8KEXJDFzRfRh0CtUFkvRHsHpk6qJd+/3DvM0M31SuDBnhGRcGv1XXadYYDTGf1KMM=
X-Received: by 2002:a05:6902:18c4:b0:e39:8e5f:adab with SMTP id
 3f1490d57ef6-e7303600d3amr865570276.39.1745447519537; Wed, 23 Apr 2025
 15:31:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423175728.3185-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250423175728.3185-2-stephen.smalley.work@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 23 Apr 2025 18:31:48 -0400
X-Gm-Features: ATxdqUE32KEOqlp_2ibuDgVpS6jFKUqzifQvQ4Ym1u8Otc3ZgrfdOM9YrKngZtc
Message-ID: <CAHC9VhR6gjRpR5-DDiSrnrSOa66Cjr7XyKRJSnsuLcNHi9UD2A@mail.gmail.com>
Subject: Re: [RFC PATCH] shmem: fix listxattr to include security.* xattrs
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com, nvraxn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 2:00=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The vfs has a fallback to obtain the security.* xattrs from the
> LSM when the filesystem does not implement its own listxattr, but
> shmem/tmpfs has its own handlers. Consequently, it fails to include
> the security.* xattr unless explicitly set by userspace, which confuses
> ls from coreutils.
>
> Before:
> $ getfattr -m.* /run/initramfs
> <no output>
>
> After:
> $ getfattr -m.* /run/initramfs
> security.selinux
>
> Link: https://lore.kernel.org/selinux/CAFqZXNtF8wDyQajPCdGn=3DiOawX4y77ph=
0EcfcqcUUj+T87FKyA@mail.gmail.com/
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> NB This only handles shmem/tmpfs inodes, not sysfs or others.

I believe applying a similar change to kernfs_iop_listxattr() should
solve the problem for sysfs as well as a few others.

We could also look at moving the security_inode_listsecurity() call
into simple_xattr_list(), but I'm not sure what other implications
that may have.

FWIW, if we need to modify security_inode_listsecurity() it shouldn't
be that hard, only SELinux and Smack provide callbacks and both are
trivial.  In fact, there might be some value in adjusting the LSM hook
to better match xattr_list_one() (even if the LSM supplies multiple
xattrs), and then leverage xattr_list_one() (multiple times if
necessary for a LSM) inside the LSM's callback.  That doesn't solve
our problem, but it simplifies the LSM code and moves the buffer
manipulation back into the VFS code.

> It also doesn't handle the case where some xattrs are set on the inode
> but not the security.* xattrs. Not sure if that's possible currently.

Good question, I'm not certain either, but my guess is that if the
filesystem has implemented its own listxattr code and omitted the
security.* xattr listing, it makes use of xattrs for something other
than SELinux/LSM.

> It would be problematic not to mention ugly to check for the presence
> of a security.* in the buffer after the simple_xattr_list() call
> since the buffer/size can be NULL/0 to just query for the buffer size.

Sigh.  Yeah.

If we know the filesystem is not persistent and we don't have to worry
about other system boots, offline edits, etc. it might almost be
easier to have simple_xattr_list() skip security.* xattrs (it already
does this for trusted.* xattrs) and rely on
security_inode_listsecurity() to supply the security.* xattr names.

> diff --git a/mm/shmem.c b/mm/shmem.c
> index 99327c30507c4..49256ca11400c 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -4372,7 +4372,11 @@ static const struct xattr_handler * const shmem_xa=
ttr_handlers[] =3D {
>  static ssize_t shmem_listxattr(struct dentry *dentry, char *buffer, size=
_t size)
>  {
>         struct shmem_inode_info *info =3D SHMEM_I(d_inode(dentry));
> -       return simple_xattr_list(d_inode(dentry), &info->xattrs, buffer, =
size);
> +       ssize_t sz =3D simple_xattr_list(d_inode(dentry), &info->xattrs, =
buffer,
> +                               size);
> +       if (sz =3D=3D 0)
> +               sz =3D security_inode_listsecurity(d_inode(dentry), buffe=
r, size);
> +       return sz;
>  }
>  #endif /* CONFIG_TMPFS_XATTR */
>
> --
> 2.47.1

--=20
paul-moore.com
