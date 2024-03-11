Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A12D6AAD
	for <selinux@vger.kernel.org>; Mon, 11 Mar 2024 20:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710189146; cv=none; b=fG1X+j8LsaPXJwKadMAx68Q3+9SYwDZPNak7x9zYbOvn7Ylq/xwrjiVGtUgtKoYPJTz6kxwiWc+3eyu3bC2/4OvrstiZTblK1Kvw3gTLQsadIdnMAa5i9NQ0HlCkpY257PA9EF9wxU1yQBuieAaFEkWzJQ1AM7JtTUjsGNbt+KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710189146; c=relaxed/simple;
	bh=O0Nlcqvr9LO9Aju5Bd439ARfh2rULcED5m1oAp8WguU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VesLxWMvu47biYCHIVVqmMHiJE7Qr182wJWadRwLOZqBtoom+04j09hvr0JM61w2dOqcNE0xUBENr6z2NCSvy8zyvS4l9N5Dq/3BRKhcK/RLWZt72ikOPsrta/72RHk41wWD4O94cNsCOigr0VEsqJnYP2E5WEaomVh1OfMMuRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnW3thgn; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnW3thgn"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7db44846716so1924262241.2
        for <selinux@vger.kernel.org>; Mon, 11 Mar 2024 13:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710189143; x=1710793943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ed9BsA324gkGlxi9y1ttuAehz2an0uZIQZyVI6XSxMY=;
        b=DnW3thgn6zMC8D89Exp+IW3MISiO8PFEga8pM3AxbFGB9oJXNwnLyXX4mHhXhSeYA8
         0qGfNmbOpxn/ZFTvAb08EssCDgRblDfk9HVANLhut1dW/mrTCxA9sAkZNXqjThnF5C77
         PKuYgHx6QH9oBOuXWEC3AVTZH6TCNCq8HGnOVUd5K00pKtNAQ9MxqmZLf/tat9RvytUh
         Lx8WHnckDYbReuDM3C5gmaXq96Bhs5o5sD7oMJaxU4UWgoatCzx/Hx1UsNDMEvY560Fa
         z69+EujJ2B0NiMw8dADbmuP6e2Vq+hg4uNLzLdpWnwq32/IVaOj4Nv8LlVbXksRbGFGW
         qgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710189143; x=1710793943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ed9BsA324gkGlxi9y1ttuAehz2an0uZIQZyVI6XSxMY=;
        b=fgf11kZ3iKnedSqOpuHhMpemiAcWq5R5Jp121lJteYCRN8ZRNZDk60mWE7wironC2O
         8L9ocut3rJffSr3CcGe4GPzLirXWuUDYuHc1X0nVtTvU6I3PR5fDJBFI+5mdeFJgLcny
         KDZrMt+8Fa4/VDWhl0qBQFDQaf7sWg5pnNJoXBdbSZQVCh+hd4BkEq8T0NnA6O8zYCG6
         UOvlWVhpvJCeZ0p3lSFA6wqPE7EvOKzuMtReJZ0/N9gBCAo46qtBMGgUMF50lBtYfMEM
         dT2MP0EZj9ewitqcOZFqqVxEA4OHNNQnayjygcsHByDK/SE0q4sIcQf63deLuqDi0cD+
         o72g==
X-Gm-Message-State: AOJu0YxLYinXailr1cVjXxB81oKyLaIuMIl6qnjNcafY+3NAJBALVnbW
	thZ4bJwF06w/SoBp3t0IBFPKFhZzjlYTMgbqbZZxwBm/69pDdRr7Zug73DDWn9bc1KPx1h/KMEL
	+enjBiyPhPpC9bN+Lx1b/xWLwdDCPm+Jq
X-Google-Smtp-Source: AGHT+IEQXbWULoiohfKWr5d+afV1NT8auljRgTTvSfgeQ24lU+nAcWYmaUMz3iEkmfktp7MPFC5yDuCQDga9T2UPc/g=
X-Received: by 2002:a05:6102:313:b0:473:1d10:13e with SMTP id
 19-20020a056102031300b004731d10013emr4580807vsa.9.1710189143519; Mon, 11 Mar
 2024 13:32:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311124832.2659731-1-jwcart2@gmail.com> <CAJ2a_Df=V+sMzA9K1Qu-1PVYnrthq=kQMgtMZL3txO-a+jytsg@mail.gmail.com>
