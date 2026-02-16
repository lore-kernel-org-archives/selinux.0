Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B7CA937
	for <selinux@vger.kernel.org>; Mon, 16 Feb 2026 15:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771256812; cv=pass; b=SZ5X9YIWrNWxCbrlDWVmr4EjLs6AfTQOdpr8+5APuZMkVwr54hDQBJZ5dWD1RI7fPMiS7N67QgGjaFJYavI+nl2nU6MUAEqETj1GLEz7QdgxNW7TdIzTPytAHjFUFyeRhU/LDppM1nn90bBT6x2bDoKRgISAt0kZQMocWFmFlJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771256812; c=relaxed/simple;
	bh=djpwv/o4GoPPJBT2whDzEpO49Xpb/mpKkKS5KADS0aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j59rqACLh6mNrSRqNQ/clSawKF0i+nDIG0xVcerUT/qnUsoKVrVtevV/vhsm2yEWq6eQd0H5WF+Cq7hASPUj1DVeeVVPA1860mBwh7TrIF9LGyJ/UfVW7pPvFdb1FGbK7ng5qRIDAJmIyldYjE8ZfBTchCbuo/byOAlfHZF3TOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ls2hUITJ; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ls2hUITJ"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8845cb5862so417556266b.3
        for <selinux@vger.kernel.org>; Mon, 16 Feb 2026 07:46:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771256810; cv=none;
        d=google.com; s=arc-20240605;
        b=O6prFgiFMB3sOksAegezIw6/7zKbWfR0l9Oci0r9ERRl4kRzXvHmDpkYyCMjkuYbfO
         oa1swEvoOz4Q/Izoy1WrVn2ITYNvYKYijRMR02ElzGIZurQqQZFSvmLTwEG30ziSLh6a
         YEBNPpalfRbvLEwzn6+7AgvE7Fco2fYZnQIXYJs/UkECDOjEHEz2qxzk5gmf7nkhdcD4
         thUzvf6wtWRIokoGBLo5TNKMqap/lOCjwdOhmEyz+g7FQ0x+13ezfJRoYgas5OA9csQ/
         b3RrUDWVU7s8NxZUz+ZYdmVLGz1FavzogPuvyN/cBzdq1jpeOGDVr/3Mk24372KyBygd
         dM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EwFQ9XHRm/+AQIEABXNY8BO3EtxJflHDwT4zNmU2dNc=;
        fh=o9ptpelM+R9jbP5m1Kkmpex4HGRYTrM1sefWui3uy0M=;
        b=QMMuSMKUkAPtGTp4QBKKQu0zYoZMCPcbCTzwG5A+dqu0VchhoprsX12FxJ2oJT4Dku
         er8sxdWJM+zgRgPkCus9Q/EQwkWAPPLrmxVgBWGPoRthcIgfy22X0k0RxiRfnTNisnWo
         vrUVlAipttx4ZSvRVzJEw1o6nf2vHGcmzCSq6tZlMCrcZ1fuJLS9xB0w3emMO0YcgC9O
         T66sSADPfNl87RktaUwj1HZGX4PoWaTmDWxq0dGLl1AsT030idoeiTSEZVY55sliL86b
         TMq8fHAW8a/NCW0GjXJg+5yd93cePpcChDFbZ/FdPhNBTqS1hpZsi79j1oq9Nuw1Ga0y
         Tiow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771256810; x=1771861610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwFQ9XHRm/+AQIEABXNY8BO3EtxJflHDwT4zNmU2dNc=;
        b=Ls2hUITJPzh2+aWIbjAnvxJ8Q3fFBL8727qpP89XXZGqd1sAOZ99q8QjdTRmIAPaOV
         u1/gLyUXYWeZ1xoU7g/QQOQA9RdQcD87jAzZKzd/vW5fJOt4W2hsjan8lsCrA9lx7uma
         eet9IKx02VqAYcsdPlfB3MXSN6n6bUbT7YiOhN1vjkchrlsHbnI2sLmTCPtR1fYhjr39
         7hwEvZOW32wRq8aTMGUnWPfL7kUlsSyB0uW0lEY/GYpvUkBNcM5X+uG4EHkHzrJgELjC
         rCJlf6+HgnW4yasia/jFwu1YG2BllD7zQL/yE4TYth5SqvE+iQZSGFQJXdIz7cKEDcCP
         hnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771256810; x=1771861610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EwFQ9XHRm/+AQIEABXNY8BO3EtxJflHDwT4zNmU2dNc=;
        b=F9/25Li8BKX7DEQsJeNkCkLT8JkNaCtwnpYpT8KtWLPeaInaeUepBx21MmmNzCfeWd
         CNcWbYk0jW2HAT3ziGBEq6pxuSmex3wuuc8EFWTuRXuyjwPm+L5COxFSWRmDs6ZybaWc
         6723QIXgQ7Ru2Hjjt78+l54p5Cv1n+md50Mtf9BbtuhkzaR8/fVM6PZt/PnnKOnV7d9k
         DzIxtEnHm/UoWdLur+p2i3ISuLeqyVnIFGtDsTz68UZRyrxQaGEy1k1y4+VxZ3Isu9Ax
         7UHJRovnQOjDXDgdm/H+Yu6YvXf4Pxou5uY8E2OkEWcCExl+nN3lRbev9MAet7+pDqyq
         Mx/g==
