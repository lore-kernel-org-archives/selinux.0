Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A515FC433EF
	for <selinux@archiver.kernel.org>; Thu,  2 Jun 2022 13:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbiFBNFL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Jun 2022 09:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbiFBNFH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Jun 2022 09:05:07 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257922004EB
        for <selinux@vger.kernel.org>; Thu,  2 Jun 2022 06:05:06 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-e656032735so6708964fac.0
        for <selinux@vger.kernel.org>; Thu, 02 Jun 2022 06:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wcMzYyx3v/XoBrq+EWrRLcNuK2ZvlRN60oPoP+9FO5I=;
        b=KiDmYVObhFJVUVgQ7cgSN66dEMXe17O3RfgQSt+FHVFnZlGn6JhsCy1YCtfRQOlCLS
         UKIBR3R79i5TD9tLqt67OG1thJQ3lOboRIm6NSJ86zjVGzAtDeG20Y4fz7znampVgAXc
         qrXj3By53SJD8z7WjHRZjLwZeCJwJeSi6J1N6MIzN3DpsUVyC0UOpIWr7DD8uYDzlBWd
         FZHreSmHuUMgH8wmV7DgfR6IS26n47b+q8qaZtGlSdD+1mRZYkjZl3gV6G3mMNVHGRX6
         q1LqbgD0kfiu9BkxngmQOqaYdSQk+pY5aJPoUI3lqneh4DEnusI1L1QOOqfA4S/qTfx4
         sGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wcMzYyx3v/XoBrq+EWrRLcNuK2ZvlRN60oPoP+9FO5I=;
        b=TjTyyE6O6EtOhmeJLnMpylYwi9mz0ks9xmPP04RGkYDPS4V9Lln0SjYsU6IKXKHXuT
         xuIR9kMNbo5+dDuQyNHbtYgSpSf1L04UsFkxdsPQpsVZ1C7xOrK5gEyvYwDL6kW+vDHV
         ctXh7BGF2QLYDRo1ole6RpRSNMd3MLQY4GEdul74tNLGMJbAbOSWiblxTs8XSWkxOcN6
         UJZR2okbSYjL6kmFvZvcfUathd8amKQWfcIZp6sghdsFl8S6VTOS30+uY93D7lRehNk5
         jlbBKFlQGARUl0n3A7Eyn05gUTLVBNwXLkc5MnkGYalLNeVX9KU8tO6YnX1kIaowo8md
         dZQg==
X-Gm-Message-State: AOAM530HqXts6FsdjGKYznAmKGrzaQEGh8wuRyPbqEqXyvofrFHRCOyP
        UQFKJA4Qwu3vdW7ulCErLkPlUS30C1tvz0NZF4c=
X-Google-Smtp-Source: ABdhPJyrbVuDh1NOXSjbZf7FMqe3qVWbE4vx+ceDExTv/Y8MTRL4REEHmfSWF2abqP/DuRx8sR61cxqs2TnmR1w+W6g=
X-Received: by 2002:a05:6870:d68e:b0:e2:861:8b15 with SMTP id
 z14-20020a056870d68e00b000e208618b15mr19951141oap.156.1654175105382; Thu, 02
 Jun 2022 06:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220531125750.278211-1-plautrba@redhat.com> <CAP+JOzRpqRFWZsKW5nrvhRqiRH=Mo1coWG1h7SsoH17K54R54Q@mail.gmail.com>
