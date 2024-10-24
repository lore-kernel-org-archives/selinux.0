Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2010D1DD0D9
	for <selinux@vger.kernel.org>; Thu, 24 Oct 2024 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789647; cv=none; b=XERxGI5pIiPrzY76dScNzmcVpWjUHuHmHIayYMLRzOn/NxFmOl5rUGpnzifqGWw2TOk+rM/JGeqJeMzxkGfYPprV21BIIOP1Je4Cp9+uvxwCnGZv1m0CHmQfMxrxfdjyN0i4p9KgQ0iphuKU6kQXoE5v0vLlvzsCksdLG/2gV+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789647; c=relaxed/simple;
	bh=tGDp+G/YC8YsIXSEREIqL4/1VhY7PLFAb+5yGkg41sE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=mrd2H1cGIdQQ6CbQAbau0lS/RT0RCSdpweEaWvON62bUiOEQSjeXejM3fTmqzXD+DGWxw8mg2Y5ESPJT1z1iV+PcxLHckvysdfjoiUCE+KhoYBz1U2/IvKv0mcZU4CoDtrdqBUbVCidLJGS/J9bKfZR6N/boySGyiVSA8mmID1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=btNdmz38; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="btNdmz38"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6db20e22c85so10140527b3.0
        for <selinux@vger.kernel.org>; Thu, 24 Oct 2024 10:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1729789643; x=1730394443; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wURak6K9/lDxdl0phh1nPAIe8cDWxKVODItCMW2t/Xc=;
        b=btNdmz38miYyi1+2KvMY2kSmkI3MIxbtuVpV1s0J9e94ubKLLPmfwB1SVEHoKoeQNQ
         /X7RiVZmL+4z2myJ9JcOa9PVrtJhSA+01mY0F9B8BnmezVFzQoyh6KRnn9vkUWUX1/kG
         f9eVidk+fUflpNI38bbckyp0MwkF8lgMEQZOJdgWG0ZKyX+ZIPhvHuhps3tlFd1Eu1if
         x3mAsiJrUO3/8E1ePlevH8VCvG9mXrSUBmfrtcjK1VQ+WxdDKCB0s6iQbTH1aSZ2g37D
         fhG97nTtf8U8iUfyXdHV1QNWkK7VUU7DW8D4/JG/hSYKXuSqFvW7IaIUGL1l5viu9/df
         ns8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729789643; x=1730394443;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wURak6K9/lDxdl0phh1nPAIe8cDWxKVODItCMW2t/Xc=;
        b=PKVScpL36x/2LCTeuE9mnWkERZPlDH6robvxJZITelNZ9GRUv1Ymq24aVDiiIFZimK
         7nT24toZk9s8792BciSJLCpE9T7m5QBg0NbZUNRRbADXKDmLwgrVVnff6H2xj84nA4S5
         Tl/xVn75I5cPTxsa8dSDtHr9Mu+PsZYJLWk7/39zuu+jGKKRieWQPEX+Xpyy+uAo1/Ya
         zea3zgpmAOsmzvPCoK9GowR2THhFC8jyPijBjaQ4ZCs/wh6U6pKl4akBdCQWao9m6EWA
         yYKIXccIjMM/ZB8vyroniSjEa995/2CGpIfJjmYhJmA53sqEg+HneAibE66hXGWBs4fD
         hTiQ==
X-Gm-Message-State: AOJu0Yy6wW/h6KJbnJROXyKQicAJFjMOUHkFhsu1bFbW9MBuRoSOtii4
	E24hbIHr6m3j8RVbLuW7X20RqQ4XuZwp3aUmWH5vzap3ij9u/uQgWbTynoYSTcauf4uBNvZIFgN
	meCC8ejHaS940tlSyyfqsGJOrV8cPX9EUMbU=
X-Google-Smtp-Source: AGHT+IFjp8zj03uSceXsnqpFcgHdY0SNE1MdF94F45LKK1vEewhKn8Cn4T0bkZixZwxYuTXyzTWtuXS4RWPb7lymw5A=
X-Received: by 2002:a05:690c:3512:b0:6e3:2c80:5413 with SMTP id
 00721157ae682-6e8581842f8mr35189657b3.23.1729789642776; Thu, 24 Oct 2024
 10:07:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024160140.71347-1-cgoettsche@seltendoof.de> <20241024160140.71347-2-cgoettsche@seltendoof.de>
