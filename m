Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28B630C153
	for <selinux@vger.kernel.org>; Thu, 18 Jun 2026 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781801078; cv=pass; b=Y7Xq62CxnPXntKrouWVp/BU8RY2GNRxw1OkQ2+xSiXkJ0YcaoxVKpR/pB7UdJ30cK2ABYkSwAKm5xVsEZojjZXwTt3hYybgGY5f3aM4eGWDi3DdlVv6KB0vbexdSRJlXsuz7UTC6Udt/znkzuMCgmrBithPXmCT/FgBleNxsz0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781801078; c=relaxed/simple;
	bh=zud3lGF/Zd8P9kNjSiaYZ+SwVPJoI9h0nV9AuZ8mh9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKGTBFzRhXX0TrQ0geiBqd66W2F6y3vQcjasz2TjhwD8W3GYs+j4O4h7lQ3IPKNj0I6uaw3Ail802+K9r6bG9gz9KOEks7Xza7M1VQiBNbGfWXLgfXuVSSHqMHG33GbGhxUlGMtdSiqsLl6F4TONPyidW7K9utkVPLTC/MlmGk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAiWYbMZ; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAiWYbMZ"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39676ff4674so10038791fa.0
        for <selinux@vger.kernel.org>; Thu, 18 Jun 2026 09:44:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781801075; cv=none;
        d=google.com; s=arc-20240605;
        b=LiY8xRqvWeJ7nHRfhacjqhf//LNzMzR0zQdJ8OdsMETa4K2CGHh/DXfy4J7Icj7BjB
         KXDtKylgjzpGMKW4stBEoXZuzYeX/bC6qnuax6nq+8bnFQccqcGkXOJ4MxuRqPaDQ1gG
         BHtjUc/I/r0oP1oilHZSJiN4KuBO3lphnFTM3ipb8sIQORJS2vbYuhfC+N9SaS5Qs4FC
         eukJo2n0b/98p0v2CjAt6MQlIZX6P6q6Jfpk9crVcMUVNTWHBfOHq4mH94xm2yEjWctf
         BkimNlQDm58smxg9nVocTpElC4lpk3uH6dRWdQrCyUMT7eAakOGhTnJE1bDIbHzijsQp
         EGIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2WevS0BmWVYxaEf+RGr0GyHI06/+lNQ/v7PUKWPnpSQ=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=lZ8IZz3BL/4rzlgCU4RW7ghja7xuFz+RRYBTkHULaxANi6jP3YWcxiA3WZ3WsFhQ3v
         E8w+Go6D5BXfdVpC6pEefPL2LwyRDgmGpE1l6eCeaNN6h5PXW1DtFeZNMzisgVQVXcq2
         7+05EDNFma76FESbH5md3r7Fbo4AxYUDmZL+Bo1RAeU537F3AHiUtD3jzQr0Xkv/zOn7
         zziaqst6Fc+M8D5eLWlJBqoCR64ZbrZop9OsHV7UxzQnroj1efJPS6JY3swNDltDqzzk
         m6x0D8aRnOelaig387ONoNq2IlaPm0AT+Un3aqvbSbf6gwY9rFzK4wfGXeEKpTynhRc6
         ZcvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781801075; x=1782405875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WevS0BmWVYxaEf+RGr0GyHI06/+lNQ/v7PUKWPnpSQ=;
        b=kAiWYbMZVOsoiXUCiV/4OJZCgXgA/jl7nmVCGyxTgYN4yb7G0tj+KqRqDQ2cWgNBOQ
         w1Zf2dDYAgHA5T2jLpMh4yuioYZJ4XKGTYQ9SrFk3w5GC50O68CNKDdyQRwGnshnA439
         QNwtZ6jNOPflkrd7qLQA5JAQ9GSyhKSR1QS6WQ2dGytQPUiYMS7PWbe60g7xttk40h2h
         Rn0I+v/8keuWJWTVbEL4dch+ZRyS2Oy4IPkIIvHib2aPBAuM5K5K4y6vhV4PhgJ1bNO7
         tu0ZTr7+hWoYbdxBo+Rl7tipf+hUt8GsHrOSsgYVqZkku1LHdMf2mqEQ9LW24Ktbwqsg
         dTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781801075; x=1782405875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2WevS0BmWVYxaEf+RGr0GyHI06/+lNQ/v7PUKWPnpSQ=;
        b=pFSg1WYGw6nmLiloGxTQipGRjPb9tg82b7AZwTMz69Fm3CKLfMfbcBMOgUwnKKRxhO
         3R6rmpTaSpWD73BxCYWgDUIEXlpnB7NV343sp0Arm8zRX/DYOLjiQnlRz/38JsCdJpIm
         DZ8htUutWHK5Q1BPf/vdXvXpp18bWAGV08t+8+Rx6SM6y0yMoIdAo3A9WyVBxe1Da2Dw
         NnTv/V+Q6fXZETCyqax2lQ9GhV+MJ8QCIPqXRA3kmCDRxpQg11XIQCuHHn3G1cnKqFxV
         /0FSF6DNiqaLkanvaiMkPMjjYTztHXIH2pA1wc40zjJeFwQpqX5J4RWV6Q5iliZcB/66
         eQpQ==
