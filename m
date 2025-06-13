Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7179A1BEF8C
	for <selinux@vger.kernel.org>; Fri, 13 Jun 2025 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749837687; cv=none; b=hmmSM68KYNQCBwNp35QfIdPCjj1Eo7U9LnmYcHcSeDQ9cysw4oG7Vy3pNMSgtbOXmDi+fcfnyJqnQzQHWy/ba3KerJ+nu7ShOq4sgAOQ3Gv8OhVInuFUcBuhb7Jry15VaCGntUyZYS/q2fBpMGdTWIZGQhACDAhd9kh42zGAHec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749837687; c=relaxed/simple;
	bh=p0ys9Or3Q/FxBpaudYWiyL/uDfHIqEUtwARHF5HSsoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ViP/KlZ6YnkRWGRgSp8vY4siMg4PGoQm1S67ZkSjQUgtZEDY63xlLKLbUeMAy3R1FeYyFeQaRfDfhuvBZ9ospLB1ivmU0/SYqVmb395rZsGqqwLAiihBj5ZSCSjrrtG3jtAckZzITfRIBFkQIeasqmy4DAKvLoL9NtUFS8Qx5G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtLQKnm6; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtLQKnm6"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4e7eb3fad4fso526529137.0
        for <selinux@vger.kernel.org>; Fri, 13 Jun 2025 11:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749837684; x=1750442484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pb7/8HHmz3M34T41Tnf4wkgfo9Zud972TkNRtYDEtPI=;
        b=AtLQKnm6OaY8OAAkWKJeLmRkuPMdFms8onw2RE9Couwm0cSdCmK5QuhJsWKu56/Ro/
         ey0CztbsnALiTi4XRwUFPHlsNPU1xvaG3yhSwp73sXNABw/CzWvBUf92BvAa0uLPjI9K
         OvfW5Re2SRHlAASPGKluAfe2xDl8/bjjP74wbrctUidMc4cZhZQIyiK/r0En7Vz/WorO
         ZJwy/C280PDfFNoMmDqB+MWpMdY6Usp56xDVb5htAj+a2vJ0HPIcok2V2LBKttrNbp1T
         0pkcVqKRDmwkzCMhcUKrXkRB68PCt6uoCGCfGRZPu0hYuU9GN2D7Q0W4gap/W4LNB1yP
         jmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749837684; x=1750442484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pb7/8HHmz3M34T41Tnf4wkgfo9Zud972TkNRtYDEtPI=;
        b=AIu/khVLE4UEaQ7NlD/1Ak2O95PaMpisVYIaWVu8ZNm9j4mG5ZOLG5YJ5TDbV9a2OA
         zF7VQDaqM2Iguj2Y1XPJw4DhR9PMALU9xq62Nag+9lCW4U4hmNYvbhReQ08ftVVwR+zY
         MbqxDAfCn3kDbTLwgDnJy+ZrhZvqf8oLFYXFabGzRIWzNUJHE4XHKBc9DLOekmgALYvN
         3JHF4PC1Ds9kc53e0gIt2GecM4oHk43pH6KrIyDxGBdNpkzibTQT06E6BPzsXG1dTBAM
         3Ggp7m0qkr6ab9+4oJtoMILfiNpGPbFKYsq3/+kzGTDtq1SeuC97qhKMq/amfGbkgbkZ
         YIvg==
X-Gm-Message-State: AOJu0YwBd9JA1McnLpX7OMVMNMCvzZ89Ipr44VBb4y0QWtcm0IkYjxn6
	fGccfnqENZg870X+eIWGJ+0P1A4V94ntc23UJjGj2UlnRBa5ZzLpAB6orZ1QsR9zT3P4PSCU1ve
	G4sKvdGZyuWJUxO199KhtyHP9WodRiFs=
X-Gm-Gg: ASbGnctEkJHQATx5/TL84EDShrduBHdQbPkdL9FpX5a+iIHJUUxxJAo9oGTXz3azPvg
	VlwbpJq8xB7C9xT0Gi+yTYt02bMRZcDiLW4Fh95eJRDLS1IX2leqCE5EFQi2nuyrO3PuQjRJGDj
	Snzb+XQuyjDid6L6jaHk88lvXg+V0s5HjqKe52FlbDXqjzIgKjGuA5ZQ==
