Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C7B3BE621
	for <selinux@vger.kernel.org>; Thu, 28 May 2026 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779986765; cv=pass; b=p9kvX0L61Ll9PzIT3OyHZYqHOqYOFEgUcAX2h0HaM7HTS1tuzSjVyaws21BomEI9uWdsDvSA97DAjLJsSQd+fMojsCxmkiPfqsy7595tWs7bWElt3LfJOkkFNsc6+W4xSw1v9nm7g2mArMdtRAa56mJ2yUg/uJiP63I3Siy5/NA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779986765; c=relaxed/simple;
	bh=VlLrP79zff+VXV77dRwuczkrovvYdxzxQ2N5UioNsww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pc1gpIBNdm9y6xCsvg1CGEyhKPkHktmhQcNfRNBv1i1ipS5W5n/QmU+mwg02ej3OKcY4QBayl7YO9dG/AkCk3+OmiitZFPEMVuZSkwY9QVpujIpdpAPBfStwybER/Kk7UW8dk7v0Mp0FDqFwxQmUakvnyb5RncHBR8qdscmt11A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8Q3lgGR; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8Q3lgGR"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-394413a63d3so98427381fa.1
        for <selinux@vger.kernel.org>; Thu, 28 May 2026 09:46:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779986762; cv=none;
        d=google.com; s=arc-20240605;
        b=e8wEaMpp++1ILzCa12uL2kvSAp+piXC9Zk87UC83CSlOdPXS8AttjkXK/G/TE9qFDv
         k6yMjrIukKtFCB1IYzSsHS/3jnGB+X6e8Ji5lnC88RRCfiXA3KH/hnJ9ATWwJtUQBS5W
         dzQOIOXEeUrJrcIsxfkDs+jGx5HU5Bl0PYX6u/fN55pDsG5IhgZmzpsxRt3SLsorK1No
         5w7sR4MyTmOBFK4fAzTMzYNfobYS5O6/YdzOPVp1dYQibiZSkFI9Ns9NZIMhFn1vfMS/
         7X44RtIBKPX8PzRydeMj/Oj1BB4EQazb/sxth3o47BqeubGOM5VPTa8+bex4CcuNU3HU
         6aHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4KG1rQfoltCblWcxJ2tNR+kvbR6tIHh2dSmX26Ivrm4=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=bQTAdAA7cgdceDw0b9ezXmBtEW3uvWGC27T/cMBryP/TtMLWeEX37YwlTWDWWYfzi8
         6K48lUoScgDftoGRgo+weEzWSS3XbT4zJghe6YwVtOlBMOLMaNoRP+OuO1ICWH9dsj/9
         XWezZKFLPvOmBOXCPFEXFJxjw3kyvsp6LPlcPHJzscTddHboeo8xY0mU4G4TcSBu+lVr
         NCvlBXfV4wGX2pMu/ROsgb6VCNp3WZZUUi35DXP2en0WU0t70V7MKZlcw0rWkaIortql
         l80+CfSG+9sXqCXKLDzH0QFgzvMw0UjrZflGMJl3Dq94wv9cVAdBSivjJnFYmMizUFt8
         gbqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779986762; x=1780591562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KG1rQfoltCblWcxJ2tNR+kvbR6tIHh2dSmX26Ivrm4=;
        b=m8Q3lgGRENyn+Ngr/d1GRIW4RapCBY1Ws2GGFzg4KZfq5iMSArPdQ5kqxfFxVXSZnI
         pSSiPsfau5OP4SPKSNxh4nbUQRpQipHLv/676JtVWh6ZgIwxruzXLHsgUR45Lg9zz45y
         Rt+Zb2rct/Lq4+iYafhePZOMVi9gM9qh3g5x0uvb+tgc7K0RfmQp/G/xVIkUefGlOozN
         AMzXYqOZVADoFpPpjanH6wG0Cy2OQmNykgC+0IbepNYjmSHPRm2/d6i5+ddrbRz5t220
         3xipTQHjH+3xcl1pPuWyMV2jokUszFJoxTVeCOVSsco/zPeQ6xF5OzxdmQWUhZMX/C7D
         Bbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779986762; x=1780591562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4KG1rQfoltCblWcxJ2tNR+kvbR6tIHh2dSmX26Ivrm4=;
        b=Dk79AhOfUOJO31sEgDMIQXATI4Nqrk3oWCQm7qI3/KTm9ESwlheiLM9HYYs940c9rr
         2dq1SB36IPcsNd3a9Fgs85Y+eh2Ed9LMCjiDaBEaH5KawgaVF9cINreFGJI1UOiOnhoa
         SM6aoXM2Hrq+rKNetffYCGGDjDVri5QI51XAKXib1pWcDVOfl1QA0SACTWKGV7GNCEzj
         X1IJCMyUDnEmHYxqyVDWM27GxWn7tk6a42aWIYWjc99hmfZXBdqiecrZg5xpi1aXjiQF
         c+jZbk99quS+vNceNu+HFM+AWPgc/oMZ2luQ7J/YL6g6yNxlR+T3YEMVHtRlqpr9y14/
         I7Jw==
