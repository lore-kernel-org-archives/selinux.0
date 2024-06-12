Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE11316E895
	for <selinux@vger.kernel.org>; Wed, 12 Jun 2024 18:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718215819; cv=none; b=OUP/EB8TvwEtRZfyFSrV2uTaOA8GNn3Fs6TZTM9G0qA3vHUqpvxdD1iQZjgNsWw0z1AWmXmeXCDNqOKcsNd+Yz9JHDM6fLchNdiDPI0OIgVwZSgPBcF8HiON+RMTSKu2JqL8Qo6aLusdlAZau7zpjA5JIhZADUULAU87vJD2kVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718215819; c=relaxed/simple;
	bh=YpJfc60fzON/bmbYJZiDJBe6HVFzjKN7f6Fss3w4g+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUK/5ccB+RKoniAbl3Ze68N4muqmkau77nYU8I0AjgRlSn0rBzoLf55FBkiaszBDBB5XxGeVEUTMyoTlp252wizcpE/v4wg9KM+I0LD9eT8btnkbpctu6bMefaxd6puaIPZwGWAEywPjUiNYwZzQmMs3BrgcEX+A3jzgpRcy8ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIsCZu+L; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIsCZu+L"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3cabac56b38so16753b6e.3
        for <selinux@vger.kernel.org>; Wed, 12 Jun 2024 11:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718215817; x=1718820617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHM6tNGnMdwoIpBJCjWrbaRtH1vLkhAzUY58hOQsyME=;
        b=iIsCZu+LRqH0BodvZX6JTqv/EL70f10F2KtXN8z3j9LeXeo3tzPul6IQM775HGAZHa
         qkgvFmktoWf0uaEX3akHDcB4rKDo078+vhXXKVdrnesj3fEI4CwqwONjq099M5JNatZk
         ARgCxYcrLlgGvAvLmcrXIyGGE1PS5R+grAXiZNp7/7w1FkRlybj9aVm7UVVsVcPFpxYq
         9JHl3Ey6J6vqS5S+RIfie4i4c/68Aqp8YmEUdo50sJFRpeTLOJLmxACp5Aa90MHVaWZb
         9aSs0w7+oeJShkutoheHAxYt0n0S0tVf+0mAxA4L+HxTgW/pEr1fYmQ9OTQaGH1i44CT
         yqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718215817; x=1718820617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHM6tNGnMdwoIpBJCjWrbaRtH1vLkhAzUY58hOQsyME=;
        b=sND/PRH1Blz4DJUjTBaDJtRCPuS1sDt3szzQ4mpIxCGYNQzfUNxEy4F/VeqJoUXpF1
         vYI0S/o6aVoFOOxeD0alhaoHjbZymtI2snf88nlgvu8wjN34kp/3hgpadHTFl0K0jHiA
         gryNUWzNoTIk6HRvrI28BYvDUUBlnpc+Fh3kGpaGN2L8ng/eitN3EKri2/4XhAwU++Pz
         J7aa2dCmKX8uNbCfDhVPKS599Bqgv5J1VDDH03xXpgMcJqW8KdSREjM1DwktGajICSAP
         r51Xn7yE4+UqygziFwzNyoj0AkVHeckjcPgInTSuWgpFIM1knT5ye+Bt5/E74JXU7H3s
         Wr1w==
X-Gm-Message-State: AOJu0Yz/YgY/c0CowKV8A07D6mTuH7ci2KxtXXDT/pQdiIl0Uc3dST4Z
	HZhLVGfYaQCwzcN9OOKfvSRiFfctbvPpkLrNR2oriO6Om/pnBtd8sDO9GYn846mJvHAGbPllh2Y
	BS1IdacV1xp6pFavgEbh0cb+J8PetBCdv
X-Google-Smtp-Source: AGHT+IGMgonVwdAkRdA+YWDxo8TquBWMe4mEj6GL5VEFwaytDhJjdfNvqIwzjMjWYwIQULL/wrgiyh/sEnvZFH9kQn4=
X-Received: by 2002:a05:6808:3096:b0:3d2:2703:2573 with SMTP id
 5614622812f47-3d23dfb5b5amr3147879b6e.8.1718215816872; Wed, 12 Jun 2024
 11:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608172332.140336-1-cgoettsche@seltendoof.de>
