Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D275EC433EF
	for <selinux@archiver.kernel.org>; Thu, 12 May 2022 17:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357130AbiELRkC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 May 2022 13:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357146AbiELRj4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 May 2022 13:39:56 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E7126C4E5
        for <selinux@vger.kernel.org>; Thu, 12 May 2022 10:39:55 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id j12so7308051oie.1
        for <selinux@vger.kernel.org>; Thu, 12 May 2022 10:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ySZVvUjfoqfm/uhx9e/C+zyuF4m2BtnlNAHCxh4ZZ7E=;
        b=clAH0/TMGUja7iq/HIV1OFFcCFP8PqBCNyexxY9/YlvILlmMo1wY4G8d/PLjaMux+3
         cQ8rZsWVNffq2HjMQenaE4tbG+Om3RbPtxpkbqIDTz+kf0FJdDLufTrbRoyFKjTWysCT
         X5DPdKDSzJcsBiRxOvTC5cYH0vrGLEqvJOuTldF8dPp+8YuPCsErcXaRaN7DwaWpwRbU
         KfllgvizVApNbH2mtSRLWmaVCfbXVb05Z2jXra3HKrTTGQ2Vgi7BWLcHcnbKe6ZDmS8l
         rEial/Ep+uGMRn97F4IdfiOWcl9P6R6+1SUfqr+pamB3gofAaDJ3O4pNMl6e0KvfjjQy
         9tSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ySZVvUjfoqfm/uhx9e/C+zyuF4m2BtnlNAHCxh4ZZ7E=;
        b=NupZvJjdm8KwFkBT1mWiWoWoSLMR4kCD74/XRwgA2uBU6N6eqpooTw+QQvIcxs1JKO
         4zltB28MeJvWga7Wox1Da5VMFdJbIZ5VbUmLfayh/MwxTxEVfgXG0e2GDfmqu0wZ3xsE
         1t8PywJfvyEbXRMa7oVFJYKpdTSfiUEc6nOr53SXy6dnxmMz2PC6h1gLTM+FRnJIkH1V
         rsI/uah/aLtmll/GAsn1iu2mvLRLv2sL8Fg9JocfeKme5TiBVd5WVZm4pnYErqwO0KVZ
         qwZZpOuuJXh+WwgjOxgM0HDDaa5tElCMT8L7G7njZvK0WTjwGKwAmt+JjOchDyAd5e3+
         3eqQ==
X-Gm-Message-State: AOAM530aG9PcdyOiCeojB0qNCWUtys9hCk17Y/Oc6OJH+vijmYHzr0HH
        cE1yn9HQtArcjBsb75omxXoQtruoKeV5+/Zr4Bi537kPDRw=
X-Google-Smtp-Source: ABdhPJxG4U6KkPz6zKjm9/1T2+U1yoO7+ynhL8zht9/mLFAftU5CWF4luUcSsOqfEKOB+5y5yhD+XcnNZ444+y72Qqs=
X-Received: by 2002:a05:6808:2082:b0:326:9857:840b with SMTP id
 s2-20020a056808208200b003269857840bmr521600oiw.182.1652377194413; Thu, 12 May
 2022 10:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220505174420.24537-1-cgzones@googlemail.com>
 <20220511184225.218062-1-cgzones@googlemail.com> <20220511184225.218062-3-cgzones@googlemail.com>
In-Reply-To: <20220511184225.218062-3-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 12 May 2022 13:39:43 -0400
Message-ID: <CAP+JOzQYsC_n=vx=iv6xze0Lk3A1UPVkLqM3EFtytSTLjzxa-Q@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] libselinux: restorecon: pin file to avoid TOCTOU issues
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 11, 2022 at 3:32 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Pin the file to operate on in restorecon_sb() to prevent symlink attacks
> in between the label database lookup, the current context query and the
> final context write.  Also don't use the file information from
> fts_read(3), which might also be out of sync.
>
> Due to querying file information twice, one in fts_read(3) needed for
> the cross device check and one on the pinned file descriptor for the
> database lookup, there is a slight slowdown:
>
>     [current]
>     Time (mean =C2=B1 =CF=83):     14.456 s =C2=B1  0.306 s    [User: 45.=
863 s, System: 4.463 s]
>     Range (min =E2=80=A6 max):   14.275 s =E2=80=A6 15.294 s    10 runs
>
>     [changed]
>     Time (mean =C2=B1 =CF=83):     15.843 s =C2=B1  0.045 s    [User: 46.=
274 s, System: 9.495 s]
>     Range (min =E2=80=A6 max):   15.787 s =E2=80=A6 15.916 s    10 runs
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/selinux_restorecon.c | 43 +++++++++++++++++------------
>  1 file changed, 25 insertions(+), 18 deletions(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index 42ef30cb..12b85101 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -621,13 +621,13 @@ out:
>         return rc;
>  }
>
> -static int restorecon_sb(const char *pathname, const struct stat *sb,
> -                           struct rest_flags *flags, bool first)
> +static int restorecon_sb(const char *pathname, struct rest_flags *flags,=
 bool first)
