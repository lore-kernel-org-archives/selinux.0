Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0390F3DD86E
	for <selinux@vger.kernel.org>; Tue, 26 May 2026 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802044; cv=pass; b=iSG019pZyHetvyQCNgddq0sdYZmXFw49p3wqiAMs0WaAaLt88KIqVyOPx8Ng6DPAD3rlqxKSVSyt5ocfO22DMjhzfw1qqJ1Jhwqcpvgxagi1eqIolwkDn999oamYWrlsZYGFyKEmvMhi14iXG55O7bXebx3Ryajl+OgDFHNtSeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802044; c=relaxed/simple;
	bh=SI3rQvy3C7tsu0Ive0W4tAIAWaZML7kU9OIh/r6saRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tex3pGb8c7J864jECdk9DGZzXWAjozyBD11y787iOV66EyjfWfD0mb2Zex926FPhVlnWsFjDQMYdD0nBmHwhBw8HwzmbKYXhsZqbeeByknHWjRA/RPKlROTxk0oD7pynNCcpYhpjRRXATnoIcIEHZuv9PclBlUMaijlBbhlehcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHvexaYc; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHvexaYc"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3664df32e91so12212814a91.3
        for <selinux@vger.kernel.org>; Tue, 26 May 2026 06:27:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779802042; cv=none;
        d=google.com; s=arc-20240605;
        b=XWCoaR4dEe58I0+G9NlTOpOwKQwMJSVMNZuioxH6oz66cz1RcPLx6vhDzvl96IGhz1
         kALLdiHqebgqAKXgGt3YoO3rvIJiETIMQZhYcFVwT2yie6SmeWpPjywG/f2ZQGbsyypf
         2vUZ7NBZy4wmW2HC3n0UwNDZNYRVA/p2rTG7Fhr42j4KVp74FZwXVjzs6VMcxPoXYfyo
         m2628wteziaKImFhBGUQYBKI1o8jpNyxPq+mw4Arfi5btpAfAPEGX7eVDEtl1g8znJYA
         YF4KK15X4dXZwBXxMwKH28SoGk5e4+xwJx7BQhbO7x5/EtKOTr70lB/tVuMlLYcFpCkH
         Vjng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/WB596cP7iPvaIKpYrzOX05m1BishXEYuf+CQFF6AdU=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=WgYJVrXmeUjn4JNFgXvcA533J2Hx6kfNNwh7+OMI0KGlYJUON91xXrvD73baEtWYs/
         GZsYl7+m9icziqsyaRkXdKMW30sL/bKfmbj5QXusGAAbf86XPHJ2YHDNKgW81RAV2pTo
         IN6JOiIPuKtEtNNa+2LOfguiXIHTXe3tB/CGbmadrG5+eKx55oq/uHWIiI/W0ZNsVv66
         lwFFpTejZkRqcimuOPyfFgBw3HE4HMvbd00GIH2Lis3WyC+/ODO6kttZHyvlbPsgMID9
         /VfzPUwrilI/uPU/uix+0S810YqY6+SJ5Bu1Qf2b6nBh0IuaqO0ewlrlpeTmR4spy0wT
         K9Jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779802042; x=1780406842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WB596cP7iPvaIKpYrzOX05m1BishXEYuf+CQFF6AdU=;
        b=iHvexaYcIuPHVm9EfwWeolmDS0WyPDK0h4AQelDcrRJmmWVIPLJnPwM/eEhIrF8L6T
         sKA2dPvQ+MnPMffiKYdcSbZLlg0+TKZmjUrlBLTzMKWgZYzTwznDa+sF16Nv/s9i0G4W
         +kKhQk/8qMc0ocNjPrdNB8aIcCwSOe6cUKqzcdBUMLOsjSAgkfAilzLAs2xh4WU56smE
         jpuuoIHtvX2e4tCXNoVAWHYmQ/wmUmdUh/mlAtZOckzgi9qD180+PIwfaSJ/7koB3ZgL
         a8vZ1roUyukQhwOB+teiqgRSIMMAFf7qD4T5kfvqMXG70RxdWNE/xw+W1khQfrkHVzhc
         VugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779802042; x=1780406842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/WB596cP7iPvaIKpYrzOX05m1BishXEYuf+CQFF6AdU=;
        b=L/LPXpXaick06XwCPG6esrjniJobAhbwlUoAjIqSW2wdRgPpvaPd+BAcBHWMj7kIE0
         eVx9IQypiP/uOxf79As8iTNLCAmGR7MEiOU7FNbI4kE38KNmzaJWd80KM3xgy1xV0u+M
         PJiD0XRmDOTpLDi5ia6U5Kgu6M5vVn89J+cFhlC74BFKxgxcY/k0mMFC2f5339YW699g
         uGDuzKy1xH9JjE6xJR1kKkMquzBjlAzGZkJ2VU2QdLKPNvJmFkH2P2pVgOVsTpPjcVz0
         6AhWkSxavMhnw9Yl79zQRBtX5tZP8O1ZQVkCeGywNxq3Ks3QvY77TdInmMX40UKkhLhZ
         qlWA==
X-Gm-Message-State: AOJu0Yz3Mmthq6BaomOlSB2rl9hGC2qYN9XseO73DwEg6VOiilON/srB
	uKie1aEBqsD+0P5p5E2qlmXUhr57NLAs76QQHSLCdouo5wRuDNomQE6/V5bbZURljVpP0B/1kEp
	tPa5TdoQW4tUZuRlpV+iD4A57xsb5mh+BjwBZ
