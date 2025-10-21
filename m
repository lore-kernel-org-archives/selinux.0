Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8CF334C38
	for <selinux@vger.kernel.org>; Tue, 21 Oct 2025 12:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051584; cv=none; b=d68I5XOPOmTZqZw8pR1jnMKAGYzZjVLnZzOxSum9ww7z8c0h8/BvdHE59beFkBokcfOvYpDKHKzC13gzP4Pu2k6TfBHtTuP5AdEwhJ0gtpjascW519bWiHLOtkpXediLa2HdeeRLn+M0EE6tP+qKtsI07WFI0XjvldxIP+APIWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051584; c=relaxed/simple;
	bh=/p+HgR3jic0vaW33oVFFcwkYd4QS/6dl17XZeRGVpzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xsf36TeXOHHPZbc0/IL3c1c66oWGDRc1P480t+3kg/7fFv79/TKOGrSv+DfWVVVDJqhULGWdcTA/Xw7DOdgJezZC27AyXH3AKT7d7IuOsmcKoVqaX3k/vByLHilWJRR9Pqqt2LoLijXZ8hMS0/eEjl7w9Uaf1I+MJA6vZDOSZ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auvr6gzM; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auvr6gzM"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33ba5d8f3bfso4860018a91.3
        for <selinux@vger.kernel.org>; Tue, 21 Oct 2025 05:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761051582; x=1761656382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnjs5HLXRntrXc8jqDCnWXhI3O4BYXlR37R4X7p/hic=;
        b=auvr6gzMi5eSj2lPQ/zLzitADpzm5UGdvsvr/m/BNWP+MIfUWkCIGodc878JL4+oJB
         BVe7J6dcjRpcrCAaCCbTFH0Ya0yR82KUpjQ8YvBdZZBq9c/lmBP1R5E7UuAuarKt4Row
         F4fCb4PPiKxb+DxMn7uUBPd94BDsQa3oQaupTIwxG536967Hp33pLmCpVbwfZB2XSs8u
         zsMjgK9KpXmh/xCd01KesCF5mQ//c4RsNCD/3Z/d/g61SaKOeg5zuX1zZzzZ4N6etJxe
         svDDgJ6BHwKGSTXm9cJY8tNzzihvCMrtwrUjETiv/QpapHMwTWzq3MQ52gGFKpM314xJ
         fPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051582; x=1761656382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnjs5HLXRntrXc8jqDCnWXhI3O4BYXlR37R4X7p/hic=;
        b=qdyPIJU1G1yZgp1fyjb7SOkFXMERS+xkHjS2r+zDNBxUmEeFfmByBd05Dkzai7sYE5
         cyrQyacnLUEA28p9spGA9bOtSquR/F/eUyRcClSDheIrXkiSxSQRa92TIRAVZ82KXs7p
         SoVtjFwrKsB5de8/si2S+Gs7Nqjdv3+0siKSS4HnTWIvO3QNpK2C8a0HtxaYTlbObY/J
         e4uJyGg6ow7zDFzT1RdRwGYgSBTYHJGIfjPv13vAREGvrApoi3D8HeFta6Hr17ZqelkH
         aGqH9yY85LMEGyoUDh4d/q5GB2mjWQCMgwusde0hhZh4x4c9S2RGz32+Cbcisk/ic2Xv
         9hlg==
X-Gm-Message-State: AOJu0YzkKN6CVyk0CH/mNM8MVecyh8f1qBWsb/FUnpdrBpeORn2DIjQ2
	yvry7gCQ8SfEUMyPbl5a/0ARg0f7BO3exvhhQfJSj/yvIMoKUgwuARY1Zyv22cuKQ/uMjGdX995
	hG8htLnKdKWH7HEZSY1OlTuFNHoURRFE=
X-Gm-Gg: ASbGncsl8RkJDXQY/JaRPc7WHirKLtp/awjKSaGeee/kuuYW7g2N6Th0Mq7AkzQA5bx
	zTwoOwLWLtxeO4aObQ/Ro0HmLS1k5/E4Uj8ROQFu4qjBhVoUQo+qwHbz2bdRtOCMODaClbu1zQz
	77c16cu+cjn9DUXjYSJYMK67pOFWB7pFMHRrYrzG1YwNr8U0pYKDzxJeyDOtXjTW+1vGMcYmAS8
	dYS/XP3n0IfQpiNVf9HfzfesLHZhOjiXAcZKwiNxwTGaPCVBehwRqIffaB9
X-Google-Smtp-Source: AGHT+IGwP501xpAkJwxEgbk+ygNEbzIlvQShLmM7P1Qv/msLmpndMyTlRic9mwGqAiP0YVPylwykBHyd4H9GY0WuJcg=
X-Received: by 2002:a17:90b:5383:b0:33b:b0d6:6bc2 with SMTP id
 98e67ed59e1d1-33bcf90923amr19809068a91.30.1761051582040; Tue, 21 Oct 2025
 05:59:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ7VktYWYreg4PMUSTeoxRvBBoD0HVb1bsXdsach+j7PyA@mail.gmail.com>
 <20251020174027.11343-1-nvraxn@gmail.com>
