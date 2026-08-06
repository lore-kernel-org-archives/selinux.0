Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1289435C190
	for <selinux@vger.kernel.org>; Thu,  6 Aug 2026 15:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030203; cv=pass; b=KoUBHdIdyvMO5ofKM5enUwoBUEfxlWQ2QMF/JEXiloOgqF36oDZ89Hxak7dC/9Q/cNMgfeApZtaX6q+wQEQYY8B0fEiUxZtgkp2O1Nk4YbGV582pC0hL/mJoB6FZjaWQi4/0MbwYYBN4GduKCyyjzpQB9eSzIX2aU9mZgO47KqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030203; c=relaxed/simple;
	bh=YxQJH1xjIZw8i8lQrAXwCtYMDb3H/x/clKgPUKneh7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2S59EzVgfwuJsgyzGfg7fJy1wozdwA/mRrxjciK4FWWoRqGClACJCgL+ifKmCCqcTEC3j+Ss62Lfc2V2NrpeT1aF85ilNTPuAQ1IJQJRyPsp5oxUK0JDYF1y5jHWoP0FkMcT213omgRlhKUf0M5l4a9vt3cZ4jp+uA9FNnnIg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABl9Wc1w; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABl9Wc1w"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aea0fff535so2601812e87.3
        for <selinux@vger.kernel.org>; Thu, 06 Aug 2026 08:29:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786030198; cv=none;
        d=google.com; s=arc-20260327;
        b=GodMoSHdzOdcCQaJpe5f9XFs6n71jMticYcZGScZ39rPTlWH2TsePlLb7RE6bDLgde
         T4mwLBZXf+4HRE4R2ONHb2u0Gqr8e8r/OMWPI3LBT2S5Sx2CR/Kh91poDoXpPwuC7oIj
         Yz9rD/JmmjY2QwJ1VxNykneDFwwJRThAWsHgXJoAPFZjYL2xbhsyNFC0g80E48JJX/m7
         71E3idKnXXA5qU2jzuV0GMzHmb3bxNGkOnDeHKy771hEUF+g6f8qavk46F75Eed2vZB/
         bslcOvpruTj7e4mDd7dvFf5nsQKdn6L1V2vMVX6I/72YrcgB4Ghx2TyTNgpyFLJwC+Wf
         dgPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=odxWTDUYreKGyVl3rzYLX8PlMynEO5T8DXPFQWUNn/Q=;
        fh=5nMwbpmQ58B5CaD7V3jaLqse69jqPAIvV9MWOzRIojA=;
        b=GbThbA34lJR+4h4TX0++IFXKUfDfxsDTrXhY04M5uG7gSEMghoOwqg1te9+T+mWBNA
         pPejnADUrefjDSOwpP4um3A8U3aBpyByLpZAA46NfM5WZ5/aEEG0Xy68zXp3HDetYx9u
         QuA+9N1pjmHF7EllUnpKNO43NpdUJ/jWGQ3cyzsmQpWWg8/M1DTCu39tE/klaXESqC7d
         dwudFgZCOnfYxNk1PrWcU5KfL/Jl2PNdiSD2Fv+DuEFicIODPSmtNCBvk4w/p4D0p8X1
         7apVDU0Bi2Q++m+siUmQe3biNyuAHqlHQ37UIdRyWyGBziMgrmR1fQqVH958ZhIZ+N0M
         UELQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786030198; x=1786634998; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=odxWTDUYreKGyVl3rzYLX8PlMynEO5T8DXPFQWUNn/Q=;
        b=ABl9Wc1w9xowB54F0FB2YfslNYORkOAlpm4sghH/3U6BHmKBXyJ7owq2w+tGrTxams
         loYHDraTm0SlH0sWUeoWlfguBUsgw0eFQDbimRYKLg6TnaJIn0Lkd4rReRX9SFCS6Of7
         bQg1wKYGMG5YxX84ihqGvYe8wnFIeZTpCVDZbHh9ISV85lsr5ZRtlDnTruc8pMTVbRtu
         XYPyxT1vmiK6Vlp/p+0bLeMDvCOQ1XUr6L2HOqY0RoYgJ28ktRqR7bTQ9BZzT1IUP3Iu
         2gZnsdTl9+0HbpAvOk1FG2e+1v8T7IRC1qCyIn8szSMcYeah+GkaEd8+76uSwRDM5UOg
         9MlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786030198; x=1786634998;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=odxWTDUYreKGyVl3rzYLX8PlMynEO5T8DXPFQWUNn/Q=;
        b=BFewhzJCN3dxj9LViO819R4iHFrutAR0P/0NlTMxPuqVg6Xm1yS707G3KxDQNv28sL
         oq1Bnbp5xkiMuGpm+MpcEfOjrV8LWtHm8BcQsECmD6Uap0oyo9o+nN6zGsJRuazOTNOU
         dXXN/av5maMMhHsxBAfI9Z+CZi4p/pv49LsfCvucUnCq6RXEGzHVdj5NBH6O1gscdrYs
         KRdlNjAt0Kd7dtsfrMXrJHg6pPVI2+Gm8Bgu846hZyCV2MJ7MI4EKSF/4R6JY2p85gzn
         brAjgI/vbkMocfClCzYiUYHd/C0DbrMMcSe2d4F7a/NuTgd+mJTDMYVCfjROPvBEOqRH
         pXHw==
X-Gm-Message-State: AOJu0Yxa/kduFgv0/E58bz9mYz3hCgk2JgOZY1OXyRyqOGFAdJNEEM8q
	y1ElzN8dxjj/1KRbFf3HPM8L4qVnYPXvuFSu0qa01NPUzUn99wGozGVLnmUNhjxbgJ97FT0q3K0
	Zo305yBXZWTtFQhR+qSiDVY2hEItoeWntgRLk
X-Gm-Gg: AR+sD11nBMbAHOcz1tH9bqVCEE+ZqFuK0ktX7qN5NSvdjpm3KqjkdHVdGu7TgzOdpNj
	I1Ep0zPpP8VncG1DTkI73+7+9wyvexbeWWrLJuYQBS74s5n4YSP2rHJtN+ESL854IRMA6b4A/rZ
	opNdbklu27lhF/QyNbsD4hno0R3UsYtTxr0+cdnPawWTJ+j8otdQYVfHCTQRjCbzDkKbH4QysPw
	FMFKkbeqonJksj5gd/sFwXvjjt/GogXPSIKTpLzk2wkmhPAaRbgoCg+86oU1paznV0ZVXZlOuR8
	Bi/Ca4KeElq471QYpnMZv4S/jXIGCmOLJMbzY+KDmA==
