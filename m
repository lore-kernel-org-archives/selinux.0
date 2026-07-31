Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEFB40F75B
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785501325; cv=pass; b=jUeWIh3hhGo02wlw0U0SM9BC7mztK0bEfECO0pfbYS+hHGTvqKcp4IjETzO1icL//QiFUpXGxmz1J2rD7P+JjOsD3IcwH9fDPJN9WFJ/k+ijawsI76YMAHx7fgLVqL73yRbILsmFcrShjcRc/F7zCh9i5ZEM5xTfuG+gQGxrcJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785501325; c=relaxed/simple;
	bh=UEXA2jz7/8V+cAKqn+ecsYKqLFIMPeiztSrq0J+wmAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5ePKsxAPCnJvce7PR29tCH/Ldu0oFZ236YhbqKdVGzM/5G2yUnJg5ZwQDcw8eRna/SFrzeU0AX5b+U5zRC/asuLWHOw5YUaEQXsY6rzr6FlpYSy0Zq1tKupWh+QRioVrQRKXUZHQgfNcqq0i+aWrP4Inc7VOTKzXbEOnEXuvRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REXVkRy3; arc=pass smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REXVkRy3"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6aa9606ddadso618413eaf.0
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 05:35:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785501323; cv=none;
        d=google.com; s=arc-20260327;
        b=YkatpFhESeglLWHfjR+PdXlaYmYacBmhCUgG+kthBNtUVi2FiIyQHcm94wdWQ0LYlb
         BSt+CKqoI62T0ce9b9V+qV4tR8AKGVfauxOunFAYsidpaMGS5Me6qUolVlv9AUkgkOm9
         yMP0FIyM+Y+dUn+suP6viF1jRL67436nA7+2h1DqRA6N8t9irZAnK98PjfFkp5DkxCPL
         8nZ+L8BcYY98pXoZvkXuRC41sPxNPhXMNh2TWAXliL3fqIPeXldBlbOnzyJ10zFb1tZ4
         8SHVv0c8tWTjR/ThGC6Dp4ZAtIk/i6L4dhgcR4hyzLZggtxOVkwPzCeA83uJ2y6nfSPv
         aTKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YFAI/9+RvNlaopRe0SqCEvXX6CBi05C4fAg0TyUNeEU=;
        fh=DMQgHh3KCgCiT9Q+vADFVWIpQ7sVwsss2USiMTAUi9A=;
        b=Kefm79S6Rui2VB3DCcry4OuN8LCc0q/8quaa4Xr/X8CA5W1CA8avKFFTaVnYCQTEDC
         z4/UJDWUxWvz8hj/YzHYkEcez4iiMhjwYzBs2VUAwtGM+DD/C/RaRQOsoOjYmscnV0x1
         98Xs7UaG4tQiUbRmiwT7KB/yUoffu8fdu1aRkExhsTTTwesQWOFZAEuUN694iLVamcrY
         T1j4EnHeWsjxwpMcUt/ynHix9LVOqrRK4U1NWRcQDztyUPsbuugHS4SBakSZPQn2A5GS
         tYP1AkYL4egRcvSzb1ATjJ6TJEeIGImo+mydI3TyHgBg9kj2pKy3gypVBYjpHrCMrVxg
         WV3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785501323; x=1786106123; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YFAI/9+RvNlaopRe0SqCEvXX6CBi05C4fAg0TyUNeEU=;
        b=REXVkRy3KxPSPr+1PvDbz53nE/VdaLuOmJyFOcwmV9/GnhNCzeZ+LKuWgCI1kLGTzz
         sA8noSXGop1VRy5mJv/qmiWYoURK89NTQQLd3e8h7t5tyCNKWx9c9b4aMDqIYPu7Ov6j
         w0PXfFUz70YrS2zcA6g05R8Ck+Pllf97q9vn+wbtNLoq48MOhER6RrH62c9Go9fA2Hc9
         IHdp/Kkxh2dsQYLJS7R5ebo3N8cABHgcasxljvAgQD3MMjQgxb19FSEkSnsoXoV4R+ql
         MJu/vwTHzM7ho03qU1J1SCjmcXrtJQ3tXsejZdwt9Jm7K5gw5nQFvzxaykrZr2VZ5sy0
         rnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785501323; x=1786106123;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YFAI/9+RvNlaopRe0SqCEvXX6CBi05C4fAg0TyUNeEU=;
        b=Y1UN1+g8u+6LStjar37LL3T+g1TehXGOm4qCeyywqbOiHbtjOUei9j3bMcrG0CfzuE
         lVgjAO9s7Mj/rzcP4c3Sw++A9K7d4B9LmsKUHTbNXYhjs49yJvZxpXrLXjLOtM8iFkx0
         clynzA4SXx0OC78Fv4DdzkbMXY7nFgSbtnO/qsrT7yCHzwUSsXMtcmIw0h7iOvctL9j5
         TiSpbDydDXMStpxrzm8uVndWw3mcU1jeORWUtouI5U/KHuZn0KJoD+8MuZ56jZOuym5L
         sT5tRWdhkTqzrdCXrai6fMn+qu/kxsGcouPBZy1avbheCGSy2DjlqxuKKIcTT3KAZ6Qk
         LUUg==
