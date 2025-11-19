Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9566D194098
	for <selinux@vger.kernel.org>; Wed, 19 Nov 2025 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568081; cv=none; b=Gz3iqYwyj1e+Y37iWZEqJgXy1a8d3fVUfv+8jxfJTrTrjGubHvQ732GRbHWb4+hcHKRStckbXoTIXRl0xN9Gv0AaS/IKcbrt3iMgPBAmn6M/hU+8nBrT7Rkb2FIACalK6J0ujThFhueCGyddpQgUX4ECBEAvbZdEjcNrJ/7ojSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568081; c=relaxed/simple;
	bh=rniMEAlcG4k6RmOAOHyt2Pb7dSzLwXzZREP8XCBmK/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGvTZfXN5jf2tO5eaBFwkPYj2jIt3IgwDGMz/PPPSoTMgQiBqPf1WqQEb53fbZbunBPlnHPJPUFYVpLpGIDU8e3RqMzF7L0fO00quufvJJL3D0RvVq1WvX6DtG00xGgg0O3JRF9fmJXBdqh/ibW+IXjd3MT9X1yVc9isK7BFldY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VXog0hBk; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VXog0hBk"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3418ad69672so4698987a91.3
        for <selinux@vger.kernel.org>; Wed, 19 Nov 2025 08:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1763568079; x=1764172879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qe685wKuah+T7N8wNeFvDE81iMldrSZlF77WqlBYkI=;
        b=VXog0hBkdweuJSOgduilHht7LJwD71h3vQX+/BVZ7t/GdwVmSVLsJbYaOLC8kyDOtU
         /GblnW2grUpF3UAVbnFElxjwlNcXEF0ypg5wUfwtL50iiE525dqS1f0Vt82w6H9YBdq9
         eRLFY9vMoetYlSWru1KQb63DhsRtpJ8gkghc5mqQTx++3dwXtq64x81mc5CG5KbKgha+
         iVbT29/3X1BNHRW3XSs6P4U1LiQjJF1qDEwa7veqSI69wX4b+j3IbaIxC+IJGoQtVTWJ
         n3pX5x5q29/7kSYoDyi/qDryehBLfpzua4AckYlBPe3qNcZ+qDkNKr6cc7iPqO2Ch9AB
         QXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763568079; x=1764172879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7qe685wKuah+T7N8wNeFvDE81iMldrSZlF77WqlBYkI=;
        b=h4jBbj+nBX1vsSZ6jIwXKnNoqEdHrimalQS6+w03rMFNNLhrRe0QSAmmAQ/0aJmTPB
         iEWTq4OEtyOcYaQ2zOBlwfrOLNeT566I+JGorAYW/gSxibkE/HdHvMMgkcihnf/8KWKN
         oq4VF4Xjhw9NEEiygT3ZqkReuXEG2eP5arCqC78TJkyVxiDSorWpb0RuEWSCs8wunOe4
         cPwC8vvFt3YM1Tod2ecSI8JYjotpOqKK6oCI1KBaFFW+6GqgicWuKMnLRmZKeY+1RwRI
         1bYEsxITt8o22ve60FQrLQkGYVcbBpX822okbCHOTmD3lYDeLdp1xylOYnUEQRoBhzrb
         U4ag==
X-Gm-Message-State: AOJu0YxKdeGEqmFNpezOK3M0vW4A7awGQAVPGhKeAI7RKbNKe2jHHcV+
	xZboBjWTxtvVXlBKtKRFDp1ArpBM2cNggAh5BUJmOKFYyEVAwhTnyR38JqObS1XBaamW7wV/L3K
	MTcmY+6+WD0J0tjHoOjvw64/cQbkHNNcnX7obRn9o
