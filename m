Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D156730D407
	for <selinux@vger.kernel.org>; Tue,  7 Jul 2026 12:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427208; cv=pass; b=RIuPTcRUYfHjF9DFlXR7h86W7jYGLoa4h+Oy5/by3zrRXNTcHoTXJxJHr4FxoG4iXEdV6LT5DkExnkDsiW9NonRdmLVIqK1d3VhsYCShzInlbV2Wqgf+pC0CIxSPzqjL5ZehVvQZbROspPfTfQER7jEK63x0NI19cucHqEbL4GQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427208; c=relaxed/simple;
	bh=jOGfwEgvBi9/HTnrp5q1wd492PkRP9tg24nYRCa+kvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gkqGeo3ePps2PpiB7X0ErcZ21QMPfL6qiOY0xldXL37sDfJH9FjYIqqM5BjlFMQul4fyGXqsJC5Qm5k4tbj0an3QDW+GCb2NUpVBcsHdR3p0nAeb4DHlWa8YeKS4iuBS/MXy8WU02LpCsmDyHbpITyAnwBaSyx6X/M+VkGPYLw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUczPUuB; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUczPUuB"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cc84e77e78so19634095ad.2
        for <selinux@vger.kernel.org>; Tue, 07 Jul 2026 05:26:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783427206; cv=none;
        d=google.com; s=arc-20260327;
        b=JX+pUNhlxFFd6x4Z/PCr1bd+eCnBg7UaYp78a7PoJG87f3MSEcedt1PFXXHbLuTsCz
         81J8O8tivjtusIgeEEdkW6MPoeGzIi8xgymUrM0ffraZ661mkc+qznbR9Iq46QdF2uGW
         mMgKqL6vmTgHazO8DnWhyEvrUOi5iI2vGF0bWFKpXfXFfVcbKSLGeZjSiKESbzAyOOnA
         GdWPFldhz0V3HdJPYpHR7GD3ks9UKOXuQ+X2KiD8lvpkkRpdkaoSQ+bIQWt8slsGvpMD
         JH1orGDYv+2ig0i7vpYNjcrZmLP46GH+6Qia0Xycf7yjaizFsGQkC3Dj+bEX//R9gkMD
         3eBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3djrQ5yfwvdw9pprZ4z3OI78TUaoQo5H6Br4OC51gZM=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=BB5SKcuG85XHtk2z4ahBUr0/FXyK7sDpAwsclG7bSwUWtcGRUxLjw1ai5dOeuDJZlu
         VQ97Z4V+/Nus8jQU/l42L+BR3N5ZYNcIao4tkbZPfHP6qmi7Cj4eRduXkCMS0UTJ878z
         zrM23Sgb5poYW7zK0VR1/SISaDzaxw0MYiB/qpGLAqYl62VI0uhdz2/W4CsHDHmjMEjs
         WHqdq1LIns3PGbWGdyu9KaENtzCgJ3dX7gjZTmxQhk1Szr1ZHHKFBnuSwCOGxCjeRYKd
         EEOiO2rCVSSaPdDJq3jNeXUrUkpvip3FAS+pZsaXPW77i4SgkzLjXJLBUTIsRYIzSty+
         uEvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783427206; x=1784032006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3djrQ5yfwvdw9pprZ4z3OI78TUaoQo5H6Br4OC51gZM=;
        b=HUczPUuBpliHgtcVkrBx4GU24hAvOnKZp//M30X2YEWZtL17dGiEPcy6qiO4Wkx3/o
         2tmwOvwH5QcsNJbARNfpZGNUoLjY9EmTIPw3OQBQ0j1407gR23DH6fjXmZS5e7ZSzsXO
         sY8AXSGiwJKxTvN2KeUHDxWP6LyDt9R05yR2M23AKuKypftaLS7PDnavqagH0+FfSJSF
         c+/CzyV/gsYyny+5fRwX1ExBGUrBNKAWhgd/LpG53eEoAfiU7vcFmVFv95FYrRbrbsU+
         gMjeNDHXDzbgpXDAu9OvG5UliML5SEbNLi8xuwblQ30LZLYHoI55LDiCkh6LoTQKIv9n
         mzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783427206; x=1784032006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3djrQ5yfwvdw9pprZ4z3OI78TUaoQo5H6Br4OC51gZM=;
        b=XR62AZY8enjLpWLIiw+oIV2y6fqXOTA0TywZt0M/dJIVgdhsX/JUeoiYh32DC58VUn
         YDS6dZSiL1hFru7G2/9V2aTXrqDc9ajHbxTg1XpDd1irgppUDgDprKGQak1SYfSV0flh
         RFgdrKx8N5fdJk40oK2tg3ZIZp7DDE4SB+5nzCo/eGV+mnr038m1fwowk24WiIXJcYGW
         9r45Vd4tG6cm5TomfPHJ0V/drvMHmbGUOqFzICg9hlhpoYrKmvZumIPiPcrFvIz8XXGK
         ex9KRXu3MpXtkejUK3IM8XjfZ4UY5S6RWdLM2MvmEm5bruwiRd9Lnh4ciCnXZT75pAq+
         u1tQ==
