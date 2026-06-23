Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB143191C8
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 16:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782233054; cv=pass; b=qaJQp3aSz+FdJdomMj+LQJY7MTAzVW7+3l9dS/WJR3Mi0kjZ1kSEMiRwNl+xZlQt/rbq+GeO2hVFESC2HbFcVTW/QAHal/504ELNKFioMgm5QtwvQ8eXOnRIprCzkwg266gk8E10ZoipkVHHkwjiY75I+dmN7x9wSk6WtgBrXPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782233054; c=relaxed/simple;
	bh=Lo3VG/dlTd2ecaQAZZaZ0baYpP6RblGNNv9vHhUsfU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8Dcccmfv921tWfVNZqBRd48Mm1HEaVCIWlVY3H58ZOsBwZtc/dBmiPWBX2vwfaduqQqd7VVuDIbRxof7psZnbqESveWZdqWn8UjHmHcpN5A+lFk3EBmQDCnmFOOg8SmBkWvmNqyPSrlC1hxRlg3MZkZkhmdj5zBiQEEqdzDqk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZE8hfol; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZE8hfol"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-37d4ab2e7c5so134182a91.2
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 09:44:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782233052; cv=none;
        d=google.com; s=arc-20240605;
        b=UG5Q0ghrgU2sJY+qJJiF/3U5iOi4i5UwWiRLCQFxc5K7Hz4O4NLdonLz7pMP+EbZVD
         9a60foJmpWztGQbZ7WTk7xWhdZnauYq57HnExI6iIGd3HkXvhXjwnUdDqiNFrByRetJX
         uGc2XouV45PuOIGAtnhPK3N1zUZM0ABYHbQ0sHbgq9cFi6Y36KipJ3zm3NPk+sUuuMuN
         YEPYKdGGNW01CTF5b5yuUnJcXyjbj0qUkGwvcNVylxcrLHsgbPrqL0ySN8nC/fooG9WN
         64P7X0vm65LY7NaOKF+sHBcujbxWNyWE32V32cBdwPMNZ+7Ql12No/Vq/GajCOThf0Z7
         dAqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YU5i0ymcUHuEMv8JDivKqmtVFwbo1/0KG/qaOvFBfBg=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=dSOOYVXT4VFtgzZm72mALn1dyxlSqe5HAf3vRDu8Ph50OA3EXEbUxk049ZsDHsJjTM
         SuVMyYI3cjJ0vIdW7wdkCxWW01J+haxNlsEXDt38zj9CNAmMo7vhe+D/tLobaxEoELGo
         9kSh2ZOJpLzJCHQVJV5yPKmlmJ7u+5XUjzpg+IQuLTlo/UAog4YEkZrn1ukO5qnYpCPD
         BYGpksqxKlNuYeKKplG1bRAZL+7i6OmXbaNpWFceTCdWbTgpOOrKCwLIcbxAMURYfBex
         CHQojz3E84TPi5g1FxNt5OMFFxAW+S6aV/+ZiONnXmv4J05HYJc8Lffuxc8FAaZ+6VAE
         LIDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782233052; x=1782837852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YU5i0ymcUHuEMv8JDivKqmtVFwbo1/0KG/qaOvFBfBg=;
        b=QZE8hfolJWz+dqBGlXvTZt0QbG6b1F/Ya/fBaziivmZGFGq6joFDZ5mehEDO3bR57Q
         do7v8m4Bh/FtDXb0Ljz0/4BnUmcJjSp2/Oc8RywzVH628Fm1UvE79EwwDHb3mj4Y7jek
         k16HaYWrNSxI8P0TeZDJb1chjygXVnKJ1CyxGNDOABB60zUUvoIK9KAvHYYBIO0uwkIm
         8mrahqe240cESG5N92LCjB9k/Bmp5zVrLLAZTXx90LcVotHwrEz2XZqKwXzgq6NRYf14
         +bdmBZaS/7zj1qnODF6wAJzurULt90l9g1ymXZTNymv7ZAhFRyB/BkUt9RBqaLC17uVt
         urcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782233052; x=1782837852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YU5i0ymcUHuEMv8JDivKqmtVFwbo1/0KG/qaOvFBfBg=;
        b=g8lFo4V8btN4iFDZyn569xFmp5FC+tdHgsfHqebI31Ttr5a6CPxWRAf+Pd8LGQFbAk
         Mr+utmwkA1SAQSyu6NYhTlquSOZWZGsPutRsILnQuVOWebd0UJGSPpnWNYG8r33Xj8fC
         frxLjQ6sTFuHiOQePwqvKebGgxuf0ax8Ce7evL8bUDyfJuPfgoANO43+k1efzuCNIWL0
         IElUF4QOUrgIYd00WZfcAxHWkxp/Pv7TGsZOANIdf9+LCPDO5AGea0FrjTiXCouWs7VO
         fmCl267dNtH1rSedE8Vy0Tb028yIX1cElBR9qAB5uBUx/q/QCHovRdvfhvATuFgtvFFB
         FdBQ==
X-Gm-Message-State: AOJu0YxK6vURTvI9fMXnowX6OfI/0PDz14BdSscbkMIq51gAyJI1xflA
	GYvTzCGzrtjM1zPe0cBH5YKsEqpsAVtnU8UKIf+GqaREYia03aP8oGenFHpZIr3yYOJnhHBczzP
	SUBhuVbbOO2jXmJBbfAf6vewbGTc23ox2DA==
