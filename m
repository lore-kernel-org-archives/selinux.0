Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770B8C05027
	for <selinux@archiver.kernel.org>; Fri, 20 Jan 2023 16:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjATQpK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Jan 2023 11:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjATQpJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Jan 2023 11:45:09 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2452CDF5
        for <selinux@vger.kernel.org>; Fri, 20 Jan 2023 08:45:04 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id m17so1486896uap.7
        for <selinux@vger.kernel.org>; Fri, 20 Jan 2023 08:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boZ0dqIpKAH785rpqEYhFf53N8uHdCYZGulaRtCPwlg=;
        b=TVQaI7HiHCVIlj6zEGYEbXX+XKuoYNwYTOjzlPportjxZHOiU8e5jpWfQxleHEBVB5
         632Ngvuxn8DoeTwBHIPaWkPqRF0Iq4Eu4DjeOfVczVi693CAaxS8LSWFc+ERadDDNtgG
         jE14vqARySpLV9TPULDCx8yp1gwGWL6WOHhVxE+lROv5gCYao17Th9jX+BrQ3tcWCLm3
         m1zcBYJ8HZ0sNauOQprbj0e+V8FPRz3wiN8WtLCiFfpBzIhwCjg++r6eKwHMe5HBtWZr
         eOLB/aQ1R6IjPzQH1KYR88Ogs5bZix2WxQC66BV5fbtpz2JB6jleb/sQMPH+yBdrPZY+
         T+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boZ0dqIpKAH785rpqEYhFf53N8uHdCYZGulaRtCPwlg=;
        b=OUVRnuxRHj7dmqDdU7NVWpUqLR1PRjSeUdauwcF88spZsjPNvlZ10H/l1XHPjfWORu
         CYaNui128WCrEnwCw8mt2WwmgJXdmVIwAnhaRnxFkgpJ9gyRLXTyNB69lN9WaIOMxtfe
         mgfNPCMu8y8Y5XN2b3NG5OG8msjE3NxRkxrofQnaaskNcw6nSGo4o4ZCCc4o2nueVJnR
         t0wKjEZ4RHgw3BIAR73eJPSp7SlGhc8Pp45LNQwqOQ9Qk4+2C2y49dpGlLFyP9EuqkL1
         F8Zsbeo7pxccXhBgPRAz9zMAcZ8DIqFlQ6umxfseP4XSMir799+T4g2FDP91huSC0mER
         eIXw==
X-Gm-Message-State: AFqh2koMiUHWoKO5hWUfZKwgKj/RS52n1N/JMbR5eOyycqMahtMtJPIt
        K0XeesECS63ruQOHks3Lgp6MwZ87TLgUiBw5tPYHPA==
X-Google-Smtp-Source: AMrXdXtdwU7/czYs54x51aVYHuClvYtp579EFc9KBin2CLEyM75ufjP4aaw03DcsrfcymIFQkppReTzHyVcdsmzZNFE=
X-Received: by 2002:ab0:6c54:0:b0:424:e8b8:7bcb with SMTP id
 q20-20020ab06c54000000b00424e8b87bcbmr1985318uas.123.1674233103918; Fri, 20
 Jan 2023 08:45:03 -0800 (PST)
MIME-Version: 1.0
References: <20221221-sockopt-port-range-v3-0-36fa5f5996f4@cloudflare.com>
In-Reply-To: <20221221-sockopt-port-range-v3-0-36fa5f5996f4@cloudflare.com>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Fri, 20 Jan 2023 11:44:47 -0500
Message-ID: <CADVnQy=GCiBHDu0PYETh2nbaAeMtCwGgSG00wyJ8ezRgRBbABQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/2] Add IP_LOCAL_PORT_RANGE socket option
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

)On Fri, Jan 20, 2023 at 6:53 AM Jakub Sitnicki <jakub@cloudflare.com> wrot=
e:
>
> This patch set is a follow up to the "How to share IPv4 addresses by
> partitioning the port space" talk given at LPC 2022 [1].
>
> Please see patch #1 for the motivation & the use case description.
> Patch #2 adds tests exercising the new option in various scenarios.
>
> Documentation
> -------------
>
> Proposed update to the ip(7) man-page:
>
>        IP_LOCAL_PORT_RANGE (since Linux X.Y)
>               Set or get the per-socket default local port range. This
>               option  can  be used to clamp down the global local port
>               range, defined by the ip_local_port_range  /proc  inter=E2=
=80=90
>               face described below, for a given socket.
>
>               The option takes an uint32_t value with the high 16 bits
>               set to the upper range bound, and the low 16 bits set to
>               the lower range bound. Range bounds are inclusive.

IMHO it would be nice for this text to document whether the port
numbers are in host order or network order, and perhaps whether "high"
and "low" here refer to host or network order. Key parts of the
sockets API express port numbers in network order, but this new API
seems to express port numbers in host order, so it seem worth (a)
deciding carefully, and (b) documenting explicitly in the man page
text (here in the cover letter) and commit message for the patch
(patch #1).

thanks,
neal
