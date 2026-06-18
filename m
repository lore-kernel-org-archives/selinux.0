Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB373E7141
	for <selinux@vger.kernel.org>; Thu, 18 Jun 2026 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781791836; cv=pass; b=JM4k4J8VF+5kNtEvIq2ejLKLY3dI2NIdw8gmWmgUHWyp0cIkal600jGZefj+9khNWo/3H3K1hGkCDrxsMyIfYOZBc9IRZklSDL19G3oKovnTyyjCUs0KIkt5BF3gETNzKdAgKHR9RbYCR1f/HwAOd/SiTLOBA18wyJjHC+T/zSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781791836; c=relaxed/simple;
	bh=7P4oGlceWEgHYZKnIbg3+9PEdhyAJK0/mtFqx76+Ycs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EBVvAPRjEEjqklhxIDyyS5098HiRzRmJT8KRigYc41VH1Haez4dqwE8IxhYlSpNWGaBTYLUvZB7ka2rbz28kqOk0mmOvNsUGU9I2a+yXVYhipRhcc0e9/nPdr/5ERoHKU3KUy0fkwDHXmsrO8i8pAo95UORfLSOeEKODK8nZ8og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nrmv0Pyn; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nrmv0Pyn"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36b8e1760ccso481985a91.0
        for <selinux@vger.kernel.org>; Thu, 18 Jun 2026 07:10:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781791835; cv=none;
        d=google.com; s=arc-20240605;
        b=iY2LRXTawfGw0OHHdg+99c89ZquMddC7/8ObJG2xGZAXS1Ol4tSc7+KN34Yc5QsL3K
         CrYhHUkq+TndrCL3tyNV0fhSHhaDjTg2y36OoCG7Pov/xmNC1V6speibUEKBnYPJpWJe
         pS4obQabYAPx/4W0CxaXlqZsnbTr9kml8e46JOc8LnCyth7989f03rwVyw/gAayjTb9Y
         kh0yp6nsChl89eHjNsv1s7V6xa6mqNghyAHeQlVhS6adsA+hqLOUt2mcKP2Q35jNvrrQ
         nbA/kJDZkoo93QIgCQYYjpT5WrvP7g4ao48XZi/M63rRGnspyNUJ8MivO7gRbbvMMRJK
         GewA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ooqwv3Tb2nitH2zFUMTSbFMkmt+o3xl5qJVjlehD8I8=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=ifUXQ1knEM2GK2wr5Sq3NG4hwVakYSYwDyjBOM7A1pJUszVj1SzpYDBM7vyL3EErKJ
         OaLY2EJ18sw5HEYto94ewYULcj9WDm3GBCvZUpLqwAEb0sab6+rNMcceD+8GYCDXrhdS
         kGn8L1q8NCYAF+LK2EcbX2Yx7rUMGtZztS1vNP0jq9WZGnuOD/KRixx0AmN+9TYBR7+G
         fmluz7whMgZ3Il0NEA0ULeNjeepoXTRx2ZxtY9kion0U8Jvkzy20bmqSyyp3MW4cHX6c
         Qb+OGLb9wswb5FCne2rbCiUxgoqTjzMomSzy/ofYi6OrP+Ch7D+CP7j40TivTX6C7uGN
         Sbkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781791835; x=1782396635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ooqwv3Tb2nitH2zFUMTSbFMkmt+o3xl5qJVjlehD8I8=;
        b=Nrmv0PynUubU5bsmyHLfABbizpsoNap2KCYH3c+bWU7GeTMagOO2YNU/FYjjurXFqH
         xMA9Jhd+tq/rcLf/EliD+bczxHesrAQ3B0pE7DdcE0eGF7JEOpOq0WUKogyJNKc9ciqC
         RwVSRWpjmc/7091J9pqWwaJsYLFVZkmFGSqtIELpftix0hO2Ni00rTKBZU62MIiw0HKZ
         ApXZVzq+Oexn46Ixnsf9kjJ4/vgl8LQF7xAikszDI6qqSl7VD0/D8kjL32OfN0PnF3A2
         0Wi6s3NUpTkLaQQBsoFWQM+X5s/RKXHw9lh47gnU3l8qUesNt6eIvXkXqeMFeD5/vlwj
         sbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781791835; x=1782396635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ooqwv3Tb2nitH2zFUMTSbFMkmt+o3xl5qJVjlehD8I8=;
        b=iOwiAD+UZCLkIUREHbU9n9m8Qfms9hrWRmQ/PKlysgnrXO5tdEnTRmxGV30Bl7aHNs
         LYsQKQPsMFAvoUZadXoxGF9KogrrbHs0bdov7Dx05TySpFOY0E99TLn/Y8O39uVRZyWh
         GhxKnvTbjxFyslF5IsezYqf99PtkUo9WVXU2aP0l1zPwSbV54q8XgHj+8HLpYM+q5ilL
         qBZe6YJEusuqJ0QyqUUoBQq8b2AEF5nYkH1ZbORhBjaVvCGZc0tC2tc+MkGgXS7K7lOn
         uGePR9mE2XkDsaeMcpRaz4gN6dDYgWeCo27vridiBitUkAcft743e5qU3JgOeISwgbyr
         JMaA==
