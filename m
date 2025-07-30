Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9909239E66
	for <selinux@vger.kernel.org>; Wed, 30 Jul 2025 13:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753880813; cv=none; b=suVzg9bmcs2LpJIOzD+9/flldmlGny+ep1cQDov+KiZUycOjB5hIH6tD+fnOLrUwU6ur3ee92Kb7xuEiiHfqVKZELQP1zkMVrC1GlCr3/DlEHbdM+Qi1BT07NQoWtB9AswxkNyDYP0xvxoOqrJ3R4beU+RvL1zjU4B3o7FX7/rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753880813; c=relaxed/simple;
	bh=FhaDu2vywmZiBudjqLPlvdKWFKnYtF6A54O57l4qISQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQtvZtMAq1pjRVz22urDNY1p7dsH9AUl8Y/reLzqnUMhyHuyE//ZKTW3sx5sWHIeJhCl4hZSa/mqz7wgr/5VQfoo9YZqXeJ5a9Rxf6wpGpOvjusQZkFsQLfEQ/77W/kezXFGyZyy/V8GnNbwIgcML8zTPJAbzmkheQGAycNrQpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMsMW+I6; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMsMW+I6"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b3f741a77f7so4939951a12.1
        for <selinux@vger.kernel.org>; Wed, 30 Jul 2025 06:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753880811; x=1754485611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbFIBk8MqICrZCZBU74FD2TzlY3Y66bnDkMNIzTIg4E=;
        b=KMsMW+I6NJLR+nus+P81c2DqxkmVU55wF58DoXX7ns50dsmVze/EbMKEPNCyvvv0SJ
         CwIl/gDK5SK8d8U13zZepb36CneIY8cOImd9eS67Ob0RPj044Nukcj7w4aijy7Xwg6Ki
         KMiBhGSBBsgukKsw2eQQYtocaou9ZlsQOz6DdbnH4wNn1fMLBMFvqwjIlhfO0EZZIc3H
         vHCbJFLWdJBcqTEkWBP87Yd3nAAQifEJZI1SPauuJyyUAQpUjkxc5fzWfE1lUL5915I7
         eHaP1pxwzQpAiZqH+cvtx+ePd4+oVr2S6sryIWH8voHFOm7R3gebYvMqlJugpNEv2zTT
         ZpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753880811; x=1754485611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RbFIBk8MqICrZCZBU74FD2TzlY3Y66bnDkMNIzTIg4E=;
        b=PEwx8LaXbtJSNQTR+xATecBbft2S2/jt7pTi0419feYWIdAdr8HYJvbq8fvnriPC/o
         X1q7PRqnrAvpYTiZkfgvPU1werCEyix+CXYdeeDW5FSDEV4ouMNEaDP9mHlIMVMdSAX0
         JCSjUckMepNWDDREaEf4AVux2vvib74jlwrtN3BYywt/WH6Fcst73xninFSQBRN4Gdwn
         Wx0YPzrzBiEwYfQdx9Ln6aw6QnCnO67hVrC/gq3D197x0gE9yHBjil+OxXvmTBb6JeBQ
         KrRpvCl5QLqTpr0xWDv9kCN+X1L4VUPxd+CawQRmsssRECKvWGjPHyeNCsSRhmPAp124
         6hgg==
X-Forwarded-Encrypted: i=1; AJvYcCX/h3lH+EhdMpaJ6KiROYf/72sw0OlNYReDvgstwdsS3m2e+i6MopkMbh6ODjYG0mpqn3oywYFs@vger.kernel.org
X-Gm-Message-State: AOJu0Yy28eILY0q5tKSYqd6KUsCVG+jugSG3GBp8pi4vRbMRW8eu4hAA
	txOukSIevBySy54bcDnhJxNTh7pTzpoZ5FPu9hzBCnzpcYEV9//V5MA2VPJa9ypcxFL3JOjaOiK
	lBu6UUDBPuGtKup1c2ZeqxidVxdsix80=
X-Gm-Gg: ASbGncv4D8UJczOYxkgwQqVvmT/jWayaFXrTItZctMWfKeQN5KwxwsPaI6r6upaCjpn
	GU6+y+MbU62NaCxwjiYRHML5/VCNowqqqfJXLwwNdfvvtD+mT7up0F2nWq2QGHqtbjWXesIiFo2
	HdZ0gdVz1wsmUN9atX9+ZHiIFZEm+UONZB6qkxt7YZ+5y4DdgdROzSFtVEokJQvJeWcwC8C+wkd
	HY1Q7DXqPeyfDZFnQ==
X-Google-Smtp-Source: AGHT+IGdKbWcnL3o9y0K5VGvpvgwRtPOU9+RWH/9Q+r5PQouNBrruumUntuEQwkX1kxMDKjfyPWTQr/sTrKiM1WUaoI=
X-Received: by 2002:a17:903:19e5:b0:240:75dd:3a3 with SMTP id
 d9443c01a7336-24096b1bf27mr49332795ad.28.1753880810685; Wed, 30 Jul 2025
 06:06:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ6nRZ50-L5wDtnppC641OjuEzO8QRUhGjJXcT5iKTNfbQ@mail.gmail.com>
 <20250725221525.479629-2-nvraxn@gmail.com> <CAEjxPJ4GN0rTV_aH1eWnr5FGrBeQ=KaXaRDkkDpVwHv5myye-g@mail.gmail.com>
