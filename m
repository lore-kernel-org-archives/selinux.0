Return-Path: <SRS0=3hV4=6A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44FFC2BB85
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A442421927
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8P15Nll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442475AbgDPPog (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2395504AbgDPPoe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 11:44:34 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24822C061A0C
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:34 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b8so1827209pfp.8
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dIncQSwCNx/aPdpe4r94CQyn+890WYtRiOUFVSN6ZnU=;
        b=k8P15NllPGZVtnvdmyfUgMOmu4mZCfh/Y3yyJCTO7RQuAI1f6N9gtgVcQptGmD/eY8
         LAzBjMTG8Rayx3S/3LF7LC2yNYgVsSK8/W9BhMQJl83ZXVw8G27qEK4iq6DsQQLVPOYj
         N4/V9Bjb27wJ21P6Hs83cXaMlDj52XktykQcqNfxGXKpV3cuLKYqjJpeW9uY7j4Q/Jlw
         mp/kasqXraMvvyF4RoMUBeNpVdIMUrn07dmxBBWZrTTE1zCwXO+7UU2DbELGEuQ4eVOO
         jsKFPPmuBeqzM1Ks2Aj0sj3No0RXBJg/b39pf26D9mlAhCK5dnqIkGPQCZs3QlRFbCJV
         Xf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dIncQSwCNx/aPdpe4r94CQyn+890WYtRiOUFVSN6ZnU=;
        b=F5QhOVZmSrrFvedQVONc4OmqJSvcHWdzZqwZ8FgyXVWdU7MnBMiIeu3+yEyRp4m/8y
         IIjvxXGPQ2/VbaOE1U4+OW/YUzrX7LPAQ+Xex3AFavsy95m4tUXiCpwpo9KajGZmbLyP
         NMX5iBo4/7VLovcFCa9GxqjqR+BO97qS8pwWFEodXBEvaC7XaI9lwEASVW/mpwlzMQR7
         aS5lH4q12/0xl7nrzqyi1M5YYsBbZfF0hUm27cYCS4KxGXEXw66/6WJ2u7BkGgc3lZ6p
         8PaeCu4SenfnkhmBtSfmehk2AcqDtOfwIaWSZCzivGTfvI9mz8LefWfBqAQH68PqV79+
         i5zA==
X-Gm-Message-State: AGi0PuZ44VB+nUXsZY/vPDWUjrWZv42T8mEc6B0i/FbsT0IktFeBOdgs
        WSY25nK50BNknPtHgypx1YI=
X-Google-Smtp-Source: APiQypLvx6hsyPKwUQI9hVNmrS/kEsPt4S/bFuW3TivE7FmB9TnhqHO3RDGoFtOw9cHw6JuwtXEBlA==
X-Received: by 2002:a63:ea4e:: with SMTP id l14mr32030238pgk.431.1587051873637;
        Thu, 16 Apr 2020 08:44:33 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id g25sm16888626pfh.55.2020.04.16.08.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:44:33 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v2 16/18] selinux_check_passwd_access: annotate deprecated
Date:   Thu, 16 Apr 2020 10:43:50 -0500
Message-Id: <20200416154352.21619-17-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416154352.21619-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <20200416154352.21619-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Update the one internal tree caller in the same file to
call selinux_check_passwd_access2.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/include/selinux/selinux.h | 4 +++-
 libselinux/src/checkAccess.c         | 7 +++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 5a66fa6f9d78..b8d011fa07a7 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -609,7 +609,9 @@ extern int selinux_check_access(const char * scon, const char * tcon, const char
 
 /* Check a permission in the passwd class.
    Return 0 if granted or -1 otherwise. */
-extern int selinux_check_passwd_access(access_vector_t requested);
+extern int selinux_check_passwd_access(access_vector_t requested)
+  __attribute__ ((deprecated("Use selinux_check_access")));
+
 extern int checkPasswdAccess(access_vector_t requested)
    __attribute__ ((deprecated("Use selinux_check_access")));
 
diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
index 677e2ecd7df4..555d7ff3cca5 100644
--- a/libselinux/src/checkAccess.c
+++ b/libselinux/src/checkAccess.c
@@ -64,7 +64,7 @@ int selinux_check_access(const char *scon, const char *tcon, const char *class,
        return avc_has_perm (scon_id, tcon_id, sclass, av, NULL, aux);
 }
 
-int selinux_check_passwd_access(access_vector_t requested)
+static int selinux_check_passwd_access2(access_vector_t requested)
 {
 	int status = -1;
 	char *user_context;
@@ -99,8 +99,11 @@ int selinux_check_passwd_access(access_vector_t requested)
 	return status;
 }
 
+int selinux_check_passwd_access(access_vector_t requested) {
+	return selinux_check_passwd_access2(requested);
+}
 
 int checkPasswdAccess(access_vector_t requested)
 {
-	return selinux_check_passwd_access(requested);
+	return selinux_check_passwd_access2(requested);
 }
-- 
2.17.1

