Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZ2DTMup"
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEF9B3
	for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 09:07:35 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50c0478f970so4854557e87.3
        for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 09:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702314454; x=1702919254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88PT0KIdhuZBDpDKw7eJDq1RomTeOs5lGfhTm4QS/Uo=;
        b=hZ2DTMup59I3ygiARoPIQZ12bGIZGZ8xiyNm0TflK8IdYGUeK5fbqnv6j9K44PAhiW
         S8BFRU80ALJPMgMtnAYBVh9xEfRh0W9osuAqL400eOH3QVb78cBb8oyPayZN2ayiAsq2
         Fy/QHou4wJIXnStIHIng2QyS9nOWh1u+6qEDhWmP+g+5Jz4CkNolcfXWI33ivpL3cGMb
         gxClNRSqvDx0WS5OpTWVw/IHQWJL4gDVEr8/56u/c8VnSvbAEMpcc2vJ2yc1AHk/9swM
         mLWgokMGA/VnwSUmlJ+1mZ+4WaebjoNaShfMr/ZF+cVef6ek43YbirwYVwxegS7BOQSz
         0KFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702314454; x=1702919254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88PT0KIdhuZBDpDKw7eJDq1RomTeOs5lGfhTm4QS/Uo=;
        b=LXTf0r+rnYqnGQnoPxeXgheaEGqasMoqp6JIRmtgtiAjTPqVvshZIJsh7IWzCU2axO
         2RoiIhwz8DsRwKuaTUYvG0C901vI5myOZo4VJcda/qkpj/eVYkk4vqP2oFjyjf9b7bNh
         8S73L5y3HTr+SrxbYqC6KP102KoeFhhdCdzRA9Yn8eAEVN1oT+l7PYgRmUgrWYhr4R//
         Tri9p1+b5UcjCdq38V6S56h4GW5HpCNPQCI4Z112z7nCpfBGyKoANy9WxDX6a7xwL/KO
         RRSG17u+tct9pN18BCEaTWiTUgU1f4gGO27CkhW2AOBim2+djIOxzjvfbD6Zq34Mm+nG
         HV+w==
X-Gm-Message-State: AOJu0YxP2jNl0+CMs8OxshgP1OHq9CDW+skIz4zSgXkIthFY1Xa59Fmg
	1kKGumdJa5G6No624+8er6Jjo9wwa/6iB3MK3iM=
X-Google-Smtp-Source: AGHT+IFmdl+5wCt8RvuG0F2isUjfZfmZh5/LyMwBR5ddvzeYpINMbAfGR/JPcvUizinvXqMWQU93ONNDP7++uPVvCKQ=
X-Received: by 2002:a05:6512:3f0a:b0:50b:c41d:8e8b with SMTP id
 y10-20020a0565123f0a00b0050bc41d8e8bmr2503449lfa.8.1702314453355; Mon, 11 Dec
 2023 09:07:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211145408.124757-1-cgzones@googlemail.com>
In-Reply-To: <20231211145408.124757-1-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 11 Dec 2023 12:07:21 -0500
Message-ID: <CAP+JOzS+CAydQ=bhw5L8TUb2TXzp-EX20b3C6EDKQOv++MYVnQ@mail.gmail.com>
Subject: Re: [RFC PATCH] libsepol: handle long permission names in sepol_av_to_string()
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 9:54=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Use a growing dynamically allocated buffer to format permission names of
> an access vector instead of a fixed static buffer to support very long
> permission names.
>
> This changes the behavior of the since libsepol 3.4 exported function
> sepol_av_perm_to_string(): previously it returned a pointer to a static
> buffer which must not be free'd by the caller, now an allocated string
> which should be free'd by the caller (to avoid memory leaks).
>
> Reported-by: oss-fuzz (issue 64832, 64933)
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

I like this patch and would like to merge it, but it does change an
exported function (by removing const on the return type).
As far as I know, the only thing that uses the function externally is
sepol_compute_av in libsepol/utils and the function has only been
exported since 2022, so I doubt there would be any harm in making the
change. But I am still hesitant to make the change.

What is the best way to handle this?
Jim


