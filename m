Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F00A1F4C82
	for <selinux@vger.kernel.org>; Fri, 25 Apr 2025 17:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745601321; cv=none; b=nRdW/PhiAmvzAfH149Y7O5kS8Mn1KTJdPmo5AaqL9VnaNGZfP2HcIU71DP6lc3NR3d+7Cz+ZtrpWq0fmT9JUl71mAoY4wdS3JK3iqgicAX3OwDqrC5lQUmkYqk7J+kcIqpcVeVRzr28rBWKbksix7autMJiqx9sXGZwtcYzWUOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745601321; c=relaxed/simple;
	bh=f1VOR6axDQIIOKhrx3S8xL2+rQ+QI+LvhnbQImOh1JQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fP4tDLsiyiwlggeFpsusb78OsL3PipZD0zYvE1XwWKqY5ADhfXa1ZW2+qBsuEOC0Z8Q6eBRWy9/mkyxDzHpGUpA9eMjsys0AaC8vD2hCI+KPV6U4ij/yQvgvdctsk10WgapJX20iELI+k6jBry6kzP7TKNFS1rhYlq0wnvD8Ewc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOydVdi3; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOydVdi3"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-477296dce8dso29111911cf.3
        for <selinux@vger.kernel.org>; Fri, 25 Apr 2025 10:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745601318; x=1746206118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voBjvAmih5g7GdiM4pfh91ek+K/nVGpaaKb/fJ0RHj8=;
        b=LOydVdi3hsw3fMrfb5gktBW5luJ811ZsHe14/m4fFlqe8s0U3VbkcT2FjCthDUlSpY
         ZIX11vhocV8pizkmkDeHRzxXZN2nIgULSyVS7nYYXTFYO2VuDmrhpDppsdJnYk59c047
         mzhymXTb9dUPFja1OalcwrM2o+vmjDYRoz90df0eg8TGU9rtQyAbvWwoH74mwW6HvIyF
         kCCYMJksLHkdV6LF2hHU7b2vyVt7umdrb/uLTwvBSri8e7Gw0JfdeLO9Dn7/6r0jxLXW
         zGLHf6obLu9UOKqO1UQtSf5dx854tPRGFr+ZTwfd113mPCThsvJrZRmdfu66RgRyUi9M
         vWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745601318; x=1746206118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voBjvAmih5g7GdiM4pfh91ek+K/nVGpaaKb/fJ0RHj8=;
        b=SdKWx1hnNTW4/QbvJxgvl7ZmYxj0oHYgkiguYFkGBK9KrAH5BQFa1aYOs1SWx9Kocu
         IA8eKzNz2g6NBIw0PLGquUFRBcojGAoXyeKNmWEG/CZId/iO9eitYGbmaOfPSGUyWyMN
         A9V1eIb92Ho7h43/zDsuhxhLnaoKxQgu7UbbBqWrZbs5kHOe4EMAUU6/dy2LJ7SeikXl
         kwOrjrEpFWkzqrNNzp33aOkeS9XHhtwaHAo5fgYVvMrMzlB7NPSFOT04K2QyVPFGbj8b
         b8flkIPcRZbywdrr6/J3BuBcotFJilvnM/yieUd5M0ef+P6R+WZ+bjbFrsQQ4nVMfxfe
         tDjQ==
X-Gm-Message-State: AOJu0YxkS7O/e9+WLiMBJ1VncKansIE5lw0OIGW3WrYfkVW16rc4Er8j
	5sTdZbmI1If8DNrJ8m4sT1kjmZypeIuVhGEO/Qtc240XmBeZmJzElS5gHUDetEVVM7yXlmeJLMc
	aBpuU1gGFkesYIVSMl5cX/0/DEYYOzg==
X-Gm-Gg: ASbGnctvcS8tBugKKntxK3DWDQKTQmVl1m37FZIs3Oik5QARqyjeY8O29RXa1yPDxVi
	/fmUKx4ouapQT4cbCNDydP+kAdRezVfgQqaIqOA6peKF3wPnq16GhVvvMe950NnB1ICSLeInm++
	c+J89/aKNyFBRy3hP/7c4=
