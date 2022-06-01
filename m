Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7D1C43334
	for <selinux@archiver.kernel.org>; Wed,  1 Jun 2022 18:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240794AbiFASOQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Jun 2022 14:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiFASOP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Jun 2022 14:14:15 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86738880DC
        for <selinux@vger.kernel.org>; Wed,  1 Jun 2022 11:14:14 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id s188so3694670oie.4
        for <selinux@vger.kernel.org>; Wed, 01 Jun 2022 11:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tJrdc8tXiR7WnlhHOK2UeGfZ9MeVdfg3v3Z1sCy1u2M=;
        b=TNmm5l3JopMn9ahJkwHfkeU4UrxBTQMJwxp/ya58hgqL7j+Ko0PZO42AJ1HfAXoLtE
         c54NFaT4+Tz8PY2MNv2j8wQTKxgAkYgoPFI7zxUAM0Sn0Oh1fpdpsgWZXmAEGHAm0eeP
         hiEAEB/aHhvyFCscnkwBYCo2OBHO/dYKctPTiQBtPwA80HeimZeyePCeRLceuOrKKvz/
         fJ/tkNnUrc2xF2G03uv0JwjSa6GgAyciqJ4rMzBMXKOihHwTLYzbR5ueL7uTzw1lqiYK
         dLZrx8r6Y3d9M4s3HiDjAmmWtLLMbuuTAcsId+JiDZv4FD4rUbxGBdLHOCnDchE7L48U
         CXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tJrdc8tXiR7WnlhHOK2UeGfZ9MeVdfg3v3Z1sCy1u2M=;
        b=uj9l888g2OJR88GtolcUNVomRaZSt9hl1VJn+bRDv554OWo0WlpR/DqH8Arw0cxDbl
         LprUiJtjiJ1xg9D15NdXtKMiVheaLfEjlJUTmWfuIwYxA9D682cTKaVXVvxRLx3pSPoe
         q3+DfbazlYHwBeHrEMsPMFJncLUXNwLlpBjIDL+cFaezFbiPbiWqS0sLggpgAvQvtGMf
         L0OBld9Fz3qEDJV6Aek/wyO6Yjcx0Q7yrrI2oyCDBuIPY9LQi6oH/OtKpxBHxsQUlqGs
         pMiVBTtOMmos9dmusXWq6GBJhUMFJZD22NGDltXVl5xvh8r2OOgB83gWcg1EciPhXNq/
         jHdA==
X-Gm-Message-State: AOAM5336dMUcIUVfBGO5ijQOswb/Uc1bmWZtwgOFUcm9XLBfu9YkmzD6
        g/du78l/GHoFazjacU5lEPSaWVePL8fX0kMZS29CXR2kxXo=
X-Google-Smtp-Source: ABdhPJwBU7GYhjRNbBF7xBnzt/54C5Ezji/uZuXv1xspvjPmliiHBiEC/LdXpXPMR8D3kMreIch64+GN8aLsr+pbKT8=
X-Received: by 2002:a05:6808:ec5:b0:2f9:a7fb:4dfb with SMTP id
 q5-20020a0568080ec500b002f9a7fb4dfbmr16238520oiv.156.1654107253901; Wed, 01
 Jun 2022 11:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220531125750.278211-1-plautrba@redhat.com>
