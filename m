Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2027F3C945A
	for <selinux@vger.kernel.org>; Tue, 28 Apr 2026 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391384; cv=pass; b=LnbznRks89jT+3iUYihwfgdBPe1w1IvuOp3FwaNApn+/ZTQLSHCah+oDq+72wwaoaNf0gxi3T4uHSl8KL9Xa5Scuer1KaiVH7LLAb3bUMSXRPdVitDA6M88glQxkEqmDXXX1WQFGZLkKZt1NeN2l1dSAKAvtX9kj6F3iB4xW7Eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391384; c=relaxed/simple;
	bh=N4QHSkapAAa26gV6eeV0t1pkkcrFqgR/lEdphVHKLzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOFbwcZTJBX2kQTXZqba5Qq40dHHOWoX2C1anvzvQG9bzU4hNVF4515gWyvD309uK1uzcQbFWnnwH7qFuVgpA92jRxLKEFUYJqr7//9NmwJPZ9mJdHWi408kNMrY7vz/It2fcLCEwgw3uZmnGuk79YbonFe7i34olZGF2bk9MUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c77evGXW; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c77evGXW"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38e7d983f91so118214851fa.2
        for <selinux@vger.kernel.org>; Tue, 28 Apr 2026 08:49:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777391381; cv=none;
        d=google.com; s=arc-20240605;
        b=bq/JTG5Zat4sFQEAkjwF4aD5Cb6ZVuOCG9xUbLVvVLaRJ1CtIRg9v3BS7C8OvI/PTI
         tihp4KO6EFhQQw23qLnjqgda86i57GgZOXbVoUBHz4F/93bXMtMC76D7P2ABimydsHcY
         hQE4H1N85kih1mbKE/vB6UQ0HbV2Yx2T2FgMuaIrIyWlFcZgsHG4NLQMSlfF7lK9C6aO
         LP2hliyczYWGFUIfTQomU3GZzbH/ckF7eyaCeFstce4tIiGkfO4WI4DHiiafGbuynWbv
         gfMM2YiJPzdFmZbrMJY82+fuVRV4rCsYbEzzvOllb+pSyHSXCkrL5BaD+5+3m2048wSq
         EZ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gKT2/29Q3BhhEBEZZ5yjh0FSOpPGfD+Vp6F+UZ7AaNY=;
        fh=VWwbX+H1Sc8ilbX5LEN836EN17/lKaPP6kwZv2JuZcs=;
        b=EOi1er6CMzNBTae/U5bb6IxZOv4QkAKxFrv6xPFzuYAsN7uXUNvaTnjn/mMRyRrZpN
         5is4I8q125Xyin9SFaH8M6WEFfUR1svwOI5mbg4WmxRUHZbm+BeD11smmaKiT71qmxKT
         4UVvaBj+1kyXIJ+08NsVRa5ejtBrGg4/Nig64tCby8fA6qUOMYDn8KfgcsxeWVaikXql
         iqXmPpTfgVo00D4Di3Ak04/OoMmPT5/vSnPJ13YFWbR/F+UFqeCXScMjE3kJfH7zv91n
         hVAJK7GeA5ZKUO393QTTegES9dh0DRw48tpWde7EeqQq8fiyMmu2eUVQZeQ4MZr7dYEj
         0q/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777391381; x=1777996181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKT2/29Q3BhhEBEZZ5yjh0FSOpPGfD+Vp6F+UZ7AaNY=;
        b=c77evGXWNEW5xnC0jSiA6BhuJN39Cz3fcnyQwEu2H+cEoovWaA5xVkBfOTHhJ3NeSe
         OXdM+nf7YpOEEHEUSoucEvVGGDuExUarDebCkcqZKRkQxCSi8xbc5zg42XA6CuHo33B5
         8qqdXVFifHam6EBLkV+JN3W9fUeTmVgSjmx4DRifhHZERxIO/92SH0hFPDFXd/fhUzN1
         NNK8adLK4LlViq/SNZYIBtwCSQ7KhRF6GmigGCXCvWOhaQvHAzr0LVwAo/SJRZIOinme
         OC3SG65RNWtcV2eliR1BClVHJpRpvYhVrwt7ooKcBs7kr8lYMjmkW7uD7dAIBu8Vkzks
         zgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777391381; x=1777996181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gKT2/29Q3BhhEBEZZ5yjh0FSOpPGfD+Vp6F+UZ7AaNY=;
        b=HzFvb6CTB1mQSsi9nnWv5JPkaXoGzpzg2+BWG8uCpi3gp6hWUTFEyNDbX/7GH8mocN
         TPbCC4VFjliUYHSmTYx1GKQiKrnwz0o94qQfXBylqXJos6X43cJ5pYGKgDqGHDHBVm65
         Josclv1S12Borbe06eN2XhJGVvqURzcegAK/6oU5uWYPiP4uJD2OXHyajRapBCfh00L/
         YvpIvst1jwmqKdi6DUwpm3GsgkIKGCs4EZKIuh3kull18nyqDC27ETd1D4CuybMXyb07
         0ec8A6WMGKSfBPxnowrdXh6HNikPFJkJOIsMSUnMnlziI7f56bP3BKznxjFIXGXZFnmE
         XnsQ==
