Return-Path: <SRS0=ZZHY=7D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD2DC433E0
	for <selinux@archiver.kernel.org>; Thu, 21 May 2020 14:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BB0F20721
	for <selinux@archiver.kernel.org>; Thu, 21 May 2020 14:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlZul831"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbgEUO7k (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 May 2020 10:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgEUO7k (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 May 2020 10:59:40 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E5AC061A0E
        for <selinux@vger.kernel.org>; Thu, 21 May 2020 07:59:38 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id z80so7540645qka.0
        for <selinux@vger.kernel.org>; Thu, 21 May 2020 07:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jU6raySYtgqJoggAaktXMck8xKnmI3ZMLzn4xs03a1Y=;
        b=VlZul831GL7TgdhLKHIECbDbDpcWH9zbXm/UhMKYbyXSVZiz5SRTy9HgWRBxqXLHgQ
         XzyI9pD9ztSS3x3G/7It/Ie4jw3wed/T6DGCxGo1uE/sV2EEp1KgqMFNPcwJuZVevXBt
         qZ/uXnpMLqbvhOP/gjUfI37MT4N0Dqhsm1au6Z6xTHuLKA0kh8LVGAVwAL0fIZuRXQCA
         OSUWTtsAMZFRGuSf2pGVh1nxTjMV+GDmjPXvUA9BGIEM9PEf7Byp4o2iZLmSzkdfeY1A
         8S6LBwUq41+Hm1o4X3nNZEWzgXYbTThv6Duf8OLsVvFcvqPvFblz0zmWfgS1/MNLMrtJ
         xAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jU6raySYtgqJoggAaktXMck8xKnmI3ZMLzn4xs03a1Y=;
        b=EBY5k3XZ1b0JT9knRmH68sfX8TVHSnK5Q3wF7XQN6ZMV5789M7JNyEfG0Th5DA+OH3
         60Shq3TK772huoiDw1T6W8zF0888NDp8m2RRejGmyEQnoW+t7M+3ysn6X0A4lCxvOacu
         mBIFtXnWSzHs+MBZonNHgJms9HbpROfk879l/TLzDlpbKMaf8sS5ymxey15QljIt1Ygr
         vkTT8FkSgtinGXsJCzOC1uc0uC5LFf+GwemOsbXJKXmXuZ4Tmvese4io+aLQEJe7w3hV
         DjzI5BcTjuNibVNp9xGG5inPUgxRc/RXvuYHihgZ+Mts2C7d0kr43ElWDqI+Oz5zOM2O
         drLg==
X-Gm-Message-State: AOAM531Z7nQ5bt4MtVJHBS0p7gWIqCDJVASR8P9F73XleJvAt0sjKSLR
        aAOOgjjRd0jCkt/bIVesIdo0vv2zDKs=
X-Google-Smtp-Source: ABdhPJxoh8S8RUtPKkfkOei3UAEgZ7CH5DFqBejj5NrOEe0ZlarSbF54zEf8owTU9dzVRbfsbZWayQ==
X-Received: by 2002:a05:620a:950:: with SMTP id w16mr4921999qkw.42.1590073177856;
        Thu, 21 May 2020 07:59:37 -0700 (PDT)
Received: from localhost.localdomain (pool-71-166-99-106.bltmmd.east.verizon.net. [71.166.99.106])
        by smtp.gmail.com with ESMTPSA id n42sm5297481qtf.51.2020.05.21.07.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 07:59:37 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH v2 1/2] libsepol: Fix type alias handling in kernel_to_cil
Date:   Thu, 21 May 2020 10:59:24 -0400
Message-Id: <20200521145925.143481-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Type alias rules are not written out when converting a binary kernel
policy to CIL. The problem is that type aliases are not in the
type_val_to_struct array and that is what is being used to find the
aliases.

Since type aliases are only in the types hashtable, walk that to
find the type aliases.

Fixes: 70a480bfcd46214a ("libsepol: Add ability to convert binary
       policy to CIL")

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2: No changes

 libsepol/src/kernel_to_cil.c | 44 +++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index ede78a20..bc5f9b52 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -1367,33 +1367,55 @@ exit:
 	return rc;
 }
 
+static int map_count_type_aliases(char *key, void *data, void *args)
+{
+	type_datum_t *datum = data;
+	unsigned *count = args;
+
+	if (datum->primary == 0 && datum->flavor == TYPE_TYPE)
+		(*count)++;
+
+	return SEPOL_OK;
+}
+
+static int map_type_aliases_to_strs(char *key, void *data, void *args)
+{
+	type_datum_t *datum = data;
+	struct strs *strs = args;
+	int rc = 0;
+
+	if (datum->primary == 0 && datum->flavor == TYPE_TYPE)
+		rc = strs_add(strs, key);
+
+	return rc;
+}
+
 static int write_type_alias_rules_to_cil(FILE *out, struct policydb *pdb)
 {
 	type_datum_t *alias;
 	struct strs *strs;
 	char *name;
 	char *type;
-	unsigned i, num;
+	unsigned i, num = 0;
 	int rc = 0;
 
-	rc = strs_init(&strs, pdb->p_types.nprim);
+	rc = hashtab_map(pdb->p_types.table, map_count_type_aliases, &num);
 	if (rc != 0) {
 		goto exit;
 	}
 
-	for (i=0; i < pdb->p_types.nprim; i++) {
-		alias = pdb->type_val_to_struct[i];
-		if (!alias->primary) {
-			rc = strs_add(strs, pdb->p_type_val_to_name[i]);
-			if (rc != 0) {
-				goto exit;
-			}
-		}
+	rc = strs_init(&strs, num);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	rc = hashtab_map(pdb->p_types.table, map_type_aliases_to_strs, strs);
+	if (rc != 0) {
+		goto exit;
 	}
 
 	strs_sort(strs);
 
-	num = strs_num_items(strs);
 	for (i=0; i<num; i++) {
 		name = strs_read_at_index(strs, i);
 		if (!name) {
-- 
2.25.4