X-Gm-Gg: AfdE7cn1MQ4yVDNecQON+M3iYQvHNgRcZfj0WmxMzK/Kky9KsU6kBktSz9eUVv9/LMm
	7toEeVMxZH9zs6jllUC/VAEjwAt1m/wecYSbs5AUvKunHIQdLyRcRWQq/6XvBG9Hxm0K96ob2jU
	ubizlXCC6DluhVza841gZIg+OZl2Ao0/uSq5ndcYCL8w+I0TKapg2w0nAmsG0lTvU5lONE3lrJa
	W50tIFA8q30/0YfiQkGTAi/A7/5oPLrvFMWvfbPzo+6yx6CECT4rwdCpW75T2EDsz52Vygl
X-Received: by 2002:a17:90b:5212:b0:37d:135e:2c42 with SMTP id
 98e67ed59e1d1-37dd17b6369mr3858665a91.24.1782233051967; Tue, 23 Jun 2026
 09:44:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623141023.114173-1-cgoettsche@seltendoof.de> <20260623141023.114173-4-cgoettsche@seltendoof.de>
In-Reply-To: <20260623141023.114173-4-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 12:44:00 -0400
X-Gm-Features: AVVi8CfP7zpYWPAQDSa7Wv4UCQlfE6E32sq7lp_P9Rkg1XT_eZ00VZlqZk0njqw
Message-ID: <CAEjxPJ7mBfTOLc=PY_jrSM0SrsqcRC97ioeFnG8vZcetDGs27A@mail.gmail.com>
Subject: Re: [PATCH 5/5] newrole: fail closed for -l when the terminal context
 is unknown
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 10:11=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> The -l secure-terminal check only ran when fgetfilecon() on stdin
> succeeded; if it failed the level change proceeded with no securetty
> check at all.  Resolve the enforcing mode and, when the terminal's
> context cannot be retrieved, reject the level change while enforcing
> rather than silently allowing it.
>
> Refactor the enforcing passing to unify security_getenforce(3) calls.
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Doesn't check clean with make check-format; will reformat on merge.


> ---
>  policycoreutils/newrole/newrole.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/=
newrole.c
> index 09b10b35..58524b6a 100644
> --- a/policycoreutils/newrole/newrole.c
> +++ b/policycoreutils/newrole/newrole.c
> @@ -732,21 +732,16 @@ static inline int send_audit_message(int success __=
attribute__((unused)),
>   * in permissive mode.
>   */
>  static int relabel_tty(const char *ttyn, const char *new_context,
> -                      char **tty_context, char **new_tty_context)
> +                      char **tty_context, char **new_tty_context,
> +                      int enforcing)
>  {
>         int fd, rc;
> -       int enforcing =3D security_getenforce();
>         char *tty_con =3D NULL;
>         char *new_tty_con =3D NULL;
>
>         if (!ttyn)
>                 return 0;
>
> -       if (enforcing < 0) {
> -               fprintf(stderr, _("Could not determine enforcing mode.\n"=
));
> -               return -1;
> -       }
> -
>         /* Re-open TTY descriptor */
>         fd =3D open(ttyn, O_RDWR | O_NONBLOCK);
>         if (fd < 0) {
> @@ -856,7 +851,8 @@ skip_relabel:
>  static int parse_command_line_arguments(int argc, char **argv, char *tty=
n,
>                                         const char *old_context,
>                                         char **new_context,
> -                                       int *preserve_environment)
> +                                       int *preserve_environment,
> +                                       int enforcing)
>  {
>         int flag_index; /* flag index in argv[] */
>         int clflag; /* holds codes for command line flags */
> @@ -928,6 +924,10 @@ static int parse_command_line_arguments(int argc, ch=
ar **argv, char *ttyn,
>                                                 return -1;
>                                         }
>                                         freecon(tty_con);
> +                               } else if (enforcing) {
> +                                       fprintf(stderr,
> +                                               _("Error: could not deter=
mine the security context of the terminal, not allowed to change levels\n")=
);
> +                                       return -1;
>                                 }
>                         }
>
> @@ -1093,6 +1093,7 @@ int main(int argc, char *argv[])
>         int fd;
>         pid_t childPid =3D 0;
>         char *shell_argv0 =3D NULL;
> +       int enforcing;
>         int rc;
>
>  #ifdef USE_PAM
> @@ -1139,7 +1140,8 @@ int main(int argc, char *argv[])
>                 return -1;
>         }
>
> -       if (security_getenforce() < 0) {
> +       enforcing =3D security_getenforce();
> +       if (enforcing < 0) {
>                 fprintf(stderr, _("Could not determine enforcing mode.\n"=
));
>                 return -1;
>         }
> @@ -1162,7 +1164,8 @@ int main(int argc, char *argv[])
>         }
>
>         if (parse_command_line_arguments(argc, argv, ttyn, old_context,
> -                                        &new_context, &preserve_environm=
ent))
> +                                        &new_context, &preserve_environm=
ent,
> +                                        enforcing))
>                 return -1;
>
>         /*
> @@ -1226,7 +1229,7 @@ int main(int argc, char *argv[])
>          * Once we authenticate the user, we know that we want to proceed=
 with
>          * the action. Prior to this point, no changes are made the to sy=
stem.
>          */
> -       fd =3D relabel_tty(ttyn, new_context, &tty_context, &new_tty_cont=
ext);
> +       fd =3D relabel_tty(ttyn, new_context, &tty_context, &new_tty_cont=
ext, enforcing);
>         if (fd < 0)
>                 goto err_close_pam;
>
> --
> 2.53.0
>
>
