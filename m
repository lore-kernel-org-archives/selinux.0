Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEB33D9538
	for <selinux@vger.kernel.org>; Tue, 11 Aug 2026 18:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474619; cv=pass; b=ma4LWF+gTse+1ADrkVsXcA92iNjveK0iWECXDzrVe4Z64DUVKizoiahEbYMJytAgDgfnMYy/ocp/+1ATO4sctiSWZ1o/mggQkDyYSzECiuqvO8OB91FAb3pPiTLgJnPvNzOv1CjRm1Fw6jBiHekC41dq+yZ2IHqEdBPI7XNh0kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474619; c=relaxed/simple;
	bh=DLupr2I25oVHurCWtX+KKFU/YVtBKgZXxM6qObvmb7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/ttmolw0NzdKqZV7yqDGB4utB5opS128KqujeiyUl5rEcdevtek8u2WAI+mfxhpC7LYVegPpl9ZnYOoUZefKvgSFb/dM1nnjgwbV7s7IlDjXuKzkEVcoDxjb3BXIBUR3OAAzoZ25+osrkZLMHHz2zJtLQP/bQ3ZJ0tp8BKJg60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjSTI8Mx; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjSTI8Mx"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b013084dc2so182373e87.0
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2026 11:56:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786474614; cv=none;
        d=google.com; s=arc-20260327;
        b=EuZyaB/ULL8dnTWOktz5+PHbpJPKdnSg6UYR0wwCZRX+j/GoWvfHJlwKX/t+gC2PBD
         mr4ozE6TclJKIeP3d+kBrDTujwpulKDk3525PmsC5braEAzHn4xZn1pBSUewXDFFSPcs
         DZDqsJR/QsjgZC6IPr8SGZP1NMusP6y9+q2dzFRBQyPsky3McMe/hStT3XWWq+J+MKeK
         qAuR7Y8tWgTHxd+fJf0nttZPuVbocLAYZ3MsHeP5PyqgdrQKP2wqKRx2z+sOf7Cl/SBf
         goiAMTUIyKU9AtqbIvdub9+/HKH5kcUe3p17rOOCs9AjvEreU55q7Pw44pnUFYQ2QUDz
         l77w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F1DZdnT5ollm2iI8fP23G2XKzbXO8eedqBckOBUUIns=;
        fh=9qqehjuxnn2X0mJ7hQbZg99PSLTxs4BCAql4/69ZoU8=;
        b=AACz8UaoQUGz/x3Dm27ZwWukZ1v4FulLvgdOexBuKN3VtpepIkwbvwT7turF6inYxR
         zLu7/lLTMcqR+3tKsd2Ws9h/3c9wqH6nYl3/tz1iCaYkOBAomc3bg+0/MPyN6cpnXURI
         tK3uOu2puqpzS7m46NXIyC7RCYtgkjQUdpo+/SfcNJGVWTCy3clfIDIXq6w58HQIf4I4
         M+GDGs6ImA2dyWSgRddHfGyXvVMdsOP7MGZE1C+ESY83vARyBe0fDA9FH8PIEPc8a+E8
         gM4ZS4uxJwGoRwYtk996uWkMORKyv0sATEl9r7+1ANfw3m87Ds5wn4rBVPkoDxqTCLAp
         ph5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786474614; x=1787079414; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F1DZdnT5ollm2iI8fP23G2XKzbXO8eedqBckOBUUIns=;
        b=NjSTI8MxquhZyYKi75efVlZNs3NyeeSLVFemXzs37iLUi4XG90iVsaoOBFPERufcaa
         cBVI85UPQWJZ/tE/LlXt8UodJZIKfXx7JITp4jF+ER9HRX/aiTfKzMWC3OGEoBttOBAi
         2VkudmctrsFIGLoGGFuqrPwtbNUDhWGrUDEo4fjwGBFXNjl+c9u1fXci9lmnVLusAK2u
         DYnKbcbQrAfSmnyKJgE1mwEWHNEX6N6YrJu8QP+2/9sDymx2IqDs61YttmeBWKq2IUnM
         Ik/wJd5+1FAPVR6zehF4iqq6wWVUFbRtw6CIAdNGyy2k8RJYT8qKADtq98UzDiLbfqWz
         dxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786474614; x=1787079414;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F1DZdnT5ollm2iI8fP23G2XKzbXO8eedqBckOBUUIns=;
        b=Pbo+7Hxg8lllgeiH3RujSGwhhSfbEuNaDn0BalcZvipy0DA5ENmAmoCsp/RJNEjBYp
         3On/2lvXANfuW9IzIln3po2gOmJG1x9ZyaGvGv2Urqo2Z/ENOeIdyNT5LIQY3dLXIhEC
         0FeIlkvsVPpJlvVXMYo27yl2V1LQqjffDUnEVdNYcpxJMQ7y2BvkX2MAtrGiJ50uiTbq
         TgPNJIiQnMdc1x72Ox1adN5KVJFQnrLZmdGH/2+fxnHxgr6lCjsHi/5WAYXwysRAD7uE
         uzVQGL/+SFYPaAsmXzXPzMlCxBnRX1dJOCWdihcTQh76eFYKKrljRkgWP4NqBgZ/Gi/6
         lFHQ==
