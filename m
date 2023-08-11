Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF943C001DB
	for <selinux@archiver.kernel.org>; Fri, 11 Aug 2023 13:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbjHKNJ6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Aug 2023 09:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbjHKNJi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Aug 2023 09:09:38 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC788359F
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 06:09:11 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so30109561fa.2
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 06:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691759349; x=1692364149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwqLErI6BmmfGKl4a90zJKkZT2N+1XE1ylL8yTwS0V8=;
        b=n2tFCRP9m1v7ytexPU3UVNOuet9f+NldllW+nDbxrDk6DwmTHoDFgh7Gn8flcig50p
         TIrsCkpmYnLzfjLmpdBNGqtVOXZp7lcGCnWgK14UrsFLRO5V0dcL99X5Kf3OwXaxFnAi
         drYQvSimItmmO3Sx4FAMFdYcmqueoHcwo2tKqfDMklUDl9Un6dgTByalWqeT8mSsSWS8
         yEO/jNuSwimKX63ctcbE5s0YXEI3hOBvm52OnCQMm1zmz2XPl8rMdv0tLalUGtVIuZEB
         UCrgxX4CGoc/E5e1IAXcYPRt1rofkifFqnsNZc6CB+OUMDV5I3uOUd+14T91gGvrfn+t
         MitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691759349; x=1692364149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwqLErI6BmmfGKl4a90zJKkZT2N+1XE1ylL8yTwS0V8=;
        b=fClsN0QcwzUQwpL0aSC49zq2aSLYXSp6UyZYSjfEtUa17ltpyY/7hXD4eSVMH09YNb
         TMZX77+6ld2wWtIlHIQDr+IYCLqvVZB9H0zbHQO5staQq41gZstZ7d83Sj80f1EWWbXU
         Vm/RgWl+21X0yHg+EiglWpSuudSLNPTUZwjZLRYP9lTOxvmhkojdFsQI6OJzTJzxDTCu
         tpADTJpgd3Uhpw9FlPL4SOdqVz60koYSiTUbXfoklUfVjeEwqBYEzXWYIjOd1MwvxZHU
         kH5veo4OvO6suTSR9i7/0hRxRVYW7HSQZ0ehMAprWOqhp1fZrCJIEDrGOqKfSpQ7niUC
         T4EQ==
X-Gm-Message-State: AOJu0Yz6oBdmpMSeEhxh+W8yihf77UQjs0c1T1u+mxhKB2q4ExuIyyr5
        KqLjjaASfQvI4hJZKSTd/wWt6wkuMCg4vSd/A3AfIb9t7IQ=
X-Google-Smtp-Source: AGHT+IGzbj90sThA1aj43uBQoH6wEZUF9py9ezHpE37LablPGZAmFmxcmFE+wTh5K//FYSfAjdIm91/N1Tr/c0h0gck=
X-Received: by 2002:a2e:680f:0:b0:2b4:7f2e:a433 with SMTP id
 c15-20020a2e680f000000b002b47f2ea433mr1481544lja.36.1691759349070; Fri, 11
 Aug 2023 06:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230803162326.302824-1-cgzones@googlemail.com>
In-Reply-To: <20230803162326.302824-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 11 Aug 2023 09:08:57 -0400
Message-ID: <CAP+JOzTQp_fNVZ9zAeeRW7T1JE11tzED65Sb57VODaTtmMS8mw@mail.gmail.com>
Subject: Re: [PATCH 1/4] libselinux/utils: update selabel_partial_match
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 3, 2023 at 12:37=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Print usage information and exit if required path option is not given
> or superfluous arguments are given.
>
> Constify read-only variables assigned command line arguments.
>
> Simplify bool evaluation.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For this four patch series:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/utils/selabel_partial_match.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/utils/selabel_partial_match.c b/libselinux/utils/=
selabel_partial_match.c
> index 7bbd5777..0df2627a 100644
> --- a/libselinux/utils/selabel_partial_match.c
> +++ b/libselinux/utils/selabel_partial_match.c
> @@ -28,7 +28,7 @@ int main(int argc, char **argv)
>  {
>         int opt;
>         bool partial_match;
> -       char *validate =3D NULL, *path =3D NULL, *file =3D NULL;
> +       const char *validate =3D NULL, *path =3D NULL, *file =3D NULL;
>
>         struct selabel_handle *hnd;
>         struct selinux_opt selabel_option[] =3D {
> @@ -55,6 +55,9 @@ int main(int argc, char **argv)
>                 }
>         }
>
> +       if (!path || optind !=3D argc)
> +               usage(argv[0]);
> +
>         selabel_option[0].value =3D file;
>         selabel_option[1].value =3D validate;
>
> @@ -69,7 +72,7 @@ int main(int argc, char **argv)
>         partial_match =3D selabel_partial_match(hnd, path);
>
>         printf("Match or Partial match: %s\n",
> -                   partial_match =3D=3D 1 ? "TRUE" : "FALSE");
> +                   partial_match ? "TRUE" : "FALSE");
>
>         selabel_close(hnd);
>         return partial_match;
> --
> 2.40.1
>
