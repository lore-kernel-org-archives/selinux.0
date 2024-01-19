Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB4A54BC5
	for <selinux@vger.kernel.org>; Fri, 19 Jan 2024 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705679261; cv=none; b=hpmAtvL8ttaAO4MSRGS0jvDSCpkHMPCnXtnmQq0lvNp5YbZ7+wUTnhBdG5VOBi8ABS3e79dPbLHsDVYZElYoNCbZXZahNt9/3fJTw2GoRjTNk887RNppfW3qLR/3rjj3xfgAgpI0tpYQiWd3pGocDovneEH4uSalp+ofvUpbmn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705679261; c=relaxed/simple;
	bh=NUJuWDJytPPI+PXeAaQynNt46FEWlgDmM65lg1PY814=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FI9axSPpQbg6i/zeR0GXjEEquNJIl0iiAuiMO6IQ4y0Id/QUxFCmNCcvS/elV0QNMMgaTpKFwhhrCg/Nd8LHYWBZEgAx1MtTjxZB1Pj1gyC3lHKgjTvU1Z4HZNq0c88moYeuv7RdESQf5+q8P4L5dbppu1fL27E9M8Rh6qW7NqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLmbfMfj; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLmbfMfj"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2900c648b8bso804108a91.3
        for <selinux@vger.kernel.org>; Fri, 19 Jan 2024 07:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705679259; x=1706284059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFEg4BxAikzXJ46OSmDAqpZfuMC9r/TUVkXWDB8jV7M=;
        b=CLmbfMfj0IsWIQG+yAhlUDDr16q/H322jaacS865XfgXvOmMbtjRz5A3j1k7aRfayv
         qRHM7osmIadV0VBY2k0zlp6Ndjaq11OVuHrxkGDyOvAJRP07mmymJXLlT3BfqTrjQXk4
         1Apz5N5n8HD1sxwTnu6teZRLtdUcCU32yWwE6ab+fpNSa0YBV7p6pmABWOIYliIm+1yr
         cBJotE+BlKRq6QmxOe0bh/tfKvMJOzZSW45ogMIVf6Ye6MkS2PE7AHB+sCCFAtEp3tRh
         EyCLy/pH1SjBPxMJ9beixZ8fOaeZgLr9NVqlIKJ2Ky++40hOjyhYNlmJ+wj+4Nyy16vM
         a5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705679259; x=1706284059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFEg4BxAikzXJ46OSmDAqpZfuMC9r/TUVkXWDB8jV7M=;
        b=wOY3gZRQlkUtXesU5Te2e2JhWQnPH1TiEz99VR9gEo9fOMQiHlrHHgRox3gCboimNC
         JmOVqkOrlpOLBtx9ISvCf6x8q52YCOMaknIOPzdpBikz7REbX3ypowP+PNQLzJK+PNiM
         etK4nIWVekbOpxB4q+dh+Hp8ZEhxFXDCD3+/kKb1TUxQvC70pgNKBGw5OnTy539418CY
         deswDFVB/IiP4/yOMkKV6SbqT8XYBz6pOTmQACT3K8uR4TKcbCk8GZrp73xb3KpT7KMC
         y2YEl2GInY/j/qLVJiW31y/BPApkrkyeEdEDZiTkZWGzEbnFOrmxZarIIClXoiRN3ZH3
         8wIw==
X-Gm-Message-State: AOJu0Yxa2iHlVLqGPRedExAUin9QHvpvBRwspcujvpLjlaEYn8CBt16/
	PZI7twp/YX7XCbTQxqVVyEcOQcV1QGhdbJYyxG7uW8ScX5zkUrwTifnq7gf8hgpF3RMWw+Zzrj9
	vB5x0wXC3nK4Ff+o5Ty4We0XMReWenUSu
X-Google-Smtp-Source: AGHT+IHUH2jTPBZgLVRNhGug64iR3MDs2Lcb1N9lF5UtY9MYTwJ6iUK4YES/Tz8qg79n8V8yo7cdfNS8+NQfkh/121U=
X-Received: by 2002:a17:90a:2d86:b0:28d:b7d7:c1fa with SMTP id
 p6-20020a17090a2d8600b0028db7d7c1famr2418301pjd.47.1705679258869; Fri, 19 Jan
 2024 07:47:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119014420.493814-2-paul@paul-moore.com>
In-Reply-To: <20240119014420.493814-2-paul@paul-moore.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 19 Jan 2024 10:47:27 -0500
Message-ID: <CAEjxPJ5orNXNpm-pu1c524vbKXgbUOytD4F3qs9V_s=FYK6dRA@mail.gmail.com>
Subject: Re: [PATCH] selinux: reduce the object class calculations at inode
 init time
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 8:44=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> We only need to call inode_mode_to_security_class() once in
> selinux_inode_init_security().
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  security/selinux/hooks.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 7c69ce62c106..9e59f9c80ca8 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2920,23 +2920,22 @@ static int selinux_inode_init_security(struct ino=
de *inode, struct inode *dir,
>         struct superblock_security_struct *sbsec;
>         struct xattr *xattr =3D lsm_get_xattr_slot(xattrs, xattr_count);
>         u32 newsid, clen;
> +       u16 newsclass;
>         int rc;
>         char *context;
>
>         sbsec =3D selinux_superblock(dir->i_sb);
>
>         newsid =3D tsec->create_sid;
> -
> -       rc =3D selinux_determine_inode_label(tsec, dir, qstr,
> -               inode_mode_to_security_class(inode->i_mode),
> -               &newsid);
> +       newsclass =3D inode_mode_to_security_class(inode->i_mode);
> +       rc =3D selinux_determine_inode_label(tsec, dir, qstr, newsclass, =
&newsid);
>         if (rc)
>                 return rc;
>
>         /* Possibly defer initialization to selinux_complete_init. */
>         if (sbsec->flags & SE_SBINITIALIZED) {
>                 struct inode_security_struct *isec =3D selinux_inode(inod=
e);
> -               isec->sclass =3D inode_mode_to_security_class(inode->i_mo=
de);
> +               isec->sclass =3D newsclass;
>                 isec->sid =3D newsid;
>                 isec->initialized =3D LABEL_INITIALIZED;
>         }
> --
> 2.43.0
>
>
