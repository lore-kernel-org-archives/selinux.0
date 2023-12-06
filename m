Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZggRzVdw"
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3E5A3
	for <selinux@vger.kernel.org>; Wed,  6 Dec 2023 12:58:11 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50bf898c43cso234855e87.1
        for <selinux@vger.kernel.org>; Wed, 06 Dec 2023 12:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701896289; x=1702501089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mLb3z99sNnWwLRGfB6nUbCZYeoFDePbjJ64UBbHRJQ=;
        b=ZggRzVdwoqxwZCCahsPZXG8+lL+LwPSVl1kcBULyH6r27ATbs3rwRK1DHX7BBq9QMn
         nlTVuE9+uaoKxXka48iLMYS7OVVR79AQGx4ufgI98lgnNyRUBKZQt7S/eLDozYCe3U2O
         VOhgnifGWQoUwlD7KWOiVUSQLwE55Yo59kNMRkwF6Kx6pwIphVhhPn+nS0mUJ5JiPjve
         iLEGV1WKkSyJuGR6WdyFgDNyt/V2FdI05mKaPHCN0MifStsuyLm6M9FmaoFmtANutd9a
         B9vZdRuS4Ip+TUB+IJPbsmWRkLhggdHAGtjAz3xLqrmySXq7hD8WEsyXiNgkbM2/90RJ
         qqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701896289; x=1702501089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mLb3z99sNnWwLRGfB6nUbCZYeoFDePbjJ64UBbHRJQ=;
        b=Ciu0xtIdGnHBIXfUqFaHie0w4x/zqBMKLbT3P2e/9JjelfE0akEXRjwn72RiZd/uCl
         LAoNrLN3fV05E6J5qddIE5NBC036WThtdB4+LE3q6L4GzNyHfVXlWPJ7gzTpHvcfqFeB
         DP8mc8NLo5h5Vw1ryixATIR3cpRQjdYU3iEMIfSMnd3zFD/ainEgAK6jwCS0prcWDkcv
         yvmFLIp4JyTvzNJEZkDP6HGPBrK407MZyY9zXUxjueWedBAKgwClQS3BLUXJnQPVxO0s
         mct4zBV2/jAAKsVw+o61VtpqDWYm8k6ysKIaGNC9u8M8xfQaFAOxenTHH/QvkcNgjoLv
         q3yQ==
X-Gm-Message-State: AOJu0YzqiJjGHUE8JNow2XOboq6Er4Zo/T8r8SdrurU6RsvJmWO0Bs0L
	/+rNPiKlTi+9TJ2oY4N9AN+FZUClfcPUpEUEuTg=
X-Google-Smtp-Source: AGHT+IFhFBzxFxDiudnP8kRUZp7QfSgHm/B3jOTzwaW+2BXY7SE2FPh96LlUWu0G9IN2gLPvK2Xr/Iay2u+nuHfKwbY=
X-Received: by 2002:a05:6512:3d87:b0:50b:f0a8:eb38 with SMTP id
 k7-20020a0565123d8700b0050bf0a8eb38mr786958lfv.47.1701896288815; Wed, 06 Dec
 2023 12:58:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204161655.1349063-1-slyich@gmail.com> <CAP+JOzRLtgvOjFYveZ6F9_Z8j0Jv4oWh2qM1WCdPnzL6i1hqiw@mail.gmail.com>
In-Reply-To: <CAP+JOzRLtgvOjFYveZ6F9_Z8j0Jv4oWh2qM1WCdPnzL6i1hqiw@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 6 Dec 2023 15:57:57 -0500
Message-ID: <CAP+JOzQSEhOqKfa4vSsgYgdkuWPozKtWXdD53cFire8-EtVNhA@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: fix src/genhomedircon.c build on `gcc-14` (`-Werror=alloc-size`)
To: Sergei Trofimovich <slyich@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 2:24=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Mon, Dec 4, 2023 at 11:17=E2=80=AFAM Sergei Trofimovich <slyich@gmail.=
com> wrote:
> >
> > `gcc-14` added a new `-Walloc-size` warning that makes sure that size o=
f
> > an individual element matches size of a pointed type:
> >
> >     https://gcc.gnu.org/PR71219
> >
> > `libsemanage` triggers it on `calloc()` calls where member size is used
> > as `1` (instead of member count):
> >
> >     genhomedircon.c: In function 'ignore_setup':
> >     genhomedircon.c:152:21:
> >       error: allocation of insufficient size '1' for type 'ignoredir_t'
> >         {aka 'struct IgnoreDir'} with size '16' [-Werror=3Dalloc-size]
> >       152 |                 ptr =3D calloc(sizeof(ignoredir_t),1);
> >           |                     ^
> >
> > Signed-off-by: Sergei Trofimovich <slyich@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsemanage/src/genhomedircon.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomed=
ircon.c
> > index 8f8774d3..66585987 100644
> > --- a/libsemanage/src/genhomedircon.c
> > +++ b/libsemanage/src/genhomedircon.c
> > @@ -149,7 +149,7 @@ static int ignore_setup(char *ignoredirs) {
> >
> >         tok =3D strtok(ignoredirs, ";");
> >         while(tok) {
> > -               ptr =3D calloc(sizeof(ignoredir_t),1);
> > +               ptr =3D calloc(1, sizeof(ignoredir_t));
> >                 if (!ptr)
> >                         goto err;
> >                 ptr->dir =3D strdup(tok);
> > --
> > 2.42.0
> >
> >
