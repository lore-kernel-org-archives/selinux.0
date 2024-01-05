Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E71436087
	for <selinux@vger.kernel.org>; Fri,  5 Jan 2024 19:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKzQCCAN"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cd37c0b8e5so6915131fa.3
        for <selinux@vger.kernel.org>; Fri, 05 Jan 2024 11:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704484575; x=1705089375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jN28bXgrYRdAN66yVAKIHCh62DDa5n1ak0dhqkgOUl8=;
        b=UKzQCCANykLQu4lPVdSkYkHw+I4FxMHkblviD0hewiewny5tUnNW7phd6Oc+AbxTMP
         B6zu5/CCrkfK2AsFDBUbNi1Hn0SZCzl5x9Om3encKnx0vc3Ecm7FpXs4VHEaRdyIuAEO
         7it/9tSHbZRebDVALgKPrgj2I4A1bu2HhCiL+xW5cwewmyV0l+Gv2bDi023XPo2r+1jZ
         FkSKb1pYFGBau5zwOsV1AG/tRasf1kRPEpY4u+8bmOdlqW23WHs0ZNshbm8CsaRrK7j2
         aPHe43BsNdqKUGJYAw3bb9311vXRpfvnvMs6dzMbTJJ9ogNHvep/tRAe7wvDfo8DyNmf
         +aYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704484575; x=1705089375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jN28bXgrYRdAN66yVAKIHCh62DDa5n1ak0dhqkgOUl8=;
        b=KMxGZjl55N6N6zLFeSvitpgq2WgaEGfuUKovhWnQ6/XPDQ8cBlGGBGYh++uIAHaiOL
         ZhVSVkwzhR0L1pUDcelCUH90/TvSyTsFkJeO0lrYeRPOhHnsoWOoU0L5ueNmy3+oZr7s
         sMnBeGME9GGzRNndzznsCJ9TWjSplnAkjiqFG5DHmsCJexxJXZiZbt0mF49HcemRZfvz
         3XWcUxjGkKIVKHCmJhXOAcZKs8G9fWki2ieCGjk1u6BfLGY0K6geVaRxNxSQHieRGISf
         31b3GazAAbdDiz9dtTgTyhnbCWZXOP2knu2j2Ks1niMgGl80msdZvw3DfSvYE6CWp2+M
         6KLA==
X-Gm-Message-State: AOJu0Yxy6iYOxsqrK0GgWAWZBPyaw8XGFRe9LLDu9tOIFERO4WEq8IGX
	jB65xNGKmtsne6nGp+uXjgrHJxL4vtNpds+Dwq3YFrwfWkg=
X-Google-Smtp-Source: AGHT+IGYltwajjswX1h7zxKi92u8kfT8yPk4+YOJrLfmyqsKZDALtXVEa9BE65Tg3MpYGgKYWqe/1+o67JhmEY5XKsM=
X-Received: by 2002:a05:651c:1988:b0:2cc:eb95:684d with SMTP id
 bx8-20020a05651c198800b002cceb95684dmr1683418ljb.76.1704484574972; Fri, 05
 Jan 2024 11:56:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105183534.1110639-1-cgzones@googlemail.com>
In-Reply-To: <20240105183534.1110639-1-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 5 Jan 2024 14:56:03 -0500
Message-ID: <CAP+JOzSjf8zZCETt108K2nboKmsHNnhnKva+u_nw7xYashU_aA@mail.gmail.com>
Subject: Re: [PATCH 1/4] libsepol: reorder calloc(3) arguments
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 1:36=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The canonical order of calloc(3) parameters is the number of elements
> first and the size of each element second.
>
> Reported by GCC 14:
>
>     kernel_to_conf.c:814:47: warning: 'calloc' sizes specified with 'size=
of' in the earlier argument and not in the later argument [-Wcalloc-transpo=
sed-args]
>     kernel_to_conf.c:945:46: warning: 'calloc' sizes specified with 'size=
of' in the earlier argument and not in the later argument [-Wcalloc-transpo=
sed-args]
>     kernel_to_conf.c:2109:35: warning: 'calloc' sizes specified with 'siz=
eof' in the earlier argument and not in the later argument [-Wcalloc-transp=
osed-args]
>     kernel_to_common.c:578:29: warning: 'calloc' sizes specified with 'si=
zeof' in the earlier argument and not in the later argument [-Wcalloc-trans=
posed-args]
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these four patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/kernel_to_common.c | 2 +-
>  libsepol/src/kernel_to_conf.c   | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_com=
mon.c
> index 4612eef3..2422eed0 100644
> --- a/libsepol/src/kernel_to_common.c
> +++ b/libsepol/src/kernel_to_common.c
> @@ -575,7 +575,7 @@ static int sort_ocontext_data(struct ocontext **ocons=
, int (*cmp)(const void *,
>                 return 0;
>         }
>
> -       data =3D calloc(sizeof(*data), num);
> +       data =3D calloc(num, sizeof(*data));
>         if (!data) {
>                 ERR(NULL, "Out of memory");
>                 return -1;
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
> index 83f46e0f..e6b449b4 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -811,7 +811,7 @@ static int write_sensitivity_rules_to_conf(FILE *out,=
 struct policydb *pdb)
>         num =3D strs_num_items(strs);
>
>         if (num > 0) {
> -               sens_alias_map =3D calloc(sizeof(*sens_alias_map), pdb->p=
_levels.nprim);
> +               sens_alias_map =3D calloc(pdb->p_levels.nprim, sizeof(*se=
ns_alias_map));
>                 if (!sens_alias_map) {
>                         rc =3D -1;
>                         goto exit;
> @@ -942,7 +942,7 @@ static int write_category_rules_to_conf(FILE *out, st=
ruct policydb *pdb)
>         num =3D strs_num_items(strs);
>
>         if (num > 0) {
> -               cat_alias_map =3D calloc(sizeof(*cat_alias_map), pdb->p_c=
ats.nprim);
> +               cat_alias_map =3D calloc(pdb->p_cats.nprim, sizeof(*cat_a=
lias_map));
>                 if (!cat_alias_map) {
>                         rc =3D -1;
>                         goto exit;
> @@ -2106,7 +2106,7 @@ static int write_cond_nodes_to_conf(FILE *out, stru=
ct policydb *pdb)
>                 return 0;
>         }
>
> -       cond_data =3D calloc(sizeof(struct cond_data), num);
> +       cond_data =3D calloc(num, sizeof(struct cond_data));
>         if (!cond_data) {
>                 rc =3D -1;
>                 goto exit;
> --
> 2.43.0
>
>
