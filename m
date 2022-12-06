Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B015C352A1
	for <selinux@archiver.kernel.org>; Tue,  6 Dec 2022 20:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiLFU0m (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Dec 2022 15:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLFU0k (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Dec 2022 15:26:40 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEA01F9DC
        for <selinux@vger.kernel.org>; Tue,  6 Dec 2022 12:26:39 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id g1so7559954pfk.2
        for <selinux@vger.kernel.org>; Tue, 06 Dec 2022 12:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5w/JA/rNNSsgqdpY1QhKCqr+BFJRPZ0RCMlM6oTlS2I=;
        b=JlgK0dUVOa387jbpMDqW8SJmd3bPSSNkuD8CDb/mCtVCLTauv/Mz5dEYnq9VYd7yWM
         JwMxFUCYoHau9FWytySAWrHGmCtBCPkoF/j/Rgdl0HSNO5InOf9tv4Oy5Iyn20gwoFoW
         mjn6XWtDDm9BgzJ8SSHMfe/wbyAyMqxRw/o1qeRmg3kDcijd/iifX6oRgXCY+yq158bm
         o59JzwqLo/A16mTGjUuX7sZhkMW7CTNAaUvw71fUmiYjpTWEwQ9laR6ZGgOUO07LJojx
         ho1GqsG0xA5ZzJVzh0L1Hv9XnlfNPQvm5J3zTfaDmgyANE5Zl4SGZavqHEO2tlfQcLpL
         EepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5w/JA/rNNSsgqdpY1QhKCqr+BFJRPZ0RCMlM6oTlS2I=;
        b=KAnjEWXX/DR+E9zDZbBXQ6PBsUms1/1nomeL7gswJSJ+zds1Bm0hFLLDLaL2rt9xZU
         T8GCiI637gcp+QivjXuYWSd31u9xkA4SvdsKJ42uHjpI8cBdKQ5iI/m7fo8i6XGFlXct
         vZbef7ROaRRZ6zzeopZsKP0KcI7mWxFgfPqCIunlZ/V0wccZSenA1e8NXWSOCJmJao+A
         z6o52DdOsKr/l+fzFTy6BjJ3AkLg1zPZ7ton7l7VBAqQ6yt2AQovyjZSDT6pKwenXTy3
         sAUkYamBT6noz0q7ErC0sq4nY8gHWvRdA7+Wbiv7q7PImEQTKoQdyBBFjF2/x+YrGbQ8
         asvg==
X-Gm-Message-State: ANoB5pnb2ySkN1uNL66C1eI1nBpX9ttCPZImIWqnrwkMO7SStjQ5fVoh
        ggUNByVAnqoOCG9ihd9XmRdh/YMk/Nb2XGsT3cE6
X-Google-Smtp-Source: AA0mqf4ciNjmUT/XCeTPCg50EIAZp0OgH9sZk/GANybiOzZJiX9Bt5Gx/aG46+j2ClgYrf2v1V29Ctwj/ZxoSNUh75A=
X-Received: by 2002:a63:4424:0:b0:477:96e2:9065 with SMTP id
 r36-20020a634424000000b0047796e29065mr62696644pga.533.1670358399001; Tue, 06
 Dec 2022 12:26:39 -0800 (PST)
MIME-Version: 1.0
References: <202212051932088061889@zte.com.cn>
In-Reply-To: <202212051932088061889@zte.com.cn>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 6 Dec 2022 15:26:27 -0500
Message-ID: <CAHC9VhQnfMkrRNmEe0FtcFis3pkPp7Xd8dUbE3cT+cSni-9qxA@mail.gmail.com>
Subject: Re: [PATCH security-next] selinux: use sysfs_emit() to instead of scnprintf()
To:     ye.xingchen@zte.com.cn
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 5, 2022 at 6:32 AM <ye.xingchen@zte.com.cn> wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  security/selinux/avc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

SELinux uses securityfs, not sysfs, for entries under /sys/fs/selinux.

> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 9a43af0ebd7d..517fe3454aec 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -174,7 +174,7 @@ int avc_get_hash_stats(struct selinux_avc *avc, char *page)
>
>         rcu_read_unlock();
>
> -       return scnprintf(page, PAGE_SIZE, "entries: %d\nbuckets used: %d/%d\n"
> +       return sysfs_emit(page, "entries: %d\nbuckets used: %d/%d\n"
>                          "longest chain: %d\n",
>                          atomic_read(&avc->avc_cache.active_nodes),
>                          slots_used, AVC_CACHE_SLOTS, max_chain_len);
> --
> 2.25.1

-- 
paul-moore.com