In-Reply-To: <20251020174027.11343-1-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Oct 2025 08:59:31 -0400
X-Gm-Features: AS18NWDp0MnU-hJbbklS8tausxfFeLymAoiqG73JX7ot12Nlzrtx7fKLsv7tSZM
Message-ID: <CAEjxPJ5Qab+=YSVNFhjHxGrzb983XtqzKoTi5avbYQ9w6t+a9w@mail.gmail.com>
Subject: Re: [PATCH v2] libsemanage: semanage_store: recursively create SEMANAGE_ROOT
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 1:42=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> wro=
te:
>
> In package build/install environments, when semodule(8) is passed the
> `--path` option, it is expected that it creates the entire directory
> tree for the policy root.
>
> Some package managers warn or error if permissions do not align between
> the tree on the existing system and the build environment about to be
> merged. To make sure this is a non-issue, create the tree of the policy
> root with 0755 permissions (in line with standards for `/var/lib`) and
> then chmod the final path to the more restrictive 0700 permissions. As
> the contents being placed in the policy root are security sensitive,
> error instead of warning if we fail to chown the policy root to 0700.
>
> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libsemanage/src/semanage_store.c | 59 ++++++++++++++++++++++++++++----
>  1 file changed, 53 insertions(+), 6 deletions(-)
>
> v2: fix-up buffer length check, use memcpy instead of strncpy: we check
>     the size already.
>
> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_=
store.c
> index 1731c5e8..e3048c08 100644
> --- a/libsemanage/src/semanage_store.c
> +++ b/libsemanage/src/semanage_store.c
> @@ -491,6 +491,45 @@ char *semanage_conf_path(void)
>         return semanage_conf;
>  }
>
> +/* Recursively create a directory from a path string.
> + * Returns 0 on success, -errno on failure.
> + */
> +static int mkdir_recursive(const char *path, mode_t mode)
> +{
> +       if (!path || !*path) {
> +               return -EINVAL;
> +       }
> +
> +       char path_buffer[PATH_MAX] =3D {0};
> +       size_t len =3D strlen(path);
> +       /* + 1 for nullterm.  */
> +       if (len + 1 > sizeof(path_buffer)) {
> +               return -ENAMETOOLONG;
> +       }
> +
> +       /* + 1 for nullterm.  */
> +       memcpy(path_buffer, path, len + 1);
> +
> +       /* trim possible trailing slashes, except if '/' is the entire pa=
th.  */
> +       while (len > 1 && path_buffer[len - 1] =3D=3D '/') {
> +               path_buffer[--len] =3D '\0';
> +       }
> +
> +       for (char *pos =3D path_buffer + 1, *slash; (slash =3D strchr(pos=
, '/')); pos =3D slash + 1) {
> +               *slash =3D '\0';
> +               if (mkdir(path_buffer, mode) !=3D 0 && errno !=3D EEXIST)=
 {
> +                       return -errno;
> +               }
> +               *slash =3D '/';
> +       }
> +
> +       if (mkdir(path_buffer, mode) !=3D 0 && errno !=3D EEXIST) {
> +               return -errno;
> +       }
> +
> +       return 0;
> +}
> +
>  /**************** functions that create module store ***************/
>
>  /* Check that the semanage store exists.  If 'create' is non-zero then
> @@ -506,14 +545,20 @@ int semanage_create_store(semanage_handle_t * sh, i=
nt create)
>
>         if (stat(path, &sb) =3D=3D -1) {
>                 if (errno =3D=3D ENOENT && create) {
> -                       mask =3D umask(0077);
> -                       if (mkdir(path, S_IRWXU) =3D=3D -1) {
> -                               umask(mask);
> -                               ERR(sh, "Could not create module store at=
 %s.",
> -                                   path);
> +                       /* First we create directories recursively with s=
tandard permissions so that
> +                          we don't screw up ownership of toplevel dirs s=
uch as `/var` in pkgmgr
> +                          environments.  */
> +                       const int r =3D mkdir_recursive(path, (mode_t)075=
5);
> +                       if (r !=3D 0) {
> +                               ERR(sh, "Could not create module store at=
 %s: %s.", path, strerror(-r));
> +                               return -2;
> +                       }
> +                       /* Now that we've created the directory tree, we =
set the permissions of the
> +                          target path to 0700. */
> +                       if (chmod(path, (mode_t)0700) !=3D 0) {
> +                               ERR(sh, "Failed to chown module store at =
%s: %s.", path, strerror(errno));
>                                 return -2;
>                         }
> -                       umask(mask);
>                 } else {
>                         if (create)
>                                 ERR(sh,
> @@ -529,6 +574,8 @@ int semanage_create_store(semanage_handle_t * sh, int=
 create)
>                         return -1;
>                 }
>         }
> +       /* We no longer need to use mkdir_recursive at this point: the to=
plevel
> +          directory hierarchy has been created by now.  */
>         path =3D semanage_path(SEMANAGE_ACTIVE, SEMANAGE_TOPLEVEL);
>         if (stat(path, &sb) =3D=3D -1) {
>                 if (errno =3D=3D ENOENT && create) {
> --
> 2.51.0
>
