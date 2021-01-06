Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFAFC43381
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 13:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 642572311C
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 13:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbhAFN2F (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jan 2021 08:28:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24471 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726449AbhAFN2D (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jan 2021 08:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609939597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gUXpnHMB5BQWXnJYebKzDvEArZh3kRKXO9Yn4rzEv8g=;
        b=BEbOqrrzeOAIr+yLOS6iDgF73osrQ+7cTU3MXrGspxEJ2L+rRFCkVsXb5vwOyzo4WumEIG
        XIG1MNevhUCcXU/+dXYZZtVvoNO91sfTVY79zIM4llsMopIYZXbpqYwM1Wg/BnnKyYrkn0
        1n4KAoOaDBG+fe3SeOvMOmMogxp4kBI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-u0bHsy_9NOmfLPl4VZjbYA-1; Wed, 06 Jan 2021 08:26:35 -0500
X-MC-Unique: u0bHsy_9NOmfLPl4VZjbYA-1
Received: by mail-ed1-f70.google.com with SMTP id h5so1927143edq.3
        for <selinux@vger.kernel.org>; Wed, 06 Jan 2021 05:26:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gUXpnHMB5BQWXnJYebKzDvEArZh3kRKXO9Yn4rzEv8g=;
        b=loiKi6MJES5TEsUay2o4j7tzIgDwu28DIZZGUUsEtE13OyaxgsMCwGqhzxPY/R/pSY
         74iw3KM6o047h4j6aM0CYCFaQK5rVNyHZpsJxEtp60SZoYGDWucmBJh5LlgkzBF7xD+k
         HiDhNbZ7AhZHc2MWGB9sXTNnuboZrIiWt3LZL5YZkc3UnFr2kIWzxfWNXAzYTr5O8iDp
         LiiJodbfBswIkU+DGAawYY1/fw42JFV2KHzyFvMiNYyjExH5gNZ2w+tsI0kIBdYgZQ+A
         eJNsrVlwUKVlydWevTiYiQ0i8KMfTtj1oE+uat2k8c5ZE/FXkctQw6UHD1J7ZpwyCcZ1
         +Kuw==
X-Gm-Message-State: AOAM5337Qh3XFwGI5+loYpOaLMp2YEF5JQGn+8WYuvC21EZyzEIHbHvh
        X9C+4KFULvcnIMA5ObU5wMY1Fb6p7miix34uBnDVrY9ez98urM74Iaf8x0J0fTaq1ZkYx+C8fGK
        6rMyP2nUuN54L0pKrK7QVvVcRxrSrfiDjYVHntMRoYJ29+G5hMp2O4g5lueduN73DHmjtFQ==
X-Received: by 2002:a50:ce13:: with SMTP id y19mr3932258edi.241.1609939594008;
        Wed, 06 Jan 2021 05:26:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwUTwu3C5lccobb7OINbVazRCPaRAl4cAYZx1N3eE86k8tLEoOIq809yWAp4rVodNLlJr38bw==
X-Received: by 2002:a50:ce13:: with SMTP id y19mr3932239edi.241.1609939593662;
        Wed, 06 Jan 2021 05:26:33 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id bm12sm1225893ejb.117.2021.01.06.05.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 05:26:32 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 4/5] selinux: mark some global variables __ro_after_init
Date:   Wed,  6 Jan 2021 14:26:21 +0100
Message-Id: <20210106132622.1122033-5-omosnace@redhat.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210106132622.1122033-1-omosnace@redhat.com>
References: <20210106132622.1122033-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

All of these are never modified outside initcalls, so they can be
__ro_after_init.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/avc.c        | 10 +++++-----
 security/selinux/netlink.c    |  2 +-
 security/selinux/selinuxfs.c  |  4 ++--
 security/selinux/ss/avtab.c   |  4 ++--
 security/selinux/ss/ebitmap.c |  2 +-
 security/selinux/ss/hashtab.c |  2 +-
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 3c05827608b6a..ad451cf9375e4 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -118,11 +118,11 @@ void avc_set_cache_threshold(struct selinux_avc *avc,
 	avc->avc_cache_threshold = cache_threshold;
 }
 
-static struct avc_callback_node *avc_callbacks;
-static struct kmem_cache *avc_node_cachep;
-static struct kmem_cache *avc_xperms_data_cachep;
-static struct kmem_cache *avc_xperms_decision_cachep;
-static struct kmem_cache *avc_xperms_cachep;
+static struct avc_callback_node *avc_callbacks __ro_after_init;
+static struct kmem_cache *avc_node_cachep __ro_after_init;
+static struct kmem_cache *avc_xperms_data_cachep __ro_after_init;
+static struct kmem_cache *avc_xperms_decision_cachep __ro_after_init;
+static struct kmem_cache *avc_xperms_cachep __ro_after_init;
 
 static inline int avc_hash(u32 ssid, u32 tsid, u16 tclass)
 {
diff --git a/security/selinux/netlink.c b/security/selinux/netlink.c
index 621e2e9cd6a1d..1760aee712fd2 100644
--- a/security/selinux/netlink.c
+++ b/security/selinux/netlink.c
@@ -19,7 +19,7 @@
 
 #include "security.h"
 
-static struct sock *selnl;
+static struct sock *selnl __ro_after_init;
 
 static int selnl_msglen(int msgtype)
 {
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 4fdfe7b67df89..01a7d50ed39b8 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -2204,8 +2204,8 @@ static struct file_system_type sel_fs_type = {
 	.kill_sb	= sel_kill_sb,
 };
 
-static struct vfsmount *selinuxfs_mount;
-struct path selinux_null;
+static struct vfsmount *selinuxfs_mount __ro_after_init;
+struct path selinux_null __ro_after_init;
 
 static int __init init_sel_fs(void)
 {
diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 0172d87e2b9ae..6dcb6aa4db7f0 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -23,8 +23,8 @@
 #include "avtab.h"
 #include "policydb.h"
 
-static struct kmem_cache *avtab_node_cachep;
-static struct kmem_cache *avtab_xperms_cachep;
+static struct kmem_cache *avtab_node_cachep __ro_after_init;
+static struct kmem_cache *avtab_xperms_cachep __ro_after_init;
 
 /* Based on MurmurHash3, written by Austin Appleby and placed in the
  * public domain.
diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index 14bedc95c6dcf..61fcbb8d0f880 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -26,7 +26,7 @@
 
 #define BITS_PER_U64	(sizeof(u64) * 8)
 
-static struct kmem_cache *ebitmap_node_cachep;
+static struct kmem_cache *ebitmap_node_cachep __ro_after_init;
 
 int ebitmap_cmp(struct ebitmap *e1, struct ebitmap *e2)
 {
diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index dab8c25c739b9..3881787ce492c 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -9,7 +9,7 @@
 #include <linux/errno.h>
 #include "hashtab.h"
 
-static struct kmem_cache *hashtab_node_cachep;
+static struct kmem_cache *hashtab_node_cachep __ro_after_init;
 
 /*
  * Here we simply round the number of elements up to the nearest power of two.
-- 
2.29.2

