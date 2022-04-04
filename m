Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7130BC4332F
	for <selinux@archiver.kernel.org>; Mon,  4 Apr 2022 21:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380586AbiDDVbM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379673AbiDDRsP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Apr 2022 13:48:15 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C782E9CD
        for <selinux@vger.kernel.org>; Mon,  4 Apr 2022 10:46:18 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id z8so10829919oix.3
        for <selinux@vger.kernel.org>; Mon, 04 Apr 2022 10:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UAY+9rNpnqBIm1qMqGmuc2irHcAEvHGjwuQwuYFL7J8=;
        b=oTYP9TM/mPyRid4N/fSEVl+9jXlBFhsegB9aWg3atVGP6kMrrGU0ftLf4m2S3jIf5E
         fUzwP+O2DIUgrBf6NAlJs/1JwSLnrmsgVbyLPqUgCJ/6j1oLkiKb0bc05O1Wz7j2cO3d
         27Xo6+yy5YoX5ukAze6K+aD1Pt4qJWJCbYTkWVj/QOaA6bOqCph+Vbn0N3HF/I9094qS
         pVRg8X5mwV9MeDnD0m80XT5tXwzaMP9SWAncTHcXvrmoQR+94sJTGrL2vRIo368IyX6v
         9YM2JLcKMiWsft7U/zNETeRgO62G/rxAiaGhRMaonHvVeZBkCE7nQAqwiMax0FDclxTV
         KjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UAY+9rNpnqBIm1qMqGmuc2irHcAEvHGjwuQwuYFL7J8=;
        b=msFF6a1D+8nfN0qr3xVQRcDqLDKvGl+W7Dg+PmCtu1yvXNQ/MDQyktIdiYL4QebZZo
         9tJqJLzryKXw4GCRMFWuDSAIoE6jTB84lfes9TMD7xgDE36mk/VCO5Sk6GzYa8yhUgfs
         EzDeeqoq24HYKsXZTz5m9BjcAyv/a46je9VZ2VfwCKIZJDcR5XOMfLcU+ylK0SJ3qWgb
         675Pg18WRCCfWx6ZDOALywq5bLXW44QbS/Pnq6mDXEtqqzsqXRteNc2qSw4bxCoLYKU+
         gSoaqVBP8fKj6q0f72mWOuMCd5WRyegQCv3AzStddP+cNO2h05m3Xyvxb7uZfHiIkLHd
         LJwg==
X-Gm-Message-State: AOAM531XDctmHeoif5zi/VuVQhY/WK8gqOm3aaYTawq4qJrOw49yuDDX
        fywBbSlYV+kWkFibKiG8n3aFR9PcoysGD0WMezU=
X-Google-Smtp-Source: ABdhPJwUBxW0nJCR5X1Y9w+H9qKTTNsZL1bN/iFMe65sc+Rbjoixx4Y96C3V8etxhpmMrp30g/41PGo0TGDsp34dDNk=
X-Received: by 2002:a05:6808:210b:b0:2d9:a6d3:b029 with SMTP id
 r11-20020a056808210b00b002d9a6d3b029mr147450oiw.182.1649094377918; Mon, 04
 Apr 2022 10:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220331144653.31178-1-cgzones@googlemail.com>
