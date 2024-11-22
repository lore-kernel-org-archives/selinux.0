Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D1C4A0C
	for <selinux@vger.kernel.org>; Fri, 22 Nov 2024 21:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309378; cv=none; b=K053Amque64za9cZ8d6Qhsm3oCxewjxGkOr5Mhq0aZYn0J2WfhOwnxfJEr5EJUXvYo7OzUQ1a8uhkZyg5VQFaKhbDh1RV+bHDDq1LwPVzHE4kzq1NQbzg/ShJhBW/4ttNVweoiFDLyrlnvFa8nKl5Z6XWuf7WfNN5IgMo4bTcPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309378; c=relaxed/simple;
	bh=rSCvkp5Qanwt1tPLW/ue+LdGfNupFYxxE/GI82L6Toc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KZ5i13k0gVTUt9aNa2FNU/8F0GRL1YiBkTupb+cyFWHiiXOrpkgEYBmm0z5DdCbP2dS9IqaJ85AiO/7KJOM6DWhgXBZUQvyigGL3sCfo70ooFZITZC7E5/Q56JhXruR2p5DyosrZRARmwmUSolV0cUbNWhQdZpKmP73EtzMARPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVrKAcRK; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVrKAcRK"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5eb9ee4f14cso1225675eaf.1
        for <selinux@vger.kernel.org>; Fri, 22 Nov 2024 13:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732309376; x=1732914176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIIK6f5qVlohxhNp1pijMKAU+Cs4kYi9dk7jsYv0U8w=;
        b=GVrKAcRKMgfxFtaCvmJe9799b44F++Hg4kjNYSsuTs1DHQzLD+jSDoAm0h547tEWiq
         +OOnoiuePb0CSnEDB/X+cNanzwyDopl/X4knQeax3A9zPwTKHo1U+23avXnHLQ5L57c+
         PMifYspr8loe7Er2cnbtLgcwPM/e+FqxvXnrpfs6sOKVaG3On9V0A25GrIXNAUzT+NHS
         lnB7S78O6qTcKgaqNU1TuAidEEul6aDKOKIz5Q46dfRb26U/QgH1TVRZXgaw+pq8qGWY
         f1dc7U/I60UC7sYsiwNCklivQp7KxmMFntc+POsPNHCDv869O5H4UE5xk863Ju+nqq3Z
         EtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732309376; x=1732914176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wIIK6f5qVlohxhNp1pijMKAU+Cs4kYi9dk7jsYv0U8w=;
        b=drzIZeZ5XTS3G3srbzEveOBxG6EpyWRkOIQZhH7p2EEWtwhPLNWS1AXb1ebRGACOdY
         4WcJPUJ51CQrFMfr7H2bIUd+zQz+QX54pFLgciNUBth4FCia2kGGy7t0iuWgqkvoRBIv
         vrjqvgvmUd07r28cPTExNQ8mPBz7R75QiEMijJ0axmg9Zn8OoA4IGlYlJN2OnHknG3rf
         m/+9p4UnVwRm82aB+jlFDfZINUlAzQea45GjJxV0MGGyNIF1iS+2MRVxKqCsEWjsCWEO
         3UZZBEfOjGGVir6Enpkd2XgMQD5J89uBDFvtI6kE4vRm6/8lUkSdqyD1AvL5hequtp1g
         1csQ==
X-Gm-Message-State: AOJu0Yyu8z3Nr/Zrex/y2edmJBikizBBE2e86L/40IESNIJcxpzQjq2b
	eJGiImh1UJ+kzTfAFG4dILapgrWAAhdqle0/z0xI19xPB6/x4DbdAQ7G3FxtPl6Pe9DVJrrQoym
	7c6JScuPG5gaBllN1jrpW6fRduZfRXGV+
X-Gm-Gg: ASbGncutcBhpnir9/o43JNqoz6feLLU4wpLD+yZmgZMuCGxumA83cJVL4JfZqd1Ts3t
	VTLwFDdCsdZjPhV+6WBDstQEIiPPsUNo=
X-Google-Smtp-Source: AGHT+IFSv2Gtsexl/LtTL+h2JF99VDuHPw6DC7pCnFSNWkBOHclsT4x6D3/UPfZfCMXl26F51s754pzRHqJ+QVTxBEQ=
X-Received: by 2002:a05:6359:5ce0:b0:1ca:79f0:4e25 with SMTP id
 e5c5f4694b2df-1ca79f0681fmr346094155d.7.1732309375566; Fri, 22 Nov 2024
 13:02:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120115951.42445-1-cgoettsche@seltendoof.de>