X-Gm-Message-State: AOJu0Yx/wgmsxIJ7MrAa2nC/gIxdHNPhEvJ9P+oNYXr/zu6oLse3vxXm
	QKtBKOsqQ7v+OLvkpNzVjxufMIu01hXtsQJfNilSUl89koVy1NapxEx4Wq5kuN3GgRdw9Q6X+x8
	IJ3Uu+4glqMQjzjcbH2vtbTSA8JjxK4/vjg==
X-Gm-Gg: AfdE7clzizTRrL21aKHgXtTWGMF94k+kqa6wyG4YzizrABxY2S26TltqctrTNFXP6KW
	tZ0jjrhAO4C2JaZcUaXh4L8VTwjX39d/Qewh6QpiatQ0H0mnrWheE1jIhG++rOGB6RY628SqhK3
	w3ThjqwkzMnMS7hzgtAJPPIrDz0oVcSX7LQDU5gexEQ7f7qSx84o6mecLDWEjT63kD5PkXAztDJ
	5axweLSw76ZOoxM2uwJqO5ayuC+QWsBqj/uAvJEwmQ9x9yMCgG58ilgsZQkNNlvndGdTt3R
X-Received: by 2002:a17:902:ef44:b0:2ca:cee0:e172 with SMTP id
 d9443c01a7336-2ccbee24250mr47293675ad.30.1783427206149; Tue, 07 Jul 2026
 05:26:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623141023.114173-1-cgoettsche@seltendoof.de>
 <20260623141023.114173-4-cgoettsche@seltendoof.de> <CAEjxPJ7mBfTOLc=PY_jrSM0SrsqcRC97ioeFnG8vZcetDGs27A@mail.gmail.com>
 <CAEjxPJ6hodiguYnZd1rkf0eyHnnHH=zgBX=ZJ7V2epA52091Dw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6hodiguYnZd1rkf0eyHnnHH=zgBX=ZJ7V2epA52091Dw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Jul 2026 08:26:35 -0400
X-Gm-Features: AVVi8CdGAzDAWCx_sLr34855M16yF79F3qOIHQ_mPJ3yeCT_ZFRPzKu5MOiRF4w
Message-ID: <CAEjxPJ7GyuVnqp0agkK49+L30dxiu2pAhBX+J378+Yoqc6nGEA@mail.gmail.com>
Subject: Re: [PATCH 5/5] newrole: fail closed for -l when the terminal context
 is unknown
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 12:44=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Jun 23, 2026 at 12:44=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Tue, Jun 23, 2026 at 10:11=E2=80=AFAM Christian G=C3=B6ttsche
> > <cgoettsche@seltendoof.de> wrote:
> > >
> > > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > >
> > > The -l secure-terminal check only ran when fgetfilecon() on stdin
> > > succeeded; if it failed the level change proceeded with no securetty
> > > check at all.  Resolve the enforcing mode and, when the terminal's
> > > context cannot be retrieved, reject the level change while enforcing
> > > rather than silently allowing it.
> > >
> > > Refactor the enforcing passing to unify security_getenforce(3) calls.
> > >
> > > Assisted-by: Claude:claude-4.8-opus
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Doesn't check clean with make check-format; will reformat on merge.
>
> But otherwise,
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series has been merged.

