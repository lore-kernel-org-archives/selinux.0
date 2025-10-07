Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478DB1CF96
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759846168; cv=none; b=j9ALqhrosGY4NKsAWZ1BG1DWD3ghJz/uyN+jmlJHaObT4N2ncEyp6dugO2axAG6o45kPD5Uk9Yf7h/7D2pXvRvZHNZUMXN/LEeuuWBVpknxNCjp2pVehzTQqe9AyO5X2u77+ShTfNzIWb3lzBaiD8yjPH7bucc84vrPvjSudeGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759846168; c=relaxed/simple;
	bh=9pGQACeLLLR7mvadcADphGbdUUViVuCS9WPeaEML7xs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ftqx/pdO9uf9bwNHuBqNdopY2eIkP62skDRov42qw9Ko5dEezWMt0k4gmV7NAGll5U1scuy8tUwKmgE7r9umxwhn+vSGKK60giLMKjHTZW6ZI0MKhIbhUbtxbshf/Zh0CW49103oL6JowprPNoiCm4BeAmJyssa1c1DR354cldM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VY9assen; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VY9assen"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-339e71ccf48so2663606a91.3
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 07:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759846166; x=1760450966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeFvv0gvjQw2E8eHABo3iUJK8AezI3Xk3/k1vyG5qqM=;
        b=VY9assenOgS4qQXtakcBxzlMx/QqBApOmaLuVuGICU6RJPlLIMfNnQ8ZaW8BbaUmw9
         E2O8MeCFpioNIl+YZLvvK3aEa1O3bB+5XtsbPE5PtMrCM8E9jgrbS5CUwlP4Fe4i/uGj
         EjgvhWoFOowcoo8W0ETpu4JH00eJ4OjI1ekc+ketxMgAVtXxkeVJnl/97VSLAfpIKWXP
         T+py4pkvoINedqIWARW07thHgXAZ2+hV+63gzP/nIVaQL01CahJSpF0OnbNekVZF0kzG
         xtc5UVsh2VkJjbpotKZo5Oc9c+4SnyRlcp6MtadmphZh8ZUWKHWCNbLsMaea250WXAqB
         YpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759846166; x=1760450966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EeFvv0gvjQw2E8eHABo3iUJK8AezI3Xk3/k1vyG5qqM=;
        b=A2QBmIMG9DCqILxTuLyCY8u8Qriph2jIcHTZgU90VgqWDg/AyV5I60VoqreErUBWNx
         pFLb+tZpP4BmKnwK1u6ACi27XkjI9HMTmTe90+bkRiWHl4T34rATHKWDmgVvcVmqPkjl
         FJULgJjVdf349Cyusv+8EtuMR5GXwhxpag3JLaGF0PAMxv9QayHFS3MESpwJ8cwvYK3F
         FA1SsaA8PkSkSHdWexl7SUISk0V8taRIZRJ2DBWtmO8HEyj9BtTchitG77CqxiCeIBVK
         YBnMF/wg/88X4/x81scj46fmk5jOQjYDrmcxgA44cwPD8eBLcbHbU0DmGmnRfYMv5VB3
         7JZA==
X-Forwarded-Encrypted: i=1; AJvYcCUrPaihpQyTlaB+as9ZmbZiinKn1FxaXzfr6timkGS/hlGchvikKwvXzhY/Dg0gUfGw5tc8WuTV@vger.kernel.org
X-Gm-Message-State: AOJu0YwsgtvYxvwlB9XyxzwJeQrbtxdEp+zd2C627PQnncoJYUxv65hM
	nIv6Z1Q8YnzFd/hr1Z0rFH4/q8Lv0M/k+ZWJSoozOeajN5VDrwvVZ6dcUop6OTWGfGNu4VcxZow
	18wv7wpmy4wpYLzsC3nDhgy++ioFcvm0=
X-Gm-Gg: ASbGncsEtWm42A6tcyOHSCAJ3ivSFJFvsIsnmZfkwq9jwfPOdAXEU8taH+o9EiUdgw+
	YDOP3vOvAH3e5ldkC7S70gr21ociuXqi6XzY95oZZtoLEiAxW664LRJ284fEzftIrUfNo4wXM/r
	J5/pIJo+30iJEnJQIz6xp3+K/WP20HwM13l9vfTopo0HZ2xxi4VmMjlcJI9g1BJGsRjkXQmCnVX
	wiirmpYep+ZkTgR4EtR9k267GwBtj0=
