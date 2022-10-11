Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D97BC433F5
	for <selinux@archiver.kernel.org>; Tue, 11 Oct 2022 11:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiJKL1q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Oct 2022 07:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiJKL1p (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Oct 2022 07:27:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE2F7D7B0
        for <selinux@vger.kernel.org>; Tue, 11 Oct 2022 04:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665487663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=U+9ngazxHfMLR2zW8Bes0We/4FgqYpPnohPQSacW2tk=;
        b=DbPh64bL2xhGslv6m2H0tkxdx2vs2EHxMaspRVtwKojFyS9c3bL76ctAeWMNYCHB2VKRdf
        JdaP99/uN4i2gEAQ2zSguwlAz8eF2it7eTE3NE+doTwa84fzxzY0kiCd8Syim+RhLnYRvd
        DqRTzSWckCYE6snT/wpDwgDowaOwFb4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-388-cS17XlAbPFiSIhWsU5f0kw-1; Tue, 11 Oct 2022 07:27:42 -0400
X-MC-Unique: cS17XlAbPFiSIhWsU5f0kw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 11024185A78F
        for <selinux@vger.kernel.org>; Tue, 11 Oct 2022 11:27:42 +0000 (UTC)
Received: from localhost.localdomain (ovpn-194-111.brq.redhat.com [10.40.194.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 774F51415102;
        Tue, 11 Oct 2022 11:27:41 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] libselinux: Add missing '\n' to avc_log() messages
Date:   Tue, 11 Oct 2022 13:27:33 +0200
Message-Id: <20221011112733.194079-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libselinux/src/avc.c          | 2 +-
 libselinux/src/avc_internal.c | 4 ++--
 libselinux/src/checkAccess.c  | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
index 8d5983a2fe0c..98a3fcae41c8 100644
--- a/libselinux/src/avc.c
+++ b/libselinux/src/avc.c
@@ -725,7 +725,7 @@ void avc_audit(security_id_t ssid, security_id_t tsid,
 	if (denied)
 		log_append(avc_audit_buf, " permissive=%u", result ? 0 : 1);
 
-	avc_log(SELINUX_AVC, "%s", avc_audit_buf);
+	avc_log(SELINUX_AVC, "%s\n", avc_audit_buf);
 
 	avc_release_lock(avc_log_lock);
 }
diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.c
index 71a1357bc564..c550e5788527 100644
--- a/libselinux/src/avc_internal.c
+++ b/libselinux/src/avc_internal.c
@@ -59,7 +59,7 @@ int avc_process_setenforce(int enforcing)
 	int rc = 0;
 
 	avc_log(SELINUX_SETENFORCE,
-		"%s:  op=setenforce lsm=selinux enforcing=%d res=1",
+		"%s:  op=setenforce lsm=selinux enforcing=%d res=1\n",
 		avc_prefix, enforcing);
 	if (avc_setenforce)
 		goto out;
@@ -81,7 +81,7 @@ int avc_process_policyload(uint32_t seqno)
 	int rc = 0;
 
 	avc_log(SELINUX_POLICYLOAD,
-		"%s:  op=load_policy lsm=selinux seqno=%u res=1",
+		"%s:  op=load_policy lsm=selinux seqno=%u res=1\n",
 		avc_prefix, seqno);
 	rc = avc_ss_reset(seqno);
 	if (rc < 0) {
diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
index 022cd6b5ecab..319af267c6a7 100644
--- a/libselinux/src/checkAccess.c
+++ b/libselinux/src/checkAccess.c
@@ -44,7 +44,7 @@ int selinux_check_access(const char *scon, const char *tcon, const char *class,
        sclass = string_to_security_class(class);
        if (sclass == 0) {
 	       rc = errno;
-	       avc_log(SELINUX_ERROR, "Unknown class %s", class);
+	       avc_log(SELINUX_ERROR, "Unknown class %s\n", class);
 	       if (security_deny_unknown() == 0)
 		       return 0;
 	       errno = rc;
@@ -54,7 +54,7 @@ int selinux_check_access(const char *scon, const char *tcon, const char *class,
        av = string_to_av_perm(sclass, perm);
        if (av == 0) {
 	       rc = errno;
-	       avc_log(SELINUX_ERROR, "Unknown permission %s for class %s", perm, class);
+	       avc_log(SELINUX_ERROR, "Unknown permission %s for class %s\n", perm, class);
 	       if (security_deny_unknown() == 0)
 		       return 0;
 	       errno = rc;
-- 
2.37.3

