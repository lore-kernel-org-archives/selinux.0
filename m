Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB9C35E952
	for <selinux@vger.kernel.org>; Tue, 11 Aug 2026 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786463340; cv=pass; b=pKtywTbIJEpN/ZOU9WftpA6hkNrTYVlmFDcCVtANi7c9baJzCuiw1NZQLpe0UPYlMCkp2g0f8t890/kxZua5A8BG5j/Cm6KYKd2Cbn8Ojcj0I/pbxGMc19dZYsgBdmR434qtkCK/hS3FpayPrHGSjxie8lXzsJQ6giB87pbU2gU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786463340; c=relaxed/simple;
	bh=hKsa5A5nePYmRKVEeVHnyM1BJ9X1pSYsdqcqm0StBEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wt2sH6SmjVgBmuqsaumHEQUS2Jz3n/nVmlcpMbc3rtz9mjvE1+2DPEfSSoZbEl1Cqoo1g6WW66H5BhJ+bn2BKY2u+Qhvbgg+xXU+0VYZ9DmQ5zViRepwnCwASWxBhao+lvpeSTIqHpPUcUvRJ0SKMt5FJu4C0pgQuOk4zq4CTk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=povdWplU; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="povdWplU"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39dbe684115so9391791fa.1
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2026 08:48:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786463337; cv=none;
        d=google.com; s=arc-20260327;
        b=kOJzJI1utXWGGDaT/F+PxafjSJwlooaJ/dXHZbZVI9TWnoHGLAckgveUctMsBXQwz6
         rkYcQuIy6diDxRXyMVrp9T6UfCk3sY7E7vFMsfqOrasTtzL1zIfxcNyVn+VaIfMWx/DS
         VoPY4klti82MJy6LNuE0gX1V+qbi1dJlKeojbVbHGTAKFDsSkf5dMTNFGE6tn5Ry2Qw1
         HCYEBvj6j/8JC5/brPl8pBZFzpK8u5qdv4XlpJ2Rr8kP+rcxtwLKBd9YTOuTVl3Ef5fd
         Ia//a+P8aCw6JjlS4RQ0t6FOTPFpJCjF1W6jD6UAEVMUpoFiLVmlvZMLGo9eOs/dCfjK
         0LIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=soYHaWevycNpc/BPliauRr9NLIDa7t8hxiCXRWJjYIQ=;
        fh=Jo4LTK3+aWHrc7SVZjtcvtwpYtNLGosw1J+CxlQ+7eM=;
        b=YGZ4t7lwnmA1fdiP3iJmisQfoG5wzmPG5yPJvtPELMuJBOVpUrM8KLPdsypdRd9hJ0
         +Okrvq61LpbX8koJkVb7K5wWgt4i6UdIuHzFZ7cDmfCstYdUdHl5Q4P7iMh/1RXN6TGx
         d6s1Z3wiJlFYEHoU8cVltOkBXnN+LuootciPyOyO6JLRVttjVUZGgzvmNWEEh0X5ff3N
         PfwrzC5XFKD+u/RIhp2FxaruyD6zOHXYstcMSYZocX2ZDtSTWWHp1PDc4qjcJFrL7OM6
         qZMAXIkWZMaJL17dl3E7WuvIkMeL/hmQvcChAFhnvSXdQTQ3ZwZwrNdZ+O4Tc4sLqEV1
         L35Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786463337; x=1787068137; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=soYHaWevycNpc/BPliauRr9NLIDa7t8hxiCXRWJjYIQ=;
        b=povdWplUMpxSVy3Dezfn2OCW8xmM6uRxTQfpyKWQ7x2hHKHoEXXbJjpYz3sp1jD7Jx
         7C8cEZ1lWp3MiO5vYKzfCoDgnitd+c++OqGY9aUypqF2lRG1D6ZoOYL6kZCDdFlBxGVJ
         dHgUczM0J9RFhM59lX2aynAVVLzENvI1F9lxG0wtlhgI6QBEe+q+xSUHluhs8N+3IOBC
         BAW0Ay6/qgHuUAA4DKixKNOXvwj1o+VI+oP1N4ca15Awb2fWGIMlxSSuGqP21cOc+ofh
         +n+JRDnXFcPFtofHeVgCyX4dt+kuMA+l3HL1hCmrB7lob6DXtSd9E8Hs970m3bYZsdAo
         CvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786463337; x=1787068137;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=soYHaWevycNpc/BPliauRr9NLIDa7t8hxiCXRWJjYIQ=;
        b=CneseN/nFu2P3ljEmuKztkbuec6QYnI3S+AZIot5M9HxCloXIpeVQvnVxsDykpkVv+
         2iauEUsLQZm/dhYZl7CLjct/7HUXrMIpcDNGBUFwcOZZsv4VgqRBTIuVF7+roSTSR75V
         1SGz192b3aDd9mmyL3SmtVHLkq82m91BlyTaC8YclVYioCNPwhK/L/tYMlLSrRniR2vD
         zjK3OwKTIUYj4w+QIz/2pxRk1xu1xoXIphQI75/Qx646pRYbQpsINX+sRPe4VoTSVfaM
         IHGS1AXnX9rUJ3Jc+Y30WO+WWqJ6e6p3LhAv0jdNiXauKGq55ybntwWPcwDivXuxstN6
         L9LQ==