In-Reply-To: <CAEjxPJ4GN0rTV_aH1eWnr5FGrBeQ=KaXaRDkkDpVwHv5myye-g@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 30 Jul 2025 09:06:36 -0400
X-Gm-Features: Ac12FXw9lI-hSNT-cEbWqsYpFz2UF2zUrKiG2F1lPhB4RFWR8vRuxxW1wwXFpbg
Message-ID: <CAEjxPJ7R2Ze5Eiwzv0-qG9Y5JRtwzSEB3NGVPeUs3w78bo6kDg@mail.gmail.com>
Subject: Re: [PATCH v5] libselinux: fix parsing of the enforcing kernel
 cmdline parameter
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: jwcart2@gmail.com, omosnace@redhat.com, paul@paul-moore.com, 
	plautrba@redhat.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 10:04=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jul 25, 2025 at 6:16=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> w=
rote:
> >
> > Currently, parsing of the cmdline has two issues:
> > - By using atoi, no error checking is done. What happens if an argument
> >   that isn't an integer is provided, e.g. enforcing=3Dfoo? And as there
> >   is also no validation that the number provided is actually valid, 1
> >   or 0, what happens if enforcing=3D2?
> >
> > - After the first strstr, no arguments that follow are searched for; if
> >   I have enforcing=3D0 enforcing=3D1, the latter enforcing=3D1 is not t=
aken
> >   into account. This is made even worse due to halting searching after
> >   finding the first "enforcing=3D" token, meaning that if the cmdline w=
as
> >   as follows:
> >
> >   fooenforcing=3D0 enforcing=3D0
> >
> >   the enforcing parameter is entirely ignored.
> >
> > This patch fixes this by:
> >
> >   - Using strtol to actually validate that we got passed a number, and
> >     if not default to 0 (i.e. permissive mode) as per kernel behaviour.
> >     If given a positive integer that isn't 1, also treat that as 1 (so
> >     enforcing mode).
> >
> >   - Looping until the last "enforcing=3D" in the cmdline. Latter (valid=
)
> >     arguments take precedence over previous arguments.
> >
> > For the case where "enforcing=3D" is provided with a valid integer, 0 i=
s
> > treated as permissive mode, and anything else (such as 1 or 2, etc) is
> > treated as enforcing mode. When "enforcing=3D" is passed an argument th=
at
> > is not a valid integer (such as "on"), default to enforcing=3D0, i.e.
> > permissive mode. This is in line with how the kernel parses the
> > enforcing parameter.
> >
> > Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmall.com>
> Tested-by:  Stephen Smalley <stephen.smalley.work@gmall.com>

Thanks, merged.

> > ---
> >  libselinux/src/load_policy.c | 23 +++++++++++++++++------
> >  1 file changed, 17 insertions(+), 6 deletions(-)
> >
> > v2: Follow the same argument parsing behaviour as the kernel does.
> > v3: Actually follow the kernel's behaviour where "enforcing=3D" is not
> >     provided with a valid integer...
> > v4: Update the commit message to also reflect the behaviour above.
> > v5: Advance past sizeof("enforcing=3D") - 1 instead of just 1
> >
> > diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.=
c
> > index dc1e4b6e..f67e5538 100644
> > --- a/libselinux/src/load_policy.c
> > +++ b/libselinux/src/load_policy.c
> > @@ -244,17 +244,28 @@ int selinux_init_load_policy(int *enforce)
> >         rc =3D mount("proc", "/proc", "proc", 0, 0);
> >         cfg =3D fopen("/proc/cmdline", "re");
> >         if (cfg) {
> > -               char *tmp;
> >                 buf =3D malloc(selinux_page_size);
> >                 if (!buf) {
> >                         fclose(cfg);
> >                         return -1;
> >                 }
> > -               if (fgets(buf, selinux_page_size, cfg) &&
> > -                   (tmp =3D strstr(buf, "enforcing=3D"))) {
> > -                       if (tmp =3D=3D buf || isspace((unsigned char)*(=
tmp - 1))) {
> > -                               secmdline =3D
> > -                                   atoi(tmp + sizeof("enforcing=3D") -=
 1);
> > +               if (fgets(buf, selinux_page_size, cfg)) {
> > +                       char *search =3D buf;
> > +                       char *tmp;
> > +                       while ((tmp =3D strstr(search, "enforcing=3D"))=
) {
> > +                               if (tmp =3D=3D buf || isspace((unsigned=
 char)*(tmp - 1))) {
> > +                                       char *valstr =3D tmp + sizeof("=
enforcing=3D") - 1;
> > +                                       char *endptr;
> > +                                       errno =3D 0;
> > +                                       const long val =3D strtol(valst=
r, &endptr, 0);
> > +                                       if (endptr !=3D valstr && errno=
 =3D=3D 0) {
> > +                                               secmdline =3D val ? 1 :=
 0;
> > +                                       } else {
> > +                                               secmdline =3D 0;
> > +                                       }
> > +                               }
> > +                               /* advance past the current substring, =
latter arguments take precedence */
> > +                               search =3D tmp + sizeof("enforcing=3D")=
 - 1;
> >                         }
> >                 }
> >                 fclose(cfg);
> > --
> > 2.50.1
> >
