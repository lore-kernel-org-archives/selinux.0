Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5350F33AD99
	for <selinux@vger.kernel.org>; Fri, 29 May 2026 13:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780062195; cv=pass; b=ThjsCpHhcKUKReXIvkReGq6sSOwhmYxINdL7uZq76jCD87YI1nGKYjDhjB3eWYqQXJ1GR2t2kTwukeK7xXfY6AuRoyI4GxAnhpdjzINpfiz36yLmQTFq6hbCNt/y5QjBNFYuTJk3GBCVS440EHiTh26nbHvOxm8TVzIQR2KTU8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780062195; c=relaxed/simple;
	bh=RZBygnYqKdO8cehoB6gfYwDZgxY2qTO4fIimRmq7YAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Er08mR1YypJaJzlU3+5EtdtMuPkV9S3aCoPGOAFRiX4X4MGXGJNDZjReM+es+v5qTdflmW2pqDHtBtEqsRRWuvlWxRXhiZ4IkzueC/Ek+vWpRS4ud6+/ZpGTtUA7RdbdALnxQqY9vo0/MDEo+ScZvnoRVm2Uh9AwWCK0YFGH22I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZl0kGxW; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZl0kGxW"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39393ec4ed0so124030411fa.0
        for <selinux@vger.kernel.org>; Fri, 29 May 2026 06:43:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780062191; cv=none;
        d=google.com; s=arc-20240605;
        b=cAR52yQ8anjFmu6SW4GiK5LuNhivm3ure2AAzi7dwBgyEq4Cvf6K88Qowz4URK3sze
         KVyrR2twtuJc3urvnqszmUhJLsmmAeNY7JyGvd9qzZg1sffpax7DAmv1ZG8nchv9xcY1
         PTUVDgeVQBrNeL7tzq8hQIkr9Qw8zmFSFIHO/ZCYYXF8bh/mP/6JEsQ3ghlwJTn8ovKI
         /rOszNGpRRD/ILd+3+hYOyy2ms57ooE0H1JI69wm9v84kYM25X0wl6NdHvvDyxz/IuW+
         sa6rx1OgQZtmKCmQ0Wb1SL3xUiuFmvA155M7gw34K/OyeVR9IH1ZnjM3FUfaf2HI/Ga/
         V0GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wlqMbrRHzsH5O8CfcYnOTiyFxtngWB1nEvleeAFFVFg=;
        fh=+D6xJ6BB9J6NyoJZZl71KoOEMrrFPGwz9kIyEgHHWvo=;
        b=AGgINXyPPCfJM3STFegjYoTg0FU+zBLZDgCJ0WtBxxIesIwoHX/IH+wUlMgXEXlQi6
         zqxp+VHbZZOmf4M3BsIEUlWPWsHlhxi8V1XfvFWm3W6RLTMKpQKezUC/WwJXrsxjS4PB
         y2Bmxtsqo1sqd/jUOQEYSlKDO6wTIoU0Zii67hpCBQJbdRMA6xu4z2xgqrsJ1ZofIkXd
         A7lMwMXa9dK0Pm9KKfW3Fm4OzqnpZCfP2FNQTpwQXe0p+nLTNwi3yyZRdHYcW6LTwZOK
         /Q6Vd7weseqYyJVLW7dTihawh5jWHuq0MIAVTXCnXOCrFS71VjIpkBm7u0Qp3DY9shE+
         V0zQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780062191; x=1780666991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlqMbrRHzsH5O8CfcYnOTiyFxtngWB1nEvleeAFFVFg=;
        b=EZl0kGxWNJrGFw5HlNJtpPOEYnOV4i6FSGIAu1Musa+rZemeMtYrBZvGJlCxJDZUEh
         b98tnS+Ypwx+359KBaR7LhfdtfYxgeCgt3OUlt91TcIxawwgVDnxkOGjj1SLGo8DWmBO
         sJn/kODTo5GsmjnRdyQnG/YTrCEEfx9FyEvq3ktBgd+Zs5pYD658CxoRFE/nUtysvA+T
         PrzL01CPx7xLegcQI5xraWrJVF+2SCDBshBuqBRBLzUOtn/zsV24OtZrVAVlCO+fb0ys
         9sSz4LqA/MmIBt08CrHu8n4JYwenPTdw64bv7Qaxwvcqa663xfIudujjq9m7YXgYrrcN
         Mp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780062191; x=1780666991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wlqMbrRHzsH5O8CfcYnOTiyFxtngWB1nEvleeAFFVFg=;
        b=qR2d8SZTFcDKfWMbXNou1jRWN+DzfSqtOGVaqfz7Lae2AoviWRLmdfb1DcjXtupemV
         NXIj3tVQGqhn2LwxlVyevXEnheHa4MSe/F6qktEJB9dnfxUy/k57KD/FQWzr/hvgQRS/
         /XijJwxc6ERXZVkpjMaO/2s01EzIYGNXI2hq1uiTCLcPFLc1u/egit/f4OhHxs+KjGSg
         2LP8J9ELubNpADxLXG5uibflCdJHRErp2jtW95P9f54asMmW5k3Trg92p+WPAu17tl1a
         BhqmfMHwm6lMH8DmYvtdKvXqxSgqw3rFoZY0HWeUQXtvs6bJo5C5y3qmS84axALPSnJV
         Me/w==
