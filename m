Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803EBC433EF
	for <selinux@archiver.kernel.org>; Fri, 22 Apr 2022 16:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449661AbiDVQ37 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Apr 2022 12:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449657AbiDVQ35 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Apr 2022 12:29:57 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D735EDC9
        for <selinux@vger.kernel.org>; Fri, 22 Apr 2022 09:26:48 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r4-20020a05600c35c400b0039295dc1fc3so5664026wmq.3
        for <selinux@vger.kernel.org>; Fri, 22 Apr 2022 09:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UQKwgkK7XcnD0Rg5dyzM5z8p1A79/VfuJ1pqbXYKM5g=;
        b=DB7OJJQM6ToLBwkgF1N6fJGkNaBv8n3ClPRlWkq03mVVL/VMuo988a/CRj/JU2y/J3
         LxIs6u2dVbU/dDDZQkfSypxNKRbl/F8k4++kuvNm1WnLAugDdOpzuNve1T0LTcewF0bY
         zmEP3SO2qgXPWgxHFH4ICYAlPt3RzE06HMA2A3AiJv7egQz6/emF65NCjuOgSU9ESYU4
         BDFntr1axQYaCcfEpgCW/juiNKBN5tRTlUoplhRG6UdiHRv6so2i2RIQqbOdUI5f8AnA
         6I5JDeixp+QaRbIk+MeGB/B/IoWYPnesEjbNFuitEtMfGJ/Nrz9uobpFuEWDZMT7afgN
         kKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UQKwgkK7XcnD0Rg5dyzM5z8p1A79/VfuJ1pqbXYKM5g=;
        b=lD/hfPbGOi+g/Nci/y38ZusjVuL3M3oPS/IQEmX/jotWj5GtKO0wJlMtmB9SLMaY4w
         qJnn9+XJaspuPxnDLVTQymG3TLEIm7SzD160W0RCfjq5KMHxO5n0sbJ0hVBUgrRdzGnU
         lHDilIbSDeAkGEUy6+KQsxgC4CiWKnvZzyHRxiUzAitF8mmD3EyhROidsTbvLJxa0lGY
         WDWAARqnFDFZvkBN3OV1qpopcwE0HM8KMjIQFf8XqQ6EGm+/bvKta/CALVeSSi3o10R7
         ewiAYq5fTUGKAoReLdcfZVcAUoEv8xF+FkBu7Qw98ZCFfkdWv8wU3q7QiOqbs0EwAS/p
         F9yQ==
X-Gm-Message-State: AOAM5332eH2Z5yc1sMU2ezY4457tQHpU9ysvdqnktWz6FL++CSdN6Z+H
        pw9EbtGsFlvO1nLIH2PChEcRpnTyByaBVE06ItiQ
X-Google-Smtp-Source: ABdhPJz0usETe5tYcvsLPEcLUMTwIkTc1Rk3Ud2Ys3tDsyivrygwosiMcwEzjUWboIzGHFJlhESi2sq4OIiN1z5J2UY=
X-Received: by 2002:a1c:3b89:0:b0:38e:b37f:52d with SMTP id
 i131-20020a1c3b89000000b0038eb37f052dmr4774530wma.197.1650644806553; Fri, 22
 Apr 2022 09:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220418145945.38797-1-casey@schaufler-ca.com> <20220418145945.38797-25-casey@schaufler-ca.com>
In-Reply-To: <20220418145945.38797-25-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 22 Apr 2022 12:26:35 -0400
Message-ID: <CAHC9VhS04Q5BdOgJAo0QB-HZNSgCVRbp1-YZn7vitGfVrqyDuw@mail.gmail.com>
Subject: Re: [PATCH v35 24/29] LSM: Add a function to report multiple LSMs
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 18, 2022 at 11:12 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Add a new boolean function lsm_multiple_contexts() to
> identify when multiple security modules provide security
> context strings.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h | 9 +++++++++
>  1 file changed, 9 insertions(+)

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul-moore.com
