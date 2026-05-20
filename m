Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC0B272E61
	for <selinux@vger.kernel.org>; Wed, 20 May 2026 14:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288177; cv=pass; b=CFi5H9USep/curjz+Su9EECTolasr4XIr9B8zQYSg1Be7eVT70V1UNqrmr+iXrClr+7VkVHqy3Y2XuUATWXFMOclqYHRH4ahlBYUMv+LADQ2CY5LHiT7SBT/i6InZX1BjG/VqHs0ZoXrA7M9uS+3HS4U8JJHquO2MUAPKy2SIaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288177; c=relaxed/simple;
	bh=NO79mN+5XhbXQCpzjnSsw8M/jj62WuoImfApUriBTSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fbWqdwFkekCTkV61938mcXT3NUNhAuvmrPy9FL2z5aKo2zeXQL4zqNKrmxVEQiKxfEYKaC/n5jVpATFJeruUTeZgcjZNp0/uTow+3Ht0XFCiIago4fXNGBpQQyxvjoZy9Yl5uoQZZSZfvvmFti3aUBuOfKlKtw4HFm37N/6qdS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ry957RAx; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ry957RAx"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a8891febd2so7078831e87.1
        for <selinux@vger.kernel.org>; Wed, 20 May 2026 07:42:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779288174; cv=none;
        d=google.com; s=arc-20240605;
        b=hkgrcjOsRsNwN8KjWTr4sc0rUiscnA+UKKPlbmyjRzTs02ZYM11EU0Y08DDujqPFh4
         WERUpmU1clWaURuINMe17XKPVc68ulSO1+IHVgVZTPAezFD8GSBiXtTES2/jIxZjDi/T
         JZcbF6dp2V+wU2YsII/1UczeB3/gWV9PH4D1agJfN623lK55e0ZMxOq34ak9j9nVt2hA
         9OE8IqnRM2KvCU4rUMqQ49KhYYMSEJ/GHJSwx9/JPqRBXUfPnK/HCK810VmcrJuYkuJ9
         KnXlmtAow88jEp/5fJ0zEb5MgAT0hJHRLw7MGQdSAm1zHvPEIPQs/im4L+3cRIW1xN8i
         oAaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m7LWMLTn1/8YlBJFxQAaE/1ye9Ul0o+ncwKWc81X4xs=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=YHrWaatzzQ/TZfyvd3nZ4aXC4Wr6E2bohIGgFP4RAqgzkgfP6eNwXay8QdS3dHuBE2
         94Gv5z+c6xM2Znhd2sNstImgxF706eZEcYiV+s5FFN0Wqf2sMCYzsLHzfDQ2RgnJCuQI
         RRm+LEpBqFkOkpyXuhmXlbOJxtz6fnb388hEvPNp5Z+pMPo+LrUjermzPRsWFoQ3BxHC
         rrOmheAQPpB1HZyDXrHeLv55U5pUI9nGQdxSAY2lSzJRP8OKAqXdSGu5MJi8+xXXlryz
         6fLfg2erOsOHSnFMmQl1nGpw8i7zn+4YrX4Dh2PqNJq24bpiENEJH0XR63korHnWArfm
         kc2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779288174; x=1779892974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7LWMLTn1/8YlBJFxQAaE/1ye9Ul0o+ncwKWc81X4xs=;
        b=ry957RAxfBD7Wok1fVOcfoIP+GHWgLQdLg/QAJueBXzpqrXMgbYt3783n6VYkwnktJ
         BmakTDteOU3aZIN7hkJq00gv5w2PyZImbWxhcdCsKO1KK4BX9lQW/C9U9yr1ZN4oeOoV
         kxGdyUOwrqz11+A1DlLDX+dWgMvKS3K68M9TQ+VuKFPXWDDslgKTqtsYcUXec55uVbtZ
         kHCVdEatDMwz7mowiUhq+Oc5+MADIElsvNr+d3YTHprEj1JxFYeKeACMgZsFoKqcQSqi
         wqt2XI8ZalYOEGQTLxthMw2ULlxMfdjlWi7pkFohgQkxn0prntyO71nRpkM9fTO1HnuL
         adTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779288174; x=1779892974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m7LWMLTn1/8YlBJFxQAaE/1ye9Ul0o+ncwKWc81X4xs=;
        b=SSwaQzU9Snwh4alYK/mg6/zW+GhWbWBSBGyvew32gqOY8cYXkxCxLkWeK8/SNiaZjI
         r/3N/XzhmpZMO1GogwTiuLI6it0Bv3VgLFzfV78rdL1GfgCuhq2EXBfoLp/EPNK+a0+J
         NaXHP+LYKWAAL8m1I+CyxeeLhGdSaYitsxE0JBjTc1FTF7MCJtB6AadUFpoih+Jd89ZP
         M7iBEctNwLwN5VPJCU3hTJawA+JcUm2klSiFJi3oVsLdWvOVTVGdhUSvftwDbEKeYQh0
         wQEtQBUGZgGPqQ3i1bgeCfMfmBJv4YwUm75XK8lVy51Olkyycmcq3IIjivgdZ3wrCJAK
         Ndog==
