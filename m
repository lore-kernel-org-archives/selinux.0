Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5CEC7EE2F
	for <selinux@archiver.kernel.org>; Thu,  1 Jun 2023 15:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbjFAPKm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Jun 2023 11:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbjFAPKl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Jun 2023 11:10:41 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03741A6
        for <selinux@vger.kernel.org>; Thu,  1 Jun 2023 08:10:15 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2af2ef0d0daso13273851fa.2
        for <selinux@vger.kernel.org>; Thu, 01 Jun 2023 08:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685632213; x=1688224213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5SBFHcpI3d+h5o9i7o3FRY60+UBS97afYfarxcEF20=;
        b=Ffax6NzP86yweqBmmZV/EZap1jmYsQbrKOZc9ue2JlRvflEU6HzwnlIUPMET7mpzSM
         dHhOdzgLmqxMTY71n35N9i3z9GDZgZGigzdR/TfGGVUHrLNisApWZ5TsGCrEHQAG069D
         e4lLN4qOKRhh5k9+EY1JHnmynzk0IsZv3qJK2U8GsZ8OTZ39edaQ8jmvZ3IN93WLJdxe
         XY1UCdQz8gXafmOJD2WTuwbsQJ3TiG2W347njLM69i2+EyhUMffToRXVN/s/pP3wpptj
         JBI5e0roQcU8D5RKYXW1ZD4B9SWIiL9vgF34GsDMpEoX4U3PY/v7+Pt7BERNCR9rXQTU
         mlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685632213; x=1688224213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5SBFHcpI3d+h5o9i7o3FRY60+UBS97afYfarxcEF20=;
        b=U43CzzjsiS8OIfc1CzVRgOi9HuZi7atIHflFUxTAn6XwPdQR4+yk7nI2wCCMpR95TO
         L4D31nyAw/viMYkHwG2QaYV7AVpnDuov1aPMsJuiHmFeW9nIFxv84+RWpN4c3Jx5XJrL
         k0O/TFAXknzUEuzvso3zuBxMfDsNK+U5uHB8XYenQWtye3llCtBQDEL3rZF/ymD0ze/M
         P+g3Y2GNPYE2A5ecoWfLK1Ks6QFZRpxHchsRTrQ9e79wN7hA1oZ3zYL8k3k4YdGKt8Y1
         g0zNlHw99oSMByIVW05Xeyo2gCqeCUJF83CbBleX2rdnuE1rZXl2PalxA1Ch89A69aK2
         tCzw==
X-Gm-Message-State: AC+VfDzy9NM81Snki3Xl5Orf1yEOlGMRneq/KAoYezc8hfw3cN6yUUpQ
        qJiSHFEtPaFqgp0R2wPQ1rN+z4R6BX3k9G1BShI=
X-Google-Smtp-Source: ACHHUZ4evVNw78YExQccS2DH7HPFn07LFuGPrQKyUtq8tNd7/QyDWRXWmjfgIGwZ3ecO1e279O2IrhEvd7hENKzRggg=
X-Received: by 2002:a2e:9f02:0:b0:2ac:e66c:e91 with SMTP id
 u2-20020a2e9f02000000b002ace66c0e91mr4936209ljk.19.1685632212849; Thu, 01 Jun
 2023 08:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230512101333.67196-1-cgzones@googlemail.com>
In-Reply-To: <20230512101333.67196-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 1 Jun 2023 11:10:01 -0400
Message-ID: <CAP+JOzScriL43-Jsbas1zA0nEmY=ntCdHnMHW+Zidr2aBGPTXw@mail.gmail.com>
Subject: Re: [PATCH 1/4] libsepol: drop message for uncommon error cases
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

These four patches need sign-off lines.
Thanks,
Jim


On Fri, May 12, 2023 at 6:17=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Match surrounding code and the message were quite generic too.
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
