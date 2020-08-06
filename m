Return-Path: <SRS0=AdpT=BQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664F6C433E0
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 22:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43225221E3
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 22:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="GLXZ4/lY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgHFWHI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Aug 2020 18:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728606AbgHFWHH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Aug 2020 18:07:07 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85186C061574
        for <selinux@vger.kernel.org>; Thu,  6 Aug 2020 15:07:07 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l23so22541832edv.11
        for <selinux@vger.kernel.org>; Thu, 06 Aug 2020 15:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ZSOmudXEzGccoCRo+wgdsxhT1wBTYpEa/yS42mJcVA=;
        b=GLXZ4/lYCwoaAgl3GymM4eskAyJ53x6Xp/NluJyTJ9LC4ggrZj8jhO8uMpDcozy059
         6zKPpbL/B46GbIFhkWgHo57U6LIrS9PZ1HZzFIisRHemHMXqQllZ+x9mSj+FG/ojU6Jv
         18DvwmYhg9kb5lbTRt5cizIj4RbAwi3/9S9Re210Xu6dBTLuc/HJ1ZdKoDseioJzeRRz
         XggQ5kN6bBkNK0wJhI0WaEypReZX7rxhR4dkN/WoHMbsxsUfUpUESqQmRAgJyFltrPs/
         h17zhdTB/DIgi/ysMsTx/xUSjsg6X6HNO2y6AMGrAfbSknMU/50c9Ujrwpvkpij4VCTo
         2h+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ZSOmudXEzGccoCRo+wgdsxhT1wBTYpEa/yS42mJcVA=;
        b=owJZnpgLhtZMzvlGh480Cg1H2b2J0w9uHx1ocW5JUBrZ8ENEi6gUEJ/Vvw9uxn3yHd
         UuRoTZClUJsAWAJqGpxTs19+93knmO7HEPxCShOEhk4hTDGFjpV323k/sUEvLo4DtQ5V
         qBoF2CmMTbud03/HArHZNnJ3oJv2+/lcnPxNzJXOctZ/ppOOrtscTMhcxf4/xRmNbwjU
         bRMbSb7WwuWVJ28o6bUf7Oz2XvCP3Y173UGS52oWiyBcaa8zIJRsdzCQDuZmomiw1Ng3
         rUdUzWyt0RvoDIAx2GIg+h4EnBZc21iDnXGGL115yVkx88/EVGQiQ6DYj08MNZ8WF9KM
         I95Q==
X-Gm-Message-State: AOAM533QKKXDEl1on7qyOh7c2DbsBL5mbsk/Q7GRXN3WN4Xoh+cnLw6c
        RgmemTWjBrRt2vX7IouPxVAzpktzabu8RkCLSEwfvhWN8Q==
X-Google-Smtp-Source: ABdhPJyuxOKdFmqtQqg7nVEnpHCpbdnh5yhJCqa1RN/vmpS/S/4Z0UCdIYxZWSGStjk3TmYEgYdyXs75Nq8KFvP6wRM=
X-Received: by 2002:a50:93c5:: with SMTP id o63mr5957489eda.31.1596751626216;
 Thu, 06 Aug 2020 15:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200806095055.7055-1-richard_c_haines@btinternet.com>
In-Reply-To: <20200806095055.7055-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 6 Aug 2020 18:06:55 -0400
Message-ID: <CAHC9VhQjVXMjy8muogpR7CWXb58Cyks0916R0GmXA1kQOAG=_w@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux_notebook: seandroid.md convert to markdown
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 6, 2020 at 5:51 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> This update adds a TOC to aid navigation, also converts all HTML tables
> to markdown unordered lists.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  src/seandroid.md | 1137 +++++++++++++++++++++++-----------------------
>  1 file changed, 577 insertions(+), 560 deletions(-)

This looks good to me, merged.  Thanks Richard!

Note to others, take a look at the style choices and let us know what you think.

-- 
paul moore
www.paul-moore.com
