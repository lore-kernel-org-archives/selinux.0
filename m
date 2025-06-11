Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5889A10A3E
	for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 15:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749655841; cv=none; b=haumeqiJIcEJTxp/ApyJB6Lvh4n3RSgkopQDdG+3uwgpCzoiBwFgEQDuZ1cooFZzgzQP86gAjhhce6XDi3vyAt1KYyuKZozSYx57O2mjxk1sE69SWwNIRVS/RH5uBN5Oo2hRS6xwkzvVUgSNd2GDqSTk+sXE24J+ONqs0ver8bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749655841; c=relaxed/simple;
	bh=pNJOXdi3l7fwO1gxfAHI0a1ONlcK5NB1mWw2wwmTOzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+y3JWYlM5+nBbDhSZMp9e5RtNoHcstKyyRebAk0VEBJLLMeQ/7feN2djjMQ08QF03bLqTjz6AgCtDG/N0Ig2G0on8bt6imdN721MGI7TsrZs5UjMrk/xsQ0wsN5ZZ9gdbjgMMl/u9YLyJEM1BRRUfsN9+xQ3ERbO+8MCif9AQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+N/ZqQA; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+N/ZqQA"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-87ecca2dc48so1165575241.1
        for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 08:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749655838; x=1750260638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFdp4V30xJ6F5RrkLVo4NP/VPl9qtELLZ4lTRTNvz6M=;
        b=a+N/ZqQA1sxJPLx2PHzpte83lDHAWfM02glKe/tXBnU7KQo6frBXGgDmO/J9E/1kWz
         vwemjhZ278T46vN7h5NCnCpcctWqnrI0uKLz4b/ZXuODUuVFcqGnvy723K8Ipki+NZr4
         7khS/QNusGej6PdQrKrMWeQ9Y24IPrOVPGR/yrXHXTr9cUqWqClYczHlswhMk5wM3pY8
         n66+l/Jl0NanBWGmBbrddb511x83viQilzsD++bX+ceUUbhKOF3PKDOjWHvnwXTMLMDs
         Sft538tAXyIonowPA4ug/IRLnL1nP3j3/69bX5UeRhO3+gX9qhRI0XZIG9dp23vHLpAl
         uUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749655838; x=1750260638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFdp4V30xJ6F5RrkLVo4NP/VPl9qtELLZ4lTRTNvz6M=;
        b=vvPCYDUo9FPq8pBFDSP7S5/sTGkWtIh1H/pEBEu5PHRz/uroj/Q7llxTw656dsVqxm
         39nekNWrYuaglOdTYszUWPBw0i53pnEmrpsLBHdGPdCR3nQJIrvKOLk36mKgJCcg6Lfa
         kRy+jbNgU2csHqeVyf2sYT1VKqiIwHfsDYjVoEJNlFKntSOVCShTzylioWlbtsLAAXFk
         c6baZIhg6IJyR8LXIZfaai5ya/LfH6UJNT6f/9f0Ia5f/fNpjvsU5iB/jpDFz58vWhqD
         5edHxic1awdwAbtqqPmtA2nRkR7O4sOSKyqr8PxHLZTWK6ztH7piYPGyObi2povW62II
         bryw==
X-Gm-Message-State: AOJu0YzGvUBtIs15VJVtlXfK5JdgTaiMVcckgfoYoPLJfi3uAIflQRsc
	/zv7P2w9nDlqn/JyrThZJKl0bBbysrMGg1y/6WC98M3oO6X6hgCCf4lAGl3Yf8rA5Si0UoYjLeU
	Nyeup2p4lSIdwsLILS7M6wG+CkDlFPo0=
X-Gm-Gg: ASbGncuxEm+f+P33q/MNuqo9+2c6jtvFMLCeDVPDceytCajKhRu56D9nE9KJeXSJq5F
	grMr5od6xp1lstrVT9PwXob8hit60+L3D1o6OcTb1binchnQQ3JsjsRYazJ55hqq4yjM96JixX2
	v9M6uqJvWZA6A9y2YjXU8+U7T0HN5kL+qCgx0rqwzeLVA=
X-Google-Smtp-Source: AGHT+IFiqP+KJK2BY8E1ALPIM91kEtcFtEHEsMUMO8/Jw/z82suwfXl13eP+btwLvHtd+YZbbaoxQsLi63XR2Tb6dZ8=
X-Received: by 2002:a05:6102:94d:b0:4e5:ac0f:582c with SMTP id
 ada2fe7eead31-4e7ccd123a3mr217502137.13.1749655837853; Wed, 11 Jun 2025
 08:30:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530051322.1678251-1-inseob@google.com> <20250530051322.1678251-3-inseob@google.com>
