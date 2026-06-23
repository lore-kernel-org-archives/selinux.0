Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E6330F548
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782233085; cv=pass; b=cdKUWAt3Jj6irUebAe4EISJd6Zcy2I6JuuXOxBYPOhyaGHpEzhkDCy+eKKkc3lCDKg2h+eWGurykW+nVYyazQ3WctiDE/nK2mCnJJ5yGse1Eoh5DkfbgACUSpb37WNqTNp6/GJmH/twDgCpK800ZC5pv1mAnM8vFirKGEA/6xYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782233085; c=relaxed/simple;
	bh=3/bqIIx8k9GiQKhNUqJiEOI8wvjuYjTBqpuEjB+8Bh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S0kiIMxqzvgIl7jS8w77sLXRQiqA2w3bxm14t6JfWAP4FpdP+YCXLHkC/Ei4F0dnnCTQtlZOUovkWYsDAanfHqTkPNzmbVdNWFhXjveahc/kVPXmuDAIPy+60ZYaxLxv1gIV62vpMDtvd50BxIeHFkdu+Ph7llIfC2jY/Dfl5Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8A9UA75; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8A9UA75"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c6b3f71648so438555ad.2
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 09:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782233083; cv=none;
        d=google.com; s=arc-20240605;
        b=OyllVKTNcpHFKjq/J3/UPbVlllP7rvMrSW/2/1YofKBSXnxfZie/nILt9Y0e/dPo6h
         5mrYpa5FmyrKrz0FYu69ZRFbdcrm0912qNx15NLa9HMZPpkDdjt89HEuN+3aFMWJitLt
         C7Mt2Aajy0ffT9KR1C2+03GsrdyJPZISYGT/F8M4fi74/uTSSWe+su0LLl0a+Wt0Jp3J
         o7I2y+Y8AW+lov77jqmw94mW2plQ+GDOdDeOvDYrlPiWfLU8smtK+VQheuKI9vjjxvYU
         S2DfDQojNXNTEAUWQZen0DnJ+AT9Zl0MABmAOsF9hlw//jMWHrJmR3fzOgnPVhFZoAgp
         GnaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=16WQdIYXifQXndHELhpvrAMxZOIoKgKmafM3DorW014=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=XOhOi/sOZzwTrHZYOmdcFrCeIWgDf6BPDSZS3V55Bq5F2UwKOjdC4MLxs+WaSh2/Nw
         g7RWc7SEhhXB7NwKc6wrC1puEG1BEtxHo6sVzmc63sdomfz7Ab5DEmXkCy884A9+xZAw
         qH+ppWaWg+V463Q5Qdf/gVmWdJ8ObWLsVJniwgJbrowVsyiSjd8mSAnHkCVHUN448rag
         HDDzA3rpJ2J4aDRMfa7oKEq3B3ucQURdMAXidCqVQEfB5Am054O10Rfg352jXEZwcQ33
         gP4a5Sbw8egkw0OJq8oPaysy8l5S2JIdJ8cYwkXwBerQVN1xWiaCiLyziwERo/YYtmpw
         Zj0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782233083; x=1782837883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16WQdIYXifQXndHELhpvrAMxZOIoKgKmafM3DorW014=;
        b=N8A9UA75p+hX14bPAJCU01j0aF+O2kC7b4AvVjPsbV96umCDTSmTXl8pX8HllNSBOU
         n4ild6TTL0/d7b3RipLInK3rGiWMDDBSgYXOH6fNbEIrwZfIgkKjShWQMJxxYQTyIyLa
         rouAkpmrpgJACWZ/v0z4+RvepR5bnxRAXKQYZTFchsOcsqHZw5oZZPUZaehaFOByZYXp
         3LgARwzDwD/PkOMY1xOgKbGiL5AP4Y4q/uWnPQKauN/PW45Ddo9n+e34i+4Y/d5cLw0q
         HEB/S5E/XBlDFgwgIHhVflHeVxgQ59SZK0bsZDosMEAi/Gm/qQztaRiUf+OSmlePsm5V
         igNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782233083; x=1782837883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=16WQdIYXifQXndHELhpvrAMxZOIoKgKmafM3DorW014=;
        b=XwYZx3+PFj+XDOXf7VhGJZmnULFDEkDDahUBfZi3bS3cnCND8Lqb2YDTF1ewBn/KjG
         M+YipChouwGn2OuSANFthsHCgMAVwxkNdLLG0ntFJkdVKVBNgDCuHXa3+CeLHukbl4cX
         KU/f1BeAWLy6tpEWR1+LP0X+bLbTDUis7AnkhRvwf1K+00SKdO8VNtmOmWGI6A0qU3VG
         g8mkGBKTQTcxL/40OJBD8Yceee7U7Rne2htsahfijhTyQJijSTLSx7GPJj0ZT4ERRd7J
         qrMh2cuqM7IaLayz0BUFfkLgOBSgfHtwn870L3EWwThaDunhCyBGwbB0Uaz96/3L6FcV
         qrgA==