X-Gm-Gg: Acq92OGtD2408Ut5c95uZKlhsYvQ68G8/UMXOwS391aIXpX+2u+VIOgvivTBvcP9xWA
	4Gcm7Qt6KPVJHmWamTn5jHCWM5QNABopOVzjsMHJ7jPOogsZ3mBWwTAl6REuGN7O40VTGmhhIDp
	d27HohL29jZ1/vdKOHWC7T1wRomtw9Md514zf17vDNorLe+uW1dD/A0DMEZBPA0O7intURzBdXS
	EuBZFx8pY3idfzGqnXeRiAU43pLrNkUkKJDmHKXqq1qk6C/jNjWGgayIT+KGUEt8ju2baqd0F6b
	1yP1mVuc2rahb4fumQ==
X-Received: by 2002:a17:903:f90:b0:2bc:dca9:f0ef with SMTP id
 d9443c01a7336-2beb0770a09mr219814105ad.36.1779802042250; Tue, 26 May 2026
 06:27:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521190627.34885-1-jwcart2@gmail.com> <20260521190627.34885-3-jwcart2@gmail.com>
In-Reply-To: <20260521190627.34885-3-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 26 May 2026 09:27:10 -0400
X-Gm-Features: AVHnY4JFyuOz-qX9PfWMxedy8CijWGxse6c0nFPAYETjRCI4yZCq6Vr811RraIw
Message-ID: <CAEjxPJ7yVwRtbJKUB1Bm=Vsd3X+HX2BvDDLp-5qfUytxOTqb_w@mail.gmail.com>
Subject: Re: [PATCH 3/3] libsepol: In module_to_cil use constrain and
 validatetrans where possible
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 3:06=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> When converting a module to CIL for an MLS policy module_to_cil was
> always using mlsconstrain and mlsvalidatetrans.
>
> Instead only use mlsconstrain and mlsvalidatetrans when the constraint
> expression contains l1, l2, h1, or h2.
>
> This follows the example of kernel_to_cil.
>
> It also avoids an error that would occur if a user is referred to
> in a constrain that then becomes an mlsconstrain. "u1 =3D=3D user_u" is
> allowed for a constrain, but the error "unknown user user_u" will
> occur for an mlsconstrain.

I'm a little confused by the above - why would u1 =3D=3D user_u be allowed
for a constrain but fail for a mlsconstrain -
shouldn't it be consistent between both (i.e. user_u is either defined
or it isn't)?

Likewise would be good to have an explicit test added for this.

Otherwise,
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/src/module_to_cil.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index f736288c..79d34576 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -1742,7 +1742,7 @@ exit:
>  }
>
>
> -static int constraint_expr_to_string(struct policydb *pdb, struct constr=
aint_expr *exprs, char **expr_string)
> +static int constraint_expr_to_string(struct policydb *pdb, struct constr=
aint_expr *exprs, char **expr_string, int *use_mls)
>  {
>         int rc =3D -1;
>         struct constraint_expr *expr;
> @@ -1762,6 +1762,8 @@ static int constraint_expr_to_string(struct policyd=
b *pdb, struct constraint_exp
>         unsigned int num_names =3D 0;
>         struct type_set *ts;
>
> +       *use_mls =3D 0;
> +
>         rc =3D stack_init(&stack);
>         if (rc !=3D 0) {
>                 goto exit;
> @@ -1803,6 +1805,10 @@ static int constraint_expr_to_string(struct policy=
db *pdb, struct constraint_exp
>                                 goto exit;
>                         }
>
> +                       if (expr->attr >=3D CEXPR_L1L2) {
> +                               *use_mls =3D 1;
> +                       }
> +
>                         if (expr->expr_type =3D=3D CEXPR_ATTR) {
>                                 // length of values/attrs + 2 separating =
spaces + 2 parens + null terminator
>                                 len =3D strlen(op) + strlen(attr1) + strl=
en(attr2) + 2 + 2 + 1;
> @@ -1979,18 +1985,26 @@ static int constraints_to_cil(int indent, struct =
policydb *pdb, char *classkey,
>         int rc =3D -1;
>         struct constraint_node *node;
>         char *expr =3D NULL;
> -       const char *mls;
> +       int use_mls;
> +       const char *mls =3D "";
>         char *perms;
>
> -       mls =3D pdb->mls ? "mls" : "";
> -
>         for (node =3D constraints; node !=3D NULL; node =3D node->next) {
>
> -               rc =3D constraint_expr_to_string(pdb, node->expr, &expr);
> +               rc =3D constraint_expr_to_string(pdb, node->expr, &expr, =
&use_mls);
>                 if (rc !=3D 0) {
>                         goto exit;
>                 }
>
> +               if (use_mls) {
> +                       if (!pdb->mls) {
> +                               ERR(NULL, "MLS constraint expression in n=
on-mls policy");
> +                               rc =3D -1;
> +                               goto exit;
> +                       }
> +                       mls =3D "mls";
> +               }
> +
>                 if (is_constraint) {
>                         perms =3D sepol_av_to_string(pdb, class->s.value,=
 node->permissions);
>                         if (perms =3D=3D NULL) {
> --
> 2.54.0
>
>
