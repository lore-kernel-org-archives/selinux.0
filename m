Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C645EC7EE25
	for <selinux@archiver.kernel.org>; Wed,  7 Jun 2023 13:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbjFGNXA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Jun 2023 09:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbjFGNW7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Jun 2023 09:22:59 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408C21735
        for <selinux@vger.kernel.org>; Wed,  7 Jun 2023 06:22:58 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f122ff663eso9057118e87.2
        for <selinux@vger.kernel.org>; Wed, 07 Jun 2023 06:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686144176; x=1688736176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APcKMuguwEWEdhWkUgZKqSlkNgOQHYPd4puhjt5BDfM=;
        b=mjnYaBpjZeIWmeBFK7TRKxOa4blzkcD8t/HAxwVsTEpl3TQjqc5j4U7LWOBHEcESl0
         RqR1DXa22qZjD62QiS7/9ORGe4x24NnRPwecfGuPmsuYaNROqRrzUFzpNKj7fv7T4WR2
         IEcLf2BQyyxMWibCyckTJ4QrVa9qLRIDER7Sqoe/UsKKZenuaBZTTEkHjOKvi+TDaQSr
         bSNrYe5EFqu4UgONTn7TVTOJfLf6C0LP3IAuZOxHCtj8HPenoS+5XcaCX+tTuw/6bNJb
         GqxTduKQstXfQs+1u7ZEpg3zvT0+BV5oxumuBG/XMbfQxgVtF86MXP8nFDSpt63BsnE1
         NcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686144176; x=1688736176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APcKMuguwEWEdhWkUgZKqSlkNgOQHYPd4puhjt5BDfM=;
        b=HvxWbSUpVqXOQaduQkVl3QQ3JeYky9pw2M7EN3HyWNwYtUuv6+uHH7uC4gGgv9UzKM
         DAFq8NHlXGLPTvQv+pr18rgq/XfRCR8NS/X/1IwW+AiNBvXzAWdf8H4660I7Z6eYbbax
         iuO8Mp9xDHbgDvty0pMeacMOtQD0C8Lr8G8hgGULBaN81xiJRgshkEfptErVYLfe3SJB
         DbGgpMd1iGhVl8TGvrYyVVMe8KtZ6kYLGn0Rbrhqy0bfIh5aw2AeRrQUm4ZR6/ODpX+c
         FPy2Ua269Iojli6NaOEDq7wKwzkaBHi/qxcwoqdeOHN0FdQEFvn2rz2cp+jmGZ+pLmPG
         wing==
X-Gm-Message-State: AC+VfDwWnZ8JWg4xGNjBEIa6x8/hUmh80C3dZuy4+rj7UZkfho3MJrHx
        XL3+kEb0l5UdaUOIandRb95TYKZMQPEaePbIDOSLbwza3uw=
X-Google-Smtp-Source: ACHHUZ5H7lZfov8JtefaPJ3THDsXUgBNZ8flZuS0wkuMk7FnqVbEhprFxoIrRbyZcvelCyA5irhxilA1DsUUn2OVcb8=
X-Received: by 2002:a19:ac03:0:b0:4f4:cebe:a7aa with SMTP id
 g3-20020a19ac03000000b004f4cebea7aamr2007802lfc.39.1686144176187; Wed, 07 Jun
 2023 06:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230531013224.1135775-1-yamato@redhat.com>
In-Reply-To: <20230531013224.1135775-1-yamato@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 7 Jun 2023 09:22:44 -0400
Message-ID: <CAP+JOzTypfDmj1jF8o28dWUABuFyEUjq4DVMefTzwL-BkHVnDA@mail.gmail.com>
Subject: Re: [PATCH 1/4] dismod: add --help option
To:     Masatake YAMATO <yamato@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 30, 2023 at 9:36=E2=80=AFPM Masatake YAMATO <yamato@redhat.com>=
 wrote:
>
> Signed-off-by: Masatake YAMATO <yamato@redhat.com>

It might make sense to add the actions option to dispol as well, but I
am not sure how much dismod and dispol are actually used.

For these four patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/test/dismod.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
> index 929ee308..eb090a36 100644
> --- a/checkpolicy/test/dismod.c
> +++ b/checkpolicy/test/dismod.c
> @@ -66,7 +66,11 @@ static const char *symbol_labels[9] =3D {
>
>  static __attribute__((__noreturn__)) void usage(const char *progname)
>  {
> -       printf("usage:  %s binary_pol_file\n\n", progname);
> +       puts("Usage:");
> +       printf(" %s [OPTIONS] binary_pol_file\n\n", progname);
> +       puts("Options:");
> +       puts(" -h, --help       print this help message");
> +       puts("\n");
>         exit(1);
>  }
>
> @@ -872,7 +876,7 @@ int main(int argc, char **argv)
>         FILE *out_fp =3D stdout;
>         char ans[81], OutfileName[121];
>
> -       if (argc !=3D 2)
> +       if (argc < 2 || strcmp(argv[1], "-h") =3D=3D 0 || strcmp(argv[1],=
 "--help") =3D=3D 0)
>                 usage(argv[0]);
>
>         /* read the binary policy */
> --
> 2.40.1
>
