Return-Path: <SRS0=GKMn=7Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBEFC433DF
	for <selinux@archiver.kernel.org>; Fri, 12 Jun 2020 18:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 503A2206D7
	for <selinux@archiver.kernel.org>; Fri, 12 Jun 2020 18:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="LX+fhIdg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgFLS5B (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Jun 2020 14:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgFLS5B (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Jun 2020 14:57:01 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76520C03E96F
        for <selinux@vger.kernel.org>; Fri, 12 Jun 2020 11:57:01 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id p18so7148034eds.7
        for <selinux@vger.kernel.org>; Fri, 12 Jun 2020 11:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eHxv7YnrTnFal4bAAg0KfXvwzuyBoM8n9kAFerahLHk=;
        b=LX+fhIdgX4kIyMvgWNAma3AL6ebGz+lMmOCcmECmcj4+kyVdItZY119md/zIsFPZKt
         boQovkdD1fdzJllmQcJs536S61U8BW96ISlVWVdQm1vMM09a0RUd0FyFh50sR49tNEyS
         bAvlscpf9tfXBqpv/a/Un044l1bhyIyoew5Vojmx7aW4ftLuTmAK1yaJ1s3ohoVx/ofW
         FFGoD8yWXJmqp2Wo+guPCV0XUkA6W0UP74sPPUZeLWxCNDjLTgKfouzpT5Fz7ovU8nNf
         0hIRTwK6ScnNhhYgcQuJe6rfcVUn2hsjwGuMj3ciH2Uhb+gEJzEDZT8w0v3rI4jFMqDY
         g01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eHxv7YnrTnFal4bAAg0KfXvwzuyBoM8n9kAFerahLHk=;
        b=p8JW05+uLLTEz68dDlhibpyfOTEEzN8kJaqdaNUlM0IY1lq3iCjugL2BzATeRi8ebl
         ZCyD8hUTF6MvXCtc+cVbaVS4qHAZGEmw4I87kTBbo9+eomFskOYINJPKAb+e9vmHgHy1
         sU3XEK9v5qDx9nWY/6EzoPWJwRX4wEfE1Nhq4RX/r74gqOm+3FNGbbjcLvmdPtE7Ipps
         faQUQ+RJRAJHLHsIiqOIGdV1/L73fe+Ci6orPHkTZJMBCoHpSPjJuHgWKW8BY2BEV/Yo
         tpGDm5LLPW8lYcu7HBux3k9pvExQhLQ9OmJ9GsYAHzD+5TrBJY9LIDJaI2gAX/QoA900
         3I/A==
X-Gm-Message-State: AOAM5333rimtVjFiYG/JNj5k5+vpo7iNkb0JwTF1pTcYw+qX0HVD2Oi9
        uYno0AkZO5rV864Qi6QAss8PW36OaXEVm+eL0ScYKBI=
X-Google-Smtp-Source: ABdhPJx6VBBxxgqpihqFhRxPedVDbNCRpOIQMDSpTey0IYkFLqqbPjBiA4cDJiKjlYVRwylnfAzhk2M0buI0IHc6mCU=
X-Received: by 2002:aa7:de08:: with SMTP id h8mr12665796edv.164.1591988219793;
 Fri, 12 Jun 2020 11:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <159110207843.57260.5661475689740939480.stgit@chester>
 <CAHC9VhQacYKE4sJRbqmpudXfMyzCT8VM0SFUCi=o-MNsn4c_MA@mail.gmail.com>
 <CAEjxPJ5oGWygz87dQw1HbP2wZovc+Q7ESKSF0zBMF_cSwxRdww@mail.gmail.com>
 <CAHC9VhSsY+MtSrj17g+p3FMeaKQ-Mjjy=iXS+1TbhCKGAn_yxA@mail.gmail.com> <CAEjxPJ6nLAOjLvhswyLNCUO8bUuwm_h7emFp7dZXDzRjMuG2HA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6nLAOjLvhswyLNCUO8bUuwm_h7emFp7dZXDzRjMuG2HA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 12 Jun 2020 14:56:48 -0400
Message-ID: <CAHC9VhSAh=bs4M11iMuVCAMyYz0ReKNgm5Y9MaQ5oO+tMy9PrQ@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: runtime disable is deprecated, add some
 ssleep() discomfort
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 8, 2020 at 6:13 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Jun 8, 2020 at 5:35 PM Paul Moore <paul@paul-moore.com> wrote:
> > What were you envisioning when we marked this as deprecated Stephen?
> > If not this, what were you thinking we would do?
>
> I feel like we've already communicated the fact that it is being
> deprecated to those who need to know (Fedora maintainers), and we
> already have it displaying an error message for those who look at
> kernel logs.  So I was fine with just waiting some number of kernel
> release cycles (not sure what is typical for these kinds of things)
> and then just changing selinux_write_disable() to just return 0
> without doing anything and dropping the selinux_disable() code and the
> config option.

Regardless of what we do with this, I thought the deprecation commit
was pretty clear about adding a delay as part of the deprecation
process.  The most appropriate time to raise objections like this
would have been when the original patch was posted.

In other words, I expect people to review the commit descriptions
along with the patches.  When anyone adds an "Acked-by" or a
"Reviewed-by" tag, I take that to mean they have read not just the
patch, but the commit description as well and the person approves of
both.

-- 
paul moore
www.paul-moore.com
