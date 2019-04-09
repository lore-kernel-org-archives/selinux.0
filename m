Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFDCC282CE
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090B02082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="XITBCGUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfDIVlG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:06 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:33814
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726907AbfDIVlF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846063; bh=vbPmsKchcYujFbsoTOZdCYFpnfZ1qp/ZBXWOn5HufTo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=XITBCGUdf4hlzvpYKdlZ9dm22juCfkr4Ly0mCOBQEaB6Y2sS9qHI5XWaMWx0pRxfppxSvPLTTRSIvfrMY0UBE8qI26XPV08xzMdE1PGbqeA2pFjflEBxHJuAzQ2vLMcaSA4Zd3aOrWz6d+kfrBNyfBLPdzF0KsdufZz9yeNeNs9Eu0coSnHrEuH62Ac5IR3rHaA37O9MSPLjRMK5AYJcGAL9IvPzochxUx4ZBLqviZGLmBbIaeGqHMW9qayrGTf44pcaTX1ZVQ4Rso9pUZZeYr9+s39J8P/v8Ib4B2Sh3Ba//YzRGED27VPlG7+xJGN80tSuOmQi9VSXbX3lPY1IGg==
X-YMail-OSG: qKFGFvAVM1n3.Ch8BujxaN_OZC1dIGto_I1tskiGCkYkTO2UuOw5YBD9H3OYpBG
 ZnjmQ0ou824x1UXR6VuW2VVny_Lc2L3gV3FJnnrVPVrfAJGkiuYe1.SHuJCxU8eDFc40eYqWpjFk
 ulcwwohBqy4_Ux8SqmWSryOuF_pivWoJfsEgNUQOVX5m2EtlLsVtVhGgVqEBQrHztXhANRg5XRDX
 1Ba0BJu4fWO8UlLwhzsPIhb460Aa19JaRXQKnb7Ux4ob_n1M10CnTpgRrmar9F9EzowwDpzTSCeL
 fp295QAOaCFcyBHTTOBfxX2vCZ2oMTQZ8p30hnujEJZBsSNphYJzm7EyEn3TvpaEXaX20f1h8AG9
 c75XdcFbgL4mQxbXOIe9_9rR6jVKk97M_kgHqz3zgl88D8UGqEg_nMj1iHIBlt2aPu625pHjhwy_
 c0O9b7UGVjMvSfaCuiFoIW4ViL.WVloR2UBq09Mr6JlE.hd.jMVqNOBGx13dELxdp.E8dKoqXlG.
 mLgp_X1_DJ_qm.rJp2QWMtqVECRy4W1iEMHhCXPAOM6PxoRTFsk7OsRLnddPeOQLTTRPNvMzd8m4
 I3kAJmpLMf1pO1ceChGEquJ9k3WXitbriz67IFLyHwAxgBFYU59upG2pFiKgl06rAL3hLqOZMZHm
 GwEzZcZ0QBYe7IGDo7U_QsPCoTfG7l3MTeHssJnq036Ah40EflcOwFzO0WM1We.k7zATabZJiGqP
 vQE7XUPMVNiEYjiV612cpJrlkntjOspNQSUw4C0hvI7DKYu6slH5Ge2HcgP6PLKKCXxZ6mpGybAw
 7Nc_SQe04sxSf1fnf5amSXjGn9.q.phvjBcnuSlPIbHEqqbT.m1vBBxAbjga_KlDSYa_h4EgOqx0
 Rr8LpAp9XDXjZOBUmO6F7nshg1KdaqNVpewWdaM.KJeuQ.v82TcSK_pVYYUS80LkwPJ7nImnzZrc
 IKU85ubRBTN6rRiXqZ_F0tNcAx898p9FzXB6SoHZhiLUXJgyC85YXvxzX6xpmY4U29y3ksIVM9N7
 ote8V6gzLgkVdS9eqEERV.sAtwHXc_YGTRdrCCu7jLV.hoRX3y0Pamu7RG5EDGpl2I.pPEojkJdZ
 r6AzywkUt4_xeq6vGbubFkCCy5EnDXE.Xyy_ZjhbnqHd3pF8Pz5qmEBX6ukrmzA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:03 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp408.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6a737b6f7572f7259a29fc213d8f0ed1;
          Tue, 09 Apr 2019 21:40:53 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 37/59] LSM: Create a data structure for a security context
Date:   Tue,  9 Apr 2019 14:39:24 -0700
Message-Id: <20190409213946.1667-38-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A "security context" is the text representation of
the information used by LSMs. This provides a structure
so that the use can be made consistant.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 6c44aca19c65..8dd21133ede8 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -119,6 +119,17 @@ static inline bool lsm_export_equal(struct lsm_export *l, struct lsm_export *m)
 
 extern struct lsm_export *lsm_export_skb(struct sk_buff *skb);
 
+/* Text representation of LSM specific security information - a "context" */
+struct lsm_context {
+	char	*context;
+	u32	len;
+};
+
+static inline void lsm_context_init(struct lsm_context *cp)
+{
+	memset(cp, 0, sizeof(*cp));
+}
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
-- 
2.19.1

