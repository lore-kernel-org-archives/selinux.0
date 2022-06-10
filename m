Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4094CCA47B
	for <selinux@archiver.kernel.org>; Fri, 10 Jun 2022 21:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243046AbiFJVLO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jun 2022 17:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347096AbiFJVLL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jun 2022 17:11:11 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E505049267
        for <selinux@vger.kernel.org>; Fri, 10 Jun 2022 14:11:09 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id h192so283819pgc.4
        for <selinux@vger.kernel.org>; Fri, 10 Jun 2022 14:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mAlhHjicxdibTZDY5HOZ3HLGftkcyfsPbsuBXvhev58=;
        b=rZoLQeeoRRIJfdLUJHE4dnrv8nvOAt9iOR0vH2qVCqvRI5W3AZ+mv8x+IW7fCeK6ba
         OVKZBg+dmXyW9W+XodkUKv8lx+avXiEFgpHK17IIYAWUXvzSmlWwi9ZgEJByV24JtQVO
         yqMzskfHsVeIjFMHcrNFCLiOvBVonmGQq2DEtnnHc9yOLy++SvJkgef5FG4G+cG43fEd
         /Fvg5ax3RpWb3XiCYQeuzl/1lH4B3XataJDDAwrYOiiTIg3FxWNSp0B+/gxNwomFI++O
         03qLVVKkULvOYqTllPPH4HMOJPK4F6Da8bvMMDw6+uMoPLYmWDrfFLEGDTdRsqCouOQ6
         n14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mAlhHjicxdibTZDY5HOZ3HLGftkcyfsPbsuBXvhev58=;
        b=W8QS+w/UtvIXIZInZYY7EcReG32mczvg4LUKP7wKUYPn8JoOK4vdK2YRTNduxQ5xfZ
         uxZbXWUSjgJTyIeCtYu+X5YNK7DZqcifEz5hopfr6y7gZ5zdek1vf82B0ilytIujqHip
         7fgJGh/mdYjWYVFS//iRS3tlZq2fsRTLd80EXRpHUthkyeEAA0g4hu/+kz1ygpnuyPZF
         N9b/Z4Ie37ZYSCgXpjtH/5dZEqrbT7azCzFzC3dPm1w4IWcdvVBjxQJagAFFKQcyOIW3
         L2YDWmfpWI1QiHYwglNIhCA6PhvAaVPwqZ/pgiD1ex3Bl69WNLSC0jmmr7k56VJO8my8
         /98A==
X-Gm-Message-State: AOAM5301nejIn+8KFZyPxNRWJc5WqSSI737S7L0FGQSAUv72TBw35Crp
        TnVrPsUDdRjce+hEoGwhGj8WZZyINObtSxwR/1nYMRd95g==
X-Google-Smtp-Source: ABdhPJwx7n3musHGFyiyfqvl/EdH710RryS6Xm5TNC7u0DL6j33BjBGOdeGMogcoVPAETgbUEuZ93EmDm/ToHyuQPv0=
X-Received: by 2002:a63:31d0:0:b0:3fc:5770:e779 with SMTP id
 x199-20020a6331d0000000b003fc5770e779mr40782512pgx.376.1654895469427; Fri, 10
 Jun 2022 14:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220609230146.319210-1-casey@schaufler-ca.com> <20220609230146.319210-29-casey@schaufler-ca.com>
In-Reply-To: <20220609230146.319210-29-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Jun 2022 17:10:58 -0400
Message-ID: <CAHC9VhSTdZVVAbSS_kT-Qtk6iy7w+GdAx7-F=aPQLtG5Ncb_ZA@mail.gmail.com>
Subject: Re: [PATCH v36 28/33] audit: multiple subject lsm values for netlabel
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

On Thu, Jun 9, 2022 at 7:16 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Refactor audit_log_task_context(), creating a new
> audit_log_subject_context(). This is used in netlabel auditing
> to provide multiple subject security contexts as necessary.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/audit.h        |  7 +++++++
>  kernel/audit.c               | 26 ++++++++++++++++----------
>  net/netlabel/netlabel_user.c |  7 +------
>  3 files changed, 24 insertions(+), 16 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul-moore.com
