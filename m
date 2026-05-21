Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B563803C1
	for <selinux@vger.kernel.org>; Thu, 21 May 2026 23:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779407333; cv=pass; b=uVibSAxn6pvoN6uPerNPrfzzPpk39jKnHjPjn9C6wxXLcC2XrpaLO7/QdCyqeKdGfvOopFgsgsMwtADdkCH182D/KUhNzzYD04/q7KFCxh+mbrjlbvGUDu4OVtxb6z7K8EVBJiBpjbOlYhDFoANSJjR52Nw3RUwT6s4e9p272zI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779407333; c=relaxed/simple;
	bh=4NOoBOMowbyAKUBIX33WsfUuN8agLMW5UYJ1ZNhoTUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EdIF37qJTB2wQ2l31OX25ZBvhi81KMBavWkiCGRIOPkIr9EMiMzOcuhHJBXPNAfXTfhHbYkz9dZGwqyyYiDb1KcCHCVusfmvMMfuMK2NVRtquOy/6lQXA/Nzn1QWRDL0jW8VhLSwe6rnGdsQ5hxPKQJc/CV1e7dU2rp1mMrbEIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XxSCTeTS; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XxSCTeTS"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-516d78ba1adso7841cf.1
        for <selinux@vger.kernel.org>; Thu, 21 May 2026 16:48:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779407324; cv=none;
        d=google.com; s=arc-20240605;
        b=XBvumTMqbI14/BitveI6Jv2pHzDhT208YujSjBy3RrASrtRzjxiSA5+kxNfocdzlgC
         KXmC4COY+pnMmmAJqZNYXVk4BvnIVJnIG5IWx5035Tw8h/b2ycFgqlaLP/GMlOQgmbaa
         LTbW02Qs9lI6wtwAqwTEFV5rzPYbPC1eTg1Ieh+yIySQM0DC1QLdft0mZfYQHUHFpqJR
         F5hptCai0o3vNgJSvM3JyqKtMFviTNMwxY17nzb6qFC8nSM1VrlU+NihXpQon8MN3BNN
         UxmUjM8v0OCzDBQi5BbuRgyGPQVv7PSnZenyfP0gQdMbzbzG8YCoxQXomyj1nRQTsE5N
         34gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NgfCYNsghVLKoNPYAODYbWSqRuCq55dOJdet6UtaPmk=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=FgDoH+Mc85hy10Akxh9N4ic81P9H65aFs+VUBZ0K2wRErLoBA5L6JExrFnopaFPWYn
         5ttuDLyxmX8aIErpXASHk9VfArn8kEQO7Pq3lTL2ntAorB1whrU8kCG2PQuVG+tQ08R8
         P1mXel3BcLUfJbGRAPLmapIjIEQg/lcfvLYbTP6RAGRFDGL8Wpi1kmmfDw+1+AVe432D
         01GPY2DcO0boJ5NZASAPTGoRODDWs78lUL9YsyM3oFpZfevC7G40dnf6vp+lknuOMF4Q
         0eDb3SwGtCpiKlyahg64Kyq849bv9GNJwvOMRan4AqapCJ06hucuci1iec6tgQ6+THUm
         1w/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779407324; x=1780012124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgfCYNsghVLKoNPYAODYbWSqRuCq55dOJdet6UtaPmk=;
        b=XxSCTeTSUT49C4kzx8vYAKflCQbkOtv5xLu6Ay1bPtv9TiRCAFofIUv84iT50y99LG
         W9+69apsIUW6ni6+Mlbmlw2l5NCGKZLFdV/mI3UF27uYToMp9IezOeLv1D7YB6GBrU/V
         hxXO6GzWzQUstBqv51qR9IN34+VI3frK0OI1CtJj3/2x9QBMIV9DalET1T4NL6Os3DB7
         +rhxndHaCnQUqLlGI1ecTK1tXR74sKCQkANHpF5msk43tmUb26gB47u+iqBSHreDa0Vd
         I6TpL5mikLodQ5/fHe/bmJC/4WK9qSPc4ptABMVVjzbW6+o3aogDNyALusVvUc43NSKN
         QRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779407324; x=1780012124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NgfCYNsghVLKoNPYAODYbWSqRuCq55dOJdet6UtaPmk=;
        b=B5nUao5gIX+ZQJuuWOfuExgeRDQ9+8gxy0k2qH7tr1hheljpLSKo55ZdisMlxQwL1l
         VZ7W+1jFlQbM1yY+MRZ97h7XuCbM3CnEl8egxZKqaWEkP+2pP2N9guDIhagKUl5M06rp
         cSGXdEm5UMKmu17CSc4bzPJkkUDbco8gggsmvxVvYFgqzSKI7q9uLERvssax1syCv/dC
         qmH3W1vW2nHnvsGg99bA9y/vLzlLJ1RYEcLcQNgBhvBG0ZDJgPv/q9YYo3XjPQoeOaUf
         mhZLgvlgkTdxT50B2l1qoWUeCy4lE4zmhEQGB0NvOdEDkYJiRr1Rll3GOldnv+j8KSCM
         93sw==
