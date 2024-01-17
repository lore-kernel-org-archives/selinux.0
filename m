Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82CF20DD1
	for <selinux@vger.kernel.org>; Wed, 17 Jan 2024 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705503043; cv=none; b=ZzIuNsPpLZ2bLyYqQRvMih6wJhxYuFCj/fSPRGxZCUAXXElVS82D/Hg8iPETdIWNiAdMkfHs+3MhfZW/hkcR3ApMwTEkxx5KTvgQTszx0mYAArgNHcJRN3awnkGf9KsBEIw1EHfeRa4/PUtqtzlNlJ6bv5KpoH46QftOjr2WGjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705503043; c=relaxed/simple;
	bh=tNG7gg7/XiGaKj0gcx9WxIF0KusbF5XMx6up3JkSs1M=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=NpHnHRxfavl7oanCdmGG7z6WFA3cL0yhjuYpsDRYtVdPZCFFRbz63elTGfI/92OoCT0U/a+6gq2KNmLp4CrPVnRVM9kJDTv7M2QNbgQL7s79CqUV7EmJ0FisSzfcFyt9AOLF1cW+o6O+WIabckUmCi1fmvR+NVh3ZHexpuDY60A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=cOaBnNP5; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="cOaBnNP5"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5f00bef973aso114972797b3.0
        for <selinux@vger.kernel.org>; Wed, 17 Jan 2024 06:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1705503040; x=1706107840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocmUAaNDQZ0wiOc6mbUbS0z1qhuSeTEd/a+UvLaxPkc=;
        b=cOaBnNP5TIiZ2LKiDcT5+JqjGWKa0M4Hn3isnb2K4PR8kgfEzMWKQrXa2K7YqdDnpc
         CZ8zpgVFjj8U9qeeWddbq5NV/TQHvz854m5iS9JBaAlulpbJmnAxRVYD3E7cwNcqmjh9
         QC3r3ldPoW6Maowl+obrcRkq0coC96Qd5ff9ysSZuPxrqd9+tVaD82S7l0rWaOtdqao2
         05jvVFJFQB3ad++1nvCnV4UTj+kQsPkGxtYaF7mrSFRDmQ6objJqEB7+cE2acG00WwFV
         pbeRCWXg1OXTYvHvi5V/xPaziYfUQHtiKS8eLz2Dt7aYO1T1rjmBEamrmY6XNB1VndcB
         WlSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705503040; x=1706107840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocmUAaNDQZ0wiOc6mbUbS0z1qhuSeTEd/a+UvLaxPkc=;
        b=t4dNDHwT+DpR8sp3kbiyvw75RYbCCseW+ppAoy3zu5aaFBEAmzGkX2/FskiwUPStGb
         YF7XFHhd+aociEbceJV+dFWSGYaO9YmLONSANOIKgkC21qkaikYYxI91TU1r88AelrT9
         chlNAkYrICp7bzFYeimwkk4o8Dc3v0qIdPrEAeLeeXod/cqPMNqEB2Pm36lBJO4rw/ZF
         8RYqz/RCsYOQOZWSU7d3SwlpsUjPe9gSO9DKkqOs6NrPCDh5d6f7jXLRKI7AXPZQ0Cks
         YKNQsm/Aav2op2n6oV4iFX6ohH6iVtnMQrjzuJTGi9I/IVMX8Eooz+7fL/3VTky1rQsn
         veTw==
X-Gm-Message-State: AOJu0Yw1MeMNvuMnLYxMIIlnco/o5uoHSPN541TOvGXApuLTpph70YEj
	3jM8hQQ4yXgYYFPwddh+tRrnWawvNLfgDZIO4zI=
X-Google-Smtp-Source: AGHT+IHCkEtJP0+MKGyskSVdNTI51gvuKkg+/CwByu99OB5H4CL5LzyZBiz3d8BrhzVDU/IwqxB+lNGG43P1/7ie6P0=
X-Received: by 2002:a0d:ea06:0:b0:5ff:5d87:efa5 with SMTP id
 t6-20020a0dea06000000b005ff5d87efa5mr1791413ywe.40.1705503040551; Wed, 17 Jan
 2024 06:50:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213161412.23022-1-cgzones@googlemail.com> <CAP+JOzTKn9pw6J5a-LaeAkS2hiOV6O52OZxqVWUC31K=iVoVoA@mail.gmail.com>