>  {
>         char *newcon =3D NULL;
>         char *curcon =3D NULL;
>         char *newtypecon =3D NULL;
> -       int rc;
> +       int fd =3D -1, rc;
> +       struct stat stat_buf;
>         bool updated =3D false;
>         const char *lookup_path =3D pathname;
>         float pc;
> @@ -642,13 +642,21 @@ static int restorecon_sb(const char *pathname, cons=
t struct stat *sb,
>                 lookup_path +=3D rootpathlen;
>         }
>
> +       fd =3D open(pathname, O_PATH | O_NOFOLLOW | O_EXCL);
> +       if (fd < 0)
> +               goto err;
> +
> +       rc =3D fstat(fd, &stat_buf);
> +       if (rc < 0)
> +               goto err;
> +
>         if (rootpath !=3D NULL && lookup_path[0] =3D=3D '\0')
>                 /* this is actually the root dir of the alt root. */
>                 rc =3D selabel_lookup_raw(fc_sehandle, &newcon, "/",
> -                                                   sb->st_mode);
> +                                                   stat_buf.st_mode);
>         else
>                 rc =3D selabel_lookup_raw(fc_sehandle, &newcon, lookup_pa=
th,
> -                                                   sb->st_mode);
> +                                                   stat_buf.st_mode);
>
>         if (rc < 0) {
>                 if (errno =3D=3D ENOENT) {
> @@ -657,10 +665,10 @@ static int restorecon_sb(const char *pathname, cons=
t struct stat *sb,
>                                             "Warning no default label for=
 %s\n",
>                                             lookup_path);
>
> -                       return 0; /* no match, but not an error */
> +                       goto out; /* no match, but not an error */
>                 }
>
> -               return -1;
> +               goto err;
>         }
>
>         if (flags->progress) {
> @@ -680,19 +688,17 @@ static int restorecon_sb(const char *pathname, cons=
t struct stat *sb,
>         }
>
>         if (flags->add_assoc) {
> -               rc =3D filespec_add(sb->st_ino, newcon, pathname, flags);
> +               rc =3D filespec_add(stat_buf.st_ino, newcon, pathname, fl=
ags);
>
>                 if (rc < 0) {
>                         selinux_log(SELINUX_ERROR,
>                                     "filespec_add error: %s\n", pathname)=
;
> -                       freecon(newcon);
> -                       return -1;
> +                       goto out1;
>                 }
>
>                 if (rc > 0) {
>                         /* Already an association and it took precedence.=
 */
> -                       freecon(newcon);
> -                       return 0;
> +                       goto out;
>                 }
>         }
>
> @@ -700,7 +706,7 @@ static int restorecon_sb(const char *pathname, const =
struct stat *sb,
>                 selinux_log(SELINUX_INFO, "%s matched by %s\n",
>                             pathname, newcon);
>
> -       if (lgetfilecon_raw(pathname, &curcon) < 0) {
> +       if (fgetfilecon_raw(fd, &curcon) < 0) {
>                 if (errno !=3D ENODATA)
>                         goto err;
>
> @@ -733,7 +739,7 @@ static int restorecon_sb(const char *pathname, const =
struct stat *sb,
>                 }
>
>                 if (!flags->nochange) {
> -                       if (lsetfilecon(pathname, newcon) < 0)
> +                       if (fsetfilecon(fd, newcon) < 0)
>                                 goto err;
>                         updated =3D true;
>                 }
> @@ -758,6 +764,8 @@ static int restorecon_sb(const char *pathname, const =
struct stat *sb,
>  out:
>         rc =3D 0;
>  out1:
> +       if (fd >=3D 0)
> +               close(fd);
>         freecon(curcon);
>         freecon(newcon);
>         return rc;
> @@ -855,7 +863,6 @@ static void *selinux_restorecon_thread(void *arg)
>         FTSENT *ftsent;
>         int error;
>         char ent_path[PATH_MAX];
> -       struct stat ent_st;
>         bool first =3D false;
>
>         if (state->parallel)
> @@ -953,11 +960,11 @@ loop_body:
>                         /* fall through */
>                 default:
>                         strcpy(ent_path, ftsent->fts_path);
> -                       ent_st =3D *ftsent->fts_statp;
> +
>                         if (state->parallel)
>                                 pthread_mutex_unlock(&state->mutex);
>
> -                       error =3D restorecon_sb(ent_path, &ent_st, &state=
->flags,
> +                       error =3D restorecon_sb(ent_path, &state->flags,
>                                               first);
>
>                         if (state->parallel) {
> @@ -1153,7 +1160,7 @@ static int selinux_restorecon_common(const char *pa=
thname_orig,
>                         goto cleanup;
>                 }
>
> -               error =3D restorecon_sb(pathname, &sb, &state.flags, true=
);
> +               error =3D restorecon_sb(pathname, &state.flags, true);
>                 goto cleanup;
>         }
>
> --
> 2.36.1
>
