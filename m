Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A952AC282DC
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB6727982
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="AjbZdcI0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfFBQv0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:51:26 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com ([66.163.186.211]:43546
        "EHLO sonic310-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726858AbfFBQv0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494285; bh=is2u5Y0DRwzBY1W00Se6/XMCwBAVUpvFG8LStFYaqTs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=AjbZdcI0d+8eSkp8NmA98Zlyn7gq6xguZrWlL/j9xkztJEH7qrCD5hv2FPEHlxRT12UM1ni1uMByE0NF3vesK01/+U3ezvWdcaSKQcGu/KztCl1dImPuX+aPSWl0SeIPanp4f5FRgEjySRtILwLRYMaeP9ha0VaothOJgq3dOhSVnU8aQsMcFA0vq09YXbHZHlBaQW0QKgOO1TzKaa9+c/+cw24KWn2zLWBubo+y60q2w6/4TGh+uAZg33Xya2yHKY9L84DFuXBLuR7ex7e8BRqPJrcGATuga6vYWoTiw8d5D9iO9H4mC2zCs9EJUJmvcckdho+ug9fRwY3nWWqdTA==
X-YMail-OSG: HsBoamcVM1nLFHVuiHRD7.WGzRqSwAxkoofAKbx2ZCivukPLzbcrSEu5Y8KdxEl
 R5ZLYONuQwCS1ttwVBa6POfV57BBEPb4yCdUHk.lWTmJQpygEfbLI3cWhnvMR9v_CFaccuDEJYT1
 7zTB8hHGVcmIVRSBR4Jorf0qkPRWNHZQRslrYc8hGkYwOtDnbRD3MoXQPvewRrRJwRJYSsQoKosW
 PHjrhGImhGFdIXUqBrSyvPq91500BcjAxrLl4hznzkQkMOIMe8DUTP3m.2Ti_oOEu8vhCRIySMIG
 J96lFEG28z.AgiCZ0qp7cDkk6GtFS9vYfPgQZ52vpKo5R8JoclvYrVwSe3laT9LnLONaaVmGpLsV
 RF9mTy7vAj_sFEdBb7SQlWp1ifkLYtdqfkPZ62t94aalIHdDVx_fADyT6fFIeXMTH2VPIKyZqg8F
 vsMUmNL02HnOmmh2d42R0k19WJBazkmuIr97_NjCXUYzjcA4pCCBdQkoRtrGr_F8LYEwM9BUDH5F
 kCw9ElQu0QowdIj3YayI5YU5a7s5XRIWYTVBP2yV0Kd6ArBQk_cdS2JtLbR7eU5q1rTHU7f5m.jO
 E1sYrhEAatKjCTZ1vm1zQ8v2T4DNnZ2vBDWv006t4CCv4AMGDx8ibVZe6vYThv6v73OtEeAybHJ9
 b4Qr94IOlHfzJM7SoZ8HopZxzlZ9llZUNQxwOS_5YBBPEEH1lyrWF3YBDCsuB7Y4E9lJvCJgfvX1
 SeWojGT.Ha.i9bn6hHywnXEIOFrBA24V1Snn7qcAh2TEptMaqdKOVQ6XyxDXDlA8K4mUNX.CMI_W
 _nyrI5z309FTF7aw9_L14Z3a69ObEt7Hh0YB7452FT_9fGGl60PGZbcejDBYz4XiYcQxVfdrNAXG
 5jFqbkpCW6LZfNKv5jez1fJhfuJrq25HuhxahHnFtLIlfcjPBtZxE_.MARqoxhXnUxPstLBzjeW3
 Oa5qlizVpFid0DjZdKiJo5UXJlTPRyZ0qt2u8lq0PbY_IL6kKIhCaWjo4MaXh5WjEB8JkdHjPlQ1
 z7eriBmo2clLEIIMwV7GgPSZp8pX.SjFtutMatZ83jVP2gpiSy.xrTnfQCPxZZU0dTBOoVL8bvAq
 PuMAKVN4X48s1QKQrtMA4ckrj2giBOEqvAz0kw53mu9IH3zdiKGHOayjU.BmBC81RmEUTOQvFiHl
 H1f6Og_U353yun26AtDzBsaO47h.fE3vll6C.6LF02I6X9_EMlu0D290vhCRmTKkArXS02caotmU
 1FnbhUvzQ.OSvnpAbXysSV44JP3mZtFJArDnsgAPO
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Sun, 2 Jun 2019 16:51:25 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp429.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID eaaddcf00ddf2fd5d1fdcb38c64db575;
          Sun, 02 Jun 2019 16:51:20 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 04/58] LSM: Create an lsm_export data structure.
Date:   Sun,  2 Jun 2019 09:50:07 -0700
Message-Id: <20190602165101.25079-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When more than one security module is exporting data to
audit and networking sub-systems a single 32 bit integer
is no longer sufficient to represent the data. Add a
structure to be used instead.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 49f2685324b0..81f9f79f9a1e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -76,6 +76,18 @@ enum lsm_event {
 	LSM_POLICY_CHANGE,
 };
 
+/* Data exported by the security modules */
+struct lsm_export {
+	u32	selinux;
+	u32	smack;
+	u32	apparmor;
+	u32	flags;
+};
+#define LSM_EXPORT_NONE		0x00
+#define LSM_EXPORT_SELINUX	0x01
+#define LSM_EXPORT_SMACK	0x02
+#define LSM_EXPORT_APPARMOR	0x04
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
-- 
2.19.1