X-Gm-Message-State: AOJu0YyD4pY8WgkX91Pa9ukYefyDYfo1RHsfAPxFjSthyy7kuWhwkG/K
	yTbLAZXLAg2kx3tUA7YS9TfAqjlZv+FTFiQjMJ7Xh8o+ilomrwWuGodgRBkhlcdHoy1PBt9Zo2r
	pR45P/UjbFg7FrftmHdXxN8DuKhsfZ1dOdan6
X-Gm-Gg: AfdE7cn7L8DqON61+IgV/knOzt1GLj9ZAjC+F//6H7q5k5KEKV2/zlCKi5+v1DYlYg3
	ka2jqHAMrgC79/iDEs+JQsOZw6ZY+5lor/ogjLkwb61FuoUiCKqilnUFZ2YZ6g6xrxLoJKbMcn7
	cRQdvnlINs/CrS90iH4f0QxirjD5y9p4h06didYlchUtK/QHiDPernrjOM79GUrtt4c8TJGJvsk
	SgBOJm8O0SGPZTnX7loptr69KhUQUXAVzIT1k3O+xbW6PUHS+bChOI8Q+MPkZZBnlgqyzd0
X-Received: by 2002:a17:903:3c4e:b0:2c0:af09:f3c7 with SMTP id
 d9443c01a7336-2c718f95888mr200997065ad.30.1782233083438; Tue, 23 Jun 2026
 09:44:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623141023.114173-1-cgoettsche@seltendoof.de>
 <20260623141023.114173-4-cgoettsche@seltendoof.de> <CAEjxPJ7mBfTOLc=PY_jrSM0SrsqcRC97ioeFnG8vZcetDGs27A@mail.gmail.com>
In-Reply-To: <CAEjxPJ7mBfTOLc=PY_jrSM0SrsqcRC97ioeFnG8vZcetDGs27A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 12:44:31 -0400
X-Gm-Features: AVVi8CdbRktglb3zg0-5Vy5uMY8jXvckjWaScjVzXEhyNDKaH_H7x74aod7SppA
Message-ID: <CAEjxPJ6hodiguYnZd1rkf0eyHnnHH=zgBX=ZJ7V2epA52091Dw@mail.gmail.com>
Subject: Re: [PATCH 5/5] newrole: fail closed for -l when the terminal context
 is unknown
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 12:44=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Jun 23, 2026 at 10:11=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > The -l secure-terminal check only ran when fgetfilecon() on stdin
> > succeeded; if it failed the level change proceeded with no securetty
> > check at all.  Resolve the enforcing mode and, when the terminal's
> > context cannot be retrieved, reject the level change while enforcing
> > rather than silently allowing it.
> >
> > Refactor the enforcing passing to unify security_getenforce(3) calls.
> >
> > Assisted-by: Claude:claude-4.8-opus
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Doesn't check clean with make check-format; will reformat on merge.

