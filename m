Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B924BC3B1A9
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 17:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9254824649
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 17:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581700239;
	bh=gJ6PYiOZ9tjx/ZCthQTxYJAlsb/bFGZPBzlT3GvKWrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SUv7DWAmq7XHc1TMOrDYIMsr5MHk0tzaVBLUGnxI/SQY0L1duo8wDDEoGbRwJlza6
	 ZJgdWVyHn+QEVjlbgqGWM7KrMGNdfAXtZgdjBD2Uu6QBzCGx55tBPtT9IKrUWvfQZ9
	 GleFrrwxFc6ha3pOPUJ/Vh/b7O/dw5zJjipAxTWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392196AbgBNQNh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:13:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:42340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390803AbgBNQNh (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 14 Feb 2020 11:13:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1B86246C0;
        Fri, 14 Feb 2020 16:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696816;
        bh=gJ6PYiOZ9tjx/ZCthQTxYJAlsb/bFGZPBzlT3GvKWrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KkaASNu06FbddyDo2k9fBEWLklmpRH6ETRJDycRh975gRH8VbDuyHeBC95RxIIW5N
         16/y4YpVX57LFuAEvT8zj7aQZDzjJP4B0AaQVSLCXMbiAiHB3zux2pv4pVJ+Wvso6L
         xprNfIltoJhs3bXxlEMDjMwIEERvtgo2tzoZP5BA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>, rsiddoji@codeaurora.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Sasha Levin <sashal@kernel.org>, selinux@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 085/252] selinux: ensure we cleanup the internal AVC counters on error in avc_insert()
Date:   Fri, 14 Feb 2020 11:09:00 -0500
Message-Id: <20200214161147.15842-85-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Paul Moore <paul@paul-moore.com>

[ Upstream commit d8db60cb23e49a92cf8cada3297395c7fa50fdf8 ]

Fix avc_insert() to call avc_node_kill() if we've already allocated
an AVC node and the code fails to insert the node in the cache.

Fixes: fa1aa143ac4a ("selinux: extended permissions for ioctls")
Reported-by: rsiddoji@codeaurora.org
Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/avc.c | 51 ++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 0622cae510461..83eef39c8a799 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -689,40 +689,37 @@ static struct avc_node *avc_insert(struct selinux_avc *avc,
 	struct avc_node *pos, *node = NULL;
 	int hvalue;
 	unsigned long flag;
+	spinlock_t *lock;
+	struct hlist_head *head;
 
 	if (avc_latest_notif_update(avc, avd->seqno, 1))
-		goto out;
+		return NULL;
 
 	node = avc_alloc_node(avc);
-	if (node) {
-		struct hlist_head *head;
-		spinlock_t *lock;
-		int rc = 0;
-
-		hvalue = avc_hash(ssid, tsid, tclass);
-		avc_node_populate(node, ssid, tsid, tclass, avd);
-		rc = avc_xperms_populate(node, xp_node);
-		if (rc) {
-			kmem_cache_free(avc_node_cachep, node);
-			return NULL;
-		}
-		head = &avc->avc_cache.slots[hvalue];
-		lock = &avc->avc_cache.slots_lock[hvalue];
+	if (!node)
+		return NULL;
 
-		spin_lock_irqsave(lock, flag);
-		hlist_for_each_entry(pos, head, list) {
-			if (pos->ae.ssid == ssid &&
-			    pos->ae.tsid == tsid &&
-			    pos->ae.tclass == tclass) {
-				avc_node_replace(avc, node, pos);
-				goto found;
-			}
+	avc_node_populate(node, ssid, tsid, tclass, avd);
+	if (avc_xperms_populate(node, xp_node)) {
+		avc_node_kill(avc, node);
+		return NULL;
+	}
+
+	hvalue = avc_hash(ssid, tsid, tclass);
+	head = &avc->avc_cache.slots[hvalue];
+	lock = &avc->avc_cache.slots_lock[hvalue];
+	spin_lock_irqsave(lock, flag);
+	hlist_for_each_entry(pos, head, list) {
+		if (pos->ae.ssid == ssid &&
+			pos->ae.tsid == tsid &&
+			pos->ae.tclass == tclass) {
+			avc_node_replace(avc, node, pos);
+			goto found;
 		}
-		hlist_add_head_rcu(&node->list, head);
-found:
-		spin_unlock_irqrestore(lock, flag);
 	}
-out:
+	hlist_add_head_rcu(&node->list, head);
+found:
+	spin_unlock_irqrestore(lock, flag);
 	return node;
 }
 
-- 
2.20.1

