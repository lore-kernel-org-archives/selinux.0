Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D2820330
	for <selinux@vger.kernel.org>; Thu,  5 Jun 2025 21:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749159620; cv=none; b=S7KwG1ag+290IEpsURvyR/tbBa5m5YVcXBUbpq7xgvYKoIbdlJvC2PDtj9MrkGZATdUllG5zqBMbe840LRCtrgzGnI93HP8M9o1pg6jmZYUJgjCCPkomHyg7oCh8iLZhbKUbLEprYCngKv+8/4JDF3uTNH3SAo9sEr/clapv8yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749159620; c=relaxed/simple;
	bh=owrTpob8Z3VilSx0/gmgUp1e46LRN3HBsxPE3/o5G6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AnRgUUKcYReuIFcXnLZDtjdy0aaK4GEei3vyCrSGu/i8M1C3FiKtaBiuFdPWexFWwOc880QBa/Z02yEDGEHW5Ih5I7tv0mxFDEbtXX7bBT2XR3/Zm8qc9P5Z7AzMxr1R6+CL4dY8riO9VgHRgFjvLL/mKP2bT4HHfrfGJgVUElQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IuXURwNx; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IuXURwNx"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e819aa98db9so729160276.3
        for <selinux@vger.kernel.org>; Thu, 05 Jun 2025 14:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749159617; x=1749764417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiGFe0gms5Y7vXFNBwmlK7Nf7zyHEzhHaHnVsxs9CbY=;
        b=IuXURwNxIrnWOqUZ9sEpemZZlfxmRJhl0gOPEcfhNi/MwOqL/nUbuit38StphM+GIX
         hugZIKs7KZ0RtLYfCmShISEwue9SDjGsqrL+xnqcuWEV6e/8XoIqLlaq9lzYJOpN490P
         H5gxSAnTVHvi6XUhUCO50od0foj1uKTmX14SQtbCA5MKA6pN0BsBwhgbosnxsrIVXpK5
         p08NRHRHMZynjIGJVQN8WV79FWD2lkIcvJa4EV27B+ktqAJZfQP0JWGeTz0kC5RKKL5s
         tgGek5VF8hInimgY6QFZRAJzQSI1/JxNdYBRxCb/f4nftEt5cQn09gYlvWK39BDL4R6t
         o+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749159617; x=1749764417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yiGFe0gms5Y7vXFNBwmlK7Nf7zyHEzhHaHnVsxs9CbY=;
        b=GsiUNbw/8+hYcSlVmUo2vrvoDubE4x4OwCDHcPrWPecsruq1jZikc8aOhTzYpKR/ez
         HXE8WkiQxITD3L1Y8dlz3JGTjQYkDjSg4NeZoPS63uCPXzYeF1mejJ48BFCWxEL5Dhoz
         OBC+5MJHc+h6cjqXHw6v3lSPrD4cq2Uo9tH1Xm8vNZbrhfFUSkcPSZTqoAgDCRYnLSm+
         7UBZUQkvFKisiYne9+pLOkbf3Kd3P875d/BU/QGgAV7gsjYvvrTMn4Cqxe3nH21Lpbsl
         1pR+Yd6/JLw2Dh4eIkxIMO9zRdEKNV5+bmP23fR79PAXTzOOgL00uS89xbgAo/5lFrkk
         Ex9A==
X-Forwarded-Encrypted: i=1; AJvYcCXx55tE4aZJOYlK2r+feas7R/LFSAKJYaBUkK8o+cKLgaLfIj/oUExv2IxYt5OvXvch/gXiQhtx@vger.kernel.org
X-Gm-Message-State: AOJu0YzGWMPm80aS1Daa42vVgKymHG9iXhdZ3PgvsU4H7Rz05ryVgeEj
	bG61KOFumsNFXCxwYp8dWWdokqQ0Plfx4qIyT3Wg80kZhw3JIHB9rSFquSgDWpWs192HdVTj0Lk
	ubB8AWahwtqUxemJj43yPbpWO967zyZeVilumH1m1
X-Gm-Gg: ASbGncsWLN9Ii47rmkEwEsyaVJf1n0pMLy911APLV7TqPqu3qnZCqGIlsODUIdwKG+L
	WnmlTktez+dCAhXTluq6h/fmMNbOiC8f992YVhZ8YHS6MgtsuJYbY30FThgFi+0/VqjBFz1Ntyv
	CA9/3lfj0rupD294VDlYlKTulBp1pdNT43WX8iVtZKSrg=
X-Google-Smtp-Source: AGHT+IGTeby9Zg/JuU6w1mykeF0rzMEB/yxOlEg0U/HDEnInZhQM1QBBvHoRi8EzOT3QP4pmXeIss0vQyHFHUSPEmnM=
X-Received: by 2002:a05:6902:70b:b0:e7d:a3bc:22fd with SMTP id
 3f1490d57ef6-e81a232544bmr1970836276.39.1749159617415; Thu, 05 Jun 2025
 14:40:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605164852.2016-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20250605164852.2016-1-stephen.smalley.work@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Jun 2025 17:40:06 -0400
X-Gm-Features: AX0GCFvLs9Ehag9allmkViAyOyTZUnzE1Hp0rLlPcQr3EgCFF2MrKf7Z5oBdrT4
Message-ID: <CAHC9VhQ-f-n+0g29MpBB3_om-e=vDqSC3h+Vn_XzpK2zpqamdQ@mail.gmail.com>
Subject: Re: [PATCH] fs/xattr.c: fix simple_xattr_list()
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: brauner@kernel.org, linux-fsdevel@vger.kerne.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, collin.funk1@gmail.com, 
	eggert@cs.ucla.edu, bug-gnulib@gnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 12:49=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> commit 8b0ba61df5a1 ("fs/xattr.c: fix simple_xattr_list to always
> include security.* xattrs") failed to reset err after the call to
> security_inode_listsecurity(), which returns the length of the
> returned xattr name. This results in simple_xattr_list() incorrectly
> returning this length even if a POSIX acl is also set on the inode.
>
> Reported-by: Collin Funk <collin.funk1@gmail.com>
> Closes: https://lore.kernel.org/selinux/8734ceal7q.fsf@gmail.com/
> Reported-by: Paul Eggert <eggert@cs.ucla.edu>
> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2369561
> Fixes: 8b0ba61df5a1 ("fs/xattr.c: fix simple_xattr_list to always include=
 security.* xattrs")
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  fs/xattr.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Paul Moore <paul@paul-moore.com>

> diff --git a/fs/xattr.c b/fs/xattr.c
> index 8ec5b0204bfd..600ae97969cf 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -1479,6 +1479,7 @@ ssize_t simple_xattr_list(struct inode *inode, stru=
ct simple_xattrs *xattrs,
>                 buffer +=3D err;
>         }
>         remaining_size -=3D err;
> +       err =3D 0;
>
>         read_lock(&xattrs->lock);
>         for (rbp =3D rb_first(&xattrs->rb_root); rbp; rbp =3D rb_next(rbp=
)) {
> --
> 2.49.0

--=20
paul-moore.com
