Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9941433A0
	for <selinux@vger.kernel.org>; Wed, 27 Nov 2024 16:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732723584; cv=none; b=S18AgYuL96vosBf4yIiMogLV3RUt90gsw3NvwIfB4s1BY2O2ESEALCEVPRrEwuhVfpz1bHBWyXuFCc8xBXVt5LnUIqXipetsY4qqZBNbtYjuVhHd6hVd+Xqd9j7w65I7PSuk/7G6MU6/rfsi1zZ3SmYIFUwgeTNuH1MrnFaJsD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732723584; c=relaxed/simple;
	bh=yN1+Q7euXatCRerultiCjUzbr5TRWzrmMqgdeDfw8s8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OhZgrh7ZU/1UzWTLvqt0FHMtpTqkzPYYE/eHede079MhNTSiJ2HA81f5e1kh1WRNRBBxtAQ1XEQgzkCvYvm3OBq5ht1SSWASdKMgbY+GiYjQemST4FzUyXvddTeRa/mxqzgjL9b+dpFE7YOEbknbug9fU/x30Stcb5Xkc81hPwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILkB8CSV; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILkB8CSV"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3ea48624a2aso1890200b6e.2
        for <selinux@vger.kernel.org>; Wed, 27 Nov 2024 08:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732723582; x=1733328382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDw/Z3x5RBBZZ2gQHFW6GU8WbK9dNRQDdvxtFjitC2E=;
        b=ILkB8CSVfeaw8JOf6ai7JmqV2pmwshkoS+7sYomYTaDZtF0tw9N2hR1LjGwk3h/Wmn
         LTQFFQJ3rngyHoGi3XNyXsKRETaTzef7wEd0Z66AAJroi6lftWfv++akytbV3m8pkEnP
         4ZTZ5ckcwk0SM4DtlN/QQAljTgzJj4V9WVFUriDBnuDi+YmNbA5T0ebrC+VD1S5yWQcP
         0feFOBsyelN1TLDMwYJbf+le5eGLvwI5sylMV8qo1eb1SiWpzmAfSA+gvmdqfVIKkVZh
         NZjWU0M6h4ApXVOX3oGl+YqXcU72qbihKKbwnNtqXiiQmi0cBOA6yQgWl9Ad3zjc4FHc
         568Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732723582; x=1733328382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDw/Z3x5RBBZZ2gQHFW6GU8WbK9dNRQDdvxtFjitC2E=;
        b=VkKyStViot40eaWGHbnnG3Nf8EaaW2oxMlnNlrex0WynhUSIsFdIMG7xsiGi0EltVd
         JTQayqufn3IptQ+atp7W2JhW8RbgfOfMv/Gfvp/N78muCzDd7u56D7eCzL43sVPUDdSl
         jQfN547VraTXlby1XkNCA87ILBph4rI6afkVsWQajRc8xaKMU5v6jZV7ZombDNOxGhFX
         lfcCKLrC+OMKUz5NwQ4D1n0dWQliCoF86R3h1/QqdC+jRN7oaEBrdQkxSgJDO6a1icH2
         fSaJ6rc5mgO8vBZOXSVEp8WDNW7YaxV/6bwVSzH7guCRG2RyppYFRI77M/XMeOEv0kPx
         cHXg==
X-Gm-Message-State: AOJu0YxaNW6AMrBfxLPiOTaCxbCl/ZZcBSm5pls7eg1qeALw333nuRpi
	lWmGam57F7g+tNvPAehD5Hzs8yMMLbvHcTI/r3TNpmq0Ti2xscdJzpToxc6kKy/wBy5RQSvRhMQ
	Aal3Y/TiqEVipb3YjHtY/TRsw13jUNw==
X-Gm-Gg: ASbGncs4a5W9avJlVkcu0KOQK1pP5nExqR+NF7OspsHyphHuJaRTQ8WJQ/RGkEeZ+E7
	nkIk512pVQNkszjnH7wy7pXITYeTShHw=
X-Google-Smtp-Source: AGHT+IHPAGatvZUUO5JC6v3z7VBRR38n71ug8tsp9GYNPldSBq0tVbFztqpKJ9zIEOlfN+dxV7inkTswT+fVfNb8srk=
X-Received: by 2002:a05:6358:678c:b0:1c3:813d:47c2 with SMTP id
 e5c5f4694b2df-1cab16941d2mr313851455d.20.1732723580080; Wed, 27 Nov 2024
 08:06:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125120827.97332-1-cgoettsche@seltendoof.de>
 <20241125120827.97332-2-cgoettsche@seltendoof.de> <CAP+JOzR8M2oe1mZiixO-6Pt0gW8E6qrGtv5fkyhk==NkfrcU5Q@mail.gmail.com>
 <52901ead-a61d-4f6f-8c80-da61b05043af@googlemail.com>
