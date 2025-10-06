Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3EC296BA9
	for <selinux@vger.kernel.org>; Mon,  6 Oct 2025 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759766237; cv=none; b=e6MOqgztAFntq4lrC9gksFQWH67i7jXvIij1emhyBAzQKTrvndGK2MqDkY2CPj4CZD7ti5GVo+WUZkv9NJdkwqkldOau4CIPgvnlZVuKA3t4Na+q/tM6cYQVHN77CeZ3tJrV3CHtpx0FGJ/0vvxlk1Wyt7rJfbDvyFGrIGgQ4wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759766237; c=relaxed/simple;
	bh=mZLbIRKZ9oBb9AleeSbxh26CUnYA8xnqDs6589MauhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SU6xXmWv43TbmRC9JIZ/hoDVaKFwLjq//pzOsJyxPQ2eIq1jf6As+E5dFhKiGOCCObHDTiSNKNRXs/CsfmrckQRd+qGHDtSc2CwIIYydGv3rA+SnYWayxixgW58OK0HT8s7JUqec9eyve+SvyNLK6jJafmffj3Qp6iTccfQE1HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dymCCBxR; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dymCCBxR"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3383ac4d130so4770607a91.2
        for <selinux@vger.kernel.org>; Mon, 06 Oct 2025 08:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759766234; x=1760371034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mw3bITPgOTP+U0uHmoeCb2AmTqC/scsrxmvKTulfnpw=;
        b=dymCCBxRk2+oEGcamO767uFNlvpm3idqceS5p4OgpkecpgtyOAh6bmn978lR5/4Tue
         QgGxE2V5WwkM/o5Xi3x5Fk1nKg4kFRS9/oPkzpDi/kWGV70FB/BNXOvUh+sHjUwpmevp
         DPxislvajRHS5m1tlORJv5on5u2CBD1QFqyLkObQBVVsQxTVQyZG8mjXqtsnXvWMMutN
         YWjaJQU18naNPPTi1aVMs6ssPF7UMEYYUTfEAPjaUnNHVtV1VWv6TaYkz0F0UMgA+IfJ
         V4ghNSpU9aW+kcgeO5cvj3bT0C5FQc/P+D9TfRTYC4r/BHLIR8I3rxI9FKaEjkdEw72n
         cCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759766234; x=1760371034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mw3bITPgOTP+U0uHmoeCb2AmTqC/scsrxmvKTulfnpw=;
        b=tOmxRxtBV5Ii8YXp562kYuSFISFkT3QWRbQwxp8sQmiuwt42BRutRgKyljex0+UxgQ
         kHB/fwcO9MaAa97HEH3Kq9GgSkpP5IpQbZUHKxyyi+Pp8MYexRuDPO4P5MjnzWgXmN6S
         zVa6cNOqOM+H9NyEg9tvvXngKtsPV2K8GKGKEPrWMu0v5RVyn3enfuQtRR2cy4DSX1U1
         jkd6il+hxnmzoSJEzqMevr5CfwNYf2S94EePAeWxuqk8uwo+ljFn5L5JUeNA98T8iQ+n
         /hJtb+99oArMjvhS05zmXIu07hcmJP5Imo5kw5Sfw1vih3pz48yo66dIgIPntXNdvLXp
         jJGw==
X-Forwarded-Encrypted: i=1; AJvYcCVO341bjzIEFjoUxDVfill2tE+8c7AYzvSlD7OUJdJbjFuJy6E30pf0p37PAUlXoV7FnrIpJ3p2@vger.kernel.org
X-Gm-Message-State: AOJu0YzA6QG18QaMKMQczH2veQ1t/sSKkDfcnCZOt4oKhjf0bHZXMWTF
	bo33E4yApzLvmbnuD7YFADHNJVnvwQGFsZhw+PYSc2tDDdxcSyKh8iVRDi7fGNBNjlpFvhB0mkq
	eT1BsNWY4qC11sYBGn0KVbeKtM3UtmwdoSw==
