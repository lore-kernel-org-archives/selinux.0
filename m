Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE06034EF15
	for <selinux@vger.kernel.org>; Mon, 23 Feb 2026 09:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771840156; cv=pass; b=XiQJNpWtESSJXuNt4TtT4OzbI2Zvv3AyOPIp9v0hAk6rzD7jkIGQe8aL+aNrhgvwJrlN+l5KW9DifKvlIXGPhl1e2FApDicSYre0btHOcDpYnnOP9CGDEQ8HkhKmaPoZG9QzPziJ4Ivm5O+vNjUgVCZBg3T1mHhpqB47N1qslLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771840156; c=relaxed/simple;
	bh=Xh4bjPWHtF+IO6/pJTbboimYkYntcuZV8mtoP+YljlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hAOrYhhsKX7E498SWc1UgBl7z/eJhtblEI2nnWJKK4qWkCyV5JI2Dm2J9kI3VkCkXq5Jxdt3KHK9Gmljl71dEo0p/EYx8cKUDenPpMzomY3LWSZiGk9rUCfHNszS8QvboGmpqlqz574WDhItzUsS9IZh4klB8E8+ovUPWCNVJj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsjZlfRu; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsjZlfRu"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4362507f0bcso2886754f8f.0
        for <selinux@vger.kernel.org>; Mon, 23 Feb 2026 01:49:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771840152; cv=none;
        d=google.com; s=arc-20240605;
        b=hraKWXJPLO0JVZCrqWGDYxrT9i6bo1IJO8ht0B6gSeMeK7K2HDTw3Gu27CMU2e2XmG
         giL9eG5BiXdclGVMXhCflgqe3YysvBZ9pXAfO8EWZ4e5BBMY66JqUCk/OMbMhAmlvg1b
         enHrL4X+IG4nGDNnu5OUjSNKyK5YNoZN51XJk15Kf2Ev+jNs81oE7M/YjPETy9EAGOR2
         i2zAV88LRbLLby22gWygknzeCT7tOCwkTSyijnVzEIG02q6Jj+FEOej7wu04VI9BpEq3
         NvXW42Dw1ovG849hvUnpfmF0cwQEzHKC/xu4h9uw6hWFQslva6HAYvq9uWWSl1dHyzdG
         d+iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2/el3cFDhCdryFwCuaSLEKRCesYmHLj0qrChriFmVgE=;
        fh=Bi7InJx+3qw6msxkyyP2yDNrIM3F/3nzYrt3f0mUxj8=;
        b=JYNYmZCUddEBnO6huJT5X4Ww9G6uhzRK1e5q2nNyuDVGLrzww3DjAVTuJ+NUr/p/NP
         Q6UA/0XA9/Jlcky6G2DtK19H2xUb7/8fvk1ID6lOfYDir7N2s4PLBDOQjvyNiRpNPw+9
         WAk+wAHVktJBp+ZfKPNw8Hw26C+ooky69hstT+l7OzzR4sGLhAgczVhWZA5R7pXEoOqL
         s2mBwQTpyx7n6Sryyq4O4+2oCBv3bMHnVHfCG4XUu69jMQ1E/ac87GhyNKhj/DG0gfnP
         y46cvJwUQt8j66q+M2zwPNyk+CYynsCWqM6qIWvqpr2S18FmZJoqfbYNswGwjonsi7lK
         IbzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771840152; x=1772444952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/el3cFDhCdryFwCuaSLEKRCesYmHLj0qrChriFmVgE=;
        b=VsjZlfRucprXXOxcNuewJuffOlegZKKI002qWZs6ZknVE5gsDu7XvFbdD5dYC0pBHF
         hYL4t9/tAM4Ib47GjXqtmt1+txReBN2DP219k3nvQ58w/bzLOsKfBpZjvSqR75boT8f9
         l+9GG23LZCTKykPI9++AyA0AG0BF9yl5B0HKfazfIfR+B9QAaUXlw2yg1KK7EwCHKbro
         JpHGhiGOxZcrJ+a+weU45TKUUDyC2y/I5985HYfX8JLsIxEsVfU5Em8XgO6/ZZ2VzSmf
         m+KZ5Xz8wLZqWkRdq6LqW0MPFKwCBu21z91i8tk3RhrOlHD3gF2z9uT7Kjk50oW693rW
         dBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771840152; x=1772444952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2/el3cFDhCdryFwCuaSLEKRCesYmHLj0qrChriFmVgE=;
        b=k6AgwqQX+EJPuRefbboTv4P1gjyqHOaknEs8heQSZSC4EUxBpPOZRml6T1Hci4uL+M
         EVwe+6Tqbd3/bAee6j6HpLDD0Fw/KczmcQJULGArIrupymf2jh0AwS7viD/uJpQfJw8h
         /pzHzdC05dt7P3QOvbh5WL56ejFS1CtaoBrBfUfU57IpIibFKI8xwGQb9N7EyvlY1XPR
         25WC07TecjvO8cY2OUwSMRK0+pSEnvJc8uFfJGA1zjGhL/N1BpcrQ1p5K4HtjR+qi32d
         OYcfAALUvXlE4FPoU5j3yaJcs5uo4CSzwy3mNDTDV/RFcUhgCOuEYK0d3CXrsWwA4mDj
         RbLg==