X-Gm-Message-State: AOJu0Yyr9ZSPO/5ZWBdBBN1clqsEW47Le+UvM/V7UvBRRZVK05Buofpm
	uipsZ8mM9IbyX06kYjsa5L9MkJFa3rW9LCY2yJpl3qouKIcj5j/vJuruPp5+QlZbJr2TYTEGQN9
	9EOVrX6Fmd64xnWePgQSngBZEtoqQfQbNEA==
X-Gm-Gg: Acq92OGUYzcE1NwIpTdEg3J/mKidwtXbISqv8tT1vxqdYLR7c2yWWixvKc2M9cPcgg4
	d+09pft1RbVHvwf4jlk9qcJJ1NKbrIEltjM2ikSOvJqJVUQ2JNlDh4KNnSdJ+rg8AIlqCIxxYoj
	AAlWXUmdR5h3AQ0c6iQkfntwkM0znMOkHB/zXzKI4hdo0xFvC8eFS/65pdrgLk5GKffcpr+u6RE
	Xjmqdf6+DaJphN90DVnF7w+Tf5FTlviBQ1gPnaNA9Fu23UFhVSWP/wf3o8cBU31ly9LTRjw2j/i
	r5mPRg6wALFzCdA=
X-Received: by 2002:a05:6512:2248:b0:5a8:f03b:a406 with SMTP id
 2adb3069b0e04-5aa0e73d743mr9347386e87.16.1779288173285; Wed, 20 May 2026
 07:42:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513191302.81039-1-kalevi@kolttonen.fi> <CAP+JOzRdTaTxB2QJg=DQ4vt_6pLGfzPnpY=Ofvde3omYq1wHZA@mail.gmail.com>
In-Reply-To: <CAP+JOzRdTaTxB2QJg=DQ4vt_6pLGfzPnpY=Ofvde3omYq1wHZA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 20 May 2026 10:42:41 -0400
X-Gm-Features: AVHnY4IAbR8-w49RdB8gkwxpBp6d17mzLc0_5ZoNWgEFv1EmrAPkAhv2g7dXG0M
Message-ID: <CAP+JOzQvhJ0BUArSn1rJJODPY-Xnq3mnK+9ZQQZXNXZmcuEhnA@mail.gmail.com>
Subject: Re: [PATCH v3] checkpolicy: use calloc() so no need to do memset()
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 11:11=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Wed, May 13, 2026 at 3:19=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttone=
n.fi> wrote:
> >
> > Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  checkpolicy/checkpolicy.c     | 4 +---
> >  checkpolicy/module_compiler.c | 3 +--
> >  2 files changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
> > index b808e4d0..323e11ca 100644
> > --- a/checkpolicy/checkpolicy.c
> > +++ b/checkpolicy/checkpolicy.c
> > @@ -235,13 +235,11 @@ static int identify_equiv_types(void)
> >          * Create a list of access vector rules for each type
> >          * from the access vector table.
> >          */
> > -       type_rules =3D malloc(sizeof(struct avtab_node) * policydb.p_ty=
pes.nprim);
> > +       type_rules =3D calloc(policydb.p_types.nprim, sizeof(struct avt=
ab_node));
> >         if (!type_rules) {
> >                 fprintf(stderr, "out of memory\n");
> >                 exit(1);
> >         }
> > -       memset(type_rules, 0,
> > -              sizeof(struct avtab_node) * policydb.p_types.nprim);
> >         if (avtab_map(&policydb.te_avtab, create_type_rules, type_rules=
))
> >                 exit(1);
> >
> > diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compile=
r.c
> > index 4b2f98d8..a6ecc939 100644
> > --- a/checkpolicy/module_compiler.c
> > +++ b/checkpolicy/module_compiler.c
> > @@ -842,12 +842,11 @@ int require_class(int pass)
> >                                 return -1;
> >                         }
> >                         allocated =3D 1;
> > -                       if ((perm =3D malloc(sizeof(*perm))) =3D=3D NUL=
L) {
> > +                       if ((perm =3D calloc(1, sizeof(*perm))) =3D=3D =
NULL) {
> >                                 yyerror("Out of memory!");
> >                                 free(perm_id);
> >                                 return -1;
> >                         }
> > -                       memset(perm, 0, sizeof(*perm));
> >                         ret =3D
> >                             hashtab_insert(datum->permissions.table, pe=
rm_id,
> >                                            perm);
> > --
> > 2.54.0
> >
> >
