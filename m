Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4B43242B8
	for <selinux@vger.kernel.org>; Tue,  2 Jun 2026 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780423808; cv=pass; b=qIyumQKA4LyVVBFQcpDLMIGPCyXdj+ypzob/uovHwxcE4L7FTsreYB0HdWq/ejBiRQdG9iXc8BimIhxO4yO1n5dc+Ir8TKpTfNnkwDBuKVvYz191bvibxNE6w4cOw6DfT6d8A2FudyJKQr1qh2eiksgSX+FAHeR38+vdZMY7pK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780423808; c=relaxed/simple;
	bh=SyQGpFy/BobS8loX3VljA/M/dKFRJ3MQO48KY2qrvUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZ6tuSTqWJqXpyrqol1Tzs9D2wF/T/py56skGUgzTUJxAXNS+FdRUOEDsDEaRB2wB1U/2YzKg8SCmrP/VvdyZpIFPyvXuOGJhgtyQbUfLqoWzV22i2j0GPWbYtb03+M36OG8QpYUu2TShyvqp/D+bBK9kib6LARN9oHyp0m6mI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNBYG3Hy; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNBYG3Hy"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c0c20f0c0aso20249145ad.0
        for <selinux@vger.kernel.org>; Tue, 02 Jun 2026 11:10:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780423806; cv=none;
        d=google.com; s=arc-20240605;
        b=iVQIPLC6mel/8f0NtrlLQfdoKMjF0YeNaEQcJegIRzzrDAY/kOnhriWokbCqNCsz6d
         0nsbxP6B7hFT/pJ5ZqNEtyMrtfyhK/Cr0lR9vTtI6SCWeBVH2HQWYPlCeA/C8X79ZfFl
         KpRTiIIDQTB63ryUu7FMJPcBRx7C3vUb54E7775WxAtH9alWnXeoVAPYbjqNycWSlKhh
         bJKRQu6TE6xgiolEEZuOMAcgMD4sF6EUCrf7wf8BnxgThNWfCmgyT6p+GXH9+0eWFWsf
         zocGmu4pSJGPQd5CYrpu7Pir0g0uXT7OTH2k0JUq01p4I6eumRonA9GKOac+3BSZhOJS
         fLKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J/SsrkT9taK6t8q6hf8knYKBPv2CQpkecZtjE4dX2A4=;
        fh=ZRedc575flThWjp0FOeY4xu8TVTKDyGyGDcFPwDIv+A=;
        b=NxKah6Zw4sO1i2aN13Y4taTnuPU9JvHFRbFkPBbcQ+bIGQesPR/nxenSna1EQaIiaK
         If3zbDVDWmdutQj/VW7ta4vtiQ9WJSz5u6nNDVkWJaaEYY4R5dt2PSGoyQwrsysh3InB
         +Hk4uJO87MXJGCt92E9B1STwusIleVAesdgPS3CwBhuO8pvmj9YGb7mas/r/y+KNmdVj
         kpiqt921wqTeRbw7E/mBR/y3NCFIHl9ot4M1rGk9QrrxFVCJKmXWabGT96xZPJuwtrtw
         Hn+gWSeBLnvxFG8T1OMpQFwew6CAzSp1K8J03odHD1U0gaSjA2DBM5j92XJjEPg3OzQD
         5RjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780423806; x=1781028606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/SsrkT9taK6t8q6hf8knYKBPv2CQpkecZtjE4dX2A4=;
        b=PNBYG3HyPu6IhNpNGsY10a1fjnACV20ujkZfVHnQ7Zs76LRd0qvb3/yDpwYMP/hzQ1
         2U0vUfor8Uwitg7nnMNWw8IFH6IDBXxW4NcVQoWlpfvkqGzEmhO3VE1KkMFsyjXCYHaX
         ZmqSp4V39uI1Iz3ROaYF4A/yhwm9gMVxxuZubaET7tAYPIzIzSivHey3SJU9+VVkQLLG
         UJHB2fluf1cD9MU1+tIuqLgfneWj3gdFvsPQ85JxzzYSWj200d8lTGSzuXBzQYt3ICKo
         oNzifmxELsKu94+NcnW+1RuJqw0WUitjEy4KeERtRZngCaypJ2x+4L+zyxoeyfvUJLB0
         47zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780423806; x=1781028606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J/SsrkT9taK6t8q6hf8knYKBPv2CQpkecZtjE4dX2A4=;
        b=tB5Ra7GcZQ1qfMYbwiVKRB42DGas0ieSbqOYKki6VLwliISKg68IU7xiwffVK5MBV9
         LSS8Q+oUIfpE/9ftf9yV8vqgI16KaJSLzO5HTw2FmeBDeBErM2DKZR+Jk3dOCtp04wDG
         J3pQGTFKZk5rRbxX6wEriPxtbVUd1WpEhwVdL1nOAHn1iSAaRrJbu/y5zHDVs9lemtcp
         fvNjkPdZrKco7sc3qQFqJRRaH8+0Ey+67So+sp4WkbGDS3Q5pdxjqKKiRN2fztigP/vT
         DvvAllRvs3PNT3DDvWQ4gw1NJjUkEUvgf5TubpNA5UvLI4ktjo77u2dKT3/trzQhxG8i
         Zsyg==
