Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593E2C4707F
	for <selinux@archiver.kernel.org>; Fri, 21 May 2021 20:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E3BC613EC
	for <selinux@archiver.kernel.org>; Fri, 21 May 2021 20:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhEUUVZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 May 2021 16:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbhEUUVM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 May 2021 16:21:12 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3285AC0613CE
        for <selinux@vger.kernel.org>; Fri, 21 May 2021 13:19:39 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id lz27so32203008ejb.11
        for <selinux@vger.kernel.org>; Fri, 21 May 2021 13:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HdFvc7fptOa2U/lZENFnDrQgRiZEVZLgg6sKDbnUzyg=;
        b=aG3bBjgVeg6slH6NXO/4ixHXPGXGELFb98HmduPBE+sk25y//o2bRRKcaARiDg1p7r
         Ozu6MToPEGXm2IsakqX3NYJXJMtB2pgtfkj0HRlt/O3XV6FPK+ZmafBVMw397fb3siBV
         Ym6c6OhgQ/BbBPgcaUrSg/ObB813tXqU6lqYivpVGYTSEyEAHMHc+9ExoYvMQSqhYrcp
         qObmfIZLSwbX29/TiIs9l7krP5U/BWdae6GVoJKcyPw1I+PrcjPYoDRf4JWY0JWBa5z2
         ArQYV3pvf/0S/Vh55fioWORYr/OIioK3LtSKT9AZIiY9Sd3ggrtQ9uqaKsfmhj95+znj
         hpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HdFvc7fptOa2U/lZENFnDrQgRiZEVZLgg6sKDbnUzyg=;
        b=UIo3oeUKxYZnkMbPbsIKwkd2ieFWNY/2dOpqEdQCrpCtjJZBbBx5VUNLLLOvAU6SEq
         zCm6OU2UBCnOpGEBMI3UcNhsb1kXKo5BnbT5zel5grUN434EIEUsTlvYLkQX8MYMVEdF
         IF0MQ9k1qz2epzwOhF+696lS4lvod6KL/qewkyuwCnv2oCaAatm5tRLR4wX89+BVzOeu
         rh1FGjzzlr3Hj9yOe9R6mhwzeETMxQGAu/4o11o3dA1mVhMxvSTmYTXtKz6u0gB6hR7i
         vNO0Y+XDzUp8r0ylg1OdCjT9PsQCPOyRumWbluI14jjvomO3gNPxICSnNOwACN9n+yTT
         K6Ng==
X-Gm-Message-State: AOAM531Y6//7yF9NSqFeQE6TBsiQlhp/xjrsVzy4G2QqGzwPFPU8Q4+A
        VL6X0JndO1vcAysSxwz5Iv/RcbalXfYp3b0M6aZN
X-Google-Smtp-Source: ABdhPJz6RI+DFTaAZKp1yYFkI36BapBPZgGOSGg8oZyqUJOh8WRI4wf9Oyp08Zz6Th80x+gDaI37+ox3yh/PXrCSCRM=
X-Received: by 2002:a17:907:1749:: with SMTP id lf9mr12367624ejc.178.1621628377771;
 Fri, 21 May 2021 13:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210513200807.15910-1-casey@schaufler-ca.com> <20210513200807.15910-22-casey@schaufler-ca.com>
In-Reply-To: <20210513200807.15910-22-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 May 2021 16:19:26 -0400
Message-ID: <CAHC9VhSmAUg-mVrHpmgr3bF_+MeFd3p6W9N3b_kptzEY5YrsiA@mail.gmail.com>
Subject: Re: [PATCH v26 21/25] audit: add support for non-syscall auxiliary records
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-kernel@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 13, 2021 at 4:31 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Standalone audit records have the timestamp and serial number generated
> on the fly and as such are unique, making them standalone.  This new
> function audit_alloc_local() generates a local audit context that will
> be used only for a standalone record and its auxiliary record(s).  The
> context is discarded immediately after the local associated records are
> produced.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: linux-audit@redhat.com
> To: Richard Guy Briggs <rgb@redhat.com>
> ---
>  include/linux/audit.h |  8 ++++++++
>  kernel/audit.h        |  1 +
>  kernel/auditsc.c      | 33 ++++++++++++++++++++++++++++-----
>  3 files changed, 37 insertions(+), 5 deletions(-)

At some point I suspect we will need to add filtering for these
"local" records, but that is a problem for another day.

Acked-by: Paul Moore <paul@paul-moore.com>


--
paul moore
www.paul-moore.com
