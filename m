Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A6BC41513
	for <selinux@archiver.kernel.org>; Thu,  3 Aug 2023 16:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbjHCQXM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Aug 2023 12:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbjHCQXI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Aug 2023 12:23:08 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5E7E67
        for <selinux@vger.kernel.org>; Thu,  3 Aug 2023 09:23:06 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51d95aed33aso1481448a12.3
        for <selinux@vger.kernel.org>; Thu, 03 Aug 2023 09:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691079785; x=1691684585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yOtpLWp5tJrAK7/EmVMT3zyqfKWlAxfHM6ZvZqzUaig=;
        b=GshsYbC6GllWOwA41vpZb15adJ7LqgDHETt9ajS0ZdI7mBY8OCjR0mMATpUbGv5kw5
         Bbcr+dqwAJyJomaMp7LrvvsRyQURezFGxJznQqN8gi4Fz/GGGsr1TLatEmkcRJhY8xJ7
         TG3ljgKKTzvlqBkjkh89+F8/C9dKJjnVvvMONNZ4XNJug7tTPN7U9G+Zr5YN0r/HTsQl
         klbvnE3fklEJZzoYPwXvTSk8AEaUfK6/270vyPw/Va0HP+NuBSc70/wGvAa1ZKIeLG6Y
         FaZLah6hxYCGZXIkFdPPjqm3kEo2MQwxUAc84w9iLwg6fvr/EPQVpkOYJ9t3Q7t1C20E
         3bsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691079785; x=1691684585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yOtpLWp5tJrAK7/EmVMT3zyqfKWlAxfHM6ZvZqzUaig=;
        b=klnMwGmD8rt4mYmyUwv9YqV7pWNx1k9OH6l/1zPpLI/1hcABj0MSmnFR5TKHpCiW/N
         N2YwjfN7KY37COTpj3E8QrvxujWXXrhUAN4YkMvPTz6THKd+j8U8km5IsC8DtuDAATsy
         +xegjVdhS/W05FOn8whssp2pLOd0V4VdBUnC0y6hLR8uDb0upIfbRT69owyG0CuMGYK2
         hLD46Ga1ZLmHHZai9JdCxb5vrIX7TvpLnQT+ly3yRtibyf+n8gexwS3DB2PH8unNrM/v
         lnXbR8D/T5xM0HUsdI9/kU6MSM7GVHTkIeCwqA4LKCCncLlOs6yz7RJ01FidRPLEMZRE
         SXnQ==
X-Gm-Message-State: ABy/qLasftOGe67Dr0qXRerXTvQnZ935OmqliaBuDKhqZpuRt/TyGRvy
        7bsRMqsdwiRyMRtQzW8vLBVyf6vORh5qSMOVyrI=
X-Google-Smtp-Source: APBJJlGz1c/TIjUvzttejRnncD0/Crs5L+Ej+omI6OEdDGBre7FaMD7eGv6hj/Lr5tPAiQziM+iHHw==
X-Received: by 2002:aa7:c6cb:0:b0:522:5778:ee2d with SMTP id b11-20020aa7c6cb000000b005225778ee2dmr8077652eds.19.1691079785415;
        Thu, 03 Aug 2023 09:23:05 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-150-191.77.0.pool.telefonica.de. [77.0.150.191])
        by smtp.gmail.com with ESMTPSA id z22-20020aa7c656000000b0052302c27de2sm7804edr.10.2023.08.03.09.23.05
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 09:23:05 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] setfiles: do not issue AUDIT_FS_RELABEL on dry run
Date:   Thu,  3 Aug 2023 18:23:01 +0200
Message-Id: <20230803162301.302579-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Do not issue an audit event of type AUDIT_FS_RELABEL in case of a
passive check.

Print the reason for an audit_open(3) failure.

Do not prematurely exit in case audit_open(3) fails, since all important
work is already done, but proceed with cleanup tasks.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/setfiles/setfiles.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 4dd0d0dc..88a27241 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -86,23 +86,20 @@ static int canoncon(char **contextp)
 }
 
 #ifndef USE_AUDIT
-static void maybe_audit_mass_relabel(int mass_relabel __attribute__((unused)),
-				int mass_relabel_errs __attribute__((unused)))
+static void audit_mass_relabel(int mass_relabel_errs __attribute__((unused)))
 {
 #else
-static void maybe_audit_mass_relabel(int mass_relabel, int mass_relabel_errs)
+static void audit_mass_relabel(int mass_relabel_errs)
 {
 	int audit_fd = -1;
 	int rc = 0;
 
-	if (!mass_relabel)		/* only audit a forced full relabel */
-		return;
-
 	audit_fd = audit_open();
 
 	if (audit_fd < 0) {
-		fprintf(stderr, "Error connecting to audit system.\n");
-		exit(-1);
+		fprintf(stderr, "Error connecting to audit system: %s.\n",
+			strerror(errno));
+		return;
 	}
 
 	rc = audit_log_user_message(audit_fd, AUDIT_FS_RELABEL,
@@ -463,7 +460,8 @@ int main(int argc, char **argv)
 					       &skipped_errors) < 0;
 	}
 
-	maybe_audit_mass_relabel(r_opts.mass_relabel, errors);
+	if (r_opts.mass_relabel && !r_opts.nochange)
+		audit_mass_relabel(errors);
 
 	if (warn_no_match)
 		selabel_stats(r_opts.hnd);
-- 
2.40.1

