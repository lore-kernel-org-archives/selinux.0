Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DB535EEC
	for <selinux@vger.kernel.org>; Fri,  5 Jan 2024 19:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUQ0b/BM"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cceb5f0918so21311531fa.2
        for <selinux@vger.kernel.org>; Fri, 05 Jan 2024 11:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704482111; x=1705086911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxAVdAbcdB241Y75D5Ljaw972S6fF87Gv/vi/oGQ0gU=;
        b=AUQ0b/BMWkqWNky09TnnSFcaBns3Vz+tcWoZYh5U5aDGYDDeKJscmyyhWeFvXw0xnK
         TRsQ27X/Q7GztNC0Tmkj0mzrRcMZlb0eUw7e4XJSTiakPDyyrinHLuAzDrtigPVSSr3E
         f8grW0dn5YZ6WIcj4OKmi5xPK8IRhSu5EP6ITUGXxakYLKN10dqswX4i1+mSRA3kEdCa
         wcAYEUliJovvKJ63HMkiOCzVMNf5SRd+bCd3SyiZutBhCFrPvug3S9yvk1Loi1BkoEm6
         Kv4j9U23XIDhaJuAWZZJ7a5DlBUFWOV9VHPV8XavWFXXmHaKg3rMCLE9kVdt01awpmSP
         K8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704482111; x=1705086911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HxAVdAbcdB241Y75D5Ljaw972S6fF87Gv/vi/oGQ0gU=;
        b=Vn02zi9OoZ22elYKAYeDeW6MwppbexSQtUA4U5S8hSA8goCTIH03E6aupEnhpIbgbz
         lOVIZjAj4ueybpGgXuSLVyxkPzF0yjza1n0IEVVJGmErJ0uCt4TQy91uegsoLBzYoNpS
         rRmBGeNN3XVebbusN/Ii65yDF9tOaWoeREDA0kadrZ7IBKfDeuKUZ1Vh0xjgeK1768Q3
         k7CjV2D1t1x/07nweuA+IVY2kpWoZhSs8ZdhHrtnBMPzi9Xz0nyVG293Bsm1UR9bmp9G
         FgIlFppEHNEN2n3yUDhSJSnDz2GzxzJ7CBYeJe0fsDYxyCLOwWWvE8xjQxgz9zcNfFXg
         7Gsw==
X-Gm-Message-State: AOJu0YylyvIRlyy/+92MLRJUU5gRzkvSe13RbWAcmvEk5+lrvaw42R3b
	8cNRpwGVpK83lEtgmuHnyV7U0vij15hM+heeGVg=
X-Google-Smtp-Source: AGHT+IFVmT1NaqexnnZqW7iEWmsbPQZydc5EKwX9Y2s5Szo82P+MDU0PCX9Nq+YCRTKoADLTY54zpGtUdgL/kNYgJ9Y=
X-Received: by 2002:a2e:7815:0:b0:2cd:3731:9c39 with SMTP id
 t21-20020a2e7815000000b002cd37319c39mr293484ljc.33.1704482111287; Fri, 05 Jan
 2024 11:15:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213161412.23022-1-cgzones@googlemail.com>
In-Reply-To: <20231213161412.23022-1-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 5 Jan 2024 14:14:59 -0500
Message-ID: <CAP+JOzTKn9pw6J5a-LaeAkS2hiOV6O52OZxqVWUC31K=iVoVoA@mail.gmail.com>
Subject: Re: [UTIL-LINUX PATCH] sulogin: relabel terminal according to SELinux policy
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 11:14=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The common SELinux practice is to have a distinct label for terminals in
> use by logged in users.  This allows to differentiate access on the
> associated terminal (e.g. user_tty_device_t) vs foreign ones (e.g.
> tty_device_t or sysadm_tty_device_t).  Therefore the application
> performing the user login and setting up the associated terminal should
> label that terminal according to the loaded SELinux policy.  Commonly
> this is done by pam_selinux(7).  Since sulogin(8) does not use pam(7)
> perform the necessary steps manually.
>
> Fixes: https://github.com/util-linux/util-linux/issues/1578
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

The SELinux parts look ok to me.
Reviewed-by: James Carter <jwcart2@gmail.com>

> ---
> Upstream pull-request: https://github.com/util-linux/util-linux/pull/2650
> ---
>  login-utils/sulogin-consoles.c |   4 +
>  login-utils/sulogin-consoles.h |   4 +
>  login-utils/sulogin.c          | 156 +++++++++++++++++++++++++++++----
>  3 files changed, 146 insertions(+), 18 deletions(-)
>
> diff --git a/login-utils/sulogin-consoles.c b/login-utils/sulogin-console=
s.c
> index 9ae525556..0dca949f4 100644
> --- a/login-utils/sulogin-consoles.c
> +++ b/login-utils/sulogin-consoles.c
> @@ -341,6 +341,10 @@ int append_console(struct list_head *consoles, const=
 char * const name)