X-Gm-Message-State: AOJu0YzYBOiDWRZT2ArFYKBuMN1gFBBJMwR4ccRfSe8Yvk8h8V3Os11W
	NEyw8uNLSw4DHcX5fviT2ztmn1NNIXMszM1bFPlhylWz/eqv3TRSSjagtstDTQVKSAMq0ZoVirX
	WqjwNSC1kPIFv7R9fchmSnRuA7SjsCz/CfYfO
X-Gm-Gg: Acq92OHoTzPVkdQJFDsOdB5AMVJAc7H1bXWRAF6B/qOaf44negWFP84IwGTABx2a4F+
	bKilVHmAwQOf3AldIBVxVps1mg/yht0REG8kXGId/SZ4r9b5VAf9JJJYVJpyUK446mmQAaTiE2j
	jA1pSfNIdEcDo6uqw3STzdjL4NWzO00szCLtdp6NelOpKf5an5UPOKegbVNha2ZLMDnF/IuHsMr
	t1Flu+6sWHlQBtw3dBTh6Ujx+RaBWG/LozNxJShmnU+nDnpo2+w5CQlY1n5Qfp/eMPWB1/KCY9z
	HDuDKoH5JAS75IiDmyJYX/F56Q==
X-Received: by 2002:a2e:bcc1:0:b0:38e:af87:8dee with SMTP id
 38308e7fff4ca-396539ca646mr9203511fa.22.1780062191138; Fri, 29 May 2026
 06:43:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528163930.418992-2-nvraxn@posteo.uk>
