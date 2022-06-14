Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D6BC433EF
	for <selinux@archiver.kernel.org>; Tue, 14 Jun 2022 13:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiFNN1c (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Jun 2022 09:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbiFNN1a (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Jun 2022 09:27:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B668DF13
        for <selinux@vger.kernel.org>; Tue, 14 Jun 2022 06:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655213247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7KSfRxmynF/0bEL15Z7vCj5nx3rSbUmvPTUePsWGLMo=;
        b=c4/Exfy6P87ZMFav8aj7Q/Mf0vQlZGJrYPpaNq5uFwLv21/TF3R7RVVOKlahtHyQ/8kFOJ
        CY/j6g5yEtEG6HCIfhVln3TrVaryZmJqUNXv3aG71DwuEw6w6YzpC5esfkMxxV2QtfwZn1
        57sB8CSUn2ZY1M5UViFOPuzZvRAjwss=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-385-cr0NuSnANrWfwYdzP-Jngg-1; Tue, 14 Jun 2022 09:27:25 -0400
X-MC-Unique: cr0NuSnANrWfwYdzP-Jngg-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-30c87716af6so24839347b3.22
        for <selinux@vger.kernel.org>; Tue, 14 Jun 2022 06:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7KSfRxmynF/0bEL15Z7vCj5nx3rSbUmvPTUePsWGLMo=;
        b=Sv5Paes3g0djOYBzosQVXVTOlaGUQMl5xz5hyYQPAeLT9n44AyuE6WJ3522efbLOod
         0gR0W6XJCj5mVmuRK4H0ghQDpXpzjlDVqAczMqs2CGcPd13HaXSa+5SOa8jJnUJkw2ot
         fbJxaKGiS9P3hdKBzDmzv0PLrV66Z27A9qJGuPWPSXgsB4/gcs7Uqj2Uob3i5VTxXkg1
         c+ycrI47MRVcK/7hrXxYTa58s6MOP3xEUH9sY2dyALDxwI7X9Irv0QRHedx6IEi4i//a
         IguBL9xaLJEFMNhbdejoELUPN6rYOrEzF58fjKUsGUb0AdqsYxe2bhvLqgmy4u9YPLdl
         wJqw==
X-Gm-Message-State: AJIora+NEtZbCSpDQgPi9CtJw7hXV9ZWNuGwwdZWhmsdHuLvq8zzQorE
        O8gReiH0tKqxWhGWp2ruu4besQux4oyHwaA7VM1MzY9NIvRAB6cKYmocyeOWB9GwrtFIHPDltz/
        kGgvYd6qcdb7o3q8RHejWxxXV/mw04mCMmg==
X-Received: by 2002:a81:7010:0:b0:30c:c6cf:d4af with SMTP id l16-20020a817010000000b0030cc6cfd4afmr5377981ywc.459.1655213243884;
        Tue, 14 Jun 2022 06:27:23 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tIscPb3aFH+nVkUVveubiMwaOR5JWMLBhW3ZjMr1jaEKSsvyBOjhz4TRb13MOktMx0JeaOp36nMvLn8sXs8eo=
X-Received: by 2002:a81:7010:0:b0:30c:c6cf:d4af with SMTP id
 l16-20020a817010000000b0030cc6cfd4afmr5377950ywc.459.1655213243556; Tue, 14
 Jun 2022 06:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220614102029.13006-1-cgzones@googlemail.com> <20220614102029.13006-4-cgzones@googlemail.com>
In-Reply-To: <20220614102029.13006-4-cgzones@googlemail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 14 Jun 2022 15:27:12 +0200
Message-ID: <CAFqZXNvv7cAYF7fFKDThp1e_CcWVrxwhk=wkdHqXrykBiGGApg@mail.gmail.com>
Subject: Re: [PATCH 4/4] watchkey: skip if CONFIG_WATCH_QUEUE not set
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 14, 2022 at 12:21 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> Debian does not set CONFIG_WATCH_QUEUE, whereby pipe2(2) returns ENOPKG
> for the option O_NOTIFICATION_PIPE.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  tests/watchkey/test       |  9 ++++++++-
>  tests/watchkey/watchkey.c | 16 ++++++++++++++--
>  2 files changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/tests/watchkey/test b/tests/watchkey/test
> index f61ff78..38cbb74 100755
> --- a/tests/watchkey/test
> +++ b/tests/watchkey/test
> @@ -16,7 +16,14 @@ BEGIN {
>          $v =3D " ";
>      }
>
> -    plan tests =3D> 2;
> +    $result =3D system "runcon -t test_watchkey_t $basedir/watchkey $v -=
c";
> +    if ( $result ne 0 ) {
> +        plan skip_all =3D>
> +"pipe2(2) does not support O_NOTIFICATION_PIPE; CONFIG_WATCH_QUEUE proba=
bly not set";
> +    }
> +    else {
> +        plan tests =3D> 2;
> +    }
>  }
>
>  $result =3D system "runcon -t test_watchkey_t $basedir/watchkey $v";
> diff --git a/tests/watchkey/watchkey.c b/tests/watchkey/watchkey.c
> index c7f3274..4feba42 100644
> --- a/tests/watchkey/watchkey.c
> +++ b/tests/watchkey/watchkey.c
> @@ -27,8 +27,9 @@ static long keyctl_watch_key(int key, int watch_fd, int=
 watch_id)
>  static void print_usage(char *progname)
>  {
>         fprintf(stderr,
> -               "usage:  %s [-v]\n"
> +               "usage:  %s [-cv]\n"
>                 "Where:\n\t"
> +               "-c  Check for availability.\n"
>                 "-v  Print information.\n", progname);
>         exit(-1);
>  }
> @@ -37,10 +38,14 @@ int main(int argc, char **argv)
>  {
>         int opt, fd, pipefd[2], result, save_errno;
>         char *context;
> +       bool check =3D false;
>         bool verbose =3D false;
>
> -       while ((opt =3D getopt(argc, argv, "v")) !=3D -1) {
> +       while ((opt =3D getopt(argc, argv, "cv")) !=3D -1) {
>                 switch (opt) {
> +               case 'c':
> +                       check =3D true;
> +                       break;
>                 case 'v':
>                         verbose =3D true;
>                         break;
> @@ -60,6 +65,13 @@ int main(int argc, char **argv)
>                 free(context);
>         }
>
> +       if (check) {
> +               result =3D pipe2(pipefd, O_NOTIFICATION_PIPE);
> +               if (!result || errno !=3D ENOPKG)
> +                       exit(0);
> +               exit(-1);

This patch looks good to me, but I'd prefer to exit with a different
code here (e.g. positive 1) to explicitly distinguish this from the
exit via print_usage() or getcon() failure.

> +       }
> +
>         result =3D pipe2(pipefd, O_NOTIFICATION_PIPE);
>         if (result < 0) {
>                 fprintf(stderr, "Failed to create pipe2(2): %s\n",
> --
> 2.36.1
>

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

