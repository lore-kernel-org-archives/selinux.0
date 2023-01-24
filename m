Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E349CC25B4E
	for <selinux@archiver.kernel.org>; Tue, 24 Jan 2023 13:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbjAXNeI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Jan 2023 08:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbjAXNeH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Jan 2023 08:34:07 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62EE83F5
        for <selinux@vger.kernel.org>; Tue, 24 Jan 2023 05:34:05 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id v13so18271127eda.11
        for <selinux@vger.kernel.org>; Tue, 24 Jan 2023 05:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+R92fQrpcdOxA7n8+Wz6CRyggOb716hAqimEPplr2M=;
        b=wjmdH+Js/pyt67ToH4gglRTsx7PRg3bQ+k7S4YmLlM7GBIDtJJFkZb91Zhlw34LtvD
         bH2YD2DA6Hx//F1bT2PZUEZk16UDnKz/GDufYvMiVQsih9jQs6A3zyK+CJLlcotehxQQ
         sXj4nNkLYMqf2rjEHhsx2sD3BD8Qnc7Jv1awE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+R92fQrpcdOxA7n8+Wz6CRyggOb716hAqimEPplr2M=;
        b=rqa+eesoBdT3t19uCrb+JgSx2sbBWIbVWQoGa0Uc0cklZlsPbB+w1I41FTlsu8WCEQ
         3p+8g55RhLCyzbIWhcWymUetTbgXCLywoYjnxLE89EvPTRB8krG0SvfqSp7OneDp7MGE
         gjQE7LSSuqDET234X9jaWLTYuzNmpmd/G45QEDn2hNa/RRRUl6Gg1tasfRbH2ypc08Ef
         0My1BnIYNXpqiccOKAly8FjTsGUE36TQGBASNkcMVQD/sa/fiXxrszixyMG8tRvwZ23/
         Xc+wsjPglMxqAhPzAwQU//r5Anzxwi+2BdmzqTSlvT5xD6momHYH+tGasbbRB5JI3RPg
         me8g==
X-Gm-Message-State: AFqh2kq8ZS37X7BCCvNCN49PbFfkokoHxkXYTKEqODce/VuYZziCt7iL
        u8d007u+lKL/zJQEYQNP9XVQgA==
X-Google-Smtp-Source: AMrXdXsdS/bhr7JQkKp3wXtxrtV3ghb1VYV47FKbContXQHG5E6JgdMdva4GJ44Ei9qStxyZMbImuw==
X-Received: by 2002:a05:6402:27cf:b0:49a:23ce:2ab4 with SMTP id c15-20020a05640227cf00b0049a23ce2ab4mr35735860ede.42.1674567244288;
        Tue, 24 Jan 2023 05:34:04 -0800 (PST)
Received: from cloudflare.com (79.184.123.123.ipv4.supernova.orange.pl. [79.184.123.123])
        by smtp.gmail.com with ESMTPSA id v25-20020aa7d659000000b0049ac6f53e6asm1049657edr.80.2023.01.24.05.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 05:34:03 -0800 (PST)
References: <20221221-sockopt-port-range-v5-0-9fb2c00ad293@cloudflare.com>
 <20221221-sockopt-port-range-v5-1-9fb2c00ad293@cloudflare.com>
 <Y8/NrXosvah67bUg@unreal> <87fsc0w1hp.fsf@cloudflare.com>
 <Y8/XYBtzMzKyIZjo@unreal>
User-agent: mu4e 1.6.10; emacs 28.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Neal Cardwell <ncardwell@google.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, kernel-team@cloudflare.com,
        Marek Majkowski <marek@cloudflare.com>
Subject: Re: [PATCH net-next v5 1/2] inet: Add IP_LOCAL_PORT_RANGE socket
 option
Date:   Tue, 24 Jan 2023 14:32:38 +0100
In-reply-to: <Y8/XYBtzMzKyIZjo@unreal>
Message-ID: <878rhsvyyd.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 24, 2023 at 03:04 PM +02, Leon Romanovsky wrote:
> On Tue, Jan 24, 2023 at 01:33:07PM +0100, Jakub Sitnicki wrote:

[...]

>> I'm happy to adjust the changelog in whichever way that will make
>> everyone content. However, ATM we don't have one, it seems.
>
> We have, just some of us don't care. It doesn't mean they prefer to see
> changelog before ---.

OK. Thanks for clarifying. Will sent v6 with changelog moved.
