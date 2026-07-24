Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B8A36195C
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784907097; cv=pass; b=HyywMYUzm0CcAV0lgheVDXRkYjHdr0g8B8GvGDnGDQOaIpXAWUwsqoCSn5Uw8r5whusWbdAFr6iwtGv8cr6FMokM6G6o+l7O1drkbeuj/9xNLo/lHp8KH8InF4vARfRj92xCcwJm4yVAiQvBzbkzw1O/71XGQZ+qhz2obMNTjjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784907097; c=relaxed/simple;
	bh=5i2KPG/1Z6xXrSYbHVaNllnwNSHAYgUTdbPYMGU4bLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jST/N8F5SVQiCHb/j9IN6HbVZJ1hmRd+369OHzO4dJlJPMcbC6A8uW2oVJwEam0o1Htg4npzHLifcm41jJJJQlSdf3sga0DH1MKGn4ZKu5vi6qAu1+uchS1o1y2ZJu6YYW1IRpmyoP2ac2wRVmSlvmBxIim+uq3/dxzYSJqO4xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeOAmHly; arc=pass smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeOAmHly"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-43b7e186a0cso205172fac.0
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 08:31:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784907095; cv=none;
        d=google.com; s=arc-20260327;
        b=WDQxFPR9/1aD1Qe3CuqTz3YUWQ+wSC8/LLBghmdnpU7MOreHNShnsYoJhPqfk2jEpF
         Be4HDe9x4V3Ofl1sogD7iyRiCPkzlgrgig0Glsi/AXDUsMCVZTF7OfQAFHReiPDO8H5X
         v6fTbX9QlEpJ24UfSoBUT+k+69RsuxNjTIvMcwuiLvhnZ7Khh6nafELplVL8lixjuEC5
         BEwyn1fq64nxHA9O5W9YAiJgy32NNHMKF44aXMO8Rz3FYHAbugsZ+n8FiY1y/71rML7y
         fpvGjPCiH4SsV/rCx+wOFka2iYrqKVCeMn/rHCeNEv1m3kgUXSEaGsXlZOtjlwr/iVAa
         9PBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gUzQI7g5QC8sK5IJRLz3K1u4o3UbNd1W88b6WQ6BvIA=;
        fh=mMDxYY5wtlIekXoYIfjt6lvMWgTaMUwdwgsYDQ6qy3A=;
        b=cg70/ZvkhUYVWcV29zHzcAIff+dVAQAYDUUfpmVhoHslQz467Musig85ThfzrSdFqX
         iXjrs3gAUjT54HM41L8u1DhGRnr2gEWp21/bV6Csw5hQcwBJ1YLcQfasrO5QvHUxwG8J
         Quj5BysW4GGhj4vWi/KMVJ1f4ZlRWWyvrn5bQYMNXlUQ1gbpDXsqsNKyA8idx0wrk/LH
         iIuAAqSTnjTF8U+npJDzizTqHSmFfs+RZNsZc2fNrj0DT3JK1MiSDKzoj+g9QlqsmYsn
         7iUeGoeFqTNSBTWv7QR0f+3uxvhBm/5JXWzaCB6o+k9c4V/WNoX8ogszRMgglpLyrVUJ
         dPzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784907095; x=1785511895; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gUzQI7g5QC8sK5IJRLz3K1u4o3UbNd1W88b6WQ6BvIA=;
        b=UeOAmHlyw7guZ3il9BhGbISWtvlmQs19jA9MBmW2wHAbbbF/vlqFG/v+fVj6oR6C4N
         nMT3q/J12Xgh2Q68CM724d5hkhmdSGKe/1WuTDLFcr16kgv/Bsco2IlsJhKRG68CQSXH
         zMstErAPwJmRoVQKK1e9MLnRqqgoeD1gqMoTe83wzdywXMIux2IgRdnAaarkrNb3AiVr
         l3GUpkQI5W7bX0He0cKvXvK0whNsCxXFIkk7PBPJUqmG1/CvntX6hqz320YrXmXsme1q
         AOjlTxeFOTHb1GctzhRe1Xvbi5pVdm3pXE0dA/GgT1QbTp0HN5d26dv94+hkhPXiV9SK
         oSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784907095; x=1785511895;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gUzQI7g5QC8sK5IJRLz3K1u4o3UbNd1W88b6WQ6BvIA=;
        b=gM3kjQta6+hEYgikbfYeNEFNHsPzjJMlrv34HJ40jk2Rrz9BQcEr0gPik58PQXXrbo
         BzXnY22TIegsvI2Z0PDeRhTsn47rEEHpPJiNo7aLWwLED3RoFSH1JmiPq6I5LWNHAsRk
         8UMHZCPtezpIlAoGUd4dg5jcWnriP6R8qJh5oGSBbawo6x7ZSCppbmhmr1b8aPGI0pW+
         QlSLDLE1fYu3QA9VNL1IUCC/I9MFVDRjlcRVswkmq2Q2xWQ9lfP0WX7BFx0kH9MMlGIn
         DhUMeaJw/rLco93s90XBbSnKTrnNzRJJpBtTmU1RGqWBnInDyXvQcWp1Tp+Xgvk4Dx8p
         7AiA==
