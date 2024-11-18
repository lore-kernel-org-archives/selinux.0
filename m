Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4D736124
	for <selinux@vger.kernel.org>; Mon, 18 Nov 2024 20:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731960951; cv=none; b=Dj4c7zQpuVCQG0bNoT0CYwxMDk97j2n2wD16DQQK7IG4w2OEAOkxpAr/aYom4zOdtZyXfCjUS1YVqb5WIdagmI7h8e39JyNVRbX7hD8sqwXByFrbiqOkoMiZYEVaHxwdRSJB9CL2PgvhZ2Yfj20HaAncZnh+/pz6JLNgkK5n1uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731960951; c=relaxed/simple;
	bh=H2GZZ4XRpG12xodS1Rl9vZIKP5p/YdVHRuD7WjK1lvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a65h+YZk2372DtS1maLbwiqNZYPsm4anjWAWbWFcEPewAtSzc3z/HE28x/k4w/ef4bMAMc89Ge3BB4mZnQy+RvthYQWVICw1P8q5SrC/p24g73k2/kg4lzL2+4QfbwnbS5dINyEQ47m4RG3jkc3hgqaOkUBY+hinyqEoFA2cfaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JU+4P/HA; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JU+4P/HA"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5ebc52deca0so1235461eaf.3
        for <selinux@vger.kernel.org>; Mon, 18 Nov 2024 12:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731960948; x=1732565748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6EQBIgN1IdgX1kqmpMBiomAMJIdYf/LYhGwfJyHqiM=;
        b=JU+4P/HAWogvPXu5Clz/ESkK63v9pBOp73PS+TiOgHFNEEpi/zRb/A+gBFYV3I0aN6
         pmBp9HLBkaoyhESSoeJqLr6wEBszRHq7EkzWNh3hyK5E4v2u9GL7MdHuyg24w9XdT3qF
         gAYmmgYSouJuOG6ovn8Snzefs1KL5btDgRmJGTXqX6Rfoa73NhPvUf6fJ8jTmH+q2lzv
         a0kYzagrAMOGuLnopb6b2l6GxeSjQ5IWoF0oyIsWqmbEl1qhToiVQAmXMRltubB6EpMk
         DyzPPPjVv1kRbk4K6H/YII58T7ZixReo1qe52bCuJCCz4/8FRsM8avdrYQ356/hQlV8e
         GT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731960948; x=1732565748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6EQBIgN1IdgX1kqmpMBiomAMJIdYf/LYhGwfJyHqiM=;
        b=VucHWw8gcBNfM3lyEaHtY83CcF2M72+TAvUVnjDdA6kiyfC0EOFmJAw2NXxEd5Kmr7
         IPZnluFDaktMfTcYlUIL00zTSIs3QIFlGaQ6vQswCkMk0RA6iT+eu26I9lJR/PHgBTsm
         JS+pSbOLqk3EM65z9ID6bK4lF4DLQvFo9KgBjUHfR02FnfEjF20XPsrECq3EURQlzG8W
         LqwU8F0RTAMc4yc/UytwzrC7q47IJX0j6ljy0eHeLBPJRbDlJZTQkFt2W3jRiN1QLm9T
         HJ3KHSqLE6Da2T3OvGjjr15AAvKqG6XZY5fLkXEo/tpKTJ3YsCa2aB6JJ9UJaNCfmjkw
         m/Wg==
X-Gm-Message-State: AOJu0YzHorW4QoCXz+0DG8NDDq3J6MgsBV4kl7/iKKiQ4utPkCF+4BrZ
	1Vm2DSl4y34J68TsJRqyb95RH5VVqNMcv5kUHMHI0RyWuFtPGt0pGx1FYQHjnQzBdCegxsaIrLV
	t+P2AMLOG+KYrDHFgHcdKbqXkPZQQdg==
X-Google-Smtp-Source: AGHT+IGUlfONIq3fjVdCkw6WqEI+3veCSep/1OFo1YPDyyaoxS6oEv/MXlb44H9rMAJ4LJKE19qK7quWsaBSR0AG94Q=
X-Received: by 2002:a05:6830:f84:b0:718:41c6:821c with SMTP id
 46e09a7af769-71a778ff42amr12049420a34.5.1731960948195; Mon, 18 Nov 2024
 12:15:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111135107.20280-1-cgoettsche@seltendoof.de> <CAP+JOzTPxACZuPhNV48P4t1B+5-=x+gDNY-15EngAKUcQU8Sxg@mail.gmail.com>
