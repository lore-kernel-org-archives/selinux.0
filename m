Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E929FC282DF
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56FF21736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ON8R6RF/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfDSAtN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:49:13 -0400
Received: from sonic310-23.consmr.mail.bf2.yahoo.com ([74.6.135.197]:38778
        "EHLO sonic310-23.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727054AbfDSAtL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634950; bh=E0tCQDUWbNPu0uHhuqprzqFCq9/uRZl3GZh+KPSBEGM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ON8R6RF/4VHxRxP2BJvwXj0Zlc/QG/RWWUTtfSlkoi8tI+hIEmbh4cBX3BXdVvFxsSRx7YZLSK9oQ3/OtU7r6TUjbCxaCTtvpuLwhzPtN4bGBpmhUsfO3p29DpqCKP+Qbimud6ktaPHtkEIN3labhzKj8ss7KYN7z5gM7SZtyt5WobPiFg1R9DODiytYKIuDqoPwy6Gi+ytOLy9corw59i+QvX9eHQAYgf9GOMM0JOR8WQmY2jIv+fEQL9epw4o8Xa+E3nv7ymS5WtA0cHHoerMLWtbC8TOQhGN+r8T/DkrZaBBVikUsHnuF1jvuWOdFDrwQ7WyrQ/+oIMa0BfSeCg==
X-YMail-OSG: uiG2Z.sVM1kRKn.ZsvXYmTyWHz312fQBpsm8QNeLQwM2QZjLKH1Vr9XiOD3OCk4
 OG5bKTf0UKx.ym8JFHH1Mqplbd1Rl.5S9phWfmu_2Lu_kp32_c4RZxgSvp1Wjh8QxAnxUfA9QQIP
 pPnk_vPqtoJHA5nEcTemlfWw1Mcsw_0ouSTppneqFEKSkQmiObozPIXjMdgBaPudIh9Xp76l4xsc
 nYdQ6FGbw8R3bp8Q4F6hx3UJzWQ4q4nom2fQq.XTcXGjhnXsImpfzRwCaVI1BE4pZ3zPLs0TdFMn
 RTVYFTVdjYTtvN8PKCNbvdXAz96_1EThy2CZIZdu39VR3C0J267TllXtiQKVN7JNwWkX4BF4tDop
 PPgLniOTl3Pefhv.lomS9TDoGMsWTl_DWuBSV74FUzR10up._oHSlyrSTDQDj_rWBfZAjL7XgXa_
 rTBEAq8p3dJRQQKpUiaS0YwLrCjTvvTT.k.JJcQK7Pbid3tUFR_J8N5Fl_aB1Tg6eYo9GRTzzGoq
 6M.zOKZ7KPx.0VObxrh0AjW5xZCaH4cx7S3MRMMhTxK4qkfhr0xRcCWUgSOTTsQVX7yx4J9_GFju
 EcpGbWP9xAWoIdwjAcjQJbPTTUUQPPd4UMUfo1_3oyL0_Ku94_0qzIvCtrgjm9aTZNPxb8JdE._6
 ZoAn7PaIVSvqzsJvvXiXfueenZXEezLfmIhS6W7j2GBqzVmqDleHXXVKFXId4NBYbULuE1B3YlC1
 2bn5xVWR0d.Jm3kT3VDjTFgiJdZT7652V.o5OskifreS3fvAfq_qbWlGIBoKqHjy4Vt.EST6biQF
 djImMH6ZyzvNMWZAErYXKhmYAiUcXjUwFMR50hfuLGvQh_ybPLooFrsfHzurczaL6SwDsHFaRb4i
 Uz2RDGHVvcvQtSP17szRe5KQFI7IM3Gx5VO8Qt14RB3RpNK97Qaw7Fzpl3qmp0SxZ7U1ywLB81GQ
 eeBky76nZuP85_bT2OVbdSTksDvZfwsJIC9J1tNfQJRdJxVfFyuFEVDjTzTApvgsBW8D3kVtxzs.
 DR63uCFTf2tnUfJJC.L9xh4FS59qQ2EKbe4DAjnuc1iOO13TrbPo2vkbTIZws_jQ2sDXzaiczU0Q
 0Mr0DK05mmdqofVHq9fAjkebOC4G1uBgPKC.JVeaslQq48L4UwpGyQF6REq.xVjc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:49:10 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp419.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 524225efee00edb3a1e75559f6c5c8ed;
          Fri, 19 Apr 2019 00:49:07 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 73/90] Smack: Advertise the secid to netlabel
Date:   Thu, 18 Apr 2019 17:46:00 -0700
Message-Id: <20190419004617.64627-74-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add the secid to the attributes shared with netlabel.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack_access.c | 8 ++++++--
 security/smack/smackfs.c      | 8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index fe2ce3a65822..0764bb85daee 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -549,8 +549,12 @@ struct smack_known *smk_import_entry(const char *string, int len)
 	skp->smk_known = smack;
 	skp->smk_secid = smack_next_secid++;
 	skp->smk_netlabel.domain = skp->smk_known;
-	skp->smk_netlabel.flags =
-		NETLBL_SECATTR_DOMAIN | NETLBL_SECATTR_MLS_LVL;
+	lsm_export_init(&skp->smk_netlabel.attr.le);
+	skp->smk_netlabel.attr.le.flags = LSM_EXPORT_SMACK;
+	skp->smk_netlabel.attr.le.smack = skp->smk_secid;
+	skp->smk_netlabel.flags = NETLBL_SECATTR_DOMAIN |
+				  NETLBL_SECATTR_MLS_LVL |
+				  NETLBL_SECATTR_SECID;
 	/*
 	 * If direct labeling works use it.
 	 * Otherwise use mapped labeling.
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 28c567465f6c..abaa5325c32f 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -2953,8 +2953,12 @@ static struct vfsmount *smackfs_mount;
 static int __init smk_preset_netlabel(struct smack_known *skp)
 {
 	skp->smk_netlabel.domain = skp->smk_known;
-	skp->smk_netlabel.flags =
-		NETLBL_SECATTR_DOMAIN | NETLBL_SECATTR_MLS_LVL;
+	lsm_export_init(&skp->smk_netlabel.attr.le);
+	skp->smk_netlabel.attr.le.flags = LSM_EXPORT_SMACK;
+	skp->smk_netlabel.attr.le.smack = skp->smk_secid;
+	skp->smk_netlabel.flags = NETLBL_SECATTR_DOMAIN |
+				  NETLBL_SECATTR_MLS_LVL |
+				  NETLBL_SECATTR_SECID;
 	return smk_netlbl_mls(smack_cipso_direct, skp->smk_known,
 				&skp->smk_netlabel, strlen(skp->smk_known));
 }
-- 
2.19.1