In-Reply-To: <20250530051322.1678251-3-inseob@google.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 11 Jun 2025 11:30:25 -0400
X-Gm-Features: AX0GCFvXG0psMorFoBoaRfm6bLYG6MUO7vrZzlTe0ubJL9qAFXPQIHZQO-EVbu4
Message-ID: <CAP+JOzTSS=hY0SpCAJ=+o6=i8kbsqTSyx_OTmRghZRUC6yi9ow@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] libsepol: Support genfs_seclabel_wildcard
To: Inseob Kim <inseob@google.com>
Cc: selinux@vger.kernel.org, takayas@google.com, tweek@google.com, 
	stephen.smalley.work@gmail.com, cgzones@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 1:14=E2=80=AFAM Inseob Kim <inseob@google.com> wrot=
e:
>
> This adds genfs_seclabel_wildcard support to libsepol, which makes genfs
> paths wildcard-matched. To support backward compatibility and to keep
> semantics of genfscon statements, an asterisk '*' is added to paths of
> genfscon statements when compiling CIL/conf files having policycap
> genfs_seclabel_wildcard.
>
> Signed-off-by: Inseob Kim <inseob@google.com>
>
> Changes since v1:
> - Sync the order of polcaps with the kernel
> - Cast to int for printf precision arguments
> ---
>  checkpolicy/policy_define.c               | 14 ++++++++++++++
>  libsepol/cil/src/cil_binary.c             | 15 ++++++++++++++-
>  libsepol/include/sepol/policydb/polcaps.h |  1 +
>  libsepol/src/kernel_to_cil.c              | 20 ++++++++++++++++----
>  libsepol/src/kernel_to_conf.c             | 20 ++++++++++++++++----
>  libsepol/src/polcaps.c                    |  1 +
>  6 files changed, 62 insertions(+), 9 deletions(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 78adbec0..868b8214 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -5967,6 +5967,7 @@ static int define_genfs_context_helper(char *fstype=
, int has_type)
>         char *type =3D NULL;
>         const char *sclass;
>         size_t len, len2;
> +       int wildcard =3D ebitmap_get_bit(&policydbp->policycaps, POLICYDB=
_CAP_GENFS_SECLABEL_WILDCARD);
>
>         if (policydbp->target_platform !=3D SEPOL_TARGET_SELINUX) {
>                 yyerror("genfs not supported for target");
> @@ -6017,6 +6018,19 @@ static int define_genfs_context_helper(char *fstyp=
e, int has_type)
>         newc->u.name =3D (char *)queue_remove(id_queue);
>         if (!newc->u.name)
>                 goto fail;
> +
> +       if (wildcard) {
> +               size_t name_len =3D strlen(newc->u.name);
> +               newc->u.name =3D realloc(newc->u.name, name_len + 2);
> +               if (newc->u.name =3D=3D NULL) {
> +                       yyerror("out of memory");
> +                       return -1;
> +               }
> +
> +               newc->u.name[name_len] =3D '*';
> +               newc->u.name[name_len + 1] =3D '\0';
> +       }
> +
>         if (has_type) {
>                 type =3D (char *)queue_remove(id_queue);
>                 if (!type)
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.=
c
> index b0befda3..b2c940f9 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -3749,6 +3749,7 @@ int cil_genfscon_to_policydb(policydb_t *pdb, struc=
t cil_sort *genfscons)
>         uint32_t i =3D 0;
>         genfs_t *genfs_tail =3D NULL;
>         ocontext_t *ocon_tail =3D NULL;
> +       int wildcard =3D ebitmap_get_bit(&pdb->policycaps, POLICYDB_CAP_G=
ENFS_SECLABEL_WILDCARD);
>
>         for (i =3D 0; i < genfscons->count; i++) {
>                 struct cil_genfscon *cil_genfscon =3D genfscons->array[i]=
;
> @@ -3773,7 +3774,19 @@ int cil_genfscon_to_policydb(policydb_t *pdb, stru=
ct cil_sort *genfscons)
>
>                 ocon_tail =3D new_ocon;
>
> -               new_ocon->u.name =3D cil_strdup(cil_genfscon->path_str);
> +               if (wildcard) {
> +                       size_t name_len =3D strlen(cil_genfscon->path_str=
);
> +                       new_ocon->u.name =3D malloc(name_len + 2);
> +                       if (new_ocon->u.name =3D=3D NULL) {
> +                               cil_log(CIL_ERR, "Failed to allocate memo=
ry\n");
> +                               exit(1);
> +                       }

You should use cil_malloc() here. It will take care of checking for
NULL and exiting with an error message for you.
Everything else looks good to me.
Thanks,
Jim

> +                       memcpy(new_ocon->u.name, cil_genfscon->path_str, =
name_len);
> +                       new_ocon->u.name[name_len] =3D '*';
> +                       new_ocon->u.name[name_len + 1] =3D '\0';
> +               } else {
> +                       new_ocon->u.name =3D cil_strdup(cil_genfscon->pat=
h_str);
> +               }
>
>                 if (cil_genfscon->file_type !=3D CIL_FILECON_ANY) {
>                         class_datum_t *class_datum;
> diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include=
/sepol/policydb/polcaps.h
> index 7bebe4da..0835ea21 100644
> --- a/libsepol/include/sepol/policydb/polcaps.h
> +++ b/libsepol/include/sepol/policydb/polcaps.h
> @@ -18,6 +18,7 @@ enum {
>         POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
>         POLICYDB_CAP_NETLINK_XPERM,
>         POLICYDB_CAP_NETIF_WILDCARD,
> +       POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
>         __POLICYDB_CAP_MAX
>  };
>  #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index ddca2b62..e69e1663 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -2708,6 +2708,8 @@ static int write_genfscon_rules_to_cil(FILE *out, s=
truct policydb *pdb)
>         uint32_t sclass;
>         const char *file_type;
>         int rc;
> +       int wildcard =3D ebitmap_get_bit(&pdb->policycaps, POLICYDB_CAP_G=
ENFS_SECLABEL_WILDCARD);
> +       size_t name_len;
>
>         rc =3D strs_init(&strs, 32);
>         if (rc !=3D 0) {
> @@ -2749,12 +2751,22 @@ static int write_genfscon_rules_to_cil(FILE *out,=
 struct policydb *pdb)
>                                 goto exit;
>                         }
>
> +                       name_len =3D strlen(name);
> +                       if (wildcard) {
> +                               if (name_len =3D=3D 0 || name[name_len - =
1] !=3D '*') {
> +                                       ERR(NULL, "genfscon path must end=
 with '*' when genfs_seclabel_wildcard");
> +                                       rc =3D -1;
> +                                       goto exit;
> +                               }
> +                               --name_len;
> +                       }
> +
>                         if (file_type) {
> -                               rc =3D strs_create_and_add(strs, "(genfsc=
on %s \"%s\" %s %s)",
> -                                                                        =
        fstype, name, file_type, ctx);
> +                               rc =3D strs_create_and_add(strs, "(genfsc=
on %s \"%.*s\" %s %s)",
> +                                                        fstype, (int)nam=
e_len, name, file_type, ctx);
>                         } else {
> -                               rc =3D strs_create_and_add(strs, "(genfsc=
on %s \"%s\" %s)",
> -                                                                        =
        fstype, name, ctx);
> +                               rc =3D strs_create_and_add(strs, "(genfsc=
on %s \"%.*s\" %s)",
> +                                                        fstype, (int)nam=
e_len, name, ctx);
>                         }
>                         free(ctx);
>                         if (rc !=3D 0) {
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
> index 661546af..a7160997 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -2556,6 +2556,8 @@ static int write_genfscon_rules_to_conf(FILE *out, =
struct policydb *pdb)
>         uint32_t sclass;
>         const char *file_type;
>         int rc;
> +       int wildcard =3D ebitmap_get_bit(&pdb->policycaps, POLICYDB_CAP_G=
ENFS_SECLABEL_WILDCARD);
> +       size_t name_len;
>
>         rc =3D strs_init(&strs, 32);
>         if (rc !=3D 0) {
> @@ -2597,12 +2599,22 @@ static int write_genfscon_rules_to_conf(FILE *out=
, struct policydb *pdb)
>                                 goto exit;
>                         }
>
> +                       name_len =3D strlen(name);
> +                       if (wildcard) {
> +                               if (name_len =3D=3D 0 || name[name_len - =
1] !=3D '*') {
> +                                       ERR(NULL, "genfscon path must end=
 with '*' when genfs_seclabel_wildcard");
> +                                       rc =3D -1;
> +                                       goto exit;
> +                               }
> +                               --name_len;
> +                       }
> +
>                         if (file_type) {
> -                               rc =3D strs_create_and_add(strs, "genfsco=
n %s \"%s\" %s %s",
> -                                                                        =
        fstype, name, file_type, ctx);
> +                               rc =3D strs_create_and_add(strs, "genfsco=
n %s \"%.*s\" %s %s",
> +                                                        fstype, (int)nam=
e_len, name, file_type, ctx);
>                         } else {
> -                               rc =3D strs_create_and_add(strs, "genfsco=
n %s \"%s\" %s",
> -                                                                        =
        fstype, name, ctx);
> +                               rc =3D strs_create_and_add(strs, "genfsco=
n %s \"%.*s\" %s",
> +                                                        fstype, (int)nam=
e_len, name, ctx);
>                         }
>                         free(ctx);
>                         if (rc !=3D 0) {
> diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
> index ec6c902d..7ac0ae7c 100644
> --- a/libsepol/src/polcaps.c
> +++ b/libsepol/src/polcaps.c
> @@ -17,6 +17,7 @@ static const char * const polcap_names[POLICYDB_CAP_MAX=
 + 1] =3D {
>         [POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT]        =3D "userspace_in=
itial_context",
>         [POLICYDB_CAP_NETLINK_XPERM]                    =3D "netlink_xper=
m",
>         [POLICYDB_CAP_NETIF_WILDCARD]                   =3D "netif_wildca=
rd",
> +       [POLICYDB_CAP_GENFS_SECLABEL_WILDCARD]          =3D "genfs_seclab=
el_wildcard",
>  };
>
>  int sepol_polcap_getnum(const char *name)
> --
> 2.49.0.1238.gf8c92423fb-goog
>
>
