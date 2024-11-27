Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AC31E1041
	for <selinux@vger.kernel.org>; Wed, 27 Nov 2024 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732720492; cv=none; b=gK/UI5o98j+lyv3eHQF5sJHIiL6q4SHk3LOcOsrbegFvwSc8LKLnk36uAHTPSADx9f/ZhhLOzWYrn9eDYbkN5CM3Up1MTmt8QOwniVo1X3C2ST9cGOOBcM2Hbuzdh2/Uh2vdjcTXkzs4rrPLFKequsC2hVahbTkzSC7Wjf+0a8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732720492; c=relaxed/simple;
	bh=MFVPpCGAvlQ9Fae4bwWx6Bhph/0J1YPG+UT1ZUhPv8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tni53cMY4Y89cAayqhA2JLeU88zAQavkv8aWpxOZAd7L+syWRxLd6Tkpy1cP42Wwf9lTKLeroQGB7zmhdHcLWlf4tHQRfWnAt6AnT2ZqdBlCm5D0PSZUdl55Y4HvJlJbz1uxLryyTPc8MZZnu/2GNnPx9JXLUt4AuT1M3dZ0Xgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPIyeEmg; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPIyeEmg"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3ea3bf79a03so1606609b6e.2
        for <selinux@vger.kernel.org>; Wed, 27 Nov 2024 07:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732720490; x=1733325290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFKwhpBPSpWL7xTI840I+Tf7sw6JL+kuAaMQ8kd4nBs=;
        b=JPIyeEmg3kRlDRtTcol4tIaAQx1RpXE7q5upA1nAyNr+AJE/viq6p3S7LX4xj3aosM
         ns1+6zBoZLMHA+0kyZE/mEGBDHM72cwuLY+OhkHlv7tY0mYSN11vkZ1fz5Ta17DGcNoq
         NOTeIpAYU7i90sgGXlfaJ6mZSNdgvbwggkFXDAqYdHIjYIldh2VxB3zOwnb3LTYUrkjV
         7HIiPY2arxkzGh2HhJcafWNBgPSEFv5lwHuubw9CeXVJTkeomitS+4RJClNA6/+Tg+jn
         n9byqvGQvx+D9JVn7qjD6tZVybI1CVPhWl7LYQxPNSkn381LSrfK4/puF9L+VgXGxn2l
         egMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732720490; x=1733325290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFKwhpBPSpWL7xTI840I+Tf7sw6JL+kuAaMQ8kd4nBs=;
        b=sjKxC1jKNl83OVCyqW2TNK/g3yV+UIb9mUmOstpLOhsT0RWm87Eyjfk6Gccj1DyIXu
         EXE14ZJztGZbpB5MCAGxWc+1LGVHsmlz7Txe+V6XIP5OlZIsawBTsaOThJyX8tL24QVu
         ciFAiFv6QkKXPHcRIMb/mt0gs43/gfX76ZWvKzj6fpeMk4nSIOmWzeQwKOIml1GSrKhz
         14XHhdmz/dsNnB+DY8oC2RvX2IeDa0B7L51nZga62Bw/KZC0FTXStisRwk65mC+3BVbV
         teoNggbLQyXphLR0UxZs18n1qJQTyHT6XXm915NRUuuiGGHxPtdyqnI71KTRNlJq+iJP
         pzbg==
X-Gm-Message-State: AOJu0Yx0AIttWO4KF6PA6/9lt0EaPvji98XpMEj+8GLPDDCzN1kgvb8n
	hXRLyV0lbpSdionWZkJ3xl9ek7WFDUvNFQvVrB5iNTC+LdrByFDnUIxWylVr79k3C2dP3W5qz6D
	fysCr5f8uEWPb0YL7z6kzja8lEG8=
X-Gm-Gg: ASbGnctOAaXIeFbGtzc6LeiiTZPZwkVGrAOvKLrzfdS/peb/h4OGVOuiLYYdffbT3Em
	Ijo/Mauuvjt8nBaKNtLHjIGiitkIHZ/4=