In-Reply-To: <20241024160140.71347-2-cgoettsche@seltendoof.de>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Thu, 24 Oct 2024 19:07:11 +0200
Message-ID: <CAJ2a_Dc+f7zO_MHVTULiRQz4JRhtcaax+OE1Xw8L=7FbxyezsA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] libsepol: add support for xperms in conditional policies
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Oct 2024 at 18:01, Christian G=C3=B6ttsche
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
> v2:
>   - rebase onto libsepol: Support nlmsg xperms in assertions
>   - fix assertion checking with xperm av rules in conditional policies
>     (spotted by Jim, thanks!)

Still not finished, fails to assert on the following (since it is
checked whether there exists an enabled and disabled rule, but not if
they are under the same condition):

allow TYPE1 TYPE2 : CLASS1 ioctl;
if BOOL1 {
  allowxperm TYPE1 TYPE2 : CLASS1 ioctl 0x1;
}
if !BOOL2 {
  allowxperm TYPE1 TYPE2 : CLASS1 ioctl 0x1;
}
neverallowxperm TYPE1 TYPE2 : CLASS1 ioctl 0x4;

> ---
>  libsepol/include/sepol/policydb/policydb.h | 12 ++-
>  libsepol/src/assertion.c                   | 86 +++++++++++++++++-----
>  libsepol/src/policydb.c                    | 21 ++++++
>  libsepol/src/policydb_validate.c           |  4 +-
>  libsepol/src/write.c                       | 46 ++++++++----
>  5 files changed, 131 insertions(+), 38 deletions(-)
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
> index 71faa3b2..5765d9e5 100644
> --- a/libsepol/src/assertion.c
> +++ b/libsepol/src/assertion.c
> @@ -32,7 +32,6 @@ struct avtab_match_args {
>         sepol_handle_t *handle;
>         policydb_t *p;
>         const avrule_t *narule;
> -       avtab_t *avtab;
>         unsigned long errors;
>  };
>
> @@ -160,7 +159,7 @@ static int report_assertion_extended_permissions(sepo=
l_handle_t *handle,
>                                 policydb_t *p, const avrule_t *avrule,
>                                 unsigned int stype, unsigned int ttype,
>                                 const class_perm_node_t *curperm, uint32_=
t perms,
> -                               const avtab_key_t *k, avtab_t *avtab)
> +                               const avtab_key_t *k)
>  {
>         avtab_ptr_t node;
>         avtab_key_t tmp_key;
> @@ -171,7 +170,7 @@ static int report_assertion_extended_permissions(sepo=
l_handle_t *handle,
>         ebitmap_node_t *snode, *tnode;
>         unsigned int i, j;
>         int rc;
> -       int found_xperm =3D 0;
> +       int found_xperm =3D 0, found_enabled_xperm =3D 0, found_disabled_=
xperm =3D 0;
>         int errors =3D 0;
>
>         memcpy(&tmp_key, k, sizeof(avtab_key_t));
> @@ -181,7 +180,7 @@ static int report_assertion_extended_permissions(sepo=
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
> @@ -210,11 +209,45 @@ static int report_assertion_extended_permissions(se=
pol_handle_t *handle,
>                                         errors++;
>                                 }
>                         }
> +
> +                       for (node =3D avtab_search_node(&p->te_cond_avtab=
, &tmp_key);
> +                            node;
> +                            node =3D avtab_search_node_next(node, tmp_ke=
y.specified)) {
> +                               xperms =3D node->datum.xperms;
> +                               if ((xperms->specified !=3D AVTAB_XPERMS_=
IOCTLFUNCTION)
> +                                               && (xperms->specified !=
=3D AVTAB_XPERMS_IOCTLDRIVER)
> +                                               && (xperms->specified !=
=3D AVTAB_XPERMS_NLMSG))
> +                                       continue;
> +                               if (node->key.specified & AVTAB_ENABLED) =
{
> +                                       found_enabled_xperm =3D 1;
> +                               } else {
> +                                       found_disabled_xperm =3D 1;
> +                               }
> +                               rc =3D check_extended_permissions(avrule-=
>xperms, xperms);
> +                               /* failure on the extended permission che=
ck_extended_permissions */
> +                               if (rc) {
> +                                       char *permstring;
> +
> +                                       extended_permissions_violated(&er=
ror, avrule->xperms, xperms);
> +                                       permstring =3D sepol_extended_per=
ms_to_string(&error);
> +
> +                                       ERR(handle, "neverallowxperm on l=
ine %lu of %s (or line %lu of %s) violated by\n"
> +                                                       "allowxperm %s %s=
:%s %s;",
> +                                                       avrule->source_li=
ne, avrule->source_filename, avrule->line, policy_name(p),
> +                                                       p->p_type_val_to_=
name[i],
> +                                                       p->p_type_val_to_=
name[j],
> +                                                       p->p_class_val_to=
_name[curperm->tclass - 1],
> +                                                       permstring ?: "<f=
ormat-failure>");
> +
> +                                       free(permstring);
> +                                       errors++;
> +                               }
> +                       }
>                 }
>         }
>
>         /* failure on the regular permissions */
> -       if (!found_xperm) {
> +       if (!found_xperm && (!found_enabled_xperm || !found_disabled_xper=
m)) {
>                 char *permstr =3D sepol_av_to_string(p, curperm->tclass, =
perms);
>
>                 ERR(handle, "neverallowxperm on line %lu of %s (or line %=
lu of %s) violated by\n"
> @@ -239,7 +272,6 @@ static int report_assertion_avtab_matches(avtab_key_t=
 *k, avtab_datum_t *d, void
>         struct avtab_match_args *a =3D (struct avtab_match_args *)args;
>         sepol_handle_t *handle =3D a->handle;
>         policydb_t *p =3D a->p;
> -       avtab_t *avtab =3D a->avtab;
>         const avrule_t *narule =3D a->narule;
>         const class_perm_node_t *cp;
>         uint32_t perms;
> @@ -313,7 +345,7 @@ static int report_assertion_avtab_matches(avtab_key_t=
 *k, avtab_datum_t *d, void
>                                         continue;
>                                 if (narule->specified =3D=3D AVRULE_XPERM=
S_NEVERALLOW) {
>                                         a->errors +=3D report_assertion_e=
xtended_permissions(handle,p, narule,
> -                                                                        =
               i, j, cp, perms, k, avtab);
> +                                                                        =
               i, j, cp, perms, k);
>                                 } else {
>                                         a->errors++;
>                                         report_failure(handle, p, narule,=
 i, j, cp, perms);
> @@ -340,12 +372,10 @@ static int report_assertion_failures(sepol_handle_t=
 *handle, policydb_t *p, cons
>         args.narule =3D narule;
>         args.errors =3D 0;
>
> -       args.avtab =3D  &p->te_avtab;
>         rc =3D avtab_map(&p->te_avtab, report_assertion_avtab_matches, &a=
rgs);
>         if (rc < 0)
>                 goto oom;
>
> -       args.avtab =3D  &p->te_cond_avtab;
>         rc =3D avtab_map(&p->te_cond_avtab, report_assertion_avtab_matche=
s, &args);
>         if (rc < 0)
>                 goto oom;
> @@ -360,7 +390,7 @@ oom:
>   * Look up the extended permissions in avtab and verify that neverallowe=
d
>   * permissions are not granted.
>   */
> -static int check_assertion_extended_permissions_avtab(const avrule_t *na=
rule, avtab_t *avtab,
> +static int check_assertion_extended_permissions_avtab(const avrule_t *na=
rule,
>                                                 unsigned int stype, unsig=
ned int ttype,
>                                                 const avtab_key_t *k, pol=
icydb_t *p)
>  {
> @@ -372,7 +402,8 @@ static int check_assertion_extended_permissions_avtab=
(const avrule_t *narule, av
>         const ebitmap_t *tattr =3D &p->type_attr_map[ttype];
>         ebitmap_node_t *snode, *tnode;
>         unsigned int i, j;
> -       int rc =3D 1;
> +       int found_xperm =3D 0, found_enabled_xperm =3D 0, found_disabled_=
xperm =3D 0;
> +       int rc;
>
>         memcpy(&tmp_key, k, sizeof(avtab_key_t));
>         tmp_key.specified =3D AVTAB_XPERMS_ALLOWED;
> @@ -381,7 +412,22 @@ static int check_assertion_extended_permissions_avta=
b(const avrule_t *narule, av
>                 tmp_key.source_type =3D i + 1;
>                 ebitmap_for_each_positive_bit(tattr, tnode, j) {
>                         tmp_key.target_type =3D j + 1;
> -                       for (node =3D avtab_search_node(avtab, &tmp_key);
> +                       for (node =3D avtab_search_node(&p->te_avtab, &tm=
p_key);
> +                            node;
> +                            node =3D avtab_search_node_next(node, tmp_ke=
y.specified)) {
> +                               xperms =3D node->datum.xperms;
> +
> +                               if ((xperms->specified !=3D AVTAB_XPERMS_=
IOCTLFUNCTION)
> +                                               && (xperms->specified !=
=3D AVTAB_XPERMS_IOCTLDRIVER)
> +                                               && (xperms->specified !=
=3D AVTAB_XPERMS_NLMSG))
> +                                       continue;
> +                               found_xperm =3D 1;
> +                               rc =3D check_extended_permissions(neveral=
low_xperms, xperms);
> +                               if (rc)
> +                                       return rc;
> +                       }
> +
> +                       for (node =3D avtab_search_node(&p->te_cond_avtab=
, &tmp_key);
>                              node;
>                              node =3D avtab_search_node_next(node, tmp_ke=
y.specified)) {
>                                 xperms =3D node->datum.xperms;
> @@ -390,6 +436,11 @@ static int check_assertion_extended_permissions_avta=
b(const avrule_t *narule, av
>                                                 && (xperms->specified !=
=3D AVTAB_XPERMS_IOCTLDRIVER)
>                                                 && (xperms->specified !=
=3D AVTAB_XPERMS_NLMSG))
>                                         continue;
> +                               if (node->key.specified & AVTAB_ENABLED) =
{
> +                                       found_enabled_xperm =3D 1;
> +                               } else {
> +                                       found_disabled_xperm =3D 1;
> +                               }
>                                 rc =3D check_extended_permissions(neveral=
low_xperms, xperms);
>                                 if (rc)
>                                         return rc;
> @@ -397,7 +448,7 @@ static int check_assertion_extended_permissions_avtab=
(const avrule_t *narule, av
>                 }
>         }
>
> -       return rc;
> +       return !found_xperm && (!found_enabled_xperm || !found_disabled_x=
perm);
>  }
>
>  /*
> @@ -416,7 +467,7 @@ static int check_assertion_extended_permissions_avtab=
(const avrule_t *narule, av
>   * 4. FAIL - The ioctl permission is granted AND the extended permission=
 is
>   *    granted
>   */
> -static int check_assertion_extended_permissions(const avrule_t *narule, =
avtab_t *avtab,
> +static int check_assertion_extended_permissions(const avrule_t *narule,
>                                                 const avtab_key_t *k, pol=
icydb_t *p)
>  {
>         ebitmap_t src_matches, tgt_matches, self_matches;
> @@ -479,7 +530,7 @@ static int check_assertion_extended_permissions(const=
 avrule_t *narule, avtab_t
>                                 continue;
>                         if (is_narule_notself && i =3D=3D j)
>                                 continue;
> -                       if (check_assertion_extended_permissions_avtab(na=
rule, avtab, i, j, k, p)) {
> +                       if (check_assertion_extended_permissions_avtab(na=
rule, i, j, k, p)) {
>                                 rc =3D 1;
>                                 goto exit;
>                         }
> @@ -583,7 +634,6 @@ static int check_assertion_avtab_match(avtab_key_t *k=
, avtab_datum_t *d, void *a
>         struct avtab_match_args *a =3D (struct avtab_match_args *)args;
>         policydb_t *p =3D a->p;
>         const avrule_t *narule =3D a->narule;
> -       avtab_t *avtab =3D a->avtab;
>
>         if ((k->specified & AVTAB_ALLOWED) =3D=3D 0)
>                 goto nomatch;
> @@ -616,7 +666,7 @@ static int check_assertion_avtab_match(avtab_key_t *k=
, avtab_datum_t *d, void *a
>         }
>
>         if (narule->specified =3D=3D AVRULE_XPERMS_NEVERALLOW) {
> -               rc =3D check_assertion_extended_permissions(narule, avtab=
, k, p);
> +               rc =3D check_assertion_extended_permissions(narule, k, p)=
;
>                 if (rc < 0)
>                         goto oom;
>                 if (rc =3D=3D 0)
> @@ -639,13 +689,11 @@ int check_assertion(policydb_t *p, const avrule_t *=
narule)
>                 .p =3D p,
>                 .narule =3D narule,
>                 .errors =3D 0,
> -               .avtab =3D &p->te_avtab,
>         };
>
>         rc =3D avtab_map(&p->te_avtab, check_assertion_avtab_match, &args=
);
>
>         if (rc =3D=3D 0) {
> -               args.avtab =3D &p->te_cond_avtab;
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
