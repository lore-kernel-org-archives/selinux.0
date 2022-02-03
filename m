Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23872C433FE
	for <selinux@archiver.kernel.org>; Thu,  3 Feb 2022 16:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352450AbiBCQxo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Feb 2022 11:53:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52153 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352441AbiBCQxo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Feb 2022 11:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643907223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X0NdXg5yzCYHZTH0V7EG9B4rZd0u+04O3/S8qHXYy0k=;
        b=eBmHu7aqKaGXEe//mdTt1Q/Ja0ORBXyxwKNYTMe+bls1RhqX4Y0d3hONkqhOIKg1rFlJkQ
        3nzZTaltFxFSOvfmOCH/AKC48Gp7+o94LzvhXVVC/f3HVsRug3+yYhjjgJ03Bwi823mR2J
        Ymw+RFsx5jrcW7lTp5/Yyb2uxwcunXI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-_R0osSdJO1ufQkGYTSI3PA-1; Thu, 03 Feb 2022 11:53:42 -0500
X-MC-Unique: _R0osSdJO1ufQkGYTSI3PA-1
Received: by mail-ej1-f70.google.com with SMTP id k16-20020a17090632d000b006ae1cdb0f07so1425723ejk.16
        for <selinux@vger.kernel.org>; Thu, 03 Feb 2022 08:53:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X0NdXg5yzCYHZTH0V7EG9B4rZd0u+04O3/S8qHXYy0k=;
        b=IZfyFa2sK3Ruqlk2b0aj7efyzHYYK4fo0XGMIz6sNPnCEvS49kzeV7Kkuq9Q0JSIt8
         fSu1XYcvKrZi5HZQFeFgm1BNSX4hDqW658Bw3L3/735XTB6G9EEt883yWNaHIxcoXn1Q
         LOtOiOC9nb9TPgsMMPox/p2esVyc2X9wBN44JXLnOJbyldUOba1sJhArpN8IfF8jTOAw
         RLGRpPFLkJZSkZN4zqM/TG+CRrCCOWlEk9FV7CIjvb9235spP8JiwuP0eCIPUgYiJb2q
         jrWBQf7WIUFDYMXC59G9QAehLqvGDlUTX7RImZJIL/wYXxIm5E559wxQre0V0kXiID/u
         2H9Q==
X-Gm-Message-State: AOAM533/3hmTsA2X94/tw5otuFqJI4J5xKmnHZ8ed1wlNom3T1S7tos6
        bI7+qjczjvWm4Gc/nrS//Fd6Jo2o44ZpiJz91nehbeVRaCDlUpsEmbp5O97/WYFRN2WwUw+LvtE
        ZiY52Pq61b3flO3MEsICWKrpcM2Eh2yb5/leSgq+RIn3x1ckMmCJ8hWqqZhJUO6GKT50ZxA==
X-Received: by 2002:a17:907:948c:: with SMTP id dm12mr31611617ejc.770.1643907221126;
        Thu, 03 Feb 2022 08:53:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyUptYgKo7Iqdi+E3YCm15WlBbXH3o46JdPXeiEXo293Ko/TGU231+lj/hn5iUZDK5QEkkc9Q==
X-Received: by 2002:a17:907:948c:: with SMTP id dm12mr31611599ejc.770.1643907220789;
        Thu, 03 Feb 2022 08:53:40 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id bs4sm18141027edb.84.2022.02.03.08.53.39
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 08:53:40 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v2 4/6] libsemanage: clean up semanage_direct_commit() a bit
Date:   Thu,  3 Feb 2022 17:53:25 +0100
Message-Id: <20220203165327.213601-5-omosnace@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203165327.213601-1-omosnace@redhat.com>
References: <20220203165327.213601-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Do some minor cosmetic cleanup, mainly to eliminate the 'rebuilt' goto
label.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libsemanage/src/direct_api.c | 91 ++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 46 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 7eb6938b..f0bd7716 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -994,6 +994,16 @@ cleanup:
 	return status;
 }
 
+/* Files that must exist in order to skip policy rebuild. */
+static const int semanage_computed_files[] = {
+	SEMANAGE_STORE_KERNEL,
+	SEMANAGE_STORE_FC,
+	SEMANAGE_STORE_SEUSERS,
+	SEMANAGE_LINKED,
+	SEMANAGE_SEUSERS_LINKED,
+	SEMANAGE_USERS_EXTRA_LINKED
+};
+
 /* Copies a file from src to dst. If dst already exists then
  * overwrite it. If source doesn't exist then return success.
  * Returns 0 on success, -1 on error. */
