Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF7322424E
	for <selinux@vger.kernel.org>; Mon,  6 Oct 2025 18:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759776060; cv=none; b=JaLNziThojV5d9Y20cJbcfy263Dns7o+p4lN35B0cJH71nxxT2KlOV8eZwKylJW8IiDcrv8KtZsTET2eh2TsVFTXaeUi+X+20yH3SSWSphrF2ZLvhSASV5QBAmwp3pqS3mzveRTaSBoYlifffmvDiiOBlfNAy6xUTaqD5OsF0AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759776060; c=relaxed/simple;
	bh=wknYIZWGB+xD77G9/QKnl9zsAuWh36+rx/4uoCif1tI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VE9Aq4duZPziGh2xApShTyjW2eCuzFQm6zSE9Ykh3AOWbvGpKeskUWuVNlgWqDNMjRAp/StEX/6RHAXodcAQ3C9QdzWgHgpzpig4+vSHBkYc5YjGAz5edQvf6qJ9B0tCIKtVuT6VLtl99qv11WMJNWpZjpgJslZjX70+xhx1mng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPr59w9U; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPr59w9U"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2698e4795ebso51390345ad.0
        for <selinux@vger.kernel.org>; Mon, 06 Oct 2025 11:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759776058; x=1760380858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKJUEwf2Ino8XF+6l7dcMpA8uMsbuh5rIHggGT+ciHo=;
        b=SPr59w9UcCrVYe04KBmM6HZj1kYqKA7yUV5KvmXIGNLToN5r4+F8uDMfG3CUZ2wllG
         5b2zNY46Cl4PJ6owOIh39TGYJ0Onr+fvF9gXaIVj6BUczKFSUcTqrRWz3tAx8V4HYyzn
         9Uw829GZtgcLNZspIEEiCwmQyQCf7Dr5WZuwGqxtfMi0vj/6cCg7KPJOtfSbIg3RHh+f
         eXjzpHKtpu3o2uJrJrU/CZXYXq3MpDluRhVYMZLsUyvhT9qoUJ9TPHtxjRBkty9OxqG7
         XYpT4iNwxDW0mDLkx0Zv1SbyqUq5biI4Z2TuvrJEbmbjKPkTVUJLNZR0ODSWO/E1xhes
         tyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759776058; x=1760380858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKJUEwf2Ino8XF+6l7dcMpA8uMsbuh5rIHggGT+ciHo=;
        b=k2FfVzlNOjGce55aAbX7BZ7F6XYyyNlD/6EP+f+uQcZZNHDLyimG+Mqdn9dLqsiBH0
         PNcApwHpLwn3h2eTMeZaYMu+7ZHxiV9WDwPrm1COsgLb8lDPZdCFSj3mYTg7eRchIUO4
         O0nJhXag54oiC9DDIiJgRuc+ITJeBV1UsNTbo+IuWhj7nQG0MQYbjmTel2VsJjdV9LyN
         gAlaXhgnk0FuElxtu0iHQPJGptJM3GWsi70ItJKjpTXpNc8fflF35uUzXNwD5GbXmyH4
         zvRidktY1mdTvwq0qf0+035DRmledU9SlLAKhD8E2JE506va2ljU+b4Aj0cn593BwMHW
         K3+w==
X-Forwarded-Encrypted: i=1; AJvYcCXtj6Jup53J+z2+ZMb3yomAi2L8gfgm3Cfpq3CwveYZm3JZuNndBaX/Xx7Bp8zR1UEQKIlMIpnS@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq4wCzilLrgzf+fioJAVf/dQrBxYtz8BydlIkU3K062l4wSjNk
	q2XlGpQ3EvflXs+z4keMwH6xYH8kPJY/2GEtUlFKrCgZzyNKGFUWbysUCGuIGcTk1TUfnYPPCzz
	mrMb/uqoExmMkW2ZuOZYndKsnZyidKh0=
X-Gm-Gg: ASbGnct2WgFcHqiZyjT2dh5NCctud7YxIKpAnsXUAeCMITe0jFQ/QA2JFl99MKA0jr+
	lAeXrP/1mdu8c7NxRYYLfX88T+2ZkbmBvkFphON/3e1C9oamtxOMnohGuMs46Cb5JKavrS0lqBz
	uZ9iuhyNeyv0xu1J6izX0OfVnsPYqbN77vHVt8rwdTZXSEfUC8BBfCh7NLqE64XlKW3P9gy/6ft
	ArntqgfoDE0iEHqEaiKYks/a4BL1qA=
