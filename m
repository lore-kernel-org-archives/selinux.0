Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748723115B2
	for <selinux@vger.kernel.org>; Thu, 18 Sep 2025 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209952; cv=none; b=fHqylw6CTqovUWPoPUYl6yuGYz+ZBg3srpJYngSzPJZeHE3YTQU0nm/DISa1qmtVe8HNmEtazlQhMAaZzskuUZrzo38pfQotD7NYqVG31Zz4UnQXO5asJwuyBgPM3hpm7HYnLTXCj7XRbMDiV36thAWySRPiL4vzsYh0HiJI0NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209952; c=relaxed/simple;
	bh=l+CHzfhzTph9TC1j6Luy+Ow00xFATk2QnuE2sNI8HvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E6bTQydYFV4tc/Iyi6zFT6ic9b8TSs9SJSxqmT1+rz6I9IggPIHcej/lDQS9IwDY+lG+LR6VH2Iiso0N74kTG/L6IEJ5WaJn7vpPind2hb8P2mlZh9Qd/65pnrRtIL8A3r3KP5xbtoE09ueELucrTEaQqMoVsGdYRKb+b9G1Kdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZAtRkFSP; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZAtRkFSP"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77dedf198d4so452586b3a.0
        for <selinux@vger.kernel.org>; Thu, 18 Sep 2025 08:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758209950; x=1758814750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0r97KKGYMsHeXRrgZiOGNJu+AOhAt5WoepEoce/7wW0=;
        b=ZAtRkFSPf5ojJtW5ChBGUbvS+ay7iIPvOJudujNeN5AvH3CWRJlB/z7qFqCvog+NKI
         hzY7GO8FBHC+YHd5byMPQA82ZFA05HZCZaKJZ2eNWv8yTBXxJ6QIqgLvoft56+yWgGwN
         QSGtNF3QjWl72RnbslNjbsC+z+17hibmiXjlc3izTf2eJ92Q3mX2iIfPdrxXnZGSR4lc
         XxbpE8SaEkYOqsCSD8qKSHrZID/P+1bF9o8mN+LHnQjzPjjGUBGWsgX9rpx28Il5fzem
         i7f61mCGFRktj9xSM9JPo8G0iSm5q0vY1tMX8ME3r+WZCu/KOBU8yqfPIZ0hO9SLj/7H
         QC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758209950; x=1758814750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0r97KKGYMsHeXRrgZiOGNJu+AOhAt5WoepEoce/7wW0=;
        b=CjGu47Dnod9lZtKyITHhWHF5TlDzdry9RARvnt5Im2S/HlqItzM6+F0hNNLTwgJhP1
         AweFPKMUI4erUbRnvGfJhlzDVi8jnqnyBzbEDmfGIfxS07eWIF9jbXgzWgv9anPRamBT
         S80UUALG2qnVrPJ5UpOU93irsyVy8wGWzwfY0o9nJAKTJtr7dgEEfAVnWrd7/yvIZK4T
         rE+feeiv82XpzY6CYJYqaGA1slSgbURj79GVY72c3Q0WM19bdesqFXEHl97XkdNMhsaB
         y1KSqZBD2CHd+wURw0a3vW3Ut1RsLzOapMnGEt7ekuSLTx+opSO400McGwUlrIlu+QQt
         Ysnw==
X-Forwarded-Encrypted: i=1; AJvYcCVxYBjB3yxuQn9hwj683mJvGJmrowRkuxRnsnXkzkvxRqsJWch4xqVc7DWgnmwv6Qab+UOqa2bl@vger.kernel.org
X-Gm-Message-State: AOJu0YzyORxRB7evBieBI0P6q7Gv6r0P05Js4BrYxl5INep/jXy48Z69
	fBd4UkwVaQULuFHGxAfSrAmICQrunBb0BhroU1O132uXk85OvrTyqKt3apAynfsRTVc302FRXvR
	GNF1D3Z39YStdBZticdeO+in+7WV67fGmh9poIjS8
X-Gm-Gg: ASbGncteoZtI+FiJicGew+zfBqeJLls0tz8WkNOyxVs3/JRmyxsExMhhGyNt9nDW2vp
	uZqMR7D0+0p6CO1UC+cGEdBXNqOCZ1TWCbECy/3EHFEUe8d9k1QHUJgWOAoP0WQMbQABnaLB9Mp
	ce7gFl/GqZXOIww9FFNfF5THC2dWKIFNcyy+VMY2yof18kXJeCjhytmuUlbuACJqpQZiaMFfuHt
	OwG0UUyhgg0tuQajMGBZKfakA==
X-Google-Smtp-Source: AGHT+IElmkij4wYopIn8UrpgdMTCj5k6zUQlBbkUIO8IyLnCWwFl7MhD5rIB7cKOXRm/+Dj0xrbvWGIatYmEZd7kYmg=
X-Received: by 2002:a05:6a20:a10f:b0:263:81aa:d613 with SMTP id
 adf61e73a8af0-2925d4b2bcbmr37354637.22.1758209949741; Thu, 18 Sep 2025
 08:39:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916220355.252592-36-paul@paul-moore.com> <20250916220355.252592-51-paul@paul-moore.com>
 <8b560b9522c1c42e26a108e2f9b2977901d73649.camel@linux.ibm.com>