X-Forwarded-Encrypted: i=1; AHgh+Ropjxy6+jhy0eyi/If0RaLq47e34ny/pA5/Daoe0fuNSkaIVf9GYN10ogDvyr2lB57pO4y4H2Xd@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9sdN+1FASKBLFjzscnT496jIIUzbRJGrDzIcj/ShaZ1R6gm5a
	9ANa5XuRqHWtpzrpNghovtW6g+umq5cmyhX0CqftqczuU9Pa8ybnUgYDxl7ikV58ZMB3lr749x3
	JG1hL3qEJqouJsiXYZy7cleSXQKyz7CA=
X-Gm-Gg: AR+sD11vE9mz5HgBSItGtxZAO5Ub4R9oGTXuVS/UL5jwsbzj3/PeN/kUVAbXf/73FyO
	zQxwhkV5cO7Q4lwMjRZyLz9yBomQIh5aTjIbLJIfc0MP5KGFaIBM1/wX1GfkQPFF+EQ6Ky0jxJJ
	/AmVlyZgXc+ePpjPSgr+ov3XRgnUxvKfuwkyeOCCQ9p8ZsDTZk9Mo1VU3N+mXOxkf/YOszkWa36
	bEsiHr1ls06r2MPi9arALsIh5mPZWCff1+Ne6n9lRu7Ng/VwbV21/f6rDG4P+bw6Rj51M66f+Sa
	/Dtg+w/KOrS8MP5fIeS+vCS3wrd4hPWKyotWoVNGuA==
X-Received: by 2002:a2e:be0e:0:b0:38a:5bf2:80d6 with SMTP id
 38308e7fff4ca-3a1032a4eedmr1661951fa.5.1786463336462; Tue, 11 Aug 2026
 08:48:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811042908.3803430-1-tweek@google.com>