X-Gm-Message-State: AOJu0YxYZXMbAe0MDnG1PpQKQ8brbFBiDz6hmFYYfaszBM3aOtNW0w4K
	FL4t1iCzFhk2izsD4vjn0etn0CI2mG93ThvOvn1ySZOSh2m382RNL1ziYsC8lA8QqnNKLiw0b3c
	g/WkKECls5a3hmzR//h/1Cd4B+bvsn9g=
X-Gm-Gg: AfdE7ckkQNPSHljBrrTmoaIM2AyqEn2oxcAUEmVpNnAo4ONQK/mhP0ecoqZzzCOReUg
	qDHEkgd2lt5ko2qgBpDlXRSJD6de7r2cgHVA7vOSumLdAiP5iwzYnb/Z7IREbAEWZmhmDDw7lew
	Lu1xKM/+CkKtC+mOKf6CuByVqa29fu0bFablhRLqhKDRVCHxz0BQLOdL0Edn7Lx55OTCtZ8m4YN
	el+jTZIsMgUq0n5gCNTOrAmDamw8L3iB+KQnhv6JJsHxqtwBnZ6/cEst8u+VyHlK1WXSar3wgUN
	m99F
X-Received: by 2002:a2e:9084:0:b0:396:71a5:783 with SMTP id
 38308e7fff4ca-3998a266f1bmr728251fa.10.1781801074431; Thu, 18 Jun 2026
 09:44:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617195645.96604-1-jwcart2@gmail.com> <20260617195645.96604-3-jwcart2@gmail.com>
 <CAEjxPJ4R0Z7d_mOJ=cYr7R+hERc6d_2_JfDSA41tKaXFaVeFMQ@mail.gmail.com>
 <CAEjxPJ6R6NxH8RQYq-tdmgJUB3=315c-wsKA3GKih76mm=UbYg@mail.gmail.com> <CAEjxPJ6ByVMQeveaBwXWpsikPZE06sBww-hvMeT=da0jMSWJJg@mail.gmail.com>
