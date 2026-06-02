Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA6237204A
	for <selinux@vger.kernel.org>; Tue,  2 Jun 2026 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418506; cv=pass; b=P8jes7SrgQV1daZQM7Czcxr6vN22oonpylsr69FbTm8SGL5qAFVETxURNMS+QInp/eimQxsiDeH7JAvMADzSBMpWyIsuGtHaMTfsCrizShkyy/MG/SxtGG9wvuneo7188Ob0Wn0lYPtBPech4SnWTn1JdUMt5SPMK3LSsfAFYY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418506; c=relaxed/simple;
	bh=qFNSkyWTUXAmkmgrgLSkj5HeS/GlaRvUFx44uuoldAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cAZbsNwXDSw3Qby936fiigu/DruzSiy4W1aVQ2M2mB8912EfsIZcb91BAtrUdL1PovWsJr0pcUpareJQetGRqsWEeJubWWJ4o3Om/IcemlO8XIRjHd1FukQubwpPryy2fTsrwJ/B/tbgjg74le6uWMqeICJTvuiT72dsxqKJmg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rEgkje9a; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEgkje9a"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36d98b68d68so1879407a91.2
        for <selinux@vger.kernel.org>; Tue, 02 Jun 2026 09:41:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780418504; cv=none;
        d=google.com; s=arc-20240605;
        b=IaG/QUwrkgL+SMQjq1XUAeCKN0S4KLmvQYmwahqFp3hyumRZYWiRRl1BeNY2KPp10b
         pnZc52CZRvUK+3QoQvVKnk2hE4DrI7FSMCeTeL2My2SgpdzLBl9oPUijyair1c8glWYu
         vqLabi3pU0W+bKwHtbHx6p59wfn/olroCFfVHMnyZWAqN1R81Fw6OQOMR1DEr3hvp6BG
         RZC8iSr6UShcXW8YV887GqsOr7HbJYvyHYIkdzYJPI1B+X0AqDrYXplOdsTDRyJW46jb
         THFQVxOXAC0/aPkUGxzXsLqzpq5d8A8bHPEvLZfzSoNkJHaaIVqq69ERSVil9R+6AB26
         Kb8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RYk1kq8ayB1SnLE0sBXZ+gAfKz83o3hwqF//XjpBM18=;
        fh=ZRedc575flThWjp0FOeY4xu8TVTKDyGyGDcFPwDIv+A=;
        b=UVAZDuouLsaCm2IwOfiAcnH3iagX4H8T4x4AFw5zGVlkNv0skAyl34tFcts90EsMwJ
         MDUbuiHwMorw9/lzTYlRrO8/NJhZWdX8rB1PNGefCNl5t0SsaItLqUFiLZZrBkeYqeaT
         kzfoqdR+0uuRBUqP6sNrbZLefqedT4CfRyogq+qPsfbHBjsq5n2fhc0iHBPKzEgC7lnG
         dqNURa1d+//wwxAar1aerbAOEPCnGPyqZHn7rXFjbjPeUytCPNRWosl8QJtEYlMgMWRZ
         pHYFMf2aPgb1xSIDxnXFR0y/npouwgSxuM2Kp8XuwbWvi1pI7yoAqmRDwk97HtKTwLlo
         8L3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780418504; x=1781023304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYk1kq8ayB1SnLE0sBXZ+gAfKz83o3hwqF//XjpBM18=;
        b=rEgkje9aMcnSwq0tsuCsFSMqyn99+XI9DSzTNkJjoMJ7d87PxIRE3oEWnJcTMWRfmy
         4hWbo7bBUdaWHIeBTCLMIg7o4EttVEhtngdApDP7jlC7lszjmzIkkfJ/bDJLE4A8WDqM
         oo230dkQ5EDFmF4wFKMSEUMdBcGGhBedhVSxmmOqResSK0r5WY1C1fT+6dfhwJFtwHS3
         /fzsRZF/6CJ5TeyGhEmZfEdlpgPYqRD46QAti7Jz+wpkG/5r3ZeYZAp1bTCiiI43bJOd
         oIaz7q6XW8g7OlrIugFfkMls80I03yXyn+t2uJ+H7A8Bzs4+a13GCzluMnCxsKzGe3cF
         2hzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780418504; x=1781023304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RYk1kq8ayB1SnLE0sBXZ+gAfKz83o3hwqF//XjpBM18=;
        b=YDcnqc5IGaB2vfpLUppifVrm/q8BpPWU9CM0nEYeVX+kaZqEzXWi7eTQ99ftjSRb4Z
         YIucZeoVU+3p0sX9jsebUsUHmpYB9gzxH2wxxqRTFjbu9o2pj5kvP8x+Y7mq+LV3L3S4
         4aQ+lP7QqUZygMlVHwThoGx59paXYHwmgXje3bP6tWSkvFG5N3v2dB08dmmqiyPFR6MK
         Zf05qQ83HyqCijsrqAZIinppP1kB/m67Wf8llDE+ENo0rCL5jGZv0+sFyV84N9/AwkUG
         slSLmfZEFZnNDS18CQmiowYLDVexhJsBIBmqyrjAgeQ0/4RlUm8drTsY5RUCFk8OwfY+
         xWXQ==
