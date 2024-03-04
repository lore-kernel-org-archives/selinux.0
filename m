Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7031278B7A
	for <selinux@vger.kernel.org>; Mon,  4 Mar 2024 19:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579831; cv=none; b=b7omVfo2bwFp9/9/+y4jsz6cuT39Tn3k/fp4s24GBICygxSPUH8WI93tOKwKjiPDS9QO+FCp8FzVDQ/lualGn/xd1gT2xEQWN9dKYW1i03zE9ok903EJVrpjJUj5Vx2yJWpgd9Vup4vPefik+evkgez7FLFEZ1bIQnwvPanFZH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579831; c=relaxed/simple;
	bh=GbSzSlwuxK9vKs8khkIyDxn32gPfumkTcRmkh6PjOas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Drw8CsMNTxNKH+hH4n8CH1yPSIw4kv+A92rDRCh3y8S/OSMsyCNOISlAjjyBHDMxuSFRIiOZTjxk8IPYog50C13CX9w42G3aqyHcpqYFCO8xm+4MO5aviCJHg8Cbxpalp7oSByu64HSBcXQ/TMpOYeWTUlD0CCS4cesQRfPDwao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N14BjC1B; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N14BjC1B"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7d698a8d93cso2596190241.3
        for <selinux@vger.kernel.org>; Mon, 04 Mar 2024 11:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709579828; x=1710184628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAHYd0Hs11Rh+rDtmBpdr5oYAdCU3qVyIt2eJXLGnj4=;
        b=N14BjC1B4MjxsCycmCLGJko5hGJ4lWB5aN5SuXdCqjZVbPSNp4KRoydKhX3eZPkhwf
         U/sZg1lM5Wy/cHkMq1Vztcgp9gME2CIy438Fafy6EDL5bC3Qo2z5r91Y49rQcuRRr6U0
         DxH710J01Aj921uxwuOR9xzvtCNvvxd7SJRJf1+Irf1Ni0FzstRdHCDfMB8ExfmbNi2j
         cWV9KmPSyiWa5WiTvzZ3fitYKt9oS9Cz/FnHihuMER3LeGDI0bmlxIk9wWr9oQKRyBCl
         9Liu0VA3WjNCc8k+CRCUnyBbtDYnUoinfDicOdL042Bbr0HpaeRF68o3kN8ZitysT1Dz
         v1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579828; x=1710184628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAHYd0Hs11Rh+rDtmBpdr5oYAdCU3qVyIt2eJXLGnj4=;
        b=fxtP2x9STL1GnsUtTnPPQAsnFCun+PTDCRhYwRMRP0TmL9iSNC745HzYAhFIp2uOmP
         uSb74zqR2SdTSVHTewCkY//FuJXfMYtGiNbFXaYych72GklmmYQkHZ38NXAqerOsidXI
         OmHY2PrPBADjv8kqh19EdgT2Bivgr8KJCnNxIwPJGEQK7apmBPUFRS1sB9zzLARN47Ly
         hHfjQOorw6JprpZ0bANHT6CcYmAgwt4l2rLMrv/6FH//XPI2p5ePIUthG1s9lf195xkZ
         svWinbT6B4qyMb1ese/PT5wUpql2AX3513+CWBbUUU2IgzojMT5Scam8HLm63tLBM49/
         3SiA==
X-Gm-Message-State: AOJu0Yyp7Qzgo6a6IlZnoLg0ikHPDK6X2ylMJMjMPpGCJaJ4fKxKZdsz
	LwzMhKv5u7gNGMzjKWt93me1dJWMQyYh3toDCWVEjae+BO3sSRmfxAlL9qapFgU1QxUviXaRZMh
	hvx0dld/jPDq/CmWPvGDzQZe0shgGXk/f
