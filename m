Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF6E314A81
	for <selinux@vger.kernel.org>; Fri, 29 Aug 2025 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756477313; cv=none; b=KkaSuH+jjwbaFHLqayPgGu1lo7Zt6FlCgCZTkqUH8rKMPMFZBmlxB8DOqWBRo1rbvDeVHN5VfIeOgFzaVo+jteRsVwkTnJlK0JvtWJkWAnwN76aTyVsUrgj7O0k+6mWlEo49DBfj/jx+mu1PDy/OYYdEb5XQYETpDe7N7CGMBdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756477313; c=relaxed/simple;
	bh=d4XoZNc9cduMyfwotp3SBa0zk165uOd57JOMvnLgwWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QF4p+6UeYt1o6smh5EJyBwkB78MkuAex1j2eAtYXO66pW1mDJIlBPdG4Zmfm4sJJ/Zlqh7y4Rqi64kCe+peomUdtSzHglEfrRmjPSE29wkC+JgaEgp1kGCulCAVbDjDFo93dmY0pQs/U5bNJTDe/qNG7KomlqFm2PsR+kHLgOjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCKxBOCu; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCKxBOCu"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4c6fee41c9so1387724a12.1
        for <selinux@vger.kernel.org>; Fri, 29 Aug 2025 07:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756477311; x=1757082111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzRSTTydT8IbaiprwfVaOjrfTXNJ4jQqmuHyDkQEpJE=;
        b=bCKxBOCuKbGljBivFHts7QngUvbFQQuwrMyRUm4Bw8XlP8DR5vKIWysFqmN4T7bSgs
         OYXd5MbiGpFvC8fblQUO1S3GHCI1FrYgef2Rc6tqQfv1XBx0eA+DJEaao095cLKKMp7G
         sd5qaRgzGLn8vJdFQz2ObV+dKY+q48mEhy5zJpPFxiftJ7btClKJeW4/C3sp7NfvcdBj
         yoisFzRkxKOnpwXdie+pNUbIJln7NOWrKgiBbH3f/O0mk+nqr3pNPVJGpavZAY7c1S8B
         Lg6Xechrk9LIquwrDAIDdmHL0HxV9Ur/8eFdVY5+pynt6IKofx+hsMpim5r7bLgv9RIV
         7R3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756477311; x=1757082111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzRSTTydT8IbaiprwfVaOjrfTXNJ4jQqmuHyDkQEpJE=;
        b=m+eQLSb2KqBL8TS+keX1kBbUqojylH4Nyv5fwzfS4LL+bzXQHC+ZNhv08nibItpFFB
         oPiOzauOVyAZgwPJEnHvVr59yxamGBxwAv/j/T4LeVqQvyf1xoGhgvBXjRgi12KU9NkF
         7nAxbkOUPZzJEtn+OACO/tQof6qT9110ZuK7uBWucGGuWXuugpzrLyfj6oWjHVeC52Nj
         58dMyURm3goIjCA5iscVMGfSv4YjqnmCKderxSzzCe/1DkmmCZy4wP6jLXcIINPawoxu
         cYZg9IQ0bytzlOC1koIZ5J8z8zrRdxtELNogC6Yey4P84qjIbxmaJzor9qR4ApyHXY5F
         lGlw==
X-Gm-Message-State: AOJu0YzQp/RPcjPX56qpKmtgldM1wCOEJ6YrphtRTeApate6YXsdkz6y
	8AI0auII9ethhALDowVGTdnrRoq25D8H9MjzWjCi07R9vtY02pFDA9HvSe0ps7rVAfPAL30JuVp
	d74B9J0Y1J2AsWFkH4dO0xGcilwjFxAA5JA==
