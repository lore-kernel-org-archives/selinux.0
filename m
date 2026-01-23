Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDE5283CB1
	for <selinux@vger.kernel.org>; Fri, 23 Jan 2026 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769180606; cv=pass; b=NqfJ2Ayyn2fbs3FeQVN63h9Hk4KkuRg3ruEGRkoagBa1/2vtF3Uef5Uv4h1fA/C958jj4kvacTRSrfDdzwVwckBI7Tbzl7IOUA3AzIxAlU8/lEgD6fQKeuTRW276wdOTOOyz6WApXcHA2dZIQTNGD42bijoQ+e5HU2+TYYnCNTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769180606; c=relaxed/simple;
	bh=rwq4m3hpjYG+3BRQ2DEHd6zcUlfJe9q+EJVxABrqJcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tk7YSWEPO/39sKoZt8CacLohpyVzLRBpVzIE1Wn9nXWXfvbni3PozNwPEe/VQy3ar6sLHrysTzw9kOQ0JrGXEDLh9AwtWSDe6NlNTWKP51L7JqsqZgdWYVhBUlJ1a5a1S5FvUjwZp6AHtgKQv7Zee4a7CS6fD7qdX3/4qLAv9yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SML46LoV; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SML46LoV"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-37fd6e91990so24351611fa.3
        for <selinux@vger.kernel.org>; Fri, 23 Jan 2026 07:03:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769180603; cv=none;
        d=google.com; s=arc-20240605;
        b=XrwYCzx1RcVGf38vnyGfnNJKchHQ3r3eoNx25NjuUtw+tOZrlqFfshn4BmBrgiT0V4
         II4VYy3EUbvOykk0luAD/d7oQNu934/tTdaSghR7UGEztaTkZMdMU3QsDMFy4m14DeW7
         oDWitpn8bCMYbD6e0BVg3h2cylVsTHT7nqbfFTIHGv87uvR5s2go2jzrK+bPa1bGoBik
         Yl6BWav/QQ7Vzd/MkmzVfw01wSlH9ZE9CTOWEZagbVp1xfbgHM/5zBd+Szgo9HW+GY1N
         dROtvv3MGExebmscHXB+KfjkyYZ8wI3RC5osLH9BHYYk13xeHnaj82b1hrgyB2GCY06x
         B9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ps/oiUAwxkPxIkd+nFlk13f/Z4J97rmsNvG2ipwa+7k=;
        fh=IdnM6pgHPPeNgwOxSSybsMeRgsAFlvhyJ19RVUnmBlA=;
        b=UFvob/4iM1295kErt7rzD+1+P1o453KWuFw/L+tjQbxlnEVGX8kYrlsh5pv7VAjRN4
         rXYt5eXnMDhSSuWmJl/y0AUwGAP1o03G79MGEk5UsvHmQfkxJ7ePcoLupNY6s7WKqTAF
         3wQ1KU4wNWotDTw7amnYONe2QVTjOPHJ65+R7tChDgRkQcL5nWNVcYsy2C65Yh8T1/X1
         fCdDRYGi0CuO+ztzhw3ak3OT5/jduUqfy3IpJHzsh4VFHfOcZfv+cHBIhbjv6p9fkZe0
         6iKp+TtwFQ+0mguJhku58P88/AFpdbmENyBe3jdQ3zbg/ERt1Gjxh1To6JbFhvKRsqCI
         qE3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769180603; x=1769785403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ps/oiUAwxkPxIkd+nFlk13f/Z4J97rmsNvG2ipwa+7k=;
        b=SML46LoVhEi3CHtzcIZfoN2gsBl1G7CkgsQke2YfJ1T8wPNDsu+0HGKhFzThd5yHJ2
         ShlzBn3uWOsM8vbTjYYOA2E4rLdoHu9zNa2NPbS53JrNGSFKsKyAgJuNWsGATHgkt7Vb
         lTKKRDVfunhdZE7hFgaD2gP7hkY+/W4GPuVFTcsOtd5Vdl7p04NJOa2t9bI+7FUL302b
         sM2fgRDCV+2F9nwot9l9bJ4k/v/1rkYcoYvN/oDFuLZNBPM9rLytwuUkJMqi7tYenqf7
         hVOgAiTNZS4dnJ1K2EKlX5YwxAbhVH6jr9NItCo0n+whf9SjzPm1vVuL+n09YXq/jeac
         dJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769180603; x=1769785403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ps/oiUAwxkPxIkd+nFlk13f/Z4J97rmsNvG2ipwa+7k=;
        b=paGL8kz4wPNtPBGwtsAdFQZo3l06n2/RqQEvxhFDZvBiviUqGyFCYIFTAbRmLvcwaZ
         Gi1xywfUAknYmFqSb3KDb6icXsUD9S/4eeZ+jRP/3otSiNlX+sFJbvH+shGXWQ0Igk1K
         I0KbSsE3WeGmigbmuYJcV55594AmqZvzlVGNy/MABgp+o7GvVa5c+g+qOjV1Tu+IsGVp
         9Xu79CxJYmypNPQzrrO66A4dOaUqZIwf8q7lym2wUcpmVCGmkMREa/X+glookNeYQvFy
         Cmgu3OownIizfW4SPV5MDEXrEThV3e2/EIdFF9Hp4JWdmdQuZWt0wsMyJh62ID0PkVGX
         BNrg==
