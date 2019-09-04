Return-Path: <SRS0=KzaI=W7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1674BC3A5A7
	for <selinux@archiver.kernel.org>; Wed,  4 Sep 2019 14:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD191206B8
	for <selinux@archiver.kernel.org>; Wed,  4 Sep 2019 14:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="jwgefeTZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730789AbfIDOc4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Sep 2019 10:32:56 -0400
Received: from UCOL19PA36.eemsg.mail.mil ([214.24.24.196]:58417 "EHLO
        UCOL19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729809AbfIDOc4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Sep 2019 10:32:56 -0400
X-EEMSG-check-017: 18260180|UCOL19PA36_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,467,1559520000"; 
   d="scan'208";a="18260180"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Sep 2019 14:32:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1567607575; x=1599143575;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VzY6taYiQKl7/EZs+QJiU0pAy7Rw+at0mdSJNitmD10=;
  b=jwgefeTZKP0XmgwNg/3Z7nrxGb4XUR7pg3pxDHwkCCD2mFmT2y60zizF
   Wdyomvft8XtZzvId8VPTGglji4A93cfZQHDzO/FL1QNqIGa8CaNfpnQZt
   FOy2ZkzWlBvyFCumQ/azfmPUZlXku1EBtjX9+NkQ+AvV5+rNHdsE/Oxzb
   bNeRfKEVESuEhpf42YO2Y/W2pSKOKbQSGwy0bkyWAE65p6lQVjNyt1m3G
   Hq3IbG1zSHBfMacSgNY5yxXEySpBZkeojJy66z1rNKuPzveJSsjBZghY0
   8QyV66KzwELSg/u0HVEVEblT/wrS2Gz808QRkobS8q5kv5djwrR8QSsFh
   g==;
X-IronPort-AV: E=Sophos;i="5.64,467,1559520000"; 
   d="scan'208";a="27501681"
IronPort-PHdr: =?us-ascii?q?9a23=3Al8CNXB2AehwafVwDsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesXK/3xwZ3uMQTl6Ol3ixeRBMOHsqgC0rWL+P+9EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCejbb9oMRm7rwXcusYUjIZiN6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjhykdNz497WrZlMp+gqxGqx6lvhByw4rZbISTOfFjfK3SYMkaSH?=
 =?us-ascii?q?JBUMhPSiJPDICyYYwAAOQOJutUs4rwqkESoRakGQWgGOXiwSJIiH/s2q061v?=
 =?us-ascii?q?wsHxza3AM+B9IOsGrbrNPoP6kPVOC61q3IzTHdYPJWxDzw75PIfQ06ofyXQb?=
 =?us-ascii?q?JxcdbeyUkoFw/fiFWQspbqMyma1uQKrWiW9uxtXv+shW4/swx9vzeiy8g2ho?=
 =?us-ascii?q?TJm44Z0E7I+CpnzIovONG1TlNwb8S+H5tKrS6aMpN7QsYlQ251pik30qYGuZ?=
 =?us-ascii?q?unfCgSz5Qn2gLfZ+SHc4eW5hLjU/6cIStii3J/ebK/mg2y/VK8yuz8Ssa00F?=
 =?us-ascii?q?FKojBDktbQrXACywbf6s2GSvt55kuh2DCP2B7P6uxcPEw5mqXWJ4Qhz7ItjJ?=
 =?us-ascii?q?Yfr0vOEjHslEnrlKOWc18r+ums6+TpeLXmoZqcOpdvig7jKaQjgdC/AOQkPQ?=
 =?us-ascii?q?gOWGiX4+K81Kb58kHjT7VKieM2nrHDsJ/GPcQburK5AwhN34k+6xa/CDmn38?=
 =?us-ascii?q?ocnXkDN1JIYwiHgJb0NFHOOv/4Ee2zjEirkDdu3/rGJKHuAo3RLnjfl7fsZb?=
 =?us-ascii?q?R960tbyAop19Bf5olUB6oHIP3pX0/+qt3YAgU+MwyuzObtEM992Z8GWWKTHq?=
 =?us-ascii?q?+ZN7vfsVuJ5uIpPumNa5YZuC3jJPc5+v7ul345mUMdfKWw2JsXb223HuliI0?=
 =?us-ascii?q?qHenfsnNgBHnkQvgYkT+zllkeCUThNaHa2Ra484Ss7CI2+B4fZWo+tmKCB3D?=
 =?us-ascii?q?u8HpBOfWBJFFSMEXbud4WZVPYBczySIsB/nTweT7ShSJEu1QuotADkz7prNO?=
 =?us-ascii?q?3U+jcXtZj7zth6+/XTlQ0u9TxzF8mSz3uCT3pqkWIIXDI2x7xwoUxnxVee36?=
 =?us-ascii?q?h4h+JXFcZK6/xVSAg2L4LTz+t/C9rqQALOYs+JSEq6QtWhGTwxTcw+zMEVY0?=
 =?us-ascii?q?lhHNWiiRPD0jG2DL8VjbyLA5k08qPB33j0Pcp9zGzG1KY5hVk8XsRPLXGmhr?=
 =?us-ascii?q?J49wXLH47GiViZl6KxeKQExiHN6WODwXOLvEFfVw5wS7vKUWoDaUvRqNSqrn?=
 =?us-ascii?q?/FGqenFLAPKgJczYuHLaxQZ5viilAVau3kPYHlf2+pm2q2TS2Nz7eIYZuiL3?=
 =?us-ascii?q?4Rxw3BGUMElEYV5n/AOg8gUHTy61nCBSBjQAq8K3jn9vNz/TbmH0I=3D?=
X-IPAS-Result: =?us-ascii?q?A2CTBQBqym9d/wHyM5BlHQEBBQEHBQGBZ4FuKoFAMiqTf?=
 =?us-ascii?q?QEBBosligeHHwkBAQEBAQEBAQEbGQECAQGEP4I0IzgTAgsBAQEEAQEBAQEGA?=
 =?us-ascii?q?wEBbIU6gjopgxULAUaBUYJjP4F3FKsQM4kFgUmBNIcfhFkYeIEHgRGDUIURh?=
 =?us-ascii?q?RYEjE+IIJc1gimCKIlYiFUMG5hqAS2oKCGBWCsIAhgIIQ+DJ4JOF44+JAMwg?=
 =?us-ascii?q?QYBAY5zAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 04 Sep 2019 14:32:54 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x84EWrQc009825;
        Wed, 4 Sep 2019 10:32:53 -0400
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     keescook@chromium.org, casey@schaufler-ca.com,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        jmorris@namei.org, dhowells@redhat.com,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux: fix residual uses of current_security() for the SELinux blob
Date:   Wed,  4 Sep 2019 10:32:48 -0400
Message-Id: <20190904143248.7003-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

We need to use selinux_cred() to fetch the SELinux cred blob instead
of directly using current->security or current_security().  There
were a couple of lingering uses of current_security() in the SELinux code
that were apparently missed during the earlier conversions. IIUC, this
would only manifest as a bug if multiple security modules including
SELinux are enabled and SELinux is not first in the lsm order. After
this change, there appear to be no other users of current_security()
in-tree; perhaps we should remove it altogether.

Fixes: bbd3662a8348 ("Infrastructure management of the cred security blob")
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/hooks.c          |  2 +-
 security/selinux/include/objsec.h | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d55571c585ff..f1b763eceef9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3435,7 +3435,7 @@ static int selinux_inode_copy_up_xattr(const char *name)
 static int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
 					struct kernfs_node *kn)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	u32 parent_sid, newsid, clen;
 	int rc;
 	char *context;
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 231262d8eac9..d2e00c7595dd 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -40,16 +40,6 @@ struct task_security_struct {
 	u32 sockcreate_sid;	/* fscreate SID */
 };
 
-/*
- * get the subjective security ID of the current task
- */
-static inline u32 current_sid(void)
-{
-	const struct task_security_struct *tsec = current_security();
-
-	return tsec->sid;
-}
-
 enum label_initialized {
 	LABEL_INVALID,		/* invalid or not initialized */
 	LABEL_INITIALIZED,	/* initialized */
@@ -188,4 +178,14 @@ static inline struct ipc_security_struct *selinux_ipc(
 	return ipc->security + selinux_blob_sizes.lbs_ipc;
 }
 
+/*
+ * get the subjective security ID of the current task
+ */
+static inline u32 current_sid(void)
+{
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
+
+	return tsec->sid;
+}
+
 #endif /* _SELINUX_OBJSEC_H_ */
-- 
2.21.0

