Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70040C4332F
	for <selinux@archiver.kernel.org>; Wed,  1 Nov 2023 20:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbjKAU5U (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Nov 2023 16:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjKAU5T (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Nov 2023 16:57:19 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A243B10C
        for <selinux@vger.kernel.org>; Wed,  1 Nov 2023 13:57:16 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5094727fa67so182219e87.3
        for <selinux@vger.kernel.org>; Wed, 01 Nov 2023 13:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698872235; x=1699477035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpyjsz+m+2VaCLryeyYNJFD+0z3gFCwmA/WZUnVC5FQ=;
        b=E0Dr/8PWdCN725d8pmX1/S3WPHwx1k7+QXYMY9GtNy/8y0KFTsmNQ7g3ImCr3fimLd
         KAyDmf9DXmYj22hHilN+smE2jjfRAsZI4nONak65pQGEeOMfNEBTbC3oXtMHm8xA10HP
         ZPriyqWK/vZTzTKF9U10mNOqJZhm0omue2svr12NBYitCiDhqwayr6h6HePhAEuAxoxR
         yC+M2RfY9m422m+0yxO5XDzqp29FfxXpnahhyb88zmKQQdK6tWY4Tni8oEGUxQSZqbRB
         ITuNiRq7DVmc+Zo3D28FgCMb2YJV9XeYheGKDy1394HmANTnb65oviN5bfBZuNxomPgC
         6LJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698872235; x=1699477035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpyjsz+m+2VaCLryeyYNJFD+0z3gFCwmA/WZUnVC5FQ=;
        b=mFOvX5sgNYs5f5PNg7+iaZSL/YvVSO5jfLxGcLodDcZ1s8v5R/RjPKuqsPz9eb0jle
         lBcpMI2NLOELvu79h5lEZHEgu+srm4pQCEVEO03cnIyiGUFHSrdX9g92iw6qaG5GzKYm
         eAc+PQT3XCdMFnZwAUcjbNz5Q+72R7msKAoy611AI9omPrg4q/oEHyG9vOzQZsW0hyWr
         KpWaA4UbhYvaQGO+lwNF+Mqoy+4UccFOy3pU5i5x1oiKlFdiJw/bbMIijLcFJZ1mZqK2
         q1tsKqkJfF9f11Q2D7jfg2GkS6ENyDKsj49UzpMHm7sWZu2ZK3OGF79f4PdmQy6Xpq3G
         alLQ==
X-Gm-Message-State: AOJu0YzTQ79hWrpfrZLOJknOBul+qMR4a0G7xyub9hVajBKuQC7tsMSt
        DjHG05SGFqOdDhQMlGZj79rq39KM746RgZjMwj0=
X-Google-Smtp-Source: AGHT+IFpTQF2fiLm1X1MgwoP2OZsUHFC83FibtNA+T5ebvU12eYJD2IyHmQSqDqLnSXf+xzW/plfBWkarIRA7S/ebD4=
X-Received: by 2002:a19:5517:0:b0:500:b7ed:1055 with SMTP id
 n23-20020a195517000000b00500b7ed1055mr11361726lfe.56.1698872234581; Wed, 01
 Nov 2023 13:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com>
 <20230814132025.45364-14-cgzones@googlemail.com> <CAP+JOzQXWc=pScMrxsSpn4=tR=CZYXzQRLL6MvZ+c8VmGFumew@mail.gmail.com>
 <CAJ2a_DcXJYeAyHwpx6A=cVM=Z55wy+PmhSpBekumn+VTndJELg@mail.gmail.com>
In-Reply-To: <CAJ2a_DcXJYeAyHwpx6A=cVM=Z55wy+PmhSpBekumn+VTndJELg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 1 Nov 2023 16:57:03 -0400
Message-ID: <CAP+JOzS+bY8g+ccxOKkny31DNbZXC5vA=y1ETXuK2xNoH5MggQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 13/27] libselinux/utils: introduce selabel_compare
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 1, 2023 at 12:47=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Thu, 5 Oct 2023 at 17:29, James Carter <jwcart2@gmail.com> wrote:
> >
> > On Mon, Aug 14, 2023 at 9:42=E2=80=AFAM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > >
> > > Add a utility around selabel_cmp(3).
> > >
> > > Can be used by users to compare a pre-compiled fcontext file to an
> > > original text-based file context definition file.
> > >
> > > Can be used for development to verify compilation and parsing of the
> > > pre-compiled fcontext format works correctly.
> > >
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > ---
> > >  libselinux/utils/.gitignore        |   1 +
> > >  libselinux/utils/selabel_compare.c | 119 +++++++++++++++++++++++++++=
++
> > >  2 files changed, 120 insertions(+)
> > >  create mode 100644 libselinux/utils/selabel_compare.c
> > >
> > > diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignor=
e
> > > index a92e1e94..4e2dfba8 100644
> > > --- a/libselinux/utils/.gitignore
> > > +++ b/libselinux/utils/.gitignore
> > > @@ -16,6 +16,7 @@ getseuser
> > >  matchpathcon
> > >  policyvers
> > >  sefcontext_compile
> > > +selabel_compare
> > >  selabel_digest
> > >  selabel_get_digests_all_partial_matches
> > >  selabel_lookup
> > > diff --git a/libselinux/utils/selabel_compare.c b/libselinux/utils/se=
label_compare.c
> > > new file mode 100644
> > > index 00000000..f4325f7e
> > > --- /dev/null
> > > +++ b/libselinux/utils/selabel_compare.c
> > > @@ -0,0 +1,119 @@
> > > +#include <getopt.h>
> > > +#include <stdio.h>
> > > +#include <stdlib.h>
> > > +#include <string.h>
> > > +
> > > +#include <selinux/label.h>
> > > +
> > > +
> > > +static void usage(const char *progname)
> > > +{
> > > +       fprintf(stderr,
> > > +               "usage: %s [-b backend] [-v] file1 file2\n\n"
> > > +               "Where:\n\t"
> > > +               "-b           The backend - \"file\", \"media\", \"x\=
", \"db\" or \"prop\" (defaults to \"file\")\n\t"
> > > +               "-v           Validate entries against loaded policy.=
\n\t"
> > > +               "file1/file2  Files containing the specs.\n",
> > > +               progname);
> > > +}
> > > +
> > > +int main(int argc, char *argv[])
> > > +{
> > > +       unsigned int backend =3D SELABEL_CTX_FILE;
> > > +       int opt;
> > > +       const char *validate =3D NULL, *file1 =3D NULL, *file2 =3D NU=
LL;
> > > +
> > > +       if (argc < 3) {
> > > +               usage(argv[0]);
> > > +               return EXIT_FAILURE;
> > > +       }
> > > +
> > > +       while ((opt =3D getopt(argc, argv, "b:v")) > 0) {
> > > +               switch (opt) {
> > > +               case 'b':
> > > +                       if (!strcasecmp(optarg, "file")) {
> > > +                               backend =3D SELABEL_CTX_FILE;
> > > +                       } else if (!strcmp(optarg, "media")) {
> > > +                               backend =3D SELABEL_CTX_MEDIA;
> > > +                       } else if (!strcmp(optarg, "x")) {
> > > +                               backend =3D SELABEL_CTX_X;
> > > +                       } else if (!strcmp(optarg, "db")) {
> > > +                               backend =3D SELABEL_CTX_DB;
> > > +                       } else if (!strcmp(optarg, "prop")) {
> > > +                               backend =3D SELABEL_CTX_ANDROID_PROP;
> > > +                       } else if (!strcmp(optarg, "service")) {
> > > +                               backend =3D SELABEL_CTX_ANDROID_SERVI=
CE;
> > > +                       } else {
> > > +                               fprintf(stderr, "Unknown backend: %s\=
n", optarg);
> > > +                               usage(argv[0]);
> > > +                               return EXIT_FAILURE;
> > > +                       }
> > > +                       break;
> > > +               case 'v':
> > > +                       validate =3D (char *)1;
> > > +                       break;
> > > +               default:
> > > +                       usage(argv[0]);
> > > +                       return EXIT_FAILURE;
> > > +               }
> > > +       }
> > > +
> > > +       if (argc !=3D optind + 2) {
> > > +               usage(argv[0]);
> > > +               return EXIT_FAILURE;
> > > +       }
> > > +
> > > +       file1 =3D argv[optind++];
> > > +       file2 =3D argv[optind];
> > > +
> > > +       {
> >
> > To me, having a block like this means that the stuff below should be
> > in a helper function.
> >
> > Everything else looks good.
> > Jim
> >
>
> I didn't want to split the function to complicate the reasoning by
> splitting the control flow, introducing 4 function parameters, and
> adding return value handling.
> Do you still prefer to split?
> (I'll send a v2 regardless for a typo below)
>

Yes, I would.
Something like this:

static enum selabel_cmp_result compare(unsigned int backend, const
char *file1, const char *file2, const char *validate)
{
    struct selabel_handle *hnd1, *hnd2;
    const struct selinux_opt selabel_option1[] =3D {
        { SELABEL_OPT_PATH, file1 },
        { SELABEL_OPT_VALIDATE, validate }
    };
    const struct selinux_opt selabel_option2[] =3D {
        { SELABEL_OPT_PATH, file2 },
        { SELABEL_OPT_VALIDATE, validate }
    };
    enum selabel_cmp_result result;

    hnd1 =3D selabel_open(backend, selabel_option1, 2);
    if (!hnd1) {
        fprintf(stderr, "ERROR: selabel_open - Could not obtain handle
for %s:  %m\n", file1);
        return EXIT_FAILURE;
    }

    hnd2 =3D selabel_open(backend, selabel_option2, 2);
    if (!hnd2) {
        fprintf(stderr, "ERROR: selabel_open - Could not obtain handle
for %s:  %m\n", file2);
        selabel_close(hnd1);
        return EXIT_FAILURE;
    }

    result =3D selabel_cmp(hnd1, hnd2);

    selabel_close(hnd2);
    selabel_close(hnd1);
    return result;
}

...

int main(int argc, char *argv[])
{
...
    result =3D compare(backend, file1, file2, validate);
    switch (result) {
    case SELABEL_SUBSET:
        printf("spec %s is a subset of spec %s\n", file1, file2);
        break;
    case SELABEL_EQUAL:
        printf("spec %s is equal to spec %s\n", file1, file2);
        break;
    case SELABEL_SUPERSET:
        printf("spec %s is a superset of spec %s\n", file1, file2);
        break;
    case SELABEL_INCOMPARABLE:
        printf("spec %s is uncompareable to spec %s\n", file1, file2);
        break;
    default:
        fprintf(stderr, "ERROR: selabel_cmp - Unexpected result %d\n", resu=
lt);
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}

You can probably think of a better name for the function.

Thanks,
Jim


> >
> > > +               struct selabel_handle *hnd1, *hnd2;
> > > +               const struct selinux_opt selabel_option1[] =3D {
> > > +                       { SELABEL_OPT_PATH, file1 },
> > > +                       { SELABEL_OPT_VALIDATE, validate }
> > > +               };
> > > +               const struct selinux_opt selabel_option2[] =3D {
> > > +                       { SELABEL_OPT_PATH, file2 },
> > > +                       { SELABEL_OPT_VALIDATE, validate }
> > > +               };
> > > +               enum selabel_cmp_result result;
> > > +
> > > +               hnd1 =3D selabel_open(backend, selabel_option1, 2);
> > > +               if (!hnd1) {
> > > +                       fprintf(stderr, "ERROR: selabel_open - Could =
not obtain handle for %s:  %m\n", file1);
> > > +                       return EXIT_FAILURE;
> > > +               }
> > > +
> > > +               hnd2 =3D selabel_open(backend, selabel_option2, 2);
> > > +               if (!hnd2) {
> > > +                       fprintf(stderr, "ERROR: selabel_open - Could =
not obtain handle for %s:  %m\n", file2);
> > > +                       selabel_close(hnd1);
> > > +                       return EXIT_FAILURE;
> > > +               }
> > > +
> > > +               result =3D selabel_cmp(hnd1, hnd2);
> > > +
> > > +               selabel_close(hnd2);
> > > +               selabel_close(hnd1);
> > > +
> > > +               switch (result) {
> > > +               case SELABEL_SUBSET:
> > > +                       printf("spec %s is a subset of spec %s\n", fi=
le1, file2);
> > > +                       break;
> > > +               case SELABEL_EQUAL:
> > > +                       printf("spec %s is equal to spec %s\n", file1=
, file2);
> > > +                       break;
> > > +               case SELABEL_SUPERSET:
> > > +                       printf("spec %s is a superset of spec %s\n", =
file1, file2);
> > > +                       break;
> > > +               case SELABEL_INCOMPARABLE:
> > > +                       printf("spec %s is uncompareable to spec %s\n=
", file1, file2);
> > > +                       break;
> > > +               default:
> > > +                       fprintf(stderr, "ERROR: selabel_cmp - Unexpec=
ted result %d\n", result);
> > > +                       return EXIT_FAILURE;
> > > +               }
> > > +
> > > +               return EXIT_SUCCESS;
> > > +       }
> > > +}
> > > --
> > > 2.40.1
> > >