X-Gm-Message-State: AOJu0Yw9rjYhv1URZpF/DTrKx5Y8jdz9fHlYlSldtTgsxijMVIDEkAsc
	dd2iHHtxNQQdjoS3XBHwlS8+5kI2n+AfP5YCaVkgBeYoXKZj+X93y29L8dmMRtAOLCGn8mOutUz
	kN3uQWHRa/LgYKzg85dZu+o/ukTktGNA=
X-Gm-Gg: AR+sD12KMnyqxY2q7th8QrvQX6gcbuQTKLoqDnGuyuyu5dacetLqNuEMrTS/p4P8tLX
	qV/0IEQwApV587uQa/dyZokEmzx0ysaUQE97ShZSC/36o18QRE/EFrRshZlL+B43AEU6EN6hHtb
	VcT7mFvqJ+FK8gvoUQp0Bx1Zkaf078EpSSHxQ+GNmdK4S7RanyiwGOY2UQvHgBzIiH98FnCtXL2
	xQn3ErRuwF5DpBum4qn/j12nhtre04pdAu6kIoM/wI9wKFWxKatOcJMDCrCRg9VnHm8U+8a
X-Received: by 2002:a05:6870:80d1:b0:456:b261:abe4 with SMTP id
 586e51a60fabf-457a117db5bmr4871554fac.37.1784907095099; Fri, 24 Jul 2026
 08:31:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723031102.2718093-1-tweek@google.com>
In-Reply-To: <20260723031102.2718093-1-tweek@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 24 Jul 2026 11:31:23 -0400
X-Gm-Features: AUfX_mxlA4O_c4C8IWs8ZrbBdG8I3jmgCz-qt0g45VeHIJnHKQFzrCoJeh8aAMo
Message-ID: <CAEjxPJ6pr8RUQtNwTLBL6xDkGFRqgea=a-41T3Mf3GwUYQee4w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] libselinux: support multiple spec_files
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: selinux@vger.kernel.org, James Carter <jwcart2@gmail.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 11:11=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goog=
le.com> wrote:
>
> Update the existing backends to potentially allocate multiple
> spec_files. This commit simply adds a level of indirection but does not
> change any current behaviour. It will facilitate the gradual migration
> of backends to multiple context files.
>
> In selabel_fini(), compat_validate() is updated to use the first
> spec_file only, for legacy validation error reporting. selabel_open() is
> already performing context validation if requested against individual
> file paths (see insert_spec).
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>