X-Gm-Gg: ASbGncuVJAu0YP5oJvEWQmSy0zPoH5k31r+V9P2xaEXAoRfZQg9rpLLqXWhB9FlkJia
	mJOnlriTo2/mt7TsrLsyEibfR1XY2sfCsjTohLBED1FwC5E5e8O3n2sPSoNBXtoOmOAeHPrZWME
	13Fm3ReXYH+x1FdOFlL8w8qH8v2kF9IY3uGA/n8cisEIcdsB40h1VZWZUG3jtH0bkR82mYj2jlL
	F0uUqjN1Qtn9Rjscp7HJEzAnp2cStw1mfRuMdV9uc871ZGgYewQF5PKII+jOW09Wi0V3L0Q4GC6
	JG39bA==
X-Google-Smtp-Source: AGHT+IFvI2ZbHs7AyepcW7BaTt2u4hGbvow7gzOEk1nDTwdC0nbF+zVJZuBF9AweBe31QaeAH3tWK2zby2goq8Mavos=
X-Received: by 2002:a17:90b:1d0e:b0:341:8491:472a with SMTP id
 98e67ed59e1d1-343f9d90850mr24542141a91.4.1763568078244; Wed, 19 Nov 2025
 08:01:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119020334.521449-4-paul@paul-moore.com> <20251119020334.521449-5-paul@paul-moore.com>
 <CAHC9VhQaR9r9uWuJ4h_HoDtyGu1M2tU+ASkWxsFOf6OR_thNUw@mail.gmail.com> <CAEjxPJ6U-dvDbA7zVx+Y-mQyS6sFCT=K_nr=wQo3=R10qRAYAg@mail.gmail.com>
In-Reply-To: <CAEjxPJ6U-dvDbA7zVx+Y-mQyS6sFCT=K_nr=wQo3=R10qRAYAg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 19 Nov 2025 11:01:06 -0500
X-Gm-Features: AWmQ_bn8icJVX8mfUidqs0dNRJCvs9M4pQWEizDHiCR3QzFEpeD1nNBgqAqQXmI
Message-ID: <CAHC9VhRjVYsjeCd0HZYjyhkoB1zGWsLZcyFropDqaceHpKAMMA@mail.gmail.com>
Subject: Re: [PATCH 2/3] selinux: move avdcache to per-task security struct
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 10:58=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Nov 19, 2025 at 10:50=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Tue, Nov 18, 2025 at 9:03=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > From: Stephen Smalley <stephen.smalley.work@gmail.com>
> > >
> > > The avdcache is meant to be per-task; move it to a new
> > > task_security_struct that is duplicated per-task.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 5d7ddc59b3d89b724a5aa8f30d0db94ff8d2d93f ("selinux: reduce pat=
h walk overhead")
> > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > ---
> > >  security/selinux/hooks.c          | 31 ++++++++++++++++++-----------=
--
> > >  security/selinux/include/objsec.h | 13 +++++++++++--
> > >  2 files changed, 29 insertions(+), 15 deletions(-)
> >
> > ...
> >
> > > diff --git a/security/selinux/include/objsec.h b/security/selinux/inc=
lude/objsec.h
> > > index e71ce352bc97..6cc5104fd2f2 100644
> > > --- a/security/selinux/include/objsec.h
> > > +++ b/security/selinux/include/objsec.h
> > > @@ -177,6 +181,11 @@ static inline struct cred_security_struct *selin=
ux_cred(const struct cred *cred)
> > >         return cred->security + selinux_blob_sizes.lbs_cred;
> > >  }
> > >
> > > +static inline struct task_security_struct *selinux_task(const struct=
 task_struct *task)
> > > +{
> > > +       return task->security + selinux_blob_sizes.lbs_task;
> > > +}
> >
> > FYI, I just noticed this and fixed it, but selinux_task() needed to be
> > wrapped to fit under 80 characters.
>
> Ok, wasn't sure since we didn't wrap selinux_cred() but I guess it is
> just on the edge of 80.

Also don't discount me simply missing something ;)

--=20
paul-moore.com
