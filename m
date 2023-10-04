Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F236E936E6
	for <selinux@archiver.kernel.org>; Wed,  4 Oct 2023 21:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbjJDVCD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Oct 2023 17:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbjJDVCD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Oct 2023 17:02:03 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726BE90
        for <selinux@vger.kernel.org>; Wed,  4 Oct 2023 14:01:59 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-504a7f9204eso329663e87.3
        for <selinux@vger.kernel.org>; Wed, 04 Oct 2023 14:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696453317; x=1697058117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6zbUhDdQIvX/Ja84ToO8RUO4o7j2td4VtIMmL8U640=;
        b=ZR04e3QnzvQJRn869YqeJw8SngazzrwMuFMRhQHsL3kruelICFfYkIBEXsK2yWhGUa
         x+DmKESoj52dcf9eNWONZncyZM7BS/eJ2byTWhOa/Sa0HWZhiTrwTChAmwq89J5CLYsN
         vMj6M4lQXz0I25eWnId9o77//LsawtkhUycxI2wGtceoa3SINEg9barpk5PwJY7lLKuN
         jyxUrM4ZdKwB6rK3c2h6ABurD9bKhoAY808y9KyAHVzMJkqfp0GoSCwbqDJgvAfcp+Sc
         eQXf0Qq7jblu3ELUKQIC+gx2pURBQdsPaipzj/CwczIQ5+/Q5kFpaKwNfr7AcruaSFel
         gGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696453317; x=1697058117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6zbUhDdQIvX/Ja84ToO8RUO4o7j2td4VtIMmL8U640=;
        b=nmCS9qoWcSqQCQ6tLyWusCx+hPUtl8jRmu7QtB2hfoqPy5jdSJq7ZfiC4uJk/IyxN7
         Up4noB8ASMgBNEqwV4EdkcjWTfrpCdTgf6LGCh01KLVvTA4urfLxmTdWPEx5k1cDSb5B
         UfFaaTpXt7jX1U3qT+CaataFPztLMKaocnE7z77TP8gs2ncV51fd6FfKfh6M/knayv2V
         7UlOZtbP1+itDwnBs6qEEYsSW5EX6lTCWBA7hPGru3HIta1ScSuplB985qq6bIsFIu9n
         bxADj3ytIzaIttP2nBtoFmFxvneq1YsRPRPGp3JHzoZfbTTqKqrsro6cYcoSHkZ80vCh
         eVwA==
X-Gm-Message-State: AOJu0Yw4/2Sz77WdUrQwgBxmGEsxCo+4JxI+88pLJWKyYUVd1VjwG5d1
        nXjk1gKQNkmqaO/C1RyA8fQ2h6zDOKdqrIIwTaCLJihT
X-Google-Smtp-Source: AGHT+IEg7BCL/GmeeTOHvEtVkiyCL+61Pj1yN4GtDm1c3UCfuWFiTeaNzbb5JIZQksEbrHN5Tz2XhCQgE+tsafmqkNQ=
X-Received: by 2002:ac2:558a:0:b0:4fd:cbd6:d2ff with SMTP id
 v10-20020ac2558a000000b004fdcbd6d2ffmr2401921lfg.33.1696453317355; Wed, 04
 Oct 2023 14:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com> <20230814132025.45364-11-cgzones@googlemail.com>
In-Reply-To: <20230814132025.45364-11-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 4 Oct 2023 17:01:45 -0400
Message-ID: <CAP+JOzSaG5B9odXriQ=fTQZ27mU7HBFL+Mo4+yDVSPP+H8XB-w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 10/27] libselinux: introduce selabel_nuke
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 14, 2023 at 9:41=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Introduce a helper to remove SELinux file contexts.
>
> Mainly for testing label operations and only for SELinux disabled
> systems, since removing file contexts is not supported by SELinux.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/utils/.gitignore     |   1 +
>  libselinux/utils/selabel_nuke.c | 134 ++++++++++++++++++++++++++++++++
>  2 files changed, 135 insertions(+)
>  create mode 100644 libselinux/utils/selabel_nuke.c
>
> diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignore
> index b3311360..a92e1e94 100644
> --- a/libselinux/utils/.gitignore
> +++ b/libselinux/utils/.gitignore
> @@ -20,6 +20,7 @@ selabel_digest
>  selabel_get_digests_all_partial_matches
>  selabel_lookup
>  selabel_lookup_best_match
> +selabel_nuke

This is not a good name and I am not sure that it should have a
"selabel" prefix. It doesn't use any selabel stuff.

It seems like this should be in policycoreutils maybe with the name
"remove_filecons".

Jim


