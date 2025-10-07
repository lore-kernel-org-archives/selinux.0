Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F351B0437
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759860076; cv=none; b=WKLu9BbeRXYgUoCx1YB4d8a3CPUZ0CcFTQeoTFoCrbfF66nrt+WUVBI0b0C3VqFsgpRqwVy2rrO6iGxxnBK0R+tJ9Xfko6ySsdvrdwjz3jc0LQEQnnB9CeDKx1yi6qovscu1HIbcvveOMyjjNDI9rGqv0igkMKq6VqUeA8HP9qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759860076; c=relaxed/simple;
	bh=pDtOiYBY/e51w3zTc1vgqo1JJ5tmPW1XbCppOGWpxfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0/jix4bNBAGrtEwwMzm1bSI/ojRShdtY85XcEbs2lwMDgxtJRaHsLC9JTK5dLpBMVTYSMwZn3Errdo8XLAcHy1X+3p5zjL8guTYaHKDkTD4kYDVa1YWXzHssUekCQw5Qgs+P6Sg66tYAH2hShiLR7IGLztUHRwU4Q/+q/m0eIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+257oTZ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+257oTZ"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b5f2c1a7e48so4436596a12.0
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 11:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759860074; x=1760464874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbfqpesGMMY6WYM9kxBUgt53y0ZqnOID88ufo9HAoL8=;
        b=m+257oTZJC6/v7uGfYkc2xb6hFeJApgwconfB9EvqLL5yeThZ8ZADukFkv81Dn/pf3
         fMtD7PcREThuwOOjgO2WlcvJXRgESTs2l6w0MjJQYeZcCaZzo6uinLf4U7cKgROt6CaA
         9x3tREm7iBkotciNBDVQMJhKrZ77nJeP5kASrKpY5LX9gpckN/SFHOhlimC4r7iw61CS
         qqxc4UuP63tKzUpy5+8I6Ii9fZk92Yi7Z1gh54wSrgkFbf4jCNDs+zTXIePFBNw24ojB
         cY+4r+iQ5k4Oivx3x2uJyQt//lTX/LHhFN0lebo/oyDNuHvBssSj5nmagpDH9dkixafd
         CShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759860074; x=1760464874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbfqpesGMMY6WYM9kxBUgt53y0ZqnOID88ufo9HAoL8=;
        b=v5eHOBqTt1Fthnf17J/ekKCXX8+IySGk11aWEnOc8h09gp2VvMfP4gobbraeeAOfX/
         NKpyhvKMFRiCJQ5r8VFhlkvOoz6wFKOyWyco145yBXSIlt2oU5PCStgMMMi0KNH8ZJmm
         NlUJtTWTCIVplU65mHbwI2ZWQ/NAj/BED4XvxIN2ZR5XwBGpC7PBLVsTcoC/eDlmgkiD
         SOg9L/+TyWrnrRFlLD9284OCZCgZepb2+0oR2lgNb+kqfsvmjcfEDd5PRNe8JDP17FLJ
         Yie2MdQ7urif5aWfP7UN/3uHZ5qnmdfnwfoHd+hWeL29ias1iLbh6XD9mXr+2OrLPduI
         jI2A==
X-Forwarded-Encrypted: i=1; AJvYcCV8vzRl8ND4p4mxlMWTTion9tWRYUDoJDSYtdUM3JubqVnAJeEIqRkVcLGdrHA5ZueRnKEL/Thp@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0owI3zPezOAXwTx+H0ExlCA3z9YynMMmv3qzw1k8w8jrfVztI
	RJ8nkUbhdYK5Rj0sP2tqs5wFeSdT+EX5l3jixCD/vlRkt5KQFctxKG9aSIkVAvM+Ck9kw2BsK87
	/vHhxR8bwA5vmQ/46H52MiRIWc3TQ3pQ=
X-Gm-Gg: ASbGnctRSB1sbdaxluRUuVClrTr8d5gAMxwwN4UfjP6CvBIW3uIDMO54Dcuse5qdVDd
	B0m9yoj1KdnQOVesimNx413+6qmf8snhjdITipATPctW0SQi9q1DteE4gw6I4p5ViRHPbfqveL/
	HK+zgGd7DaTmnRZ/M+tnzbii/Tu4/wXO1LLFcs8sF6LkVMlLfy501fxOHfb65yoiBtJ8+/4pPrI
	C8EAx9M+JmkRtC7N44V+x6vH1Gr4ZM=
X-Google-Smtp-Source: AGHT+IFstO9YfSIQFeg1DMCq5l1vanv5rC3BOOWh23merEPuplsWZByGuKp4h+RxhrMXjQZAv5n8225oamLhWODJ5Z0=
X-Received: by 2002:a17:90b:1b4c:b0:327:9e88:7714 with SMTP id
 98e67ed59e1d1-33b513ebf89mr444158a91.37.1759860072497; Tue, 07 Oct 2025
 11:01:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DDC92OTGUZC7.OWZX9FSUWYQN@gmail.com> <20251007170608.502567-1-nvraxn@gmail.com>
 <CAEjxPJ5VVRnBKnL2R=Dv5jm+6=kZDn+B1L9P7cc=winxXqYJLw@mail.gmail.com>
In-Reply-To: <CAEjxPJ5VVRnBKnL2R=Dv5jm+6=kZDn+B1L9P7cc=winxXqYJLw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Oct 2025 14:01:00 -0400
X-Gm-Features: AS18NWC7dhkYVKSKWD-a-x7pBEjWGYQDPlIX6R8q2usStmtERhfyRXU_vF6OL3E
Message-ID: <CAEjxPJ7xRYnSgN2qauMPHT54uV5PB7z+8DO1=PPOtT68so6=4g@mail.gmail.com>
Subject: Re: [PATCH v6] seunshare: fix the frail tmpdir cleanup
To: Rahul Sandhu <nvraxn@gmail.com>, Petr Lautrbach <lautrbach@redhat.com>
Cc: jwcart2@gmail.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 1:42=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Oct 7, 2025 at 1:06=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> wr=
ote:
> >
> > For some reason, rm is invoked via system (3) to cleanup the runtime
> > temp directory.  This really isn't all that robust, *especially* given
> > that seunshare is supposed to be a security boundary.  Instead do this
> > using libc, the API designed to be used within C programs.
> >
> > Also make sure that we don't follow symbolic links; the input being
> > deleted is untrusted, and hence a malicious symbolic link may be placed
> > outside of the sandbox.
> >
> > Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
>
> Curiously the /tmp/.sandbox-$USER-$random directory remains after
> exiting the sandbox, but this also seems to be true with the current
> seunshare.
> Consequently, I think this is fine as is although maybe we ought to
> look into removing that too.
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Oops, missing #include <stdbool.h>, broke CI,
https://github.com/SELinuxProject/selinux/actions/runs/18321378627/job/5217=
5025361?pr=3D496#logs

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
> > v6: fix the error checking for the rm_rf () function.
> >
> > diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
> > index 106f625f..337a9205 100644
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
> > +                       if (!rm_rf(dirfd(dir), entry->d_name)) {
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