X-Gm-Message-State: AOJu0Yy2lNYjfhRP1G7PasQ/tnX6IU2dR14/jGdZ9tUs/dvbac4026Yb
	qd/QoIrngWIV/4oQ+psgkEn5rTS/+6NVs/w+vq3RkmzRQfL8+7GINSJffvGe4eNT2Y64BFcfDlm
	sP+38VrF+DFtVHscWcLfwQkF/5Q6c9MY=
X-Gm-Gg: AfdE7cl/gTU5DHNUKLuXTbKLUoY0QjKhJ/3uRI1fJIf0avOZH4edvVx5UAqXBSthdeT
	E6v84xfl9t0Y5VqHUPMkbpaKlXQTu6H5JlxDNzpnQCAMsTwm56oyW5Bpz5pZ/rR6/RmptndY8f8
	emax4xgCDm+KUr6Lfnw/TRuvK5tuGGQTaDaoorFBcWRn08vzJRh1XjaKeUioo3Y91oxMKJR4duk
	R2y7uHW9WpConYnUmV3KIwY70zyD4p0kFHpmHSLLplmiAq7wcIyETQJ+OI4a0EmZKusLNOa
X-Received: by 2002:a17:90a:e7d1:b0:369:1dcf:4a46 with SMTP id
 98e67ed59e1d1-37c937055c5mr9132387a91.25.1781791834820; Thu, 18 Jun 2026
 07:10:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617195645.96604-1-jwcart2@gmail.com> <20260617195645.96604-3-jwcart2@gmail.com>
 <CAEjxPJ4R0Z7d_mOJ=cYr7R+hERc6d_2_JfDSA41tKaXFaVeFMQ@mail.gmail.com> <CAEjxPJ6R6NxH8RQYq-tdmgJUB3=315c-wsKA3GKih76mm=UbYg@mail.gmail.com>
