Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F4AC197A0
	for <selinux@archiver.kernel.org>; Thu, 16 Nov 2023 14:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbjKPO4U (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Nov 2023 09:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbjKPO4U (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Nov 2023 09:56:20 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A0619D
        for <selinux@vger.kernel.org>; Thu, 16 Nov 2023 06:56:16 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507973f3b65so1274091e87.3
        for <selinux@vger.kernel.org>; Thu, 16 Nov 2023 06:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700146575; x=1700751375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWQ9E1g8dFn3m9OZe/t8ev1q+SL0rRcBi1OLqXCWYuY=;
        b=lBILIFaiiQKZ8uF8mvZ3/06vCiPFt81+oG0sJjylCBPbqEB24w2iEoYwPBr1Mdz03O
         l7tpGRx2jK7vvnM+jDVgwmPQp6lA/XboyrwgKdvnc9/vubv2ZQgx7/BpH2dedZGLaZf0
         cEYyPkoPdRk70zkbQqf4AyVsZrNOqk7ec0vINwwgeFx9kUnLT+L93KZhkhYCo1INU11L
         7opVoUL6df7OsjYzqB541scrPVuzmXhBWpnMNPsq3SpUqMS5RaUnDTz9fhI7tOsVvmDe
         6ZK3Mm9J/r9++35lt+laOf9aQ62PEmUfXhGFkJYcMvz6+Dy0/gqmsyE9B+JnHCGT1CXW
         7TkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700146575; x=1700751375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWQ9E1g8dFn3m9OZe/t8ev1q+SL0rRcBi1OLqXCWYuY=;
        b=ZnsICoqMTPIyOiDfL8xMnX8ZU4f9DxekmAkqof0gYmQwSW7tkPPWBjqdebtdYiEnak
         kUbdo1duB4VYKJc2c7Ht7nxhXQJ535j0fwdQQnvzcg1iQdGiPeIe4IWW5XGIkNwenvc+
         FTcCFbJOoOHwZoYdHgI7Tj1lORsvgATrcrAVBzi4CeGQhb8jemIFQLigmoGLPwjOP1Ti
         fzu/tXmZs1mQBLayl7SU3pBGMr9pvKhglNbgyi2S470vMIjmSiWbTTtTdg7vIiMwg0ZX
         OmSz9U/P57SzzrxnDNk+yAcv6TD4mdwUx2p4CioW23mOri9dy69R0yZhqKTXPp3Jju4c
         phkQ==
X-Gm-Message-State: AOJu0YzzznIi/RXlRgCdQupdUiEibHjyT5yEBr3wa/Cl8S2ra2DgvRy7
        9tR8Tqn6+YpemssvNaWMiLjiag9ZofklfzLIJ5iSNo8K
X-Google-Smtp-Source: AGHT+IGuosBPe8qK7QqUrp1w5h+Qm6wPFkkNy1CGZ1OIKciQbGNw1nQixZ+pBACFeREbIS3FWf10g1Iv3nHu6eXSuK8=
X-Received: by 2002:ac2:4c38:0:b0:4f3:9136:9cd0 with SMTP id
 u24-20020ac24c38000000b004f391369cd0mr10886965lfq.44.1700146574558; Thu, 16
 Nov 2023 06:56:14 -0800 (PST)
MIME-Version: 1.0
References: <20231109135148.42688-1-cgzones@googlemail.com> <CAP+JOzTqSdFv+Cz9H3wZH=gaRmSpJM_CMeBd_DwR6_r6JGtswQ@mail.gmail.com>
In-Reply-To: <CAP+JOzTqSdFv+Cz9H3wZH=gaRmSpJM_CMeBd_DwR6_r6JGtswQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 16 Nov 2023 09:56:03 -0500
Message-ID: <CAP+JOzTnZHWjGqRJ+vRhCj-nC05-pXOwFyZqY=OMCMj414otAQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] Drop LGTM.com configuration
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 13, 2023 at 3:12=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, Nov 9, 2023 at 8:51=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > LGTM.com has been discontinued in 2022 and replaced by GitHub code
> > scanning[1].
> >
> > [1]: https://github.blog/2022-08-15-the-next-step-for-lgtm-com-github-c=
ode-scanning/
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these seven patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These seven patches have been merged.
Thanks,
Jim

> > ---
> >  lgtm.yml | 5 -----
> >  1 file changed, 5 deletions(-)
> >  delete mode 100644 lgtm.yml
> >
> > diff --git a/lgtm.yml b/lgtm.yml
> > deleted file mode 100644
> > index f80bf146..00000000
> > --- a/lgtm.yml
> > +++ /dev/null
> > @@ -1,5 +0,0 @@
> > -extraction:
> > -  cpp:
> > -    index:
> > -      build_command:
> > -        - make DESTDIR=3D"$LGTM_WORKSPACE/destdir" install
> > --
> > 2.42.0
> >
