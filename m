Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A69CC001DE
	for <selinux@archiver.kernel.org>; Wed, 26 Jul 2023 05:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjGZFjN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jul 2023 01:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjGZFjM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jul 2023 01:39:12 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1388310CB
        for <selinux@vger.kernel.org>; Tue, 25 Jul 2023 22:39:11 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-26813478800so1764237a91.1
        for <selinux@vger.kernel.org>; Tue, 25 Jul 2023 22:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bzdzb-com.20221208.gappssmtp.com; s=20221208; t=1690349950; x=1690954750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TYQ0BVBvZTOCvI/FzH6ve1D8Z37B89W1NJbrejSx60=;
        b=WwFS7w1FpAFhf0/eSfck6NtCT/5tcCC6XwMIePqVSnPsZ6JrBDBAcWkJPzAm/aHiBH
         XvWfB2Ee5BKtf7w4h2r+N8RjlITSDmb0leIgqjlj2I4vL7ZWKfTPm24P+71l+Le9mbCC
         JxwVnWD9xvjYyg0e0D+9OyHbWNGx0RL/R27xrhnQXtsyLjd2fdcoYkMTPWV0NBaaOnMm
         Ne+n77vk9MfLGpTjSJy7vGuoj5ta0kFP09ppXWeanNhMdvGDIYItgemBKWs1bewsBXdG
         mEIbNP3Kahda5nvGo24NXkvuSQ/ZKH+znE/EZiuE2GRq0qXK8BOFFSGcfU7LDOW+IuEE
         cTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690349950; x=1690954750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1TYQ0BVBvZTOCvI/FzH6ve1D8Z37B89W1NJbrejSx60=;
        b=MEefA7ibKwzywcoEE+z94t8Kveea7kiJaTsP2C+rjHhX068blIS8kc+G62M8+ePgBM
         bf9Shh4/LAKA0Te7pLdI2V2t2cwVPkJUavXe1vPTowbV8lcBiIWh0KSM5miNM45EdfGU
         Hu4eqSf/QblZ67RFzwByMub+sEFGGcTJqHn1BQR9O5NB9TWx0m4vn76bDz3H9cwSWyxj
         1zziaUXfujVRiijwVEL30mK8GxrCZg/jRFlwsuHu13/pO9B7ySwXQyFRiO+n5dIf7zIY
         SiwRfb1vXuZx9og2PK7wRCJMX3aWkHDCXmANBGb6mdnxeERNuu3HOJ1zA01gxeac/U/p
         vYpg==
X-Gm-Message-State: ABy/qLa/XPOTgRtSJNck8nOHxphstUe8Df+p5TKU3VhRKXh22apavfIp
        wI6Rq5jii00iabNq1rtGw1N+Ds1+3LP8WQCl/cHPSQ==
X-Google-Smtp-Source: APBJJlHF5n3m7uBmTER4PHrmkvcfzIu5BQ+Ptc+B6Keo2SZzCmv4IJAkRd9VL3CtMdt3XA+tMfarcG/IqBUPDFtclLU=
X-Received: by 2002:a17:90a:9112:b0:263:a37:fcc3 with SMTP id
 k18-20020a17090a911200b002630a37fcc3mr880842pjo.5.1690349950444; Tue, 25 Jul
 2023 22:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAPQCZivM+qGve5eUekri3_iEzAPE5o3ymqOunYMjQJ=4mRwPUg@mail.gmail.com>
 <877cqv6m7g.fsf@defensec.nl>
In-Reply-To: <877cqv6m7g.fsf@defensec.nl>
From:   Brett Anderson <brett@bzdzb.com>
Date:   Wed, 26 Jul 2023 01:38:54 -0400
Message-ID: <CAPQCZitsWEmZopbg0fEVx73XGW=ujQXozZk1-imK-vGDjQRBzA@mail.gmail.com>
Subject: Re: SELinux Mascot/Logo
To:     Dominick Grift <dominick.grift@defensec.nl>,
        Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I submitted a PR with SVGs and PNGs with the existing dimensions and
file naming scheme.

On Thu, Jul 20, 2023 at 4:06=E2=80=AFAM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> Brett Anderson <brett@bzdzb.com> writes:
>
> > Hello!
> >
> > I made an SELinux logo for my own purposes and figured I would share
> > it with you in case you would like to use it. I'm putting this into
> > the public domain and you can do with it as you see fit; attribution
> > would be cool, but not required.
> >
> > https://imgur.com/a/khkSEux.png
> >
> > Cheers!
>
> Nice. No .svg? Check out: https://github.com/SELinuxProject/selinux-artwo=
rk#readme
>
> --
> gpg --locate-keys dominick.grift@defensec.nl (wkd)
> Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> Dominick Grift
> Mastodon: @kcinimod@defensec.nl
