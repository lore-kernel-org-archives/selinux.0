Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288C6C433F5
	for <selinux@archiver.kernel.org>; Mon, 16 May 2022 17:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243283AbiEPRFc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 May 2022 13:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344166AbiEPRFS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 May 2022 13:05:18 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8987C27FF1
        for <selinux@vger.kernel.org>; Mon, 16 May 2022 10:05:17 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id i66so19320671oia.11
        for <selinux@vger.kernel.org>; Mon, 16 May 2022 10:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gxenxykS3cM3blCfksDoU5ZacGhIOIllTl99JWVrEbc=;
        b=i+hriwybQ+HNVv8RJmasO4pkKyCp9gD6aXp+K6n5h465Ao21Ji98hPT31TO0ScB0sY
         Dl41CDtAY/ZzLiqXgCejmGi2o3cbpsf2DwZhjuK1yU1nAxFDQTCeAE4Rpj4DflOBpxpj
         oqJIQYEqA0/u/F18CdA5I4nr6Kn35iQZERubrfcpzBYZh8+ExItuBO2ASXE7Rtyi+4JD
         llB5BhTb01Ziw4Ih4oaTIggOkpxfGLZ8S18vcqKFbAudUyTRD8arW7+nivoy5t4UpuZL
         8tlnmBtHU032mWm3y8D9v2Pa14vwLcOjpvmx8JsXnScZZlTqyJ9KgJAqyhjbEn3C7YFe
         ywNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gxenxykS3cM3blCfksDoU5ZacGhIOIllTl99JWVrEbc=;
        b=NOX5Y/7C1juvBa82XmjCiNTnBpzEBm9nF8X55UWwvkiE2S4QbcdtU5Me0HsNs5WRYg
         0PCsQQuMP2tc4s73Iz6aEopisY30ByJGSW3N7zom/paQvnO3TSaQhlMu1BsoN5x+bdAz
         JbgzOUTo2x6rwYtTnRyA+cAd4q+u3d33Zyk7EWZXW7eu0hAxjlgrEY+mBEhD4aqEU4YD
         BbdbE083E/JkFm/MOYaSu1gJQB7lV+LXye4OKOTSKkOfaWffh3PGhKqZKh7qNOICsRlE
         EVdZSQcPMwHq0mlba+FAwSP4aYEGlrxUiWVMFgXYzKpWK1gQDbU+IdZnj96sOVH5dq0L
         fwcg==
X-Gm-Message-State: AOAM5324vcaakLg5Q6IznqJ6EmqVDHLWWU1aDBtOllU4N25mjn2Ov3U9
        J63dgU1jrAMI2l0vRltQwdKIyTrMUTRFP6T9FtFD+87J
X-Google-Smtp-Source: ABdhPJzdLcRA/phAawAlv/czkGcl6Hs8pnsFerO88kla4YhVAhBUNGiVrYzfKGyK0B/mT8n9II22d5EeFNQzyWgp+jw=
X-Received: by 2002:a05:6808:2082:b0:326:9857:840b with SMTP id
 s2-20020a056808208200b003269857840bmr8460466oiw.182.1652720716708; Mon, 16
 May 2022 10:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220505174401.24442-1-cgzones@googlemail.com> <CAP+JOzQiR-RA+M5L=fkUhEowY-vFS9xcXyGWj5O0GbjYr2W3NA@mail.gmail.com>
