Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF202877DE
	for <selinux@vger.kernel.org>; Mon, 27 Apr 2026 20:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777320721; cv=pass; b=pWgHl6g4x737oMbPI4YBRwYFwI3CoMvtnIWbJIuJ8b01HUoXVEgsCt87BBDLGLziDr5b7Xn9nSfso7Fotme5nSJOJ2ZeR+O2tedukoBh5t0xus219MwyuhulNJcd07zz4btxztjR3GNJAb6ryYSflAOutAy8OALhBkC8Fcay7Ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777320721; c=relaxed/simple;
	bh=/gZOE45mbL0DmWFyT5/Sj2dZkBCDI9HdOzREcz0Nidg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ld75oqb4J/YbFwG6Oq5I1+eDx1Es3/KeFmkBtWZdL7FwzoZgVGS56nOhCDO0Kd3RgvFgU6MIzOh17tweqBZVdxjomwhLDGEo5GAtOQ3Lj8HclTnbl1BGs2fWvygAK/UmKQumNTM5ymr7wlW26WJ1MiIOLSE9sb1Pj2CVZfA6iTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qZFl65KT; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZFl65KT"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38eab6cf7d8so101303131fa.1
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2026 13:11:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777320717; cv=none;
        d=google.com; s=arc-20240605;
        b=HipGEurFUpK6BKt8HvNadu/oXWrmL0MyC0X/KSEGLb03+jViEULFCNOk3H3OMUQon9
         mXxgN9Ha4f4s9Mah+wa8+vvuQC3koRgfIqfNRHBrsS6CZ9yiEUbWnE+yh2bOS/7zdd5s
         piFazwv5IHOMee+uWkk3OHrYCyrgV6yvH7F4eIx8WNLWhD0rvAEZdD17UGAKzDMolfjh
         B1U1hcjLI4KbE94lZl7NVPQOu26xYiu+ROjMeh0XM2BBs3pvE9IVmqYVCGo0cl3pkpaw
         oZvM4jEBg/Ul9QI1+QBAM11LRE2BsEnleXXi+swq0tsAHYPDImXphdFsjBn5vfmuNCHT
         1FaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OHuEHeOI9kh0GNWLXqzOZ9zpeiOuQYnm26jJnMLRRRo=;
        fh=r3J4a89fSqNfDYqNBLS7nK1BDXjaLdXvlvWKd/S9wzw=;
        b=DjMOJgwNDFPf7mXlBIC/4p+qXIfKFxdo2bnlZG1bpR2tBpPJXoi4FpQ8quTJJaRXHi
         t+00uxBRfiyEVlYavSLvbzgkVl5I3KTlIcwCb5mEjHTrqQVSgrGKe/BdMvg47mWUV0YJ
         /L33Ja6MkeIycbGTJvW/aO44R8M1FdrDwgFz7KYxEJVetnWxpHServ4J5Q3smCULv2FJ
         yxsLtAEslOqIAh1qgkrKZu22NhPJGLT9XlZdx7UEkd/FXC7rqC/TH42uI+DhYJWhqrfw
         yHj4zZdLmf001Wc2LNScWAlGFrz37MLJmh/rPJCc1M/OHxKSeNwT2EexQ/gO/Qw14w75
         byeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777320717; x=1777925517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHuEHeOI9kh0GNWLXqzOZ9zpeiOuQYnm26jJnMLRRRo=;
        b=qZFl65KT7cMOb/yBMDMN/RCxgatcT1GB8mDo+QMmdHVm3FESqSYqVhLeQKpjCFi3Ap
         2iuSY9SK5iMckecLL9oHyqp2Pmn/nCKFnc+CiUMfABofnzjiVg7DdRhhhkfD2QruPtXS
         4kuU4QJrLI0FHjh18nVh4tjWWDQoKJ02eGw4f1Km1x8lrFB1UDCyBVfuRnBc/OdOTViw
         SmB0vYw1tcmjvxF9jnCvP4SwYI5xVxQ2IaNaLAPP/OR1jfRkjtOePCRbLj0IT1pi0ZCm
         1Sa8woEPYfWPgiQ8Phhv/tbOCxWY2XoPboraZiB98waIjyXnopE2z3tFa9RG8Rlzj0V0
         bRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777320717; x=1777925517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OHuEHeOI9kh0GNWLXqzOZ9zpeiOuQYnm26jJnMLRRRo=;
        b=Jy407l10noVsImHOkResHc+pB9jSKZvGM+pIREWQex6ug/lMyARqbSL0lNltimtOVN
         EyruoGBmeMo6n+cTpZcPthmzZXo4BgPDYGJv2MVHJqScKj0Dxyx81/f+Btf73TLisdFn
         kAwhadY0MAHk0O8b/aLymtMggIngUDMe2kVEo0+V3z3I5u8glcWHxcVUpwg/d/oOA4XL
         DuCY2jYbwdjTo2HAM4J7o9IS+lgo4iWvMhTrhCE/YRbvZtDmDWMZsExf8F336s346koE
         JVhPG8iVMxxLZVUFdKn3ogxLeYU9u26UFE4l1jgzrR30ByMKlrHM+Hcq/npC/VO1I6JZ
         +pxw==
