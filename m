Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED66FC46460
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4DEA26FE7
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="YY5koEQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfEaXSO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:18:14 -0400
Received: from sonic305-9.consmr.mail.bf2.yahoo.com ([74.6.133.48]:44776 "EHLO
        sonic305-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726798AbfEaXSO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344692; bh=GL92BlbATLhdlRxbERwtGOiRrC+zdGB2SpJVUW1Y7c8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=YY5koEQssmES3RQBFBnJESTYs2Sg85tL167VqVSIPP6OOq90Ma92jKhmn8s76exWFQiAVtBX4+q8tSR+Kdfu4g7iibrDMgapdmQYQQI4pFcQgLVh40HP1qeCvOC6Wp+9XNbnRcl+edhHmL7AXjPEj3/fUoQSS9zWEWvHzWOV1QswLjXUtd2SMMstpUU3ahKZi0dC4yMqG82sRWh/mlXKzom7CMRSthRA6xDvSfme7I0Iolh3Kf+aY4Z4p+xbZ/kg+ImK7Sf2T0uy5rCJQYi1GD39saEvWhaMbGtTlrRRC0auJz1zjJXoNMhF3ejvyGaKIrJ4HiMz/OTiu8qGSnoQTw==
X-YMail-OSG: h1J0amwVM1mu08x6nKgyzsfD_GYnthFB_yx.7iLwmdaWcSJyDe9vFQm8ip_2eMu
 Kc15OG7FTWC1pWFbof5dkboIzPRn4EvYvStxyV7_W4XBTaA0uWukLJFr2vRsdTW46z.gvCqLX2HP
 q410hEvy_ZUKXOXvDdP9V2hrTWjrg2oW1tCEiMvHMITM0LXmdk9xuYi0U3onew2nVKYZ9SgxlmMg
 iSPbp9z7Vd6Lvu_dOsDS6HJqmi8MU48A4rXXQKq7ttyJUMqFv9zF79ZlLC4e1zHzxrIzd0quzqJE
 cfad0sQo3NSiGI.K5fUvazX5NiD_.adou4wm9KpfMfX8xu4Rkgwa_3zvCkR3JheQx8vne1bsam5V
 0cK47QYucmzbfUMc59qsSXAppGXES4QU55lInDr8lxkOEuZhQ2Y2FrDFBni1ojaezySyh_jGNyiX
 i_ckDudfGBatqRuur6wGoURnvcGaqYUYcQ0XrgzZN6.szHdH02Dyjqq5xdBSfMEBiTViCzQxYvy9
 nA02ojNP7wo_CjJXLQQteN0zx69hjOzLVF5zpn.FhH3UatNlplzBkDVC2vkBZ7Si6X8BTEtPHLhm
 vebDytNtQv3Gy8sQA5MMhj3LEGqY9ms5lLnTp.wQsYL54AmKexE4WOYSEJrHsOSRUG7hEwjfPbpl
 Bfh5KHNCN1uXBQIwiPRaLed_tQsI1ggDpHSSsXA2HNFJjAunpsd7En3_VTTKx4mQADAgXbKhXVtx
 1BV1Ve0udWI_ysUT9R2AZfbUdwu1P.kVVIuZeGdWtZe0hbZOsQxtXy8r9LcvHP9Ujj0_Q7RtAdIx
 A8bKbGN2R6m0a9XlFYNTtDIASRihZIq2fOHiYRPo4WOpzcwgR.hiQMbEQ6E72IjFb77M39g8hhls
 HihkEqULAkr5whO46zMSXT5zonuehnRYAXTPQ0ZybO_yNMpDepU5VuV_FbakYTqFliR0ZF8IJgg4
 gyb2KM745fsJBBTDxv40.XB7mv3cLC6Miij3FO0N3rk0qqkWEDqlcPmU1xaMODB.qmfTJ.YqxwQ9
 QZmnVi9HyEBOmwlIoIk1n.piwKgEZQQMPw8C2pxBt..qI27NOU14OuWhPR7K4lwzXzebPBrHeR_d
 eAfXA7TvWRG_fWjbgmFizjFrejyVQQjRpPnOBBjKZouydSfoZhp9oLkNOhAi9pPOygTh2jZWCiV0
 xV5jrftLivaFbw8ihP8jgiGcFRXB_G8KmjbGPBwl42oQ.S4vP8aLk0VFWnOK5fC178TJORT4zOQY
 JFacaW6L4XR2WGBkLjyn44kX9cvfkwJPaLAzHzXliSKFf9VStTCgsWMgy
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Fri, 31 May 2019 23:18:12 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp411.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 92e9b7c7b89b418ca5baa88a2cbfd034;
          Fri, 31 May 2019 23:18:12 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 42/58] LSM: Use lsm_context in security_dentry_init_security
Date:   Fri, 31 May 2019 16:10:04 -0700
Message-Id: <20190531231020.628-43-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Casey Schaufler <cschaufler@schaufler-ca.com>

Convert security_dentry_init_security to use the lsm_context structure
instead of a context/secid pair. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/nfs/nfs4proc.c        |  5 ++++-
 include/linux/security.h |  7 +++----
 security/security.c      | 14 ++++----------
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 4dbb0ee23432..de000649f9f3 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -113,6 +113,7 @@ static inline struct nfs4_label *
 nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 	struct iattr *sattr, struct nfs4_label *label)
 {
+	struct lsm_context lc; /* Scaffolding -Casey */
 	int err;
 
 	if (label == NULL)
@@ -122,7 +123,9 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 		return NULL;
 
 	err = security_dentry_init_security(dentry, sattr->ia_mode,
-				&dentry->d_name, (void **)&label->label, &label->len);
+					    &dentry->d_name, &lc);
+	label->label = lc.context;
+	label->len = lc.len;
 	if (err == 0)
 		return label;
 
diff --git a/include/linux/security.h b/include/linux/security.h
index e12b169deed6..6c3a74a44a59 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -302,8 +302,8 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
 int security_add_mnt_opt(const char *option, const char *val,
 				int len, void **mnt_opts);
 int security_dentry_init_security(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen);
+					const struct qstr *name,
+					struct lsm_context *cp);
 int security_dentry_create_files_as(struct dentry *dentry, int mode,
 					struct qstr *name,
 					const struct cred *old,
@@ -674,8 +674,7 @@ static inline void security_inode_free(struct inode *inode)
 static inline int security_dentry_init_security(struct dentry *dentry,
 						 int mode,
 						 const struct qstr *name,
-						 void **ctx,
-						 u32 *ctxlen)
+						 struct lsm_context *cp)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index c04b334370a5..628287180ce7 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1014,17 +1014,11 @@ void security_inode_free(struct inode *inode)
 }
 
 int security_dentry_init_security(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen)
+					const struct qstr *name,
+					struct lsm_context *cp)
 {
-	struct lsm_context lc = { .context = NULL, .len = 0, };
-	int rc;
-
-	rc = call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
-				name, &lc);
-	*ctx = (void *)lc.context;
-	*ctxlen = lc.len;
-	return rc;
+	return call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
+			     name, cp);
 }
 EXPORT_SYMBOL(security_dentry_init_security);
 
-- 
2.19.1

