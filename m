Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E55A1E0DC4
	for <selinux@vger.kernel.org>; Wed,  6 Nov 2024 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730901327; cv=none; b=pBaJ7hQKxEuGhQyH4JbtKShQCO9Pma3DhHrKzWapZ4DtN1g0woJFUb9qQ0lggawC2O4lV0f359E+uoYJ3dHrognSC0Hrbs7+raQ5ws3ZIpf9KC5EgIS8CVmCUcZqmASnJUng+xOrk0rg74pznRBeumCjn/LUrr/fMY4jhIxRBNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730901327; c=relaxed/simple;
	bh=m2d2jVOnj67DvJbYk7hdIDirbGO/paJWx9BnCWRdi70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u16ncr41/h3J2cmnFQHFGjglTJSstmGiknWGTIrP4oLI0OvNAwMrXeoWSWkeGXvGWt9jVGluEfoBTb8jkWLirSUCQGKvPGIO1UBDKFEpfVt3392aoQvZeRzvc7bPCCnf2HsV/gP+TrfVGvKvsPLHOKAhGN+tnmQUbd/gZJQoTNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glpm+mGL; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glpm+mGL"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-50dc984bf5dso2440862e0c.0
        for <selinux@vger.kernel.org>; Wed, 06 Nov 2024 05:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730901323; x=1731506123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbIgRcaiCKxzVhIuSbJJz2XehiSMd/nVMhPKcIE0vIg=;
        b=glpm+mGLYz40jdvt6hH5SHWihKXvGVlF7mhtlOb3lSdgI8VyQHZBP/QnfP1cuW5F41
         QatwHTX7kpljuJcxohiJztnRwM/qVbmsVVmJXIQQFW4/MQd9mzHCPHGEoamaCaMHTxvb
         yBP2ZWUosXi5x/qHsQOhrsAfKW5lNMMMiBPcUs8FTCo+8i78OPvF1nVCGW1rj1vcBt88
         jJ0MEhaaOfk2xdoU+dW7gNCE4UnSDcDs7EvOxI8XTNO5wm8HpfNUlk+zQyTZoe0bY+Do
         eYUGsbsMjW9nLqvsjQq34gqsPZGmEDBu0Em/anHoF2fjII6yDD+H0XuHSJDoqiM1WFuD
         Y5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730901323; x=1731506123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbIgRcaiCKxzVhIuSbJJz2XehiSMd/nVMhPKcIE0vIg=;
        b=UGcsNbIvzitmMQZ9ktqtUnNU8i+FXZGQHSHlXHo2PzFpL5K46has/1m8HxYC7X4Lhb
         A6oDbp2J9r6s0z0f71i748KA4HCwN+K0kIonw/es0jFDHHt7mbSGBL9ojq2tgJQUBcgZ
         s8pPW/SMwa9N+ImZSvxU1syXkLkMSfNmwEY/yMOWJojB/o5sJV0CXbxUyGrCGeqqRfH3
         Jn7wjv78jCpSxrhXsN+lGuuv2E9cNG4wE5W1MpTETtRGc7yptV0T9RzXElfK4NX9aew4
         SL0xIz9ebUygyDrXii0Q0KVK6XtWBp/7j0tgF3k6qVeBHavF/3q+sFKXSvvBjGnSmop6
         iGtw==
X-Gm-Message-State: AOJu0YxbJTt1eka3RLxRziWAGvUQd9EdfpUrwMkNZrHWyWYYVvKaWHrS
	EikGfTURRcnrRsZSMsXJjGxW1yjXnjoQEnGnLbVpEo5+6oTPMORrdAB2o2+4HO24J2iGecNSCCn
	bsTDp1mzGLDK0s4oYyuQz+02pReiFpqGc
X-Google-Smtp-Source: AGHT+IHwfNC9sBYEtttBaRSe1QThT1rqEgMP+fUWHu9GsF/9jAVex7kZ+WVUhGFLVScapGz09XD9u3IhuC7Qkw67e2w=
X-Received: by 2002:a05:6102:ccd:b0:4a5:c297:7d5a with SMTP id
 ada2fe7eead31-4a95431688cmr22042118137.16.1730901323053; Wed, 06 Nov 2024
 05:55:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105135428.124398-1-cgoettsche@seltendoof.de> <20241105135428.124398-2-cgoettsche@seltendoof.de>