X-Gm-Message-State: AOJu0Yyvq4Nfs+MPO9Tq/eNtNqgDQc1cUBASpk3IxAfsvLc+tp753hFS
	l8VjkRw/cr/sTtTEfqB22Wvk9/k8m8piDSmv0v+kUM5kTLjSfi3KtUsqfoeqjHOWP+vOBhNVf8G
	yUAn3l+6/G1qyaQgLrumU38JBvO8qaOBauw==
X-Gm-Gg: Acq92OFwEAx+gd3A8eva0AUvWwGCW6GI5PbDBqc2WQgUSj3dzk9ywC4TZwuBjOVQrlI
	U2KIhoCrGlpryK+C5k/us74QstxCp4+odBQGTTZoklMOarFFuJ8fK5ClY9O7Lvi/pUXSTnwlKlG
	BQtZwSWMDlI7fapxbdyjioJgXRwNvgp4lf2b+HTryqhwtPUMF4Jx42dnjECwgokeWPtPlQ9ZIST
	xhIq37t65kPaM5g/fMa9MunkGqIimYz630Qp0O3jtZeDjat3st2JSLGJTBPNb3YiNG+WQRD9REG
	Mgst6LkHsh242Q4=
X-Received: by 2002:a2e:9894:0:b0:38a:8602:71aa with SMTP id
 38308e7fff4ca-395d8cd90fcmr74311451fa.16.1779986762064; Thu, 28 May 2026
 09:46:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521190627.34885-1-jwcart2@gmail.com> <20260521190627.34885-3-jwcart2@gmail.com>
 <CAEjxPJ7yVwRtbJKUB1Bm=Vsd3X+HX2BvDDLp-5qfUytxOTqb_w@mail.gmail.com>
In-Reply-To: <CAEjxPJ7yVwRtbJKUB1Bm=Vsd3X+HX2BvDDLp-5qfUytxOTqb_w@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 28 May 2026 12:45:51 -0400
X-Gm-Features: AVHnY4Lk90wx-XBy5jHlyEJOtuo54fIJbLvjYkS9jhkExpqLVQ9QnmP2jYfJ1no
Message-ID: <CAP+JOzR3dCeaAcJV7x3GdL8YQdu8x0a-t890z7p+m6dNJOC+tw@mail.gmail.com>
Subject: Re: [PATCH 3/3] libsepol: In module_to_cil use constrain and
 validatetrans where possible
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 9:27=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, May 21, 2026 at 3:06=E2=80=AFPM James Carter <jwcart2@gmail.com> =
wrote:
> >
> > When converting a module to CIL for an MLS policy module_to_cil was
> > always using mlsconstrain and mlsvalidatetrans.
> >
> > Instead only use mlsconstrain and mlsvalidatetrans when the constraint
> > expression contains l1, l2, h1, or h2.
> >
> > This follows the example of kernel_to_cil.
> >
> > It also avoids an error that would occur if a user is referred to
> > in a constrain that then becomes an mlsconstrain. "u1 =3D=3D user_u" is
> > allowed for a constrain, but the error "unknown user user_u" will
> > occur for an mlsconstrain.
>
> I'm a little confused by the above - why would u1 =3D=3D user_u be allowe=
d
> for a constrain but fail for a mlsconstrain -
> shouldn't it be consistent between both (i.e. user_u is either defined
> or it isn't)?
>

