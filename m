Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887A5155389
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 17:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759858988; cv=none; b=pkiTPZbGUrovcfDBzp7tLXFYmxgi7FPpnDHqKiQ4BrWBGYbFpf3K/XHzmupU36bLAXEp8W2/BydLTCd498NxbsBLPrBDwszFVY7/G5pz6FT3PpAm2/PjXg+z9AMYBAFhA2eCZwl7LUKiwr/90Vfh/kLpsoa5ksTGqcQ6Njos2u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759858988; c=relaxed/simple;
	bh=cc2K7U0fvY3+uu4HChqMpUxCAz91/REHwPe8cca28ro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s003koNjpV4QTkxOarc2G7AB8kli3DN4t3MkhCdRyGYg3M9Iv20VrORXI3O+4Hykt8Qotk/Q53PMltME+1waofepOVe3XBkkpaucXkqPXOVI6+lXMciFvvBe89Op+rslSKU6tMKs7BROPh2GKOsQnTLQ9lWnCITb4he6oWYC7dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PArdKZAE; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PArdKZAE"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-330a4d4359bso5511374a91.2
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 10:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759858984; x=1760463784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzYdcsvssHe4/+i2zNdX1uApCSflD37wc6nG+47pzQo=;
        b=PArdKZAE00U/yKzOnskD7gV97velVFHU4kbuJ0SmIz2TK42GycFW4hn5ae3TKKrOIO
         Rlpd6MlBLgvZqYlTs0e6GWrQ1RM96iflXiemhYa194JaKMnmYTGgIj1SfWqtsxL3CsOY
         Pf36a4A0WYDvupxDSgZ8iAs3RWlayu/E5ZA3OEtGU/XJV83yhBkMsPc3eYNgolSbp2Xj
         JHgOB1Rtf63CY8FYHMHoWG+kaLf+mtqn/o5hCiUSU3Wkek6FEJM8Nf0ZjNYQhoo91S9u
         pcZlM+HBYvs4E5q2Eo12rzHiI3T6XPYJJv8Mj9d12hKFwj8YYG8M+KUO9XHHMbXSzlgW
         61Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759858984; x=1760463784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzYdcsvssHe4/+i2zNdX1uApCSflD37wc6nG+47pzQo=;
        b=ed4APcd/r0LuIFhYzirpF2c7h9oP0qqN7Wwj4ZMcXNhMfIRL4AAogbf1D2Z8a3Wqvi
         OmGmS5K9l58QYRsKzAEWmP/KRf9bpXVFZ7qIvRthbQMS6FKQuS9B6sbZdR+tCq+0FiKz
         GgOGxGZi6zv2W6IhMdsRyYi0XSPXEbHQdwx+idVgEC9xBeEwe1xb+ChukhcNPl0rZFsH
         jHogVLOh3MPNrraq83ktkqDed7t1wFtvriA1Jvmz0cU6+6wtHdzXK89uPaumMKCACgCz
         MfIowcK1ZpGummpgxFomytl+tdP9c3MoVlAxvGGIsgA2LPTL2wCtCQ4OErl9s3murU8s
         Z9VA==
X-Forwarded-Encrypted: i=1; AJvYcCVCIzfsCmkMPYh8M77kn6bFob0woRDpnHnv73WTqokgXX4Z8b8D+o4s0aEguZbwtLNg0pgmKUOw@vger.kernel.org
X-Gm-Message-State: AOJu0YyOz/bOdJfK9Z46ZT0mkDhmTq76xMErkZTLNl0aDY6L0Tt4Kc/S
	+RARoUmPBy2B1R9RTWxDzqcRKo6zKkaCs3yYl4FEXFAc1uCr+2eESpNzUrMCo8NSAFhVe3azlBB
	2YGCKTUCnVqnOPFglsfUTVaaOZvpKFcc=
X-Gm-Gg: ASbGnctI6HPk0Sakiu2u4gty7BRlj4rt0xG/YPZ2/XdSGmpgH7lgSjGiUl6CP9YGjxU
	zWc3i8ETMkV8T50c0geOW4L+/cQJALyBfawYuMNs956fRo1QduB2AW3Hwl3TLLJx9mTFVewqrmw
	bieE7ryoTy5tql2SKCibjtpEKSeWOOtYJPvRvAOW3M191Y4kj4THweXGwQq0GhVJ1CKGxvLLD+C
	3W4P1Qzi8GFSZX7ax2knTp8eHUbgYURyA86S65m5g==
X-Google-Smtp-Source: AGHT+IE33RrDqdmFW7C2W2IFQnLgmbEM+7+KjTzztkrFWxQELLJT0WiPRTaqEejWybvNYPscPsNCugDDF8sDYBja2qc=
X-Received: by 2002:a17:90b:4ac9:b0:32b:9774:d340 with SMTP id
 98e67ed59e1d1-33b513ea07emr348160a91.33.1759858984399; Tue, 07 Oct 2025
 10:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DDC92OTGUZC7.OWZX9FSUWYQN@gmail.com> <20251007170608.502567-1-nvraxn@gmail.com>
In-Reply-To: <20251007170608.502567-1-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Oct 2025 13:42:52 -0400
X-Gm-Features: AS18NWDDeTq3N1Pio_i6XsiFfykTBaFuZz6MhN4uDPUyvyzLhoBWPvnm8dSKYEw
Message-ID: <CAEjxPJ5VVRnBKnL2R=Dv5jm+6=kZDn+B1L9P7cc=winxXqYJLw@mail.gmail.com>
Subject: Re: [PATCH v6] seunshare: fix the frail tmpdir cleanup
To: Rahul Sandhu <nvraxn@gmail.com>, Petr Lautrbach <lautrbach@redhat.com>
Cc: jwcart2@gmail.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 1:06=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> wrot=
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

Curiously the /tmp/.sandbox-$USER-$random directory remains after
exiting the sandbox, but this also seems to be true with the current
seunshare.
Consequently, I think this is fine as is although maybe we ought to
look into removing that too.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

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
> v6: fix the error checking for the rm_rf () function.
>
> diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
> index 106f625f..337a9205 100644
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
