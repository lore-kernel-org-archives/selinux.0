Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8248BC433E9
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 13:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 444542311A
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 13:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbhAFN2D (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jan 2021 08:28:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38929 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726430AbhAFN2C (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jan 2021 08:28:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609939596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zih4Bfaq/tVIh8oxdOY97CMjx0ttgE9uKFS1bihmBb0=;
        b=YsMS7w9A12o27P1wnjbFGOpiEIH1DQ8yR0e5AWJ3IvoCwQ0HnGngz4h8Ebk5U/P0uiX3/k
        T5Pp1ycNaHkSZuWJWoXuxFpIY+2TuJYFGFBHT8tQ6FWYp77hpT39Z5kdviGAF2xA3NowNk
        h3/adlYaPeGYeu8lCZ0yXehfIb+tPk8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-0S3iigdxPviSX4bErSURoA-1; Wed, 06 Jan 2021 08:26:32 -0500
X-MC-Unique: 0S3iigdxPviSX4bErSURoA-1
Received: by mail-ej1-f69.google.com with SMTP id ov1so1309999ejb.1
        for <selinux@vger.kernel.org>; Wed, 06 Jan 2021 05:26:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zih4Bfaq/tVIh8oxdOY97CMjx0ttgE9uKFS1bihmBb0=;
        b=D7MpyUgziPouOc9nRd++WPNiAU45OKhubuBVmyKSyuPbEBSyAajZzZQT2vinzglgna
         JKbOQiNL3mhGcv4UGSuxSwGAXyffxLZ21s/mbdDYaL7loiwIjc8W5dt45uvo72DaUsA5
         qGSGuEdppROsaOnJqBlcy0DbYEfU4zaQibzmbWSFQWBgq/jUgOc7KbJ1LShsxp60IA7X
         6AKalg25HGhgVEpazueBt0NdUa5ItysfaFXnsSayOpjpc6z53UoBdMqtCCwj6WJIDWbU
         Q15b7zpFZKK/zYnqvxZLpBedmI2El4Z0Ox3aAJlivGYac0ZF9K+FGkApkaKQyrLyK725
         jSww==
X-Gm-Message-State: AOAM530OpFU6zAylecoNsx/LqvY4NfYKZ8Sn6oag1hdsj7UABlHG41ol
        Gp3nOv5OBAhRDK+sVmlSw1lXIdbG+IokLtY5QfM9VkbzOCh90mf71MAm+/elPeP9L9nB19Ib4XQ
        Nb5Uqa4gN5HruT226zFuQONxQEkF38SA47gYXvndiAn00BGWwYDGtQD7nljq7YIrfZcr10Q==
X-Received: by 2002:a50:f392:: with SMTP id g18mr4008717edm.306.1609939591082;
        Wed, 06 Jan 2021 05:26:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzIeEdxpSFApb+WZ3MR7lIvwESJ+4g6sj5pwOpPy5AMvTiS/0wMHJvudZB28kcTc8WImZ63ng==
X-Received: by 2002:a50:f392:: with SMTP id g18mr4008707edm.306.1609939590918;
        Wed, 06 Jan 2021 05:26:30 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id bm12sm1225893ejb.117.2021.01.06.05.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 05:26:30 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 1/5] selinux: remove unused global variables
Date:   Wed,  6 Jan 2021 14:26:18 +0100
Message-Id: <20210106132622.1122033-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210106132622.1122033-1-omosnace@redhat.com>
References: <20210106132622.1122033-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

All of sel_ib_pkey_list, sel_netif_list, sel_netnode_list, and
sel_netport_list are declared but never used. Remove them.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ibpkey.c  | 1 -
 security/selinux/netif.c   | 1 -
 security/selinux/netnode.c | 1 -
 security/selinux/netport.c | 1 -
 4 files changed, 4 deletions(-)

diff --git a/security/selinux/ibpkey.c b/security/selinux/ibpkey.c
index f68a7617cfb95..dbd8fe028b3f2 100644
--- a/security/selinux/ibpkey.c
+++ b/security/selinux/ibpkey.c
@@ -40,7 +40,6 @@ struct sel_ib_pkey {
 	struct rcu_head rcu;
 };
 
-static LIST_HEAD(sel_ib_pkey_list);
 static DEFINE_SPINLOCK(sel_ib_pkey_lock);
 static struct sel_ib_pkey_bkt sel_ib_pkey_hash[SEL_PKEY_HASH_SIZE];
 
diff --git a/security/selinux/netif.c b/security/selinux/netif.c
index 86813b46fad5f..1ab03efe74947 100644
--- a/security/selinux/netif.c
+++ b/security/selinux/netif.c
@@ -36,7 +36,6 @@ struct sel_netif {
 };
 
 static u32 sel_netif_total;
-static LIST_HEAD(sel_netif_list);
 static DEFINE_SPINLOCK(sel_netif_lock);
 static struct list_head sel_netif_hash[SEL_NETIF_HASH_SIZE];
 
diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index 461fb548453ab..4a7d2ab5b9609 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -54,7 +54,6 @@ struct sel_netnode {
  * if this becomes a problem we can always add a hash table for each address
  * family later */
 
-static LIST_HEAD(sel_netnode_list);
 static DEFINE_SPINLOCK(sel_netnode_lock);
 static struct sel_netnode_bkt sel_netnode_hash[SEL_NETNODE_HASH_SIZE];
 
diff --git a/security/selinux/netport.c b/security/selinux/netport.c
index d340f4dcdf5f0..b8bc3897891d9 100644
--- a/security/selinux/netport.c
+++ b/security/selinux/netport.c
@@ -53,7 +53,6 @@ struct sel_netport {
  * if this becomes a problem we can always add a hash table for each address
  * family later */
 
-static LIST_HEAD(sel_netport_list);
 static DEFINE_SPINLOCK(sel_netport_lock);
 static struct sel_netport_bkt sel_netport_hash[SEL_NETPORT_HASH_SIZE];
 
-- 
2.29.2

