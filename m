Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15553085CC
	for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 21:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750283775; cv=none; b=ETRjiXoJp2IQOD8qo80QhBz5KiztKuEEwz3Q+W4ilcb3hcu5lnQdNLMJoP3KF+ajaFrMsYdPMNXAy6mXG+syg1mD8HiKLLZmkqTEa03SkgD7rAbBfwb2aWK57xIrRcTsjenXICttfppkn0UUEHHyNgHehrTKWD5nw8r7GNacvmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750283775; c=relaxed/simple;
	bh=DEqgaN2aULUekitHbqZBtUEtf+lAozE/KxT5zgVnBek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JcC5klFdFO1PapEh8vlrjHZyi02XgfYTJl3bihSKuuDdDDk34SLfOuYmVDMUNpilwFD7z3Vur0ggbj03YMVjAJgA/eaJiuFYBBlqlVzJQyEmydjiXb1gTExDwabIf/zXhLpELIxXvXBT5wecXsotT+TN+lSu8sYKzTEADAcwPPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZiOBeNmK; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZiOBeNmK"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e819aa98e7aso181017276.2
        for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 14:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750283772; x=1750888572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrYICK1GrQgV6lt9pYlAwr/eamW2R9KMq+2pDaROL8M=;
        b=ZiOBeNmKWCt8Y4Qu06b0spHUCKKVkzZNpv+J7kicva8blwGbeXbbPB/4nHApSR09oO
         7tAsys6+on7QDcEl3Cx6eApnooItjZRrC6mZKWfWe2N0dXjua+8j/9huUQF1QQBuGPIh
         QnBYuWVY8GkY9xmr+3876xy0PvTqcQNE9HS20LhZmIrh8NnDGiAvk7TX72tr9DeDj3QD
         4UIgpiCmJ5oF3nLcDDLpeDxrjCikTjKfNfeYd56yTVV19RkyUmGFjagUYC08nG+Bxdkz
         Hs3d4ZujS1mugsEefokSw/GQuu1WSvql5UPX09lUI+enIv7Aq/bIifFrv1KniRUZKs7U
         d25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750283772; x=1750888572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrYICK1GrQgV6lt9pYlAwr/eamW2R9KMq+2pDaROL8M=;
        b=ALIu+xKywhxalUxhV+lHvdNvXjkQVVnoIddM3AzLngmWhsd7nzs0kns+lacrr1x+tL
         sqEYsOWNXOYKvAwW97aTC5deRP2tEnxz+JQxUFGdm8uX72DBa2WNYlbFHEWZiahf4T+w
         83jTyCdoSCpAXzn3uTad83d/bOaQ4ALwmx5gxgkEG9PC25Rq23WjcE0XpZmKPFSDq53N
         +oqld4QWmTdkWcmcrn1tfEe38z2J3PWj86piaQ9Vr/Cpft441avBCgksbuRxyqZChjsi
         yWErFkYadwVcBtxV60AxflOzwXD3ovqpkn+2zL817jaDltXL5ZlNY32FYEG5RHr/TMRV
         D6YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCa1KvbYTbYJdX11RbEAZN+xkfHs2CXtRRS2PMlCUz/KjKxHUrBE41Vm7cQQLgd8vaKDf88Zeu@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4/5rQqY2JaCc7p5yZ7xZusPkGpWTMOgkrx2eqgkKaOPn68zkp
	G/hje68cROxvWEuqKY0rwFw2sy/5rbmeFAoy57qzfJGHSgY9O/frWNtL84qwDlr9cteq2iNnsGl
	H11LH+BmtrcMr0VmgjMHDtdfhZscJhkRMYwGWxV7/
X-Gm-Gg: ASbGncvZWjoq3YxnabMByJLCMpFPG4g0AnpbJwwvwiVxL3d54dWpFE+zsNnx6OIkZ7y
	EisMrkuRP74woPen+hgsmz2NF9gdrA4/dKteJKHPIuANgzT8vG0Obu3StrPTe/IAEqIk0erF0Od
	VVdCUh5yXfhdDfzUcw6704mCOatu6dWabIE3ZeVAglV5ADydNv1k8jyg==
X-Google-Smtp-Source: AGHT+IHWFZCYlMLhtuOAU/UVZad0NTEAgR/vBiBV1tN1Lbw35rquLFljlnismQvjRxgwY6CsuPxtOwc40dna/dtyDII=
X-Received: by 2002:a05:690c:dc7:b0:710:e4c4:a92f with SMTP id
 00721157ae682-71175384d69mr253158277b3.5.1750283772549; Wed, 18 Jun 2025
 14:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610194826.80606-2-stephen.smalley.work@gmail.com>
 <1749647531.6091.5.camel@trentalancia.com> <CAHC9VhTjwOcwzKdiq5m=QyWo8=-a6E-2bW4gKJoDtij7kEmxeA@mail.gmail.com>
 <1749670408.6186.15.camel@trentalancia.com> <CAEjxPJ58ZSqhYaXr+fOLwbN=bBb7+WGRQf59vv9c-UWDBnyZMQ@mail.gmail.com>
 <1749671000.6186.18.camel@trentalancia.com>
In-Reply-To: <1749671000.6186.18.camel@trentalancia.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Jun 2025 17:56:01 -0400
X-Gm-Features: Ac12FXzgQ67-ocB2UmcXXY22wQZWf60coLDiR7gou6rmAzVPaiK0i6QSx24zUEw
Message-ID: <CAHC9VhTFww3khVjjd1Tci6Qx+MnM+v9_u7vANWNqE0vwTW=Ftw@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: change security_compute_sid to return the
 ssid or tsid on match