In-Reply-To: <CAP+JOzTPxACZuPhNV48P4t1B+5-=x+gDNY-15EngAKUcQU8Sxg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 18 Nov 2024 15:15:37 -0500
Message-ID: <CAP+JOzSOaHbgG481u2WV+tT9_3L-bwFRTqLimB_=5FY_+5dymA@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] libsepol: misc assertion cleanup
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 2:36=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Nov 11, 2024 at 8:51=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Use const parameters where applicable to signal immutability.
> >
> > Rename the passed iterator avrule from avrule to narule, to make clear
> > its the neverallow rule to assert against, not the allow rule to check.
> >
> > Drop needless branch in check_assertions(), since in the case avrules i=
s
> > NULL the for loop won't execute and errors will stay at 0, so 0 will be
> > returned regardless. Also there is no call to free() as mentioned in th=
e
> > outdated comment.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these three patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

I meant six patches and all six have been merged.
Thanks,
Jim

> > ---
> > v3:
> >   - use C99 bool where applicable
> >   - minor additions
> > v2:
> >   add patch
> > ---
> >  libsepol/include/sepol/policydb/policydb.h |   4 +-
> >  libsepol/src/assertion.c                   | 222 ++++++++++-----------
> >  2 files changed, 107 insertions(+), 119 deletions(-)
> >
> > diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/incl=
ude/sepol/policydb/policydb.h
> > index f73e21fc..88fb3672 100644
> > --- a/libsepol/include/sepol/policydb/policydb.h
> > +++ b/libsepol/include/sepol/policydb/policydb.h
> > @@ -698,9 +698,9 @@ extern void level_datum_init(level_datum_t * x);
> >  extern void level_datum_destroy(level_datum_t * x);
> >  extern void cat_datum_init(cat_datum_t * x);
> >  extern void cat_datum_destroy(cat_datum_t * x);
> > -extern int check_assertion(policydb_t *p, avrule_t *avrule);
> > +extern int check_assertion(policydb_t *p, const avrule_t *avrule);
> >  extern int check_assertions(sepol_handle_t * handle,
> > -                           policydb_t * p, avrule_t * avrules);
> > +                           policydb_t * p, const avrule_t * avrules);
> >
> >  extern int symtab_insert(policydb_t * x, uint32_t sym,
> >                          hashtab_key_t key, hashtab_datum_t datum,
> > diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
> > index 5e129883..e0e8685f 100644
> > --- a/libsepol/src/assertion.c
> > +++ b/libsepol/src/assertion.c
> > @@ -20,6 +20,7 @@
> >   *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1=
301  USA
> >   */
> >
> > +#include <stdbool.h>
> >  #include <sepol/policydb/avtab.h>
> >  #include <sepol/policydb/policydb.h>
> >  #include <sepol/policydb/expand.h>
> > @@ -31,35 +32,31 @@
> >  struct avtab_match_args {
> >         sepol_handle_t *handle;
> >         policydb_t *p;
> > -       avrule_t *avrule;
> > +       const avrule_t *narule;
> >         avtab_t *avtab;
> >         unsigned long errors;
> >  };
> >
> > -static const char* policy_name(policydb_t *p) {
> > -       const char *policy_file =3D "policy.conf";
> > -       if (p->name) {
> > -               policy_file =3D p->name;
> > -       }
> > -       return policy_file;
> > +static const char* policy_name(const policydb_t *p) {
> > +       return p->name ?: "policy.conf";
> >  }
> >
> > -static void report_failure(sepol_handle_t *handle, policydb_t *p, cons=
t avrule_t *avrule,
> > +static void report_failure(sepol_handle_t *handle, const policydb_t *p=
, const avrule_t *narule,
> >                            unsigned int stype, unsigned int ttype,
> >                            const class_perm_node_t *curperm, uint32_t p=
erms)
> >  {
> >         char *permstr =3D sepol_av_to_string(p, curperm->tclass, perms)=
;
> >
> > -       if (avrule->source_filename) {
> > +       if (narule->source_filename) {
> >                 ERR(handle, "neverallow on line %lu of %s (or line %lu =
of %s) violated by allow %s %s:%s {%s };",
> > -                   avrule->source_line, avrule->source_filename, avrul=
e->line, policy_name(p),
> > +                   narule->source_line, narule->source_filename, narul=
e->line, policy_name(p),
> >                     p->p_type_val_to_name[stype],
> >                     p->p_type_val_to_name[ttype],
> >                     p->p_class_val_to_name[curperm->tclass - 1],
> >                     permstr ?: "<format-failure>");
> > -       } else if (avrule->line) {
> > +       } else if (narule->line) {
> >                 ERR(handle, "neverallow on line %lu violated by allow %=
s %s:%s {%s };",
> > -                   avrule->line, p->p_type_val_to_name[stype],
> > +                   narule->line, p->p_type_val_to_name[stype],
> >                     p->p_type_val_to_name[ttype],
> >                     p->p_class_val_to_name[curperm->tclass - 1],
> >                     permstr ?: "<format-failure>");
> > @@ -74,29 +71,29 @@ static void report_failure(sepol_handle_t *handle, =
policydb_t *p, const avrule_t
> >         free(permstr);
> >  }
> >
> > -static int match_any_class_permissions(class_perm_node_t *cp, uint32_t=
 class, uint32_t data)
> > +static bool match_any_class_permissions(const class_perm_node_t *cp, u=
int32_t class, uint32_t data)
> >  {
> >         for (; cp; cp =3D cp->next) {
> >                 if ((cp->tclass =3D=3D class) && (cp->data & data))
> > -                       return 1;
> > +                       return true;
> >         }
> >
> > -       return 0;
> > +       return false;
> >  }
> >
> > -static int extended_permissions_and(uint32_t *perms1, uint32_t *perms2=
) {
> > +static bool extended_permissions_and(const uint32_t *perms1, const uin=
t32_t *perms2) {
> >         size_t i;
> >         for (i =3D 0; i < EXTENDED_PERMS_LEN; i++) {
> >                 if (perms1[i] & perms2[i])
> > -                       return 1;
> > +                       return true;
> >         }
> >
> > -       return 0;
> > +       return false;
> >  }
> >
> > -static int check_extended_permissions(av_extended_perms_t *neverallow,=
 avtab_extended_perms_t *allow)
> > +static bool check_extended_permissions(const av_extended_perms_t *neve=
rallow, const avtab_extended_perms_t *allow)
> >  {
> > -       int rc =3D 0;
> > +       bool rc =3D false;
> >         if ((neverallow->specified =3D=3D AVRULE_XPERMS_IOCTLFUNCTION)
> >                         && (allow->specified =3D=3D AVTAB_XPERMS_IOCTLF=
UNCTION)) {
> >                 if (neverallow->driver =3D=3D allow->driver)
> > @@ -121,8 +118,8 @@ static int check_extended_permissions(av_extended_p=
erms_t *neverallow, avtab_ext
> >
> >  /* Compute which allowed extended permissions violate the neverallow r=
ule */
> >  static void extended_permissions_violated(avtab_extended_perms_t *resu=
lt,
> > -                                       av_extended_perms_t *neverallow=
,
> > -                                       avtab_extended_perms_t *allow)
> > +                                       const av_extended_perms_t *neve=
rallow,
> > +                                       const avtab_extended_perms_t *a=
llow)
> >  {
> >         size_t i;
> >         if ((neverallow->specified =3D=3D AVRULE_XPERMS_IOCTLFUNCTION)
> > @@ -157,21 +154,20 @@ static void extended_permissions_violated(avtab_e=
xtended_perms_t *result,
> >
> >  /* Same scenarios of interest as check_assertion_extended_permissions =
*/
> >  static int report_assertion_extended_permissions(sepol_handle_t *handl=
e,
> > -                               policydb_t *p, const avrule_t *avrule,
> > +                               policydb_t *p, const avrule_t *narule,
> >                                 unsigned int stype, unsigned int ttype,
> >                                 const class_perm_node_t *curperm, uint3=
2_t perms,
> > -                               avtab_key_t *k, avtab_t *avtab)
> > +                               const avtab_key_t *k, avtab_t *avtab)
> >  {
> >         avtab_ptr_t node;
> >         avtab_key_t tmp_key;
> >         avtab_extended_perms_t *xperms;
> >         avtab_extended_perms_t error;
> > -       ebitmap_t *sattr =3D &p->type_attr_map[stype];
> > -       ebitmap_t *tattr =3D &p->type_attr_map[ttype];
> > +       const ebitmap_t *sattr =3D &p->type_attr_map[stype];
> > +       const ebitmap_t *tattr =3D &p->type_attr_map[ttype];
> >         ebitmap_node_t *snode, *tnode;
> >         unsigned int i, j;
> > -       int rc;
> > -       int found_xperm =3D 0;
> > +       bool found_xperm =3D false;
> >         int errors =3D 0;
> >
> >         memcpy(&tmp_key, k, sizeof(avtab_key_t));
> > @@ -189,18 +185,17 @@ static int report_assertion_extended_permissions(=
sepol_handle_t *handle,
> >                                                 && (xperms->specified !=
=3D AVTAB_XPERMS_IOCTLDRIVER)
> >                                                 && (xperms->specified !=
=3D AVTAB_XPERMS_NLMSG))
> >                                         continue;
> > -                               found_xperm =3D 1;
> > -                               rc =3D check_extended_permissions(avrul=
e->xperms, xperms);
> > +                               found_xperm =3D true;
> >                                 /* failure on the extended permission c=
heck_extended_permissions */
> > -                               if (rc) {
> > +                               if (check_extended_permissions(narule->=
xperms, xperms)) {
> >                                         char *permstring;
> >
> > -                                       extended_permissions_violated(&=
error, avrule->xperms, xperms);
> > +                                       extended_permissions_violated(&=
error, narule->xperms, xperms);
> >                                         permstring =3D sepol_extended_p=
erms_to_string(&error);
> >
> >                                         ERR(handle, "neverallowxperm on=
 line %lu of %s (or line %lu of %s) violated by\n"
> >                                                         "allowxperm %s =
%s:%s %s;",
> > -                                                       avrule->source_=
line, avrule->source_filename, avrule->line, policy_name(p),
> > +                                                       narule->source_=
line, narule->source_filename, narule->line, policy_name(p),
> >                                                         p->p_type_val_t=
o_name[i],
> >                                                         p->p_type_val_t=
o_name[j],
> >                                                         p->p_class_val_=
to_name[curperm->tclass - 1],
> > @@ -219,7 +214,7 @@ static int report_assertion_extended_permissions(se=
pol_handle_t *handle,
> >
> >                 ERR(handle, "neverallowxperm on line %lu of %s (or line=
 %lu of %s) violated by\n"
> >                                 "allow %s %s:%s {%s };",
> > -                               avrule->source_line, avrule->source_fil=
ename, avrule->line, policy_name(p),
> > +                               narule->source_line, narule->source_fil=
ename, narule->line, policy_name(p),
> >                                 p->p_type_val_to_name[stype],
> >                                 p->p_type_val_to_name[ttype],
> >                                 p->p_class_val_to_name[curperm->tclass =
- 1],
> > @@ -240,26 +235,26 @@ static int report_assertion_avtab_matches(avtab_k=
ey_t *k, avtab_datum_t *d, void
> >         sepol_handle_t *handle =3D a->handle;
> >         policydb_t *p =3D a->p;
> >         avtab_t *avtab =3D a->avtab;
> > -       avrule_t *avrule =3D a->avrule;
> > -       class_perm_node_t *cp;
> > +       const avrule_t *narule =3D a->narule;
> > +       const class_perm_node_t *cp;
> >         uint32_t perms;
> >         ebitmap_t src_matches, tgt_matches, self_matches;
> >         ebitmap_node_t *snode, *tnode;
> >         unsigned int i, j;
> > -       const int is_avrule_self =3D (avrule->flags & RULE_SELF) !=3D 0=
;
> > -       const int is_avrule_notself =3D (avrule->flags & RULE_NOTSELF) =
!=3D 0;
> > +       const bool is_narule_self =3D (narule->flags & RULE_SELF) !=3D =
0;
> > +       const bool is_narule_notself =3D (narule->flags & RULE_NOTSELF)=
 !=3D 0;
> >
> >         if ((k->specified & AVTAB_ALLOWED) =3D=3D 0)
> >                 return 0;
> >
> > -       if (!match_any_class_permissions(avrule->perms, k->target_class=
, d->data))
> > +       if (!match_any_class_permissions(narule->perms, k->target_class=
, d->data))
> >                 return 0;
> >
> >         ebitmap_init(&src_matches);
> >         ebitmap_init(&tgt_matches);
> >         ebitmap_init(&self_matches);
> >
> > -       rc =3D ebitmap_and(&src_matches, &avrule->stypes.types,
> > +       rc =3D ebitmap_and(&src_matches, &narule->stypes.types,
> >                          &p->attr_type_map[k->source_type - 1]);
> >         if (rc < 0)
> >                 goto oom;
> > @@ -267,22 +262,22 @@ static int report_assertion_avtab_matches(avtab_k=
ey_t *k, avtab_datum_t *d, void
> >         if (ebitmap_is_empty(&src_matches))
> >                 goto exit;
> >
> > -       if (is_avrule_notself) {
> > -               if (ebitmap_is_empty(&avrule->ttypes.types)) {
> > +       if (is_narule_notself) {
> > +               if (ebitmap_is_empty(&narule->ttypes.types)) {
> >                         /* avrule tgt is of the form ~self */
> >                         rc =3D ebitmap_cpy(&tgt_matches, &p->attr_type_=
map[k->target_type -1]);
> >                 } else {
> >                         /* avrule tgt is of the form {ATTR -self} */
> > -                       rc =3D ebitmap_and(&tgt_matches, &avrule->ttype=
s.types, &p->attr_type_map[k->target_type - 1]);
> > +                       rc =3D ebitmap_and(&tgt_matches, &narule->ttype=
s.types, &p->attr_type_map[k->target_type - 1]);
> >                 }
> >                 if (rc)
> >                         goto oom;
> >         } else {
> > -               rc =3D ebitmap_and(&tgt_matches, &avrule->ttypes.types,=
 &p->attr_type_map[k->target_type -1]);
> > +               rc =3D ebitmap_and(&tgt_matches, &narule->ttypes.types,=
 &p->attr_type_map[k->target_type -1]);
> >                 if (rc < 0)
> >                         goto oom;
> >
> > -               if (is_avrule_self) {
> > +               if (is_narule_self) {
> >                         rc =3D ebitmap_and(&self_matches, &src_matches,=
 &p->attr_type_map[k->target_type - 1]);
> >                         if (rc < 0)
> >                                 goto oom;
> > @@ -298,7 +293,7 @@ static int report_assertion_avtab_matches(avtab_key=
_t *k, avtab_datum_t *d, void
> >         if (ebitmap_is_empty(&tgt_matches))
> >                 goto exit;
> >
> > -       for (cp =3D avrule->perms; cp; cp =3D cp->next) {
> > +       for (cp =3D narule->perms; cp; cp =3D cp->next) {
> >
> >                 perms =3D cp->data & d->data;
> >                 if ((cp->tclass !=3D k->target_class) || !perms) {
> > @@ -307,16 +302,16 @@ static int report_assertion_avtab_matches(avtab_k=
ey_t *k, avtab_datum_t *d, void
> >
> >                 ebitmap_for_each_positive_bit(&src_matches, snode, i) {
> >                         ebitmap_for_each_positive_bit(&tgt_matches, tno=
de, j) {
> > -                               if (is_avrule_self && i !=3D j)
> > +                               if (is_narule_self && i !=3D j)
> >                                         continue;
> > -                               if (is_avrule_notself && i =3D=3D j)
> > +                               if (is_narule_notself && i =3D=3D j)
> >                                         continue;
> > -                               if (avrule->specified =3D=3D AVRULE_XPE=
RMS_NEVERALLOW) {
> > -                                       a->errors +=3D report_assertion=
_extended_permissions(handle,p, avrule,
> > +                               if (narule->specified =3D=3D AVRULE_XPE=
RMS_NEVERALLOW) {
> > +                                       a->errors +=3D report_assertion=
_extended_permissions(handle,p, narule,
> >                                                                        =
                 i, j, cp, perms, k, avtab);
> >                                 } else {
> >                                         a->errors++;
> > -                                       report_failure(handle, p, avrul=
e, i, j, cp, perms);
> > +                                       report_failure(handle, p, narul=
e, i, j, cp, perms);
> >                                 }
> >                         }
> >                 }
> > @@ -330,22 +325,22 @@ exit:
> >         return rc;
> >  }
> >
> > -static int report_assertion_failures(sepol_handle_t *handle, policydb_=
t *p, avrule_t *avrule)
> > +static int report_assertion_failures(sepol_handle_t *handle, policydb_=
t *p, const avrule_t *narule)
> >  {
> >         int rc;
> > -       struct avtab_match_args args;
> > -
> > -       args.handle =3D handle;
> > -       args.p =3D p;
> > -       args.avrule =3D avrule;
> > -       args.errors =3D 0;
> > +       struct avtab_match_args args =3D {
> > +               .handle =3D handle,
> > +               .p =3D p,
> > +               .narule =3D narule,
> > +               .errors =3D 0,
> > +       };
> >
> > -       args.avtab =3D  &p->te_avtab;
> > +       args.avtab =3D &p->te_avtab;
> >         rc =3D avtab_map(&p->te_avtab, report_assertion_avtab_matches, =
&args);
> >         if (rc < 0)
> >                 goto oom;
> >
> > -       args.avtab =3D  &p->te_cond_avtab;
> > +       args.avtab =3D &p->te_cond_avtab;
> >         rc =3D avtab_map(&p->te_cond_avtab, report_assertion_avtab_matc=
hes, &args);
> >         if (rc < 0)
> >                 goto oom;
> > @@ -360,19 +355,19 @@ oom:
> >   * Look up the extended permissions in avtab and verify that neverallo=
wed
> >   * permissions are not granted.
> >   */
> > -static int check_assertion_extended_permissions_avtab(avrule_t *avrule=
, avtab_t *avtab,
> > +static bool check_assertion_extended_permissions_avtab(const avrule_t =
*narule, avtab_t *avtab,
> >                                                 unsigned int stype, uns=
igned int ttype,
> > -                                               avtab_key_t *k, policyd=
b_t *p)
> > +                                               const avtab_key_t *k, p=
olicydb_t *p)
> >  {
> >         avtab_ptr_t node;
> >         avtab_key_t tmp_key;
> > -       avtab_extended_perms_t *xperms;
> > -       av_extended_perms_t *neverallow_xperms =3D avrule->xperms;
> > -       ebitmap_t *sattr =3D &p->type_attr_map[stype];
> > -       ebitmap_t *tattr =3D &p->type_attr_map[ttype];
> > +       const avtab_extended_perms_t *xperms;
> > +       const av_extended_perms_t *neverallow_xperms =3D narule->xperms=
;
> > +       const ebitmap_t *sattr =3D &p->type_attr_map[stype];
> > +       const ebitmap_t *tattr =3D &p->type_attr_map[ttype];
> >         ebitmap_node_t *snode, *tnode;
> >         unsigned int i, j;
> > -       int rc =3D 1;
> > +       bool ret =3D true;
> >
> >         memcpy(&tmp_key, k, sizeof(avtab_key_t));
> >         tmp_key.specified =3D AVTAB_XPERMS_ALLOWED;
> > @@ -390,14 +385,14 @@ static int check_assertion_extended_permissions_a=
vtab(avrule_t *avrule, avtab_t
> >                                                 && (xperms->specified !=
=3D AVTAB_XPERMS_IOCTLDRIVER)
> >                                                 && (xperms->specified !=
=3D AVTAB_XPERMS_NLMSG))
> >                                         continue;
> > -                               rc =3D check_extended_permissions(never=
allow_xperms, xperms);
> > -                               if (rc)
> > -                                       return rc;
> > +                               ret =3D check_extended_permissions(neve=
rallow_xperms, xperms);
> > +                               if (ret)
> > +                                       return ret;
> >                         }
> >                 }
> >         }
> >
> > -       return rc;
> > +       return ret;
> >  }
> >
> >  /*
> > @@ -416,21 +411,21 @@ static int check_assertion_extended_permissions_a=
vtab(avrule_t *avrule, avtab_t
> >   * 4. FAIL - The ioctl permission is granted AND the extended permissi=
on is
> >   *    granted
> >   */
> > -static int check_assertion_extended_permissions(avrule_t *avrule, avta=
b_t *avtab,
> > -                                               avtab_key_t *k, policyd=
b_t *p)
> > +static int check_assertion_extended_permissions(const avrule_t *narule=
, avtab_t *avtab,
> > +                                               const avtab_key_t *k, p=
olicydb_t *p)
> >  {
> >         ebitmap_t src_matches, tgt_matches, self_matches;
> >         unsigned int i, j;
> >         ebitmap_node_t *snode, *tnode;
> > -       const int is_avrule_self =3D (avrule->flags & RULE_SELF) !=3D 0=
;
> > -       const int is_avrule_notself =3D (avrule->flags & RULE_NOTSELF) =
!=3D 0;
> > +       const bool is_narule_self =3D (narule->flags & RULE_SELF) !=3D =
0;
> > +       const bool is_narule_notself =3D (narule->flags & RULE_NOTSELF)=
 !=3D 0;
> >         int rc;
> >
> >         ebitmap_init(&src_matches);
> >         ebitmap_init(&tgt_matches);
> >         ebitmap_init(&self_matches);
> >
> > -       rc =3D ebitmap_and(&src_matches, &avrule->stypes.types,
> > +       rc =3D ebitmap_and(&src_matches, &narule->stypes.types,
> >                          &p->attr_type_map[k->source_type - 1]);
> >         if (rc < 0)
> >                 goto oom;
> > @@ -440,22 +435,22 @@ static int check_assertion_extended_permissions(a=
vrule_t *avrule, avtab_t *avtab
> >                 goto exit;
> >         }
> >
> > -       if (is_avrule_notself) {
> > -               if (ebitmap_is_empty(&avrule->ttypes.types)) {
> > +       if (is_narule_notself) {
> > +               if (ebitmap_is_empty(&narule->ttypes.types)) {
> >                         /* avrule tgt is of the form ~self */
> >                         rc =3D ebitmap_cpy(&tgt_matches, &p->attr_type_=
map[k->target_type -1]);
> >                 } else {
> >                         /* avrule tgt is of the form {ATTR -self} */
> > -                       rc =3D ebitmap_and(&tgt_matches, &avrule->ttype=
s.types, &p->attr_type_map[k->target_type - 1]);
> > +                       rc =3D ebitmap_and(&tgt_matches, &narule->ttype=
s.types, &p->attr_type_map[k->target_type - 1]);
> >                 }
> >                 if (rc < 0)
> >                         goto oom;
> >         } else {
> > -               rc =3D ebitmap_and(&tgt_matches, &avrule->ttypes.types,=
 &p->attr_type_map[k->target_type -1]);
> > +               rc =3D ebitmap_and(&tgt_matches, &narule->ttypes.types,=
 &p->attr_type_map[k->target_type -1]);
> >                 if (rc < 0)
> >                         goto oom;
> >
> > -               if (is_avrule_self) {
> > +               if (is_narule_self) {
> >                         rc =3D ebitmap_and(&self_matches, &src_matches,=
 &p->attr_type_map[k->target_type - 1]);
> >                         if (rc < 0)
> >                                 goto oom;
> > @@ -475,11 +470,11 @@ static int check_assertion_extended_permissions(a=
vrule_t *avrule, avtab_t *avtab
> >
> >         ebitmap_for_each_positive_bit(&src_matches, snode, i) {
> >                 ebitmap_for_each_positive_bit(&tgt_matches, tnode, j) {
> > -                       if (is_avrule_self && i !=3D j)
> > +                       if (is_narule_self && i !=3D j)
> >                                 continue;
> > -                       if (is_avrule_notself && i =3D=3D j)
> > +                       if (is_narule_notself && i =3D=3D j)
> >                                 continue;
> > -                       if (check_assertion_extended_permissions_avtab(=
avrule, avtab, i, j, k, p)) {
> > +                       if (check_assertion_extended_permissions_avtab(=
narule, avtab, i, j, k, p)) {
> >                                 rc =3D 1;
> >                                 goto exit;
> >                         }
> > @@ -496,7 +491,7 @@ exit:
> >         return rc;
> >  }
> >
> > -static int check_assertion_notself_match(avtab_key_t *k, avrule_t *avr=
ule, policydb_t *p)
> > +static int check_assertion_notself_match(const avtab_key_t *k, const a=
vrule_t *narule, policydb_t *p)
> >  {
> >         ebitmap_t src_matches, tgt_matches;
> >         unsigned int num_src_matches, num_tgt_matches;
> > @@ -505,16 +500,16 @@ static int check_assertion_notself_match(avtab_ke=
y_t *k, avrule_t *avrule, polic
> >         ebitmap_init(&src_matches);
> >         ebitmap_init(&tgt_matches);
> >
> > -       rc =3D ebitmap_and(&src_matches, &avrule->stypes.types, &p->att=
r_type_map[k->source_type - 1]);
> > +       rc =3D ebitmap_and(&src_matches, &narule->stypes.types, &p->att=
r_type_map[k->source_type - 1]);
> >         if (rc < 0)
> >                 goto oom;
> >
> > -       if (ebitmap_is_empty(&avrule->ttypes.types)) {
> > +       if (ebitmap_is_empty(&narule->ttypes.types)) {
> >                 /* avrule tgt is of the form ~self */
> >                 rc =3D ebitmap_cpy(&tgt_matches, &p->attr_type_map[k->t=
arget_type - 1]);
> >         } else {
> >                 /* avrule tgt is of the form {ATTR -self} */
> > -               rc =3D ebitmap_and(&tgt_matches, &avrule->ttypes.types,=
 &p->attr_type_map[k->target_type - 1]);
> > +               rc =3D ebitmap_and(&tgt_matches, &narule->ttypes.types,=
 &p->attr_type_map[k->target_type - 1]);
> >         }
> >         if (rc < 0)
> >                 goto oom;
> > @@ -551,7 +546,7 @@ nomatch:
> >         return rc;
> >  }
> >
> > -static int check_assertion_self_match(avtab_key_t *k, avrule_t *avrule=
, policydb_t *p)
> > +static int check_assertion_self_match(const avtab_key_t *k, const avru=
le_t *narule, policydb_t *p)
> >  {
> >         ebitmap_t src_matches;
> >         int rc;
> > @@ -560,7 +555,7 @@ static int check_assertion_self_match(avtab_key_t *=
k, avrule_t *avrule, policydb
> >          * and the key's source.
> >          */
> >
> > -       rc =3D ebitmap_and(&src_matches, &avrule->stypes.types, &p->att=
r_type_map[k->source_type - 1]);
> > +       rc =3D ebitmap_and(&src_matches, &narule->stypes.types, &p->att=
r_type_map[k->source_type - 1]);
> >         if (rc < 0)
> >                 goto oom;
> >
> > @@ -582,29 +577,29 @@ static int check_assertion_avtab_match(avtab_key_=
t *k, avtab_datum_t *d, void *a
> >         int rc;
> >         struct avtab_match_args *a =3D (struct avtab_match_args *)args;
> >         policydb_t *p =3D a->p;
> > -       avrule_t *avrule =3D a->avrule;
> > +       const avrule_t *narule =3D a->narule;
> >         avtab_t *avtab =3D a->avtab;
> >
> >         if ((k->specified & AVTAB_ALLOWED) =3D=3D 0)
> >                 goto nomatch;
> >
> > -       if (!match_any_class_permissions(avrule->perms, k->target_class=
, d->data))
> > +       if (!match_any_class_permissions(narule->perms, k->target_class=
, d->data))
> >                 goto nomatch;
> >
> > -       if (!ebitmap_match_any(&avrule->stypes.types, &p->attr_type_map=
[k->source_type - 1]))
> > +       if (!ebitmap_match_any(&narule->stypes.types, &p->attr_type_map=
[k->source_type - 1]))
> >                 goto nomatch;
> >
> > -       if (avrule->flags & RULE_NOTSELF) {
> > -               rc =3D check_assertion_notself_match(k, avrule, p);
> > +       if (narule->flags & RULE_NOTSELF) {
> > +               rc =3D check_assertion_notself_match(k, narule, p);
> >                 if (rc < 0)
> >                         goto oom;
> >                 if (rc =3D=3D 0)
> >                         goto nomatch;
> >         } else {
> >                 /* neverallow may have tgts even if it uses SELF */
> > -               if (!ebitmap_match_any(&avrule->ttypes.types, &p->attr_=
type_map[k->target_type -1])) {
> > -                       if (avrule->flags =3D=3D RULE_SELF) {
> > -                               rc =3D check_assertion_self_match(k, av=
rule, p);
> > +               if (!ebitmap_match_any(&narule->ttypes.types, &p->attr_=
type_map[k->target_type -1])) {
> > +                       if (narule->flags =3D=3D RULE_SELF) {
> > +                               rc =3D check_assertion_self_match(k, na=
rule, p);
> >                                 if (rc < 0)
> >                                         goto oom;
> >                                 if (rc =3D=3D 0)
> > @@ -615,8 +610,8 @@ static int check_assertion_avtab_match(avtab_key_t =
*k, avtab_datum_t *d, void *a
> >                 }
> >         }
> >
> > -       if (avrule->specified =3D=3D AVRULE_XPERMS_NEVERALLOW) {
> > -               rc =3D check_assertion_extended_permissions(avrule, avt=
ab, k, p);
> > +       if (narule->specified =3D=3D AVRULE_XPERMS_NEVERALLOW) {
> > +               rc =3D check_assertion_extended_permissions(narule, avt=
ab, k, p);
> >                 if (rc < 0)
> >                         goto oom;
> >                 if (rc =3D=3D 0)
> > @@ -631,17 +626,17 @@ oom:
> >         return rc;
> >  }
> >
> > -int check_assertion(policydb_t *p, avrule_t *avrule)
> > +int check_assertion(policydb_t *p, const avrule_t *narule)
> >  {
> >         int rc;
> > -       struct avtab_match_args args;
> > +       struct avtab_match_args args =3D {
> > +               .handle =3D NULL,
> > +               .p =3D p,
> > +               .narule =3D narule,
> > +               .errors =3D 0,
> > +       };
> >
> > -       args.handle =3D NULL;
> > -       args.p =3D p;
> > -       args.avrule =3D avrule;
> > -       args.errors =3D 0;
> >         args.avtab =3D &p->te_avtab;
> > -
> >         rc =3D avtab_map(&p->te_avtab, check_assertion_avtab_match, &ar=
gs);
> >
> >         if (rc =3D=3D 0) {
> > @@ -653,20 +648,13 @@ int check_assertion(policydb_t *p, avrule_t *avru=
le)
> >  }
> >
> >  int check_assertions(sepol_handle_t * handle, policydb_t * p,
> > -                    avrule_t * avrules)
> > +                    const avrule_t * narules)
> >  {
> >         int rc;
> > -       avrule_t *a;
> > +       const avrule_t *a;
> >         unsigned long errors =3D 0;
> >
> > -       if (!avrules) {
> > -               /* Since assertions are stored in avrules, if it is NUL=
L
> > -                  there won't be any to check. This also prevents an i=
nvalid
> > -                  free if the avtabs are never initialized */
> > -               return 0;
> > -       }
> > -
> > -       for (a =3D avrules; a !=3D NULL; a =3D a->next) {
> > +       for (a =3D narules; a !=3D NULL; a =3D a->next) {
> >                 if (!(a->specified & (AVRULE_NEVERALLOW | AVRULE_XPERMS=
_NEVERALLOW)))
> >                         continue;
> >                 rc =3D check_assertion(p, a);
> > --
> > 2.45.2
> >
> >