In-Reply-To: <CAEjxPJ6R6NxH8RQYq-tdmgJUB3=315c-wsKA3GKih76mm=UbYg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 18 Jun 2026 10:10:23 -0400
X-Gm-Features: AVVi8CeObO_85YfKyb0m2d2pfCXZVyFzLy36xWbpfSExIiblOTnqa8ba4k-nJ2E
Message-ID: <CAEjxPJ6ByVMQeveaBwXWpsikPZE06sBww-hvMeT=da0jMSWJJg@mail.gmail.com>
Subject: Re: [PATCH 3/4 v2] libsepol/cil: Add checks when growing lists to
 prevent wrapping
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 8:36=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Jun 17, 2026 at 4:21=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Wed, Jun 17, 2026 at 3:59=E2=80=AFPM James Carter <jwcart2@gmail.com=
> wrote:
> > >
> > > A common idiom to grow a list or buffer is to use "len *=3D 2", but
> > > it is possible for the multiplication to wrap on overflow. This
> > > would result in the new len being smaller than the old len and
> > > could lead to problems.
> > >
> > > Add checks to prevent doing the multiplication if it would wrap.
> > > The multiplication can always be done if len <=3D MAX / 2 and
> > > should not be done if len > MAX / 2.
> > >
> > > Signed-off-by: James Carter <jwcart2@gmail.com>
> > > ---
> > >  libsepol/cil/src/cil_resolve_ast.c |  7 +++++++
> > >  libsepol/cil/src/cil_stack.c       |  4 ++++
> > >  libsepol/cil/src/cil_verify.c      | 28 ++++++++++++++++++++++++++++
> > >  3 files changed, 39 insertions(+)
> > >
> > > diff --git a/libsepol/cil/src/cil_stack.c b/libsepol/cil/src/cil_stac=
k.c
> > > index d9c7b0c0..c80ed7ad 100644
> > > --- a/libsepol/cil/src/cil_stack.c
> > > +++ b/libsepol/cil/src/cil_stack.c
> > > @@ -77,6 +77,10 @@ void cil_stack_push(struct cil_stack *stack, enum =
cil_flavor flavor, void *data)
> > >         stack->pos++;
> > >
> > >         if (stack->pos =3D=3D stack->size) {
> > > +               if (stack->size > INT_MAX / 2) {
> > > +                       cil_log(CIL_ERR, "Stack too large\n");
> > > +                       exit(1);
> > > +               }
> > >                 stack->size *=3D 2;
> > >                 stack->stack =3D cil_realloc(stack->stack,
> > >                                            sizeof(*stack->stack) * st=
ack->size);
> >
> > Can't this still overflow on the sizeof(*strack->stack)*stack->size cal=
culation?
> > reallocarray() is good for this kind of thing.
>
> I guess this one is ok because stack->size is capped at INT_MAX and
> sizeof(*stack->stack) * INT_MAX can't exceed SIZE_MAX.

Never mind, I was right the first time - on 32-bit it can still overflow.

>
> >
> > > diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_ver=
ify.c
> > > index eb732e44..ee90b0ce 100644
> > > --- a/libsepol/cil/src/cil_verify.c
> > > +++ b/libsepol/cil/src/cil_verify.c
> > > @@ -975,6 +975,13 @@ static int __cil_verify_user_pre_eval(struct cil=
_tree_node *node)
> > >                         }
> > >
> > >                         if (steps =3D=3D limit) {
> > > +                               if (limit > INT_MAX / 2) {
> > > +                                       cil_log(CIL_ERR,
> > > +                                               "User bounds checking=
 failed "
> > > +                                               "to finish for user %=
s\n",
> > > +                                               user->datum.name);
> > > +                                       goto exit;
> > > +                               }
> >
> > Not sure about the error messages for all of these; they are overflow
> > conditions unrelated to the bounds checking.
> >
> > > @@ -2112,6 +2133,13 @@ static int __cil_verify_classperms(struct cil_=
list *classperms,
> > >         } else {
> > >                 steps++;
> > >                 if (steps > limit) {
> > > +                       if (limit > INT_MAX / 2) {
> >
> > limit here is unsigned so UINT_MAX / 2 would match its type but no big
> > deal either way.
> >
> > > +                               cil_log(CIL_ERR,
> > > +                                       "Class permission circular re=
ference "
> > > +                                       "checking failed to finish fo=
r %s",
> > > +                                       cur->name);
> > > +                               goto exit;
> > > +                       }
> > >                         steps =3D 1;
> > >                         limit *=3D 2;
> > >                         orig =3D cur;
> > > --
> > > 2.54.0
> > >
> > >
