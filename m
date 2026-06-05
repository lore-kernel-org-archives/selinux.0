Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831F0318146
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780665146; cv=pass; b=OHjU3+Gmjxpeq9TGYPnLELbPlNzvA+u7Kzfm9etYu2bVCW+ecOhlUmXxGzUU9MoXCDOmD0LYP+JcK/kKbaGfAf0QqLIN/q1LO9xZpirYW/qFMufqjF9EV4TrpXzTj7eSoybqzBvJv9KHHIV7hOjbNP92qHglqjgUYRmx5lQ+VzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780665146; c=relaxed/simple;
	bh=tq2DpmG3PNdQDSLFXJpsSoHUvGFx5Kmc0oUQxp/jgR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKYPCgZCV4s54n115gXDc2wj2uKejT127OWGIFr4YN0+B1MNoymgbzIxr5JNgTn9YMDuoXPksMDAH4Eq492bJRF7D9cABXQux8CX2NMWtz3MDD5q+6tAmRFBwYMTZuiLDPFPdToo2ds4/0/YP3K2iV+ad7sTz8xm0hL9dAfhxCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5RgPPls; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5RgPPls"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-396779b9a7fso16400481fa.3
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 06:12:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780665144; cv=none;
        d=google.com; s=arc-20240605;
        b=WAPplzIQMZoTS4g4OGXnQkI9ULLQdgwGNAKf8VJHEVoiuRxYchunpEzIbeH0kpfDV/
         eJza48B3mdKgx6lsqtkKVU1k4KVkxl4/izCH6olxb6OXKhuYIoJjF5RnnVNelTziPdqi
         +aP70jp5tqau2J4wBW7xoiQsXOPveirr4XPCehV7xdOSo0D4eqm/OwB/1nLuvNzU58K0
         psscF3q7BfH8D9o7RvUw9Gc5xcFZwoXdhFCD70sJ6L7BU7kKxUfOexid+hciewIkrPh7
         GA1GH43I1Q/oyLxh44LwM52b7iT4XtWtcokowbzBNmUs5OlurRhTfuc92+mPbiehuRzU
         f7qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EoD3zoTWGdFDfrAqfwBxw1Gc67O7o9+UXXXlOsyrFPE=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=CCLMvglNZbH6Xpl9uJZKaFwmvFk7v4WWGU5pfRofeEe4i+7VwXa7Y0qLVa7So6ruyG
         QhSMpQblJD1VTYkpoHYaPOvX2YJp2BAZh+FDjrddKS/oAGbhlLJF89O8obm97oE4ktZG
         T90/8C6WV5F4BVzWh5pw4S2vsSKG/ia9e/2PntlTSmFYnmRzKcZ8llr4cH8jF74AYtYK
         bir+NTQ9v39s7opE0cAws2kW5fQkvWRFK+7YZ2h7hFWQTMpHI/eYfR5jTGrEsFFnBGsX
         D/nGPBPyYy1gEEiwKvOvhvttYYlDYHUV2rVFnyR9ZvjAWK1RnnQdKkzi7wGVZLvLYYRY
         KIHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780665144; x=1781269944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoD3zoTWGdFDfrAqfwBxw1Gc67O7o9+UXXXlOsyrFPE=;
        b=Y5RgPPlsFdNgM/ooaACqV7hsuOyTfQvInTDUzHwyjfbqUcdk6mdG6b+wKyw50KzKGe
         bAJYz8/SVWXWxZSqXU2sdbSJQoRCmk8h9ckyRepwj6bHbe4donPRnv5rQ249xgGoVZMB
         +WGV0FpRY1BZipiGNoyMKETzgHzKOY30iIQS2pdEbigaSsS4KfXrVkNWHZjnKn7gRo3y
         aOq8bPjJ012G7Ikq42WT9SXjyiF/iOm2I3fJUmQpHNh6ZCe5Hh6jxACIliR3DXAhPSy6
         S5ZV7taZwEVf3g2KcNwmMTc4/HHQRyyxePhC/ee9tzRl6UprS9Lz/7U1BfqvhgkGh//W
         QF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780665144; x=1781269944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EoD3zoTWGdFDfrAqfwBxw1Gc67O7o9+UXXXlOsyrFPE=;
        b=UbByrkPmjVvaY3Vl5H919PiBOulUKIMnzLoGw34Bj5x+7rXbU/J/0lgew0xI+1MPGv
         VJwfLHwEimkbGvSK3oSHD5g3Kp+2zOkt71O5/8PEIgIoLgwSFzhbjpKyryG+67YlJ/Rg
         h6VVWMrSjreUcG4jfo4hkG7rJl/rrWBHsc8/cG9m/aEOau3IZC9oyHo22SB9HggcSfcp
         1+lVsR5ewRF4zxRYWsmXGBQlTKI1DWRvg49OnqaZTRGJAH8QEZZfjhnfUNAznoBblS2E
         lzldJTBpbrxSbnSHxMAMi+cSHvQZLYssrhqsElHUQb+oiVINMJZ1j6JBWtQUiHn5q8oO
         ZOTQ==
