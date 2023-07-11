Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AFCEB64DC
	for <selinux@archiver.kernel.org>; Tue, 11 Jul 2023 13:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjGKNGz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Jul 2023 09:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjGKNGy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Jul 2023 09:06:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA00493
        for <selinux@vger.kernel.org>; Tue, 11 Jul 2023 06:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689080770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=621jpeg8rXw1HoMqyF3Cr2cXzc4xRe3exawPPb/GBlI=;
        b=dNQ0L5yolGdd8UrEMMOE38bjyiLAijGO3EWQzs3rmFAcC7D4M54Fwg5CA2T3a1C107Ak6/
        n6huyjmfQoaPXFKwwo8Vng06yZq/aGBOIcztImtkYpzrcsgc1wUQ07iMnZc80rcuX9fjjh
        qpj9zQ3qp9qVySVv3d4DLJ9Gi0nZW84=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81--UYgiII6Omq28PU8WOlJOw-1; Tue, 11 Jul 2023 09:06:09 -0400
X-MC-Unique: -UYgiII6Omq28PU8WOlJOw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7675fc3333eso389786085a.0
        for <selinux@vger.kernel.org>; Tue, 11 Jul 2023 06:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689080768; x=1691672768;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=621jpeg8rXw1HoMqyF3Cr2cXzc4xRe3exawPPb/GBlI=;
        b=dXf94PnrCFIk89imJoHM6vGjBy8jToYsISNoiDsUgLZk+gXrhZ3HxHqHWxZD7A8GNj
         9doJWQO35ZSYLppl24wBAG7t0n+IHr0lOyDfeX3hr/zONnE+zQ09xXViYpxtZ3W6bKJJ
         5ZHDPtBlvNTzne7ps2ywT7fZQqmpm8WjguUcyGTSws4KRstiJFnfYI0v51J2kL2i8fBk
         cW9PO6GRQezVM9c8GWYixXdKfvPZRs93hqgFy5OSRFxN9iNwT7zdvjPeTUevc9gIFA3p
         V+nlVG67jhU2SuCE9zX/UQ1VhkH863NdRNM+uOGwJBZO6eQQsRUs7rPez7sHFjEnDPO5
         NTPQ==
X-Gm-Message-State: ABy/qLbQ83S1Q2BzQnJiwO1ZHcCQrapRwCUcCoPJU6tiz/VBNngyQjtY
        y1JvjRtpTqab+Gu3ZkVyqM3OXgx0hrSOv9yAYWPBXDXCZcYswGHG1IMhPIzxC9pAVcZZ9K9iLUu
        Do5zaHIt4jNzaNhJffQ==
X-Received: by 2002:a05:620a:2a08:b0:765:734b:1792 with SMTP id o8-20020a05620a2a0800b00765734b1792mr23405412qkp.23.1689080768677;
        Tue, 11 Jul 2023 06:06:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGKsAEoYjCuBe/RLC+s8vVfCSnBTIjmYs9lUXherbrMHdd/xt8k/DuInjKGuiKn/ST+FGm8LA==
X-Received: by 2002:a05:620a:2a08:b0:765:734b:1792 with SMTP id o8-20020a05620a2a0800b00765734b1792mr23405385qkp.23.1689080768414;
        Tue, 11 Jul 2023 06:06:08 -0700 (PDT)
Received: from debian ([92.62.32.42])
        by smtp.gmail.com with ESMTPSA id g6-20020ae9e106000000b00767dc4c539bsm970048qkm.44.2023.07.11.06.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 06:06:07 -0700 (PDT)
Date:   Tue, 11 Jul 2023 15:06:00 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     netdev@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        David Ahern <dsahern@kernel.org>, Dmitry Kozlov <xeb@mail.ru>
Subject: [PATCH net-next 0/4] net: Mark the sk parameter of routing functions
 as 'const'.
Message-ID: <cover.1689077819.git.gnault@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The sk_getsecid security hook prevents the use of a const sk pointer in
several routing functions. Since this hook should only read sk data,
make its sk argument const (patch 1), then constify the sk parameter of
various routing functions (patches 2-4).

Build-tested with make allmodconfig.

Guillaume Nault (4):
  security: Constify sk in the sk_getsecid hook.
  ipv4: Constify the sk parameter of ip_route_output_*().
  ipv6: Constify the sk parameter of several helper functions.
  pptp: Constify the po parameter of pptp_route_output().

 drivers/net/ppp/pptp.c        |  4 ++--
 include/linux/icmpv6.h        | 10 ++++------
 include/linux/lsm_hook_defs.h |  2 +-
 include/linux/security.h      |  5 +++--
 include/net/route.h           |  6 +++---
 net/ipv6/datagram.c           |  7 ++++---
 net/ipv6/icmp.c               |  6 ++----
 net/ipv6/mcast.c              |  8 +++-----
 security/security.c           |  2 +-
 security/selinux/hooks.c      |  4 ++--
 10 files changed, 25 insertions(+), 29 deletions(-)

-- 
2.39.2