X-Google-Smtp-Source: AGHT+IFfMP4USybDXSlub1eTdAOvOeNRgYQ+Qg1KEP8OfYJxKlB8mW2uoiYfT1JE6vDuznRIzgi67wvR/vpWC2rjUlo=
X-Received: by 2002:a17:90b:380a:b0:338:3221:9dc0 with SMTP id
 98e67ed59e1d1-339c27d518cmr22556960a91.37.1759846166377; Tue, 07 Oct 2025
 07:09:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ5BOMkXu+=F0yG=OhqR0=w4vcY+J8KtUU-732vEXokk6w@mail.gmail.com>
 <20251007092922.471609-1-nvraxn@gmail.com> <CAEjxPJ4wxMi0kXc7wDi+qwboAcz1Y0UvzDoZMZrpUgcNH_cNRg@mail.gmail.com>
In-Reply-To: <CAEjxPJ4wxMi0kXc7wDi+qwboAcz1Y0UvzDoZMZrpUgcNH_cNRg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Oct 2025 10:09:15 -0400
X-Gm-Features: AS18NWCHCy3pcmYPuhI_YeBEn06yZ0AHEOXatvrMM37M6BzzmWmB1U0DxftNSxo
Message-ID: <CAEjxPJ7536Z8DpOV6nRD-hkmddGLJa0uQ=9yB=tiqXMO7Bu5pQ@mail.gmail.com>
Subject: Re: [PATCH v5] seunshare: fix the frail tmpdir cleanup
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: jwcart2@gmail.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 8:46=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Oct 7, 2025 at 5:30=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> wr=
ote:
> >
> > For some reason, rm is invoked via system (3) to cleanup the runtime
> > temp directory.  This really isn't all that robust, *especially* given
> > that seunshare is supposed to be a security boundary.  Instead do this
> > using libc, the API designed to be used within C programs.
> >
> > Also, don't bother trying to delete the contents of the tmpdir and then
> > trying to delete the parent directory with rmdir later - for some...
> > undocumented reason currently we attempt to delete the contents of the
> > dir with dropped perms, *then* elevate perms, *then* delete the tmpdir.
> >
> > This doesn't really make all that much sense as far as I can tell.  We
> > should be the only ones using the tmpdir, so we may as well just delete

Also, to be clear, "should be the only ones using the tmpdir above" is
not a safe assumption against the user spawning a detached process
that can try to create symlinks in parallel with the recursive
removal, but that should be mitigated by your rm_rf implementation
IIUC.

