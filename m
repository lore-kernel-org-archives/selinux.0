Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520DA16A930
	for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 20:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734467123; cv=none; b=JzVr7viuPcON4lTuq0hy9Zf35JtdKt9FXKpRt6/B3nsDltZJQoomV30Daze/lvw7OyRUgrN8wtRxy8NSKU4FJifo+lnOA1YtQAp3MAxUn3hEfsLT673CKFxrvC01+LqaA3x7IA4xiCB4FnVrGfhw6LM+p3zGwdf7Bgkz6vcE6fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734467123; c=relaxed/simple;
	bh=SmFH+gpshzJCPnyG14fkoOiuhDqRDPbM2b3AFi5q9nw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RwcNtWVZQSonrkarhtSp71OnBLUUn2uhwLJ6eDNs4EgF5sW9/UkWn9xd51Zj8CGq6MQJRtfpbULqOMZ6gmMH4wUnNm/f0cr/WI3L+ohKe1eaLPyiRi7FRPFEZj9XJYAOkDp5Iy3fUY1QCu30J4QPP6qQ3WdXoXv2tTTzzRH8hiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnoXh+NO; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnoXh+NO"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-85c5eb83a7fso2402798241.2
        for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 12:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734467121; x=1735071921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nhj62Re8zjKq1Z7+Q6RxG34dtkAvrhdkZga/8dJIxis=;
        b=nnoXh+NOdQmOha67mhOdPGddrVPY+mJbJMgsHR2+XU9lc4yiLREN/2Bldvu5+LYGmF
         MfGVyICSb5WVvuYJfamg5f1iCxJpH0Z1V3QSj7mqnZO0c9+UOT6A6FT94tvC6Eyv3yOS
         O4eNyjLGCWQgr98YwR+WZ9krCMlh3j/YLYa9y513JmgqrRlh6zUBT4alkliiZTDX1tyL
         lJcbPbELqWF4vPcBraTfLsw7x17KDbY7SeRXrgRBP9fLav+zgKsfQAqDZCBfH/Hx30zU
         /uWBzzkpmtri7mtbjjTI9vfArSDm97oaorF7r1796hGkPVmyu7yzA20JaQfoAtj66ex2
         SVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734467121; x=1735071921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nhj62Re8zjKq1Z7+Q6RxG34dtkAvrhdkZga/8dJIxis=;
        b=JZLmgN/m7GpkQV4wGrBrOkmSS/X/kZ2IJxuGugPkGQMZ0W+OuEz8QT7sln8CZzYFCE
         77VX8XM0mH231PL9YkxangyclvYILf4IIBbuRMIvk0BBFMDQOqqzOJn+qf3e3VIYO9xo
         OSJFhanKTkQ7ZV8wVKXn/NA0ADkMzIMUUTKwtC6gwsVYg0JEKn3pT0dNuUNIXznearyg
         rl5CP36QMWHwwwQo6ySs/Hcheha0pcHACgEVs/iKojYKctO58AyogGm1l1lisbthaKlQ
         Ygk/IJxhp9FjD/nIBsbDVeyUy+7ckirYBKoXqDGAiRsPmCPg44kLaubpffQJlIGGQ1k9
         7ehA==
X-Gm-Message-State: AOJu0Yy0G91Ip8XujcnZqFNMu8uyOeaynerq7O1H9BMNOpolILF2jb2g
	K4fu1sj7E8JTjE2Vdeg/zPfQ+XPI+XmJQ+P5KrpzRD6m84+AwIRKACrQidhSKv0Gm2UEvdGMCYm
	LmbstXxakqDbFS9shTLm90OHZn9Umlw==
X-Gm-Gg: ASbGncu9jMBEeDvhUKNpQkSSPauHixn/x2RtIRaTilxy2W4ocdefK7OdWClrdKQ4+NW
	aKymbgxOD/mwdUB3czA+uiRw8osbnlbf3ozZW9A==
X-Google-Smtp-Source: AGHT+IFiOwSOPEaEvFCREW6RXU3p6TKiqtcb1QsGdPSR/eH0qZzsrTLRWQ+ljnikHWIoKuprtDQ5r7/RnwufnVyz0TM=
X-Received: by 2002:a05:6102:1489:b0:4b1:11c6:d3d2 with SMTP id
 ada2fe7eead31-4b2ae91be61mr230562137.27.1734467121035; Tue, 17 Dec 2024
 12:25:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819182123.1037607-2-lautrbach@redhat.com>
 <20240827113150.1843304-1-lautrbach@redhat.com> <CAP+JOzRsUGNtO4j2T6Wfnj=MgUhqxxxHqKqOjXgxqa+Rap6evw@mail.gmail.com>
In-Reply-To: <CAP+JOzRsUGNtO4j2T6Wfnj=MgUhqxxxHqKqOjXgxqa+Rap6evw@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 17 Dec 2024 15:25:10 -0500
Message-ID: <CAP+JOzQvwgRt8Ggz4gjt5eeUb-PSe_tUu-VDStSMLsFP08EhNg@mail.gmail.com>
Subject: Re: [PATCH v2] sepolgen-ifgen: allow M4 escaped filenames
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 2:34=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Tue, Aug 27, 2024 at 7:32=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.=
com> wrote:
> >
> > When a file name in type transition rule used in an interface is same a=
s
> > a keyword, it needs to be M4 escaped so that the keyword is not expande=
d
> > by M4, e.g.
> >
> > -       filetrans_pattern($1, virt_var_run_t, virtinterfaced_var_run_t,=
 dir, "interface")
> > +       filetrans_pattern($1, virt_var_run_t, virtinterfaced_var_run_t,=
 dir, ``"interface"'')
> >
> > But sepolgen-ifgen could not parse such string:
> >
> >     # sepolgen-ifgen
> >     Illegal character '`'
> >
> > This change allows M4 escaping inside quoted strings and fixed describe=
d
> > problem.
> >
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D2254206
> >
> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>
> Sorry, I don't know how I missed this patch earlier.
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >
> > change to v1:
> >
> > - use ``"..."'' instead of "``..''" - sugested in https://github.com/SE=
LinuxProject/selint/pull/291 by
> >   @cgzones
> >
> > - controls right number of openning and closing quotes
> >
> >  python/sepolgen/src/sepolgen/refparser.py | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolge=
n/src/sepolgen/refparser.py
> > index e261d3f78f87..c8a3eb54d679 100644
> > --- a/python/sepolgen/src/sepolgen/refparser.py
> > +++ b/python/sepolgen/src/sepolgen/refparser.py
> > @@ -486,7 +486,7 @@ def p_interface_call_param(p):
> >                              | nested_id_set
> >                              | TRUE
> >                              | FALSE
> > -                            | FILENAME
> > +                            | quoted_filename
> >      '''
> >      # Intentionally let single identifiers pass through
> >      # List means set, non-list identifier
> > @@ -1027,6 +1027,11 @@ def p_optional_semi(p):
> >                     | empty'''
> >      pass
> >
> > +def p_quoted_filename(p):
> > +    '''quoted_filename : TICK quoted_filename SQUOTE
> > +                       | FILENAME
> > +    '''
> > +    p[0] =3D p[1]
> >
> >  #
> >  # Interface to the parser
> > --
> > 2.46.0
> >
> >