>         tail->id =3D last ? last->id + 1 : 0;
>         tail->pid =3D -1;
>         memset(&tail->tio, 0, sizeof(tail->tio));
> +#ifdef HAVE_LIBSELINUX
> +       tail->reset_tty_context =3D NULL;
> +       tail->user_tty_context =3D NULL;
> +#endif
>
>         return 0;
>  }
> diff --git a/login-utils/sulogin-consoles.h b/login-utils/sulogin-console=
s.h
> index 12032c997..608c4f84f 100644
> --- a/login-utils/sulogin-consoles.h
> +++ b/login-utils/sulogin-consoles.h
> @@ -44,6 +44,10 @@ struct console {
>         pid_t pid;
>         struct chardata cp;
>         struct termios tio;
> +#ifdef HAVE_LIBSELINUX
> +       char *reset_tty_context;
> +       char *user_tty_context;
> +#endif
>  };
>
>  extern int detect_consoles(const char *device, int fallback,
> diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
> index 019f35092..2682c30fb 100644
> --- a/login-utils/sulogin.c
> +++ b/login-utils/sulogin.c
> @@ -99,6 +99,81 @@ static int locked_account_password(const char * const =
passwd)
>         return 0;
>  }
>
> +#ifdef HAVE_LIBSELINUX
> +/*
> + * Cached check whether SELinux is enabled.
> + */
> +static int is_selinux_enabled_cached(void)
> +{
> +       static int cache =3D -1;
> +
> +       if (cache =3D=3D -1)
> +               cache =3D is_selinux_enabled();
> +
> +       return cache;
> +}
> +
> +/* Computed SELinux login context. */
> +static char *login_context;
> +
> +/*
> + * Compute SELinux login context.
> + */
> +static void compute_login_context(void)
> +{
> +       char *seuser =3D NULL;
> +       char *level =3D NULL;
> +
> +       if (is_selinux_enabled_cached() =3D=3D 0)
> +               goto cleanup;
> +
> +       if (getseuserbyname("root", &seuser, &level) =3D=3D -1) {
> +               warnx(_("failed to compute seuser"));
> +               goto cleanup;
> +       }
> +
> +       if (get_default_context_with_level(seuser, level, NULL, &login_co=
ntext) =3D=3D -1) {
> +               warnx(_("failed to compute default context"));
> +               goto cleanup;
> +       }
> +
> +cleanup:
> +       free(seuser);
> +       free(level);
> +}
> +
> +/*
> + * Compute SELinux terminal context.
> + */
> +static void tcinit_selinux(struct console *con)
> +{
> +       security_class_t tclass;
> +
> +       if (!login_context)
> +               return;
> +
> +       if (fgetfilecon(con->fd, &con->reset_tty_context) =3D=3D -1) {
> +               warn(_("failed to get context of terminal %s"), con->tty)=
;
> +               return;
> +       }
> +
> +       tclass =3D string_to_security_class("chr_file");
> +       if (tclass =3D=3D 0) {
> +               warnx(_("security class chr_file not available"));
> +               freecon(con->reset_tty_context);
> +               con->reset_tty_context =3D NULL;
> +               return;
> +       }
> +
> +       if (security_compute_relabel(login_context, con->reset_tty_contex=
t, tclass, &con->user_tty_context) =3D=3D -1) {
> +               warnx(_("failed to compute relabel context of terminal"))=
;
> +               freecon(con->reset_tty_context);
> +               con->reset_tty_context =3D NULL;
> +               return;
> +       }
> +}
> +#endif
> +
>  /*
>   * Fix the tty modes and set reasonable defaults.
>   */
> @@ -132,6 +207,10 @@ static void tcinit(struct console *con)
>         errno =3D 0;
>  #endif
>
> +#ifdef HAVE_LIBSELINUX
> +       tcinit_selinux(con);
> +#endif
> +
>  #ifdef TIOCGSERIAL
>         if (ioctl(fd, TIOCGSERIAL,  &serinfo) >=3D 0)
>                 con->flags |=3D CON_SERIAL;
> @@ -785,7 +864,7 @@ out:
>  /*
>   * Password was OK, execute a shell.
>   */
> -static void sushell(struct passwd *pwd)
> +static void sushell(struct passwd *pwd, struct console *con)
>  {
>         char shell[PATH_MAX];
>         char home[PATH_MAX];
> @@ -842,22 +921,21 @@ static void sushell(struct passwd *pwd)
>         mask_signal(SIGHUP, SIG_DFL, NULL);
>
>  #ifdef HAVE_LIBSELINUX
> -       if (is_selinux_enabled() > 0) {
> -               char *scon =3D NULL;
> -               char *seuser =3D NULL;
> -               char *level =3D NULL;
> -
> -               if (getseuserbyname("root", &seuser, &level) =3D=3D 0) {
> -                       if (get_default_context_with_level(seuser, level,=
 0, &scon) =3D=3D 0) {
> -                               if (setexeccon(scon) !=3D 0)
> -                                       warnx(_("setexeccon failed"));
> -                               freecon(scon);
> -                       }
> +       if (is_selinux_enabled_cached() =3D=3D 1) {
> +               if (con->user_tty_context) {
> +                       if (fsetfilecon(con->fd, con->user_tty_context) =
=3D=3D -1)
> +                               warn(_("failed to set context to %s for t=
erminal %s"), con->user_tty_context, con->tty);
> +               }
> +
> +               if (login_context) {
> +                       if (setexeccon(login_context) =3D=3D -1)
> +                               warn(_("failed to set exec context to %s"=
), login_context);
>                 }
> -               free(seuser);
> -               free(level);
>         }
> +#else
> +       (void)con;
>  #endif
> +
>         execl(su_shell, shell, (char *)NULL);
>         warn(_("failed to execute %s"), su_shell);
>
> @@ -866,6 +944,30 @@ static void sushell(struct passwd *pwd)
>         warn(_("failed to execute %s"), "/bin/sh");
>  }
>
> +#ifdef HAVE_LIBSELINUX
> +static void tcreset_selinux(struct list_head *consoles) {
> +       struct list_head *ptr;
> +       struct console *con;
> +
> +       if (is_selinux_enabled_cached() =3D=3D 0)
> +               return;
> +
> +       list_for_each(ptr, consoles) {
> +               con =3D list_entry(ptr, struct console, entry);
> +
> +               if (con->fd < 0)
> +                       continue;
> +               if (!con->reset_tty_context)
> +                       continue;
> +               if (fsetfilecon(con->fd, con->reset_tty_context) =3D=3D -=
1)
> +                       warn(_("failed to reset context to %s for termina=
l %s"), con->reset_tty_context, con->tty);
> +
> +               freecon(con->reset_tty_context);
> +               con->reset_tty_context =3D NULL;
> +       }
> +}
> +#endif
> +
>  static void usage(void)
>  {
>         FILE *out =3D stdout;
> @@ -1015,6 +1117,10 @@ int main(int argc, char **argv)
>                 return EXIT_FAILURE;
>         }
>
> +#ifdef HAVE_LIBSELINUX
> +       compute_login_context();
> +#endif
> +
>         /*
>          * Ask for the password on the consoles.
>          */
> @@ -1034,9 +1140,18 @@ int main(int argc, char **argv)
>         }
>         ptr =3D (&consoles)->next;
>
> -       if (ptr->next =3D=3D &consoles) {
> -               con =3D list_entry(ptr, struct console, entry);
> -               goto nofork;
> +#ifdef HAVE_LIBSELINUX
> +       /*
> +        * Always fork with SELinux enabled, so the parent can restore th=
e
> +        * terminal context afterwards.
> +        */
> +       if (is_selinux_enabled_cached() =3D=3D 0)
> +#endif
> +       {
> +               if (ptr->next =3D=3D &consoles) {
> +                       con =3D list_entry(ptr, struct console, entry);
> +                       goto nofork;
> +               }
>         }
>
>
> @@ -1087,7 +1202,7 @@ int main(int argc, char **argv)
>  #endif
>                                 if (doshell) {
>                                         /* sushell() unmask signals */
> -                                       sushell(pwd);
> +                                       sushell(pwd, con);
>
>                                         mask_signal(SIGQUIT, SIG_IGN, &sa=
ved_sigquit);
>                                         mask_signal(SIGTSTP, SIG_IGN, &sa=
ved_sigtstp);
> @@ -1193,5 +1308,10 @@ int main(int argc, char **argv)
>         } while (1);
>
>         mask_signal(SIGCHLD, SIG_DFL, NULL);
> +
> +#ifdef HAVE_LIBSELINUX
> +       tcreset_selinux(&consoles);
> +#endif
> +
>         return EXIT_SUCCESS;
>  }
> --
> 2.43.0
>
>
