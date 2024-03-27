Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B441514E5
	for <selinux@vger.kernel.org>; Wed, 27 Mar 2024 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566177; cv=none; b=BjwCoxxOdNnH9NuqRe/JC5HOn5spVaxYfuRLtgpvEUK3iAhp8hUd0LpftOGmn98Z5EAIsdxQq/yasi1Y1Eq2GKP9BAMw7srJdPmEFfGq4cjraaGbEbQveCYRMBWQNg/+yn7nQ1dnYXli5x5kgoj91cuGsdPJKvCNozpS1+cP5Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566177; c=relaxed/simple;
	bh=D8a5ZfXMpPXAwPj5kiiz0KDYFu4aJWCrtp+mhKqVfls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LvLZ1nY3Abm5yaBAMFgcb4aZOEmQ+4wLKNQZCgURBFyqaXBFq2a+MBdrC2SbqqLc+SznrMJXiBcSNWBG8HFznYyy8E/sEfBdN1QSgOeCVmpjEvAhS9XIdviItu9qktADA2qkNSRPZeIJdFduD5XTAuMeLwz8DGgxTQM0C2o2P6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JH1UMNn1; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JH1UMNn1"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-607c5679842so1587207b3.2
        for <selinux@vger.kernel.org>; Wed, 27 Mar 2024 12:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711566174; x=1712170974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mL5128psZuAbV8STCgbOfU47SK+zDLdVx4j+fOAWeow=;
        b=JH1UMNn1JOrBqCVb/hXMJB3NpFl8XLc2114Jz6Wj7pOu2WJ2tjwCOkTHo3FtvnUNQz
         luaU1TDKel12CVx2oqCqVz5tDQLbJmNibkyEgICzAwt6Pf9i4ZQxfbywjeLlOUaM6ZEy
         NHbmR1AVgmFg68+xSKZdPkwTbMz8zWbevRHKG+3Eyfl2GWCSoKYxS6ndXqZj7REm/2Kw
         ATICr9mTwzcEhi35zf6+7WYZ5ea8t+81w63lZbknJfOkPiI2dPInwzXqyicn+JuLmy/g
         nM/vDgNNsfLKD5vvVf0aAp9RdM4nL5anTR8rDu0UjTLHkQI2A0RMNpOIOPaJhvkU2t56
         DKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711566174; x=1712170974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mL5128psZuAbV8STCgbOfU47SK+zDLdVx4j+fOAWeow=;
        b=HuN9ZGPXCLPYUCUVGnNJPO8az6xgfhT+fQ1idTVL5TBhNMPGKbI/CeK1Gv7auA/J4Z
         cKw7ZQ3fzc0vZzqPmfVWeHyGxgyJg6lqk4qD5q85D32zu3thNTns6vhTgidKSDqo2emu
         evFHJs9asNkrp7Ws21uFMpPYjqUWo6quF6wS3jYSQZu002J2LxZNSeRjJ5G/5LBwC1oJ
         ADWO8XVa/SDyL3eUz+cTQ8IeeIwKelA1UbPqjAut+swGR0WzKT+9B/A7/FlD4QZjna62
         NrxOJXnnN+gXXReyEVIe6VW3VKATfKIrFpH+V8iz90GTJcD77zVESfkgB107ORdaADyY
         jqEw==
X-Gm-Message-State: AOJu0YzXK456Y5mTtHBHEd3aVNcnAU+bQcSC4tFQSWLeJBB7GQ0Q6SkD
	09T6eWAh2f/fpnVIG9RaE/C89CjNC9f1FyR08M/taz7ebb2iCRmuCctEjRgxahaBzRqEb9XZ+lK
	J9QmU9/LCJG3ErfGGDHtGGsjb2Tm4vFScuYi3Tyt8MBE52kg=
X-Google-Smtp-Source: AGHT+IGR5g0iXLoSfOOA2vGxuNjZw+n9wVLKxoj+FnZHokF7/VsBYWr6Q9ZfUo/kafkMthuDRnOIZKc6EANHucp+Ylo=
X-Received: by 2002:a25:a1c8:0:b0:dcc:ec02:38b0 with SMTP id
 a66-20020a25a1c8000000b00dccec0238b0mr665287ybi.64.1711566173577; Wed, 27 Mar
 2024 12:02:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327155201.117066-2-paul@paul-moore.com> <CAJ2a_De6-AfBZ6fAwe-3hzT-r4v=RfaxQ8YyQ4v-MWNei0j_Pw@mail.gmail.com>
In-Reply-To: <CAJ2a_De6-AfBZ6fAwe-3hzT-r4v=RfaxQ8YyQ4v-MWNei0j_Pw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 27 Mar 2024 15:02:42 -0400
Message-ID: <CAHC9VhSxmUQ+DiL68Hk-P_q1bT3LGExObxU0AoymUktuvZxqdw@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix pr_err() format specifier in ebitmap_read()
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 12:56=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> On Wed, 27 Mar 2024 at 16:52, Paul Moore <paul@paul-moore.com> wrote:
> >
> > Correct the use of integer specifiers when printing ebitmap and
> > ebitmap_node information.
> >
> > Fixes: 0142c56682fb ("selinux: reject invalid ebitmaps")
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/selinux/ss/ebitmap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitma=
p.c
> > index f1ba333f127d..13d5fb47a2bb 100644
> > --- a/security/selinux/ss/ebitmap.c
> > +++ b/security/selinux/ss/ebitmap.c
> > @@ -461,7 +461,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
> >         }
> >
> >         if (n && n->startbit + EBITMAP_SIZE !=3D e->highbit) {
> > -               pr_err("SELinux: ebitmap: high bit %d is not equal to t=
he expected value %ld\n",
> > +               pr_err("SELinux: ebitmap: high bit %u is not equal to t=
he expected value %lu\n",
> >                        e->highbit, n->startbit + EBITMAP_SIZE);
>
> Maybe %zu is more appropriate for the second argument?

Agreed, that would be better.  Did you want to submit a patch with
this?  I can always update my patch, but it's always nice when the
original patch author fixes the problems in their patch.

The catch is that you would need to submit the patch soon.

> `n->startbit + EBITMAP_SIZE` should be of type size_t since
> EBITMAP_SIZE is computed via sizeof().
>
> See https://www.kernel.org/doc/html/v6.8/core-api/printk-formats.html

--=20
paul-moore.com