X-Gm-Message-State: AOJu0YwJX+PVsBnANYV5ZpFV1WHn7pBQ2Txa6RDtNLTZZXwkZTT2kCt1
	mEM8ivdthIV02nfb6x6ri/w/Dt3q/UQeE98akadZc6WbZ+QE1VTZI8tZkDHbmq2zZMYK/8/KwVu
	7AXwRbgZxvAt4VeMicO7sRERf4jwLX3o=
X-Gm-Gg: Acq92OHUhhts6wz+M5i5iMUEAH3oYaOhR+7F5k1suq0EdGslrP35qCc6I06ZXzmIxgV
	gv3pOf8yftnIPmZRlh5O0Q+aqtG0eFPNL779GVZIzU6w59vdNlIzbEsWVSy1N0nL8LAdGgcbAvm
	7rTD446Dhcaq4Gk84nDKOAQvjphLMTKAY6WZx8agMTipX+zLcIKD5NKEk0ip/9hLqSWbduW+g0n
	zZMpaMg6QT1+Ht1iW2NOJSGzG2Mc8TcPGxQ7Wi6NKHapBZnXIvMAtbUEFRypZ+TBnYFA28zndxR
	RACET9/WIPlETek++XGTl2iIaI3i
X-Received: by 2002:a17:90b:1d84:b0:36b:7725:defd with SMTP id
 98e67ed59e1d1-36c2ebaf38amr15663002a91.0.1780418503720; Tue, 02 Jun 2026
 09:41:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602153309.157348-1-jwcart2@gmail.com> <20260602153309.157348-2-jwcart2@gmail.com>
In-Reply-To: <20260602153309.157348-2-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 2 Jun 2026 12:41:32 -0400
X-Gm-Features: AVHnY4I-HJbnqtBsOkV_nmQQ3eUyc7s5GvwHf4dJzOz6zXquAXthx913G9zjgPs
Message-ID: <CAEjxPJ4=AfO0J0=mwyZ9y6LfvGp3+c7k7FmLp-7PYZgofRK5AQ@mail.gmail.com>
Subject: Re: [PATCH 2/3 v4] libsepol: Add a function to output CIL
 declarations from a binary policy
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, tweek@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 11:33=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> Add the function sepol_kernel_policydb_decls_to_cil() that takes a
> binary policy as input and outputs the declarations in CIL format.
>
> Also move the checks for a supported policy to a new common function
> and use that function in kernel_to_conf and kernel_to_cil.
>
> In the near-term this will be used get the declarations from a
> policydb so they can be used along with neverallows written in CIL
> to check for neverallow and neverallowx violations in the binary policy.
>
> Suggested-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by; Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> v4: Don't delete the Python swig exception stuff like an idiot
> v3: Split out less common functionality to keep the same order for the ru=
les
>     to prevent breaking existing tests (even though CIL is not dependent =
on
>     order.)
> v2: Added more explanation to the commit msg
>     Split out common functionality
>  libsepol/include/sepol/kernel_to_cil.h |  3 +-
>  libsepol/src/kernel_to_cil.c           | 97 +++++++++++++++++++-------
>  libsepol/src/kernel_to_common.c        | 26 +++++++
>  libsepol/src/kernel_to_common.h        |  2 +
>  libsepol/src/kernel_to_conf.c          | 29 ++------
>  libsepol/src/libsepol.map.in           |  1 +
>  6 files changed, 109 insertions(+), 49 deletions(-)
>
> diff --git a/libsepol/include/sepol/kernel_to_cil.h b/libsepol/include/se=
pol/kernel_to_cil.h
> index 60346ad1..1db0383a 100644
> --- a/libsepol/include/sepol/kernel_to_cil.h
> +++ b/libsepol/include/sepol/kernel_to_cil.h
> @@ -2,4 +2,5 @@
>
>  #include <sepol/policydb/policydb.h>
>
> -int sepol_kernel_policydb_to_cil(FILE *fp, struct policydb *pdb);
> +int sepol_kernel_policydb_to_cil(FILE *out, struct policydb *pdb);
> +int sepol_kernel_policydb_decls_to_cil(FILE *out, struct policydb *pdb);
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index 49040ae4..db63ac3f 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -3262,6 +3262,11 @@ int sepol_kernel_policydb_to_cil(FILE *out, struct=
 policydb *pdb)
