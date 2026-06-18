Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18F22EACF9
	for <selinux@vger.kernel.org>; Thu, 18 Jun 2026 12:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781786181; cv=pass; b=OSULFvojVk29zAxUKP7A6IyqhqGgySo/cbBUjCGs35WtJWHk9KZxHkTXZbNOUTaq4uIEf0oOOyohBDb9EZxByPCU4ptknpzUYt6kvCU7nhEWpjLutMn6GC25OzGFl1wD9d9yIEPa7UBhuOss/UhoEjGOonhJZ0Bcyglv7wxlHGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781786181; c=relaxed/simple;
	bh=mk3dcrfLBfGeoc3ujl2yrS7TAGJuafoIHyW1l4XI5wY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYmW4nAtlEVf/PxbQkkkmjeaTaobXFBzLzmyzvcqxjOYJOP97vJXVvQpUCn2uPfy03y6CsELJXvClITmP0To6bmzirz35IIwph3e87vTENVh05QyQbZ5R5aYKJoE2R4CSisdfN+cPQdB3NEEPumvdjIIzmpI1ww3OyeeuxPPOKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+S/5StM; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+S/5StM"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84538597e1fso482907b3a.1
        for <selinux@vger.kernel.org>; Thu, 18 Jun 2026 05:36:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781786180; cv=none;
        d=google.com; s=arc-20240605;
        b=C0/pQe5EL57Y8b3X3r/ZoyY6jAPrvh1upo3dv2YF83CuUxVQx84xflNoaxGv4oFx6+
         QV9HY6i8b6fxyA5Es1iZcybuPEwjioKeeIZAfmb6WxoQKv93AAtOV/PRTg8CHRKRJ9Q3
         C5VyvbVS1PEiZreUEch5w2hZtMwX8liPiKKQQ7XcprQVEmaQVjuj4CWB3J4CGNj9rw6X
         qCdpLKaAXQJn6Vo47+ym6jS4NQanh/RDulxbfpJg55jC7a0jBMdsaIhQsJKoXnq6J/SB
         aHM1ymFZ3w2QDObVRDuEJOdL5OG+oupu3yhwk1qCD0P3oBc6VI5gYwpGHxshICvRrnuM
         3Aiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S0c7z61Rd6NI3Er0IgA5dSuyi5iVKp5O6CXvhveCTVw=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=BhbGiksPR4NlWCdkb68KDdTq2SLjA64ZvMm1S288A4XvW83CWCBsl031wHwDcHS5D6
         GhGBqwZb3MZoDssZ4vkiEGUt+vIYS68WfGrpsEhvt8SlTN5gnUwU+usibp3JZPY9SBsY
         4QbmJ9MO9tSrVzv21lIWIyBxKXL4e5ue+3lN/hoMRnTjG6u+so0JKJ6ji2GIQBPotJ4L
         +2MUnyUFDw7oaPKFp0MRCUPPNK52gIxpDoS0jL0lEk61emXV9V+lYqmsrUyizt3xLM1y
         aHHwYx139KUWxDXDk9pLcbjWXXQcEjaJ4wJMJonf20ISrIeC6isKpW7sAdDgORQTv7jE
         Kl+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781786180; x=1782390980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0c7z61Rd6NI3Er0IgA5dSuyi5iVKp5O6CXvhveCTVw=;
        b=f+S/5StMYKDcoLol9fh7r09RAcS58alnhr95EMp0zIlnsBxkza+iRbXy/xAfdVNTPE
         ljn1yIvm0XdiYsoDR5ZVWnTVYl47UyVkX3d1siNw95IzCH0R02BOjTFKIHXZFDEGOM14
         A04ZtV/S0hF4DCpVEnBjsjrcpf5bhiYueFTZU1CD94y2DDooFSjMCNCYR4Z0py1maSzN
         KFhySBZ0J/1dHp4CB9O+cZd/nwdxN909+Nc/rpV25TC2v7zRNO3XVh9LVV0Fd1GKuGFo
         HseAeiCTadJy7Yx5kaNN3U9vrN7+PKa7IV1YI67XNIJFtrknicdzyqSVq1WtlHV+pozL
         FUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781786180; x=1782390980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S0c7z61Rd6NI3Er0IgA5dSuyi5iVKp5O6CXvhveCTVw=;
        b=Zy3UREyhDzQ82chzWcq9pD6uOjGfl5j3Kxytdb4T6HotosjVofNbDvaU4x2bcZ0sDk
         cLjtEA7rbmjLgr/CmQt0eO5TO4lEeU45WOmhikgmN9zLf+tdjavCjaeYag8+kTZJt/BD
         kSVA0sPuWHYTjtPB/scGu2cIojvd559ttKkDf2dykD7IkIvVJetjeXNDG8yT3J28eyIq
         8Peg7g/CSGdO5mwcfDLp6vS+Hm7UOr5KzdSRg0iwI7xFI71BQzgwZqFfW8KrlhxL9yqB
         R+zAQU4s1yKNhM9FiqEDO16gL0sieRDnQ0F5IQsmwpV28bJd9CZ5Z8Gzx2I+mb5ADwl9
         HcQA==
X-Gm-Message-State: AOJu0Yy2WwMAwN34booD1D7VoFzKAgHGE0izUfWlKd+iTK9It180FbLn
	uUDPfoZ+h71UZsB6CN8KEI2BlzGQtmFIfNigYVUIrn6CaTuN3zqet64SZ5z/2c+bQsGYbeFUFoK
	RLOtR4mLeXpaoiATkAzpIky36cliXHfw=
