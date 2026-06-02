Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDA436309B
	for <selinux@vger.kernel.org>; Tue,  2 Jun 2026 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418487; cv=pass; b=X4mOWTnafZ8DxaJLcz+vT8y1BXR2pxByk8UOnVwLQL+5nh8yREHrprfviNgTOo5kVwEVFft1j/PpwI3Qp/jL+C7K8C8k5KpV6T28QNpYW3S3QXGP4xAksIbdcqUV6Ya1qZLGF8RcjSQR38g/DnvJuZLn94GZW5OfWj0tYj4kdUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418487; c=relaxed/simple;
	bh=bK0LDlcGwq08ZGJfpqMVegT19r4FpWyaSW7XWn3R1Ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGyB+5vS4s9VqYZ46ddFc3Oa3dzIaBbF7I/yDk6U4GMZ4EptquIWpnDCSUVVUxQAO4Bh+EldpU7kCWYg1Iru8hQL4jAwnV6fF9f/JO6RlbHqisod058jEW0q9Fua+T5Mk4q2N7b7ybvD178VltUsYja2xZdMFa3j7usOAV6rnqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tLoPESeG; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tLoPESeG"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c858b5de728so2150815a12.0
        for <selinux@vger.kernel.org>; Tue, 02 Jun 2026 09:41:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780418485; cv=none;
        d=google.com; s=arc-20240605;
        b=SezaKGCNWRW98S5o3zbBbYI6tYPBg5E1A5ExenjyZMyP3XceokqLztajYKs7Yq9TTx
         PMCrnUDzqj5g9d3XkCXResIAy3eHb+n0HOSpaybD9FIjAf993+j+TA50h6YWwDZWYgZY
         mb3sEZ4f4lwWmvKvQ7Vw7D0eEqY56y8JNNuYRVcdukl4wXS8HSrzivzxcxM336aodOKK
         aQaT7dT3GYV/RqC3Mscd2pYLhPN/ytkRY01Vb2TR1F7ta5SRpqIuGwKpvsbKzk8hEPku
         +0Ko6cyFpvrfYOGoFCDNkYN2awy9l2ThrH7KDJcyxmtZAa5w3gKG/i4WQWtETelvdLA2
         7WJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I3bXEUKFR1SHzD8v1yl1Ak68tue1l/Fq9vBkiYiMTm8=;
        fh=ZRedc575flThWjp0FOeY4xu8TVTKDyGyGDcFPwDIv+A=;
        b=lARe5pj1qndWighSqZfRTagcg0euZpU1z7bqfwpDEtvN1Y3Uw2W/Um5SC4IQY6sIjF
         OzIHO+jtVcMX/+zy+z2rvqdxe5I7QHH+GA5cGqMqYT40Wi/3caRxNGI70x8/yYrfp6TP
         cQfZ5t4Kw/uEi/Glr3T9RcJg39tXVYu300nM7n8nKhwWNs37Y1VjzVPOl2CH7szWjeI5
         f/cGjsB/pfkTkBdIV6UHTzpwLyujLvDrbQ1/yuR37zMQZGZbthT5t4sDxpKQGkEgjR3J
         ydQa1E4xmAFuPdrkxWDjGzNfrprB4mts379OEtfbbYK4RaGAENYwABToLVucDrSU1CmP
         aOEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780418485; x=1781023285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3bXEUKFR1SHzD8v1yl1Ak68tue1l/Fq9vBkiYiMTm8=;
        b=tLoPESeGueDagDDq4/7hfIUS1BQv14l64qctq093Xe2T+nF/BSt0MPJbYv5lAVFgCU
         h2Hu1Xq1x2DrDgruWbjoE/hW6CVKWsQ/TkphnxlLzrYmTr7KUvgc3gxroGk0wMXFcoUm
         brc2LtobNgHIYGBd3pz43TCVMENV8LXrTeiES9s+UDLLG/SdDeutSBCz0PgEPAqDDHkN
         glypXsiQFBeno7D+4TiRJec/X7aEXgm9onmXSYt0EQAbUQu+oTh9D0pyrt2ZCI9Wf75i
         gERN5WUcabem+hXAlPHUssK82nTcHvecrjzSf+hR7ZxA+ro8x+2HHqoO7x3W1E9bTcu3
         Q+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780418485; x=1781023285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I3bXEUKFR1SHzD8v1yl1Ak68tue1l/Fq9vBkiYiMTm8=;
        b=ExoZFsBVOUvWfPnEf12lO1cR+awUhIl95HxpCQu4akU8LDVEB8N0zkAo6Ub2nQ1/ML
         zAcykVkv0bdpDiez+of13fZytxid1OguUPYC4c3Xm/kR/rQXFHla755NHbQLfkvFXA6v
         924WGOv+sZtPtfO0Ct7cMibvJ6qE628CxeBIUpTyD9Ijvpr2Nce/uS8MUJKhH+7WdVHC
         PUeql0GXd2nQtdaxZgB6gfCe34v/8XFyzKg8xZ9xcsfpqlPB49524UK6igcXjHNg1YDZ
         mbnPKbDWyC0Ret3aEGvVWSl7qmdWjaD5HUfBF6h8/zer4XubC6uAc62wJFfwQ2DOFsu6
         8Heg==
X-Gm-Message-State: AOJu0YyQ1hedNxv7SwkD1GW4Uwthhyj6awqxRXqb64wX2X3TxryucA8D
	AUtcrJV8GK+gbtq6pW1My+rEe8boNuW25N07uRutY7dWzacaGUE9ASPjbWy2DR4Qn+fhjkzbLIc
	aemD6V2iL+ziOxkGO/ipOVhcGu2PBLQ9EJfvo
X-Gm-Gg: Acq92OHmfPDf0IPtr/zSGPwZXAKFP6Ay+HL3ee1qA/8FmS0wbUCa2TlNhBACaQj6yfW
	hVGPh1hEGHY60rDBeqJg7ntM2Hfi7QaGhPHH5lLkS3qZsVPkvgj6iN464dtMAngFNRt2HZlOcoW
	kpBU2mE3KVyMRoVS4c44zU1mgyTwLTDlbsnkkXeAjb2CkaJSU8E9Swtxu1rl4pxdHYYcyQGFf0Y
	Qp4sjpaQMKfkqe67Xvz/L1RUnP8WhwHzPgQem5jzsoIKUIKxhSOO/S1M1UozN9RuxbaYZ8/IeCx
	AUuDwZTY/KfEvufjqQ==
X-Received: by 2002:a05:6a21:9089:b0:3b4:76c6:f961 with SMTP id
 adf61e73a8af0-3b49430733bmr333206637.17.1780418485270; Tue, 02 Jun 2026
 09:41:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602153309.157348-1-jwcart2@gmail.com>
In-Reply-To: <20260602153309.157348-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 2 Jun 2026 12:41:14 -0400
X-Gm-Features: AVHnY4LrJR5WJG5kuW3PkmZRVEKFNF63HrpEoJroMZf6MP9J5Wqbym7giL0ZOy8
Message-ID: <CAEjxPJ5fqQQRXCiD6wXAyJGmY=CNkOkFamMMONxe09j36t_7GQ@mail.gmail.com>
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

Acked-by; Stephen Smalley <stephen.smalley.work@gmail.com>

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