>         struct strs *non_mls_validatetrans =3D NULL;
>         int rc =3D 0;
>
> +       rc =3D check_for_supported_policy(pdb);
> +       if (rc !=3D 0) {
> +               return rc;
> +       }
> +
>         rc =3D strs_init(&mls_constraints, 32);
>         if (rc !=3D 0) {
>                 goto exit;
> @@ -3282,30 +3287,6 @@ int sepol_kernel_policydb_to_cil(FILE *out, struct=
 policydb *pdb)
>                 goto exit;
>         }
>
> -       if (pdb =3D=3D NULL) {
> -               ERR(NULL, "No policy");
> -               rc =3D -1;
> -               goto exit;
> -       }
> -
> -       if (pdb->policy_type !=3D SEPOL_POLICY_KERN) {
> -               ERR(NULL, "Policy is not a kernel policy");
> -               rc =3D -1;
> -               goto exit;
> -       }
> -
> -       if (pdb->policyvers >=3D POLICYDB_VERSION_AVTAB && pdb->policyver=
s <=3D POLICYDB_VERSION_PERMISSIVE) {
> -               /*
> -                * For policy versions between 20 and 23, attributes exis=
t in the policy,
> -                * but only in the type_attr_map. This means that there a=
re gaps in both
> -                * the type_val_to_struct and p_type_val_to_name arrays a=
nd policy rules
> -                * can refer to those gaps.
> -                */
> -               ERR(NULL, "Writing policy versions between 20 and 23 as C=
IL is not supported");
> -               rc =3D -1;
> -               goto exit;
> -       }
> -
>         rc =3D constraint_rules_to_strs(pdb, mls_constraints, non_mls_con=
straints);
>         if (rc !=3D 0) {
>                 goto exit;
> @@ -3533,3 +3514,71 @@ exit:
>
>         return rc;
>  }
> +
> +int sepol_kernel_policydb_decls_to_cil(FILE *out, struct policydb *pdb)
> +{
> +       int rc =3D 0;
> +
> +       rc =3D check_for_supported_policy(pdb);
> +       if (rc !=3D 0) {
> +               return rc;
> +       }
> +
> +       rc =3D write_sid_decl_rules_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       rc =3D write_class_decl_rules_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       rc =3D write_mls_rules_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       rc =3D write_boolean_decl_rules_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       rc =3D write_type_decl_rules_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       rc =3D write_type_alias_rules_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       rc =3D write_type_attributes_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       rc =3D write_type_attribute_sets_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       rc =3D write_role_decl_rules_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       rc =3D write_role_attributes_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       rc =3D write_user_decl_rules_to_cil(out, pdb);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +exit:
> +       return rc;
> +}
> diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_com=
mon.c
> index 99e46865..b267b5d7 100644
> --- a/libsepol/src/kernel_to_common.c
> +++ b/libsepol/src/kernel_to_common.c
> @@ -751,3 +751,29 @@ exit:
>
>         return rc;
>  }
> +
> +int check_for_supported_policy(struct policydb *pdb)
> +{
> +       if (pdb =3D=3D NULL) {
> +               ERR(NULL, "No policy");
> +               return -1;
> +       }
> +
> +       if (pdb->policy_type !=3D SEPOL_POLICY_KERN) {
> +               ERR(NULL, "Policy is not a kernel policy");
> +               return -1;
> +       }
> +
> +       if (pdb->policyvers >=3D POLICYDB_VERSION_AVTAB && pdb->policyver=
s <=3D POLICYDB_VERSION_PERMISSIVE) {
> +               /*
> +                * For policy versions between 20 and 23, attributes exis=
t in the policy,
> +                * but only in the type_attr_map. This means that there a=
re gaps in both
> +                * the type_val_to_struct and p_type_val_to_name arrays a=
nd policy rules
> +                * can refer to those gaps.
> +                */
> +               ERR(NULL, "Writing out CIL or policy.conf from policy ver=
sions between 20 and 23 is not supported");
> +               return -1;
> +       }
> +
> +       return 0;
> +}
> diff --git a/libsepol/src/kernel_to_common.h b/libsepol/src/kernel_to_com=
mon.h
> index d3283658..53f398b7 100644
> --- a/libsepol/src/kernel_to_common.h
> +++ b/libsepol/src/kernel_to_common.h
> @@ -117,3 +117,5 @@ int strs_stack_empty(const struct strs *stack);
>
>  struct strs *isids_to_strs(const char *const *sid_to_str, unsigned num_s=
ids, struct ocontext *isids);
>  int sort_ocontexts(struct policydb *pdb);
> +
> +int check_for_supported_policy(struct policydb *pdb);
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
> index a8126d58..628a792e 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -3116,6 +3116,11 @@ int sepol_kernel_policydb_to_conf(FILE *out, struc=
t policydb *pdb)
>         struct strs *non_mls_validatetrans =3D NULL;
>         int rc =3D 0;
>
> +       rc =3D check_for_supported_policy(pdb);
> +       if (rc !=3D 0) {
> +               return rc;
> +       }
> +
>         rc =3D strs_init(&mls_constraints, 32);
>         if (rc !=3D 0) {
>                 goto exit;
> @@ -3136,30 +3141,6 @@ int sepol_kernel_policydb_to_conf(FILE *out, struc=
t policydb *pdb)
>                 goto exit;
>         }
>
> -       if (pdb =3D=3D NULL) {
> -               ERR(NULL, "No policy");
> -               rc =3D -1;
> -               goto exit;
> -       }
> -
> -       if (pdb->policy_type !=3D SEPOL_POLICY_KERN) {
> -               ERR(NULL, "Policy is not a kernel policy");
> -               rc =3D -1;
> -               goto exit;
> -       }
> -
> -       if (pdb->policyvers >=3D POLICYDB_VERSION_AVTAB && pdb->policyver=
s <=3D POLICYDB_VERSION_PERMISSIVE) {
> -               /*
> -                * For policy versions between 20 and 23, attributes exis=
t in the policy,
> -                * but only in the type_attr_map. This means that there a=
re gaps in both
> -                * the type_val_to_struct and p_type_val_to_name arrays a=
nd policy rules
> -                * can refer to those gaps.
> -                */
> -               ERR(NULL, "Writing policy versions between 20 and 23 as a=
 policy.conf is not supported");
> -               rc =3D -1;
> -               goto exit;
> -       }
> -
>         rc =3D constraint_rules_to_strs(pdb, mls_constraints, non_mls_con=
straints);
>         if (rc !=3D 0) {
>                 goto exit;
> diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
> index 2b103993..8785cff1 100644
> --- a/libsepol/src/libsepol.map.in
> +++ b/libsepol/src/libsepol.map.in
> @@ -297,5 +297,6 @@ LIBSEPOL_3.6 {
>
>  LIBSEPOL_3.11 {
>    global:
> +       sepol_kernel_policydb_decls_to_cil;
>         cil_check_neverallows_against_pdb;
>  } LIBSEPOL_3.6;
> --
> 2.54.0
>
