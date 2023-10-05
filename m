Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F8BE92723
	for <selinux@archiver.kernel.org>; Thu,  5 Oct 2023 16:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239406AbjJEQN0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Oct 2023 12:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240640AbjJEQMN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Oct 2023 12:12:13 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B08618F
        for <selinux@vger.kernel.org>; Thu,  5 Oct 2023 08:29:45 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-503065c4b25so1512077e87.1
        for <selinux@vger.kernel.org>; Thu, 05 Oct 2023 08:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696519783; x=1697124583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCWca6E4Rj/SWchH+iNrraFrInCbmif3RGEU3elC6mA=;
        b=OPqNlMcIiOrNXp4GkYL26jv5P+HYRWuDZKezxEGWhSv7L2AAUYLew5Vj8JYiuw9pYP
         wl9V+xflsxgGfEqlxRieKtTcAWqEanvhvSA+F2t30fCIas00O6o3Y8lmj6Qm8/4vSbhH
         LWmS0Vp/aTZ/BylUzMV0cHIRrSqkNnNSDPonHe8tgutW4PMkIiI2n92HRsgNu7sMN9LM
         h/QcUZXxYWnZ0UcJjYTRZKR7TJcEn5567SLEGVumse3/IT6ynpgOc8mYv2aEcZ2yfVwb
         fokZjqQm65zZQoWjZbeNMp9XRZddu8YKfYvSMUkzmIG0AGilmh4skBuhzRMDRl5ljrnG
         DxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696519783; x=1697124583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZCWca6E4Rj/SWchH+iNrraFrInCbmif3RGEU3elC6mA=;
        b=EoMHYtViCgReV05kcMCfqvVf8uOtCPa607ilO4BXLjvStLZU/D0ecNTC+FZC2LXbTZ
         bUiUQLG6+YVilzKt48LkzuoNsdRlwYAsdo+SWjCakLS71WFM9yFAXK2YfraNWCXpbXfD
         09SurX1m9jWR0cmUIgqNt5Ji8qEw1lkvAFvvUnFubp8u2XlDHRDBFGjmufgTUp73b+FH
         RSCj3c+kGeoF4hrmK6jqFxcJ6RwBQgBoQV8DW13STgFhTNbZnHMlHEPw7pc6Dwj56NZP
         Ua2fyMhahkpq8Q5zHRDVE08NplHYCJJeYwoGqVq/wkKAmduz462eFWS62PLMj8J8KZ1w
         Irkg==
X-Gm-Message-State: AOJu0YxCHO80U9y6Jkh4zUBthGSije/Yhtx8YBfy8NF0YDnu0qCYtDhQ
        7umbpGPotFLx1CpAVS00gkr13Ln+VqGT2IeUAgCb+O5/
X-Google-Smtp-Source: AGHT+IG5xXlArG1ddZdANslrkkRhfGo59gynMeUhmBk/CHlKjBqVDyrHfQ2LfgiD46mg+DWRCIKQoBZ+AhbtgBu+b6A=
X-Received: by 2002:a05:6512:10c9:b0:504:3807:22a4 with SMTP id
 k9-20020a05651210c900b00504380722a4mr6072974lfg.23.1696519783285; Thu, 05 Oct
 2023 08:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com> <20230814132025.45364-14-cgzones@googlemail.com>
