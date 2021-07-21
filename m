Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECECC63799
	for <selinux@archiver.kernel.org>; Wed, 21 Jul 2021 16:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC5C561244
	for <selinux@archiver.kernel.org>; Wed, 21 Jul 2021 16:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbhGUQEq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Jul 2021 12:04:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22939 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233471AbhGUQEp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Jul 2021 12:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626885921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DwKCXybqdYJgCEVqcEB3Z+Nt6LD1i2o79n/k3LGtGF8=;
        b=T2cqBOHu+gYwe5X0iC4KEKtF1gZ4P3N4iQd8cOoEnp9EGtDEJrehh0I90r8v4bInojilsA
        sJ6wkBHTSG7cRl8eUBj9BdN0WybWzF1vP9uy/aw+v5TwG9tDvSO2X5AH7ChEkBhtN4ClP0
        abduvm5aW0bkbgVUJo5FCatOM82RoSA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-mBC2ygcBOYuwoiv89_8P-Q-1; Wed, 21 Jul 2021 12:45:18 -0400
X-MC-Unique: mBC2ygcBOYuwoiv89_8P-Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE8F4800D62;
        Wed, 21 Jul 2021 16:45:16 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-219.ams2.redhat.com [10.36.114.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29ED4797C0;
        Wed, 21 Jul 2021 16:45:14 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Florian Westphal <fw@strlen.de>,
        Eric Dumazet <edumazet@google.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: [PATCH RFC 4/9] net: optimize GRO for the common case.
Date:   Wed, 21 Jul 2021 18:44:36 +0200
Message-Id: <7f2f6283a35ffc590eaf6dde88a5848db21ccd3f.1626882513.git.pabeni@redhat.com>
In-Reply-To: <cover.1626882513.git.pabeni@redhat.com>
References: <cover.1626882513.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

After the previous patches, at GRO time, skb->_state is
usually 0, unless the packets comes from some H/W offload
slowpath or tunnel without rx checksum offload.

We can optimize the GRO code assuming !skb->_state is likely.
This remove multiple conditionals in the fast-path, at the
price of an additional one when we hit the above "slow-paths".

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/core/dev.c    | 29 +++++++++++++++++++++--------
 net/core/skbuff.c |  8 +++++---
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 3ee58876e8f5..70c24ed9ca67 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6002,7 +6002,6 @@ static void gro_list_prepare(const struct list_head *head,
 		diffs |= skb_vlan_tag_present(p) ^ skb_vlan_tag_present(skb);
 		if (skb_vlan_tag_present(p))
 			diffs |= skb_vlan_tag_get(p) ^ skb_vlan_tag_get(skb);
-		diffs |= skb_metadata_dst_cmp(p, skb);
 		diffs |= skb_metadata_differs(p, skb);
 		if (maclen == ETH_HLEN)
 			diffs |= compare_ether_header(skb_mac_header(p),
@@ -6012,17 +6011,29 @@ static void gro_list_prepare(const struct list_head *head,
 				       skb_mac_header(skb),
 				       maclen);
 
-		diffs |= skb_get_nfct(p) ^ skb_get_nfct(skb);
+		/* in most common scenarions _state is 0
+		 * otherwise we are already on some slower paths
+		 * either skip all the infrequent tests altogether or
+		 * avoid trying too hard to skip each of them individually
+		 */
+		if (!diffs && unlikely(skb->_state | p->_state)) {
+#if IS_ENABLED(CONFIG_SKB_EXTENSIONS) && IS_ENABLED(CONFIG_NET_TC_SKB_EXT)
+			struct tc_skb_ext *skb_ext;
+			struct tc_skb_ext *p_ext;
+#endif
+
+			diffs |= skb_metadata_dst_cmp(p, skb);
+			diffs |= skb_get_nfct(p) ^ skb_get_nfct(skb);
+
 #if IS_ENABLED(CONFIG_SKB_EXTENSIONS) && IS_ENABLED(CONFIG_NET_TC_SKB_EXT)
-		if (!diffs) {
-			struct tc_skb_ext *skb_ext = skb_ext_find(skb, TC_SKB_EXT);
-			struct tc_skb_ext *p_ext = skb_ext_find(p, TC_SKB_EXT);
+			skb_ext = skb_ext_find(skb, TC_SKB_EXT);
+			p_ext = skb_ext_find(p, TC_SKB_EXT);
 
 			diffs |= (!!p_ext) ^ (!!skb_ext);
 			if (!diffs && unlikely(skb_ext))
 				diffs |= p_ext->chain ^ skb_ext->chain;
-		}
 #endif
+		}
 
 		NAPI_GRO_CB(p)->same_flow = !diffs;
 	}
@@ -6287,8 +6298,10 @@ static void napi_reuse_skb(struct napi_struct *napi, struct sk_buff *skb)
 	skb->encapsulation = 0;
 	skb_shinfo(skb)->gso_type = 0;
 	skb->truesize = SKB_TRUESIZE(skb_end_offset(skb));
-	skb_ext_reset(skb);
-	nf_reset_ct(skb);
+	if (unlikely(skb->_state)) {
+		skb_ext_reset(skb);
+		nf_reset_ct(skb);
+	}
 
 	napi->skb = skb;
 }
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 2ffe18595635..befb49d1a756 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -943,9 +943,11 @@ void __kfree_skb_defer(struct sk_buff *skb)
 
 void napi_skb_free_stolen_head(struct sk_buff *skb)
 {
-	nf_reset_ct(skb);
-	skb_dst_drop(skb);
-	skb_ext_put(skb);
+	if (unlikely(skb->_state)) {
+		nf_reset_ct(skb);
+		skb_dst_drop(skb);
+		skb_ext_put(skb);
+	}
 	napi_skb_cache_put(skb);
 }
 
-- 
2.26.3

