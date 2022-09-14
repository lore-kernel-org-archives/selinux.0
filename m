Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186E1ECAAD3
	for <selinux@archiver.kernel.org>; Wed, 14 Sep 2022 13:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiINN44 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Sep 2022 09:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiINN4z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Sep 2022 09:56:55 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C167755B
        for <selinux@vger.kernel.org>; Wed, 14 Sep 2022 06:56:53 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-12803ac8113so41126654fac.8
        for <selinux@vger.kernel.org>; Wed, 14 Sep 2022 06:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Sr2wU3YSWBwhCxEQJoE1i3zQYmbJdpbozpXHeTGBoW0=;
        b=ddJ2bP5ONY5DKuQ1S5CMRCKFiBt64fU/gIJFOw6Wzw0HNICQv6c5D5pFzA1aUcYRED
         KhZ1aa/4m355bP/udx5mgE7Y/5n7DjLAJilhZCe2qQINl7vLYXCpfmoCbE9DSDdKmzej
         pGi9DM9DoX4JB0KtGPjExowSaMea7n0JcmpjBqHjICYAcfCgHBgZ9zMAVvH45o8A0h47
         LAjpmOfYngakzp57MDIez+DePZVWTISqbLcAEjBBogJ8AalAIUyfbgerHDiSxQdWEkqI
         yzcD5573bbkaHt7a3ERKPrk0leJ0LmOmLY+HBKRhQTctzvQ1YhHrJijLv3Xj/ERdmDAF
         hB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Sr2wU3YSWBwhCxEQJoE1i3zQYmbJdpbozpXHeTGBoW0=;
        b=sBgOH8x6amYQ6qg8FcoyopRy3YWgHDPvCcPBsNjrVawcAx5WXP9Bqia37BcmQF/8mY
         bD+obYDLAR3mhEcnHn1mYoG697aZ4A1qhPj4d/deOMrMSmouyim+HeP2s2WpNEf6rBff
         yNeOuF717uA9E8AOqKibfYJyjRpDsCks67hiMmPyFLsClquaEEv5YQgVsUBrBliSV0Hd
         R60y0xheSROSuLuERgMJHnNJS+YWCnGKefbtq9neVBoDOa7o8gd73lNIC3yW+F6FDW7l
         kvEYkWFlyGNCQ5SxeCgxP1BI/3H4G7pZsaVsururIDHLM0J7wgl3Jqoe1C/GKIFowiFf
         Jk5Q==
X-Gm-Message-State: ACgBeo2F0+RdgAz4mIfCUW3xtMzqN2kDbY3iLOpcUf5fljwMxyVTAnnU
        6Tm0pOgnT/6+2bSu2vDyxVF3zuXUCNu/Yska5VOG
X-Google-Smtp-Source: AA6agR4BaYOtQoQqm2IcpyBcCdUKTptJ3Ojuz61FIJFDzR2uCD7XPdaY1McbizNfu7fWAxQvXZ3gN+N3oInFdZD8jHQ=
X-Received: by 2002:a05:6870:178b:b0:12b:c621:b7a9 with SMTP id
 r11-20020a056870178b00b0012bc621b7a9mr2476963oae.41.1663163812506; Wed, 14
 Sep 2022 06:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com> <8ac2731c-a1db-df7b-3690-dac2b371e431@I-love.SAKURA.ne.jp>
 <CAHC9VhQGnEcoYeGpwbbXbMrG1dOvJ=2ohd4zPYoqBJK9p1mSjQ@mail.gmail.com> <854c05ad-888e-b882-bb97-65f4ca289bc6@I-love.SAKURA.ne.jp>
In-Reply-To: <854c05ad-888e-b882-bb97-65f4ca289bc6@I-love.SAKURA.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 14 Sep 2022 09:56:41 -0400
Message-ID: <CAHC9VhSDL+wuPGNB3axkksqVTjnxU8pS8Axz7skPk3zjBbRJXw@mail.gmail.com>
Subject: Re: LSM stacking in next for 6.1?
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        John Johansen <john.johansen@canonical.com>,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 9, 2022 at 7:33 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2022/09/09 3:52, Paul Moore wrote:
> > At least one of those, Landlock, has been merged upstream and is now
> > available in modern released Linux Kernels.  As far as the other LSMs
> > are concerned, I don't recall there ever being significant interest
> > among other developers or users to warrant their inclusion upstream.
> > If the authors believe that has changed, or is simply not true, they
> > are always welcome to post their patches again for discussion, review,
> > and potential upstreaming.  However, I will caution that it is
> > becoming increasingly difficult for people to find time to review
> > potential new LSMs so it may a while to attract sufficient comments
> > and feedback.
>
> Inclusion into upstream is far from the goal.

For better or worse, there is a long history of the upstream Linux
Kernel focusing only on in-tree kernel code, I see no reason why we
should change that now for LSMs.  I am sorry that this approach
negatively affects the LSMs you mentioned, but if they are not
interested in being merged upstream there is not much we can do to
help.

-- 
paul-moore.com