In-Reply-To: <CAP+JOzTKn9pw6J5a-LaeAkS2hiOV6O52OZxqVWUC31K=iVoVoA@mail.gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Wed, 17 Jan 2024 15:50:29 +0100
Message-ID: <CAJ2a_DcuPYfVdfgdgNqr7ALZwA8B9n+iwKBWbW13OWCG=sX1Gg@mail.gmail.com>
Subject: Re: [UTIL-LINUX PATCH] sulogin: relabel terminal according to SELinux policy
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Jan 2024 at 20:15, James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Dec 13, 2023 at 11:14=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > The common SELinux practice is to have a distinct label for terminals i=
n
> > use by logged in users.  This allows to differentiate access on the
> > associated terminal (e.g. user_tty_device_t) vs foreign ones (e.g.
> > tty_device_t or sysadm_tty_device_t).  Therefore the application
> > performing the user login and setting up the associated terminal should
> > label that terminal according to the loaded SELinux policy.  Commonly
> > this is done by pam_selinux(7).  Since sulogin(8) does not use pam(7)
> > perform the necessary steps manually.
> >
> > Fixes: https://github.com/util-linux/util-linux/issues/1578
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> The SELinux parts look ok to me.
> Reviewed-by: James Carter <jwcart2@gmail.com>

Thanks for the review Jim.
Applied via https://github.com/util-linux/util-linux/commit/eb02db62685cca3=
0e5afc61652c8b6e9cd0774e9