X-Forwarded-Encrypted: i=1; AHgh+Rq2AaeqtOM98GDmWGlrFpqMfA+u+oq5feTGzRwPXGDZYYUwvtz0CAnuN+AcM3byNqgULJrrLXdx@vger.kernel.org
X-Gm-Message-State: AOJu0YwWIDZF6FZjKvDz7jSBncbsQjjVD4WQsVaxiBQt5TI1eVOLQUC6
	a1z5I42N7OvoSzVFc1wRPeuZdRZyDp7WB3WB2Xz1lN41XYjfhEmUqQGw7hs+bS0558BJ6367H7x
	9kBDRv3q9jU1zrnCVdwXuFDFutqMv4Ck=
X-Gm-Gg: AR+sD10dhHGczgr9wZHO9RlqwR3D/rwcAAJyg6rwYkHZCed5KdyHv1beHiYjCzAlR9Y
	cCDf27w8yD/q4RmWo/lfvmN5wbEAGlfd4jQcTJDvYutuLESVUO+TwYMan76sqmZT7DnFZ36gJZi
	88sV7h5+u2Fuq95Mbc3gkwMD8rVGK6ajW8VOqTu0/3nPbg/IhNedBDcsHY+UaRQ/LOYFPWkQC2Q
	5dZfotfYyetyDJ85vT9mUhk0cU1U57vt4W/K0yBi9srtPkXw4xVCpoztVmHLN+w9sep4a8/O+cs
	bwciJ+YajHCWy9nbWp0TIO2+ttqz2aoR7C75Ow0zB3BB
X-Received: by 2002:a05:6820:c0c9:20b0:6aa:e252:dc59 with SMTP id
 006d021491bc7-6ae37cf9c54mr1615552eaf.5.1785501323220; Fri, 31 Jul 2026
 05:35:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <db6fe5d2d4081f20f85abc6020b831fd@paul-moore.com> <20260730221508.3846409-1-cmllamas@google.com>
In-Reply-To: <20260730221508.3846409-1-cmllamas@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 31 Jul 2026 08:35:11 -0400
X-Gm-Features: AUfX_mwlKgyb6AEn20yiXH-27f3TnQmpcyFREg2qUfV_pjvNieyaRo-vjnWDeh8
Message-ID: <CAEjxPJ5PPyM+fkMnLj+FATHtoyYg4TK+tthGpudWnq52GSF6MA@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: bpf: check SBLABEL_MNT before isec init
To: Carlos Llamas <cmllamas@google.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	"open list:SELINUX SECURITY MODULE" <selinux@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 6:15=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> selinux_inode_init_security() marks the isec as initialized before
> checking if mount labeling is supported (SBLABEL_MNT). This was fine
> until commit 9722955b5430 ("bpf: Add simple xattr support to bpffs"),
> where genfscon bpffs mounts fail the SBLABEL_MNT check as expected (no
> xattrs) and yet leave the isec->initialized. This breaks subsequent
> calls to inode_doinit_with_dentry().
>
> Do the SBLABEL_MNT check before the inode security is initialized.
>
> Cc: stable@vger.kernel.org
> Closes: https://lore.kernel.org/all/akWdcp6P0FkNDzBk@google.com/
> Fixes: 9722955b5430 ("bpf: Add simple xattr support to bpffs")
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Just re-affirming my Ack since the patch did change slightly.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> v2:
>   - Move the check further at the top per Paul's feedback.
>   - Collect Stephen's Ack.
>
> v1:
>   https://lore.kernel.org/all/20260730181008.3654413-1-cmllamas@google.co=
m/
>
>  security/selinux/hooks.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 8d6945edae7a..18dd28b2bb13 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2974,6 +2974,10 @@ static int selinux_inode_init_security(struct inod=
e *inode, struct inode *dir,
>
>         sbsec =3D selinux_superblock(dir->i_sb);
>
> +       if (!selinux_initialized() ||
> +           !(sbsec->flags & SBLABEL_MNT))
> +               return -EOPNOTSUPP;
> +
>         newsid =3D crsec->create_sid;
>         newsclass =3D inode_mode_to_security_class(inode->i_mode);
>         rc =3D selinux_determine_inode_label(crsec, dir, qstr, newsclass,=
 &newsid);
> @@ -2988,10 +2992,6 @@ static int selinux_inode_init_security(struct inod=
e *inode, struct inode *dir,
>                 isec->initialized =3D LABEL_INITIALIZED;
>         }
>
> -       if (!selinux_initialized() ||
> -           !(sbsec->flags & SBLABEL_MNT))
> -               return -EOPNOTSUPP;
> -
>         xattr =3D lsm_get_xattr_slot(xattrs, xattr_count);
>         if (xattr) {
>                 rc =3D security_sid_to_context_force(newsid,
> --
> 2.55.0.508.g3f0d502094-goog
>
