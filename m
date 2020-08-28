Return-Path: <SRS0=arMl=CG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16622C433E2
	for <selinux@archiver.kernel.org>; Fri, 28 Aug 2020 16:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE598208C9
	for <selinux@archiver.kernel.org>; Fri, 28 Aug 2020 16:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KzpF/wd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgH1QAq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:00:46 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44760 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgH1QAe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Aug 2020 12:00:34 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2023D20B36E7;
        Fri, 28 Aug 2020 09:00:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2023D20B36E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598630433;
        bh=rFS7E9EDFK2NArtUO3BlDUuIRiMcxaSWtbaQ0LSrhHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KzpF/wd+aA6rwHO+q6X+ytLf4Zit/tOWra0KBylE8WuFSrDJsCGifaBLh+1RUbbTl
         FBPLmMJ/ckkMURFTfM3isJnTZi4vEDBjKHrjqiNxN13CtDifFool7ToFXkHLE1kKlS
         c46W67h1IpWckpArWJXeeeHxMcFXc7L8tLQCqu1U=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com
Cc:     tyhicks@linux.microsoft.com, tusharsu@linux.microsoft.com,
        sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] IMA: Support early boot measurement of critical data
Date:   Fri, 28 Aug 2020 09:00:21 -0700
Message-Id: <20200828160021.11537-4-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200828160021.11537-1-nramas@linux.microsoft.com>
References: <20200828160021.11537-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The IMA hook, namely ima_measure_critical_data(), to measure kernel
critical data requires a custom IMA policy to be loaded.

Update ima_measure_critical_data() to utilize early boot measurement
support to defer processing data if a custom IMA policy is not yet
loaded.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 41be4d1d839e..ce0ef310c575 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -885,12 +885,22 @@ int ima_measure_critical_data(const char *event_name,
 			      const void *buf, int buf_len,
 			      bool measure_buf_hash)
 {
+	bool queued = false;
+
 	if (!event_name || !event_data_source || !buf || !buf_len)
 		return -EINVAL;
 
 	if (!ima_kernel_data_source_is_supported(event_data_source))
 		return -EPERM;
 
+	if (ima_should_queue_data())
+		queued = ima_queue_data(event_name, buf, buf_len,
+					event_data_source, CRITICAL_DATA,
+					measure_buf_hash);
+
+	if (queued)
+		return 0;
+
 	return process_buffer_measurement(NULL, buf, buf_len, event_name,
 					  CRITICAL_DATA, 0, event_data_source,
 					  measure_buf_hash);
-- 
2.28.0

