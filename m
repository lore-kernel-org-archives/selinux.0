Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D442022B5BC
	for <selinux@vger.kernel.org>; Thu, 29 May 2025 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748531768; cv=none; b=ulGqJaerba/fdWGqeAg6LHwSsLAlcPt/2sly4PmUSQ7GxOIFLBZo+aAnucNWpkcb/rOjjp1+Mak0eHsqnyZvNJq3LetOCE6RObYZJK2R9ojEYQw8qdfKiajcH0vTf4ExhnKmk9jrgCLGZ27IhAj1m9ObTTcUiBo+b5ORk5vn6EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748531768; c=relaxed/simple;
	bh=RQNzwiPZPNAguWp68nwhIwytqWDmqTCk9zHmL9DEcYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TiqFFoJT4ejdDNQTlD/gHmr1VC6eVFcCnQXmCZ0eoLE55/OYXnXw3XjarE8Xel6RhJ901YL7Wx+6iY2I+e3GAfFOhoHgq+EwpJRX76OISfaeNDRCkBic5xg+6LSHJwpGYu7f9Wbh02QdK7szGKAGKTSqJ+qLZXBdnmozqZKTp8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZAjiJqU; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZAjiJqU"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4033c70577fso519713b6e.0
        for <selinux@vger.kernel.org>; Thu, 29 May 2025 08:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748531765; x=1749136565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlLoFX1JkcGYumhf3LlO/ppsmw1Ga8HTahxy3f27APc=;
        b=jZAjiJqUvbRAktkSe0TdHiv+WLA+U2m/WTKYuY8zgEbOuQ9yoeXS25YddGeKtpjnLB
         2C2NRSr0pZxpULoQir+N9hZEadiaekrAZd7y+hKBmqPvqXOkIUsSY5yMp94dKx3K6GT1
         mVwwnJDTN33+tnc3hJ0qnke35zBZ27eoxuYKBuaqs/jr8TamHzgHaLNDwuTHyjgDaF7D
         4cxajVRUXEDFzhhJND9c12Um+x8w08Uu2W+wICPgT1QD5mw4Y6XCrvOSjRVL14/72F9h
         qzZx2R7EUppG8zVsmTsJpL4AavvtUd952TvB5lsqp3ee25NDNqw00mazYvlebX8hwe3/
         jsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748531765; x=1749136565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlLoFX1JkcGYumhf3LlO/ppsmw1Ga8HTahxy3f27APc=;
        b=h670+uUeuKKUqB9UGyrJrHOFpcX9RsYv6/ZP/ju2WxWCt/g1gwLk7mz0ggx1kdo+9V
         Yk4OFHpfQ7u+2M9QBCFdf6YyAVU3T0OOsFDBXQ1v24MVNrzrInOFTuzKaFlgzIhbhj/C
         hkW1y4bo55OVcatsscrsQWa3YtNxUyADiayj+CPUC+L/gQRU2fCtY6zqE1Mzi2H1Vsxy
         9TkzhOmTnftF0OWYgktOz9qxefE9cm42qQrVfwD4xPdNFF+QvskCTmIqWzXtQeZLfC8o
         54GzkG7RpGVUTADqnxxfCQq1Fg2lL3zkWNPm+scitwuV2dHKZUyzkGqWV5Neu6ArBkzo
         zfGg==
X-Gm-Message-State: AOJu0YzrDid9LQvQjTmXEZESYVcZ70R5XwjBM0kwzSpAX0BQ3DXHtIFP
	l3p55V/0O0yDTYq7yib9ZT3Me5MUFBlo4EZI5R/1ijODUbqJkukqniDAXaTIdBTH4mKgUiIxbCZ
	wfEYh9srHgo20yEC1/ClFa7Mv/6n8tow=
X-Gm-Gg: ASbGncvIYaBYcQAvedXGqZa1hDgiJNuhcSAWDo+nDmcK/GsZjHZZ9+wIhqHqjkwN+9s
	oELasc7ax88/dYc3/cyIh4miSIY2l6dRwyIBZGq6aFtymRx+u4f50nYcU6cnXWE/ECM2awhZwsB
	5RvO1qzBNGUPsLgglkXSNoJtrdQ64s3BVe
