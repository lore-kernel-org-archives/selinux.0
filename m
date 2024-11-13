Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99BE2038DD
	for <selinux@vger.kernel.org>; Wed, 13 Nov 2024 19:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731526583; cv=none; b=ZLAfUx04aObgdUF9M7KPTzaC4SQcfreKn8DrvJ/ubSEUHtTqvU7FDNWM/4SBNm4xnnRQbn4t2s7k+9gxwv3hqSdUkwRCcLD45W11L5gs5EoPOMWu4NUsTzUu1OwLEtWPRMk2qhFFk0GPzZMaxjZL8+aKuIBfItn42ZcIEF7ceAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731526583; c=relaxed/simple;
	bh=WzxBrhlwjAb+P8pi093CsK6gPJhWhjvfru2dkuepp9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q/aYmUAEOxNmw2E7Ah6kYFVw/D5BinaRHlut0Z4DGqFwVUECILZR9vGN8CpjiNKD9rS6M0c1U7R1VXzvgmC1FSNeHd+BNhh4QEmukP1OLlwfqV1LAYWkrwgvB5ZDsPb3PKW9ffYpHp5LDiKCQkGZbOw9SurqnaTizs79nKrAOpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjJa595k; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjJa595k"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-85019a60523so2602812241.1
        for <selinux@vger.kernel.org>; Wed, 13 Nov 2024 11:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731526578; x=1732131378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMeqBcvGRt3BsNF+yHy7oU60fPJ5WLnJyGygrSRdrjg=;
        b=NjJa595k16Xw2yNp1Zlo+tgIiV5sJy6CjnOtZD50BrresJUlEiLBqoCIcCmy3qYOcm
         kM6VNBz4pngOQD8tsjH8iynYqMlFsTupJ2XogZwqsjE8sjknViPN8MW7EwIkKADpsK0n
         ry9qpui5QNJg0VDjF9580x0/tdA7ETNBZENTxH/94sZ4LhMQAhoPJDHDZeijmdvzBLSK
         lQ+0UQoq4/LCLZBNn4QGW6qzw2vNmo11/sg2XJ2OcpTcL/31+1jNot20ZPbjhkdPH7C3
         daK9Wusa09uJxLRpPzMXSZI85EFsKdPaolSX7VQRcGuT3mS+y2+VhVLM8S01DzVC0/s2
         TejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731526578; x=1732131378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TMeqBcvGRt3BsNF+yHy7oU60fPJ5WLnJyGygrSRdrjg=;
        b=Jse1rtlsFTqQLvUpTgyTgG7JpdEZnO7H2Vba7PLL7F7GLibekzKTXDkbDdlDNsC8of
         ZA6LuNIRtT1/jYMYGg+PSwgtXg7Le77thXe3qgWqaipT+b6ikXbA6AazxywgLh9WX6Ev
         3cOT6vz4gBOHZHR9AeQyzIgc3zkFdL7v28wR/XUw+xP9ME3qdtzM+04FBN+aTr/uXlcd
         mXOHbNjC6vg7kGIEvBOkV57c2Nts3uX4yz7A0iUbmd+lUI2uJWmzC+F3ahOjdQN67f87
         w3RYui5zy/6dCXXiEOy/fi2RAvwoqtg5vGXvtuor0vDQ/kgBALdUlvthzBoQNZwwhWnq
         wjaw==
X-Gm-Message-State: AOJu0YxC+lrvQ+C26ykJFBF7xAtumG6KC3PPdyVPxADiRIpcFdc1jZd1
	OKoCiAbswgtoKqyuS0j09FZKnikSZfmcI+CQhhLVjRIoI06+gvoodrwYR2+UrJ3SsOM6A1oys6G
	AEUtLhXlcAM5ggnVW0CRhTJe/K/o=
X-Google-Smtp-Source: AGHT+IGZO+U6OCrzzvHGbSVnG2RP2ccMIXixRWGeNkGxF/DpV/KpNEXUqU+1CTqZEc7vVdyoLmIpcaMI5c7Fz5myI+c=
X-Received: by 2002:a05:6102:3f09:b0:4a9:15c:ef8 with SMTP id
 ada2fe7eead31-4aae1672194mr20696601137.24.1731526577477; Wed, 13 Nov 2024
 11:36:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111135107.20280-1-cgoettsche@seltendoof.de>
