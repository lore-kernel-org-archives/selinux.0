Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7632F241139
	for <selinux@vger.kernel.org>; Thu,  5 Feb 2026 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770284251; cv=pass; b=RlCzFpOBC+qfO07E5EMZw+7e3JZaZB3Pi+0tGggfmfg1ghKgMfVNTE/BBNDDQRDAZ8iTmW8E/kEo83NsYW9zfIXBUaGzVOCuDt7wePD2ar5gQqMF4CFrWK6V8KCrScNB1caDph3QVSsC/iTeNKpDK9FsD2bikprG/aPGg+3x5P4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770284251; c=relaxed/simple;
	bh=O3zjcpb1gIgdrnZIOWkOIcCmTAMhdJCAtczZfkl8Mgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WAzYR/ZgXqDUhQfl0FcWGaky8U5CYVpZtKdwoWWc0pXwiOqhxQUKA72zFm5xTrEgiS9Z6t0FrhTrjwSpcsqBmHXn+gTRucJ192H+l76+PGFfVcj0nELJ96/zEv4ceKfwKxpJjQSwZQ04l4ksDArzNMn2EdYxI9FzfLjxvniLD/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjUGTiXw; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjUGTiXw"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-658078d6655so1221963a12.3
        for <selinux@vger.kernel.org>; Thu, 05 Feb 2026 01:37:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770284250; cv=none;
        d=google.com; s=arc-20240605;
        b=Qosu9xRIgQ5lWbeMf5HqUIe0tOQpU6IABlK+bOLdnp2m04hARJE0vBg0M7wX6+dfwt
         kTpZxXi+sgv6e9QtgaEWSRBBYwCrW6Wj/3injbWBrpuMGBTA7Gdvhd7adfVEVv3GqSQS
         fSjAb+ghavShWH1dsjBz1df1+ULQRy40M+tFHPTWDPFx1ul2K7YRwKBiBKI9kJ5Vebj0
         eZlBApc4jR5T+vYa2B+1qzRhvu+Q7CbUzuS64/5p6c7JGzlUJuj67DzTIKUhwP/RvOOv
         d1pxIa7xGFkrFwOnRufFmpgP3tgzRVMv2dz06icTFF7MDW4jfe9QMy8KbhXujiycyVHw
         4vUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ts7BIpqOHUIYO1yz8UgL/PwCOZwIbnvcvFeQ/hBIaCk=;
        fh=HqE4w9eBUEA3x++Xq4VNcR8xdIqJZLUjJ5/uEDnven0=;
        b=i/rKTxhavC+xTxnM6jwPk39xIDlKwd/QjYtL1LgJ5LatWBTD9ha3ldpsk5r2LC3MVu
         aTi9TKlO3J0jZZ1qWDbfON8EIqVoTs49a4a5Isc9vRDaFBOUYHX3kp+1FswwXW4AeEbD
         +F9/sxHXGDU2lRoTpoMSrZGZu9SJlcPDsw0bkbjPNITlmm2yYBkttS/5CbkKuo+K4T8G
         DE0Rb7Fn8ezjh86Akkg/LSVhp6bGRku9TqyqMtELAs7qEhEtp1uDB/SE+EyaMXwOQGC0
         uEDnGRvFtbS9FD8YDiDS96P6HbeFhKcsG6a7WY7KaxcnQsN1vrXLP5F/NS8+xZdiUE7J
         qLVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770284250; x=1770889050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ts7BIpqOHUIYO1yz8UgL/PwCOZwIbnvcvFeQ/hBIaCk=;
        b=FjUGTiXw2YWjuQ7I+GqvszU9ONy2XE3+0JTAxPXHkvt5eZPZz+J5Ufml3pqOgP8T2L
         rGpjc6btwhogLQMha/Jf6R6/yMMHusEbVvvB9GvauRcrLVSE37m/5NRzEmxkn7UFT56a
         iuPSJZkpndM52iukwsc73xY8GdCH4GozIXR7BrzDyyEcwiI2UfOmNraXaq/qo6qKWX5v
         Js4guz62jAPbbEGBBruoJBw9nESFq2rhHfK5hAw/E3v3AMLBniyg3HEQD/EO70aNkSpl
         fnmqT9r0YmS9KqEzDR/y8yvYgP0e5gBj2781l3djCI2R2Qr30Ey5NTf0YpiUPWKYhCsR
         bKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770284250; x=1770889050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ts7BIpqOHUIYO1yz8UgL/PwCOZwIbnvcvFeQ/hBIaCk=;
        b=ThSbcIHaVU4xLhGkGLQK1PjACOp2S0v39JlnQwPzjeSAvgCF7M3Ra+Nd2RV5pReLo/
         852e0kvz6LLJS53JQJmie0kaBBUVePnK5+c+0EBaMCnyj5Qw2HwiRP5LorstLQul+5TA
         WIC579ytf+VzXDX4g/ysBIvEtSMViR5rrv0AptKf7xdKnxh1HPByLQbNEyrTagWWqg98
         k/WdCA3uBe+G925vC5acmnbe789ORIeoh/Wx9BkfBBntwFFUVg8vsRXnwiZkXBBooCvX
         lxHGpCkkpfdQsRXH6VIbFzwuoB1eHTg+SCY0D5Z75IkXKFYfsa4Skzmdiqycm3KegASQ
         MFbw==
