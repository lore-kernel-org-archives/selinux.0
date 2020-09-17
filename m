Return-Path: <SRS0=4esc=C2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768ABC43464
	for <selinux@archiver.kernel.org>; Thu, 17 Sep 2020 20:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 406E8206B7
	for <selinux@archiver.kernel.org>; Thu, 17 Sep 2020 20:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oea1gOpY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgIQUUr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Sep 2020 16:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbgIQUUr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Sep 2020 16:20:47 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DD4C06174A
        for <selinux@vger.kernel.org>; Thu, 17 Sep 2020 13:20:47 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id c10so3118736otm.13
        for <selinux@vger.kernel.org>; Thu, 17 Sep 2020 13:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7h7nGzYtgZ0ykSgp/t8cCub58d2a2nZY3Hv4oUMb4o4=;
        b=oea1gOpYRsrPE9+0QhN/65JiOfCoQmYTMu7akBZEbazewYY2Z4UwVytJnf9hktm8ck
         pXh5oyd6sxvC+nUsiOhfQFTm6EgwcAN5Yysq2HdxWMI2cQhaHEgNFKXnCeh4iytOyQJY
         tDY1OSzwfsTNKwdp+cv4gizI6a0Hd7cmK8MSZaLdAfH4/+KhH8jBnFxd0fsJwl2G//uP
         dbA9JecI8Iif8TBlvJ0ClneY96r/+KuIpMQaij/GX3XIinlVme2wDjX/R61Mzcj04Ctj
         yrnXQzPC3r/Yn0PRHdGTl8uj3RYJXHULM1w0T20cPi4Dlm3O101NbwKzxWCse572I4kz
         9eVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7h7nGzYtgZ0ykSgp/t8cCub58d2a2nZY3Hv4oUMb4o4=;
        b=HSjs28q2whWYcImzaYMlAKm87SbXiOu57Cltw6De5Pme/0tN9h4Ilc5oK0exWqk9lR
         8LyvWj38AMzyZD40VTtloSzQl1BpTTCTClGLuWk45VqOck/MQOmif5TwHYSxeSxYJv0V
         u/nIzDKX1IgUlxzVc+A9QkGxMHGljRgxnZrvXganbfvTrklzeL516XsEKFEpNfMFI5JF
         H3sxfm1yeO8JOzLnEkXi6PNYH7BwWcicHWnh08ykF9cu3ohLXvl5PWm/CQqiy8Yb4Hdi
         SJziH1Ut9Uq9H0/NigXkUUdI0lLln16pit0F2oKEzbM3M/cRICQ8rsrYxKG6Gxwk/HoX
         sGPQ==
X-Gm-Message-State: AOAM530hWNxfrQbNsRCvMhHod1C4bQ8Sb5dVYzxOChKdYD3JtTqmrCqx
        THkIxOSpGzncAIxsBGB3NBbIuw1Ny1EWBptfNApt5gu7
X-Google-Smtp-Source: ABdhPJzQY5J0TAjoEFVZPYFg+tzaV3DCTizS4VmRY3WcBuwDHxFid0hkxQhaktzywhWQh1kIO3U7Umt497AJ9ZZyrnk=
X-Received: by 2002:a05:6830:1be7:: with SMTP id k7mr20933191otb.162.1600374046972;
 Thu, 17 Sep 2020 13:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200915184806.396309-1-jwcart2@gmail.com> <CAEjxPJ667-sqywnL+nib6ndhbpSD7FWDq-ghnbttmVZx+-hi=w@mail.gmail.com>
In-Reply-To: <CAEjxPJ667-sqywnL+nib6ndhbpSD7FWDq-ghnbttmVZx+-hi=w@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 17 Sep 2020 16:20:36 -0400
Message-ID: <CAEjxPJ54kwegorP4Hcd4FZigz_57DV6MnMDXieoAK-p+Ksv2ng@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Fix neverallow checking involving classmaps
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Jonathan Hettwer <j2468h@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 15, 2020 at 4:45 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Sep 15, 2020 at 2:49 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > When classmaps used in a neverallow were being expanded during CIL
> > neverallow checking, an empty classmapping in the list of
> > classmappings for a classmap would cause the classmap expansion to
> > stop and the rest of the classmapping of the classmap to be ignored.
> > This would mean that not all of the classes and permissions associated
> > with the classmap would be used to check for a neverallow violation.
> >
> > Do not end the expansion of a classmap when one classmapping is empty.
> >
> > Reported-by: Jonathan Hettwer <j2468h@gmail.com>
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Applied.
