Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6EAC433EF
	for <selinux@archiver.kernel.org>; Tue, 10 May 2022 17:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348014AbiEJR1E (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 May 2022 13:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348064AbiEJR1B (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 May 2022 13:27:01 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126DE56429
        for <selinux@vger.kernel.org>; Tue, 10 May 2022 10:22:49 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id r1so19242599oie.4
        for <selinux@vger.kernel.org>; Tue, 10 May 2022 10:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F96CDkITzuhjQai1BuhFRd5AOEgI2AiRfYqilurEZnU=;
        b=Aua8oV0uLfxnI118WJvMvYNx2kgSGxbmcpNNFFeZ5FF5ummLae2n7JBK/OJ/lQ2iXj
         /2w7gOHcTuykKREhVevmtw1xoflcWonGMyz0LW/R6NG52m1FBF4JwPoNVC83NXroaOdU
         iR9c8VE8qdNJsfZqxfzJ97D3hNOvNknLoOJA1ugLp2ywCpVu5LxHVmKW6saBtUeGZ9J7
         1hJ8g6g5JD+X1/wfi4O3R3CY3nZ2c7B/c1XpgXT2aOq76JMl/AXEEDPzV0OdN+qDq39R
         adrygpbz3uznFbGMBLEgRj1WnwqeuQKwwk02JaTZg1A6+hLvMRMHBA5/+AsMBxbWnDfX
         nnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F96CDkITzuhjQai1BuhFRd5AOEgI2AiRfYqilurEZnU=;
        b=76B4lMOtcGQ6u62W2cEs3LIYfIC8smxS7dgw6442RPr53b1GHAn4/lgmeI01p4ORoG
         C3E52C7j013R0WaA+bXDHQHGqV36xDrZFcXMy5jTx0p8fzdT5wQDjYpVRv5EY8HWWpLa
         wYuXnWcBhvVC6MvM0ty8weCbSZvDL5sG0zURPid9HcBPsyowPkNMblR4HnxMkyRmPYfa
         g9ABv9kzRo3NbGk+bbSJvHbm76DDpUP9gk9wxyTZ6Lum5Fb2NnOzmQ3/3FyRP3tWjsGX
         Ki16dK1s1kvNZcHfJHJTI++dEBIY19YM6sSraSV06sjbQZVhYbwTHwBCY9ql+elD3ewG
         97og==
X-Gm-Message-State: AOAM530LJsH22l7zmj7fwCdY1Dhqbk+b0M3FhkRPB2j8ZGJvcV+Y2i4N
        8fZupJ2TE2Ct2bk/2neeGxDYYI7xU/uBAegvNv0=
X-Google-Smtp-Source: ABdhPJzNSzM6DP5FGvUHLUAg9bqCGwmfzzKZePmX4Wa9SDMIVvg/lhiBqjgP9W5/OrE9tbYEqxAEPBlFBcghEVOD8K0=
X-Received: by 2002:a05:6808:3009:b0:2f9:6119:d676 with SMTP id
 ay9-20020a056808300900b002f96119d676mr537241oib.205.1652203368191; Tue, 10
 May 2022 10:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220505174401.24442-1-cgzones@googlemail.com> <CAP+JOzRyJX-sWThenQNAqsXrxKkqaqWythPubHAXZDnkOP2FDQ@mail.gmail.com>
In-Reply-To: <CAP+JOzRyJX-sWThenQNAqsXrxKkqaqWythPubHAXZDnkOP2FDQ@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Tue, 10 May 2022 19:22:37 +0200
Message-ID: <CAJ2a_DeT6fRFusWyrWRrKTF0emFufnJrAOSa2dEVC5=w5yc1UA@mail.gmail.com>
Subject: Re: [PATCH] libselinux/utils: print errno on failure
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 9 May 2022 at 16:38, James Carter <jwcart2@gmail.com> wrote:
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
>
> Back in August you converted a bunch of strerror() uses in libselinux
> to instead use "%m" for thread safety. Since all of these are for
> utility programs and not the main library, thread safety is not a
> concern, but is there any reason not to just use "%m"?

None to my knowledge, other than matching the surrounding code.

>
> Jim
>
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