X-Gm-Message-State: AOJu0YxjPDL2daSF53BtfwJmO38hoPqanjuoE9FWfQx9vlJLZs0ilCnY
	cBqFyWm35gz3Snx71I6QfY7oPW41+HFyXanfl+kLpxn8/CVKwYn1PvIsiUuDtpsIyFdv9McM2Vu
	6D69hUlle5+2Jw7IuxoAGRqE9ZKN7gzw=
X-Gm-Gg: AeBDiesTo2Umg+rrgYivmm9M+q9DopFBJBRudQKBLC9+pbH5VPHcY4bsDW8p1Fe9+n9
	imc2JoLq+LkkBV/cgFSoyGt6Ku9h+zxZcsvf2uBEXDtAyRDHGwAkKDlYo+RhpuTKSgZ55OT3D1P
	ZRABfj9RgD3qG7UPlxqndMphNEqPLhNlzf4I+fRIvvlKSQxGEWQJEBixSYnYL62fk8pKTFZZnJL
	VZAaVe4k6puBIAWL1hYUlUJh3JTsjD0unQENmk4OWxJXWWNZpm5DpZfQjdcVSOMWZacrjMGxrp/
	MrNH+DDEGJEbmV8=
X-Received: by 2002:a05:651c:41c7:b0:38c:d92e:c7ca with SMTP id
 38308e7fff4ca-39240b2845dmr107621fa.0.1777320716318; Mon, 27 Apr 2026
 13:11:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401051651.3639709-1-tweek@google.com>
