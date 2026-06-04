Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48E63B95F8
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 16:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780591335; cv=pass; b=RXt5ipQ6ZdKCXz0+NM8tg2Y+jN3M4wGzdvckTtjHBcE+1iK6b7z1dEhSi8qtIfgYVoAtYRqs2OHPPjCCnlRgQvXrMdikljyzoxd8TUeoYvhB7lyQ+9vnLHMQ0A2BFQulzYGNMMjXQ1vZMvI5QUcLWg7kByiVKa1im/tEqX8sTeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780591335; c=relaxed/simple;
	bh=aDte4MtL46wDaXGGHp9mZ+9w+FAWmWNfOFHbElIvfyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mgxMYb4k0E8wHKiYFMO5Y0udKH3TK/Bbbsyx1PgQFyLiRNUFKuG3p+g50XZvbwCk3tw5aoSfY5/t7E9h0ZHR+nmrkI/Z29kfVkwCpVKCeV3xJRama9XS/R2gTKMQqlXyx8BkzVTMOWTWvwQ0EOpVShliZZ2t8jhZV94B7NMiqlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdvPxqVW; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdvPxqVW"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36bb3551f6eso821051a91.1
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 09:42:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780591333; cv=none;
        d=google.com; s=arc-20240605;
        b=HCDvgO75EDuqr9XHpPF/DbGywZiaC0oMh+H6zyTEcC4C6GzTG5d5OusFox9XuxzoRU
         xOFofWB2ZE3mCinbFGuEymjGQ6eY49lR2UIDlylt7WkNieqabsoEIwp2xuSQZrxopoLQ
         BoeLNsCqNTVEGn9HoHaZuA0h42D6+cBRJFcPq4c3SN/qsVLSCYZ4m6EpwRo0DeohQXa0
         rOWBqwv7VCJtiZBHFUrwolnCVHmSDRjjAI6jPMoKsm9n2bkZi+hRNFjOrvE88tcQpxgU
         QVUM3tQYPaX7KGjhGkdQEx0JgUHNSYYYLpBQ2l4Xt7O5d7POH/M+cRVEQ9NaATbRQ8rZ
         HtEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BbIYBJaF9RYjxUbt/fa3RN2+tDBOX6SmtIyr0OlHsew=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=C9eiH2gVG99PGBzOcB+ScqrnX8QzkAvXrFj1bDzViy/kJRsjh+qVIAuc0x5UPuWt+v
         JasW2qKQJzikkr9s2L27qvOMJ5RUK/NLdxz2msdX4w6vDIbMp/uqxyzP0ikJkzgpRJRP
         DLj/CA7p6GrUYEFmIceHqr+0Dg0zr7ZPRs9NP4HV10bexymBfEBxUJqQ5YYEpAY06sRA
         Vtwnpw1AXxDNCm7gAMa7HuP2mNGRL8yNIFSFmqcnB88oHjcXEhCZoLVZRklCFOX/ByNm
         NGQkrJaKlS5ZpUreaiSVG7FZXaorlUwIhi6pIaFrRlhbP7MMlHLW7NOOMOmOddBSYSJo
         u8Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780591333; x=1781196133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbIYBJaF9RYjxUbt/fa3RN2+tDBOX6SmtIyr0OlHsew=;
        b=PdvPxqVWUi/IEF9SlCjbql76PF90yAQ0dk+TZACQbOxxgTgT0c4DCppVW4T567jSGb
         ACYl97dDvNCjbBHPJW0aGsXkOtBHTwx4Adh0O6Ky3UYYrSfwrE01ALDjh87jJrHDuzz8
         YjQAqYNRCzOw7DWgJ73cCQZY4TahHdha0B9F0pqjTw0aVEz2VZVc3jgNnvX8TMSGjfHS
         Da4/ft6h5eyfaj20W5HgByeLzkXOflnHAsbvpfTmPgb5YPHJ/MOn25aPV9PBCRXiAwaH
         c4ZfJxGzSjqO3764cueKN5vFieCbjo8lNyCD4X26gNViDG02C6gRzifOK6/h5n4ntlRL
         DKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780591333; x=1781196133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BbIYBJaF9RYjxUbt/fa3RN2+tDBOX6SmtIyr0OlHsew=;
        b=b0sVmH2sOvwo5ZbgpJm0X30ssDaOn7V0LDm8qspiWRrmfKMPniUu2NkO4YbRZjOmqV
         pR05snNJDyzO7FS0oYHCdpwNGFbFtu1IsOsrmRGOesDlWWPu8+z0I3eZ5+KWBheDX0a0
         tEIn28+eegI4lt7sxfRXuTjSNclDsQYa6aFoEgSaf8wagB64QJG4aPdphGfVA2JgP+eC
         RXamzrsxBkuY54QVE0iqgBe5Norj+ekeDLx+qSfO2WVFyu5e/qtws+CxISPUY/+KCBzZ
         FTiguRTvrmBVwOs+giWVVSZwA9XsnjfKZyq2SAvy4ZpMC7M+JBDjnSfeC/i5tymMy2FQ
         7FRw==
