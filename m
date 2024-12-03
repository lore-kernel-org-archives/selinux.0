Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0D81DF27F
	for <selinux@vger.kernel.org>; Tue,  3 Dec 2024 22:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263282; cv=none; b=VWRut0aIhm0MNN6fvXYTr8LRIJB721tM49my8j/UmhFlrwYKr5QIyJhvKlAodbnPyPmm58zpUe7heTyx00UNwMji+SvowUXWlAo3C2k7BIgTicY1WR9roV5AUEclX3ZvKZDfK7KIgNvjF+dtY21+DQfU+577TXUFbhkvqlQV8Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263282; c=relaxed/simple;
	bh=nlLNsIBaPE8DbwU3YOwvEZchSfRrBm/kQ7raa5CRm6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g3T6VwulPxd8TjWrl/9rOM3eS93vjQ4vw9vOAMjbinfGqhHAOR54jzQX7/DWi37RRKiXWyEysm0l9pKvekoPnOKeKWeGdpteWCd8kVER+BaBkQktWXdztM/04+pwAmyEoQacW6aYjv3r+pmikpa8Jq1IZ+kk4Kfbcq5g5yyXl/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiddbXKs; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiddbXKs"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b676152a86so30659885a.1
        for <selinux@vger.kernel.org>; Tue, 03 Dec 2024 14:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733263279; x=1733868079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aww052LXAcIbjz7H3tV75sd9KTXv5E9f6i4IzMNHoUI=;
        b=iiddbXKsPIxnh6bNflF4ehSZfZ3nSWTHri2Rfbk95iDpZlbYnyCLDyt599GQbhJBDh
         VhVMqjUj2hB3tdcnquEVwuqhKXUD99TxdZsa1XljvPU0wSYWMUd+pQR2LuzGj3cRCbbf
         WPIWwdefg0BwgimDDeSWqRyZ5EqfuT8ogsGSzNAXFXQVkzccNfc+Ha+On9DP+DzOJgPG
         BrNi2tYou8c3WXfA/4D7RAMEpqiDhaSvEiI/D/+I2Sy3PiuXY5ub0lQ+Og6KXn2r1oFx
         /TXegt/U4MXOn9Bfhy2Y7e4qenOB8blZSsbfmqey3+WDQN7v2wUMYR0wbjF6xZORZxFT
         TGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733263279; x=1733868079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aww052LXAcIbjz7H3tV75sd9KTXv5E9f6i4IzMNHoUI=;
        b=GjxOlBkkeU+xLI58b2N4BdvHhfFS3ywfaYjBO0qi2aWcTDq19Z5PF0NPKRt3J9+S60
         /V6WxLq/KAvu4hZvzm+tPIsWAGj1zzFBKh4wBbUs7eLAQRS15nmnHbk/jNQo3xmmI1sE
         ay6i2EuFubF8PL7+vhXqyNIs6NXJQPHG151D98ZY/ofm9tFp07M3cNeSfnjq3+cWuR+A
         aXYLEsun0GxCswqTTxkUazxwCAvuzP2uLOIZR+qlW/D2FoJfG8/O2slQJHbUiN7UxVV6
         f/7ERlVtn586+weG3jBv1Ap4yHtrTO3uJxsxVIM03zQqSHXfNAp25myk3eza0qG0BpiD
         L3MA==
X-Forwarded-Encrypted: i=1; AJvYcCU/GLSjrBOLsVQ2DaoMOgve7rZoyWP5E4aqDr7DR+sdm58rLRmj/5WYJ/1sMtyQwiOSqNDFQZ8D@vger.kernel.org
X-Gm-Message-State: AOJu0YwYgCOVkVtaGYMkWYFwErwBxqeB8L87KYxQpf0RJzF1GKmgpXUt
	4z278ZFjX/c2XyboQufXJnCrEJ6F9dhM7nv9wFnmR4tQB10UQBTXYOnpjciwU2FuFr+rILLlHsa
	LOaZVk6VLV4N9nUqUnLai+tTnMqQ=
X-Gm-Gg: ASbGncsyr+gVCbs2o4vsS5/6sV5Pr3ZkaDy8U/Iupc2bFUtURCfWZa8/PCTBeU73xte
	9rFUua8EZOtTGrMWo+jdnNu/LCPirb5Q=
X-Google-Smtp-Source: AGHT+IGw0L6l64lfg9aP77pb0vfSsundiiMsVkAIGmKj3dGajAKvdG/FPo2wY2mrsnTKFfH27siJaVzW+FDCpKz2gPc=
X-Received: by 2002:a05:620a:46a6:b0:7b1:1fdd:d54f with SMTP id
 af79cd13be357-7b683a8337dmr4362910785a.29.1733263279463; Tue, 03 Dec 2024
 14:01:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203155448.48237-1-cgoettsche@seltendoof.de> <87ed2orb32.fsf@redhat.com>
In-Reply-To: <87ed2orb32.fsf@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 3 Dec 2024 17:01:08 -0500
Message-ID: <CAP+JOzQKgatY=eDeN42A5Rh7pq6KCR_ux5ab63JhTojOTrCovg@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux/utils: drop reachable assert in sefcontext_compile
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, 
	selinux@vger.kernel.org, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 11:24=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> Christian G=C3=B6ttsche <cgoettsche@seltendoof.de> writes:
>
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > The two asserts following qsort(3) where useful during development to
> > ensure the comparison function and the corresponding pointer handling
> > were correct.  They however do not take into account an empty file
> > context definition file containing no definitions and thus `stab->nel`
> > being NULL.  Drop the two asserts.
> >
> > Also return early to not depend on whether calloc(3) called with a size
> > of zero returns NULL or a special value.
> >
> > Reported-by: Petr Lautrbach <lautrbach@redhat.com>
> > Closes: https://lore.kernel.org/selinux/87jzchqck5.fsf@redhat.com/
> > Fixes: 92306daf ("libselinux: rework selabel_file(5) database")
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Works for me. Thanks!
>
> Tested-by: Petr Lautrbach <lautrbach@redhat.com>
>

Acked-by: James Carter <jwcart2@gmail.com>

> > ---
> > v2: fix condition from not zero to equal to zero
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  libselinux/utils/sefcontext_compile.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/s=
efcontext_compile.c
> > index 23d31274..e5da51ea 100644
> > --- a/libselinux/utils/sefcontext_compile.c
> > +++ b/libselinux/utils/sefcontext_compile.c
> > @@ -188,6 +188,9 @@ static int write_sidtab(FILE *bin_file, const struc=
t sidtab *stab)
> >       if (len !=3D 1)
> >               return -1;
> >
> > +     if (stab->nel =3D=3D 0)
> > +             return 0;
> > +
> >       /* sort entries by id */
> >       sids =3D calloc(stab->nel, sizeof(*sids));
> >       if (!sids)
> > @@ -203,8 +206,6 @@ static int write_sidtab(FILE *bin_file, const struc=
t sidtab *stab)
> >       }
> >       assert(index =3D=3D stab->nel);
> >       qsort(sids, stab->nel, sizeof(struct security_id), security_id_co=
mpare);
> > -     assert(sids[0].id =3D=3D 1);
> > -     assert(sids[stab->nel - 1].id =3D=3D stab->nel);
> >
> >       /* write raw contexts sorted by id */
> >       for (uint32_t i =3D 0; i < stab->nel; i++) {
> > --
> > 2.45.2
>
>
