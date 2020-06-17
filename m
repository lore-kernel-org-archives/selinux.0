Return-Path: <SRS0=Tm5b=76=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E29C433E0
	for <selinux@archiver.kernel.org>; Wed, 17 Jun 2020 19:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 201B120884
	for <selinux@archiver.kernel.org>; Wed, 17 Jun 2020 19:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ucd9fTbA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgFQTW0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Jun 2020 15:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQTW0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Jun 2020 15:22:26 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B910C06174E
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2020 12:22:26 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id r22so1701778qke.13
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2020 12:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mze8QGzi6Q3IDebRtnT+0yGjJKFMD81OKJiTMzTrdxs=;
        b=Ucd9fTbAWeIEwb9OYGQjP/wzHSyCI/XWnOQItDciJS/a539y6CjeFawF3ce2dg6M6A
         YYYih9/qUePnqdNEE2PQz4/a/bTbYVOJbmNGoU3DaHWtoHFqYqdViNC324HNBAHhsC2D
         /jKlU7XAPArYUJPHahPmrb9AXZ5iuNzdZCfs3QvrVALOIo7QJgW/4AceFcID29x9YwYU
         3alF5R6m9e7ARekHeHJxIq7iaui3rUtDYVGPtkb8tKWq1OtheiduJHBQDybiPOY/Ti8d
         nTEFCgPbxfsOYw2986Fd5xnakJC1nYqDZ55ZY3Ub6QJpQtYiJ2kGWH3Fj2YPvdRkA7S+
         6asA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mze8QGzi6Q3IDebRtnT+0yGjJKFMD81OKJiTMzTrdxs=;
        b=qpGA12/wBmXw6xNeGNDXfQCo/sxQdU89c2wql8Zn/xfQEJKDr/mdVyqgkRTwxKvm1O
         +nP4ySSbo74ep/+0JjpSzNjlB/hj82n5VYHS4lvSVMa8p6yHNGrcFoV1tb+PcKX3njfg
         aYCsmqKAQ6uhPMcbh+NQdlj3DATt55RkVYhwmFka80vtBw1iM4LUvrKZsOtEB3Bxa8h1
         ymdb9Bcn8GrS6upS20eOFMiLZ6jGlHN8+gGlRfcApr0nkjWcLIsUp4yDfy7KJ4O59a3W
         IryrNcydDCV/IvtgjGub7pkhK7bK1Y/Bvd51wRmfJR6lk3sBta9q609qYHLLOgi91sYA
         s0kg==
X-Gm-Message-State: AOAM531G4+RDel7qOLHNk05ManOkMB0mQcMDnwVTECJRBD56eiG+xYVA
        fafFN4AdFOZLcKSMSSZxUTdiCYoJajA=
X-Google-Smtp-Source: ABdhPJzQ2HPnL7Rs+Be508lo7cpETWj0Un9qPN0cxnN0/dKZrRnj+I6tJzWLZgBuPWQqTOWNQ682/Q==
X-Received: by 2002:a37:aac4:: with SMTP id t187mr148835qke.263.1592421745499;
        Wed, 17 Jun 2020 12:22:25 -0700 (PDT)
Received: from puritycontrol.fios-router.home (pool-96-244-118-111.bltmmd.fios.verizon.net. [96.244.118.111])
        by smtp.gmail.com with ESMTPSA id f13sm792514qka.52.2020.06.17.12.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 12:22:25 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] scripts/selinux/mdp: fix initial SID handling
Date:   Wed, 17 Jun 2020 15:22:16 -0400
Message-Id: <20200617192216.69444-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

commit e3e0b582c321 ("selinux: remove unused initial SIDs and improve
handling") broke scripts/selinux/mdp since the unused initial SID names
were removed and the corresponding generation of policy initial SID
definitions by mdp was not updated accordingly.  Fix it.  With latest
upstream checkpolicy it is no longer necessary to include the SID context
definitions for the unused initial SIDs but retain them for compatibility
with older checkpolicy.

Fixes: e3e0b582c321 ("selinux: remove unused initial SIDs and improve handling")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 scripts/selinux/mdp/mdp.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
index 576d11a60417..6ceb88eb9b59 100644
--- a/scripts/selinux/mdp/mdp.c
+++ b/scripts/selinux/mdp/mdp.c
@@ -67,8 +67,14 @@ int main(int argc, char *argv[])
 
 	initial_sid_to_string_len = sizeof(initial_sid_to_string) / sizeof (char *);
 	/* print out the sids */
-	for (i = 1; i < initial_sid_to_string_len; i++)
-		fprintf(fout, "sid %s\n", initial_sid_to_string[i]);
+	for (i = 1; i < initial_sid_to_string_len; i++) {
+		const char *name = initial_sid_to_string[i];
+
+		if (name)
+			fprintf(fout, "sid %s\n", name);
+		else
+			fprintf(fout, "sid unused%d\n", i);
+	}
 	fprintf(fout, "\n");
 
 	/* print out the class permissions */
@@ -126,9 +132,16 @@ int main(int argc, char *argv[])
 #define OBJUSERROLETYPE "user_u:object_r:base_t"
 
 	/* default sids */
-	for (i = 1; i < initial_sid_to_string_len; i++)
-		fprintf(fout, "sid %s " SUBJUSERROLETYPE "%s\n",
-			initial_sid_to_string[i], mls ? ":" SYSTEMLOW : "");
+	for (i = 1; i < initial_sid_to_string_len; i++) {
+		const char *name = initial_sid_to_string[i];
+
+		if (name)
+			fprintf(fout, "sid %s ", name);
+		else
+			fprintf(fout, "sid unused%d\n", i);
+		fprintf(fout, SUBJUSERROLETYPE "%s\n",
+			mls ? ":" SYSTEMLOW : "");
+	}
 	fprintf(fout, "\n");
 
 #define FS_USE(behavior, fstype)			    \
-- 
2.25.1

