Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DFF47124B
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 16:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784822831; cv=pass; b=DlKFRPJZKjAYFYN25ND6VO98tVeJ6jy5JkJhtSC/POfbGoDK1qN5ZJNo9ry5Y5kkYhJ4kTad2U4ajTX2ubBVVNNInls+EpIjrYtksfGhB+8/dx6LLLFhwIXKbRs4AoHmZVCmJhoQPAj6xr9LS8YVgFd0qrSiBAYDswGVV4Wx7gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784822831; c=relaxed/simple;
	bh=d6HS2eAH47XEC3BGpz32i57etEUDsdH51rruAE1rsZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cR1i1gbREfxW25+7RCd6LCbXedrrb+h74RitPWXVu2+Gl3x3OGLwrbLXiUEC72ZoPUDuXFx4PPV5b810Em361K8f6V2Hv08kB+H894Hk4rDEgwrY6gC1zmnb5i4GJVDxDmxkI8gC3vLZUZtQlMC1j0v0mgjDEyLSz+s3pzVNehA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKejEodw; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKejEodw"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84e3007a2b7so683829b3a.0
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 09:07:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784822826; cv=none;
        d=google.com; s=arc-20260327;
        b=dFEgypE/f/1F7jIe1RlUe6DTPfSIOhI91509VPsJeE3gIWlNc5XDHUC94c9SIIccnz
         c5+4cFyAe7fbQQLOksZhW31NhE5MlWOf/ZW5vVLK2taMvr2roinf+HDxKajZWRIzj7ZK
         93nF0+9j29c275D6+sa0htMs+Mwdr+Ecyp6iVYMksJYdKmqbn50LOTqqV1RsGQ//AkMj
         P2U3lkii9vdHBuqBd0X3n70+240xfsn0NWcWAFIz5/d6iEzGzmYO933+0f5upY0jVn4j
         oEZWwopmo97auqysGflzjlb9/j3A/gNNU9v6QsyPhwr4HHoBRW7A7ZTZk5GFtnuo2tTx
         047w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NmC1xEMYIWM4ikprDNl5lMcqgI6hE0skZBxq19J2RVU=;
        fh=mMDxYY5wtlIekXoYIfjt6lvMWgTaMUwdwgsYDQ6qy3A=;
        b=Zzy1bb5BnTZiHP9NUxDV/6EahKUOky82j5Oxjw2xrvvO/J8JUno0f839mbyBFB6YH/
         X88m/9gWVJqUHkNOS01FiuUwiy1UE5+S/zey4OgFsbTUkAwzBWcDOqn6DOs1f4lJmJpF
         z/BJpmY5RpIlXZCUyr1JRKRryUPGg14w+EEwja+XBwzJedtdwHBv2ad2Z3GHDxScy54B
         R8Am+2ku1yr+FhrnIl469fND0j3IP1vodX/hN4IF9tBhFyB4lEhWeTzSuyAwF9CXskA3
         +Sta0eOjdYfVG69talYj9v5Sq9R9Pu8zGmeY5I+OKVaNbZaanjaguPouNNoGVeMgNRNX
         hh0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784822826; x=1785427626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NmC1xEMYIWM4ikprDNl5lMcqgI6hE0skZBxq19J2RVU=;
        b=JKejEodwUlrJ12ZzU00+5XxeQwO0Xz9p0bf8UmBJSGFHXOzDzIIkbO1Pexki7TqK8K
         qkk6KONRmL+4r9i/7RspcwfYbUjHzCbcNzZZnPA/NFo2JNiuj11dFofNGr4ppIyOlXj3
         sz5xw8r+wtezw9XB+50jQD4+UHOL5o0lPeb4eMx47nN2ZfeQab2G7dZcCg2NzvsH0czL
         PSm5QQ5Y8RkxihW34cyWbfqobbACnpRj9j61/7OszrcjGRbZiNxuGAjwvaOkyb8QlR3O
         f2OOhiv8L/XgPuglaCLhpr2VQLfy2/LO9QM8RykF/H/D1e76nXd6GAjgdT+DTs/+J9gy
         FTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784822826; x=1785427626;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NmC1xEMYIWM4ikprDNl5lMcqgI6hE0skZBxq19J2RVU=;
        b=es1u8dhgFGrhBEcLi7WFgdTqZWV8DfvXmkU6fV+yXQGsxMOGv+ZTItruzYgo2eYJXx
         GpTgP2xQZEZHyZKWOOnJcFBLwDCbkXUyz7Pdh/5VBYLwd+7WsLtQtMB0/ukeF2xIcRmI
         CdruNEubRAtJ5jYJtHTFoN9dOwyIqIxPG4xAl82otfDmcB00aHNmQSGRzYPeEam/fcMm
         vaB7af0vdE3jrzGdaL6WuRC8d/8aEmaaOSgwD9d+UZnzDVdjZYWWLyJkXRaULadaO1eT
         el4CzQ90AJhfN2E/KLgzG6lHyXefU5jPGA3YyVVoAkOZw+Ru8lOvmYBACrJiVrA2SoH6
         zXNw==
