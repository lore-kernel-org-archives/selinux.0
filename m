Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0056BFBA
	for <selinux@vger.kernel.org>; Wed, 20 Mar 2024 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710965121; cv=none; b=k5EYX+ivZnxwEhifqnrgvHvDjmrroSHwBehSn4oirf/cDhtpC4/JcnvLZ1Vc6VxcBgjCoY41GnZkAtQ3PVH0MEOgwqdEvnK9Maf1Sjy0q/b0K97XELAaGPCyri+fET6KEKRJsNZ9RnBQW3Ws6rH1LPF3F5ygrPOZjnvWcACy6p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710965121; c=relaxed/simple;
	bh=/sSOeFFKIc53duQfBnEUxHqpQcZp/umbvZE7n7CeWBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A1Fpeq++F7sBu6JI0TzTlRBkQJNxPdZtEXylsxlfcyscUgTSBqPqgmUebi3MdC+EVrHg62a2+gK25gzuaDD3M+3EDoKxwFgVmpEP5axvwuOi7O2ry2AQmk9kIEeGKndxmOnOGmGdBlLTnL/K8s9MB1N13IKrESGDx0FZrsxvwvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgyoStDs; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgyoStDs"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c39177fea4so194742b6e.2
        for <selinux@vger.kernel.org>; Wed, 20 Mar 2024 13:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710965119; x=1711569919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YD5fWv7ONP2jcaPbMUVcVRPeSfDYkZ0herFWbGPAd1k=;
        b=YgyoStDsypHzvYa2UUVQPqLrWGjRajCDZZJzgszdswyCMLfXmwHUzQslXZz9UuxA9R
         YPVkimZRa85dUToUmr/he3ohBDEmT4ssO9mGpXKdjwAkKXRHdE+yKvXNEIBMgXr5xR7K
         +jchgb+XetNYshZXUwtlA+z9pOQZu6048uZemVTUr2qDCMQk2Fk44xkLJ68PABq9/nXv
         G3b6BV1WQirL4yHlhro743mH/7RGASG26nBq/sfop8Y4t9xlQXgds1r810ZaB/KhPRB/
         yWabU9agDNyMOomC07/G3xw/F3Z+jag5Z0pmoelhVy1DiN2Q3sl5xequ5iSZKsxJPq7B
         v51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710965119; x=1711569919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YD5fWv7ONP2jcaPbMUVcVRPeSfDYkZ0herFWbGPAd1k=;
        b=eeDOlYFCU+AawSXa5p6YDekrl/H5cowzfn1Pl889tcs5LCw1qvIMiCYbOIA/PB3nsc
         Eqz5Zvg+O6XS7gHaJla2fpgCXGBdHa0e+AZuQqLd/JR0SpcqFfgjnZ5z7mhfNwTlzG0N
         ZGZDYHaU3RRS8XzXb6EAaDzyRZz3biGOVtZ8j+SQJ5NAzC4eYEs2vj4UgSK+/7O0y5rI
         ZKxRz71n4IBi/oGkW5B1Ftw++44DYEUvWNjFGgzu2g9awTJrTT01lQGKbaefPGJwsVut
         pRmdLjFUMzIPEGbFh7ROAoS2rhtg3ZAaALOIl8t3R9yjcFWyUSME574YeJ7blNDLjmUv
         b9Zg==
X-Gm-Message-State: AOJu0Yye6W+3CnnNh4Z2NkwcLl4DJaqc0Lh9IilUcMO2MfHSQy0PANeW
	gkTcZY+sAWJq0/qiFxfcPsmOA5rbsMD837EJ+gog29a5DaoF8PRY2gwAd3R6r9gGz7qzE/ksoVB
	2D96oUxr5CSp7S/yRPzhMOeI4guj6n0vE
X-Google-Smtp-Source: AGHT+IEVPFuykhhXmobwq9SSanem1wJPkEC7PYyDbRZd5UhpExc+hp/znxO1q4GFOkGYkuaCsTXaif0aHUsBDrYE3jA=
X-Received: by 2002:a05:6808:19a9:b0:3c1:f027:aaec with SMTP id
 bj41-20020a05680819a900b003c1f027aaecmr3725582oib.26.1710965118957; Wed, 20
 Mar 2024 13:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311211946.2691879-1-jwcart2@gmail.com>