In-Reply-To: <20240608172332.140336-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 12 Jun 2024 14:10:05 -0400
Message-ID: <CAP+JOzQPRyF06cb=y4LQ-ASt3ei48bb7WCwSUoivsx+yus2oUg@mail.gmail.com>
Subject: Re: [PATCH] tree-wide: fix misc typos
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 1:23=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/utils/sefcontext_compile.c | 2 +-
>  libsepol/src/kernel_to_cil.c          | 4 ++--
>  libsepol/src/kernel_to_conf.c         | 4 ++--
>  secilc/docs/cil_reference_guide.md    | 4 ++--
>  4 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sef=
context_compile.c
> index 6c32172d..8677189e 100644
> --- a/libselinux/utils/sefcontext_compile.c
> +++ b/libselinux/utils/sefcontext_compile.c
> @@ -189,7 +189,7 @@ static int write_binary_file(struct saved_data *data,=
 int fd,
>                 if (len !=3D 1)
>                         goto err;
>
> -               /* original context strin (including nul) */
> +               /* original context string (including nul) */
>                 len =3D fwrite(context, sizeof(char), to_write, bin_file)=
;
>                 if (len !=3D to_write)
>                         goto err;
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index e20ba4af..f94cb245 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -303,7 +303,7 @@ static int class_constraint_rules_to_strs(struct poli=
cydb *pdb, char *classkey,
>                         goto exit;
>                 }
>                 if (*perms =3D=3D '\0') {
> -                       ERR(NULL, "No permisisons in permission string");
> +                       ERR(NULL, "No permissions in permission string");
>                         free(perms);
>                         rc =3D -1;
>                         goto exit;
> @@ -1782,7 +1782,7 @@ static char *avtab_node_to_str(struct policydb *pdb=
, avtab_key_t *key, avtab_dat
>                         goto exit;
>                 }
>                 if (*perms =3D=3D '\0') {
> -                       ERR(NULL, "No permisisons in permission string");
> +                       ERR(NULL, "No permissions in permission string");
>                         free(perms);
>                         goto exit;
>                 }
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
> index 5860a513..ca91ffae 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -298,7 +298,7 @@ static int class_constraint_rules_to_strs(struct poli=
cydb *pdb, char *classkey,
>                         goto exit;
>                 }
>                 if (*perms =3D=3D '\0') {
> -                       ERR(NULL, "No permisisons in permission string");
> +                       ERR(NULL, "No permissions in permission string");
>                         free(perms);
>                         rc =3D -1;
>                         goto exit;
> @@ -1748,7 +1748,7 @@ static char *avtab_node_to_str(struct policydb *pdb=
, avtab_key_t *key, avtab_dat
>                         goto exit;
>                 }
>                 if (*permstring =3D=3D '\0') {
> -                       ERR(NULL, "No permisisons in permission string");
> +                       ERR(NULL, "No permissions in permission string");
>                         free(permstring);
>                         goto exit;
>                 }
> diff --git a/secilc/docs/cil_reference_guide.md b/secilc/docs/cil_referen=
ce_guide.md
> index d1d3ff16..5ae5a3a3 100644
> --- a/secilc/docs/cil_reference_guide.md
> +++ b/secilc/docs/cil_reference_guide.md
> @@ -281,7 +281,7 @@ The number of `expr_set`'s in an `expr` is dependent =
on the statement type (ther
>          (mlsconstrain (process (transition dyntransition))
>              (or (and (eq h1 h2) (eq l1 l2)) (eq t1 mlstrustedsubject)))
>
> -        ; The equivalent policy language mlsconstrain statememt is:
> +        ; The equivalent policy language mlsconstrain statement is:
>          ;mlsconstrain process { transition dyntransition }
>          ;    ((h1 eq h2 and l1 eq l2) or t1 =3D=3D mlstrustedsubject);
>
> @@ -289,7 +289,7 @@ The number of `expr_set`'s in an `expr` is dependent =
on the statement type (ther
>          (mlsconstrain (process (getsched getsession getpgid getcap getat=
tr ptrace share))
>              (or (dom l1 l2) (eq t1 mlstrustedsubject)))
>
> -        ; The equivalent policy language mlsconstrain statememt is:
> +        ; The equivalent policy language mlsconstrain statement is:
>          ;mlsconstrain process { getsched getsession getpgid getcap getat=
tr ptrace share }
>          ;    (l1 dom l2 or t1 =3D=3D mlstrustedsubject);
>      ```
> --
> 2.45.1
>
>
