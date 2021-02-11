Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17137C433E6
	for <selinux@archiver.kernel.org>; Thu, 11 Feb 2021 00:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1D1364E57
	for <selinux@archiver.kernel.org>; Thu, 11 Feb 2021 00:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhBKAbq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Feb 2021 19:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbhBKAbn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Feb 2021 19:31:43 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E7EC061756
        for <selinux@vger.kernel.org>; Wed, 10 Feb 2021 16:31:03 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id bl23so7355658ejb.5
        for <selinux@vger.kernel.org>; Wed, 10 Feb 2021 16:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c5rU9dL4ccxDJCC2GsRZydqYKmxsl5IxnGPynZh3RSA=;
        b=aGWjnGZewSrWZ3K3/d7u11yFVdMJwbFUb72QIMzF7uazTTjmmJjdCZ9ONCwpVum/Xj
         rUnyJFIjrV2/sv/sMWips1S1T8uW7fEcxow+yJ8Fi8S1tuU7N0iHvY8bdarOnjhkpTg7
         NM2vO1cUlF1AG733ehWn+NqRuX8HUe5HiNMTwryDfBY2OLSISJazAUg7JTyxK46DjIGO
         j3dJkqmDp3qhw9b3nqZP8SSM2YxsFsMYxW37vaCItkwoqLwFtWXhrzBCXq/hSbQQvnLR
         9eUD4kLnW+lu3CIWSQIsbWuWbKgCTCExt3oTUMc6WvURIBjupGTZOMfyJeRKLm10oON0
         QdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c5rU9dL4ccxDJCC2GsRZydqYKmxsl5IxnGPynZh3RSA=;
        b=GDRRWtal/9x5wttX+x5J8NLkp+ISB2E0kC6ixJkUxmyI6JJn07jYL87zxEdgnPrb/X
         nVxVP35VMVbPECylGSxT486Ycd5OfIMnttiLZDqfaeEDLXu1T5ACqv0ncQjqvh8+Q641
         MQNL390wACVAP6tDoCRfoN6z/61zGwNjV6h975eMZgwpFuJyB926SXcLxXS+hRL9+64w
         kRHFhdY///J4e/TaNegwdFS4o881aVG1mh89HAPGfrhBIJd/FH7PYnS9glQlxAxP5/+V
         GVH8aEX0BCeEN4iyKgmy1nix6SOyVP/1PiI+n+AzVVwxOqyynrMtja1y1GjxCz+0wVf5
         V5xg==
X-Gm-Message-State: AOAM532cQyK630Y0yfx29zjH3FpHWTAjYioNfLiBTJN6erhwb4k+xP0D
        a7c33UZDpvcZceGUyBXQUWd4SJrajRSXaDR1COGe
X-Google-Smtp-Source: ABdhPJz8ksZuRHwxCcIXKHby0HjyUeHx/rZiAg6W3mF2umhO4bo3vR/iBs2/wfczZHq1IVEr1mpTRvi5aNrcXT1rokM=
X-Received: by 2002:a17:906:37c1:: with SMTP id o1mr5437412ejc.488.1613003462376;
 Wed, 10 Feb 2021 16:31:02 -0800 (PST)
MIME-Version: 1.0
References: <20210125112409.6956-1-richard_c_haines@btinternet.com>
 <ypjl1rdpqgy8.fsf@defensec.nl> <960f300d47abf038355dfb48fb5f56fbaa4b62f0.camel@btinternet.com>
In-Reply-To: <960f300d47abf038355dfb48fb5f56fbaa4b62f0.camel@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 10 Feb 2021 19:30:51 -0500
Message-ID: <CAHC9VhTw7ihm=Kw5cHHyRTbPcDJ4UH-xDKegJUU0iwnrpwYXJQ@mail.gmail.com>
Subject: Re: [PATCH] selinux-notebook: Add new section for Embedded Systems
To:     Richard Haines <richard_c_haines@btinternet.com>,
        Dominick Grift <dominick.grift@defensec.nl>
Cc:     selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 10, 2021 at 10:01 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Tue, 2021-02-09 at 18:38 +0100, Dominick Grift wrote:
> > Richard Haines <richard_c_haines@btinternet.com> writes:
> >
> > > Add a new section and supporting examples for embedded systems.
> >
> > Looks good. Thanks
> >
> > I will probably submit a patch once this one is committed that
> > expands a
> > little on the OpenWrt scenario.
>
> This patch has already been commited by Paul on 27th Jan.

I just got done double checking to make sure this patch was merged; I
saw Dominick's reply and worried that I forgot to do the 'git push'
after merging :)

> This
> particular email was sent on the 25th Jan but got lost so I resent.
> Looks like this one only took 14 days to finally get delivered.

E-mail, it's just like real mail!

-- 
paul moore
www.paul-moore.com