> > the entire thing using the rm_rf () function with elevated permissions.
> >
> > Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
>
> With this patch applied, I see the following output when I use sandbox
> -M and create anything in the tmpdir.
>
> $ sandbox -M bash
> bash: cannot set terminal process group (-1): Inappropriate ioctl for dev=
ice
> bash: no job control in this shell
> bash-5.2$ mkdir /tmp/foobar
> bash-5.2$ exit
> Failed to recursively remove directory /tmp/.sandbox-sdsmall-chjRXi
>
> > ---
> >  sandbox/seunshare.c | 77 ++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 65 insertions(+), 12 deletions(-)
> >
> > v2: don't use else after return
> > v3: don't follow symlinks in rm_rf ().  This is pretty important as we
> >     we are operating on an untrusted directory, which may have symlinks
> >     pointed to privileged content.  However, as we only really need to
> >     operate on the contents of the tmpdir, we can ignore symlinks.
> > v4: fix spelling in commit message
> > v5: fix spelling in comment
> >
> > diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
> > index 106f625f..55e62620 100644
> > --- a/sandbox/seunshare.c
> > +++ b/sandbox/seunshare.c
> > @@ -403,6 +403,66 @@ err:
> >         return rc;
> >  }
> >
> > +/*
> > + * Recursively delete a directory.
> > + * SAFETY: This function will NOT follow symbolic links (AT_SYMLINK_NO=
FOLLOW).
> > + *         As a result, this function can be run safely on a directory=
 owned by
> > + *         a non-root user: symbolic links to root paths (such as /roo=
t) will
> > + *         not be followed.
> > + */
> > +static bool rm_rf(int targetfd, const char *path) {
> > +       struct stat statbuf;
> > +
> > +       if (fstatat(targetfd, path, &statbuf, AT_SYMLINK_NOFOLLOW) < 0)=
 {
> > +               if (errno =3D=3D ENOENT) {
> > +                       return true;
> > +               }
> > +               perror("fstatat");
> > +               return false;
> > +       }
> > +
> > +       if (S_ISDIR(statbuf.st_mode)) {
> > +               const int newfd =3D openat(targetfd, path, O_RDONLY | O=
_DIRECTORY | O_CLOEXEC);
> > +               if (newfd < 0) {
> > +                       perror("openat");
> > +                       return false;
> > +               }
> > +
> > +               DIR *dir =3D fdopendir(newfd);
> > +               if (!dir) {
> > +                       perror("fdopendir");
> > +                       close(newfd);
> > +                       return false;
> > +               }
> > +
> > +               struct dirent *entry;
> > +               int rc =3D true;
> > +               while ((entry =3D readdir(dir)) !=3D NULL) {
> > +                       if (strcmp(entry->d_name, ".") =3D=3D 0 || strc=
mp(entry->d_name, "..") =3D=3D 0) {
> > +                               continue;
> > +                       }
> > +
> > +                       if (rm_rf(dirfd(dir), entry->d_name) !=3D 0) {
> > +                               rc =3D false;
> > +                       }
> > +               }
> > +
> > +               closedir(dir);
> > +
> > +               if (unlinkat(targetfd, path, AT_REMOVEDIR) < 0) {
> > +                       perror("unlinkat");
> > +                       rc =3D false;
> > +               }
> > +
> > +               return rc;
> > +       }
> > +       if (unlinkat(targetfd, path, 0) < 0) {
> > +               perror("unlinkat");
> > +               return false;
> > +       }
> > +       return true;
> > +}
> > +
> >  /**
> >   * Clean up runtime temporary directory.  Returns 0 if no problem was =
detected,
> >   * >0 if some error was detected, but errors here are treated as non-f=
atal and
> > @@ -428,24 +488,17 @@ static int cleanup_tmpdir(const char *tmpdir, con=
st char *src,
> >                 free(cmdbuf); cmdbuf =3D NULL;
> >         }
> >
> > -       /* remove files from the runtime temporary directory */
> > -       if (asprintf(&cmdbuf, "/bin/rm -r '%s/' 2>/dev/null", tmpdir) =
=3D=3D -1) {
> > -               fprintf(stderr, _("Out of memory\n"));
> > -               cmdbuf =3D NULL;
> > +       if ((uid_t)setfsuid(0) !=3D 0) {
> > +               /* setfsuid does not return error, but this check makes=
 code checkers happy */
> >                 rc++;
> >         }
> > -       /* this may fail if there's root-owned file left in the runtime=
 tmpdir */
> > -       if (cmdbuf && spawn_command(cmdbuf, pwd->pw_uid) !=3D 0) rc++;
> > -       free(cmdbuf); cmdbuf =3D NULL;
> >
> > -       /* remove runtime temporary directory */
> > -       if ((uid_t)setfsuid(0) !=3D 0) {
> > -               /* setfsuid does not return error, but this check makes=
 code checkers happy */
> > +       /* Recursively remove the runtime temp directory.  */
> > +       if (!rm_rf(AT_FDCWD, tmpdir)) {
> > +               fprintf(stderr, _("Failed to recursively remove directo=
ry %s\n"), tmpdir);
> >                 rc++;
> >         }
> >
> > -       if (pwd->pw_uid !=3D 0 && rmdir(tmpdir) =3D=3D -1)
> > -               fprintf(stderr, _("Failed to remove directory %s: %s\n"=
), tmpdir, strerror(errno));
> >         if ((uid_t)setfsuid(pwd->pw_uid) !=3D 0) {
> >                 fprintf(stderr, _("unable to switch back to user after =
clearing tmp dir\n"));
> >                 rc++;
> > --
> > 2.50.1
> >
