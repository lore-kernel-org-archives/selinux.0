Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B219C10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1C52082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="oa/jJREb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfDIVlt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:49 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:45099
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727110AbfDIVls (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846093; bh=affcoRY2PaaUmEgcqS6C9HybTLSyjRteSCEEdycSbI0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=oa/jJREb89TjXV79eluJR5dpbltM7D3c8VX5Xa6x0wNQTUaLFD72c6b4h0jnFI2BpwpEOZQlAh6e8BQ92JPYVLP8jVeDaXKn6qYOvyLqdOCpR/l+YN9z9vFr2nOpqcMAUvDsJQA/jsdykXEVBU7szwkpn7pKvjAdF1lssm9x/1DTQfk7nA1Kq/2+C1xyEX3W2+urYE6MkO8SWdL4dUucFkWhhROMrjlGyCn9vvCRbtzdaAND6st4SCwG7bY374Paze5qGMor9gpsfIxSNDh6PZC10OhPjkOK/E/JLKLWbibxh7ATZgcvkMFQrfNABDjS+B/xjYfPBMvZcWErnq2jEA==
X-YMail-OSG: 3G9yRZwVM1k70hb1uLdKllt8nUp9CmO7gqzKcBPeyHyp7uQCbuDJtw80aPxC3H8
 LAReeD51Z39bHuOp.m5qQRB6In.ScJUqP1U1_WdPqoKdf_mmyvy2nkdYM011TzInpQD3ab6txgGa
 xouGgm1ZcWqoABVNxerr2RHdbLTcxTBgtF2bwFSyJipGMPFCDRFDS9OkcqOJeUPLplpV9pxo2C6T
 Dk1Qo2ZuJ8pmnhRlcXEJ2Cb9Ox7i9.PEE2D1RXY4NXtwFWTctPNRY5towJZ0lOOTnlmgEDz66W81
 _Z8pXQqc7a2Rwn40wzpxPlskkw.W8MQlxa4_h52lFOMMe3yp475L6hYRs6u53VIQwOnA_fZtwsm0
 LcHkrWzbDEpsRDsOP_Lfrq1bbEoM2g4L5r1issw_6Isj.e.1hmOkqijISMthgQz9CRvSs20MVJdf
 VH3vdop5Wxpq48heH48x9HhTodYWLMAkDSSAFGbzygoeS_x_W_Hu.oH3qAIea2Qak.oSlCfe3wNW
 Cpm0cTEZ79oiCptGhVtpDmIJBW0rMCDSRGZPAHwU4eE0m1Xm89ePHXF7BCblzFNrqT0Vi371Tdd_
 KFZWOs8dSs7ooP8NVBiOftdah56wUm8WwoYoaEtbKcnF7_oCaPBYm1C1xSrhOsfDcIaDsSbmo8fm
 3kRmSWTDxe906rAtfikNZkSQPjdWi5NvIl0UA1o4r3rweZ4jsZrSKV2Fb94dZDUPQkzZbJtDhQa5
 VAvoMwIFJ59MxWUUO8tOnBhL01f3clZSZownbygonDL5cVmkEyhDvzALyUrKmctgSsYJLbbxcjzg
 C7UpMfNu9fJSLP06Q5z87_jAtHGY_JaoSbs88UqXNORz9QS3B5cwnOHcoS4FfBENsru5k1jDX_Y6
 pizwDEdH7qnV39eizN9ZhqtUjwkuC163fVaUbwsELleGZ5AN4c14IEJ36Gr4IyLuFfRsfoKDOyUu
 EG4U5cxUI4LxeeH0puwkiwbqySpgKUebUrVOg3FNyWQlf4flMIWasr8bMKTxoAx8wiSYWv0hAHgv
 WLCfhAINdkgfx5UyoZJEnckBLsK6IGRCGu7nNpYEtnRT6EXMfmWrZxYbvlmC70HWi28vrkSVxkqh
 GITY2PqVUyFWmTMBkdpabFp5azQK2xWL6.6XY8Ou.6uA7evD3_C7TIG53TV_I
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:33 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp425.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d8fc391abae2ed5c1368bb3c988d9ffd;
          Tue, 09 Apr 2019 21:40:20 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 19/59] LSM: Use lsm_export in security_ipc_getsecid
Date:   Tue,  9 Apr 2019 14:39:06 -0700
Message-Id: <20190409213946.1667-20-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert security_ipc_getsecid to use the lsm_export structure
instead of a u32 secid. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 7 ++++---
 kernel/auditsc.c         | 4 +++-
 security/security.c      | 8 +++-----
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 5cea6260bbd9..6ac48c7c4a41 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -411,7 +411,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsm_export *l);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1096,9 +1096,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
 	return 0;
 }
 
-static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp,
+					 struct lsm_export *l)
 {
-	*secid = 0;
+	lsm_export_init(l);
 }
 
 static inline int security_msg_msg_alloc(struct msg_msg *msg)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 83aba0336eac..eabbf78fee96 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2266,11 +2266,13 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
 void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
 {
 	struct audit_context *context = audit_context();
+	struct lsm_export le;
 	context->ipc.uid = ipcp->uid;
 	context->ipc.gid = ipcp->gid;
 	context->ipc.mode = ipcp->mode;
 	context->ipc.has_perm = 0;
-	security_ipc_getsecid(ipcp, &context->ipc.osid);
+	security_ipc_getsecid(ipcp, &le);
+	lsm_export_secid(&le, &context->ipc.osid);
 	context->type = AUDIT_IPC;
 }
 
diff --git a/security/security.c b/security/security.c
index b6a096be95ac..6ba1187c9655 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1775,12 +1775,10 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 	return call_int_hook(ipc_permission, 0, ipcp, flag);
 }
 
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsm_export *l)
 {
-	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
-
-	call_void_hook(ipc_getsecid, ipcp, &data);
-	lsm_export_secid(&data, secid);
+	lsm_export_init(l);
+	call_void_hook(ipc_getsecid, ipcp, l);
 }
 
 int security_msg_msg_alloc(struct msg_msg *msg)
-- 
2.19.1