X-Gm-Message-State: AOJu0YycHIIUzyFMFVwlLraq43K7kYVgdeBU1c+b3KyUGMZKYUFTxPZ2
	s8Yq74w9/CR20HUd1VeFbIp2AYCRSlMl+8ywR9kqfmWUb+DN2ABS1U8or9hryYwtT7s8djhgLv4
	Z6oAd+91+4mLMMuJ43W6omxw8bgWwKuc=
X-Gm-Gg: Acq92OGTeeR72B8UuyZh9LrrxbA7hy88/W9DT+C13qTuYPK/2Lm1y0cmc40EJBemfOE
	I2vSvGXyXb/NefLmTZah8McHIAyBuNLGwqGZ1GmfWrDkxhCZvV69IzIP/iO3cdoHrglV9di7R3h
	yxiAzmfXBSiPjFD5fwL1QzkxZ6i9e9CTi4i5hacXzDArLRcsg+b2P9EMuQ0HaxJtxQti1oyLjlc
	ZU4jHBDZ85lBupWfgqaJUuXxpvGKFktzjPed+z12o7w6i/M2fWDo9Pckfv9LLmjxEfo+2DI1WK0
	N+SvW5U1rexgyQ4l9A==
X-Received: by 2002:a17:90b:2742:b0:36b:bec8:94cf with SMTP id
 98e67ed59e1d1-36e2f9a2497mr8622023a91.9.1780591333096; Thu, 04 Jun 2026
 09:42:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604162748.37719-1-jwcart2@gmail.com>
In-Reply-To: <20260604162748.37719-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 4 Jun 2026 12:42:02 -0400
X-Gm-Features: AVHnY4K-ZDIsxfch-Sr_elfUuxwjwX379JwlCzdrm094GgZvMphOubkdY7D4Xp0
Message-ID: <CAEjxPJ67ijKe05-YwcbtC0NezqmABTwf+pez7CtHktWa3n93ZA@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Fix type confusion when writing policy.conf
 from CIL
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 12:35=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> The functions __cil_cons_leaf_operand_len() and
> __cil_cons_leaf_operand_to_string() use the list pointer instead of
> the item pointer when writing out a list of names in a constraint
> expression.
>
> Fix both to use the item pointer when processing a list of names.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libsepol/cil/src/cil_policy.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.=
c
> index b56fbc81..7f20b7b7 100644
> --- a/libsepol/cil/src/cil_policy.c
> +++ b/libsepol/cil/src/cil_policy.c
> @@ -382,12 +382,11 @@ static size_t __cil_cons_leaf_operand_len(struct ci=
l_db *db,
>         } else if (flavor =3D=3D CIL_LIST) {
>                 len =3D 1; /* "{" */
>                 cil_list_for_each(i1, (struct cil_list *)operand->data) {
> -                       struct cil_tree_node *node =3D NODE(operand->data=
);
> +                       struct cil_tree_node *node =3D NODE(i1->data);
>                         if (node->flavor =3D=3D CIL_USERATTRIBUTE) {
> -                               len =3D __cil_userattribute_len(db,
> -                                                             operand->da=
ta);
> +                               len =3D __cil_userattribute_len(db, node-=
>data);
>                         } else {
> -                               len +=3D strlen(DATUM(operand->data)->fqn=
);
> +                               len +=3D strlen(DATUM(node->data)->fqn);
>                                 len++; /* " " or "}" */
>                         }
>                 }
> @@ -554,12 +553,12 @@ static char *__cil_cons_leaf_operand_to_string(stru=
ct cil_db *db,
>         } else if (flavor =3D=3D CIL_LIST) {
>                 *new++ =3D '{';
>                 cil_list_for_each(i1, (struct cil_list *)operand->data) {
> -                       struct cil_tree_node *node =3D NODE(operand->data=
);
> +                       struct cil_tree_node *node =3D NODE(i1->data);
>                         if (node->flavor =3D=3D CIL_USERATTRIBUTE) {
>                                 new =3D __cil_userattribute_to_string(
> -                                       db, operand->data, new);
> +                                       db, node->data, new);
>                         } else {
> -                               o_str =3D DATUM(operand->data)->fqn;
> +                               o_str =3D DATUM(node->data)->fqn;
>                                 o_len =3D strlen(o_str);
>                                 memcpy(new, o_str, o_len);
>                                 new +=3D o_len;
> --
> 2.54.0
>
>
