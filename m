Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60217C433EF
	for <selinux@archiver.kernel.org>; Fri,  4 Feb 2022 19:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbiBDTaq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Feb 2022 14:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbiBDTaq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Feb 2022 14:30:46 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F78C061714
        for <selinux@vger.kernel.org>; Fri,  4 Feb 2022 11:30:42 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id w25so15092560edt.7
        for <selinux@vger.kernel.org>; Fri, 04 Feb 2022 11:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uui2S04KfeLn7tclqk4uBCi+KQBiT0TSdJ2j2Eo0eK8=;
        b=NhqOSn17aSsi/ox5fxEoCy2FwwLX1SOhHrCI+8ZWAQ5lkdLmcZZYyknKsi73xuykjw
         emTSzMEUMrQrrhxTHL3PL5XTWilsTOaOo4GBj6OfX/qId3k4GVyXSkqkLCte2QAwmSay
         Wy7N0UWEeBJqanCayUMZN9R39/EkEdGDNnahJVN/O9PR7+036pGkGisbH0ab6zp98bHJ
         w8uXQKuk/EdsoNjvdJZZpf3aTytkFAH2GZmLxe+UogNQj1utcV3wgQvJUN7/vJoljh+y
         do7tRjgul4Li24eF+yv1wCKo8kTIMwqM8B9uiEMxSTXnqSBA9SoawPLSTt75yR+k8kqS
         YPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uui2S04KfeLn7tclqk4uBCi+KQBiT0TSdJ2j2Eo0eK8=;
        b=D8iypzZDSFQygN4evSQimv9SxE9H5t+AnxMGUO67cRou8DDuf5bVaG06k2sJ6DuZCJ
         t7VjeNSdH3Qsd0Ro6pa6fx97+BaEgrBwP7vEzVxyB64lpaaaermepDC2xA31aTNjtv9f
         MmQCjNtD95XecEfdyVz0eHw2utYn2OQL1LeAAWKD9kwSieT7+V8+zHoxPdjuPByP3FYP
         eR/P2U6YSndYJSEQjDEpGZOChn3UfDNNtKKItsXdNA9IiHv/eOYy3oBtxMEf8Vzx0Ot6
         i5yZPw9gD8/H/5kQPf+ta0EkZnXHePF0uAlFW2XA3ZI3sct5I2+u1+VRADXZw+OUmcLF
         WOQw==
X-Gm-Message-State: AOAM532qtZo0r7Vk5wzY+XYn8HxILZxKOtlC8YWHcwJTTO6h4aU/jZKl
        SMGvLa+a5NW5J+7MnY6lmgYKkxYD0CfVP+q+nIna
X-Google-Smtp-Source: ABdhPJybAnOs3EILKmkxqYMlHoTkc8+8HzQn1vjqTBXf9gRABfFmwMC2mBV9avik9K+Bx0RXLIWkICKs9tSRw5NwAAU=
X-Received: by 2002:a05:6402:51d1:: with SMTP id r17mr709509edd.22.1644003034250;
 Fri, 04 Feb 2022 11:30:34 -0800 (PST)
MIME-Version: 1.0
References: <20220202125529.85533-1-omosnace@redhat.com>
In-Reply-To: <20220202125529.85533-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 4 Feb 2022 14:30:23 -0500
Message-ID: <CAHC9VhSCqqFu6xA=A7G8kA0JVO9s7emf_3LkcAXT_UkdP7DHsg@mail.gmail.com>
Subject: Re: [PATCH] selinux: parse contexts for mount options early
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Scott Mayhew <smayhew@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 2, 2022 at 7:55 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Commit b8b87fd954b4 ("selinux: Fix selinux_sb_mnt_opts_compat()")
> started to parse mount options into SIDs in selinux_add_opt() if policy
> has already been loaded. Since it's extremely unlikely that anyone would
> depend on the ability to set SELinux contexts on fs_context before
> loading the policy and then mounting that context after simplify the
> logic by always parsing the options early.
>
> Note that the multi-step mounting is only possible with the new
> fscontext mount API and wasn't possible before its introduction.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/hooks.c | 202 ++++++++++-----------------------------
>  1 file changed, 53 insertions(+), 149 deletions(-)

Merged into selinux/next, thanks.

Please keep an eye on line length in the future; I understand it is
considered poor form to split long error messages, but some of the
messages in this patch are unnecessarily long and wordy.  You may have
inherited some of those messages from the current code, but that
doesn't mean you can't make them more concise.

-- 
paul-moore.com
