Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D290C320CD3
	for <selinux@vger.kernel.org>; Tue,  2 Jun 2026 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780423836; cv=pass; b=QxH8Qu+xYqG/9F8ltCd0CiproifUQ0fcLCMGl6hHRTtY79/hLdCWaS5jSh1lzYFXX3S0zLnQsC9iFC3VRDGvxyQ2KTi/f7nm7AV7oHqkujUx1u4EWISBmBHxb8eYTgU2UK6pi30X4wVtG969BIE8JeN176PYR/7F6FabqnLbWR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780423836; c=relaxed/simple;
	bh=mwCjl/FTVYBxtAon4LFN5gKlL740eUf7KX8AseVQGow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LhErYDZ3W6x65qKVBM7yfJt1UfpjtDnJBqzEZNLh6Iexqe0R9HyWm1UDYhTY6olQ4+6dW2YXmHC8/U7MxcQ+FOkoUaEODOGFflvEAmlHs8808D0RtqfsHTWYlp2qitzqWr6kvo0uGo1dJFm4Qz4exx49zLvwkuDDOZBcBuq273c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/gnbw95; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/gnbw95"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8423f1d8902so1127232b3a.1
        for <selinux@vger.kernel.org>; Tue, 02 Jun 2026 11:10:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780423834; cv=none;
        d=google.com; s=arc-20240605;
        b=UFmrlKE0nmAskkUr+Eb6iUnb9wU6Jlag8xl6IPik9CJMOWt2bo/HrYcCyjvYss8Tom
         468+JVMfNYy5pjDnaGky+gZGbu/bZbg+tMm95W6feSd/A+E6w8r5rtIF3+u/XllOTi+c
         xQ3+qfbGSMQXpLUWAxyTuPFa/tWCb+fG+eOlYQ4LU+yR9LM0JYGBSxqOA2OVFoIZ7vAX
         2LR2vLPowlyIOcZAmyz9PzUV75GZ9wd1VY4qIdrtVwrpc7ivTTQ/yuE7VZhpO8riSxMq
         uWcfRUjmU3ivQqRoEKajkzykW2kH97KoxOOHqAPyDJBJ7sP7RwnHP9ppmgrgQ5shf/cn
         Sluw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=al9Z0kR8yuVJjxKIhJY0XH/4VkxlJFVQvIDonr42D+g=;
        fh=ZRedc575flThWjp0FOeY4xu8TVTKDyGyGDcFPwDIv+A=;
        b=kfzH175U7VXxKS5E1nle/Hz0LVTToo0wgGj8mgYPQdgsQ/WGrat4/zATbwAyLmB+Jz
         wy8CByBxUmVs80hNKtOnEcagm4ZVBG/kNhDiX+NOiW6zytyfLGT5E50+ZKkTwnulGAX3
         D2K42CJMBXpfUv563hcFUPjjFNSHUVj0XrZZ8LTntk8N0TAJxlytMinsoBszHuZhiVHg
         nIQKp0jfP+drSg98gJyE8utsqAVyLrJlj79vaZ4mg4cIu6JTtRxgF4qZSoc6R9l6KOhZ
         nqpvJw8tprpxBHyraJ8ZgdcE4WF4cI147GIBXUzejSj5SaErLW1kb4sVQZTlIjo0SC6E
         B74g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780423834; x=1781028634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=al9Z0kR8yuVJjxKIhJY0XH/4VkxlJFVQvIDonr42D+g=;
        b=L/gnbw95zMSjMYBYM0cx0Ln6b3yqpB4fvYqvkPYIYp1Km9eQQLagYPx1QY51vnIL5Q
         a7rliA10KCSBFzti86ScvOUYToXEDI4Mza/QNxD/IwgSfa7Wn0rorTWqe/CvQ/IH5F24
         +LM5NK4t139hwAdBtnE9HrNrdojshhjrVNKA0sUlPVfuBv3YBLUHu7DFgcBVHTsQ5epr
         tzMJitqttNbcbbRt1OuT9n+V9gJX3LExKwW6cRaPYIvhC9QQREMrH5pYUa6g/BtQCyhz
         ESh4YCSLaAcIu65QvD6PSQe648FUfcl+YihmGRC7BpyMLGwLj0d6oLdmOI8Ty3s5sT5b
         NaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780423834; x=1781028634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=al9Z0kR8yuVJjxKIhJY0XH/4VkxlJFVQvIDonr42D+g=;
        b=irgatL1odFy4LKXiZ8v610RrkOsiMyACUNzLy466qy3Dzq5vUo2LvxFNggmoyV4x0I
         5o73ihP1Igbl+AqyAbvn6y8EiI1GoE0CCuSVG53hB4E14i6PSgqHngOIb81iFDERDQlR
         LgW0YMr5eTxWZ4s2wCz+WvcsrclmraXbooPJoChZf7tBm4LK7IlipnvVVXUDcPBHxJbH
         d4fa8oBr7qClIQ1IH8wR5ebOdyV3v2KR3RwnBgOkeEmINovPquwFcczYdY3cGIXUCDnG
         jBSp/xDsTM5SHlkKK4uCmSMlMQSwJiijQDySr2u12q6g83/wv7+VtijGP+RvsXs3mOOg
         QKYA==
X-Gm-Message-State: AOJu0Yzf7WKH3Zz2hRU0Taf5xcgO9lqb7W6qQkpFhKBUU5EgehjFfM/V
	R8uI14skdg6c0gDV03DfKLBaoTsi8GTKGhiiOmqOE7zpxoJ4YKwwAgZovxcpV4XNuZDlK1N9g1G
	Hppwg2hBAVxpFbi7GRTzoyncL6YSwbrg=
X-Gm-Gg: Acq92OFMQNe5KyQSMZs94QmsCumLIXhJ0xGDNaMgfVKHyWDNxT8Fi0AFN3nrsL+OFTv
	dzWqWeblPS5gwayOnm4N7uzzhRUvNMdW5IcA2B/HOHtRx/EAIKdEDHZTYcmCQPhNdSxSzt3zAG2
	JO99Zh4Htk92rg4isFllOQSkgT7VvHa3GVkpTDllqATwVcvK8PxufW1v1qrdZKs2wocbR93lB7T
	16/9U6ho+X7wXmLV/oepoL2at7HRq0QoIpjpD334aZcciPQHd923m+L2/hbYTO7GKEKqQFXM7nS
	ZEkPs5OYNvuJ/lbH3kE2Vxaca5E+
X-Received: by 2002:a05:6a00:b45:b0:842:678a:a7dc with SMTP id
 d2e1a72fcca58-84284e3668fmr44014b3a.2.1780423834052; Tue, 02 Jun 2026
 11:10:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602153309.157348-1-jwcart2@gmail.com> <20260602153309.157348-2-jwcart2@gmail.com>
In-Reply-To: <20260602153309.157348-2-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 2 Jun 2026 14:10:23 -0400
X-Gm-Features: AVHnY4JZQ7t1YCswhP-lgNGMXhcBH891Mm9ccAJKvDDcvNbwUR9dy5yBf7zua_E
Message-ID: <CAEjxPJ6P29Fk1f2-wQrB5L82SbLNzgxa+B3oStY+LKxk1amV0w@mail.gmail.com>
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

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

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
