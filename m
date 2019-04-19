Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF22C282DF
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6942221736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="UI06IT/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfDSAsh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:48:37 -0400
Received: from sonic310-23.consmr.mail.bf2.yahoo.com ([74.6.135.197]:46054
        "EHLO sonic310-23.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726759AbfDSAsg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634914; bh=nBnBMo6nnWk5nN0YxdI8fLfbN2dvJh7eXD4R2+pTog8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=UI06IT/NAuX2dGs6Cc59C3ocm2igfXAE11wCxTDp7kyrht4krhz75sEPYhc+IXd0141XCPUxl0803k3UARAl+Ks1Ia9cZ2gAYdS8opL6FS1SF3vz4isjjQtcFFhnCilL7LGcMtQwdzwpHxIKi4rjzQ5Au/rcpbIFJ9SGJO0i+KcIaQxtG+p+gC8N0g7buRflBQwY4QXf4Is1x80FqZx/2ioPC0LAXMedZpMQyoRJ3T5ZbAT84H+LHCZNP9fyiq2/skc55itv2VjuBqfz9HZ29514eWIWXmOpUl9tZQi8u+6YZdDm7Sl4NwPyPLhvQXBMPDyIYLY2StNjAkvMkIterg==
X-YMail-OSG: pBTW4kUVM1k8jHbvIxRVJRiLkc6iXHCIQAtYzQJAbK3_PuEFCWpGfNeSvf5nsoH
 k6WyzMjzSDD1.JurjKHlURxjfIOP3a2j30gtcOikUorBh.RLmdcSwpR_mnfctOj3CRke0RFxFBQa
 oenJEia_qQYdH8gkdzj0rGEq0.FRHB0IiiM9ABCtQjMvpsWZhskJGN5icGonnVbJ0VR_6F79qTnj
 lyfoOoAFjj4Br1UePMOXnyuwiC6GSJYqYGL56_UZFrj6Rx_zmiANn.Px.hB9luKw9fEyFT7yfD4A
 WCe7d9kLnVi3T1UrbxGtpDmgPmkZtt0yIgrBsuhnZ0.0VMu3Wv1qgte4HWR0sKZJyr.hrF8xwYeW
 dPlL1SQBdc0kEpUVNkz9lo4KnzK9wCuUSR_mMDn5NAPlAVKUkzBwUdxzXzXNXZOTify.pf8deFZa
 PRj8MrRG1NOAYDwk7e7AOcvOHnYSxa8swHHUkx1RbV8_L5I5xD71Y2Foh2Pn7QN.SVs6nXpzxznp
 IODTD..RyFhbTxW4mf5y0p30JqsyiI25YahCd2W_iLQI8aQrK8I0w1Cv6RIQ6rjKJD._oxBennrV
 brUcq.Igh3njTrHGy.6.ZYXWUo7_rhoHdJvLBIUkCnb3PgiWaBcxFh4633CVNvCoEtLDV3BYz1Mz
 Kki5uO8ka_DXB3pVtJfY.ylYu35I.G2tnMR8WSkh7eUlrTga.0_1diKI9i4KwrP4u427b07jMeZv
 ubf72lAEfckdGSlCGdKyAAxXGd0g1xcxFhPRZJ0gDrhf._2nUN5IhdLQX_WBabjFZCIv7qzxQy4g
 1KuxvcyaJAJ_dfaHZwcS9XZ7g4FAzreSXvdjK8rhbDIIywTDXObLPGrcNuN513ZV6235OlXYIurq
 SFPrXVIEIJ_ho.RyeMY83qzuVz299qvMV2ZA2Q2SREyv_oLNk3GEeZSqXKeA_DDGVkx1bGWjtEu4
 VEA_gT6vu.8WjckUaosjhWJhIMptclQv8T85FYyMuIYkXuYH65eV5q1sWpM.inZ_d5wF.TTNIq2l
 vGJvKB3RVaeWfgiCGAY1jut1Wqi6nUXS9Cvopj3.4nJ0vkGZAZGY4BNQP6ywdnS_Bd9HOg7VCIgb
 Fy4T8nbWj20ueIuY.PYiqSIdsKnHzZI.WCKOwAm9uWRBb2AlF6CWq7qWJLgsnyMjigzojF.VUVAT
 DzL6fFyMN9dR7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:48:34 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp432.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 828306e040049ab0082b23fbf6722cca;
          Fri, 19 Apr 2019 00:48:32 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 57/90] SELinux: Use blob offset in current_sid
Date:   Thu, 18 Apr 2019 17:45:44 -0700
Message-Id: <20190419004617.64627-58-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
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

