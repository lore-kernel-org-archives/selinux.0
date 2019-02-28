Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A9EC43381
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD25420851
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="GELUpyIo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfB1WUa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:30 -0500
Received: from sonic315-15.consmr.mail.gq1.yahoo.com ([98.137.65.39]:33420
        "EHLO sonic315-15.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731894AbfB1WU1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392426; bh=QK9560GfKQyWtmcg3Y6lnKMpYD6MKgEAgcdInD1a9Ak=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=GELUpyIomE4pB5EPW95vvS+oN7rUfuX2a2xKewver3BfrJV6MJbBTyca3NR4x1E7n2FkioJr69DGI07cwtLkr+RKiXQQxnineaDW1H5F/PsDZ1ntV7k/f/5KNZS96K7JTXt6hrIwb+0u5WJ3darmSc/zvhe+xPODuc+c0ovNVOOGSSepY39bqWpsEKeuy0Q4pdE0mDICptELK40Hp+ZMw11tbaiIZKgghW76D3zv1RXQNQMsobggCZZjKgFwY+Na6FFty/EsoKEpr24o7Ymxigqnr4bzXrBKGlGuz5jJyrmV9w7ctYNVpdIdD3ywicI/TvLqTnKi9jdkQLdEErSq0Q==
X-YMail-OSG: 6gKhbYgVM1mmrPWBCA6062HAsRKfehk83tx2skYssZg8lVo1NX0G6GyQyvCthqz
 nqcZBPkCs7NhKpQx0aGTPopwKzJ_HFHdUeg2TjLcumnlHyR_1DtJsYa_y1U9X0FrRL6d5zh9q6Ps
 PVkOEf7bGhoC9lYWaSEH1.Xl5lxnfG9jv9OGOG7XXxGEvl92bSzEPMUInQrCnVwXb9SZQAlJ.14F
 AOmemee8j2ZepFbOEJCBOAqsxtwrbvRLU10a9Dz6BrfvnN6uFPPxRrecKluWXK7m_Z26GkkSgS6Q
 I8kcxjwZTU3yzYASi0aLwPWp8d1iVPb6D6mRyBwqRXH__EmCE8cavBciM_IFjyuiHeBKhMeScqXk
 8137TH8UqLtlJdnt3vUQbjP_G2Cf95PBWidc0pfWX9n8ykHNZoJfF.9j7qy4mRFSizjbxJLG4Fql
 SlHC_Ns6mCjwfXJgYTPqVogxHhyvg5xeCOtoAelWjdVEQSfXJenw7Y5Jgzl0kO3dDSfHQ5Nm7Uti
 eSEO8AEyMQi0wEC5oHIJ.Z03wr8tmTqWS9I3Bfpshe3Fke5psSPXoO5co0LBarsmIlKilxWzSCPf
 QkvJsBYIc3PA6LSpQS5YhG4dlOCaw5UWQQ1OizM4hQ.AF_Io9ifjcHz9PcwwZV2Scr7zasOQ11j6
 m0aS94CcULdZlbIvCNQrmtYD4X9o9Cj4yLsgHunHh39hweu.nu8q700mV9KC7O3lmwvju_2UcGHT
 NNn1cQLZcX.5iJ4X3GtnK8hX.gSZAk18ZUZvfbei4vxeBJypS7VBE7iz_s041B3Bkji16WFiVJXn
 pf03RInsX4rvpLKIL3cnWJuYFzoCgR1UKZTpRbj4pXVrGEyJNA84ob_7LV5_PtL1fWDSTsDKEza.
 3E9qxYVcgjrNI2kZdeG56oECssHj_9zus8TdwBOHaQI3cLL49YMuZWmjbluq34KYaQaAg4Mma_hg
 e8z6eOcmd7WKSrYsQVAGT3hgwuPPJMjIXZSTbpWvTQbN6mx7bqBLS2QOeGDT_U.GpU5o.mnYBlnW
 dh9JwnurkGWP5uEMGE2pqnfB8Qy.B9U39LXGCkw8LbzzqjpV5y_G4CZ12NhkfA19BWNpEa7Whcow
 c8.lGkASTeyzF8eFNzS6deawihLERsJkdYSlJRbDxXeUhFq6g
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:26 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp421.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d90148b291d74b44c78573c559ceeae0;
          Thu, 28 Feb 2019 22:20:23 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 63/97] SELinux: Use blob offset in current_sid
Date:   Thu, 28 Feb 2019 14:18:59 -0800
Message-Id: <20190228221933.2551-64-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
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
2.17.0

