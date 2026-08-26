Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9E131D730
	for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787759596; cv=pass; b=FtW70WY++dekiwwlGt5HfQ1O9lU4JKXEGhYfdFPjyOIUNYNOU2w4KHHOYdn+Vcw+uwN4/VNBMoOaeqXJJz5IdQdIpCoDpax4XJGIxsKaMHkMprITsX1HaEU/8OZFnoRm208kLTzIMAeriCPFjbdglXef5lUrcfAZwgbeqfnX5WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787759596; c=relaxed/simple;
	bh=PT3u20a75T3NMNDgJs/Art52z1OS5p+mQGT9Odn0Gy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mhOeZbuxYPNNlTp44/6kTcRT9YHX+yZKK6UA0o9iN+f8ktqgpyfakvK8p5dt5M+Fxl1UIlSbslH5WOGjF1mP1TLetliQwHBRy0lDtzC0fhTcipRF0BHtuKxjkPJxRrxWRZsefBeF8eJSuf/EZp3nR38xVXBsWIbOjqDdf5IeEaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hslIRaCp; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hslIRaCp"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39c86ce9e29so8647841fa.3
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 08:53:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787759589; cv=none;
        d=google.com; s=arc-20260327;
        b=lcVe/mibD4tzi9XlEVuNX6m1C5aVR37aFzcpKXqCvIEdwwCjcuUYzHoYwFr6u2VnrL
         FiKb/ykKSWxp4eTHvQHTJx/iblWcmkP6UX+n0eByRUXSSqQAme3lwpWiwxghFYEAzFfH
         P4RUEDM/3k37mxEMbWZqqTnhg2dcUB4NdZPhX3dzjOnSO/V/iwqsbGnsQpfL4Db/6BBl
         qtWT8MD3x0+vIwIz7NssM06uoykHaSDmRYEBrnMoyAgFS7KtNErWb9tj9CcIZjRyIbKk
         uGBkO14N+M7A8BUiV+kmyvLShzCaqLo3/BCBoPxgmhsUp6F9xu8w8c3XcmL3UfLswRqw
         9Chg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mdmWp7qPQu/2/MAoUzUVIcnIoLXfJQxfaKcRsOkBW54=;
        fh=9qqehjuxnn2X0mJ7hQbZg99PSLTxs4BCAql4/69ZoU8=;
        b=Ag+itosAEmFn6iIdlYGCG+iwm3A9LQgCrq/cOw1L/nk7aeiCZHpZFqX8/LoN/MrAnF
         WmqJuhEqgFFVokSWxCRJLKKeIQJa1oeA1de8s/JWsd8/NueFNCnqpLy3sH6y8J9RiIw2
         KO5nYgBa5W8Op2MSLp7LK9qykQsSduc6qz/Datf0/IniKxmmlTawBZaMxhJ2TZOiTtlr
         9vD8M9UjcCvdSLPGPS2kdtRvFfw8HH4c+hmUVibRoABuv5KodKoTpsgaq4x733B+toh/
         cc6lnJbONAi063MKy+H0pEydxV90UcoAC3iap8Z6rMYQO3mNZbXh/HRfCsSNmGiBuByC
         +qKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787759589; x=1788364389; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mdmWp7qPQu/2/MAoUzUVIcnIoLXfJQxfaKcRsOkBW54=;
        b=hslIRaCpwV5u2+QXJM9aP5HzV3AzF6SUgTyudaxtTZAJqiP2Wau7YQtGAeEe4yrDEL
         7GZmqwrvgUGP1kriFsx65vZKl9PIxFqEiwu9XrL16yO3kwWEcp5D3xrp9NOk8WmWS2Oj
         Jlc6dLmyhHPc+jqAsUgeyOMmLZKE+GibC8BdrtmULIAqCUABC+OIIPaeJ1/aCUaV2J0n
         GmknxmikZ3mrplYGBgRPQ0Q3RMZ4CjPaSlshP15p51Jntyfb8oeH2Rk7rVpjdOAlTVFm
         602WoSghCWQXSsDxdguxiiPV+IpMZr9wYQqO6acwOVNc4p+n4an05MwsJWA73WscZZjg
         XLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787759589; x=1788364389;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mdmWp7qPQu/2/MAoUzUVIcnIoLXfJQxfaKcRsOkBW54=;
        b=eEXkqnI+jJN4rBbjESMqFXtaP9Q8+dJNDxctj1H9uyre1+146prZdgQXrt0xPmJ9GS
         QDRzKpiLdG+25blSCwSLEUxhZ8KMz5zFdqzy6tpKuDeyx0c87eVEQX4YjAmIblCsfMEG
         VoFyba2iMUU3nPZlAulL3HKbYinGg4wonezBGB6tQGZ/WdgHExaIk+PI/WuLV2YhU/QS
         +JAQdY+4m7qvWEaNSFTzKWrIXqzaHs80WL5aJBb7jpiAvpNpArsU11w2+So0HaAmXEy7
         bsgQxBGrvNvYy5OCqawG25ctcCoStN965Xy2szGHzM8kEHU3brB238hnhzsd3skFvQgF
         uJGw==
X-Gm-Message-State: AFuF++nxj6lPkhXsgHBKjU/ccduWDzSk0jg2tFq/IqoG6M3K+9+StGmA
	KiS/xe6CWFef/g1lIJtMEwSUaNe3+YRnP9/txCiPiyvsZQrtKfFTWel1EBPpVGFoAfsQbqCSF/m
	mt6Xk8fL0cpC66Cj6XisoZ1wmRaxMVP6BWS+H
X-Gm-Gg: AR+sD10pKA/luScHB3WAP/Gzk5lGsithoflz03iyCSOtulzZgVt4H4VnzGopFA5AYtr
	6o58GaLNtHz3pOIIrNdrQO5UqTtkZZWtVNGFIlRgovkdKpP6vTDbBkqSBNQw3xizpwPu/el4h1+
	nRWx3IqZFaBd0BlzIEOtd+w4c6GPDRt0aQOXXs+VtYBPNRzLwxRjvxPqoWfWGttdcvxQN2VsLt1
	XagskBTCQp9uksNDHy6faB2m6/iQXda4rCjfexqroWm9ZI26n7yxMnsnxmoPdIU0Zu8pBs5ansm
	UPUBmHe/e9dbbeJuu0QVmNy4jnIH3g6SdMJPuJkNV94sWdW4R7yy
X-Received: by 2002:a05:651c:220a:b0:39f:27a4:8037 with SMTP id
 38308e7fff4ca-3a1fd5e4c58mr16675131fa.5.1787759588789; Wed, 26 Aug 2026
 08:53:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820183839.38419-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260820183839.38419-2-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 26 Aug 2026 11:52:57 -0400