In-Reply-To: <CAJ2a_Df=V+sMzA9K1Qu-1PVYnrthq=kQMgtMZL3txO-a+jytsg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 11 Mar 2024 16:32:12 -0400
Message-ID: <CAP+JOzSHKgB4Wfdb9VqYkx+NoCpCLmtouDXrS0s4e5=wc0BHug@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Fix buffer overflow when using sepol_av_to_string()
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 9:48=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Mon, 11 Mar 2024 at 13:48, James Carter <jwcart2@gmail.com> wrote:
> >
> > The function sepol_av_to_string() returns a list of permissions
> > with a space at the beginning. This fits the normal formating of
> > permisisons for a policy.conf policy which uses a format of
> > "{ p1 p2 ... pn }", but not the formating for a CIL policy which uses
> > a format of "(p1 p2 ... pn)". Both kernel_to_cil and module_to_cil
> > skip the space by using "perms+1", but this is a problem if there
> > are no permissions because sepol_av_to_string() returns '\0'.
> >
> > In kernel_to_cil and module_to_cil, check for the permission string
> > being '\0' and return an error if it is.
> >
> > Reported-by: oss-fuzz (issue 67276)
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/src/kernel_to_cil.c | 11 +++++++++++
> >  libsepol/src/module_to_cil.c | 12 ++++++++++++
>
> I think there are also two occurrences in libsepol/src/kernel_to_conf.c.
>
> Also: s/permisisons/permissions/
>

Thanks, I was thinking that it was just a CIL problem.
Jim

> >  2 files changed, 23 insertions(+)
> >
> > diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.=
c
> > index a081915e..e20ba4af 100644
> > --- a/libsepol/src/kernel_to_cil.c
> > +++ b/libsepol/src/kernel_to_cil.c
> > @@ -302,6 +302,12 @@ static int class_constraint_rules_to_strs(struct p=
olicydb *pdb, char *classkey,
> >                         rc =3D -1;
> >                         goto exit;
> >                 }
> > +               if (*perms =3D=3D '\0') {
> > +                       ERR(NULL, "No permisisons in permission string"=
);
> > +                       free(perms);
> > +                       rc =3D -1;
> > +                       goto exit;
> > +               }
> >
> >                 if (is_mls) {
> >                         key_word =3D "mlsconstrain";
> > @@ -1775,6 +1781,11 @@ static char *avtab_node_to_str(struct policydb *=
pdb, avtab_key_t *key, avtab_dat
> >                         ERR(NULL, "Failed to generate permission string=
");
> >                         goto exit;
> >                 }
> > +               if (*perms =3D=3D '\0') {
> > +                       ERR(NULL, "No permisisons in permission string"=
);
> > +                       free(perms);
> > +                       goto exit;
> > +               }
> >                 rule =3D create_str("(%s %s %s (%s (%s)))",
> >                                   flavor, src, tgt, class, perms+1);
> >                 free(perms);
> > diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.=
c
> > index 6699a46b..3b3480bf 100644
> > --- a/libsepol/src/module_to_cil.c
> > +++ b/libsepol/src/module_to_cil.c
> > @@ -593,6 +593,12 @@ static int avrule_to_cil(int indent, struct policy=
db *pdb, uint32_t type, const
> >                                 rc =3D -1;
> >                                 goto exit;
> >                         }
> > +                       if (*perms =3D=3D '\0') {
> > +                               ERR(NULL, "No permissions in permission=
 string");
> > +                               free(perms);
> > +                               rc =3D -1;
> > +                               goto exit;
> > +                       }
> >                         cil_println(indent, "(%s %s %s (%s (%s)))",
> >                                         rule, src, tgt,
> >                                         pdb->p_class_val_to_name[classp=
erm->tclass - 1],
> > @@ -1973,6 +1979,12 @@ static int constraints_to_cil(int indent, struct=
 policydb *pdb, char *classkey,
> >                                 rc =3D -1;
> >                                 goto exit;
> >                         }
> > +                       if (*perms =3D=3D '\0') {
> > +                               ERR(NULL, "No permissions in permission=
 string");
> > +                               free(perms);
> > +                               rc =3D -1;
> > +                               goto exit;
> > +                       }
> >                         cil_println(indent, "(%sconstrain (%s (%s)) %s)=
", mls, classkey, perms + 1, expr);
> >                         free(perms);
> >                 } else {
> > --
> > 2.44.0
> >
> >
