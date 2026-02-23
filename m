Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FADB34EF02
	for <selinux@vger.kernel.org>; Mon, 23 Feb 2026 09:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771839328; cv=pass; b=laA3S1nBAL1c3WrquDG0jgSIfUw8OvsFU5Q7CtXGT0Qmlc1rcIhb1v2K16/DS/gJ+LoYU5N9N50ekXEP9Y5dL6rKP/50UjygmhxxpBToD2u6vU9RSrD4hzhR1/4mQgtmPhuyQ7bST1f79Ii3MsBGswXtFHk/XRR62ZCebvXjV94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771839328; c=relaxed/simple;
	bh=mAAOjC5VpT1HkXsRAwtGw0eUE/35I2Skqe677nArRZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tvgkJLyGgNlE1jxFTKHuF08XuXeEBoAUS0TNyQ8C92mJWOkTP7B5gJU5lp8sLYPO1kpmLGclvSLrKHfdfAs+Ubh/L9pS4wrXmXL//b23kWDu+uvxuXxVklM4Lrc947eLv1Zz+dk4skdPpfBcJPUEcbgWivlCGjjmcSlDDsdyjfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvjUXwJM; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvjUXwJM"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b8f9b5240a2so524393166b.0
        for <selinux@vger.kernel.org>; Mon, 23 Feb 2026 01:35:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771839326; cv=none;
        d=google.com; s=arc-20240605;
        b=VWGkMJWTciFexoadK/t4GnieO/kAn7JXn6vZXGkCrpjc+r3CePDE6l0DAHNY5fBO6W
         LBKLopZHlgtqtv/jgYKaYm+tz+IZHVLfXwWcaZREla/kBqP1L4SDbhVbAEstrREZtMzY
         fX/qJwv8TfPA0knxmi3C55DHnPNnZQE7BeaFYZ2Emnn4Dj9irsBnMhsrZ8Uv9lyDXM2T
         AImbUoyAHIjB3i7lufVFooAKcuIK0OoeJ9X8lsRhoC9YGUXLurYigDtgyNxOGkmDdKqp
         JcnOGmbPx6qC22F5ZYvugUZsnbS5rsva6H7ZfpiWEGtu6hHkm3lOUYws4R+7yxodiZnI
         QOjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5/tsVKpvOF9hjEuBModNYiVpSPXtrrKrMQ519faKcis=;
        fh=Rsl+Mo7aHIHSp3AN4M/qglOZZpIG/2Y00l8GBZRrbhQ=;
        b=ADYPf1TS8iHu8Ya1PSrvAIq/hPf07zVRTwmU0evVmTFE9wCITpOtxSjSNNAM4YyJ4f
         3uzL0lHhMmFDGlmjs35ssP1rMQfJsKi8bsgVbBjFBw1kLGBkEcScpZIDi82wu+/lEpOf
         v0QZ0C8WnYiQRaxF9i38J5JQ7Yygr5HDvELpjeMMnjo90ZGKTg4ovs1ikg6xlzAka/a5
         Z6UgX6ur9udA9hA2r4DZiZm9zXcC6IV/Y6caQABg437+0VJJyYrfbtzPYHWxdGMfSC9m
         wsc3PkR1YWmTaSjQ1SC7xmLZ/1xM5Vuv4BMfIu8omJPCZUZYP8BtHYKNiSgwEAjtZMh8
         iXvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771839326; x=1772444126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/tsVKpvOF9hjEuBModNYiVpSPXtrrKrMQ519faKcis=;
        b=lvjUXwJMFDUVNdE9/6JGFIIEgXAr+NW/nxJYiNKP83A2h2rSdOYnS2Qap5SEi8qvuc
         Xvv8mX7Ib5UTjZ2Ntgfe8sP1Y8sbStPRBVlVXYlUG96b6S34FcSJuKZLdABzCTwQSawB
         6kEeAv1Xy3QQTZBXYrCOuzdG6KW4vFjs2HUXgSqvz4TtzIzp1VaFIlsTAa6b5Sp1Jd34
         8+G7qchOZolFb2NrtqZ2ma6izvwW8ElQncc0YNDtZAtfeVwNdlTIquDlE1K/HvvMVBW5
         MVSWix+ReYo/KfT3GNcH4MXXhrxRSIQZW2RW+9DJtcTlAkJOfHQiKIYj+U2ejfaspoaD
         g7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771839326; x=1772444126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5/tsVKpvOF9hjEuBModNYiVpSPXtrrKrMQ519faKcis=;
        b=i1Tcj0WQe9EZ2CEUwhVCyq3dUHW9mVnT0Ox3Fi76TREyvKi37uJHxgqtkmx/DMxvSr
         jVYPGQY809yhzM0fXAoHYj0PGwzZklVVC8vy9ejLvuCLlR1+nt+nYrNioLpaJ/BhkBTd
         ZmMeoLL4eDZ/M2pdwHJ1+gcr4RNBYXHZVcV92EmQkbUTprF+yOnk6Yis6Y6PPl7/YqQe
         NPTpxOEQDNSZGbstz6JkJPceeLclgCMW0huDOA/eR37YG4a7YBH1Q5B6WlRD6SJ3dwSE
         qLmymxmL/AGstPkMkxQVANiUjKx+1mA2z6cvBUK8Tr24nBqoaE8HBwM88DNbe9fKLkEY
         YwEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSIfKBmPtf7TicbNChKw/EYEqA3r3XvPGYIlwdLjBjrN2N7LzE8kolgK0fSWihcBAl4D4ahJQh@vger.kernel.org