In-Reply-To: <20241105135428.124398-2-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 6 Nov 2024 08:55:12 -0500
Message-ID: <CAP+JOzRJAK3C5P-NRNWY_j+vLs4YkdOZajWjErZoGLgJbn2O7g@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] libsepol: add support for xperms in conditional policies
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 9:00=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Add support for extended permission rules in conditional policies by
> adding a new policy version and adjusting writing and validating
> policies accordingly.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v4:
>   - fix assertion logic on CIL generated policy
>   - enhance xperm validation
>   - rebase onto main
> v3:
>   - several assertion logic fixes
> v2:
>   - rebase onto libsepol: Support nlmsg xperms in assertions
>   - fix assertion checking with xperm av rules in conditional policies
>     (spotted by Jim, thanks!)
> ---
>  libsepol/include/sepol/policydb/policydb.h |  12 +-
>  libsepol/src/assertion.c                   | 217 ++++++++++++++++++---
>  libsepol/src/policydb.c                    |  21 ++
>  libsepol/src/policydb_validate.c           |  41 ++--
>  libsepol/src/write.c                       |  46 +++--
>  5 files changed, 270 insertions(+), 67 deletions(-)
>
> diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/includ=
e/sepol/policydb/policydb.h
> index 88fb3672..f833354b 100644
> --- a/libsepol/include/sepol/policydb/policydb.h
> +++ b/libsepol/include/sepol/policydb/policydb.h
> @@ -759,10 +759,11 @@ extern int policydb_set_target_platform(policydb_t =
*p, int platform);
>  #define POLICYDB_VERSION_INFINIBAND            31 /* Linux-specific */
>  #define POLICYDB_VERSION_GLBLUB                32
>  #define POLICYDB_VERSION_COMP_FTRANS   33 /* compressed filename transit=
ions */
> +#define POLICYDB_VERSION_COND_XPERMS   34 /* extended permissions in con=
ditional policies */
>
>  /* Range of policy versions we understand*/
>  #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
> -#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_COMP_FTRANS
> +#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_COND_XPERMS
>
>  /* Module versions and specific changes*/
>  #define MOD_POLICYDB_VERSION_BASE              4
> @@ -785,9 +786,10 @@ extern int policydb_set_target_platform(policydb_t *=
p, int platform);
>  #define MOD_POLICYDB_VERSION_INFINIBAND                19
>  #define MOD_POLICYDB_VERSION_GLBLUB            20
>  #define MOD_POLICYDB_VERSION_SELF_TYPETRANS    21
> +#define MOD_POLICYDB_VERSION_COND_XPERMS       22
>
>  #define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
> -#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_SELF_TYPETRANS
> +#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_COND_XPERMS
>
>  #define POLICYDB_CONFIG_MLS    1
>
> @@ -801,6 +803,12 @@ extern int policydb_set_target_platform(policydb_t *=
p, int platform);
>          ((p)->policy_type !=3D POLICY_KERN                       \
>           && (p)->policyvers >=3D MOD_POLICYDB_VERSION_BOUNDARY))
>
> +#define policydb_has_cond_xperms_feature(p)                    \
> +       (((p)->policy_type =3D=3D POLICY_KERN                       \
> +         && (p)->policyvers >=3D POLICYDB_VERSION_COND_XPERMS) ||       =
 \
> +        ((p)->policy_type !=3D POLICY_KERN                       \
> +         && (p)->policyvers >=3D MOD_POLICYDB_VERSION_COND_XPERMS))
> +
>  /* the config flags related to unknown classes/perms are bits 2 and 3 */
>  #define DENY_UNKNOWN   SEPOL_DENY_UNKNOWN
>  #define REJECT_UNKNOWN SEPOL_REJECT_UNKNOWN
> diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
> index e0e8685f..4028a33d 100644
> --- a/libsepol/src/assertion.c
> +++ b/libsepol/src/assertion.c
> @@ -33,8 +33,8 @@ struct avtab_match_args {
>         sepol_handle_t *handle;
>         policydb_t *p;
>         const avrule_t *narule;
> -       avtab_t *avtab;
>         unsigned long errors;
> +       bool conditional;
>  };
>
>  static const char* policy_name(const policydb_t *p) {
> @@ -152,12 +152,19 @@ static void extended_permissions_violated(avtab_ext=
ended_perms_t *result,
>         }
>  }
>
> +static bool match_node_key(const struct avtab_node *node, const avtab_ke=
y_t *key)
> +{
> +       return node->key.source_type =3D=3D key->source_type
> +               && node->key.target_type =3D=3D key->target_type
> +               && node->key.target_class =3D=3D key->target_class;
> +}
> +
>  /* Same scenarios of interest as check_assertion_extended_permissions */
>  static int report_assertion_extended_permissions(sepol_handle_t *handle,
>                                 policydb_t *p, const avrule_t *narule,
>                                 unsigned int stype, unsigned int ttype,
>                                 const class_perm_node_t *curperm, uint32_=
t perms,
> -                               const avtab_key_t *k, avtab_t *avtab)
> +                               const avtab_key_t *k, bool conditional)
>  {
>         avtab_ptr_t node;
>         avtab_key_t tmp_key;
> @@ -167,7 +174,7 @@ static int report_assertion_extended_permissions(sepo=
l_handle_t *handle,
>         const ebitmap_t *tattr =3D &p->type_attr_map[ttype];
>         ebitmap_node_t *snode, *tnode;
>         unsigned int i, j;
> -       bool found_xperm =3D false;
> +       bool found_xperm =3D false, found_cond_conflict =3D false;
>         int errors =3D 0;
>
>         memcpy(&tmp_key, k, sizeof(avtab_key_t));
> @@ -177,7 +184,7 @@ static int report_assertion_extended_permissions(sepo=
l_handle_t *handle,
>                 tmp_key.source_type =3D i + 1;
>                 ebitmap_for_each_positive_bit(tattr, tnode, j) {
>                         tmp_key.target_type =3D j + 1;
> -                       for (node =3D avtab_search_node(avtab, &tmp_key);
> +                       for (node =3D avtab_search_node(&p->te_avtab, &tm=
p_key);
>                              node;
>                              node =3D avtab_search_node_next(node, tmp_ke=
y.specified)) {
>                                 xperms =3D node->datum.xperms;
> @@ -205,11 +212,105 @@ static int report_assertion_extended_permissions(s=
epol_handle_t *handle,
>                                         errors++;
>                                 }
>                         }
> +
> +                       for (const cond_list_t *cl =3D p->cond_list; cl; =
cl =3D cl->next) {
> +                               bool found_true_base =3D false, found_tru=
e_xperm =3D false;
> +                               bool found_false_base =3D false, found_fa=
lse_xperm =3D false;
> +
> +                               for (const cond_av_list_t *cal =3D cl->tr=
ue_list; cal; cal =3D cal->next) {
> +                                       node =3D cal->node; /* node->next=
 is not from the same condition */
> +                                       if (!node)
> +                                               continue;
> +
> +                                       if (!match_node_key(node, &tmp_ke=
y))
> +                                               continue;
> +
> +                                       if (match_any_class_permissions(n=
arule->perms, node->key.target_class, node->datum.data)) {
> +                                               found_true_base =3D true;
> +                                               continue;
> +                                       }
> +
> +                                       if (!(node->key.specified & AVTAB=
_XPERMS_ALLOWED))
> +                                               continue;
> +
> +                                       xperms =3D node->datum.xperms;
> +                                       if ((xperms->specified !=3D AVTAB=
_XPERMS_IOCTLFUNCTION)
> +                                                       && (xperms->speci=
fied !=3D AVTAB_XPERMS_IOCTLDRIVER)
> +                                                       && (xperms->speci=
fied !=3D AVTAB_XPERMS_NLMSG))
> +                                               continue;
> +                                       found_true_xperm =3D true;
> +                                       /* failure on the extended permis=
sion check_extended_permissions */
> +                                       if (check_extended_permissions(na=
rule->xperms, xperms)) {
> +                                               char *permstring;
> +
> +                                               extended_permissions_viol=
ated(&error, narule->xperms, xperms);
> +                                               permstring =3D sepol_exte=
nded_perms_to_string(&error);
> +
> +                                               ERR(handle, "neverallowxp=
erm on line %lu of %s (or line %lu of %s) violated by\n"
> +                                                               "allowxpe=
rm %s %s:%s %s;",
> +                                                               narule->s=
ource_line, narule->source_filename, narule->line, policy_name(p),
> +                                                               p->p_type=
_val_to_name[i],
> +                                                               p->p_type=
_val_to_name[j],
> +                                                               p->p_clas=
s_val_to_name[curperm->tclass - 1],
> +                                                               permstrin=
g ?: "<format-failure>");
> +
> +                                               free(permstring);
> +                                               errors++;
> +                                       }
> +                               }
> +
> +                               for (const cond_av_list_t *cal =3D cl->fa=
lse_list; cal; cal =3D cal->next) {
> +                                       node =3D cal->node; /* node->next=
 is not from the same condition */
> +                                       if (!node)
> +                                               continue;
> +
> +                                       if (!match_node_key(node, &tmp_ke=
y))
> +                                               continue;
> +
> +                                       if (match_any_class_permissions(n=
arule->perms, node->key.target_class, node->datum.data)) {
> +                                               found_false_base =3D true=
;
> +                                               continue;
> +                                       }
> +
> +                                       if (!(node->key.specified & AVTAB=
_XPERMS_ALLOWED))
> +                                               continue;
> +
> +                                       xperms =3D node->datum.xperms;
> +                                       if ((xperms->specified !=3D AVTAB=
_XPERMS_IOCTLFUNCTION)
> +                                                       && (xperms->speci=
fied !=3D AVTAB_XPERMS_IOCTLDRIVER)
> +                                                       && (xperms->speci=
fied !=3D AVTAB_XPERMS_NLMSG))
> +                                               continue;
> +                                       found_false_xperm =3D true;
> +                                       /* failure on the extended permis=
sion check_extended_permissions */
> +                                       if (check_extended_permissions(na=
rule->xperms, xperms)) {
> +                                               char *permstring;
> +
> +                                               extended_permissions_viol=
ated(&error, narule->xperms, xperms);
> +                                               permstring =3D sepol_exte=
nded_perms_to_string(&error);
> +
> +                                               ERR(handle, "neverallowxp=
erm on line %lu of %s (or line %lu of %s) violated by\n"
> +                                                               "allowxpe=
rm %s %s:%s %s;",
> +                                                               narule->s=
ource_line, narule->source_filename, narule->line, policy_name(p),
> +                                                               p->p_type=
_val_to_name[i],
> +                                                               p->p_type=
_val_to_name[j],
> +                                                               p->p_clas=
s_val_to_name[curperm->tclass - 1],
> +                                                               permstrin=
g ?: "<format-failure>");
> +
> +                                               free(permstring);
> +                                               errors++;
> +                                       }
> +                               }
> +
> +                               if (found_true_xperm && found_false_xperm=
)
> +                                       found_xperm =3D true;
> +                               else if (conditional && ((found_true_base=
 && !found_true_xperm) || (found_false_base && !found_false_xperm)))
> +                                       found_cond_conflict =3D true;
> +                       }
>                 }
>         }
>
> -       /* failure on the regular permissions */
> -       if (!found_xperm) {
> +       if ((!found_xperm && !conditional) || found_cond_conflict) {
> +               /* failure on the regular permissions */
>                 char *permstr =3D sepol_av_to_string(p, curperm->tclass, =
perms);
>
>                 ERR(handle, "neverallowxperm on line %lu of %s (or line %=
lu of %s) violated by\n"
> @@ -222,7 +323,6 @@ static int report_assertion_extended_permissions(sepo=
l_handle_t *handle,
>
>                 free(permstr);
>                 errors++;
> -
>         }
>
>         return errors;
> @@ -234,7 +334,6 @@ static int report_assertion_avtab_matches(avtab_key_t=
 *k, avtab_datum_t *d, void
>         struct avtab_match_args *a =3D (struct avtab_match_args *)args;
>         sepol_handle_t *handle =3D a->handle;
>         policydb_t *p =3D a->p;
> -       avtab_t *avtab =3D a->avtab;
>         const avrule_t *narule =3D a->narule;
>         const class_perm_node_t *cp;
>         uint32_t perms;
> @@ -308,7 +407,8 @@ static int report_assertion_avtab_matches(avtab_key_t=
 *k, avtab_datum_t *d, void
>                                         continue;
>                                 if (narule->specified =3D=3D AVRULE_XPERM=
S_NEVERALLOW) {
>                                         a->errors +=3D report_assertion_e=
xtended_permissions(handle,p, narule,
> -                                                                        =
               i, j, cp, perms, k, avtab);
> +                                                                        =
               i, j, cp, perms, k,
> +                                                                        =
               a->conditional);
>                                 } else {
>                                         a->errors++;
>                                         report_failure(handle, p, narule,=
 i, j, cp, perms);
> @@ -335,12 +435,12 @@ static int report_assertion_failures(sepol_handle_t=
 *handle, policydb_t *p, cons
>                 .errors =3D 0,
>         };
>
> -       args.avtab =3D &p->te_avtab;
> +       args.conditional =3D false;
>         rc =3D avtab_map(&p->te_avtab, report_assertion_avtab_matches, &a=
rgs);
>         if (rc < 0)
>                 goto oom;
>
> -       args.avtab =3D &p->te_cond_avtab;
> +       args.conditional =3D true;
>         rc =3D avtab_map(&p->te_cond_avtab, report_assertion_avtab_matche=
s, &args);
>         if (rc < 0)
>                 goto oom;
> @@ -355,9 +455,10 @@ oom:
>   * Look up the extended permissions in avtab and verify that neverallowe=
d
>   * permissions are not granted.
>   */
> -static bool check_assertion_extended_permissions_avtab(const avrule_t *n=
arule, avtab_t *avtab,
> +static bool check_assertion_extended_permissions_avtab(const avrule_t *n=
arule,
>                                                 unsigned int stype, unsig=
ned int ttype,
> -                                               const avtab_key_t *k, pol=
icydb_t *p)
> +                                               const avtab_key_t *k, pol=
icydb_t *p,
> +                                               bool conditional)
>  {
>         avtab_ptr_t node;
>         avtab_key_t tmp_key;
> @@ -367,7 +468,7 @@ static bool check_assertion_extended_permissions_avta=
b(const avrule_t *narule, a
>         const ebitmap_t *tattr =3D &p->type_attr_map[ttype];
>         ebitmap_node_t *snode, *tnode;
>         unsigned int i, j;
> -       bool ret =3D true;
> +       bool found_xperm =3D false, found_cond_conflict =3D false;
>
>         memcpy(&tmp_key, k, sizeof(avtab_key_t));
>         tmp_key.specified =3D AVTAB_XPERMS_ALLOWED;
> @@ -376,7 +477,7 @@ static bool check_assertion_extended_permissions_avta=
b(const avrule_t *narule, a
>                 tmp_key.source_type =3D i + 1;
>                 ebitmap_for_each_positive_bit(tattr, tnode, j) {
>                         tmp_key.target_type =3D j + 1;
> -                       for (node =3D avtab_search_node(avtab, &tmp_key);
> +                       for (node =3D avtab_search_node(&p->te_avtab, &tm=
p_key);
>                              node;
>                              node =3D avtab_search_node_next(node, tmp_ke=
y.specified)) {
>                                 xperms =3D node->datum.xperms;
> @@ -385,14 +486,78 @@ static bool check_assertion_extended_permissions_av=
tab(const avrule_t *narule, a
>                                                 && (xperms->specified !=
=3D AVTAB_XPERMS_IOCTLDRIVER)
>                                                 && (xperms->specified !=
=3D AVTAB_XPERMS_NLMSG))
>                                         continue;
> -                               ret =3D check_extended_permissions(nevera=
llow_xperms, xperms);
> -                               if (ret)
> -                                       return ret;
> +                               found_xperm =3D true;
> +                               if (check_extended_permissions(neverallow=
_xperms, xperms))
> +                                       return true;
> +                       }
> +
> +                       for (const cond_list_t *cl =3D p->cond_list; cl; =
cl =3D cl->next) {
> +                               bool found_true_base =3D false, found_tru=
e_xperm =3D false;
> +                               bool found_false_base =3D false, found_fa=
lse_xperm =3D false;
> +
> +                               for (const cond_av_list_t *cal =3D cl->tr=
ue_list; cal; cal =3D cal->next) {
> +                                       node =3D cal->node; /* node->next=
 is not from the same condition */
> +                                       if (!node)
> +                                               continue;
> +
> +                                       if (!match_node_key(node, &tmp_ke=
y))
> +                                               continue;
> +
> +                                       if ((node->key.specified & AVTAB_=
ALLOWED) && match_any_class_permissions(narule->perms, node->key.target_cla=
ss, node->datum.data)) {
> +                                               found_true_base =3D true;
> +                                               continue;
> +                                       }
> +
> +                                       if (!(node->key.specified & AVTAB=
_XPERMS_ALLOWED))
> +                                               continue;
> +
> +                                       xperms =3D node->datum.xperms;
> +
> +                                       if ((xperms->specified !=3D AVTAB=
_XPERMS_IOCTLFUNCTION)
> +                                                       && (xperms->speci=
fied !=3D AVTAB_XPERMS_IOCTLDRIVER)
> +                                                       && (xperms->speci=
fied !=3D AVTAB_XPERMS_NLMSG))
> +                                               continue;
> +                                       found_true_xperm =3D true;
> +                                       if (check_extended_permissions(ne=
verallow_xperms, xperms))
> +                                               return true;
> +                               }
> +
> +                               for (const cond_av_list_t *cal =3D cl->fa=
lse_list; cal; cal =3D cal->next) {
> +                                       node =3D cal->node; /* node->next=
 is not from the same condition */
> +                                       if (!node)
> +                                               continue;
> +
> +                                       if (!match_node_key(node, &tmp_ke=
y))
> +                                               continue;
> +
> +                                       if ((node->key.specified & AVTAB_=
ALLOWED) && match_any_class_permissions(narule->perms, node->key.target_cla=
ss, node->datum.data)) {
> +                                               found_false_base =3D true=
;
> +                                               continue;
> +                                       }
> +
> +                                       if (!(node->key.specified & AVTAB=
_XPERMS_ALLOWED))
> +                                               continue;
> +
> +                                       xperms =3D node->datum.xperms;
> +
> +                                       if ((xperms->specified !=3D AVTAB=
_XPERMS_IOCTLFUNCTION)
> +                                                       && (xperms->speci=
fied !=3D AVTAB_XPERMS_IOCTLDRIVER)
> +                                                       && (xperms->speci=
fied !=3D AVTAB_XPERMS_NLMSG))
> +                                               continue;
> +                                       found_false_xperm =3D true;
> +                                       if (check_extended_permissions(ne=
verallow_xperms, xperms))
> +                                               return true;
> +                               }
> +
> +                               if (found_true_xperm && found_false_xperm=
)
> +                                       found_xperm =3D true;
> +                               else if (conditional && ((found_true_base=
 && !found_true_xperm) || (found_false_base && !found_false_xperm)))
> +                                       found_cond_conflict =3D true;
>                         }
>                 }
>         }
>
> -       return ret;
> +       return (!conditional && !found_xperm) || found_cond_conflict;
>  }
>
>  /*
> @@ -411,8 +576,9 @@ static bool check_assertion_extended_permissions_avta=
b(const avrule_t *narule, a
>   * 4. FAIL - The ioctl permission is granted AND the extended permission=
 is
>   *    granted
>   */
> -static int check_assertion_extended_permissions(const avrule_t *narule, =
avtab_t *avtab,
> -                                               const avtab_key_t *k, pol=
icydb_t *p)
> +static int check_assertion_extended_permissions(const avrule_t *narule,
> +                                               const avtab_key_t *k, pol=
icydb_t *p,
> +                                               bool conditional)
>  {
>         ebitmap_t src_matches, tgt_matches, self_matches;
>         unsigned int i, j;
> @@ -474,7 +640,7 @@ static int check_assertion_extended_permissions(const=
 avrule_t *narule, avtab_t
>                                 continue;
>                         if (is_narule_notself && i =3D=3D j)
>                                 continue;
> -                       if (check_assertion_extended_permissions_avtab(na=
rule, avtab, i, j, k, p)) {
> +                       if (check_assertion_extended_permissions_avtab(na=
rule, i, j, k, p, conditional)) {
>                                 rc =3D 1;
>                                 goto exit;
>                         }
> @@ -578,7 +744,6 @@ static int check_assertion_avtab_match(avtab_key_t *k=
, avtab_datum_t *d, void *a
>         struct avtab_match_args *a =3D (struct avtab_match_args *)args;
>         policydb_t *p =3D a->p;
>         const avrule_t *narule =3D a->narule;
> -       avtab_t *avtab =3D a->avtab;
>
>         if ((k->specified & AVTAB_ALLOWED) =3D=3D 0)
>                 goto nomatch;
> @@ -611,7 +776,7 @@ static int check_assertion_avtab_match(avtab_key_t *k=
, avtab_datum_t *d, void *a
>         }
>
>         if (narule->specified =3D=3D AVRULE_XPERMS_NEVERALLOW) {
> -               rc =3D check_assertion_extended_permissions(narule, avtab=
, k, p);
> +               rc =3D check_assertion_extended_permissions(narule, k, p,=
 a->conditional);
>                 if (rc < 0)
>                         goto oom;
>                 if (rc =3D=3D 0)
> @@ -636,11 +801,11 @@ int check_assertion(policydb_t *p, const avrule_t *=
narule)
>                 .errors =3D 0,
>         };
>
> -       args.avtab =3D &p->te_avtab;
> +       args.conditional =3D false;
>         rc =3D avtab_map(&p->te_avtab, check_assertion_avtab_match, &args=
);
>
>         if (rc =3D=3D 0) {
> -               args.avtab =3D &p->te_cond_avtab;
> +               args.conditional =3D true;
>                 rc =3D avtab_map(&p->te_cond_avtab, check_assertion_avtab=
_match, &args);
>         }
>
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index e90ccca1..0747e789 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -208,6 +208,13 @@ static const struct policydb_compat_info policydb_co=
mpat[] =3D {
>          .ocon_num =3D OCON_IBENDPORT + 1,
>          .target_platform =3D SEPOL_TARGET_SELINUX,
>         },
> +       {
> +        .type =3D POLICY_KERN,
> +        .version =3D POLICYDB_VERSION_COND_XPERMS,
> +        .sym_num =3D SYM_NUM,
> +        .ocon_num =3D OCON_IBENDPORT + 1,
> +        .target_platform =3D SEPOL_TARGET_SELINUX,
> +       },
>         {
>          .type =3D POLICY_BASE,
>          .version =3D MOD_POLICYDB_VERSION_BASE,
> @@ -334,6 +341,13 @@ static const struct policydb_compat_info policydb_co=
mpat[] =3D {
>          .ocon_num =3D OCON_IBENDPORT + 1,
>          .target_platform =3D SEPOL_TARGET_SELINUX,
>         },
> +       {
> +        .type =3D POLICY_BASE,
> +        .version =3D MOD_POLICYDB_VERSION_COND_XPERMS,
> +        .sym_num =3D SYM_NUM,
> +        .ocon_num =3D OCON_IBENDPORT + 1,
> +        .target_platform =3D SEPOL_TARGET_SELINUX,
> +       },
>         {
>          .type =3D POLICY_MOD,
>          .version =3D MOD_POLICYDB_VERSION_BASE,
> @@ -460,6 +474,13 @@ static const struct policydb_compat_info policydb_co=
mpat[] =3D {
>          .ocon_num =3D 0,
>          .target_platform =3D SEPOL_TARGET_SELINUX,
>         },
> +       {
> +        .type =3D POLICY_MOD,
> +        .version =3D MOD_POLICYDB_VERSION_COND_XPERMS,
> +        .sym_num =3D SYM_NUM,
> +        .ocon_num =3D 0,
> +        .target_platform =3D SEPOL_TARGET_SELINUX,
> +       },
>  };
>
>  #if 0
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index 5035313b..3828ba82 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -903,7 +903,7 @@ static int validate_avtab_key(const avtab_key_t *key,=
 int conditional, const pol
>         case AVTAB_XPERMS_DONTAUDIT:
>                 if (p->target_platform !=3D SEPOL_TARGET_SELINUX)
>                         goto bad;
> -               if (conditional)
> +               if (conditional && !policydb_has_cond_xperms_feature(p))
>                         goto bad;
>                 break;
>         default:
> @@ -972,8 +972,16 @@ static int validate_avtab_key_and_datum(avtab_key_t =
*k, avtab_datum_t *d, void *
>         if ((k->specified & AVTAB_TYPE) && validate_simpletype(d->data, m=
args->policy, margs->flavors))
>                 return -1;
>
> -       if ((k->specified & AVTAB_XPERMS) && validate_xperms(d->xperms))
> -               return -1;
> +       if (k->specified & AVTAB_XPERMS) {
> +               uint32_t data =3D d->data;
> +
> +               /* checkpolicy does not touch data for xperms, CIL sets i=
t. */
> +               if (data !=3D 0 && validate_access_vector(margs->handle, =
margs->policy, k->target_class, data))
> +                       return -1;
> +
> +               if (validate_xperms(d->xperms))
> +                       return -1;
> +       }
>
>         return 0;
>  }
> @@ -992,28 +1000,13 @@ static int validate_avtab(sepol_handle_t *handle, =
const avtab_t *avtab, const po
>
>  static int validate_cond_av_list(sepol_handle_t *handle, const cond_av_l=
ist_t *cond_av, const policydb_t *p, validate_t flavors[])
>  {
> -       const struct avtab_node *avtab_ptr;
> -
> -       for (; cond_av; cond_av =3D cond_av->next) {
> -               for (avtab_ptr =3D cond_av->node; avtab_ptr; avtab_ptr =
=3D avtab_ptr->next) {
> -                       const avtab_key_t *key =3D &avtab_ptr->key;
> -                       const avtab_datum_t *datum =3D &avtab_ptr->datum;
> -
> -                       if (validate_avtab_key(key, 1, p, flavors))

validate_avtab_key_and_datum() calls validate_avtab_key(k, 0,
margs->policy, margs->flavors), so you won't be getting the exact same
thing when you replace all of this code with a call to it.

> -                               goto bad;
> -                       if (key->specified & AVTAB_AV) {
> -                               uint32_t data =3D datum->data;
> -
> -                               if ((0xFFF & key->specified) =3D=3D AVTAB=
_AUDITDENY)
> -                                       data =3D ~data;
> +       struct avtab_node *avtab_ptr;
> +       map_arg_t margs =3D { flavors, handle, p };
>
> -                               if (validate_access_vector(handle, p, key=
->target_class, data))
> -                                       goto bad;
> -                       }
> -                       if ((key->specified & AVTAB_TYPE) && validate_sim=
pletype(datum->data, p, flavors))
> +       for (; cond_av; cond_av =3D cond_av->next)
> +               for (avtab_ptr =3D cond_av->node; avtab_ptr; avtab_ptr =
=3D avtab_ptr->next)
> +                       if (validate_avtab_key_and_datum(&avtab_ptr->key,=
 &avtab_ptr->datum, &margs))

It seems like you need to add an argument for the conditional flag to
be passed to validate_avtab_key().

I've tested all the patches and the past issues have been corrected.

Thanks,
Jim


>                                 goto bad;
> -               }
> -       }
>
>         return 0;
>
> @@ -1046,7 +1039,7 @@ static int validate_avrules(sepol_handle_t *handle,=
 const avrule_t *avrule, int
>                 case AVRULE_XPERMS_AUDITALLOW:
>                 case AVRULE_XPERMS_DONTAUDIT:
>                 case AVRULE_XPERMS_NEVERALLOW:
> -                       if (conditional)
> +                       if (conditional && !policydb_has_cond_xperms_feat=
ure(p))
>                                 goto bad;
>                         break;
>                 default:
> diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> index a52e2e82..4ef98449 100644
> --- a/libsepol/src/write.c
> +++ b/libsepol/src/write.c
> @@ -56,7 +56,8 @@ struct policy_data {
>  };
>
>  static int avrule_write_list(policydb_t *p,
> -                            avrule_t * avrules, struct policy_file *fp);
> +                            avrule_t * avrules, struct policy_file *fp,
> +                            unsigned conditional);
>
>  static int ebitmap_write(ebitmap_t * e, struct policy_file *fp)
>  {
> @@ -104,7 +105,8 @@ static uint16_t spec_order[] =3D {
>
>  static int avtab_write_item(policydb_t * p,
>                             avtab_ptr_t cur, struct policy_file *fp,
> -                           unsigned merge, unsigned commit, uint32_t * n=
el)
> +                           unsigned merge, unsigned commit, unsigned con=
ditional,
> +                           uint32_t * nel)
>  {
>         avtab_ptr_t node;
>         uint8_t buf8;
> @@ -229,14 +231,20 @@ static int avtab_write_item(policydb_t * p,
>                 return POLICYDB_ERROR;
>         if ((p->policyvers < POLICYDB_VERSION_XPERMS_IOCTL) &&
>                         (cur->key.specified & AVTAB_XPERMS)) {
> -               ERR(fp->handle, "policy version %u does not support ioctl=
 extended"
> +               ERR(fp->handle, "policy version %u does not support exten=
ded"
>                                 "permissions rules and one was specified"=
, p->policyvers);
>                 return POLICYDB_ERROR;
>         }
>
> +       if (!policydb_has_cond_xperms_feature(p) && (cur->key.specified &=
 AVTAB_XPERMS) && conditional) {
> +               ERR(fp->handle, "policy version %u does not support exten=
ded"
> +                               "permissions rules in conditional policie=
s and one was specified", p->policyvers);
> +               return POLICYDB_ERROR;
> +       }
> +
>         if (p->target_platform !=3D SEPOL_TARGET_SELINUX &&
>                         (cur->key.specified & AVTAB_XPERMS)) {
> -               ERR(fp->handle, "Target platform %s does not support ioct=
l "
> +               ERR(fp->handle, "Target platform %s does not support "
>                                 "extended permissions rules and one was s=
pecified",
>                                 policydb_target_strings[p->target_platfor=
m]);
>                 return POLICYDB_ERROR;
> @@ -313,7 +321,7 @@ static int avtab_write(struct policydb *p, avtab_t * =
a, struct policy_file *fp)
>                 for (cur =3D a->htable[i]; cur; cur =3D cur->next) {
>                         /* If old format, compute final nel.
>                            If new format, write out the items. */
> -                       if (avtab_write_item(p, cur, fp, 1, !oldvers, &ne=
l)) {
> +                       if (avtab_write_item(p, cur, fp, 1, !oldvers, 0, =
&nel)) {
>                                 rc =3D -1;
>                                 goto out;
>                         }
> @@ -332,7 +340,7 @@ static int avtab_write(struct policydb *p, avtab_t * =
a, struct policy_file *fp)
>                 avtab_reset_merged(a);
>                 for (i =3D 0; i < a->nslot; i++) {
>                         for (cur =3D a->htable[i]; cur; cur =3D cur->next=
) {
> -                               if (avtab_write_item(p, cur, fp, 1, 1, NU=
LL)) {
> +                               if (avtab_write_item(p, cur, fp, 1, 1, 0,=
 NULL)) {
>                                         rc =3D -1;
>                                         goto out;
>                                 }
> @@ -795,7 +803,7 @@ static int cond_write_av_list(policydb_t * p,
>
>         for (cur_list =3D list; cur_list !=3D NULL; cur_list =3D cur_list=
->next) {
>                 if (cur_list->node->parse_context)
> -                       if (avtab_write_item(p, cur_list->node, fp, 0, 1,=
 NULL))
> +                       if (avtab_write_item(p, cur_list->node, fp, 0, 1,=
 1, NULL))
>                                 goto out;
>         }
>
> @@ -846,9 +854,9 @@ static int cond_write_node(policydb_t * p,
>                 if (cond_write_av_list(p, node->false_list, fp) !=3D 0)
>                         return POLICYDB_ERROR;
>         } else {
> -               if (avrule_write_list(p, node->avtrue_list, fp))
> +               if (avrule_write_list(p, node->avtrue_list, fp, 1))
>                         return POLICYDB_ERROR;
> -               if (avrule_write_list(p, node->avfalse_list, fp))
> +               if (avrule_write_list(p, node->avfalse_list, fp, 1))
>                         return POLICYDB_ERROR;
>         }
>
> @@ -1743,7 +1751,7 @@ static int range_write(policydb_t * p, struct polic=
y_file *fp)
>  /************** module writing functions below **************/
>
>  static int avrule_write(policydb_t *p, avrule_t * avrule,
> -                       struct policy_file *fp)
> +                       struct policy_file *fp, unsigned conditional)
>  {
>         size_t items, items2;
>         uint32_t buf[32], len;
> @@ -1801,15 +1809,23 @@ static int avrule_write(policydb_t *p, avrule_t *=
 avrule,
>
>                 if (p->policyvers < MOD_POLICYDB_VERSION_XPERMS_IOCTL) {
>                         ERR(fp->handle,
> -                           "module policy version %u does not support io=
ctl"
> +                           "module policy version %u does not support"
>                             " extended permissions rules and one was spec=
ified",
>                             p->policyvers);
>                         return POLICYDB_ERROR;
>                 }
>
> +               if (conditional && !policydb_has_cond_xperms_feature(p)) =
{
> +                       ERR(fp->handle,
> +                           "module policy version %u does not support"
> +                           " extended permissions rules in conditional p=
olicies and one was specified",
> +                           p->policyvers);
> +                       return POLICYDB_ERROR;
> +               }
> +
>                 if (p->target_platform !=3D SEPOL_TARGET_SELINUX) {
>                         ERR(fp->handle,
> -                           "Target platform %s does not support ioctl"
> +                           "Target platform %s does not support"
>                             " extended permissions rules and one was spec=
ified",
>                             policydb_target_strings[p->target_platform]);
>                         return POLICYDB_ERROR;
> @@ -1834,7 +1850,7 @@ static int avrule_write(policydb_t *p, avrule_t * a=
vrule,
>  }
>
>  static int avrule_write_list(policydb_t *p, avrule_t * avrules,
> -                            struct policy_file *fp)
> +                            struct policy_file *fp, unsigned conditional=
)
>  {
>         uint32_t buf[32], len;
>         avrule_t *avrule;
> @@ -1852,7 +1868,7 @@ static int avrule_write_list(policydb_t *p, avrule_=
t * avrules,
>
>         avrule =3D avrules;
>         while (avrule) {
> -               if (avrule_write(p, avrule, fp))
> +               if (avrule_write(p, avrule, fp, conditional))
>                         return POLICYDB_ERROR;
>                 avrule =3D avrule->next;
>         }
> @@ -2056,7 +2072,7 @@ static int avrule_decl_write(avrule_decl_t * decl, =
int num_scope_syms,
>                 return POLICYDB_ERROR;
>         }
>         if (cond_write_list(p, decl->cond_list, fp) =3D=3D -1 ||
> -           avrule_write_list(p, decl->avrules, fp) =3D=3D -1 ||
> +           avrule_write_list(p, decl->avrules, fp, 0) =3D=3D -1 ||
>             role_trans_rule_write(p, decl->role_tr_rules, fp) =3D=3D -1 |=
|
>             role_allow_rule_write(decl->role_allow_rules, fp) =3D=3D -1) =
{
>                 return POLICYDB_ERROR;
> --
> 2.45.2
>
>
