Return-Path: <SRS0=4SPy=7P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BEAC433E0
	for <selinux@archiver.kernel.org>; Tue,  2 Jun 2020 12:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 002EC206A2
	for <selinux@archiver.kernel.org>; Tue,  2 Jun 2020 12:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Rx2vYLqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgFBMhS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Jun 2020 08:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgFBMhS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Jun 2020 08:37:18 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEACC061A0E
        for <selinux@vger.kernel.org>; Tue,  2 Jun 2020 05:37:18 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id m21so9902387eds.13
        for <selinux@vger.kernel.org>; Tue, 02 Jun 2020 05:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W/vYqnxlfvvFWrXHji4N72JrQSobl8YG8BgmGFzw/1o=;
        b=Rx2vYLqRvuZ2QKlILCZzY/LVn3JDrFHH8skOv/+7EUS5fodt6cfPr2t+JJ6fzFvQsT
         tZylnD7F8FbDgXth3nah+OaMZ+1e7OanS8NkaaMJOtX1QygMPvVjOZKczW4ugpc3LEMI
         2nkGkBzl9xANI0G3+xnCDIO/TzIfRc7jT9TnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W/vYqnxlfvvFWrXHji4N72JrQSobl8YG8BgmGFzw/1o=;
        b=naWcGQU+bS5c5USvx1OJtANrKG9mgTJJ58m3b/XyqDYb7VrHNZJxO6NDbfROkLY22c
         3Sbw9ufBpBAltGhnAkptEGULP/9DO6OaK0Rg9rHm3PjUogig4N9Y9bfMmZUctTj37JrD
         IhV6XSCa41jJPK39XW6mSORBg9OHg3L7k2F8AFEkkwXJ/SpBo/wU3R96pS51ZuoPQPk/
         ZUowaOAqvMyI/e8q68uUUosLHrBLbNLZbOs04IBv8jE85SietAxCrFtxB6+AYXgAotNq
         sHRfPixM0JAbZ0D483T3cR+3J7clvDiEXkpRu+mVYnZICMGzKm6rmcdOce8038TQ4e1s
         MIzA==
X-Gm-Message-State: AOAM531HrmjXbfhHfpV3CsIgMZTT3itIHSqYE8Jl9DEImt6kHwDNSUyS
        FkTYrlHDkCoeHu86S2VyjeJW1HF4ILBKV2IMyAzHOQ==
X-Google-Smtp-Source: ABdhPJypBt+WIIAVApWYTVRjaFYRB0mkj+y2A4u/Ommo2t3aLoJeydBGnpT9qqrdPoMaiZz3kL/fI0/tg07mtER07Yg=
X-Received: by 2002:aa7:d785:: with SMTP id s5mr12196951edq.17.1591101436823;
 Tue, 02 Jun 2020 05:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <cki.F472C8C7F2.AWNOVIOTU4@redhat.com> <CAFqZXNtdwMAiu65Ne0HLyY5JO-QK=cqT-OF_=6mdnGVo8XA9Eg@mail.gmail.com>
In-Reply-To: <CAFqZXNtdwMAiu65Ne0HLyY5JO-QK=cqT-OF_=6mdnGVo8XA9Eg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 2 Jun 2020 14:37:05 +0200
Message-ID: <CAJfpegvF+vJ9DAmAD7mTcuT2pvPMC1foWs9yuTFjSmkkQ6w3KQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E7=2E0=2Df359287=2Ec?=
        =?UTF-8?Q?ki_=28mainline=2Ekernel=2Eorg=29?=
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 2, 2020 at 11:27 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:

> I haven't tried to reproduce/debug it locally yet. Just posting here
> as a heads-up. The last known good commit is c2b0fc847f31 ("Merge tag
> 'for-linus' of git://git.armlinux.org.uk/~rmk/linux-arm"), first known
> failing is f359287765c0 ("Merge branch 'from-miklos' of
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs").

Likely culprit is:

a3c751a50fe6 ("vfs: allow unprivileged whiteout creation")

And the change of behavior vs. LSM are expected due to the fact that
now whiteout creation calls the security_inode_mknod() whereas before
the patch that hook wasn't called.  This was discussed here:

https://lore.kernel.org/linux-fsdevel/20200409212859.GH28467@miu.piliscsaba.redhat.com/

Thanks,
Miklos