X-Gm-Message-State: AOJu0YyEKEw3K+MXDbd1ZWxr0xBzLuMb4M76MvHVw0nIqdhuY/V09z9w
	2GKyu/RF51uOV3au6LvZXwZQn26Wx8fQLdnjfxsQZNS7iOrlyErCnNwt7tkirUNKgS3gz2EvonC
	8CDlLT+0mCI2NNa+RADI9yWSIprLvT3dKTj2Z
X-Gm-Gg: Acq92OEDdSP9v8Ni1se+Dbh081nZTdYrmeV0OueP1JeFOmy7SROx9xgGq8lOx954btA
	mPgUJAkLi3elbRrb72N9H91EoTyxdfP9AjBDlaqqrZURs0mPDowxBQFAP6mBelRBt3qvp3qZfaC
	kHU3Gh620C7mxqjvQ/qibCfJguBn3LMGCQ0FxnMmQmDs269c2klU0835ThtikZNRdk5D/CUAXD1
	FeT6F+sBPG8Yy+EjQMLCMoyVF9EGK/V4QfwGitgsrq0hiJnjIQKWvEevq1Eu8KDON/QHrd6NHyy
	Nt3lT7f4EGofbQ1/GPwlOuNSBu/B
X-Received: by 2002:a17:903:2305:b0:2ba:7881:948d with SMTP id
 d9443c01a7336-2bf367b214fmr181803695ad.1.1780423806029; Tue, 02 Jun 2026
 11:10:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602153309.157348-1-jwcart2@gmail.com>
