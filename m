Return-Path: <SRS0=vGri=CY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F8AC43461
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 17:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE535208E4
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 17:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="C4KFVzhD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgIOReQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Sep 2020 13:34:16 -0400
Received: from linux.microsoft.com ([13.77.154.182]:48522 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgIOReL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Sep 2020 13:34:11 -0400
Received: from chpebeni.pebenito.net (pool-108-15-23-247.bltmmd.fios.verizon.net [108.15.23.247])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9EA3D20A1B15;
        Tue, 15 Sep 2020 10:34:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9EA3D20A1B15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600191250;
        bh=atq6M6Tvkt1DWV59xIzdhq616ZdPeZ8f+HdH83TIsi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C4KFVzhDkn4t2WIwsATSEVee7KPcsqiwvH9Jm4pa2LT94CpDV/nawIsy27KJYJjde
         QoBn4e5hBM0XLdLfEcgzdJUKwv+1VOfLtK1sTsDbz8WrfboZ9Gfx1Le+xB1qZzICLj
         fsmpAOyLkxUIxZUeREzokuXVHPkSpS3nvq81DnYY=
From:   Chris PeBenito <chpebeni@linux.microsoft.com>
To:     selinux@vger.kernel.org
Cc:     sgrubb@redhat.com
Subject: [PATCH 2/2] libselinux: Change userspace AVC setenforce and policy load messages to audit format.
Date:   Tue, 15 Sep 2020 13:33:32 -0400
Message-Id: <20200915173332.574700-2-chpebeni@linux.microsoft.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200915173332.574700-1-chpebeni@linux.microsoft.com>
References: <20200915173332.574700-1-chpebeni@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Chris PeBenito <chpebeni@linux.microsoft.com>
---
 libselinux/src/avc_internal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.c
index 572b2159..53a99a1f 100644
--- a/libselinux/src/avc_internal.c
+++ b/libselinux/src/avc_internal.c
@@ -59,7 +59,7 @@ int avc_process_setenforce(int enforcing)
 	int rc = 0;
 
 	avc_log(SELINUX_SETENFORCE,
-		"%s:  received setenforce notice (enforcing=%d)\n",
+		"%s:  op=setenforce lsm=selinux enforcing=%d res=1",
 		avc_prefix, enforcing);
 	if (avc_setenforce)
 		goto out;
@@ -81,7 +81,7 @@ int avc_process_policyload(uint32_t seqno)
 	int rc = 0;
 
 	avc_log(SELINUX_POLICYLOAD,
-		"%s:  received policyload notice (seqno=%u)\n",
+		"%s:  op=load_policy lsm=selinux seqno=%u res=1",
 		avc_prefix, seqno);
 	rc = avc_ss_reset(seqno);
 	if (rc < 0) {
-- 
2.26.2

