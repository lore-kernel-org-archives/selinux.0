Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647DDC04A94
	for <selinux@archiver.kernel.org>; Fri, 11 Aug 2023 16:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjHKQ1x (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Aug 2023 12:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjHKQ1w (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Aug 2023 12:27:52 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F7A273E
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:52 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bf91956cdso283223166b.3
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691771271; x=1692376071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yOtpLWp5tJrAK7/EmVMT3zyqfKWlAxfHM6ZvZqzUaig=;
        b=ORcO5/7ivmRo47hiJXGaRnOBhlBIKXD2GtX8bwiM2zB9lSmKGuuGOPcSGJ9wnez+2a
         myUmRgBnEVm5yOF50d1804k50Adnse/rH7QJQn0Nam8ADxD+5vvAthybKvnOnarOovN5
         RIvF0GCnBdXO9phNo3dvEeqhuz2OtqDJwOI3K7x/pTO3jEYlSAmRG6SYN2DvjTTL5zja
         YcCMf17YZOxUyXr+tZHG4LSuLJTIJkfpgqQOrIliELgOqYrbk7dQ58PYj1ftbm93sZKm
         T9d2TQ3cw8Dy207RkP28Qb5rddYzZL7COZVzlzjOpDaOeHo0ac7fd25Evj8ED/0CYbhl
         EMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771271; x=1692376071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOtpLWp5tJrAK7/EmVMT3zyqfKWlAxfHM6ZvZqzUaig=;
        b=CsRTg4JRJfRCcuEWQKrpAxAR0h1u7D2elWkquk6ny/UWOMHFK+zpQPw7luTq30g8VN
         72KvPK27NVsLoZ0gv/f7l4tJs74ZhCdqQkwn9tJ2E7urltZwUh+EV/F01V4Jlvf12zGv
         armJNBCr+lRpSbubCvoLap2VLYc4c7JBOGz6nOXRtKEekyKmmEGpEsUZDg4k8g9LYNm0
         Ptz1mZDoflCyJqiPyHrIL5jI0xRRdqo8AWDsdpz0J08UTFtHVWuOiHGw8MofVBZtHrkO
         1YEap7Q+u3iJZRYvNfPSJCUbcV6nH+u6/IJ4pFc0LhnoLJQPRYtGEqJWHsxdWtPwxKfk
         rH5A==
X-Gm-Message-State: AOJu0Yz8ZtipnpgnW3jTS8Ackko/ZJk/yyvbyRLd9fCFQL7j+Dr71L2k
        upVg1A7LyIRiMbDF2fjGTmZIspPtGqJ5cQ==
X-Google-Smtp-Source: AGHT+IFyk/cM7Go7fWE8CkN/zXSybGgWIwrOucw0w9uToN3+RV3mWX9pRyGW20Ti+s4688Q3kL3a7A==
X-Received: by 2002:a17:906:3288:b0:992:1233:9c45 with SMTP id 8-20020a170906328800b0099212339c45mr2045156ejw.69.1691771270693;
        Fri, 11 Aug 2023 09:27:50 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-174-226.77.0.pool.telefonica.de. [77.0.174.226])
        by smtp.gmail.com with ESMTPSA id p9-20020a170906b20900b00992afee724bsm2408807ejz.76.2023.08.11.09.27.50
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 09:27:50 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 05/24] setfiles: do not issue AUDIT_FS_RELABEL on dry run
Date:   Fri, 11 Aug 2023 18:27:12 +0200
Message-Id: <20230811162731.50697-6-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230811162731.50697-1-cgzones@googlemail.com>
References: <20230811162731.50697-1-cgzones@googlemail.com>
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

