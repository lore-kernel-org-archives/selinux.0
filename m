Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF31C433F5
	for <selinux@archiver.kernel.org>; Thu, 12 May 2022 19:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358095AbiELTie (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 May 2022 15:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358098AbiELTib (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 May 2022 15:38:31 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14BF2532ED
        for <selinux@vger.kernel.org>; Thu, 12 May 2022 12:38:28 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-e2fa360f6dso7955501fac.2
        for <selinux@vger.kernel.org>; Thu, 12 May 2022 12:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Qw5ouPb3dB6YATKn0qmQACftsz6SPCu2KMtfsgcJh1I=;
        b=Uet7u27YtnhSmlXVdcvchn8wTlH1BE94UCoUlF70plhRXPF9YU6Ejl3+yXfZjelTbP
         KqQjrgZ87e283jDMNKpZJSiww3a1HijiQNL4fFvHlb/IMeV7gB/9lRfkod3Ei+yJIvLk
         zdEo9tTI4Qs3Iz1FSYGc6IdPGUIxk9T6yZMrRkf9LPUPjpbeP6ahVZ8B+6uFnxfm1B/c
         R5EXmux7TeXKvxydZIFopsVctBkCoioZcVsFUAPs1vN6pegmWY0q14DDi9Xp5J/ozdbJ
         URQszr6oZeAXiKqCuqp36wo36QzEMrrP/6fbhAJSZ4azrNW3+ikpymSTotzOzozdi3i6
         woSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Qw5ouPb3dB6YATKn0qmQACftsz6SPCu2KMtfsgcJh1I=;
        b=N2hnB3UE1D3YvWMuhcPf8nQZxmCzkfvGfuUezE6nxsMOwJlHZ4cT7FHPzGUoZHm4le
         zfPrP9U1l4p1kfuRsK+8QlVL1xTWWtfWdDIrsviDl+RPqYhjzVBVqOu6vALiAD8PnR95
         4a54EBnwul82CcZjmVElexe3mdaOWhSugGSBpTh7ZOZW1Ya8vM7ShJk/88cYihgbOGkI
         /S/8tiZiv2coWQhj06MWIRledh1cgp3VaT/4gLXeWMfWnetbg9bA/+6RUuFo1korF9Om
         d+RsmLG2G7IE+AvWR5PX2C2Uzy4kazoImadpzZ0fNrNe8PR3UsEE09P2+jqE0XNhXMGa
         mR7g==
X-Gm-Message-State: AOAM533Ftgww2a+xhZKfZWDIAEOB+ds+Hs/VY0FLV768UFFp/mCrDbPS
        v7hSzMuGny4h6Nbyvgt27s/JhdGH2OLGj6R5c9jDvDicB6w=
X-Google-Smtp-Source: ABdhPJxJpZAEexk3aK8ZgodeBJMulL+lQe7iYNbL/KqYm5rI0nCTb9wwSy7+hp0mhzOH8FPtuwa/GbEI+nZsKaILRDM=
X-Received: by 2002:a05:6870:c692:b0:e9:5368:10df with SMTP id
 cv18-20020a056870c69200b000e9536810dfmr816404oab.182.1652384307895; Thu, 12
 May 2022 12:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220505174401.24442-1-cgzones@googlemail.com>
In-Reply-To: <20220505174401.24442-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 12 May 2022 15:38:17 -0400
Message-ID: <CAP+JOzQiR-RA+M5L=fkUhEowY-vFS9xcXyGWj5O0GbjYr2W3NA@mail.gmail.com>
Subject: Re: [PATCH] libselinux/utils: print errno on failure
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, May 7, 2022 at 11:59 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Print error description on failure after functions known to set errno.
>
> Also mention the library function name in getenforce, policyvers and
> setenforce instead of the program name twice.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/utils/compute_av.c                              | 3 ++-
>  libselinux/utils/compute_create.c                          | 5 +++--
>  libselinux/utils/compute_member.c                          | 5 +++--
>  libselinux/utils/compute_relabel.c                         | 5 +++--
>  libselinux/utils/getconlist.c                              | 2 +-
>  libselinux/utils/getdefaultcon.c                           | 2 +-
>  libselinux/utils/getenforce.c                              | 4 +++-
>  libselinux/utils/getfilecon.c                              | 6 ++++--
>  libselinux/utils/getpidcon.c                               | 4 +++-
>  libselinux/utils/policyvers.c                              | 4 +++-
>  libselinux/utils/selabel_digest.c                          | 2 +-
>  libselinux/utils/selabel_get_digests_all_partial_matches.c | 3 ++-
>  libselinux/utils/selabel_lookup.c                          | 3 ++-
>  libselinux/utils/selabel_lookup_best_match.c               | 3 ++-
>  libselinux/utils/selabel_partial_match.c                   | 3 ++-
>  libselinux/utils/setenforce.c                              | 3 ++-
>  libselinux/utils/setfilecon.c                              | 6 ++++--
>  17 files changed, 41 insertions(+), 22 deletions(-)
>
> diff --git a/libselinux/utils/compute_av.c b/libselinux/utils/compute_av.=
c
> index ef08338f..cca407d6 100644
> --- a/libselinux/utils/compute_av.c
> +++ b/libselinux/utils/compute_av.c
> @@ -2,6 +2,7 @@
>  #include <sys/types.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <string.h>
>  #include <errno.h>
>  #include <selinux/selinux.h>
>
> @@ -35,7 +36,7 @@ int main(int argc, char **argv)
>
>         ret =3D security_compute_av(argv[1], argv[2], tclass, 1, &avd);
>         if (ret < 0) {
> -               fprintf(stderr, "%s:  security_compute_av failed\n", argv=
[0]);
> +               fprintf(stderr, "%s:  security_compute_av failed:  %s\n",=
 argv[0], strerror(errno));
>                 exit(3);
>         }
>
> diff --git a/libselinux/utils/compute_create.c b/libselinux/utils/compute=
_create.c
> index 63029c19..c6481f4b 100644
> --- a/libselinux/utils/compute_create.c
> +++ b/libselinux/utils/compute_create.c
> @@ -2,6 +2,7 @@
>  #include <sys/types.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <string.h>
>  #include <errno.h>
>  #include <selinux/selinux.h>
>
> @@ -35,8 +36,8 @@ int main(int argc, char **argv)
>
>         ret =3D security_compute_create(argv[1], argv[2], tclass, &buf);
>         if (ret < 0) {
> -               fprintf(stderr, "%s:  security_compute_create failed\n",
> -                       argv[0]);
> +               fprintf(stderr, "%s:  security_compute_create failed:  %s=
\n",
> +                       argv[0], strerror(errno));
>                 exit(3);
>         }
>
> diff --git a/libselinux/utils/compute_member.c b/libselinux/utils/compute=
_member.c
> index 1ef47c25..9fe790ee 100644
> --- a/libselinux/utils/compute_member.c
> +++ b/libselinux/utils/compute_member.c
> @@ -2,6 +2,7 @@
>  #include <sys/types.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <string.h>
>  #include <errno.h>
>  #include <selinux/selinux.h>
>
> @@ -35,8 +36,8 @@ int main(int argc, char **argv)
>
>         ret =3D security_compute_member(argv[1], argv[2], tclass, &buf);
>         if (ret < 0) {
> -               fprintf(stderr, "%s:  security_compute_member failed\n",
> -                       argv[0]);
> +               fprintf(stderr, "%s:  security_compute_member failed:  %s=
\n",
> +                       argv[0], strerror(errno));
>                 exit(3);
>         }
>
> diff --git a/libselinux/utils/compute_relabel.c b/libselinux/utils/comput=
e_relabel.c
> index f6a957da..bdd39d0f 100644
> --- a/libselinux/utils/compute_relabel.c
> +++ b/libselinux/utils/compute_relabel.c
> @@ -2,6 +2,7 @@
>  #include <sys/types.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <string.h>
>  #include <errno.h>
>  #include <selinux/selinux.h>
>
> @@ -35,8 +36,8 @@ int main(int argc, char **argv)
>
>         ret =3D security_compute_relabel(argv[1], argv[2], tclass, &buf);
>         if (ret < 0) {
> -               fprintf(stderr, "%s:  security_compute_relabel failed\n",
> -                       argv[0]);
> +               fprintf(stderr, "%s:  security_compute_relabel failed:  %=
s\n",
> +                       argv[0], strerror(errno));
>                 exit(3);
>         }
>
> diff --git a/libselinux/utils/getconlist.c b/libselinux/utils/getconlist.=
c
> index 0bb28469..92f6a793 100644
> --- a/libselinux/utils/getconlist.c
> +++ b/libselinux/utils/getconlist.c
> @@ -55,7 +55,7 @@ int main(int argc, char **argv)
>         /* If a context wasn't passed, use the current context. */
>         if (((argc - optind) < 2)) {
>                 if (getcon(&cur_context) < 0) {
> -                       fprintf(stderr, "Couldn't get current context.\n"=
);
> +                       fprintf(stderr, "Couldn't get current context:  %=
s\n", strerror(errno));
>                         free(level);
>                         return 2;
>                 }
> diff --git a/libselinux/utils/getdefaultcon.c b/libselinux/utils/getdefau=
ltcon.c
> index 590e98d9..93102e5e 100644
> --- a/libselinux/utils/getdefaultcon.c
> +++ b/libselinux/utils/getdefaultcon.c
> @@ -62,7 +62,7 @@ int main(int argc, char **argv)
>         /* If a context wasn't passed, use the current context. */
>         if (((argc - optind) < 2)) {
>                 if (getcon(&cur_context) < 0) {
> -                       fprintf(stderr, "Couldn't get current context.\n"=
);
> +                       fprintf(stderr, "Couldn't get current context:  %=
s\n", strerror(errno));
>                         return 2;
>                 }
>         } else
> diff --git a/libselinux/utils/getenforce.c b/libselinux/utils/getenforce.=
c
> index e5d19c54..aeeb79a8 100644
> --- a/libselinux/utils/getenforce.c
> +++ b/libselinux/utils/getenforce.c
> @@ -1,6 +1,8 @@
>  #include <unistd.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <string.h>
> +#include <errno.h>
>  #include <selinux/selinux.h>
>
>  int main(int argc __attribute__ ((unused)),
> @@ -16,7 +18,7 @@ int main(int argc __attribute__ ((unused)),
>         if (rc =3D=3D 1) {
>                 rc =3D security_getenforce();
>                 if (rc < 0) {
> -                       fputs("getenforce:  getenforce() failed", stderr)=
;
> +                       fprintf(stderr, "getenforce:  security_getenforce=
() failed:  %s\n", strerror(errno));
>                         return 2;
>                 }
>
> diff --git a/libselinux/utils/getfilecon.c b/libselinux/utils/getfilecon.=
c
> index 6266ae16..b823a1a1 100644
> --- a/libselinux/utils/getfilecon.c
> +++ b/libselinux/utils/getfilecon.c
> @@ -1,6 +1,8 @@
>  #include <unistd.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <string.h>
> +#include <errno.h>
>  #include <selinux/selinux.h>
>
>  int main(int argc, char **argv)
> @@ -16,8 +18,8 @@ int main(int argc, char **argv)
>         for (i =3D 1; i < argc; i++) {
>                 rc =3D getfilecon(argv[i], &buf);
>                 if (rc < 0) {
> -                       fprintf(stderr, "%s:  getfilecon(%s) failed\n", a=
rgv[0],
> -                               argv[i]);
> +                       fprintf(stderr, "%s:  getfilecon(%s) failed:  %s\=
n", argv[0],
> +                               argv[i], strerror(errno));
>                         exit(2);
>                 }
>                 printf("%s\t%s\n", argv[i], buf);
> diff --git a/libselinux/utils/getpidcon.c b/libselinux/utils/getpidcon.c
> index ea6c274e..1a88fa6d 100644
> --- a/libselinux/utils/getpidcon.c
> +++ b/libselinux/utils/getpidcon.c
> @@ -1,6 +1,8 @@
>  #include <unistd.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <string.h>
> +#include <errno.h>
>  #include <selinux/selinux.h>
>
>  int main(int argc, char **argv)
> @@ -21,7 +23,7 @@ int main(int argc, char **argv)
>
>         rc =3D getpidcon(pid, &buf);
>         if (rc < 0) {
> -               fprintf(stderr, "%s:  getpidcon() failed\n", argv[0]);
> +               fprintf(stderr, "%s:  getpidcon() failed:  %s\n", argv[0]=
, strerror(errno));
>                 exit(3);
>         }
>
> diff --git a/libselinux/utils/policyvers.c b/libselinux/utils/policyvers.=
c
> index dd56f2c7..5230bcaf 100644
> --- a/libselinux/utils/policyvers.c
> +++ b/libselinux/utils/policyvers.c
> @@ -1,6 +1,8 @@
>  #include <unistd.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <string.h>
> +#include <errno.h>
>  #include <selinux/selinux.h>
>
>  int main(int argc __attribute__ ((unused)), char **argv)
> @@ -9,7 +11,7 @@ int main(int argc __attribute__ ((unused)), char **argv)
>
>         rc =3D security_policyvers();
>         if (rc < 0) {
> -               fprintf(stderr, "%s:  policyvers() failed\n", argv[0]);
> +               fprintf(stderr, "%s:  security_policyvers() failed:  %s\n=
", argv[0], strerror(errno));
>                 exit(2);
>         }
>
> diff --git a/libselinux/utils/selabel_digest.c b/libselinux/utils/selabel=
_digest.c
> index 49408a0b..6a8313a2 100644
> --- a/libselinux/utils/selabel_digest.c
> +++ b/libselinux/utils/selabel_digest.c
> @@ -34,7 +34,7 @@ static int run_check_digest(char *cmd, char *selabel_di=
gest)
>
>         fp =3D popen(cmd, "r");
>         if (!fp) {
> -               printf("Failed to run command line\n");
> +               fprintf(stderr, "Failed to run command '%s':  %s\n", cmd,=
 strerror(errno));
>                 return -1;
>         }
>
> diff --git a/libselinux/utils/selabel_get_digests_all_partial_matches.c b=
/libselinux/utils/selabel_get_digests_all_partial_matches.c
> index e28833d2..c4e0f836 100644
> --- a/libselinux/utils/selabel_get_digests_all_partial_matches.c
> +++ b/libselinux/utils/selabel_get_digests_all_partial_matches.c
> @@ -77,7 +77,8 @@ int main(int argc, char **argv)
>         hnd =3D selabel_open(SELABEL_CTX_FILE, selabel_option, 2);
>         if (!hnd) {
>                 fprintf(stderr, "ERROR: selabel_open - Could not obtain "
> -                                                            "handle.\n")=
;
> +                                                            "handle:  %s=
\n",
> +                                                            strerror(err=
no));
>                 return -1;
>         }
>
> diff --git a/libselinux/utils/selabel_lookup.c b/libselinux/utils/selabel=
_lookup.c
> index 1aef64de..112ffda1 100644
> --- a/libselinux/utils/selabel_lookup.c
> +++ b/libselinux/utils/selabel_lookup.c
> @@ -91,7 +91,8 @@ int main(int argc, char **argv)
>         hnd =3D selabel_open(backend, selabel_option, 2);
>         if (!hnd) {
>                 fprintf(stderr, "ERROR: selabel_open - Could not obtain "
> -                                                            "handle.\n")=
;
> +                                                            "handle:  %s=
\n",
> +                                                            strerror(err=
no));
>                 return -1;
>         }
>
> diff --git a/libselinux/utils/selabel_lookup_best_match.c b/libselinux/ut=
ils/selabel_lookup_best_match.c
> index 2cddc6cd..a4af0679 100644
> --- a/libselinux/utils/selabel_lookup_best_match.c
> +++ b/libselinux/utils/selabel_lookup_best_match.c
> @@ -117,7 +117,8 @@ int main(int argc, char **argv)
>         hnd =3D selabel_open(SELABEL_CTX_FILE, options, 2);
>         if (!hnd) {
>                 fprintf(stderr, "ERROR: selabel_open - Could not obtain "
> -                                                            "handle.\n")=
;
> +                                                            "handle:  %s=
\n",
> +                                                            strerror(err=
no));
>                 rc =3D -1;
>                 goto out;
>         }
> diff --git a/libselinux/utils/selabel_partial_match.c b/libselinux/utils/=
selabel_partial_match.c
> index c5932cb1..7bbd5777 100644
> --- a/libselinux/utils/selabel_partial_match.c
> +++ b/libselinux/utils/selabel_partial_match.c
> @@ -61,7 +61,8 @@ int main(int argc, char **argv)
>         hnd =3D selabel_open(SELABEL_CTX_FILE, selabel_option, 2);
>         if (!hnd) {
>                 fprintf(stderr, "ERROR: selabel_open - Could not obtain "
> -                                                            "handle.\n")=
;
> +                                                            "handle:  %s=
\n",
> +                                                            strerror(err=
no));
>                 return -1;
>         }
>
> diff --git a/libselinux/utils/setenforce.c b/libselinux/utils/setenforce.=
c
> index 60a20a4b..67c13dca 100644
> --- a/libselinux/utils/setenforce.c
> +++ b/libselinux/utils/setenforce.c
> @@ -4,6 +4,7 @@
>  #include <ctype.h>
>  #include <string.h>
>  #include <strings.h>
> +#include <errno.h>
>  #include <selinux/selinux.h>
>
>  static __attribute__ ((__noreturn__)) void usage(const char *progname)
> @@ -35,7 +36,7 @@ int main(int argc, char **argv)
>                         usage(argv[0]);
>         }
>         if (rc < 0) {
> -               fprintf(stderr, "%s:  setenforce() failed\n", argv[0]);
> +               fprintf(stderr, "%s:  security_setenforce() failed:  %s\n=
", argv[0], strerror(errno));
>                 return 2;
>         }
>         return 0;
> diff --git a/libselinux/utils/setfilecon.c b/libselinux/utils/setfilecon.=
c
> index 79af55de..a3fbc3ed 100644
> --- a/libselinux/utils/setfilecon.c
> +++ b/libselinux/utils/setfilecon.c
> @@ -1,6 +1,8 @@
>  #include <unistd.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <string.h>
> +#include <errno.h>
>  #include <selinux/selinux.h>
>
>  int main(int argc, char **argv)
> @@ -15,8 +17,8 @@ int main(int argc, char **argv)
>         for (i =3D 2; i < argc; i++) {
>                 rc =3D setfilecon(argv[i], argv[1]);
>                 if (rc < 0) {
> -                       fprintf(stderr, "%s:  setfilecon(%s,%s) failed\n"=
,
> -                               argv[0], argv[i], argv[1]);
> +                       fprintf(stderr, "%s:  setfilecon(%s,%s) failed:  =
%s\n",
> +                               argv[0], argv[i], argv[1], strerror(errno=
));
>                         exit(2);
>                 }
>         }
> --
> 2.36.0
>
