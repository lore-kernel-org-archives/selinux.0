Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0FAC282CE
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777E32082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kbdlnl+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfDIVlz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:55 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:42447
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727057AbfDIVly (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846104; bh=l6hRzUHs1qLEfXiPo6JWIN35aWkJvJ1zUm6OHnbsNzM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=kbdlnl+pv+6zUqnIVxnOjJ81uQeaNWrSds9jTGAW1YtIcpoYlVDoleZEJX+4O+suEorDKfRm0UnzJfhydzL0IK7pRaP9BT60VyDuiJKjFCsSvIWRCEsJ85nRaCo+GceMbQZPP51iQPt1cB9evCxKZ2gTynTuDzq2n/O1d/w/gki+1yTSz902OK9UzTKHVjFmEi9K565SSNILk5eRsIaEjByneNs9wov967nEY5BE6JbjYGCzihV/L84LRoW1GLpEM67x94McRu6FGoIU4NmuC5u1r+xnI0hlVObUoHJma9aiCVqc3nMZcMCPkcOj5dAxugNRdRJ/NAzPOOn9N55M3g==
X-YMail-OSG: iNBbxMoVM1n0V4dQ4RxuRHlQRJ0gmlrcl5I5kZmo_RZpHuGnFygTPrgxXvVQRjF
 sbmi_fYRiRx6T3MKmCVAGOMS5bw.tQYaazhayV6By6lGEJ4oS0.SbNPZY9qR8fI434vrOjXHQetd
 9GI3cTxmqvZj8JyfQK9zmeBMDldk53ydAcEp8n.IyMul5lBqU3F9dHabUvyOgTqyz0aHFVbRt86X
 1Pt0gQ_MEjS0VMinVE1f7f._J3jSD0zzyH4Pv30Zw2k0zotwkwvGJSbtfZQwW4pZ6tTWEMCFUSkn
 FzsSQge4UVIsFxPubJeUXlPxqvM_KcwuD_1lHV.oq2oi6c_KwxL2TAGeE0bw3rB6faUVdZoRzqDX
 55dOSJO4YO5T6E7_1FuNeM0RGRRpYaRFlXwkvesKLrVbu2kq6fqs5YLvhIHFi31jyPqItXu.0yOo
 CcK66pQHKEyyZX_DdDKcGyxw7Sg6nyJBo0QPa_Kj988aCzUb8MH5XC3GcR_VRYwDmrjIzSwCbulb
 CxlZ3pAXX0cOXxMlGUtxfUnDwwjP3tVNX3yRaqhmaS9bPuDux7NJUmn.KJy62CrrBJcTCzoJOsVL
 rJkQMyuFKmZZGFmu.99v_rFK8d_GCxxcCOR8TEjIy3tgLb.PuBw1IkuU.zZNjtyPFxU286EgVd1U
 XP9NK7ITLamzTJmmYPKHNW5t8ABMxeMlpufiHGEzzz3m_SKrXQNE015q.CojYT.g505j3rgdjE_X
 6zb.LTXi9YfAhP5hU1XsdI.9XPyTTga55JO6xMwhMbCke6jWkPFlT5q1qAX0bQDESUtAdy6tipIq
 gkPAPGd3f7i3Ol4yOHwOOs8mI7UTloVKlxss8CNcuy8FmCwBkk4CIWXTjdH.iDWxs93Q2O5koAJT
 t3NZFw8q2F.QlzsmJ5cPfUudCfk5k32I8UdQVnEvd1NHwlDa1m0Ps0btD9XG7gsp3eMLuKCXPckL
 1Uf_yag5fXzGGGlpfA4lRhYx5iz6Ki4mohm0Jsc8orwdWx7AclFZfJGD4hMUMsJUQ06okiWWX_v2
 jYf1IIOHkFSdjEQN.Ifc5UDN3YPwy4CsGUTEtk63G.9xJRrlYKJyXv_Ou0mN6Pz_Bxq6xEOVU_Ie
 OVUWh4mqJajUdtkNsCeFy6XflfzbYUuMyuAo77oLwvedVrNbXVjop139z5qU.1w--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:44 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp416.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3e563602cfa877b5908e791085320721;
          Tue, 09 Apr 2019 21:41:27 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 56/59] LSM: Special handling for secctx lsm hooks
Date:   Tue,  9 Apr 2019 14:39:43 -0700
Message-Id: <20190409213946.1667-57-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Create a special set of LSM hooks for the translation
to human readable security data.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h | 10 ++++++++++
 security/security.c       | 32 ++++++++++++++++++++++++--------
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 014791349bbd..0653f295897a 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2040,6 +2040,16 @@ struct security_hook_list {
 	char				*lsm;
 } __randomize_layout;
 
+/*
+ * The set of hooks that may be selected for a specific module.
+ */
+struct lsm_one_hooks {
+	char *lsm;
+	union security_list_options secid_to_secctx;
+	union security_list_options secctx_to_secid;
+	union security_list_options socket_getpeersec_stream;
+};
+
 /*
  * Security blob size or offset data.
  */
diff --git a/security/security.c b/security/security.c
index ce50054f58a0..29149db3f78a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -435,6 +435,9 @@ static int lsm_append(char *new, char **result)
 	return 0;
 }
 
+/* Base list of once-only hooks */
+struct lsm_one_hooks lsm_base_one;
+
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
  * @hooks: the hooks to add
@@ -451,6 +454,25 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	for (i = 0; i < count; i++) {
 		hooks[i].lsm = lsm;
 		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
+
+		/*
+		 * Check for the special hooks that are restricted to
+		 * a single module to create the base set. Use the hooks
+		 * from that module for the set, which may not be complete.
+		 */
+		if (lsm_base_one.lsm && strcmp(lsm_base_one.lsm, hooks[i].lsm))
+			continue;
+		if (hooks[i].head == &security_hook_heads.secid_to_secctx)
+			lsm_base_one.secid_to_secctx = hooks[i].hook;
+		else if (hooks[i].head == &security_hook_heads.secctx_to_secid)
+			lsm_base_one.secctx_to_secid = hooks[i].hook;
+		else if (hooks[i].head ==
+				&security_hook_heads.socket_getpeersec_stream)
+			lsm_base_one.socket_getpeersec_stream = hooks[i].hook;
+		else
+			continue;
+		if (lsm_base_one.lsm == NULL)
+			lsm_base_one.lsm = kstrdup(hooks[i].lsm, GFP_KERNEL);
 	}
 	if (lsm_append(lsm, &lsm_names) < 0)
 		panic("%s - Cannot get early memory.\n", __func__);
@@ -729,14 +751,8 @@ int lsm_superblock_alloc(struct super_block *sb)
 
 #define call_one_int_hook(FUNC, IRC, ...) ({			\
 	int RC = IRC;						\
-	do {							\
-		struct security_hook_list *P;			\
-								\
-		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
-			RC = P->hook.FUNC(__VA_ARGS__);		\
-			break;					\
-		}						\
-	} while (0);						\
+	if (lsm_base_one.FUNC.FUNC)				\
+		RC = lsm_base_one.FUNC.FUNC(__VA_ARGS__);	\
 	RC;							\
 })
 
-- 
2.19.1