In-Reply-To: <20220531125750.278211-1-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 1 Jun 2022 14:14:02 -0400
Message-ID: <CAP+JOzRpqRFWZsKW5nrvhRqiRH=Mo1coWG1h7SsoH17K54R54Q@mail.gmail.com>
Subject: Re: [PATCH] Revert "libselinux: restorecon: pin file to avoid TOCTOU issues"
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 1, 2022 at 12:39 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> This reverts commit 7e979b56fd2cee28f647376a7233d2ac2d12ca50.
>
> The reverted commit broke `setfiles` when it's run from a chroot
> without /proc mounted, e.g.
>
>     # chroot /mnt/sysimage
>
>     chroot# setfiles -e /proc -e /sys /sys /etc/selinux/targeted/contexts/files/file_contexts /
>     [strace]
>     openat(AT_FDCWD, "/", O_RDONLY|O_EXCL|O_NOFOLLOW|O_PATH) = 3
>     newfstatat(3, "", {st_mode=S_IFDIR|0555, st_size=4096, ...}, AT_EMPTY_PATH) = 0
>     mmap(NULL, 2101248, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f1697c91000
>     fgetxattr(3, "security.selinux", 0x55be8881d3f0, 255) = -1 EBADF (Bad file descriptor)
>     fcntl(3, F_GETFL)                       = 0x220000 (flags O_RDONLY|O_NOFOLLOW|O_PATH)
>     getxattr("/proc/self/fd/3", "security.selinux", 0x55be8881d3f0, 255) = -1 ENOENT (No such file or directory)
>     [/strace]
>     setfiles: Could not set context for /:  No such file or directory
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/selinux_restorecon.c | 43 ++++++++++++-----------------
>  1 file changed, 18 insertions(+), 25 deletions(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
> index 9dd6be817832..9f5b326c19ec 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -623,13 +623,13 @@ out:
>         return rc;
>  }
>
> -static int restorecon_sb(const char *pathname, struct rest_flags *flags, bool first)
> +static int restorecon_sb(const char *pathname, const struct stat *sb,
> +                           struct rest_flags *flags, bool first)
>  {
>         char *newcon = NULL;
>         char *curcon = NULL;
>         char *newtypecon = NULL;
> -       int fd = -1, rc;
> -       struct stat stat_buf;
> +       int rc;
>         bool updated = false;
>         const char *lookup_path = pathname;
>         float pc;
> @@ -644,21 +644,13 @@ static int restorecon_sb(const char *pathname, struct rest_flags *flags, bool fi
>                 lookup_path += rootpathlen;
>         }
>
> -       fd = open(pathname, O_PATH | O_NOFOLLOW | O_EXCL);
> -       if (fd < 0)
> -               goto err;
> -
> -       rc = fstat(fd, &stat_buf);
> -       if (rc < 0)
> -               goto err;
> -
>         if (rootpath != NULL && lookup_path[0] == '\0')
>                 /* this is actually the root dir of the alt root. */
>                 rc = selabel_lookup_raw(fc_sehandle, &newcon, "/",
> -                                                   stat_buf.st_mode);
> +                                                   sb->st_mode);
>         else
>                 rc = selabel_lookup_raw(fc_sehandle, &newcon, lookup_path,
> -                                                   stat_buf.st_mode);
> +                                                   sb->st_mode);
>
>         if (rc < 0) {
>                 if (errno == ENOENT) {
> @@ -667,10 +659,10 @@ static int restorecon_sb(const char *pathname, struct rest_flags *flags, bool fi
>                                             "Warning no default label for %s\n",
>                                             lookup_path);
>
> -                       goto out; /* no match, but not an error */
> +                       return 0; /* no match, but not an error */
>                 }
>
> -               goto err;
> +               return -1;
>         }
>
>         if (flags->progress) {
> @@ -690,17 +682,19 @@ static int restorecon_sb(const char *pathname, struct rest_flags *flags, bool fi
>         }
>
>         if (flags->add_assoc) {
> -               rc = filespec_add(stat_buf.st_ino, newcon, pathname, flags);
> +               rc = filespec_add(sb->st_ino, newcon, pathname, flags);
>
>                 if (rc < 0) {
>                         selinux_log(SELINUX_ERROR,
>                                     "filespec_add error: %s\n", pathname);
> -                       goto out1;
> +                       freecon(newcon);
> +                       return -1;
>                 }
>
>                 if (rc > 0) {
>                         /* Already an association and it took precedence. */
> -                       goto out;
> +                       freecon(newcon);
> +                       return 0;
>                 }
>         }
>
> @@ -708,7 +702,7 @@ static int restorecon_sb(const char *pathname, struct rest_flags *flags, bool fi
>                 selinux_log(SELINUX_INFO, "%s matched by %s\n",
>                             pathname, newcon);
>
> -       if (fgetfilecon_raw(fd, &curcon) < 0) {
> +       if (lgetfilecon_raw(pathname, &curcon) < 0) {
>                 if (errno != ENODATA)
>                         goto err;
>
> @@ -741,7 +735,7 @@ static int restorecon_sb(const char *pathname, struct rest_flags *flags, bool fi
>                 }
>
>                 if (!flags->nochange) {
> -                       if (fsetfilecon(fd, newcon) < 0)
> +                       if (lsetfilecon(pathname, newcon) < 0)
>                                 goto err;
>                         updated = true;
>                 }
> @@ -766,8 +760,6 @@ static int restorecon_sb(const char *pathname, struct rest_flags *flags, bool fi
>  out:
>         rc = 0;
>  out1:
> -       if (fd >= 0)
> -               close(fd);
>         freecon(curcon);
>         freecon(newcon);
>         return rc;
> @@ -865,6 +857,7 @@ static void *selinux_restorecon_thread(void *arg)
>         FTSENT *ftsent;
>         int error;
>         char ent_path[PATH_MAX];
> +       struct stat ent_st;
>         bool first = false;
>
>         if (state->parallel)
> @@ -962,11 +955,11 @@ loop_body:
>                         /* fall through */
>                 default:
>                         strcpy(ent_path, ftsent->fts_path);
> -
> +                       ent_st = *ftsent->fts_statp;
>                         if (state->parallel)
>                                 pthread_mutex_unlock(&state->mutex);
>
> -                       error = restorecon_sb(ent_path, &state->flags,
> +                       error = restorecon_sb(ent_path, &ent_st, &state->flags,
>                                               first);
>
>                         if (state->parallel) {
> @@ -1162,7 +1155,7 @@ static int selinux_restorecon_common(const char *pathname_orig,
>                         goto cleanup;
>                 }
>
> -               error = restorecon_sb(pathname, &state.flags, true);
> +               error = restorecon_sb(pathname, &sb, &state.flags, true);
>                 goto cleanup;
>         }
>
> --
> 2.36.1
>