In-Reply-To: <20240311211946.2691879-1-jwcart2@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 20 Mar 2024 16:05:08 -0400
Message-ID: <CAP+JOzQH3eJxsS+OrF9nXKk+QrZKLn2gUteOLX6N=SvCAuf6Ug@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: Fix buffer overflow when using sepol_av_to_string()
To: selinux@vger.kernel.org
Cc: cgzones@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 5:19=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> The function sepol_av_to_string() normally returns a list of
> permissions with a space at the beginning, but it will return '\0'
> if there are no permissions. Unfortunately, functions in
> kernel_to_cil, kernel_to_conf, and module_to_cil assume there is a
> space at the beginning and skip the space by using "perms+1".
>
> In kernel_to_cil, kernel_to_conf, and module_to_cil, check for the
> permission string being '\0' and return an error if it is.
>
> Reported-by: oss-fuzz (issue 67276)
> Signed-off-by: James Carter <jwcart2@gmail.com>

This patch has been merged.
Jim

> ---
>  libsepol/src/kernel_to_cil.c  | 11 +++++++++++
>  libsepol/src/kernel_to_conf.c | 11 +++++++++++
>  libsepol/src/module_to_cil.c  | 12 ++++++++++++
>  3 files changed, 34 insertions(+)
>
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index a081915e..e20ba4af 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -302,6 +302,12 @@ static int class_constraint_rules_to_strs(struct pol=
icydb *pdb, char *classkey,
>                         rc =3D -1;
>                         goto exit;
>                 }
> +               if (*perms =3D=3D '\0') {
> +                       ERR(NULL, "No permisisons in permission string");
> +                       free(perms);
> +                       rc =3D -1;
> +                       goto exit;
> +               }
>
>                 if (is_mls) {
>                         key_word =3D "mlsconstrain";
> @@ -1775,6 +1781,11 @@ static char *avtab_node_to_str(struct policydb *pd=
b, avtab_key_t *key, avtab_dat
>                         ERR(NULL, "Failed to generate permission string")=
;
>                         goto exit;
>                 }
> +               if (*perms =3D=3D '\0') {
> +                       ERR(NULL, "No permisisons in permission string");
> +                       free(perms);
> +                       goto exit;
> +               }
>                 rule =3D create_str("(%s %s %s (%s (%s)))",
>                                   flavor, src, tgt, class, perms+1);
>                 free(perms);
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
> index 956fb6e8..5860a513 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -297,6 +297,12 @@ static int class_constraint_rules_to_strs(struct pol=
icydb *pdb, char *classkey,
>                         rc =3D -1;
>                         goto exit;
>                 }
> +               if (*perms =3D=3D '\0') {
> +                       ERR(NULL, "No permisisons in permission string");
> +                       free(perms);
> +                       rc =3D -1;
> +                       goto exit;
> +               }
>                 if (strchr(perms, ' ')) {
>                         perm_prefix =3D "{ ";
>                         perm_suffix =3D " }";
> @@ -1741,6 +1747,11 @@ static char *avtab_node_to_str(struct policydb *pd=
b, avtab_key_t *key, avtab_dat
>                         ERR(NULL, "Failed to generate permission string")=
;
>                         goto exit;
>                 }
> +               if (*permstring =3D=3D '\0') {
> +                       ERR(NULL, "No permisisons in permission string");
> +                       free(permstring);
> +                       goto exit;
> +               }
>                 rule =3D create_str("%s %s %s:%s { %s };",
>                                   flavor, src, tgt, class, permstring+1);
>                 free(permstring);
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 6699a46b..3b3480bf 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -593,6 +593,12 @@ static int avrule_to_cil(int indent, struct policydb=
 *pdb, uint32_t type, const
>                                 rc =3D -1;
>                                 goto exit;
>                         }
> +                       if (*perms =3D=3D '\0') {
> +                               ERR(NULL, "No permissions in permission s=
tring");
> +                               free(perms);
> +                               rc =3D -1;
> +                               goto exit;
> +                       }
>                         cil_println(indent, "(%s %s %s (%s (%s)))",
>                                         rule, src, tgt,
>                                         pdb->p_class_val_to_name[classper=
m->tclass - 1],
> @@ -1973,6 +1979,12 @@ static int constraints_to_cil(int indent, struct p=
olicydb *pdb, char *classkey,
>                                 rc =3D -1;
>                                 goto exit;
>                         }
> +                       if (*perms =3D=3D '\0') {
> +                               ERR(NULL, "No permissions in permission s=
tring");
> +                               free(perms);
> +                               rc =3D -1;
> +                               goto exit;
> +                       }
>                         cil_println(indent, "(%sconstrain (%s (%s)) %s)",=
 mls, classkey, perms + 1, expr);
>                         free(perms);
>                 } else {
> --
> 2.44.0
>