X-Gm-Gg: ASbGncsOnQmN6sIXTW8KI1q2ybnNmyVVBGhROk8FzlUUblGsY1h4aWwyxKWhpE9mycD
	3jdtqZiTRevwdAq4frsWjryTEj1C985C8tTeswUn5j6nl2exBJN2V8aIs7SlwOK697QPUhuZbOb
	pzCvqypeV44EC0KXYVq0StFnZ6XaFASzQlrlUzSnGqteoK7I0bMa8ny6VUQb+MSPJHeR8fLDoBR
	HsOxSSSCX5P4xdsjbauTLSPi0AX9NjLpLUm0mtnGeGwvDa/8Ytn
X-Google-Smtp-Source: AGHT+IHm4+e5MQ0oCjR1ov4+pa9O7QvUVfHQhl/Ix1CkSns8lqPTcUh52iNS6W40jJWH89OTGOwePT7TMuxi2cHubMc=
X-Received: by 2002:a17:90b:4c4f:b0:32e:f1c:e796 with SMTP id
 98e67ed59e1d1-339c27d2ebcmr15819469a91.25.1759766233601; Mon, 06 Oct 2025
 08:57:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP+JOzRkLMewUzpbdeQZDx7gR=t4eMysQkThxgBr8sfoaB-f7w@mail.gmail.com>
 <20250925053816.904674-1-nvraxn@gmail.com>
In-Reply-To: <20250925053816.904674-1-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 6 Oct 2025 11:57:02 -0400
X-Gm-Features: AS18NWALQzX3fZbrlucpdWzWfOdZJS2d-203DUSl-4nY-butH4ATcWwODoEP63E
Message-ID: <CAEjxPJ6S0o_Rmzt4nd+0jE0mHVP0sp-DA+=QrvJP5XjnAwTVSw@mail.gmail.com>
Subject: Re: [PATCH v4] seunshare: fix the frail tmpdir cleanup
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: jwcart2@gmail.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 1:38=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> wro=
te:
>
> For some reason, rm is invoked via system (3) to cleanup the runtime
> temp directory.  This really isn't all that robust, *especially* given
> that seunshare is supposed to be a security boundary.  Instead do this
> using libc, the API designed to be used within C programs.
>
> Also, don't bother trying to delete the contents of the tmpdir and then
> trying to delete the parent directory with rmdir later - for some...
> undocumented reason currently we attempt to delete the contents of the
> dir with dropped perms, *then* elevate perms, *then* delete the tmpdir.

I think this was for security/safety reasons, to prevent unlinking any
files linked from the tmpdir that weren't actually owned by the user.
However, in theory, your rewrite makes that obsolete.