X-Received: by 2002:a2e:bc86:0:b0:39f:7feb:a07 with SMTP id
 38308e7fff4ca-39fbb1e7e91mr18090181fa.24.1786030197568; Thu, 06 Aug 2026
 08:29:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805191438.77935-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260805191438.77935-2-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 6 Aug 2026 11:29:46 -0400
X-Gm-Features: AUfX_mxXohYD88fsnCBwodl1nqGmWrId0ppS9ufWDbCOmimBt-cWvqy5bXJ8Neg
Message-ID: <CAP+JOzTTwarKFCiaOmKfcT+M6V_uShJuD3EMfNCWNgfxcsDLag@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol,checkpolicy: drop support for kernel policy
 versions < 24
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com, Chen Gong <reister@ruc.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 3:15=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Given the recently reported bugs in libsepol's support for policy
> versions 20 through 23, let's drop support for kernel policy versions
> < 24. This also aligns the minimum SELinux kernel policy version with
> the minimum Xen policy version. This makes libsepol's minimum
> supported kernel version v2.6.28 which is older than the v3.0 minimum
> we already set for libselinux.
>
> Reported-by: Chen Gong <reister@ruc.edu.cn>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v2 fixes up a duplicated validate_filename_trans_hashtab() call and
> an incorrectly removed mls check for binary modules.
>
>  checkpolicy/checkpolicy.c                  |  14 +-
>  libsepol/include/sepol/policydb/policydb.h |  12 +-
>  libsepol/src/avtab.c                       |  92 +------
>  libsepol/src/kernel_to_common.c            |  13 -
>  libsepol/src/optimize.c                    |  13 -
>  libsepol/src/policydb.c                    | 129 ++-------
>  libsepol/src/policydb_validate.c           |  43 +--
>  libsepol/src/write.c                       | 290 ++-------------------
>  libsepol/tests/test-downgrade.c            |   7 -
>  9 files changed, 64 insertions(+), 549 deletions(-)
>
> diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
> index c1b33869..b5a6da3a 100644
> --- a/checkpolicy/checkpolicy.c
> +++ b/checkpolicy/checkpolicy.c
> @@ -605,18 +605,8 @@ int main(int argc, char **argv)
>                         }
>                 }
>
> -               if (policydbp->policyvers <=3D POLICYDB_VERSION_PERMISSIV=
E) {
> -                       if (policyvers > policydbp->policyvers) {
> -                               fprintf(stderr,
> -                                       "Binary policies with version <=
=3D %u cannot be upgraded\n",
> -                                       POLICYDB_VERSION_PERMISSIVE);
> -                       } else if (policyvers) {
> -                               policydbp->policyvers =3D policyvers;
> -                       }
> -               } else {
> -                       policydbp->policyvers =3D
> -                               policyvers ? policyvers : POLICYDB_VERSIO=
N_MAX;
> -               }
> +               policydbp->policyvers =3D policyvers ? policyvers :
> +                                                    POLICYDB_VERSION_MAX=
;
>         } else {
>                 if (conf) {
>                         fprintf(stderr,
> diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/includ=
e/sepol/policydb/policydb.h
> index a1b5e99b..985a496e 100644
> --- a/libsepol/include/sepol/policydb/policydb.h
> +++ b/libsepol/include/sepol/policydb/policydb.h
> @@ -750,16 +750,6 @@ extern int policydb_set_target_platform(policydb_t *=
p, int platform);
>  #define PERM_SYMTAB_SIZE 32
>
>  /* Identify specific policy version changes */
> -#define POLICYDB_VERSION_BASE 15
> -#define POLICYDB_VERSION_BOOL 16
> -#define POLICYDB_VERSION_IPV6 17
> -#define POLICYDB_VERSION_NLCLASS 18
> -#define POLICYDB_VERSION_VALIDATETRANS 19
> -#define POLICYDB_VERSION_MLS 19
> -#define POLICYDB_VERSION_AVTAB 20
> -#define POLICYDB_VERSION_RANGETRANS 21
> -#define POLICYDB_VERSION_POLCAP 22
> -#define POLICYDB_VERSION_PERMISSIVE 23
>  #define POLICYDB_VERSION_BOUNDARY 24
>  #define POLICYDB_VERSION_FILENAME_TRANS 25
>  #define POLICYDB_VERSION_ROLETRANS 26
> @@ -776,7 +766,7 @@ extern int policydb_set_target_platform(policydb_t *p=
, int platform);
>  #define POLICYDB_VERSION_NEVERAUDIT 35 /* neveraudit domains */
>
>  /* Range of policy versions we understand*/
> -#define POLICYDB_VERSION_MIN POLICYDB_VERSION_BASE
> +#define POLICYDB_VERSION_MIN POLICYDB_VERSION_BOUNDARY
>  #define POLICYDB_VERSION_MAX POLICYDB_VERSION_NEVERAUDIT
>
>  /* Module versions and specific changes*/
> diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
> index 4a81e551..2bb67599 100644
> --- a/libsepol/src/avtab.c
> +++ b/libsepol/src/avtab.c
> @@ -417,23 +417,14 @@ void avtab_hash_eval(avtab_t *h, char *tag)
>                tag, h->nel, slots_used, h->nslot, max_chain_len);
>  }
>
> -/* Ordering of datums in the original avtab format in the policy file. *=
/
> -static const uint16_t spec_order[] =3D {
> -       AVTAB_ALLOWED,         AVTAB_AUDITDENY,
> -       AVTAB_AUDITALLOW,      AVTAB_TRANSITION,
> -       AVTAB_CHANGE,          AVTAB_MEMBER,
> -       AVTAB_XPERMS_ALLOWED,  AVTAB_XPERMS_AUDITALLOW,
> -       AVTAB_XPERMS_DONTAUDIT
> -};
> -
>  int avtab_read_item(struct policy_file *fp, uint32_t vers, avtab_t *a,
>                     int (*insertf)(avtab_t *a, avtab_key_t *k, avtab_datu=
m_t *d,
>                                    void *p),
>                     void *p)
>  {
>         uint8_t buf8;
> -       uint16_t buf16[4], enabled;
> -       uint32_t buf32[8], items, items2, val;
> +       uint16_t buf16[4];
> +       uint32_t buf32[8], items;
>         avtab_key_t key;
>         avtab_datum_t datum;
>         avtab_extended_perms_t xperms;
> @@ -444,85 +435,6 @@ int avtab_read_item(struct policy_file *fp, uint32_t=
 vers, avtab_t *a,
>         memset(&datum, 0, sizeof(avtab_datum_t));
>         memset(&xperms, 0, sizeof(avtab_extended_perms_t));
>
> -       if (vers < POLICYDB_VERSION_AVTAB) {
> -               rc =3D next_entry(buf32, fp, sizeof(uint32_t));
> -               if (rc < 0) {
> -                       ERR(fp->handle, "truncated entry");
> -                       return -1;
> -               }
> -               items2 =3D le32_to_cpu(buf32[0]);
> -
> -               if (items2 < 5 || items2 > ARRAY_SIZE(buf32)) {
> -                       ERR(fp->handle, "invalid item count");
> -                       return -1;
> -               }
> -
> -               rc =3D next_entry(buf32, fp, sizeof(uint32_t) * items2);
> -               if (rc < 0) {
> -                       ERR(fp->handle, "truncated entry");
> -                       return -1;
> -               }
> -
> -               items =3D 0;
> -               val =3D le32_to_cpu(buf32[items++]);
> -               key.source_type =3D (uint16_t)val;
> -               if (key.source_type !=3D val) {
> -                       ERR(fp->handle, "truncated source type");
> -                       return -1;
> -               }
> -               val =3D le32_to_cpu(buf32[items++]);
> -               key.target_type =3D (uint16_t)val;
> -               if (key.target_type !=3D val) {
> -                       ERR(fp->handle, "truncated target type");
> -                       return -1;
> -               }
> -               val =3D le32_to_cpu(buf32[items++]);
> -               key.target_class =3D (uint16_t)val;
> -               if (key.target_class !=3D val) {
> -                       ERR(fp->handle, "truncated target class");
> -                       return -1;
> -               }
> -
> -               val =3D le32_to_cpu(buf32[items++]);
> -               enabled =3D (val & AVTAB_ENABLED_OLD) ? AVTAB_ENABLED : 0=
;
> -
> -               if (!(val & (AVTAB_AV | AVTAB_TYPE))) {
> -                       ERR(fp->handle, "null entry");
> -                       return -1;
> -               }
> -               if ((val & AVTAB_AV) && (val & AVTAB_TYPE)) {
> -                       ERR(fp->handle, "entry has both access "
> -                                       "vectors and types");
> -                       return -1;
> -               }
> -
> -               for (i =3D 0; i < ARRAY_SIZE(spec_order); i++) {
> -                       if (val & spec_order[i]) {
> -                               if (items >=3D
> -                                   items2) { /* items is index, items2 i=
s total number */
> -                                       ERR(fp->handle,
> -                                           "entry has too many items (%d=
/%d)",
> -                                           items + 1, items2);
> -                                       return -1;
> -                               }
> -                               key.specified =3D spec_order[i] | enabled=
;
> -                               datum.data =3D le32_to_cpu(buf32[items++]=
);
> -                               rc =3D insertf(a, &key, &datum, p);
> -                               if (rc)
> -                                       return rc;
> -                       }
> -               }
> -
> -               if (items !=3D items2) {
> -                       ERR(fp->handle,
> -                           "entry only had %d items, "
> -                           "expected %d",
> -                           items2, items);
> -                       return -1;
> -               }
> -               return 0;
> -       }
> -
>         rc =3D next_entry(buf16, fp, sizeof(uint16_t) * 4);
>         if (rc < 0) {
>                 ERR(fp->handle, "truncated entry");
> diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_com=
mon.c
> index c7b6d73a..338dcef6 100644
> --- a/libsepol/src/kernel_to_common.c
> +++ b/libsepol/src/kernel_to_common.c
> @@ -795,18 +795,5 @@ int check_for_supported_policy(struct policydb *pdb)
>                 return -1;
>         }
>
> -       if (pdb->policyvers >=3D POLICYDB_VERSION_AVTAB &&
> -           pdb->policyvers <=3D POLICYDB_VERSION_PERMISSIVE) {
> -               /*
> -                * For policy versions between 20 and 23, attributes exis=
t in the policy,
> -                * but only in the type_attr_map. This means that there a=
re gaps in both
> -                * the type_val_to_struct and p_type_val_to_name arrays a=
nd policy rules
> -                * can refer to those gaps.
> -                */
> -               ERR(NULL,
> -                   "Writing out CIL or policy.conf from policy versions =
between 20 and 23 is not supported");
> -               return -1;
> -       }
> -
>         return 0;
>  }
> diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
> index 7a961ca4..eeffee7d 100644
> --- a/libsepol/src/optimize.c
> +++ b/libsepol/src/optimize.c
> @@ -453,19 +453,6 @@ int policydb_optimize(policydb_t *p)
>         if (p->policy_type !=3D POLICY_KERN)
>                 return -1;
>
> -       if (p->policyvers >=3D POLICYDB_VERSION_AVTAB &&
> -           p->policyvers <=3D POLICYDB_VERSION_PERMISSIVE) {
> -               /*
> -                * For policy versions between 20 and 23, attributes exis=
t in the policy,
> -                * but only in the type_attr_map. This means that there a=
re gaps in both
> -                * the type_val_to_struct and p_type_val_to_name arrays a=
nd policy rules
> -                * can refer to those gaps.
> -                */
> -               ERR(NULL,
> -                   "Optimizing policy versions between 20 and 23 is not =
supported");
> -               return -1;
> -       }
> -
>         type_map =3D build_type_map(p);
>         if (!type_map)
>                 return -1;
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 44e26f4f..84b7ac1e 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -76,69 +76,6 @@ static const struct policydb_compat_info policydb_comp=
at[] =3D {
>                 .ocon_num =3D OCON_XEN_DEVICETREE + 1,
>                 .target_platform =3D SEPOL_TARGET_XEN,
>         },
> -       {
> -               .type =3D POLICY_KERN,
> -               .version =3D POLICYDB_VERSION_BASE,
> -               .sym_num =3D SYM_NUM - 3,
> -               .ocon_num =3D OCON_FSUSE + 1,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_KERN,
> -               .version =3D POLICYDB_VERSION_BOOL,
> -               .sym_num =3D SYM_NUM - 2,
> -               .ocon_num =3D OCON_FSUSE + 1,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_KERN,
> -               .version =3D POLICYDB_VERSION_IPV6,
> -               .sym_num =3D SYM_NUM - 2,
> -               .ocon_num =3D OCON_NODE6 + 1,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_KERN,
> -               .version =3D POLICYDB_VERSION_NLCLASS,
> -               .sym_num =3D SYM_NUM - 2,
> -               .ocon_num =3D OCON_NODE6 + 1,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_KERN,
> -               .version =3D POLICYDB_VERSION_MLS,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D OCON_NODE6 + 1,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_KERN,
> -               .version =3D POLICYDB_VERSION_AVTAB,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D OCON_NODE6 + 1,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_KERN,
> -               .version =3D POLICYDB_VERSION_RANGETRANS,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D OCON_NODE6 + 1,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_KERN,
> -               .version =3D POLICYDB_VERSION_POLCAP,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D OCON_NODE6 + 1,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_KERN,
> -               .version =3D POLICYDB_VERSION_PERMISSIVE,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D OCON_NODE6 + 1,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
>         {
>                 .type =3D POLICY_KERN,
>                 .version =3D POLICYDB_VERSION_BOUNDARY,
> @@ -2088,8 +2025,7 @@ static int context_read_and_validate(context_struct=
_t *c, policydb_t *p,
>         c->user =3D le32_to_cpu(buf[0]);
>         c->role =3D le32_to_cpu(buf[1]);
>         c->type =3D le32_to_cpu(buf[2]);
> -       if ((p->policy_type =3D=3D POLICY_KERN &&
> -            p->policyvers >=3D POLICYDB_VERSION_MLS) ||
> +       if ((p->policy_type =3D=3D POLICY_KERN) ||
>             (p->policy_type =3D=3D POLICY_BASE &&
>              p->policyvers >=3D MOD_POLICYDB_VERSION_MLS)) {
>                 if (mls_read_range_helper(&c->range, fp)) {
> @@ -2348,8 +2284,7 @@ static int class_read(policydb_t *p, hashtab_t h, s=
truct policy_file *fp)
>         if (read_cons_helper(p, &cladatum->constraints, ncons, 0, fp))
>                 goto bad;
>
> -       if ((p->policy_type =3D=3D POLICY_KERN &&
> -            p->policyvers >=3D POLICYDB_VERSION_VALIDATETRANS) ||
> +       if ((p->policy_type =3D=3D POLICY_KERN) ||
>             (p->policy_type =3D=3D POLICY_BASE &&
>              p->policyvers >=3D MOD_POLICYDB_VERSION_VALIDATETRANS)) {
>                 /* grab the validatetrans rules */
> @@ -3365,8 +3300,7 @@ static int user_read(policydb_t *p, hashtab_t h, st=
ruct policy_file *fp)
>          * MOD_POLICYDB_VERSION_MLS_USERS, but they could have been
>          * required - the mls fields will be empty.  user declarations in
>          * non-mls modules will also have empty mls fields */
> -       if ((p->policy_type =3D=3D POLICY_KERN &&
> -            p->policyvers >=3D POLICYDB_VERSION_MLS) ||
> +       if ((p->policy_type =3D=3D POLICY_KERN) ||
>             (p->policy_type =3D=3D POLICY_MOD &&
>              p->policyvers >=3D MOD_POLICYDB_VERSION_MLS &&
>              p->policyvers < MOD_POLICYDB_VERSION_MLS_USERS) ||
> @@ -3603,8 +3537,7 @@ static int range_read(policydb_t *p, struct policy_=
file *fp)
>         struct mls_range *r =3D NULL;
>         range_trans_rule_t *rtr =3D NULL, *lrtr =3D NULL;
>         unsigned int i;
> -       int new_rangetr =3D (p->policy_type =3D=3D POLICY_KERN &&
> -                          p->policyvers >=3D POLICYDB_VERSION_RANGETRANS=
);
> +       int new_rangetr =3D (p->policy_type =3D=3D POLICY_KERN);
>         int rc;
>
>         rc =3D next_entry(buf, fp, sizeof(uint32_t));
> @@ -4361,8 +4294,7 @@ int policydb_read(policydb_t *p, struct policy_file=
 *fp, unsigned verbose)
>                         goto bad;
>         }
>
> -       if ((p->policyvers >=3D POLICYDB_VERSION_POLCAP &&
> -            p->policy_type =3D=3D POLICY_KERN) ||
> +       if ((p->policy_type =3D=3D POLICY_KERN) ||
>             (p->policyvers >=3D MOD_POLICYDB_VERSION_POLCAP &&
>              p->policy_type =3D=3D POLICY_BASE) ||
>             (p->policyvers >=3D MOD_POLICYDB_VERSION_POLCAP &&
> @@ -4371,8 +4303,7 @@ int policydb_read(policydb_t *p, struct policy_file=
 *fp, unsigned verbose)
>                         goto bad;
>         }
>
> -       if (p->policyvers >=3D POLICYDB_VERSION_PERMISSIVE &&
> -           p->policy_type =3D=3D POLICY_KERN) {
> +       if (p->policy_type =3D=3D POLICY_KERN) {
>                 if (ebitmap_read(&p->permissive_map, fp))
>                         goto bad;
>         }
> @@ -4422,9 +4353,8 @@ int policydb_read(policydb_t *p, struct policy_file=
 *fp, unsigned verbose)
>         if (policy_type =3D=3D POLICY_KERN) {
>                 if (avtab_read(&p->te_avtab, fp, r_policyvers))
>                         goto bad;
> -               if (r_policyvers >=3D POLICYDB_VERSION_BOOL)
> -                       if (cond_read_list(p, &p->cond_list, fp))
> -                               goto bad;
> +               if (cond_read_list(p, &p->cond_list, fp))
> +                       goto bad;
>                 if (role_trans_read(p, fp))
>                         goto bad;
>                 if (role_allow_read(&p->role_allow, fp))
> @@ -4487,8 +4417,7 @@ int policydb_read(policydb_t *p, struct policy_file=
 *fp, unsigned verbose)
>                 goto bad;
>         }
>
> -       if ((p->policy_type =3D=3D POLICY_KERN &&
> -            p->policyvers >=3D POLICYDB_VERSION_MLS) ||
> +       if ((p->policy_type =3D=3D POLICY_KERN) ||
>             (p->policy_type =3D=3D POLICY_BASE &&
>              p->policyvers >=3D MOD_POLICYDB_VERSION_MLS &&
>              p->policyvers < MOD_POLICYDB_VERSION_RANGETRANS)) {
> @@ -4503,30 +4432,28 @@ int policydb_read(policydb_t *p, struct policy_fi=
le *fp, unsigned verbose)
>                 if (!p->type_attr_map || !p->attr_type_map)
>                         goto bad;
>                 for (i =3D 0; i < p->p_types.nprim; i++) {
> -                       if (r_policyvers >=3D POLICYDB_VERSION_AVTAB) {
> -                               if (ebitmap_read(&p->type_attr_map[i], fp=
))
> +                       if (ebitmap_read(&p->type_attr_map[i], fp))
> +                               goto bad;
> +                       ebitmap_for_each_positive_bit(&p->type_attr_map[i=
],
> +                                                     tnode, j) {
> +                               if (i =3D=3D j)
> +                                       continue;
> +
> +                               if (j >=3D p->p_types.nprim)
> +                                       goto bad;
> +
> +                               if (p->type_val_to_struct[i] &&
> +                                   p->type_val_to_struct[i]->flavor =3D=
=3D
> +                                           TYPE_ATTRIB) {
> +                                       ERR(fp->handle,
> +                                           "Invalid to have type attribu=
tes associated with an attribute for a kernel policy");
>                                         goto bad;
> -                               ebitmap_for_each_positive_bit(
> -                                       &p->type_attr_map[i], tnode, j) {
> -                                       if (i =3D=3D j)
> -                                               continue;
> -
> -                                       if (j >=3D p->p_types.nprim)
> -                                               goto bad;
> -
> -                                       if (p->type_val_to_struct[i] &&
> -                                           p->type_val_to_struct[i]->fla=
vor =3D=3D
> -                                                   TYPE_ATTRIB) {
> -                                               ERR(fp->handle,
> -                                                   "Invalid to have type=
 attributes associated with an attribute for a kernel policy");
> -                                               goto bad;
> -                                       }
> -
> -                                       if (ebitmap_set_bit(
> -                                                   &p->attr_type_map[j],=
 i, 1))
> -                                               goto bad;
>                                 }
> +
> +                               if (ebitmap_set_bit(&p->attr_type_map[j],=
 i, 1))
> +                                       goto bad;
>                         }
> +
>                         /* add the type itself as the degenerate case */
>                         if (p->type_val_to_struct[i] &&
>                             ebitmap_set_bit(&p->type_attr_map[i], i, 1))
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index 4cdf0b78..5687c82b 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -77,21 +77,9 @@ static int validate_array_init(const policydb_t *p, va=
lidate_t flavors[])
>         if (validate_init(&flavors[SYM_ROLES], p->p_role_val_to_name,
>                           p->p_roles.nprim))
>                 goto bad;
> -       if (p->policy_type !=3D POLICY_KERN ||
> -           p->policyvers < POLICYDB_VERSION_AVTAB ||
> -           p->policyvers > POLICYDB_VERSION_PERMISSIVE) {
> -               if (validate_init(&flavors[SYM_TYPES], p->p_type_val_to_n=
ame,
> -                                 p->p_types.nprim))
> -                       goto bad;
> -       } else {
> -               /*
> -                * For policy versions between 20 and 23, attributes exis=
t in the policy,
> -                * but they only exist in the type_attr_map, so there wil=
l be references
> -                * to gaps and we just have to treat this case as if ther=
e were no gaps.
> -                */
> -               flavors[SYM_TYPES].nprim =3D p->p_types.nprim;
> -               ebitmap_init(&flavors[SYM_TYPES].gaps);
> -       }
> +       if (validate_init(&flavors[SYM_TYPES], p->p_type_val_to_name,
> +                         p->p_types.nprim))
> +               goto bad;
>         if (validate_init(&flavors[SYM_USERS], p->p_user_val_to_name,
>                           p->p_users.nprim))
>                 goto bad;
> @@ -954,19 +942,10 @@ static int validate_datum_array_gaps(sepol_handle_t=
 *handle,
>                         goto bad;
>         }
>
> -       /*
> -        * For policy versions between 20 and 23, attributes exist in the=
 policy,
> -        * but only in the type_attr_map, so all gaps must be assumed to =
be valid.
> -        */
> -       if (p->policy_type !=3D POLICY_KERN ||
> -           p->policyvers < POLICYDB_VERSION_AVTAB ||
> -           p->policyvers > POLICYDB_VERSION_PERMISSIVE) {
> -               for (i =3D 0; i < p->p_types.nprim; i++) {
> -                       if (bool_xnor(p->type_val_to_struct[i],
> -                                     ebitmap_get_bit(&flavors[SYM_TYPES]=
.gaps,
> -                                                     i)))
> -                               goto bad;
> -               }
> +       for (i =3D 0; i < p->p_types.nprim; i++) {
> +               if (bool_xnor(p->type_val_to_struct[i],
> +                             ebitmap_get_bit(&flavors[SYM_TYPES].gaps, i=
)))
> +                       goto bad;
>         }
>
>         for (i =3D 0; i < p->p_users.nprim; i++) {
> @@ -1994,8 +1973,6 @@ static int validate_properties(sepol_handle_t *hand=
le, const policydb_t *p)
>                 if (p->policyvers < POLICYDB_VERSION_MIN ||
>                     p->policyvers > POLICYDB_VERSION_MAX)
>                         goto bad;
> -               if (p->mls && p->policyvers < POLICYDB_VERSION_MLS)
> -                       goto bad;
>                 break;
>         case POLICY_BASE:
>         case POLICY_MOD:
> @@ -2086,10 +2063,8 @@ int policydb_validate(sepol_handle_t *handle, cons=
t policydb_t *p)
>         if (p->policy_type =3D=3D POLICY_KERN) {
>                 if (validate_avtab(handle, &p->te_avtab, p, flavors))
>                         goto bad;
> -               if (p->policyvers >=3D POLICYDB_VERSION_BOOL)
> -                       if (validate_cond_list(handle, p->cond_list, p,
> -                                              flavors))
> -                               goto bad;
> +               if (validate_cond_list(handle, p->cond_list, p, flavors))
> +                       goto bad;
>                 if (validate_role_transes(handle, p->role_tr, flavors))
>                         goto bad;
>                 if (validate_role_allows(handle, p->role_allow, flavors))
> diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> index adec6caf..4e180ef3 100644
> --- a/libsepol/src/write.c
> +++ b/libsepol/src/write.c
> @@ -92,126 +92,15 @@ static int ebitmap_write(ebitmap_t *e, struct policy=
_file *fp)
>         return POLICYDB_SUCCESS;
>  }
>
> -/* Ordering of datums in the original avtab format in the policy file. *=
/
> -static uint16_t spec_order[] =3D { AVTAB_ALLOWED,           AVTAB_AUDITD=
ENY,
> -                                AVTAB_AUDITALLOW, AVTAB_TRANSITION,
> -                                AVTAB_CHANGE,     AVTAB_MEMBER };
> -
>  static int avtab_write_item(policydb_t *p, avtab_ptr_t cur,
> -                           struct policy_file *fp, unsigned merge,
> -                           unsigned commit, unsigned conditional,
> -                           uint32_t *nel)
> +                           struct policy_file *fp, unsigned conditional)
>  {
> -       avtab_ptr_t node;
>         uint8_t buf8;
>         uint16_t buf16[4];
> -       uint32_t buf32[10], lookup, val;
> -       size_t items, items2;
> -       unsigned set;
> -       unsigned int oldvers =3D (p->policy_type =3D=3D POLICY_KERN &&
> -                               p->policyvers < POLICYDB_VERSION_AVTAB);
> +       uint32_t buf32[10];
> +       size_t items;
>         unsigned int i;
>
> -       if (oldvers) {
> -               /* Generate the old avtab format.
> -                  Requires merging similar entries if uncond avtab. */
> -               if (merge) {
> -                       if (cur->merged)
> -                               return POLICYDB_SUCCESS; /* already merge=
d by prior merge */
> -               }
> -
> -               items =3D 1; /* item 0 is used for the item count */
> -               val =3D cur->key.source_type;
> -               buf32[items++] =3D cpu_to_le32(val);
> -               val =3D cur->key.target_type;
> -               buf32[items++] =3D cpu_to_le32(val);
> -               val =3D cur->key.target_class;
> -               buf32[items++] =3D cpu_to_le32(val);
> -
> -               val =3D cur->key.specified & ~AVTAB_ENABLED;
> -               if (cur->key.specified & AVTAB_ENABLED)
> -                       val |=3D AVTAB_ENABLED_OLD;
> -               set =3D 1;
> -
> -               if (merge) {
> -                       /* Merge specifier values for all similar (av or =
type)
> -                          entries that have the same key. */
> -                       if (val & AVTAB_AV)
> -                               lookup =3D AVTAB_AV;
> -                       else if (val & AVTAB_TYPE)
> -                               lookup =3D AVTAB_TYPE;
> -                       else
> -                               return POLICYDB_ERROR;
> -                       for (node =3D avtab_search_node_next(cur, lookup)=
; node;
> -                            node =3D avtab_search_node_next(node, lookup=
)) {
> -                               val |=3D (node->key.specified & ~AVTAB_EN=
ABLED);
> -                               set++;
> -                               if (node->key.specified & AVTAB_ENABLED)
> -                                       val |=3D AVTAB_ENABLED_OLD;
> -                       }
> -               }
> -
> -               if (!(val & (AVTAB_AV | AVTAB_TYPE))) {
> -                       ERR(fp->handle, "null entry");
> -                       return POLICYDB_ERROR;
> -               }
> -               if ((val & AVTAB_AV) && (val & AVTAB_TYPE)) {
> -                       ERR(fp->handle, "entry has both access "
> -                                       "vectors and types");
> -                       return POLICYDB_ERROR;
> -               }
> -
> -               buf32[items++] =3D cpu_to_le32(val);
> -
> -               if (merge) {
> -                       /* Include datums for all similar (av or type)
> -                          entries that have the same key. */
> -                       for (i =3D 0;
> -                            i < (sizeof(spec_order) / sizeof(spec_order[=
0]));
> -                            i++) {
> -                               if (val & spec_order[i]) {
> -                                       if (cur->key.specified & spec_ord=
er[i])
> -                                               node =3D cur;
> -                                       else {
> -                                               node =3D avtab_search_nod=
e_next(
> -                                                       cur, spec_order[i=
]);
> -                                               if (nel)
> -                                                       (*nel)--; /* one =
less node */
> -                                       }
> -
> -                                       if (!node) {
> -                                               ERR(fp->handle, "missing =
node");
> -                                               return POLICYDB_ERROR;
> -                                       }
> -                                       buf32[items++] =3D
> -                                               cpu_to_le32(node->datum.d=
ata);
> -                                       set--;
> -                                       node->merged =3D 1;
> -                               }
> -                       }
> -               } else {
> -                       buf32[items++] =3D cpu_to_le32(cur->datum.data);
> -                       cur->merged =3D 1;
> -                       set--;
> -               }
> -
> -               if (set) {
> -                       ERR(fp->handle, "data count wrong");
> -                       return POLICYDB_ERROR;
> -               }
> -
> -               buf32[0] =3D cpu_to_le32(items - 1);
> -
> -               if (commit) {
> -                       /* Commit this item to the policy file. */
> -                       items2 =3D put_entry(buf32, sizeof(uint32_t), ite=
ms, fp);
> -                       if (items !=3D items2)
> -                               return POLICYDB_ERROR;
> -               }
> -
> -               return POLICYDB_SUCCESS;
> -       }
> -
>         /* Generate the new avtab format. */
>         buf16[0] =3D cpu_to_le16(cur->key.source_type);
>         buf16[1] =3D cpu_to_le16(cur->key.target_type);
> @@ -271,86 +160,30 @@ static int avtab_write_item(policydb_t *p, avtab_pt=
r_t cur,
>         return POLICYDB_SUCCESS;
>  }
>
> -static inline void avtab_reset_merged(avtab_t *a)
> -{
> -       unsigned int i;
> -       avtab_ptr_t cur;
> -       for (i =3D 0; i < a->nslot; i++) {
> -               for (cur =3D a->htable[i]; cur; cur =3D cur->next)
> -                       cur->merged =3D 0;
> -       }
> -}
> -
>  static int avtab_write(struct policydb *p, avtab_t *a, struct policy_fil=
e *fp)
>  {
>         unsigned int i;
>         int rc;
> -       avtab_t expa;
>         avtab_ptr_t cur;
>         uint32_t nel;
>         size_t items;
> -       unsigned int oldvers =3D (p->policy_type =3D=3D POLICY_KERN &&
> -                               p->policyvers < POLICYDB_VERSION_AVTAB);
> -
> -       if (oldvers) {
> -               /* Old avtab format.
> -                  First, we need to expand attributes.  Then, we need to
> -                  merge similar entries, so we need to track merged node=
s
> -                  and compute the final nel. */
> -               if (avtab_init(&expa))
> -                       return POLICYDB_ERROR;
> -               if (expand_avtab(p, a, &expa)) {
> -                       rc =3D -1;
> -                       goto out;
> -               }
> -               a =3D &expa;
> -               avtab_reset_merged(a);
> -               nel =3D a->nel;
> -       } else {
> -               /* New avtab format.  nel is good to go. */
> -               nel =3D cpu_to_le32(a->nel);
> -               items =3D put_entry(&nel, sizeof(uint32_t), 1, fp);
> -               if (items !=3D 1)
> -                       return POLICYDB_ERROR;
> -       }
> +
> +       nel =3D cpu_to_le32(a->nel);
> +       items =3D put_entry(&nel, sizeof(uint32_t), 1, fp);
> +       if (items !=3D 1)
> +               return POLICYDB_ERROR;
>
>         for (i =3D 0; i < a->nslot; i++) {
>                 for (cur =3D a->htable[i]; cur; cur =3D cur->next) {
> -                       /* If old format, compute final nel.
> -                          If new format, write out the items. */
> -                       if (avtab_write_item(p, cur, fp, 1, !oldvers, 0,
> -                                            &nel)) {
> +                       if (avtab_write_item(p, cur, fp, 0)) {
>                                 rc =3D -1;
>                                 goto out;
>                         }
>                 }
>         }
>
> -       if (oldvers) {
> -               /* Old avtab format.
> -                  Write the computed nel value, then write the items. */
> -               nel =3D cpu_to_le32(nel);
> -               items =3D put_entry(&nel, sizeof(uint32_t), 1, fp);
> -               if (items !=3D 1) {
> -                       rc =3D -1;
> -                       goto out;
> -               }
> -               avtab_reset_merged(a);
> -               for (i =3D 0; i < a->nslot; i++) {
> -                       for (cur =3D a->htable[i]; cur; cur =3D cur->next=
) {
> -                               if (avtab_write_item(p, cur, fp, 1, 1, 0,
> -                                                    NULL)) {
> -                                       rc =3D -1;
> -                                       goto out;
> -                               }
> -                       }
> -               }
> -       }
> -
>         rc =3D 0;
>  out:
> -       if (oldvers)
> -               avtab_destroy(&expa);
>         return rc;
>  }
>
> @@ -770,21 +603,10 @@ static int cond_write_av_list(policydb_t *p, cond_a=
v_list_t *list,
>                               struct policy_file *fp)
>  {
>         uint32_t buf[4];
> -       cond_av_list_t *cur_list, *new_list =3D NULL;
> -       avtab_t expa;
> +       cond_av_list_t *cur_list;
>         uint32_t len, items;
> -       unsigned int oldvers =3D (p->policy_type =3D=3D POLICY_KERN &&
> -                               p->policyvers < POLICYDB_VERSION_AVTAB);
>         int rc =3D -1;
>
> -       if (oldvers) {
> -               if (avtab_init(&expa))
> -                       return POLICYDB_ERROR;
> -               if (expand_cond_av_list(p, list, &new_list, &expa))
> -                       goto out;
> -               list =3D new_list;
> -       }
> -
>         len =3D 0;
>         for (cur_list =3D list; cur_list !=3D NULL; cur_list =3D cur_list=
->next) {
>                 if (cur_list->node->parse_context)
> @@ -803,18 +625,12 @@ static int cond_write_av_list(policydb_t *p, cond_a=
v_list_t *list,
>
>         for (cur_list =3D list; cur_list !=3D NULL; cur_list =3D cur_list=
->next) {
>                 if (cur_list->node->parse_context)
> -                       if (avtab_write_item(p, cur_list->node, fp, 0, 1,=
 1,
> -                                            NULL))
> +                       if (avtab_write_item(p, cur_list->node, fp, 1))
>                                 goto out;
>         }
>
>         rc =3D 0;
>  out:
> -       if (oldvers) {
> -               cond_av_list_destroy(new_list);
> -               avtab_destroy(&expa);
> -       }
> -
>         return rc;
>  }
>
> @@ -912,8 +728,7 @@ static int context_write(struct policydb *p, context_=
struct_t *c,
>         items2 =3D put_entry(buf, sizeof(uint32_t), items, fp);
>         if (items2 !=3D items)
>                 return POLICYDB_ERROR;
> -       if ((p->policyvers >=3D POLICYDB_VERSION_MLS &&
> -            p->policy_type =3D=3D POLICY_KERN) ||
> +       if ((p->policy_type =3D=3D POLICY_KERN) ||
>             (p->policyvers >=3D MOD_POLICYDB_VERSION_MLS &&
>              p->policy_type =3D=3D POLICY_BASE))
>                 if (mls_write_range_helper(&c->range, fp))
> @@ -1086,8 +901,7 @@ static int class_write(hashtab_key_t key, hashtab_da=
tum_t datum, void *ptr)
>         if (write_cons_helper(p, cladatum->constraints, 0, fp))
>                 return POLICYDB_ERROR;
>
> -       if ((p->policy_type =3D=3D POLICY_KERN &&
> -            p->policyvers >=3D POLICYDB_VERSION_VALIDATETRANS) ||
> +       if ((p->policy_type =3D=3D POLICY_KERN) ||
>             (p->policy_type =3D=3D POLICY_BASE &&
>              p->policyvers >=3D MOD_POLICYDB_VERSION_VALIDATETRANS)) {
>                 /* write out the validatetrans rule */
> @@ -1231,15 +1045,6 @@ static int type_write(hashtab_key_t key, hashtab_d=
atum_t datum, void *ptr)
>
>         typdatum =3D (type_datum_t *)datum;
>
> -       /*
> -        * The kernel policy version less than 24 (=3D POLICYDB_VERSION_B=
OUNDARY)
> -        * does not support to load entries of attribute, so we skip to w=
rite it.
> -        */
> -       if (p->policy_type =3D=3D POLICY_KERN &&
> -           p->policyvers < POLICYDB_VERSION_BOUNDARY &&
> -           typdatum->flavor =3D=3D TYPE_ATTRIB)
> -               return POLICYDB_SUCCESS;
> -
>         len =3D strlen(key);
>         items =3D 0;
>         buf[items++] =3D cpu_to_le32(len);
> @@ -1349,8 +1154,7 @@ static int user_write(hashtab_key_t key, hashtab_da=
tum_t datum, void *ptr)
>                         return POLICYDB_ERROR;
>         }
>
> -       if ((p->policyvers >=3D POLICYDB_VERSION_MLS &&
> -            p->policy_type =3D=3D POLICY_KERN) ||
> +       if ((p->policy_type =3D=3D POLICY_KERN) ||
>             (p->policyvers >=3D MOD_POLICYDB_VERSION_MLS &&
>              p->policyvers < MOD_POLICYDB_VERSION_MLS_USERS &&
>              p->policy_type =3D=3D POLICY_MOD) ||
> @@ -1759,8 +1563,7 @@ static int range_write(policydb_t *p, struct policy=
_file *fp)
>  {
>         size_t items;
>         uint32_t buf[2];
> -       int new_rangetr =3D (p->policy_type =3D=3D POLICY_KERN &&
> -                          p->policyvers >=3D POLICYDB_VERSION_RANGETRANS=
);
> +       int new_rangetr =3D (p->policy_type =3D=3D POLICY_KERN);
>         struct rangetrans_write_args args;
>         int rc;
>
> @@ -2214,19 +2017,6 @@ err:
>         return rc;
>  }
>
> -static int type_attr_uncount(hashtab_key_t key __attribute__((unused)),
> -                            hashtab_datum_t datum, void *args)
> -{
> -       type_datum_t *typdatum =3D datum;
> -       uint32_t *p_nel =3D args;
> -
> -       if (typdatum->flavor =3D=3D TYPE_ATTRIB) {
> -               /* uncount attribute from total number of types */
> -               (*p_nel)--;
> -       }
> -       return 0;
> -}
> -
>  static int role_attr_uncount(hashtab_key_t key __attribute__((unused)),
>                              hashtab_datum_t datum, void *args)
>  {
> @@ -2262,9 +2052,7 @@ int policydb_write(policydb_t *p, struct policy_fil=
e *fp)
>
>         config =3D 0;
>         if (p->mls) {
> -               if ((p->policyvers < POLICYDB_VERSION_MLS &&
> -                    p->policy_type =3D=3D POLICY_KERN) ||
> -                   (p->policyvers < MOD_POLICYDB_VERSION_MLS &&
> +               if ((p->policyvers < MOD_POLICYDB_VERSION_MLS &&
>                      p->policy_type =3D=3D POLICY_BASE) ||
>                     (p->policyvers < MOD_POLICYDB_VERSION_MLS &&
>                      p->policy_type =3D=3D POLICY_MOD)) {
> @@ -2344,8 +2132,7 @@ int policydb_write(policydb_t *p, struct policy_fil=
e *fp)
>                         return POLICYDB_ERROR;
>         }
>
> -       if ((p->policyvers >=3D POLICYDB_VERSION_POLCAP &&
> -            p->policy_type =3D=3D POLICY_KERN) ||
> +       if ((p->policy_type =3D=3D POLICY_KERN) ||
>             (p->policyvers >=3D MOD_POLICYDB_VERSION_POLCAP &&
>              p->policy_type =3D=3D POLICY_BASE) ||
>             (p->policyvers >=3D MOD_POLICYDB_VERSION_POLCAP &&
> @@ -2355,18 +2142,7 @@ int policydb_write(policydb_t *p, struct policy_fi=
le *fp)
>         }
>
>         if (p->policy_type =3D=3D POLICY_KERN) {
> -               if (p->policyvers < POLICYDB_VERSION_PERMISSIVE) {
> -                       ebitmap_node_t *tnode;
> -
> -                       ebitmap_for_each_positive_bit(&p->permissive_map,=
 tnode,
> -                                                     i) {
> -                               WARN(fp->handle,
> -                                    "Warning! Policy version %d cannot "
> -                                    "support permissive types, but some =
were defined",
> -                                    p->policyvers);
> -                               break;
> -                       }
> -               } else if (ebitmap_write(&p->permissive_map, fp) =3D=3D -=
1)
> +               if (ebitmap_write(&p->permissive_map, fp) =3D=3D -1)
>                         return POLICYDB_ERROR;
>
>                 if (p->policyvers < POLICYDB_VERSION_NEVERAUDIT) {
> @@ -2389,19 +2165,6 @@ int policydb_write(policydb_t *p, struct policy_fi=
le *fp)
>                 buf[0] =3D cpu_to_le32(p->symtab[i].nprim);
>                 buf[1] =3D p->symtab[i].table->nel;
>
> -               /*
> -                * A special case when writing type/attribute symbol tabl=
e.
> -                * The kernel policy version less than 24 does not suppor=
t
> -                * to load entries of attribute, so we have to re-calcula=
te
> -                * the actual number of types except for attributes.
> -                */
> -               if (i =3D=3D SYM_TYPES &&
> -                   p->policyvers < POLICYDB_VERSION_BOUNDARY &&
> -                   p->policy_type =3D=3D POLICY_KERN) {
> -                       hashtab_map(p->symtab[i].table, type_attr_uncount=
,
> -                                   &buf[1]);
> -               }
> -
>                 /*
>                  * Another special case when writing role/attribute symbo=
l
>                  * table, role attributes are redundant for policy.X, or
> @@ -2426,15 +2189,8 @@ int policydb_write(policydb_t *p, struct policy_fi=
le *fp)
>         if (p->policy_type =3D=3D POLICY_KERN) {
>                 if (avtab_write(p, &p->te_avtab, fp))
>                         return POLICYDB_ERROR;
> -               if (p->policyvers < POLICYDB_VERSION_BOOL) {
> -                       if (p->p_bools.nprim)
> -                               WARN(fp->handle,
> -                                    "Discarding "
> -                                    "booleans and conditional rules");
> -               } else {
> -                       if (cond_write_list(p, p->cond_list, fp))
> -                               return POLICYDB_ERROR;
> -               }
> +               if (cond_write_list(p, p->cond_list, fp))
> +                       return POLICYDB_ERROR;
>                 if (role_trans_write(p, fp))
>                         return POLICYDB_ERROR;
>                 if (role_allow_write(p->role_allow, fp))
> @@ -2466,8 +2222,7 @@ int policydb_write(policydb_t *p, struct policy_fil=
e *fp)
>                 return POLICYDB_ERROR;
>         }
>
> -       if ((p->policyvers >=3D POLICYDB_VERSION_MLS &&
> -            p->policy_type =3D=3D POLICY_KERN) ||
> +       if ((p->policy_type =3D=3D POLICY_KERN) ||
>             (p->policyvers >=3D MOD_POLICYDB_VERSION_MLS &&
>              p->policyvers < MOD_POLICYDB_VERSION_RANGETRANS &&
>              p->policy_type =3D=3D POLICY_BASE)) {
> @@ -2476,8 +2231,7 @@ int policydb_write(policydb_t *p, struct policy_fil=
e *fp)
>                 }
>         }
>
> -       if (p->policy_type =3D=3D POLICY_KERN &&
> -           p->policyvers >=3D POLICYDB_VERSION_AVTAB) {
> +       if (p->policy_type =3D=3D POLICY_KERN) {
>                 for (i =3D 0; i < p->p_types.nprim; i++) {
>                         if (ebitmap_write(&p->type_attr_map[i], fp) =3D=
=3D -1)
>                                 return POLICYDB_ERROR;
> diff --git a/libsepol/tests/test-downgrade.c b/libsepol/tests/test-downgr=
ade.c
> index bf747780..5f879b39 100644
> --- a/libsepol/tests/test-downgrade.c
> +++ b/libsepol/tests/test-downgrade.c
> @@ -155,13 +155,6 @@ int do_downgrade_test(int mls)
>                         /* Write out modified binary policy */
>                         if (write_binary_policy(POLICY_BIN_LO, &policydb)=
 !=3D
>                             0) {
> -                               /*
> -                                * Error from MLS to pre-MLS is expected =
due
> -                                * to MLS re-implementation in version 19=
.
> -                                */
> -                               if (mls && lo < POLICYDB_VERSION_MLS)
> -                                       continue;
> -
>                                 fprintf(stderr,
>                                         "error writing %spolicy binary, v=
ersion %d (downgraded from %d)\n",
>                                         mls ? "mls " : "", lo, hi);
> --
> 2.55.0
>