In-Reply-To: <20260528163930.418992-2-nvraxn@posteo.uk>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 29 May 2026 09:42:59 -0400
X-Gm-Features: AVHnY4LsjxnW9J26vC3chiCaDmqbXAttG6WitVKefU7Dc_-hhQctrhyyYCjfyF0
Message-ID: <CAP+JOzRB=2-jSQaSVjVQ12YHb5yTM71yPrXmFDDG_FiaQaT3TQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: check the number of elements in the avtab
To: Rahul Sandhu <nvraxn@posteo.uk>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 12:57=E2=80=AFPM Rahul Sandhu <nvraxn@posteo.uk> wr=
ote:
>
> Instead of counting each time we semantically see an AV rule, check the
> number of elements in the access vector table. AV rules may collapse to
> nothing, for example:
>
> (class foo (bar baz))
> (classorder (foo))
>
> (allow t self (foo (not (bar baz))))
>
> Previously, the compiler would incorrectly count the above rule as one
> AV rule, when in reality it collapses down to nothing as no permissions
> are actually granted.
>
> Signed-off-by: Rahul Sandhu <nvraxn@posteo.uk>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_binary.c | 6 ++++++
>  libsepol/cil/src/cil_post.c   | 8 --------
>  libsepol/cil/src/cil_verify.c | 6 ------
>  libsepol/cil/src/cil_verify.h | 1 -
>  4 files changed, 6 insertions(+), 15 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.=
c
> index 74ec3cd5..dca1937a 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -5468,6 +5468,12 @@ int cil_binary_create_allocated_pdb(const struct c=
il_db *db, sepol_policydb_t *p
>                 goto exit;
>         }
>
> +       if (pdb->te_avtab.nel =3D=3D 0) {
> +               cil_log(CIL_ERR, "Policy must include at least one avrule=
\n");
> +               rc =3D SEPOL_ERR;
> +               goto exit;
> +       }
> +
>         rc =3D SEPOL_OK;
>
>  exit:
> diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> index 2b6dad73..fa59d337 100644
> --- a/libsepol/cil/src/cil_post.c
> +++ b/libsepol/cil/src/cil_post.c
> @@ -2506,7 +2506,6 @@ exit:
>  static int cil_post_verify(struct cil_db *db)
>  {
>         int rc =3D SEPOL_ERR;
> -       int avrule_cnt =3D 0;
>         int handleunknown =3D -1;
>         int mls =3D -1;
>         int nseuserdflt =3D 0;
> @@ -2518,7 +2517,6 @@ static int cil_post_verify(struct cil_db *db)
>
>         extra_args.db =3D db;
>         extra_args.csymtab =3D &csymtab;
> -       extra_args.avrule_cnt =3D &avrule_cnt;
>         extra_args.handleunknown =3D &handleunknown;
>         extra_args.mls =3D &mls;
>         extra_args.nseuserdflt =3D &nseuserdflt;
> @@ -2548,12 +2546,6 @@ static int cil_post_verify(struct cil_db *db)
>                 }
>         }
>
> -       if (avrule_cnt =3D=3D 0) {
> -               cil_log(CIL_ERR, "Policy must include at least one avrule=
\n");
> -               rc =3D SEPOL_ERR;
> -               goto exit;
> -       }
> -
>         if (nseuserdflt > 1) {
>                 cil_log(CIL_ERR, "Policy cannot contain more than one sel=
inuxuserdefault, found: %d\n", nseuserdflt);
>                 rc =3D SEPOL_ERR;
> diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.=
c
> index 9654d71d..d3c4fd81 100644
> --- a/libsepol/cil/src/cil_verify.c
> +++ b/libsepol/cil/src/cil_verify.c
> @@ -1621,7 +1621,6 @@ exit:
>  int __cil_verify_helper(struct cil_tree_node *node, uint32_t *finished, =
void *extra_args)
>  {
>         int rc =3D SEPOL_ERR;
> -       int *avrule_cnt =3D 0;
>         int *handleunknown;
>         int *mls;
>         int *nseuserdflt =3D 0;
> @@ -1635,7 +1634,6 @@ int __cil_verify_helper(struct cil_tree_node *node,=
 uint32_t *finished, void *ex
>         }
>
>         db =3D args->db;
> -       avrule_cnt =3D args->avrule_cnt;
>         handleunknown =3D args->handleunknown;
>         mls =3D args->mls;
>         nseuserdflt =3D args->nseuserdflt;
> @@ -1671,10 +1669,6 @@ int __cil_verify_helper(struct cil_tree_node *node=
, uint32_t *finished, void *ex
>                 case CIL_TYPE:
>                         rc =3D __cil_verify_type(node);
>                         break;
> -               case CIL_AVRULE:
> -                       (*avrule_cnt)++;
> -                       rc =3D SEPOL_OK;
> -                       break;
>                 case CIL_HANDLEUNKNOWN:
>                         if (*handleunknown !=3D -1) {
>                                 cil_log(CIL_ERR, "Policy can not have mor=
e than one handleunknown\n");
> diff --git a/libsepol/cil/src/cil_verify.h b/libsepol/cil/src/cil_verify.=
h
> index daa2f80a..f86d07ed 100644
> --- a/libsepol/cil/src/cil_verify.h
> +++ b/libsepol/cil/src/cil_verify.h
> @@ -49,7 +49,6 @@ enum cil_syntax {
>  struct cil_args_verify {
>         struct cil_db *db;
>         struct cil_complex_symtab *csymtab;
> -       int *avrule_cnt;
>         int *handleunknown;
>         int *mls;
>         int *nseuserdflt;
> --
> 2.54.0
>
>