In-Reply-To: <8b560b9522c1c42e26a108e2f9b2977901d73649.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 18 Sep 2025 11:38:58 -0400
X-Gm-Features: AS18NWAHpIkWgt5Zhht6NQrhgyLZn1uDjxVxDej5yO7gbsbueflErH6ttnEljyU
Message-ID: <CAHC9VhSxookZfVQhDMdrikmFrk0VoUhEwMx0FR5DS3JfK_MY9Q@mail.gmail.com>
Subject: Re: [PATCH v4 15/34] lsm: rename/rework ordered_lsm_parse() to lsm_order_parse()
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 7:30=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Tue, 2025-09-16 at 18:03 -0400, Paul Moore wrote:
> > Rename ordered_lsm_parse() to lsm_order_parse() for the sake of
> > consistency with the other LSM initialization routines, and also
> > do some minor rework of the function.  Aside from some minor style
> > decisions, the majority of the rework involved shuffling the order
> > of the LSM_FLAG_LEGACY and LSM_ORDER_FIRST code so that the
> > LSM_FLAG_LEGACY checks are handled first; it is important to note
> > that this doesn't affect the order in which the LSMs are registered.
> >
> > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> > Reviewed-by: John Johansen <john.johhansen@canonical.com>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/lsm_init.c | 82 ++++++++++++++++++++-------------------------
> >  1 file changed, 37 insertions(+), 45 deletions(-)
> >
> > diff --git a/security/lsm_init.c b/security/lsm_init.c
> > index a314484d7c2f..7b2491120fc8 100644
> > --- a/security/lsm_init.c
> > +++ b/security/lsm_init.c
> > @@ -228,83 +228,75 @@ static void __init initialize_lsm(struct lsm_info=
 *lsm)
> >       }
> >  }
> >
> > -/* Populate ordered LSMs list from comma-separated LSM name list. */
> > -static void __init ordered_lsm_parse(const char *order, const char *or=
igin)
> > +/**
> > + * lsm_order_parse - Parse the comma delimited LSM list
> > + * @list: LSM list
> > + * @src: source of the list
> > + */
> > +static void __init lsm_order_parse(const char *list, const char *src)
> >  {
> >       struct lsm_info *lsm;
> >       char *sep, *name, *next;
> >
> > -     /* LSM_ORDER_FIRST is always first. */
> > -     lsm_for_each_raw(lsm) {
> > -             if (lsm->order =3D=3D LSM_ORDER_FIRST)
> > -                     lsm_order_append(lsm, "  first");
> > -     }
> > -
> > -     /* Process "security=3D", if given. */
> > +     /* Handle any Legacy LSM exclusions if one was specified. */
> >       if (lsm_order_legacy) {
> > -             struct lsm_info *major;
> > -
> >               /*
> > -              * To match the original "security=3D" behavior, this
> > -              * explicitly does NOT fallback to another Legacy Major
> > -              * if the selected one was separately disabled: disable
> > -              * all non-matching Legacy Major LSMs.
> > +              * To match the original "security=3D" behavior, this exp=
licitly
> > +              * does NOT fallback to another Legacy Major if the selec=
ted
> > +              * one was separately disabled: disable all non-matching
> > +              * Legacy Major LSMs.
> >                */
> > -             lsm_for_each_raw(major) {
> > -                     if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
> > -                         strcmp(major->id->name, lsm_order_legacy) !=
=3D 0) {
> > -                             lsm_enabled_set(major, false);
> > +             lsm_for_each_raw(lsm) {
> > +                     if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) &&
> > +                          strcmp(lsm->id->name, lsm_order_legacy)) {
> > +                             lsm_enabled_set(lsm, false);
> >                               init_debug("security=3D%s disabled: %s (o=
nly one legacy major LSM)\n",
> > -                                        lsm_order_legacy, major->id->n=
ame);
> > +                                        lsm_order_legacy, lsm->id->nam=
e);
> >                       }
> >               }
> >       }
> >
> > -     sep =3D kstrdup(order, GFP_KERNEL);
> > +     /* LSM_ORDER_FIRST */
> > +     lsm_for_each_raw(lsm) {
> > +             if (lsm->order =3D=3D LSM_ORDER_FIRST)
> > +                     lsm_order_append(lsm, "first");
> > +     }
> > +
> > +     /* Normal or "mutable" LSMs */
>
> Paul, there's a reason for another set of eyes reviewing patches and yes,=
 even,
> comments.

Mimi, if you've read my emails over the years, or discussed this topic
with me in person or off-list, you'll know that I almost always* hold
my patches to the same standard as any other contributor; even in
cases where I know there is likely to be no review beyond my own.

[*] There have been exceptions in the past due to build breakages and
other "critical" fixes that need to be merged ASAP, but even then the
patches are posted and subject to review and additional
patching/fixing afterwards.

>  What are "mutable" LSMs?!

As the "or" would indicate, they are "normal" LSMs where the ordering
is mutable, as opposed to the "first" or "last" LSMs.

--=20
paul-moore.com
