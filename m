Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF03C54EBF
	for <selinux@archiver.kernel.org>; Thu,  5 Jan 2023 17:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbjAERVl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Jan 2023 12:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbjAERVD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Jan 2023 12:21:03 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456771EADC
        for <selinux@vger.kernel.org>; Thu,  5 Jan 2023 09:13:48 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id jo4so91576125ejb.7
        for <selinux@vger.kernel.org>; Thu, 05 Jan 2023 09:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Tp+O4FotLLNEYzR5qFIBQhm82P+di5aQZ3JKRiOrSs=;
        b=XtmMrNI6eSUrmJSMKrZ8mpBq3W5mpJuP3XZtf+z/4JaMhjLs7GgoEFLL21lyw+S1LT
         sdlxvepOww8XlQ4cQiviY9UAltZj/foi0584TEgktuQp4S4HskFzWMTFjM1aLXJhTivN
         Frtp2vPWeoxUSg24Q4O5jLqv7Qw8yUWyJkrux5rIVhHiGLPLt6+ZVyZF+dIG+3osOgsS
         Pc2z7lIqDq3ntO3ykMYgonWA6dU9eG1gm+CkZLXVWJnfvmjDom41hzIxHJ8I1vyjiJsk
         rz0vL+LGuy5ye5p4bpHGURS9JhSqQAGMjWV5Qx9WzP7Jk6jytq9dIMkEUvhOFINeTVss
         dptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Tp+O4FotLLNEYzR5qFIBQhm82P+di5aQZ3JKRiOrSs=;
        b=UXK/o/Vb4QMdeC0MgVdUXkRWrPV0HkoXiRrDlB9Lw86hb1KrFED8Qv4KdQy65JnNF4
         nJm2tInAvcDjN7uLfOvUryh4/k3W99ENgvxwd0zi9ObELtKXQquaoQSirBTd5TGKqdPV
         pDqQqYJNQqaaPA6jX6QBHBjeS1idcNtFbkoVH1whcPw+2KnmopuPvvNf1XeeQKKZOPQk
         s8j07+Fi0rjZf0GHTisH8W9BUyjolSHptUxX2IlQS5W2CWIaM0D5ISUTAgjO6j2pyF8J
         mgMDo0g8V+7EWMaBYnOdxrCHHopjNWopG0lvEWmR76xANtHD7CvU2E8jG2/stqI6Qh+I
         MD3g==
X-Gm-Message-State: AFqh2kpa3n4qnuuxHlzWETU/7h1HJ2fqIavY/y/E51n7WAZAT165Lx46
        FWcRQiejcaO1HhzIooleoguY7W5o8rblkA==
X-Google-Smtp-Source: AMrXdXvxNmcaeTXzKsvVD8p/qfffos7RdrJUK3WHEM3J0qhOMyWqfqzoH/kIVjfue4sf0s7H1JH1qQ==
X-Received: by 2002:a17:907:8c86:b0:7c1:1adc:46fd with SMTP id td6-20020a1709078c8600b007c11adc46fdmr48508770ejc.34.1672938826884;
        Thu, 05 Jan 2023 09:13:46 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-010-153-041.77.10.pool.telefonica.de. [77.10.153.41])
        by smtp.gmail.com with ESMTPSA id v1-20020a170906292100b0073c10031dc9sm16585182ejd.80.2023.01.05.09.13.46
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 09:13:46 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/2] libsepol: do not write empty class definitions
Date:   Thu,  5 Jan 2023 18:13:39 +0100
Message-Id: <20230105171340.18444-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Do not write class definitions for classes without any permission and
any inherited common class.  The classes are already declared in
write_class_decl_rules_to_conf().  Skipping those empty definitions,
which are equal to the corresponding class declarations, will enable to
parse the generated policy conf file with checkpolicy, as checkpolicy
does not accept class declarations after initial sid declarations.

This will enable simple round-trip tests with checkpolicy.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/kernel_to_conf.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 63dffd9b..73b72b5d 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -591,16 +591,21 @@ static int write_class_and_common_rules_to_conf(FILE *out, struct policydb *pdb)
 		class = pdb->class_val_to_struct[i];
 		if (!class) continue;
 		name = pdb->p_class_val_to_name[i];
-		sepol_printf(out, "class %s", name);
-		if (class->comkey) {
-			sepol_printf(out, " inherits %s", class->comkey);
-		}
 		perms = class_or_common_perms_to_str(&class->permissions);
-		if (perms) {
-			sepol_printf(out, " { %s }", perms);
-			free(perms);
+		/* Do not write empty classes, their declaration was alreedy
+		 * printed in write_class_decl_rules_to_conf() */
+		if (perms || class->comkey) {
+			sepol_printf(out, "class %s", name);
+			if (class->comkey) {
+				sepol_printf(out, " inherits %s", class->comkey);
+			}
+
+			if (perms) {
+				sepol_printf(out, " { %s }", perms);
+				free(perms);
+			}
+			sepol_printf(out, "\n");
 		}
-		sepol_printf(out, "\n");
 	}
 
 exit:
-- 
2.39.0

