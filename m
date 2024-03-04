Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301D678B53
	for <selinux@vger.kernel.org>; Mon,  4 Mar 2024 19:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579881; cv=none; b=o1CX9HQUqsu51rtuLyVoilpGqBkxYMjNjMmNdIsok3NldWDh70L1UrosKymfLvtXf+og9hrhDhCvoGXmYE1GhhdW1KkfQ8+oLdCQ2teGXcxLgBvsgG47HNB7Yunyj1vtjPerUcc/b/hCU27nPRNbeNmALJTy4JzT7vdzCysZYtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579881; c=relaxed/simple;
	bh=5yLyBrNe8gtiI1iBjjrXl4HSHUzt7phMpftxsezUKxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JYGCrb1WF+/l5EFwT8c07v0cAB0ZJYieEEeGj4jU5HlpR/U+/RHMEdSr/cBhXGIiZcqdx1TgyTW9mTTBch4jOxlzMYTk8wrrgmdIqamOljqPf69xt1Zxs3J5oWCEmy8o9izUYIW3Yz7CQVzytvWjZ5pgiBZk0UR0KypdI0gdqOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keUwOzRy; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keUwOzRy"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7db1a2c1f96so1507214241.0
        for <selinux@vger.kernel.org>; Mon, 04 Mar 2024 11:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709579879; x=1710184679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4xRyhu7OoJjo6mc8gHxYCTXj7uy2ty10FUsOmNCIlw=;
        b=keUwOzRyJytm67DyyV8mnQZXb+I7DJH+OFOJIKEdKh7bXu5z+aMJ+KcK9bx5YOu4Nn
         Eiv0KDpamCcLz5rm/F+EpMTWBG6+oCQn1gR9kLaTBpC7ovMkL0FoTREULe6LIClraCuG
         KaX+JYmBS/pNs8yxBllBpmjrkHa1YuGfbK8Mi/KmHFzRcOY8tu0suiTGANev5MgvgmRM
         iM9emQi/BaA599TCoxjAkTkNVxflKdm5LLgW3ot9UPbJWewVRJcFARF3EX6zXfKclrkO
         ORErtDCyyxPeKp9U9b/iZgxDHKVladCTGfxXhtoYALpXusyF9vEAzd997cOF653GyAHL
         jKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579879; x=1710184679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4xRyhu7OoJjo6mc8gHxYCTXj7uy2ty10FUsOmNCIlw=;
        b=SxCf0TX2mR7c2A3ruk0U3GTCKI3hLOUmjPD8ZVp/3Yt/7nrkrCI7EKqKWMscnuE0th
         S5bES7onllWYE/TTSOHcoaaK77X1EQ4FUDqeexDyAXRvAGdC0CgbAuBgdGw+SEpbi9lt
         LVEQxJdBoKjc0G0uWEItXzabNbeNYMzeX2WLWF5Hgoc7XS6CVjto7pz7yoyiuC9MEqEp
         roylfGdwHLybfHv6A5KUrZEoUP5xYw+LjoteChsjqUeF3m1HEIGqDuoE9asKKOqGrlSn
         D4J8cpgNolY8i8vaqJTzxiuP4Yxi1y55uP98trkel8795FHDnmIlbRMkLxmG60vsEGHR
         KoAg==
X-Gm-Message-State: AOJu0YxpI6IH9FiZ0085MtDc26RH0tKSrDpkgnG88EhqYJWPWiPaEM3F
	HRoHbdeNYDFKu8NTDX43/+clcVJqZDECHEjucKawf/5eswA0ivm1Ae2m30coN2FEqYFNu5kc6OI
	sjLrzYbX5amWqVjRjdx6rZUvKzL7mbm8C
X-Google-Smtp-Source: AGHT+IGGaXrl79oIl2yTC2G9POvC9MmX/HSBUcry0lGU8E1PHbCbm0cM5jag+y7cgN/yJorAV4lRC6z9Z15T6i1uH6w=
X-Received: by 2002:a67:f15a:0:b0:472:727c:fb5d with SMTP id
 t26-20020a67f15a000000b00472727cfb5dmr5579151vsm.35.1709579878167; Mon, 04
 Mar 2024 11:17:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122135507.63506-1-cgzones@googlemail.com>
 <20240122135507.63506-4-cgzones@googlemail.com> <CAP+JOzT3dYjoT_ugVbM_paVVfsU31=W+341aNz0yh4+7R1ewkA@mail.gmail.com>
In-Reply-To: <CAP+JOzT3dYjoT_ugVbM_paVVfsU31=W+341aNz0yh4+7R1ewkA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 4 Mar 2024 14:17:47 -0500
Message-ID: <CAP+JOzQs5mFrgvcpQ61fstanE6VkmNYr1x4o9jTuBAVr5vNU=w@mail.gmail.com>
Subject: Re: [PATCH 04/15] checkpolicy: free ebitmap on error
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:35=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Jan 22, 2024 at 9:02=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  checkpolicy/policy_define.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index db7e9d0e..053156df 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -2544,6 +2544,8 @@ static int define_te_avtab_helper(int which, avru=
le_t ** rule)
> >         int add =3D 1, ret =3D 0;
> >         int suppress =3D 0;
> >
> > +       ebitmap_init(&tclasses);
> > +
> >         avrule =3D (avrule_t *) malloc(sizeof(avrule_t));
> >         if (!avrule) {
> >                 yyerror("memory error");
> > @@ -2607,7 +2609,6 @@ static int define_te_avtab_helper(int which, avru=
le_t ** rule)
> >                 }
> >         }
> >
> > -       ebitmap_init(&tclasses);
> >         ret =3D read_classes(&tclasses);
> >         if (ret)
> >                 goto out;
> > @@ -2693,8 +2694,6 @@ static int define_te_avtab_helper(int which, avru=
le_t ** rule)
> >                 free(id);
> >         }
> >
> > -       ebitmap_destroy(&tclasses);
> > -
> >         avrule->perms =3D perms;
> >         *rule =3D avrule;
> >
> > @@ -2703,6 +2702,9 @@ static int define_te_avtab_helper(int which, avru=
le_t ** rule)
> >                 avrule_destroy(avrule);
> >                 free(avrule);
> >         }
> > +
> > +       ebitmap_destroy(&tclasses);
> > +
> >         return ret;
> >
> >  }
> > --
> > 2.43.0
> >
> >