In-Reply-To: <20230814132025.45364-14-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 5 Oct 2023 11:29:32 -0400
Message-ID: <CAP+JOzQXWc=pScMrxsSpn4=tR=CZYXzQRLL6MvZ+c8VmGFumew@mail.gmail.com>
Subject: Re: [RFC PATCH v2 13/27] libselinux/utils: introduce selabel_compare
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 14, 2023 at 9:42=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Add a utility around selabel_cmp(3).
>
> Can be used by users to compare a pre-compiled fcontext file to an
> original text-based file context definition file.
>
> Can be used for development to verify compilation and parsing of the
> pre-compiled fcontext format works correctly.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/utils/.gitignore        |   1 +
>  libselinux/utils/selabel_compare.c | 119 +++++++++++++++++++++++++++++
>  2 files changed, 120 insertions(+)
>  create mode 100644 libselinux/utils/selabel_compare.c
>
> diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignore
> index a92e1e94..4e2dfba8 100644
> --- a/libselinux/utils/.gitignore
> +++ b/libselinux/utils/.gitignore
> @@ -16,6 +16,7 @@ getseuser
>  matchpathcon
>  policyvers
>  sefcontext_compile
> +selabel_compare
>  selabel_digest
>  selabel_get_digests_all_partial_matches
>  selabel_lookup
> diff --git a/libselinux/utils/selabel_compare.c b/libselinux/utils/selabe=
l_compare.c
> new file mode 100644
> index 00000000..f4325f7e
> --- /dev/null
> +++ b/libselinux/utils/selabel_compare.c
> @@ -0,0 +1,119 @@
> +#include <getopt.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +#include <selinux/label.h>
> +
> +
> +static void usage(const char *progname)
> +{
> +       fprintf(stderr,
> +               "usage: %s [-b backend] [-v] file1 file2\n\n"
> +               "Where:\n\t"
> +               "-b           The backend - \"file\", \"media\", \"x\", \=
"db\" or \"prop\" (defaults to \"file\")\n\t"
> +               "-v           Validate entries against loaded policy.\n\t=
"
> +               "file1/file2  Files containing the specs.\n",
> +               progname);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       unsigned int backend =3D SELABEL_CTX_FILE;
> +       int opt;
> +       const char *validate =3D NULL, *file1 =3D NULL, *file2 =3D NULL;
> +
> +       if (argc < 3) {
> +               usage(argv[0]);
> +               return EXIT_FAILURE;
> +       }
> +
> +       while ((opt =3D getopt(argc, argv, "b:v")) > 0) {
> +               switch (opt) {
> +               case 'b':
> +                       if (!strcasecmp(optarg, "file")) {
> +                               backend =3D SELABEL_CTX_FILE;
> +                       } else if (!strcmp(optarg, "media")) {
> +                               backend =3D SELABEL_CTX_MEDIA;
> +                       } else if (!strcmp(optarg, "x")) {
> +                               backend =3D SELABEL_CTX_X;
> +                       } else if (!strcmp(optarg, "db")) {
> +                               backend =3D SELABEL_CTX_DB;
> +                       } else if (!strcmp(optarg, "prop")) {
> +                               backend =3D SELABEL_CTX_ANDROID_PROP;
> +                       } else if (!strcmp(optarg, "service")) {
> +                               backend =3D SELABEL_CTX_ANDROID_SERVICE;
> +                       } else {
> +                               fprintf(stderr, "Unknown backend: %s\n", =
optarg);
> +                               usage(argv[0]);
> +                               return EXIT_FAILURE;
> +                       }
> +                       break;
> +               case 'v':
> +                       validate =3D (char *)1;
> +                       break;
> +               default:
> +                       usage(argv[0]);
> +                       return EXIT_FAILURE;
> +               }
> +       }
> +
> +       if (argc !=3D optind + 2) {
> +               usage(argv[0]);
> +               return EXIT_FAILURE;
> +       }
> +
> +       file1 =3D argv[optind++];
> +       file2 =3D argv[optind];
> +
> +       {

To me, having a block like this means that the stuff below should be
in a helper function.

Everything else looks good.
Jim


> +               struct selabel_handle *hnd1, *hnd2;
> +               const struct selinux_opt selabel_option1[] =3D {
> +                       { SELABEL_OPT_PATH, file1 },
> +                       { SELABEL_OPT_VALIDATE, validate }
> +               };
> +               const struct selinux_opt selabel_option2[] =3D {
> +                       { SELABEL_OPT_PATH, file2 },
> +                       { SELABEL_OPT_VALIDATE, validate }
> +               };
> +               enum selabel_cmp_result result;
> +
> +               hnd1 =3D selabel_open(backend, selabel_option1, 2);
> +               if (!hnd1) {
> +                       fprintf(stderr, "ERROR: selabel_open - Could not =
obtain handle for %s:  %m\n", file1);
> +                       return EXIT_FAILURE;
> +               }
> +
> +               hnd2 =3D selabel_open(backend, selabel_option2, 2);
> +               if (!hnd2) {
> +                       fprintf(stderr, "ERROR: selabel_open - Could not =
obtain handle for %s:  %m\n", file2);
> +                       selabel_close(hnd1);
> +                       return EXIT_FAILURE;
> +               }
> +
> +               result =3D selabel_cmp(hnd1, hnd2);
> +
> +               selabel_close(hnd2);
> +               selabel_close(hnd1);
> +
> +               switch (result) {
> +               case SELABEL_SUBSET:
> +                       printf("spec %s is a subset of spec %s\n", file1,=
 file2);
> +                       break;
> +               case SELABEL_EQUAL:
> +                       printf("spec %s is equal to spec %s\n", file1, fi=
le2);
> +                       break;
> +               case SELABEL_SUPERSET:
> +                       printf("spec %s is a superset of spec %s\n", file=
1, file2);
> +                       break;
> +               case SELABEL_INCOMPARABLE:
> +                       printf("spec %s is uncompareable to spec %s\n", f=
ile1, file2);
> +                       break;
> +               default:
> +                       fprintf(stderr, "ERROR: selabel_cmp - Unexpected =
result %d\n", result);
> +                       return EXIT_FAILURE;
> +               }
> +
> +               return EXIT_SUCCESS;
> +       }
> +}
> --
> 2.40.1
>
