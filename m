Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD6FC00140
	for <selinux@archiver.kernel.org>; Wed,  3 Aug 2022 02:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbiHCCkr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Aug 2022 22:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbiHCCkq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Aug 2022 22:40:46 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9ED33348
        for <selinux@vger.kernel.org>; Tue,  2 Aug 2022 19:40:46 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id bb16so18565315oib.11
        for <selinux@vger.kernel.org>; Tue, 02 Aug 2022 19:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=dJ9RyKWE5FBwVhzJS/Ney0KLGBUDYNi42Whw7jsCqTk=;
        b=Pb2Eej0xmH23y/cqzxJPqY7hR1X5oZDSF3Ij3l5/RGclHhaIy+1giMDCyH6E97NFtw
         W7X8k0+rOQNq7e1b+QP8yaXoPmf+qMf6CRY+OtEnlKXjnb7XFhgGh/463kRiVyWF7sEJ
         2ks+XT7DASO3j70gCiOwsvZl/c6VaVseb8He8FApS/vdEXrmKVJeJd/HpZoNtO2dQoWS
         W23yk7KbilvyYWCQg4K3FoK0MopX7hfo/gsWWqE8RR8xXHUj0N4MpYTT/v/7R+B6NDmZ
         17+OATGNanpWeQa72PZc4UUaEZpBHSPUuYebvjMsZgMHlQPnGOk0Ou0b6zPKA9p7+yFe
         Zefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=dJ9RyKWE5FBwVhzJS/Ney0KLGBUDYNi42Whw7jsCqTk=;
        b=6xroOo+12E0PwGBRUN8yK4nrUCkUDtc/1EPH9K4lcO2wndVSOsyomgGARKA+Xi7cMU
         S8MteRxiA3T4pQ37kcwQyu1UzVPYwRD4gklkXD/NxsHm8QjPpspgZ0vcCOkhUQ/EE0Mx
         Ch9W2cmsrRhbjUEEsYLV0jQhpfzc47AKRvz0iCT500o0fFL7b0NYH1760NaKcEQx7SU2
         P9CfVjYzZycPHO8Opq0stcQYRuyx9NmDPe8+RWy0ea3/QmYrnb/wq/vBhZBxK90Bvdyx
         rHf43L//l27PIwjWJPocCccVPKZQiCAN2Kzhih6eVj/zg/GGD1ZCtvAeHPNsKzWjYYIj
         7WCQ==
X-Gm-Message-State: ACgBeo0sYdFyEx9kEnhdcQgC/OwrjXzwwDMLfRhejU2YqrK+4senJ0pM
        1yUkpDeg/9M5q0ZBeGMOatW/bhS2p4JE+ZdzUGCdk2lqEA==
X-Google-Smtp-Source: AA6agR5+3/8/YLolArypjH7JH1LqPE7ZmK02/QYNQW0OMSF5rhL00CxWaT/Z0tNJLAoc36IeOmsIxl5nMMQQIu3vF8c=
X-Received: by 2002:a05:6808:2389:b0:33a:cbdb:f37a with SMTP id
 bp9-20020a056808238900b0033acbdbf37amr962169oib.136.1659494445502; Tue, 02
 Aug 2022 19:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com> <CAHC9VhSF8hWg=7tbFiCrizNF61vpwJcU3793LcStiu-anW4i1g@mail.gmail.com>
 <2642904.mvXUDI8C0e@x2>
In-Reply-To: <2642904.mvXUDI8C0e@x2>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 2 Aug 2022 22:40:34 -0400
Message-ID: <CAHC9VhR0mhUp-dnyP3uE5ALS6Dt43k6xQ_LVYw+QVjC5LG3qqA@mail.gmail.com>
Subject: Re: LSM stacking in next for 6.1?
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>, linux-audit@redhat.com,
        John Johansen <john.johansen@canonical.com>,
        SElinux list <selinux@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 2, 2022 at 10:34 PM Steve Grubb <sgrubb@redhat.com> wrote:
> On Tuesday, August 2, 2022 8:56:21 PM EDT Paul Moore wrote:
> >  I can tell you that I've never been really excited about the /proc
> >  changes, and believe it or not I've been thinking about those a fair
> >  amount since James asked me to start maintaining the LSM.
>
> Why do we not have auid and sessionid in /proc/<pid>/status  ?
>
> This has been needed for 10 - 15 years.

Nice thread hijack, but I believe you already know the answer to your
question Steve: submit a patch for review.

-- 
paul-moore.com
