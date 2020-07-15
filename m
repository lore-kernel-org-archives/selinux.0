Return-Path: <SRS0=JLv6=A2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C45C43457
	for <selinux@archiver.kernel.org>; Wed, 15 Jul 2020 15:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C9A2065E
	for <selinux@archiver.kernel.org>; Wed, 15 Jul 2020 15:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bZ8yXgGD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgGOPti (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:49:38 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45944 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgGOPtA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jul 2020 11:49:00 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id D3AAA20B490E;
        Wed, 15 Jul 2020 08:48:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D3AAA20B490E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594828140;
        bh=mt9WRyN0K0mzACad6GlGI3HgDlUI75SH8oC6SKEyiMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bZ8yXgGDaH7urVxRxxM++HSvnS6y6t2xPiZ3xpoXfjiJ5nKL3fB0zrdqtU8Y+p5Hd
         FenGfLez3cKpkI9GZ4rc3vLDj5nhUFk3VBwR7qLpBGTCCgqLcOG5dgFk3pG+uxk4kY
         u5uINadxvFX/hr6XYygFY1GOE0a9zfWaMP+a3qAQ=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com
Cc:     jmorris@namei.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] LSM: Define workqueue for measuring security module state
Date:   Wed, 15 Jul 2020 08:48:53 -0700
Message-Id: <20200715154853.23374-6-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200715154853.23374-1-nramas@linux.microsoft.com>
References: <20200715154853.23374-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Data structures critical to the functioning of a security module could
be tampered with by malware or changed inadvertently at runtime
thereby disabling or reducing the security guarantees provided by
the security module. Such critical data need to be periodically checked
and measured, if there is any change. This would enable an attestation
service, for instance, to verify that the security modules are operating
with the configuration and policy setup by the system administrator.

Define a workqueue in the LSM and invoke the security modules in
the workqueue handler to check their data and measure.

Note that the data given by the security module would be measured by
the IMA subsystem only if it has changed since the last time it was
measured.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/security.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/security/security.c b/security/security.c
index 3fbabc2e6ddb..6a0ceff815a2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -89,6 +89,11 @@ static __initdata struct lsm_info *exclusive;
 static struct lsm_info *security_state_lsms;
 static int security_state_lsms_count;
 
+static long security_state_timeout = 300000; /* 5 Minutes */
+static void security_state_handler(struct work_struct *work);
+static DECLARE_DELAYED_WORK(security_state_delayed_work,
+			    security_state_handler);
+
 static __initdata bool debug;
 #define init_debug(...)						\
 	do {							\
@@ -277,6 +282,26 @@ static void __init initialize_security_state_lsms(void)
 	security_state_lsms_count = count;
 }
 
+static void initialize_security_state_monitor(void)
+{
+	if (security_state_lsms_count == 0)
+		return;
+
+	schedule_delayed_work(&security_state_delayed_work,
+			      msecs_to_jiffies(security_state_timeout));
+}
+
+static void security_state_handler(struct work_struct *work)
+{
+	int inx;
+
+	for (inx = 0; inx < security_state_lsms_count; inx++)
+		measure_security_state(&(security_state_lsms[inx]));
+
+	schedule_delayed_work(&security_state_delayed_work,
+			      msecs_to_jiffies(security_state_timeout));
+}
+
 /* Populate ordered LSMs list from comma-separated LSM name list. */
 static void __init ordered_lsm_parse(const char *order, const char *origin)
 {
@@ -400,6 +425,7 @@ static void __init ordered_lsm_init(void)
 	}
 
 	initialize_security_state_lsms();
+	initialize_security_state_monitor();
 
 	kfree(ordered_lsms);
 }
-- 
2.27.0