>
> This doesn't really make all that much sense as far as I can tell.  We
> should be the only ones using the tmpdir, so we may as well just delete
> the entire thing using the rm_rf () function with elevated permissions.
>
> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
> ---
>  sandbox/seunshare.c | 77 ++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 65 insertions(+), 12 deletions(-)
>
> v2: don't use else after return
> v3: don't follow symlinks in rm_rf ().  This is pretty important as we
>     we are operating on an untrusted directory, which may have symlinks
>     pointed to privileged content.  However, as we only really need to
>     operate on the contents of the tmpdir, we can ignore symlinks.
> v4: fix spelling in commit message
>
> diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
> index 106f625f..c46db90f 100644
> --- a/sandbox/seunshare.c
> +++ b/sandbox/seunshare.c
> @@ -403,6 +403,66 @@ err:
>         return rc;
>  }
>
> +/*
> + * Recursively delete a directory.
> + * SAFTEY: This function will NOT follow symbolic links (AT_SYMLINK_NOFO=
LLOW).

Spelling here too: SAFETY

> + *         As a result, this function can be run safely on a directory o=
wned by
> + *         a non-root user: symbolic links to root paths (such as /root)=
 will
> + *         not be followed.
> + */
> +static bool rm_rf(int targetfd, const char *path) {
> +       struct stat statbuf;
> +
> +       if (fstatat(targetfd, path, &statbuf, AT_SYMLINK_NOFOLLOW) < 0) {
> +               if (errno =3D=3D ENOENT) {
> +                       return true;
> +               }
> +               perror("fstatat");
> +               return false;
> +       }
> +
> +       if (S_ISDIR(statbuf.st_mode)) {
> +               const int newfd =3D openat(targetfd, path, O_RDONLY | O_D=
IRECTORY | O_CLOEXEC);
> +               if (newfd < 0) {
> +                       perror("openat");
> +                       return false;
> +               }
> +
> +               DIR *dir =3D fdopendir(newfd);
> +               if (!dir) {
> +                       perror("fdopendir");
> +                       close(newfd);
> +                       return false;
> +               }
> +
> +               struct dirent *entry;
> +               int rc =3D true;
> +               while ((entry =3D readdir(dir)) !=3D NULL) {
> +                       if (strcmp(entry->d_name, ".") =3D=3D 0 || strcmp=
(entry->d_name, "..") =3D=3D 0) {
> +                               continue;
> +                       }
> +
> +                       if (rm_rf(dirfd(dir), entry->d_name) !=3D 0) {
> +                               rc =3D false;
> +                       }
> +               }
> +
> +               closedir(dir);
> +
> +               if (unlinkat(targetfd, path, AT_REMOVEDIR) < 0) {
> +                       perror("unlinkat");
> +                       rc =3D false;
> +               }
> +
> +               return rc;
> +       }
> +       if (unlinkat(targetfd, path, 0) < 0) {
> +               perror("unlinkat");
> +               return false;
> +       }
> +       return true;
> +}
> +
>  /**
>   * Clean up runtime temporary directory.  Returns 0 if no problem was de=
tected,
>   * >0 if some error was detected, but errors here are treated as non-fat=
al and
> @@ -428,24 +488,17 @@ static int cleanup_tmpdir(const char *tmpdir, const=
 char *src,
>                 free(cmdbuf); cmdbuf =3D NULL;
>         }
>
> -       /* remove files from the runtime temporary directory */
> -       if (asprintf(&cmdbuf, "/bin/rm -r '%s/' 2>/dev/null", tmpdir) =3D=
=3D -1) {
> -               fprintf(stderr, _("Out of memory\n"));
> -               cmdbuf =3D NULL;
> +       if ((uid_t)setfsuid(0) !=3D 0) {
> +               /* setfsuid does not return error, but this check makes c=
ode checkers happy */
>                 rc++;
>         }
> -       /* this may fail if there's root-owned file left in the runtime t=
mpdir */
> -       if (cmdbuf && spawn_command(cmdbuf, pwd->pw_uid) !=3D 0) rc++;
> -       free(cmdbuf); cmdbuf =3D NULL;
>
> -       /* remove runtime temporary directory */
> -       if ((uid_t)setfsuid(0) !=3D 0) {
> -               /* setfsuid does not return error, but this check makes c=
ode checkers happy */
> +       /* Recursively remove the runtime temp directory.  */
> +       if (!rm_rf(AT_FDCWD, tmpdir)) {
> +               fprintf(stderr, _("Failed to recursively remove directory=
 %s\n"), tmpdir);
>                 rc++;
>         }
>
> -       if (pwd->pw_uid !=3D 0 && rmdir(tmpdir) =3D=3D -1)
> -               fprintf(stderr, _("Failed to remove directory %s: %s\n"),=
 tmpdir, strerror(errno));
>         if ((uid_t)setfsuid(pwd->pw_uid) !=3D 0) {
>                 fprintf(stderr, _("unable to switch back to user after cl=
earing tmp dir\n"));
>                 rc++;
> --
> 2.50.1
>
