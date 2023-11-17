Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4265BC072A2
	for <selinux@archiver.kernel.org>; Fri, 17 Nov 2023 15:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjKQPa4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Nov 2023 10:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjKQPa4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Nov 2023 10:30:56 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B81DD56
        for <selinux@vger.kernel.org>; Fri, 17 Nov 2023 07:30:52 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507a29c7eefso3072916e87.1
        for <selinux@vger.kernel.org>; Fri, 17 Nov 2023 07:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700235050; x=1700839850; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Di5jhtTTI5coMwCZ5Ml2IFIsNFGb9iyA2VO0pqDlbqk=;
        b=gxfft+IHEVzBNveNjl0gl77M7AvvHnJLQqX0LV01cCIGG2SLsuvIUfdvUOCTS9rVyv
         Lae/kG8UZ0aBjtt9+vMh78LBKPKactnhcBuRKjOczjSxOFmIZ/tBn/qYgs+qMic7qbNg
         zk2+nleI3ywe/hW8mQnmVczm/UfcC3ZE9e+k2pVe1q/UmLzyb9s0K5ja6IYAuYc0I3LY
         q89KTZKO1In5acU7PbTWRhKe2SVY491kivF4zK+uhmNGjH6s2WZvca8w4FUyN38kHDXe
         cZw8hVAjO/dd5lUlEPgvIBQ+rYx1yBAfLoBabf3+zl20M7kCpAaDiPuN5y+9hT0oJdio
         gQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700235050; x=1700839850;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Di5jhtTTI5coMwCZ5Ml2IFIsNFGb9iyA2VO0pqDlbqk=;
        b=YKGBh6r8FkqB9yPE/NvtzQ0e0zyUlrReYG5boivZWcDKH5VO28jad2oOsExvw4c8Nr
         zqVCiswNLx1HlUOhcFMJUDh/boBe/0X/3mTHjBvk6DmsT7jSvwjtlsTsvj5z4LY/MrtN
         HwHoQtx7f7KFD7XRG7KGadKCAF+qwTKyA6UKsJQqUiiwSnjF2mtCEQMaQ8B8ZZNE3dLJ
         Huj67BMmrnoHxcHMKQ9FoS1EzOM8TUjAv1/LFKrFOT3+EOjLN65jhQlX0aYrxfVnQ2tA
         VPib8Fn1TDkhs68R97mr3swCh2nsH8tSagu51sLDK5AOBAyceSQAxjLwf4tjcBZZNrOk
         Dlhw==
X-Gm-Message-State: AOJu0YwkK4Y1JhNVJXXdnnUXxhOmVvIbqSnckMhXw5i9l4beMQa4wrVw
        NlAoRmMRG51b549uGoQOCpAJbASZmsX6LO6S/5+muiAy
X-Google-Smtp-Source: AGHT+IEzNMElBXPNS404zWRvxKPvSnkEBxnx0LGvZxj0DSnb2RkGwkcBr4/duKvF6czBtKv1whRtHEWiPORuNW3q/iM=
X-Received: by 2002:ac2:5471:0:b0:509:297d:b7a2 with SMTP id
 e17-20020ac25471000000b00509297db7a2mr13302892lfn.65.1700235049807; Fri, 17
 Nov 2023 07:30:49 -0800 (PST)
MIME-Version: 1.0
References: <20231013135207.1462729-1-jwcart2@gmail.com>
In-Reply-To: <20231013135207.1462729-1-jwcart2@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 17 Nov 2023 10:31:43 -0500
Message-ID: <CAP+JOzTTa_BnpocHZ5_AAJO99z3gF2FbtBj7L=_iOU93LYPVKg@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Do not allow classpermissionset to use
 anonymous classpermission
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 13, 2023 at 9:52=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> Macros can use classpermission arguments. These are used in two
> different ways. Either a named classpermission is passed (which is
> declared using a classpermisison rule) or an anonymous classpermission
> is passed (something like "(CLASS (PERM))").
>
> Usually this will look like either of the following:
> Ex1/
> (classpermission cp1)
> (classpermisisonset cp1 (CLASS (PERM)))
> (macro m1 ((classpermisison ARG1))
>   (allow t1 self ARG1)
> )
> (call m1 (cp1))
> or
> Ex2/
> (macro m2 ((classpermission ARG2))
>   (allow t2 self ARG2)
> )
> (call m2 ((CLASS (PERM))))
>
> The following would also be valid:
> Ex3/
> (classpermission cp3)
> (macro m3 ((classpermission ARG3))
>   (classpermissionset ARG3 (CLASS (PERM)))
>   (allow t3 self ARG3)
> )
> (call m3 (cp3))
>
> The oss-fuzzer did the equivalent of the following:
>
> (classpermission cp4)
> (macro m4 ((classpermission ARG4))
>   (classpermissionset ARG4 (CLASS (PERM1)))
>   (allow t4 self ARG4)
> )
> (call m4 (CLASS (PERM2)))
>
> It passed an anonymous classpermission into a macro where there
> was a classpermissionset rule. Suprisingly, everything worked well
> until it was time to destroy the AST. There is no way to distinguish
> between the anonymous classpermission being passed in which needs
> to be destroyed and the classpermission in the classpermissionset
> rule which is destroyed when the classpermissionset rule is
> destroyed. This led to CIL trying to destroy the classpermission
> in the classpermissionset rule twice.
>
> To fix this, when resolving the classpermission name in the
> classpermissionset rule, check if the datum returned is for
> an anonymous classpermission (it has no name) and return an
> error if it is.
>
> This fixes oss-fuzz issue 60670.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

This patch could use a review. I would like to get it in the upcoming relea=
se.
Jim

> ---
>  libsepol/cil/src/cil_resolve_ast.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_re=
solve_ast.c
> index 33b9d321..49de8618 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -254,6 +254,12 @@ int cil_resolve_classpermissionset(struct cil_tree_n=
ode *current, struct cil_cla
>                 goto exit;
>         }
>
> +       if (!datum->fqn) {
> +               cil_tree_log(current, CIL_ERR, "Anonymous classpermission=
 used in a classpermissionset");
> +               rc =3D SEPOL_ERR;
> +               goto exit;
> +       }
> +
>         rc =3D cil_resolve_classperms_list(current, cps->classperms, extr=
a_args);
>         if (rc !=3D SEPOL_OK) {
>                 goto exit;
> --
> 2.41.0
>