X-Google-Smtp-Source: AGHT+IE2HherBhUufYNBmFUa8kpDdbgtqAErvD8RbAVMISIWWQWvYy24/RNKgEOJ2q9OwTjR+NX4muJNsdwrF3JeSiQ=
X-Received: by 2002:a67:c407:0:b0:472:cc25:4597 with SMTP id
 c7-20020a67c407000000b00472cc254597mr2965565vsk.12.1709579828370; Mon, 04 Mar
 2024 11:17:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122135507.63506-1-cgzones@googlemail.com>
 <20240122135507.63506-2-cgzones@googlemail.com> <CAP+JOzQa7g-r1d9ogf2u3C8ht4Uf8x0HLLnFDtHWUSYuqKojoQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQa7g-r1d9ogf2u3C8ht4Uf8x0HLLnFDtHWUSYuqKojoQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 4 Mar 2024 14:16:57 -0500
Message-ID: <CAP+JOzRk4MpGpsKO-xxGE5rMAVoDJanoYpOvLDXtw=r-sAHyOw@mail.gmail.com>
Subject: Re: [PATCH 02/15] checkpolicy: cleanup resources on parse error
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:34=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Jan 22, 2024 at 9:02=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Close the input file and free all memory by the queue and lexer on a
> > syntax or parse error.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  checkpolicy/parse_util.c | 26 +++++++++++++++++++-------
> >  1 file changed, 19 insertions(+), 7 deletions(-)
> >
> > diff --git a/checkpolicy/parse_util.c b/checkpolicy/parse_util.c
> > index f2d1e04d..eda814e1 100644
> > --- a/checkpolicy/parse_util.c
> > +++ b/checkpolicy/parse_util.c
> > @@ -26,6 +26,7 @@ extern FILE *yyin;
> >  extern void init_parser(int);
> >  extern int yyparse(void);
> >  extern void yyrestart(FILE *);
> > +extern int yylex_destroy(void);
> >  extern queue_t id_queue;
> >  extern unsigned int policydb_errors;
> >  extern policydb_t *policydbp;
> > @@ -34,6 +35,8 @@ extern void set_source_file(const char *name);
> >
> >  int read_source_policy(policydb_t * p, const char *file, const char *p=
rogname)
> >  {
> > +       int rc =3D -1;
> > +
> >         yyin =3D fopen(file, "r");
> >         if (!yyin) {
> >                 fprintf(stderr, "%s:  unable to open %s:  %s\n", progna=
me, file, strerror(errno));
> > @@ -41,21 +44,26 @@ int read_source_policy(policydb_t * p, const char *=
file, const char *progname)
> >         }
> >         set_source_file(file);
> >
> > -       if ((id_queue =3D queue_create()) =3D=3D NULL) {
> > +       id_queue =3D queue_create();
> > +       if (id_queue =3D=3D NULL) {
> >                 fprintf(stderr, "%s: out of memory!\n", progname);
> > -               return -1;
> > +               goto cleanup;
> >         }
> >
> > +       mlspol =3D p->mls;
> >         policydbp =3D p;
> >         policydbp->name =3D strdup(file);
> > -       mlspol =3D p->mls;
> > +       if (!policydbp->name) {
> > +               fprintf(stderr, "%s: out of memory!\n", progname);
> > +               goto cleanup;
> > +       }
> >
> >         init_parser(1);
> >         if (yyparse() || policydb_errors) {
> >                 fprintf(stderr,
> >                         "%s:  error(s) encountered while parsing config=
uration\n",
> >                         progname);
> > -               return -1;
> > +               goto cleanup;
> >         }
> >         rewind(yyin);
> >         init_parser(2);
> > @@ -65,11 +73,15 @@ int read_source_policy(policydb_t * p, const char *=
file, const char *progname)
> >                 fprintf(stderr,
> >                         "%s:  error(s) encountered while parsing config=
uration\n",
> >                         progname);
> > -               return -1;
> > +               goto cleanup;
> >         }
> > -       queue_destroy(id_queue);
> >
> > +       rc =3D 0;
> > +
> > +cleanup:
> > +       queue_destroy(id_queue);
> >         fclose(yyin);
> > +       yylex_destroy();
> >
> > -       return 0;
> > +       return rc;
> >  }
> > --
> > 2.43.0
> >
> >