In-Reply-To: <52901ead-a61d-4f6f-8c80-da61b05043af@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 27 Nov 2024 11:06:09 -0500
Message-ID: <CAP+JOzQksB6ny3tKmzrtJJLPuGAysL1tCNLtJjYQAADpNL-JUA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] libselinux: use vector instead of linked list for substitutions
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 11:02=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Nov 27, 2024 16:14:50 James Carter <jwcart2@gmail.com>:
>
> > On Tue, Nov 26, 2024 at 5:45=E2=80=AFAM Christian G=C3=B6ttsche
> > <cgoettsche@seltendoof.de> wrote:
> >>
> >> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >>
> >> Utilize cache locality for the substitutions by storing them in
> >> contiguous memory instead of a linked list.
> >>
> >> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >> ---
> >> v2: drop unnecessary check for zero length
> >> ---
> >> libselinux/src/label_file.c | 127 +++++++++++++++++++-----------------
> >> libselinux/src/label_file.h |  20 ++++--
> >> 2 files changed, 80 insertions(+), 67 deletions(-)
> >>
> >> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> >> index 4e212aa4..c91a91f7 100644
> >> --- a/libselinux/src/label_file.c
> >> +++ b/libselinux/src/label_file.c
> >> @@ -1120,28 +1120,27 @@ static int process_file(const char *path, cons=
t char *suffix,
> >>         return -1;
> >> }
> >>
> >> -static void selabel_subs_fini(struct selabel_sub *ptr)
> >> +static void selabel_subs_fini(struct selabel_sub *subs, uint32_t num)
> >> {
> >> -       struct selabel_sub *next;
> >> -
> >> -       while (ptr) {
> >> -               next =3D ptr->next;
> >> -               free(ptr->src);
> >> -               free(ptr->dst);
> >> -               free(ptr);
> >> -               ptr =3D next;
> >> +       for (uint32_t i =3D 0; i < num; i++) {
> >> +               free(subs[i].src);
> >> +               free(subs[i].dst);
> >>         }
> >> +
> >> +       free(subs);
> >> }
> >>
> >> -static char *selabel_sub(const struct selabel_sub *ptr, const char *s=
rc)
> >> +static char *selabel_apply_subs(const struct selabel_sub *subs, uint3=
2_t num, const char *src)
> >> {
> >> -       char *dst =3D NULL;
> >> -       unsigned int len;
> >> +       char *dst;
> >> +       uint32_t len;
> >> +
> >> +       for (uint32_t i =3D 0; i < num; i++) {
> >> +               const struct selabel_sub *ptr =3D &subs[i];
> >>
> >> -       while (ptr) {
> >>                 if (strncmp(src, ptr->src, ptr->slen) =3D=3D 0 ) {
> >>                         if (src[ptr->slen] =3D=3D '/' ||
> >> -                           src[ptr->slen] =3D=3D 0) {
> >> +                           src[ptr->slen] =3D=3D '\0') {
> >>                                 if ((src[ptr->slen] =3D=3D '/') &&
> >>                                     (strcmp(ptr->dst, "/") =3D=3D 0))
> >>                                         len =3D ptr->slen + 1;
> >> @@ -1152,34 +1151,38 @@ static char *selabel_sub(const struct selabel_=
sub *ptr, const char *src)
> >>                                 return dst;
> >>                         }
> >>                 }
> >> -               ptr =3D ptr->next;
> >>         }
> >> +
> >>         return NULL;
> >> }
> >>
> >> #if !defined(BUILD_HOST) && !defined(ANDROID)
> >> static int selabel_subs_init(const char *path, struct selabel_digest *=
digest,
> >> -                            struct selabel_sub **out_subs)
> >> +                            struct selabel_sub **out_subs,
> >> +                            uint32_t *out_num, uint32_t *out_alloc)
> >> {
> >>         char buf[1024];
> >> -       FILE *cfg =3D fopen(path, "re");
> >> -       struct selabel_sub *list =3D NULL, *sub =3D NULL;
> >> +       FILE *cfg;
> >>         struct stat sb;
> >> -       int status =3D -1;
> >> +       struct selabel_sub *tmp =3D NULL;
> >> +       uint32_t tmp_num =3D 0, tmp_alloc =3D 0;
> >
> > Sorry for replying to v2, but I never received v3 (I can download it
> > with b4). It doesn't matter for my comment.
> >
> > tmp_alloc is never updated.
> >
> >> +       char *src_cpy =3D NULL, *dst_cpy =3D NULL;
> >> +       int rc;
> >>
> >>         *out_subs =3D NULL;
> >> +       *out_num =3D 0;
> >> +       *out_alloc =3D 0;
> >
> > Near the end of this function, we have *out_alloc =3D tmp_alloc, but
> > since tmp_alloc is never updated, this is always going to be 0 (unless
> > I missed something).
>
> tmp_alloc is updated in the macro GROW_ARRAY(tmp), which modifies the dat=
a pointer tmp, its size tmp_num, and its capacity tmp_alloc.
>

Ok, I see it now.
Thanks,
Jim

> > Thanks,
> > Jim
> >
> >
> >> +
> >> +       cfg =3D fopen(path, "re");
> >>         if (!cfg) {
> >>                 /* If the file does not exist, it is not fatal */
> >>                 return (errno =3D=3D ENOENT) ? 0 : -1;
> >>         }
> >>
> >> -       if (fstat(fileno(cfg), &sb) < 0)
> >> -               goto out;
> >> -
> >>         while (fgets_unlocked(buf, sizeof(buf) - 1, cfg)) {
> >> -               char *ptr =3D NULL;
> >> +               char *ptr;
> >>                 char *src =3D buf;
> >> -               char *dst =3D NULL;
> >> +               char *dst;
> >>                 size_t len;
> >>
> >>                 while (*src && isspace((unsigned char)*src))
> >> @@ -1207,62 +1210,64 @@ static int selabel_subs_init(const char *path,=
 struct selabel_digest *digest,
> >>                         goto err;
> >>                 }
> >>
> >> -               sub =3D calloc(1, sizeof(*sub));
> >> -               if (! sub)
> >> +               src_cpy =3D strdup(src);
> >> +               if (!src_cpy)
> >>                         goto err;
> >>
> >> -               sub->src =3D strdup(src);
> >> -               if (! sub->src)
> >> +               dst_cpy =3D strdup(dst);
> >> +               if (!dst_cpy)
> >>                         goto err;
> >>
> >> -               sub->dst =3D strdup(dst);
> >> -               if (! sub->dst)
> >> +               rc =3D GROW_ARRAY(tmp);
> >> +               if (rc)
> >>                         goto err;
> >>
> >> -               sub->slen =3D len;
> >> -               sub->next =3D list;
> >> -               list =3D sub;
> >> -               sub =3D NULL;
> >> +               tmp[tmp_num++] =3D (struct selabel_sub) {
> >> +                       .src =3D src_cpy,
> >> +                       .slen =3D len,
> >> +                       .dst =3D dst_cpy,
> >> +               };
> >> +               src_cpy =3D NULL;
> >> +               dst_cpy =3D NULL;
> >>         }
> >>
> >> +       rc =3D fstat(fileno(cfg), &sb);
> >> +       if (rc < 0)
> >> +               goto err;
> >> +
> >>         if (digest_add_specfile(digest, cfg, NULL, sb.st_size, path) <=
 0)
> >>                 goto err;
> >>
> >> -       *out_subs =3D list;
> >> -       status =3D 0;
> >> +       *out_subs =3D tmp;
> >> +       *out_num =3D tmp_num;
> >> +       *out_alloc =3D tmp_alloc;
> >>
> >> -out:
> >>         fclose(cfg);
> >> -       return status;
> >> +
> >> +       return 0;
> >> +
> >> err:
> >> -       if (sub)
> >> -               free(sub->src);
> >> -       free(sub);
> >> -       while (list) {
> >> -               sub =3D list->next;
> >> -               free(list->src);
> >> -               free(list->dst);
> >> -               free(list);
> >> -               list =3D sub;
> >> -       }
> >> -       goto out;
> >> +       free(dst_cpy);
> >> +       free(src_cpy);
> >> +       free(tmp);
> >> +       fclose_errno_safe(cfg);
> >> +       return -1;
> >> }
> >> #endif
> >>
> >> static char *selabel_sub_key(const struct saved_data *data, const char=
 *key)
> >> {
> >> -       char *ptr =3D NULL;
> >> -       char *dptr =3D NULL;
> >> +       char *ptr, *dptr;
> >>
> >> -       ptr =3D selabel_sub(data->subs, key);
> >> +       ptr =3D selabel_apply_subs(data->subs, data->subs_num, key);
> >>         if (ptr) {
> >> -               dptr =3D selabel_sub(data->dist_subs, ptr);
> >> +               dptr =3D selabel_apply_subs(data->dist_subs, data->dis=
t_subs_num, ptr);
> >>                 if (dptr) {
> >>                         free(ptr);
> >>                         ptr =3D dptr;
> >>                 }
> >>         } else {
> >> -               ptr =3D selabel_sub(data->dist_subs, key);
> >> +               ptr =3D selabel_apply_subs(data->dist_subs, data->dist=
_subs_num, key);
> >>         }
> >>
> >>         return ptr;
> >> @@ -1307,23 +1312,25 @@ static int init(struct selabel_handle *rec, co=
nst struct selinux_opt *opts,
> >>         if (!path) {
> >>                 status =3D selabel_subs_init(
> >>                         selinux_file_context_subs_dist_path(),
> >> -                       rec->digest, &data->dist_subs);
> >> +                       rec->digest,
> >> +                       &data->dist_subs, &data->dist_subs_num, &data-=
>dist_subs_alloc);
> >>                 if (status)
> >>                         goto finish;
> >>                 status =3D selabel_subs_init(selinux_file_context_subs=
_path(),
> >> -                       rec->digest, &data->subs);
> >> +                       rec->digest,
> >> +                       &data->subs, &data->subs_num, &data->subs_allo=
c);
> >>                 if (status)
> >>                         goto finish;
> >>                 path =3D selinux_file_context_path();
> >>         } else {
> >>                 snprintf(subs_file, sizeof(subs_file), "%s.subs_dist",=
 path);
> >>                 status =3D selabel_subs_init(subs_file, rec->digest,
> >> -                                          &data->dist_subs);
> >> +                                          &data->dist_subs, &data->di=
st_subs_num, &data->dist_subs_alloc);
> >>                 if (status)
> >>                         goto finish;
> >>                 snprintf(subs_file, sizeof(subs_file), "%s.subs", path=
);
> >>                 status =3D selabel_subs_init(subs_file, rec->digest,
> >> -                                          &data->subs);
> >> +                                          &data->subs, &data->subs_nu=
m, &data->subs_alloc);
> >>                 if (status)
> >>                         goto finish;
> >>         }
> >> @@ -1391,8 +1398,8 @@ static void closef(struct selabel_handle *rec)
> >>         if (!data)
> >>                 return;
> >>
> >> -       selabel_subs_fini(data->subs);
> >> -       selabel_subs_fini(data->dist_subs);
> >> +       selabel_subs_fini(data->subs, data->subs_num);
> >> +       selabel_subs_fini(data->dist_subs, data->dist_subs_num);
> >>
> >>         free_spec_node(data->root);
> >>         free(data->root);
> >> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> >> index de8190f9..436982bf 100644
> >> --- a/libselinux/src/label_file.h
> >> +++ b/libselinux/src/label_file.h
> >> @@ -67,11 +67,11 @@ extern struct lookup_result *lookup_all(struct sel=
abel_handle *rec, const char *
> >> extern enum selabel_cmp_result cmp(const struct selabel_handle *h1, co=
nst struct selabel_handle *h2);
> >> #endif  /* FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION */
> >>
> >> +/* A path substitution entry */
> >> struct selabel_sub {
> >> -       char *src;
> >> -       unsigned int slen;
> >> -       char *dst;
> >> -       struct selabel_sub *next;
> >> +       char *src;                              /* source path prefix =
*/
> >> +       char *dst;                              /* substituted path pr=
efix */
> >> +       uint32_t slen;                          /* length of source pa=
th prefix */
> >> };
> >>
> >> /* A regular expression file security context specification */
> >> @@ -159,9 +159,17 @@ struct saved_data {
> >>
> >>         struct mmap_area *mmap_areas;
> >>
> >> -       /* substitution support */
> >> +       /*
> >> +        * Array of distribution substitutions
> >> +        */
> >>         struct selabel_sub *dist_subs;
> >> +       uint32_t dist_subs_num, dist_subs_alloc;
> >> +
> >> +       /*
> >> +        * Array of local substitutions
> >> +        */
> >>         struct selabel_sub *subs;
> >> +       uint32_t subs_num, subs_alloc;
> >> };
> >>
> >> static inline mode_t string_to_file_kind(const char *mode)
> >> @@ -811,8 +819,6 @@ static int insert_spec(const struct selabel_handle=
 *rec, struct saved_data *data
> >>         return 0;
> >> }
> >>
> >> -#undef GROW_ARRAY
> >> -
> >> static inline void free_spec_node(struct spec_node *node)
> >> {
> >>         for (uint32_t i =3D 0; i < node->literal_specs_num; i++) {
> >> --
> >> 2.45.2
> >>
> >>
>