X-Gm-Message-State: AOJu0YyjVvujN6qIx4FHhGxFb1Zw6sd/H/A5Cdkij0w5pSqfPKrIiHex
	uWCiNLQ6BHxDdlJhP9pUQvJwfVmS4OqQksSW8+N8W/Na9Zjb0ooWcAWkqjk5FYNTDh+GtoWlPnK
	aLJE4emN3NUEX1r6LAy5ReRhj1iJ9sAA=
X-Gm-Gg: AZuq6aLG8/CXCt1XgqMfdotgVY9sMeeIn4WWkQel/hlnMHayeudbM48VbqdnVBV1KwP
	7G39mNwXhwrB6tfjqFyFdPl+kQodjHAomWKWNZ500UzTwqVK8si57IPqBNbtGEn8bgjgSarXv1W
	vOgtlTzAPRp4bWbxjPrjqfLDOPQP+Rq3W6YMBc33QVY6IRPs4/Ni9AusOB0joS4JqcCI8ZE7x2A
	HR9/eQp/qj4ImXM0qxqnuefYjTU3Qll8I8VgOoyjdogV5wll6i98JMt2NIcwyrsb9f46+vXkti2
	GW35TH3a2jCSB1R7YfkQ0HdeSpNCU2+Y4gULnnAc8g==
X-Received: by 2002:a17:906:7307:b0:b88:5002:50c0 with SMTP id
 a640c23a62f3a-b90819db296mr564028666b.20.1771839325394; Mon, 23 Feb 2026
 01:35:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223011210.3853517-1-neilb@ownmail.net> <20260223011210.3853517-12-neilb@ownmail.net>
In-Reply-To: <20260223011210.3853517-12-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 23 Feb 2026 11:35:14 +0200
X-Gm-Features: AaiRm51zLgcrRbPb_4HmwkH5uY0J9aukMWrvlX2vP_E-cCHRJFMZshxY7_A02Xw
Message-ID: <CAOQ4uxibL=2Z0FZMz5wMAo=JMaJouOVo3p7t3Fi3FR59U5Tu=g@mail.gmail.com>
Subject: Re: [PATCH v2 11/15] ovl: pass name buffer to ovl_start_creating_temp()
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

On Mon, Feb 23, 2026 at 2:14=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> Now ovl_start_creating_temp() is passed a buffer in which to store the
> temp name.  This will be useful in a future patch were ovl_create_real()
> will need access to that name.
>
> Signed-off-by: NeilBrown <neil@brown.name>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/dir.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index ff3dbd1ca61f..c4feb89ad1e3 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -66,10 +66,9 @@ void ovl_tempname(char name[OVL_TEMPNAME_SIZE])
>  }
>
>  static struct dentry *ovl_start_creating_temp(struct ovl_fs *ofs,
> -                                             struct dentry *workdir)
> +                                             struct dentry *workdir,
> +                                             char name[OVL_TEMPNAME_SIZE=
])
>  {
> -       char name[OVL_TEMPNAME_SIZE];
> -
>         ovl_tempname(name);
>         return start_creating(ovl_upper_mnt_idmap(ofs), workdir,
>                               &QSTR(name));
> @@ -81,11 +80,12 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs=
)
>         struct dentry *whiteout, *link;
>         struct dentry *workdir =3D ofs->workdir;
>         struct inode *wdir =3D workdir->d_inode;
> +       char name[OVL_TEMPNAME_SIZE];
>
>         guard(mutex)(&ofs->whiteout_lock);
>
>         if (!ofs->whiteout) {
> -               whiteout =3D ovl_start_creating_temp(ofs, workdir);
> +               whiteout =3D ovl_start_creating_temp(ofs, workdir, name);
>                 if (IS_ERR(whiteout))
>                         return whiteout;
>                 err =3D ovl_do_whiteout(ofs, wdir, whiteout);
> @@ -97,7 +97,7 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
>         }
>
>         if (!ofs->no_shared_whiteout) {
> -               link =3D ovl_start_creating_temp(ofs, workdir);
> +               link =3D ovl_start_creating_temp(ofs, workdir, name);
>                 if (IS_ERR(link))
>                         return link;
>                 err =3D ovl_do_link(ofs, ofs->whiteout, wdir, link);
> @@ -247,7 +247,9 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, st=
ruct dentry *workdir,
>                                struct ovl_cattr *attr)
>  {
>         struct dentry *ret;
> -       ret =3D ovl_start_creating_temp(ofs, workdir);
> +       char name[OVL_TEMPNAME_SIZE];
> +
> +       ret =3D ovl_start_creating_temp(ofs, workdir, name);
>         if (IS_ERR(ret))
>                 return ret;
>         ret =3D ovl_create_real(ofs, workdir, ret, attr);
> --
> 2.50.0.107.gf914562f5916.dirty
>