X-Gm-Message-State: AOJu0YzE3qIpUxa9II0owsx3EJldDqJSbSZmvXEvnyFNbgAUSoQR8Mxt
	vcA/bU/GMdqwymwQfPfdfDNWYfwjgnUabBTLcdQRVNb/iYdR+kTtW6UT3cWz+s5GXhz6/KKnyYf
	EFGtxYDyWEVEMphZuVSANKcRgl+6Njcw=
X-Gm-Gg: AR+sD11XCMYIxTKLqNM4LGe+0MvsGUvy43TrUictHW2F4tF6/iTAwAvjVZwLUEUwvnR
	rr6KPDpR40O4FTsWvfYa3nWfl3/euGRQekjPpsF96U42FV0loEC/ab0qD8SbdDbacWMX3b/LZIt
	zC1kEUIOVk/gF+/CoJ+odHc6Ocuor+BPYbJ1Mn/eNJMOjUzrevXiP4xQetEX3fSI1yzNn/3jXp1
	QLlxyzvFJqpSHaRPKPEjZkzfkTDxn4cQGD+kIrwd8X+515S6KHe9zaYpVJyfg==
X-Received: by 2002:a05:6a00:1913:b0:847:8b1d:230d with SMTP id
 d2e1a72fcca58-84e2b7e5dcfmr4422457b3a.3.1784822826270; Thu, 23 Jul 2026
 09:07:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723031102.2718093-1-tweek@google.com> <20260723031102.2718093-2-tweek@google.com>
