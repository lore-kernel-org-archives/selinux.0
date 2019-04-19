Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5547CC282DD
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FEB421736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="acacLhFZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfDSAs0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:48:26 -0400
Received: from sonic308-9.consmr.mail.bf2.yahoo.com ([74.6.130.48]:33867 "EHLO
        sonic308-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726964AbfDSAs0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634904; bh=s293PbMAjW22h/8ubCAR0YEDBHbqaLOuUY2hFLr6/0s=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=acacLhFZkPFnSCjkbZB35KCwIteWOVEUJVISTdz71ynWEREktoPebQa8DPiM1qKvybX7ModcO1VY0I9IEXTmTzzu0JRUKzbcgNl5HJB/4dJSM2GdOF2c7NfalN0VMgu32aauWN7j6gFFTBd1Jx2EcpJdIASuygI2OlMD0qiuzDuhcmPpAuXcoibH316T2mKy3QQmKUTxWQbdt96onOPl8K1uBIvmhuLSXR9yuetCem5tP9aGDStW/N1el4ey0HphNvR6O95g9EWk+GHh9lw3/o0tAAjCLOvns9oKsHoPKuOlvSrFwC78qpoEPBUIj+q6ldi/SnWA2kZnmSGcR1rr/Q==
X-YMail-OSG: 1hdnEPwVM1nuPZUEKTSPJOE2Hc9dG27sgA_mjmJwIltxIiqS0hSAZAeyr0UIeME
 KkagB7KlHecKpBcdzzoDi3F1LCrxkK7b2MDraACCM0DhX_VQDghsekK7iwLqh8MxVbBgFwGRyeon
 PiS7GLD.BAGv9Hot8itA1.LPWLH0N_xlmyGQPEVrJ34mNQ056IjOJZ2nLd0x4L81.plV8V02y5Ai
 jt6yx16Sx4q79lEFF.WyebBP_Hqu2igpFwjUAZIJ7O2rU8O4294tgHzfHPbER_kTVgtyhSzALx8H
 .iqKFm86yPFkL065ttqbQxX26ApkFNKanqUs82f9M7Z454VtHXwnCw1eKnYe4tSHMILKV5b0y6As
 iwN0pP1mQU2CiuhbZPPjv2QH05dE.PhqYisdSbRomXz9Ypff5FGhw4JrGgHLcurftE6VyyT67q2y
 nW3rFD7kMvhUSHMz6rkwka67Ra20rASFt5IoGQN6IEiKZPk0fIr75136ZItfiv.0pu_C.hlNOvbi
 6yfmv1_ms6yOxBdIeiaYc4maXwZYMMpp1xULOlYD3_Iqg1hTO50EwzXvHarKph1i8bw01dvDbHkl
 k431OY2yEj_iE3fbQK_Os3NqygIGdi7IKbrIwbUm458iMVjUIhnOSetcKAjWLMc_oPkqDRJLN_aA
 rS9x4Ps.0vz_KsLQWjE_v.kYu3Zk7mML54ROWfNhbNibC4BfmK0D1CLUv3cquDiUHQHaVkeWjnnk
 uFAAs18Gq1aBLy5EPkxOsUWBJU_S9M3fGb9fKxZuBKnQkKhAjiQocbGeT_IwfBHRHhdCpj4M2Hsa
 QTCYWPh2GbhyZe9UVmeIUJXcP46PBK4jodJeZMadaNipD5phXl1JYtEYniDfAX9zyDn5v3BJTdH1
 PQXQSjul4GNgBGcPYbVXF2fRRmM0okrJ6f6KC_OHw8WnWW9lqQMLosxRVNafQxeiNXob.GVPG4mP
 RIsFhp7yQC41hj0zU3_.eA1Jtm4DdePD2d0todsJeobUOHqCgK_7MHYMniJViH7ZviduTFqpO9zq
 8PJVDgDQ6JuOe0UUbmyfEQceazNvXU5tIt9zMv1TRlfai3bNg8LVyxiMoiThJzPFaF8RGJ9sdqR.
 ARZ0GCoqJjxZ7W69x6YUKZgiwYl90J1UZWNeZaG0nphVv5_D4yapOZ9_lFFw5Y5E-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:48:24 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp425.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 48f2b950f84a4435a371532cc5391b39;
          Fri, 19 Apr 2019 00:48:23 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 54/90] kernfs: remove lsm_context scaffolding
Date:   Thu, 18 Apr 2019 17:45:41 -0700
Message-Id: <20190419004617.64627-55-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the parameters to kernfs_node_setsecdata from a
data/length pair to a lsm_context struct as both the function
it calls and the function that calls it want that.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/kernfs/inode.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 4c7da446d210..d6e25cd7bf21 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -135,20 +135,15 @@ int kernfs_iop_setattr(struct dentry *dentry, struct iattr *iattr)
 	return error;
 }
 
-static int kernfs_node_setsecdata(struct kernfs_iattrs *attrs, void **secdata,
-				  u32 *secdata_len)
+static int kernfs_node_setsecdata(struct kernfs_iattrs *attrs,
+				  struct lsm_context *cp)
 {
-	void *old_secdata;
-	size_t old_secdata_len;
+	struct lsm_context old_context;
 
-	old_secdata = attrs->ia_context.context;
-	old_secdata_len = attrs->ia_context.len;
+	old_context = attrs->ia_context;
+	attrs->ia_context = *cp;
+	*cp = old_context;
 
-	attrs->ia_context.context = *secdata;
-	attrs->ia_context.len = *secdata_len;
-
-	*secdata = old_secdata;
-	*secdata_len = old_secdata_len;
 	return 0;
 }
 
@@ -363,7 +358,7 @@ static int kernfs_security_xattr_set(const struct xattr_handler *handler,
 		return error;
 
 	mutex_lock(&kernfs_mutex);
-	error = kernfs_node_setsecdata(attrs, (void **)&lc.context, &lc.len);
+	error = kernfs_node_setsecdata(attrs, &lc);
 	mutex_unlock(&kernfs_mutex);
 
 	if (lc.context)
-- 
2.19.1