In-Reply-To: <CAP+JOzQiR-RA+M5L=fkUhEowY-vFS9xcXyGWj5O0GbjYr2W3NA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 16 May 2022 13:05:05 -0400
Message-ID: <CAP+JOzRcRnZjVWiohUv00bFX12vNm8yC28_dZCAr8CsX3f4t4g@mail.gmail.com>
Subject: Re: [PATCH] libselinux/utils: print errno on failure
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 12, 2022 at 3:38 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Sat, May 7, 2022 at 11:59 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Print error description on failure after functions known to set errno.
> >
> > Also mention the library function name in getenforce, policyvers and
> > setenforce instead of the program name twice.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libselinux/utils/compute_av.c                              | 3 ++-
> >  libselinux/utils/compute_create.c                          | 5 +++--
> >  libselinux/utils/compute_member.c                          | 5 +++--
> >  libselinux/utils/compute_relabel.c                         | 5 +++--
> >  libselinux/utils/getconlist.c                              | 2 +-
> >  libselinux/utils/getdefaultcon.c                           | 2 +-
> >  libselinux/utils/getenforce.c                              | 4 +++-
> >  libselinux/utils/getfilecon.c                              | 6 ++++--
> >  libselinux/utils/getpidcon.c                               | 4 +++-
> >  libselinux/utils/policyvers.c                              | 4 +++-
> >  libselinux/utils/selabel_digest.c                          | 2 +-
> >  libselinux/utils/selabel_get_digests_all_partial_matches.c | 3 ++-
> >  libselinux/utils/selabel_lookup.c                          | 3 ++-
> >  libselinux/utils/selabel_lookup_best_match.c               | 3 ++-
> >  libselinux/utils/selabel_partial_match.c                   | 3 ++-
> >  libselinux/utils/setenforce.c                              | 3 ++-
> >  libselinux/utils/setfilecon.c                              | 6 ++++--
> >  17 files changed, 41 insertions(+), 22 deletions(-)
> >
> > diff --git a/libselinux/utils/compute_av.c b/libselinux/utils/compute_a=
v.c
> > index ef08338f..cca407d6 100644
> > --- a/libselinux/utils/compute_av.c
> > +++ b/libselinux/utils/compute_av.c
> > @@ -2,6 +2,7 @@
> >  #include <sys/types.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> > +#include <string.h>
> >  #include <errno.h>
> >  #include <selinux/selinux.h>
> >
> > @@ -35,7 +36,7 @@ int main(int argc, char **argv)
> >
> >         ret =3D security_compute_av(argv[1], argv[2], tclass, 1, &avd);
> >         if (ret < 0) {
> > -               fprintf(stderr, "%s:  security_compute_av failed\n", ar=
gv[0]);
> > +               fprintf(stderr, "%s:  security_compute_av failed:  %s\n=
", argv[0], strerror(errno));
> >                 exit(3);
> >         }
> >
> > diff --git a/libselinux/utils/compute_create.c b/libselinux/utils/compu=
te_create.c
> > index 63029c19..c6481f4b 100644
> > --- a/libselinux/utils/compute_create.c
> > +++ b/libselinux/utils/compute_create.c
> > @@ -2,6 +2,7 @@
> >  #include <sys/types.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> > +#include <string.h>
> >  #include <errno.h>
> >  #include <selinux/selinux.h>
> >
> > @@ -35,8 +36,8 @@ int main(int argc, char **argv)
> >
> >         ret =3D security_compute_create(argv[1], argv[2], tclass, &buf)=
;
> >         if (ret < 0) {
> > -               fprintf(stderr, "%s:  security_compute_create failed\n"=
,
> > -                       argv[0]);
> > +               fprintf(stderr, "%s:  security_compute_create failed:  =
%s\n",
> > +                       argv[0], strerror(errno));
> >                 exit(3);
> >         }
> >
> > diff --git a/libselinux/utils/compute_member.c b/libselinux/utils/compu=
te_member.c
> > index 1ef47c25..9fe790ee 100644
> > --- a/libselinux/utils/compute_member.c
> > +++ b/libselinux/utils/compute_member.c
> > @@ -2,6 +2,7 @@
> >  #include <sys/types.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> > +#include <string.h>
> >  #include <errno.h>
> >  #include <selinux/selinux.h>
> >
> > @@ -35,8 +36,8 @@ int main(int argc, char **argv)
> >
> >         ret =3D security_compute_member(argv[1], argv[2], tclass, &buf)=
;
> >         if (ret < 0) {
> > -               fprintf(stderr, "%s:  security_compute_member failed\n"=
,
> > -                       argv[0]);
> > +               fprintf(stderr, "%s:  security_compute_member failed:  =
%s\n",
> > +                       argv[0], strerror(errno));
> >                 exit(3);
> >         }
> >
> > diff --git a/libselinux/utils/compute_relabel.c b/libselinux/utils/comp=
ute_relabel.c
> > index f6a957da..bdd39d0f 100644
> > --- a/libselinux/utils/compute_relabel.c
> > +++ b/libselinux/utils/compute_relabel.c
> > @@ -2,6 +2,7 @@
> >  #include <sys/types.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> > +#include <string.h>
> >  #include <errno.h>
> >  #include <selinux/selinux.h>
> >
> > @@ -35,8 +36,8 @@ int main(int argc, char **argv)
> >
> >         ret =3D security_compute_relabel(argv[1], argv[2], tclass, &buf=
);
> >         if (ret < 0) {
> > -               fprintf(stderr, "%s:  security_compute_relabel failed\n=
",
> > -                       argv[0]);
> > +               fprintf(stderr, "%s:  security_compute_relabel failed: =
 %s\n",
> > +                       argv[0], strerror(errno));
> >                 exit(3);
> >         }
> >
> > diff --git a/libselinux/utils/getconlist.c b/libselinux/utils/getconlis=
t.c
> > index 0bb28469..92f6a793 100644
> > --- a/libselinux/utils/getconlist.c
> > +++ b/libselinux/utils/getconlist.c
> > @@ -55,7 +55,7 @@ int main(int argc, char **argv)
> >         /* If a context wasn't passed, use the current context. */
> >         if (((argc - optind) < 2)) {
> >                 if (getcon(&cur_context) < 0) {
> > -                       fprintf(stderr, "Couldn't get current context.\=
n");
> > +                       fprintf(stderr, "Couldn't get current context: =
 %s\n", strerror(errno));
> >                         free(level);
> >                         return 2;
> >                 }
> > diff --git a/libselinux/utils/getdefaultcon.c b/libselinux/utils/getdef=
aultcon.c
> > index 590e98d9..93102e5e 100644
> > --- a/libselinux/utils/getdefaultcon.c
> > +++ b/libselinux/utils/getdefaultcon.c
> > @@ -62,7 +62,7 @@ int main(int argc, char **argv)
> >         /* If a context wasn't passed, use the current context. */
> >         if (((argc - optind) < 2)) {
> >                 if (getcon(&cur_context) < 0) {
> > -                       fprintf(stderr, "Couldn't get current context.\=
n");
> > +                       fprintf(stderr, "Couldn't get current context: =
 %s\n", strerror(errno));
> >                         return 2;
> >                 }
> >         } else
> > diff --git a/libselinux/utils/getenforce.c b/libselinux/utils/getenforc=
e.c
> > index e5d19c54..aeeb79a8 100644
> > --- a/libselinux/utils/getenforce.c
> > +++ b/libselinux/utils/getenforce.c
> > @@ -1,6 +1,8 @@
> >  #include <unistd.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> > +#include <string.h>
> > +#include <errno.h>
> >  #include <selinux/selinux.h>
> >
> >  int main(int argc __attribute__ ((unused)),
> > @@ -16,7 +18,7 @@ int main(int argc __attribute__ ((unused)),
> >         if (rc =3D=3D 1) {
> >                 rc =3D security_getenforce();
> >                 if (rc < 0) {
> > -                       fputs("getenforce:  getenforce() failed", stder=
r);
> > +                       fprintf(stderr, "getenforce:  security_getenfor=
ce() failed:  %s\n", strerror(errno));
> >                         return 2;
> >                 }
> >
> > diff --git a/libselinux/utils/getfilecon.c b/libselinux/utils/getfileco=
n.c
> > index 6266ae16..b823a1a1 100644
> > --- a/libselinux/utils/getfilecon.c
> > +++ b/libselinux/utils/getfilecon.c
> > @@ -1,6 +1,8 @@
> >  #include <unistd.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> > +#include <string.h>
> > +#include <errno.h>
> >  #include <selinux/selinux.h>
> >
> >  int main(int argc, char **argv)
> > @@ -16,8 +18,8 @@ int main(int argc, char **argv)
> >         for (i =3D 1; i < argc; i++) {
> >                 rc =3D getfilecon(argv[i], &buf);
> >                 if (rc < 0) {
> > -                       fprintf(stderr, "%s:  getfilecon(%s) failed\n",=
 argv[0],
> > -                               argv[i]);
> > +                       fprintf(stderr, "%s:  getfilecon(%s) failed:  %=
s\n", argv[0],
> > +                               argv[i], strerror(errno));
> >                         exit(2);
> >                 }
> >                 printf("%s\t%s\n", argv[i], buf);
> > diff --git a/libselinux/utils/getpidcon.c b/libselinux/utils/getpidcon.=
c
> > index ea6c274e..1a88fa6d 100644
> > --- a/libselinux/utils/getpidcon.c
> > +++ b/libselinux/utils/getpidcon.c
> > @@ -1,6 +1,8 @@
> >  #include <unistd.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> > +#include <string.h>
> > +#include <errno.h>
> >  #include <selinux/selinux.h>
> >
> >  int main(int argc, char **argv)
> > @@ -21,7 +23,7 @@ int main(int argc, char **argv)
> >
> >         rc =3D getpidcon(pid, &buf);
> >         if (rc < 0) {
> > -               fprintf(stderr, "%s:  getpidcon() failed\n", argv[0]);
> > +               fprintf(stderr, "%s:  getpidcon() failed:  %s\n", argv[=
0], strerror(errno));
> >                 exit(3);
> >         }
> >
> > diff --git a/libselinux/utils/policyvers.c b/libselinux/utils/policyver=
s.c
> > index dd56f2c7..5230bcaf 100644
> > --- a/libselinux/utils/policyvers.c
> > +++ b/libselinux/utils/policyvers.c
> > @@ -1,6 +1,8 @@
> >  #include <unistd.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> > +#include <string.h>
> > +#include <errno.h>
> >  #include <selinux/selinux.h>
> >
> >  int main(int argc __attribute__ ((unused)), char **argv)
> > @@ -9,7 +11,7 @@ int main(int argc __attribute__ ((unused)), char **arg=
v)
> >
> >         rc =3D security_policyvers();
> >         if (rc < 0) {
> > -               fprintf(stderr, "%s:  policyvers() failed\n", argv[0]);
> > +               fprintf(stderr, "%s:  security_policyvers() failed:  %s=
\n", argv[0], strerror(errno));
> >                 exit(2);
> >         }
> >
> > diff --git a/libselinux/utils/selabel_digest.c b/libselinux/utils/selab=
el_digest.c
> > index 49408a0b..6a8313a2 100644
> > --- a/libselinux/utils/selabel_digest.c
> > +++ b/libselinux/utils/selabel_digest.c
> > @@ -34,7 +34,7 @@ static int run_check_digest(char *cmd, char *selabel_=
digest)
> >
> >         fp =3D popen(cmd, "r");
> >         if (!fp) {
> > -               printf("Failed to run command line\n");
> > +               fprintf(stderr, "Failed to run command '%s':  %s\n", cm=
d, strerror(errno));
> >                 return -1;
> >         }
> >
> > diff --git a/libselinux/utils/selabel_get_digests_all_partial_matches.c=
 b/libselinux/utils/selabel_get_digests_all_partial_matches.c
> > index e28833d2..c4e0f836 100644
> > --- a/libselinux/utils/selabel_get_digests_all_partial_matches.c
> > +++ b/libselinux/utils/selabel_get_digests_all_partial_matches.c
> > @@ -77,7 +77,8 @@ int main(int argc, char **argv)
> >         hnd =3D selabel_open(SELABEL_CTX_FILE, selabel_option, 2);
> >         if (!hnd) {
> >                 fprintf(stderr, "ERROR: selabel_open - Could not obtain=
 "
> > -                                                            "handle.\n=
");
> > +                                                            "handle:  =
%s\n",
> > +                                                            strerror(e=
rrno));
> >                 return -1;
> >         }
> >
> > diff --git a/libselinux/utils/selabel_lookup.c b/libselinux/utils/selab=
el_lookup.c
> > index 1aef64de..112ffda1 100644
> > --- a/libselinux/utils/selabel_lookup.c
> > +++ b/libselinux/utils/selabel_lookup.c
> > @@ -91,7 +91,8 @@ int main(int argc, char **argv)
> >         hnd =3D selabel_open(backend, selabel_option, 2);
> >         if (!hnd) {
> >                 fprintf(stderr, "ERROR: selabel_open - Could not obtain=
 "
> > -                                                            "handle.\n=
");
> > +                                                            "handle:  =
%s\n",
> > +                                                            strerror(e=
rrno));
> >                 return -1;
> >         }
> >
> > diff --git a/libselinux/utils/selabel_lookup_best_match.c b/libselinux/=
utils/selabel_lookup_best_match.c
> > index 2cddc6cd..a4af0679 100644
> > --- a/libselinux/utils/selabel_lookup_best_match.c
> > +++ b/libselinux/utils/selabel_lookup_best_match.c
> > @@ -117,7 +117,8 @@ int main(int argc, char **argv)
> >         hnd =3D selabel_open(SELABEL_CTX_FILE, options, 2);
> >         if (!hnd) {
> >                 fprintf(stderr, "ERROR: selabel_open - Could not obtain=
 "
> > -                                                            "handle.\n=
");
> > +                                                            "handle:  =
%s\n",
> > +                                                            strerror(e=
rrno));
> >                 rc =3D -1;
> >                 goto out;
> >         }
> > diff --git a/libselinux/utils/selabel_partial_match.c b/libselinux/util=
s/selabel_partial_match.c
> > index c5932cb1..7bbd5777 100644
> > --- a/libselinux/utils/selabel_partial_match.c
> > +++ b/libselinux/utils/selabel_partial_match.c
> > @@ -61,7 +61,8 @@ int main(int argc, char **argv)
> >         hnd =3D selabel_open(SELABEL_CTX_FILE, selabel_option, 2);
> >         if (!hnd) {
> >                 fprintf(stderr, "ERROR: selabel_open - Could not obtain=
 "
> > -                                                            "handle.\n=
");
> > +                                                            "handle:  =
%s\n",
> > +                                                            strerror(e=
rrno));
> >                 return -1;
> >         }
> >
> > diff --git a/libselinux/utils/setenforce.c b/libselinux/utils/setenforc=
e.c
> > index 60a20a4b..67c13dca 100644
> > --- a/libselinux/utils/setenforce.c
> > +++ b/libselinux/utils/setenforce.c
> > @@ -4,6 +4,7 @@
> >  #include <ctype.h>
> >  #include <string.h>
> >  #include <strings.h>
> > +#include <errno.h>
> >  #include <selinux/selinux.h>
> >
> >  static __attribute__ ((__noreturn__)) void usage(const char *progname)
> > @@ -35,7 +36,7 @@ int main(int argc, char **argv)
> >                         usage(argv[0]);
> >         }
> >         if (rc < 0) {
> > -               fprintf(stderr, "%s:  setenforce() failed\n", argv[0]);
> > +               fprintf(stderr, "%s:  security_setenforce() failed:  %s=
\n", argv[0], strerror(errno));
> >                 return 2;
> >         }
> >         return 0;
> > diff --git a/libselinux/utils/setfilecon.c b/libselinux/utils/setfileco=
n.c
> > index 79af55de..a3fbc3ed 100644
> > --- a/libselinux/utils/setfilecon.c
> > +++ b/libselinux/utils/setfilecon.c
> > @@ -1,6 +1,8 @@
> >  #include <unistd.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> > +#include <string.h>
> > +#include <errno.h>
> >  #include <selinux/selinux.h>
> >
> >  int main(int argc, char **argv)
> > @@ -15,8 +17,8 @@ int main(int argc, char **argv)
> >         for (i =3D 2; i < argc; i++) {
> >                 rc =3D setfilecon(argv[i], argv[1]);
> >                 if (rc < 0) {
> > -                       fprintf(stderr, "%s:  setfilecon(%s,%s) failed\=
n",
> > -                               argv[0], argv[i], argv[1]);
> > +                       fprintf(stderr, "%s:  setfilecon(%s,%s) failed:=
  %s\n",
> > +                               argv[0], argv[i], argv[1], strerror(err=
no));
> >                         exit(2);
> >                 }
> >         }
> > --
> > 2.36.0
> >
