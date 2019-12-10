Return-Path: <SRS0=5m9B=2A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC89C04E30
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 02:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF1F2080D
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 02:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="c8GYnrmr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfLJC2z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Dec 2019 21:28:55 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35612 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbfLJC2y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Dec 2019 21:28:54 -0500
Received: by mail-qt1-f193.google.com with SMTP id s8so1375735qte.2
        for <selinux@vger.kernel.org>; Mon, 09 Dec 2019 18:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=FYqGJ1X4T1UO7XLK6Jwmfc00AN5N7pd5UpCiH4kkXbQ=;
        b=c8GYnrmrQEkmzMUqWRJtf9/TYM8KOlazobxKoHy6tLxVxadgPkrSbADXZSt2ImGDcT
         H+P654U80gjbbfe+PtajYXpBD7Dc1MQrxK9AVFVH9Ad1JdssrEG+dmxV8hiQgocKKQd6
         TRF2BRKM+B0iqBDU0SYPli197DGUpGOSfEz9aEJbEAfjuk9Fufz3wsEXcPz+E8KoJ7bx
         bKoSId6bnq+sv8LO2uCaRb7G+VXi3TBwdVVfMqEKvwJFEWSUpqOKUQi1UnSEyG1spRUK
         /tqcSqtx8YmtlUVrdji4dWyDGZQ1HqOZ+3HdLw6vch26uQbDuTzVlMxSyPRbT/fchglW
         SJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=FYqGJ1X4T1UO7XLK6Jwmfc00AN5N7pd5UpCiH4kkXbQ=;
        b=EeUlDVMNO33VWQdGVdqtsp37v3ZLoGlG9Oh31Wj+Rzwy79feoHGxj+aLyjqdp7X670
         ErkyvF69J/zNJHH8sW0MTvWDwdIWVa4jTbCgrr7Z4h2JR4MfaLLjw4EG79PTpUFqdogy
         yKDoKj87D/wiF/wLZTVz26PEQnxe0E661sCSKlH3Exq5gddKgjRLMric2Fk1GHxHAggO
         guzlRdWL024YfByr5t/R6/D8LJGJ9ZuitgHZBn7+1OiyrIK8PMRXi7CdSmyZiJziBUlB
         nQgKoLwlaMn1///0kyBTMdUjmn1fsMNkjVF2hBJHsCr4bk6j/cq1EKFVhguH3cLRuMsZ
         sS+Q==
X-Gm-Message-State: APjAAAUl9efoPb7ugCwnRxmzYFXUPZw951Vtwg/0Z/u6iyQ6W1f1DTjv
        pqajA9p1Zhwa6/7X2f/eNZOuKdoQlZlT
X-Google-Smtp-Source: APXvYqz44Y9+4yFvD+lbQEvXNBgH1oI/VzxvWcT+TjjJpE9pJWiNwuV11k40kWlUMR74IJRsl0BNpA==
X-Received: by 2002:ac8:5205:: with SMTP id r5mr28581499qtn.230.1575944932650;
        Mon, 09 Dec 2019 18:28:52 -0800 (PST)
Received: from localhost (static-96-233-112-89.bstnma.ftas.verizon.net. [96.233.112.89])
        by smtp.gmail.com with ESMTPSA id o19sm623953qtb.43.2019.12.09.18.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 18:28:51 -0800 (PST)
Subject: [RFC PATCH] security: add an interface to lookup the lockdown reason
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     linux-next@vger.kernel.org, sds@tycho.nsa.gov,
        jamorris@linux.microsoft.com
Date:   Mon, 09 Dec 2019 21:28:50 -0500
Message-ID: <157594493094.748324.9234611948545428995.stgit@chester>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

With CONFIG_AUDIT enabled but CONFIG_SECURITY disabled we run into
a problem where the lockdown reason table is missing.  This patch
attempts to fix this by hiding the table behind a lookup function.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/security.h |    7 +++++++
 security/lsm_audit.c     |   12 +++++++++---
 security/security.c      |    5 +++++
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 64b19f050343..295509a809d6 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -447,6 +447,8 @@ int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 int security_locked_down(enum lockdown_reason what);
+const char *security_locked_reasonstr(enum lockdown_reason what);
+
 #else /* CONFIG_SECURITY */
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
@@ -1274,6 +1276,11 @@ static inline int security_locked_down(enum lockdown_reason what)
 {
 	return 0;
 }
+
+static inline const char *security_locked_reasonstr(enum lockdown_reason what)
+{
+	return NULL;
+}
 #endif	/* CONFIG_SECURITY */
 
 #ifdef CONFIG_SECURITY_NETWORK
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 2d2bf49016f4..519ef6046638 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -426,10 +426,16 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 				 a->u.ibendport->dev_name,
 				 a->u.ibendport->port);
 		break;
-	case LSM_AUDIT_DATA_LOCKDOWN:
-		audit_log_format(ab, " lockdown_reason=");
-		audit_log_string(ab, lockdown_reasons[a->u.reason]);
+	case LSM_AUDIT_DATA_LOCKDOWN: {
+		const char *str = security_locked_reasonstr(a->u.reason);
+
+		if (str) {
+			audit_log_format(ab, " lockdown_reason=");
+			audit_log_string(ab, str);
+		} else
+			audit_log_format(ab, " lockdown_reason=?");
 		break;
+	}
 	} /* switch (a->type) */
 }
 
diff --git a/security/security.c b/security/security.c
index 2b5473d92416..2f228fdbebf5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2438,6 +2438,11 @@ int security_locked_down(enum lockdown_reason what)
 }
 EXPORT_SYMBOL(security_locked_down);
 
+const char *security_locked_reasonstr(enum lockdown_reason what)
+{
+	return lockdown_reasons[what];
+}
+
 #ifdef CONFIG_PERF_EVENTS
 int security_perf_event_open(struct perf_event_attr *attr, int type)
 {

