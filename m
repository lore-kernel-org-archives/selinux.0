Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA932F5337
	for <selinux@vger.kernel.org>; Mon, 17 Aug 2026 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786979078; cv=pass; b=USMZcrojI+ChuxkeZOqs5jbc09vupzKBnM+x+UDGV6hDVJQwakJCY4PXsN9g8vroYvHzP8PKpHmN5/2aWz3x+g1C9yy109KExzv3FoFaBYRfCdurevkt53NiCbZYIn1mbFI5DkoayIE2tIXplFs4ODUATzIS6ECwtcyjFdwSc4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786979078; c=relaxed/simple;
	bh=Ct/ojxO7RoCFKdjpm4pZOfjf64ofn3FG7B8NARjWeAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pivOolIRbXdqK0FM0Q+eo3MBdlseoZpxEUU6Nap8/z5/mef/g4Z15nQfbFDIW1MUZQINkk4LHGoyr2olLH4h4zBM2jxplDLsUkfQgRVcCDsyr/Uk2gkVUl5ObOMpKld9eeysRVxGZUG1DZS+yfvja8G/EnqoMawxi6ZkIY0LpYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p4u6q7+I; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p4u6q7+I"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39db07589caso27107211fa.2
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2026 08:04:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786979074; cv=none;
        d=google.com; s=arc-20260327;
        b=Ni4hTZqV6xoXKeCq0yhF9Troerja9IJh/XOrwW1It0jCyxQ5Jpxo5jMSL/0S6/iFN4
         MLUYVD60tpebZFB72Kabsnt4zhMteVEyBATDqvAzWNonazRDyszGnyKZxbARA9MpeQgg
         vMvPUUxYKWEcCSvlVBwj6y2iyJg7qptapVsMUXxQBqZCV0qN0KMO3OyM1XOd6i5JrhNT
         9Rz5vpkpcFB8JRvI1oGEgILEQPChHVm+cIzCE3+uS9jjUkSogSxKGWZacSgi7g+MvYHA
         05IgWMubflGt4aVOV8zmptZgYhJhPD+ciuw0F/EZY3K17b02mcrI7TM22N9e175Pj2tf
         MREA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RvE78KN6XMVnLADkj5N+pIqRp8mxm3puJE3e8+XMAms=;
        fh=axRoY9vCckR1BMylL6Yj0fucVOYx8YrXkrMB2J6BasI=;
        b=izPbYKFppuExqWuDBJ6t4IvhljLKSRnpObz1LwnhDY0PLwhfZ0VWIfwKbtpE7JjorK
         L0yqSF3S3Rh2azNBE5ipNguI2S8l3FrVzMcpFL3bsOwBY7uxBZO5LhHIRRdHhfSCDPAn
         ngBt8nc5hL2wuxMXqzzyxWrYrYORzBmsAtKghAQjHvNThhuPjHBqTQ3lZttwXGMg3yA5
         sgc59o/X2KsUSTThinYW6wIzL7EwhO57fI4RJcrqZH+TrmtbAvaRvNq3Bxi3IxENIgP/
         gO6NOOqXxcHKe5hTqFjmwHiBYayiS7CvSSTL6d+xeXirlxzTblt/ryV+Jv5Ls/JIKnJV
         HUAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786979074; x=1787583874; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RvE78KN6XMVnLADkj5N+pIqRp8mxm3puJE3e8+XMAms=;
        b=p4u6q7+IK7NoCD4j5Ta7OKIj0PmGHJptTZCXl/4YW55Kd0ZPFh6eWDaCBDjJNOFN42
         V+4dVgDqNE7qNblApjKSYBBYNtuntD/0zy6sjhQCC8GYGsU9KejsU4TUsnGGZTHnsxc1
         cBhr2bzPZpfqBijb8yg0QgBPOImP3P9qKiILUpGcYvplgQmMbY+eO4hbMWfV92FGxuzo
         xfGT2xPBXWR2P+i85icIOrDHyagpLc0rXK1XkcTCs+ObGhqI/6WsJ5L5S8zL5/zw84Sj
         KlcQxnXT3gpmCkQMj3iDmhA4buMH57oC09PRw3tnIssI5iaeV2RyvKAlQTXcn59rb6GD
         qEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786979074; x=1787583874;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RvE78KN6XMVnLADkj5N+pIqRp8mxm3puJE3e8+XMAms=;
        b=e8r4C+V0QWY6BdLem9YbZqMOlJwXFMS5FjbdCSmFYOd/xyBD5uIQLMG7yMHBCEiqdX
         b9Jfte5XSdznX1hqJbxshZ7EqtFPJPVS9g/HTCFDiUGUnO2qYwFxFxpo29hc+UQw67ou
         6i035uhyXwG8VPbiEGkl4NniVMMKZgfwOtkyz4e1waWKhTULAojmAL6G/3zZeIlFrUhC
         NFMcLFTw/kXZoRTyNzhUytXwOIe5mpFUbxzdyKcSC9PbJ4ZUTNMEfNn6ACrsqos61INk
         3u0t9VIw8Lyz7hZibrZW0pQ9agTVvFMlgmbsb+Lg/XvGemLCkHhYrQ7SurPi39rdiEIU
         KqFQ==
