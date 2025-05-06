Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D201B9831
	for <selinux@vger.kernel.org>; Tue,  6 May 2025 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560054; cv=none; b=TCyhyz2fGS9bQM/fBDNClEZGfMZ9pm0PD17FJuVecFA6BVryfb4OwECw9rVgZEqbAiadWNmM5ZH1BTkCffbX6LaBtrhWYRNPOpxBn2qZG79YKpyew2vQpMBiZEkOou9K/DZBLhRcMRblqX54Ugrkfh9lnNn2PlfroKj/8CBGOb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560054; c=relaxed/simple;
	bh=D/mxaM9LL+mcrfnRPmiZMGSDrxQhs0/+SRIjbkS2N9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRUvZe3WjxOOJlNnYOXabP1DFvwVRnWtnwfqhOueh1NJlUHs69Mb+Sahlsa/yrRQycLUA+cipQyMS2yHt36Q7xdqCsTsPmR1vT7bPpZaD3AnJHtPKU4fyV3BmQSL8sIdmJ+jYKVgx2SIpwjB6d2iYQvLh790HGKs2OGuXDRVMz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sozxl25r; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sozxl25r"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4c5574f04easo1881071137.3
        for <selinux@vger.kernel.org>; Tue, 06 May 2025 12:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746560051; x=1747164851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xi5Q3clJmX6Va9FIxLH2oqGnn35Y8oCOc83ZQZBcvUI=;
        b=Sozxl25rD63z1BtiBr4FTzA9bnR9L2h5LrxLv4p2A963AaGQhj4vgmWlTAiJFP+PBq
         LOR+76Ep3WycfRzIjCJsy8OUgl7bwL9fIoiZHXnVcrvMaiwjwofX7ndgLeEm84jwPzdc
         nzniq654pgSb5FNyXsTfIsLQ8adVFR0h2EvpK7Fb0/r4Fa/sdOoqyLnUE2asBwh/2+Vc
         7tzY3J6/+gG2Y5zeNmZJPeXF1Z2ymBSfZ7W10vwwC2nB1pG2c38b7QhiZOL1g+5+wFoZ
         7HqHQoedOxjcH47MY0LJGVITalXZKuziIBdxxwaZHmO9H49K6dogROm+ZfLG5kEuPOok
         ZKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746560051; x=1747164851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xi5Q3clJmX6Va9FIxLH2oqGnn35Y8oCOc83ZQZBcvUI=;
        b=URotQ5ZCg7qOH+K/rxT/7LMY1YwIiw9OH8cW1yf/a7Ef4e6BYBUbkEgkTFJvsjnV5U
         kGDF3tf1WEk2uJlKT5CgAVRfq1XxxZXjJeoH8NO1E0+NpO5Cdg3HVU+5MTyc8nju2Z3I
         LyrBTgECPKXo5hsU1LbW4jM103iw4As0LJ7YhV5GYYxP9UKqwkKUqcH6KKalbvptHg9N
         qh2z2R5z+T4oev4lsZVXGKmUmDI8OEwBBrnW7lmRh9uxGM2O0jUP8/jE4ecnzOwUDXac
         Eyl3yhUr8PuoY2cttWwxahOuiot1aqKckren0l19s7kgGuMuufcI2Iza7v82PLSXGoIw
         Hprg==
X-Gm-Message-State: AOJu0YzhNquKSoap/WlRxTfGdopVyQ0B091xoR8BxlD/TNWul+D0pr28
	S09xhNd04KD1d3/J6POy0LuiEt7IzRo91M/RQMkS8pB2uua1YzaUef9FlCNhLuFVHk0C4yQQa1N
	Vooi3Xe1HQPW45kAZ0Jt4QWeaucE=
X-Gm-Gg: ASbGnctwfKvFTtZ+l8CrdJAq7xBaA9OStCK/8Is9E0Yat2zKPGYpZgO8vcJyEu0VZkb
	z8eyho2jGcU7Rq8iLZ9B43D/BqWhs/rGi7gSc6BAcHZUrR9b1RhjS4lVvAzsD0bqUwYIf39+Sjv
	lx7C3pzKEgMxUV1FDBgdY=