X-Gm-Message-State: AOJu0YyKvumosNoERY+Sr171/Q0vBP5bVvWhK8V4Cdxmbdi6LleQuB4N
	mSVDxUFOblRHDQS9jb59uEsElR0TnTRtlQdr/a9gWGblPo7osAkc9vf2o7r1vN5ymmuCccp8RBX
	j2vQml7vc47RMezaiIpq8taAgKc9RKqiiczvoNKMm
X-Gm-Gg: Acq92OFnlCzUbEx7Q1dOICYnk0qnz6gg3XSTpFLMXtUwRsRMjTdOGrJmqJw32Iuoigw
	p9N/x2bfdc+a4E8pidL+JXVdg4tHT1l5W2+rcv+hfoiY8XXpwdDyKiXYllkMkxGohIzEiwQptl4
	uX35aQU2VNWGIqZ0ALe5AaiZYVehMBaQfDMBf931kb3Pt/hyaJPQakW0Egq2mhtr+KP708eCeRQ
	9jOuzsRFVaeYF0Puo98b5Zoq/vOOxZe1i58r2yVaBXnljyrH7taibkVQFT/H81ObsNNcqpVZSRE
	Ze//k16EoksEgl6yO5SC2lcFluWDWfCpuSHL+8QhRwoGy319BoFPSygW8T7QYs3TPZXDyTkwMpl
	92Q==
X-Received: by 2002:ac8:57c5:0:b0:50f:af60:3496 with SMTP id
 d75a77b69052e-516d7b9a3e6mr494401cf.1.1779407323253; Thu, 21 May 2026
 16:48:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427195546.91395-1-jwcart2@gmail.com>
In-Reply-To: <20260427195546.91395-1-jwcart2@gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Fri, 22 May 2026 09:48:25 +1000
X-Gm-Features: AVHnY4LvULlPiIBMzQB3sGyBrs8qTI7CBGnHuq1lCeOFtQ0Dyz-pBnDyyBvnV-0
Message-ID: <CA+zpnLeGVzFqeWijirYhROz-yVXk0yJ7Q+90Hd7aUuTHi4pqUg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] libsepol/cil: Add function to check CIL
 neverallows against binary policy
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for taking the time to write this RFC. Again, the approach
looks good to me.

On Tue, Apr 28, 2026 at 5:55=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> Add the function cil_check_neverallows_against_pdb() that will extract
> the neverallows from a CIL db and check them against a kernel policydb.

It might be worth adding a bit more background here? Feel free to pull
in some of the commit message from my RFC.

>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/cil/include/cil/cil.h |  1 +
>  libsepol/cil/src/cil_binary.c  | 46 ++++++++++++++++++++++++++++++++++
>  libsepol/cil/src/cil_binary.h  | 12 +++++++++
>  libsepol/src/libsepol.map.in   |  5 ++++
>  4 files changed, 64 insertions(+)
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
> index 74ec3cd5..21cb07ad 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -5143,6 +5143,52 @@ exit:
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

I think violation might not be set if nothing is found. For the other
existing caller (cil_binary_create_allocated_pdb), violation is
manually set to false before calling cil_check_neverallows. We should
do the same here?

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
> index e6826221..e8fff9b4 100644
> --- a/libsepol/cil/src/cil_binary.h
> +++ b/libsepol/cil/src/cil_binary.h
> @@ -36,6 +36,18 @@
>  #include "cil_tree.h"
>  #include "cil_list.h"
>
> +
> +/**
> + * Check neverallows from a cil database against a policy database

Same here, maybe we can add some context on why this function exists?
Do we have a strict requirement that all definitions from pdb are in
db?

> + *
> + * @param[in] db The cil database.
> + * @param[in] pdb The policy database.
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
> 2.53.0
>