>
> > ---
> > Upstream pull-request: https://github.com/util-linux/util-linux/pull/26=
50
> > ---
> >  login-utils/sulogin-consoles.c |   4 +
> >  login-utils/sulogin-consoles.h |   4 +
> >  login-utils/sulogin.c          | 156 +++++++++++++++++++++++++++++----
> >  3 files changed, 146 insertions(+), 18 deletions(-)
> >
> > diff --git a/login-utils/sulogin-consoles.c b/login-utils/sulogin-conso=
les.c
> > index 9ae525556..0dca949f4 100644
> > --- a/login-utils/sulogin-consoles.c
> > +++ b/login-utils/sulogin-consoles.c
> > @@ -341,6 +341,10 @@ int append_console(struct list_head *consoles, con=
st char * const name)
> >         tail->id =3D last ? last->id + 1 : 0;
> >         tail->pid =3D -1;
> >         memset(&tail->tio, 0, sizeof(tail->tio));
> > +#ifdef HAVE_LIBSELINUX
> > +       tail->reset_tty_context =3D NULL;
> > +       tail->user_tty_context =3D NULL;
> > +#endif
> >
> >         return 0;
> >  }
> > diff --git a/login-utils/sulogin-consoles.h b/login-utils/sulogin-conso=
les.h
> > index 12032c997..608c4f84f 100644
> > --- a/login-utils/sulogin-consoles.h
> > +++ b/login-utils/sulogin-consoles.h
> > @@ -44,6 +44,10 @@ struct console {
> >         pid_t pid;
> >         struct chardata cp;
> >         struct termios tio;
> > +#ifdef HAVE_LIBSELINUX
> > +       char *reset_tty_context;
> > +       char *user_tty_context;
> > +#endif
> >  };
> >
> >  extern int detect_consoles(const char *device, int fallback,
> > diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
> > index 019f35092..2682c30fb 100644
> > --- a/login-utils/sulogin.c
> > +++ b/login-utils/sulogin.c
> > @@ -99,6 +99,81 @@ static int locked_account_password(const char * cons=
t passwd)
> >         return 0;
> >  }
> >
> > +#ifdef HAVE_LIBSELINUX
> > +/*
> > + * Cached check whether SELinux is enabled.
> > + */
> > +static int is_selinux_enabled_cached(void)
> > +{
> > +       static int cache =3D -1;
> > +
> > +       if (cache =3D=3D -1)
> > +               cache =3D is_selinux_enabled();
> > +
> > +       return cache;
> > +}
> > +
> > +/* Computed SELinux login context. */
> > +static char *login_context;
> > +
> > +/*
> > + * Compute SELinux login context.
> > + */
> > +static void compute_login_context(void)
> > +{
> > +       char *seuser =3D NULL;
> > +       char *level =3D NULL;
> > +
> > +       if (is_selinux_enabled_cached() =3D=3D 0)
> > +               goto cleanup;
> > +
> > +       if (getseuserbyname("root", &seuser, &level) =3D=3D -1) {
> > +               warnx(_("failed to compute seuser"));
> > +               goto cleanup;
> > +       }
> > +
> > +       if (get_default_context_with_level(seuser, level, NULL, &login_=
context) =3D=3D -1) {
> > +               warnx(_("failed to compute default context"));
> > +               goto cleanup;
> > +       }
> > +
> > +cleanup:
> > +       free(seuser);
> > +       free(level);
> > +}
> > +
> > +/*
> > + * Compute SELinux terminal context.
> > + */
> > +static void tcinit_selinux(struct console *con)
> > +{
> > +       security_class_t tclass;
> > +
> > +       if (!login_context)
> > +               return;
> > +
> > +       if (fgetfilecon(con->fd, &con->reset_tty_context) =3D=3D -1) {
> > +               warn(_("failed to get context of terminal %s"), con->tt=
y);
> > +               return;
> > +       }
> > +
> > +       tclass =3D string_to_security_class("chr_file");
> > +       if (tclass =3D=3D 0) {
> > +               warnx(_("security class chr_file not available"));
> > +               freecon(con->reset_tty_context);
> > +               con->reset_tty_context =3D NULL;
> > +               return;
> > +       }
> > +
> > +       if (security_compute_relabel(login_context, con->reset_tty_cont=
ext, tclass, &con->user_tty_context) =3D=3D -1) {
> > +               warnx(_("failed to compute relabel context of terminal"=
));
> > +               freecon(con->reset_tty_context);
> > +               con->reset_tty_context =3D NULL;
> > +               return;
> > +       }
> > +}
> > +#endif
> > +
> >  /*
> >   * Fix the tty modes and set reasonable defaults.
> >   */
> > @@ -132,6 +207,10 @@ static void tcinit(struct console *con)
> >         errno =3D 0;
> >  #endif
> >
> > +#ifdef HAVE_LIBSELINUX
> > +       tcinit_selinux(con);
> > +#endif
> > +
> >  #ifdef TIOCGSERIAL
> >         if (ioctl(fd, TIOCGSERIAL,  &serinfo) >=3D 0)
> >                 con->flags |=3D CON_SERIAL;
> > @@ -785,7 +864,7 @@ out:
> >  /*
> >   * Password was OK, execute a shell.
> >   */
> > -static void sushell(struct passwd *pwd)
> > +static void sushell(struct passwd *pwd, struct console *con)
> >  {
> >         char shell[PATH_MAX];
> >         char home[PATH_MAX];
> > @@ -842,22 +921,21 @@ static void sushell(struct passwd *pwd)
> >         mask_signal(SIGHUP, SIG_DFL, NULL);
> >
> >  #ifdef HAVE_LIBSELINUX
> > -       if (is_selinux_enabled() > 0) {
> > -               char *scon =3D NULL;
> > -               char *seuser =3D NULL;
> > -               char *level =3D NULL;
> > -
> > -               if (getseuserbyname("root", &seuser, &level) =3D=3D 0) =
{
> > -                       if (get_default_context_with_level(seuser, leve=
l, 0, &scon) =3D=3D 0) {
> > -                               if (setexeccon(scon) !=3D 0)
> > -                                       warnx(_("setexeccon failed"));
> > -                               freecon(scon);
> > -                       }
> > +       if (is_selinux_enabled_cached() =3D=3D 1) {
> > +               if (con->user_tty_context) {
> > +                       if (fsetfilecon(con->fd, con->user_tty_context)=
 =3D=3D -1)
> > +                               warn(_("failed to set context to %s for=
 terminal %s"), con->user_tty_context, con->tty);
> > +               }
> > +
> > +               if (login_context) {
> > +                       if (setexeccon(login_context) =3D=3D -1)
> > +                               warn(_("failed to set exec context to %=
s"), login_context);
> >                 }
> > -               free(seuser);
> > -               free(level);
> >         }
> > +#else
> > +       (void)con;
> >  #endif
> > +
> >         execl(su_shell, shell, (char *)NULL);
> >         warn(_("failed to execute %s"), su_shell);
> >
> > @@ -866,6 +944,30 @@ static void sushell(struct passwd *pwd)
> >         warn(_("failed to execute %s"), "/bin/sh");
> >  }
> >
> > +#ifdef HAVE_LIBSELINUX
> > +static void tcreset_selinux(struct list_head *consoles) {
> > +       struct list_head *ptr;
> > +       struct console *con;
> > +
> > +       if (is_selinux_enabled_cached() =3D=3D 0)
> > +               return;
> > +
> > +       list_for_each(ptr, consoles) {
> > +               con =3D list_entry(ptr, struct console, entry);
> > +
> > +               if (con->fd < 0)
> > +                       continue;
> > +               if (!con->reset_tty_context)
> > +                       continue;
> > +               if (fsetfilecon(con->fd, con->reset_tty_context) =3D=3D=
 -1)
> > +                       warn(_("failed to reset context to %s for termi=
nal %s"), con->reset_tty_context, con->tty);
> > +
> > +               freecon(con->reset_tty_context);
> > +               con->reset_tty_context =3D NULL;
> > +       }
> > +}
> > +#endif
> > +
> >  static void usage(void)
> >  {
> >         FILE *out =3D stdout;
> > @@ -1015,6 +1117,10 @@ int main(int argc, char **argv)
> >                 return EXIT_FAILURE;
> >         }
> >
> > +#ifdef HAVE_LIBSELINUX
> > +       compute_login_context();
> > +#endif
> > +
> >         /*
> >          * Ask for the password on the consoles.
> >          */
> > @@ -1034,9 +1140,18 @@ int main(int argc, char **argv)
> >         }
> >         ptr =3D (&consoles)->next;
> >
> > -       if (ptr->next =3D=3D &consoles) {
> > -               con =3D list_entry(ptr, struct console, entry);
> > -               goto nofork;
> > +#ifdef HAVE_LIBSELINUX
> > +       /*
> > +        * Always fork with SELinux enabled, so the parent can restore =
the
> > +        * terminal context afterwards.
> > +        */
> > +       if (is_selinux_enabled_cached() =3D=3D 0)
> > +#endif
> > +       {
> > +               if (ptr->next =3D=3D &consoles) {
> > +                       con =3D list_entry(ptr, struct console, entry);
> > +                       goto nofork;
> > +               }
> >         }
> >
> >
> > @@ -1087,7 +1202,7 @@ int main(int argc, char **argv)
> >  #endif
> >                                 if (doshell) {
> >                                         /* sushell() unmask signals */
> > -                                       sushell(pwd);
> > +                                       sushell(pwd, con);
> >
> >                                         mask_signal(SIGQUIT, SIG_IGN, &=
saved_sigquit);
> >                                         mask_signal(SIGTSTP, SIG_IGN, &=
saved_sigtstp);
> > @@ -1193,5 +1308,10 @@ int main(int argc, char **argv)
> >         } while (1);
> >
> >         mask_signal(SIGCHLD, SIG_DFL, NULL);
> > +
> > +#ifdef HAVE_LIBSELINUX
> > +       tcreset_selinux(&consoles);
> > +#endif
> > +
> >         return EXIT_SUCCESS;
> >  }
> > --
> > 2.43.0
> >
> >
