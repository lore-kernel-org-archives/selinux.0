Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6EE1D7E26
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759841178; cv=none; b=YdfSWRyWB+8PQDLx43mWH47FO1THXbboadkv919vD+OnvEx1RWDtLZSKvvkt4El4qNJc6556wNTbOyWgQUxi9ANAMO8aAcZHlWPt23dTRR3wBxshIatnHWhkwcmSW6k6fKhT4LIPQW+kBA5yI+jTio4IitOTNaqxVW0uFrp3+II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759841178; c=relaxed/simple;
	bh=uY8mmHcpMTgatLdeHQjcoM4QEygUYK049VZn8ViZhKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQOdtnVXNCbbBf7TiEhju2aUaEPJNj7jnsxIG67XWogci48N+/knKRnO+htQU+isa349c3izYY3w8aAGz2YQjJHIIM0/R2hjjfud93b7YN2NVsD+59Dv2C/AN7c/NCHnh5EGD89x/zcu1oEfe0765G4ltwrw/5vl8rrnHGGXV/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAhCuLZL; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAhCuLZL"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32eb45ab7a0so6784208a91.0
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 05:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759841176; x=1760445976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zI3nVWuAhFQzTBWxiUJMiQoo/wWbu9ZeB+B0f7YqtoY=;
        b=TAhCuLZLW0+EItCdo5PFLPnlTRtgzflWuo1pjetXm0MnmXLpeAvcmZk93bXIayajog
         WL6O3MqDhcpLVGSwksvPoMF/m1FNHij4p6QsLRf3ouYxumP+rZW2R0UOJWrKG6yenRbx
         I2QfXS4DsNpgNw5/JskXFIyKzt4a2OApgZI0H49umFj4s308nnd+iq26DxyV6bLtr39e
         Vu7AXdGcITvl9CIXVIYcb6l6qarrqJ4tFaCk0ck04oamrndyGcp787Aq2SXkghWJQ75F
         pCjTOeLhTx9aJZi4A8W8t1CerG3j2B0IrDukdTys1aPy5TWn3PULTSizs7yAgqSDG1ke
         NT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759841176; x=1760445976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zI3nVWuAhFQzTBWxiUJMiQoo/wWbu9ZeB+B0f7YqtoY=;
        b=ksAO5jmgmKx65h2HF3Du0/uqmPjkqYi94wabKiMWRyA4DvUhTTSUYtIfKYtcwWwe3H
         Ig6kQTjHehYOCf+cvbfeUoi9Q4kZgQR6MEOy11T8e/3ZBA1swOfUiKzJAjtGivcQEGFH
         zdGaWn6enxd3wCpDNM71tUMnlpSaH0n80zk+h9GWQ3kpYzI1497e4UC5/mVyL85zJ1u9
         7kjbvH6EPg+XLF9QMRiWrRjGWQvok9Fb6Bz+7bF5cDfvq/IQnOBQ99qabum8fFp/6KDA
         +iv4SA1MVWp+zM5hFsdtTIUchqnYJttOivyLn585GiJ2QqWEP+X3IO16UZ+eebd91sBA
         yqSg==
X-Forwarded-Encrypted: i=1; AJvYcCVaCgfdbke86/spBppqdRwur2MbUDb69JQy7zCbOCbzW//iVrYls0IceztUs64wjdUi6UyH65Lg@vger.kernel.org
X-Gm-Message-State: AOJu0YxNql7j+Shgm1yDeODAtTPeXgV0cbuGsKo9jCeVcS69Ykh8XgOr
	0xbD8q1nOSx0YqDUDf+bqAxfQqdrs7z023iO6LhNQU9pmd3fKhEPJwgLwZ8dosAOjrR2q+RE+q7
	DGun2CVJnGQKZnTqMjNeXLJMD+tqXbJUGz4yl
X-Gm-Gg: ASbGnct4FO5hrEylSqHA5s58DC9/Gh1zngSub+slVCbVHbcp8JJXFJh0zdu+yzO3skw
	TU3YnQsawrlP9tHYyhTVqWL7EB7jrCoGwxfd/R5I4Z1HeW1tnHPLNAptytrW6fo3eYkpZPZMn0x
	Eg9PGR7brdopzyxT2l5pUhLxv6D2zPJX+1yvQ3GnphUL8s6qSwfwy13nk5JHSJETc/FYsdRwvQK
	NriFuyWz5849BfJ2wcBNghQadfL8pZot7GFGcGv3w==
X-Google-Smtp-Source: AGHT+IEe7mDevRvivvKUVhKsWOQH6NPq9Oi3lo/TM06a4S3P3AEYM1+80aiNgVE/1OkWwCqZ2248c/mJUVvtK3GqO1M=
X-Received: by 2002:a17:90b:1c88:b0:32e:4924:690f with SMTP id
 98e67ed59e1d1-339c26e547emr23550479a91.6.1759841176133; Tue, 07 Oct 2025
 05:46:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ5BOMkXu+=F0yG=OhqR0=w4vcY+J8KtUU-732vEXokk6w@mail.gmail.com>
 <20251007092922.471609-1-nvraxn@gmail.com>
In-Reply-To: <20251007092922.471609-1-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Oct 2025 08:46:05 -0400
X-Gm-Features: AS18NWBTnJaznXvQVqSUiDXntq19tOZP0Zs7T9Vze44ldb1psyybJUxYJtTlpGM
Message-ID: <CAEjxPJ4wxMi0kXc7wDi+qwboAcz1Y0UvzDoZMZrpUgcNH_cNRg@mail.gmail.com>
Subject: Re: [PATCH v5] seunshare: fix the frail tmpdir cleanup
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: jwcart2@gmail.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 5:30=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> wrot=
e:
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
>
> This doesn't really make all that much sense as far as I can tell.  We
> should be the only ones using the tmpdir, so we may as well just delete
> the entire thing using the rm_rf () function with elevated permissions.
>
> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>

With this patch applied, I see the following output when I use sandbox
-M and create anything in the tmpdir.

$ sandbox -M bash
bash: cannot set terminal process group (-1): Inappropriate ioctl for devic=
e
bash: no job control in this shell
bash-5.2$ mkdir /tmp/foobar
bash-5.2$ exit
Failed to recursively remove directory /tmp/.sandbox-sdsmall-chjRXi

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
> v5: fix spelling in comment
>
> diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
> index 106f625f..55e62620 100644
> --- a/sandbox/seunshare.c
> +++ b/sandbox/seunshare.c
> @@ -403,6 +403,66 @@ err:
>         return rc;
>  }
>
> +/*
> + * Recursively delete a directory.
> + * SAFETY: This function will NOT follow symbolic links (AT_SYMLINK_NOFO=
LLOW).
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
