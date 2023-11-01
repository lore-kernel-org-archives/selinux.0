Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B08C4332F
	for <selinux@archiver.kernel.org>; Wed,  1 Nov 2023 16:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbjKAQre (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Nov 2023 12:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjKAQre (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Nov 2023 12:47:34 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8B2FD
        for <selinux@vger.kernel.org>; Wed,  1 Nov 2023 09:47:28 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-457c82cd837so2971952137.2
        for <selinux@vger.kernel.org>; Wed, 01 Nov 2023 09:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1698857247; x=1699462047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfnZjqPN2j1ptrFILft7mNVqeReFBkyAbhM+XM9/geQ=;
        b=VYPbjSDJsTjUtTRVuTm+yr0X5dqiHkp7AREvGWH0FKXywIZHQdnol/b/Ns+WmOzwIJ
         AfHLPYAmGq/lWcu8mxEHW+uSeZ82uiXywn4+xFNzctCsAEJR64014WWq5cgrvmazqDA/
         HfEBzNOSeBNq4anlCrcxcbUOGDCw6bpNLDfYPKzTyeM/6X2sdlR7h6Na/v/2Qxd305Bx
         +wLrJQj5Ks7JcTVg6Fnu0XCLdeyHqEjrC/9yFZvpb3cobskIGUFuITCEGf/1mVL+atcw
         t3RhZpEY1YN+zlTD95JOxStE7R2IOiixrds9LfctibrCVclhocjMLPAZueit0iaFg4NV
         pyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698857247; x=1699462047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KfnZjqPN2j1ptrFILft7mNVqeReFBkyAbhM+XM9/geQ=;
        b=DC7k1+u1eDuYHF8q6kAO7C4eP89MwlKGll/bka1GGqocnbEzxfPAbClpfSMdcN5PCU
         SNczptFMl1+2lfnAct48Xu+ENy/GiXZolHSvVV/SuHN/6kMWbtDeXVaQWbtilQdjYTc7
         oYeYnpr+oK6HrFdgC4D8kpmRTmfVV/XAD62rVExGPux6i0BAhtaWd7J6e106N+fvsBRd
         SzPtfSDmw5nt+NXNMMOM2LJNKCM3QM/j7f63b8LZER0X2gQGbRF8zqTRauveh0RTl0Dn
         26PT3Sk6EoVeRshWUohpUSuz7dHu+xG4ec/u71bQT44sn6ljj577vj4nsYZ1SdI6Yum9
         wrGQ==
X-Gm-Message-State: AOJu0YxVZgtebRLABdVLd0xqgcL8IhubXVUs9Qtr1snynLK1H0AMtP2A
        O2rANFNlG+yWia6wsyNGgFmGfMD24/c/tWTjEtQ=
X-Google-Smtp-Source: AGHT+IE2uH5WFEau8zxkYF76AYyUGOBfll+40DxggEiEzGODnyQVd5kpcA9GrLZrN/6RIokZTZC1BRDLSu9qb9MUKKY=
X-Received: by 2002:a67:e0c6:0:b0:452:c3a4:1f99 with SMTP id
 m6-20020a67e0c6000000b00452c3a41f99mr15030203vsl.4.1698857247309; Wed, 01 Nov
 2023 09:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com>
 <20230814132025.45364-14-cgzones@googlemail.com> <CAP+JOzQXWc=pScMrxsSpn4=tR=CZYXzQRLL6MvZ+c8VmGFumew@mail.gmail.com>
In-Reply-To: <CAP+JOzQXWc=pScMrxsSpn4=tR=CZYXzQRLL6MvZ+c8VmGFumew@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Wed, 1 Nov 2023 17:47:16 +0100
Message-ID: <CAJ2a_DcXJYeAyHwpx6A=cVM=Z55wy+PmhSpBekumn+VTndJELg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 13/27] libselinux/utils: introduce selabel_compare
To:     James Carter <jwcart2@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 5 Oct 2023 at 17:29, James Carter <jwcart2@gmail.com> wrote:
>
> On Mon, Aug 14, 2023 at 9:42=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Add a utility around selabel_cmp(3).
> >
> > Can be used by users to compare a pre-compiled fcontext file to an
> > original text-based file context definition file.
> >
> > Can be used for development to verify compilation and parsing of the
> > pre-compiled fcontext format works correctly.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  libselinux/utils/.gitignore        |   1 +
> >  libselinux/utils/selabel_compare.c | 119 +++++++++++++++++++++++++++++
> >  2 files changed, 120 insertions(+)
> >  create mode 100644 libselinux/utils/selabel_compare.c
> >
> > diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignore
> > index a92e1e94..4e2dfba8 100644
> > --- a/libselinux/utils/.gitignore
> > +++ b/libselinux/utils/.gitignore
> > @@ -16,6 +16,7 @@ getseuser
> >  matchpathcon
> >  policyvers
> >  sefcontext_compile
> > +selabel_compare
> >  selabel_digest
> >  selabel_get_digests_all_partial_matches
> >  selabel_lookup
> > diff --git a/libselinux/utils/selabel_compare.c b/libselinux/utils/sela=
bel_compare.c
> > new file mode 100644
> > index 00000000..f4325f7e
> > --- /dev/null
> > +++ b/libselinux/utils/selabel_compare.c
> > @@ -0,0 +1,119 @@
> > +#include <getopt.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +
> > +#include <selinux/label.h>
> > +
> > +
> > +static void usage(const char *progname)
> > +{
> > +       fprintf(stderr,
> > +               "usage: %s [-b backend] [-v] file1 file2\n\n"
> > +               "Where:\n\t"
> > +               "-b           The backend - \"file\", \"media\", \"x\",=
 \"db\" or \"prop\" (defaults to \"file\")\n\t"
> > +               "-v           Validate entries against loaded policy.\n=
\t"
> > +               "file1/file2  Files containing the specs.\n",
> > +               progname);
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +       unsigned int backend =3D SELABEL_CTX_FILE;
> > +       int opt;
> > +       const char *validate =3D NULL, *file1 =3D NULL, *file2 =3D NULL=
;
> > +
> > +       if (argc < 3) {
> > +               usage(argv[0]);
> > +               return EXIT_FAILURE;
> > +       }
> > +
> > +       while ((opt =3D getopt(argc, argv, "b:v")) > 0) {
> > +               switch (opt) {
> > +               case 'b':
> > +                       if (!strcasecmp(optarg, "file")) {
> > +                               backend =3D SELABEL_CTX_FILE;
> > +                       } else if (!strcmp(optarg, "media")) {
> > +                               backend =3D SELABEL_CTX_MEDIA;
> > +                       } else if (!strcmp(optarg, "x")) {
> > +                               backend =3D SELABEL_CTX_X;
> > +                       } else if (!strcmp(optarg, "db")) {
> > +                               backend =3D SELABEL_CTX_DB;
> > +                       } else if (!strcmp(optarg, "prop")) {
> > +                               backend =3D SELABEL_CTX_ANDROID_PROP;
> > +                       } else if (!strcmp(optarg, "service")) {
> > +                               backend =3D SELABEL_CTX_ANDROID_SERVICE=
;
> > +                       } else {
> > +                               fprintf(stderr, "Unknown backend: %s\n"=
, optarg);
> > +                               usage(argv[0]);
> > +                               return EXIT_FAILURE;
> > +                       }
> > +                       break;
> > +               case 'v':
> > +                       validate =3D (char *)1;
> > +                       break;
> > +               default:
> > +                       usage(argv[0]);
> > +                       return EXIT_FAILURE;
> > +               }
> > +       }
> > +
> > +       if (argc !=3D optind + 2) {
> > +               usage(argv[0]);
> > +               return EXIT_FAILURE;
> > +       }
> > +
> > +       file1 =3D argv[optind++];
> > +       file2 =3D argv[optind];
> > +
> > +       {
>
> To me, having a block like this means that the stuff below should be
> in a helper function.
>
> Everything else looks good.
> Jim
>

I didn't want to split the function to complicate the reasoning by
splitting the control flow, introducing 4 function parameters, and
adding return value handling.
Do you still prefer to split?
(I'll send a v2 regardless for a typo below)

>
> > +               struct selabel_handle *hnd1, *hnd2;
> > +               const struct selinux_opt selabel_option1[] =3D {
> > +                       { SELABEL_OPT_PATH, file1 },
> > +                       { SELABEL_OPT_VALIDATE, validate }
> > +               };
> > +               const struct selinux_opt selabel_option2[] =3D {
> > +                       { SELABEL_OPT_PATH, file2 },
> > +                       { SELABEL_OPT_VALIDATE, validate }
> > +               };
> > +               enum selabel_cmp_result result;
> > +
> > +               hnd1 =3D selabel_open(backend, selabel_option1, 2);
> > +               if (!hnd1) {
> > +                       fprintf(stderr, "ERROR: selabel_open - Could no=
t obtain handle for %s:  %m\n", file1);
> > +                       return EXIT_FAILURE;
> > +               }
> > +
> > +               hnd2 =3D selabel_open(backend, selabel_option2, 2);
> > +               if (!hnd2) {
> > +                       fprintf(stderr, "ERROR: selabel_open - Could no=
t obtain handle for %s:  %m\n", file2);
> > +                       selabel_close(hnd1);
> > +                       return EXIT_FAILURE;
> > +               }
> > +
> > +               result =3D selabel_cmp(hnd1, hnd2);
> > +
> > +               selabel_close(hnd2);
> > +               selabel_close(hnd1);
> > +
> > +               switch (result) {
> > +               case SELABEL_SUBSET:
> > +                       printf("spec %s is a subset of spec %s\n", file=
1, file2);
> > +                       break;
> > +               case SELABEL_EQUAL:
> > +                       printf("spec %s is equal to spec %s\n", file1, =
file2);
> > +                       break;
> > +               case SELABEL_SUPERSET:
> > +                       printf("spec %s is a superset of spec %s\n", fi=
le1, file2);
> > +                       break;
> > +               case SELABEL_INCOMPARABLE:
> > +                       printf("spec %s is uncompareable to spec %s\n",=
 file1, file2);
> > +                       break;
> > +               default:
> > +                       fprintf(stderr, "ERROR: selabel_cmp - Unexpecte=
d result %d\n", result);
> > +                       return EXIT_FAILURE;
> > +               }
> > +
> > +               return EXIT_SUCCESS;
> > +       }
> > +}
> > --
> > 2.40.1
> >