X-Google-Smtp-Source: AGHT+IG/vIfLbxce3tpJH1ebloMFW9jqEM3/mh0u3YSbN1scM5oD8YTUrFVgX6wTsm5Y0xsQlKQnlCeCkgPBMjIDJA4=
X-Received: by 2002:a05:6358:d39a:b0:1ca:9bcb:6fd6 with SMTP id
 e5c5f4694b2df-1cab1585c4emr238331555d.4.1732720489939; Wed, 27 Nov 2024
 07:14:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125120827.97332-1-cgoettsche@seltendoof.de> <20241125120827.97332-2-cgoettsche@seltendoof.de>
In-Reply-To: <20241125120827.97332-2-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 27 Nov 2024 10:14:39 -0500
Message-ID: <CAP+JOzR8M2oe1mZiixO-6Pt0gW8E6qrGtv5fkyhk==NkfrcU5Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] libselinux: use vector instead of linked list for substitutions
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 5:45=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Utilize cache locality for the substitutions by storing them in
> contiguous memory instead of a linked list.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v2: drop unnecessary check for zero length
> ---
>  libselinux/src/label_file.c | 127 +++++++++++++++++++-----------------
>  libselinux/src/label_file.h |  20 ++++--
>  2 files changed, 80 insertions(+), 67 deletions(-)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 4e212aa4..c91a91f7 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -1120,28 +1120,27 @@ static int process_file(const char *path, const c=
har *suffix,
>         return -1;
>  }
>
> -static void selabel_subs_fini(struct selabel_sub *ptr)
> +static void selabel_subs_fini(struct selabel_sub *subs, uint32_t num)
>  {
> -       struct selabel_sub *next;
> -
> -       while (ptr) {
> -               next =3D ptr->next;
> -               free(ptr->src);
> -               free(ptr->dst);
> -               free(ptr);
> -               ptr =3D next;
> +       for (uint32_t i =3D 0; i < num; i++) {
> +               free(subs[i].src);
> +               free(subs[i].dst);
>         }
> +
> +       free(subs);
>  }
>
> -static char *selabel_sub(const struct selabel_sub *ptr, const char *src)
> +static char *selabel_apply_subs(const struct selabel_sub *subs, uint32_t=
 num, const char *src)
>  {
> -       char *dst =3D NULL;
> -       unsigned int len;
> +       char *dst;
> +       uint32_t len;
> +
> +       for (uint32_t i =3D 0; i < num; i++) {
> +               const struct selabel_sub *ptr =3D &subs[i];
>
> -       while (ptr) {
>                 if (strncmp(src, ptr->src, ptr->slen) =3D=3D 0 ) {
>                         if (src[ptr->slen] =3D=3D '/' ||
> -                           src[ptr->slen] =3D=3D 0) {
> +                           src[ptr->slen] =3D=3D '\0') {
>                                 if ((src[ptr->slen] =3D=3D '/') &&
>                                     (strcmp(ptr->dst, "/") =3D=3D 0))
>                                         len =3D ptr->slen + 1;
> @@ -1152,34 +1151,38 @@ static char *selabel_sub(const struct selabel_sub=
 *ptr, const char *src)
>                                 return dst;
>                         }
>                 }
> -               ptr =3D ptr->next;
>         }
> +
>         return NULL;
>  }
>
>  #if !defined(BUILD_HOST) && !defined(ANDROID)
>  static int selabel_subs_init(const char *path, struct selabel_digest *di=
gest,
> -                            struct selabel_sub **out_subs)
> +                            struct selabel_sub **out_subs,
> +                            uint32_t *out_num, uint32_t *out_alloc)
>  {
>         char buf[1024];
> -       FILE *cfg =3D fopen(path, "re");
> -       struct selabel_sub *list =3D NULL, *sub =3D NULL;
> +       FILE *cfg;
>         struct stat sb;
> -       int status =3D -1;
> +       struct selabel_sub *tmp =3D NULL;
> +       uint32_t tmp_num =3D 0, tmp_alloc =3D 0;

Sorry for replying to v2, but I never received v3 (I can download it
with b4). It doesn't matter for my comment.

tmp_alloc is never updated.

> +       char *src_cpy =3D NULL, *dst_cpy =3D NULL;
> +       int rc;
>
>         *out_subs =3D NULL;
> +       *out_num =3D 0;
> +       *out_alloc =3D 0;

Near the end of this function, we have *out_alloc =3D tmp_alloc, but
since tmp_alloc is never updated, this is always going to be 0 (unless
I missed something).

Thanks,
Jim


> +
> +       cfg =3D fopen(path, "re");
>         if (!cfg) {
>                 /* If the file does not exist, it is not fatal */
>                 return (errno =3D=3D ENOENT) ? 0 : -1;
>         }
>
> -       if (fstat(fileno(cfg), &sb) < 0)
> -               goto out;
> -
>         while (fgets_unlocked(buf, sizeof(buf) - 1, cfg)) {
> -               char *ptr =3D NULL;
> +               char *ptr;
>                 char *src =3D buf;
> -               char *dst =3D NULL;
> +               char *dst;
>                 size_t len;
>
>                 while (*src && isspace((unsigned char)*src))
> @@ -1207,62 +1210,64 @@ static int selabel_subs_init(const char *path, st=
ruct selabel_digest *digest,
>                         goto err;
>                 }
>
> -               sub =3D calloc(1, sizeof(*sub));
> -               if (! sub)
> +               src_cpy =3D strdup(src);
> +               if (!src_cpy)
>                         goto err;
>
> -               sub->src =3D strdup(src);
> -               if (! sub->src)
> +               dst_cpy =3D strdup(dst);
> +               if (!dst_cpy)
>                         goto err;
>
> -               sub->dst =3D strdup(dst);
> -               if (! sub->dst)
> +               rc =3D GROW_ARRAY(tmp);
> +               if (rc)
>                         goto err;
>
> -               sub->slen =3D len;
> -               sub->next =3D list;
> -               list =3D sub;
> -               sub =3D NULL;
> +               tmp[tmp_num++] =3D (struct selabel_sub) {
> +                       .src =3D src_cpy,
> +                       .slen =3D len,
> +                       .dst =3D dst_cpy,
> +               };
> +               src_cpy =3D NULL;
> +               dst_cpy =3D NULL;
>         }
>
> +       rc =3D fstat(fileno(cfg), &sb);
> +       if (rc < 0)
> +               goto err;
> +
>         if (digest_add_specfile(digest, cfg, NULL, sb.st_size, path) < 0)
>                 goto err;
>
> -       *out_subs =3D list;
> -       status =3D 0;
> +       *out_subs =3D tmp;
> +       *out_num =3D tmp_num;
> +       *out_alloc =3D tmp_alloc;
>
> -out:
>         fclose(cfg);
> -       return status;
> +
> +       return 0;
> +
>  err:
> -       if (sub)
> -               free(sub->src);
> -       free(sub);
> -       while (list) {
> -               sub =3D list->next;
> -               free(list->src);
> -               free(list->dst);
> -               free(list);
> -               list =3D sub;
> -       }
> -       goto out;
> +       free(dst_cpy);
> +       free(src_cpy);
> +       free(tmp);
> +       fclose_errno_safe(cfg);
> +       return -1;
>  }
>  #endif
>
>  static char *selabel_sub_key(const struct saved_data *data, const char *=
key)
>  {
> -       char *ptr =3D NULL;
> -       char *dptr =3D NULL;
> +       char *ptr, *dptr;
>
> -       ptr =3D selabel_sub(data->subs, key);
> +       ptr =3D selabel_apply_subs(data->subs, data->subs_num, key);
>         if (ptr) {
> -               dptr =3D selabel_sub(data->dist_subs, ptr);
> +               dptr =3D selabel_apply_subs(data->dist_subs, data->dist_s=
ubs_num, ptr);
>                 if (dptr) {
>                         free(ptr);
>                         ptr =3D dptr;
>                 }
>         } else {
> -               ptr =3D selabel_sub(data->dist_subs, key);
> +               ptr =3D selabel_apply_subs(data->dist_subs, data->dist_su=
bs_num, key);
>         }
>
>         return ptr;
> @@ -1307,23 +1312,25 @@ static int init(struct selabel_handle *rec, const=
 struct selinux_opt *opts,
>         if (!path) {
>                 status =3D selabel_subs_init(
>                         selinux_file_context_subs_dist_path(),
> -                       rec->digest, &data->dist_subs);
> +                       rec->digest,
> +                       &data->dist_subs, &data->dist_subs_num, &data->di=
st_subs_alloc);
>                 if (status)
>                         goto finish;
>                 status =3D selabel_subs_init(selinux_file_context_subs_pa=
th(),
> -                       rec->digest, &data->subs);
> +                       rec->digest,
> +                       &data->subs, &data->subs_num, &data->subs_alloc);
>                 if (status)
>                         goto finish;
>                 path =3D selinux_file_context_path();
>         } else {
>                 snprintf(subs_file, sizeof(subs_file), "%s.subs_dist", pa=
th);
>                 status =3D selabel_subs_init(subs_file, rec->digest,
> -                                          &data->dist_subs);
> +                                          &data->dist_subs, &data->dist_=
subs_num, &data->dist_subs_alloc);
>                 if (status)
>                         goto finish;
>                 snprintf(subs_file, sizeof(subs_file), "%s.subs", path);
>                 status =3D selabel_subs_init(subs_file, rec->digest,
> -                                          &data->subs);
> +                                          &data->subs, &data->subs_num, =
&data->subs_alloc);
>                 if (status)
>                         goto finish;
>         }
> @@ -1391,8 +1398,8 @@ static void closef(struct selabel_handle *rec)
>         if (!data)
>                 return;
>
> -       selabel_subs_fini(data->subs);
> -       selabel_subs_fini(data->dist_subs);
> +       selabel_subs_fini(data->subs, data->subs_num);
> +       selabel_subs_fini(data->dist_subs, data->dist_subs_num);
>
>         free_spec_node(data->root);
>         free(data->root);
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index de8190f9..436982bf 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -67,11 +67,11 @@ extern struct lookup_result *lookup_all(struct selabe=
l_handle *rec, const char *
>  extern enum selabel_cmp_result cmp(const struct selabel_handle *h1, cons=
t struct selabel_handle *h2);
>  #endif  /* FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION */
>
> +/* A path substitution entry */
>  struct selabel_sub {
> -       char *src;
> -       unsigned int slen;
> -       char *dst;
> -       struct selabel_sub *next;
> +       char *src;                              /* source path prefix */
> +       char *dst;                              /* substituted path prefi=
x */
> +       uint32_t slen;                          /* length of source path =
prefix */
>  };
>
>  /* A regular expression file security context specification */
> @@ -159,9 +159,17 @@ struct saved_data {
>
>         struct mmap_area *mmap_areas;
>
> -       /* substitution support */
> +       /*
> +        * Array of distribution substitutions
> +        */
>         struct selabel_sub *dist_subs;
> +       uint32_t dist_subs_num, dist_subs_alloc;
> +
> +       /*
> +        * Array of local substitutions
> +        */
>         struct selabel_sub *subs;
> +       uint32_t subs_num, subs_alloc;
>  };
>
>  static inline mode_t string_to_file_kind(const char *mode)
> @@ -811,8 +819,6 @@ static int insert_spec(const struct selabel_handle *r=
ec, struct saved_data *data
>         return 0;
>  }
>
> -#undef GROW_ARRAY
> -
>  static inline void free_spec_node(struct spec_node *node)
>  {
>         for (uint32_t i =3D 0; i < node->literal_specs_num; i++) {
> --
> 2.45.2
>
>
