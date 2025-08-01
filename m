Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD29519F43A
	for <selinux@vger.kernel.org>; Fri,  1 Aug 2025 18:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754071976; cv=none; b=JCIAy0++YRHquCZQE+aBWXmku8KQr64tEOVsEqUTg9o+9TUI2IPZbzakljNJBaHTbvy3pb8f9rXRvCjhilKqjFKk91L9KtFDTtQ0LU6S8oH7PZ43DSvR1aiFSZDEqy4meJitFmom7Tx2b3K3zjPI23U2Tc/rz4nsSa83vKfGQU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754071976; c=relaxed/simple;
	bh=AuTrePRgGNFyuw9P3cyvy9P5xxoHQ8MDC1g9oiJ4PxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=erGNndoHSfWFszLsVC7GFHt58LsI5jY/iOi6twQPgi6lFrizM8YfLTWnlaIpdzjfr7ZVDRTno8fmdNB7M7y/scc4SmrnocRbZQj1on0jsGIbc/+LIOZMdeUrS9a4MUYAIKH6I3HMjlfosqImjsnvBPrM+xWbkxzZ79ba8Fh7GOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfGtMyF2; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfGtMyF2"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-313a001d781so1778328a91.3
        for <selinux@vger.kernel.org>; Fri, 01 Aug 2025 11:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754071974; x=1754676774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JoCfU8TLuVNQDPKRIC9ue9KBuDr180gVKJ3960V3HVU=;
        b=dfGtMyF2lSCElE75V7TjlUntWOR1ICZwmbJyCwpQbcg/hWYY2bML4HfGa2X/qKk+55
         ZHxDl0EHwsRjF6NjFGDRxYsJaEAv8Wf2l/rwC3vBVlhNWWQCrnPv+ly784mYnFajkr8h
         m9+enrdOSiqw+bfnGTffjY9o9SBCa+Nl5IPeyksHlipixhfXRvleJyOlrtAXeN2s68YQ
         BN2yeKDBcbZRCG/EDFeAPkvpfy+z6KPTdlZJlurod9L/NzV9kV6TjNXMmh/B4uWbBY2N
         7DThW6/B7iGCYaOLQuKJZ0JkU6fPhRXUi2dcyveSjgaG+ypawGftXITzDqlfmGvyJ0Uf
         BZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754071974; x=1754676774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JoCfU8TLuVNQDPKRIC9ue9KBuDr180gVKJ3960V3HVU=;
        b=OpGe66Pn47CbsKZw/wPgdIR82120Kr+PePKlkJcXkQxf+JXHJKMDpinwHtE4/2mwcJ
         lBJDIFbs1FQlkYxicR5jjIcZwneg/DqdmcJyLo4DSD1VI9Z0zrvJW7mVplGTQ0pQHtOf
         LodLRT7Dag91t/N0M+otisp5XM5XG+W1k/6dFk0E79oJqeyN9OHZbtK9MrV1knEiMiE8
         xt9yubPyjpDd1q7a1K9aanrtqlh34fFDxiG4TsTk6fG48sOsIMky5wwzU/XuRxl5S8Lc
         drLO9DoxGxpE8FQlOLxim3oSLpxz/R+1Cb/+5o8WQZi0VgLHLeXh+wH8S5C4PUSkYj1/
         J5XQ==
X-Gm-Message-State: AOJu0YwxYziJ++dX7mRHuzYLdpiJnR3d3Js+jaskzyJ86OnXc1JTWmWm
	MCBnukwhBN0PJ8XPFiPGbcC7WVHup0JLrj5PPMV32OORSmln8TPOggEZxusSwgtjQr4Hn8Zh8vM
	5P3yTDhAtX6s4J6JpEAqSU0knxA3aajZrCg==
X-Gm-Gg: ASbGncvDIpRwZGM4dRVb5s3bo0nbsdBRx/Jjlvlb9CaeO3/4rqub0FloKfwwpBFT/gx
	4lwynJ25AcMjTFRCTmqhZ/MTaQCUFoI0mCMj8rkXjxI521OBnydVlLtk6LPFIuzywvi7QHFR4GM
	zpReMq2sIlG5hLFpbt5JreFIspYykuQZpbhKjRueImHicr+pTvQILgXhRPcY9hh7M6tjMVgcf+X
	9E9HWoq8jFxyvCXQg==
X-Google-Smtp-Source: AGHT+IEiII/zzz4Y//UocUeWs5da+pReBZ5kCgoJLrUJEFahGyx+RcxYO0e54P281oNsF07UpJdgWDD90u1KOn5AfyM=
X-Received: by 2002:a17:90b:4a01:b0:313:5d2f:54f8 with SMTP id
 98e67ed59e1d1-321162e51f8mr1051524a91.33.1754071973902; Fri, 01 Aug 2025
 11:12:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DBQHP9O2QZP7.15GAYG3PERBJ8@gmail.com> <20250731211849.1102381-1-nvraxn@gmail.com>
In-Reply-To: <20250731211849.1102381-1-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 1 Aug 2025 14:12:42 -0400
X-Gm-Features: Ac12FXztzHbVopUyG_lpiAelWO3nmC8ZUt6jx8Iv7E58w3YIK6pEIPz9u1sYX7U
Message-ID: <CAEjxPJ6QGZcAO+zjdajOFTaDc+tuh56Vao3niO37udEr=UfAgg@mail.gmail.com>
Subject: Re: [PATCH v3] seunshare: fix the frail tmpdir cleanup
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 5:19=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> wro=
te:
>
> For some reason, rm is invoked via system (3) to cleanup the runtime
> temp directory.  This really isn't all that robust, *especially* given
> that seunshare is supposed to be a security boundry.  Instead do this

spelling (boundry->boundary)

> using libc, the API designed to be used within C programs.

I would think the idiomatic C way of doing this would be to use fts(3)
or nftw(3).
setfiles/restorecon originally used nftw(3) but later switched to
fts(3) for reasons I don't recall.

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
> ---
>  sandbox/seunshare.c | 77 ++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 65 insertions(+), 12 deletions(-)
>
> v2: don't use else after return
> v3: don't follow symlinks in rm_rf ().  This is pretty important as we
>     we are operating on an untrusted directory, which may have symlinks
>     pointed to privileged content.  However, as we only really need to
>     operate on the contents of the tmpdir, we can ignore symlinks.
>
> diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
> index 97430535..8b1af609 100644
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
>