In-Reply-To: <CAEjxPJ6ByVMQeveaBwXWpsikPZE06sBww-hvMeT=da0jMSWJJg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 18 Jun 2026 12:44:23 -0400
X-Gm-Features: AVVi8Cd3Ht4Er7pzWTOZJZOBfbXOaePfA5IR7X36q8qXBGcuhpQkNHv6AcnlnLs
Message-ID: <CAP+JOzQvAJRdnXZqc_uCPEp_ApXwp16zu8zwS_QvwHgjhcBY1w@mail.gmail.com>
Subject: Re: [PATCH 3/4 v2] libsepol/cil: Add checks when growing lists to
 prevent wrapping
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 10:10=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jun 18, 2026 at 8:36=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Wed, Jun 17, 2026 at 4:21=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Wed, Jun 17, 2026 at 3:59=E2=80=AFPM James Carter <jwcart2@gmail.c=
om> wrote:
> > > >
> > > > A common idiom to grow a list or buffer is to use "len *=3D 2", but
> > > > it is possible for the multiplication to wrap on overflow. This
> > > > would result in the new len being smaller than the old len and
> > > > could lead to problems.
> > > >
> > > > Add checks to prevent doing the multiplication if it would wrap.
> > > > The multiplication can always be done if len <=3D MAX / 2 and
> > > > should not be done if len > MAX / 2.
> > > >
> > > > Signed-off-by: James Carter <jwcart2@gmail.com>
> > > > ---
> > > >  libsepol/cil/src/cil_resolve_ast.c |  7 +++++++
> > > >  libsepol/cil/src/cil_stack.c       |  4 ++++
> > > >  libsepol/cil/src/cil_verify.c      | 28 ++++++++++++++++++++++++++=
++
> > > >  3 files changed, 39 insertions(+)
> > > >
> > > > diff --git a/libsepol/cil/src/cil_stack.c b/libsepol/cil/src/cil_st=
ack.c
> > > > index d9c7b0c0..c80ed7ad 100644
> > > > --- a/libsepol/cil/src/cil_stack.c
> > > > +++ b/libsepol/cil/src/cil_stack.c
> > > > @@ -77,6 +77,10 @@ void cil_stack_push(struct cil_stack *stack, enu=
m cil_flavor flavor, void *data)
> > > >         stack->pos++;
> > > >
> > > >         if (stack->pos =3D=3D stack->size) {
> > > > +               if (stack->size > INT_MAX / 2) {
> > > > +                       cil_log(CIL_ERR, "Stack too large\n");
> > > > +                       exit(1);
> > > > +               }
> > > >                 stack->size *=3D 2;
> > > >                 stack->stack =3D cil_realloc(stack->stack,
> > > >                                            sizeof(*stack->stack) * =
stack->size);
> > >
> > > Can't this still overflow on the sizeof(*strack->stack)*stack->size c=
alculation?
> > > reallocarray() is good for this kind of thing.
> >
> > I guess this one is ok because stack->size is capped at INT_MAX and
> > sizeof(*stack->stack) * INT_MAX can't exceed SIZE_MAX.
>
> Never mind, I was right the first time - on 32-bit it can still overflow.
>

I should add a cil_reallocarray.

> >
> > >
> > > > diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_v=
erify.c
> > > > index eb732e44..ee90b0ce 100644
> > > > --- a/libsepol/cil/src/cil_verify.c
> > > > +++ b/libsepol/cil/src/cil_verify.c
> > > > @@ -975,6 +975,13 @@ static int __cil_verify_user_pre_eval(struct c=
il_tree_node *node)
> > > >                         }
> > > >
> > > >                         if (steps =3D=3D limit) {
> > > > +                               if (limit > INT_MAX / 2) {
> > > > +                                       cil_log(CIL_ERR,
> > > > +                                               "User bounds checki=
ng failed "
> > > > +                                               "to finish for user=
 %s\n",
> > > > +                                               user->datum.name);
> > > > +                                       goto exit;
> > > > +                               }
> > >
> > > Not sure about the error messages for all of these; they are overflow
> > > conditions unrelated to the bounds checking.
> > >

Honestly, I don't know if an error message is needed at all. No real
policy is going to overflow while checking for circular bounds.

> > > > @@ -2112,6 +2133,13 @@ static int __cil_verify_classperms(struct ci=
l_list *classperms,
> > > >         } else {
> > > >                 steps++;
> > > >                 if (steps > limit) {
> > > > +                       if (limit > INT_MAX / 2) {
> > >
> > > limit here is unsigned so UINT_MAX / 2 would match its type but no bi=
g
> > > deal either way.
> > >

I missed that this was using a different type than the others.
Thanks,
Jim

> > > > +                               cil_log(CIL_ERR,
> > > > +                                       "Class permission circular =
reference "
> > > > +                                       "checking failed to finish =
for %s",
> > > > +                                       cur->name);
> > > > +                               goto exit;
> > > > +                       }
> > > >                         steps =3D 1;
> > > >                         limit *=3D 2;
> > > >                         orig =3D cur;
> > > > --
> > > > 2.54.0
> > > >
> > > >