For some reason users are not added to the symtab on the first pass,
so using a user in an mlsconstrain fails, but the normal constrain
works because it is after the user declarations.
Jim

> Likewise would be good to have an explicit test added for this.
>
> Otherwise,
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/src/module_to_cil.c | 24 +++++++++++++++++++-----
> >  1 file changed, 19 insertions(+), 5 deletions(-)
> >
> > diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.=
c
> > index f736288c..79d34576 100644
> > --- a/libsepol/src/module_to_cil.c
> > +++ b/libsepol/src/module_to_cil.c
> > @@ -1742,7 +1742,7 @@ exit:
> >  }
> >
> >
> > -static int constraint_expr_to_string(struct policydb *pdb, struct cons=
traint_expr *exprs, char **expr_string)
> > +static int constraint_expr_to_string(struct policydb *pdb, struct cons=
traint_expr *exprs, char **expr_string, int *use_mls)
> >  {
> >         int rc =3D -1;
> >         struct constraint_expr *expr;
> > @@ -1762,6 +1762,8 @@ static int constraint_expr_to_string(struct polic=
ydb *pdb, struct constraint_exp
> >         unsigned int num_names =3D 0;
> >         struct type_set *ts;
> >
> > +       *use_mls =3D 0;
> > +
> >         rc =3D stack_init(&stack);
> >         if (rc !=3D 0) {
> >                 goto exit;
> > @@ -1803,6 +1805,10 @@ static int constraint_expr_to_string(struct poli=
cydb *pdb, struct constraint_exp
> >                                 goto exit;
> >                         }
> >
> > +                       if (expr->attr >=3D CEXPR_L1L2) {
> > +                               *use_mls =3D 1;
> > +                       }
> > +
> >                         if (expr->expr_type =3D=3D CEXPR_ATTR) {
> >                                 // length of values/attrs + 2 separatin=
g spaces + 2 parens + null terminator
> >                                 len =3D strlen(op) + strlen(attr1) + st=
rlen(attr2) + 2 + 2 + 1;
> > @@ -1979,18 +1985,26 @@ static int constraints_to_cil(int indent, struc=
t policydb *pdb, char *classkey,
> >         int rc =3D -1;
> >         struct constraint_node *node;
> >         char *expr =3D NULL;
> > -       const char *mls;
> > +       int use_mls;
> > +       const char *mls =3D "";
> >         char *perms;
> >
> > -       mls =3D pdb->mls ? "mls" : "";
> > -
> >         for (node =3D constraints; node !=3D NULL; node =3D node->next)=
 {
> >
> > -               rc =3D constraint_expr_to_string(pdb, node->expr, &expr=
);
> > +               rc =3D constraint_expr_to_string(pdb, node->expr, &expr=
, &use_mls);
> >                 if (rc !=3D 0) {
> >                         goto exit;
> >                 }
> >
> > +               if (use_mls) {
> > +                       if (!pdb->mls) {
> > +                               ERR(NULL, "MLS constraint expression in=
 non-mls policy");
> > +                               rc =3D -1;
> > +                               goto exit;
> > +                       }
> > +                       mls =3D "mls";
> > +               }
> > +
> >                 if (is_constraint) {
> >                         perms =3D sepol_av_to_string(pdb, class->s.valu=
e, node->permissions);
> >                         if (perms =3D=3D NULL) {
> > --
> > 2.54.0
> >
> >