X-Gm-Gg: ASbGncujVg/fvtuRBRbMFxfmWDj/b6F6YdhLlg+Atd3fBHAELmRFnqGEd/8EZcMzHol
	dqrV4YhSDyEW+bGk6hDMBnJrO/Usc9VSPh0URfb3zqJz5rPR/vva9GugzLnLRfXvfKMbkuRPxPv
	6n+hT0/v9HTBB/m1BCmXuSUJI/lx1ltiwr8L0Ij8alETXMuphHUNIa/tJkq93Us9Mo3Q1xQXa4A
	DJI71BObCMZ2PhTTw==
X-Google-Smtp-Source: AGHT+IGi1Su2qxFmnChTeSkNXhvovmJvMuJsWsctdNnOpWcdx6HnfmBnROGyVSZZNoLMca/amo+ZsYSQTnHqw7TJE6A=
X-Received: by 2002:a17:90b:5644:b0:327:70b9:9d68 with SMTP id
 98e67ed59e1d1-32770b99e1bmr13412969a91.16.1756477311161; Fri, 29 Aug 2025
 07:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829141000.13795-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250829141000.13795-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 29 Aug 2025 10:21:40 -0400
X-Gm-Features: Ac12FXx0SeY008bxqNDEgMuBlarrwLw43gp1cTiGHwmGz-nqvL6QabTVHoOdnQ0
Message-ID: <CAEjxPJ4h3QmeRJN++8A=hjD98tOis6_09Zhi1EDK6sKtP5cZiQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix sel_read_bool() allocation and error handling
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com, willy@infradead.org, 
	vishal.moola@gmail.com, david@redhat.com, mst@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 10:13=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Switch sel_read_bool() from using get_zeroed_page() and free_page()
> to kzalloc() and kfree(), and fix the error path to free the buffer
> when security_get_bool_value() returns an error.
>
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> Could likely just use kmalloc() as suggested but being conservative.
> Double NOT also likely unnecessary since values are sanitized on
> input but likewise being conservative. We obviously have more places
> to fix in selinuxfs.
>
>  security/selinux/selinuxfs.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 9aa1d03ab612..e90990c57bd1 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -1203,7 +1203,8 @@ static ssize_t sel_read_bool(struct file *filep, ch=
ar __user *buf,
>                              size_t count, loff_t *ppos)
>  {
>         struct selinux_fs_info *fsi =3D file_inode(filep)->i_sb->s_fs_inf=
o;
> -       char *page =3D NULL;
> +       char *buffer =3D NULL;
> +       size_t size;
>         ssize_t length;
>         ssize_t ret;
>         int cur_enforcing;
> @@ -1218,21 +1219,22 @@ static ssize_t sel_read_bool(struct file *filep, =
char __user *buf,
>                 goto out_unlock;
>
>         ret =3D -ENOMEM;
> -       page =3D (char *)get_zeroed_page(GFP_KERNEL);
> -       if (!page)
> +       size =3D 4; /* 0|1 0|1 */
> +       buffer =3D kzalloc(size, GFP_KERNEL);

Should likely just allocate that on the stack and be done with it.
Will wait a bit for other comments before re-spinning though.

> +       if (!buffer)
>                 goto out_unlock;
>
>         cur_enforcing =3D security_get_bool_value(index);
>         if (cur_enforcing < 0) {
>                 ret =3D cur_enforcing;
> -               goto out_unlock;
> +               goto out_free;
>         }
> -       length =3D scnprintf(page, PAGE_SIZE, "%d %d", cur_enforcing,
> -                         fsi->bool_pending_values[index]);
> +       length =3D scnprintf(buffer, size, "%d %d", !!cur_enforcing,
> +                         !!fsi->bool_pending_values[index]);
>         mutex_unlock(&selinux_state.policy_mutex);
> -       ret =3D simple_read_from_buffer(buf, count, ppos, page, length);
> +       ret =3D simple_read_from_buffer(buf, count, ppos, buffer, length)=
;
>  out_free:
> -       free_page((unsigned long)page);
> +       kfree(buffer);
>         return ret;
>
>  out_unlock:
> --
> 2.51.0
>
