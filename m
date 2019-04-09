Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A166EC282E0
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A7C2084B
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="uAoaJpFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfDIUAk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:00:40 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:32785
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726865AbfDIUAk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 16:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554840038; bh=VEDYIM3R1NMqedNbn6scDMcxUUfpt0y9Ccbwl5mHx6o=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=uAoaJpFqStuTJS7chYTdPmDD8VA3ogNv8dPSzJUv2iYiTLRJg2dBCw5A5xmJhcUJEbWm/Oe1GKseTU1YT6gPUMfEVTzNkofrVqsa7uOpAkU5JOm90lMVpzLWYY7lDGWhMAA8JNOI/2L9YDrWB/rvH9zFgmyb0hCIj2txWWqpu6AIEtsqgOhsH+8pWzqiPvFT+cTX3vls9kasyD9mKK/g/Q3PxoNT5yXYach4yMrro1quo4ki9eVlFqG/P5pWfx613gf72WSUOXpGbLtltKDZ2NRh+ubB77QnG7QH30DLhFBpqErntdOfF4VVJVZ2w5lY3ztmthKNhAGNWk5KvM7+hw==
X-YMail-OSG: W69HfXYVM1kluaw2aTRORj7ETkkYmzfoJUlL4uNz0wtixsiQYtS2blrvTBrIF3X
 jYQAXyKvCVI7s09Ps8NsxfmJVvJnA2OINF8GXRbYxJL3TSEg7blllhpRorEEwmhWZO8uqZcsdk64
 Mtye_T.iLh5GD1jeh5fNHef91XrASAyxDZLxOpgekhywtBHLLN_sWyypkZ2LcH75xcK.LkF_Qy1C
 FGziGZP5i7X4MWAd5IGyj9j1U7ru7vNNvTWgmAC57OHsdw_yhqxVUOF8sDCueVga3tCs1zMrQE.T
 wPe2Y5OXNhyW47_L8UPAy4On8WZmnaZZEs9EpE5n3OUPvduF8Yh63g.LBO1WZwk.hKOH2RotYAKq
 vMgRbfMdufZPn9uyNkbqK1qUb5ZHtvICbU9U_4PmcAXOsq1IYztDBHNXHmnKbIEe.IvZ6XjImsWp
 r874HbExIFxtd0zua4vnrPftQUn2DnMi2.htkq_F2iv9pv1Np3zzXxtWK7OIX8uHXKHUrIJZymWd
 7VA.7ku2Scv0cCw8qv7OLFYWoT5vSVXceAXesk9.FNRLFbZ0KoULYSOgsZ3a3wnG6BX0GflkXICZ
 OyZovSST4IADymVKbRpJ8wzaePGz8DukWI0D5.ockAKfQCce.uJ9DyvmzvibLbl.9bx9H5rB4GCe
 _HQcj7Fxg6WCXMozTjXQXzrpYL2WZ52XrJODYAlUGpslQK4G7WuPyuuwLiSVxQ_NRk1KC9gCFJjg
 JzK0Vj1COBtBwgGKhTPWLF9O4C6_JJp401N3gF0J9v5vuGog0N64MTAwdN4AWG9wjedcXXMl3B.C
 GZU4dse9BdWwxtqRMX08WN9_KUS7HtQ.ngUBP4zn1qyywPaOM.dn0rsGHlTI6eOBNKznYnAv0cCx
 LxQUwiXHkIujJCApwvPkA38JgM5aGEJzoIMjBs9sRLGqeMZbvtUiMd0PHUvnCOjg_guBD6YOTakN
 z6tHyKGu34TxOg1hFglPUyQS4mThXy93.NQLmbLrJ548XxnoHDUKy9x3QdvsqaMCRf7l3Pjd.aD7
 DZwd5PFFUSjaQsxkACkTPBOIubSSNmX0Lo0BTrdSxWtae5IEAN5HimluUveOT7lJYmLuNfdGLG9V
 iifBLowiwH_6LZ9RGRX7eHr3QPRuAkzdDZuUR_33oun0tETraOPTs0xe6YF8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 20:00:38 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID dd207be9b16b6375049b46b06443493a;
          Tue, 09 Apr 2019 20:00:37 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 35/59] AppArmor: Remove unnecessary hook stub
Date:   Tue,  9 Apr 2019 12:59:00 -0700
Message-Id: <20190409195924.1509-36-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409195924.1509-1-casey@schaufler-ca.com>
References: <20190409195924.1509-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Remove the getpeersec_dgram hook stub. It's unnecessary
and disrupts stacking.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/apparmor/lsm.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 24b638bd4305..76c409737370 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1094,15 +1094,9 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
  * @secid: pointer to where to put the secid of the packet
  *
  * Sets the netlabel socket state on sk from parent
+ *
+ * The TODO stub interfered with stacking and was removed - Casey
  */
-static int apparmor_socket_getpeersec_dgram(struct socket *sock,
-					    struct sk_buff *skb,
-					    struct lsm_export *l)
-
-{
-	/* TODO: requires secid support */
-	return -ENOPROTOOPT;
-}
 
 /**
  * apparmor_sock_graft - Initialize newly created socket
@@ -1202,8 +1196,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 #endif
 	LSM_HOOK_INIT(socket_getpeersec_stream,
 		      apparmor_socket_getpeersec_stream),
-	LSM_HOOK_INIT(socket_getpeersec_dgram,
-		      apparmor_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sock_graft, apparmor_sock_graft),
 #ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(inet_conn_request, apparmor_inet_conn_request),
-- 
2.19.1