To: Guido Trentalancia <guido@trentalancia.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 3:43=E2=80=AFPM Guido Trentalancia
<guido@trentalancia.com> wrote:
>
> Ok then, as long as it passes the testsuite it should be sufficiently
> tested for most purposes, I suppose.
>
> You can add the Tested-by line, if you like...

Thanks Guido.

I'm thinking this might be a good candidate for stable, what do others thin=
k?

> On Wed, 11/06/2025 at 15.37 -0400, Stephen Smalley wrote:
> > On Wed, Jun 11, 2025 at 3:33=E2=80=AFPM Guido Trentalancia
> > <guido@trentalancia.com> wrote:
> > >
> > > I have very little time to look at the underlying problem and, as
> > > already explained, I have only tested that it solves dracut-ng
> > > issue
> > > 377.
> > >
> > > This change has widened the scope considerably compared to the
> > > other
> > > proposed patch, I cannot so easily certify that it does not
> > > introduce
> > > regressions or problems in other scenarios.
> > >
> > > The main point is that the offending code in ae254858ce07 is only
> > > executed when the policy has not been loaded yet (and it sets the
> > > SID
> > > to SECINITSID_INIT).
> > >
> > > On the other hand, when the policy is not loaded
> > > security_compute_sid()
> > > is reduced to:
> > >
> > > switch (orig_tclass) {
> > >                 case SECCLASS_PROCESS: /* kernel value */
> > >                         *out_sid =3D ssid;
> > >                         break;
> > >                 goto out;
> > > return rc;
> > >
> > > In other words, when the policy has not been loaded yet (which is
> > > when
> > > the problem is introduced), the code in this change is not reached
> > > and
> > > security_compute_sid() simply returns ssid (when called with
> > > SECCLASS_PROCESS). So, the mechanism of action of this change on
> > > the
> > > problem appears to be indirect in some way.
> > >
> > > Moreover, security_compute_sid() is called by several other
> > > functions
> > > rather than simply by security_transition_sid(), so without proper
> > > extensive testing in multiple use cases (read multiple code paths)
> > > it's
> > > very difficult to say the change is fully tested...
> > >
> > > I would recommend more extensive testing.
> >
> > It passes the selinux-testsuite without any problems, FWIW.
> >
> > >
> > > Guido
> > >
> > > On Wed, 11/06/2025 at 12.27 -0400, Paul Moore wrote:
> > > > On Wed, Jun 11, 2025 at 9:12=E2=80=AFAM Guido Trentalancia
> > > > <guido@trentalancia.com> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > I have just tested Stephen's patch and it solves the problem as
> > > > > an
> > > > > alternative to the dracut patch and other patches posted here
> > > > > along
> > > > > with the issue description:
> > > > >
> > > > > https://github.com/dracut-ng/dracut-ng/issues/377
> > > > >
> > > > > Please note that I have only tested the success of the boot
> > > > > process
> > > > > with sysvinit and not other aspects of the system
> > > > > functionality,
> > > > > other
> > > > > init daemons or regressions that might be caused as a result of
> > > > > applying this patch.
> > > >
> > > > Understood, thanks for the testing you've done.
> > > >
> > > > Would you be okay if I added your "Tested-by:" tag to the patch?
> > > >
> > > > > On Tue, 10/06/2025 at 15.48 -0400, Stephen Smalley wrote:
> > > > > > If the end result of a security_compute_sid() computation
> > > > > > matches
> > > > > > the
> > > > > > ssid or tsid, return that SID rather than looking it up
> > > > > > again.
> > > > > > This
> > > > > > avoids the problem of multiple initial SIDs that map to the
> > > > > > same
> > > > > > context.
> > > > > >
> > > > > > Reported-by: Guido Trentalancia <guido@trentalancia.com>
> > > > > > Fixes: ae254858ce07 ("selinux: introduce an initial SID for
> > > > > > early
> > > > > > boot processes")
> > > > > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.co
> > > > > > m>
> > > > > > ---
> > > > > > v2 fixes a compiler error.
> > > > > >
> > > > > >  security/selinux/ss/services.c | 16 +++++++++++-----
> > > > > >  1 file changed, 11 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/security/selinux/ss/services.c
> > > > > > b/security/selinux/ss/services.c
> > > > > > index 7becf3808818..d185754c2786 100644
> > > > > > --- a/security/selinux/ss/services.c
> > > > > > +++ b/security/selinux/ss/services.c
> > > > > > @@ -1909,11 +1909,17 @@ static int security_compute_sid(u32
> > > > > > ssid,
> > > > > >                       goto out_unlock;
> > > > > >       }
> > > > > >       /* Obtain the sid for the context. */
> > > > > > -     rc =3D sidtab_context_to_sid(sidtab, &newcontext,
> > > > > > out_sid);
> > > > > > -     if (rc =3D=3D -ESTALE) {
> > > > > > -             rcu_read_unlock();
> > > > > > -             context_destroy(&newcontext);
> > > > > > -             goto retry;
> > > > > > +     if (context_equal(scontext, &newcontext))
> > > > > > +             *out_sid =3D ssid;
> > > > > > +     else if (context_equal(tcontext, &newcontext))
> > > > > > +             *out_sid =3D tsid;
> > > > > > +     else {
> > > > > > +             rc =3D sidtab_context_to_sid(sidtab, &newcontext,
> > > > > > out_sid);
> > > > > > +             if (rc =3D=3D -ESTALE) {
> > > > > > +                     rcu_read_unlock();
> > > > > > +                     context_destroy(&newcontext);
> > > > > > +                     goto retry;
> > > > > > +             }
> > > > > >       }
> > > > > >  out_unlock:
> > > > > >       rcu_read_unlock();
> > > >
> > > >



--=20
paul-moore.com