X-Gm-Message-State: AOJu0YxTEhWp60vqd15RfkW4cEcPNwYs/itphDOYtlTs/KV/K+qMk+ZV
	w0GUTD0k4EzocIjPfqghKnXnU20Rh6be7aQDyqtcAzaMx3+eqpYfxXm6RZkpSp2EMPcS8/ApOqU
	0Z3m8sLetSztXUxY/gDFNnMQFZQwBj+Q=
X-Gm-Gg: Acq92OEYHdm3arB7p6NwEGB+MxZ7escTN7tMCheP+OO/AxNS1xy/pUNGqQrFo6IBoo0
	FpiBbrt+HUYJseMAv+0vewqSKT7yykLVM4wGVXAO5noe/5BnbTC/zdDluYijWwJofK1wAJHlunW
	9WwjCnZXRggQhTnbCwWrZr0CZ7RHTIBM1ijb8PUdecI3ov4bhvGMmUQUCst8lbFGfEytRH0LrkU
	i25scVQR3mPhbKqGI8CST4ymYQ35f7JffcjhV8He493miLNeBvk7gaz6QbtkygExQtxM1ZjwP7r
	Xx53KdgRY/q2m70=
X-Received: by 2002:a2e:2ac5:0:b0:396:6b67:b53e with SMTP id
 38308e7fff4ca-396d0985758mr8827831fa.17.1780665143433; Fri, 05 Jun 2026
 06:12:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604162748.37719-1-jwcart2@gmail.com> <CAEjxPJ67ijKe05-YwcbtC0NezqmABTwf+pez7CtHktWa3n93ZA@mail.gmail.com>
In-Reply-To: <CAEjxPJ67ijKe05-YwcbtC0NezqmABTwf+pez7CtHktWa3n93ZA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 5 Jun 2026 09:12:12 -0400
X-Gm-Features: AVVi8CcY_EofpVKQp-KsJD_zjb9rkjgYVsfXhI464f2fso3UldZsL3IqKgqo2Ts
Message-ID: <CAP+JOzRZ7VrTjrYJyqhpmRJ8J2qm9Eidpim=Gj+WsnocpoNJ-A@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Fix type confusion when writing policy.conf
 from CIL
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 12:42=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jun 4, 2026 at 12:35=E2=80=AFPM James Carter <jwcart2@gmail.com> =
wrote:
> >
> > The functions __cil_cons_leaf_operand_len() and
> > __cil_cons_leaf_operand_to_string() use the list pointer instead of
> > the item pointer when writing out a list of names in a constraint
> > expression.
> >
> > Fix both to use the item pointer when processing a list of names.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>

Merged.
Jim

> > ---
> >  libsepol/cil/src/cil_policy.c | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_polic=
y.c
> > index b56fbc81..7f20b7b7 100644
> > --- a/libsepol/cil/src/cil_policy.c
> > +++ b/libsepol/cil/src/cil_policy.c
> > @@ -382,12 +382,11 @@ static size_t __cil_cons_leaf_operand_len(struct =
cil_db *db,
> >         } else if (flavor =3D=3D CIL_LIST) {
> >                 len =3D 1; /* "{" */
> >                 cil_list_for_each(i1, (struct cil_list *)operand->data)=
 {
> > -                       struct cil_tree_node *node =3D NODE(operand->da=
ta);
> > +                       struct cil_tree_node *node =3D NODE(i1->data);
> >                         if (node->flavor =3D=3D CIL_USERATTRIBUTE) {
> > -                               len =3D __cil_userattribute_len(db,
> > -                                                             operand->=
data);
> > +                               len =3D __cil_userattribute_len(db, nod=
e->data);
> >                         } else {
> > -                               len +=3D strlen(DATUM(operand->data)->f=
qn);
> > +                               len +=3D strlen(DATUM(node->data)->fqn)=
;
> >                                 len++; /* " " or "}" */
> >                         }
> >                 }
> > @@ -554,12 +553,12 @@ static char *__cil_cons_leaf_operand_to_string(st=
ruct cil_db *db,
> >         } else if (flavor =3D=3D CIL_LIST) {
> >                 *new++ =3D '{';
> >                 cil_list_for_each(i1, (struct cil_list *)operand->data)=
 {
> > -                       struct cil_tree_node *node =3D NODE(operand->da=
ta);
> > +                       struct cil_tree_node *node =3D NODE(i1->data);
> >                         if (node->flavor =3D=3D CIL_USERATTRIBUTE) {
> >                                 new =3D __cil_userattribute_to_string(
> > -                                       db, operand->data, new);
> > +                                       db, node->data, new);
> >                         } else {
> > -                               o_str =3D DATUM(operand->data)->fqn;
> > +                               o_str =3D DATUM(node->data)->fqn;
> >                                 o_len =3D strlen(o_str);
> >                                 memcpy(new, o_str, o_len);
> >                                 new +=3D o_len;
> > --
> > 2.54.0
> >
> >
