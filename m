Return-Path: <SRS0=vGri=CY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106D7C43461
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 17:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7D61208E4
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 17:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mPWeboOD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgIOReU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Sep 2020 13:34:20 -0400
Received: from linux.microsoft.com ([13.77.154.182]:48520 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbgIOReK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Sep 2020 13:34:10 -0400
Received: from chpebeni.pebenito.net (pool-108-15-23-247.bltmmd.fios.verizon.net [108.15.23.247])
        by linux.microsoft.com (Postfix) with ESMTPSA id 15BDF20A1AF8;
        Tue, 15 Sep 2020 10:34:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 15BDF20A1AF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600191250;
        bh=YnZ8nh2/TJDYNPtq1VLi3JErbIBF08S1SGEPH+VEpDE=;
        h=From:To:Cc:Subject:Date:From;
        b=mPWeboODp5rnqWHlZYdImTvTCv54+yQ4xOiAPQ6LChObG9llyVA84tcJTtrQtNX7y
         lG/QErUKZfL9AgqdVfTGfQTXhJjbs9Dju/xdYKN6+TW4y/zkNLEBEbw6sMT6rChNf7
         8dn217w/NqHsbEbAhI1ZWEHq0JUcZAoQF9YgnFqw=
From:   Chris PeBenito <chpebeni@linux.microsoft.com>
To:     selinux@vger.kernel.org
Cc:     sgrubb@redhat.com
Subject: [PATCH 1/2] libselinux: Add additional log callback details in man page for auditing.
Date:   Tue, 15 Sep 2020 13:33:31 -0400
Message-Id: <20200915173332.574700-1-chpebeni@linux.microsoft.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add additional information about the log callback message types.  Indicate
which types could be audited and the relevant audit record types for them.

Signed-off-by: Chris PeBenito <chpebeni@linux.microsoft.com>
---
 libselinux/man/man3/selinux_set_callback.3 | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/libselinux/man/man3/selinux_set_callback.3 b/libselinux/man/man3/selinux_set_callback.3
index 6dfe5ff6..75f49b06 100644
--- a/libselinux/man/man3/selinux_set_callback.3
+++ b/libselinux/man/man3/selinux_set_callback.3
@@ -51,6 +51,15 @@ argument indicates the type of message and will be set to one of the following:
 
 .B SELINUX_SETENFORCE
 
+SELINUX_ERROR, SELINUX_WARNING, and SELINUX_INFO indicate standard log severity
+levels and are not auditable messages.
+
+The SELINUX_AVC, SELINUX_POLICYLOAD, and SELINUX_SETENFORCE message types can be
+audited with AUDIT_USER_AVC, AUDIT_USER_MAC_POLICY_LOAD, and AUDIT_USER_MAC_STATUS
+values from libaudit, respectively.  If they are not audited, SELINUX_AVC should be
+considered equivalent to SELINUX_ERROR; similarly, SELINUX_POLICYLOAD and
+SELINUX_SETENFORCE should be considered equivalent to SELINUX_INFO.
+
 .
 .TP
 .B SELINUX_CB_AUDIT
-- 
2.26.2