In-Reply-To: <20260723031102.2718093-2-tweek@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 23 Jul 2026 12:06:54 -0400
X-Gm-Features: AUfX_mxXJVMuuwPBhgoY4zJ5usEiLYDuRDUOoj9EfxAX1XfzkX_hE3Lh8JWf2sw
Message-ID: <CAEjxPJ6qSMAHv9=KfM=-AybsWWoE3E+jG7JTgfuFjSgJ3hLgcA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] libselinux: support multiple context files for the
 file backend
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: selinux@vger.kernel.org, James Carter <jwcart2@gmail.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 11:11=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goog=
le.com> wrote:
>
> Update the file labeling backend to support specifying multiple
> SELABEL_OPT_PATH options in selabel_open().
>
> All provided paths are stored in rec->spec_files and processed during
> initialization. Derived files, such as substitutions (.subs, .subs_dist)
> and auxiliary contexts (.homedirs, .local), continue to be based on the
> first path (or default selinux_file_context_path()) when enabled.
>
> Duplicate checking is only performed within each context file. The curren=
t
> behavior expects the ability for a later file to overwrite a previous
> declaration (e.g., .local).
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> ---
> Changes since v1:
> - Restore nodups_spec_node, ignore duplicates across files.
> - Change num_paths type to uint8_t and check for overflow.
> - Check for NULL before strdup any path.
> - Use num_paths and num_paths+1 for homedirs and local.
>
>  libselinux/src/label_file.c | 139 ++++++++++++++++++++++++------------
>  1 file changed, 92 insertions(+), 47 deletions(-)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index d91e1462..02bd6f5d 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c-
> @@ -1484,22 +1491,30 @@ static int init(struct selabel_handle *rec, const=
 struct selinux_opt *opts,
>                 unsigned n)
>  {
>         struct saved_data *data =3D rec->data;
> -       const char *path =3D NULL;
> +       uint8_t num_paths =3D 0, i;
> +       char **paths =3D NULL;
>         const char *prefix =3D NULL;
> -       int status =3D -1, baseonly =3D 0;
> +       int status =3D -1;
> +       bool baseonly =3D false, path_provided =3D false;
>
>         /* Process arguments */
> -       while (n) {
> -               n--;
> -               switch (opts[n].type) {
> +       for (i =3D 0; i < n; i++) {

uint8_t i versus unsigned n; if n >=3D 256, i will wrap and we'll loop fore=
ver.
Unlikely I know but should either use unsigned for i or cap n up front.

> +               switch (opts[i].type) {
>                 case SELABEL_OPT_PATH:
> -                       path =3D opts[n].value;
> +                       if (opts[i].value) {
> +                               num_paths++;
> +                               if (num_paths =3D=3D UINT8_MAX) {
> +                                       errno =3D EINVAL;
> +                                       return -1;
> +                               }
> +                               path_provided =3D true;
> +                       }
>                         break;
>                 case SELABEL_OPT_SUBSET:
> -                       prefix =3D opts[n].value;
> +                       prefix =3D opts[i].value;
>                         break;
>                 case SELABEL_OPT_BASEONLY:
> -                       baseonly =3D !!opts[n].value;
> +                       baseonly =3D !!opts[i].value;
>                         break;
>                 case SELABEL_OPT_UNUSED:
>                 case SELABEL_OPT_VALIDATE:
> @@ -1511,10 +1526,50 @@ static int init(struct selabel_handle *rec, const=
 struct selinux_opt *opts,
>                 }
>         }
>
> +       /* If no paths were provided, we will use the default path or fai=
l,
> +        * depending on the target. */
> +       if (!path_provided) {
> +#if !defined(BUILD_HOST) && !defined(ANDROID)
> +               num_paths =3D 1;
> +#else
> +               selinux_log(SELINUX_ERROR,
> +                           "No path given to file labeling backend\n");
> +               errno =3D EINVAL;
> +               return -1;
> +#endif
> +       }
> +
> +       /* If !baseonly, we reserve the last 2 indexes for homedirs and l=
ocal.
> +        * Let's make sure we don't wrap */
> +       if (!baseonly && num_paths > UINT8_MAX - 1) {
> +               errno =3D EINVAL;
> +               return -1;
> +       }
> +
> +       /* Allocate the paths. */
> +       paths =3D calloc(num_paths, sizeof(*paths));
> +       if (paths =3D=3D NULL)
> +               goto finish;
> +
> +       rec->spec_files =3D paths;
> +       rec->spec_files_len =3D num_paths;
> +
> +       /* Copy all the paths given. */
> +       if (path_provided) {
> +               for (i =3D 0; i < n; i++) {
> +                       if (opts[i].type =3D=3D SELABEL_OPT_PATH && opts[=
i].value) {
> +                               *paths =3D strdup(opts[i].value);
> +                               if (*paths =3D=3D NULL)
> +                                       goto finish;
> +                               paths++;
> +                       }
> +               }
> +       }
> +
>  #if !defined(BUILD_HOST) && !defined(ANDROID)
>         char subs_file[PATH_MAX + 1];
>         /* Process local and distribution substitution files */
> -       if (!path) {
> +       if (!path_provided) {
>                 status =3D selabel_subs_init(
>                         selinux_file_context_subs_dist_path(), rec->diges=
t,
>                         &data->dist_subs, &data->dist_subs_num,
> @@ -1526,66 +1581,56 @@ static int init(struct selabel_handle *rec, const=
 struct selinux_opt *opts,
>                                            &data->subs_num, &data->subs_a=
lloc);
>                 if (status)
>                         goto finish;
> -               path =3D selinux_file_context_path();
> +               rec->spec_files[0] =3D strdup(selinux_file_context_path()=
);
> +               if (rec->spec_files[0] =3D=3D NULL)
> +                       goto finish;
>         } else {
> -               snprintf(subs_file, sizeof(subs_file), "%s.subs_dist", pa=
th);
> +               snprintf(subs_file, sizeof(subs_file), "%s.subs_dist",
> +                        rec->spec_files[0]);
>                 status =3D selabel_subs_init(subs_file, rec->digest,
>                                            &data->dist_subs,
>                                            &data->dist_subs_num,
>                                            &data->dist_subs_alloc);
>                 if (status)
>                         goto finish;
> -               snprintf(subs_file, sizeof(subs_file), "%s.subs", path);
> +               snprintf(subs_file, sizeof(subs_file), "%s.subs",
> +                        rec->spec_files[0]);
>                 status =3D selabel_subs_init(subs_file, rec->digest, &dat=
a->subs,
>                                            &data->subs_num, &data->subs_a=
lloc);
>                 if (status)
>                         goto finish;
>         }
> -
>  #endif
>
> -       if (!path) {
> -               errno =3D EINVAL;
> -               goto finish;
> -       }
> -
> -       rec->spec_files =3D calloc(1, sizeof(*rec->spec_files));
> -       if (!rec->spec_files)
> -               goto finish;
> -       rec->spec_files[0] =3D strdup(path);
> -       if (!rec->spec_files[0])
> -               goto finish;
> -       rec->spec_files_len =3D 1;
> -
>         /*
> -        * The do detailed validation of the input and fill the spec arra=
y
> +        * Process each input file.
>          */
> -       status =3D process_file(path, NULL, rec, prefix, rec->digest, 0);
> -       if (status)
> -               goto finish;
> -
> -       if (rec->validating) {
> -               sort_specs(data);
> -
> -               status =3D nodups_spec_node(data->root, path);
> +       for (i =3D 0; i < num_paths; i++) {
> +               status =3D process_file(rec->spec_files[i], NULL, rec, pr=
efix,
> +                                     rec->digest, i);
>                 if (status)
>                         goto finish;
>         }
>
>         if (!baseonly) {
> -               status =3D process_file(path, "homedirs", rec, prefix,
> -                                     rec->digest, 1);
> +               status =3D process_file(rec->spec_files[0], "homedirs", r=
ec,
> +                                     prefix, rec->digest, num_paths);
>                 if (status && errno !=3D ENOENT)
>                         goto finish;
>
> -               status =3D process_file(path, "local", rec, prefix, rec->=
digest,
> -                                     2);
> +               status =3D process_file(rec->spec_files[0], "local", rec,=
 prefix,
> +                                     rec->digest, num_paths + 1);
>                 if (status && errno !=3D ENOENT)
>                         goto finish;
>         }
>
> -       if (!rec->validating || !baseonly)
> -               sort_specs(data);
> +       sort_specs(data);
> +
> +       if (rec->validating) {
> +               status =3D nodups_spec_node(rec, data->root);
> +               if (status)
> +                       goto finish;
> +       }
>
>         digest_gen_hash(rec->digest);
>
> --
> 2.55.0.229.g6434b31f56-goog
>
