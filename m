Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B75C433EF
	for <selinux@archiver.kernel.org>; Wed, 26 Jan 2022 22:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiAZWMZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jan 2022 17:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiAZWMZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jan 2022 17:12:25 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4816C06161C
        for <selinux@vger.kernel.org>; Wed, 26 Jan 2022 14:12:24 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id w27-20020a9d5a9b000000b005a17d68ae89so667820oth.12
        for <selinux@vger.kernel.org>; Wed, 26 Jan 2022 14:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5k1EJxCzPz6/ZghbUGHz5I9Ek7bf3jv+/ufEzxGqju8=;
        b=mG6veWkUwUEVxcP4wJd/4NrNXZrRXZJxpVVYMR4Sq1SfWR0S5tD6ChbN124feBCv11
         He3nkqYwfnMLVpAD2Ki4fsHlIBrpW1ozShaneKLYIZ9DZQdgG8zeWbKkRaIOU4cycTaJ
         t/CVoEg09ImJjBRkNam54Spv7N3PE+ErhDcCt13sk/bnecvt4Z4Wn9nd5Opj1M1EXVPp
         2lfu6VwsHkagu2WnFyHtmXjVSnr+RDmN0vttQem+3VRXImnAHz0RUNu6D4/8lYL/7sPr
         7w6H2N95Nf0Tjw7/6FOPRnMWXfKeZ9OtTIZWpslM02r1SRRxQ+lkJYkAs5nmdLcHSHKj
         EQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5k1EJxCzPz6/ZghbUGHz5I9Ek7bf3jv+/ufEzxGqju8=;
        b=pwOjogDOQoPZN9ru2kp7l+GOCTn/32es2FXGjth8CLbtwPcTQ3+F4SBPvs/2+gjaAL
         gIkbX7kCc2uzG8o4HkdTc3MeIw4IXyj22HgwzzRFrNfh25kIa8wLjgeEXWmEpa3xMAuX
         AUfM/XipxbvAcJ5xQNLbAmVb8jh0KU6N/iWlAeP6EOp8hB8wQhT9MGI1ULEiPvsmJyHM
         7KGJ/GAiP1Bao7hhAd8jpnRv44Kg/2feIoAs/ke644lGjziwQHC3CH51u9Ucl1vsHqxa
         0V3ADo3mRpN6oo3b8zEbHfKYr2oUag/0OevdDoeHsv8XZ6efteR/1Do/FORRzdjb/duR
         qNQA==
X-Gm-Message-State: AOAM5337xmNGFk5mh0+Z0Va2bO3p2K8QlFg0g4bZcvTqU+PuyhGU4ane
        Jy7EsTeGcq4Lnrw3Y/wRE69dyRpOU+yIfwqIAm6k/niXmho=
X-Google-Smtp-Source: ABdhPJzIhw1jY/XabiLtq4mysWXh5GEPNAPY82vS9oo35NzcDvpGI3fL7EM7b41FO6vOY5lF2LICIhw1V8Ff81EIUPg=
X-Received: by 2002:a9d:70cf:: with SMTP id w15mr555752otj.154.1643235144210;
 Wed, 26 Jan 2022 14:12:24 -0800 (PST)
MIME-Version: 1.0
References: <20220126145645.5236-1-cgzones@googlemail.com>
In-Reply-To: <20220126145645.5236-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 26 Jan 2022 17:12:13 -0500
Message-ID: <CAP+JOzTyxJzQz5yhnxWYXXeH-rQHz0ZupLcMjjAiG1W2879_uQ@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils: handle argument counter of zero
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 26, 2022 at 4:39 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The number of arguments passed to main(), argc, can be zero if the
> pathname passed to execve(2) is NULL, e.g. via:
>
>     execve("/path/to/exe", {NULL}, {NULL});
>
> Also avoid NULL pointer dereferences on the argument value.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  policycoreutils/run_init/open_init_pty.c | 2 +-
>  policycoreutils/secon/secon.c            | 3 +++
>  policycoreutils/setfiles/setfiles.c      | 6 +++++-
>  3 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/policycoreutils/run_init/open_init_pty.c b/policycoreutils/r=
un_init/open_init_pty.c
> index 150cb45e..19101c50 100644
> --- a/policycoreutils/run_init/open_init_pty.c
> +++ b/policycoreutils/run_init/open_init_pty.c
> @@ -244,7 +244,7 @@ int main(int argc, char *argv[])
>         rb_init(&inbuf, inbuf_mem, sizeof(inbuf_mem));
>         rb_init(&outbuf, outbuf_mem, sizeof(outbuf_mem));
>
> -       if (argc =3D=3D 1) {
> +       if (argc < 2) {
>                 printf("usage: %s PROGRAM [ARGS]...\n", argv[0]);
>                 exit(1);
>         }
> diff --git a/policycoreutils/secon/secon.c b/policycoreutils/secon/secon.=
c
> index a0957d09..d624fa13 100644
> --- a/policycoreutils/secon/secon.c
> +++ b/policycoreutils/secon/secon.c
> @@ -333,6 +333,9 @@ static void cmd_line(int argc, char *argv[])
>                 opts->from_type =3D OPTS_FROM_CUR;
>
>         if (opts->from_type =3D=3D OPTS_FROM_ARG) {
> +               if (!argv[0])
> +                       errx(EXIT_FAILURE, "No argument given");
> +
>                 opts->f.arg =3D argv[0];
>
>                 if (xstreq(argv[0], "-"))
> diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfil=
es/setfiles.c
> index 44cab46d..ab7016ac 100644
> --- a/policycoreutils/setfiles/setfiles.c
> +++ b/policycoreutils/setfiles/setfiles.c
> @@ -163,6 +163,10 @@ int main(int argc, char **argv)
>         policyfile =3D NULL;
>
>         r_opts.abort_on_error =3D 0;
> +       if (!argv[0]) {
> +               fprintf(stderr, "Called without required program name!\n"=
);
> +               exit(-1);
> +       }
>         r_opts.progname =3D strdup(argv[0]);
>         if (!r_opts.progname) {
>                 fprintf(stderr, "%s:  Out of memory!\n", argv[0]);
> @@ -423,7 +427,7 @@ int main(int argc, char **argv)
>
>                 altpath =3D argv[optind];
>                 optind++;
> -       } else if (argc =3D=3D 1)
> +       } else if (argc < 2)
>                 usage(argv[0]);
>
>         /* Set selabel_open options. */
> --
> 2.34.1
>
