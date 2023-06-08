Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C167C7EE29
	for <selinux@archiver.kernel.org>; Thu,  8 Jun 2023 14:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbjFHOVn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Jun 2023 10:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236034AbjFHOVn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Jun 2023 10:21:43 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB8B1730
        for <selinux@vger.kernel.org>; Thu,  8 Jun 2023 07:21:42 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b1a86cdec6so6183071fa.3
        for <selinux@vger.kernel.org>; Thu, 08 Jun 2023 07:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686234100; x=1688826100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snLcwp1Pt5Y7tBjy5FWt9GqXghLoW48v0lsOBATdb+E=;
        b=N/54tu/1Zamm6u0WZkauRgWUkk2R6ERKTSxrNyb85ilRuHlc7njHQuGEqROoSJAIUT
         mph6GMhb5tcpv9wThSJUseHQAX5FxcrsM3hje7GLQ+lCxhv1MAqAja/7uH9nJWMEkVas
         sLUY4sbjeAb0wkjyZ005+Ga4WP5JyhyiTjQoLJ/BLPeRqjVM6+yKk3xBExZhupK+u/zM
         1TxOzVeqQvlY5Ik8s9QI67DGYo/UDRG+AE3Iq1mXdmEAaYriGCjllg8nXVb+egGVw/9n
         HgOOnUyNTBHZCQTrrIgdCkfv2Pl624PtgPWgGdozzsfT1y4YYmWHxqjgskz5ZReCqE4T
         HKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686234100; x=1688826100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snLcwp1Pt5Y7tBjy5FWt9GqXghLoW48v0lsOBATdb+E=;
        b=h/dJKu4Wit92NcgEZBKhG0uZ6r+1/0B1mJOIOWuC67ZF04Ght0H9v+KrvACXc5IxDG
         rGxQtCdYPqdmKz66zDLGQzrNA8WTIDtMHJta9aw/ZXeZOtXUgEXg3yE/S781pw/OUEYG
         fzWiTcM4M/t6VL05PKoOgJzH1+CSTqwDbcELIZoVQGMLRRTQYDfTIUJT/XOhz9an6UV+
         R/iUCU4K5VsDh25LgH70bo1uHBXUW3WPTM/5xFJ2hyxv8Swh52t2NhF4u8zsuvw+a4qQ
         oaV64/hi7qMKT95OwgwTSz5v+MO2BI8mb2V9jueNEDaVUaUJF8Hi6Y3cTqNLO4e1Uvu7
         gPdA==
X-Gm-Message-State: AC+VfDx821xOJWOlQz2g86GlKTiG/J50pxLUWtlVqLP9h/JbBEV6GfM0
        Q+VV7qd+dr53V0vsKHTZOzbCbdrP7buFQkxZjY8=
X-Google-Smtp-Source: ACHHUZ5jOq7tLTnmkifaPO/MsJVoUPiX5cdx8gjMeRCICMbyvHG6gLvPfmRORvpsSvPLZzRuFtFDbRkzFNc16qPvmRg=
X-Received: by 2002:a2e:b6c8:0:b0:2b1:ba3c:9939 with SMTP id
 m8-20020a2eb6c8000000b002b1ba3c9939mr3657091ljo.43.1686234100093; Thu, 08 Jun
 2023 07:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230608015241.2454912-1-yamato@redhat.com>
In-Reply-To: <20230608015241.2454912-1-yamato@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 8 Jun 2023 10:21:28 -0400
Message-ID: <CAP+JOzTYNajYPUwYHMat=U3TJH1Pd6yprN0tm-EN3jxuOQaz3A@mail.gmail.com>
Subject: Re: [PATCH 1/4] dispol: add --help option
To:     Masatake YAMATO <yamato@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 7, 2023 at 9:59=E2=80=AFPM Masatake YAMATO <yamato@redhat.com> =
wrote:
>
> Signed-off-by: Masatake YAMATO <yamato@redhat.com>

For these four patches:
Acked-by: James Carter <jwcart2@gmail.com>

Thanks,
Jim

> ---
>  checkpolicy/test/dispol.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
> index b61f1b4b..50027e40 100644
> --- a/checkpolicy/test/dispol.c
> +++ b/checkpolicy/test/dispol.c
> @@ -38,7 +38,11 @@ static policydb_t policydb;
>
>  static __attribute__((__noreturn__)) void usage(const char *progname)
>  {
> -       printf("usage:  %s binary_pol_file\n\n", progname);
> +       puts("Usage:");
> +       printf(" %s [OPTIONS] binary_pol_file\n\n", progname);
> +       puts("Options:");
> +       puts(" -h, --help   print this help message");
> +       puts("\n");
>         exit(1);
>  }
>
> @@ -481,7 +485,7 @@ int main(int argc, char **argv)
>         int state;
>         struct policy_file pf;
>
> -       if (argc !=3D 2)
> +       if (argc < 2 || strcmp(argv[1], "-h") =3D=3D 0 || strcmp(argv[1],=
 "--help") =3D=3D 0)
>                 usage(argv[0]);
>
>         fd =3D open(argv[1], O_RDONLY);
> --
> 2.40.1
>
