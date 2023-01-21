Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FB7C38141
	for <selinux@archiver.kernel.org>; Sat, 21 Jan 2023 12:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjAUM4e (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 21 Jan 2023 07:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjAUM4d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 21 Jan 2023 07:56:33 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44788457D0
        for <selinux@vger.kernel.org>; Sat, 21 Jan 2023 04:56:29 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ss4so20163227ejb.11
        for <selinux@vger.kernel.org>; Sat, 21 Jan 2023 04:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcrJHPq8Fr7xe+X0sQknOBce+H/yIgTRQbEQbaP8djE=;
        b=jKeKuTEGstIFEr3+jslekqxPT3roeijgWGhHd9qI5PmPtjNM37YTFtzE3EOefKacXA
         C0/lGfcT+nEY9T7zKTFtD6CoVd3hGoLYP7VnIfjOeCSgfz3c2bb1v1Ha15VlqO9BlPPU
         D4mbSHWC6sALMwSWyFDrHY0kc/njSD8lvBNYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qcrJHPq8Fr7xe+X0sQknOBce+H/yIgTRQbEQbaP8djE=;
        b=qjI8aIvL43o/D9iBSQh4pgPedrGPELGb90EPtJPlDgXATBz/DVDF4EirC54e83L5Se
         eS8t62PDhlw10h2uS64ulc6+eZLiqcFlUsj/cd4GXbNaDV8LGi7vkuB+nEDZkedP4/q1
         BIaRkQUjv/a5Z62EPmvFWK99H339mbC8rhNfvEapjvSYwqcwNQ5ikzDGdbuLGRxW1B+1
         05OoAMUyJ0UhIHWYXS9Txs1nCPLfqeROVIdZfCyiq6cJ7U1dqDHhcdVx6/2WE90VKnS1
         UhCzejilnvxSlrUfXzIdliwzcUaY6lwpR/JnvVojmp2jJzm14eEMLYj+iE+Jr40tj9ct
         +xew==
X-Gm-Message-State: AFqh2kpqXQf7d/BswWCGSu5xrJDpPwxcOmM4MHC2hJ/kJuhlo1rmjVTX
        KcripD4tnbx40kZyr/iBpzu/hw==
X-Google-Smtp-Source: AMrXdXsXYvoiRKbFdN/0FLq6IhvlueW1WgnJYNxbn7JDvxi8XtX9NBCU+IQ2wGaeTI8vw2eWg6P0rg==
X-Received: by 2002:a17:906:95d2:b0:7c0:a6a9:64e9 with SMTP id n18-20020a17090695d200b007c0a6a964e9mr19535393ejy.36.1674305787802;
        Sat, 21 Jan 2023 04:56:27 -0800 (PST)
Received: from cloudflare.com (79.191.179.97.ipv4.supernova.orange.pl. [79.191.179.97])
        by smtp.gmail.com with ESMTPSA id kz22-20020a17090777d600b007c1633cea13sm19666901ejc.12.2023.01.21.04.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 04:56:27 -0800 (PST)
References: <20221221-sockopt-port-range-v3-0-36fa5f5996f4@cloudflare.com>
 <CADVnQy=GCiBHDu0PYETh2nbaAeMtCwGgSG00wyJ8ezRgRBbABQ@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 28.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Neal Cardwell <ncardwell@google.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, kernel-team@cloudflare.com
Subject: Re: [PATCH net-next v3 0/2] Add IP_LOCAL_PORT_RANGE socket option
Date:   Sat, 21 Jan 2023 13:45:50 +0100
In-reply-to: <CADVnQy=GCiBHDu0PYETh2nbaAeMtCwGgSG00wyJ8ezRgRBbABQ@mail.gmail.com>
Message-ID: <87cz78xczp.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 20, 2023 at 11:44 AM -05, Neal Cardwell wrote:
> )On Fri, Jan 20, 2023 at 6:53 AM Jakub Sitnicki <jakub@cloudflare.com> wr=
ote:
>>
>> This patch set is a follow up to the "How to share IPv4 addresses by
>> partitioning the port space" talk given at LPC 2022 [1].
>>
>> Please see patch #1 for the motivation & the use case description.
>> Patch #2 adds tests exercising the new option in various scenarios.
>>
>> Documentation
>> -------------
>>
>> Proposed update to the ip(7) man-page:
>>
>>        IP_LOCAL_PORT_RANGE (since Linux X.Y)
>>               Set or get the per-socket default local port range. This
>>               option  can  be used to clamp down the global local port
>>               range, defined by the ip_local_port_range  /proc  inter=E2=
=80=90
>>               face described below, for a given socket.
>>
>>               The option takes an uint32_t value with the high 16 bits
>>               set to the upper range bound, and the low 16 bits set to
>>               the lower range bound. Range bounds are inclusive.
>
> IMHO it would be nice for this text to document whether the port
> numbers are in host order or network order, and perhaps whether "high"
> and "low" here refer to host or network order. Key parts of the
> sockets API express port numbers in network order, but this new API
> seems to express port numbers in host order, so it seem worth (a)
> deciding carefully, and (b) documenting explicitly in the man page
> text (here in the cover letter) and commit message for the patch
> (patch #1).

Good point. Thanks for feedback.

I will expand the description for the man page and the patch #1.

Personally I don't see any upside to using the network byte order here.
With host byte order, users don't need to do anything else but pack the
two u16 values.
