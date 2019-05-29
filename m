Return-Path: <SRS0=VF96=T5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23F5C04AB3
	for <selinux@archiver.kernel.org>; Wed, 29 May 2019 07:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5417208C3
	for <selinux@archiver.kernel.org>; Wed, 29 May 2019 07:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfE2HiH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 May 2019 03:38:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37387 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfE2HiH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 May 2019 03:38:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id h1so923556wro.4
        for <selinux@vger.kernel.org>; Wed, 29 May 2019 00:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PtiDhSCMPolwAS174ZxqMsQbfwZV7KtLIxmNkSdGYJc=;
        b=DROhvm9FJ1CqoUVyv7zuwrS2qrk4xE7pVMC4IL0jmJFZmamNPkk/d6k19QHAhYg7V7
         tHJiNjx9aRAJa1fY65syEUJQi+cjybkN9Y1sKllDSPwG8nD72LHFIrFqTtklAb54Mp1W
         WT1doV0TdeMjk6MJ6mby7Sj3LNEopONuj5+Yw6CMEI+pLV0+7SvBdkWkRjUj4CYoE1Ca
         ZI5votv9uo5ZFVksJ6stVMSnphBzdzhV2uLdVAoekK0ebsQ3bDvUyUmSjicAOv2gtmNZ
         S++PAdCfdnTxDAZTINQgQiVblVWuIUFRDI4x+KShubw4PkyRYBzdv/GodV1V36SEn4T4
         KKHA==
X-Gm-Message-State: APjAAAV3vLglwjPFQtPJkh5ScL2J62a2o/0yGsvxA5LDE/laH9B0vzmN
        tDvqoUBIeC2KZ3OogY7CdxNHNSq0CLY=
X-Google-Smtp-Source: APXvYqxD00Sewbf20QBZErdJKC6h05RXxTBR9hatqwSujJr+Y9OXleLIbptj5Flk3sgtWJLI8NDjYA==
X-Received: by 2002:adf:8028:: with SMTP id 37mr1096427wrk.106.1559115485471;
        Wed, 29 May 2019 00:38:05 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id p16sm32024877wrg.49.2019.05.29.00.38.04
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 00:38:04 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v3 2/7] libsemanage: optionally optimize policy on rebuild
Date:   Wed, 29 May 2019 09:37:54 +0200
Message-Id: <20190529073759.20548-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529073759.20548-1-omosnace@redhat.com>
References: <20190529073759.20548-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When building binary policy, optionally run it through
sepol_policydb_optimize() just before writing it out.

Add a semanage_set_optimize() function to specify whether the
optimization should be applied or not.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libsemanage/include/semanage/handle.h |  4 ++++
 libsemanage/src/direct_api.c          |  7 +++++++
 libsemanage/src/handle.c              | 13 +++++++++++++
 libsemanage/src/handle.h              |  1 +
 libsemanage/src/libsemanage.map       |  5 +++++
 5 files changed, 30 insertions(+)

diff --git a/libsemanage/include/semanage/handle.h b/libsemanage/include/semanage/handle.h
index c8165900..f23be35a 100644
--- a/libsemanage/include/semanage/handle.h
+++ b/libsemanage/include/semanage/handle.h
@@ -66,6 +66,10 @@ void semanage_set_reload(semanage_handle_t * handle, int do_reload);
  * 1 for yes, 0 for no (default) */
 void semanage_set_rebuild(semanage_handle_t * handle, int do_rebuild);
 
+/* set whether to optimize the policy (remove redundancies) when built.
+ * 1 for yes, 0 for no (default) */
+void semanage_set_optimize(semanage_handle_t * handle, int do_optimize);
+
 /* Fills *compiler_path with the location of the hll compiler sh->conf->compiler_directory_path
  * corresponding to lang_ext.
  * Upon success returns 0, -1 on error. */
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index c58961be..95cbee81 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1461,6 +1461,13 @@ rebuild:
 
 		cil_db_destroy(&cildb);
 
+		/* Remove redundancies in binary policy if requested. */
+		if (sh->do_optimize) {
+			retval = sepol_policydb_optimize(out);
+			if (retval < 0)
+				goto cleanup;
+		}
+
 		/* Write the linked policy before merging local changes. */
 		retval = semanage_write_policydb(sh, out,
 						 SEMANAGE_LINKED);
diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
index e5109aef..8f4530c2 100644
--- a/libsemanage/src/handle.c
+++ b/libsemanage/src/handle.c
@@ -88,6 +88,10 @@ semanage_handle_t *semanage_handle_create(void)
 	 * If any changes are made, this flag is ignored */
 	sh->do_rebuild = 0;
 
+	/* By default do not optimize policy on rebuild.
+	 * If the policy is not being rebuilt, this flag is ignored. */
+	sh->do_optimize = 0;
+
 	sh->commit_err = 0;
 
 	/* By default always reload policy after commit if SELinux is enabled. */
@@ -125,6 +129,15 @@ void semanage_set_rebuild(semanage_handle_t * sh, int do_rebuild)
 	return;
 }
 
+void semanage_set_optimize(semanage_handle_t * sh, int do_optimize)
+{
+
+	assert(sh != NULL);
+
+	sh->do_optimize = do_optimize;
+	return;
+}
+
 void semanage_set_reload(semanage_handle_t * sh, int do_reload)
 {
 
diff --git a/libsemanage/src/handle.h b/libsemanage/src/handle.h
index a91907b0..b8fbf120 100644
--- a/libsemanage/src/handle.h
+++ b/libsemanage/src/handle.h
@@ -62,6 +62,7 @@ struct semanage_handle {
 	int is_in_transaction;
 	int do_reload;		/* whether to reload policy after commit */
 	int do_rebuild;		/* whether to rebuild policy if there were no changes */
+	int do_optimize;	/* whether to optimize the built policy */
 	int commit_err;		/* set by semanage_direct_commit() if there are
 				 * any errors when building or committing the
 				 * sandbox to kernel policy at /etc/selinux
diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
index 02036696..535bd9b5 100644
--- a/libsemanage/src/libsemanage.map
+++ b/libsemanage/src/libsemanage.map
@@ -63,3 +63,8 @@ LIBSEMANAGE_1.1 {
 	  semanage_module_remove_key;
 	  semanage_set_store_root;
 } LIBSEMANAGE_1.0;
+
+LIBSEMANAGE_1.2 {
+  global:
+	  semanage_set_optimize;
+} LIBSEMANAGE_1.1;
-- 
2.20.1

