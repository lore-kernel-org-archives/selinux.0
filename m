Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C8E204958
	for <selinux@vger.kernel.org>; Wed,  6 Nov 2024 21:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730929335; cv=none; b=eMykiEN/Pq9iX29xWAeoz817I6VPf49Enm+vvUeWn5HWbBSf4cpjfWpETgV/4ur7GluyzUywVO+XTdzhCKkUs4V+UQ7O9/STs8F3/K8NKQb5VUM/ZQVnqX33T6weEouafaMp3zX9fdJRK/1F9TxU/I48IjUGhqEZMbpzXyu69OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730929335; c=relaxed/simple;
	bh=eZccHAF2D4Ug1xtkrZ7EAV6VHYdcslQZRocs8Uv6sow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pcLKq2qb4lC8LdM6Q2kaqhadka8sI2rV2VTWdyKdt8GvtgU4Zounr6fMPxFiVvybpdstu59HVWtedq52D2VwzqpOvc1bl9lvDaWy0CbJWFE80RARWexySZxaCmHptKINs6c4t7dAhLrfjSkgpcEoSwHa+6zcYc30HK9JFYitEiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLFt+Qef; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLFt+Qef"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-84fc0209e87so87336241.1
        for <selinux@vger.kernel.org>; Wed, 06 Nov 2024 13:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730929332; x=1731534132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q144VAgCcVd1vsiXZJZkYdk2KimqsHbjpTX+IuAHgRc=;
        b=WLFt+Qef0bopof9NNZM0g0bUrrmOyLEuMWg2zmFGpwRLtJoOgXmji9CMSpGXfhNwOt
         RSK1ZNMo1Bx6lvGaNFwK+TjBNTI5JLPWIQwELdd/GXNKUrfPhksC5lcITGz82gmVkyPB
         L5Xfl4VKl4ZP5GWS861hljF20ZHFHyzpp9XTZ4Mdtzt2Z7mCmbAa6k0GOIseEdbUrZoB
         BXwo1uIZ66JR1lapQlChitDU8oBFifpvGmYDc15QhPzIqHK/c2/jRt28E0UiMFJhny3S
         +kaQmTSTREb1d/ElqkG8/F4pUDeZzh+2/fMbyo4mkRg3pgITqoedGGtXmeJXWYA8I7zV
         2Glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730929332; x=1731534132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q144VAgCcVd1vsiXZJZkYdk2KimqsHbjpTX+IuAHgRc=;
        b=jel8mlFkbAMjEUN+f+YXdgTMDLIHwa1UlTedQZr7SLa2zs1+xT3ED7PBQ8pDo6eSZY
         sG7w/uNCHuXl5Uuc7sK0+/iV+Y3pS4xfPd3y6Iv+6xDiEVfoc960PzNLBr0HW7P3YqK2
         zM9VZ909gn3APWeFhsLQmH+5DloNVVeQPjro9/RJFgsmnAcmQVZR2U/cjZYD0YVgHgKY
         IBv8d6uoV08jYShgseJ4yXH51dURG3g+ZrTUxEob20TqsJ//uOfCMOBCq+RsFvV1DZk3
         aQaEf1fz7afBTC+QHx6965WHR6Q93fZxLtCk0dTHpuhPLzZkZ5bIcnua+rQxonAOFDan
         8XTw==
X-Gm-Message-State: AOJu0YxQZu7MiUx9BQQbLqu/Y+TsIt8sENT1g+m0YF1Qz58LGXJha8hG
	Ljmj2kI1VzH2EvtA+vd70IhvHJ4t0c3rl8Wiw0Om+tk+vfdTdrsO3FuTYPBnpx09plZ8vV53q9Z
	62Chjt7wdDxee3D5QV4gojB8QQxiHlQ==
X-Google-Smtp-Source: AGHT+IFhnuHU0Oddu4D2j187QUrtUj4CQi5X5sgN9sfTObu5NuC/jRIrM9054xHJ4JeN6tpzkZK4HYj3HqUGNPciISo=
X-Received: by 2002:a67:f4d1:0:b0:4a4:878a:e3b7 with SMTP id
 ada2fe7eead31-4a954afdd07mr20739194137.22.1730929330940; Wed, 06 Nov 2024
 13:42:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105183936.252530-1-cgoettsche@seltendoof.de> <20241105183936.252530-2-cgoettsche@seltendoof.de>
In-Reply-To: <20241105183936.252530-2-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 6 Nov 2024 16:42:00 -0500
Message-ID: <CAP+JOzQemwf6hor+=fRm7p9LLBy9znGob=6rSYVhs3tWbqgPoQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] libselinux: avoid dynamic allocation in openattr()
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 1:46=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> openattr() supplies the simplementation for the getcon(3) interface

implementation

> family.  Use a short local buffer instead of descend into memory

"Use a short local buffer instead of dynamic memory allocation"?

> allocation.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/src/procattr.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
> index ddcc7f8d..ee1f48af 100644
> --- a/libselinux/src/procattr.c
> +++ b/libselinux/src/procattr.c
> @@ -86,32 +86,32 @@ static void init_procattr(void)
>  static int openattr(pid_t pid, const char *attr, int flags)
>  {
>         int fd, rc;
> -       char *path;
> +       char path[56];  /* must hold "/proc/self/task/%d/attr/sockcreate"=
 */

Why 56? I understand that sockcreate is the largest attr, but it looks
to me like you are giving way more space than is needed for the pid. I
am just curious. Maybe I am missing something.

Thanks,
Jim


>         pid_t tid;
>
>         if (pid > 0) {
> -               rc =3D asprintf(&path, "/proc/%d/attr/%s", pid, attr);
> +               rc =3D snprintf(path, sizeof(path), "/proc/%d/attr/%s", p=
id, attr);
>         } else if (pid =3D=3D 0) {
> -               rc =3D asprintf(&path, "/proc/thread-self/attr/%s", attr)=
;
> -               if (rc < 0)
> +               rc =3D snprintf(path, sizeof(path), "/proc/thread-self/at=
tr/%s", attr);
> +               if (rc < 0 || (size_t)rc >=3D sizeof(path)) {
> +                       errno =3D EOVERFLOW;
>                         return -1;
> +               }
>                 fd =3D open(path, flags | O_CLOEXEC);
>                 if (fd >=3D 0 || errno !=3D ENOENT)
> -                       goto out;
> -               free(path);
> +                       return fd;
>                 tid =3D selinux_gettid();
> -               rc =3D asprintf(&path, "/proc/self/task/%d/attr/%s", tid,=
 attr);
> +               rc =3D snprintf(path, sizeof(path), "/proc/self/task/%d/a=
ttr/%s", tid, attr);
>         } else {
>                 errno =3D EINVAL;
>                 return -1;
>         }
> -       if (rc < 0)
> +       if (rc < 0 || (size_t)rc >=3D sizeof(path)) {
> +               errno =3D EOVERFLOW;
>                 return -1;
> +       }
>
> -       fd =3D open(path, flags | O_CLOEXEC);
> -out:
> -       free(path);
> -       return fd;
> +       return open(path, flags | O_CLOEXEC);
>  }
>
>  static int getprocattrcon_raw(char **context, pid_t pid, const char *att=
r,
> --
> 2.45.2
>
>