X-Forwarded-Encrypted: i=1; AJvYcCXsLpNVegZTKCROQPJJsZUjdyF8piO/jp7smDUAoDdv2j1B3wdzFmLNUXaPHaIIhxpPPUqOCCG8@vger.kernel.org
X-Gm-Message-State: AOJu0YxxAjH72i+qAAp+h0jL6u6rh237G0Z1ttzokDwjLIyHgbFUHqE4
	Hem5ZbMecRoT+nbxaKerNUAdXXbSGzS/oqNkVVnToJufTgbh748swjl5eP9W0id7q68tzmCkVTh
	EpcudU19cK3iYvYGEYbqBBxPu1Ttji4s=
X-Gm-Gg: AZuq6aLuEuDOnmFrvOhgdo//46a4YmmXpIdKVeYOV3QmnWogAMArH4vITJfZMjckHr9
	zARdkPpdaosRZ8oF+xfjQCBCUzW2zo3VCMWOYzqAfseB6h2pWcSvZmAWACEqOkW56vj1Cehcnke
	JjvGOppbWwwXyMwkLz975tn5HhLL9cnVMRW2/8OLZyfkUE8EL2siuERKoQAGXTL62wIhGbrrZtk
	vg7q7sPZlyGundyUFlP5fVRy/ycQV8nDrGw+1dx6PyhLfYcXsPhSsGy4ZNnmjfOOW0svFSPE93z
	Y8PjhEBM
X-Received: by 2002:a17:907:e849:b0:b8e:dc98:ad20 with SMTP id
 a640c23a62f3a-b8fb4149e36mr557161866b.4.1771256809530; Mon, 16 Feb 2026
 07:46:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216150625.793013-1-omosnace@redhat.com> <20260216150625.793013-3-omosnace@redhat.com>
In-Reply-To: <20260216150625.793013-3-omosnace@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 16 Feb 2026 16:46:38 +0100
X-Gm-Features: AaiRm50W-dqNFKibz1fwwn2MM3hFVT2cCQwgYkQhpvQg3H1petMEkBdqAAcwRxQ
Message-ID: <CAOQ4uxhDwhd5Rn00qhd0j-OySph6v6ZCi8YM0MUP0C6Y3NQUzA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fanotify: call fanotify_events_supported() before
 path_permission() and security_path_notify()
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 5:06=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> The latter trigger LSM (e.g. SELinux) checks, which will log a denial
> when permission is denied, so it's better to do them after validity
> checks to avoid logging a denial when the operation would fail anyway.
>
> Fixes: 0b3b094ac9a7 ("fanotify: Disallow permission events for proc files=
ystem")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---

Fine by me,
Feel free to add
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

>  fs/notify/fanotify/fanotify_user.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index 9c9fca2976d2b..bfc4d09e6964a 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1210,6 +1210,7 @@ static int fanotify_find_path(int dfd, const char _=
_user *filename,
>
>                 *path =3D fd_file(f)->f_path;
>                 path_get(path);
> +               ret =3D 0;
>         } else {
>                 unsigned int lookup_flags =3D 0;
>
> @@ -1219,22 +1220,7 @@ static int fanotify_find_path(int dfd, const char =
__user *filename,
>                         lookup_flags |=3D LOOKUP_DIRECTORY;
>
>                 ret =3D user_path_at(dfd, filename, lookup_flags, path);
> -               if (ret)
> -                       goto out;
>         }
> -
> -       /* you can only watch an inode if you have read permissions on it=
 */
> -       ret =3D path_permission(path, MAY_READ);
> -       if (ret) {
> -               path_put(path);
> -               goto out;
> -       }
> -
> -       ret =3D security_path_notify(path, mask, obj_type);
> -       if (ret)
> -               path_put(path);
> -
> -out:
>         return ret;
>  }
>
> @@ -2058,6 +2044,15 @@ static int do_fanotify_mark(int fanotify_fd, unsig=
ned int flags, __u64 mask,
>                         goto path_put_and_out;
>         }
>
> +       /* you can only watch an inode if you have read permissions on it=
 */
> +       ret =3D path_permission(&path, MAY_READ);
> +       if (ret)
> +               goto path_put_and_out;
> +
> +       ret =3D security_path_notify(&path, mask, obj_type);
> +       if (ret)
> +               goto path_put_and_out;
> +
>         if (fid_mode) {
>                 ret =3D fanotify_test_fsid(path.dentry, flags, &__fsid);
>                 if (ret)
> --
> 2.53.0
>