X-Google-Smtp-Source: AGHT+IF77iZvGHG1gcZlCbGhfxwVLX2S+TpnusBWw0H/ukjKzTW07mcb0EeY76uqE6H5/7nOZtwKWqnQTNh6WEZ1ELk=
X-Received: by 2002:a17:903:268c:b0:272:a900:c42b with SMTP id
 d9443c01a7336-28e9a693f4dmr125489605ad.31.1759776057939; Mon, 06 Oct 2025
 11:40:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP+JOzRkLMewUzpbdeQZDx7gR=t4eMysQkThxgBr8sfoaB-f7w@mail.gmail.com>
 <20250925053816.904674-1-nvraxn@gmail.com> <CAEjxPJ6S0o_Rmzt4nd+0jE0mHVP0sp-DA+=QrvJP5XjnAwTVSw@mail.gmail.com>
 <CAEjxPJ6NsHyLwF2PeUTmm6noxoMcB+v2eBQjsVff5iyDyhvkCQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6NsHyLwF2PeUTmm6noxoMcB+v2eBQjsVff5iyDyhvkCQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 6 Oct 2025 14:40:46 -0400
X-Gm-Features: AS18NWCwbocJsV6qRA67JQ-xwltYMoCoDbjoEpuKynIMLye5ZV5KMuBGl5iY7ng
Message-ID: <CAEjxPJ5BOMkXu+=F0yG=OhqR0=w4vcY+J8KtUU-732vEXokk6w@mail.gmail.com>
Subject: Re: [PATCH v4] seunshare: fix the frail tmpdir cleanup
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: jwcart2@gmail.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 12:31=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Oct 6, 2025 at 11:57=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, Sep 25, 2025 at 1:38=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com>=
 wrote:
