Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5B0C433F5
	for <selinux@archiver.kernel.org>; Wed,  6 Apr 2022 17:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239853AbiDFSAf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Apr 2022 14:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239864AbiDFSAW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Apr 2022 14:00:22 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504DEB36A6
        for <selinux@vger.kernel.org>; Wed,  6 Apr 2022 09:15:08 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id n19-20020a9d7113000000b005cd9cff76c3so2052295otj.1
        for <selinux@vger.kernel.org>; Wed, 06 Apr 2022 09:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SViS/da7TTIqqCaCMS6KbvY1RVplXFlwPx56Vk1oUdk=;
        b=TebXTxXqV/2U04D/05Me+PLl+gnz3NWNTmPRv5D1jFiz4OK3aUqEd3b78tmVC3asLi
         sK2LjYkgC1e4TB+Q5MQqOCU2Howen4ty8S1E6SpheBKqye3nwfSqeUfL4RkR+0HMnnpo
         M5/QVKUT5eVxOIy7tryb6+f2eQL3HxApjJ4apR1BFx2lquy7g9AjU7YXCxWAJadXYSYd
         WOhaZKNXzdQC+3oEVhOWe6KL6t3uM5wxIHW59fV3cHbkDkoXyNf1/xDWVZQ/48oIygYY
         SqTGW7CT7Y5XBsJaWItNb0VzEvwGSocy4bQqlpm2VFBO914TcRoSZvl/y6289u1IRqAz
         hFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SViS/da7TTIqqCaCMS6KbvY1RVplXFlwPx56Vk1oUdk=;
        b=tqKKPpJ0IlS1X1MVX89IMg0SGcFLPu7m63I3td233G6mL08IdtKphgNW52RY7B/66a
         DmS2IrLeOcCsfkPUO2+m3fgxEpUd/wAQhgsAD8TFx2RBQd7laK28PmK6IfCFnI+NVXeV
         u8BbQF3w8+myRnHp20uDDp07O0qZDjRT0mTzGtYB1jtIdWUa91Y7/H6r4g6uxEnI+9lA
         n977asFbJ7GFdBkJ4moakSvxuywxrhy8RTkReN5nGxmP8C3M4w2H3PC8uggXlC1AxXaS
         SmI6u/vLQPKDSllgN5ZupzSafbCG5QaBAdAURrOO403zt3WbpBbtfR30oEqGT2iliEKw
         bsxQ==
X-Gm-Message-State: AOAM530NOgDnDHn86KqLyPiYE90ymvSWYdfR82gvng678jvnQYTDRQTz
        mAKUbws17hfOM8hkHyxCDMxEGhef8jrk87TMZZg63+18fDs=
X-Google-Smtp-Source: ABdhPJy0Rcn8FIUIjYNTTlPimxEIZeAcqXfiiausMjuo5Cwh3pQ5n00BBLdprw/4D4pMzbx/NxVst73Cmo26oWu8aHM=
X-Received: by 2002:a9d:7842:0:b0:5b2:4dee:79c2 with SMTP id
 c2-20020a9d7842000000b005b24dee79c2mr3275684otm.53.1649261707329; Wed, 06 Apr
 2022 09:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220331144653.31178-1-cgzones@googlemail.com> <20220405132630.47946-1-cgzones@googlemail.com>
In-Reply-To: <20220405132630.47946-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 6 Apr 2022 12:14:56 -0400
Message-ID: <CAP+JOzRSBJBuRSRJ4Pyy0iP5pn8RYvJaxdVeQWsNaTgSPv7dJA@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux/utils: check for valid contexts to improve
 error causes
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 6, 2022 at 3:26 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Return more detailed error messages when the supplied contexts are
> invalid.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

>
> ---
> v2:
>    check new context in validatetrans
> ---
>  libselinux/utils/compute_av.c      | 10 ++++++++++
>  libselinux/utils/compute_create.c  | 12 +++++++++++-
>  libselinux/utils/compute_member.c  | 12 +++++++++++-
>  libselinux/utils/compute_relabel.c | 10 ++++++++++
>  libselinux/utils/getdefaultcon.c   |  5 +++++
>  libselinux/utils/selinuxexeccon.c  |  6 +++++-
>  libselinux/utils/validatetrans.c   | 15 +++++++++++++++
>  7 files changed, 67 insertions(+), 3 deletions(-)
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
> index 1db33e66..9d642a93 100644
> --- a/libselinux/utils/validatetrans.c
> +++ b/libselinux/utils/validatetrans.c
> @@ -17,12 +17,27 @@ int main(int argc, char **argv)
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
>                 exit(2);
>         }
>
> +       if (security_check_context(argv[4])) {
> +               fprintf(stderr, "%s:  invalid new context '%s'\n", argv[0=
], argv[4]);
> +               exit(6);
> +       }
> +
>         ret =3D security_validatetrans(argv[1], argv[2], tclass, argv[4])=
;
>         printf("security_validatetrans returned %d errno: %s\n", ret, str=
error(errno));
>
> --
> 2.35.1
>