X-Gm-Message-State: AOJu0Yx13rkNpDebq/RnWB5bQNHnq0v5+PkkQVUICiRZj9xgLBoOF1QV
	tk3fYaIqTw5lcky7KdcvB3zP/e7JpmB/koYzeGCkgKcAMis7K4nQuVtOQv+loiiEziBdLqjA5uJ
	N+ycbydsgVKZcrUaeDOim6yE2VWSrCXY=
X-Gm-Gg: AR+sD12pfc4X6XoNmdzpjE1wA19dhM2DVcZXDrKqR2EtuyUGU0cKMGuVxWmOwSUnZyK
	5xtYg8gkcAPi604gNAv1WDQzNuZEjSKIJM8ZQmnNETVabHnMVOgqv+eYXugmfMm+d42UTWjN/Zq
	uaScgWbi2vxsOpLbyZ0rUqJ+heyYSI5iOguDGTb7qAuWgdntV3IUOsHHGG4yQSw+bDIroXwVck3
	YVCxCoaoOmsAjOITPv8DvxmpHOrIq4oImIV84+w6WE7pXqNoLKASubZS8gRmZ/xa4AA3+bnxASc
	L8LA/r3IzjycaKi3rmFyRc399wXBHyrsyh6yEPpgq5xCgX9SIm/dBQ==
X-Received: by 2002:a05:6512:15a5:b0:5ae:bbf1:b9e3 with SMTP id
 2adb3069b0e04-5b4486329d9mr825664e87.31.1786474613613; Tue, 11 Aug 2026
 11:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811123712.84028-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260811123712.84028-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 11 Aug 2026 14:56:42 -0400
