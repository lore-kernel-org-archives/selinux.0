Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FC9C43334
	for <selinux@archiver.kernel.org>; Wed,  6 Jul 2022 20:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbiGFULP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jul 2022 16:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbiGFULO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jul 2022 16:11:14 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDCF19023
        for <selinux@vger.kernel.org>; Wed,  6 Jul 2022 13:11:13 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-10c0d96953fso9146421fac.0
        for <selinux@vger.kernel.org>; Wed, 06 Jul 2022 13:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c4sqF3X4T13QiClX71gmd6tMeG4B/xs6AjB2yucyewE=;
        b=TYS/tZVLKb6ZFvXnMjZ/VlY4pLIZOjzbM1ljrzuxSaq47W4KFkbH4tM+mc/5u9M5r5
         vN+uPo9ONZkJa4PsrcjVA2ja/gtLzadLn1KxzluCljoWOfrdaJyYt8NHcmfanMYXknW/
         2hMRzXj1TEFw9RqKg7LrdiV1zOTbMRQdyhXefZjwvskF5fYFcpzecnRoLD5zDczugyLo
         FKroF95aE3mzPlpFkBbfokMPbasPm6vWKTBgFAkF5aqeIZj6nFu3XyHS4fdLgRFvxw9E
         QBp/VWiwBevO+EXRfxg2n5oDXPlUAay56aqXXeCBlCv3YnG3szjwYVMngiVFF6YSKKFV
         Qx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c4sqF3X4T13QiClX71gmd6tMeG4B/xs6AjB2yucyewE=;
        b=QN89LqVl5rSgOCj3HBStLlQLfcxa+KxjNN7AB9HLooOvS2fgdWueDK8MhH8ZY0HkEV
         wdhrYQLdGeDrfCw6TJWv00jYRH3Fzg4Pmi+VlJseIgv39ZjrEGnlLxMRPmfY55bsxfWj
         28oUVLYWYdf6JkAutiR/Cg403kJkasGs0IWnxcVDunzfQI2xS4KkaBL27sE23eKoC/1U
         CLGZisiHd449XkSkRdJZzF6AFr7UoBnGlGj9Kg/QO5Y5rr2HUaaMXMyruTObnyN7n98K
         7wD0l1hAB27LEwTMnivV7Y5Nx+grQwjAhh4mjckSmZXzBFDYjEv6okFcyxljtEgZuw06
         MX4A==
X-Gm-Message-State: AJIora9JiLFn8aYpVYw2PdVuk6VXaxpzLHk6R8HtEjOx1X8leqsCmxOb
        kfAeeHdMPHoIUgAbAChRoE2OZF3lI9RfVUy6byngOa3G
X-Google-Smtp-Source: AGRyM1vFhXgesXMws31opH2892BpDmCE/p1fFUXtonLit0STyX4LdzLriqzEI5uea/bytAv1XpXGnQu1aG7XQm34Sbo=
X-Received: by 2002:a05:6870:d68e:b0:e2:861:8b15 with SMTP id
 z14-20020a056870d68e00b000e208618b15mr276040oap.156.1657138273172; Wed, 06
 Jul 2022 13:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220610150623.21082-1-cgzones@googlemail.com> <CAP+JOzTgmEChGDe-7j8rrh1PNJQBY9AOJx4gkTdtxM_FxNauaw@mail.gmail.com>
In-Reply-To: <CAP+JOzTgmEChGDe-7j8rrh1PNJQBY9AOJx4gkTdtxM_FxNauaw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 6 Jul 2022 16:11:02 -0400
Message-ID: <CAP+JOzQaTOZ4CFQOh7p2MvvqKxL5Wwnf-xdxbBX4PegS8=jWQQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: avoid potential NULL dereference on optional parameter
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 29, 2022 at 1:59 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Fri, Jun 10, 2022 at 11:12 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > The parameter `reason` of `context_struct_compute_av()` is optional and
> > can be passed in as NULL, like from `type_attribute_bounds_av()`.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsepol/src/services.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> > index d7510e9d..24412d83 100644
> > --- a/libsepol/src/services.c
> > +++ b/libsepol/src/services.c
> > @@ -894,7 +894,8 @@ static void type_attribute_bounds_av(context_struct=
_t *scontext,
> >         /* mask violated permissions */
> >         avd->allowed &=3D ~masked;
> >
> > -       *reason |=3D SEPOL_COMPUTEAV_BOUNDS;
> > +       if (reason)
> > +               *reason |=3D SEPOL_COMPUTEAV_BOUNDS;
> >  }
> >
> >  /*
> > --
> > 2.36.1
> >