Only for the first patch:
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> Changes since v1:
> - Use sizeof(*rec->spec_files) instead of sizeof(path) as suggested by
>   Stephen.
>
>  libselinux/src/label.c          | 10 ++++++++--
>  libselinux/src/label_db.c       | 11 +++++++++--
>  libselinux/src/label_file.c     |  8 ++++++--
>  libselinux/src/label_internal.h |  5 +++--
>  libselinux/src/label_media.c    |  8 +++++++-
>  libselinux/src/label_x.c        |  8 +++++++-
>  6 files changed, 40 insertions(+), 10 deletions(-)
>
> diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> index 991b9769..4a97d3bc 100644
> --- a/libselinux/src/label.c
> +++ b/libselinux/src/label.c
> @@ -162,7 +162,7 @@ static int selabel_fini(const struct selabel_handle *=
rec,
>         char *ctx_trans;
>         int rc;
>
> -       if (compat_validate(rec, lr, rec->spec_file, lr->lineno))
> +       if (compat_validate(rec, lr, rec->spec_files[0], lr->lineno))
>                 return -1;
>
>         if (!translating)
> @@ -398,11 +398,17 @@ int selabel_digest(struct selabel_handle *rec, unsi=
gned char **digest,
>
>  void selabel_close(struct selabel_handle *rec)
>  {
> +       size_t i;
> +
>         if (rec->digest)
>                 selabel_digest_fini(rec->digest);
>         if (rec->func_close)
>                 rec->func_close(rec);
> -       free(rec->spec_file);
> +       if (rec->spec_files) {
> +               for (i =3D 0; i < rec->spec_files_len; i++)
> +                       free(rec->spec_files[i]);
> +               free(rec->spec_files);
> +       }
>         free(rec);
>  }
>
> diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
> index bafa9328..53731470 100644
> --- a/libselinux/src/label_db.c
> +++ b/libselinux/src/label_db.c
> @@ -302,12 +302,19 @@ static catalog_t *db_init(const struct selinux_opt =
*opts, unsigned nopts,
>                 errno =3D EINVAL;
>                 return NULL;
>         }
> -       rec->spec_file =3D strdup(path);
> -       if (!rec->spec_file) {
> +       rec->spec_files =3D calloc(1, sizeof(*rec->spec_files));
> +       if (!rec->spec_files) {
>                 free(catalog);
>                 fclose(filp);
>                 return NULL;
>         }
> +       rec->spec_files[0] =3D strdup(path);
> +       if (!rec->spec_files[0]) {
> +               free(catalog);
> +               fclose(filp);
> +               return NULL;
> +       }
> +       rec->spec_files_len =3D 1;
>
>         /*
>          * Parse for each lines
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 0c0499eb..d91e1462 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -1549,9 +1549,13 @@ static int init(struct selabel_handle *rec, const =
struct selinux_opt *opts,
>                 goto finish;
>         }
>
> -       rec->spec_file =3D strdup(path);
> -       if (!rec->spec_file)
> +       rec->spec_files =3D calloc(1, sizeof(*rec->spec_files));
> +       if (!rec->spec_files)
>                 goto finish;
> +       rec->spec_files[0] =3D strdup(path);
> +       if (!rec->spec_files[0])
> +               goto finish;
> +       rec->spec_files_len =3D 1;
>
>         /*
>          * The do detailed validation of the input and fill the spec arra=
y
> diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_inter=
nal.h
> index 4ff39d96..d54053df 100644
> --- a/libselinux/src/label_internal.h
> +++ b/libselinux/src/label_internal.h
> @@ -96,10 +96,11 @@ struct selabel_handle {
>         void *data;
>
>         /*
> -        * The main spec file used. Note for file contexts the local and/=
or
> +        * The spec files used. Note for file contexts the local and/or
>          * homedirs could also have been used to resolve a context.
>          */
> -       char *spec_file;
> +       size_t spec_files_len;
> +       char **spec_files;
>
>         /* ptr to SHA1 hash information if SELABEL_OPT_DIGEST set */
>         struct selabel_digest *digest;
> diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
> index 957fcfd3..f315abc3 100644
> --- a/libselinux/src/label_media.c
> +++ b/libselinux/src/label_media.c
> @@ -109,7 +109,13 @@ static int init(struct selabel_handle *rec, const st=
ruct selinux_opt *opts,
>                 errno =3D EINVAL;
>                 goto finish;
>         }
> -       rec->spec_file =3D strdup(path);
> +       rec->spec_files =3D calloc(1, sizeof(*rec->spec_files));
> +       if (!rec->spec_files)
> +               goto finish;
> +       rec->spec_files[0] =3D strdup(path);
> +       if (!rec->spec_files[0])
> +               goto finish;
> +       rec->spec_files_len =3D 1;
>
>         /*
>          * Perform two passes over the specification file.
> diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
> index 0c525bfc..b528a019 100644
> --- a/libselinux/src/label_x.c
> +++ b/libselinux/src/label_x.c
> @@ -139,7 +139,13 @@ static int init(struct selabel_handle *rec, const st=
ruct selinux_opt *opts,
>                 errno =3D EINVAL;
>                 goto finish;
>         }
> -       rec->spec_file =3D strdup(path);
> +       rec->spec_files =3D calloc(1, sizeof(*rec->spec_files));
> +       if (!rec->spec_files)
> +               goto finish;
> +       rec->spec_files[0] =3D strdup(path);
> +       if (!rec->spec_files[0])
> +               goto finish;
> +       rec->spec_files_len =3D 1;
>
>         /*
>          * Perform two passes over the specification file.
> --
> 2.55.0.229.g6434b31f56-goog
>