In-Reply-To: <20241111135107.20280-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 13 Nov 2024 14:36:06 -0500
Message-ID: <CAP+JOzTPxACZuPhNV48P4t1B+5-=x+gDNY-15EngAKUcQU8Sxg@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] libsepol: misc assertion cleanup
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 8:51=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Use const parameters where applicable to signal immutability.
>
> Rename the passed iterator avrule from avrule to narule, to make clear
> its the neverallow rule to assert against, not the allow rule to check.
>
> Drop needless branch in check_assertions(), since in the case avrules is
> NULL the for loop won't execute and errors will stay at 0, so 0 will be
> returned regardless. Also there is no call to free() as mentioned in the
> outdated comment.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these three patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v3:
>   - use C99 bool where applicable
>   - minor additions
> v2:
>   add patch
> ---
>  libsepol/include/sepol/policydb/policydb.h |   4 +-
>  libsepol/src/assertion.c                   | 222 ++++++++++-----------
>  2 files changed, 107 insertions(+), 119 deletions(-)
>
> diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/includ=
e/sepol/policydb/policydb.h
> index f73e21fc..88fb3672 100644
> --- a/libsepol/include/sepol/policydb/policydb.h
> +++ b/libsepol/include/sepol/policydb/policydb.h
> @@ -698,9 +698,9 @@ extern void level_datum_init(level_datum_t * x);
>  extern void level_datum_destroy(level_datum_t * x);
>  extern void cat_datum_init(cat_datum_t * x);
>  extern void cat_datum_destroy(cat_datum_t * x);
> -extern int check_assertion(policydb_t *p, avrule_t *avrule);
> +extern int check_assertion(policydb_t *p, const avrule_t *avrule);
>  extern int check_assertions(sepol_handle_t * handle,
> -                           policydb_t * p, avrule_t * avrules);
> +                           policydb_t * p, const avrule_t * avrules);
>
>  extern int symtab_insert(policydb_t * x, uint32_t sym,
>                          hashtab_key_t key, hashtab_datum_t datum,
> diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
> index 5e129883..e0e8685f 100644
> --- a/libsepol/src/assertion.c
> +++ b/libsepol/src/assertion.c
> @@ -20,6 +20,7 @@
>   *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-130=
1  USA
>   */
>
> +#include <stdbool.h>
>  #include <sepol/policydb/avtab.h>
>  #include <sepol/policydb/policydb.h>
>  #include <sepol/policydb/expand.h>
> @@ -31,35 +32,31 @@
>  struct avtab_match_args {
>         sepol_handle_t *handle;
>         policydb_t *p;
> -       avrule_t *avrule;
> +       const avrule_t *narule;
>         avtab_t *avtab;
>         unsigned long errors;
>  };
>
> -static const char* policy_name(policydb_t *p) {
> -       const char *policy_file =3D "policy.conf";
> -       if (p->name) {
> -               policy_file =3D p->name;
> -       }
> -       return policy_file;
> +static const char* policy_name(const policydb_t *p) {
> +       return p->name ?: "policy.conf";
>  }
>
> -static void report_failure(sepol_handle_t *handle, policydb_t *p, const =
avrule_t *avrule,
> +static void report_failure(sepol_handle_t *handle, const policydb_t *p, =
const avrule_t *narule,
>                            unsigned int stype, unsigned int ttype,
>                            const class_perm_node_t *curperm, uint32_t per=
ms)
>  {
>         char *permstr =3D sepol_av_to_string(p, curperm->tclass, perms);
>
> -       if (avrule->source_filename) {
> +       if (narule->source_filename) {
>                 ERR(handle, "neverallow on line %lu of %s (or line %lu of=
 %s) violated by allow %s %s:%s {%s };",
> -                   avrule->source_line, avrule->source_filename, avrule-=
>line, policy_name(p),
> +                   narule->source_line, narule->source_filename, narule-=
>line, policy_name(p),
>                     p->p_type_val_to_name[stype],
>                     p->p_type_val_to_name[ttype],
>                     p->p_class_val_to_name[curperm->tclass - 1],
>                     permstr ?: "<format-failure>");
> -       } else if (avrule->line) {
> +       } else if (narule->line) {
>                 ERR(handle, "neverallow on line %lu violated by allow %s =
%s:%s {%s };",
> -                   avrule->line, p->p_type_val_to_name[stype],
> +                   narule->line, p->p_type_val_to_name[stype],
>                     p->p_type_val_to_name[ttype],
>                     p->p_class_val_to_name[curperm->tclass - 1],
>                     permstr ?: "<format-failure>");
> @@ -74,29 +71,29 @@ static void report_failure(sepol_handle_t *handle, po=
licydb_t *p, const avrule_t
>         free(permstr);
>  }
>
> -static int match_any_class_permissions(class_perm_node_t *cp, uint32_t c=
lass, uint32_t data)
> +static bool match_any_class_permissions(const class_perm_node_t *cp, uin=
t32_t class, uint32_t data)
>  {
>         for (; cp; cp =3D cp->next) {
>                 if ((cp->tclass =3D=3D class) && (cp->data & data))
> -                       return 1;
> +                       return true;
>         }
>
> -       return 0;
> +       return false;
>  }
>
> -static int extended_permissions_and(uint32_t *perms1, uint32_t *perms2) =
{
> +static bool extended_permissions_and(const uint32_t *perms1, const uint3=
2_t *perms2) {
>         size_t i;
>         for (i =3D 0; i < EXTENDED_PERMS_LEN; i++) {
>                 if (perms1[i] & perms2[i])
> -                       return 1;
> +                       return true;
>         }
>
> -       return 0;
> +       return false;
>  }
>
> -static int check_extended_permissions(av_extended_perms_t *neverallow, a=
vtab_extended_perms_t *allow)
> +static bool check_extended_permissions(const av_extended_perms_t *nevera=
llow, const avtab_extended_perms_t *allow)
>  {
> -       int rc =3D 0;
> +       bool rc =3D false;
>         if ((neverallow->specified =3D=3D AVRULE_XPERMS_IOCTLFUNCTION)
>                         && (allow->specified =3D=3D AVTAB_XPERMS_IOCTLFUN=
CTION)) {
>                 if (neverallow->driver =3D=3D allow->driver)
> @@ -121,8 +118,8 @@ static int check_extended_permissions(av_extended_per=
ms_t *neverallow, avtab_ext
>
>  /* Compute which allowed extended permissions violate the neverallow rul=
e */
>  static void extended_permissions_violated(avtab_extended_perms_t *result=
,
> -                                       av_extended_perms_t *neverallow,
> -                                       avtab_extended_perms_t *allow)
> +                                       const av_extended_perms_t *nevera=
llow,
> +                                       const avtab_extended_perms_t *all=
ow)
>  {
>         size_t i;
>         if ((neverallow->specified =3D=3D AVRULE_XPERMS_IOCTLFUNCTION)
> @@ -157,21 +154,20 @@ static void extended_permissions_violated(avtab_ext=
ended_perms_t *result,
>
>  /* Same scenarios of interest as check_assertion_extended_permissions */
>  static int report_assertion_extended_permissions(sepol_handle_t *handle,
> -                               policydb_t *p, const avrule_t *avrule,
> +                               policydb_t *p, const avrule_t *narule,
>                                 unsigned int stype, unsigned int ttype,
>                                 const class_perm_node_t *curperm, uint32_=
t perms,
> -                               avtab_key_t *k, avtab_t *avtab)
> +                               const avtab_key_t *k, avtab_t *avtab)
>  {
>         avtab_ptr_t node;
>         avtab_key_t tmp_key;
>         avtab_extended_perms_t *xperms;
>         avtab_extended_perms_t error;
> -       ebitmap_t *sattr =3D &p->type_attr_map[stype];
> -       ebitmap_t *tattr =3D &p->type_attr_map[ttype];
> +       const ebitmap_t *sattr =3D &p->type_attr_map[stype];
> +       const ebitmap_t *tattr =3D &p->type_attr_map[ttype];
>         ebitmap_node_t *snode, *tnode;
>         unsigned int i, j;
> -       int rc;
> -       int found_xperm =3D 0;
> +       bool found_xperm =3D false;
>         int errors =3D 0;
>
>         memcpy(&tmp_key, k, sizeof(avtab_key_t));
> @@ -189,18 +185,17 @@ static int report_assertion_extended_permissions(se=
pol_handle_t *handle,
>                                                 && (xperms->specified !=
=3D AVTAB_XPERMS_IOCTLDRIVER)
>                                                 && (xperms->specified !=
=3D AVTAB_XPERMS_NLMSG))
>                                         continue;
> -                               found_xperm =3D 1;
> -                               rc =3D check_extended_permissions(avrule-=
>xperms, xperms);
> +                               found_xperm =3D true;
>                                 /* failure on the extended permission che=
ck_extended_permissions */
> -                               if (rc) {
> +                               if (check_extended_permissions(narule->xp=
erms, xperms)) {
>                                         char *permstring;
>
> -                                       extended_permissions_violated(&er=
ror, avrule->xperms, xperms);
> +                                       extended_permissions_violated(&er=
ror, narule->xperms, xperms);
>                                         permstring =3D sepol_extended_per=
ms_to_string(&error);
>
>                                         ERR(handle, "neverallowxperm on l=
ine %lu of %s (or line %lu of %s) violated by\n"
>                                                         "allowxperm %s %s=
:%s %s;",
> -                                                       avrule->source_li=
ne, avrule->source_filename, avrule->line, policy_name(p),
> +                                                       narule->source_li=
ne, narule->source_filename, narule->line, policy_name(p),
>                                                         p->p_type_val_to_=
name[i],
>                                                         p->p_type_val_to_=
name[j],
>                                                         p->p_class_val_to=
_name[curperm->tclass - 1],
> @@ -219,7 +214,7 @@ static int report_assertion_extended_permissions(sepo=
l_handle_t *handle,
>
>                 ERR(handle, "neverallowxperm on line %lu of %s (or line %=
lu of %s) violated by\n"
>                                 "allow %s %s:%s {%s };",
> -                               avrule->source_line, avrule->source_filen=
ame, avrule->line, policy_name(p),
> +                               narule->source_line, narule->source_filen=
ame, narule->line, policy_name(p),
>                                 p->p_type_val_to_name[stype],
>                                 p->p_type_val_to_name[ttype],
>                                 p->p_class_val_to_name[curperm->tclass - =
1],
> @@ -240,26 +235,26 @@ static int report_assertion_avtab_matches(avtab_key=
_t *k, avtab_datum_t *d, void
>         sepol_handle_t *handle =3D a->handle;
>         policydb_t *p =3D a->p;
>         avtab_t *avtab =3D a->avtab;
> -       avrule_t *avrule =3D a->avrule;
> -       class_perm_node_t *cp;
> +       const avrule_t *narule =3D a->narule;
> +       const class_perm_node_t *cp;
>         uint32_t perms;
>         ebitmap_t src_matches, tgt_matches, self_matches;
>         ebitmap_node_t *snode, *tnode;
>         unsigned int i, j;
> -       const int is_avrule_self =3D (avrule->flags & RULE_SELF) !=3D 0;
> -       const int is_avrule_notself =3D (avrule->flags & RULE_NOTSELF) !=
=3D 0;
> +       const bool is_narule_self =3D (narule->flags & RULE_SELF) !=3D 0;
> +       const bool is_narule_notself =3D (narule->flags & RULE_NOTSELF) !=
=3D 0;
>
>         if ((k->specified & AVTAB_ALLOWED) =3D=3D 0)
>                 return 0;
>
> -       if (!match_any_class_permissions(avrule->perms, k->target_class, =
d->data))
> +       if (!match_any_class_permissions(narule->perms, k->target_class, =
d->data))
>                 return 0;
>
>         ebitmap_init(&src_matches);
>         ebitmap_init(&tgt_matches);
>         ebitmap_init(&self_matches);
>
> -       rc =3D ebitmap_and(&src_matches, &avrule->stypes.types,
> +       rc =3D ebitmap_and(&src_matches, &narule->stypes.types,
>                          &p->attr_type_map[k->source_type - 1]);
>         if (rc < 0)
>                 goto oom;
> @@ -267,22 +262,22 @@ static int report_assertion_avtab_matches(avtab_key=
_t *k, avtab_datum_t *d, void
>         if (ebitmap_is_empty(&src_matches))
>                 goto exit;
>
> -       if (is_avrule_notself) {
> -               if (ebitmap_is_empty(&avrule->ttypes.types)) {
> +       if (is_narule_notself) {
> +               if (ebitmap_is_empty(&narule->ttypes.types)) {
>                         /* avrule tgt is of the form ~self */
>                         rc =3D ebitmap_cpy(&tgt_matches, &p->attr_type_ma=
p[k->target_type -1]);
>                 } else {
>                         /* avrule tgt is of the form {ATTR -self} */
> -                       rc =3D ebitmap_and(&tgt_matches, &avrule->ttypes.=
types, &p->attr_type_map[k->target_type - 1]);
> +                       rc =3D ebitmap_and(&tgt_matches, &narule->ttypes.=
types, &p->attr_type_map[k->target_type - 1]);
>                 }
>                 if (rc)
>                         goto oom;
>         } else {
> -               rc =3D ebitmap_and(&tgt_matches, &avrule->ttypes.types, &=
p->attr_type_map[k->target_type -1]);
> +               rc =3D ebitmap_and(&tgt_matches, &narule->ttypes.types, &=
p->attr_type_map[k->target_type -1]);
>                 if (rc < 0)
>                         goto oom;
>
> -               if (is_avrule_self) {
> +               if (is_narule_self) {
>                         rc =3D ebitmap_and(&self_matches, &src_matches, &=
p->attr_type_map[k->target_type - 1]);
>                         if (rc < 0)
>                                 goto oom;
> @@ -298,7 +293,7 @@ static int report_assertion_avtab_matches(avtab_key_t=
 *k, avtab_datum_t *d, void
>         if (ebitmap_is_empty(&tgt_matches))
>                 goto exit;
>
> -       for (cp =3D avrule->perms; cp; cp =3D cp->next) {
> +       for (cp =3D narule->perms; cp; cp =3D cp->next) {
>
>                 perms =3D cp->data & d->data;
>                 if ((cp->tclass !=3D k->target_class) || !perms) {
> @@ -307,16 +302,16 @@ static int report_assertion_avtab_matches(avtab_key=
_t *k, avtab_datum_t *d, void
>
>                 ebitmap_for_each_positive_bit(&src_matches, snode, i) {
>                         ebitmap_for_each_positive_bit(&tgt_matches, tnode=
, j) {
> -                               if (is_avrule_self && i !=3D j)
> +                               if (is_narule_self && i !=3D j)
>                                         continue;
> -                               if (is_avrule_notself && i =3D=3D j)
> +                               if (is_narule_notself && i =3D=3D j)
>                                         continue;
> -                               if (avrule->specified =3D=3D AVRULE_XPERM=
S_NEVERALLOW) {
> -                                       a->errors +=3D report_assertion_e=
xtended_permissions(handle,p, avrule,
> +                               if (narule->specified =3D=3D AVRULE_XPERM=
S_NEVERALLOW) {
> +                                       a->errors +=3D report_assertion_e=
xtended_permissions(handle,p, narule,
>                                                                          =
               i, j, cp, perms, k, avtab);
>                                 } else {
>                                         a->errors++;
> -                                       report_failure(handle, p, avrule,=
 i, j, cp, perms);
> +                                       report_failure(handle, p, narule,=
 i, j, cp, perms);
>                                 }
>                         }
>                 }
> @@ -330,22 +325,22 @@ exit:
>         return rc;
>  }
>
> -static int report_assertion_failures(sepol_handle_t *handle, policydb_t =
*p, avrule_t *avrule)
> +static int report_assertion_failures(sepol_handle_t *handle, policydb_t =
*p, const avrule_t *narule)
>  {
>         int rc;
> -       struct avtab_match_args args;
> -
> -       args.handle =3D handle;
> -       args.p =3D p;
> -       args.avrule =3D avrule;
> -       args.errors =3D 0;
> +       struct avtab_match_args args =3D {
> +               .handle =3D handle,
> +               .p =3D p,
> +               .narule =3D narule,
> +               .errors =3D 0,
> +       };
>
> -       args.avtab =3D  &p->te_avtab;
> +       args.avtab =3D &p->te_avtab;
>         rc =3D avtab_map(&p->te_avtab, report_assertion_avtab_matches, &a=
rgs);
>         if (rc < 0)
>                 goto oom;
>
> -       args.avtab =3D  &p->te_cond_avtab;
> +       args.avtab =3D &p->te_cond_avtab;
>         rc =3D avtab_map(&p->te_cond_avtab, report_assertion_avtab_matche=
s, &args);
>         if (rc < 0)
>                 goto oom;
> @@ -360,19 +355,19 @@ oom:
>   * Look up the extended permissions in avtab and verify that neverallowe=
d
>   * permissions are not granted.
>   */
> -static int check_assertion_extended_permissions_avtab(avrule_t *avrule, =
avtab_t *avtab,
> +static bool check_assertion_extended_permissions_avtab(const avrule_t *n=
arule, avtab_t *avtab,
>                                                 unsigned int stype, unsig=
ned int ttype,
> -                                               avtab_key_t *k, policydb_=
t *p)
> +                                               const avtab_key_t *k, pol=
icydb_t *p)
>  {
>         avtab_ptr_t node;
>         avtab_key_t tmp_key;
> -       avtab_extended_perms_t *xperms;
> -       av_extended_perms_t *neverallow_xperms =3D avrule->xperms;
> -       ebitmap_t *sattr =3D &p->type_attr_map[stype];
> -       ebitmap_t *tattr =3D &p->type_attr_map[ttype];
> +       const avtab_extended_perms_t *xperms;
> +       const av_extended_perms_t *neverallow_xperms =3D narule->xperms;
> +       const ebitmap_t *sattr =3D &p->type_attr_map[stype];
> +       const ebitmap_t *tattr =3D &p->type_attr_map[ttype];
>         ebitmap_node_t *snode, *tnode;
>         unsigned int i, j;
> -       int rc =3D 1;
> +       bool ret =3D true;
>
>         memcpy(&tmp_key, k, sizeof(avtab_key_t));
>         tmp_key.specified =3D AVTAB_XPERMS_ALLOWED;
> @@ -390,14 +385,14 @@ static int check_assertion_extended_permissions_avt=
ab(avrule_t *avrule, avtab_t
>                                                 && (xperms->specified !=
=3D AVTAB_XPERMS_IOCTLDRIVER)
>                                                 && (xperms->specified !=
=3D AVTAB_XPERMS_NLMSG))
>                                         continue;
> -                               rc =3D check_extended_permissions(neveral=
low_xperms, xperms);
> -                               if (rc)
> -                                       return rc;
> +                               ret =3D check_extended_permissions(nevera=
llow_xperms, xperms);
> +                               if (ret)
> +                                       return ret;
>                         }
>                 }
>         }
>
> -       return rc;
> +       return ret;
>  }
>
>  /*
> @@ -416,21 +411,21 @@ static int check_assertion_extended_permissions_avt=
ab(avrule_t *avrule, avtab_t
>   * 4. FAIL - The ioctl permission is granted AND the extended permission=
 is
>   *    granted
>   */
> -static int check_assertion_extended_permissions(avrule_t *avrule, avtab_=
t *avtab,
> -                                               avtab_key_t *k, policydb_=
t *p)
> +static int check_assertion_extended_permissions(const avrule_t *narule, =
avtab_t *avtab,
> +                                               const avtab_key_t *k, pol=
icydb_t *p)
>  {
>         ebitmap_t src_matches, tgt_matches, self_matches;
>         unsigned int i, j;
>         ebitmap_node_t *snode, *tnode;
> -       const int is_avrule_self =3D (avrule->flags & RULE_SELF) !=3D 0;
> -       const int is_avrule_notself =3D (avrule->flags & RULE_NOTSELF) !=
=3D 0;
> +       const bool is_narule_self =3D (narule->flags & RULE_SELF) !=3D 0;
> +       const bool is_narule_notself =3D (narule->flags & RULE_NOTSELF) !=
=3D 0;
>         int rc;
>
>         ebitmap_init(&src_matches);
>         ebitmap_init(&tgt_matches);
>         ebitmap_init(&self_matches);
>
> -       rc =3D ebitmap_and(&src_matches, &avrule->stypes.types,
> +       rc =3D ebitmap_and(&src_matches, &narule->stypes.types,
>                          &p->attr_type_map[k->source_type - 1]);
>         if (rc < 0)
>                 goto oom;
> @@ -440,22 +435,22 @@ static int check_assertion_extended_permissions(avr=
ule_t *avrule, avtab_t *avtab
>                 goto exit;
>         }
>
> -       if (is_avrule_notself) {
> -               if (ebitmap_is_empty(&avrule->ttypes.types)) {
> +       if (is_narule_notself) {
> +               if (ebitmap_is_empty(&narule->ttypes.types)) {
>                         /* avrule tgt is of the form ~self */
>                         rc =3D ebitmap_cpy(&tgt_matches, &p->attr_type_ma=
p[k->target_type -1]);
>                 } else {
>                         /* avrule tgt is of the form {ATTR -self} */
> -                       rc =3D ebitmap_and(&tgt_matches, &avrule->ttypes.=
types, &p->attr_type_map[k->target_type - 1]);
> +                       rc =3D ebitmap_and(&tgt_matches, &narule->ttypes.=
types, &p->attr_type_map[k->target_type - 1]);
>                 }
>                 if (rc < 0)
>                         goto oom;
>         } else {
> -               rc =3D ebitmap_and(&tgt_matches, &avrule->ttypes.types, &=
p->attr_type_map[k->target_type -1]);
> +               rc =3D ebitmap_and(&tgt_matches, &narule->ttypes.types, &=
p->attr_type_map[k->target_type -1]);
>                 if (rc < 0)
>                         goto oom;
>
> -               if (is_avrule_self) {
> +               if (is_narule_self) {
>                         rc =3D ebitmap_and(&self_matches, &src_matches, &=
p->attr_type_map[k->target_type - 1]);
>                         if (rc < 0)
>                                 goto oom;
> @@ -475,11 +470,11 @@ static int check_assertion_extended_permissions(avr=
ule_t *avrule, avtab_t *avtab
>
>         ebitmap_for_each_positive_bit(&src_matches, snode, i) {
>                 ebitmap_for_each_positive_bit(&tgt_matches, tnode, j) {
> -                       if (is_avrule_self && i !=3D j)
> +                       if (is_narule_self && i !=3D j)
>                                 continue;
> -                       if (is_avrule_notself && i =3D=3D j)
> +                       if (is_narule_notself && i =3D=3D j)
>                                 continue;
> -                       if (check_assertion_extended_permissions_avtab(av=
rule, avtab, i, j, k, p)) {
> +                       if (check_assertion_extended_permissions_avtab(na=
rule, avtab, i, j, k, p)) {
>                                 rc =3D 1;
>                                 goto exit;
>                         }
> @@ -496,7 +491,7 @@ exit:
>         return rc;
>  }
>
> -static int check_assertion_notself_match(avtab_key_t *k, avrule_t *avrul=
e, policydb_t *p)
> +static int check_assertion_notself_match(const avtab_key_t *k, const avr=
ule_t *narule, policydb_t *p)
>  {
>         ebitmap_t src_matches, tgt_matches;
>         unsigned int num_src_matches, num_tgt_matches;
> @@ -505,16 +500,16 @@ static int check_assertion_notself_match(avtab_key_=
t *k, avrule_t *avrule, polic
>         ebitmap_init(&src_matches);
>         ebitmap_init(&tgt_matches);
>
> -       rc =3D ebitmap_and(&src_matches, &avrule->stypes.types, &p->attr_=
type_map[k->source_type - 1]);
> +       rc =3D ebitmap_and(&src_matches, &narule->stypes.types, &p->attr_=
type_map[k->source_type - 1]);
>         if (rc < 0)
>                 goto oom;
>
> -       if (ebitmap_is_empty(&avrule->ttypes.types)) {
> +       if (ebitmap_is_empty(&narule->ttypes.types)) {
>                 /* avrule tgt is of the form ~self */
>                 rc =3D ebitmap_cpy(&tgt_matches, &p->attr_type_map[k->tar=
get_type - 1]);
>         } else {
>                 /* avrule tgt is of the form {ATTR -self} */
> -               rc =3D ebitmap_and(&tgt_matches, &avrule->ttypes.types, &=
p->attr_type_map[k->target_type - 1]);
> +               rc =3D ebitmap_and(&tgt_matches, &narule->ttypes.types, &=
p->attr_type_map[k->target_type - 1]);
>         }
>         if (rc < 0)
>                 goto oom;
> @@ -551,7 +546,7 @@ nomatch:
>         return rc;
>  }
>
> -static int check_assertion_self_match(avtab_key_t *k, avrule_t *avrule, =
policydb_t *p)
> +static int check_assertion_self_match(const avtab_key_t *k, const avrule=
_t *narule, policydb_t *p)
>  {
>         ebitmap_t src_matches;
>         int rc;
> @@ -560,7 +555,7 @@ static int check_assertion_self_match(avtab_key_t *k,=
 avrule_t *avrule, policydb
>          * and the key's source.
>          */
>
> -       rc =3D ebitmap_and(&src_matches, &avrule->stypes.types, &p->attr_=
type_map[k->source_type - 1]);
> +       rc =3D ebitmap_and(&src_matches, &narule->stypes.types, &p->attr_=
type_map[k->source_type - 1]);
>         if (rc < 0)
>                 goto oom;
>
> @@ -582,29 +577,29 @@ static int check_assertion_avtab_match(avtab_key_t =
*k, avtab_datum_t *d, void *a
>         int rc;
>         struct avtab_match_args *a =3D (struct avtab_match_args *)args;
>         policydb_t *p =3D a->p;
> -       avrule_t *avrule =3D a->avrule;
> +       const avrule_t *narule =3D a->narule;
>         avtab_t *avtab =3D a->avtab;
>
>         if ((k->specified & AVTAB_ALLOWED) =3D=3D 0)
>                 goto nomatch;
>
> -       if (!match_any_class_permissions(avrule->perms, k->target_class, =
d->data))
> +       if (!match_any_class_permissions(narule->perms, k->target_class, =
d->data))
>                 goto nomatch;
>
> -       if (!ebitmap_match_any(&avrule->stypes.types, &p->attr_type_map[k=
->source_type - 1]))
> +       if (!ebitmap_match_any(&narule->stypes.types, &p->attr_type_map[k=
->source_type - 1]))
>                 goto nomatch;
>
> -       if (avrule->flags & RULE_NOTSELF) {
> -               rc =3D check_assertion_notself_match(k, avrule, p);
> +       if (narule->flags & RULE_NOTSELF) {
> +               rc =3D check_assertion_notself_match(k, narule, p);
>                 if (rc < 0)
>                         goto oom;
>                 if (rc =3D=3D 0)
>                         goto nomatch;
>         } else {
>                 /* neverallow may have tgts even if it uses SELF */
> -               if (!ebitmap_match_any(&avrule->ttypes.types, &p->attr_ty=
pe_map[k->target_type -1])) {
> -                       if (avrule->flags =3D=3D RULE_SELF) {
> -                               rc =3D check_assertion_self_match(k, avru=
le, p);
> +               if (!ebitmap_match_any(&narule->ttypes.types, &p->attr_ty=
pe_map[k->target_type -1])) {
> +                       if (narule->flags =3D=3D RULE_SELF) {
> +                               rc =3D check_assertion_self_match(k, naru=
le, p);
>                                 if (rc < 0)
>                                         goto oom;
>                                 if (rc =3D=3D 0)
> @@ -615,8 +610,8 @@ static int check_assertion_avtab_match(avtab_key_t *k=
, avtab_datum_t *d, void *a
>                 }
>         }
>
> -       if (avrule->specified =3D=3D AVRULE_XPERMS_NEVERALLOW) {
> -               rc =3D check_assertion_extended_permissions(avrule, avtab=
, k, p);
> +       if (narule->specified =3D=3D AVRULE_XPERMS_NEVERALLOW) {
> +               rc =3D check_assertion_extended_permissions(narule, avtab=
, k, p);
>                 if (rc < 0)
>                         goto oom;
>                 if (rc =3D=3D 0)
> @@ -631,17 +626,17 @@ oom:
>         return rc;
>  }
>
> -int check_assertion(policydb_t *p, avrule_t *avrule)
> +int check_assertion(policydb_t *p, const avrule_t *narule)
>  {
>         int rc;
> -       struct avtab_match_args args;
> +       struct avtab_match_args args =3D {
> +               .handle =3D NULL,
> +               .p =3D p,
> +               .narule =3D narule,
> +               .errors =3D 0,
> +       };
>
> -       args.handle =3D NULL;
> -       args.p =3D p;
> -       args.avrule =3D avrule;
> -       args.errors =3D 0;
>         args.avtab =3D &p->te_avtab;
> -
>         rc =3D avtab_map(&p->te_avtab, check_assertion_avtab_match, &args=
);
>
>         if (rc =3D=3D 0) {
> @@ -653,20 +648,13 @@ int check_assertion(policydb_t *p, avrule_t *avrule=
)
>  }
>
>  int check_assertions(sepol_handle_t * handle, policydb_t * p,
> -                    avrule_t * avrules)
> +                    const avrule_t * narules)
>  {
>         int rc;
> -       avrule_t *a;
> +       const avrule_t *a;
>         unsigned long errors =3D 0;
>
> -       if (!avrules) {
> -               /* Since assertions are stored in avrules, if it is NULL
> -                  there won't be any to check. This also prevents an inv=
alid
> -                  free if the avtabs are never initialized */
> -               return 0;
> -       }
> -
> -       for (a =3D avrules; a !=3D NULL; a =3D a->next) {
> +       for (a =3D narules; a !=3D NULL; a =3D a->next) {
>                 if (!(a->specified & (AVRULE_NEVERALLOW | AVRULE_XPERMS_N=
EVERALLOW)))
>                         continue;
>                 rc =3D check_assertion(p, a);
> --
> 2.45.2
>
>