X-Gm-Message-State: AOJu0YzNw5f206aOvAPDFcY73Rq5hLt9/K8yGIQQhpyErCTU9KYRKCkf
	7IT5pArCIAhJqevT0+akpa/1U6upNU46PDhJ0xqgAb4X3lKRGrjiQNwgQS9WTdLXRYc+Z+0Fq36
	QA/nkZ+xtdSVaJz3fuX1K6zDoZRnAzz8=
X-Gm-Gg: AZuq6aIp8TkZBcO5LYS7r3YA9DHb0QZVBxIJbpr7HPNWKG9kj9k3Cnmv1YGVcAWvRVZ
	5crz7t5irv0OTdH46m4UtvyuGFwvbo4l69Ir2+RrhZSOXHwSQ7XH3K+9ihV6lVLFdlrPhAFLaVj
	Um04O99fJbnaIrsITYy4bFhE2vT9cpqJI4nGSEH+Q45O4poiO4yRrSJw+HNnf/WcSzP6b2bce+2
	CZYHDk2fIRqE0wheCtlT+XGnPwFDHPCBN5OUtHbztPkfd1oNAx/6BDfXAKwF0OqGjXc
X-Received: by 2002:a2e:beaa:0:b0:37a:84e5:a1cc with SMTP id
 38308e7fff4ca-385da068226mr11319641fa.22.1769180602167; Fri, 23 Jan 2026
 07:03:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DFID35MI20QY.1TO7H1O354V64@gmail.com> <20260107165908.1584087-1-lautrbach@redhat.com>
