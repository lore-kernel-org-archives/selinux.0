Return-Path: <SRS0=GpsN=BV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98813C433DF
	for <selinux@archiver.kernel.org>; Tue, 11 Aug 2020 19:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6605020771
	for <selinux@archiver.kernel.org>; Tue, 11 Aug 2020 19:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRo8a5L9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgHKTwI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Aug 2020 15:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgHKTwH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Aug 2020 15:52:07 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B21CC06174A
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2020 12:52:07 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id k23so14250803iom.10
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2020 12:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xk9Oo5DsLHA5uEG9mbrA/FsRgcFyRo78TptPiJeQZgE=;
        b=jRo8a5L98O21fFPUgJz885CCyGm5SNmTlpp6JoAdYDOYtkSiD/jE8B/8ciN0YF7P9n
         XfMA19+tdbmUaPn4tOAufZpmkQgjaRwVp9zySZM0ai9pH7YxOdW3+mrM9YFiwQZxb786
         IPRJp7U7wctSaXLiq8eFEdPPD5XyVieR+8JFrKc3LIrdrJniz13Y05uxvYLXizQEIbvT
         WS4YdVrrJr1QRDPKIGf5mwXsVfbCrfKNk9A7PGgmaQKtY2w9GRC7iXaoqF77bnN3Wx+c
         od9IHw2DCdTFee1A/zTjh19ijzZ9/RJ/NlnaEtnOPDI2ovop3fknLr5ZIwdwofgtka+4
         mkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xk9Oo5DsLHA5uEG9mbrA/FsRgcFyRo78TptPiJeQZgE=;
        b=dqK/qwbXREBmUMx11+HQzqDWWXEWvG/ghmxR1qK3BiwSI0JgA0aMQKYg8QMMkZbP3V
         WbGbgiH6eGtXB935wZTzu7HKH73IYulTbBZjiWitQu4sJVjJ6y4je9A1X2mwiT/chllk
         phbtHIgm4I9UC48BKzceMogVHDaxo2QpYJ0A34cx5al8PXnj/kWDoA++SCZUhoYSLZFe
         YKTbpi5eD8TxHClFHtHAb0hz4nYWt6U0fzBalpmVdEn53ToIy9MQv4YE8bN8jFQO72r/
         +Oh8jQIT0BuwgRNHrqW9/zx82zVnHVMapsUUa2BaGi6LUbLnV4UoYljbEZQekl87Rrt3
         HEFA==
X-Gm-Message-State: AOAM531b0SCgFnbMyvhlx21bTO/RSBAso+NC8hZvfzIHyf7I2ZD6NVQl
        hxIu+PsEm9C2/c3Qz2mChuSTcx2Lo1s8PPjksMs=
X-Google-Smtp-Source: ABdhPJxDzTYyO9XPzI7r0Zv//ct0vw1xVirVnTEKs6IJgidLzQJrU1xJcibi+vMwszPiEfJoj9WyOkqoLRNQTitxZ80=
X-Received: by 2002:a02:2407:: with SMTP id f7mr28673907jaa.130.1597175526761;
 Tue, 11 Aug 2020 12:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200811191035.13948-1-william.c.roberts@intel.com> <CAEjxPJ6sLaiVrh59AYonbDNi2jsY6YTGd5ygYx=QBGaTC7rdSg@mail.gmail.com>
In-Reply-To: <CAEjxPJ6sLaiVrh59AYonbDNi2jsY6YTGd5ygYx=QBGaTC7rdSg@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Tue, 11 Aug 2020 14:51:55 -0500
Message-ID: <CAFftDdqoA_k6jtpFbmaSBpONtEarUfF6DdrG-m47EbQSqwYx_w@mail.gmail.com>
Subject: Re: [PATCH] ci: fix stall on git log -1
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 11, 2020 at 2:16 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Aug 11, 2020 at 3:11 PM <bill.c.roberts@gmail.com> wrote:
> >
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > git log -1 may use a pager to output long messages, and when the pager
> > is invoked, leads to stalls on the ci system waiting for user input.
> > Use --oneline to print the short part of the commit message and
> > the digest. This information is for debug/informational purposes only,
> > so truncating the output is sufficient.
> >
> > Reported-by: Stephen Smalley <sds@tycho.nsa.gov>
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Staged:
https://github.com/SELinuxProject/selinux/pull/259