> > >
> > > For some reason, rm is invoked via system (3) to cleanup the runtime
> > > temp directory.  This really isn't all that robust, *especially* give=
n
> > > that seunshare is supposed to be a security boundary.  Instead do thi=
s
> > > using libc, the API designed to be used within C programs.
> > >
> > > Also, don't bother trying to delete the contents of the tmpdir and th=
en
> > > trying to delete the parent directory with rmdir later - for some...
> > > undocumented reason currently we attempt to delete the contents of th=
e
> > > dir with dropped perms, *then* elevate perms, *then* delete the tmpdi=
r.
> >
> > I think this was for security/safety reasons, to prevent unlinking any
> > files linked from the tmpdir that weren't actually owned by the user.
> > However, in theory, your rewrite makes that obsolete.
> >
> > >
> > > This doesn't really make all that much sense as far as I can tell.  W=
e
> > > should be the only ones using the tmpdir, so we may as well just dele=
te
> > > the entire thing using the rm_rf () function with elevated permission=
s.
> > >
> > > Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
> > > ---
> > >  sandbox/seunshare.c | 77 ++++++++++++++++++++++++++++++++++++++-----=
--
> > >  1 file changed, 65 insertions(+), 12 deletions(-)
> > >
> > > v2: don't use else after return
> > > v3: don't follow symlinks in rm_rf ().  This is pretty important as w=
e
> > >     we are operating on an untrusted directory, which may have symlin=
ks
> > >     pointed to privileged content.  However, as we only really need t=
o
> > >     operate on the contents of the tmpdir, we can ignore symlinks.
> > > v4: fix spelling in commit message
> > >
> > > diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
> > > index 106f625f..c46db90f 100644
> > > --- a/sandbox/seunshare.c
> > > +++ b/sandbox/seunshare.c
> > > @@ -403,6 +403,66 @@ err:
> > >         return rc;
> > >  }
> > >
> > > +/*
> > > + * Recursively delete a directory.
> > > + * SAFTEY: This function will NOT follow symbolic links (AT_SYMLINK_=
NOFOLLOW).
> >
> > Spelling here too: SAFETY
> >
> > > + *         As a result, this function can be run safely on a directo=
ry owned by
> > > + *         a non-root user: symbolic links to root paths (such as /r=
oot) will
> > > + *         not be followed.
> > > + */
> > > +static bool rm_rf(int targetfd, const char *path) {
> > > +       struct stat statbuf;
> > > +
> > > +       if (fstatat(targetfd, path, &statbuf, AT_SYMLINK_NOFOLLOW) < =
0) {
> > > +               if (errno =3D=3D ENOENT) {
> > > +                       return true;
> > > +               }
> > > +               perror("fstatat");
> > > +               return false;
> > > +       }
> > > +
> > > +       if (S_ISDIR(statbuf.st_mode)) {
> > > +               const int newfd =3D openat(targetfd, path, O_RDONLY |=
 O_DIRECTORY | O_CLOEXEC);
> > > +               if (newfd < 0) {
> > > +                       perror("openat");
> > > +                       return false;
> > > +               }
> > > +
> > > +               DIR *dir =3D fdopendir(newfd);
> > > +               if (!dir) {
> > > +                       perror("fdopendir");
> > > +                       close(newfd);
> > > +                       return false;
> > > +               }
> > > +
> > > +               struct dirent *entry;
> > > +               int rc =3D true;
> > > +               while ((entry =3D readdir(dir)) !=3D NULL) {
> > > +                       if (strcmp(entry->d_name, ".") =3D=3D 0 || st=
rcmp(entry->d_name, "..") =3D=3D 0) {
> > > +                               continue;
> > > +                       }
> > > +
> > > +                       if (rm_rf(dirfd(dir), entry->d_name) !=3D 0) =
{
> > > +                               rc =3D false;
> > > +                       }
> > > +               }
> > > +
> > > +               closedir(dir);
> > > +
> > > +               if (unlinkat(targetfd, path, AT_REMOVEDIR) < 0) {
> > > +                       perror("unlinkat");
> > > +                       rc =3D false;
> > > +               }
> > > +
> > > +               return rc;
> > > +       }
> > > +       if (unlinkat(targetfd, path, 0) < 0) {
> > > +               perror("unlinkat");
> > > +               return false;
> > > +       }
> > > +       return true;
> > > +}
> > > +
> > >  /**
> > >   * Clean up runtime temporary directory.  Returns 0 if no problem wa=
s detected,
> > >   * >0 if some error was detected, but errors here are treated as non=
-fatal and
> > > @@ -428,24 +488,17 @@ static int cleanup_tmpdir(const char *tmpdir, c=
onst char *src,
> > >                 free(cmdbuf); cmdbuf =3D NULL;
> > >         }
> > >
> > > -       /* remove files from the runtime temporary directory */
> > > -       if (asprintf(&cmdbuf, "/bin/rm -r '%s/' 2>/dev/null", tmpdir)=
 =3D=3D -1) {
> > > -               fprintf(stderr, _("Out of memory\n"));
> > > -               cmdbuf =3D NULL;
> > > +       if ((uid_t)setfsuid(0) !=3D 0) {
> > > +               /* setfsuid does not return error, but this check mak=
es code checkers happy */
>
> I'm a little confused by this - further down there is a
> setfsuid(pwd->pw_uid) call which seems to suggest that we are already
> running as uid-0 at this point? If so, why do we need this setfsuid(0)
> call?

Never mind, I see it now. So just fix the earlier spelling mistake and
we'll call it done.

>
> > >                 rc++;
> > >         }
> > > -       /* this may fail if there's root-owned file left in the runti=
me tmpdir */
> > > -       if (cmdbuf && spawn_command(cmdbuf, pwd->pw_uid) !=3D 0) rc++=
;
> > > -       free(cmdbuf); cmdbuf =3D NULL;
> > >
> > > -       /* remove runtime temporary directory */
> > > -       if ((uid_t)setfsuid(0) !=3D 0) {
> > > -               /* setfsuid does not return error, but this check mak=
es code checkers happy */
> > > +       /* Recursively remove the runtime temp directory.  */
> > > +       if (!rm_rf(AT_FDCWD, tmpdir)) {
> > > +               fprintf(stderr, _("Failed to recursively remove direc=
tory %s\n"), tmpdir);
> > >                 rc++;
> > >         }
> > >
> > > -       if (pwd->pw_uid !=3D 0 && rmdir(tmpdir) =3D=3D -1)
> > > -               fprintf(stderr, _("Failed to remove directory %s: %s\=
n"), tmpdir, strerror(errno));
> > >         if ((uid_t)setfsuid(pwd->pw_uid) !=3D 0) {
> > >                 fprintf(stderr, _("unable to switch back to user afte=
r clearing tmp dir\n"));
> > >                 rc++;
> > > --
> > > 2.50.1
> > >
