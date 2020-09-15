Return-Path: <SRS0=vGri=CY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-25.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1CEC433E2
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 13:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAAD220829
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 13:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cMFkNJ53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgIONHc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Sep 2020 09:07:32 -0400
Received: from linux.microsoft.com ([13.77.154.182]:42476 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgIONHN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Sep 2020 09:07:13 -0400
Received: from chpebeni.pebenito.net (pool-108-15-23-247.bltmmd.fios.verizon.net [108.15.23.247])
        by linux.microsoft.com (Postfix) with ESMTPSA id 56DFB20A1B07;
        Tue, 15 Sep 2020 06:07:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 56DFB20A1B07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600175232;
        bh=On3aP50y00oGqtkCdzV6Lmvkk9VeYiRAn+Fwe+jgSTM=;
        h=From:To:Cc:Subject:Date:From;
        b=cMFkNJ53MtuN0bkpiT5wwfQmICmB8o95dDjHGGpz4cXjHYbBp1063jdXF7pUYXAub
         oRKLVubWcBC9hx/qyvXuzqDkiC7rvBmc0L0zQTp5kUCHxvjvrXq3rx+YI8s0dnOJlL
         HNxPvWvw4F0jDVCMjfTxwnm6WH8UV1gqUkEAtTKg=
From:   Chris PeBenito <chpebeni@linux.microsoft.com>
To:     selinux@vger.kernel.org
Cc:     sgrubb@redhat.com
Subject: [RFC PATCH 1/1] libselinux: Revise userspace AVC avc_log() for auditable events.
Date:   Tue, 15 Sep 2020 09:05:16 -0400
Message-Id: <20200915130516.561693-1-chpebeni@linux.microsoft.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I put up a PR for dbus-broker to revise its auditing:

https://github.com/bus1/dbus-broker/pull/240

Steve Grubb mentioned that there wasn't much useful info in terms of the audit
message itself, since it isn't key:value pairs.

I'm looking to revise the avc_log() messages for SELINUX_ERROR,
SELINUX_SETENFORCE, and SELINUX_POLICYLOAD messages such that they
more closely reseble the kernel audits.

*This patch is _incomplete*; I implemented a few changes to get early feedback
on the direction I'm taking.  What seems potentially contentious is the
'lsm=selinux_uavc' and op= choices.

Signed-off-by: Chris PeBenito <chpebeni@linux.microsoft.com>
---
 libselinux/src/avc_internal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.c
index 572b2159..35ea59b6 100644
--- a/libselinux/src/avc_internal.c
+++ b/libselinux/src/avc_internal.c
@@ -59,14 +59,14 @@ int avc_process_setenforce(int enforcing)
 	int rc = 0;
 
 	avc_log(SELINUX_SETENFORCE,
-		"%s:  received setenforce notice (enforcing=%d)\n",
+		"%s:  op=setenforce lsm=selinux_uavc enforcing=%d res=1",
 		avc_prefix, enforcing);
 	if (avc_setenforce)
 		goto out;
 	avc_enforcing = enforcing;
 	if (avc_enforcing && (rc = avc_ss_reset(0)) < 0) {
 		avc_log(SELINUX_ERROR,
-			"%s:  cache reset returned %d (errno %d)\n",
+			"%s:  op=cache_reset lsm=selinux_uavc rc=%d errno=%d res=0",
 			avc_prefix, rc, errno);
 		return rc;
 	}
@@ -81,12 +81,12 @@ int avc_process_policyload(uint32_t seqno)
 	int rc = 0;
 
 	avc_log(SELINUX_POLICYLOAD,
-		"%s:  received policyload notice (seqno=%u)\n",
+		"%s:  op=load_policy lsm=selinux_uavc seqno=%u res=1",
 		avc_prefix, seqno);
 	rc = avc_ss_reset(seqno);
 	if (rc < 0) {
 		avc_log(SELINUX_ERROR,
-			"%s:  cache reset returned %d (errno %d)\n",
+			"%s:  op=cache_reset lsm=selinux_uavc rc=%d errno=%d res=0",
 			avc_prefix, rc, errno);
 		return rc;
 	}
@@ -157,7 +157,7 @@ static int avc_netlink_receive(void *buf, unsigned buflen, int blocking)
 		return -1;
 	}
 	else if (rc < 1) {
-		avc_log(SELINUX_ERROR, "%s:  netlink poll: error %d\n",
+		avc_log(SELINUX_ERROR, "%s:  op=netlink_poll lsm=selinux_uavc errno=%d res=0",
 			avc_prefix, errno);
 		return rc;
 	}
@@ -214,7 +214,7 @@ static int avc_netlink_process(void *buf)
 
 		errno = -err->error;
 		avc_log(SELINUX_ERROR,
-			"%s:  netlink error: %d\n", avc_prefix, errno);
+			"%s:  op=netlink_msgtype lsm=selinux_uavc errno=%d res=0", avc_prefix, errno);
 		return -1;
 	}
 
-- 
2.26.2

