Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BABAC25B4E
	for <selinux@archiver.kernel.org>; Fri, 20 Jan 2023 11:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjATLxZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Jan 2023 06:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjATLxZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Jan 2023 06:53:25 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207E2AD11
        for <selinux@vger.kernel.org>; Fri, 20 Jan 2023 03:53:22 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ud5so13344942ejc.4
        for <selinux@vger.kernel.org>; Fri, 20 Jan 2023 03:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rpWakQkNl2X83ZDSFDtOePv8LZ3+OGN0sQNegwXf+fw=;
        b=O/htdtOuuHtCan/kVw5B4t38wB+NaHeP/kd5FAvTjpXYFx6Qlw2RTCkBLsX4c/cY8B
         CkL0HVf5qUQIO+z9Y6b9D3iHOO7wRV9Z1DdkMLpUgVPOcdk16i8DrwFUhb6NGzN6HimI
         2mTECbkjbWA1/hncHiKvqr9+FrqbyGjwPjg1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rpWakQkNl2X83ZDSFDtOePv8LZ3+OGN0sQNegwXf+fw=;
        b=dkrqo9S94CJgQVBB7WFeyiBF03eVPHuUVNISDBmNuzSs+f/xbodHgf+lb2BS0/N32y
         IKtQrg4VW7uhG/Jn9wDOn5vOVqRYCe0vXeWfEVMAclTIulJ9zo5IoDFbVLHas/GBHJyL
         GfjMojhagacEiW/EzlUfFIvcKw8s81eR4rYE32qljC8Kd9aeyxEv1+0A3zRk1G8Gesaf
         mIOG78F+8F37e2btlzKCEpD3jf7rKZ1MaN8FF7Wj8O8sG8IlFg2S9Ukw4Wr3fjawuC7o
         lbdqlyhf9/cR6vbs94p0YaV8ZxAhhQK+UD3Ne0uMLOvoKqrjJ6DwBJzUoh9ajVEHAxAG
         p28w==
X-Gm-Message-State: AFqh2ko1BDj0xoNjCb7IUt/s1FhidIpn1q3lppZMDBkek9SWO62c/8oW
        WmkExke+2XHdP6C6ErKpwNSmqw==
X-Google-Smtp-Source: AMrXdXv+LEseIiGX+tf3vc8xwcOSx017Ruz9WQ6H3vgtG5F7dVMXdp7YQpzckS60cBXWOejsrSlesA==
X-Received: by 2002:a17:906:7e58:b0:84d:45d9:6bcf with SMTP id z24-20020a1709067e5800b0084d45d96bcfmr14912685ejr.42.1674215600589;
        Fri, 20 Jan 2023 03:53:20 -0800 (PST)
Received: from cloudflare.com (79.191.179.97.ipv4.supernova.orange.pl. [79.191.179.97])
        by smtp.gmail.com with ESMTPSA id m15-20020aa7c48f000000b0049dc0123f29sm8408427edq.61.2023.01.20.03.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 03:53:20 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, kernel-team@cloudflare.com
Subject: [PATCH net-next v3 0/2] Add IP_LOCAL_PORT_RANGE socket option
Date:   Fri, 20 Jan 2023 12:53:17 +0100
Message-Id: <20221221-sockopt-port-range-v3-0-36fa5f5996f4@cloudflare.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch set is a follow up to the "How to share IPv4 addresses by
partitioning the port space" talk given at LPC 2022 [1].

Please see patch #1 for the motivation & the use case description.
Patch #2 adds tests exercising the new option in various scenarios.

Documentation
-------------

Proposed update to the ip(7) man-page:

       IP_LOCAL_PORT_RANGE (since Linux X.Y)
              Set or get the per-socket default local port range. This
              option  can  be used to clamp down the global local port
              range, defined by the ip_local_port_range  /proc  inter‐
              face described below, for a given socket.

              The option takes an uint32_t value with the high 16 bits
              set to the upper range bound, and the low 16 bits set to
              the lower range bound. Range bounds are inclusive.

              The lower bound has to be less than the upper bound when
              both bounds are not zero. Otherwise, setting the  option
              fails with EINVAL.

              If  either  bound  is  outside  of the global local port
              range, or is zero, then that bound has no effect.

              To reset the setting, pass zero as both  the  upper  and
              the lower bound.

Interaction with SELinux bind() hook
------------------------------------

SELinux bind() hook - selinux_socket_bind() - performs a permission check
if the requested local port number lies outside of the netns ephemeral port
range.

The proposed socket option cannot be used change the ephemeral port range
to extend beyond the per-netns port range, as set by
net.ipv4.ip_local_port_range.

Hence, there is no interaction with SELinux, AFAICT.
	      
Changelog:
---------

v2 -> v3:
v2: https://lore.kernel.org/r/20221221-sockopt-port-range-v2-0-1d5f114bf627@cloudflare.com

 * Describe interaction considerations with SELinux.
 * Code changes called out in individual patches.

v1 -> v2:
v1: https://lore.kernel.org/netdev/20221221-sockopt-port-range-v1-0-e2b094b60ffd@cloudflare.com/

 * Fix the corner case when the per-socket range doesn't overlap with the
   per-netns range. Fallback correctly to the per-netns range. (Kuniyuki)

 * selftests: Instead of iterating over socket families (ip4, ip6) and types
   (tcp, udp), generate tests for each combo from a template. This keeps the
   code indentation level down and makes tests more granular.

 * Rewrite man-page prose:
   - explain how to unset the option,
   - document when EINVAL is returned.

RFC -> v1
RFC: https://lore.kernel.org/netdev/20220912225308.93659-1-jakub@cloudflare.com/

 * Allow either the high bound or the low bound, or both, to be zero
 * Add getsockopt support
 * Add selftests

Links:
------

[1]: https://lpc.events/event/16/contributions/1349/

To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Eric Paris <eparis@parisplace.org>
Cc: kernel-team@cloudflare.com
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>

---
Jakub Sitnicki (2):
      inet: Add IP_LOCAL_PORT_RANGE socket option
      selftests/net: Cover the IP_LOCAL_PORT_RANGE socket option

 include/net/inet_sock.h                            |   4 +
 include/net/ip.h                                   |   3 +-
 include/uapi/linux/in.h                            |   1 +
 net/ipv4/inet_connection_sock.c                    |  25 +-
 net/ipv4/inet_hashtables.c                         |   2 +-
 net/ipv4/ip_sockglue.c                             |  18 +
 net/ipv4/udp.c                                     |   2 +-
 net/sctp/socket.c                                  |   2 +-
 tools/testing/selftests/net/Makefile               |   2 +
 tools/testing/selftests/net/ip_local_port_range.c  | 447 +++++++++++++++++++++
 tools/testing/selftests/net/ip_local_port_range.sh |   5 +
 11 files changed, 505 insertions(+), 6 deletions(-)
---
base-commit: 147c50ac3a4ea4f5ddbcf064e1adcf3aa7e6aa11
change-id: 20221221-sockopt-port-range-e142de700f4d

Best regards,
-- 
Jakub Sitnicki <jakub@cloudflare.com>
