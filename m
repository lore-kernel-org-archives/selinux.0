Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857E516BE20
	for <selinux@vger.kernel.org>; Wed,  4 Dec 2024 14:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322745; cv=none; b=ElejQFySS21ygrbmliFonHdrT6SL9TP3vbfDFwXchR1snIoDRq1cPWINI7ovinWDg4TBXw2hbSu1TFVgNZOf6KdvQ01t8vV6QXwm++rrREmFslJM75+KqG2fWJRg8VNPWKBvJCvpfmw+jDaKDBuaru8W0lpy1glyRPkSkM1nHCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322745; c=relaxed/simple;
	bh=rpAdguYzguJ4xJJcXZPpr19454CrS2+POE7Du42mh9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdcfXJbSE0Q84K1nJc7hpqpVjl3YMX8Vfazt3DBm/fzAM6xhTHdloPTJQYj7jar5q0OYGCdLSHzYBq0tu+84WHGlYDpPN2yBNJbxSvdM0ucrVuoNvEc5RGDoiI3g5pF9vUA4GxeYRmRKp3XJlJ0GQMBKpK5Iz4vZx9pg4tQJdg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1MtzHdi; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1MtzHdi"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b66d55522dso466893285a.1
        for <selinux@vger.kernel.org>; Wed, 04 Dec 2024 06:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733322742; x=1733927542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsXjSPdKp1OmrfhHIz4Hm+LPy45dQyl0TlfU40guLkk=;
        b=j1MtzHdiNVXMKzvOsGAfCYAWzES2RrT+3noYM8/kFJpEPLdgQiDA8bV4xwmwg8ArTh
         MRb9NlO+n6jSrxhNKFJZcffjiohp0g9KWc0QtVmchMqKYoATwhFbOJ9MuOGJRXfNUW3p
         +uhc91PuB1cPOfVqDBxTszvPqh5BugDhHTRtNVCh8+ZGoy/1ptb19dC9dzLEtNJt3wwZ
         NHL9V/VLVOHo91hmvPZ9eTxwOCcS+RfFvfrcn0gbUid5alN7L9sFw6inmCGwmzL44qXO
         4ytQBfIB/ccMP5fAFmi7giWFaDO71bNjdyIkzPy74sJTC2SyLYluYv/SCA/aLXGKuQ/r
         +4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733322742; x=1733927542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsXjSPdKp1OmrfhHIz4Hm+LPy45dQyl0TlfU40guLkk=;
        b=fULDi2zmGIZKJ8OwgijycuN3XCAUxAgq+LsZ0mBNkEsd1//vCtWh6YECctnTobm5ZM
         n3YLfwSRTxhfhg6rubTXxfvSZ+sPQ/ynksTNua3hm0XEdYOxqWGBfLCVVebYfT8D8270
         tbJJKzhV6pQAbeMkLmojFpgpyJFq3Ax9rlZow6ZdNs0CPzLmJDShvSSAWP5HMnJqeDTg
         PcC2ar5qmuX4xpYsRBRcJwIjLc2VqqQj5LC0rh69ykeWG3E7cgmyE16yJuyFxNSdJ1Z6
         8V/jdNsA2pVnR3m8+MIYifoXFCvZAp6dodsF6VpdXK//8n8pPLN6VRsblePMBfGqYbW0
         Xklw==
X-Forwarded-Encrypted: i=1; AJvYcCXmVkI1XEpDNPxwCYjndTVPHkVdRYrw7i+Ibg0jFW+BOk/2Wt22ZPJjrv5ctp8PPcgdduQHbks/@vger.kernel.org
X-Gm-Message-State: AOJu0YzHnCuNBmbRWSaI06rYfbErT9PYr0J+28rGAGOkvZX/q/sLx4eC
	C9dLQfKTI4sI7zsVLrVLUcYRvf/VtrscUSbdlf5aWPIHAo50o9KWM2u2LYX9CrHpjFVsaRv10fe
	6aZCX8NP/9UMIUbSMXrFuqDoCKsg=
