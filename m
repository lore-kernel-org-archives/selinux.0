Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3554C62E
	for <selinux@vger.kernel.org>; Wed, 12 Jun 2024 18:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718217728; cv=none; b=CijAb9wza9paPi1QiViev6vvo7I+daUksREZ4t/Zz5m981a3TvOuE6bpcazNSfA2HPfF7myIBR8PZxgIOMOYhYOhaY0twrUkm1jZm6aVBX7PDNhmBnHinsi1bbNKvUk9vyqUFjuBgbHWF4f8oF4MaCOWdv2HL0QsY0SOS+zvf1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718217728; c=relaxed/simple;
	bh=k85njiGjcjmF1lfUJ/j/YLEDdKTcUTiICQa4p6cjfh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C2UJyP3G7UYvTNv8jK3Uy6q/LRhRj/01ohlv4pqXFWPwpvoGOhy1sTgKhyenG80HfTFvOOZCnGq+m/ECqPuNo2sig5M6D4Q6fbHXtVzPYe/A6V7vSHawxG6z1hTdYDem0ok3bXQSZxceHgOiU/ogeJ7tKGnITWUTXvYYpdT/2wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8e3qq/q; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8e3qq/q"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-48c50daef1fso59058137.1
        for <selinux@vger.kernel.org>; Wed, 12 Jun 2024 11:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718217725; x=1718822525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyjNx6mhpvW9YXiiGRFtRdyYH38iCG9XWhLjCi2XuMc=;
        b=m8e3qq/qDvKG3dXPYRK+4U66bVmp2LDWcVq7ZcX6C/Zg3+UHMyX+ftogWMadGGlogw
         6N7W4A8C4PazO9wgmyNEsA9prGzN+/fIT2cyBusYC8hldbad/EGKWK5A+pKcRgAAZOpZ
         n+TBRNzS/rQMmB4QL0hzVcpEMO4fANm1iVLcDJRVUdBRaMnHSoIros6TroIDhyPARPSI
         5aFBGZOtO+RKANz4SjcE93j0C3ti/jNP71t5k2y+AJ4LZvBLHXZ9Hve6QjVKVMMuwNZh
         /mfxNseAsI6OdyygzrNEVG4QO6b8s/Xk43uLJYPbo58BW8aSTxUP/u4gBnV70ZLcZFAm
         g0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718217725; x=1718822525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyjNx6mhpvW9YXiiGRFtRdyYH38iCG9XWhLjCi2XuMc=;
        b=L3Agz++Gj9/m/fCqIZjfPohXxZcM5uWuAtOGH4Y+aMDlz5EzLFiMo8p0NKdcq/pIcI
         xsCjlH9bObTB3t3DU0TREfaWJVODO2qTORUfTrBVaWP4y590Z5ilDK0snDb168BqvwS4
         tw7y8M9Qw+/DUzaLPylNufndbamnE3r67DurQIz/WCzqjOX8T5Cgx2cjV7+4XkNL97zD
         dzHyi3Dzi3P0NWinMrUea7SlgxC/nfLzFr0o4AQ+d0aub4liHQ8/dvn9/5JxTekMD7g4
         0gzeMHqzQtX1d8vatynIv9tPpb5fKZwUY1WWjzR7E/ZgRHDZIn+BfDkyHK8UDtlwg52j
         C/GA==
X-Gm-Message-State: AOJu0Yy72eX5OO8Z1Gl/5y4od54VfQr/e2SMSOTpdjF8MKoga5d1IdZn
	euvgCd2myURhrSVCcZEUsViSboKjYBPMa09GJ1YD68kiAJXZnsNd45+TB1fJeNR/bULtLqNuLQr
	nqp9SfNA7voLsjF15gJP3EoHkhJ5wKRN8
X-Google-Smtp-Source: AGHT+IHKzgeu8juG4KtB+91WBvdMYPwzps3/LALf0oWkvP1ZFxtrC5W52S1jsHKBE2hKuA2pPngG9w47ul7RhKIrdr8=
X-Received: by 2002:a05:6102:32c6:b0:48d:920a:bd43 with SMTP id
 ada2fe7eead31-48d920ac0admr3822024137.29.1718217725081; Wed, 12 Jun 2024
 11:42:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608171739.135501-1-cgoettsche@seltendoof.de>