> >
> >
> > > ---
> > >  policycoreutils/newrole/newrole.c | 25 ++++++++++++++-----------
> > >  1 file changed, 14 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newr=
ole/newrole.c
> > > index 09b10b35..58524b6a 100644
> > > --- a/policycoreutils/newrole/newrole.c
> > > +++ b/policycoreutils/newrole/newrole.c
> > > @@ -732,21 +732,16 @@ static inline int send_audit_message(int succes=
s __attribute__((unused)),
> > >   * in permissive mode.
> > >   */
> > >  static int relabel_tty(const char *ttyn, const char *new_context,
> > > -                      char **tty_context, char **new_tty_context)
> > > +                      char **tty_context, char **new_tty_context,
> > > +                      int enforcing)
> > >  {
> > >         int fd, rc;
> > > -       int enforcing =3D security_getenforce();
> > >         char *tty_con =3D NULL;
> > >         char *new_tty_con =3D NULL;
> > >
> > >         if (!ttyn)
> > >                 return 0;
> > >
> > > -       if (enforcing < 0) {
> > > -               fprintf(stderr, _("Could not determine enforcing mode=
.\n"));
> > > -               return -1;
> > > -       }
> > > -
> > >         /* Re-open TTY descriptor */
> > >         fd =3D open(ttyn, O_RDWR | O_NONBLOCK);
> > >         if (fd < 0) {
> > > @@ -856,7 +851,8 @@ skip_relabel:
> > >  static int parse_command_line_arguments(int argc, char **argv, char =
*ttyn,
> > >                                         const char *old_context,
> > >                                         char **new_context,
> > > -                                       int *preserve_environment)
> > > +                                       int *preserve_environment,
> > > +                                       int enforcing)
> > >  {
> > >         int flag_index; /* flag index in argv[] */
> > >         int clflag; /* holds codes for command line flags */
> > > @@ -928,6 +924,10 @@ static int parse_command_line_arguments(int argc=
, char **argv, char *ttyn,
> > >                                                 return -1;
> > >                                         }
> > >                                         freecon(tty_con);
> > > +                               } else if (enforcing) {
> > > +                                       fprintf(stderr,
> > > +                                               _("Error: could not d=
etermine the security context of the terminal, not allowed to change levels=
\n"));
> > > +                                       return -1;
> > >                                 }
> > >                         }
> > >
> > > @@ -1093,6 +1093,7 @@ int main(int argc, char *argv[])
> > >         int fd;
> > >         pid_t childPid =3D 0;
> > >         char *shell_argv0 =3D NULL;
> > > +       int enforcing;
> > >         int rc;
> > >
> > >  #ifdef USE_PAM
> > > @@ -1139,7 +1140,8 @@ int main(int argc, char *argv[])
> > >                 return -1;
> > >         }
> > >
> > > -       if (security_getenforce() < 0) {
> > > +       enforcing =3D security_getenforce();
> > > +       if (enforcing < 0) {
> > >                 fprintf(stderr, _("Could not determine enforcing mode=
.\n"));
> > >                 return -1;
> > >         }
> > > @@ -1162,7 +1164,8 @@ int main(int argc, char *argv[])
> > >         }
> > >
> > >         if (parse_command_line_arguments(argc, argv, ttyn, old_contex=
t,
> > > -                                        &new_context, &preserve_envi=
ronment))
> > > +                                        &new_context, &preserve_envi=
ronment,
> > > +                                        enforcing))
> > >                 return -1;
> > >
> > >         /*
> > > @@ -1226,7 +1229,7 @@ int main(int argc, char *argv[])
> > >          * Once we authenticate the user, we know that we want to pro=
ceed with
> > >          * the action. Prior to this point, no changes are made the t=
o system.
> > >          */
> > > -       fd =3D relabel_tty(ttyn, new_context, &tty_context, &new_tty_=
context);
> > > +       fd =3D relabel_tty(ttyn, new_context, &tty_context, &new_tty_=
context, enforcing);
> > >         if (fd < 0)
> > >                 goto err_close_pam;
> > >
> > > --
> > > 2.53.0
> > >
> > >