X-Forwarded-Encrypted: i=1; AJvYcCVTsOY+fSqXZ6PmGxE63GHaHkk4FIJZYwiYylatfFcKLi5M/nMteWjvudvxNM0djQaZlOasKVeb@vger.kernel.org
X-Gm-Message-State: AOJu0YwltiRtxkc83mzMM+NkvN+R9x6XLmG4PRusoPHfFgysZGGg+cfV
	l0b6ay5ZJHzpNP6Le7VYAsaTmLS+QDMA4EYEIooMyeZdphUdtJ9HjEEV//eDYUP0hJy5awetno5
	DicB2yDEBQ+H/znsr1o9D1UsKi8G+hbc=
X-Gm-Gg: ATEYQzwZb+fbxaVZEjW0rAlNbrR4X+OMrxW5y0+SsQZ2jjkqO9PrnxHg1o1ALl3LNFP
	du5trdeEWYF7w1RRXWOxCdA5yXar21rBsFSsTZ2W6NG+uYBORZwPXb9ogmlxz1gaeZP0zovOXyA
	UY82fx2ONbhmTTgAzZoq9/223OPW9oLx1DTS8fkLGDTGHdzZzl3uJJm07AKUOcmas6PYWuLnMOD
	6Im0jZZNMWagTf9tSGlrD6itwptxUwe3k5AkMB191+ChlMaNXzfKcd0WKEBHzRV8maOdh9v3A1Y
	r0FH2op1hzMdYvx2QtvQsUMUymrLjfk9CfCMm7eloQ==
X-Received: by 2002:a05:6000:4014:b0:437:6aa8:b7eb with SMTP id
 ffacd0b85a97d-4396fd9b885mr14177751f8f.5.1771840152054; Mon, 23 Feb 2026
 01:49:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223011210.3853517-1-neilb@ownmail.net> <20260223011210.3853517-10-neilb@ownmail.net>