X-Forwarded-Encrypted: i=1; AJvYcCUJpY9N3KQyDX9d3p85xbcrTlrJK0ilF55APwzujTsa9elHla3GXM82HX49LOlIWBoXrJDqzgda@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4V/EFCiBExQHcne+1a1zbLnoRFmztxsLysw1TRbDuLa+kSnMk
	ypA/W/35ONTbpBANIHpP/ekP35LkibfuuHq79cgeSFm+wGuUXU99+HW9G1vahcNieQ96Lz0HDp/
	JJM/lg1TSokssP5dlkQZbwsxFB4s79X8=
X-Gm-Gg: AZuq6aJCGyvtkC5+o7Uz67ewpZqo5SlfqHYdcbuO5aPjqqx6nhoJG+AsaVyiS6WOe1S
	bJ3N+IOgSXxoxxDtyLgkK5nx1hdtb4HQnfyhKOmlevEExyp2/mrds0Q4yjLiCjp4jo3wulSNuq5
	Rp59IXB7vXcD43BXuwtRjrNzgTm66YX8o3Ym4u4zkfF5Zi+M5uljOfgwKNG7QBgSrGSmxFU0Qkp
	Rz/f/XiQZnXEB26TPDt8xbua0FaMa93dW67UJMGE5Y2ODdxSObKXBzTM+1l1gzpbJJF0MWPXeJj
	r/lc/e+zisO0Ls62QYbCtBoTbMmCfA==
X-Received: by 2002:a05:6402:2688:b0:658:cf28:90ed with SMTP id
 4fb4d7f45d1cf-65949cc1e5emr3920680a12.15.1770284249654; Thu, 05 Feb 2026
 01:37:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204050726.177283-1-neilb@ownmail.net> <20260204050726.177283-12-neilb@ownmail.net>
In-Reply-To: <20260204050726.177283-12-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Feb 2026 10:37:18 +0100
X-Gm-Features: AZwV_QjDs8XEOiRuWGAHzisKUrokVjcatEGo5N0FYjLzK48UQXH5p374RE5BkHo
Message-ID: <CAOQ4uxiYUTi=8BjRFbY_GdBZR_5CuP6680me=_xQaPcQk7EFuQ@mail.gmail.com>
Subject: Re: [PATCH 11/13] ovl: use is_subdir() for testing if one thing is a
 subdir of another
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 6:09=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
>
> From: NeilBrown <neil@brown.name>
>
> Rather than using lock_rename(), use the more obvious is_subdir() for
> ensuring that neither upper nor workdir contain the other.
> Also be explicit in the comment that the two directories cannot be the
> same.
>
> As this is a point-it-time sanity check and does not provide any
> on-going guarantees, the removal of locking does not introduce any
> interesting races.
>
> Signed-off-by: NeilBrown <neil@brown.name>

Looks reasonable

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/super.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index ba9146f22a2c..2fd3e0aee50e 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -451,18 +451,13 @@ static int ovl_lower_dir(const char *name, const st=
ruct path *path,
>         return 0;
>  }
>
> -/* Workdir should not be subdir of upperdir and vice versa */
> +/*
> + * Workdir should not be subdir of upperdir and vice versa, and
> + * they should not be the same.
> + */
>  static bool ovl_workdir_ok(struct dentry *workdir, struct dentry *upperd=
ir)
>  {
> -       bool ok =3D false;
> -
> -       if (workdir !=3D upperdir) {
> -               struct dentry *trap =3D lock_rename(workdir, upperdir);
> -               if (!IS_ERR(trap))
> -                       unlock_rename(workdir, upperdir);
> -               ok =3D (trap =3D=3D NULL);
> -       }
> -       return ok;
> +       return !is_subdir(workdir, upperdir) && !is_subdir(upperdir, work=
dir);
>  }
>
>  static int ovl_setup_trap(struct super_block *sb, struct dentry *dir,
> --
> 2.50.0.107.gf914562f5916.dirty
>