X-Google-Smtp-Source: AGHT+IHqoEAja4S3+y/3pkCDb3y2vB+CAP946Pnd3MLDtzi5vc9+IwG69YvRgAtslA0eoXNNVMFpy9vuYuWEbw9hM6w=
X-Received: by 2002:a05:6102:2d0c:b0:4dd:b192:960f with SMTP id
 ada2fe7eead31-4e7f61cea03mr759302137.13.1749837684175; Fri, 13 Jun 2025
 11:01:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530114836.30643-1-cgoettsche@seltendoof.de>
 <20250530114836.30643-3-cgoettsche@seltendoof.de> <CAP+JOzT0fQCU5cuupP7hESNTeYaphJjiYUkubwwyhkDjpXtEVA@mail.gmail.com>
In-Reply-To: <CAP+JOzT0fQCU5cuupP7hESNTeYaphJjiYUkubwwyhkDjpXtEVA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 13 Jun 2025 14:01:13 -0400
X-Gm-Features: AX0GCFsdvbRyqpALqhIf6Nqih5Yhe7gREiTEBCizAsTVU2WTrixJQHrGVYUo7Yc
Message-ID: <CAP+JOzTUMhvPGfGu8BOCT_zYLDQSaEbCd6fsNwQUjCcRDNVWbQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] checkpolicy: add support for wildcard netifcon names
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
Cc: selinux@vger.kernel.org, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 12:30=E2=80=AFPM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Fri, May 30, 2025 at 7:54=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Support network interface names containing wildcards.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  checkpolicy/policy_parse.y                         | 8 +++++++-
> >  checkpolicy/policy_scan.l                          | 1 +
> >  checkpolicy/tests/policy_allonce.conf              | 4 ++++
> >  checkpolicy/tests/policy_allonce.expected.conf     | 4 ++++
> >  checkpolicy/tests/policy_allonce.expected_opt.conf | 4 ++++
> >  5 files changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
> > index 7e117222..f9181eaf 100644
> > --- a/checkpolicy/policy_parse.y
> > +++ b/checkpolicy/policy_parse.y
> > @@ -153,6 +153,7 @@ typedef int (* require_func_t)(int pass);
> >  %token POLICYCAP
> >  %token PERMISSIVE
> >  %token FILESYSTEM
> > +%token NETIFNAME
> >  %token DEFAULT_USER DEFAULT_ROLE DEFAULT_TYPE DEFAULT_RANGE
> >  %token LOW_HIGH LOW HIGH GLBLUB
> >  %token INVALID_CHAR
> > @@ -748,7 +749,7 @@ opt_netif_contexts      : netif_contexts
> >  netif_contexts         : netif_context_def
> >                         | netif_contexts netif_context_def
> >                         ;
> > -netif_context_def      : NETIFCON identifier security_context_def secu=
rity_context_def
> > +netif_context_def      : NETIFCON netifname security_context_def secur=
ity_context_def
> >                         {if (define_netif_context()) YYABORT;}
> >                         ;
> >  opt_node_contexts       : node_contexts
> > @@ -901,6 +902,11 @@ path               : PATH
> >  filename               : FILENAME
> >                         { yytext[strlen(yytext) - 1] =3D '\0'; if (inse=
rt_id(yytext + 1,0)) YYABORT; }
> >                         ;
> > +netifname              : NETIFNAME
> > +                       { if (insert_id(yytext,0)) YYABORT; }
> > +                        | IDENTIFIER
> > +                       { if (insert_id(yytext,0)) YYABORT; }
> > +                        ;
> >  number                 : NUMBER
> >                         { unsigned long x;
> >                           errno =3D 0;
> > diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> > index 7bdea427..0076062d 100644
> > --- a/checkpolicy/policy_scan.l
> > +++ b/checkpolicy/policy_scan.l
> > @@ -298,6 +298,7 @@ GLBLUB                              { return(GLBLUB=
); }
> >  {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*  { return(IPV6_ADDR);=
 }
> >  {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*"/"{digit}{1,3}       =
 { return(IPV6_CIDR); }
> >  {digit}+(\.({alnum}|[_.])*)?    { return(VERSION_IDENTIFIER); }
> > +({alnum}({alnum}|[\*\?_]){0,15}|[\*\?]({alnum}|[\*\?_]){1,15}) { retur=
n(NETIFNAME); }
>
> Overall, this patch series looks good. The sorting all seems to work
> as expected.
>
> There are a few issues with the handling of netif names.
> CIL will accept both "*" and "?" as the netif name, but checkpolicy
> does not. I don't know if this is desired or not. Might need to add a
> function in cil_verify.c to check that the netif name is legal.
> Also, checkpolicy gives a syntax error for any netif name that starts
> with a number but does not have "*" or "?" in it. My guess is that it
> is matching something other than NETIFNAME.
>
> Thanks,
> Jim
>

So a netifname can match a NETIFNAME, IDENTIFIER, or a FILESYSTEM. The
first two are already allowed, but it looks like the last one needs to
be added.
Thanks,
Jim

> >  #line[ ]{digit}+[ ]\"[^\n]*\"  { set_source_line_and_file(yytext+6); }
> >  #line[ ]{digit}+               {
> >                                   errno =3D 0;
> > diff --git a/checkpolicy/tests/policy_allonce.conf b/checkpolicy/tests/=
policy_allonce.conf
> > index 95a0f265..469eb9b6 100644
> > --- a/checkpolicy/tests/policy_allonce.conf
> > +++ b/checkpolicy/tests/policy_allonce.conf
> > @@ -74,6 +74,10 @@ genfscon proc "/file1" -- USER1:ROLE1:TYPE1
> >  genfscon proc "/path/to/file" USER1:ROLE1:TYPE1
> >  portcon tcp 80 USER1:ROLE1:TYPE1
> >  portcon udp 100-200 USER1:ROLE1:TYPE1
> > +netifcon net? USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> > +netifcon net* USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> > +netifcon netx* USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> > +netifcon net USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> >  netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> >  nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
> >  nodecon 192.168.42.0 255.255.0.0 USER1:ROLE1:TYPE1
> > diff --git a/checkpolicy/tests/policy_allonce.expected.conf b/checkpoli=
cy/tests/policy_allonce.expected.conf
> > index 79d62319..b3a51bef 100644
> > --- a/checkpolicy/tests/policy_allonce.expected.conf
> > +++ b/checkpolicy/tests/policy_allonce.expected.conf
> > @@ -80,6 +80,10 @@ genfscon proc "/path/to/file" USER1:ROLE1:TYPE1
> >  portcon tcp 80 USER1:ROLE1:TYPE1
> >  portcon udp 100-200 USER1:ROLE1:TYPE1
> >  netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> > +netifcon net USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> > +netifcon netx* USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> > +netifcon net? USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> > +netifcon net* USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> >  nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
> >  nodecon 127.0.0.0 255.255.255.0 USER1:ROLE1:TYPE1
> >  nodecon 192.168.0.0 255.255.0.0 USER1:ROLE1:TYPE1
> > diff --git a/checkpolicy/tests/policy_allonce.expected_opt.conf b/check=
policy/tests/policy_allonce.expected_opt.conf
> > index fa4e319b..a7914c64 100644
> > --- a/checkpolicy/tests/policy_allonce.expected_opt.conf
> > +++ b/checkpolicy/tests/policy_allonce.expected_opt.conf
> > @@ -80,6 +80,10 @@ genfscon proc "/path/to/file" USER1:ROLE1:TYPE1
> >  portcon tcp 80 USER1:ROLE1:TYPE1
> >  portcon udp 100-200 USER1:ROLE1:TYPE1
> >  netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> > +netifcon net USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> > +netifcon netx* USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> > +netifcon net? USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> > +netifcon net* USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> >  nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
> >  nodecon 127.0.0.0 255.255.255.0 USER1:ROLE1:TYPE1
> >  nodecon 192.168.0.0 255.255.0.0 USER1:ROLE1:TYPE1
> > --
> > 2.49.0
> >
> >
