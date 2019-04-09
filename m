Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDA2C282E1
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E512082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="CE4wAe4d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfDIVlF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:05 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:44187
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726860AbfDIVlF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846063; bh=is2u5Y0DRwzBY1W00Se6/XMCwBAVUpvFG8LStFYaqTs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=CE4wAe4du0Ththjc6C38kGggCV774T2tkuQoiQYOlUNxlIsngXVJxZ3TbPMjYNUK6SG71mnH867k8kOnY+ytTiZbhwC8BdfDNCRgW98ZD8DdF0FhHlFveHivLPwAIGiCqJkj9UV3jSoB6wSBmvPZ4lgCQ3hjUt5QGQ2r9ASISiJ0nx1wAKar0E5BhOTQ1stFARGpWdXLzFIFXzXRYc+tOR20P/tapt7ZdAH8ASWQuSGZ7juACUTtqkol1EC9ax6Rt5R34TcAJ0/UrZyCMqp1K3lC8G7fENRs8plBMav6/6GVypViCib12/BTR13PcIDgndEYFVqkLDQPCDbTLTdUbA==
X-YMail-OSG: ufOrQ8UVM1kku_9wSsdaAxTssXUA5YN3hBly9MNLkc8G.AqInxIMKtZzvO45810
 cHbPHlSYbqWDN0NHYapeGEaevGO7xBt89vg_yvZdtcSyOH15DR3GBMam7dA491eY7V73..PO_cRg
 ZsUI.M0utdJA65m.Xkcyf4Qf8mOVzV3W5fIXDHc_ED.ikYn4SW7QNPmai47V4_oMkCtMAUN5jPoh
 pkkPPIZk0Z9UVTgipiYTYXTC36WwYTuUu3DiLi8RGnYK4dY6imXDEVtH6jjt4WfXi2SP9KaI_gBt
 BSLI5I3n0PoYV3eFhk49x0fJJwVHcduyV9wvjzB5_Zl8CqhHOnyclcVjuLExjL19ZxVARRX3yOnH
 bXfXv0gkbD2HxRz_fGbaTPCb9C8JbMpsBrUcmBazYFtALqP9FSdI4xtdEWc1PBDq0KL9TdHwEC3z
 q2gmLhaIo4FaXUwoTZb59uOhp1tQRInEj.D11Ezud1_BE_z8rprLiNGibonMhSFJCDWwdFkvGx8J
 _MNv2CCVw6jSifdOmCqKNFUx8JS1YT47FVL_7_lPcjSu.QBgOdaRzew_KkYvyGBMXBtUpBeeBrU0
 5mrHqaqS9WCTUOYk5IX0bYZuY7r87rvHB_PxHhP.78Lmuq2Q3ZkTu6NQ3OEqRUMOwu0shV76Ijji
 p8n9VLDZyT4.2f395gZCO3Q5VSJBMRGp0p4HriljoLLT6TzNG4U_Wi7pMSG3TtN3K9Sivyw6PnNZ
 Em5fi1QTZ1OujnQh4l4QkMaS7iMb0oa8DilERtU.U6fdMDFgCaffuQXQpktTQuZ5rhXxtVqxJZNi
 HMQBJ5nB2WgrUEInhuP57k6tObqP9Bpxl5_HKubQZ6hI_nXEl80RbmyZTsDNm_sLivutS06Q3WyR
 DMYJo3t1YpXk7.SiDsQqM.9hqM1r77K5xbTXvIihfpkZ2KePS1I6sq9q8aMeibS5FvBjsEJzLQcU
 FxHS5FL3U1_ko6O8chDJPtkfC0vB0SWTTcCFaao4ymBsy2ZJ9lesNLaEihg_S_ZBH7lXgrSt_G3C
 gynWm9oo3qilb7HGCLKbDjyRyRm8NF29MKHQXHj0Ud1dqh1BeoRHFuQJdZy72F93JEY50z3Q.H2A
 kYB4ecRIF0j4foV.zDwKYeLL50I4k149DlvG4qakghL137qLOq8_u1AsI
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:03 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp423.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9c4e55bd3d312d6c1e8f7ed93770d720;
          Tue, 09 Apr 2019 21:39:56 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 04/59] LSM: Create an lsm_export data structure.
Date:   Tue,  9 Apr 2019 14:38:51 -0700
Message-Id: <20190409213946.1667-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
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