X-Gm-Message-State: AOJu0Yw1vPWiUdXjjEGShn8L6mc30/84g8RgMPzHpsqHXq0sUhy5Xqj9
	MephovufIMUKE0ioqx7HOaP6xV9ic9PLVVntsCs8trYXCCzmTj/IPUQvqFdli5q+OZ4/WoTqQlS
	1ThKPt04KE+GsZeCpqnrdxXmOk375V98=
X-Gm-Gg: AR+sD100bm6PgsCNJkOUTXtL+hpr1kDlWV7Q5b+8wuJXNCCDNT8u/VIcqZMHKIAzPsq
	9uOcHHsoR595yOLkQAXRSYNJR7aNA9fvUVBVaSipWDKd8mx7u1OuuVw9RSg8jO5FV5wZxNckQdV
	afz0hejz0bxGo+dry+p4xEdcntTcGLEYkEZ6eGg/YmdJHpkUnuB6NeplbMLGCC12gzGUlT+06Qb
	xrIyQJvACgBYaDVcf0xZ2teJV2IIj7/y4Nvrb1+Rh7dhZapXuPPPHnKO3nVU/ralV8mfoAA9ghB
	GhmDRMULFGtZcgqgdoN9EhchltGtaBvTuFiChGGrrd+D/kanFVIq
X-Received: by 2002:a2e:be03:0:b0:39f:f175:bd23 with SMTP id
 38308e7fff4ca-3a1324b3c7bmr25026571fa.15.1786979073752; Mon, 17 Aug 2026
 08:04:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814133456.203958-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260814133456.203958-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 17 Aug 2026 11:04:22 -0400
X-Gm-Features: AcwNN1XDZZCLEGhmwIe8vPExMYcVg3mG3M0DUqHBAmthuybNNP0yKeG2STbdQqc
Message-ID: <CAP+JOzQjGEDuxcS8BAzbCvUNzisDUF9KMsQv=Ay99DB8_NQTLg@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux: selinux_restorecon: fix error message on
 intermediate symlinks
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com, Krzesimir Nowak <qdlacz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 9:35=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> selinux_restorecon(3) was changed by commit 67bc978bfaf9 ("libselinux:
> restorecon: revisit pinning files to avoid TOCTOU issues") to avoid
> following intermediate symlinks on the caller-supplied pathname unless
> the SELINUX_RESTORECON_REALPATH flag was set in the restorecon_flags
> parameter. However, because it calls openat(2) with both O_NOFOLLOW
> and O_DIRECTORY, the errno was being set to ENOTDIR and a message was
> logged with the pathname being "Not a directory" even if the terminal
> node of the path was in fact a directory. Fix the error handling logic
> and log message to correctly reflect the intermediate symlink-induced
> failure.
>
> Reported-by: Krzesimir Nowak <qdlacz@gmail.com>
> Fixes: 67bc978bfaf9 ("libselinux: restorecon: revisit pinning files to av=
oid TOCTOU issues")
> Fixes: https://github.com/SELinuxProject/selinux/issues/540
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

For these two patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/selinux_restorecon.c | 31 ++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index 49b8ff7e..fbadf367 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -1167,11 +1167,30 @@ static int safe_open(const char *path, struct sta=
t *sb)
>                                 nfd =3D openat(dfd, cur,
>                                              O_PATH | O_NOFOLLOW | O_DIRE=
CTORY |
>                                                      O_CLOEXEC);
> -                               close(dfd);
>                                 if (nfd < 0) {
> +                                       int err =3D errno;
> +                                       struct stat st;
> +
> +                                       /*
> +                                        * O_NOFOLLOW | O_DIRECTORY on a
> +                                        * symlink yields ENOTDIR; report
> +                                        * ELOOP so the caller can tell a=
n
> +                                        * unfollowed intermediate symlin=
k
> +                                        * from a genuine non-directory, =
and
> +                                        * so the fallback matches openat=
2's
> +                                        * RESOLVE_NO_SYMLINKS.
> +                                        */
> +                                       if (err =3D=3D ENOTDIR &&
> +                                           fstatat(dfd, cur, &st,
> +                                                   AT_SYMLINK_NOFOLLOW) =
=3D=3D 0 &&
> +                                           S_ISLNK(st.st_mode))
> +                                               err =3D ELOOP;
> +                                       close(dfd);
>                                         free(copy);
> +                                       errno =3D err;
>                                         return -1;
>                                 }
> +                               close(dfd);
>                                 dfd =3D nfd;
>                                 cur =3D next;
>                                 continue;
> @@ -1680,8 +1699,14 @@ static int selinux_restorecon_common(const char *p=
athname_orig,
>                         free(pathname);
>                         return 0;
>                 } else {
> -                       selinux_log(SELINUX_ERROR, "open(%s) failed: %m\n=
",
> -                                   pathname);
> +                       if (errno =3D=3D ELOOP)
> +                               selinux_log(
> +                                       SELINUX_ERROR,
> +                                       "%s: an intermediate path compone=
nt is a symbolic link (not followed)\n",
> +                                       pathname);
> +                       else
> +                               selinux_log(SELINUX_ERROR,
> +                                           "open(%s) failed: %m\n", path=
name);
>                         error =3D -1;
>                         goto cleanup;
>                 }
> --
> 2.55.0
>