But otherwise,
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

>
>
> > ---
> >  policycoreutils/newrole/newrole.c | 25 ++++++++++++++-----------
> >  1 file changed, 14 insertions(+), 11 deletions(-)
> >
> > diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrol=
e/newrole.c
> > index 09b10b35..58524b6a 100644
> > --- a/policycoreutils/newrole/newrole.c
> > +++ b/policycoreutils/newrole/newrole.c
> > @@ -732,21 +732,16 @@ static inline int send_audit_message(int success =
__attribute__((unused)),
> >   * in permissive mode.
> >   */
> >  static int relabel_tty(const char *ttyn, const char *new_context,
> > -                      char **tty_context, char **new_tty_context)
> > +                      char **tty_context, char **new_tty_context,
> > +                      int enforcing)
> >  {
> >         int fd, rc;
> > -       int enforcing =3D security_getenforce();
> >         char *tty_con =3D NULL;
> >         char *new_tty_con =3D NULL;
> >
> >         if (!ttyn)
> >                 return 0;
> >
> > -       if (enforcing < 0) {
> > -               fprintf(stderr, _("Could not determine enforcing mode.\=
n"));
> > -               return -1;
> > -       }
> > -
> >         /* Re-open TTY descriptor */
> >         fd =3D open(ttyn, O_RDWR | O_NONBLOCK);
> >         if (fd < 0) {
> > @@ -856,7 +851,8 @@ skip_relabel:
> >  static int parse_command_line_arguments(int argc, char **argv, char *t=
tyn,
> >                                         const char *old_context,
> >                                         char **new_context,
> > -                                       int *preserve_environment)
> > +                                       int *preserve_environment,
> > +                                       int enforcing)
> >  {
> >         int flag_index; /* flag index in argv[] */
> >         int clflag; /* holds codes for command line flags */
> > @@ -928,6 +924,10 @@ static int parse_command_line_arguments(int argc, =
char **argv, char *ttyn,
> >                                                 return -1;
> >                                         }
> >                                         freecon(tty_con);
> > +                               } else if (enforcing) {
> > +                                       fprintf(stderr,
> > +                                               _("Error: could not det=
ermine the security context of the terminal, not allowed to change levels\n=
"));
> > +                                       return -1;
> >                                 }
> >                         }
> >
> > @@ -1093,6 +1093,7 @@ int main(int argc, char *argv[])
> >         int fd;
> >         pid_t childPid =3D 0;
> >         char *shell_argv0 =3D NULL;
> > +       int enforcing;
> >         int rc;
> >
> >  #ifdef USE_PAM
> > @@ -1139,7 +1140,8 @@ int main(int argc, char *argv[])
> >                 return -1;
> >         }
> >
> > -       if (security_getenforce() < 0) {
> > +       enforcing =3D security_getenforce();
> > +       if (enforcing < 0) {
> >                 fprintf(stderr, _("Could not determine enforcing mode.\=
n"));
> >                 return -1;
> >         }
> > @@ -1162,7 +1164,8 @@ int main(int argc, char *argv[])
> >         }
> >
> >         if (parse_command_line_arguments(argc, argv, ttyn, old_context,
> > -                                        &new_context, &preserve_enviro=
nment))
> > +                                        &new_context, &preserve_enviro=
nment,
> > +                                        enforcing))
> >                 return -1;
> >
> >         /*
> > @@ -1226,7 +1229,7 @@ int main(int argc, char *argv[])
> >          * Once we authenticate the user, we know that we want to proce=
ed with
> >          * the action. Prior to this point, no changes are made the to =
system.
> >          */
> > -       fd =3D relabel_tty(ttyn, new_context, &tty_context, &new_tty_co=
ntext);
> > +       fd =3D relabel_tty(ttyn, new_context, &tty_context, &new_tty_co=
ntext, enforcing);
> >         if (fd < 0)
> >                 goto err_close_pam;
> >
> > --
> > 2.53.0
> >
> >