X-Gm-Gg: AfdE7cmIDQA+zq6/7dqsdq5lqq6r5LPudCBy2fZHd+sXHLfiKYTA0AHqzGv6HW4+iVG
	j7jGJzUNjywXBGD+A72Iz8hSYvk7OpedqoVQJzJV+Tz9ilsB8PeAvY73B4TnC6Cakcnyac3YY7j
	pXYUqOngAUu7Bx04I8gEMrFKq0joWbmirYqtdTDK0emPZTPO0/0JRquMP63O3hfFhub20P3vAMH
	EV7eAf1eJhGHDUluetVJolxeBkftnyCmMPvR5glEHYNqsXE8o3kJm3WMalGRwf5MiPC8yje
X-Received: by 2002:a05:6a00:2e91:b0:845:4126:222b with SMTP id
 d2e1a72fcca58-84541262426mr2777713b3a.28.1781786179862; Thu, 18 Jun 2026
 05:36:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617195645.96604-1-jwcart2@gmail.com> <20260617195645.96604-3-jwcart2@gmail.com>
 <CAEjxPJ4R0Z7d_mOJ=cYr7R+hERc6d_2_JfDSA41tKaXFaVeFMQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4R0Z7d_mOJ=cYr7R+hERc6d_2_JfDSA41tKaXFaVeFMQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 18 Jun 2026 08:36:08 -0400
X-Gm-Features: AVVi8Cd0b_8Q4nsu1dozNqlxQfi1jCdlagEywr54K21Kzmxc2uWAMYSpQVxh5XM
Message-ID: <CAEjxPJ6R6NxH8RQYq-tdmgJUB3=315c-wsKA3GKih76mm=UbYg@mail.gmail.com>
Subject: Re: [PATCH 3/4 v2] libsepol/cil: Add checks when growing lists to
 prevent wrapping
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 4:21=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Jun 17, 2026 at 3:59=E2=80=AFPM James Carter <jwcart2@gmail.com> =
wrote:
> >
> > A common idiom to grow a list or buffer is to use "len *=3D 2", but
> > it is possible for the multiplication to wrap on overflow. This
> > would result in the new len being smaller than the old len and
> > could lead to problems.
> >
> > Add checks to prevent doing the multiplication if it would wrap.
> > The multiplication can always be done if len <=3D MAX / 2 and
> > should not be done if len > MAX / 2.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/cil/src/cil_resolve_ast.c |  7 +++++++
> >  libsepol/cil/src/cil_stack.c       |  4 ++++
> >  libsepol/cil/src/cil_verify.c      | 28 ++++++++++++++++++++++++++++
> >  3 files changed, 39 insertions(+)
> >
> > diff --git a/libsepol/cil/src/cil_stack.c b/libsepol/cil/src/cil_stack.=
c
> > index d9c7b0c0..c80ed7ad 100644
> > --- a/libsepol/cil/src/cil_stack.c
> > +++ b/libsepol/cil/src/cil_stack.c
> > @@ -77,6 +77,10 @@ void cil_stack_push(struct cil_stack *stack, enum ci=
l_flavor flavor, void *data)
> >         stack->pos++;
> >
> >         if (stack->pos =3D=3D stack->size) {
> > +               if (stack->size > INT_MAX / 2) {
> > +                       cil_log(CIL_ERR, "Stack too large\n");
> > +                       exit(1);
> > +               }
> >                 stack->size *=3D 2;
> >                 stack->stack =3D cil_realloc(stack->stack,
> >                                            sizeof(*stack->stack) * stac=
k->size);
>
> Can't this still overflow on the sizeof(*strack->stack)*stack->size calcu=
lation?
> reallocarray() is good for this kind of thing.

I guess this one is ok because stack->size is capped at INT_MAX and
sizeof(*stack->stack) * INT_MAX can't exceed SIZE_MAX.

>
> > diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verif=
y.c
> > index eb732e44..ee90b0ce 100644
> > --- a/libsepol/cil/src/cil_verify.c
> > +++ b/libsepol/cil/src/cil_verify.c
> > @@ -975,6 +975,13 @@ static int __cil_verify_user_pre_eval(struct cil_t=
ree_node *node)
> >                         }
> >
> >                         if (steps =3D=3D limit) {
> > +                               if (limit > INT_MAX / 2) {
> > +                                       cil_log(CIL_ERR,
> > +                                               "User bounds checking f=
ailed "
> > +                                               "to finish for user %s\=
n",
> > +                                               user->datum.name);
> > +                                       goto exit;
> > +                               }
>
> Not sure about the error messages for all of these; they are overflow
> conditions unrelated to the bounds checking.
>
> > @@ -2112,6 +2133,13 @@ static int __cil_verify_classperms(struct cil_li=
st *classperms,
> >         } else {
> >                 steps++;
> >                 if (steps > limit) {
> > +                       if (limit > INT_MAX / 2) {
>
> limit here is unsigned so UINT_MAX / 2 would match its type but no big
> deal either way.
>
> > +                               cil_log(CIL_ERR,
> > +                                       "Class permission circular refe=
rence "
> > +                                       "checking failed to finish for =
%s",
> > +                                       cur->name);
> > +                               goto exit;
> > +                       }
> >                         steps =3D 1;
> >                         limit *=3D 2;
> >                         orig =3D cur;
> > --
> > 2.54.0
> >
> >
