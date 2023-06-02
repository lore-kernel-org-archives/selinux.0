Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C358C7EE29
	for <selinux@archiver.kernel.org>; Fri,  2 Jun 2023 20:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjFBUYi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Jun 2023 16:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjFBUYh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Jun 2023 16:24:37 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12E31BE
        for <selinux@vger.kernel.org>; Fri,  2 Jun 2023 13:24:36 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2af2d092d7aso35566431fa.2
        for <selinux@vger.kernel.org>; Fri, 02 Jun 2023 13:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685737475; x=1688329475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOZIzInVjT9+NCQBusglaL+T6JXAIRvmmJdv+H1HDIo=;
        b=nFs5SA23Yu+t7lkYTcaBYDedCpXg/chF2/zVY+ig4rIbq/yoqrlfGe6Vc7kVzS0elb
         KIKOsubffR/CLmqheFVrx2pLL+/mmbub2BL8dg0m/1kfmu6hLVSUMIcA+4lZvmWXETB2
         h3a8AvPxDts1Dmpp5JCl7GmG57JVrKdhlYsR765CgZytFFQsxoQmNPBjozcuO1NdlhZd
         7dHjsF1iIEey8K61PXbqyUZKQB18UyE6yKJzaUb6eMKnxCT8VB14owBbFXamPZH4F3RH
         Byo52aIymsH0nJ0sT84mt9PfqNA+EA2NYQtRbSuMptwQRw87fW8auHa6FNtz/uZSkGG0
         emLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685737475; x=1688329475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOZIzInVjT9+NCQBusglaL+T6JXAIRvmmJdv+H1HDIo=;
        b=ZhTqwGdYO7ZA1IQBE2+1wfjWElsc0Q2nRHef9pYgGpEHpAfxxocTJBxl3sFns+N7Yd
         0c4qecQWVgKZdT+LG/PpJ2HjdgJRkxFbkxoglUqOuT0L/GuacI2U4taY8Yuq5a8kueA+
         Jzf8EXrhbMMTdv8+siLvw5Ay9lA9OUZJuqRDkM2KbYIySmald5TOp1BJLZoj8Y+qK8qk
         /psck6d8f/yXu+T+ZaG/N46TVRDZPlv2sl9JsQjYzhkd5/rjq3M9zb7YSBihdJnzd0D8
         NfaC4WlMAetClNwSzmpBtubajeOBH28pwPQbx+7R7Y+UcVfKx2M9Ybo+9ZhHLcnsqk7Y
         K1LA==
X-Gm-Message-State: AC+VfDxrNOvJICMpbJbEVOzTOYcIqUeh6HlyLo5dFSckQkq0o+qmDvc9
        ZNonK7KRFqofRB/jqKP6ktZJ1QXCwbmGaaCBqQbgt/OcHzM=
X-Google-Smtp-Source: ACHHUZ5a/VRygsyhtLQDpLOriDVPPIdAnG9FOiZqcTHDwmOO3K5wmS4WusF+7EAilDkn+820sAcJ8XG+2KNRMouWnnY=
X-Received: by 2002:a2e:b2d0:0:b0:2ad:275a:44b6 with SMTP id
 16-20020a2eb2d0000000b002ad275a44b6mr556345ljz.52.1685737474796; Fri, 02 Jun
 2023 13:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230602130608.24586-1-cgzones@googlemail.com>
In-Reply-To: <20230602130608.24586-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 2 Jun 2023 16:24:23 -0400
Message-ID: <CAP+JOzS1suo3BcDq4rZUqpSxRaEmJcH5+xM7buuwJ42d+0dVqw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] libsepol: drop message for uncommon error cases
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 2, 2023 at 9:07=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Match surrounding code and the message were quite generic too.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For all four patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v2:
>   added signed-off
> ---
>  libsepol/src/kernel_to_conf.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
> index c48a7114..cb7cb740 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -2886,7 +2886,6 @@ static int write_xen_pirq_rules_to_conf(FILE *out, =
struct policydb *pdb)
>         for (pirq =3D pdb->ocontexts[1]; pirq !=3D NULL; pirq =3D pirq->n=
ext) {
>                 rc =3D snprintf(pirq_str, 21, "%i", pirq->u.pirq);
>                 if (rc < 0 || rc >=3D 21) {
> -                       fprintf(stderr,"error1\n");
>                         rc =3D -1;
>                         goto exit;
>                 }
> @@ -2894,7 +2893,6 @@ static int write_xen_pirq_rules_to_conf(FILE *out, =
struct policydb *pdb)
>                 ctx =3D context_to_str(pdb, &pirq->context[0]);
>                 if (!ctx) {
>                         rc =3D -1;
> -                       fprintf(stderr,"error2\n");
>                         goto exit;
>                 }
>
> --
> 2.40.1
>