> ---
> The oss-fuzz issue 64832 got closed by the latest fuzzer updates (due to
> unrelated changes that invalid the current reproducer), but the issue is
> still valid.
>
> Supersedes https://patchwork.kernel.org/project/selinux/patch/20231207165=
319.63889-1-cgzones@googlemail.com/
> ---
>  checkpolicy/test/dismod.c                  | 11 +++--
>  checkpolicy/test/dispol.c                  |  7 ++--
>  libsepol/include/sepol/policydb/services.h |  5 +--
>  libsepol/include/sepol/policydb/util.h     |  2 +-
>  libsepol/src/assertion.c                   | 16 +++++--
>  libsepol/src/hierarchy.c                   |  7 +++-
>  libsepol/src/kernel_to_cil.c               |  7 ++++
>  libsepol/src/kernel_to_conf.c              | 15 +++++--
>  libsepol/src/module_to_cil.c               |  7 ++++
>  libsepol/src/services.c                    |  8 ++--
>  libsepol/src/util.c                        | 49 ++++++++++++----------
>  libsepol/utils/sepol_compute_av.c          | 25 ++++++++---
>  12 files changed, 106 insertions(+), 53 deletions(-)
>
> diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
> index ac2d61d2..bd45c95e 100644
> --- a/checkpolicy/test/dismod.c
> +++ b/checkpolicy/test/dismod.c
> @@ -118,12 +118,11 @@ static __attribute__((__noreturn__)) void usage(con=
st char *progname)
>  static void render_access_mask(uint32_t mask, uint32_t class, policydb_t=
 * p,
>                                FILE * fp)
>  {
> -       char *perm;
> +       char *perm =3D sepol_av_to_string(p, class, mask);
>         fprintf(fp, "{");
> -       perm =3D sepol_av_to_string(p, class, mask);
> -       if (perm)
> -               fprintf(fp, "%s ", perm);
> +       fprintf(fp, "%s ", perm ?: "<format-failure>");
>         fprintf(fp, "}");
> +       free(perm);
>  }
>
>  static void render_access_bitmap(ebitmap_t * map, uint32_t class,
> @@ -135,8 +134,8 @@ static void render_access_bitmap(ebitmap_t * map, uin=
t32_t class,
>         for (i =3D ebitmap_startbit(map); i < ebitmap_length(map); i++) {
>                 if (ebitmap_get_bit(map, i)) {
>                         perm =3D sepol_av_to_string(p, class, UINT32_C(1)=
 << i);
> -                       if (perm)
> -                               fprintf(fp, "%s", perm);
> +                       fprintf(fp, "%s", perm ?: "<format-failure>");
> +                       free(perm);
>                 }
>         }
>         fprintf(fp, " }");
> diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
> index 944ef7ec..2662048e 100644
> --- a/checkpolicy/test/dispol.c
> +++ b/checkpolicy/test/dispol.c
> @@ -93,12 +93,11 @@ static __attribute__((__noreturn__)) void usage(const=
 char *progname)
>  static int render_access_mask(uint32_t mask, avtab_key_t * key, policydb=
_t * p,
>                        FILE * fp)
>  {
> -       char *perm;
> +       char *perm =3D sepol_av_to_string(p, key->target_class, mask);
>         fprintf(fp, "{");
> -       perm =3D sepol_av_to_string(p, key->target_class, mask);
> -       if (perm)
> -               fprintf(fp, "%s ", perm);
> +       fprintf(fp, "%s ", perm ?: "<format-failure>");
>         fprintf(fp, "}");
> +       free(perm);
>         return 0;
>  }
>
> diff --git a/libsepol/include/sepol/policydb/services.h b/libsepol/includ=
e/sepol/policydb/services.h
> index f2e311aa..c5889da5 100644
> --- a/libsepol/include/sepol/policydb/services.h
> +++ b/libsepol/include/sepol/policydb/services.h
> @@ -106,10 +106,9 @@ extern int sepol_string_to_av_perm(sepol_security_cl=
ass_t tclass,
>  /*
>   * Return a string representation of the permission av bit associated wi=
th
>   * tclass.
> - * Returns a pointer to an internal buffer, overridden by the next call =
to
> - * this function or sepol_av_to_string().
> + * The returned string must be free'd by the caller using free(3).
>   */
> - extern const char *sepol_av_perm_to_string(sepol_security_class_t tclas=
s,
> +extern char *sepol_av_perm_to_string(sepol_security_class_t tclass,
>                                         sepol_access_vector_t av);
>
>  /*
> diff --git a/libsepol/include/sepol/policydb/util.h b/libsepol/include/se=
pol/policydb/util.h
> index db8da213..70c531d3 100644
> --- a/libsepol/include/sepol/policydb/util.h
> +++ b/libsepol/include/sepol/policydb/util.h
> @@ -31,7 +31,7 @@ extern "C" {
>
>  extern int add_i_to_a(uint32_t i, uint32_t * cnt, uint32_t ** a);
>
> -extern char *sepol_av_to_string(policydb_t * policydbp, uint32_t tclass,
> +extern char *sepol_av_to_string(const policydb_t *policydbp, sepol_secur=
ity_class_t tclass,
>                                 sepol_access_vector_t av);
>
>  char *sepol_extended_perms_to_string(avtab_extended_perms_t *xperms);
> diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
> index 6de7d031..3076babe 100644
> --- a/libsepol/src/assertion.c
> +++ b/libsepol/src/assertion.c
> @@ -48,26 +48,30 @@ static void report_failure(sepol_handle_t *handle, po=
licydb_t *p, const avrule_t
>                            unsigned int stype, unsigned int ttype,
>                            const class_perm_node_t *curperm, uint32_t per=
ms)
>  {
> +       char *permstr =3D sepol_av_to_string(p, curperm->tclass, perms);
> +
>         if (avrule->source_filename) {
>                 ERR(handle, "neverallow on line %lu of %s (or line %lu of=
 %s) violated by allow %s %s:%s {%s };",
>                     avrule->source_line, avrule->source_filename, avrule-=
>line, policy_name(p),
>                     p->p_type_val_to_name[stype],
>                     p->p_type_val_to_name[ttype],
>                     p->p_class_val_to_name[curperm->tclass - 1],
> -                   sepol_av_to_string(p, curperm->tclass, perms));
> +                   permstr ?: "<format-failure>");
>         } else if (avrule->line) {
>                 ERR(handle, "neverallow on line %lu violated by allow %s =
%s:%s {%s };",
>                     avrule->line, p->p_type_val_to_name[stype],
>                     p->p_type_val_to_name[ttype],
>                     p->p_class_val_to_name[curperm->tclass - 1],
> -                   sepol_av_to_string(p, curperm->tclass, perms));
> +                   permstr ?: "<format-failure>");
>         } else {
>                 ERR(handle, "neverallow violated by allow %s %s:%s {%s };=
",
>                     p->p_type_val_to_name[stype],
>                     p->p_type_val_to_name[ttype],
>                     p->p_class_val_to_name[curperm->tclass - 1],
> -                   sepol_av_to_string(p, curperm->tclass, perms));
> +                   permstr ?: "<format-failure>");
>         }
> +
> +       free(permstr);
>  }
>
>  static int match_any_class_permissions(class_perm_node_t *cp, uint32_t c=
lass, uint32_t data)
> @@ -200,13 +204,17 @@ static int report_assertion_extended_permissions(se=
pol_handle_t *handle,
>
>         /* failure on the regular permissions */
>         if (!found_xperm) {
> +               char *permstr =3D sepol_av_to_string(p, curperm->tclass, =
perms);
> +
>                 ERR(handle, "neverallowxperm on line %lu of %s (or line %=
lu of %s) violated by\n"
>                                 "allow %s %s:%s {%s };",
>                                 avrule->source_line, avrule->source_filen=
ame, avrule->line, policy_name(p),
>                                 p->p_type_val_to_name[stype],
>                                 p->p_type_val_to_name[ttype],
>                                 p->p_class_val_to_name[curperm->tclass - =
1],
> -                               sepol_av_to_string(p, curperm->tclass, pe=
rms));
> +                               permstr ?: "<format-failure>");
> +
> +               free(permstr);
>                 errors++;
>
>         }
> diff --git a/libsepol/src/hierarchy.c b/libsepol/src/hierarchy.c
> index 350443a8..06e05310 100644
> --- a/libsepol/src/hierarchy.c
> +++ b/libsepol/src/hierarchy.c
> @@ -443,12 +443,15 @@ static void bounds_report(sepol_handle_t *handle, p=
olicydb_t *p, uint32_t child,
>             p->p_type_val_to_name[child - 1],
>             p->p_type_val_to_name[parent - 1]);
>         for (; cur; cur =3D cur->next) {
> +               char *permstr =3D sepol_av_to_string(p, cur->key.target_c=
lass, cur->datum.data);
> +
>                 ERR(handle, "    %s %s : %s { %s }",
>                     p->p_type_val_to_name[cur->key.source_type - 1],
>                     p->p_type_val_to_name[cur->key.target_type - 1],
>                     p->p_class_val_to_name[cur->key.target_class - 1],
> -                   sepol_av_to_string(p, cur->key.target_class,
> -                                      cur->datum.data));
> +                   permstr ?: "<format-failure>");
> +
> +               free(permstr);
>         }
>  }
>
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index bcb58eee..634826d5 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -297,6 +297,11 @@ static int class_constraint_rules_to_strs(struct pol=
icydb *pdb, char *classkey,
>                 }
>
>                 perms =3D sepol_av_to_string(pdb, class->s.value, curr->p=
ermissions);
> +               if (!perms) {
> +                       ERR(NULL, "Failed to generate permission string")=
;
> +                       rc =3D -1;
> +                       goto exit;
> +               }
>
>                 if (is_mls) {
>                         key_word =3D "mlsconstrain";
> @@ -307,6 +312,7 @@ static int class_constraint_rules_to_strs(struct poli=
cydb *pdb, char *classkey,
>                 }
>
>                 rc =3D strs_create_and_add(strs, "(%s (%s (%s)) %s)", key=
_word, classkey, perms+1, expr);
> +               free(perms);
>                 free(expr);
>                 if (rc !=3D 0) {
>                         goto exit;
> @@ -1772,6 +1778,7 @@ static char *avtab_node_to_str(struct policydb *pdb=
, avtab_key_t *key, avtab_dat
>                 }
>                 rule =3D create_str("(%s %s %s (%s (%s)))",
>                                   flavor, src, tgt, class, perms+1);
> +               free(perms);
>         } else if (key->specified & AVTAB_XPERMS) {
>                 perms =3D xperms_to_str(datum->xperms);
>                 if (perms =3D=3D NULL) {
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
> index 83f46e0f..de1d9e09 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -292,6 +292,11 @@ static int class_constraint_rules_to_strs(struct pol=
icydb *pdb, char *classkey,
>                 }
>
>                 perms =3D sepol_av_to_string(pdb, class->s.value, curr->p=
ermissions);
> +               if (!perms) {
> +                       ERR(NULL, "Failed to generate permission string")=
;
> +                       rc =3D -1;
> +                       goto exit;
> +               }
>                 if (strchr(perms, ' ')) {
>                         perm_prefix =3D "{ ";
>                         perm_suffix =3D " }";
> @@ -311,6 +316,7 @@ static int class_constraint_rules_to_strs(struct poli=
cydb *pdb, char *classkey,
>                                          flavor, classkey,
>                                          perm_prefix, perms+1, perm_suffi=
x,
>                                          expr);
> +               free(perms);
>                 free(expr);
>                 if (rc !=3D 0) {
>                         goto exit;
> @@ -1682,7 +1688,7 @@ static char *avtab_node_to_str(struct policydb *pdb=
, avtab_key_t *key, avtab_dat
>  {
>         uint32_t data =3D datum->data;
>         type_datum_t *type;
> -       const char *flavor, *src, *tgt, *class, *perms, *new;
> +       const char *flavor, *src, *tgt, *class, *new;
>         char *rule =3D NULL, *permstring;
>
>         switch (0xFFF & key->specified) {
> @@ -1730,13 +1736,14 @@ static char *avtab_node_to_str(struct policydb *p=
db, avtab_key_t *key, avtab_dat
>         class =3D pdb->p_class_val_to_name[key->target_class - 1];
>
>         if (key->specified & AVTAB_AV) {
> -               perms =3D sepol_av_to_string(pdb, key->target_class, data=
);
> -               if (perms =3D=3D NULL) {
> +               permstring =3D sepol_av_to_string(pdb, key->target_class,=
 data);
> +               if (permstring =3D=3D NULL) {
>                         ERR(NULL, "Failed to generate permission string")=
;
>                         goto exit;
>                 }
>                 rule =3D create_str("%s %s %s:%s { %s };",
> -                                 flavor, src, tgt, class, perms+1);
> +                                 flavor, src, tgt, class, permstring+1);
> +               free(permstring);
>         } else if (key->specified & AVTAB_XPERMS) {
>                 permstring =3D sepol_extended_perms_to_string(datum->xper=
ms);
>                 if (permstring =3D=3D NULL) {
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index ee22dbbd..2ec66292 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -597,6 +597,7 @@ static int avrule_to_cil(int indent, struct policydb =
*pdb, uint32_t type, const
>                                         rule, src, tgt,
>                                         pdb->p_class_val_to_name[classper=
m->tclass - 1],
>                                         perms + 1);
> +                       free(perms);
>                 } else {
>                         cil_println(indent, "(%s %s %s %s %s)",
>                                         rule, src, tgt,
> @@ -1967,7 +1968,13 @@ static int constraints_to_cil(int indent, struct p=
olicydb *pdb, char *classkey,
>
>                 if (is_constraint) {
>                         perms =3D sepol_av_to_string(pdb, class->s.value,=
 node->permissions);
> +                       if (perms =3D=3D NULL) {
> +                               ERR(NULL, "Failed to generate permission =
string");
> +                               rc =3D -1;
> +                               goto exit;
> +                       }
>                         cil_println(indent, "(%sconstrain (%s (%s)) %s)",=
 mls, classkey, perms + 1, expr);
> +                       free(perms);
>                 } else {
>                         cil_println(indent, "(%svalidatetrans %s %s)", ml=
s, classkey, expr);
>                 }
> diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> index 0eeee7ec..e37221c8 100644
> --- a/libsepol/src/services.c
> +++ b/libsepol/src/services.c
> @@ -347,9 +347,11 @@ static char *get_class_info(sepol_security_class_t t=
class,
>                 p +=3D len;
>                 buf_used +=3D len;
>                 if (state_num < 2) {
> +                       char *permstr =3D sepol_av_to_string(policydb, tc=
lass, constraint->permissions);
> +
>                         len =3D snprintf(p, class_buf_len - buf_used, "{%=
s } (",
> -                       sepol_av_to_string(policydb, tclass,
> -                               constraint->permissions));
> +                                      permstr ?: "<format-failure>");
> +                       free(permstr);
>                 } else {
>                         len =3D snprintf(p, class_buf_len - buf_used, "("=
);
>                 }
> @@ -1234,7 +1236,7 @@ out:
>         return STATUS_ERR;
>  }
>
> - const char *sepol_av_perm_to_string(sepol_security_class_t tclass,
> +char *sepol_av_perm_to_string(sepol_security_class_t tclass,
>                                         sepol_access_vector_t av)
>  {
>         return sepol_av_to_string(policydb, tclass, av);
> diff --git a/libsepol/src/util.c b/libsepol/src/util.c
> index 2f877920..1d4f0005 100644
> --- a/libsepol/src/util.c
> +++ b/libsepol/src/util.c
> @@ -32,7 +32,7 @@
>
>  struct val_to_name {
>         unsigned int val;
> -       char *name;
> +       const char *name;
>  };
>
>  /* Add an unsigned integer to a dynamically reallocated array.  *cnt
> @@ -82,20 +82,26 @@ static int perm_name(hashtab_key_t key, hashtab_datum=
_t datum, void *data)
>         return 0;
>  }
>
> -char *sepol_av_to_string(policydb_t * policydbp, uint32_t tclass,
> +char *sepol_av_to_string(const policydb_t *policydbp, sepol_security_cla=
ss_t tclass,
>                          sepol_access_vector_t av)
>  {
>         struct val_to_name v;
> -       static char avbuf[1024];
> -       class_datum_t *cladatum;
> -       char *perm =3D NULL, *p;
> -       unsigned int i;
> +       const class_datum_t *cladatum =3D policydbp->class_val_to_struct[=
tclass - 1];
> +       uint32_t i;
>         int rc;
> -       int avlen =3D 0, len;
> +       char *buffer =3D NULL, *p;
> +       int len;
> +       size_t remaining, size =3D 64;
> +
> +retry:
> +       if (__builtin_mul_overflow(size, 2, &size))
> +               goto err;
> +       p =3D realloc(buffer, size);
> +       if (!p)
> +               goto err;
> +       buffer =3D p;
> +       remaining =3D size;
>
> -       memset(avbuf, 0, sizeof avbuf);
> -       cladatum =3D policydbp->class_val_to_struct[tclass - 1];
> -       p =3D avbuf;
>         for (i =3D 0; i < cladatum->permissions.nprim; i++) {
>                 if (av & (UINT32_C(1) << i)) {
>                         v.val =3D i + 1;
> @@ -106,22 +112,23 @@ char *sepol_av_to_string(policydb_t * policydbp, ui=
nt32_t tclass,
>                                                  permissions.table, perm_=
name,
>                                                  &v);
>                         }
> -                       if (rc)
> -                               perm =3D v.name;
> -                       if (perm) {
> -                               len =3D
> -                                   snprintf(p, sizeof(avbuf) - avlen, " =
%s",
> -                                            perm);
> -                               if (len < 0
> -                                   || (size_t) len >=3D (sizeof(avbuf) -=
 avlen))
> -                                       return NULL;
> +                       if (rc =3D=3D 1) {
> +                               len =3D snprintf(p, remaining, " %s", v.n=
ame);
> +                               if (len < 0)
> +                                       goto err;
> +                               if ((size_t) len >=3D remaining)
> +                                       goto retry;
>                                 p +=3D len;
> -                               avlen +=3D len;
> +                               remaining -=3D len;
>                         }
>                 }
>         }
>
> -       return avbuf;
> +       return buffer;
> +
> +err:
> +       free(buffer);
> +       return NULL;
>  }
>
>  #define next_bit_in_range(i, p) (((i) + 1 < sizeof(p)*8) && xperm_test((=
(i) + 1), p))
> diff --git a/libsepol/utils/sepol_compute_av.c b/libsepol/utils/sepol_com=
pute_av.c
> index d64dc31d..2ffc7a53 100644
> --- a/libsepol/utils/sepol_compute_av.c
> +++ b/libsepol/utils/sepol_compute_av.c
> @@ -49,12 +49,27 @@ int main(int argc, char *argv[])
>
>         rc =3D sepol_compute_av(ssid, tsid, tclass, 0, &avd);
>         switch (rc) {
> -       case 0:
> -               printf("allowed:    %s\n", sepol_av_perm_to_string(tclass=
, avd.allowed));
> -               printf("decided:    %s\n", sepol_av_perm_to_string(tclass=
, avd.decided));
> -               printf("auditallow: %s\n", sepol_av_perm_to_string(tclass=
, avd.auditallow));
> -               printf("auditdeny:  %s\n", sepol_av_perm_to_string(tclass=
, avd.auditdeny));
> +       case 0: {
> +               char *permstr;
> +
> +               permstr =3D sepol_av_perm_to_string(tclass, avd.allowed);
> +               printf("allowed:    %s\n", permstr ?: "<format-failure>")=
;
> +               free(permstr);
> +
> +               permstr =3D sepol_av_perm_to_string(tclass, avd.decided);
> +               printf("decided:    %s\n", permstr ?: "<format-failure>")=
;
> +               free(permstr);
> +
> +               permstr =3D sepol_av_perm_to_string(tclass, avd.auditallo=
w);
> +               printf("auditallow: %s\n", permstr ?: "<format-failure>")=
;
> +               free(permstr);
> +
> +               permstr =3D sepol_av_perm_to_string(tclass, avd.auditdeny=
);
> +               printf("auditdeny:  %s\n", permstr ?: "<format-failure>")=
;
> +               free(permstr);
> +
>                 break;
> +       }
>         case -EINVAL:
>                 printf("Invalid request\n");
>                 break;
> --
> 2.43.0
>
>