In-Reply-To: <20260223011210.3853517-10-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 23 Feb 2026 11:49:00 +0200
X-Gm-Features: AaiRm53oCa-QOult778vTlpI836VKQ_vX_Rm7xdLmLP8dTvXCc4lfRf1Ct2RZiU
Message-ID: <CAOQ4uxjtedA8B1QZDddRtsSP0XgFZCuBTD1VGvN4wawRyoox=A@mail.gmail.com>
Subject: Re: [PATCH v2 09/15] ovl: Simplify ovl_lookup_real_one()
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 2:13=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> The primary purpose of this patch is to remove the locking from
> ovl_lookup_real_one() as part of centralising all locking of directories
> for name operations.
>
> The locking here isn't needed.  By performing consistency tests after
> the lookup we can be sure that the result of the lookup was valid at
> least for a moment, which is all the original code promised.
>
> lookup_noperm_unlocked() is used for the lookup and it will take the
> lock if needed only where it is needed.
>
> Also:
>  - don't take a reference to real->d_parent.  The parent is
>    only use for a pointer comparison, and no reference is needed for
>    that.
>  - Several "if" statements have a "goto" followed by "else" - the
>    else isn't needed: the following statement can directly follow
>    the "if" as a new statement
>  - Use a consistent pattern of setting "err" before performing a test
>    and possibly going to "fail".
>  - remove the "out" label (now that we don't need to dput(parent) or
>    unlock) and simply return from fail:.
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: NeilBrown <neil@brown.name>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/export.c | 71 ++++++++++++++++++++-----------------------
>  1 file changed, 33 insertions(+), 38 deletions(-)
>
> diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> index 83f80fdb1567..b448fc9424b6 100644
> --- a/fs/overlayfs/export.c
> +++ b/fs/overlayfs/export.c
> @@ -349,69 +349,64 @@ static struct dentry *ovl_dentry_real_at(struct den=
try *dentry, int idx)
>         return NULL;
>  }
>
> -/*
> - * Lookup a child overlay dentry to get a connected overlay dentry whose=
 real
> - * dentry is @real. If @real is on upper layer, we lookup a child overla=
y
> - * dentry with the same name as the real dentry. Otherwise, we need to c=
onsult
> - * index for lookup.
> +/**
> + * ovl_lookup_real_one -  Lookup a child overlay dentry to get an overla=
y dentry whose real dentry is given
> + * @connected: parent overlay dentry
> + * @real: given child real dentry
> + * @layer: layer in which @real exists
> + *
> + *
> + * Lookup a child overlay dentry in @connected with the same name as the=
 @real
> + * dentry.  Then check that the parent of the result is the real dentry =
for
> + * @connected, and @real is the real dentry for the result.
> + *
> + * Returns:
> + *   %-ECHILD if the parent of @real is no longer the real dentry for @c=
onnected.
> + *   %-ESTALE if @real is no the real dentry of the found dentry.
> + *   Otherwise the found dentry is returned.
>   */
>  static struct dentry *ovl_lookup_real_one(struct dentry *connected,
>                                           struct dentry *real,
>                                           const struct ovl_layer *layer)
>  {
> -       struct inode *dir =3D d_inode(connected);
> -       struct dentry *this, *parent =3D NULL;
> +       struct dentry *this;
>         struct name_snapshot name;
>         int err;
>
>         /*
> -        * Lookup child overlay dentry by real name. The dir mutex protec=
ts us
> -        * from racing with overlay rename. If the overlay dentry that is=
 above
> -        * real has already been moved to a parent that is not under the
> -        * connected overlay dir, we return -ECHILD and restart the looku=
p of
> -        * connected real path from the top.
> -        */
> -       inode_lock_nested(dir, I_MUTEX_PARENT);
> -       err =3D -ECHILD;
> -       parent =3D dget_parent(real);
> -       if (ovl_dentry_real_at(connected, layer->idx) !=3D parent)
> -               goto fail;
> -
> -       /*
> -        * We also need to take a snapshot of real dentry name to protect=
 us
> +        * We need to take a snapshot of real dentry name to protect us
>          * from racing with underlying layer rename. In this case, we don=
't
>          * care about returning ESTALE, only from dereferencing a free na=
me
>          * pointer because we hold no lock on the real dentry.
>          */
>         take_dentry_name_snapshot(&name, real);
> -       /*
> -        * No idmap handling here: it's an internal lookup.
> -        */
> -       this =3D lookup_noperm(&name.name, connected);
> +       this =3D lookup_noperm_unlocked(&name.name, connected);
>         release_dentry_name_snapshot(&name);
> +
> +       err =3D -ECHILD;
> +       if (ovl_dentry_real_at(connected, layer->idx) !=3D real->d_parent=
)
> +               goto fail;
> +
>         err =3D PTR_ERR(this);
> -       if (IS_ERR(this)) {
> +       if (IS_ERR(this))
>                 goto fail;
> -       } else if (!this || !this->d_inode) {
> -               dput(this);
> -               err =3D -ENOENT;
> +
> +       err =3D -ENOENT;
> +       if (!this || !this->d_inode)
>                 goto fail;
> -       } else if (ovl_dentry_real_at(this, layer->idx) !=3D real) {
> -               dput(this);
> -               err =3D -ESTALE;
> +
> +       err =3D -ESTALE;
> +       if (ovl_dentry_real_at(this, layer->idx) !=3D real)
>                 goto fail;
> -       }
>
> -out:
> -       dput(parent);
> -       inode_unlock(dir);
>         return this;
>
>  fail:
>         pr_warn_ratelimited("failed to lookup one by real (%pd2, layer=3D=
%d, connected=3D%pd2, err=3D%i)\n",
>                             real, layer->idx, connected, err);
> -       this =3D ERR_PTR(err);
> -       goto out;
> +       if (!IS_ERR(this))
> +               dput(this);
> +       return ERR_PTR(err);
>  }
>
>  static struct dentry *ovl_lookup_real(struct super_block *sb,
> --
> 2.50.0.107.gf914562f5916.dirty
>
