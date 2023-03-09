Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D39BC64EC4
	for <selinux@archiver.kernel.org>; Thu,  9 Mar 2023 14:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjCIOja (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Mar 2023 09:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbjCIOjH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Mar 2023 09:39:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C8BF9EC5
        for <selinux@vger.kernel.org>; Thu,  9 Mar 2023 06:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678372666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=a6SdRp4Y1Qs9W5HvliyLu9viom5NhdtvaiV7zNTqroY=;
        b=ZL5G2mAO9LRTb9EdNtlFjJ3xcmIRuRp+dvmZfugDZr6kJHtw94sXles2umMZ+kvnYMvhBX
        sjlwWTiE7uDdFbJWJLNYJBtFl7lx35TkOU8nimPyqNI/gy4R73n7x59hyMKZ9boh6iUeQE
        08WTFCVAMPKG7sZjTJi201XKZUCuzag=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-dGfS-46oN22wvfZJ_GzEhw-1; Thu, 09 Mar 2023 09:37:45 -0500
X-MC-Unique: dGfS-46oN22wvfZJ_GzEhw-1
Received: by mail-ed1-f71.google.com with SMTP id ev6-20020a056402540600b004bc2358ac04so3221198edb.21
        for <selinux@vger.kernel.org>; Thu, 09 Mar 2023 06:37:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678372664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a6SdRp4Y1Qs9W5HvliyLu9viom5NhdtvaiV7zNTqroY=;
        b=j7NizVyfiD/FzOsWjUzr2Tpg00fQ6EOC91p9SI1lmB4EnkQHOPiRvkJD46pXMxR6lI
         CcA8lG9J75xgg7wpuJPAUJ51YNrIZFEGjnSKnrn/rqJ1/krjfncLnGGdOvFCggnABQ5k
         eqfeb8y+G4nWPPCfGcFbiqpybrayZBx7DJeI813rSz+Q9eXQdklRcNg7UxvJdHQzXJLp
         i7m4dbLlOaMv8vJtJoCmoFb7MFOfNnR4KLWJLnzfEXsGAmqTBpbX5+TrG+qKK5g8cm/r
         tJpPlzv3KhOyjRQqk0I3jXxecd0pc79gtUNJQBzXQ9LqsxVjKEBlarf5QNB2Jyq9Vy0v
         1R0A==
X-Gm-Message-State: AO0yUKX+izmANB3aX/iOevgqQQD/KA7oDJ1N22wBXYhM4AZ7FIlML30I
        EnBG1b1hIgvOFEAzqiTbWoDjish35hZzmGvG3NXwRq2B2ZlOaVJSLpvy9/rnMUL5VU83NsyxYxw
        ZZAsIPGdinszHV1KLJxIFWA2PnAiWFnQyMjQSaffiqJMZyJSRvBhgqjofgitQg0sVGz81u3UIh0
        TFNvR+
X-Received: by 2002:a17:906:590:b0:886:ec6e:4c1 with SMTP id 16-20020a170906059000b00886ec6e04c1mr25842923ejn.59.1678372663919;
        Thu, 09 Mar 2023 06:37:43 -0800 (PST)
X-Google-Smtp-Source: AK7set+8Ai+2N/L7oz8tkA0VJnU8/ak/ml4LhN6V0kM45F3e1HqAWUKQ7zo9N3LSN5AawssJg1gqhA==
X-Received: by 2002:a17:906:590:b0:886:ec6e:4c1 with SMTP id 16-20020a170906059000b00886ec6e04c1mr25842903ejn.59.1678372663626;
        Thu, 09 Mar 2023 06:37:43 -0800 (PST)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t26-20020a1709060c5a00b008ec793ac3f4sm8850232ejf.192.2023.03.09.06.37.42
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 06:37:43 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace] libsemanage: include more parameters in the module checksum
Date:   Thu,  9 Mar 2023 15:37:41 +0100
Message-Id: <20230309143741.346749-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The check_ext_changes option currently assumes that as long as the
module content is unchanged, it is safe to assume that the policy.linked
file doesn't need to be rebuilt. However, there are some additional
parameters that can affect the content of this policy file, namely:
* the disable_dontaudit and preserve_tunables flags
* the target_platform and policyvers configuration values

Include these in the checksum so that the option works correctly when
only some of these input values are changed versus the current state.

Fixes: 286a679fadc4 ("libsemanage: optionally rebuild policy when modules are changed externally")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libsemanage/src/direct_api.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 7aa081ab..d740070d 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -863,6 +863,14 @@ static void update_checksum_with_len(Sha256Context *context, size_t s)
 	Sha256Update(context, buffer, 8);
 }
 
+static void update_checksum_with_bool(Sha256Context *context, bool b)
+{
+	uint8_t byte;
+
+	byte = b ? UINT8_C(1) : UINT8_C(0);
+	Sha256Update(context, &byte, 1);
+}
+
 static int semanage_compile_module(semanage_handle_t *sh,
 				   semanage_module_info_t *modinfo,
 				   Sha256Context *context)
@@ -977,13 +985,21 @@ static int modinfo_cmp(const void *a, const void *b)
 	return strcmp(ma->name, mb->name);
 }
 
+struct extra_checksum_params {
+	int disable_dontaudit;
+	int preserve_tunables;
+	int target_platform;
+	int policyvers;
+};
+
 static int semanage_compile_hll_modules(semanage_handle_t *sh,
 					semanage_module_info_t *modinfos,
 					int num_modinfos,
+					const struct extra_checksum_params *extra,
 					char *cil_checksum)
 {
 	/* to be incremented when checksum input data format changes */
-	static const size_t CHECKSUM_EPOCH = 1;
+	static const size_t CHECKSUM_EPOCH = 2;
 
 	int i, status = 0;
 	char cil_path[PATH_MAX];
@@ -1000,6 +1016,10 @@ static int semanage_compile_hll_modules(semanage_handle_t *sh,
 
 	Sha256Initialise(&context);
 	update_checksum_with_len(&context, CHECKSUM_EPOCH);
+	update_checksum_with_bool(&context, !!extra->disable_dontaudit);
+	update_checksum_with_bool(&context, !!extra->preserve_tunables);
+	update_checksum_with_len(&context, (size_t)extra->target_platform);
+	update_checksum_with_len(&context, (size_t)extra->policyvers);
 
 	/* prefix with module count to avoid collisions */
 	update_checksum_with_len(&context, num_modinfos);
@@ -1134,6 +1154,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	mode_t mask = umask(0077);
 	struct stat sb;
 	char modules_checksum[CHECKSUM_CONTENT_SIZE + 1 /* '\0' */];
+	struct extra_checksum_params extra;
 
 	int do_rebuild, do_write_kernel, do_install;
 	int fcontexts_modified, ports_modified, seusers_modified,
@@ -1274,8 +1295,14 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 			goto cleanup;
 		}
 
+		extra = (struct extra_checksum_params){
+			.disable_dontaudit = sepol_get_disable_dontaudit(sh->sepolh),
+			.preserve_tunables = sepol_get_preserve_tunables(sh->sepolh),
+			.target_platform = sh->conf->target_platform,
+			.policyvers = sh->conf->policyvers,
+		};
 		retval = semanage_compile_hll_modules(sh, modinfos, num_modinfos,
-						      modules_checksum);
+						      &extra, modules_checksum);
 		if (retval < 0) {
 			ERR(sh, "Failed to compile hll files into cil files.\n");
 			goto cleanup;
-- 
2.39.2

