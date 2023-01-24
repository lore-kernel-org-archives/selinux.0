Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B9AC25B4E
	for <selinux@archiver.kernel.org>; Tue, 24 Jan 2023 13:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbjAXNg7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Jan 2023 08:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbjAXNg6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Jan 2023 08:36:58 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3707EFD
        for <selinux@vger.kernel.org>; Tue, 24 Jan 2023 05:36:56 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id mg12so39058393ejc.5
        for <selinux@vger.kernel.org>; Tue, 24 Jan 2023 05:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iJx2oHY5c3NhrquING4a36Em8fROKAOPADpsDJm1ULc=;
        b=xbevSRhpETt9GCfkJeXR5wBZTf05QiEs5SWLhpli7Qi9NqDDzrX5T+N8ECO2Rcbsve
         bwwNbkAuxwDuCU3rc5ItMXV/0lD50VibDwbv97Dqb7rEFtxuL6bvip/d0FkpmA7dfEyD
         09jPRH7AILZOcbF1I5aI+a0QbiNmddxpos4eM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iJx2oHY5c3NhrquING4a36Em8fROKAOPADpsDJm1ULc=;
        b=K8A4ZtqOQ9E0Yo0zbxQKoTrK6x3z9X2FthUnjqeaJJZ7SECqyeoIAhBPKDK1lxHvCM
         48N8NU61ZVkcwJdfEEnI1ZCD8cCfCWmz8+iB1nuCiyCxEql2kWd5SYWhsQOp+ChsaLuU
         318o1IdbMc1KFdejxlQYosspebWq7t8q32v4udb6o0uib5mZIaLdXpOA3YMfuhWtUNWK
         i4wZmYkLczxDci8D/UXjVsn7HtFDmhymm6IKEO49LIgugMNkzSk3wpungjZBQuxZ6ZeJ
         geYe5H+pYv0nZErPH4GLj7n5scLO4Q3S5t4xK8GVn7IbG2ycWt0pAZCeo+1PrYROZHQ+
         Jydw==
X-Gm-Message-State: AFqh2krhJAb2IDcyMO/6NV+vLO7TiTltT9iHIfI0TDLzMPisc1yrcZa2
        EUQqB1BWsOS+cTfrKqjJqfv0fQ==
X-Google-Smtp-Source: AMrXdXvbDWKI+8A5cf6ndN6ot9x2CFIQKm9DHqDXn3YadlKw5gCNz9CFAZ/xRsRDdluOs2MHYveceg==
X-Received: by 2002:a17:907:c5c6:b0:877:8a55:2a26 with SMTP id ts6-20020a170907c5c600b008778a552a26mr18420407ejc.60.1674567414992;
        Tue, 24 Jan 2023 05:36:54 -0800 (PST)
Received: from cloudflare.com (79.184.123.123.ipv4.supernova.orange.pl. [79.184.123.123])
        by smtp.gmail.com with ESMTPSA id ks27-20020a170906f85b00b0085fc3dec567sm920021ejb.175.2023.01.24.05.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 05:36:54 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH net-next v6 0/2] Add IP_LOCAL_PORT_RANGE socket option
Date:   Tue, 24 Jan 2023 14:36:43 +0100
Message-Id: <20221221-sockopt-port-range-v6-0-be255cc0e51f@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOvez2MC/4XOwW7DIAwG4FepOI8JHCDLTnuPaYcA9oKWhQjSq
 FWVd6+V66JF8sX+8WceomJJWMX75SEKrqmmPHHjXi4iDP30jTJF7gUoAM0law4/eV7knMsiy/4C
 tYGIrVJkouBF31eUnrMw8Op0HUcezgUp3fZLn2LCRU54W8QXJ0OqSy73/Qur3vP/rq1aKongVWe
 8U0TxI4z5GmnsC76G/LubK5w7wI6OlrQ2nhy0h05z7jTsNI56S7brHJlDx5w7hp3YRiCwTkPzdu
 jYc8ey05GHoFQfoWv+ONu2PQHeUQan+AEAAA==
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Neal Cardwell <ncardwell@google.com>,
        Leon Romanovsky <leon@kernel.org>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, kernel-team@cloudflare.com,
        Marek Majkowski <marek@cloudflare.com>
X-Mailer: b4 0.11.0
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
              Set or get the per-socket default local  port  range.  This
              option  can  be  used  to  clamp down the global local port
              range, defined by the ip_local_port_range  /proc  interface
              described below, for a given socket.

              The  option  takes  an uint32_t value with the high 16 bits
              set to the upper range bound, and the low 16  bits  set  to
              the  lower  range  bound.  Range  bounds are inclusive. The
              16-bit values should be in host byte order.

              The lower bound has to be less than the  upper  bound  when
              both  bounds  are  not  zero. Otherwise, setting the option
              fails with EINVAL.

              If either bound is outside of the global local port  range,
              or is zero, then that bound has no effect.

              To  reset  the setting, pass zero as both the upper and the
              lower bound.

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

v5 -> v6:
v5: https://lore.kernel.org/r/20221221-sockopt-port-range-v5-0-9fb2c00ad293@cloudflare.com

 * Move changelog in individual patches below the trailer. (Leon)

v4 -> v5:
v4: https://lore.kernel.org/r/20221221-sockopt-port-range-v4-0-d7d2f2561238@cloudflare.com

 * Code changes called out in individual patches.

v3 -> v4:
v3: https://lore.kernel.org/r/20221221-sockopt-port-range-v3-0-36fa5f5996f4@cloudflare.com

 * Highlight that port bounds should be in host byte order. (Neal)

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
Cc: Neal Cardwell <ncardwell@google.com>
Cc: Leon Romanovsky <leon@kernel.org>
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
