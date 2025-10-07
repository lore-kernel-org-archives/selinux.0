Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306582E9EC9
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 18:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759861256; cv=none; b=qiRO527TCqUu5Qe/2ywWq38fJJGHaPRTNHTKM4Uq4o3up0OAdiYAEqhqk4U9LHtV+Pc3/Bu+57a+Rvl4ASgKikzCNXdGVpB7pVovqLWidPR0ZTdVRG2BQrs8cIDOReONPudlZLgVf6AeUu8gQlHREXM4sh6s0tq0UpdGdW4U+Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759861256; c=relaxed/simple;
	bh=5MLv1a2DnUYMXvBBUzqSMIq23Mo5X0LvqgGL+gd2aUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRUHoMHYXPl69nAxc2DTo5oRnCM5LstXOembUvbjLzwKmDDSFKhPxgXnjZUdE//yhps3OsXuFdAca1a3C2P2NKrFgw5Tg0mGX9D1Tb26Xv+OjZ/skyB/J2XA5jGeUDTIMqGsNMq4WOFfzkueLHNbSrPLbs0vsHilM21vc9lugxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EavEA1cP; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EavEA1cP"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3306eb96da1so5477928a91.1
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 11:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759861254; x=1760466054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFOfFmxz2/B0vN24GlED5YoXKd3mSXZMj4p1bSTqSJk=;
        b=EavEA1cPYTQ/DXha0EKegndtFZExFa93uU7Y7nwXcBS/YNgLAxBpLxkjULfPVZd2Ip
         VjJJKVNECYgA6gZ//XS7OFZvU5P3/2s/CH2/YQVMKP9tqAlW9NPA0XDLYf6aRwkaUwW1
         iiXJL/Gy8kFzJRyLCyP7OXb9470t+bxRnhDk9uOxrQrEO2VJZn9flkT7mjHFqVjpP8pZ
         ahDN5dNE9/z/ndL/u7SkO5jM/AddcMGcAnmBIKd+J5rKICQrQGdr320yp1BzRlwWBHVc
         T1mEEe/Eegt97OkYENNXF1zryWv17NycQaUhVeiHhZAJwRmV/4/hLTf7K9MY389JTf0Z
         Rq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759861254; x=1760466054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFOfFmxz2/B0vN24GlED5YoXKd3mSXZMj4p1bSTqSJk=;
        b=vXwIDlP0DcoPFcrslFSCxLkunPzN8flL8+NEt4ty6dk16C9Nb49LsZ0OXQMBRwnzoR
         glUNDLR0fAnbJ45BTZ+2qRDt6V/Uqw0SLltQlwgCTgux/zwL/LM9PCvU7QjmHL/4nVN5
         fnJbb0NHxqbgH10ypG5L8RlmcBEv38qpUMQwlWbABko3DxVtM/WOY0T0uln/j5oPItUu
         jylC+w1Y1COiQ9cLlqHapJH3kF8FKu+07mJnHPK++Oe6O4u8R389X3qZxLVavekh0lSB
         o0DOHXMYXxDtig/90jpdPCSdYeHiYMgeEmChYQPeNjlSKbho5YTkgJLu8J4x+ePTSpsy
         oQNA==
X-Forwarded-Encrypted: i=1; AJvYcCX1fzbbCKh+/mQwIYQbStKBSoGJ9eQezlS43+PcTksHpTUnB+INa0f+mj+NrVi3OgBOUMOKSSsX@vger.kernel.org
X-Gm-Message-State: AOJu0YxOv2B9F4A1Ozkm5dLmMdKMr62JrJNZBjchM8d5U0dqxeYpPYxy
	RgoaTutDa5tcKx3KRQQ5+gILQDrDtdjTeagDhaAO2frV11dsR1Ibbj/J3byRz7mfRygj3UZDzCZ
	Gs2U6O87rqA97E6D1MHS5SbhQDZW5pyA=
X-Gm-Gg: ASbGncuz+uwXyCr6dUe7o5sD6EBNqicaUPeB/0umu5y/8fD/Pf6+ykE/cPntw+KHyXW
	gSAFl7BELJRLdYPdY60L626uUlgBygG7eBB0XKFe0dSy0JJWaTuQZHruy1XDDlcbd+ZURbPhHrI
	Af7Mp0YfhPs9Hfq5l8LS81KDQ0SzhudStcVQs17sUHgdlNlXtWqhTvniWiZxuJXR73nw/Ccd0R2
	lslYymZr/4CckfmPF6XZBQakfqby+Y=
X-Google-Smtp-Source: AGHT+IGfyOXSS6GCOH3UTNQj3Cd4ggpSraBp94Zr/4fe5F2QmLcYJNf4A6s86qMH5ycrX1h+l5PeddCrptirFxr0Z18=
X-Received: by 2002:a17:90b:3b43:b0:330:7a32:3290 with SMTP id
 98e67ed59e1d1-33b513b4de7mr554458a91.37.1759861252991; Tue, 07 Oct 2025
 11:20:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ7xRYnSgN2qauMPHT54uV5PB7z+8DO1=PPOtT68so6=4g@mail.gmail.com>
 <20251007180906.507115-1-nvraxn@gmail.com>
In-Reply-To: <20251007180906.507115-1-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Oct 2025 14:20:41 -0400
X-Gm-Features: AS18NWDgPMz9OeY2OWm-NiN2VVs3YLp_UWbYY7iiFG8cWHNgvsYPs8StcwC2iow
Message-ID: <CAEjxPJ6rpJNpFviGHDiJsx_A_APdMTOS9Nyr0mcfT5YCWUtfvQ@mail.gmail.com>
Subject: Re: [PATCH v7] seunshare: fix the frail tmpdir cleanup
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: jwcart2@gmail.com, lautrbach@redhat.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 2:09=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> wrot=
e:
>
> For some reason, rm is invoked via system (3) to cleanup the runtime
> temp directory.  This really isn't all that robust, *especially* given
> that seunshare is supposed to be a security boundary.  Instead do this
> using libc, the API designed to be used within C programs.
>
> Also make sure that we don't follow symbolic links; the input being
> deleted is untrusted, and hence a malicious symbolic link may be placed
> outside of the sandbox.
>
> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>

7th time's the charm ;)

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  sandbox/seunshare.c | 78 ++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 66 insertions(+), 12 deletions(-)
>
> v2: don't use else after return
> v3: don't follow symlinks in rm_rf ().  This is pretty important as we
>     we are operating on an untrusted directory, which may have symlinks
>     pointed to privileged content.  However, as we only really need to
>     operate on the contents of the tmpdir, we can ignore symlinks.
> v4: fix spelling in commit message
> v5: fix spelling in comment
> v6: fix the error checking for the rm_rf () function.
> v7: include stdbool.h
>
> diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
> index 106f625f..01ed9d8e 100644
> --- a/sandbox/seunshare.c
> +++ b/sandbox/seunshare.c
> @@ -4,6 +4,7 @@
>   */
>
>  #define _GNU_SOURCE
> +#include <stdbool.h>
>  #include <signal.h>
>  #include <sys/fsuid.h>
>  #include <sys/stat.h>
> @@ -403,6 +404,66 @@ err:
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
> +                       if (!rm_rf(dirfd(dir), entry->d_name)) {
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
> @@ -428,24 +489,17 @@ static int cleanup_tmpdir(const char *tmpdir, const=
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
