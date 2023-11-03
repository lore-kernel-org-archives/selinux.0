Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E157C0018C
	for <selinux@archiver.kernel.org>; Fri,  3 Nov 2023 18:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbjKCSY0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Nov 2023 14:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234166AbjKCSYZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Nov 2023 14:24:25 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71456DB
        for <selinux@vger.kernel.org>; Fri,  3 Nov 2023 11:24:20 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-45d90e1333fso472212137.3
        for <selinux@vger.kernel.org>; Fri, 03 Nov 2023 11:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1699035859; x=1699640659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsO+z1XRzYjf704mknDpzzjfCjG2dNr5a4jSQXO4hhw=;
        b=N3e7LtuOF4qRGmgdHFScFJG1GDmdKscNlxE7jGGuUcwPLu+noLSU6WHFm88JttR0eB
         2DnRsKz8d4ShFC78BPlavoVRA8IsVDUIjbxJUdetfsopifYj9hsVDk3IU+2MKfJN3qGH
         BY6LOJg4QaAJq23swr87cBhzfBv3uNRjjQ4DZO9CUeVNbgPwXdK7UpzG7zpbHBgMfRFY
         dCJSucxDlgll2zRC9JBbd5Am8Yxe8zGirYdALQqcEUdY3pgBgbXZC5rBsjOXYMaViPE2
         PPtpS4Uk+eL2Ye/jWiG6GWIzm7ZkUVbtaMctVu4eXh20ABsEB0QRb87xC27Tw8UoNGJv
         CiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699035859; x=1699640659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BsO+z1XRzYjf704mknDpzzjfCjG2dNr5a4jSQXO4hhw=;
        b=rstdrV8qr7g67DbD6GLwLJu9hKpXmu+53qF1JK6BSe/C8K1YwiRPguld/yam9Iyqd3
         p4TbBvJTo7FRNUfeo3Cb7Mk56Gn/ZF01kXoc52XBsZ5gy1cCo0LgGMQ7+Wk8vMZ5eCQl
         fGHr3YSwl3ZUiQ0na/Ix49FX14vY0bNBHomPS/o4u5SNQr0U7wLAn5AbNZMQBMA3I/Gr
         TzTPS9tQHq6b0ZNVPLBiSVD0gvYchluXBnAyePRQm6rIBfdRyiolf93BKGOkuXCgfEoT
         9TdsUbBP2nUIwPjOBK/ry623d+oSnb2nijgdmeUOBY6ZfWqest26uisl7z/X3V31HMUz
         G66Q==
X-Gm-Message-State: AOJu0YxLS8H0D37pNa02T23x9UXllke0zbpd5XqPwn6RfVC1yP+b8KcZ
        OCoBkmgnByhCr3SnoxXUa/DvfHBajWgsQyPid38=
X-Google-Smtp-Source: AGHT+IHVQq42yK9lh3ViCGdRp6XU2yLWfze4Tl4H8+Ehwrmi+iiblcwhsh1n1sqaB0Z7r+CYGEuhQvyaR5A0fsO3aUE=
X-Received: by 2002:a67:b205:0:b0:45d:7671:8253 with SMTP id
 b5-20020a67b205000000b0045d76718253mr5160811vsf.13.1699035859117; Fri, 03 Nov
 2023 11:24:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com>
 <20230814132025.45364-14-cgzones@googlemail.com> <CAP+JOzQXWc=pScMrxsSpn4=tR=CZYXzQRLL6MvZ+c8VmGFumew@mail.gmail.com>
 <CAJ2a_DcXJYeAyHwpx6A=cVM=Z55wy+PmhSpBekumn+VTndJELg@mail.gmail.com> <CAP+JOzS+bY8g+ccxOKkny31DNbZXC5vA=y1ETXuK2xNoH5MggQ@mail.gmail.com>
