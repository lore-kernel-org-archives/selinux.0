Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5163595E
	for <selinux@vger.kernel.org>; Tue, 29 Jul 2025 14:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753800721; cv=none; b=WGuPtvOmBMGZ44nF6gM9MbEoieETENtIT5QIy58OPYS3DkA/f6asICfD+kk+c8vaoUJ6Fc2WZEUQKbeLjZjvMXzy5/esHCPQEzTL+6DQkpGpBNreBYJQBhbjHZGdl73WM1IpYQwb/TMr19diZn9FpCc/JYiO+s6nzdI4I+BmMFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753800721; c=relaxed/simple;
	bh=oQTKkwdTQjNEyUfrIVtKgn7a330lBiunRL4ghfr6+Lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SqwqwvRnOFYoxhk+j1knDjEppj95cayC36/Cl5rAntDGurqs8uHiTZRt0imjkq83ls/bTUEJFt0JCuLqFqs1Tn8xH6j1FoPyqU3jSAXLuyibgIQLIdR/lZu1CKOqPQ3hskdbOxo3JFruNOIKtw0lCtlhedFX0vDav21JkqEbJCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMNvTpW5; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMNvTpW5"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-31efefd2655so892360a91.0
        for <selinux@vger.kernel.org>; Tue, 29 Jul 2025 07:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753800719; x=1754405519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdPxV1loAo4mvujVZIPZO883CQ8HMP77t/UDEHYs4CQ=;
        b=YMNvTpW5R+LTK3eL7QBNL4XK3oTHe2JLmOtuWULvU0SG6tlkq8k7bLoeyd9k7GAB0n
         1c/byeoZ59AmAVWabwxS45H2+62jGIA4BU7ka2l3VulhABb4BjbAXZqkV8pTw5QeHiiH
         JyZNVHpH5jcbXUXDMQMvkGyge1YgcXwb69pNyMS5iA/if5g/ucgIY4yIJOpwxt87namU
         oioqQy6R3ZeKe7Sje5k4S9zAkmPnmK9YqCcQF2jJyqzztJIW8iHCFacB1Qc8cVM2sgan
         bvijwR+gabA1j3mxFE8p/VftRv3lrbXX617jSymmCgDGqL5kPxlKoc9MC/LvSVNe4xl9
         9YpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753800719; x=1754405519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdPxV1loAo4mvujVZIPZO883CQ8HMP77t/UDEHYs4CQ=;
        b=DeAfTyBpwZ0TMz1hdrWXmaTmGNZt93ShEfY/TvEm1PF5eZ97Dj8NuwSFmxuGh8ThVh
         tZQhPSa9QyujWtosgf/yfRq7zbjmYhTVwgdzKLmqK7dzEySiM3IHE1f5VtDY5g+EQnJb
         RfUR2adh8KfIgg2MdPvbrrTW+d6wNXGrFe5kdJBkGvIQbjBx42S/meLsTjGUgdUXCHk8
         f+bdPS0KTk6I/n8XFvPQadE0/5V/hE9xQ2OKU27GYg7Xoqdz+s3Gt6WUypnf2FdYYidA
         lMNDo7NF6uWvrclZyaKEd4TBVBfYp21RnG2ORaszNSZxCxzwsqWY8k0EmM8ewt50L40B
         oG2w==
X-Gm-Message-State: AOJu0YwZlaY/IMPxhmEA6Y3U5rSpuhprwcO9zubzmfY8nTrcl7bSnAVo
	SAb8LZud+GXEG+Ig+sxicBd43w8/aCY3zNPd8EC5MgZDsUZEBcHgkNpKQGqR/LVdc+Ly2sukDgN
	7gnoepUL+7g+ongCFIi0texn0M4Y+Ukc=
X-Gm-Gg: ASbGncsmEQ0ve9+w6ydd1LKipMKQCh05L3huJgclv66SrSc7+6chYz2ft/qi5DXYQZ0
	OsVnS6KVX13N4uCMjgfBtl+k6py87TdtblZWfuupKqT5jJGgKUFw3W+5bDEp2XDqgOF27Nly5Qy
	wiRDbyZ9fH/ozgOMrk21rA4ZHncUSxRiyFZp0xFHc8dEZecSZmbK7Aq+uSAEWFGuunjkEzVwRLe
	Z8BqaM=