In-Reply-To: <20241120115951.42445-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 22 Nov 2024 16:02:44 -0500
Message-ID: <CAP+JOzSY4U+LJmP1reVw=mse7eG897=oj79gDp6XvRCxmFpS-g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] libselinux: make use of calloc(3)
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 7:00=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Use calloc(3) instead of calling malloc(3) plus a call to memset(3) or
> manual zero'ing.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these three patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/fgetfilecon.c         | 3 +--
>  libselinux/src/get_context_list.c    | 3 +--
>  libselinux/src/get_initial_context.c | 3 +--
>  libselinux/src/getfilecon.c          | 3 +--
>  libselinux/src/getpeercon.c          | 3 +--
>  libselinux/src/label_media.c         | 6 ++----
>  libselinux/src/label_x.c             | 6 ++----
>  libselinux/src/lgetfilecon.c         | 3 +--
>  libselinux/src/matchpathcon.c        | 3 +--
>  libselinux/src/procattr.c            | 3 +--
>  libselinux/src/setrans_client.c      | 5 ++---
>  11 files changed, 14 insertions(+), 27 deletions(-)
>
> diff --git a/libselinux/src/fgetfilecon.c b/libselinux/src/fgetfilecon.c
> index d7051171..782861ed 100644
> --- a/libselinux/src/fgetfilecon.c
> +++ b/libselinux/src/fgetfilecon.c
> @@ -39,10 +39,9 @@ int fgetfilecon_raw(int fd, char ** context)
>         ssize_t ret;
>
>         size =3D INITCONTEXTLEN + 1;
> -       buf =3D malloc(size);
> +       buf =3D calloc(1, size);
>         if (!buf)
>                 return -1;
> -       memset(buf, 0, size);
>
>         ret =3D fgetxattr_wrapper(fd, XATTR_NAME_SELINUX, buf, size - 1);
>         if (ret < 0 && errno =3D=3D ERANGE) {
> diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_conte=
xt_list.c
> index 222b54c1..8d5ee6fb 100644
> --- a/libselinux/src/get_context_list.c
> +++ b/libselinux/src/get_context_list.c
> @@ -481,12 +481,11 @@ int get_ordered_context_list(const char *user,
>            the "failsafe" context to at least permit root login
>            for emergency recovery if possible. */
>         freeconary(reachable);
> -       reachable =3D malloc(2 * sizeof(char *));
> +       reachable =3D calloc(2, sizeof(char *));
>         if (!reachable) {
>                 rc =3D -1;
>                 goto out;
>         }
> -       reachable[0] =3D reachable[1] =3D 0;
>         rc =3D get_failsafe_context(user, &reachable[0]);
>         if (rc < 0) {
>                 freeconary(reachable);
> diff --git a/libselinux/src/get_initial_context.c b/libselinux/src/get_in=
itial_context.c
> index 0f25ba3f..fb774c82 100644
> --- a/libselinux/src/get_initial_context.c
> +++ b/libselinux/src/get_initial_context.c
> @@ -39,12 +39,11 @@ int security_get_initial_context_raw(const char * nam=
e, char ** con)
>                 return -1;
>
>         size =3D selinux_page_size;
> -       buf =3D malloc(size);
> +       buf =3D calloc(1, size);
>         if (!buf) {
>                 ret =3D -1;
>                 goto out;
>         }
> -       memset(buf, 0, size);
>         ret =3D read(fd, buf, size - 1);
>         if (ret < 0)
>                 goto out2;
> diff --git a/libselinux/src/getfilecon.c b/libselinux/src/getfilecon.c
> index 4bee3137..31c9f0de 100644
> --- a/libselinux/src/getfilecon.c
> +++ b/libselinux/src/getfilecon.c
> @@ -14,10 +14,9 @@ int getfilecon_raw(const char *path, char ** context)
>         ssize_t ret;
>
>         size =3D INITCONTEXTLEN + 1;
> -       buf =3D malloc(size);
> +       buf =3D calloc(1, size);
>         if (!buf)
>                 return -1;
> -       memset(buf, 0, size);
>
>         ret =3D getxattr(path, XATTR_NAME_SELINUX, buf, size - 1);
>         if (ret < 0 && errno =3D=3D ERANGE) {
> diff --git a/libselinux/src/getpeercon.c b/libselinux/src/getpeercon.c
> index a9dca73e..c7abd886 100644
> --- a/libselinux/src/getpeercon.c
> +++ b/libselinux/src/getpeercon.c
> @@ -18,10 +18,9 @@ int getpeercon_raw(int fd, char ** context)
>         ssize_t ret;
>
>         size =3D INITCONTEXTLEN + 1;
> -       buf =3D malloc(size);
> +       buf =3D calloc(1, size);
>         if (!buf)
>                 return -1;
> -       memset(buf, 0, size);
>
>         ret =3D getsockopt(fd, SOL_SOCKET, SO_PEERSEC, buf, &size);
>         if (ret < 0 && errno =3D=3D ERANGE) {
> diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
> index 0510b5b1..be3df388 100644
> --- a/libselinux/src/label_media.c
> +++ b/libselinux/src/label_media.c
> @@ -134,10 +134,9 @@ static int init(struct selabel_handle *rec, const st=
ruct selinux_opt *opts,
>                                 status =3D 0;
>                                 goto finish;
>                         }
> -                       data->spec_arr =3D malloc(sizeof(spec_t)*data->ns=
pec);
> +                       data->spec_arr =3D calloc(data->nspec, sizeof(spe=
c_t));
>                         if (data->spec_arr =3D=3D NULL)
>                                 goto finish;
> -                       memset(data->spec_arr, 0, sizeof(spec_t)*data->ns=
pec);
>                         maxnspec =3D data->nspec;
>
>                         status =3D fseek(fp, 0L, SEEK_SET);
> @@ -230,10 +229,9 @@ int selabel_media_init(struct selabel_handle *rec,
>  {
>         struct saved_data *data;
>
> -       data =3D (struct saved_data *)malloc(sizeof(*data));
> +       data =3D (struct saved_data *)calloc(1, sizeof(*data));
>         if (!data)
>                 return -1;
> -       memset(data, 0, sizeof(*data));
>
>         rec->data =3D data;
>         rec->func_close =3D &close;
> diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
> index 1a5b9268..5b0e4063 100644
> --- a/libselinux/src/label_x.c
> +++ b/libselinux/src/label_x.c
> @@ -161,10 +161,9 @@ static int init(struct selabel_handle *rec, const st=
ruct selinux_opt *opts,
>                                 status =3D 0;
>                                 goto finish;
>                         }
> -                       data->spec_arr =3D malloc(sizeof(spec_t)*data->ns=
pec);
> +                       data->spec_arr =3D calloc(data->nspec, sizeof(spe=
c_t));
>                         if (data->spec_arr =3D=3D NULL)
>                                 goto finish;
> -                       memset(data->spec_arr, 0, sizeof(spec_t)*data->ns=
pec);
>                         maxnspec =3D data->nspec;
>
>                         status =3D fseek(fp, 0L, SEEK_SET);
> @@ -255,10 +254,9 @@ int selabel_x_init(struct selabel_handle *rec, const=
 struct selinux_opt *opts,
>  {
>         struct saved_data *data;
>
> -       data =3D (struct saved_data *)malloc(sizeof(*data));
> +       data =3D (struct saved_data *)calloc(1, sizeof(*data));
>         if (!data)
>                 return -1;
> -       memset(data, 0, sizeof(*data));
>
>         rec->data =3D data;
>         rec->func_close =3D &close;
> diff --git a/libselinux/src/lgetfilecon.c b/libselinux/src/lgetfilecon.c
> index d1fb821b..f0a3aa1a 100644
> --- a/libselinux/src/lgetfilecon.c
> +++ b/libselinux/src/lgetfilecon.c
> @@ -14,10 +14,9 @@ int lgetfilecon_raw(const char *path, char ** context)
>         ssize_t ret;
>
>         size =3D INITCONTEXTLEN + 1;
> -       buf =3D malloc(size);
> +       buf =3D calloc(1, size);
>         if (!buf)
>                 return -1;
> -       memset(buf, 0, size);
>
>         ret =3D lgetxattr(path, XATTR_NAME_SELINUX, buf, size - 1);
>         if (ret < 0 && errno =3D=3D ERANGE) {
> diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.=
c
> index 967520e4..dbc11ee1 100644
> --- a/libselinux/src/matchpathcon.c
> +++ b/libselinux/src/matchpathcon.c
> @@ -202,10 +202,9 @@ int matchpathcon_filespec_add(ino_t ino, int specind=
, const char *file)
>         struct stat sb;
>
>         if (!fl_head) {
> -               fl_head =3D malloc(sizeof(file_spec_t) * HASH_BUCKETS);
> +               fl_head =3D calloc(HASH_BUCKETS, sizeof(file_spec_t));
>                 if (!fl_head)
>                         goto oom;
> -               memset(fl_head, 0, sizeof(file_spec_t) * HASH_BUCKETS);
>         }
>
>         h =3D (ino + (ino >> HASH_BITS)) & HASH_MASK;
> diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
> index b7a93a2b..ddcc7f8d 100644
> --- a/libselinux/src/procattr.c
> +++ b/libselinux/src/procattr.c
> @@ -139,12 +139,11 @@ static int getprocattrcon_raw(char **context, pid_t=
 pid, const char *attr,
>                 return -1;
>
>         size =3D selinux_page_size;
> -       buf =3D malloc(size);
> +       buf =3D calloc(1, size);
>         if (!buf) {
>                 ret =3D -1;
>                 goto out;
>         }
> -       memset(buf, 0, size);
>
>         do {
>                 ret =3D read(fd, buf, size - 1);
> diff --git a/libselinux/src/setrans_client.c b/libselinux/src/setrans_cli=
ent.c
> index d7dbc0ca..45cbe5c1 100644
> --- a/libselinux/src/setrans_client.c
> +++ b/libselinux/src/setrans_client.c
> @@ -173,11 +173,10 @@ receive_response(int fd, uint32_t function, char **=
outdata, int32_t * ret_val)
>                 return -1;
>         }
>
> -       data =3D malloc(data_size);
> +       /* coveriety doesn't realize that data will be initialized in rea=
dv */
> +       data =3D calloc(1, data_size);
>         if (!data)
>                 return -1;
> -       /* coveriety doesn't realize that data will be initialized in rea=
dv */
> -       memset(data, 0, data_size);
>
>         resp_data.iov_base =3D data;
>         resp_data.iov_len =3D data_size;
> --
> 2.45.2
>
>