X-Gm-Message-State: AOJu0Yw4xmwaOc8ijJcsZbQsDa5WFzYoT2bdRYJDbJVxKnfgydtJBksJ
	x+vOGvsrtYgKOWTILN+Vdx2skVpL/apgj0RaPLJONKYMtoLgk3rkR0GOCvBkb33qrhgmOmK2qZE
	WK422nUoCgzt5nwu1NU2QKVBxSAm8izk=
X-Gm-Gg: AeBDies0ZdVlSvxnlTggTe+0T7a9SmpUcBWXSVwKgxN4GktNPPxNBd2DHODh/eKLXZR
	0ip58RzcaL3NixpPq2OhXMCB936PS5Uvy1mEVG/oU62XHuG2AoVRG0A9d/EW4HKtIwzPiUD2LEc
	qRVpi68Jr+zizS/Ugy4y9Bpa+Qv9XvjyF9G6SmfkBUxqWPkDhPsorSls3Mp9Pl871+dSA5WRCnm
	1gJ8qptwPRbuAzYRTixJj4y7gq8O3G1HfYojO5taxvXkewZEQ354WIlM5O0tQS+YG8yQf/lQbJI
	PLkfBjWPr20Fslo=
X-Received: by 2002:a05:6512:138a:b0:5a3:fcb2:c6a1 with SMTP id
 2adb3069b0e04-5a74640b936mr1548423e87.13.1777391380871; Tue, 28 Apr 2026
 08:49:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414191120.29067-1-jwcart2@gmail.com> <20260414191120.29067-2-jwcart2@gmail.com>
 <87340gtgij.fsf@redhat.com>
