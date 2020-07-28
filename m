Return-Path: <SRS0=YleE=BH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C52C433DF
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 02:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0210120759
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 02:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="OgN/D1fi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgG1CRw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Jul 2020 22:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgG1CRw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Jul 2020 22:17:52 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D8BC061794
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2020 19:17:51 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id g7so10782728ejw.12
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2020 19:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lgHYK+mpeEraEmj5abUsi++1XhgozLZYuja2smflQxw=;
        b=OgN/D1fi1/frlLIKlTYpaUc6icbZw6bHq97Fiacg92p9i2/BH5cSO1Gady4CayiI+S
         zLqKKcbciwtG6A8DUogtvdq9852kf0I527wv3JIW+cPd8sF5cdUERGNQuiuSQnSapg3j
         Qigjj8w7pJpofshyI8obV+lDoAyGzRtO40+rFUrKhtUDftUjPg8LiyQGzPaNDzDrPR76
         1muEATHVB3LlEnMyzq4vtr0EkGiMM1ohikkGvI392gwfGN/BG18tUz+vrLS06YQSwX2X
         BdEjhNsSprQsEnR0t65Gx7q2HFHqnqpl7MuSYLLOc34+K3gO4+weDEqkm7biuHcXTjFw
         1oqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lgHYK+mpeEraEmj5abUsi++1XhgozLZYuja2smflQxw=;
        b=slqB5uPpabnIob4V0snebjlmtpqAZeM3FSFXB6vhE2sQ4rUKHRpHPC7Zbv/kvqGymI
         2tjcjmKRMMra5s+hLH/WQQehpCVVZ3gASSFxuR2CG1unj+IgLadkxFVAxHpDwdnXSb2h
         xhlgekWCgmjNInfur5b9qB/9G65bxsywXNbUWIIt9FjMHYxHluhE7HgXlR01n+LVpPzz
         m3Ll2zPV/nm4Q0kXLi39HWKEyLAfV4zTkcCOubZZTlPjJc3ZGe9Tg9gtrYr1wKGS6GCn
         AUS1P96mjTuNQkNOr3CpiVTiuIZAeO8Eval5qEEQjCzIT+YA+vM6W0chNqMosqxefAT3
         5VJw==
X-Gm-Message-State: AOAM5321TDeGsecskvbaCZZP/MdnEdC2SL9gPNGC5VBuFRl4w8jOlXAw
        geGVvpxGEQ0iJUeq1x1TJFETDpv9axIODc80LF//ypc=
X-Google-Smtp-Source: ABdhPJy6e+rcTGjdOMtkdawah4BRecXtvc/vnVIzQsmeNIkMZ9VP/165jhj7dE/9M5KSvCL51wfmCH9sUN+rVWaDBZE=
X-Received: by 2002:a17:906:1403:: with SMTP id p3mr23132316ejc.106.1595902670555;
 Mon, 27 Jul 2020 19:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ6twZempmDtTBQjUxs_x9PJr5eQf1aSLJ1a6OpM_1eR=g@mail.gmail.com>
 <20200723075008.2256123-1-dominick.grift@defensec.nl> <CAEjxPJ49ieRSuPcTzu=J_ZiKXYSP42bOtHJhVhmvK9htR6R51g@mail.gmail.com>
 <CAEjxPJ7R0au42cBnx2onBOHRtJm6husvC28zU0RBPkVEt6Lqyw@mail.gmail.com>
In-Reply-To: <CAEjxPJ7R0au42cBnx2onBOHRtJm6husvC28zU0RBPkVEt6Lqyw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 27 Jul 2020 22:17:38 -0400
Message-ID: <CAHC9VhSCHs3p7sRVQFSvfhP5AMRibLnQunAx7MChmz2zqO_KZw@mail.gmail.com>
Subject: Re: [SELinux-notebook PATCH v9] objects.md: some clarifications
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 27, 2020 at 9:44 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jul 23, 2020 at 8:00 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, Jul 23, 2020 at 3:51 AM Dominick Grift
> > <dominick.grift@defensec.nl> wrote:
> > >
> > > Elaborate on labeling. Touch on the significance of the default state=
ment, on various av permissions related to labeling using the libselinux AP=
I, and on how the kernel and unlabeled initial security identifiers are use=
d to address labeling challenges in special cases such as initialization an=
d failover respectively.
> > >
> > > Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> >
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Applied.

Thanks everyone.

--=20
paul moore
www.paul-moore.com
