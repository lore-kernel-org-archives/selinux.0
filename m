Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3E5C4332F
	for <selinux@archiver.kernel.org>; Wed,  5 Oct 2022 14:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiJEOkY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Oct 2022 10:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiJEOkX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Oct 2022 10:40:23 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1989025E91
        for <selinux@vger.kernel.org>; Wed,  5 Oct 2022 07:40:23 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id fw14so8679219pjb.3
        for <selinux@vger.kernel.org>; Wed, 05 Oct 2022 07:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=3WXhaM8LObiEPo2iRJYvCnQJzX7KFqlG4m2H9GPBkHo=;
        b=l0qzAbxioleAb50rMnDUWnnL5l9eNMu50ywi1UXdYEpZnU0lLNOCl5XN9YLvXDgrG3
         J4GYf5eFVhQhorkm1p0kMMe8LuF+vOr15/BmbUv4dlVvL/ln2MUIp21v0Fdw07Y0nntU
         xPw1brKqiS7rT/kcEwL6hIHSwsUq7fWXGWdwXGYxMI94OwtkfUI8Jwe9P7p91njYtDxc
         ZGBFjBEGGz925alpdwISdCThCRnzLhFuMMruaueVNFVnKNyLYR11ci6VehVVDygpLhH5
         d4KXpKd1RtZY7vFhsZR+eihTrpX8R4pWFr+ifnUyJaNK75MAITRlF4lqA99S2DCYEiZ4
         6pIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3WXhaM8LObiEPo2iRJYvCnQJzX7KFqlG4m2H9GPBkHo=;
        b=Y26QaXNcdZ+i3b9xPE+PjacSilV7obLZjkqZwOBWFx2CiYXkt27iT3sFs1LfSi9yHp
         Q9SEPxc5Uju2vNBuQQiBzl2GQh61/ZeB6mG4Z/YzaqAo89aUBX2X7/QoC19MU2eZYgox
         DZ6O2X/e9xPofn8U5RX/QYeJPXmQQkS5HDLGaL3OhqJiIVuG/lZ+SH0zf1RTrxJuqdNk
         f8lVTjUHJr/v4mWAaC665+T4skX9XlpOvFq+AqmDjDI35kgwaU3vJ+yWABNLhh8RxF+G
         am4Nkr7DwaFCCxPq467Gge/h9lRptraWKMiJf7BdJy4T7Vq7GfYpbEU8vgfUeDOnfuOr
         0gIw==
X-Gm-Message-State: ACrzQf0fQMaxNKVAixSePdbPM9ObpxZpjKzNkgr19yeKmgEkMlWgfWV4
        8u1Vy/emX6L3Z0DRwCJqjpZkciN41lNRyvU5KiORTolO
X-Google-Smtp-Source: AMsMyM4ocWJbmyi8hWT6JrMVwkmR9dk+WxlMwOoBxyfZLloGfRZlfXlCu0wx64QZv47xy4BUCzjmOnsQBVPQoT802mg=
X-Received: by 2002:a17:90b:1e07:b0:202:bb50:1963 with SMTP id
 pg7-20020a17090b1e0700b00202bb501963mr5471204pjb.82.1664980822629; Wed, 05
 Oct 2022 07:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220919134914.145651-1-dominick.grift@defensec.nl> <CAP+JOzSGRSA1k8x_0jHtrq9O2wKFPF2vYXtxfXBwj6jZCO0Q5w@mail.gmail.com>
In-Reply-To: <CAP+JOzSGRSA1k8x_0jHtrq9O2wKFPF2vYXtxfXBwj6jZCO0Q5w@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 5 Oct 2022 10:40:11 -0400
Message-ID: <CAP+JOzS5DBPcb4Xnom5vvjNXd_0+vmN_DW8jTa7FGUaPf9AWfg@mail.gmail.com>
Subject: Re: [PATCH] secilc/doc: classmap is also allowed in permissionx
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 29, 2022 at 3:29 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Mon, Sep 19, 2022 at 9:56 AM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
> >
> > Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  secilc/docs/cil_class_and_permission_statements.md | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/secilc/docs/cil_class_and_permission_statements.md b/secilc/docs/cil_class_and_permission_statements.md
> > index 368e3a4d..c494f144 100644
> > --- a/secilc/docs/cil_class_and_permission_statements.md
> > +++ b/secilc/docs/cil_class_and_permission_statements.md
> > @@ -536,7 +536,7 @@ Defines a named extended permission, which can be used in the [`allowx`](cil_acc
> >  </tr>
> >  <tr class="odd">
> >  <td align="left"><p><code>class_id</code></p></td>
> > -<td align="left"><p>A single previously declared <code>class</code> identifier.</p></td>
> > +<td align="left"><p>A single previously declared <code>class</code> or <code>classmap</code> identifier.</p></td>
> >  </tr>
> >  <tr class="even">
> >  <td align="left"><p><code>permission</code></p></td>
> > --
> > 2.37.2
> >
