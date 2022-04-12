Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E23C433EF
	for <selinux@archiver.kernel.org>; Tue, 12 Apr 2022 18:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243685AbiDLSE4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Apr 2022 14:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbiDLSEz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Apr 2022 14:04:55 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AEF5AA65
        for <selinux@vger.kernel.org>; Tue, 12 Apr 2022 11:02:37 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-deb9295679so21581825fac.6
        for <selinux@vger.kernel.org>; Tue, 12 Apr 2022 11:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=frPeeTtkmKSA+LN+taXlxD5MqaLxUwSU45k69Lm1jgo=;
        b=dIQm1wn5ZsmSQI7axowMpfEnlH8JSBW0HEBNXDB9DAqyU22v0PmVO8u6l8AaXUN426
         Nam8UMiT/iTGj4Je3CE86DumHj0lfXNvD0Y/WtQ0TxHgN3VlakKisTSza2Jc7v1Oi++E
         713IR+bONw+N6HT+UF02vs/yhmoJWUsQ2MDy+PCaPELI3V5FE9U2KyzOJv6b3f64L6Dt
         GgUHc9Tt5FRFuX3jOaTnFktnIGMKszCxEMuHbfnXp1ufqPEBHWycZKQ0f5vG0doIGmMR
         VRTaSucrGv73vvWRdUoedqBECVPq3C3b9xA/77EsNFqVafgsJUru4Wth7tVo8zuYwnwz
         sW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=frPeeTtkmKSA+LN+taXlxD5MqaLxUwSU45k69Lm1jgo=;
        b=rDvngP2x/kDSCxV72+j+TJeHpEoPal2hwhxgheTx7P9EHDSf8mTZPTf52Ge6gXfT9q
         ttmIyAf8NcDgV5FmxN48PrLbbobFbvCObrgUVi55YfJeeEt1vG8nDj1+fT63QQo9eUB/
         To8IhskidXUwwxBeDNKS7haAEgHzdIJOc22jAA9hmOJD8LTgBmYiDyKzHjXNEGNRkosx
         tiHORjDdBN80a5i80JWCkh6VyQ790zYfBHbWJUEYpmuzLTMCc+CAiJYVuwedsXyYUBPk
         OVQvIhVcpRoM7PkaGCApzp6oSzfMZR/++b1bj7YbtSwHNfKTElM0pqpMEmjEll3OGvIS
         iC/A==
X-Gm-Message-State: AOAM531RN7T+LKqa3v8BNAFOQWUXJn6ddWjtAVex/4IUVEZGlXcXzQ0E
        4VTLOeXd/U2mbxWdjZwzCrpGSS8wW2BLke4736lm3NCD
X-Google-Smtp-Source: ABdhPJySyCDgZkEYtwjywDVEcPV86H6xaZMvsMz54mIr1arMR6h9rImh4noOQrWqW4zbrP4yAwhHoNbCggoOW44uQkQ=
X-Received: by 2002:a05:6870:f624:b0:e1:c071:121c with SMTP id
 ek36-20020a056870f62400b000e1c071121cmr2678281oab.182.1649786557013; Tue, 12
 Apr 2022 11:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220408131054.7957-1-cgzones@googlemail.com> <CAP+JOzRBK=rEb5Kfa1DFOMwS24D5fuLTB7NXFy=7QBj5BqmKcw@mail.gmail.com>
In-Reply-To: <CAP+JOzRBK=rEb5Kfa1DFOMwS24D5fuLTB7NXFy=7QBj5BqmKcw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 12 Apr 2022 14:02:26 -0400
Message-ID: <CAP+JOzQb2PodZteiNLqgOFq_P_=r58AtjAAaZVSejtHHeaJDsA@mail.gmail.com>
Subject: Re: [PATCH 1/5] libsepol/cil: declare file local function pointer static
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 12, 2022 at 9:03 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Fri, Apr 8, 2022 at 9:37 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> >     ../cil/src/cil_log.c:45:8: warning: no previous extern declaration =
for non-static variable 'cil_log_handler' [-Wmissing-variable-declarations]
> >     void (*cil_log_handler)(int lvl, const char *msg) =3D &cil_default_=
log_handler;
> >            ^
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these 5 patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These 5 patches have been merged.
Thanks,
Jim

> > ---
> >  libsepol/cil/src/cil_log.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsepol/cil/src/cil_log.c b/libsepol/cil/src/cil_log.c
> > index e45c58fc..f4c6e415 100644
> > --- a/libsepol/cil/src/cil_log.c
> > +++ b/libsepol/cil/src/cil_log.c
> > @@ -42,7 +42,7 @@ static void cil_default_log_handler(__attribute__((un=
used)) int lvl, const char
> >         fprintf(stderr, "%s", msg);
> >  }
> >
> > -void (*cil_log_handler)(int lvl, const char *msg) =3D &cil_default_log=
_handler;
> > +static void (*cil_log_handler)(int lvl, const char *msg) =3D &cil_defa=
ult_log_handler;
> >
> >  void cil_set_log_handler(void (*handler)(int lvl, const char *msg))
> >  {
> > --
> > 2.35.1
> >