In-Reply-To: <20260401051651.3639709-1-tweek@google.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 27 Apr 2026 16:11:44 -0400
X-Gm-Features: AVHnY4I0gFu_PPfteHVkgFoCYNLfQLr33jZE-_1EvywDUX02oNtMbzwVJbNq5RI
Message-ID: <CAP+JOzTMYcDF=z3mC2Avtd2vPQw2imLp8fi0HictTSW+7eUKKA@mail.gmail.com>
Subject: Re: [RFC PATCH] libsepol: Add support for checking standalone CIL
 neverallow rules
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: selinux@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 1:16=E2=80=AFAM Thi=C3=A9baud Weksteen <tweek@google=
.com> wrote:
>
> This commit refactors the CIL part of libsepol to support validating
> standalone "neverallow" assertions provided in CIL format against an
> existing binary policy.
>
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Android has the requirement of validating various policies from partners
> against the standard AOSP assertions. While this is done at build time,
> we also enforce this requirement during certification via the
> Compatibility Test Suite.
>
> Until now, this validation was implemented by manually parsing the
> neverallow assertions [1]. This approach is brittle and limited (we
> currently do not support neverallowxperm assertions).
>
> Design idea
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> An idea is to reuse the existing parsing in libsepol/cil to parse the
> assertions. However, the current API forces the policy to be complete
> before being able to run the verification. That is, all the symbols
> referred to in the assertions must already be defined.
>
> To solve this issue, the implementation idea of this patch is to attach
> an existing kernel policy to the incomplete cil_db_t. This existing
> policy is considered a "fallback" policy. When compiling the cil_db_t if
> any type, attribute, class or permission is unknown, it is pulled in
> from the fallback policy.
>
> An alternative option to this patch is to (1) use checkpolicy to
> translate a binary policy into its CIL format; (2) append neverallow
> assertions to the CIL policy and (3) rebuild the complete policy. While
> this reuses the current tools and API, this requires a lot of
> unnecessary translation.
>
> Implementation changes
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - Lazy Symbol Import: Modified cil_resolve_ast.c to support a "fallback
>   policy". If a symbol (type, attribute, class, or permission) is not
>   found in the CIL database during resolution, it now searches a provided
>   policydb_t. When found, it dynamically creates CIL datums and inserts
>   them into the AST, allowing compilation to proceed without requiring
>   the full source policy in CIL format.
> - Lazy Attribute Resolution: Updated cil_binary.c to correctly handle
>   imported attributes by utilizing their bitmask from the binary policy
>   when they have no explicit members in CIL.
> - New Public API: Introduced cil_compile_against and
>   cil_check_neverallows_assertions. These functions allow a caller to
>   set a fallback binary policy for compilation and then run neverallow
>   validation against it.
> - Validation Utility: Added a new utility cil_neverallow_check in
>   libsepol/utils to facilitate testing and validation of this new API.
>
> Feedback
> =3D=3D=3D=3D=3D=3D=3D=3D
> This is an RFC and I am looking for feedback on the idea. If a similar
> tool can be written without having to increase the API, please let me
> know.
>
> I don't know if these new functions (cil_compile_against and
> cil_check_neverallows_assertions) are sufficient or how they could be
> improved. Could they be made more generic to cover similar use cases?
>
> If the approach seems sensible, more work is likely needed to support
> users, roles and others objects. Please let me know what you think is
> missing here.

We definitely want to support your use-case and I think that this is
an interesting approach, but I am a bit worried about adding special
cases when resolving things.

I sent an RFC to the list of a different approach which I think will
work for you. If we add a function in the CIL library to check a given
policy binary with neverallows pulled from a CIL db, and we add the
ability to output the declarations from a binary policy to CIL
(instead of the whole policy), then we can compile the declarations
and neverallows rules as a CIL policy, extract the neverallow rules,
and check them against the binary policy. The individual parts are
simple, it will just use the normal functions to compile (but not
build a binary), and then use the normal neverallow checking.

Let me know what you think.

Jim

>
> [1] https://cs.android.com/android/platform/superproject/+/android-latest=
-release:system/sepolicy/tools/sepolicy-analyze/neverallow.c
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> ---
>  libsepol/cil/include/cil/cil.h        |  16 ++++
>  libsepol/cil/src/cil.c                |  68 +++++++++++++++++
>  libsepol/cil/src/cil_binary.c         |  15 +++-
>  libsepol/cil/src/cil_binary.h         |  24 ++++++
>  libsepol/cil/src/cil_internal.h       |   1 +
>  libsepol/cil/src/cil_resolve_ast.c    | 102 +++++++++++++++++++++++--
>  libsepol/src/libsepol.map.in          |   4 +-
>  libsepol/utils/Makefile               |   2 +-
>  libsepol/utils/cil_neverallow_check.c | 103 ++++++++++++++++++++++++++
>  9 files changed, 324 insertions(+), 11 deletions(-)
>  create mode 100644 libsepol/utils/cil_neverallow_check.c
>
> diff --git a/libsepol/cil/include/cil/cil.h b/libsepol/cil/include/cil/ci=
l.h
> index 88e47e79..51a999b9 100644
> --- a/libsepol/cil/include/cil/cil.h
> +++ b/libsepol/cil/include/cil/cil.h
> @@ -81,6 +81,22 @@ extern void cil_log(enum cil_log_level lvl, const char=
 *msg, ...);