>  selabel_partial_match
>  selinux_check_securetty_context
>  selinuxenabled
> diff --git a/libselinux/utils/selabel_nuke.c b/libselinux/utils/selabel_n=
uke.c
> new file mode 100644
> index 00000000..b6a2df66
> --- /dev/null
> +++ b/libselinux/utils/selabel_nuke.c
> @@ -0,0 +1,134 @@
> +#include <dirent.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <getopt.h>
> +#include <linux/magic.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/types.h>
> +#include <sys/xattr.h>
> +#include <unistd.h>
> +
> +#include <selinux/selinux.h>
> +
> +
> +#define XATTR_NAME_SELINUX "security.selinux"
> +
> +
> +static void usage(const char *progname)
> +{
> +       fprintf(stderr, "usage: %s [-nrv] <path>\n", progname);
> +}
> +
> +static void nuke(int atfd, const char *path, const char *fullpath, bool =
dry_run, bool recursive, bool verbose)
> +{
> +       ssize_t ret;
> +       int fd, rc;
> +       DIR *dir;
> +
> +       ret =3D lgetxattr(fullpath, XATTR_NAME_SELINUX, NULL, 0);
> +       if (ret <=3D 0) {
> +               if (errno !=3D ENODATA && errno !=3D ENOTSUP)
> +                       fprintf(stderr, "Failed to get SELinux label of %=
s:  %m\n", fullpath);
> +               else if (verbose)
> +                       printf("Failed to get SELinux label of %s:  %m\n"=
, fullpath);
> +       } else {
> +               if (dry_run) {
> +                       printf("Would remove SELinux label of %s\n", full=
path);
> +               } else {
> +                       if (verbose)
> +                               printf("Removing label of %s\n", fullpath=
);
> +
> +                       rc =3D lremovexattr(fullpath, XATTR_NAME_SELINUX)=
;
> +                       if (rc < 0)
> +                               fprintf(stderr, "Failed to remove SELinux=
 label of %s:  %m\n", fullpath);
> +               }
> +       }
> +
> +       if (!recursive)
> +               return;
> +
> +       fd =3D openat(atfd, path, O_RDONLY | O_DIRECTORY | O_NOFOLLOW | O=
_CLOEXEC);
> +       if (fd < 0) {
> +               if (errno !=3D ENOTDIR)
> +                       fprintf(stderr, "Failed to open %s:  %m\n", fullp=
ath);
> +               return;
> +       }
> +
> +       dir =3D fdopendir(fd);
> +       if (!dir) {
> +               fprintf(stderr, "Failed to open directory %s:  %m\n", ful=
lpath);
> +               close(fd);
> +               return;
> +       }
> +
> +       while (true) {
> +               const struct dirent *entry;
> +               char *nextfullpath;
> +
> +               errno =3D 0;
> +               entry =3D readdir(dir);
> +               if (!entry) {
> +                       if (errno)
> +                               fprintf(stderr, "Failed to iterate direct=
ory %s:  %m\n", fullpath);
> +                       break;
> +               }
> +
> +               if (entry->d_name[0] =3D=3D '.' && (entry->d_name[1] =3D=
=3D '\0' || (entry->d_name[1] =3D=3D '.' && entry->d_name[2] =3D=3D '\0')))
> +                       continue;
> +
> +               rc =3D asprintf(&nextfullpath, "%s/%s", strcmp(fullpath, =
"/") =3D=3D 0 ? "" : fullpath, entry->d_name);
> +               if (rc < 0) {
> +                       fprintf(stderr, "Out of memory!\n");
> +                       closedir(dir);
> +                       return;
> +               }
> +
> +               nuke(dirfd(dir), entry->d_name, nextfullpath, dry_run, re=
cursive, verbose);
> +
> +               free(nextfullpath);
> +       }
> +
> +       closedir(dir);
> +}
> +
> +
> +int main(int argc, char *argv[])
> +{
> +       bool dry_run =3D false, recursive =3D false, verbose =3D false;
> +       int c;
> +
> +       while ((c =3D getopt(argc, argv, "nrv")) !=3D -1) {
> +               switch (c) {
> +               case 'n':
> +                       dry_run =3D true;
> +                       break;
> +               case 'r':
> +                       recursive =3D true;
> +                       break;
> +               case 'v':
> +                       verbose =3D true;
> +                       break;
> +               default:
> +                       usage(argv[0]);
> +                       return EXIT_FAILURE;
> +               }
> +       }
> +
> +       if (optind >=3D argc) {
> +               usage(argv[0]);
> +               return EXIT_FAILURE;
> +       }
> +
> +       if (is_selinux_enabled()) {
> +               fprintf(stderr, "Removing SELinux attributes on a SELinux=
 enabled system is not supported!\n");
> +               return EXIT_FAILURE;
> +       }
> +
> +       for (int index =3D optind; index < argc; index++)
> +               nuke(AT_FDCWD, argv[index], argv[index], dry_run, recursi=
ve, verbose);
> +
> +       return EXIT_SUCCESS;
> +}
> --
> 2.40.1
>
