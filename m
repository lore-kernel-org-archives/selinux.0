Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8D515B0EE
	for <selinux@vger.kernel.org>; Wed, 23 Oct 2024 21:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717432; cv=none; b=I2WPanSauh/ytvUgxoffFANWzKlfgJpXCt4SFKGMtFYiQ/dO59zS/AOZF30CDpGYJlB277m+4TKVlREctQe/7Ki3hAbNXxTM/1OzdsMZhSK4HeK6mvF066/nZzw7xN0ILfr14mcDJIG8+DztbxZpJyUfiIkkjmBPudIGzvw5lOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717432; c=relaxed/simple;
	bh=Bcfl9ZPiSz/zqiCvud05feI51ih/PAjh2sHLV6qU6d4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2Vt3cW4qhFJ984qsPu3aSiD9rAFJyX5ayv1utjAOoac0sE/XLuWwvY9+ZA5CZ7NQJY0GMN2i2ZsDkq9ln/xAYGnsgZ4sfg+rNfcFabeEvrXmvkMZo7Y9Qv76Km91DR5L0am4eU4UcA1IqFHYd1dndyts137oCjCsCbOlBNcoug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHl/9x39; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHl/9x39"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b14077ec5aso122611085a.1
        for <selinux@vger.kernel.org>; Wed, 23 Oct 2024 14:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729717430; x=1730322230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufaVKuX2ErkkSnZ6umB1YhtvjCG2izteK9+9DpU0jkY=;
        b=kHl/9x39aQRi+aVOnHxJi2CBtRBFZP4T5rJQfQOeLa/1eTNFW2LnheXbTHEwKoH3UW
         3XRekLBX1f54g2S5t8vi/en93rz/V5CaU+D30RPuWkPVeHO3ka2RU/phWa8fd7c3nOv6
         dLAqA/KI8jsFW1LfbMkFyFqwOLQINWArC9asHe+lEt07spw6GE3sEfylZxPPF4yF3OA8
         WixuV1HEBzoqTPFLwC/qepjiX2TKy+yHYeDao+1/vRv6ZZ/N9NgD3kJELFWaTwiHFZW/
         hkDMq5Qi4sb3HR3+Ag/r5va5qO+rr1DgQY1sE2zHNJUJUC1M7hZMS2HtcObbE41Cn4GD
         W9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729717430; x=1730322230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufaVKuX2ErkkSnZ6umB1YhtvjCG2izteK9+9DpU0jkY=;
        b=qoys7XZrUfq/6fvl5KVy0gFo7tv8/000meiBNokbZLc46vYor/HSE//3OwwqVsyKmz
         X5KNGhtwmKsKFIRteaYt+zy1oO68qtwGXfDNz0BZu/04zG7UFEE1r7e55z5Astrp+rvw
         B1kPgVdm2QTF4tqp5/4slA5Sg/2us4wB6J6VonaEPcjVjB69NsX8//z6729+Lhft4xDb
         +DFqomEhqEDtNVNKmCH4SZpnG12VLfq9cFf9msYrtIXfgpBfUKvxiQccL0Sl5r8AwQYv
         H/rUe5t0WFwxDqoKZzr0jqNmGKAd03lVCeRrYJHSdQ0P16JT4pVc/Xt5s5kvlc24sfbc
         eABw==
X-Gm-Message-State: AOJu0Yz978oirpw5pBOcAv2EjJYgTRYuvpcMCrSWFC5mXt6Bs2qfYccM
	hj81xkPans6W1vio/48dce3wFaPAwiQg1OsGjGUea9IIaS7/GyI1prbPNi+Ph7dqVqUkdfyHMcB
	pqv83glXtTD8eoKyf4CVTn/yApvsQNikX
X-Google-Smtp-Source: AGHT+IE9F8QgmRGigshxQSX4OAXgYFCSPPfGrIvkBW1ER3QYHB3HDlHgYPOohxhLCVedXWh47ZHgmC63ivayYBFNCdg=
X-Received: by 2002:a05:6214:21c9:b0:6cb:440c:c44 with SMTP id
 6a1803df08f44-6ce21790658mr148900326d6.1.1729717429529; Wed, 23 Oct 2024
 14:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023172044.98572-1-cgoettsche@seltendoof.de>
In-Reply-To: <20241023172044.98572-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 23 Oct 2024 17:03:38 -0400
Message-ID: <CAP+JOzQXsn-r+SVUXw4twAuzf1H1j10Z48zPc58HHZBJxRaUdg@mail.gmail.com>
Subject: Re: [PATCH 1/3] libsepol: add support for xperms in conditional policies
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 1:21=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Add support for extended permission rules in conditional policies by
> adding a new policy version and adjusting writing and validating
> policies accordingly.


Some changes are going to be needed to the assertion checking for this.

optional work as expected.
boolean if's work if everything is in one branch, but problems occur
if they are not.

A couple of examples that fail

if bb04 {
  allow tp41 tpx : clx ioctl;
} else {
  allowxperm tp41 tpx : clx ioctl 0x1101;
}
neverallowxperm tp41 tpx : clx ioctl 0x4101;
This should be an assertion failure, but is not.

allow tp51 tpx : clx ioctl;
if bb05 {
  allowxperm tp51 tpx : clx ioctl 0x1101;
} else {
  allowxperm tp51 tpx : clx ioctl 0x1101;
}
neverallowxperm tp51 tpx : clx ioctl 0x4101;
This should not be an assertion failure, but is.

Thanks,
Jim


>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/include/sepol/policydb/policydb.h | 12 +++++-
>  libsepol/src/policydb.c                    | 21 ++++++++++
>  libsepol/src/policydb_validate.c           |  4 +-
>  libsepol/src/write.c                       | 46 +++++++++++++++-------
>  4 files changed, 64 insertions(+), 19 deletions(-)
>
> diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/includ=
e/sepol/policydb/policydb.h
> index f73e21fc..ccff4d71 100644
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
> index 5035313b..e021e025 100644
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
> @@ -1046,7 +1046,7 @@ static int validate_avrules(sepol_handle_t *handle,=
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
