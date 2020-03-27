Return-Path: <SRS0=745E=5M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABFEC43331
	for <selinux@archiver.kernel.org>; Fri, 27 Mar 2020 14:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB7A206F6
	for <selinux@archiver.kernel.org>; Fri, 27 Mar 2020 14:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5fbKtLo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgC0O1e (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Mar 2020 10:27:34 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:39206 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgC0O1d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Mar 2020 10:27:33 -0400
Received: by mail-io1-f43.google.com with SMTP id c19so9989691ioo.6
        for <selinux@vger.kernel.org>; Fri, 27 Mar 2020 07:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MUnUFnPERDnn7etQyQvfPIEOQtiKOO19I5v33BgJgCQ=;
        b=T5fbKtLoizYAY2KU5ec2gyhaZK/laIo6imZ/QYm9rsF0Kh9K+INBB6HMHTqKk8GOuf
         ZlHkCB9aClaKzHvtx91gDn40TC9QCppAF0tLb+T0H7GoDf0/n5hoP4XUeFD39qjBh07d
         0wf5GHSiA1pwHCEVRzYCA1Xl+wto8borqVQLdZmJQaPJfMoIvEeJlScJ/ML5uQ/VWrGl
         ltp9+mG03v6zM4mkjcesMYKwqhrDWowpyQqSiCn6scYZE9zuPpmR2FWDXbO/3ND/02Ua
         gkj2kv3MWtCN59KS7MvRWw6Gkiln3lFEjcmFF4i48TAMp8aEVtXVWHbpVB58FPUKQQ97
         HMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MUnUFnPERDnn7etQyQvfPIEOQtiKOO19I5v33BgJgCQ=;
        b=JJB3wyTgvLmr9geL+vh8ghvxGHaWgJekqBHvqIuZE18KaSRJL9Lod/DxyvAmfV2e19
         rDbn7LoU2p3cbOM0xaIdENKGDHkXHwSBFpSshqGXJOxV6MSfXJ+JgIwYsh9GKJaVMp3b
         eX2KQgrFDO+72X7FazkG3dsZh7prSLfj+sJcQq/gAv/FxMnpYnIetdMRqHzFzf7wEt3V
         pQF/LbVUhdKwas4vV+/kmgTX1VdXhnYLSFPHo7TH85B4D4Rjo1RIzIQpu2XlWvDfXKMr
         lKAQRzZ6Bw4byART27U70tVGKseBH7Unto7W6YQUPeD1fUJ16iMPOq0cadc0cLCbkLJF
         DyVA==
X-Gm-Message-State: ANhLgQ3POFgDzCmrG82j/k+V7hIN17aNxOV/4r/HPNfuNiNm07qylhjf
        OcgdOoYnL4zJz8cY2LmovYONQxvqQsBNho/yl+0=
X-Google-Smtp-Source: ADFU+vtwwPfFsMexYfw+3eEzxp349UtsM2P/R1f7wPwZdjpPlSGU9jCVW/BlWpL/o2R2wCMLptjRPvbcnmmbd5v6E5g=
X-Received: by 2002:a05:6602:25d1:: with SMTP id d17mr802255iop.88.1585319252641;
 Fri, 27 Mar 2020 07:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAGB+Vh7VOy_y2W7rxmaWAOyBQxQz5foFNL1T2hog0er4mnEQ4g@mail.gmail.com>
 <20200326154641.7253-1-william.c.roberts@intel.com> <CAFftDdp8Us2aSmAD5Q+MR3y6WvR2QAbC+_tFGmCwZbWh+0CBTA@mail.gmail.com>
 <CAGB+Vh5P-VKru1-ztYRBe4sr7OdeOpAzATGEBHkj6Q6i6s3mYw@mail.gmail.com> <CAFftDdqqjgCBgN+LsV0d0ejHz5mBhuMgLhCHankaCDexFFEY2A@mail.gmail.com>
In-Reply-To: <CAFftDdqqjgCBgN+LsV0d0ejHz5mBhuMgLhCHankaCDexFFEY2A@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 27 Mar 2020 09:27:21 -0500
Message-ID: <CAFftDdrLuq3Dg+jgB=xW8e+r6WE1qB3iQrpAmLFDta2K+aUP4Q@mail.gmail.com>
Subject: Re: cil: Fix DISABLE_SYMVER support and drop last dso.h
To:     Joshua Brindle <joshua.brindle@crunchydata.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 26, 2020 at 11:18 AM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> > > Josh can you run this on Mac build, I don't have one anymore.
> > >
> >
> > LGTM
> >
> > Acked-by: Joshua Brindle <joshua.brindle@crunchydata.com>
> Thanks!
>
> Staged: https://github.com/SELinuxProject/selinux/pull/214
>
> Will merge tomorrow afternoon unless I hear otherwise.
Merged: https://github.com/SELinuxProject/selinux/pull/214
