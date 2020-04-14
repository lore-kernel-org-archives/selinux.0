Return-Path: <SRS0=NJTS=56=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEA1C2BB1D
	for <selinux@archiver.kernel.org>; Tue, 14 Apr 2020 22:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94D472076A
	for <selinux@archiver.kernel.org>; Tue, 14 Apr 2020 22:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="1hFd2wnB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407796AbgDNWFc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Apr 2020 18:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730942AbgDNWFb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Apr 2020 18:05:31 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133D4C061A0C
        for <selinux@vger.kernel.org>; Tue, 14 Apr 2020 15:05:31 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id j20so1817260edj.0
        for <selinux@vger.kernel.org>; Tue, 14 Apr 2020 15:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2B6KSb9ULHZwvw0POXN8kn/+hN+oqa+Ekk3IkISWyS0=;
        b=1hFd2wnBwOrjzXMUj3Rksg6DM69zi2fiU1AERhoYGg01pDzQXamgVmvH1bL8qGlXWc
         uugggFPpVGiQuTgy3rkRpiO6GR7g22s51OY4fhkTXd/ote2eovm7pxmYrgroyXJIcVx0
         oSn5N5oKKcjbPYpwPPugf7hIv2QRuA0BKu9k2CTedMdh0tW3kgx8Ko+yyV8iW/VgexLu
         sflZns3Xp0yZGXxbmy7CUZRNdyn1rJSfDQgH8RbH8QqGdHKQdGblA/vq/iqFxydGaZBx
         GQ60zpSyCeCIeSW1DTSh8Sk+UhCU4c3kByJ9YBFy30TfHDnTiZx0/9Mk3WLLuA00Ul4u
         7MTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2B6KSb9ULHZwvw0POXN8kn/+hN+oqa+Ekk3IkISWyS0=;
        b=bWe3C1/1VI88n/wSYYiyEJajgYFpfpLOcW9jQTxsFwX+OiwoBLP01kjgaoZWxW0lnQ
         FK8TYbv+oza+PxWaocEGB4EV2e2AVqbOMUe9JWsHClI14eWhjTuqXaUSqivBD6b6EGpR
         eI35uxRIsXwLKonA2Tpbhaw/x4eXsu0ommsl6sQ5JnuQoxdo6MPNt3a2sXtlY4cHtc7J
         7MRaBt0PPUh+efHevEfvel5zYGYDkFlrPce867WP3LmoWoqWHzU4PrdECpw83RqmCv5e
         j2WHKQuAZuh9JJv01/sP4KFehDHpDCJqXy81ma82gjNj1EBpArKZrr8EnTDvJgLIzftN
         e6jw==
X-Gm-Message-State: AGi0PuYKEv9fbv53zvMFWqTeQThy8IUgnk0sqqb5fX29oyiWU4h1QZXw
        EwnSv/xklaKeB7mhm/CzKwbaRU2Abl3WlQBalhC3
X-Google-Smtp-Source: APiQypKLPdYWr30yfCiz990g2qhlCMkQB6hqTbWzjWYagCL5E7mjFGXo+kO5LVY8KajgI1UXBpILPIXNSdQnDReWM5g=
X-Received: by 2002:a17:906:f106:: with SMTP id gv6mr2254080ejb.271.1586901929541;
 Tue, 14 Apr 2020 15:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <1586852287-67588-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1586852287-67588-1-git-send-email-zou_wei@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 14 Apr 2020 18:05:18 -0400
Message-ID: <CAHC9VhS2Nk+XLd9RnWxCkB0-81VF-fWyRYVET0VU3pcrhnxwCg@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: fix warning Comparison to bool
To:     Zou Wei <zou_wei@huawei.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 14, 2020 at 4:12 AM Zou Wei <zou_wei@huawei.com> wrote:
>
> fix below warnings reported by coccicheck
>
> security/selinux/ss/mls.c:539:39-43: WARNING: Comparison to bool
> security/selinux/ss/services.c:1815:46-50: WARNING: Comparison to bool
> security/selinux/ss/services.c:1827:46-50: WARNING: Comparison to bool
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  security/selinux/ss/mls.c      | 2 +-
>  security/selinux/ss/services.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