X-Google-Smtp-Source: AGHT+IGC95R9x4H6b61TXezaQqpxkEx5qNILekMiAnuyNPpa7m0fkEDCV/QTXK9s9WgWX44oJ9JUoizwxZ/Iii36ZKo=
X-Received: by 2002:a05:6214:518c:b0:6e8:fac2:2e95 with SMTP id
 6a1803df08f44-6f4cbcb5895mr42244246d6.11.1745601318304; Fri, 25 Apr 2025
 10:15:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404113637.4131353-1-inseob@google.com> <CAP+JOzQ8_7Sg9PVRXf5Zfxmfg+qKOGthdQVG-o+HjAShiqaqgQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQ8_7Sg9PVRXf5Zfxmfg+qKOGthdQVG-o+HjAShiqaqgQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 25 Apr 2025 13:15:07 -0400
X-Gm-Features: ATxdqUE0RL36vOxezDHdBx3qjALpERhdZMO96Ezx3QmdbEDQnjLI8MeAbawsKKs
Message-ID: <CAP+JOzRC61ecUHTBjiOuqKwf-7wN5=7y1Mj-6MJ1rgxT7SgHig@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: Allow lineno > 1 for source file line
To: Inseob Kim <inseob@google.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 12:54=E2=80=AFPM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Fri, Apr 4, 2025 at 7:36=E2=80=AFAM Inseob Kim <inseob@google.com> wro=
te:
> >
> > There are cases that the line number starts with a number greater than
> > one, if preprocessor skipped the very first line. This extends #line
> > syntax so any lineno is valid for lines with a source file path.
> >
> > Signed-off-by: Inseob Kim <inseob@google.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Removing my ACK for now because I found a problem. See below.

> > ---
> >  checkpolicy/policy_scan.l | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> > index 5fb9ff37..c418a629 100644
> > --- a/checkpolicy/policy_scan.l
> > +++ b/checkpolicy/policy_scan.l
> > @@ -56,7 +56,7 @@ void yyfatal(const char *msg)
> >  #define YY_FATAL_ERROR(msg) yyfatal(msg)
> >  #endif
> >
> > -void set_source_file(const char *name);
> > +void set_source_file(const char *line);
> >
> >  char source_file[PATH_MAX];
> >  unsigned long source_lineno =3D 1;
> > @@ -297,7 +297,7 @@ GLBLUB                              { return(GLBLUB=
); }
> >  {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*  { return(IPV6_ADDR);=
 }
> >  {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*"/"{digit}{1,3}       =
 { return(IPV6_CIDR); }
> >  {digit}+(\.({alnum}|[_.])*)?    { return(VERSION_IDENTIFIER); }
> > -#line[ ]1[ ]\"[^\n]*\"         { set_source_file(yytext+9); }
> > +#line[ ]{digit}+[ ]\"[^\n]*\"  { set_source_file(yytext+6); }
> >  #line[ ]{digit}+               {
> >                                   errno =3D 0;
> >                                   source_lineno =3D strtoul(yytext+6, N=
ULL, 10) - 1;
> > @@ -387,10 +387,16 @@ int yywarn(const char *msg)
> >         return 0;
> >  }
> >
> > -void set_source_file(const char *name)
> > +void set_source_file(const char *line)

set_source_file() is called in policy_define.c:init_parser() where it
passes in the file name.

I tested it by specifically setting line numbers which works, but if
you don't do that there are problems.

Maybe the best way would be to break out the part that sets the
source_file to a function called set_source_file() and then have
another function called set_source_line_and_file() which sets the
lineno like below and then calls set_source_file().

Thanks,
Jim

> >  {
> > -       source_lineno =3D 1;
> > -       strncpy(source_file, name, sizeof(source_file)-1);
> > +       char *name;
> > +       errno =3D 0;
> > +       source_lineno =3D strtoul(line, &name, 10) - 1;
> > +       if (errno) {
> > +               yywarn("source line number too big");
> > +       }
> > +       name +=3D 2; /* skip a space and a quote */
> > +       strncpy(source_file, name, sizeof(source_file)-1);
> >         source_file[sizeof(source_file)-1] =3D '\0';
> >         if (strlen(source_file) && source_file[strlen(source_file)-1] =
=3D=3D '"')
> >                 source_file[strlen(source_file)-1] =3D '\0';
> > --
> > 2.49.0.504.g3bcea36a83-goog
> >
> >