@@ -1053,6 +1063,14 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	seusers_modified = seusers->dtable->is_modified(seusers->dbase);
 	fcontexts_modified = fcontexts->dtable->is_modified(fcontexts->dbase);
 
+	/* Before we do anything else, flush the join to its component parts.
+	 * This *does not* flush to disk automatically */
+	if (users->dtable->is_modified(users->dbase)) {
+		retval = users->dtable->flush(sh, users->dbase);
+		if (retval < 0)
+			goto cleanup;
+	}
+
 	/* Rebuild if explicitly requested or any module changes occurred. */
 	do_rebuild = sh->do_rebuild | sh->modules_modified;
 
@@ -1119,14 +1137,6 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 		}
 	}
 
-	/* Before we do anything else, flush the join to its component parts.
-	 * This *does not* flush to disk automatically */
-	if (users->dtable->is_modified(users->dbase)) {
-		retval = users->dtable->flush(sh, users->dbase);
-		if (retval < 0)
-			goto cleanup;
-	}
-
 	/*
 	 * This is for systems that have already migrated with an older version
 	 * of semanage_migrate_store. The older version did not copy
@@ -1135,48 +1145,20 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	 * in order to skip re-linking are present; otherwise, we force
 	 * a rebuild.
 	 */
-	if (!do_rebuild) {
-		int files[] = {SEMANAGE_STORE_KERNEL,
-					   SEMANAGE_STORE_FC,
-					   SEMANAGE_STORE_SEUSERS,
-					   SEMANAGE_LINKED,
-					   SEMANAGE_SEUSERS_LINKED,
-					   SEMANAGE_USERS_EXTRA_LINKED};
-
-		for (i = 0; i < (int) ARRAY_SIZE(files); i++) {
-			path = semanage_path(SEMANAGE_TMP, files[i]);
-			if (stat(path, &sb) != 0) {
-				if (errno != ENOENT) {
-					ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
-					retval = -1;
-					goto cleanup;
-				}
-
-				do_rebuild = 1;
-				goto rebuild;
+	for (i = 0; !do_rebuild && i < (int)ARRAY_SIZE(semanage_computed_files); i++) {
+		path = semanage_path(SEMANAGE_TMP, semanage_computed_files[i]);
+		if (stat(path, &sb) != 0) {
+			if (errno != ENOENT) {
+				ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
+				retval = -1;
+				goto cleanup;
 			}
+
+			do_rebuild = 1;
+			break;
 		}
 	}
 
-rebuild:
-	/*
-	 * Now that we know whether or not a rebuild is required,
-	 * we can determine what else needs to be done.
-	 * We need to write the kernel policy if we are rebuilding
-	 * or if any other policy component that lives in the kernel
-	 * policy has been modified.
-	 * We need to install the policy files if any of the managed files
-	 * that live under /etc/selinux (kernel policy, seusers, file contexts)
-	 * will be modified.
-	 */
-	do_write_kernel = do_rebuild | ports_modified | ibpkeys_modified |
-		ibendports_modified |
-		bools->dtable->is_modified(bools->dbase) |
-		ifaces->dtable->is_modified(ifaces->dbase) |
-		nodes->dtable->is_modified(nodes->dbase) |
-		users->dtable->is_modified(users_base->dbase);
-	do_install = do_write_kernel | seusers_modified | fcontexts_modified;
-
 	/*
 	 * If there were policy changes, or explicitly requested, or
 	 * any required files are missing, rebuild the policy.
@@ -1330,6 +1312,23 @@ rebuild:
 		}
 	}
 
+	/*
+	 * Determine what else needs to be done.
+	 * We need to write the kernel policy if we are rebuilding
+	 * or if any other policy component that lives in the kernel
+	 * policy has been modified.
+	 * We need to install the policy files if any of the managed files
+	 * that live under /etc/selinux (kernel policy, seusers, file contexts)
+	 * will be modified.
+	 */
+	do_write_kernel = do_rebuild | ports_modified | ibpkeys_modified |
+		ibendports_modified |
+		bools->dtable->is_modified(bools->dbase) |
+		ifaces->dtable->is_modified(ifaces->dbase) |
+		nodes->dtable->is_modified(nodes->dbase) |
+		users->dtable->is_modified(users_base->dbase);
+	do_install = do_write_kernel | seusers_modified | fcontexts_modified;
+
 	/* Attach our databases to the policydb we just created or loaded. */
 	dbase_policydb_attach((dbase_policydb_t *) pusers_base->dbase, out);
 	dbase_policydb_attach((dbase_policydb_t *) pports->dbase, out);
-- 
2.34.1

