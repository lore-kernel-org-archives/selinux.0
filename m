Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320BB1B14F8
	for <selinux@vger.kernel.org>; Wed, 14 Aug 2024 17:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723656971; cv=none; b=XYAFj2AA5lGSfHn9TZ70l2FyD5UE8mxPj9KxSFfm+4FeZMqxNXRgjIely5mKXpiBgdfVzuYlEk6/5Cr6GKv2j0wxCWmhRhZiV8XFFWWOdWzBrqLB7SUpRl9ZLF4GGQ+5KlCGXxcxkbtvpkdGW9tk7tS/M4Uw5ObZJIDBZVHjdVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723656971; c=relaxed/simple;
	bh=IA3Xx4NNie6d3cAj6cwNmoZMSGjxIkd/uUEtsRE7cf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1fGJ1PY4AQKLrzIC58hysp3SFO0j8IYPb81HjAhpEE5/ep1LlG8c4ujMitXsyZv737GnJwpchJ7x9HoxsnOrpcpRrFzoIfS9G6MWZtol98hu/PkQTwGMdGuA/pV1bLcfmZcIYIa6wqGzwvlyXmZ+cKy4yH7wGgL3DuVJ+/Yigg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IC7FeLiK; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IC7FeLiK"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-492a09d4c42so47842137.0
        for <selinux@vger.kernel.org>; Wed, 14 Aug 2024 10:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723656969; x=1724261769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlcIpGkDZ+GfvlHGM7Idk9L8ZoKm1VMuS7plF2ev71g=;
        b=IC7FeLiK/khe9u0qQvFNHp5sX2rjFcromMbao+fFdAtseZerlr7djEagp0/oZeiLf8
         vCXGewgCH2fKob8ylF7gZkhKOrHrzUlSgLlLbZAkB1CIHXrXAJ4VQBYxoOmJFTnlP0tp
         j+G6UZvnGbJL1ilHVCcYPa9JQlZOBnddBFDKb+4Cj+HJnUD/cUQtrAC1VfKqvVeHLuiy
         +aFAYgLPc+uv60OXnyp61Udmdy4Tf3t56s9/nTLJM4Ixc5vThRJmhp9xprLo9VAEczP0
         SmYL9q39tbuCJOaazcMX0gbzeJgFKbYKZVYlnesSXD5ADhxDz2QvDlIOqX6Lyvz13OuX
         g+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723656969; x=1724261769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SlcIpGkDZ+GfvlHGM7Idk9L8ZoKm1VMuS7plF2ev71g=;
        b=NnQuFoFIpkoB6KP1ocaym9DmkYE+Tie02xSNN55/6pufYNWUDDDgr5ZboI0O9uYxqm
         Mn9UB3E9R8obPer+TO1cvhiPYHqoGgWktjJBQYP2Cg5fMlqgSY7q54/E8/Xydw9Ypo6B
         UKr3R2vP1z4lg5cOO1qv84exHwXirHaxkYmLImRqtiSxwck2tOZgk4ymp7RHfH0dJ/H7
         P/jfNmRA3QU/8V2HbGgQWmRWa/957wjP/blID3DJYzj4rhjIUXHm2lINrJfktm640BBc
         JA4+4jkZZK2fHyTyRioS10+wp+AoB+9dqk3f946/jo3yJlc1SEU8PxOVWyKc+YDdIh7M
         U9JQ==
X-Gm-Message-State: AOJu0Ywr9CJg71NjXhb4l91OWPTKRcypQios5DTISlZ7a2f82GDzsmqe
	ynB8s4fzWp7KEIJawuPfRTKJ0GEYgZGbUEM7Jkj4jbkbCqa7k56He+PKPpbjQr3eLxdsaLW2wxH
	LAgLAW6AxSiOCH3Aw9v5HbSLL9dU=
X-Google-Smtp-Source: AGHT+IENJlhJtzI0Wpx59SS4GJzgvB3z3j7Cck/X0tl0hKDMCEhvBT6nhGPPduvmpnOVWRwpKsKsaE5TEPnAdleysHc=
X-Received: by 2002:a05:6102:94c:b0:493:b0c2:ad3c with SMTP id
 ada2fe7eead31-497599acb5fmr4216748137.22.1723656968711; Wed, 14 Aug 2024
 10:36:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723144157.1242699-1-vmojzis@redhat.com> <CAP+JOzRJ1iBY+hxO8oFGJU3umknqTO0jT5M0JrnhW4dcq+ABXg@mail.gmail.com>
In-Reply-To: <CAP+JOzRJ1iBY+hxO8oFGJU3umknqTO0jT5M0JrnhW4dcq+ABXg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 14 Aug 2024 13:35:57 -0400
Message-ID: <CAP+JOzSMB0795thXAZh6=fNd+GJOJjQVeLQZDU5egQ-i05Q7ZA@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Check that sym_index is within bounds
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 1:32=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Tue, Jul 23, 2024 at 10:42=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> =
wrote:
> >
> > Make sure sym_index is within the bounds of symtab array before using i=
t
> > to index the array.
> >
> > Fixes:
> >   Error: OVERRUN (CWE-119):
> >   libsepol-3.6/cil/src/cil_resolve_ast.c:3157: assignment: Assigning: "=
sym_index" =3D "CIL_SYM_UNKNOWN".
> >   libsepol-3.6/cil/src/cil_resolve_ast.c:3189: overrun-call: Overrunnin=
g callee's array of size 19 by passing argument "sym_index" (which evaluate=
s to 20) in call to "cil_resolve_name".
> >   \# 3187|                   switch (curr->flavor) {
> >   \# 3188|                   case CIL_STRING:
> >   \# 3189|->                         rc =3D cil_resolve_name(parent, cu=
rr->data, sym_index, db, &res_datum);
> >   \# 3190|                           if (rc !=3D SEPOL_OK) {
> >   \# 3191|                                   goto exit;
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsepol/cil/src/cil_resolve_ast.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_=
resolve_ast.c
> > index 427a320c..da8863c4 100644
> > --- a/libsepol/cil/src/cil_resolve_ast.c
> > +++ b/libsepol/cil/src/cil_resolve_ast.c
> > @@ -4291,7 +4291,7 @@ int cil_resolve_name_keep_aliases(struct cil_tree=
_node *ast_node, char *name, en
> >         int rc =3D SEPOL_ERR;
> >         struct cil_tree_node *node =3D NULL;
> >
> > -       if (name =3D=3D NULL) {
> > +       if (name =3D=3D NULL || sym_index >=3D CIL_SYM_NUM) {
> >                 cil_log(CIL_ERR, "Invalid call to cil_resolve_name\n");
> >                 goto exit;
> >         }
> > --
> > 2.43.0
> >
> >
