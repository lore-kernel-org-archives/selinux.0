Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E629C43381
	for <selinux@archiver.kernel.org>; Thu, 11 Mar 2021 15:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3516E64FF1
	for <selinux@archiver.kernel.org>; Thu, 11 Mar 2021 15:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbhCKPlX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Mar 2021 10:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbhCKPlL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Mar 2021 10:41:11 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CDCC061574
        for <selinux@vger.kernel.org>; Thu, 11 Mar 2021 07:41:11 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id u7so1427117qtq.12
        for <selinux@vger.kernel.org>; Thu, 11 Mar 2021 07:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pdjCddkZNOJ6GMfPQeaCMkWOvT+DWAzKiq8y14C4Aao=;
        b=axCO2PymNhBDawYWkphWNaHb5I4JpUT9omeMuGcR7A7482vaYohnceV9i1TFhSo8Q0
         8g9+yP3IPyvE1v71EIhp4Ed4nUF3SWmYL4W8OPe6x9hMKr1x0QCvMNPDPYXMWgYsvLe9
         wlDyWvKSqG8yp2bHhTBndrLDt/ZvEdGZ3pcdt39xtT160/N+VJ9VyTuyMM7vgpfrDxfG
         J1XQIKmoYgnHDsCiZcJ4blPCcVpx3AHBl3MISlS6P8KjfqxHdRUl3YyFHe/87QxYTcC3
         Zi4WoSVj7BdzpuAOx7M0LvJAXCDElhvGiNEe3m368soFPxqccVzt7+fvmv//vjsP8mge
         8ExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pdjCddkZNOJ6GMfPQeaCMkWOvT+DWAzKiq8y14C4Aao=;
        b=TofjplPpbKHJ/xTZOI68qO0cFggi92DWsJ7XhjLKRqlUKVlcipkaw3UpRVLNnLwVNs
         gVF2lWCBh4wTGAWkM+A1q9gIyGqFJYeqX6fOArEBkoHKENbfCxYZeSlIEii6Kzg7wGSX
         6lKIvfBpHK3pyp+cPHDuDpJnWM8qFMO6YlJbgWLz1N6Ru9PwEEOWme62dg6eZEJYf2CW
         CQ+1Gi6x5UotlThdD8Oq+NphOOJ0c3XpqTNRrsKkX+KaTkV7wrLfgH7FQVw+q1Ar0ZFn
         ssd+kHi/PWhk7AC5T45/Gh87HvdiHtF+g8IpnwQKTPwS4JXAtWikwgd/cTs0OJIUo1Qt
         +umA==
X-Gm-Message-State: AOAM530bTHxC2KT4M/It0u8TNQTGShuOeYMuCDn9B/6ba6gDpN8yNa/N
        mA0Hbud4N56igm0giuSCJ0gJVdBOdbQ=
X-Google-Smtp-Source: ABdhPJyvF/MS8EVOp9ktMbZsQNcJu4BT2chT9/PS4X9YdTBc5eqyt7zR3oAU1B+jG3vrjhItVW8Cxg==
X-Received: by 2002:ac8:1385:: with SMTP id h5mr7958835qtj.298.1615477270150;
        Thu, 11 Mar 2021 07:41:10 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id d70sm2211152qkg.30.2021.03.11.07.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 07:41:09 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/2] libsepol: Check kernel to CIL and Conf functions for supported versions
Date:   Thu, 11 Mar 2021 10:41:05 -0500
Message-Id: <20210311154105.195494-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210311154105.195494-1-jwcart2@gmail.com>
References: <20210311154105.195494-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

For policy versions between 20 and 23, attributes exist in the
policy, but only in the type_attr_map. This means that there are
gaps in both the type_val_to_struct and p_type_val_to_name arrays
and policy rules can refer to those gaps which can lead to NULL
dereferences when using sepol_kernel_policydb_to_conf() and
sepol_kernel_policydb_to_cil().

This can be seen with the following policy:
  class CLASS1
  sid SID1
  class CLASS1 { PERM1 }
  attribute TYPE_ATTR1;
  type TYPE1;
  typeattribute TYPE1 TYPE_ATTR1;
  allow TYPE_ATTR1 self : CLASS1 PERM1;
  role ROLE1;
  role ROLE1 types TYPE1;
  user USER1 roles ROLE1;
  sid SID1 USER1:ROLE1:TYPE1

Compile the policy:
  checkpolicy -c 23 -o policy.bin policy.conf
Converting back to a policy.conf causes a segfault:
  checkpolicy -F -b -o policy.bin.conf policy.bin

Have both sepol_kernel_policydb_to_conf() and
sepol_kernel_policydb_to_cil() exit with an error if the kernel
policy version is between 20 and 23.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/kernel_to_cil.c  | 12 ++++++++++++
 libsepol/src/kernel_to_conf.c | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index a146ac51..edfebeaf 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -3164,6 +3164,18 @@ int sepol_kernel_policydb_to_cil(FILE *out, struct policydb *pdb)
 		goto exit;
 	}
 
+	if (pdb->policyvers >= POLICYDB_VERSION_AVTAB && pdb->policyvers <= POLICYDB_VERSION_PERMISSIVE) {
+		/*
+		 * For policy versions between 20 and 23, attributes exist in the policy,
+		 * but only in the type_attr_map. This means that there are gaps in both
+		 * the type_val_to_struct and p_type_val_to_name arrays and policy rules
+		 * can refer to those gaps.
+		 */
+		sepol_log_err("Writing policy versions between 20 and 23 as CIL is not supported");
+		rc = -1;
+		goto exit;
+	}
+
 	rc = constraint_rules_to_strs(pdb, mls_constraints, non_mls_constraints);
 	if (rc != 0) {
 		goto exit;
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index a22f196d..ea58a026 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -3041,6 +3041,18 @@ int sepol_kernel_policydb_to_conf(FILE *out, struct policydb *pdb)
 		goto exit;
 	}
 
+	if (pdb->policyvers >= POLICYDB_VERSION_AVTAB && pdb->policyvers <= POLICYDB_VERSION_PERMISSIVE) {
+		/*
+		 * For policy versions between 20 and 23, attributes exist in the policy,
+		 * but only in the type_attr_map. This means that there are gaps in both
+		 * the type_val_to_struct and p_type_val_to_name arrays and policy rules
+		 * can refer to those gaps.
+		 */
+		sepol_log_err("Writing policy versions between 20 and 23 as a policy.conf is not supported");
+		rc = -1;
+		goto exit;
+	}
+
 	rc = constraint_rules_to_strs(pdb, mls_constraints, non_mls_constraints);
 	if (rc != 0) {
 		goto exit;
-- 
2.26.2

