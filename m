Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6207C4361B
	for <selinux@archiver.kernel.org>; Thu, 10 Dec 2020 01:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64D69207D0
	for <selinux@archiver.kernel.org>; Thu, 10 Dec 2020 01:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgLJBpQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Dec 2020 20:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgLJBpQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Dec 2020 20:45:16 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E732AC0613CF
        for <selinux@vger.kernel.org>; Wed,  9 Dec 2020 17:44:35 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id lt17so5059819ejb.3
        for <selinux@vger.kernel.org>; Wed, 09 Dec 2020 17:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yK1Gn4PW8lfNjr9C/gn+k/NySLnvUQARH45j/NyJlw8=;
        b=a3MFnbMgPuUZ/qmg7zwXDMy1cVKFx9PalSqwTwYymiqYjsUvPn6KBfBaHAzoeZBpdY
         /4j9jJO/m8Nf4UA3GtvhXd8v08JSaHqVrexbYFtlat19J8c83zm8iNWPaHya5Lqz91Mn
         gqtG+HNH6AxmcgMRqEbPbaEBTtwSGqFBlQjGRW2sV3QYqyfD0P/7HFVN/I+rvQCub4+S
         vO6uoXYfZnHaqt5+i4r9tnj8qoejDByLpxZ/9LXIhe/IO0xIBMbL/RtkcCEAkSsL++Dc
         3BFb7ofFcgF68s+NWOUKg9QY/Og2HZpF4pGqKcguA1CgT4ZmDzQ2GH+7WFdupUOf/pd8
         9PVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yK1Gn4PW8lfNjr9C/gn+k/NySLnvUQARH45j/NyJlw8=;
        b=CJ4mCpfi1x85KGd7PxrbqEwHlUESxpHpbz6c0piqpiABQ/W3WQXFBx2yhOBzI90a/Q
         Y7v4G6KThrHVbF7/j4gExpw09WpP4EG2Nfqb9tPQOr7eeoR/wOQH07pBPQ09kD0qJs7E
         xdlsfWrL7Y2zy95AQDpBssZoD6xmBJ9IoV4MtHL67HM1HBIzWV4YsksBipbmpedic/NC
         xT82CI022WV7O6pHuffsbD8EasCYi/5iTiuRKns69cQOZaUGwYQfMHuRqZEEAdzKYLxu
         gjdQ59kuqaOijaTyA5ZhvyagP0Nf08vG87GcCEWSna/dsUD2eh3vPL7vPd2lGQqsfIKo
         WLcQ==
X-Gm-Message-State: AOAM530RCVyPKvEpRzkE2OLWuB9D6oekeTk946rv9OuuHFHtpqYs+cf0
        Xs5ZP3bTwrlPCAD3+3Rw7DOE4DKajLo+5J0k4CcSMtS1hA==
X-Google-Smtp-Source: ABdhPJwjxk8DfNsdECYTzMPV0MW8JUMo7QvMYmw6MhGV6jrzZCa/pdzRllOOzC0oVZK5VJ9DJGc1JAWppRZKOt3OVdE=
X-Received: by 2002:a17:906:3712:: with SMTP id d18mr4551228ejc.178.1607564674464;
 Wed, 09 Dec 2020 17:44:34 -0800 (PST)
MIME-Version: 1.0
References: <160697083070.45245.11138404605529742839.stgit@sifl> <7957d9afeed6e17ffe7eeb117bf4db6919d76448.camel@btinternet.com>
In-Reply-To: <7957d9afeed6e17ffe7eeb117bf4db6919d76448.camel@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Dec 2020 20:44:23 -0500
Message-ID: <CAHC9VhT4NCst5ZA_H_3yuXcVUZfGCxyh+qpBXT_uL=qgstpv4w@mail.gmail.com>
Subject: Re: [PATCH] all: various small html to markdown conversions
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 3, 2020 at 10:52 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Wed, 2020-12-02 at 23:47 -0500, Paul Moore wrote:
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
>
> I've not found any more html so:
>
> Acked-by: Richard Haines <richard_c_haines@btinternet.com>

Thanks for the review.  Merged into main.

> >  src/notebook-examples/selinux-policy/README.md |    2 --
> >  src/notebook-examples/sepgsql/README.md        |    2 --
> >  src/title.md                                   |    5 +----
> >  3 files changed, 1 insertion(+), 8 deletions(-)

-- 
paul moore
www.paul-moore.com