In-Reply-To: <CAP+JOzRpqRFWZsKW5nrvhRqiRH=Mo1coWG1h7SsoH17K54R54Q@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 2 Jun 2022 09:04:54 -0400
Message-ID: <CAP+JOzTSSJC=ixzwCMOF_30heXdYVFyf8-NJwCmVWR-YQHsNSQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "libselinux: restorecon: pin file to avoid TOCTOU issues"
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 1, 2022 at 2:14 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Jun 1, 2022 at 12:39 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> >
> > This reverts commit 7e979b56fd2cee28f647376a7233d2ac2d12ca50.
> >
> > The reverted commit broke `setfiles` when it's run from a chroot
> > without /proc mounted, e.g.
> >
> >     # chroot /mnt/sysimage
> >
> >     chroot# setfiles -e /proc -e /sys /sys /etc/selinux/targeted/contexts/files/file_contexts /
> >     [strace]
> >     openat(AT_FDCWD, "/", O_RDONLY|O_EXCL|O_NOFOLLOW|O_PATH) = 3
> >     newfstatat(3, "", {st_mode=S_IFDIR|0555, st_size=4096, ...}, AT_EMPTY_PATH) = 0
> >     mmap(NULL, 2101248, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f1697c91000
> >     fgetxattr(3, "security.selinux", 0x55be8881d3f0, 255) = -1 EBADF (Bad file descriptor)
> >     fcntl(3, F_GETFL)                       = 0x220000 (flags O_RDONLY|O_NOFOLLOW|O_PATH)
> >     getxattr("/proc/self/fd/3", "security.selinux", 0x55be8881d3f0, 255) = -1 ENOENT (No such file or directory)
> >     [/strace]
> >     setfiles: Could not set context for /:  No such file or directory
> >
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libselinux/src/selinux_restorecon.c | 43 ++++++++++++-----------------
> >  1 file changed, 18 insertions(+), 25 deletions(-)
> >
> > diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
> > index 9dd6be817832..9f5b326c19ec 100644
> > --- a/libselinux/src/selinux_restorecon.c
> > +++ b/libselinux/src/selinux_restorecon.c
> > @@ -623,13 +623,13 @@ out:
> >         return rc;
> >  }
> >
> > -static int restorecon_sb(const char *pathname, struct rest_flags *flags, bool first)
> > +static int restorecon_sb(const char *pathname, const struct stat *sb,
> > +                           struct rest_flags *flags, bool first)
> >  {
> >         char *newcon = NULL;
> >         char *curcon = NULL;
> >         char *newtypecon = NULL;
> > -       int fd = -1, rc;
> > -       struct stat stat_buf;
> > +       int rc;
> >         bool updated = false;
> >         const char *lookup_path = pathname;
> >         float pc;
> > @@ -644,21 +644,13 @@ static int restorecon_sb(const char *pathname, struct rest_flags *flags, bool fi
> >                 lookup_path += rootpathlen;
> >         }
> >
> > -       fd = open(pathname, O_PATH | O_NOFOLLOW | O_EXCL);
> > -       if (fd < 0)
> > -               goto err;
> > -
> > -       rc = fstat(fd, &stat_buf);
> > -       if (rc < 0)
> > -               goto err;
> > -
> >         if (rootpath != NULL && lookup_path[0] == '\0')
> >                 /* this is actually the root dir of the alt root. */
> >                 rc = selabel_lookup_raw(fc_sehandle, &newcon, "/",
> > -                                                   stat_buf.st_mode);
> > +                                                   sb->st_mode);
> >         else
> >                 rc = selabel_lookup_raw(fc_sehandle, &newcon, lookup_path,
> > -                                                   stat_buf.st_mode);
> > +                                                   sb->st_mode);
> >
> >         if (rc < 0) {
> >                 if (errno == ENOENT) {
> > @@ -667,10 +659,10 @@ static int restorecon_sb(const char *pathname, struct rest_flags *flags, bool fi
> >                                             "Warning no default label for %s\n",
> >                                             lookup_path);
> >
> > -                       goto out; /* no match, but not an error */
> > +                       return 0; /* no match, but not an error */
> >                 }
> >
> > -               goto err;
> > +               return -1;
> >         }
> >
> >         if (flags->progress) {
> > @@ -690,17 +682,19 @@ static int restorecon_sb(const char *pathname, struct rest_flags *flags, bool fi
> >         }
> >
> >         if (flags->add_assoc) {
> > -               rc = filespec_add(stat_buf.st_ino, newcon, pathname, flags);
> > +               rc = filespec_add(sb->st_ino, newcon, pathname, flags);
> >
> >                 if (rc < 0) {
> >                         selinux_log(SELINUX_ERROR,
> >                                     "filespec_add error: %s\n", pathname);
> > -                       goto out1;
> > +                       freecon(newcon);
> > +                       return -1;
> >                 }
> >
> >                 if (rc > 0) {
> >                         /* Already an association and it took precedence. */
> > -                       goto out;
> > +                       freecon(newcon);
> > +                       return 0;
> >                 }
> >         }
> >
> > @@ -708,7 +702,7 @@ static int restorecon_sb(const char *pathname, struct rest_flags *flags, bool fi
> >                 selinux_log(SELINUX_INFO, "%s matched by %s\n",
> >                             pathname, newcon);
> >
> > -       if (fgetfilecon_raw(fd, &curcon) < 0) {
> > +       if (lgetfilecon_raw(pathname, &curcon) < 0) {
> >                 if (errno != ENODATA)
> >                         goto err;
> >
> > @@ -741,7 +735,7 @@ static int restorecon_sb(const char *pathname, struct rest_flags *flags, bool fi
> >                 }
> >
> >                 if (!flags->nochange) {
> > -                       if (fsetfilecon(fd, newcon) < 0)
> > +                       if (lsetfilecon(pathname, newcon) < 0)
> >                                 goto err;
> >                         updated = true;
> >                 }
> > @@ -766,8 +760,6 @@ static int restorecon_sb(const char *pathname, struct rest_flags *flags, bool fi
> >  out:
> >         rc = 0;
> >  out1:
> > -       if (fd >= 0)
> > -               close(fd);
> >         freecon(curcon);
> >         freecon(newcon);
> >         return rc;
> > @@ -865,6 +857,7 @@ static void *selinux_restorecon_thread(void *arg)
> >         FTSENT *ftsent;
> >         int error;
> >         char ent_path[PATH_MAX];
> > +       struct stat ent_st;
> >         bool first = false;
> >
> >         if (state->parallel)
> > @@ -962,11 +955,11 @@ loop_body:
> >                         /* fall through */
> >                 default:
> >                         strcpy(ent_path, ftsent->fts_path);
> > -
> > +                       ent_st = *ftsent->fts_statp;
> >                         if (state->parallel)
> >                                 pthread_mutex_unlock(&state->mutex);
> >
> > -                       error = restorecon_sb(ent_path, &state->flags,
> > +                       error = restorecon_sb(ent_path, &ent_st, &state->flags,
> >                                               first);
> >
> >                         if (state->parallel) {
> > @@ -1162,7 +1155,7 @@ static int selinux_restorecon_common(const char *pathname_orig,
> >                         goto cleanup;
> >                 }
> >
> > -               error = restorecon_sb(pathname, &state.flags, true);
> > +               error = restorecon_sb(pathname, &sb, &state.flags, true);
> >                 goto cleanup;
> >         }
> >
> > --
> > 2.36.1
> >