In-Reply-To: <CAP+JOzS+bY8g+ccxOKkny31DNbZXC5vA=y1ETXuK2xNoH5MggQ@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Fri, 3 Nov 2023 19:24:08 +0100
Message-ID: <CAJ2a_DcYug6JOi-0Ap-r_vjxDpk2PgJoGyjyQx97OTQCJUtZaw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 13/27] libselinux/utils: introduce selabel_compare
To:     James Carter <jwcart2@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 1 Nov 2023 at 21:57, James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Nov 1, 2023 at 12:47=E2=80=AFPM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > On Thu, 5 Oct 2023 at 17:29, James Carter <jwcart2@gmail.com> wrote:
> > >
> > > On Mon, Aug 14, 2023 at 9:42=E2=80=AFAM Christian G=C3=B6ttsche
> > > <cgzones@googlemail.com> wrote:
> > > >
> > > > Add a utility around selabel_cmp(3).
> > > >
> > > > Can be used by users to compare a pre-compiled fcontext file to an
> > > > original text-based file context definition file.
> > > >
> > > > Can be used for development to verify compilation and parsing of th=
e
> > > > pre-compiled fcontext format works correctly.
> > > >
> > > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > > ---
> > > >  libselinux/utils/.gitignore        |   1 +
> > > >  libselinux/utils/selabel_compare.c | 119 +++++++++++++++++++++++++=
++++
> > > >  2 files changed, 120 insertions(+)
> > > >  create mode 100644 libselinux/utils/selabel_compare.c
> > > >
> > > > diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitign=
ore
> > > > index a92e1e94..4e2dfba8 100644
> > > > --- a/libselinux/utils/.gitignore
> > > > +++ b/libselinux/utils/.gitignore
> > > > @@ -16,6 +16,7 @@ getseuser
> > > >  matchpathcon
> > > >  policyvers
> > > >  sefcontext_compile
> > > > +selabel_compare
> > > >  selabel_digest
> > > >  selabel_get_digests_all_partial_matches
> > > >  selabel_lookup
> > > > diff --git a/libselinux/utils/selabel_compare.c b/libselinux/utils/=
selabel_compare.c
> > > > new file mode 100644
> > > > index 00000000..f4325f7e
> > > > --- /dev/null
> > > > +++ b/libselinux/utils/selabel_compare.c
> > > > @@ -0,0 +1,119 @@
> > > > +#include <getopt.h>
> > > > +#include <stdio.h>
> > > > +#include <stdlib.h>
> > > > +#include <string.h>
> > > > +
> > > > +#include <selinux/label.h>
> > > > +
> > > > +
> > > > +static void usage(const char *progname)
> > > > +{
> > > > +       fprintf(stderr,
> > > > +               "usage: %s [-b backend] [-v] file1 file2\n\n"
> > > > +               "Where:\n\t"
> > > > +               "-b           The backend - \"file\", \"media\", \"=
x\", \"db\" or \"prop\" (defaults to \"file\")\n\t"
> > > > +               "-v           Validate entries against loaded polic=
y.\n\t"
> > > > +               "file1/file2  Files containing the specs.\n",
> > > > +               progname);
> > > > +}
> > > > +
> > > > +int main(int argc, char *argv[])
> > > > +{
> > > > +       unsigned int backend =3D SELABEL_CTX_FILE;
> > > > +       int opt;
> > > > +       const char *validate =3D NULL, *file1 =3D NULL, *file2 =3D =
NULL;
> > > > +
> > > > +       if (argc < 3) {
> > > > +               usage(argv[0]);
> > > > +               return EXIT_FAILURE;
> > > > +       }
> > > > +
> > > > +       while ((opt =3D getopt(argc, argv, "b:v")) > 0) {
> > > > +               switch (opt) {
> > > > +               case 'b':
> > > > +                       if (!strcasecmp(optarg, "file")) {
> > > > +                               backend =3D SELABEL_CTX_FILE;
> > > > +                       } else if (!strcmp(optarg, "media")) {
> > > > +                               backend =3D SELABEL_CTX_MEDIA;
> > > > +                       } else if (!strcmp(optarg, "x")) {
> > > > +                               backend =3D SELABEL_CTX_X;
> > > > +                       } else if (!strcmp(optarg, "db")) {
> > > > +                               backend =3D SELABEL_CTX_DB;
> > > > +                       } else if (!strcmp(optarg, "prop")) {
> > > > +                               backend =3D SELABEL_CTX_ANDROID_PRO=
P;
> > > > +                       } else if (!strcmp(optarg, "service")) {
> > > > +                               backend =3D SELABEL_CTX_ANDROID_SER=
VICE;
> > > > +                       } else {
> > > > +                               fprintf(stderr, "Unknown backend: %=
s\n", optarg);
> > > > +                               usage(argv[0]);
> > > > +                               return EXIT_FAILURE;
> > > > +                       }
> > > > +                       break;
> > > > +               case 'v':
> > > > +                       validate =3D (char *)1;
> > > > +                       break;
> > > > +               default:
> > > > +                       usage(argv[0]);
> > > > +                       return EXIT_FAILURE;
> > > > +               }
> > > > +       }
> > > > +
> > > > +       if (argc !=3D optind + 2) {
> > > > +               usage(argv[0]);
> > > > +               return EXIT_FAILURE;
> > > > +       }
> > > > +
> > > > +       file1 =3D argv[optind++];
> > > > +       file2 =3D argv[optind];
> > > > +
> > > > +       {
> > >
> > > To me, having a block like this means that the stuff below should be
> > > in a helper function.
> > >
> > > Everything else looks good.
> > > Jim
> > >
> >
> > I didn't want to split the function to complicate the reasoning by
> > splitting the control flow, introducing 4 function parameters, and
> > adding return value handling.
> > Do you still prefer to split?
> > (I'll send a v2 regardless for a typo below)
> >
>
> Yes, I would.

Fair enough. I am not going to send a standalone version of this patch
though, since the current compare function can not handle compiled
regular expressions, e.g.:

    $ DESTDIR=3D/tmp/destdir/ ../selinux/scripts/env_use_destdir
/tmp/destdir/usr/sbin/selabel_compare file_contexts.bin
file_contexts.bin
    selabel_cmp: mismatched regex on entry 0: (/.*, 0,
system_u:object_r:default_t) vs entry 0: (/.*, 0,
system_u:object_r:default_t)
    spec file_contexts.bin is uncompareable to spec file_contexts.bin

> Something like this:
>
> static enum selabel_cmp_result compare(unsigned int backend, const
> char *file1, const char *file2, const char *validate)
> {
>     struct selabel_handle *hnd1, *hnd2;
>     const struct selinux_opt selabel_option1[] =3D {
>         { SELABEL_OPT_PATH, file1 },
>         { SELABEL_OPT_VALIDATE, validate }
>     };
>     const struct selinux_opt selabel_option2[] =3D {
>         { SELABEL_OPT_PATH, file2 },
>         { SELABEL_OPT_VALIDATE, validate }
>     };
>     enum selabel_cmp_result result;
>
>     hnd1 =3D selabel_open(backend, selabel_option1, 2);
>     if (!hnd1) {
>         fprintf(stderr, "ERROR: selabel_open - Could not obtain handle
> for %s:  %m\n", file1);
>         return EXIT_FAILURE;
>     }
>
>     hnd2 =3D selabel_open(backend, selabel_option2, 2);
>     if (!hnd2) {
>         fprintf(stderr, "ERROR: selabel_open - Could not obtain handle
> for %s:  %m\n", file2);
>         selabel_close(hnd1);
>         return EXIT_FAILURE;
>     }
>
>     result =3D selabel_cmp(hnd1, hnd2);
>
>     selabel_close(hnd2);
>     selabel_close(hnd1);
>     return result;
> }
>
> ...
>
> int main(int argc, char *argv[])
> {
> ...
>     result =3D compare(backend, file1, file2, validate);
>     switch (result) {
>     case SELABEL_SUBSET:
>         printf("spec %s is a subset of spec %s\n", file1, file2);
>         break;
>     case SELABEL_EQUAL:
>         printf("spec %s is equal to spec %s\n", file1, file2);
>         break;
>     case SELABEL_SUPERSET:
>         printf("spec %s is a superset of spec %s\n", file1, file2);
>         break;
>     case SELABEL_INCOMPARABLE:
>         printf("spec %s is uncompareable to spec %s\n", file1, file2);
>         break;
>     default:
>         fprintf(stderr, "ERROR: selabel_cmp - Unexpected result %d\n", re=
sult);
>         return EXIT_FAILURE;
>     }
>
>     return EXIT_SUCCESS;
> }
>
> You can probably think of a better name for the function.
>
> Thanks,
> Jim
>
>
> > >
> > > > +               struct selabel_handle *hnd1, *hnd2;
> > > > +               const struct selinux_opt selabel_option1[] =3D {
> > > > +                       { SELABEL_OPT_PATH, file1 },
> > > > +                       { SELABEL_OPT_VALIDATE, validate }
> > > > +               };
> > > > +               const struct selinux_opt selabel_option2[] =3D {
> > > > +                       { SELABEL_OPT_PATH, file2 },
> > > > +                       { SELABEL_OPT_VALIDATE, validate }
> > > > +               };
> > > > +               enum selabel_cmp_result result;
> > > > +
> > > > +               hnd1 =3D selabel_open(backend, selabel_option1, 2);
> > > > +               if (!hnd1) {
> > > > +                       fprintf(stderr, "ERROR: selabel_open - Coul=
d not obtain handle for %s:  %m\n", file1);
> > > > +                       return EXIT_FAILURE;
> > > > +               }
> > > > +
> > > > +               hnd2 =3D selabel_open(backend, selabel_option2, 2);
> > > > +               if (!hnd2) {
> > > > +                       fprintf(stderr, "ERROR: selabel_open - Coul=
d not obtain handle for %s:  %m\n", file2);
> > > > +                       selabel_close(hnd1);
> > > > +                       return EXIT_FAILURE;
> > > > +               }
> > > > +
> > > > +               result =3D selabel_cmp(hnd1, hnd2);
> > > > +
> > > > +               selabel_close(hnd2);
> > > > +               selabel_close(hnd1);
> > > > +
> > > > +               switch (result) {
> > > > +               case SELABEL_SUBSET:
> > > > +                       printf("spec %s is a subset of spec %s\n", =
file1, file2);
> > > > +                       break;
> > > > +               case SELABEL_EQUAL:
> > > > +                       printf("spec %s is equal to spec %s\n", fil=
e1, file2);
> > > > +                       break;
> > > > +               case SELABEL_SUPERSET:
> > > > +                       printf("spec %s is a superset of spec %s\n"=
, file1, file2);
> > > > +                       break;
> > > > +               case SELABEL_INCOMPARABLE:
> > > > +                       printf("spec %s is uncompareable to spec %s=
\n", file1, file2);
> > > > +                       break;
> > > > +               default:
> > > > +                       fprintf(stderr, "ERROR: selabel_cmp - Unexp=
ected result %d\n", result);
> > > > +                       return EXIT_FAILURE;
> > > > +               }
> > > > +
> > > > +               return EXIT_SUCCESS;
> > > > +       }
> > > > +}
> > > > --
> > > > 2.40.1
> > > >