In-Reply-To: <20260602153309.157348-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 2 Jun 2026 14:09:54 -0400
X-Gm-Features: AVHnY4JgTzODKKr_pTuhPA7iOthPIwQqE1d6Tu7ZyNgl73-67YVF1U_AHm-R7g4
Message-ID: <CAEjxPJ4=E9uV9=u3HRYJqncsH5nik4GPV+kt3rCLv94ZepZM9w@mail.gmail.com>
Subject: Re: [PATCH 1/3 v4] libsepol/cil: Add function to check CIL
 neverallows against binary policy
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, tweek@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 11:33=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> Add the function cil_check_neverallows_against_pdb() that will extract
> the neverallows from a CIL db and check them against a kernel policydb.
>
> Android has the requirement of validating policies from partners
> against the standard AOSP assertions. While this is done at build
> time, the requirement is also enforced during certification via the
> Compatibility Test Suite.
>
> Currently, this validation is done by manually parsing the neverallow
> assertions which is brittle and does not support neverallowx assertions.
>
> This function will allow a CIL db with the neverallow and
> neverallowxperm rules to be used to check a kernel policydb for
> violations as part of the Compatibility Test Suite.
>
> Suggested-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> v2: Add more context to commit msg
>     Add error messages for when type or class-permission look-ups fail
>     Set violation to CIL_FALSE initially to ensure it gets set
>     Add more description in cil_binary.h for the function
>
>  libsepol/cil/include/cil/cil.h |  1 +
>  libsepol/cil/src/cil_binary.c  | 48 ++++++++++++++++++++++++++++++++++
>  libsepol/cil/src/cil_binary.h  | 15 +++++++++++
>  libsepol/src/libsepol.map.in   |  5 ++++
>  4 files changed, 69 insertions(+)
>
> diff --git a/libsepol/cil/include/cil/cil.h b/libsepol/cil/include/cil/ci=
l.h
> index 88e47e79..fc9cc504 100644
> --- a/libsepol/cil/include/cil/cil.h
> +++ b/libsepol/cil/include/cil/cil.h
> @@ -65,6 +65,7 @@ extern int cil_write_parse_ast(FILE *out, cil_db_t *db)=
;
>  extern int cil_write_build_ast(FILE *out, cil_db_t *db);
>  extern int cil_write_resolve_ast(FILE *out, cil_db_t *db);
>  extern int cil_write_post_ast(FILE *out, cil_db_t *db);
> +extern int cil_check_neverallows_against_pdb(const struct cil_db *db, po=
licydb_t *pdb, int *violation);
>
>  enum cil_log_level {
>         CIL_ERR =3D 1,
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.=
c
> index dca1937a..4e9b0227 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -5143,6 +5143,54 @@ exit:
>         return rc;
>  }
>
> +static int __cil_collect_neverallows_helper(struct cil_tree_node *node, =
uint32_t *finished, void *extra_args)
> +{
> +       if (node->flavor =3D=3D CIL_BLOCK) {
> +               struct cil_block *blk =3D node->data;
> +               if (blk->is_abstract =3D=3D CIL_TRUE) {
> +                       *finished =3D CIL_TREE_SKIP_HEAD;
> +               }
> +       } else if (node->flavor =3D=3D CIL_MACRO) {
> +               *finished =3D CIL_TREE_SKIP_HEAD;
> +       } else if (node->flavor =3D=3D CIL_BOOLEANIF) {
> +               *finished =3D CIL_TREE_SKIP_HEAD;
> +       } else if (node->flavor =3D=3D CIL_AVRULE || node->flavor =3D=3D =
CIL_AVRULEX) {
> +               struct cil_avrule *rule =3D node->data;
> +               if (rule->rule_kind =3D=3D CIL_AVRULE_NEVERALLOW) {
> +                       struct cil_list *neverallows =3D extra_args;
> +                       cil_list_prepend(neverallows, CIL_LIST_ITEM, node=
);
> +               }
> +       }
> +
> +       return SEPOL_OK;
> +}
> +
> +int cil_check_neverallows_against_pdb(const struct cil_db *db, policydb_=
t *pdb, int *violation)
> +{
> +       int rc =3D SEPOL_OK;
> +       struct cil_list *neverallows;
> +
> +       *violation =3D CIL_FALSE;
> +
> +       if (db =3D=3D NULL || pdb =3D=3D NULL) {
> +               cil_log(CIL_ERR,"CIL db and/or Policy db is NULL\n");
> +               return SEPOL_ERR;
> +       }
> +
> +       cil_list_init(&neverallows, CIL_LIST_ITEM);
> +       rc =3D cil_tree_walk(db->ast->root, __cil_collect_neverallows_hel=
per, NULL, NULL, neverallows);
> +       if (rc !=3D SEPOL_OK) {
> +               cil_log(CIL_INFO, "Failure collecting neverallows\n");
> +               goto exit;
> +       }
> +
> +       rc =3D cil_check_neverallows(db, pdb, neverallows, violation);
> +
> +exit:
> +       cil_list_destroy(&neverallows, CIL_FALSE);
> +       return rc;
> +}
> +
>  static struct cil_list *cil_classperms_from_sepol(policydb_t *pdb, uint1=
6_t class, uint32_t data, struct cil_class *class_value_to_cil[], struct ci=
l_perm **perm_value_to_cil[])
>  {
>         struct cil_classperms *cp;
> diff --git a/libsepol/cil/src/cil_binary.h b/libsepol/cil/src/cil_binary.=
h
> index e6826221..2bd19102 100644
> --- a/libsepol/cil/src/cil_binary.h
> +++ b/libsepol/cil/src/cil_binary.h
> @@ -36,6 +36,21 @@
>  #include "cil_tree.h"
>  #include "cil_list.h"
>
> +
> +/**
> + * Check neverallows from a CIL database against a policy database.
> + *
> + * The types, classes, and permissions used in the CIL neverallow rules =
must
> + * be declared in the policy database.
> + *
> + * @param[in] db The cil database containing the neverallows to be used.
> + * @param[in] pdb The policy database to be checked for violations.
> + * @param[out] violation 1 if a neverallow violation was found, 0 otherw=
ise
> + *
> + * @return SEPOL_OK upon success or an error otherwise.
> + */
> +int cil_check_neverallows_against_pdb(const struct cil_db *db, policydb_=
t *pdb, int *violation);
> +
>  /**
>   * Create a binary policydb from the cil db.
>   *
> diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
> index e5e6608c..2b103993 100644
> --- a/libsepol/src/libsepol.map.in
> +++ b/libsepol/src/libsepol.map.in
> @@ -294,3 +294,8 @@ LIBSEPOL_3.6 {
>    global:
>         cil_write_post_ast;
>  } LIBSEPOL_3.4;
> +
> +LIBSEPOL_3.11 {
> +  global:
> +       cil_check_neverallows_against_pdb;
> +} LIBSEPOL_3.6;
> --
> 2.54.0
>
