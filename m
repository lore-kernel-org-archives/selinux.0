Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CE8C19F2C
	for <selinux@archiver.kernel.org>; Wed,  3 Aug 2022 00:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiHCA4f (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Aug 2022 20:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiHCA4e (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Aug 2022 20:56:34 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3ADB4D4CC
        for <selinux@vger.kernel.org>; Tue,  2 Aug 2022 17:56:33 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id n133so18479350oib.0
        for <selinux@vger.kernel.org>; Tue, 02 Aug 2022 17:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1NevGAba0ONkU3FJWsW2wJAuMqxMRJskiwRYhc9paek=;
        b=AQkJLYNkY2w2xYdh+7TGvKP+aeiPMEvlvPnVww1xhFZPQxWpli9efvSPRTlyxPKfDM
         f6YM/7Ed5ki6BSv5/P9wa7cXKpol5HGm+oF+/fnhIzawJFa1ZSqFkkm3wWkruowT4Fxc
         KKsr4u9r6Nq25pGeQIua1Y6MuuI4OYM/JDWH+ZhSSlB7dH4hB5Z5M3qjrIJejX6aR1l0
         v6NUMvb1Evz5syYG79yFqjSHCctVEut9tgi2ysilsiBPaYqKHhr5uUCa3Qn50eB2ja8l
         IyOujfoJpRm53T2Nla8isP5TJq3rq9S6cMhooLru/dq9TCuR/8w+3JXZLJocAHGSqaDP
         CXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1NevGAba0ONkU3FJWsW2wJAuMqxMRJskiwRYhc9paek=;
        b=Rdd9Xg6Qlagtq3+MXNON+E2Uxm1wMm5GyqvW50qXDD4UHis+73lTScX0nxaj3vzO8Q
         i4kzNsO9LCTioOlp1SNOMuQ5G03/+D6M91d2k9xGPaOUhJS3iTPytBSlmUj2Kn6J/3JH
         tboVs/Y8wIqwCNwEAgMHDrIWSRw3X/HlJyNjKBNnmJ6HGu3qE7x/D0iNam9AB4G0P5OT
         AtVEuH4EEnwqdP4PX14upqIQYoyQP9JZahdqWt1JsNQj78WX8RcCQenxHANB9Wtf9ie2
         PpNFTVxwRJkZqP2e7y2n8H40NIStCusE8kjVi8hfFjaUk4rYsogj9l/ygUshJgps3+28
         +CQw==
X-Gm-Message-State: ACgBeo2IaTIUed+5plTOL4rrJ9WUVjnegp2usR1GREq8ZofEW2KbXJbh
        IeuTEWkHGfBAymeB3oP9j0PJcj/IQu8BTsbl4+bWn4QBdQ==
X-Google-Smtp-Source: AA6agR5jchQtFTVH4GKZpIJqVGg880F+ZJjoPfA/kz+qZ9whwyo0MPii0q6K1Q+KSmaaibqy1qpe3WOt7NgyiBuNRWs=
X-Received: by 2002:a05:6808:3087:b0:33a:a6ae:7bf7 with SMTP id
 bl7-20020a056808308700b0033aa6ae7bf7mr831237oib.41.1659488192433; Tue, 02 Aug
 2022 17:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com> <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com>
In-Reply-To: <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 2 Aug 2022 20:56:21 -0400
Message-ID: <CAHC9VhSF8hWg=7tbFiCrizNF61vpwJcU3793LcStiu-anW4i1g@mail.gmail.com>
Subject: Re: LSM stacking in next for 6.1?
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        John Johansen <john.johansen@canonical.com>,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 2, 2022 at 8:01 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> I would like very much to get v38 or v39 of the LSM stacking for Apparmor
> patch set in the LSM next branch for 6.1. The audit changes have polished
> up nicely and I believe that all comments on the integrity code have been
> addressed. The interface_lsm mechanism has been beaten to a frothy peak.
> There are serious binder changes, but I think they address issues beyond
> the needs of stacking. Changes outside these areas are pretty well limited
> to LSM interface improvements.

The LSM stacking patches are near the very top of my list to review
once the merge window clears, the io_uring fixes are in (bug fix), and
SCTP is somewhat sane again (bug fix).  I'm hopeful that the io_uring
and SCTP stuff can be finished up in the next week or two.

Since I'm the designated first stuckee now for the stacking stuff I
want to go back through everything with fresh eyes, which probably
isn't a bad idea since it has been a while since I looked at the full
patchset from bottom to top.  I can tell you that I've never been
really excited about the /proc changes, and believe it or not I've
been thinking about those a fair amount since James asked me to start
maintaining the LSM.  I don't want to get into any detail until I've
had a chance to look over everything again, but just a heads-up that
I'm not too excited about those bits.

-- 
paul-moore.com