X-Gm-Features: AUfX_mxApajFG9xoK8H3djh_obVmcy3IYxfJYy3rWJc5Vetfj0PlUFt9Ghb9RWk
Message-ID: <CAP+JOzRKSw6MKoKp_tGHNziznvgBQ8OOxLQT+=48kSzD4-EzWg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: drop support for modular policy versions < 10
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 8:37=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Drop support for modular policy versions < 10 (boundary alias, a bug
> fix to the original boundary format in modular policy) to mirror what
> was already done for the kernel policy versions. This brings a
> consistent baseline across supported kernel and modular policy
> versions.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  README.md                                  |   8 +-
>  libsepol/include/sepol/policydb/policydb.h |  16 +-
>  libsepol/src/policydb.c                    | 209 ++++-----------------
>  libsepol/src/policydb_validate.c           |   2 -
>  libsepol/src/write.c                       | 115 +++---------
>  5 files changed, 74 insertions(+), 276 deletions(-)
>
> diff --git a/README.md b/README.md
> index f7e6f562..f256912c 100644
> --- a/README.md
> +++ b/README.md
> @@ -31,8 +31,12 @@ Minimum Supported Policy Version
>  --------------------------------
>  Kernel policy version 24 (boundary) for the SELinux and Xen
>  targets. Support for this policy version first shipped in Linux
> -v2.6.28 and Xen 4.0.0. libsepol dropped support for policy versions
> -older than 24 starting with libsepol 3.12.
> +v2.6.28 and Xen 4.0.0. libsepol dropped support for kernel policy
> +versions older than 24 starting with libsepol 3.12.
> +
> +Modular policy version 10 (boundary alias). Support for this modular
> +policy version first shipped in libsepol 2.0.35. libsepol dropped
> +support for modular policies older than 10 starting with libsepol 3.12
>
>  Installation
>  ------------
> diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/includ=
e/sepol/policydb/policydb.h
> index 985a496e..9443aec6 100644
> --- a/libsepol/include/sepol/policydb/policydb.h
> +++ b/libsepol/include/sepol/policydb/policydb.h
> @@ -770,14 +770,6 @@ extern int policydb_set_target_platform(policydb_t *=
p, int platform);
>  #define POLICYDB_VERSION_MAX POLICYDB_VERSION_NEVERAUDIT
>
>  /* Module versions and specific changes*/
> -#define MOD_POLICYDB_VERSION_BASE 4
> -#define MOD_POLICYDB_VERSION_VALIDATETRANS 5
> -#define MOD_POLICYDB_VERSION_MLS 5
> -#define MOD_POLICYDB_VERSION_RANGETRANS 6
> -#define MOD_POLICYDB_VERSION_MLS_USERS 6
> -#define MOD_POLICYDB_VERSION_POLCAP 7
> -#define MOD_POLICYDB_VERSION_PERMISSIVE 8
> -#define MOD_POLICYDB_VERSION_BOUNDARY 9
>  #define MOD_POLICYDB_VERSION_BOUNDARY_ALIAS 10
>  #define MOD_POLICYDB_VERSION_FILENAME_TRANS 11
>  #define MOD_POLICYDB_VERSION_ROLETRANS 12
> @@ -794,7 +786,7 @@ extern int policydb_set_target_platform(policydb_t *p=
, int platform);
>  #define MOD_POLICYDB_VERSION_NEVERAUDIT 23
>  #define MOD_POLICYDB_VERSION_TYPE_ATTR_ATTRS 24
>
> -#define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
> +#define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BOUNDARY_ALIAS
>  #define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_TYPE_ATTR_ATTRS
>
>  #define POLICYDB_CONFIG_MLS 1
> @@ -803,12 +795,6 @@ extern int policydb_set_target_platform(policydb_t *=
p, int platform);
>
>  /* TODO: add other features here */
>
> -#define policydb_has_boundary_feature(p)                   \
> -       (((p)->policy_type =3D=3D POLICY_KERN &&               \
> -         (p)->policyvers >=3D POLICYDB_VERSION_BOUNDARY) || \
> -        ((p)->policy_type !=3D POLICY_KERN &&               \
> -         (p)->policyvers >=3D MOD_POLICYDB_VERSION_BOUNDARY))
> -
>  #define policydb_has_cond_xperms_feature(p)                   \
>         (((p)->policy_type =3D=3D POLICY_KERN &&                  \
>           (p)->policyvers >=3D POLICYDB_VERSION_COND_XPERMS) || \
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 84b7ac1e..3dd3ac4f 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -160,48 +160,6 @@ static const struct policydb_compat_info policydb_co=
mpat[] =3D {
>                 .ocon_num =3D OCON_IBENDPORT + 1,
>                 .target_platform =3D SEPOL_TARGET_SELINUX,
>         },
> -       {
> -               .type =3D POLICY_BASE,
> -               .version =3D MOD_POLICYDB_VERSION_BASE,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D OCON_NODE6 + 1,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_BASE,
> -               .version =3D MOD_POLICYDB_VERSION_MLS,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D OCON_NODE6 + 1,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_BASE,
> -               .version =3D MOD_POLICYDB_VERSION_MLS_USERS,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D OCON_NODE6 + 1,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_BASE,
> -               .version =3D MOD_POLICYDB_VERSION_POLCAP,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D OCON_NODE6 + 1,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_BASE,
> -               .version =3D MOD_POLICYDB_VERSION_PERMISSIVE,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D OCON_NODE6 + 1,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_BASE,
> -               .version =3D MOD_POLICYDB_VERSION_BOUNDARY,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D OCON_NODE6 + 1,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
>         {
>                 .type =3D POLICY_BASE,
>                 .version =3D MOD_POLICYDB_VERSION_BOUNDARY_ALIAS,
> @@ -307,48 +265,6 @@ static const struct policydb_compat_info policydb_co=
mpat[] =3D {
>                 .ocon_num =3D OCON_IBENDPORT + 1,
>                 .target_platform =3D SEPOL_TARGET_SELINUX,
>         },
> -       {
> -               .type =3D POLICY_MOD,
> -               .version =3D MOD_POLICYDB_VERSION_BASE,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D 0,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_MOD,
> -               .version =3D MOD_POLICYDB_VERSION_MLS,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D 0,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_MOD,
> -               .version =3D MOD_POLICYDB_VERSION_MLS_USERS,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D 0,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_MOD,
> -               .version =3D MOD_POLICYDB_VERSION_POLCAP,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D 0,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_MOD,
> -               .version =3D MOD_POLICYDB_VERSION_PERMISSIVE,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D 0,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
> -       {
> -               .type =3D POLICY_MOD,
> -               .version =3D MOD_POLICYDB_VERSION_BOUNDARY,
> -               .sym_num =3D SYM_NUM,
> -               .ocon_num =3D 0,
> -               .target_platform =3D SEPOL_TARGET_SELINUX,
> -       },
>         {
>                 .type =3D POLICY_MOD,
>                 .version =3D MOD_POLICYDB_VERSION_BOUNDARY_ALIAS,
> @@ -2026,8 +1942,7 @@ static int context_read_and_validate(context_struct=
_t *c, policydb_t *p,
>         c->role =3D le32_to_cpu(buf[1]);
>         c->type =3D le32_to_cpu(buf[2]);
>         if ((p->policy_type =3D=3D POLICY_KERN) ||
> -           (p->policy_type =3D=3D POLICY_BASE &&
> -            p->policyvers >=3D MOD_POLICYDB_VERSION_MLS)) {
> +           (p->policy_type =3D=3D POLICY_BASE)) {
>                 if (mls_read_range_helper(&c->range, fp)) {
>                         ERR(fp->handle, "error reading MLS range "
>                                         "of context");
> @@ -2285,8 +2200,7 @@ static int class_read(policydb_t *p, hashtab_t h, s=
truct policy_file *fp)
>                 goto bad;
>
>         if ((p->policy_type =3D=3D POLICY_KERN) ||
> -           (p->policy_type =3D=3D POLICY_BASE &&
> -            p->policyvers >=3D MOD_POLICYDB_VERSION_VALIDATETRANS)) {
> +           (p->policy_type =3D=3D POLICY_BASE)) {
>                 /* grab the validatetrans rules */
>                 rc =3D next_entry(buf, fp, sizeof(uint32_t));
>                 if (rc < 0)
> @@ -2334,16 +2248,13 @@ static int role_read(policydb_t *p, hashtab_t h, =
struct policy_file *fp)
>         role_datum_t *role;
>         uint32_t buf[3];
>         size_t len;
> -       int rc, to_read =3D 2;
> +       int rc;
>
>         role =3D calloc(1, sizeof(role_datum_t));
>         if (!role)
>                 return -1;
>
> -       if (policydb_has_boundary_feature(p))
> -               to_read =3D 3;
> -
> -       rc =3D next_entry(buf, fp, sizeof(uint32_t) * to_read);
> +       rc =3D next_entry(buf, fp, sizeof(uint32_t) * 3);
>         if (rc < 0)
>                 goto bad;
>
> @@ -2353,8 +2264,7 @@ static int role_read(policydb_t *p, hashtab_t h, st=
ruct policy_file *fp)
>                 goto bad;
>
>         role->s.value =3D le32_to_cpu(buf[1]);
> -       if (policydb_has_boundary_feature(p))
> -               role->bounds =3D le32_to_cpu(buf[2]);
> +       role->bounds =3D le32_to_cpu(buf[2]);
>
>         if (ebitmap_read(&role->dominates, fp))
>                 goto bad;
> @@ -2413,15 +2323,7 @@ static int type_read(policydb_t *p, hashtab_t h, s=
truct policy_file *fp)
>         if (!typdatum)
>                 return -1;
>
> -       if (policydb_has_boundary_feature(p)) {
> -               if (p->policy_type !=3D POLICY_KERN &&
> -                   p->policyvers >=3D MOD_POLICYDB_VERSION_BOUNDARY_ALIA=
S)
> -                       to_read =3D 5;
> -               else
> -                       to_read =3D 4;
> -       } else if (p->policy_type =3D=3D POLICY_KERN)
> -               to_read =3D 3;
> -       else if (p->policyvers >=3D MOD_POLICYDB_VERSION_PERMISSIVE)
> +       if (p->policy_type !=3D POLICY_KERN)
>                 to_read =3D 5;
>         else
>                 to_read =3D 4;
> @@ -2432,42 +2334,32 @@ static int type_read(policydb_t *p, hashtab_t h, =
struct policy_file *fp)
>
>         len =3D le32_to_cpu(buf[pos]);
>         typdatum->s.value =3D le32_to_cpu(buf[++pos]);
> -       if (policydb_has_boundary_feature(p)) {
> -               uint32_t properties;
> +       uint32_t properties;
>
> -               if (p->policy_type !=3D POLICY_KERN &&
> -                   p->policyvers >=3D MOD_POLICYDB_VERSION_BOUNDARY_ALIA=
S) {
> -                       typdatum->primary =3D le32_to_cpu(buf[++pos]);
> -                       properties =3D le32_to_cpu(buf[++pos]);
> -               } else {
> -                       properties =3D le32_to_cpu(buf[++pos]);
> -
> -                       if (properties & TYPEDATUM_PROPERTY_PRIMARY)
> -                               typdatum->primary =3D 1;
> -               }
> -
> -               if (properties & TYPEDATUM_PROPERTY_ATTRIBUTE)
> -                       typdatum->flavor =3D TYPE_ATTRIB;
> -               if (properties & TYPEDATUM_PROPERTY_ALIAS &&
> -                   p->policy_type !=3D POLICY_KERN)
> -                       typdatum->flavor =3D TYPE_ALIAS;
> -               if (properties & TYPEDATUM_PROPERTY_PERMISSIVE &&
> -                   p->policy_type !=3D POLICY_KERN)
> -                       typdatum->flags |=3D TYPE_FLAGS_PERMISSIVE;
> -               if (properties & TYPEDATUM_PROPERTY_NEVERAUDIT &&
> -                   p->policy_type !=3D POLICY_KERN)
> -                       typdatum->flags |=3D TYPE_FLAGS_NEVERAUDIT;
> -
> -               typdatum->bounds =3D le32_to_cpu(buf[++pos]);
> -       } else {
> +       if (p->policy_type !=3D POLICY_KERN) {
>                 typdatum->primary =3D le32_to_cpu(buf[++pos]);
> -               if (p->policy_type !=3D POLICY_KERN) {
> -                       typdatum->flavor =3D le32_to_cpu(buf[++pos]);
> -                       if (p->policyvers >=3D MOD_POLICYDB_VERSION_PERMI=
SSIVE)
> -                               typdatum->flags =3D le32_to_cpu(buf[++pos=
]);
> -               }
> +               properties =3D le32_to_cpu(buf[++pos]);
> +       } else {
> +               properties =3D le32_to_cpu(buf[++pos]);
> +
> +               if (properties & TYPEDATUM_PROPERTY_PRIMARY)
> +                       typdatum->primary =3D 1;
>         }
>
> +       if (properties & TYPEDATUM_PROPERTY_ATTRIBUTE)
> +               typdatum->flavor =3D TYPE_ATTRIB;
> +       if (properties & TYPEDATUM_PROPERTY_ALIAS &&
> +           p->policy_type !=3D POLICY_KERN)
> +               typdatum->flavor =3D TYPE_ALIAS;
> +       if (properties & TYPEDATUM_PROPERTY_PERMISSIVE &&
> +           p->policy_type !=3D POLICY_KERN)
> +               typdatum->flags |=3D TYPE_FLAGS_PERMISSIVE;
> +       if (properties & TYPEDATUM_PROPERTY_NEVERAUDIT &&
> +           p->policy_type !=3D POLICY_KERN)
> +               typdatum->flags |=3D TYPE_FLAGS_NEVERAUDIT;
> +
> +       typdatum->bounds =3D le32_to_cpu(buf[++pos]);
> +
>         if (p->policy_type !=3D POLICY_KERN) {
>                 if (ebitmap_read(&typdatum->types, fp))
>                         goto bad;
> @@ -3266,16 +3158,13 @@ static int user_read(policydb_t *p, hashtab_t h, =
struct policy_file *fp)
>         user_datum_t *usrdatum;
>         uint32_t buf[3];
>         size_t len;
> -       int rc, to_read =3D 2;
> +       int rc;
>
>         usrdatum =3D calloc(1, sizeof(user_datum_t));
>         if (!usrdatum)
>                 return -1;
>
> -       if (policydb_has_boundary_feature(p))
> -               to_read =3D 3;
> -
> -       rc =3D next_entry(buf, fp, sizeof(uint32_t) * to_read);
> +       rc =3D next_entry(buf, fp, sizeof(uint32_t) * 3);
>         if (rc < 0)
>                 goto bad;
>
> @@ -3285,8 +3174,7 @@ static int user_read(policydb_t *p, hashtab_t h, st=
ruct policy_file *fp)
>                 goto bad;
>
>         usrdatum->s.value =3D le32_to_cpu(buf[1]);
> -       if (policydb_has_boundary_feature(p))
> -               usrdatum->bounds =3D le32_to_cpu(buf[2]);
> +       usrdatum->bounds =3D le32_to_cpu(buf[2]);
>
>         if (p->policy_type =3D=3D POLICY_KERN) {
>                 if (ebitmap_read(&usrdatum->roles.roles, fp))
> @@ -3296,17 +3184,7 @@ static int user_read(policydb_t *p, hashtab_t h, s=
truct policy_file *fp)
>                         goto bad;
>         }
>
> -       /* users were not allowed in mls modules before version
> -        * MOD_POLICYDB_VERSION_MLS_USERS, but they could have been
> -        * required - the mls fields will be empty.  user declarations in
> -        * non-mls modules will also have empty mls fields */
> -       if ((p->policy_type =3D=3D POLICY_KERN) ||
> -           (p->policy_type =3D=3D POLICY_MOD &&
> -            p->policyvers >=3D MOD_POLICYDB_VERSION_MLS &&
> -            p->policyvers < MOD_POLICYDB_VERSION_MLS_USERS) ||
> -           (p->policy_type =3D=3D POLICY_BASE &&
> -            p->policyvers >=3D MOD_POLICYDB_VERSION_MLS &&
> -            p->policyvers < MOD_POLICYDB_VERSION_MLS_USERS)) {
> +       if (p->policy_type =3D=3D POLICY_KERN) {
>                 if (mls_read_range_helper(&usrdatum->exp_range, fp))
>                         goto bad;
>                 if (mls_read_level(&usrdatum->exp_dfltlevel, fp))
> @@ -3319,10 +3197,7 @@ static int user_read(policydb_t *p, hashtab_t h, s=
truct policy_file *fp)
>                                                   &usrdatum->dfltlevel))
>                                 goto bad;
>                 }
> -       } else if ((p->policy_type =3D=3D POLICY_MOD &&
> -                   p->policyvers >=3D MOD_POLICYDB_VERSION_MLS_USERS) ||
> -                  (p->policy_type =3D=3D POLICY_BASE &&
> -                   p->policyvers >=3D MOD_POLICYDB_VERSION_MLS_USERS)) {
> +       } else {
>                 if (mls_read_semantic_range_helper(&usrdatum->range, fp))
>                         goto bad;
>                 if (mls_read_semantic_level_helper(&usrdatum->dfltlevel, =
fp))
> @@ -3906,8 +3781,7 @@ static int avrule_decl_read(policydb_t *p, avrule_d=
ecl_t *decl,
>             filename_trans_rule_read(p, &decl->filename_trans_rules, fp))
>                 return -1;
>
> -       if (p->policyvers >=3D MOD_POLICYDB_VERSION_RANGETRANS &&
> -           range_trans_rule_read(&decl->range_tr_rules, fp) =3D=3D -1) {
> +       if (range_trans_rule_read(&decl->range_tr_rules, fp) =3D=3D -1) {
>                 return -1;
>         }
>         if (scope_index_read(&decl->required, num_scope_syms, fp) =3D=3D =
-1 ||
> @@ -4294,14 +4168,8 @@ int policydb_read(policydb_t *p, struct policy_fil=
e *fp, unsigned verbose)
>                         goto bad;
>         }
>
> -       if ((p->policy_type =3D=3D POLICY_KERN) ||
> -           (p->policyvers >=3D MOD_POLICYDB_VERSION_POLCAP &&
> -            p->policy_type =3D=3D POLICY_BASE) ||
> -           (p->policyvers >=3D MOD_POLICYDB_VERSION_POLCAP &&
> -            p->policy_type =3D=3D POLICY_MOD)) {
> -               if (ebitmap_read(&p->policycaps, fp))
> -                       goto bad;
> -       }
> +       if (ebitmap_read(&p->policycaps, fp))
> +               goto bad;
>
>         if (p->policy_type =3D=3D POLICY_KERN) {
>                 if (ebitmap_read(&p->permissive_map, fp))
> @@ -4417,10 +4285,7 @@ int policydb_read(policydb_t *p, struct policy_fil=
e *fp, unsigned verbose)
>                 goto bad;
>         }
>
> -       if ((p->policy_type =3D=3D POLICY_KERN) ||
> -           (p->policy_type =3D=3D POLICY_BASE &&
> -            p->policyvers >=3D MOD_POLICYDB_VERSION_MLS &&
> -            p->policyvers < MOD_POLICYDB_VERSION_RANGETRANS)) {
> +       if (p->policy_type =3D=3D POLICY_KERN) {
>                 if (range_read(p, fp)) {
>                         goto bad;
>                 }
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index 5687c82b..d457acdb 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -1979,8 +1979,6 @@ static int validate_properties(sepol_handle_t *hand=
le, const policydb_t *p)
>                 if (p->policyvers < MOD_POLICYDB_VERSION_MIN ||
>                     p->policyvers > MOD_POLICYDB_VERSION_MAX)
>                         goto bad;
> -               if (p->mls && p->policyvers < MOD_POLICYDB_VERSION_MLS)
> -                       goto bad;
>                 break;
>         default:
>                 goto bad;
> diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> index 4e180ef3..4bb39f99 100644
> --- a/libsepol/src/write.c
> +++ b/libsepol/src/write.c
> @@ -728,9 +728,7 @@ static int context_write(struct policydb *p, context_=
struct_t *c,
>         items2 =3D put_entry(buf, sizeof(uint32_t), items, fp);
>         if (items2 !=3D items)
>                 return POLICYDB_ERROR;
> -       if ((p->policy_type =3D=3D POLICY_KERN) ||
> -           (p->policyvers >=3D MOD_POLICYDB_VERSION_MLS &&
> -            p->policy_type =3D=3D POLICY_BASE))
> +       if ((p->policy_type =3D=3D POLICY_KERN) || (p->policy_type =3D=3D=
 POLICY_BASE))
>                 if (mls_write_range_helper(&c->range, fp))
>                         return POLICYDB_ERROR;
>
> @@ -902,8 +900,7 @@ static int class_write(hashtab_key_t key, hashtab_dat=
um_t datum, void *ptr)
>                 return POLICYDB_ERROR;
>
>         if ((p->policy_type =3D=3D POLICY_KERN) ||
> -           (p->policy_type =3D=3D POLICY_BASE &&
> -            p->policyvers >=3D MOD_POLICYDB_VERSION_VALIDATETRANS)) {
> +           (p->policy_type =3D=3D POLICY_BASE)) {
>                 /* write out the validatetrans rule */
>                 ncons =3D 0;
>                 for (c =3D cladatum->validatetrans; c; c =3D c->next) {
> @@ -983,8 +980,7 @@ static int role_write(hashtab_key_t key, hashtab_datu=
m_t datum, void *ptr)
>         items =3D 0;
>         buf[items++] =3D cpu_to_le32(len);
>         buf[items++] =3D cpu_to_le32(role->s.value);
> -       if (policydb_has_boundary_feature(p))
> -               buf[items++] =3D cpu_to_le32(role->bounds);
> +       buf[items++] =3D cpu_to_le32(role->bounds);
>         items2 =3D put_entry(buf, sizeof(uint32_t), items, fp);
>         if (items !=3D items2)
>                 return POLICYDB_ERROR;
> @@ -1059,52 +1055,32 @@ static int type_write(hashtab_key_t key, hashtab_=
datum_t datum, void *ptr)
>                      "types, but one was defined",
>                      p->policyvers);
>
> -       if (policydb_has_boundary_feature(p)) {
> -               uint32_t properties =3D 0;
> -
> -               if (p->policy_type !=3D POLICY_KERN &&
> -                   p->policyvers >=3D MOD_POLICYDB_VERSION_BOUNDARY_ALIA=
S) {
> -                       buf[items++] =3D cpu_to_le32(typdatum->primary);
> -               }
> +       uint32_t properties =3D 0;
>
> -               if (typdatum->primary)
> -                       properties |=3D TYPEDATUM_PROPERTY_PRIMARY;
> +       if (p->policy_type !=3D POLICY_KERN)
> +               buf[items++] =3D cpu_to_le32(typdatum->primary);
>
> -               if (typdatum->flavor =3D=3D TYPE_ATTRIB) {
> -                       properties |=3D TYPEDATUM_PROPERTY_ATTRIBUTE;
> -               } else if (typdatum->flavor =3D=3D TYPE_ALIAS &&
> -                          p->policy_type !=3D POLICY_KERN)
> -                       properties |=3D TYPEDATUM_PROPERTY_ALIAS;
> +       if (typdatum->primary)
> +               properties |=3D TYPEDATUM_PROPERTY_PRIMARY;
>
> -               if (typdatum->flags & TYPE_FLAGS_PERMISSIVE &&
> -                   p->policy_type !=3D POLICY_KERN)
> -                       properties |=3D TYPEDATUM_PROPERTY_PERMISSIVE;
> +       if (typdatum->flavor =3D=3D TYPE_ATTRIB) {
> +               properties |=3D TYPEDATUM_PROPERTY_ATTRIBUTE;
> +       } else if (typdatum->flavor =3D=3D TYPE_ALIAS &&
> +                  p->policy_type !=3D POLICY_KERN)
> +               properties |=3D TYPEDATUM_PROPERTY_ALIAS;
>
> -               if (typdatum->flags & TYPE_FLAGS_NEVERAUDIT &&
> -                   p->policy_type !=3D POLICY_KERN &&
> -                   p->policyvers >=3D MOD_POLICYDB_VERSION_NEVERAUDIT)
> -                       properties |=3D TYPEDATUM_PROPERTY_NEVERAUDIT;
> +       if (typdatum->flags & TYPE_FLAGS_PERMISSIVE &&
> +           p->policy_type !=3D POLICY_KERN)
> +               properties |=3D TYPEDATUM_PROPERTY_PERMISSIVE;
>
> -               buf[items++] =3D cpu_to_le32(properties);
> -               buf[items++] =3D cpu_to_le32(typdatum->bounds);
> -       } else {
> -               buf[items++] =3D cpu_to_le32(typdatum->primary);
> +       if (typdatum->flags & TYPE_FLAGS_NEVERAUDIT &&
> +           p->policy_type !=3D POLICY_KERN &&
> +           p->policyvers >=3D MOD_POLICYDB_VERSION_NEVERAUDIT)
> +               properties |=3D TYPEDATUM_PROPERTY_NEVERAUDIT;
>
> -               if (p->policy_type !=3D POLICY_KERN) {
> -                       buf[items++] =3D cpu_to_le32(typdatum->flavor);
> +       buf[items++] =3D cpu_to_le32(properties);
> +       buf[items++] =3D cpu_to_le32(typdatum->bounds);
>
> -                       if (p->policyvers >=3D MOD_POLICYDB_VERSION_PERMI=
SSIVE)
> -                               buf[items++] =3D
> -                                       cpu_to_le32(typdatum->flags &
> -                                                   ~TYPE_FLAGS_NEVERAUDI=
T);
> -                       else if (typdatum->flags & TYPE_FLAGS_PERMISSIVE)
> -                               WARN(fp->handle,
> -                                    "Warning! Module policy "
> -                                    "version %d cannot support permissiv=
e "
> -                                    "types, but one was defined",
> -                                    p->policyvers);
> -               }
> -       }
>         items2 =3D put_entry(buf, sizeof(uint32_t), items, fp);
>         if (items !=3D items2)
>                 return POLICYDB_ERROR;
> @@ -1136,8 +1112,7 @@ static int user_write(hashtab_key_t key, hashtab_da=
tum_t datum, void *ptr)
>         items =3D 0;
>         buf[items++] =3D cpu_to_le32(len);
>         buf[items++] =3D cpu_to_le32(usrdatum->s.value);
> -       if (policydb_has_boundary_feature(p))
> -               buf[items++] =3D cpu_to_le32(usrdatum->bounds);
> +       buf[items++] =3D cpu_to_le32(usrdatum->bounds);
>         items2 =3D put_entry(buf, sizeof(uint32_t), items, fp);
>         if (items !=3D items2)
>                 return POLICYDB_ERROR;
> @@ -1154,21 +1129,12 @@ static int user_write(hashtab_key_t key, hashtab_=
datum_t datum, void *ptr)
>                         return POLICYDB_ERROR;
>         }
>
> -       if ((p->policy_type =3D=3D POLICY_KERN) ||
> -           (p->policyvers >=3D MOD_POLICYDB_VERSION_MLS &&
> -            p->policyvers < MOD_POLICYDB_VERSION_MLS_USERS &&
> -            p->policy_type =3D=3D POLICY_MOD) ||
> -           (p->policyvers >=3D MOD_POLICYDB_VERSION_MLS &&
> -            p->policyvers < MOD_POLICYDB_VERSION_MLS_USERS &&
> -            p->policy_type =3D=3D POLICY_BASE)) {
> +       if (p->policy_type =3D=3D POLICY_KERN) {
>                 if (mls_write_range_helper(&usrdatum->exp_range, fp))
>                         return POLICYDB_ERROR;
>                 if (mls_write_level(&usrdatum->exp_dfltlevel, fp))
>                         return POLICYDB_ERROR;
> -       } else if ((p->policyvers >=3D MOD_POLICYDB_VERSION_MLS_USERS &&
> -                   p->policy_type =3D=3D POLICY_MOD) ||
> -                  (p->policyvers >=3D MOD_POLICYDB_VERSION_MLS_USERS &&
> -                   p->policy_type =3D=3D POLICY_BASE)) {
> +       } else {
>                 if (mls_write_semantic_range_helper(&usrdatum->range, fp)=
)
>                         return -1;
>                 if (mls_write_semantic_level_helper(&usrdatum->dfltlevel,=
 fp))
> @@ -1916,8 +1882,7 @@ static int avrule_decl_write(avrule_decl_t *decl, i=
nt num_scope_syms,
>             filename_trans_rule_write(p, decl->filename_trans_rules, fp))
>                 return POLICYDB_ERROR;
>
> -       if (p->policyvers >=3D MOD_POLICYDB_VERSION_RANGETRANS &&
> -           range_trans_rule_write(decl->range_tr_rules, fp) =3D=3D -1) {
> +       if (range_trans_rule_write(decl->range_tr_rules, fp) =3D=3D -1) {
>                 return POLICYDB_ERROR;
>         }
>         if (scope_index_write(&decl->required, num_scope_syms, fp) =3D=3D=
 -1 ||
> @@ -2051,19 +2016,8 @@ int policydb_write(policydb_t *p, struct policy_fi=
le *fp)
>         pd.p =3D p;
>
>         config =3D 0;
> -       if (p->mls) {
> -               if ((p->policyvers < MOD_POLICYDB_VERSION_MLS &&
> -                    p->policy_type =3D=3D POLICY_BASE) ||
> -                   (p->policyvers < MOD_POLICYDB_VERSION_MLS &&
> -                    p->policy_type =3D=3D POLICY_MOD)) {
> -                       ERR(fp->handle,
> -                           "%spolicy version %d cannot support MLS",
> -                           p->policy_type =3D=3D POLICY_KERN ? "" : "mod=
ule ",
> -                           p->policyvers);
> -                       return POLICYDB_ERROR;
> -               }
> +       if (p->mls)
>                 config |=3D POLICYDB_CONFIG_MLS;
> -       }
>
>         config |=3D (POLICYDB_CONFIG_UNKNOWN_MASK & p->handle_unknown);
>
> @@ -2132,14 +2086,8 @@ int policydb_write(policydb_t *p, struct policy_fi=
le *fp)
>                         return POLICYDB_ERROR;
>         }
>
> -       if ((p->policy_type =3D=3D POLICY_KERN) ||
> -           (p->policyvers >=3D MOD_POLICYDB_VERSION_POLCAP &&
> -            p->policy_type =3D=3D POLICY_BASE) ||
> -           (p->policyvers >=3D MOD_POLICYDB_VERSION_POLCAP &&
> -            p->policy_type =3D=3D POLICY_MOD)) {
> -               if (ebitmap_write(&p->policycaps, fp) =3D=3D -1)
> -                       return POLICYDB_ERROR;
> -       }
> +       if (ebitmap_write(&p->policycaps, fp) =3D=3D -1)
> +               return POLICYDB_ERROR;
>
>         if (p->policy_type =3D=3D POLICY_KERN) {
>                 if (ebitmap_write(&p->permissive_map, fp) =3D=3D -1)
> @@ -2222,10 +2170,7 @@ int policydb_write(policydb_t *p, struct policy_fi=
le *fp)
>                 return POLICYDB_ERROR;
>         }
>
> -       if ((p->policy_type =3D=3D POLICY_KERN) ||
> -           (p->policyvers >=3D MOD_POLICYDB_VERSION_MLS &&
> -            p->policyvers < MOD_POLICYDB_VERSION_RANGETRANS &&
> -            p->policy_type =3D=3D POLICY_BASE)) {
> +       if (p->policy_type =3D=3D POLICY_KERN) {
>                 if (range_write(p, fp)) {
>                         return POLICYDB_ERROR;
>                 }
> --
> 2.55.0
>
