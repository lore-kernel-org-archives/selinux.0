Return-Path: <SRS0=SKFz=ZL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E23C432C0
	for <selinux@archiver.kernel.org>; Tue, 19 Nov 2019 18:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C27223E4
	for <selinux@archiver.kernel.org>; Tue, 19 Nov 2019 18:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574188874;
	bh=ID5i6LVxAXJWLxbt0faGOihxGx2WttitYMxA2sPDKsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1s41y0pFAqi4Bnk9XSd5W6hIhliBpv0EUeZoTgp5qi7jVkO6D1EsYzy6jArtgKLRI
	 NfPSHEk093lybJknmz3vNNC68beJyzd4aWa4kzdiVbGexiyBn3M14kwqJCpcvQwj3H
	 2Z2esu2wolhKIkRDsM+3Zj2wul6ARzQBgWK+D06A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfKSSlG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Nov 2019 13:41:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbfKSSlF (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 19 Nov 2019 13:41:05 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FCEF2240B;
        Tue, 19 Nov 2019 18:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574188864;
        bh=ID5i6LVxAXJWLxbt0faGOihxGx2WttitYMxA2sPDKsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qQeCmPx7uvR5TXjLvO7hl3dDLVDJuANdiapoBJXvEorZvmmemwQ1gwz7fDtcYWOFE
         LguQTyU5XUPAOyclY6HGobwDxqVnAgqEwpEH7X539g6d2bxf16aacY1YSLQwNaaRY6
         SnmG7fnRc750oLaOnarXXwH/xG4CXev6Q8uU5VtM=
From:   Will Deacon <will@kernel.org>
To:     selinux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>
Subject: [RFC PATCH 1/2] selinux: Don't call avc_compute_av() from RCU path walk
Date:   Tue, 19 Nov 2019 18:40:56 +0000
Message-Id: <20191119184057.14961-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191119184057.14961-1-will@kernel.org>
References: <20191119184057.14961-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

'avc_compute_av()' can block, so we carefully exit the RCU read-side
critical section before calling it in 'avc_has_perm_noaudit()'.
Unfortunately, if we're calling from the VFS layer on the RCU path walk
via 'selinux_inode_permission()' then we're still actually in an RCU
read-side critical section and must not block.

'avc_denied()' already handles this by simply returning success and
postponing the auditing until we're called again on the slowpath, so
follow the same approach here and return early if the node lookup fails
on the RCU walk path.

Signed-off-by: Will Deacon <will@kernel.org>
---
 security/selinux/avc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index ecd3829996aa..9c183c899e92 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1159,16 +1159,19 @@ inline int avc_has_perm_noaudit(struct selinux_state *state,
 	rcu_read_lock();
 
 	node = avc_lookup(state->avc, ssid, tsid, tclass);
-	if (unlikely(!node))
+	if (unlikely(!node)) {
+		if (flags & AVC_NONBLOCKING)
+			goto out;
 		node = avc_compute_av(state, ssid, tsid, tclass, avd, &xp_node);
-	else
+	} else {
 		memcpy(avd, &node->ae.avd, sizeof(*avd));
+	}
 
 	denied = requested & ~(avd->allowed);
 	if (unlikely(denied))
 		rc = avc_denied(state, ssid, tsid, tclass, requested, 0, 0,
 				flags, avd);
-
+out:
 	rcu_read_unlock();
 	return rc;
 }
-- 
2.24.0.432.g9d3f5f5b63-goog