X-Google-Smtp-Source: AGHT+IEtZSH9pK63izsQ34bFfI5GwZqGXklGryspQaUOKyvq1C0puG/jr8k6FrVjGf8So2eRkBza+p+gPifZA/iBG48=
X-Received: by 2002:a05:6808:448b:b0:3fe:b0ad:f935 with SMTP id
 5614622812f47-40646810189mr13530528b6e.4.1748531764702; Thu, 29 May 2025
 08:16:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529092633.1057963-1-inseob@google.com> <20250529092633.1057963-2-inseob@google.com>
In-Reply-To: <20250529092633.1057963-2-inseob@google.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 29 May 2025 11:15:52 -0400
X-Gm-Features: AX0GCFvrYVmQrj2wjxUcGLpZsDlhHOXoQPjwYNJPtv65BqEc_ZNF33-HGfLog9g
Message-ID: <CAP+JOzRb1=9N6rAxA6tRsW=_QEiWXgpR1EefkgqNLypWQfMv0g@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsepol: Support genfs_seclabel_wildcard
To: Inseob Kim <inseob@google.com>
Cc: selinux@vger.kernel.org, takayas@google.com, tweek@google.com, 
	stephen.smalley.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 5:26=E2=80=AFAM Inseob Kim <inseob@google.com> wrot=
e:
>
> This adds genfs_seclabel_wildcard support to libsepol, which makes genfs
> paths wildcard-matched. To support backward compatibility and to keep
> semantics of genfscon statements, an asterisk '*' is added to paths of
> genfscon statements when compiling CIL/conf files having policycap
> genfs_seclabel_wildcard.
>
> Signed-off-by: Inseob Kim <inseob@google.com>
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
> index 1aa9b30a..9f3495f5 100644
> --- a/libsepol/include/sepol/policydb/polcaps.h
> +++ b/libsepol/include/sepol/policydb/polcaps.h
> @@ -16,6 +16,7 @@ enum {
>         POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS,
>         POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
>         POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
> +       POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
>         POLICYDB_CAP_NETLINK_XPERM,
>         __POLICYDB_CAP_MAX
>  };

The order has to be the same as in the kernel. The number, rather than
the name, is stored in the binary policy file.
Thanks,
Jim

> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index ddca2b62..33ee59fb 100644
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
> +                                                        fstype, name_len=
, name, file_type, ctx);
>                         } else {
> -                               rc =3D strs_create_and_add(strs, "(genfsc=
on %s \"%s\" %s)",
> -                                                                        =
        fstype, name, ctx);
> +                               rc =3D strs_create_and_add(strs, "(genfsc=
on %s \"%.*s\" %s)",
> +                                                        fstype, name_len=
, name, ctx);
>                         }
>                         free(ctx);
>                         if (rc !=3D 0) {
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
> index 661546af..dac6fce9 100644
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
> +                                                        fstype, name_len=
, name, file_type, ctx);
>                         } else {
> -                               rc =3D strs_create_and_add(strs, "genfsco=
n %s \"%s\" %s",
> -                                                                        =
        fstype, name, ctx);
> +                               rc =3D strs_create_and_add(strs, "genfsco=
n %s \"%.*s\" %s",
> +                                                        fstype, name_len=
, name, ctx);
>                         }
>                         free(ctx);
>                         if (rc !=3D 0) {
> diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
> index 6b28c84e..a6fad2a9 100644
> --- a/libsepol/src/polcaps.c
> +++ b/libsepol/src/polcaps.c
> @@ -15,6 +15,7 @@ static const char * const polcap_names[POLICYDB_CAP_MAX=
 + 1] =3D {
>         [POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS]          =3D "genfs_seclab=
el_symlinks",
>         [POLICYDB_CAP_IOCTL_SKIP_CLOEXEC]               =3D "ioctl_skip_c=
loexec",
>         [POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT]        =3D "userspace_in=
itial_context",
> +       [POLICYDB_CAP_GENFS_SECLABEL_WILDCARD]          =3D "genfs_seclab=
el_wildcard",
>         [POLICYDB_CAP_NETLINK_XPERM]                    =3D "netlink_xper=
m",
>  };
>
> --
> 2.49.0.1238.gf8c92423fb-goog
>
>
