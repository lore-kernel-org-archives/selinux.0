Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681BC344024
	for <selinux@vger.kernel.org>; Thu, 21 May 2026 14:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373354; cv=pass; b=H0xqD1u+u9zTIy4A8GXHPBJjuA3Ldjtxy32vFa8dmQ/TmF852mZGsN7iEJFSSdKEFaQcw1F+SlDIYGF90+w2/yM+B8gIB4a1zsWJdTerIc0Ojf2DpfVXGVCbqswuQc8+x3PieRlP5e5kEnnyR+m7lYUcFz3PHZmfl59goFL1NbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373354; c=relaxed/simple;
	bh=US9LhFVMvZrS1UlcTD7h7IJF50ydMDzqo4gAAPJ7ysQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dR85ZPPyHdZ5bNO1TFCxqtzpHGhKM/+X/+8xo3v0pQfeaLdD1J4aN3HmsY9Rv+TMVS2xIi+hkmGZcWfrK0qdVEYrFLHLK0Kb8hrMSP+vvwlhGMaNZt1fSXazqfvOPRUBFnegzpg/z6Ez1LnYrKBQIYK23rq/ftz8diSwuOZ5KbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+pB1Uc4; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+pB1Uc4"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39393c1b5aaso8032081fa.3
        for <selinux@vger.kernel.org>; Thu, 21 May 2026 07:22:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779373350; cv=none;
        d=google.com; s=arc-20240605;
        b=AquZzBlCI2278kcWCbSrpky4qHQirKWpKPEQKvZ72E3SvnNhAj746Niinww0bHl200
         dNxwXWNvFYfCDwkVh3CZ/0cq+WeJKz7myxQMCTeHNhwSbwO7b85+qohMPWxfY0y7Dlxa
         g92+yzN+BFYhqzKarQ4QVmViVR3nkL13UxS83TNyUP0xXg7St0kXQ7tJ7Q9R87OOh5LG
         Px1VRg0FCQOxFzpDbfqgGYCqpqjf/Yl2KN+foFlILyKo06I6RRWslBEWwWY+GsoxcZvw
         852d1nUmab7eh+PjlN62K9ZsyoQ8N4AGR/3EqjCkyQSCKiIdAhhblpmz8WV3LmEHrOIG
         b+uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OnQsTsYpJ+sZAssEcSsAe9HayCINXzjcitiGwxcxNd4=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=E0rWM/cAesS9WIalfT3+Ac2EwwGRHOcjj9g+g2wk5vahcmlHccW2UxxbD/l95Qka1m
         uRmz742x9v+fu1z6w5V8i7oVz8PKfVXqu7R6c0zDEj8jbQJeSkoRDTJVaHyVZbDZCTjE
         92cJk3BaihXZ+vE4+f2NvKh6qvZB6Cnr3YFuaBFFHcvbNA0qLHnZZVq2Bv1Tsg5Xi7zz
         YS59fYYWnxtdkdDVGttcrEM/wtEDeUIQAlPJ8FT36lndUm2tPSqlP4gsTT7T0oZXjO5W
         eazV+cR+dlHv4N/hh+qunE1FPwYd4PvXsxMvnyTZ71qpyyf4ny4lXycDBpRrb0UoeLjZ
         DMyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779373350; x=1779978150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnQsTsYpJ+sZAssEcSsAe9HayCINXzjcitiGwxcxNd4=;
        b=E+pB1Uc40ejbk4uoeTot2Qpd93zUUeZTwt0SU61myBIQ0WEwCKJ1/gQUvp/JP8HBYe
         GRQXZY5eZLa2+j62aVwHgAI/FBAvG8oL5g0qoisOiRyPp4gxzk8n+HzBwyxleNXdG7z6
         ZNTgENCCGHS+py43rHabcxLXKPqWt76YcEZmViOQKQrB8F5SIdAGRxLNk6gndV/KWriJ
         Pb0pLHeCX1oJEP69lQyHJOASpUowcn++k0UFf+J4lbfdwY9Jnc0oVeMuTqy5Z5NDZ5w7
         2RPSKslln9XtxFLuokqJKcBzXtoSudbxesPvPYHQBoRpQ0ppPT4jM1uXksW5lqXR3udr
         d/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779373350; x=1779978150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OnQsTsYpJ+sZAssEcSsAe9HayCINXzjcitiGwxcxNd4=;
        b=QOIqM9hmLtbcq0zTFKQZjyx5Kq4l1GVM1hjWqSIkP267yww0FNdnxn4QAoabVjMb2h
         WqzStPfyEdm1Y/ZCr/gTQ6m3mCgL+z/Q2xgFUroQNtXr6zNEH1/YvAOprYR88j7AXkBH
         dzdfzHzbPlAz7tg3VRkrShooB68cyxN0GTsbr3lztK+CrTmmKvkN7tcnK9V1HVYCI1+3
         hQ5ejVZnezXazS3XC2ycjEkJG5lduLAA659Wh5JHuIkykCOCUPKHFXgk+q1F76XCBorp
         N+417QH3de+KsksbVGCOGP14U+5KwX/+Gi50WE1CK6mWpR8EOr5b0FcJBZK3letZLvD+
         09Tw==
X-Gm-Message-State: AOJu0YyOCYfTuXT5y2SG22D8jxWEDFELLgYO4BXFn2g4WeeWenvYiM0S
	G7vDZT0Hu9pSBOHelWLXGDJUd7dDC3UCNjYbL1Mrry94IWyJW1/NRp16RHe7cz5odNjKdkLg5gO
	I9VLGQao2gbcfTc2mR15uCRLyBfM+ekI=
