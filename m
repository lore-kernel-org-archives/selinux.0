Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41512EEAA65
	for <selinux@archiver.kernel.org>; Thu, 14 Sep 2023 19:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238295AbjINT1f (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Sep 2023 15:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjINT1e (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Sep 2023 15:27:34 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5424826B7
        for <selinux@vger.kernel.org>; Thu, 14 Sep 2023 12:27:30 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-76dbe1866ecso89591785a.0
        for <selinux@vger.kernel.org>; Thu, 14 Sep 2023 12:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694719649; x=1695324449; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:message-id:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LgN4WCvEJ8wWXRweLBdinmd4ZI7NWvgRKKEqbKZQ8K4=;
        b=ObH4GV6HWcaqilG+6j8/TWFkjrGRr5BIQ5N0mLEhnBmfVym3SYgxW+m1GOdw6DB5AL
         6llW30QDiyYb2ojOlhhwAC8xSTnkm6WGJzqI1pwD/s2UNp/hYG38gwLPNRiNVI6tiLh/
         W3eOMVVANlesdZEG0ATsj31iMPDXro73/Dm2HifMjhIbnXUOknTlRjT/bVf49D0mzstl
         aMMaewB84f/Wl4ySr8BqCe8OjrblFpkhkcGnOA8qr+gUQ2xjH7Yth8eMghs3rLu8o/wy
         X58uk0J/kxCm83Wl2R08U8DUxkfBs0jgcNfqMe1ekq/1926bOk86OypgdRAIj+T/PwWj
         Ayrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694719649; x=1695324449;
        h=in-reply-to:references:subject:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LgN4WCvEJ8wWXRweLBdinmd4ZI7NWvgRKKEqbKZQ8K4=;
        b=pHWPh515obeCq1p9vTf2QUjKOBmozmaD0uCCVPf6g0o13uqpd6qL3loF8fYoWUZccU
         96WEeUQIcCzJLs9uW1LYYUqGlZ+MKQZFsRIYK5bfEdNzJy0M3ntcuGdmqgnyQC9wN7t+
         bmZbIReBGsQB/0I1xjZIjYCXU4eZgfkfJAfJyg6thELTTLQPn99Q7djBm+cEv2d086gz
         h70oIwtvUs1mBK7S0ILktvBUCUUqDPmN9YFStJR7ssw68WWwz/aIl3mqzkuoW3yUJTjQ
         QTfXPiNbgQj3/L+f3GUQD6MWqaRF8mLJEKrbBfWZb8mXb09EGTPpip/Fn7nzLUr8x190
         Obvg==
X-Gm-Message-State: AOJu0YxXZW+krGgisg8Ky1YI2Bk7H+pIAy+bknWGJaoaYSoPwrTMQ3WT
        rmJS7JK6fry6yOqt+ADD5+uk
X-Google-Smtp-Source: AGHT+IH/m5H1VoxPInjdFLJZV1oHAFDb0GkezDRGraHnDv5FGgIiQcSe7t9i8flET4V69d2gupot8Q==
X-Received: by 2002:a05:620a:d82:b0:76f:1eac:e720 with SMTP id q2-20020a05620a0d8200b0076f1eace720mr6189920qkl.25.1694719649320;
        Thu, 14 Sep 2023 12:27:29 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id m10-20020ae9e00a000000b0076f35d17d06sm684548qkk.69.2023.09.14.12.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 12:27:28 -0700 (PDT)
Date:   Thu, 14 Sep 2023 15:27:28 -0400
Message-ID: <c1b149b8a7d35ed3b5da3b17f38547eb.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        ztarkhani@microsoft.com, alison.schofield@intel.com
Subject: Re: [PATCH] lsm: constify 'bprm' parameter in  security_bprm_committed_creds()
References: <ZOXAaHDqesqQXaNi@gmail.com>
In-Reply-To: <ZOXAaHDqesqQXaNi@gmail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Aug 23, 2023 Khadija Kamran <kamrankhadijadj@gmail.com> wrote:
> 
> Three LSMs register the implementations for the 'bprm_committed_creds()'
> hook: AppArmor, SELinux and tomoyo. Looking at the function
> implementations we may observe that the 'bprm' parameter is not changing.
> 
> Mark the 'bprm' parameter of LSM hook security_bprm_committed_creds() as
> 'const' since it will not be changing in the LSM hook.
> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>  include/linux/lsm_hook_defs.h | 2 +-
>  include/linux/security.h      | 4 ++--
>  security/apparmor/lsm.c       | 2 +-
>  security/security.c           | 2 +-
>  security/selinux/hooks.c      | 2 +-
>  security/tomoyo/tomoyo.c      | 2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)

Merged into lsm/next, thanks!

--
paul-moore.com
