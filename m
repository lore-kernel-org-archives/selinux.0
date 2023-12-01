Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EG5MIVP/"
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E429A
	for <selinux@vger.kernel.org>; Fri,  1 Dec 2023 10:22:39 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50bba815f30so3384358e87.2
        for <selinux@vger.kernel.org>; Fri, 01 Dec 2023 10:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701454958; x=1702059758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1kn6C1pzlGhK7EHOdFgPgNmojNxPZea/r4tlCBQg7Y=;
        b=EG5MIVP/e+9CwSpVFNORGRm4frAmx9SrYmxzd+PV4kJ8BzPQjfybCTHql69BBfnvak
         ChNypiESr/l5wqdupb6JzQB9P9WoaS0aalK/sQMWG5NEQ6Rk/tuNARXNRkCRfImtCHfp
         2dgpgqSN9m6Xvjzz46t3kCZi11Bh63lbCo6XiljJZBxmWZ8PCJQom/x2EqzPYTS4bUdj
         4Ju4t5QTE1R/Wtce7CPuN0npqw7wjK/KZ74Hv4Ib15nd/AHcc3U1GNTomk9I/ag79pjC
         uBg8xdFD7QS/+9ZHy5gfSscqU+/RA0t86i/GQpNO62hCqGBTE9vMiTSoZ01c2itCLxza
         uBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701454958; x=1702059758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B1kn6C1pzlGhK7EHOdFgPgNmojNxPZea/r4tlCBQg7Y=;
        b=vM6S6V9zCUmGDwDl2Bl6UBCvuddjcjQ3AiEIByIPoqwj1g20T3m8CEBvCM9w/XsvuN
         numRzLfMf6/EoAn81Z+Lh5CpOd3wjPvY53yQWZch7XcmZK8/n7TW9bVFBjsMvIq9wIam
         ftFeLGcFfzk/g9NZhUAAySm1DB0l9hQrOgWZ0aiiww6mtwSgUKXApIBYiHNsjH9Yg9Ih
         t9W5rExmrQrzos9wqECgyMDXNMXGyvn8gaINtEZJlFJPLumGw2ctcgoh7EN9UCRyseQi
         8dTsBcrbqqJzuWnUs1ZxxnAmjJRrr96/Zjrg/yyLjZNYdmYi0J/L0KSNHPCW21Ls7y65
         1LFw==
X-Gm-Message-State: AOJu0Yz0FNARn1etmVoN7G3p8rV7t9oIEgeBhneTNUszw/veIzZoHvS9
	04ORFW04mAU3FnYEmXKCnhDDswCJonBo+2/ymA6kMZKW1Q0=
X-Google-Smtp-Source: AGHT+IEDwz5yPEo6ahjMCC8huFvwsUh9L+l+u0p2DVq12UaRX87hYIx7TdMuc/cDfrD0mlXUR4f6ow9G1O4Lott4yAk=
X-Received: by 2002:a05:6512:1116:b0:50b:c208:720b with SMTP id
 l22-20020a056512111600b0050bc208720bmr551535lfg.60.1701454957271; Fri, 01 Dec
 2023 10:22:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128182152.57198-1-cgzones@googlemail.com>
In-Reply-To: <20231128182152.57198-1-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 1 Dec 2023 13:22:25 -0500
Message-ID: <CAP+JOzQxkgxomT-rEy=vPmpqhh+W0Xvsjbm1=UhD+nHbDC4DjA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: simplify string formatting
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 1:22=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Simplify the string formatting helpers create_str() and
> strs_create_and_add() by calling the GNU extension vasprintf(3), already
> used in libsepol/cil/.  This allows to drop a redundant parameter from
> both functions.
>

The last line is missing a word. When I merge it, I am going to change
it to "This allows a redundant parameter from both functions to be
dropped."

> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/kernel_to_cil.c    | 56 ++++++++++++++---------------
>  libsepol/src/kernel_to_common.c | 62 +++++++--------------------------
>  libsepol/src/kernel_to_common.h |  8 ++---
>  libsepol/src/kernel_to_conf.c   | 60 +++++++++++++++----------------
>  4 files changed, 74 insertions(+), 112 deletions(-)
>
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index 8ec79749..bcb58eee 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -45,7 +45,7 @@ static char *cond_expr_to_str(struct policydb *pdb, str=
uct cond_expr *expr)
>         for (curr =3D expr; curr !=3D NULL; curr =3D curr->next) {
>                 if (curr->expr_type =3D=3D COND_BOOL) {
>                         char *val1 =3D pdb->p_bool_val_to_name[curr->bool=
ean - 1];
> -                       new_val =3D create_str("%s", 1, val1);
> +                       new_val =3D create_str("%s", val1);
>                 } else {
>                         const char *op;
>                         uint32_t num_params;
> @@ -79,10 +79,10 @@ static char *cond_expr_to_str(struct policydb *pdb, s=
truct cond_expr *expr)
>                                 goto exit;
>                         }
>                         if (num_params =3D=3D 2) {
> -                               new_val =3D create_str("(%s %s %s)", 3, o=
p, val1, val2);
> +                               new_val =3D create_str("(%s %s %s)", op, =
val1, val2);
>                                 free(val2);
>                         } else {
> -                               new_val =3D create_str("(%s %s)", 2, op, =
val1);
> +                               new_val =3D create_str("(%s %s)", op, val=
1);
>                         }
>                         free(val1);
>                 }
> @@ -178,7 +178,7 @@ static char *constraint_expr_to_str(struct policydb *=
pdb, struct constraint_expr
>                         }
>
>                         if (curr->expr_type =3D=3D CEXPR_ATTR) {
> -                               new_val =3D create_str("(%s %s %s)", 3, o=
p, attr1, attr2);
> +                               new_val =3D create_str("(%s %s %s)", op, =
attr1, attr2);
>                         } else {
>                                 char *names =3D NULL;
>                                 if (curr->attr & CEXPR_TYPE) {
> @@ -197,9 +197,9 @@ static char *constraint_expr_to_str(struct policydb *=
pdb, struct constraint_expr
>                                         }
>                                 }
>                                 if (strchr(names, ' ')) {
> -                                       new_val =3D create_str("(%s %s (%=
s))", 3, op, attr1, names);
> +                                       new_val =3D create_str("(%s %s (%=
s))", op, attr1, names);
>                                 } else {
> -                                       new_val =3D create_str("(%s %s %s=
)", 3, op, attr1, names);
> +                                       new_val =3D create_str("(%s %s %s=
)", op, attr1, names);
>                                 }
>                                 free(names);
>                         }
> @@ -232,10 +232,10 @@ static char *constraint_expr_to_str(struct policydb=
 *pdb, struct constraint_expr
>                         }
>
>                         if (num_params =3D=3D 2) {
> -                               new_val =3D create_str("(%s %s %s)", 3, o=
p, val1, val2);
> +                               new_val =3D create_str("(%s %s %s)", op, =
val1, val2);
>                                 free(val2);
>                         } else {
> -                               new_val =3D create_str("(%s %s)", 2, op, =
val1);
> +                               new_val =3D create_str("(%s %s)", op, val=
1);
>                         }
>                         free(val1);
>                 }
> @@ -306,7 +306,7 @@ static int class_constraint_rules_to_strs(struct poli=
cydb *pdb, char *classkey,
>                         strs =3D non_mls_list;
>                 }
>
> -               rc =3D strs_create_and_add(strs, "(%s (%s (%s)) %s)", 4, =
key_word, classkey, perms+1, expr);
> +               rc =3D strs_create_and_add(strs, "(%s (%s (%s)) %s)", key=
_word, classkey, perms+1, expr);
>                 free(expr);
>                 if (rc !=3D 0) {
>                         goto exit;
> @@ -346,7 +346,7 @@ static int class_validatetrans_rules_to_strs(struct p=
olicydb *pdb, char *classke
>                         strs =3D non_mls_list;
>                 }
>
> -               rc =3D strs_create_and_add(strs, "(%s %s %s)", 3, key_wor=
d, classkey, expr);
> +               rc =3D strs_create_and_add(strs, "(%s %s %s)", key_word, =
classkey, expr);
>                 free(expr);
>                 if (rc !=3D 0) {
>                         goto exit;
> @@ -1203,7 +1203,7 @@ static int write_polcap_rules_to_cil(FILE *out, str=
uct policydb *pdb)
>                         goto exit;
>                 }
>
> -               rc =3D strs_create_and_add(strs, "(policycap %s)", 1, nam=
e);
> +               rc =3D strs_create_and_add(strs, "(policycap %s)", name);
>                 if (rc !=3D 0) {
>                         goto exit;
>                 }
> @@ -1321,7 +1321,7 @@ static int map_boolean_to_strs(char *key, void *dat=
a, void *args)
>
>         value =3D boolean->state ? "true" : "false";
>
> -       return strs_create_and_add(strs, "(boolean %s %s)", 2, key, value=
);
> +       return strs_create_and_add(strs, "(boolean %s %s)", key, value);
>  }
>
>  static int write_boolean_decl_rules_to_cil(FILE *out, struct policydb *p=
db)
> @@ -1562,7 +1562,7 @@ static int write_type_attribute_sets_to_cil(FILE *o=
ut, struct policydb *pdb)
>                 }
>
>                 rc =3D strs_create_and_add(strs, "(typeattributeset %s (%=
s))",
> -                                        2, name, types);
> +                                        name, types);
>                 free(types);
>                 if (rc !=3D 0) {
>                         goto exit;
> @@ -1770,7 +1770,7 @@ static char *avtab_node_to_str(struct policydb *pdb=
, avtab_key_t *key, avtab_dat
>                         ERR(NULL, "Failed to generate permission string")=
;
>                         goto exit;
>                 }
> -               rule =3D create_str("(%s %s %s (%s (%s)))", 5,
> +               rule =3D create_str("(%s %s %s (%s (%s)))",
>                                   flavor, src, tgt, class, perms+1);
>         } else if (key->specified & AVTAB_XPERMS) {
>                 perms =3D xperms_to_str(datum->xperms);
> @@ -1779,13 +1779,13 @@ static char *avtab_node_to_str(struct policydb *p=
db, avtab_key_t *key, avtab_dat
>                         goto exit;
>                 }
>
> -               rule =3D create_str("(%s %s %s (%s %s (%s)))", 6,
> +               rule =3D create_str("(%s %s %s (%s %s (%s)))",
>                                   flavor, src, tgt, "ioctl", class, perms=
);
>                 free(perms);
>         } else {
>                 new =3D pdb->p_type_val_to_name[data - 1];
>
> -               rule =3D create_str("(%s %s %s %s %s)", 5, flavor, src, t=
gt, class, new);
> +               rule =3D create_str("(%s %s %s %s %s)", flavor, src, tgt,=
 class, new);
>         }
>
>         if (!rule) {
> @@ -1907,7 +1907,7 @@ static int map_filename_trans_to_str(hashtab_key_t =
key, void *data, void *arg)
>                         src =3D pdb->p_type_val_to_name[bit];
>                         rc =3D strs_create_and_add(strs,
>                                                  "(typetransition %s %s %=
s \"%s\" %s)",
> -                                                5, src, tgt, class, file=
name, new);
> +                                                src, tgt, class, filenam=
e, new);
>                         if (rc)
>                                 return rc;
>                 }
> @@ -1960,10 +1960,10 @@ static char *level_to_str(struct policydb *pdb, s=
truct mls_level *level)
>
>         if (!ebitmap_is_empty(cats)) {
>                 cats_str =3D cats_ebitmap_to_str(cats, pdb->p_cat_val_to_=
name);
> -               level_str =3D create_str("(%s %s)", 2, sens_str, cats_str=
);
> +               level_str =3D create_str("(%s %s)", sens_str, cats_str);
>                 free(cats_str);
>         } else {
> -               level_str =3D create_str("(%s)", 1, sens_str);
> +               level_str =3D create_str("(%s)", sens_str);
>         }
>
>         return level_str;
> @@ -1985,7 +1985,7 @@ static char *range_to_str(struct policydb *pdb, mls=
_range_t *range)
>                 goto exit;
>         }
>
> -       range_str =3D create_str("(%s %s)", 2, low, high);
> +       range_str =3D create_str("(%s %s)", low, high);
>
>  exit:
>         free(low);
> @@ -2018,7 +2018,7 @@ static int map_range_trans_to_str(hashtab_key_t key=
, void *data, void *arg)
>                 goto exit;
>         }
>
> -       rc =3D strs_create_and_add(strs, "(rangetransition %s %s %s %s)",=
 4,
> +       rc =3D strs_create_and_add(strs, "(rangetransition %s %s %s %s)",
>                                  src, tgt, class, range);
>         free(range);
>         if (rc !=3D 0) {
> @@ -2345,7 +2345,7 @@ static int write_role_transition_rules_to_cil(FILE =
*out, struct policydb *pdb)
>                 class =3D pdb->p_class_val_to_name[curr->tclass - 1];
>                 new =3D pdb->p_role_val_to_name[curr->new_role - 1];
>
> -               rc =3D strs_create_and_add(strs, "(roletransition %s %s %=
s %s)", 4,
> +               rc =3D strs_create_and_add(strs, "(roletransition %s %s %=
s %s)",
>                                          role, type, class, new);
>                 if (rc !=3D 0) {
>                         goto exit;
> @@ -2384,7 +2384,7 @@ static int write_role_allow_rules_to_cil(FILE *out,=
 struct policydb *pdb)
>                 role =3D pdb->p_role_val_to_name[curr->role - 1];
>                 new =3D  pdb->p_role_val_to_name[curr->new_role - 1];
>
> -               rc =3D strs_create_and_add(strs, "(roleallow %s %s)", 2, =
role, new);
> +               rc =3D strs_create_and_add(strs, "(roleallow %s %s)", rol=
e, new);
>                 if (rc !=3D 0) {
>                         goto exit;
>                 }
> @@ -2559,13 +2559,13 @@ static char *context_to_str(struct policydb *pdb,=
 struct context_struct *con)
>         if (pdb->mls) {
>                 range =3D range_to_str(pdb, &con->range);
>         } else {
> -               range =3D create_str("(%s %s)", 2, DEFAULT_LEVEL, DEFAULT=
_LEVEL);
> +               range =3D create_str("(%s %s)", DEFAULT_LEVEL, DEFAULT_LE=
VEL);
>         }
>         if (!range) {
>                 goto exit;
>         }
>
> -       ctx =3D create_str("(%s %s %s %s)", 4, user, role, type, range);
> +       ctx =3D create_str("(%s %s %s %s)", user, role, type, range);
>         free(range);
>
>  exit:
> @@ -2602,7 +2602,7 @@ static int write_sid_context_rules_to_cil(FILE *out=
, struct policydb *pdb, const
>                         goto exit;
>                 }
>
> -               rule =3D create_str("(sidcontext %s %s)", 2, sid, ctx);
> +               rule =3D create_str("(sidcontext %s %s)", sid, ctx);
>                 free(ctx);
>                 if (!rule) {
>                         rc =3D -1;
> @@ -2724,10 +2724,10 @@ static int write_genfscon_rules_to_cil(FILE *out,=
 struct policydb *pdb)
>                         }
>
>                         if (file_type) {
> -                               rc =3D strs_create_and_add(strs, "(genfsc=
on %s \"%s\" %s %s)", 4,
> +                               rc =3D strs_create_and_add(strs, "(genfsc=
on %s \"%s\" %s %s)",
>                                                                          =
        fstype, name, file_type, ctx);
>                         } else {
> -                               rc =3D strs_create_and_add(strs, "(genfsc=
on %s \"%s\" %s)", 3,
> +                               rc =3D strs_create_and_add(strs, "(genfsc=
on %s \"%s\" %s)",
>                                                                          =
        fstype, name, ctx);
>                         }
>                         free(ctx);
> diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_com=
mon.c
> index 09c08b3d..4612eef3 100644
> --- a/libsepol/src/kernel_to_common.c
> +++ b/libsepol/src/kernel_to_common.c
> @@ -40,55 +40,19 @@ void sepol_printf(FILE *out, const char *fmt, ...)
>         va_end(argptr);
>  }
>
> -__attribute__ ((format(printf, 1, 0)))
> -static char *create_str_helper(const char *fmt, int num, va_list vargs)
> +char *create_str(const char *fmt, ...)
>  {
> -       va_list vargs2;
> -       char *str =3D NULL;
> -       char *s;
> -       size_t len, s_len;
> -       int i, rc;
> -
> -       va_copy(vargs2, vargs);
> -
> -       len =3D strlen(fmt) + 1; /* +1 for '\0' */
> -
> -       for (i=3D0; i<num; i++) {
> -               s =3D va_arg(vargs, char *);
> -               s_len =3D strlen(s);
> -               len +=3D s_len > 1 ? s_len - 2 : 0; /* -2 for each %s in =
fmt */
> -       }
> -
> -       str =3D malloc(len);
> -       if (!str) {
> -               ERR(NULL, "Out of memory");
> -               goto exit;
> -       }
> -
> -       rc =3D vsnprintf(str, len, fmt, vargs2);
> -       if (rc < 0 || rc >=3D (int)len) {
> -               goto exit;
> -       }
> -
> -       va_end(vargs2);
> -
> -       return str;
> -
> -exit:
> -       free(str);
> -       va_end(vargs2);
> -       return NULL;
> -}
> -
> -char *create_str(const char *fmt, int num, ...)
> -{
> -       char *str =3D NULL;
> +       char *str;
>         va_list vargs;
> +       int rc;
>
> -       va_start(vargs, num);
> -       str =3D create_str_helper(fmt, num, vargs);
> +       va_start(vargs, fmt);
> +       rc =3D vasprintf(&str, fmt, vargs);
>         va_end(vargs);
>
> +       if (rc =3D=3D -1)
> +               return NULL;
> +
>         return str;
>  }
>
> @@ -170,20 +134,18 @@ int strs_add(struct strs *strs, char *s)
>         return 0;
>  }
>
> -int strs_create_and_add(struct strs *strs, const char *fmt, int num, ...=
)
> +int strs_create_and_add(struct strs *strs, const char *fmt, ...)
>  {
>         char *str;
>         va_list vargs;
>         int rc;
>
> -       va_start(vargs, num);
> -       str =3D create_str_helper(fmt, num, vargs);
> +       va_start(vargs, fmt);
> +       rc =3D vasprintf(&str, fmt, vargs);
>         va_end(vargs);
>
> -       if (!str) {
> -               rc =3D -1;
> +       if (rc =3D=3D -1)
>                 goto exit;
> -       }
>
>         rc =3D strs_add(strs, str);
>         if (rc !=3D 0) {
> diff --git a/libsepol/src/kernel_to_common.h b/libsepol/src/kernel_to_com=
mon.h
> index 9e567eb8..3ba97dfc 100644
> --- a/libsepol/src/kernel_to_common.h
> +++ b/libsepol/src/kernel_to_common.h
> @@ -87,15 +87,15 @@ void sepol_indent(FILE *out, int indent);
>  __attribute__ ((format(printf, 2, 3)))
>  void sepol_printf(FILE *out, const char *fmt, ...);
>
> -__attribute__ ((format(printf, 1, 3)))
> -char *create_str(const char *fmt, int num, ...);
> +__attribute__ ((format(printf, 1, 2)))
> +char *create_str(const char *fmt, ...);
>
>  int strs_init(struct strs **strs, size_t size);
>  void strs_destroy(struct strs **strs);
>  void strs_free_all(struct strs *strs);
>  int strs_add(struct strs *strs, char *s);
> -__attribute__ ((format(printf, 2, 4)))
> -int strs_create_and_add(struct strs *strs, const char *fmt, int num, ...=
);
> +__attribute__ ((format(printf, 2, 3)))
> +int strs_create_and_add(struct strs *strs, const char *fmt, ...);
>  char *strs_remove_last(struct strs *strs);
>  int strs_add_at_index(struct strs *strs, char *s, size_t index);
>  char *strs_read_at_index(struct strs *strs, size_t index);
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
> index b5b530d6..83f46e0f 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -44,7 +44,7 @@ static char *cond_expr_to_str(struct policydb *pdb, str=
uct cond_expr *expr)
>         for (curr =3D expr; curr !=3D NULL; curr =3D curr->next) {
>                 if (curr->expr_type =3D=3D COND_BOOL) {
>                         char *val1 =3D pdb->p_bool_val_to_name[curr->bool=
ean - 1];
> -                       new_val =3D create_str("%s", 1, val1);
> +                       new_val =3D create_str("%s", val1);
>                 } else {
>                         const char *op;
>                         uint32_t num_params;
> @@ -77,10 +77,10 @@ static char *cond_expr_to_str(struct policydb *pdb, s=
truct cond_expr *expr)
>                                 goto exit;
>                         }
>                         if (num_params =3D=3D 2) {
> -                               new_val =3D create_str("(%s %s %s)", 3, v=
al1, op, val2);
> +                               new_val =3D create_str("(%s %s %s)", val1=
, op, val2);
>                                 free(val2);
>                         } else {
> -                               new_val =3D create_str("%s %s", 2, op, va=
l1);
> +                               new_val =3D create_str("%s %s", op, val1)=
;
>                         }
>                         free(val1);
>                 }
> @@ -175,7 +175,7 @@ static char *constraint_expr_to_str(struct policydb *=
pdb, struct constraint_expr
>                         }
>
>                         if (curr->expr_type =3D=3D CEXPR_ATTR) {
> -                               new_val =3D create_str("%s %s %s", 3, att=
r1, op, attr2);
> +                               new_val =3D create_str("%s %s %s", attr1,=
 op, attr2);
>                         } else {
>                                 char *names =3D NULL;
>                                 if (curr->attr & CEXPR_TYPE) {
> @@ -194,9 +194,9 @@ static char *constraint_expr_to_str(struct policydb *=
pdb, struct constraint_expr
>                                         }
>                                 }
>                                 if (strchr(names, ' ')) {
> -                                       new_val =3D create_str("%s %s { %=
s }", 3, attr1, op, names);
> +                                       new_val =3D create_str("%s %s { %=
s }", attr1, op, names);
>                                 } else {
> -                                       new_val =3D create_str("%s %s %s"=
, 3, attr1, op, names);
> +                                       new_val =3D create_str("%s %s %s"=
, attr1, op, names);
>                                 }
>                                 free(names);
>                         }
> @@ -228,10 +228,10 @@ static char *constraint_expr_to_str(struct policydb=
 *pdb, struct constraint_expr
>                         }
>
>                         if (num_params =3D=3D 2) {
> -                               new_val =3D create_str("(%s %s %s)", 3, v=
al1, op, val2);
> +                               new_val =3D create_str("(%s %s %s)", val1=
, op, val2);
>                                 free(val2);
>                         } else {
> -                               new_val =3D create_str("%s (%s)", 2, op, =
val1);
> +                               new_val =3D create_str("%s (%s)", op, val=
1);
>                         }
>                         free(val1);
>                 }
> @@ -307,7 +307,7 @@ static int class_constraint_rules_to_strs(struct poli=
cydb *pdb, char *classkey,
>                         strs =3D non_mls_list;
>                 }
>
> -               rc =3D strs_create_and_add(strs, "%s %s %s%s%s %s;", 6,
> +               rc =3D strs_create_and_add(strs, "%s %s %s%s%s %s;",
>                                          flavor, classkey,
>                                          perm_prefix, perms+1, perm_suffi=
x,
>                                          expr);
> @@ -350,7 +350,7 @@ static int class_validatetrans_rules_to_strs(struct p=
olicydb *pdb, char *classke
>                         strs =3D non_mls_list;
>                 }
>
> -               rc =3D strs_create_and_add(strs, "%s %s %s;", 3, flavor, =
classkey, expr);
> +               rc =3D strs_create_and_add(strs, "%s %s %s;", flavor, cla=
sskey, expr);
>                 free(expr);
>                 if (rc !=3D 0) {
>                         goto exit;
> @@ -834,7 +834,7 @@ static int write_sensitivity_rules_to_conf(FILE *out,=
 struct policydb *pdb)
>                                 }
>                         } else {
>                                 alias =3D sens_alias_map[j];
> -                               sens_alias_map[j] =3D create_str("%s %s",=
 2, alias, name);
> +                               sens_alias_map[j] =3D create_str("%s %s",=
 alias, name);
>                                 free(alias);
>                                 if (!sens_alias_map[j]) {
>                                         rc =3D -1;
> @@ -965,7 +965,7 @@ static int write_category_rules_to_conf(FILE *out, st=
ruct policydb *pdb)
>                                 }
>                         } else {
>                                 alias =3D cat_alias_map[j];
> -                               cat_alias_map[j] =3D create_str("%s %s", =
2, alias, name);
> +                               cat_alias_map[j] =3D create_str("%s %s", =
alias, name);
>                                 free(alias);
>                                 if (!cat_alias_map[j]) {
>                                         rc =3D -1;
> @@ -1186,7 +1186,7 @@ static int write_polcap_rules_to_conf(FILE *out, st=
ruct policydb *pdb)
>                         goto exit;
>                 }
>
> -               rc =3D strs_create_and_add(strs, "policycap %s;", 1, name=
);
> +               rc =3D strs_create_and_add(strs, "policycap %s;", name);
>                 if (rc !=3D 0) {
>                         goto exit;
>                 }
> @@ -1304,7 +1304,7 @@ static int map_boolean_to_strs(char *key, void *dat=
a, void *args)
>
>         value =3D boolean->state ? "true" : "false";
>
> -       return strs_create_and_add(strs, "bool %s %s;", 2, key, value);
> +       return strs_create_and_add(strs, "bool %s %s;", key, value);
>  }
>
>  static int write_boolean_decl_rules_to_conf(FILE *out, struct policydb *=
pdb)
> @@ -1615,7 +1615,7 @@ static int write_type_attribute_sets_to_conf(FILE *=
out, struct policydb *pdb)
>                 }
>
>                 rc =3D strs_create_and_add(strs, "typeattribute %s %s;",
> -                                        2, name, attrs);
> +                                        name, attrs);
>                 free(attrs);
>                 if (rc !=3D 0) {
>                         goto exit;
> @@ -1735,7 +1735,7 @@ static char *avtab_node_to_str(struct policydb *pdb=
, avtab_key_t *key, avtab_dat
>                         ERR(NULL, "Failed to generate permission string")=
;
>                         goto exit;
>                 }
> -               rule =3D create_str("%s %s %s:%s { %s };", 5,
> +               rule =3D create_str("%s %s %s:%s { %s };",
>                                   flavor, src, tgt, class, perms+1);
>         } else if (key->specified & AVTAB_XPERMS) {
>                 permstring =3D sepol_extended_perms_to_string(datum->xper=
ms);
> @@ -1744,12 +1744,12 @@ static char *avtab_node_to_str(struct policydb *p=
db, avtab_key_t *key, avtab_dat
>                         goto exit;
>                 }
>
> -               rule =3D create_str("%s %s %s:%s %s;", 5, flavor, src, tg=
t, class, permstring);
> +               rule =3D create_str("%s %s %s:%s %s;", flavor, src, tgt, =
class, permstring);
>                 free(permstring);
>         } else {
>                 new =3D pdb->p_type_val_to_name[data - 1];
>
> -               rule =3D create_str("%s %s %s:%s %s;", 5, flavor, src, tg=
t, class, new);
> +               rule =3D create_str("%s %s %s:%s %s;", flavor, src, tgt, =
class, new);
>         }
>
>         if (!rule) {
> @@ -1871,7 +1871,7 @@ static int map_filename_trans_to_str(hashtab_key_t =
key, void *data, void *arg)
>                         src =3D pdb->p_type_val_to_name[bit];
>                         rc =3D strs_create_and_add(strs,
>                                                  "type_transition %s %s:%=
s %s \"%s\";",
> -                                                5, src, tgt, class, new,=
 filename);
> +                                                src, tgt, class, new, fi=
lename);
>                         if (rc)
>                                 return rc;
>                 }
> @@ -1924,10 +1924,10 @@ static char *level_to_str(struct policydb *pdb, s=
truct mls_level *level)
>
>         if (!ebitmap_is_empty(cats)) {
>                 cats_str =3D cats_ebitmap_to_str(cats, pdb->p_cat_val_to_=
name);
> -               level_str =3D create_str("%s:%s", 2, sens_str, cats_str);
> +               level_str =3D create_str("%s:%s", sens_str, cats_str);
>                 free(cats_str);
>         } else {
> -               level_str =3D create_str("%s", 1, sens_str);
> +               level_str =3D create_str("%s", sens_str);
>         }
>
>         return level_str;
> @@ -1949,7 +1949,7 @@ static char *range_to_str(struct policydb *pdb, mls=
_range_t *range)
>                 goto exit;
>         }
>
> -       range_str =3D create_str("%s - %s", 2, low, high);
> +       range_str =3D create_str("%s - %s", low, high);
>
>  exit:
>         free(low);
> @@ -1982,7 +1982,7 @@ static int map_range_trans_to_str(hashtab_key_t key=
, void *data, void *arg)
>                 goto exit;
>         }
>
> -       rc =3D strs_create_and_add(strs, "range_transition %s %s:%s %s;",=
 4,
> +       rc =3D strs_create_and_add(strs, "range_transition %s %s:%s %s;",
>                                  src, tgt, class, range);
>         free(range);
>         if (rc !=3D 0) {
> @@ -2264,7 +2264,7 @@ static int write_role_transition_rules_to_conf(FILE=
 *out, struct policydb *pdb)
>                 class =3D pdb->p_class_val_to_name[curr->tclass - 1];
>                 new =3D pdb->p_role_val_to_name[curr->new_role - 1];
>
> -               rc =3D strs_create_and_add(strs, "role_transition %s %s:%=
s %s;", 4,
> +               rc =3D strs_create_and_add(strs, "role_transition %s %s:%=
s %s;",
>                                          role, type, class, new);
>                 if (rc !=3D 0) {
>                         goto exit;
> @@ -2303,7 +2303,7 @@ static int write_role_allow_rules_to_conf(FILE *out=
, struct policydb *pdb)
>                 role =3D pdb->p_role_val_to_name[curr->role - 1];
>                 new =3D  pdb->p_role_val_to_name[curr->new_role - 1];
>
> -               rc =3D strs_create_and_add(strs, "allow %s %s;", 2, role,=
 new);
> +               rc =3D strs_create_and_add(strs, "allow %s %s;", role, ne=
w);
>                 if (rc !=3D 0) {
>                         goto exit;
>                 }
> @@ -2419,10 +2419,10 @@ static char *context_to_str(struct policydb *pdb,=
 struct context_struct *con)
>
>         if (pdb->mls) {
>                 range =3D range_to_str(pdb, &con->range);
> -               ctx =3D create_str("%s:%s:%s:%s", 4, user, role, type, ra=
nge);
> +               ctx =3D create_str("%s:%s:%s:%s", user, role, type, range=
);
>                 free(range);
>         } else {
> -               ctx =3D create_str("%s:%s:%s", 3, user, role, type);
> +               ctx =3D create_str("%s:%s:%s", user, role, type);
>         }
>
>         return ctx;
> @@ -2458,7 +2458,7 @@ static int write_sid_context_rules_to_conf(FILE *ou=
t, struct policydb *pdb, cons
>                         goto exit;
>                 }
>
> -               rule =3D create_str("sid %s %s", 2, sid, ctx);
> +               rule =3D create_str("sid %s %s", sid, ctx);
>                 free(ctx);
>                 if (!rule) {
>                         rc =3D -1;
> @@ -2580,10 +2580,10 @@ static int write_genfscon_rules_to_conf(FILE *out=
, struct policydb *pdb)
>                         }
>
>                         if (file_type) {
> -                               rc =3D strs_create_and_add(strs, "genfsco=
n %s \"%s\" %s %s", 4,
> +                               rc =3D strs_create_and_add(strs, "genfsco=
n %s \"%s\" %s %s",
>                                                                          =
        fstype, name, file_type, ctx);
>                         } else {
> -                               rc =3D strs_create_and_add(strs, "genfsco=
n %s \"%s\" %s", 3,
> +                               rc =3D strs_create_and_add(strs, "genfsco=
n %s \"%s\" %s",
>                                                                          =
        fstype, name, ctx);
>                         }
>                         free(ctx);
> --
> 2.43.0
>
>