X-Gm-Gg: Acq92OF400GHcVvq7KlxkvaKwmGOVJ/KogxsRqzl/I9vaM+kDEHC1tXI99xrwlMhYh1
	hPGtG/0i5WOsp3qJ9adHIctl1S0onmq1D/Ip5+rDHNzMYz5juP8nuHxY3CfakHK9B5llKrbZvKj
	ywfZDYPebwoAJT6EVGvzJSsWxVU1XXqkOFlLI0uzLmrN78qF4Snl21fmEtxfkPftNs+pp1vWCKt
	fF66l4FoJYJI2015laKCfNyYkEuFaU26gU5lHnYEyxn6HZEFXaZBQhHF70kKeSCMbSuxyTLdko7
	iffO
X-Received: by 2002:a2e:be20:0:b0:393:bc85:8d80 with SMTP id
 38308e7fff4ca-395ca5246e6mr13153151fa.12.1779373350207; Thu, 21 May 2026
 07:22:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508121327.91410-1-kalevi@kolttonen.fi> <20260508121327.91410-3-kalevi@kolttonen.fi>
 <CAP+JOzQgrnm=bDCsJ1JwL9RXY_Bz__MUa44LVaffW5x5cVRUcQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQgrnm=bDCsJ1JwL9RXY_Bz__MUa44LVaffW5x5cVRUcQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 21 May 2026 10:22:18 -0400
X-Gm-Features: AVHnY4IP9i_6UAPspn3-u79hPtiUJM-9MytEAGo2iPDL46zA7axxpOd4UjDAGYw
Message-ID: <CAP+JOzSriy7g1N4CdriGD61C5ObZUiNEYv5R_Z4-fn3z5oFwgg@mail.gmail.com>
Subject: Re: [PATCH 2/4] checkpolicy: remove unneeded tests before free() calls
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 11:33=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Fri, May 8, 2026 at 8:13=E2=80=AFAM Kalevi Kolttonen <kalevi@kolttonen=
.fi> wrote:
> >
> > ISO C guarantees that free(NULL) is always safe to do so
> > remove unneeded tests before free() calls.
> >
> > Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  checkpolicy/policy_define.c | 48 +++++++++++++------------------------
> >  1 file changed, 16 insertions(+), 32 deletions(-)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index d1511a1a..4f775111 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -381,10 +381,8 @@ int define_initial_sid(void)
> >         return 0;
> >
> >        bad:
> > -       if (id)
> > -               free(id);
> > -       if (newc)
> > -               free(newc);
> > +       free(id);
> > +       free(newc);
> >         return -1;
> >  }
> >
> > @@ -632,17 +630,13 @@ int define_common_perms(void)
> >         return 0;
> >
> >        bad:
> > -       if (id)
> > -               free(id);
> > -       if (comdatum)
> > -               free(comdatum);
> > +       free(id);
> > +       free(comdatum);
> >         return -1;
> >
> >        bad_perm:
> > -       if (perm)
> > -               free(perm);
> > -       if (perdatum)
> > -               free(perdatum);
> > +       free(perm);
> > +       free(perdatum);
> >         return -1;
> >  }
> >
> > @@ -759,10 +753,8 @@ int define_av_perms(int inherits)
> >         return 0;
> >
> >        bad:
> > -       if (id)
> > -               free(id);
> > -       if (perdatum)
> > -               free(perdatum);
> > +       free(id);
> > +       free(perdatum);
> >         return -1;
> >  }
> >
> > @@ -892,10 +884,8 @@ int define_sens(void)
> >         return 0;
> >
> >        bad:
> > -       if (id)
> > -               free(id);
> > -       if (level)
> > -               free(level);
> > +       free(id);
> > +       free(level);
> >         if (datum) {
> >                 level_datum_destroy(datum);
> >                 free(datum);
> > @@ -903,8 +893,7 @@ int define_sens(void)
> >         return -1;
> >
> >        bad_alias:
> > -       if (id)
> > -               free(id);
> > +       free(id);
> >         if (aliasdatum) {
> >                 level_datum_destroy(aliasdatum);
> >                 free(aliasdatum);
> > @@ -1076,8 +1065,7 @@ int define_category(void)
> >         return 0;
> >
> >        bad:
> > -       if (id)
> > -               free(id);
> > +       free(id);
> >         if (datum) {
> >                 cat_datum_destroy(datum);
> >                 free(datum);
> > @@ -1085,8 +1073,7 @@ int define_category(void)
> >         return -1;
> >
> >        bad_alias:
> > -       if (id)
> > -               free(id);
> > +       free(id);
> >         if (aliasdatum) {
> >                 cat_datum_destroy(aliasdatum);
> >                 free(aliasdatum);
> > @@ -6129,13 +6116,10 @@ static int define_genfs_context_helper(char *fs=
type, int has_type)
> >         free(type);
> >         return 0;
> >        fail:
> > -       if (type)
> > -               free(type);
> > +       free(type);
> >         context_destroy(&newc->context[0]);
> > -       if (fstype)
> > -               free(fstype);
> > -       if (newc->u.name)
> > -               free(newc->u.name);
> > +       free(fstype);
> > +       free(newc->u.name);
> >         free(newc);
> >         return -1;
> >  }
> > --
> > 2.54.0
> >
> >