In-Reply-To: <20260811042908.3803430-1-tweek@google.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 11 Aug 2026 11:48:45 -0400
X-Gm-Features: AUfX_myb9qQG5Hx1pjrIZTCifNAv07KNupS32-o_-hfPI0mzz5y2eIUNZUt3qF8
Message-ID: <CAP+JOzRhNTsZKOkEvmKMqB_M681T6xp3eUic=00HQUhbF_V87w@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Output culprit rules from binary policy
 when CIL AST match fails
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Inseob Kim <inseob@google.com>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 12:29=E2=80=AFAM Thi=C3=A9baud Weksteen <tweek@goog=
le.com> wrote:
>
> Commit d8507429f15c ("secilc: Add program that checks CIL neverallows
> against a binary policy") added secilcheck to validate neverallows agains=
t
> a binary policy.
>
> When a violation occurs, secilcheck attempts to locate matching allow
> rules in the CIL AST. However, since the CIL AST in secilcheck only
> contains neverallow rules and declarations (not allow rules),
> cil_find_matching_avrule_in_ast() returns an empty set, resulting in no
> culprit allow rules being printed.
>
> Fall back to calling report_assertion_failures() to output the culprit
> allow rules from the binary policydb when no matching rules are found in
> the CIL AST.
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_binary.c              | 16 +++++++++++++---
>  libsepol/include/sepol/policydb/policydb.h |  2 ++
>  libsepol/src/assertion.c                   |  4 ++--
>  3 files changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.=
c
> index 7ec3e781..e99405b4 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -5563,7 +5563,9 @@ static void __cil_print_rule(const char *pad, const=
 char *kind,
>  }
>
>  static int __cil_print_neverallow_failure(const struct cil_db *db,
> -                                         struct cil_tree_node *node)
> +                                         policydb_t *pdb,
> +                                         struct cil_tree_node *node,
> +                                         const avrule_t *rule)
>  {
>         int rc;
>         struct cil_list_item *i2;
> @@ -5609,6 +5611,12 @@ static int __cil_print_neverallow_failure(const st=
ruct cil_db *db,
>         cil_list_for_each(i2, matching) {
>                 num_matching++;
>         }
> +       if (num_matching =3D=3D 0 && pdb !=3D NULL && rule !=3D NULL) {
> +               int res =3D report_assertion_failures(NULL, pdb, rule);
> +               if (res < 0) {
> +                       rc =3D res;
> +               }
> +       }
>         cil_list_for_each(i2, matching) {
>                 n2 =3D i2->data;
>                 r2 =3D n2->data;
> @@ -5683,7 +5691,8 @@ static int cil_check_neverallow(const struct cil_db=
 *db, policydb_t *pdb,
>                 rc =3D check_assertion(pdb, rule);
>                 if (rc =3D=3D CIL_TRUE) {
>                         *violation =3D CIL_TRUE;
> -                       rc =3D __cil_print_neverallow_failure(db, node);
> +                       rc =3D __cil_print_neverallow_failure(db, pdb, no=
de,
> +                                                           rule);
>                         if (rc !=3D SEPOL_OK) {
>                                 goto exit;
>                         }
> @@ -5708,7 +5717,8 @@ static int cil_check_neverallow(const struct cil_db=
 *db, policydb_t *pdb,
>                         rc =3D check_assertion(pdb, rule);
>                         if (rc =3D=3D CIL_TRUE) {
>                                 *violation =3D CIL_TRUE;
> -                               rc =3D __cil_print_neverallow_failure(db,=
 node);
> +                               rc =3D __cil_print_neverallow_failure(db,=
 pdb,
> +                                                                   node,=
 rule);
>                                 if (rc !=3D SEPOL_OK) {
>                                         goto exit;
>                                 }
> diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/includ=
e/sepol/policydb/policydb.h
> index a1b5e99b..cf14e26a 100644
> --- a/libsepol/include/sepol/policydb/policydb.h
> +++ b/libsepol/include/sepol/policydb/policydb.h
> @@ -714,6 +714,8 @@ extern void cat_datum_destroy(cat_datum_t *x);
>  extern int check_assertion(policydb_t *p, const avrule_t *avrule);
>  extern int check_assertions(sepol_handle_t *handle, policydb_t *p,
>                             const avrule_t *avrules);
> +extern int report_assertion_failures(sepol_handle_t *handle, policydb_t =
*p,
> +                                    const avrule_t *narule);
>
>  extern int symtab_insert(policydb_t *x, uint32_t sym, hashtab_key_t key,
>                          hashtab_datum_t datum, uint32_t scope,
> diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
> index 8f829e7d..94172e5a 100644
> --- a/libsepol/src/assertion.c
> +++ b/libsepol/src/assertion.c
> @@ -504,8 +504,8 @@ exit:
>         return rc;
>  }
>
> -static int report_assertion_failures(sepol_handle_t *handle, policydb_t =
*p,
> -                                    const avrule_t *narule)
> +int report_assertion_failures(sepol_handle_t *handle, policydb_t *p,
> +                             const avrule_t *narule)
>  {
>         int rc;
>         struct avtab_match_args args =3D {
> --
> 2.55.0.679.g6767b8d81c-goog
>
