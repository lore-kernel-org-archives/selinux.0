Return-Path: <SRS0=EYrt=7J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918B7C433E0
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 12:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E6E920657
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 12:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jn2oknz3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgE0MGn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 May 2020 08:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgE0MGm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 May 2020 08:06:42 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D6EC08C5C1
        for <selinux@vger.kernel.org>; Wed, 27 May 2020 05:06:41 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id b3so21446190oib.13
        for <selinux@vger.kernel.org>; Wed, 27 May 2020 05:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/e386M61i41DUzOhY2Ie5xhC4j3u98C1N0WuuqMm85Q=;
        b=Jn2oknz3ieLcG6eQlOt6g5Cz6ZPNoSNzdeSuCoFeWgwLl0oddI70sPByDW2/Oa8v8P
         4w69nw0JOW9VndB5HalDRJrsXZd9ScTILXZYSnrooz0Tx3VgZpg2Evfm0vz0pQPD2ZVG
         jvl0BRd7zcKytPZ1lci6B6JipQZ1RnExfkmX0FZ7+05uwzfsfRnv7mDmcG0B8QUr1h6k
         DqCWJzMl8fbpWOlgfeVr2Xm3G/Js9Ah67KIRIHfkZpKi+JrMwRCwTjLRGBdxgJPhp44/
         YzyoWwc4RZ4NFu1+eY0Dlqul391I+Js6xTI6qZS+WKqMTUZyH3dTKklRC7ln3YruKuq6
         Rzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/e386M61i41DUzOhY2Ie5xhC4j3u98C1N0WuuqMm85Q=;
        b=hoUXMVjdsZopIL9oUus+V52+qhnsFPubpKhnAkQm/35ZolUNcyBFHIi32BxN6QFBTV
         oREbNWmTz8eixX5k9Vfr3kycJdKf5yjwB00D0p83dyR87UD11L/Q5iCsDe3Y7RN2bJxX
         QZgEbfufMKV/HzwWPbDJqw3D6bhY+iBwMzK4Y5vmKinWB+chxCsAJ53HG4+MMydQQQoS
         g/3we+sj+gm/7m28hrJfCZRHNY6CAYAZwcbn+4f7WoN9XMD2YZL6WO1n8GtD6+j2plFg
         PdYg81AWG1AwxoXeSopTRNRMUn8a9eRiLWElFL3KvurGBsvhI1gxFt9EC5iBwXGaA/dR
         NV1g==
X-Gm-Message-State: AOAM532fiOPWwrRTe2XCs08QEEY/BlUx2l18ri0AhKDeLcNLJFNdRxZ4
        OFRI27GLjjYkpyHI5erK4g8c6nA0uvNnsxoTbys=
X-Google-Smtp-Source: ABdhPJz/95YQ0+1HLZqt6W8iQJLv0ak+6sICvA1g42OLEbHrAQBZyzFCH+RnmUqIxGIqBZW7EhXuyhQH5YG92syDnxs=
X-Received: by 2002:aca:fd0a:: with SMTP id b10mr1657327oii.16.1590581200974;
 Wed, 27 May 2020 05:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200526185058.42827-1-jwcart2@gmail.com> <20200526185058.42827-2-jwcart2@gmail.com>
 <0cd7a2db-3b3f-fb03-19f9-f8984a913833@gmail.com>
In-Reply-To: <0cd7a2db-3b3f-fb03-19f9-f8984a913833@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 27 May 2020 08:06:30 -0400
Message-ID: <CAP+JOzQBBhS7nsec1mdo+pw8Wp5Dcaah0iF-qPzw5-DwqeFrug@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] libsepol/cil: Return error when identifier
 declared as both type and attribute
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 27, 2020 at 3:02 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>
> On 26.5.2020 21.50, James Carter wrote:
> > CIL allows a type to be redeclared when using the multiple declarations
> > option ("-m" or "--muliple-decls"), but make it an error for an identifier
> > to be declared as both a type and an attribute.
> >
> > Change the error message so that it always gives the location and flavor
> > of both declarations. The flavors will be the same in all other cases,
> > but in this case they explain why there is an error even if multiple
> > declartions are allowed.
> >
> > Fixes: Commit fafe4c212bf6c32c ("libsepol: cil: Add ability to redeclare types[attributes]")
> > Reported-by: Topi Miettinen <toiwoton@gmail.com>
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Thanks, this prevents mismatching declarations. Does this also fix the
> memory issue and prevent that buggy policy could get loaded sometimes?
>

Yes, the two patches together will prevent the buggy policy from being
loaded. It will always give an error now.

Jim

> -Topi
