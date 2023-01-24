Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479D1C54E94
	for <selinux@archiver.kernel.org>; Tue, 24 Jan 2023 17:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbjAXRO0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Jan 2023 12:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbjAXROZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Jan 2023 12:14:25 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26967458AC
        for <selinux@vger.kernel.org>; Tue, 24 Jan 2023 09:14:23 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id h184so7355008iof.9
        for <selinux@vger.kernel.org>; Tue, 24 Jan 2023 09:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VLXAoy+VMSpKCL3Hup/HJE0uJlr4RTfVEJCBn9VGcpM=;
        b=YxtFNxMB4k6TQvNJe9GQinwYxPGMK4lLWbI9P/vtPiJZQNc085f45pfboDS5DmaCmJ
         2Fuem+DsjTyuxeQ77wF7SKqFXPpduaygsdWMg/lDbx+3dAH73IvKOsSMg0WB/LkxnS9A
         GagK/5naN3NZ/+iGye0GU8bQlw8INJ6dMldY+isJ0wK+LVLQBQBE06+sECfbKI6EPKsh
         IGFwWvSb79DYKohU1XbycdvPOy4gGXDkXD+HIhlUVkZCKtGpQV+Q0ilrrts36wjPLtOH
         5bvXkBmtCbpqFOgP/NYbTZmWcuzksn0UAKOUEuiNdx3ZbY2vplTpeMTejy9CTt52VQ1C
         lH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLXAoy+VMSpKCL3Hup/HJE0uJlr4RTfVEJCBn9VGcpM=;
        b=3aqbCnIub9cmNwWG5d0JMgi6AXQj0nrOeDGlxiCdkZ7ETNiA2an/uzAgtkk8YQxVZt
         D8BqtQjNSdIpHFfET3ipSf5UcdPexkZOZwaaHR90WhPLWqkUJ39W1vzUit1uL+Kzo4rz
         XURJu9CIe+OtUNW8+73r0UVZI2f1x3gdZQJBiLpd8XFO4H7OSP6bbuyMch1+zMh7Q2BX
         8+xaNANXP98aHBKI9eK8Vft0rvpjGVBlvFMJRC89ZZyqmqtTMN4vyMmBBv0Qcryz+Ska
         Fs9lWQ12GGbZ+d0ouEgEV2MVp3aWCz/a8UGu4hyGdz1UsoRBU/jRDIMlQOt1m76XwCGf
         +s2Q==
X-Gm-Message-State: AFqh2kobBWjatYXsW2VVK6wzQSY/iMySwCZea3j0WInpGMzPoPV6sZVV
        eGhqMKGNuov+uQ65FkynUgAwmEkVs7Pz9Rl7Dqk5JA==
X-Google-Smtp-Source: AMrXdXsFvogPFk+a5kaAWAEWgADXq1aR+azC3t6rizt15U0NNDlsRxjQjP0MrZqObwykj6nKUIaW9ctUm5X6ur4QaQ8=
X-Received: by 2002:a02:cc24:0:b0:389:af9:4860 with SMTP id
 o4-20020a02cc24000000b003890af94860mr3221285jap.164.1674580462172; Tue, 24
 Jan 2023 09:14:22 -0800 (PST)
MIME-Version: 1.0
References: <20221221-sockopt-port-range-v6-0-be255cc0e51f@cloudflare.com> <20221221-sockopt-port-range-v6-1-be255cc0e51f@cloudflare.com>
In-Reply-To: <20221221-sockopt-port-range-v6-1-be255cc0e51f@cloudflare.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 24 Jan 2023 18:14:09 +0100
Message-ID: <CANn89iLE-2O8ZJGv+TqrPt+kh-ku8JdkyA4qtR=RKitt7rgrAA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/2] inet: Add IP_LOCAL_PORT_RANGE socket option
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Neal Cardwell <ncardwell@google.com>,
        Leon Romanovsky <leon@kernel.org>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, kernel-team@cloudflare.com,
        Marek Majkowski <marek@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 24, 2023 at 2:36 PM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>
> Users who want to share a single public IP address for outgoing connections
> between several hosts traditionally reach for SNAT. However, SNAT requires
> state keeping on the node(s) performing the NAT.
>
> A stateless alternative exists, where a single IP address used for egress
> can be shared between several hosts by partitioning the available ephemeral
> port range. In such a setup:
>
> [1] https://github.com/cloudflare/cloudflare-blog/blob/232b432c1d57/2022-02-connectx/connectx.py#L116
>
> Reviewed-by: Marek Majkowski <marek@cloudflare.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>