X-Google-Smtp-Source: AGHT+IE4+RuWnS8X0+42Q4Xtf1fieRnQvu18ALLHO5LlnccOry5RSYFoqZBI857rS7xY6nO4hNlYzSqKkdQ3IZEx6Nw=
X-Received: by 2002:a17:90b:53c6:b0:313:d361:73d7 with SMTP id
 98e67ed59e1d1-31f28cc103bmr5783057a91.13.1753800718985; Tue, 29 Jul 2025
 07:51:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250727154422.732647-1-nvraxn@gmail.com> <20250727155530.733633-1-nvraxn@gmail.com>
In-Reply-To: <20250727155530.733633-1-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Jul 2025 10:51:46 -0400
X-Gm-Features: Ac12FXxn6ZPaUaM7PVvFtWFE_CSJ0vP7P5inY1Tw8oziVPNX9EisKErrG4Naxzs
Message-ID: <CAEjxPJ54SJLsdzygZiCc8L4vfwdFPJ5mpLzjXvDZ_aJCcp=EXw@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: remove out2 labels
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 27, 2025 at 11:55=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> wr=
ote:
>
> The out2 label previously only existed such that free(buf) isn't called
> if malloc(3) fails to allocate buf. However, posix says[1] that calling
> free(3) with a nullptr is valid:
>
> > If ptr is a null pointer, no action shall occur.
>
> Hence, remove the extra labels to simplify the logic.
>
> [1] https://pubs.opengroup.org/onlinepubs/009604499/functions/free.html
>
> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/canonicalize_context.c |  9 ++++-----
>  libselinux/src/compute_av.c           | 11 +++++------
>  libselinux/src/compute_create.c       | 13 ++++++-------
>  libselinux/src/compute_member.c       | 11 +++++------
>  libselinux/src/compute_relabel.c      | 11 +++++------
>  libselinux/src/compute_user.c         | 15 +++++++--------
>  libselinux/src/get_initial_context.c  |  7 +++----
>  libselinux/src/procattr.c             |  9 ++++-----
>  8 files changed, 39 insertions(+), 47 deletions(-)
>
> diff --git a/libselinux/src/canonicalize_context.c b/libselinux/src/canon=
icalize_context.c
> index 6af8491d..d9f0beb4 100644
> --- a/libselinux/src/canonicalize_context.c
> +++ b/libselinux/src/canonicalize_context.c
> @@ -36,12 +36,12 @@ int security_canonicalize_context_raw(const char * co=
n,
>         if (strlcpy(buf, con, size) >=3D size) {
>                 errno =3D EOVERFLOW;
>                 ret =3D -1;
> -               goto out2;
> +               goto out;
>         }
>
>         ret =3D write(fd, buf, strlen(buf) + 1);
>         if (ret < 0)
> -               goto out2;
> +               goto out;
>
>         memset(buf, 0, size);
>         ret =3D read(fd, buf, size - 1);
> @@ -54,12 +54,11 @@ int security_canonicalize_context_raw(const char * co=
n,
>         *canoncon =3D strdup(buf);
>         if (!(*canoncon)) {
>                 ret =3D -1;
> -               goto out2;
> +               goto out;
>         }
>         ret =3D 0;
> -      out2:
> -       free(buf);
>        out:
> +       free(buf);
>         close(fd);
>         return ret;
>  }
> diff --git a/libselinux/src/compute_av.c b/libselinux/src/compute_av.c
> index 354a19e1..bd31279f 100644
> --- a/libselinux/src/compute_av.c
> +++ b/libselinux/src/compute_av.c
> @@ -46,17 +46,17 @@ int security_compute_av_flags_raw(const char * scon,
>         if (ret < 0 || (size_t)ret >=3D len) {
>                 errno =3D EOVERFLOW;
>                 ret =3D -1;
> -               goto out2;
> +               goto out;
>         }
>
>         ret =3D write(fd, buf, strlen(buf));
>         if (ret < 0)
> -               goto out2;
> +               goto out;
>
>         memset(buf, 0, len);
>         ret =3D read(fd, buf, len - 1);
>         if (ret < 0)
> -               goto out2;
> +               goto out;
>
>         ret =3D sscanf(buf, "%x %x %x %x %u %x",
>                      &avd->allowed, &avd->decided,
> @@ -64,7 +64,7 @@ int security_compute_av_flags_raw(const char * scon,
>                      &avd->seqno, &avd->flags);
>         if (ret < 5) {
>                 ret =3D -1;
> -               goto out2;
> +               goto out;
>         } else if (ret < 6)
>                 avd->flags =3D 0;
>
> @@ -79,9 +79,8 @@ int security_compute_av_flags_raw(const char * scon,
>                 map_decision(tclass, avd);
>
>         ret =3D 0;
> -      out2:
> -       free(buf);
>        out:
> +       free(buf);
>         close(fd);
>         return ret;
>  }
> diff --git a/libselinux/src/compute_create.c b/libselinux/src/compute_cre=
ate.c
> index ff8553bc..b0c6ea34 100644
> --- a/libselinux/src/compute_create.c
> +++ b/libselinux/src/compute_create.c
> @@ -81,34 +81,33 @@ int security_compute_create_name_raw(const char * sco=
n,
>         if (len < 0 || (size_t)len >=3D size) {
>                 errno =3D EOVERFLOW;
>                 ret =3D -1;
> -               goto out2;
> +               goto out;
>         }
>
>         if (objname &&
>             object_name_encode(objname, buf + len, size - len) < 0) {
>                 errno =3D ENAMETOOLONG;
>                 ret =3D -1;
> -               goto out2;
> +               goto out;
>         }
>
>         ret =3D write(fd, buf, strlen(buf));
>         if (ret < 0)
> -               goto out2;
> +               goto out;
>
>         memset(buf, 0, size);
>         ret =3D read(fd, buf, size - 1);
>         if (ret < 0)
> -               goto out2;
> +               goto out;
>
>         *newcon =3D strdup(buf);
>         if (!(*newcon)) {
>                 ret =3D -1;
> -               goto out2;
> +               goto out;
>         }
>         ret =3D 0;
> -      out2:
> -       free(buf);
>        out:
> +       free(buf);
>         close(fd);
>         return ret;
>  }
> diff --git a/libselinux/src/compute_member.c b/libselinux/src/compute_mem=
ber.c
> index 53d2f559..ebe33264 100644
> --- a/libselinux/src/compute_member.c
> +++ b/libselinux/src/compute_member.c
> @@ -41,27 +41,26 @@ int security_compute_member_raw(const char * scon,
>         if (ret < 0 || (size_t)ret >=3D size) {
>                 errno =3D EOVERFLOW;
>                 ret =3D -1;
> -               goto out2;
> +               goto out;
>         }
>
>         ret =3D write(fd, buf, strlen(buf));
>         if (ret < 0)
> -               goto out2;
> +               goto out;
>
>         memset(buf, 0, size);
>         ret =3D read(fd, buf, size - 1);
>         if (ret < 0)
> -               goto out2;
> +               goto out;
>
>         *newcon =3D strdup(buf);
>         if (!(*newcon)) {
>                 ret =3D -1;
> -               goto out2;
> +               goto out;
>         }
>         ret =3D 0;
> -      out2:
> -       free(buf);
>        out:
> +       free(buf);
>         close(fd);
>         return ret;
>  }
> diff --git a/libselinux/src/compute_relabel.c b/libselinux/src/compute_re=
label.c
> index 9c0a2304..b2c1520e 100644
> --- a/libselinux/src/compute_relabel.c
> +++ b/libselinux/src/compute_relabel.c
> @@ -41,27 +41,26 @@ int security_compute_relabel_raw(const char * scon,
>         if (ret < 0 || (size_t)ret >=3D size) {
>                 errno =3D EOVERFLOW;
>                 ret =3D -1;
> -               goto out2;
> +               goto out;
>         }
>
>         ret =3D write(fd, buf, strlen(buf));
>         if (ret < 0)
> -               goto out2;
> +               goto out;
>
>         memset(buf, 0, size);
>         ret =3D read(fd, buf, size - 1);
>         if (ret < 0)
> -               goto out2;
> +               goto out;
>
>         *newcon =3D strdup(buf);
>         if (!*newcon) {
>                 ret =3D -1;
> -               goto out2;
> +               goto out;
>         }
>         ret =3D 0;
> -      out2:
> -       free(buf);
>        out:
> +       free(buf);
>         close(fd);
>         return ret;
>  }
> diff --git a/libselinux/src/compute_user.c b/libselinux/src/compute_user.=
c
> index d4387aed..584219c7 100644
> --- a/libselinux/src/compute_user.c
> +++ b/libselinux/src/compute_user.c
> @@ -43,27 +43,27 @@ int security_compute_user_raw(const char * scon,
>         if (ret < 0 || (size_t)ret >=3D size) {
>                 errno =3D EOVERFLOW;
>                 ret =3D -1;
> -               goto out2;
> +               goto out;
>         }
>
>         ret =3D write(fd, buf, strlen(buf));
>         if (ret < 0)
> -               goto out2;
> +               goto out;
>
>         memset(buf, 0, size);
>         ret =3D read(fd, buf, size - 1);
>         if (ret < 0)
> -               goto out2;
> +               goto out;
>
>         if (sscanf(buf, "%u", &nel) !=3D 1) {
>                 ret =3D -1;
> -               goto out2;
> +               goto out;
>         }
>
>         ary =3D malloc((nel + 1) * sizeof(char *));
>         if (!ary) {
>                 ret =3D -1;
> -               goto out2;
> +               goto out;
>         }
>
>         ptr =3D buf + strlen(buf) + 1;
> @@ -72,16 +72,15 @@ int security_compute_user_raw(const char * scon,
>                 if (!ary[i]) {
>                         freeconary(ary);
>                         ret =3D -1;
> -                       goto out2;
> +                       goto out;
>                 }
>                 ptr +=3D strlen(ptr) + 1;
>         }
>         ary[nel] =3D NULL;
>         *con =3D ary;
>         ret =3D 0;
> -      out2:
> -       free(buf);
>        out:
> +       free(buf);
>         close(fd);
>         return ret;
>  }
> diff --git a/libselinux/src/get_initial_context.c b/libselinux/src/get_in=
itial_context.c
> index fb774c82..badcda9f 100644
> --- a/libselinux/src/get_initial_context.c
> +++ b/libselinux/src/get_initial_context.c
> @@ -46,17 +46,16 @@ int security_get_initial_context_raw(const char * nam=
e, char ** con)
>         }
>         ret =3D read(fd, buf, size - 1);
>         if (ret < 0)
> -               goto out2;
> +               goto out;
>
>         *con =3D strdup(buf);
>         if (!(*con)) {
>                 ret =3D -1;
> -               goto out2;
> +               goto out;
>         }
>         ret =3D 0;
> -      out2:
> -       free(buf);
>        out:
> +       free(buf);
>         close(fd);
>         return ret;
>  }
> diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
> index aa16c934..f8e8f191 100644
> --- a/libselinux/src/procattr.c
> +++ b/libselinux/src/procattr.c
> @@ -153,22 +153,21 @@ static int getprocattrcon_raw(char **context, pid_t=
 pid, const char *attr,
>                 ret =3D read(fd, buf, size - 1);
>         } while (ret < 0 && errno =3D=3D EINTR);
>         if (ret < 0)
> -               goto out2;
> +               goto out;
>
>         if (ret =3D=3D 0) {
>                 *context =3D NULL;
> -               goto out2;
> +               goto out;
>         }
>
>         *context =3D strdup(buf);
>         if (!(*context)) {
>                 ret =3D -1;
> -               goto out2;
> +               goto out;
>         }
>         ret =3D 0;
> -      out2:
> -       free(buf);
>        out:
> +       free(buf);
>         errno_hold =3D errno;
>         close(fd);
>         errno =3D errno_hold;
> --
> 2.50.1
>
>
