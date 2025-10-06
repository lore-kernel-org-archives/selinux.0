Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9462DE6F9
	for <selinux@vger.kernel.org>; Mon,  6 Oct 2025 16:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759768322; cv=none; b=Oxw1J5P0kG1UH1X5ZQwgUVHZBoRqNN2KQsiwPpeYFcd9XtHur10h6aA8IhONUVafFIO+/bqswj9t2H5LkZhbSyaQDFBvYyeyZvuaCrbplBE3k+YvmHYIZ8jwfuHvgY30MyD28n5tfLyNUTf06Eu6iwWDy3Ygc/u4Co2OOz6GTHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759768322; c=relaxed/simple;
	bh=6xsi0rjePtg5W9DA2RbEtwgIyTCpbzTt8g0EdLO0TFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SnAtNJNXvFjNZb2X0LicXNcKa6F1+YOgTTsSHB+pJmIIlCd0HZQsKLHMA3J56p4PkmbMAmQsPDsJ2EIAvqkMj5XGPd8nFYDgtRWQiocrhyTpl0cMFFtfe+ACrXgo2C0X4HAM/wnyzZ2OW+lJrdP9YBS0ejhRIlw6WX+lX1Gdx9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1k6KH6T; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1k6KH6T"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3324523dfb2so4610007a91.0
        for <selinux@vger.kernel.org>; Mon, 06 Oct 2025 09:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759768320; x=1760373120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ej/B5YlhzPmvS+w+/nIeAw9zP85tzYsUWky5XysJ6uU=;
        b=h1k6KH6Tu1YZJ5iRKpxIS5jXcsZ5wto+aJS5NJiJc+N4BybXgZh3pZEzaun0yLNoCh
         YpmrUa9jXWNe3fdr1ssbIzSxLdbpqvGxlMzdngWu/5v3rAqmYevOg4dqzL3gybsNZ7Zz
         vMngRS+VNB2PPZ60XGAdV2AjvEIkRQegyiYL5dRM+KtOLcmyaeJ/cXh0HCyyfihX4X80
         UWxJS/cRtSFUbZp/izVmz3is4CEP7r2g7Cf/P2zcqvjtWmADAym5YfLYNxygtN/YyjhW
         8g5fqag4ISuGAWaRATwweh/GVR9XPFc1zhZJ61SFk9RR6UjyYOIDcyuhTYqwq4Flm2AX
         25cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759768320; x=1760373120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ej/B5YlhzPmvS+w+/nIeAw9zP85tzYsUWky5XysJ6uU=;
        b=eD8pEx/pMGzMAyxvHXYIyrlq18EDbkliPIv57Pd5sk6HrM/16683k4ZvrBNLjpMWCt
         3LxEtNSPc/cdzMnduvJFFeEWZSM/HFCQ/C4QYARHu+ohdOAPth2P5D6IDdO2KUNb+anT
         9nQ3PnxY2mChXimzrNnSxVN6NQUprsW0evpsDDnH7o0YP5QjaC8sYymQW26vTy42oZYb
         1C5V/51kKr3RLBujuUkdlyBpGrWx0+DkMj5nxWPpP4NBXY/zeemOBotG2WuTlCr4GFO+
         vzwqMGK9OiAfhwdxqLaXLOxlZqNcvmWH7v/6PppX58MoqfkPfr95fyTrXH/o2gHVWu/4
         zcJg==
X-Forwarded-Encrypted: i=1; AJvYcCWQTGdbYrcnxR2Z7QTvvnIVx/p7gobuqrtMEKDsOpZA7AzT24zr6JOb2B1ldHflJAlt4tQtCigB@vger.kernel.org
X-Gm-Message-State: AOJu0YyW10e7SW5yPgF6SdxII1QtZZST7gcfMkJmvqGX6fXhOXdEj82U
	abS/ab7vPiH1xOwkGvkbyzTM+aP5vBiGwnuXphPZHgzubJTIMsPVv/pd9XUmVIDMPfKP2tT+Bfj
	99L/LoW8j/nUyVz1B37TtsNRlpqv5hzQ=
X-Gm-Gg: ASbGnctLNLUEYMOHcTZeq2WF97C1Ks8jCYzgJMTK6qlErmp+U1p14O04irMYZy6jcrl
	klfWIwl1dnAPWVTUkecB8g213s9wabOJh6j98FbzEPv3gsAMIY3mO35LkT+uI+gso+JDeRItLPJ
	vTCPtF8eE+bR2He7uMYz2cUrNXeqzhrCACU7sDO4LOGY+4KCK8tnMfLIBH48WemmVg0UK/6ntct
	cBBaTYOK+Ehn/cyjKFPllnWPh3ouvoVXUwGyKzXfQ==
X-Google-Smtp-Source: AGHT+IFJ7BHpc4h1hFkDI7MMBXWLXM0+7ywaLhqD2AS2EOUYpbEFSnGVmifjW+Rnc/f7NfRf3vf8kPXzPwP8Kf9L0Kg=
X-Received: by 2002:a17:90b:33c7:b0:32e:64ca:e84e with SMTP id
 98e67ed59e1d1-339c27351dfmr17904523a91.15.1759768320237; Mon, 06 Oct 2025
 09:32:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP+JOzRkLMewUzpbdeQZDx7gR=t4eMysQkThxgBr8sfoaB-f7w@mail.gmail.com>
 <20250925053816.904674-1-nvraxn@gmail.com> <CAEjxPJ6S0o_Rmzt4nd+0jE0mHVP0sp-DA+=QrvJP5XjnAwTVSw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6S0o_Rmzt4nd+0jE0mHVP0sp-DA+=QrvJP5XjnAwTVSw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 6 Oct 2025 12:31:49 -0400
X-Gm-Features: AS18NWBUAxHZ8gdKJRruM3VwOrCJZ0auAgisPqmnksI_aKPrPk4GHPu_OdJFcV4
Message-ID: <CAEjxPJ6NsHyLwF2PeUTmm6noxoMcB+v2eBQjsVff5iyDyhvkCQ@mail.gmail.com>
Subject: Re: [PATCH v4] seunshare: fix the frail tmpdir cleanup
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: jwcart2@gmail.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 11:57=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Sep 25, 2025 at 1:38=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> w=
rote:
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
>
> I think this was for security/safety reasons, to prevent unlinking any
> files linked from the tmpdir that weren't actually owned by the user.
> However, in theory, your rewrite makes that obsolete.
>
> >
> > This doesn't really make all that much sense as far as I can tell.  We
> > should be the only ones using the tmpdir, so we may as well just delete
> > the entire thing using the rm_rf () function with elevated permissions.
> >
> > Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
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
> >
> > diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
> > index 106f625f..c46db90f 100644
> > --- a/sandbox/seunshare.c
> > +++ b/sandbox/seunshare.c
> > @@ -403,6 +403,66 @@ err:
> >         return rc;
> >  }
> >
> > +/*
> > + * Recursively delete a directory.
> > + * SAFTEY: This function will NOT follow symbolic links (AT_SYMLINK_NO=
FOLLOW).
>
> Spelling here too: SAFETY
>
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

I'm a little confused by this - further down there is a
setfsuid(pwd->pw_uid) call which seems to suggest that we are already
running as uid-0 at this point? If so, why do we need this setfsuid(0)
call?

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
