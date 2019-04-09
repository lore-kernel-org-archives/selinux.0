Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB103C282E1
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BE12082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="XHrYDBlx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfDIVlw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:52 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:35820
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727122AbfDIVlv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846104; bh=nBnBMo6nnWk5nN0YxdI8fLfbN2dvJh7eXD4R2+pTog8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=XHrYDBlxnhzH74wW/Q0T3qB0ocPk5xwIo1l2f3tQHj7t3u4ZuOmnnlj3SgBqsFR5rs5Xl2YTczu8CY03J8A2q6AuLv2k1sH455hwdIrmEMjZI9NhX1qX6iK3HHQK4gJB7xVpzb2yzaxpOAJQfYa3aLGSTAbcOosNj3xZXVXsEQusGpAvfmvThxpxK8SPbM0kSEHZv/YPe4SEXRmtxqjAWGNYw8O6TmX1+462O/VCKOaY8WDxY/3DjAzW/gFQnjnxkmBdQhab4fzoeET4bj7pMLAgA4g5mSVq8AqlRuuVS9qd26WOb4Mnsg671JRXy4aAbX+tLjTSW6wgJv4wxOqk4A==
X-YMail-OSG: nvBwpLYVM1kBxGBrO8awYw070B2d7Yd8j57cSH93cWL8uFH3S.pFQDnIBl40R9w
 melP9YxcPmWAwTanYY6oEQkIR0ggW1hLxg06EDmiZVTW0s0D7NiUBW8E4eFLkdqsetls8PoIs61w
 W3mc53F67Bw6BrVpky7FajHHzQ0A4rEcay8jIo13gfqUb9LLVxmIc9LpPgLOZCRs_r8V.5ett84v
 n8j3JduquNU1d7Jylo48i.LLnt3KRIYCe7xr4UXzdLTyTcNBDlluyRGqC6OFlECIO__E_4rh_tP8
 VRYIT3Hap47RvqjOxixRyBytVmxEuJi1JKq9ggWquqDvWagDh_B3XexJWl9ENFEEM2leuwjn7W0z
 Dq0JvWijACN5m93CABIbGyhiIes6Bs286fS5rVhEmLQdDPUGnCM6FKGIf9yt4hqluHDOScyhqRkE
 ufIQfC5yUE7Ua0_DtCFzx3Wx.vOOZqWlraSzo6UgQWz9pD8FSVmGtwm1WS9lPr.Qx8_DbpnItYyv
 cnHg5FHw38MqkH_aVaQXeHijaVO1gTPz4I7858ryGOS7HAqGi4yVuMXZPCNsT0UmZQPdI6KuyNfl
 d3joAnuWbAyjNDBhlAa0fZ89QfdIwhgC7_SWlBnrXQ_M6VGuqUTKFZ85pM4Wvz9.8ldNVIR48Efe
 X0DMn6nSfBYRG_bJMgfkIUXkw8kG1KUps0Djk5MVR1bh0q43zYP9PghMFN1qK4MF4qKYe43tLdqq
 gvOYGk8iAEBDj9LgiZVwmel8EeJCAAXkUz_OcHBT1mLstrnw0p3u_yGYn.H08K_huFPwaziLYQPT
 sz80qpsxgm.8eZqhossQ3t2Q8BcVopTRl33QSZ2KTX9DKYutpbKpm5bUGzndK30xE_HudgHIITG0
 Jq4OGlF.fg8wEGyeli9FaxCSmdPZKY8pohRjFHk9IoIQGIXo_K_9QQqKEsSP8spMn9mmzei_7VUP
 hLWN5moXIqUKZ8rVHr4yblnlAM6hV_uN0zz1p1VYt2s6EtjpebfU4UTrWF_mkqYAUZWBaHoE0U23
 FSupBOAcl1vYdVhBhCkhVkQZ9nI_CF3dQ_NRejyML5bMEICikHfF6yGEFY52F.0aGKvykbGEaHHo
 EiDdpw0Nc4YeJes3KeQpoiW5XDj93K5ptZRXXwvuEnjYqyIM_V6bHuUJ_22cupA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:44 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp416.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3e563602cfa877b5908e791085320721;
          Tue, 09 Apr 2019 21:41:28 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 57/59] SELinux: Use blob offset in current_sid
Date:   Tue,  9 Apr 2019 14:39:44 -0700
Message-Id: <20190409213946.1667-58-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Replace the use of current_security() with a call to current_cred()
so that the blob offset can be correctly applied.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/selinux/include/objsec.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 59a3b1cd5ba9..c9a88b7a96a7 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -31,6 +31,8 @@
 #include "flask.h"
 #include "avc.h"
 
+extern struct lsm_blob_sizes selinux_blob_sizes;
+
 struct task_security_struct {
 	u32 osid;		/* SID prior to last execve */
 	u32 sid;		/* current SID */
@@ -45,7 +47,9 @@ struct task_security_struct {
  */
 static inline u32 current_sid(void)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec;
+
+	tsec = current_cred()->security + selinux_blob_sizes.lbs_cred;
 
 	return tsec->sid;
 }
@@ -174,7 +178,6 @@ struct bpf_security_struct {
 	u32 sid;  /*SID of bpf obj creater*/
 };
 
-extern struct lsm_blob_sizes selinux_blob_sizes;
 static inline struct task_security_struct *selinux_cred(const struct cred *cred)
 {
 	return cred->security + selinux_blob_sizes.lbs_cred;
-- 
2.19.1