In-Reply-To: <20240608171739.135501-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 12 Jun 2024 14:41:54 -0400
Message-ID: <CAP+JOzRhMS5WWgsBXnOVYKAe92EQDf64FjkqL_GZhp7RztGLMA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: contify function pointer arrays
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 1:27=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> These function pointers are never modified.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/link.c          | 4 ++--
>  libsepol/src/module_to_cil.c | 8 ++++----
>  libsepol/src/write.c         | 2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/libsepol/src/link.c b/libsepol/src/link.c
> index b8272308..048d742e 100644
> --- a/libsepol/src/link.c
> +++ b/libsepol/src/link.c
> @@ -749,7 +749,7 @@ static int cat_copy_callback(hashtab_key_t key, hasht=
ab_datum_t datum,
>         return 0;
>  }
>
> -static int (*copy_callback_f[SYM_NUM]) (hashtab_key_t key,
> +static int (*const copy_callback_f[SYM_NUM]) (hashtab_key_t key,
>                                         hashtab_datum_t datum, void *data=
p) =3D {
>  NULL, class_copy_callback, role_copy_callback, type_copy_callback,
>             user_copy_callback, bool_copy_callback, sens_copy_callback,
> @@ -1215,7 +1215,7 @@ static int user_fix_callback(hashtab_key_t key, has=
htab_datum_t datum,
>         return -1;
>  }
>
> -static int (*fix_callback_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum_=
t datum,
> +static int (*const fix_callback_f[SYM_NUM]) (hashtab_key_t key, hashtab_=
datum_t datum,
>                                        void *datap) =3D {
>  NULL, NULL, role_fix_callback, type_fix_callback, user_fix_callback,
>             NULL, NULL, NULL};
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 3b3480bf..2dbf137e 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -2951,8 +2951,8 @@ static int ocontexts_to_cil(struct policydb *pdb)
>         int rc =3D -1;
>         int ocon;
>
> -       static int (**ocon_funcs)(struct policydb *pdb, struct ocontext *=
ocon);
> -       static int (*ocon_selinux_funcs[OCON_NUM])(struct policydb *pdb, =
struct ocontext *ocon) =3D {
> +       static int (*const *ocon_funcs)(struct policydb *pdb, struct ocon=
text *ocon);
> +       static int (*const ocon_selinux_funcs[OCON_NUM])(struct policydb =
*pdb, struct ocontext *ocon) =3D {
>                 ocontext_selinux_isid_to_cil,
>                 ocontext_selinux_fs_to_cil,
>                 ocontext_selinux_port_to_cil,
> @@ -2963,7 +2963,7 @@ static int ocontexts_to_cil(struct policydb *pdb)
>                 ocontext_selinux_ibpkey_to_cil,
>                 ocontext_selinux_ibendport_to_cil,
>         };
> -       static int (*ocon_xen_funcs[OCON_NUM])(struct policydb *pdb, stru=
ct ocontext *ocon) =3D {
> +       static int (*const ocon_xen_funcs[OCON_NUM])(struct policydb *pdb=
, struct ocontext *ocon) =3D {
>                 ocontext_xen_isid_to_cil,
>                 ocontext_xen_pirq_to_cil,
>                 ocontext_xen_ioport_to_cil,
> @@ -3404,7 +3404,7 @@ exit:
>  }
>
>
> -static int (*func_to_cil[SYM_NUM])(int indent, struct policydb *pdb, str=
uct avrule_block *block, struct stack *decl_stack, char *key, void *datum, =
int scope) =3D {
> +static int (*const func_to_cil[SYM_NUM])(int indent, struct policydb *pd=
b, struct avrule_block *block, struct stack *decl_stack, char *key, void *d=
atum, int scope) =3D {
>         NULL,   // commons, only stored in the global symtab, handled els=
ewhere
>         class_to_cil,
>         role_to_cil,
> diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> index f8cd9e1d..a52e2e82 100644
> --- a/libsepol/src/write.c
> +++ b/libsepol/src/write.c
> @@ -1344,7 +1344,7 @@ static int user_write(hashtab_key_t key, hashtab_da=
tum_t datum, void *ptr)
>         return POLICYDB_SUCCESS;
>  }
>
> -static int (*write_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum_t datum=
,
> +static int (*const write_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum_t=
 datum,
>                                 void *datap) =3D {
>  common_write, class_write, role_write, type_write, user_write,
>             cond_write_bool, sens_write, cat_write,};
> --
> 2.45.1
>
>