X-Google-Smtp-Source: AGHT+IGp2HCgEfQm+MMirQnG7jA2qrF+OTSL++LrfDIssoFPNyQaG/DQ1K/dKYJNBXaV0x8HDvt6rxNiAjHM+Qo0zv8=
X-Received: by 2002:a05:6102:3e03:b0:4da:e71a:17db with SMTP id
 ada2fe7eead31-4dc737fd624mr864575137.13.1746560050995; Tue, 06 May 2025
 12:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430085757.2622178-1-inseob@google.com> <CAP+JOzTuwcZFpAEurkjiazcMXAQqzTc4=JQEswOwb+9KR=82mw@mail.gmail.com>
In-Reply-To: <CAP+JOzTuwcZFpAEurkjiazcMXAQqzTc4=JQEswOwb+9KR=82mw@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 6 May 2025 15:34:00 -0400
X-Gm-Features: ATxdqUEn9DqMo0HAKSZ_4Hq5T1hbraKSnS0eOJZAM44RbtVn3DSP7CQ_WswsjwQ
Message-ID: <CAP+JOzR923MYF0tRyWwHZvcijJx-zLUWarr15uuxwSB7LLznig@mail.gmail.com>
Subject: Re: [PATCH v2] checkpolicy: Allow lineno > 1 for source file line
To: Inseob Kim <inseob@google.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 12:00=E2=80=AFPM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Wed, Apr 30, 2025 at 4:58=E2=80=AFAM Inseob Kim <inseob@google.com> wr=
ote:
> >
> > There are cases that the line number starts with a number greater than
> > one, if preprocessor skipped the very first line. This extends #line
> > syntax so any lineno is valid for lines with a source file path.
> >
> > Signed-off-by: Inseob Kim <inseob@google.com>
> >
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > Changes since v1:
> > - Leave set_source_file as-is to prevent regressions
> > ---
> >  checkpolicy/policy_scan.l | 21 ++++++++++++++++++++-
> >  1 file changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> > index 5fb9ff37..7bdea427 100644
> > --- a/checkpolicy/policy_scan.l
> > +++ b/checkpolicy/policy_scan.l
> > @@ -57,6 +57,7 @@ void yyfatal(const char *msg)
> >  #endif
> >
> >  void set_source_file(const char *name);
> > +static void set_source_line_and_file(const char *line);
> >
> >  char source_file[PATH_MAX];
> >  unsigned long source_lineno =3D 1;
> > @@ -297,7 +298,7 @@ GLBLUB                              { return(GLBLUB=
); }
> >  {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*  { return(IPV6_ADDR);=
 }
> >  {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*"/"{digit}{1,3}       =
 { return(IPV6_CIDR); }
> >  {digit}+(\.({alnum}|[_.])*)?    { return(VERSION_IDENTIFIER); }
> > -#line[ ]1[ ]\"[^\n]*\"         { set_source_file(yytext+9); }
> > +#line[ ]{digit}+[ ]\"[^\n]*\"  { set_source_line_and_file(yytext+6); }
> >  #line[ ]{digit}+               {
> >                                   errno =3D 0;
> >                                   source_lineno =3D strtoul(yytext+6, N=
ULL, 10) - 1;
> > @@ -395,3 +396,21 @@ void set_source_file(const char *name)
> >         if (strlen(source_file) && source_file[strlen(source_file)-1] =
=3D=3D '"')
> >                 source_file[strlen(source_file)-1] =3D '\0';
> >  }
> > +
> > +void set_source_line_and_file(const char *line)
> > +{
> > +       char *name;
> > +       unsigned long lineno;
> > +       errno =3D 0;
> > +       lineno =3D strtoul(line, &name, 10) - 1;
> > +       if (errno) {
> > +               yywarn("source line number too big");
> > +       }
> > +       set_source_file(name + 2 /* skip a space and a quote */ );
> > +
> > +       /*
> > +        * set_source_file sets source_lineno to 1.
> > +        * Assign source_lineno after calling set_source_file.
> > +        */
> > +       source_lineno =3D lineno;
> > +}
> > --
> > 2.49.0.901.g37484f566f-goog
> >
> >