X-Gm-Features: AcwNN1WEej3qAA_HjH3DVk6d9pfxaxlmY74JAG9Hyi63QjqgCfv5eujF-TwVxRk
Message-ID: <CAP+JOzTXGxLp219vNoMm4PZB95wt0XvAAt9p7pHXP1=q=kRc=A@mail.gmail.com>
Subject: Re: [RFC PATCH v3] libsepol: drop support for policy versions before xperms_ioctl/xen_devicetree
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 2:43=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> RFC-only at this time since this would also increase our minimum
> supported kernel version from v3.0 to v4.3 and might break very old
> long term support distro releases that predate the kernel or libsepol
> versions that support policy 30. That said, I doubt those distro
> releases would ever update to latest libsepol.
>
> Drop support for kernel and module policy versions before the
> xperms_ioctl support (SELinux kernel policy version 30, modular policy
> version 18) and xen_devicetree support (Xen policy version 30). Kernel
> policy version 30 was first supported in Linux v4.3, Xen 4.6, and
> libsepol 2.5 (20160223). Modular policy version 18 was first supported
> in libsepol 2.7 aka selinux userspace release (20170804).
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v3 updates checkpolicy-fuzzer.c for the removal of
> POLICYDB_VERSION_BOUNDARY, removes a lingering reference to it in a
> comment in policydb.h, coalesces the three back-to-back if blocks in
> class_write(), and drops the no-longer-needed new_rangetr and
> rangetrans_count() logic.
>
>  README.md                                  |  27 ++-
>  checkpolicy/fuzz/checkpolicy-fuzzer.c      |   3 +-
>  libsepol/cil/src/cil_binary.c              |  31 ++-
>  libsepol/include/sepol/policydb/policydb.h |  19 +-
>  libsepol/src/conditional.c                 |   6 +-
>  libsepol/src/policydb.c                    | 241 ++-------------------
>  libsepol/src/policydb_validate.c           |  10 +-
>  libsepol/src/services.c                    |  10 +-
>  libsepol/src/write.c                       | 181 +++-------------
>  9 files changed, 89 insertions(+), 439 deletions(-)
>
> diff --git a/README.md b/README.md
> index 3069e1a5..a02a0a4d 100644
> --- a/README.md
> +++ b/README.md
> @@ -25,9 +25,8 @@ for more information.
>
>  Minimum Supported Kernel Version
>  --------------------------------
> -The minimum supported kernel version is Linux v3.0 (for the
> -/sys/fs/selinux mount point directory) for libselinux and anything
> -that uses libselinux to access selinuxfs.
> +The minimum supported kernel version is Linux v4.3 to match the
> +minimum supported kernel policy version by libsepol.
>
>  Note that the policy build toolchain (e.g. libsepol, checkpolicy,
>  checkmodule, secilc, semodule_package/expand/link) does not link with
> @@ -38,16 +37,16 @@ successfully been built and run on non-Linux platform=
s as well
>
>  Minimum Supported Policy Versions
>  ---------------------------------
> -The minimum kernel policy version is 24 (boundary) for the SELinux and
> -Xen targets. Support for this policy version first shipped in libsepol
> -2.0.34 (userspace release 20090403), Linux v2.6.28, and Xen
> -4.0.0. libsepol dropped support for kernel policy versions older than
> -24 starting with libsepol 3.12.
> +The minimum kernel policy version is 30 (xperms_ioctl for SELinux,
> +xen_devicetree for Xen). Support for this policy version first shipped
> +in libsepol 2.5 (userspace release 20160223), Linux v4.3, and Xen
> +4.6. libsepol dropped support for kernel policy versions older than 30
> +starting with libsepol 3.12.
>
> -The minimum modular policy version is 10 (boundary alias). Support for
> -this modular policy version first shipped in libsepol 2.0.35
> -(userspace release 20090403). libsepol dropped support for modular
> -policies older than 10 starting with libsepol 3.12
> +The minimum modular policy version is 18 (xperms_ioctl). Support for
> +this modular policy version first shipped in libsepol 2.7 (userspace
> +release 20170804). libsepol dropped support for modular policies older
> +than 18 starting with libsepol 3.12.
>
>  These minimum policy versions in libsepol affect:
>  1. The policy build toolchain. For example, checkpolicy, checkmodule,
> @@ -60,8 +59,8 @@ the minimum.
>  3. SELinux policy analysis tools. For example, setools cannot read a
>  policy with a version less the minimum.
>  4. The Xen hypervisor, which compiles its XSM/Flask policies using
> -checkpolicy, and only currently supports kernel policy versions 24 and
> -30 for the Xen target. Xen does not use binary policy modules so it is
> +checkpolicy, and only currently supports kernel policy version 30 for
> +the Xen target. Xen does not use binary policy modules so it is
>  unaffected by changes to the minimum modular policy version.
>  5. Android, which is on kernel policy version 30. There has not been
>  any need for newer policy version features yet. Android does not use
> diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.c b/checkpolicy/fuzz/che=
ckpolicy-fuzzer.c
> index 401f24e3..ccbcfa7a 100644
> --- a/checkpolicy/fuzz/checkpolicy-fuzzer.c
> +++ b/checkpolicy/fuzz/checkpolicy-fuzzer.c
> @@ -187,8 +187,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_=
t size)
>             policyvers > POLICYDB_VERSION_MAX)
>                 return 0;
>         if (platform =3D=3D SEPOL_TARGET_XEN &&
> -           policyvers !=3D POLICYDB_VERSION_XEN_DEVICETREE &&
> -           policyvers !=3D POLICYDB_VERSION_BOUNDARY)
> +           policyvers !=3D POLICYDB_VERSION_XEN_DEVICETREE)
>                 return 0;
>         data +=3D 3;
>         size -=3D 3;
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.=
c
> index e99405b4..60b4db4d 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -3189,28 +3189,23 @@ static int __cil_constrain_expr_datum_to_sepol_ex=
pr(policydb_t *pdb,
>                 ebitmap_node_t *tnode;
>                 unsigned int i;
>
> -               if (pdb->policyvers >=3D POLICYDB_VERSION_CONSTRAINT_NAME=
S) {
> -                       rc =3D __cil_get_sepol_type_datum(pdb, item->data=
,
> -                                                       &sepol_type);
> -                       if (rc !=3D SEPOL_OK) {
> -                               if (FLAVOR(item->data) =3D=3D CIL_TYPEATT=
RIBUTE) {
> -                                       struct cil_typeattribute *attr =
=3D
> -                                               item->data;
> -                                       if (!attr->keep) {
> -                                               rc =3D 0;
> -                                       }
> +               rc =3D __cil_get_sepol_type_datum(pdb, item->data, &sepol=
_type);
> +               if (rc !=3D SEPOL_OK) {
> +                       if (FLAVOR(item->data) =3D=3D CIL_TYPEATTRIBUTE) =
{
> +                               struct cil_typeattribute *attr =3D item->=
data;
> +                               if (!attr->keep) {
> +                                       rc =3D 0;
>                                 }
>                         }
> +               }
>
> -                       if (sepol_type) {
> -                               rc =3D ebitmap_set_bit(&expr->type_names-=
>types,
> -                                                    sepol_type->s.value =
- 1,
> -                                                    1);
> -                       }
> +               if (sepol_type) {
> +                       rc =3D ebitmap_set_bit(&expr->type_names->types,
> +                                            sepol_type->s.value - 1, 1);
> +               }
>
> -                       if (rc !=3D SEPOL_OK) {
> -                               goto exit;
> -                       }
> +               if (rc !=3D SEPOL_OK) {
> +                       goto exit;
>                 }
>
>                 rc =3D __cil_expand_type(item->data, &type_bitmap);
> diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/includ=
e/sepol/policydb/policydb.h
> index 8390874d..03831fc2 100644
> --- a/libsepol/include/sepol/policydb/policydb.h
> +++ b/libsepol/include/sepol/policydb/policydb.h
> @@ -195,7 +195,6 @@ typedef struct type_datum {
>
>  /*
>   * Properties of type_datum
> - * available on the policy version >=3D (MOD_)POLICYDB_VERSION_BOUNDARY
>   */
>  #define TYPEDATUM_PROPERTY_PRIMARY 0x0001
>  #define TYPEDATUM_PROPERTY_ATTRIBUTE 0x0002
> @@ -752,12 +751,6 @@ extern int policydb_set_target_platform(policydb_t *=
p, int platform);
>  #define PERM_SYMTAB_SIZE 32
>
>  /* Identify specific policy version changes */
> -#define POLICYDB_VERSION_BOUNDARY 24
> -#define POLICYDB_VERSION_FILENAME_TRANS 25
> -#define POLICYDB_VERSION_ROLETRANS 26
> -#define POLICYDB_VERSION_NEW_OBJECT_DEFAULTS 27
> -#define POLICYDB_VERSION_DEFAULT_TYPE 28
> -#define POLICYDB_VERSION_CONSTRAINT_NAMES 29
>  #define POLICYDB_VERSION_XEN_DEVICETREE 30 /* Xen-specific */
>  #define POLICYDB_VERSION_XPERMS_IOCTL 30 /* Linux-specific */
>  #define POLICYDB_VERSION_INFINIBAND 31 /* Linux-specific */
> @@ -768,18 +761,10 @@ extern int policydb_set_target_platform(policydb_t =
*p, int platform);
>  #define POLICYDB_VERSION_NEVERAUDIT 35 /* neveraudit domains */
>
>  /* Range of policy versions we understand*/
> -#define POLICYDB_VERSION_MIN POLICYDB_VERSION_BOUNDARY
> +#define POLICYDB_VERSION_MIN POLICYDB_VERSION_XPERMS_IOCTL
>  #define POLICYDB_VERSION_MAX POLICYDB_VERSION_NEVERAUDIT
>
>  /* Module versions and specific changes*/
> -#define MOD_POLICYDB_VERSION_BOUNDARY_ALIAS 10
> -#define MOD_POLICYDB_VERSION_FILENAME_TRANS 11
> -#define MOD_POLICYDB_VERSION_ROLETRANS 12
> -#define MOD_POLICYDB_VERSION_ROLEATTRIB 13
> -#define MOD_POLICYDB_VERSION_TUNABLE_SEP 14
> -#define MOD_POLICYDB_VERSION_NEW_OBJECT_DEFAULTS 15
> -#define MOD_POLICYDB_VERSION_DEFAULT_TYPE 16
> -#define MOD_POLICYDB_VERSION_CONSTRAINT_NAMES 17
>  #define MOD_POLICYDB_VERSION_XPERMS_IOCTL 18
>  #define MOD_POLICYDB_VERSION_INFINIBAND 19
>  #define MOD_POLICYDB_VERSION_GLBLUB 20
> @@ -788,7 +773,7 @@ extern int policydb_set_target_platform(policydb_t *p=
, int platform);
>  #define MOD_POLICYDB_VERSION_NEVERAUDIT 23
>  #define MOD_POLICYDB_VERSION_TYPE_ATTR_ATTRS 24
>
> -#define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BOUNDARY_ALIAS
> +#define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_XPERMS_IOCTL
>  #define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_TYPE_ATTR_ATTRS
>
>  #define POLICYDB_CONFIG_MLS 1
> diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
> index a8070a6a..55d10344 100644
> --- a/libsepol/src/conditional.c
> +++ b/libsepol/src/conditional.c
> @@ -592,8 +592,7 @@ int cond_read_bool(policydb_t *p, hashtab_t h, struct=
 policy_file *fp)
>         if (str_read(&key, fp, len))
>                 goto err;
>
> -       if (p->policy_type !=3D POLICY_KERN &&
> -           p->policyvers >=3D MOD_POLICYDB_VERSION_TUNABLE_SEP) {
> +       if (p->policy_type !=3D POLICY_KERN) {
>                 rc =3D next_entry(buf, fp, sizeof(uint32_t));
>                 if (rc < 0)
>                         goto err;
> @@ -808,8 +807,7 @@ static int cond_read_node(policydb_t *p, cond_node_t =
*node, void *fp)
>                         goto err;
>         }
>
> -       if (p->policy_type !=3D POLICY_KERN &&
> -           p->policyvers >=3D MOD_POLICYDB_VERSION_TUNABLE_SEP) {
> +       if (p->policy_type !=3D POLICY_KERN) {
>                 rc =3D next_entry(buf, fp, sizeof(uint32_t));
>                 if (rc < 0)
>                         goto err;
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 3dd3ac4f..bb65a731 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -62,13 +62,6 @@ const char *const policydb_target_strings[] =3D { POLI=
CYDB_STRING,
>
>  /* These need to be updated if SYM_NUM or OCON_NUM changes */
>  static const struct policydb_compat_info policydb_compat[] =3D {
> -       {
> -               .type =3D POLICY_KERN,
> -               .version =3D POLICYDB_VERSION_BOUNDARY,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D OCON_XEN_PCIDEVICE + 1,
> -               .target_platform =3D SEPOL_TARGET_XEN,
> -       },
>         {
>                 .type =3D POLICY_KERN,
>                 .version =3D POLICYDB_VERSION_XEN_DEVICETREE,
> @@ -76,48 +69,6 @@ static const struct policydb_compat_info policydb_comp=
at[] =3D {
>                 .ocon_num =3D OCON_XEN_DEVICETREE + 1,
>                 .target_platform =3D SEPOL_TARGET_XEN,
>         },
> -       {
> -               .type =3D POLICY_KERN,
> -               .version =3D POLICYDB_VERSION_BOUNDARY,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D OCON_NODE6 + 1,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_KERN,
> -               .version =3D POLICYDB_VERSION_FILENAME_TRANS,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D OCON_NODE6 + 1,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_KERN,
> -               .version =3D POLICYDB_VERSION_ROLETRANS,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D OCON_NODE6 + 1,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_KERN,
> -               .version =3D POLICYDB_VERSION_NEW_OBJECT_DEFAULTS,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D OCON_NODE6 + 1,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_KERN,
> -               .version =3D POLICYDB_VERSION_DEFAULT_TYPE,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D OCON_NODE6 + 1,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_KERN,
> -               .version =3D POLICYDB_VERSION_CONSTRAINT_NAMES,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D OCON_NODE6 + 1,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
>         {
>                 .type =3D POLICY_KERN,
>                 .version =3D POLICYDB_VERSION_XPERMS_IOCTL,
> @@ -160,62 +111,6 @@ static const struct policydb_compat_info policydb_co=
mpat[] =3D {
>                 .ocon_num =3D OCON_IBENDPORT + 1,
>                 .target_platform =3D SEPOL_TARGET_SELINUX,
>         },
> -       {
> -               .type =3D POLICY_BASE,
> -               .version =3D MOD_POLICYDB_VERSION_BOUNDARY_ALIAS,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D OCON_NODE6 + 1,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_BASE,
> -               .version =3D MOD_POLICYDB_VERSION_FILENAME_TRANS,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D OCON_NODE6 + 1,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_BASE,
> -               .version =3D MOD_POLICYDB_VERSION_ROLETRANS,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D OCON_NODE6 + 1,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_BASE,
> -               .version =3D MOD_POLICYDB_VERSION_ROLEATTRIB,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D OCON_NODE6 + 1,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_BASE,
> -               .version =3D MOD_POLICYDB_VERSION_TUNABLE_SEP,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D OCON_NODE6 + 1,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_BASE,
> -               .version =3D MOD_POLICYDB_VERSION_NEW_OBJECT_DEFAULTS,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D OCON_NODE6 + 1,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_BASE,
> -               .version =3D MOD_POLICYDB_VERSION_DEFAULT_TYPE,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D OCON_NODE6 + 1,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_BASE,
> -               .version =3D MOD_POLICYDB_VERSION_CONSTRAINT_NAMES,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D OCON_NODE6 + 1,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
>         {
>                 .type =3D POLICY_BASE,
>                 .version =3D MOD_POLICYDB_VERSION_XPERMS_IOCTL,
> @@ -265,62 +160,6 @@ static const struct policydb_compat_info policydb_co=
mpat[] =3D {
>                 .ocon_num =3D OCON_IBENDPORT + 1,
>                 .target_platform =3D SEPOL_TARGET_SELINUX,
>         },
> -       {
> -               .type =3D POLICY_MOD,
> -               .version =3D MOD_POLICYDB_VERSION_BOUNDARY_ALIAS,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D 0,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_MOD,
> -               .version =3D MOD_POLICYDB_VERSION_FILENAME_TRANS,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D 0,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_MOD,
> -               .version =3D MOD_POLICYDB_VERSION_ROLETRANS,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D 0,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_MOD,
> -               .version =3D MOD_POLICYDB_VERSION_ROLEATTRIB,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D 0,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_MOD,
> -               .version =3D MOD_POLICYDB_VERSION_TUNABLE_SEP,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D 0,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_MOD,
> -               .version =3D MOD_POLICYDB_VERSION_NEW_OBJECT_DEFAULTS,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D 0,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_MOD,
> -               .version =3D MOD_POLICYDB_VERSION_DEFAULT_TYPE,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D 0,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_MOD,
> -               .version =3D MOD_POLICYDB_VERSION_CONSTRAINT_NAMES,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D 0,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
>         {
>                 .type =3D POLICY_MOD,
>                 .version =3D MOD_POLICYDB_VERSION_XPERMS_IOCTL,
> @@ -2046,9 +1885,8 @@ bad:
>         return -1;
>  }
>
> -static int read_cons_helper(policydb_t *p, constraint_node_t **nodep,
> -                           unsigned int ncons, int allowxtarget,
> -                           struct policy_file *fp)
> +static int read_cons_helper(constraint_node_t **nodep, unsigned int ncon=
s,
> +                           int allowxtarget, struct policy_file *fp)
>  {
>         constraint_node_t *c, *lc;
>         constraint_expr_t *e, *le;
> @@ -2120,13 +1958,7 @@ static int read_cons_helper(policydb_t *p, constra=
int_node_t **nodep,
>                                 depth++;
>                                 if (ebitmap_read(&e->names, fp))
>                                         return -1;
> -                               if (p->policy_type !=3D POLICY_KERN &&
> -                                   type_set_read(e->type_names, fp))
> -                                       return -1;
> -                               else if (p->policy_type =3D=3D POLICY_KER=
N &&
> -                                        p->policyvers >=3D
> -                                                POLICYDB_VERSION_CONSTRA=
INT_NAMES &&
> -                                        type_set_read(e->type_names, fp)=
)
> +                               if (type_set_read(e->type_names, fp))
>                                         return -1;
>                                 break;
>                         default:
> @@ -2196,7 +2028,7 @@ static int class_read(policydb_t *p, hashtab_t h, s=
truct policy_file *fp)
>                         goto bad;
>         }
>
> -       if (read_cons_helper(p, &cladatum->constraints, ncons, 0, fp))
> +       if (read_cons_helper(&cladatum->constraints, ncons, 0, fp))
>                 goto bad;
>
>         if ((p->policy_type =3D=3D POLICY_KERN) ||
> @@ -2206,26 +2038,18 @@ static int class_read(policydb_t *p, hashtab_t h,=
 struct policy_file *fp)
>                 if (rc < 0)
>                         goto bad;
>                 ncons =3D le32_to_cpu(buf[0]);
> -               if (read_cons_helper(p, &cladatum->validatetrans, ncons, =
1, fp))
> +               if (read_cons_helper(&cladatum->validatetrans, ncons, 1, =
fp))
>                         goto bad;
>         }
>
> -       if ((p->policy_type =3D=3D POLICY_KERN &&
> -            p->policyvers >=3D POLICYDB_VERSION_NEW_OBJECT_DEFAULTS) ||
> -           (p->policy_type =3D=3D POLICY_BASE &&
> -            p->policyvers >=3D MOD_POLICYDB_VERSION_NEW_OBJECT_DEFAULTS)=
) {
> +       if ((p->policy_type =3D=3D POLICY_KERN) ||
> +           (p->policy_type =3D=3D POLICY_BASE)) {
>                 rc =3D next_entry(buf, fp, sizeof(uint32_t) * 3);
>                 if (rc < 0)
>                         goto bad;
>                 cladatum->default_user =3D le32_to_cpu(buf[0]);
>                 cladatum->default_role =3D le32_to_cpu(buf[1]);
>                 cladatum->default_range =3D le32_to_cpu(buf[2]);
> -       }
> -
> -       if ((p->policy_type =3D=3D POLICY_KERN &&
> -            p->policyvers >=3D POLICYDB_VERSION_DEFAULT_TYPE) ||
> -           (p->policy_type =3D=3D POLICY_BASE &&
> -            p->policyvers >=3D MOD_POLICYDB_VERSION_DEFAULT_TYPE)) {
>                 rc =3D next_entry(buf, fp, sizeof(uint32_t));
>                 if (rc < 0)
>                         goto bad;
> @@ -2277,8 +2101,7 @@ static int role_read(policydb_t *p, hashtab_t h, st=
ruct policy_file *fp)
>                         goto bad;
>         }
>
> -       if (p->policy_type !=3D POLICY_KERN &&
> -           p->policyvers >=3D MOD_POLICYDB_VERSION_ROLEATTRIB) {
> +       if (p->policy_type !=3D POLICY_KERN) {
>                 rc =3D next_entry(buf, fp, sizeof(uint32_t));
>                 if (rc < 0)
>                         goto bad;
> @@ -2386,8 +2209,6 @@ static int role_trans_read(policydb_t *p, struct po=
licy_file *fp)
>         uint32_t buf[3], nel;
>         role_trans_t *tr, *ltr;
>         int rc;
> -       int new_roletr =3D (p->policy_type =3D=3D POLICY_KERN &&
> -                         p->policyvers >=3D POLICYDB_VERSION_ROLETRANS);
>
>         rc =3D next_entry(buf, fp, sizeof(uint32_t));
>         if (rc < 0)
> @@ -2410,13 +2231,10 @@ static int role_trans_read(policydb_t *p, struct =
policy_file *fp)
>                 tr->role =3D le32_to_cpu(buf[0]);
>                 tr->type =3D le32_to_cpu(buf[1]);
>                 tr->new_role =3D le32_to_cpu(buf[2]);
> -               if (new_roletr) {
> -                       rc =3D next_entry(buf, fp, sizeof(uint32_t));
> -                       if (rc < 0)
> -                               return -1;
> -                       tr->tclass =3D le32_to_cpu(buf[0]);
> -               } else
> -                       tr->tclass =3D p->process_class;
> +               rc =3D next_entry(buf, fp, sizeof(uint32_t));
> +               if (rc < 0)
> +                       return -1;
> +               tr->tclass =3D le32_to_cpu(buf[0]);
>                 ltr =3D tr;
>         }
>         return 0;
> @@ -3412,7 +3230,6 @@ static int range_read(policydb_t *p, struct policy_=
file *fp)
>         struct mls_range *r =3D NULL;
>         range_trans_rule_t *rtr =3D NULL, *lrtr =3D NULL;
>         unsigned int i;
> -       int new_rangetr =3D (p->policy_type =3D=3D POLICY_KERN);
>         int rc;
>
>         rc =3D next_entry(buf, fp, sizeof(uint32_t));
> @@ -3432,13 +3249,10 @@ static int range_read(policydb_t *p, struct polic=
y_file *fp)
>                 rt->target_type =3D le32_to_cpu(buf[1]);
>                 if (!value_isvalid(rt->target_type, p->p_types.nprim))
>                         goto err;
> -               if (new_rangetr) {
> -                       rc =3D next_entry(buf, fp, (sizeof(uint32_t)));
> -                       if (rc < 0)
> -                               goto err;
> -                       rt->target_class =3D le32_to_cpu(buf[0]);
> -               } else
> -                       rt->target_class =3D p->process_class;
> +               rc =3D next_entry(buf, fp, (sizeof(uint32_t)));
> +               if (rc < 0)
> +                       goto err;
> +               rt->target_class =3D le32_to_cpu(buf[0]);
>                 if (!value_isvalid(rt->target_class, p->p_classes.nprim))
>                         goto err;
>                 r =3D calloc(1, sizeof(*r));
> @@ -3532,8 +3346,7 @@ int avrule_read_list(policydb_t *p, avrule_t **avru=
les, struct policy_file *fp)
>         return 0;
>  }
>
> -static int role_trans_rule_read(policydb_t *p, role_trans_rule_t **r,
> -                               struct policy_file *fp)
> +static int role_trans_rule_read(role_trans_rule_t **r, struct policy_fil=
e *fp)
>  {
>         uint32_t buf[1], nel;
>         unsigned int i;
> @@ -3564,16 +3377,8 @@ static int role_trans_rule_read(policydb_t *p, rol=
e_trans_rule_t **r,
>                 if (type_set_read(&tr->types, fp))
>                         return -1;
>
> -               if (p->policyvers >=3D MOD_POLICYDB_VERSION_ROLETRANS) {
> -                       if (ebitmap_read(&tr->classes, fp))
> -                               return -1;
> -               } else {
> -                       if (!p->process_class)
> -                               return -1;
> -                       if (ebitmap_set_bit(&tr->classes, p->process_clas=
s - 1,
> -                                           1))
> -                               return -1;
> -               }
> +               if (ebitmap_read(&tr->classes, fp))
> +                       return -1;
>
>                 rc =3D next_entry(buf, fp, sizeof(uint32_t));
>                 if (rc < 0)
> @@ -3772,13 +3577,12 @@ static int avrule_decl_read(policydb_t *p, avrule=
_decl_t *decl,
>         decl->enabled =3D le32_to_cpu(buf[1]);
>         if (cond_read_list(p, &decl->cond_list, fp) =3D=3D -1 ||
>             avrule_read_list(p, &decl->avrules, fp) =3D=3D -1 ||
> -           role_trans_rule_read(p, &decl->role_tr_rules, fp) =3D=3D -1 |=
|
> +           role_trans_rule_read(&decl->role_tr_rules, fp) =3D=3D -1 ||
>             role_allow_rule_read(&decl->role_allow_rules, fp) =3D=3D -1) =
{
>                 return -1;
>         }
>
> -       if (p->policyvers >=3D MOD_POLICYDB_VERSION_FILENAME_TRANS &&
> -           filename_trans_rule_read(p, &decl->filename_trans_rules, fp))
> +       if (filename_trans_rule_read(p, &decl->filename_trans_rules, fp))
>                 return -1;
>
>         if (range_trans_rule_read(&decl->range_tr_rules, fp) =3D=3D -1) {
> @@ -4227,8 +4031,7 @@ int policydb_read(policydb_t *p, struct policy_file=
 *fp, unsigned verbose)
>                         goto bad;
>                 if (role_allow_read(&p->role_allow, fp))
>                         goto bad;
> -               if (r_policyvers >=3D POLICYDB_VERSION_FILENAME_TRANS &&
> -                   filename_trans_read(p, fp))
> +               if (filename_trans_read(p, fp))
>                         goto bad;
>         } else {
>                 /* first read the AV rule blocks, then the scope tables *=
/
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index fe8bf1cf..4d7983d5 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -1586,11 +1586,6 @@ static int validate_ocontexts(sepol_handle_t *hand=
le, const policydb_t *p,
>                                         if (octx->u.iomem.low_iomem >
>                                             octx->u.iomem.high_iomem)
>                                                 goto bad;
> -                                       if (p->policyvers <
> -                                                   POLICYDB_VERSION_XEN_=
DEVICETREE &&
> -                                           octx->u.iomem.high_iomem >
> -                                                   0xFFFFFFFFULL)
> -                                               goto bad;
>                                         break;
>                                 case OCON_XEN_DEVICETREE:
>                                         if (validate_string_field(octx->u=
.name))
> @@ -2088,9 +2083,8 @@ int policydb_validate(sepol_handle_t *handle, const=
 policydb_t *p)
>                         goto bad;
>                 if (validate_role_allows(handle, p->role_allow, flavors))
>                         goto bad;
> -               if (p->policyvers >=3D POLICYDB_VERSION_FILENAME_TRANS)
> -                       if (validate_filename_trans_hashtab(handle, p, fl=
avors))
> -                               goto bad;
> +               if (validate_filename_trans_hashtab(handle, p, flavors))
> +                       goto bad;
>         } else {
>                 if ((p->policy_type =3D=3D POLICY_MOD) && (p->p_commons.n=
prim > 0))
>                         goto bad;
> diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> index 3e8bd38b..fdd84078 100644
> --- a/libsepol/src/services.c
> +++ b/libsepol/src/services.c
> @@ -202,12 +202,10 @@ static void cat_expr_buf(char *e_buf, const char *s=
tring)
>  }
>
>  /*
> - * If the POLICY_KERN version is >=3D POLICYDB_VERSION_CONSTRAINT_NAMES,
> - * then for 'types' only, read the types_names->types list as it will
> + * For 'types' only, read the types_names->types list as it will
>   * contain a list of types and attributes that were defined in the
>   * policy source.
> - * For user and role plus types (for policy vers <
> - * POLICYDB_VERSION_CONSTRAINT_NAMES) just read the e->names list.
> + * For user and role just read the e->names list.
>   */
>  static void get_name_list(constraint_expr_t *e, int type, const char *sr=
c,
>                           const char *op, int failed)
> @@ -218,9 +216,7 @@ static void get_name_list(constraint_expr_t *e, int t=
ype, const char *src,
>         char tmp_buf[128];
>         int counter =3D 0;
>
> -       if (policydb->policy_type =3D=3D POLICY_KERN &&
> -           policydb->policyvers >=3D POLICYDB_VERSION_CONSTRAINT_NAMES &=
&
> -           type =3D=3D CEXPR_TYPE)
> +       if (policydb->policy_type =3D=3D POLICY_KERN && type =3D=3D CEXPR=
_TYPE)
>                 types =3D &e->type_names->types;
>         else
>                 types =3D &e->names;
> diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> index a0c9af85..11202333 100644
> --- a/libsepol/src/write.c
> +++ b/libsepol/src/write.c
> @@ -347,41 +347,26 @@ static int role_trans_write(policydb_t *p, struct p=
olicy_file *fp)
>         role_trans_t *tr;
>         uint32_t buf[3];
>         size_t nel, items;
> -       int new_roletr =3D (p->policy_type =3D=3D POLICY_KERN &&
> -                         p->policyvers >=3D POLICYDB_VERSION_ROLETRANS);
> -       int warning_issued =3D 0;
>
>         nel =3D 0;
>         for (tr =3D r; tr; tr =3D tr->next)
> -               if (new_roletr || tr->tclass =3D=3D p->process_class)
> -                       nel++;
> +               nel++;
>
>         buf[0] =3D cpu_to_le32(nel);
>         items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
>         if (items !=3D 1)
>                 return POLICYDB_ERROR;
>         for (tr =3D r; tr; tr =3D tr->next) {
> -               if (!new_roletr && tr->tclass !=3D p->process_class) {
> -                       if (!warning_issued)
> -                               WARN(fp->handle,
> -                                    "Discarding role_transition "
> -                                    "rules for security classes other th=
an "
> -                                    "\"process\"");
> -                       warning_issued =3D 1;
> -                       continue;
> -               }
>                 buf[0] =3D cpu_to_le32(tr->role);
>                 buf[1] =3D cpu_to_le32(tr->type);
>                 buf[2] =3D cpu_to_le32(tr->new_role);
>                 items =3D put_entry(buf, sizeof(uint32_t), 3, fp);
>                 if (items !=3D 3)
>                         return POLICYDB_ERROR;
> -               if (new_roletr) {
> -                       buf[0] =3D cpu_to_le32(tr->tclass);
> -                       items =3D put_entry(buf, sizeof(uint32_t), 1, fp)=
;
> -                       if (items !=3D 1)
> -                               return POLICYDB_ERROR;
> -               }
> +               buf[0] =3D cpu_to_le32(tr->tclass);
> +               items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
> +               if (items !=3D 1)
> +                       return POLICYDB_ERROR;
>         }
>
>         return POLICYDB_SUCCESS;
> @@ -500,9 +485,6 @@ static int filename_trans_write(struct policydb *p, v=
oid *fp)
>         uint32_t buf[1];
>         int rc;
>
> -       if (p->policyvers < POLICYDB_VERSION_FILENAME_TRANS)
> -               return 0;
> -
>         if (p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
>                 buf[0] =3D cpu_to_le32(p->filename_trans_count);
>                 items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
> @@ -579,8 +561,7 @@ static int cond_write_bool(hashtab_key_t key, hashtab=
_datum_t datum, void *ptr)
>         if (items !=3D len)
>                 return POLICYDB_ERROR;
>
> -       if (p->policy_type !=3D POLICY_KERN &&
> -           p->policyvers >=3D MOD_POLICYDB_VERSION_TUNABLE_SEP) {
> +       if (p->policy_type !=3D POLICY_KERN) {
>                 buf[0] =3D cpu_to_le32(booldatum->flags);
>                 items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
>                 if (items !=3D 1)
> @@ -678,8 +659,7 @@ static int cond_write_node(policydb_t *p, cond_node_t=
 *node,
>                         return POLICYDB_ERROR;
>         }
>
> -       if (p->policy_type !=3D POLICY_KERN &&
> -           p->policyvers >=3D MOD_POLICYDB_VERSION_TUNABLE_SEP) {
> +       if (p->policy_type !=3D POLICY_KERN) {
>                 buf[0] =3D cpu_to_le32(node->flags);
>                 items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
>                 if (items !=3D 1)
> @@ -728,7 +708,7 @@ static int context_write(struct policydb *p, context_=
struct_t *c,
>         items2 =3D put_entry(buf, sizeof(uint32_t), items, fp);
>         if (items2 !=3D items)
>                 return POLICYDB_ERROR;
> -       if ((p->policy_type =3D=3D POLICY_KERN) || (p->policy_type =3D=3D=
 POLICY_BASE))
> +       if (p->policy_type =3D=3D POLICY_KERN || p->policy_type =3D=3D PO=
LICY_BASE)
>                 if (mls_write_range_helper(&c->range, fp))
>                         return POLICYDB_ERROR;
>
> @@ -796,8 +776,8 @@ static int common_write(hashtab_key_t key, hashtab_da=
tum_t datum, void *ptr)
>         return POLICYDB_SUCCESS;
>  }
>
> -static int write_cons_helper(policydb_t *p, constraint_node_t *node,
> -                            int allowxtarget, struct policy_file *fp)
> +static int write_cons_helper(constraint_node_t *node, int allowxtarget,
> +                            struct policy_file *fp)
>  {
>         constraint_node_t *c;
>         constraint_expr_t *e;
> @@ -829,12 +809,7 @@ static int write_cons_helper(policydb_t *p, constrai=
nt_node_t *node,
>                                 if (ebitmap_write(&e->names, fp)) {
>                                         return POLICYDB_ERROR;
>                                 }
> -                               if ((p->policy_type !=3D POLICY_KERN &&
> -                                    type_set_write(e->type_names, fp)) |=
|
> -                                   (p->policy_type =3D=3D POLICY_KERN &&
> -                                    (p->policyvers >=3D
> -                                     POLICYDB_VERSION_CONSTRAINT_NAMES) =
&&
> -                                    type_set_write(e->type_names, fp))) =
{
> +                               if (type_set_write(e->type_names, fp)) {
>                                         return POLICYDB_ERROR;
>                                 }
>                                 break;
> @@ -896,11 +871,10 @@ static int class_write(hashtab_key_t key, hashtab_d=
atum_t datum, void *ptr)
>         if (hashtab_map(cladatum->permissions.table, perm_write, pd))
>                 return POLICYDB_ERROR;
>
> -       if (write_cons_helper(p, cladatum->constraints, 0, fp))
> +       if (write_cons_helper(cladatum->constraints, 0, fp))
>                 return POLICYDB_ERROR;
>
> -       if ((p->policy_type =3D=3D POLICY_KERN) ||
> -           (p->policy_type =3D=3D POLICY_BASE)) {
> +       if (p->policy_type =3D=3D POLICY_KERN || p->policy_type =3D=3D PO=
LICY_BASE) {
>                 /* write out the validatetrans rule */
>                 ncons =3D 0;
>                 for (c =3D cladatum->validatetrans; c; c =3D c->next) {
> @@ -910,14 +884,9 @@ static int class_write(hashtab_key_t key, hashtab_da=
tum_t datum, void *ptr)
>                 items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
>                 if (items !=3D 1)
>                         return POLICYDB_ERROR;
> -               if (write_cons_helper(p, cladatum->validatetrans, 1, fp))
> +               if (write_cons_helper(cladatum->validatetrans, 1, fp))
>                         return POLICYDB_ERROR;
> -       }
>
> -       if ((p->policy_type =3D=3D POLICY_KERN &&
> -            p->policyvers >=3D POLICYDB_VERSION_NEW_OBJECT_DEFAULTS) ||
> -           (p->policy_type =3D=3D POLICY_BASE &&
> -            p->policyvers >=3D MOD_POLICYDB_VERSION_NEW_OBJECT_DEFAULTS)=
) {
>                 char default_range =3D cladatum->default_range;
>
>                 buf[0] =3D cpu_to_le32(cladatum->default_user);
> @@ -937,12 +906,7 @@ static int class_write(hashtab_key_t key, hashtab_da=
tum_t datum, void *ptr)
>                 items =3D put_entry(buf, sizeof(uint32_t), 3, fp);
>                 if (items !=3D 3)
>                         return POLICYDB_ERROR;
> -       }
>
> -       if ((p->policy_type =3D=3D POLICY_KERN &&
> -            p->policyvers >=3D POLICYDB_VERSION_DEFAULT_TYPE) ||
> -           (p->policy_type =3D=3D POLICY_BASE &&
> -            p->policyvers >=3D MOD_POLICYDB_VERSION_DEFAULT_TYPE)) {
>                 buf[0] =3D cpu_to_le32(cladatum->default_type);
>                 items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
>                 if (items !=3D 1)
> @@ -970,10 +934,7 @@ static int role_write(hashtab_key_t key, hashtab_dat=
um_t datum, void *ptr)
>          *
>          * Their numbers would be deducted in policydb_write().
>          */
> -       if ((role->flavor =3D=3D ROLE_ATTRIB) &&
> -           ((p->policy_type =3D=3D POLICY_KERN) ||
> -            (p->policy_type !=3D POLICY_KERN &&
> -             p->policyvers < MOD_POLICYDB_VERSION_ROLEATTRIB)))
> +       if (role->flavor =3D=3D ROLE_ATTRIB && p->policy_type =3D=3D POLI=
CY_KERN)
>                 return POLICYDB_SUCCESS;
>
>         len =3D strlen(key);
> @@ -1016,8 +977,7 @@ static int role_write(hashtab_key_t key, hashtab_dat=
um_t datum, void *ptr)
>                         return POLICYDB_ERROR;
>         }
>
> -       if (p->policy_type !=3D POLICY_KERN &&
> -           p->policyvers >=3D MOD_POLICYDB_VERSION_ROLEATTRIB) {
> +       if (p->policy_type !=3D POLICY_KERN) {
>                 buf[0] =3D cpu_to_le32(role->flavor);
>                 items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
>                 if (items !=3D 1)
> @@ -1463,27 +1423,10 @@ static int genfs_write(policydb_t *p, struct poli=
cy_file *fp)
>  }
>
>  struct rangetrans_write_args {
> -       size_t nel;
> -       int new_rangetr;
>         struct policy_file *fp;
>         struct policydb *p;
>  };
>
> -static int rangetrans_count(hashtab_key_t key,
> -                           void *data __attribute__((unused)), void *ptr=
)
> -{
> -       struct range_trans *rt =3D (struct range_trans *)key;
> -       struct rangetrans_write_args *args =3D ptr;
> -       struct policydb *p =3D args->p;
> -
> -       /* all range_transitions are written for the new format, only
> -          process related range_transitions are written for the old
> -          format, so count accordingly */
> -       if (args->new_rangetr || rt->target_class =3D=3D p->process_class=
)
> -               args->nel++;
> -       return 0;
> -}
> -
>  static int range_write_helper(hashtab_key_t key, void *data, void *ptr)
>  {
>         uint32_t buf[2];
> @@ -1491,33 +1434,19 @@ static int range_write_helper(hashtab_key_t key, =
void *data, void *ptr)
>         struct mls_range *r =3D data;
>         struct rangetrans_write_args *args =3D ptr;
>         struct policy_file *fp =3D args->fp;
> -       struct policydb *p =3D args->p;
> -       int new_rangetr =3D args->new_rangetr;
>         size_t items;
> -       static int warning_issued =3D 0;
>         int rc;
>
> -       if (!new_rangetr && rt->target_class !=3D p->process_class) {
> -               if (!warning_issued)
> -                       WARN(fp->handle,
> -                            "Discarding range_transition "
> -                            "rules for security classes other than "
> -                            "\"process\"");
> -               warning_issued =3D 1;
> -               return 0;
> -       }
> -
>         buf[0] =3D cpu_to_le32(rt->source_type);
>         buf[1] =3D cpu_to_le32(rt->target_type);
>         items =3D put_entry(buf, sizeof(uint32_t), 2, fp);
>         if (items !=3D 2)
>                 return POLICYDB_ERROR;
> -       if (new_rangetr) {
> -               buf[0] =3D cpu_to_le32(rt->target_class);
> -               items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
> -               if (items !=3D 1)
> -                       return POLICYDB_ERROR;
> -       }
> +       buf[0] =3D cpu_to_le32(rt->target_class);
> +       items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
> +       if (items !=3D 1)
> +               return POLICYDB_ERROR;
> +
>         rc =3D mls_write_range_helper(r, fp);
>         if (rc)
>                 return rc;
> @@ -1529,19 +1458,12 @@ static int range_write(policydb_t *p, struct poli=
cy_file *fp)
>  {
>         size_t items;
>         uint32_t buf[2];
> -       int new_rangetr =3D (p->policy_type =3D=3D POLICY_KERN);
>         struct rangetrans_write_args args;
> -       int rc;
>
> -       args.nel =3D 0;
> -       args.new_rangetr =3D new_rangetr;
>         args.fp =3D fp;
>         args.p =3D p;
> -       rc =3D hashtab_map(p->range_tr, rangetrans_count, &args);
> -       if (rc)
> -               return rc;
>
> -       buf[0] =3D cpu_to_le32(args.nel);
> +       buf[0] =3D cpu_to_le32(p->range_tr->nel);
>         items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
>         if (items !=3D 1)
>                 return POLICYDB_ERROR;
> @@ -1676,58 +1598,27 @@ static int avrule_write_list(policydb_t *p, avrul=
e_t *avrules,
>         return POLICYDB_SUCCESS;
>  }
>
> -static int only_process(ebitmap_t *in, struct policydb *p)
> -{
> -       unsigned int i, value;
> -       ebitmap_node_t *node;
> -
> -       if (!p->process_class)
> -               return 0;
> -
> -       value =3D p->process_class - 1;
> -
> -       ebitmap_for_each_positive_bit(in, node, i) {
> -               if (i !=3D value)
> -                       return 0;
> -       }
> -       return 1;
> -}
> -
> -static int role_trans_rule_write(policydb_t *p, role_trans_rule_t *t,
> -                                struct policy_file *fp)
> +static int role_trans_rule_write(role_trans_rule_t *t, struct policy_fil=
e *fp)
>  {
>         int nel =3D 0;
>         size_t items;
>         uint32_t buf[1];
>         role_trans_rule_t *tr;
> -       int warned =3D 0;
> -       int new_role =3D p->policyvers >=3D MOD_POLICYDB_VERSION_ROLETRAN=
S;
>
>         for (tr =3D t; tr; tr =3D tr->next)
> -               if (new_role || only_process(&tr->classes, p))
> -                       nel++;
> +               nel++;
>
>         buf[0] =3D cpu_to_le32(nel);
>         items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
>         if (items !=3D 1)
>                 return POLICYDB_ERROR;
>         for (tr =3D t; tr; tr =3D tr->next) {
> -               if (!new_role && !only_process(&tr->classes, p)) {
> -                       if (!warned)
> -                               WARN(fp->handle,
> -                                    "Discarding role_transition "
> -                                    "rules for security classes other th=
an "
> -                                    "\"process\"");
> -                       warned =3D 1;
> -                       continue;
> -               }
>                 if (role_set_write(&tr->roles, fp))
>                         return POLICYDB_ERROR;
>                 if (type_set_write(&tr->types, fp))
>                         return POLICYDB_ERROR;
> -               if (new_role)
> -                       if (ebitmap_write(&tr->classes, fp))
> -                               return POLICYDB_ERROR;
> +               if (ebitmap_write(&tr->classes, fp))
> +                       return POLICYDB_ERROR;
>                 buf[0] =3D cpu_to_le32(tr->new_role);
>                 items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
>                 if (items !=3D 1)
> @@ -1873,13 +1764,12 @@ static int avrule_decl_write(avrule_decl_t *decl,=
 int num_scope_syms,
>         }
>         if (cond_write_list(p, decl->cond_list, fp) =3D=3D -1 ||
>             avrule_write_list(p, decl->avrules, fp, 0) =3D=3D -1 ||
> -           role_trans_rule_write(p, decl->role_tr_rules, fp) =3D=3D -1 |=
|
> +           role_trans_rule_write(decl->role_tr_rules, fp) =3D=3D -1 ||
>             role_allow_rule_write(decl->role_allow_rules, fp) =3D=3D -1) =
{
>                 return POLICYDB_ERROR;
>         }
>
> -       if (p->policyvers >=3D MOD_POLICYDB_VERSION_FILENAME_TRANS &&
> -           filename_trans_rule_write(p, decl->filename_trans_rules, fp))
> +       if (filename_trans_rule_write(p, decl->filename_trans_rules, fp))
>                 return POLICYDB_ERROR;
>
>         if (range_trans_rule_write(decl->range_tr_rules, fp) =3D=3D -1) {
> @@ -2120,10 +2010,7 @@ int policydb_write(policydb_t *p, struct policy_fi=
le *fp)
>                  * when the pp's version is not big enough. So deduct
>                  * their numbers from p_roles.table->nel.
>                  */
> -               if ((i =3D=3D SYM_ROLES) &&
> -                   ((p->policy_type =3D=3D POLICY_KERN) ||
> -                    (p->policy_type !=3D POLICY_KERN &&
> -                     p->policyvers < MOD_POLICYDB_VERSION_ROLEATTRIB)))
> +               if (i =3D=3D SYM_ROLES && p->policy_type =3D=3D POLICY_KE=
RN)
>                         (void)hashtab_map(p->symtab[i].table, role_attr_u=
ncount,
>                                           &buf[1]);
>
> @@ -2144,14 +2031,8 @@ int policydb_write(policydb_t *p, struct policy_fi=
le *fp)
>                         return POLICYDB_ERROR;
>                 if (role_allow_write(p->role_allow, fp))
>                         return POLICYDB_ERROR;
> -               if (p->policyvers >=3D POLICYDB_VERSION_FILENAME_TRANS) {
> -                       if (filename_trans_write(p, fp))
> -                               return POLICYDB_ERROR;
> -               } else {
> -                       if (p->filename_trans)
> -                               WARN(fp->handle,
> -                                    "Discarding filename type transition=
 rules");
> -               }
> +               if (filename_trans_write(p, fp))
> +                       return POLICYDB_ERROR;
>         } else {
>                 if (avrule_block_write(p->global, num_syms, p, fp) =3D=3D=
 -1) {
>                         return POLICYDB_ERROR;
> --
> 2.55.0
>

There seems to be some other places that can be simplified in write.c.
In avtab_write_item() on line 112:
 if ((p->policyvers < POLICYDB_VERSION_XPERMS_IOCTL) &&
   (cur->key.specified & AVTAB_XPERMS)) {

In ocontext_write_xen() on line 1168:
    if (p->policyvers >=3D
   POLICYDB_VERSION_XEN_DEVICETREE) {

In avrule_write() on line 1532:
  if (p->policyvers < MOD_POLICYDB_VERSION_XPERMS_IOCTL) {


Also in avtab.c, in avtab_read_item() on line 460:
 if ((vers < POLICYDB_VERSION_XPERMS_IOCTL) &&
   (key.specified & AVTAB_XPERMS)) {


In policydb.c in ocontext_read_xen() on line 2593:
    if (p->policyvers >=3D
   POLICYDB_VERSION_XEN_DEVICETREE) {

Thanks,
Jim