In-Reply-To: <20220331144653.31178-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 4 Apr 2022 13:46:07 -0400
Message-ID: <CAP+JOzRH_vtoTR1Yhz36QUxkhCg88BqEQ_Mf0V6+d=voQ5pSdQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux/utils: check for valid contexts to improve
 error causes
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Apr 1, 2022 at 11:38 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Return more detailed error messages when the supplied contexts are
> invalid.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/utils/compute_av.c      | 10 ++++++++++
>  libselinux/utils/compute_create.c  | 12 +++++++++++-
>  libselinux/utils/compute_member.c  | 12 +++++++++++-
>  libselinux/utils/compute_relabel.c | 10 ++++++++++
>  libselinux/utils/getdefaultcon.c   |  5 +++++
>  libselinux/utils/selinuxexeccon.c  |  6 +++++-
>  libselinux/utils/validatetrans.c   | 10 ++++++++++
>  7 files changed, 62 insertions(+), 3 deletions(-)
>
> diff --git a/libselinux/utils/compute_av.c b/libselinux/utils/compute_av.=
c
> index df4a77e8..ef08338f 100644
> --- a/libselinux/utils/compute_av.c
> +++ b/libselinux/utils/compute_av.c
> @@ -17,6 +17,16 @@ int main(int argc, char **argv)
>                 exit(1);
>         }
>
> +       if (security_check_context(argv[1])) {
> +               fprintf(stderr, "%s:  invalid source context '%s'\n", arg=
v[0], argv[1]);
> +               exit(4);
> +       }
> +
> +       if (security_check_context(argv[2])) {
> +               fprintf(stderr, "%s:  invalid target context '%s'\n", arg=
v[0], argv[2]);
> +               exit(5);
> +       }
> +
>         tclass =3D string_to_security_class(argv[3]);
>         if (!tclass) {
>                 fprintf(stderr, "%s:  invalid class '%s'\n", argv[0], arg=
v[3]);
> diff --git a/libselinux/utils/compute_create.c b/libselinux/utils/compute=
_create.c
> index 449ccd90..63029c19 100644
> --- a/libselinux/utils/compute_create.c
> +++ b/libselinux/utils/compute_create.c
> @@ -17,9 +17,19 @@ int main(int argc, char **argv)
>                 exit(1);
>         }
>
> +       if (security_check_context(argv[1])) {
> +               fprintf(stderr, "%s:  invalid source context '%s'\n", arg=
v[0], argv[1]);
> +               exit(4);
> +       }
> +
> +       if (security_check_context(argv[2])) {
> +               fprintf(stderr, "%s:  invalid target context '%s'\n", arg=
v[0], argv[2]);
> +               exit(5);
> +       }
> +
>         tclass =3D string_to_security_class(argv[3]);
>         if (!tclass) {
> -               fprintf(stderr, "Invalid class '%s'\n", argv[3]);
> +               fprintf(stderr, "%s:  invalid class '%s'\n", argv[0], arg=
v[3]);
>                 exit(2);
>         }
>
> diff --git a/libselinux/utils/compute_member.c b/libselinux/utils/compute=
_member.c
> index c6dad19e..1ef47c25 100644
> --- a/libselinux/utils/compute_member.c
> +++ b/libselinux/utils/compute_member.c
> @@ -17,9 +17,19 @@ int main(int argc, char **argv)
>                 exit(1);
>         }
>
> +       if (security_check_context(argv[1])) {
> +               fprintf(stderr, "%s:  invalid source context '%s'\n", arg=
v[0], argv[1]);
> +               exit(4);
> +       }
> +
> +       if (security_check_context(argv[2])) {
> +               fprintf(stderr, "%s:  invalid target context '%s'\n", arg=
v[0], argv[2]);
> +               exit(5);
> +       }
> +
>         tclass =3D string_to_security_class(argv[3]);
>         if (!tclass) {
> -               fprintf(stderr, "Invalid class '%s'\n", argv[3]);
> +               fprintf(stderr, "%s:  invalid class '%s'\n", argv[0], arg=
v[3]);
>                 exit(2);
>         }
>
> diff --git a/libselinux/utils/compute_relabel.c b/libselinux/utils/comput=
e_relabel.c
> index 85c760bc..f6a957da 100644
> --- a/libselinux/utils/compute_relabel.c
> +++ b/libselinux/utils/compute_relabel.c
> @@ -17,6 +17,16 @@ int main(int argc, char **argv)
>                 exit(1);
>         }
>
> +       if (security_check_context(argv[1])) {
> +               fprintf(stderr, "%s:  invalid source context '%s'\n", arg=
v[0], argv[1]);
> +               exit(4);
> +       }
> +
> +       if (security_check_context(argv[2])) {
> +               fprintf(stderr, "%s:  invalid target context '%s'\n", arg=
v[0], argv[2]);
> +               exit(5);
> +       }
> +
>         tclass =3D string_to_security_class(argv[3]);
>         if (!tclass) {
>                 fprintf(stderr, "%s:  invalid class '%s'\n", argv[0], arg=
v[3]);
> diff --git a/libselinux/utils/getdefaultcon.c b/libselinux/utils/getdefau=
ltcon.c
> index 957c1cb2..590e98d9 100644
> --- a/libselinux/utils/getdefaultcon.c
> +++ b/libselinux/utils/getdefaultcon.c
> @@ -68,6 +68,11 @@ int main(int argc, char **argv)
>         } else
>                 cur_context =3D argv[optind + 1];
>
> +       if (security_check_context(cur_context)) {
> +               fprintf(stderr, "%s:  invalid from context '%s'\n", argv[=
0], cur_context);
> +               return 3;
> +       }
> +
>         if ((ret =3D getseuser(user, service, &seuser, &dlevel)) =3D=3D 0=
) {
>                 if (! level) level=3Ddlevel;
>                 if (role !=3D NULL && role[0])
> diff --git a/libselinux/utils/selinuxexeccon.c b/libselinux/utils/selinux=
execcon.c
> index b50e7886..66754b6a 100644
> --- a/libselinux/utils/selinuxexeccon.c
> +++ b/libselinux/utils/selinuxexeccon.c
> @@ -16,7 +16,7 @@ static __attribute__ ((__noreturn__)) void usage(const =
char *name, const char *d
>         exit(rc);
>  }
>
> -static char * get_selinux_proc_context(const char *command, char * execc=
on) {
> +static char * get_selinux_proc_context(const char *command, const char *=
 execcon) {
>         char * fcon =3D NULL, *newcon =3D NULL;
>
>         int ret =3D getfilecon(command, &fcon);
> @@ -43,6 +43,10 @@ int main(int argc, char **argv)
>                 }
>         } else {
>                 con =3D strdup(argv[2]);
> +               if (security_check_context(con)) {
> +                       fprintf(stderr, "%s:  invalid from context '%s'\n=
", argv[0], con);
> +                       return -1;
> +               }
>         }
>
>         proccon =3D get_selinux_proc_context(argv[1], con);
> diff --git a/libselinux/utils/validatetrans.c b/libselinux/utils/validate=
trans.c
> index 1db33e66..9aa03e62 100644
> --- a/libselinux/utils/validatetrans.c
> +++ b/libselinux/utils/validatetrans.c
> @@ -17,6 +17,16 @@ int main(int argc, char **argv)
>                 exit(1);
>         }
>
> +       if (security_check_context(argv[1])) {
> +               fprintf(stderr, "%s:  invalid source context '%s'\n", arg=
v[0], argv[1]);
> +               exit(4);
> +       }
> +
> +       if (security_check_context(argv[2])) {
> +               fprintf(stderr, "%s:  invalid target context '%s'\n", arg=
v[0], argv[2]);
> +               exit(5);
> +       }
> +
>         tclass =3D string_to_security_class(argv[3]);
>         if (!tclass) {
>                 fprintf(stderr, "%s:  invalid class '%s'\n", argv[0], arg=
v[3]);

You should check that argv[4] is a valid context as well.

Everything else looks good.
Jim


> --
> 2.35.1
>