X-Gm-Gg: ASbGncv2QywVqk2A/ey152APfBmxEuXDNATR46KUUYywDEM04dXEzb33OEGwQjYNVOn
	aRrpOvHsZVvN0n7gbteDrjNr+MBJ8QCM=
X-Google-Smtp-Source: AGHT+IFBb+87N8OB+DnJjgozPpBaZ+ydSms+1iU8zoYkM2GkxonIGrhz4shJZ7IufuOiBaWCd8QOt2rmOV5Zh1gaVec=
X-Received: by 2002:a05:620a:1916:b0:7b6:6756:eef5 with SMTP id
 af79cd13be357-7b6a5d28ec8mr770864885a.4.1733322742353; Wed, 04 Dec 2024
 06:32:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203155448.48237-1-cgoettsche@seltendoof.de>
 <87ed2orb32.fsf@redhat.com> <CAP+JOzQKgatY=eDeN42A5Rh7pq6KCR_ux5ab63JhTojOTrCovg@mail.gmail.com>
In-Reply-To: <CAP+JOzQKgatY=eDeN42A5Rh7pq6KCR_ux5ab63JhTojOTrCovg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 4 Dec 2024 09:32:11 -0500
Message-ID: <CAP+JOzQ0pn2yN5aTOpU5nMJjr9rANWM7vyqxdBR8ewPtUhMJWA@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux/utils: drop reachable assert in sefcontext_compile
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, 
	selinux@vger.kernel.org, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 5:01=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Tue, Dec 3, 2024 at 11:24=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.=
com> wrote:
> >
> > Christian G=C3=B6ttsche <cgoettsche@seltendoof.de> writes:
> >
> > > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > >
> > > The two asserts following qsort(3) where useful during development to
> > > ensure the comparison function and the corresponding pointer handling
> > > were correct.  They however do not take into account an empty file
> > > context definition file containing no definitions and thus `stab->nel=
`
> > > being NULL.  Drop the two asserts.
> > >
> > > Also return early to not depend on whether calloc(3) called with a si=
ze
> > > of zero returns NULL or a special value.
> > >
> > > Reported-by: Petr Lautrbach <lautrbach@redhat.com>
> > > Closes: https://lore.kernel.org/selinux/87jzchqck5.fsf@redhat.com/
> > > Fixes: 92306daf ("libselinux: rework selabel_file(5) database")
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Works for me. Thanks!
> >
> > Tested-by: Petr Lautrbach <lautrbach@redhat.com>
> >
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > > ---
> > > v2: fix condition from not zero to equal to zero
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > ---
> > >  libselinux/utils/sefcontext_compile.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils=
/sefcontext_compile.c
> > > index 23d31274..e5da51ea 100644
> > > --- a/libselinux/utils/sefcontext_compile.c
> > > +++ b/libselinux/utils/sefcontext_compile.c
> > > @@ -188,6 +188,9 @@ static int write_sidtab(FILE *bin_file, const str=
uct sidtab *stab)
> > >       if (len !=3D 1)
> > >               return -1;
> > >
> > > +     if (stab->nel =3D=3D 0)
> > > +             return 0;
> > > +
> > >       /* sort entries by id */
> > >       sids =3D calloc(stab->nel, sizeof(*sids));
> > >       if (!sids)
> > > @@ -203,8 +206,6 @@ static int write_sidtab(FILE *bin_file, const str=
uct sidtab *stab)
> > >       }
> > >       assert(index =3D=3D stab->nel);
> > >       qsort(sids, stab->nel, sizeof(struct security_id), security_id_=
compare);
> > > -     assert(sids[0].id =3D=3D 1);
> > > -     assert(sids[stab->nel - 1].id =3D=3D stab->nel);
> > >
> > >       /* write raw contexts sorted by id */
> > >       for (uint32_t i =3D 0; i < stab->nel; i++) {
> > > --
> > > 2.45.2
> >
> >