In-Reply-To: <20260107165908.1584087-1-lautrbach@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 23 Jan 2026 10:03:10 -0500
X-Gm-Features: AZwV_QhQLNXlKsoFMm_X9fCpziAMWY_z5x4qLhYY_EZlPWmOe_J6U9B7xxh7sBY
Message-ID: <CAP+JOzS23+GZdXGGXdce8-UCvAc8jpsZ84aCCTP1_QJ2tNmNoA@mail.gmail.com>
Subject: Re: [PATCH v2] sandbox/seunshare: Replace system() with execv() to
 prevent shell injection
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org, Rahul Sandhu <nvraxn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 12:33=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> Refactor spawn_command() to use execv() instead of system() to eliminate
> shell injection vulnerabilities.
>
> Reported-By: Rahul Sandhu <nvraxn@gmail.com>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v2  - drop index initialization
>
>  sandbox/seunshare.c | 132 ++++++++++++++++++++++++++------------------
>  1 file changed, 79 insertions(+), 53 deletions(-)
>
> diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
> index 65da46463a8f..2512a18c7b52 100644
> --- a/sandbox/seunshare.c
> +++ b/sandbox/seunshare.c
> @@ -56,6 +56,12 @@
>  #define USAGE_STRING _("USAGE: seunshare [ -v ] [ -C ] [ -k ] [ -t tmpdi=
r ] [ -h homedir ] \
>  [ -r runuserdir ] [ -P pipewiresocket ] [ -W waylandsocket ] [ -Z CONTEX=
T ] -- executable [args] ")
>
> +#define strdup_or_err(args, index, src) do {   \
> +               args[index] =3D strdup(src); \
> +               if (! args[index]) \
> +                       goto err; \
> +       } while(0)
> +
>  static int verbose =3D 0;
>  static int child =3D 0;
>
> @@ -136,15 +142,14 @@ static int set_signal_handles(void)
>         } while(0)
>
>  /**
> - * Spawn external command using system() with dropped privileges.
> - * TODO: avoid system() and use exec*() instead
> + * Spawn external command with dropped privileges.
>   */
> -static int spawn_command(const char *cmd, uid_t uid){
> +static int spawn_command(char **cmd, uid_t uid){
>         int childpid;
>         int status =3D -1;
>
>         if (verbose > 1)
> -               printf("spawn_command: %s\n", cmd);
> +               printf("spawn_command: %s\n", cmd[0]);
>
>         childpid =3D fork();
>         if (childpid =3D=3D -1) {
> @@ -155,8 +160,7 @@ static int spawn_command(const char *cmd, uid_t uid){
>         if (childpid =3D=3D 0) {
>                 if (drop_privs(uid) !=3D 0) exit(-1);
>
> -               status =3D system(cmd);
> -               status_to_retval(status, status);
> +               status =3D execv(cmd[0], cmd);
>                 exit(status);
>         }
>
> @@ -342,15 +346,24 @@ static int bad_path(const char *path) {
>         return 0;
>  }
>
> -static int rsynccmd(const char * src, const char *dst, char **cmdbuf)
> -{
> +static void free_args(char **args) {
> +       char **args_p =3D args;
> +       if (! args)
> +               return;
> +       while (*args_p !=3D NULL) {
> +               free(*args_p);
> +               args_p++;
> +       }
> +       free(args);
> +}
> +
> +static int rsynccmd(const char * src, const char *dst, char ***cmd) {
> +       char **args;
>         char *buf =3D NULL;
> -       char *newbuf =3D NULL;
>         glob_t fglob;
>         fglob.gl_offs =3D 0;
>         int flags =3D GLOB_PERIOD;
> -       unsigned int i =3D 0;
> -       int rc =3D -1;
> +       unsigned int i =3D 0, index;
>
>         /* match glob for all files in src dir */
>         if (asprintf(&buf, "%s/*", src) =3D=3D -1) {
> @@ -365,43 +378,35 @@ static int rsynccmd(const char * src, const char *d=
st, char **cmdbuf)
>
>         free(buf); buf =3D NULL;
>
> -       for ( i=3D0; i < fglob.gl_pathc; i++) {
> -               const char *path =3D fglob.gl_pathv[i];
> -
> -               if (bad_path(path)) continue;
> -
> -               if (!buf) {
> -                       if (asprintf(&newbuf, "\'%s\'", path) =3D=3D -1) =
{
> -                               fprintf(stderr, _("Out of memory\n"));
> -                               goto err;
> -                       }
> -               } else {
> -                       if (asprintf(&newbuf, "%s  \'%s\'", buf, path) =
=3D=3D -1) {
> -                               fprintf(stderr, _("Out of memory\n"));
> -                               goto err;
> -                       }
> -               }
> -
> -               free(buf); buf =3D newbuf;
> -               newbuf =3D NULL;
> +       /* rsync  -trlHDq + <glob list> + dst + NULL */
> +       *cmd =3D calloc(2 + fglob.gl_pathc + 2, sizeof(char *));
> +       if (! *cmd) {
> +               fprintf(stderr, _("Out of memory\n"));
> +               return -1;
>         }
>
> -       if (buf) {
> -               if (asprintf(&newbuf, "/usr/bin/rsync -trlHDq %s '%s'", b=
uf, dst) =3D=3D -1) {
> -                       fprintf(stderr, _("Out of memory\n"));
> -                       goto err;
> -               }
> -               *cmdbuf=3Dnewbuf;
> -       }
> -       else {
> -               *cmdbuf=3DNULL;
> -       }
> -       rc =3D 0;
> +       args =3D *cmd;
> +       strdup_or_err(args, 0, "/usr/bin/rsync");
> +       strdup_or_err(args, 1, "-trlHDq");
>
> +       for ( i=3D0, index =3D 2; i < fglob.gl_pathc; i++) {
> +               const char *path =3D fglob.gl_pathv[i];
> +               if (bad_path(path)) continue;
> +               strdup_or_err(args, index, path);
> +               index++;
> +       }
> +       strdup_or_err(args, index, dst);
> +       index++;
> +       args[index] =3D NULL;
> +       globfree(&fglob);
> +       return 0;
>  err:
> -       free(buf); buf =3D NULL;
>         globfree(&fglob);
> -       return rc;
> +       if (args) {
> +               free_args(args);
> +               *cmd =3D NULL;
> +       }
> +       return -1;
>  }
>
>  /*
> @@ -472,21 +477,38 @@ static bool rm_rf(int targetfd, const char *path) {
>  static int cleanup_tmpdir(const char *tmpdir, const char *src,
>         struct passwd *pwd, int copy_content)
>  {
> -       char *cmdbuf =3D NULL;
> +       char **args;
>         int rc =3D 0;
>
>         /* rsync files back */
>         if (copy_content) {
> -               if (asprintf(&cmdbuf, "/usr/bin/rsync --exclude=3D.X11-un=
ix -utrlHDq --delete '%s/' '%s/'", tmpdir, src) =3D=3D -1) {
> +               args =3D calloc(7, sizeof(char *));
> +               if (! args) {
>                         fprintf(stderr, _("Out of memory\n"));
> -                       cmdbuf =3D NULL;
> -                       rc++;
> +                       return 1;
> +               }
> +
> +               strdup_or_err(args, 0, "/usr/bin/rsync");
> +               strdup_or_err(args, 1, "--exclude=3D.X11-unix");
> +               strdup_or_err(args, 2, "-utrlHDq");
> +               strdup_or_err(args, 3, "--delete");
> +               if (asprintf(&args[4], "%s/", tmpdir) =3D=3D -1) {
> +                       fprintf(stderr, _("Out of memory\n"));
> +                       free_args(args);
> +                       return 1;
>                 }
> -               if (cmdbuf && spawn_command(cmdbuf, pwd->pw_uid) !=3D 0) =
{
> +               if (asprintf(&args[5], "%s/", src) =3D=3D -1) {
> +                       fprintf(stderr, _("Out of memory\n"));
> +                       free_args(args);
> +                       return 1;
> +               }
> +               args[6] =3D NULL;
> +
> +               if (spawn_command(args, pwd->pw_uid) !=3D 0) {
>                         fprintf(stderr, _("Failed to copy files from the =
runtime temporary directory\n"));
>                         rc++;
>                 }
> -               free(cmdbuf); cmdbuf =3D NULL;
> +               free_args(args);
>         }
>
>         if ((uid_t)setfsuid(0) !=3D 0) {
> @@ -506,6 +528,10 @@ static int cleanup_tmpdir(const char *tmpdir, const =
char *src,
>         }
>
>         return rc;
> +err:
> +       if (args)
> +               free_args(args);
> +       return 1;
>  }
>
>  /**
> @@ -518,7 +544,7 @@ static char *create_tmpdir(const char *src, struct st=
at *src_st,
>         struct stat *out_st, struct passwd *pwd, const char *execcon)
>  {
>         char *tmpdir =3D NULL;
> -       char *cmdbuf =3D NULL;
> +       char **cmd =3D NULL;
>         int fd_t =3D -1, fd_s =3D -1;
>         struct stat tmp_st;
>         char *con =3D NULL;
> @@ -605,7 +631,7 @@ static char *create_tmpdir(const char *src, struct st=
at *src_st,
>         if ((uid_t)setfsuid(pwd->pw_uid) !=3D 0)
>                 goto err;
>
> -       if (rsynccmd(src, tmpdir, &cmdbuf) < 0) {
> +       if (rsynccmd(src, tmpdir, &cmd) < 0) {
>                 goto err;
>         }
>
> @@ -613,7 +639,7 @@ static char *create_tmpdir(const char *src, struct st=
at *src_st,
>         if ((uid_t)setfsuid(0) !=3D pwd->pw_uid)
>                 goto err;
>
> -       if (cmdbuf && spawn_command(cmdbuf, pwd->pw_uid) !=3D 0) {
> +       if (spawn_command(cmd, pwd->pw_uid) !=3D 0) {
>                 fprintf(stderr, _("Failed to populate runtime temporary d=
irectory\n"));
>                 cleanup_tmpdir(tmpdir, src, pwd, 0);
>                 goto err;
> @@ -623,7 +649,7 @@ static char *create_tmpdir(const char *src, struct st=
at *src_st,
>  err:
>         free(tmpdir); tmpdir =3D NULL;
>  good:
> -       free(cmdbuf); cmdbuf =3D NULL;
> +       free_args(cmd);
>         freecon(con); con =3D NULL;
>         if (fd_t >=3D 0) close(fd_t);
>         if (fd_s >=3D 0) close(fd_s);
> --
> 2.52.0
>
>