In-Reply-To: <87340gtgij.fsf@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 28 Apr 2026 11:49:29 -0400
X-Gm-Features: AVHnY4K1Bf21k-wq7bpAVUT2SKYNECB0-DeucFIGAMlh8amr8C6KYvukqeljhEw
Message-ID: <CAP+JOzToqCFRip_CSc5RntrLkPmxG6GbziM_bh-yQT93DnUVEA@mail.gmail.com>
Subject: Re: [PATCH 2/3] libsepol: When resolving names check if a block is abstract
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 2:17=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> James Carter <jwcart2@gmail.com> writes:
>
> > Nothing in an abstract block in CIL is instantiated until the block
> > is inherited. No declartion, macro, or optional block within an
> > abstract block should ever be referred to from outside of the block.
> >
> > Check for abstract blocks when resolving names and return an error
> > if one is found.
> >
> > This patch is based on a report from the security firm Trail of Bits.
>
>
> Since this commit, it's not possible to build Fedora selinux-policy:
>
> # semodule -B -n
> Failed to resolve pcp_var_lib_t at /var/lib/selinux/targeted/tmp/modules/=
100/abrt/cil:1241
> Failed to resolve pcp_var_lib_t at /var/lib/selinux/targeted/tmp/modules/=
100/abrt/cil:1244
> Failed to resolve pcp_var_lib_t at /var/lib/selinux/targeted/tmp/modules/=
100/abrt/cil:1245
> Failed to resolve dirsrvadmin_config_t at /var/lib/selinux/targeted/tmp/m=
odules/100/apache/cil:2384
> Failed to resolve dirsrvadmin_tmp_t at /var/lib/selinux/targeted/tmp/modu=
les/100/apache/cil:2385
> Failed to resolve dirsrvadmin_unconfined_script_t at /var/lib/selinux/tar=
geted/tmp/modules/100/apache/cil:2386
> ...
>
>
>
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/cil/src/cil_resolve_ast.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_=
resolve_ast.c
> > index bcac4026..b0965f1d 100644
> > --- a/libsepol/cil/src/cil_resolve_ast.c
> > +++ b/libsepol/cil/src/cil_resolve_ast.c
> > @@ -4355,7 +4355,7 @@ int cil_resolve_name_keep_aliases(struct cil_tree=
_node *ast_node, char *name, en
> >               node =3D ast_node;
> >               if (*name =3D=3D '.') {
> >                       /* Leading '.' */
> > -                     symtab =3D &((struct cil_root *)db->ast->root->da=
ta)->symtab[CIL_SYM_BLOCKS];
> > +                     symtab =3D ((struct cil_root *)db->ast->root->dat=
a)->symtab;
> >               } else {
> >                       rc =3D __cil_resolve_name_helper(db, node->parent=
, current, CIL_SYM_BLOCKS, datum);
> >                       if (rc !=3D SEPOL_OK) {
> > @@ -4366,14 +4366,20 @@ int cil_resolve_name_keep_aliases(struct cil_tr=
ee_node *ast_node, char *name, en
> >               }
> >               /* Keep looking up blocks by name until only last part of=
 name remains */
> >               while (next !=3D NULL) {
> > -                     rc =3D cil_symtab_get_datum(symtab, current, datu=
m);
> > +                     rc =3D cil_symtab_get_datum(&(symtab[CIL_SYM_BLOC=
KS]), current, datum);
> >                       if (rc !=3D SEPOL_OK) {
> >                               free(name_dup);
> >                               goto exit;
> >                       }
> >                       node =3D NODE(*datum);
> >                       if (node->flavor =3D=3D CIL_BLOCK) {
> > -                             symtab =3D &((struct cil_block*)node->dat=
a)->symtab[CIL_SYM_BLOCKS];
> > +                             if (((struct cil_block *)node->data)->is_=
abstract) {
> > +                                     cil_log(CIL_WARN, "Found %s which=
 is an abstract block and invalid for name resolution\n", current);
> > +                                     free(name_dup);
> > +                                     rc =3D SEPOL_ERR;
> > +                                     goto exit;
> > +                             }
> > +                             symtab =3D ((struct cil_block*)node->data=
)->symtab;
> >                       } else {
> >                               if (ast_node->flavor !=3D CIL_IN) {
> >                                       cil_log(CIL_WARN, "Can only use %=
s name for name resolution in \"in\" blocks\n", cil_node_to_string(node));
> > @@ -4383,7 +4389,7 @@ int cil_resolve_name_keep_aliases(struct cil_tree=
_node *ast_node, char *name, en
> >                               }
> >                               if (node->flavor =3D=3D CIL_MACRO) {
> >                                       struct cil_macro *macro =3D node-=
>data;
> > -                                     symtab =3D &macro->symtab[sym_ind=
ex];
> > +                                     symtab =3D macro->symtab;
> >                               }
> >                       }
> >                       current =3D next;
> > @@ -4401,6 +4407,7 @@ int cil_resolve_name_keep_aliases(struct cil_tree=
_node *ast_node, char *name, en
> >
> >  exit:
> >       if (rc !=3D SEPOL_OK) {
> > +             cil_tree_log(ast_node, CIL_ERR, "Failed to resolve %s", n=
ame);

My testing shows that it is still building, but I added this error
message which is generating a lot of noise. I forgot that optional
blocks have unresolved things. Oops.
I will send a patch that will make the log level of this message
CIL_INFO which will mean that you will need "-v -v" to see them.

Thanks,
Jim



> >               *datum =3D NULL;
> >       }
> >
> > --
> > 2.53.0
>
