Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E427C05027
	for <selinux@archiver.kernel.org>; Mon, 23 Jan 2023 20:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjAWUsB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 23 Jan 2023 15:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjAWUsB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 23 Jan 2023 15:48:01 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E886C32523
        for <selinux@vger.kernel.org>; Mon, 23 Jan 2023 12:47:59 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id bk15so33758403ejb.9
        for <selinux@vger.kernel.org>; Mon, 23 Jan 2023 12:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=gojuXeiAJOSy3/DtsptehDxMc4WEvKVnWFIlQO9sDIA=;
        b=Jvbd6YHgdYjzrPnXJDJm3mCYYF6D8ySZTo1N5G11v0eAHGRy6SVBosoQhj7JwFUh3g
         eicY/zujM1+GNufw8Sp1aNH/USui06SS7unFDTqbTgcy74Ciuf++VuaQ4V0PZcvDkSyv
         opy9bz0s/F5eHRVmLe2wCI6zgjKPx4ZqHUPfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gojuXeiAJOSy3/DtsptehDxMc4WEvKVnWFIlQO9sDIA=;
        b=GsCCYzvDbEvgM7n2MT4u/JUuBh79Mxg3VC2bhNceelOnlMZyxyJ45yf061D1UD6C/K
         uoUDGNGhtZzOa/xNFssTCXv7wgQU0scjfnPpgIlWGKI59VWJAHvrO/Eid8ZfnxUTapWR
         iGc4oevjjXKIvM3TtUEbkqiSsRoaZga+K7tm+bW+rlP8Up4tNShs1odPBW+MZGT5wAn3
         HrjAMGA8ErggzyJA7L7yNbdVaLXYxWwz1lX7BkHUzoStVTLWN7wfx2IE15knHC/6nGdD
         PoipDdup2cCcGMYjjIpy0cq8bBFVGfd2hXQN4r/BSzrUeRlkuVjGGrlsgZzJ6bcU/VaV
         crMA==
X-Gm-Message-State: AFqh2kq46DzPn6DHTAJBAtwdBKbtbpjaX6EcPaxwtB18MnjzyZWf4DcB
        BkaqxB2WGykEHkVOOMyFPmCUeQ==
X-Google-Smtp-Source: AMrXdXuUhT6YpTwL5XRzeyScmly38+amMVg3l0LQR1ZRnS4Rn2MqWkt7NgyMKqyMaHt3bl7Xtm3gtg==
X-Received: by 2002:a17:906:7f0c:b0:877:77f5:a8e2 with SMTP id d12-20020a1709067f0c00b0087777f5a8e2mr16424827ejr.63.1674506878499;
        Mon, 23 Jan 2023 12:47:58 -0800 (PST)
Received: from cloudflare.com (79.191.179.97.ipv4.supernova.orange.pl. [79.191.179.97])
        by smtp.gmail.com with ESMTPSA id e11-20020a056402148b00b0048ebe118a46sm171996edv.77.2023.01.23.12.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 12:47:58 -0800 (PST)
References: <20221221-sockopt-port-range-v4-1-d7d2f2561238@cloudflare.com>
 <20230123175526.59356-1-kuniyu@amazon.com>
User-agent: mu4e 1.6.10; emacs 28.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     davem@davemloft.net, edumazet@google.com, eparis@parisplace.org,
        kernel-team@cloudflare.com, kuba@kernel.org, marek@cloudflare.com,
        ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com,
        paul@paul-moore.com, selinux@vger.kernel.org,
        stephen.smalley.work@gmail.com
Subject: Re: [PATCH net-next v4 1/2] inet: Add IP_LOCAL_PORT_RANGE socket
 option
Date:   Mon, 23 Jan 2023 21:46:45 +0100
In-reply-to: <20230123175526.59356-1-kuniyu@amazon.com>
Message-ID: <87zga9vuyr.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 23, 2023 at 09:55 AM -08, Kuniyuki Iwashima wrote:

[...]

>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>
> In case you might forgot this comment, but the patch looks good to me.
> https://lore.kernel.org/netdev/20230111005923.47037-1-kuniyu@amazon.com/

Sorry, it has slipped my mind. I'll apply it in v5.

Thank you for reviewing.
