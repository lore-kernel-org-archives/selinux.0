Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147D5C433ED
	for <selinux@archiver.kernel.org>; Tue, 11 May 2021 01:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C938F61623
	for <selinux@archiver.kernel.org>; Tue, 11 May 2021 01:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhEKBfm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 May 2021 21:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhEKBfm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 May 2021 21:35:42 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B75DC061574
        for <selinux@vger.kernel.org>; Mon, 10 May 2021 18:34:36 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id b25so27267396eju.5
        for <selinux@vger.kernel.org>; Mon, 10 May 2021 18:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y6ufyLjYEex5aN+DFjzjDFHTD06N7OWtffrZX+Hg2+M=;
        b=HhDyopFWLxwJ666wRKPYXT+Hq5GBeKh/IQtz1CV/50gEtd3GOnXCamBvP806hLePtS
         MsgsLigqkzjLworUCcgO2fIwI/mIv6WEewB4Zavl+eATfeJTHBaz3zhUZXQJkGp+4zCq
         KdNhu0YmPvGdb43bnyOXNe44EhjxAk14/vkoPyl0WBUtnrrWlleQkqydMW84nqR2HfST
         ONvDTadk+xxslBpAUjYvzqku2pjXbwYDX2c6QXPYkxw7fpr4wZgjrGRjCJz2l7/Zc52I
         Qrt8gFJbTqNOcMp+axx/j8gMUIM+YCbhI4Vy8HKIsWtoRxUX9fSk04IHRvcM4tWoaTi4
         RXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y6ufyLjYEex5aN+DFjzjDFHTD06N7OWtffrZX+Hg2+M=;
        b=djMTC96Im6iA6B66lKF0Eu5Yn/y7rd34Zn0jSuZRzGPWgDNbkskkTnA7llwL815Gco
         h15ZeaHe030O4kNYIrxCgiBIoiD4naacPn2CDl2VlIZNJXL2c65Un+w975K6y2N5BsVo
         ++Ec2VktD2ifw1eRSbHyKixkdNOb+/JwrUab4V6V/lJG/V0APVTYUAI82Ee5EQafcQsp
         JQ4zwAkm0qJrzo/Chtr0e+7Qhqv3MnwXZC+iUPgb6cksIGq4cOSuw9TNoy5gvpV/pMM/
         SMbozBp6eiAfjw0+mruJlqZPmKJcyqs1mA+FxS6j7MoA6wqZ+JBwp2aR0yI7/5gtFKs4
         hXyw==
X-Gm-Message-State: AOAM531i03oo5LwBBOUMMJAwDF70byTRgqZvkcIPFNWnPx/baXr9pbUx
        RKnZuPXRy0yZePho9e9LX6/MuFDhd3Rkq44A9TNG
X-Google-Smtp-Source: ABdhPJyOqhx/ssF/I+/EChp5VN8xClVMM6LsqNtALrsGAYuchLNsDrLnaPcs8be9tcag0abWhlqrWWkZ/5vuXTZUkjo=
X-Received: by 2002:a17:906:2510:: with SMTP id i16mr28702968ejb.488.1620696875283;
 Mon, 10 May 2021 18:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210330131646.1401838-1-omosnace@redhat.com> <20210330131646.1401838-3-omosnace@redhat.com>
In-Reply-To: <20210330131646.1401838-3-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 May 2021 21:34:24 -0400
Message-ID: <CAHC9VhTs29CWGOxvi38hwkRB6WocESOz48JmyS9QPeyoMMJ4Ew@mail.gmail.com>
Subject: Re: [PATCH 2/3] selinux: simplify duplicate_policydb_cond_list() by
 using kmemdup()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 30, 2021 at 9:16 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> We can do the allocation + copying of expr.nodes in one go using
> kmemdup().
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/conditional.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