>
>  extern void cil_set_malloc_error_handler(void (*handler)(void));
>
> +/*
> + * Compile a partial policy (db), importing types, attributes,
> + * classes and permissions from sepol_db if not found.
> + */
> +extern int cil_compile_against(cil_db_t *db, sepol_policydb_t *sepol_db)=
;
> +
> +/*
> + * Validate neverallow assertions in a policy.
> + *
> + * This step is usually performed implicitly within cil_build_policydb.
> + * However, there might be some interest in validating these assertions
> + * without a full build.
> + */
> +extern int cil_check_neverallows_assertions(cil_db_t *db);
> +
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> index 9662cf45..b323f144 100644
> --- a/libsepol/cil/src/cil.c
> +++ b/libsepol/cil/src/cil.c
> @@ -467,6 +467,7 @@ void cil_db_init(struct cil_db **db)
>         (*db)->qualified_names =3D CIL_FALSE;
>         (*db)->target_platform =3D SEPOL_TARGET_SELINUX;
>         (*db)->policy_version =3D POLICYDB_VERSION_MAX;
> +       (*db)->fallback_pdb =3D NULL;
>  }
>
>  static void cil_declared_strings_list_destroy(struct cil_list **strings)
> @@ -3001,3 +3002,70 @@ void cil_src_info_init(struct cil_src_info **info)
>         (*info)->hll_line =3D 0;
>         (*info)->path =3D NULL;
>  }
> +
> +struct cil_check_neverallow_args {
> +       const struct cil_db *db;
> +       policydb_t *pdb;
> +       int violation;
> +};
> +
> +static int __cil_check_neverallow_helper(struct cil_tree_node *node, uin=
t32_t *finished __attribute__((unused)), void *extra_args)
> +{
> +       struct cil_check_neverallow_args *args =3D extra_args;
> +       int rc =3D SEPOL_OK;
> +
> +       if (node->flavor =3D=3D CIL_AVRULE) {
> +               struct cil_avrule *rule =3D node->data;
> +               if (rule->rule_kind =3D=3D CIL_AVRULE_NEVERALLOW) {
> +                       int violation =3D CIL_FALSE;
> +                       rc =3D cil_check_neverallow(args->db, args->pdb, =
node, &violation);
> +                       if (rc !=3D SEPOL_OK) {
> +                               return rc;
> +                       }
> +                       if (violation =3D=3D CIL_TRUE) {
> +                               args->violation =3D CIL_TRUE;
> +                       }
> +               }
> +       }
> +       return SEPOL_OK;
> +}
> +
> +int cil_compile_against(cil_db_t *db, sepol_policydb_t *sepol_db)
> +{
> +       int rc;
> +
> +       if (db =3D=3D NULL || sepol_db =3D=3D NULL) {
> +               return SEPOL_ERR;
> +       }
> +
> +       db->fallback_pdb =3D &sepol_db->p;
> +
> +       rc =3D cil_compile(db);
> +
> +       return rc;
> +}
> +
> +int cil_check_neverallows_assertions(cil_db_t *db)
> +{
> +       int rc;
> +       struct cil_check_neverallow_args extra_args;
> +
> +       if (db =3D=3D NULL || db->fallback_pdb =3D=3D NULL) {
> +               return SEPOL_ERR;
> +       }
> +
> +       extra_args.db =3D db;
> +       extra_args.pdb =3D db->fallback_pdb;
> +       extra_args.violation =3D CIL_FALSE;
> +
> +       rc =3D cil_tree_walk(db->ast->root, __cil_check_neverallow_helper=
, NULL, NULL, &extra_args);
> +       if (rc !=3D SEPOL_OK) {
> +               return rc;
> +       }
> +
> +       if (extra_args.violation =3D=3D CIL_TRUE) {
> +               return SEPOL_ERR;
> +       }
> +
> +       return SEPOL_OK;
> +}
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.=
c
> index 74ec3cd5..a1485560 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -4843,6 +4843,17 @@ static int __cil_add_sepol_type(policydb_t *pdb, c=
onst struct cil_db *db, struct
>                 ebitmap_node_t *tnode;
>                 unsigned int i;
>                 struct cil_typeattribute *attr =3D (struct cil_typeattrib=
ute *)datum;
> +
> +               if (attr->types =3D=3D NULL) {
> +                       rc =3D __cil_get_sepol_type_datum(pdb, datum, &se=
pol_datum);
> +                       if (rc !=3D SEPOL_OK) goto exit;
> +                       if (sepol_datum->flavor !=3D TYPE_ATTRIB) {
> +                               rc =3D SEPOL_ERR;
> +                               goto exit;
> +                       }
> +                       return ebitmap_union(map, &pdb->attr_type_map[sep=
ol_datum->s.value - 1]);
> +               }
> +
>                 ebitmap_for_each_positive_bit(attr->types, tnode, i) {
>                         datum =3D DATUM(db->val_to_type[i]);
>                         rc =3D __cil_get_sepol_type_datum(pdb, datum, &se=
pol_datum);
> @@ -5032,7 +5043,7 @@ exit:
>         return rc;
>  }
>
> -static int cil_check_neverallow(const struct cil_db *db, policydb_t *pdb=
, struct cil_tree_node *node, int *violation)
> +int cil_check_neverallow(const struct cil_db *db, policydb_t *pdb, struc=
t cil_tree_node *node, int *violation)
>  {
>         int rc =3D SEPOL_OK;
>         struct cil_avrule *cil_rule =3D node->data;
> @@ -5127,7 +5138,7 @@ exit:
>         return rc;
>  }
>
> -static int cil_check_neverallows(const struct cil_db *db, policydb_t *pd=
b, struct cil_list *neverallows, int *violation)
> +int cil_check_neverallows(const struct cil_db *db, policydb_t *pdb, stru=
ct cil_list *neverallows, int *violation)
>  {
>         int rc =3D SEPOL_OK;
>         struct cil_list_item *item;
> diff --git a/libsepol/cil/src/cil_binary.h b/libsepol/cil/src/cil_binary.=
h
> index e6826221..8b20e45e 100644
> --- a/libsepol/cil/src/cil_binary.h
> +++ b/libsepol/cil/src/cil_binary.h
> @@ -341,6 +341,30 @@ int cil_sepol_level_define(policydb_t *pdb, struct c=
il_sens *cil_sens);
>   */
>  int cil_rangetransition_to_policydb(policydb_t *pdb, const struct cil_db=
 *db, struct cil_rangetransition *rangetrans);
>
> +/**
> + * Check a neverallow rule against a policydb.
> + *
> + * @param[in] db The cil database.
> + * @param[in] pdb The policy database to check against.
> + * @param[in] node The AST node containing the neverallow rule.
> + * @param[out] violation Set to CIL_TRUE if a violation is found.
> + *
> + * @return SEPOL_OK upon success or an error otherwise.
> + */
> +int cil_check_neverallow(const struct cil_db *db, policydb_t *pdb, struc=
t cil_tree_node *node, int *violation);
> +
> +/**
> + * Check a list of neverallow rules against a policydb.
> + *
> + * @param[in] db The cil database.
> + * @param[in] pdb The policy database to check against.
> + * @param[in] neverallows The list of AST nodes containing neverallow ru=
les.
> + * @param[out] violation Set to CIL_TRUE if any violation is found.
> + *
> + * @return SEPOL_OK upon success or an error otherwise.
> + */
> +int cil_check_neverallows(const struct cil_db *db, policydb_t *pdb, stru=
ct cil_list *neverallows, int *violation);
> +
>  /**
>   * Insert cil ibpkeycon structure into sepol policydb.
>   * The function is given a structure containing the sorted ibpkeycons an=
d
> diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_inter=
nal.h
> index ae3ab824..fcfa7b0d 100644
> --- a/libsepol/cil/src/cil_internal.h
> +++ b/libsepol/cil/src/cil_internal.h
> @@ -336,6 +336,7 @@ struct cil_db {
>         int qualified_names;
>         int target_platform;
>         int policy_version;
> +       policydb_t *fallback_pdb;
>  };
>
>  struct cil_root {
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_re=
solve_ast.c
> index bcac4026..75a790e7 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -68,17 +68,18 @@ struct cil_args_resolve {
>         struct cil_list *abstract_blocks;
>  };
>
> -static int __cil_resolve_perms(symtab_t *class_symtab, symtab_t *common_=
symtab, struct cil_list *perm_strs, struct cil_list **perm_datums, enum cil=
_flavor class_flavor)
> +static int __cil_resolve_perms(struct cil_db *db, struct cil_class *clas=
s, symtab_t *common_symtab, struct cil_list *perm_strs, struct cil_list **p=
erm_datums, enum cil_flavor class_flavor)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_list_item *curr;
> +       symtab_t *class_symtab =3D &class->perms;
>
>         cil_list_init(perm_datums, perm_strs->flavor);
>
>         cil_list_for_each(curr, perm_strs) {
>                 if (curr->flavor =3D=3D CIL_LIST) {
>                         struct cil_list *sub_list;
> -                       rc =3D __cil_resolve_perms(class_symtab, common_s=
ymtab, curr->data, &sub_list, class_flavor);
> +                       rc =3D __cil_resolve_perms(db, class, common_symt=
ab, curr->data, &sub_list, class_flavor);
>                         if (rc !=3D SEPOL_OK) {
>                                 cil_log(CIL_ERR, "Failed to resolve permi=
ssion list\n");
>                                 goto exit;
> @@ -92,6 +93,37 @@ static int __cil_resolve_perms(symtab_t *class_symtab,=
 symtab_t *common_symtab,
>                                         rc =3D cil_symtab_get_datum(commo=
n_symtab, curr->data, &perm_datum);
>                                 }
>                         }
> +
> +                       if (rc =3D=3D SEPOL_ENOENT && db->fallback_pdb !=
=3D NULL) {
> +                               /* Try fallback to policydb */
> +                               if (class !=3D NULL && FLAVOR(class) =3D=
=3D CIL_CLASS) {
> +                                       class_datum_t *sepol_class =3D ha=
shtab_search(db->fallback_pdb->p_classes.table, DATUM(class)->fqn);
> +                                       if (sepol_class !=3D NULL) {
> +                                               perm_datum_t *sepol_perm =
=3D hashtab_search(sepol_class->permissions.table, curr->data);
> +                                               if (sepol_perm =3D=3D NUL=
L && sepol_class->comdatum !=3D NULL) {
> +                                                       sepol_perm =3D ha=
shtab_search(sepol_class->comdatum->permissions.table, curr->data);
> +                                               }
> +
> +                                               if (sepol_perm !=3D NULL)=
 {
> +                                                       struct cil_perm *=
cil_perm =3D NULL;
> +                                                       struct cil_tree_n=
ode *node =3D NULL;
> +                                                       cil_perm_init(&ci=
l_perm);
> +                                                       cil_tree_node_ini=
t(&node);
> +                                                       node->data =3D ci=
l_perm;
> +                                                       node->flavor =3D =
CIL_PERM;
> +                                                       node->parent =3D =
NODE(class);
> +                                                       rc =3D cil_symtab=
_insert(class_symtab, curr->data, (struct cil_symtab_datum *)cil_perm, node=
);
> +                                                       if (rc =3D=3D SEP=
OL_OK) {
> +                                                               perm_datu=
m =3D (struct cil_symtab_datum *)cil_perm;
> +                                                       } else {
> +                                                               cil_destr=
oy_data(&node->data, node->flavor);
> +                                                               cil_tree_=
node_destroy(&node);
> +                                                       }
> +                                               }
> +                                       }
> +                               }
> +                       }
> +
>                         if (rc !=3D SEPOL_OK) {
>                                 if (class_flavor =3D=3D CIL_MAP_CLASS) {
>                                         cil_log(CIL_ERR, "Failed to resol=
ve permission %s for map class\n", (char*)curr->data);
> @@ -137,7 +169,7 @@ int cil_resolve_classperms(struct cil_tree_node *curr=
ent, struct cil_classperms
>
>         cp->class =3D class;
>
> -       rc =3D __cil_resolve_perms(&class->perms, common_symtab, cp->perm=
_strs, &cp->perms, FLAVOR(datum));
> +       rc =3D __cil_resolve_perms(db, class, common_symtab, cp->perm_str=
s, &cp->perms, FLAVOR(datum));
>         if (rc !=3D SEPOL_OK) {
>                 goto exit;
>         }
> @@ -4188,9 +4220,11 @@ int cil_resolve_ast(struct cil_db *db, struct cil_=
tree_node *current)
>                 }
>         }
>
> -       rc =3D __cil_verify_initsids(db->sidorder);
> -       if (rc !=3D SEPOL_OK) {
> -               goto exit;
> +       if (db->fallback_pdb =3D=3D NULL) {
> +               rc =3D __cil_verify_initsids(db->sidorder);
> +               if (rc !=3D SEPOL_OK) {
> +                       goto exit;
> +               }
>         }
>
>         rc =3D SEPOL_OK;
> @@ -4211,8 +4245,62 @@ exit:
>  static int __cil_resolve_name_with_root(struct cil_db *db, char *name, e=
num cil_sym_index sym_index, struct cil_symtab_datum **datum)
>  {
>         symtab_t *symtab =3D &((struct cil_root *)db->ast->root->data)->s=
ymtab[sym_index];
> +       int rc =3D cil_symtab_get_datum(symtab, name, datum);
> +
> +       if (rc !=3D SEPOL_OK && db->fallback_pdb !=3D NULL) {
> +               void *sepol_datum =3D NULL;
> +               struct cil_tree_node *node =3D NULL;
> +               struct cil_symtab_datum *new_datum =3D NULL;
> +
> +               enum cil_flavor flavor =3D CIL_NONE;
> +
> +               switch (sym_index) {
> +               case CIL_SYM_TYPES:
> +                       sepol_datum =3D hashtab_search(db->fallback_pdb->=
p_types.table, name);
> +                       if (sepol_datum !=3D NULL) {
> +                               type_datum_t *type =3D sepol_datum;
> +                               if (type->flavor =3D=3D TYPE_ATTRIB) {
> +                                       struct cil_typeattribute *cil_att=
r =3D NULL;
> +                                       cil_typeattribute_init(&cil_attr)=
;
> +                                       new_datum =3D (struct cil_symtab_=
datum *)cil_attr;
> +                                       flavor =3D CIL_TYPEATTRIBUTE;
> +                               } else {
> +                                       struct cil_type *cil_type =3D NUL=
L;
> +                                       cil_type_init(&cil_type);
> +                                       new_datum =3D (struct cil_symtab_=
datum *)cil_type;
> +                                       flavor =3D CIL_TYPE;
> +                               }
> +                       }
> +                       break;
> +               case CIL_SYM_CLASSES:
> +                       sepol_datum =3D hashtab_search(db->fallback_pdb->=
p_classes.table, name);
> +                       if (sepol_datum !=3D NULL) {
> +                               struct cil_class *cil_class =3D NULL;
> +                               cil_class_init(&cil_class);
> +                               new_datum =3D (struct cil_symtab_datum *)=
cil_class;
> +                               flavor =3D CIL_CLASS;
> +                       }
> +                       break;
> +               default:
> +                       break;
> +               }
>
> -       return cil_symtab_get_datum(symtab, name, datum);
> +               if (new_datum !=3D NULL) {
> +                       cil_tree_node_init(&node);
> +                       node->data =3D new_datum;
> +                       node->flavor =3D flavor;
> +                       node->parent =3D db->ast->root;
> +                       rc =3D cil_symtab_insert(symtab, name, new_datum,=
 node);
> +                       if (rc =3D=3D SEPOL_OK) {
> +                               *datum =3D new_datum;
> +                       } else {
> +                               cil_destroy_data(&node->data, node->flavo=
r);
> +                               cil_tree_node_destroy(&node);
> +                       }
> +               }
> +       }
> +
> +       return rc;
>  }
>
>  static int __cil_resolve_name_with_parents(struct cil_tree_node *node, c=
har *name, enum cil_sym_index sym_index, struct cil_symtab_datum **datum)
> diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
> index e5e6608c..3440fe98 100644
> --- a/libsepol/src/libsepol.map.in
> +++ b/libsepol/src/libsepol.map.in
> @@ -290,7 +290,9 @@ LIBSEPOL_3.4 {
>         sepol_validate_transition_reason_buffer;
>  } LIBSEPOL_3.0;
>
> -LIBSEPOL_3.6 {
> +LIBSEPOL_3.11 {
>    global:
>         cil_write_post_ast;
> +       cil_compile_against;
> +       cil_check_neverallows_assertions;
>  } LIBSEPOL_3.4;
> diff --git a/libsepol/utils/Makefile b/libsepol/utils/Makefile
> index a8bedf2e..67eebd16 100644
> --- a/libsepol/utils/Makefile
> +++ b/libsepol/utils/Makefile
> @@ -3,7 +3,7 @@ PREFIX ?=3D /usr
>  BINDIR ?=3D $(PREFIX)/bin
>
>  CFLAGS ?=3D -Wall -Werror
> -override CFLAGS +=3D -I../include
> +override CFLAGS +=3D -I../include -I../cil/include
>  override LDFLAGS +=3D -L../src
>  override LDLIBS +=3D -lsepol
>
> diff --git a/libsepol/utils/cil_neverallow_check.c b/libsepol/utils/cil_n=
everallow_check.c
> new file mode 100644
> index 00000000..0dae047c
> --- /dev/null
> +++ b/libsepol/utils/cil_neverallow_check.c
> @@ -0,0 +1,103 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <sys/mman.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +
> +#include <sepol/policydb.h>
> +#include <cil/cil.h>
> +
> +int main(int argc, char *argv[])
> +{
> +       if (argc < 3) {
> +               fprintf(stderr, "Usage: %s <policy_file> <neverallow_cil_=
file>\n", argv[0]);
> +               return -1;
> +       }
> +
> +       const char *policy_file =3D argv[1];
> +       const char *neverallow_file =3D argv[2];
> +
> +       sepol_policydb_t *pdb =3D NULL;
> +       sepol_policy_file_t *pf =3D NULL;
> +       FILE *fp;
> +
> +       fp =3D fopen(policy_file, "re");
> +       if (!fp) {
> +               perror("fopen policy_file");
> +               return -1;
> +       }
> +
> +       if (sepol_policy_file_create(&pf) !=3D 0) {
> +               fprintf(stderr, "sepol_policy_file_create failed\n");
> +               fclose(fp);
> +               return -1;
> +       }
> +       sepol_policy_file_set_fp(pf, fp);
> +
> +       if (sepol_policydb_create(&pdb) !=3D 0) {
> +               fprintf(stderr, "sepol_policydb_create failed\n");
> +               sepol_policy_file_free(pf);
> +               fclose(fp);
> +               return -1;
> +       }
> +
> +       if (sepol_policydb_read(pdb, pf) !=3D 0) {
> +               fprintf(stderr, "sepol_policydb_read failed\n");
> +               sepol_policydb_free(pdb);
> +               sepol_policy_file_free(pf);
> +               fclose(fp);
> +               return -1;
> +       }
> +       fclose(fp);
> +       sepol_policy_file_free(pf);
> +
> +       struct cil_db *db;
> +       cil_db_init(&db);
> +
> +       int fd =3D open(neverallow_file, O_RDONLY);
> +       if (fd < 0) {
> +               perror("open neverallow_file");
> +               sepol_policydb_free(pdb);
> +               cil_db_destroy(&db);
> +               return -1;
> +       }
> +       struct stat sb;
> +       if (fstat(fd, &sb) < 0) {
> +               perror("fstat neverallow_file");
> +               close(fd);
> +               sepol_policydb_free(pdb);
> +               cil_db_destroy(&db);
> +               return -1;
> +       }
> +       char *text =3D mmap(NULL, sb.st_size, PROT_READ, MAP_PRIVATE, fd,=
 0);
> +       close(fd);
> +
> +       if (cil_add_file(db, neverallow_file, text, sb.st_size)) {
> +               fprintf(stderr, "cil_add_file failed\n");
> +               munmap(text, sb.st_size);
> +               sepol_policydb_free(pdb);
> +               cil_db_destroy(&db);
> +               return -1;
> +       }
> +
> +       int rc =3D cil_compile_against(db, pdb);
> +       if (rc !=3D SEPOL_OK) {
> +               fprintf(stderr, "cil_compile_against failed\n");
> +       } else {
> +               rc =3D cil_check_neverallows_assertions(db);
> +               if (rc =3D=3D SEPOL_OK) {
> +                       printf("Neverallow check passed (no violations)\n=
");
> +               } else {
> +                       printf("Neverallow check failed (violation found =
or error)\n");
> +               }
> +       }
> +
> +       munmap(text, sb.st_size);
> +       cil_db_destroy(&db);
> +       sepol_policydb_free(pdb);
> +
> +       return (rc =3D=3D SEPOL_OK) ? 0 : 1;
> +}
> --
> 2.53.0.1118.gaef5881109-goog
>
