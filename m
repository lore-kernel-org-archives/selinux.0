Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1063DEB64D9
	for <selinux@archiver.kernel.org>; Thu,  6 Jul 2023 14:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjGFONl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Jul 2023 10:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjGFONk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Jul 2023 10:13:40 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAD4199D
        for <selinux@vger.kernel.org>; Thu,  6 Jul 2023 07:13:35 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fb960b7c9dso1053655e87.0
        for <selinux@vger.kernel.org>; Thu, 06 Jul 2023 07:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688652813; x=1691244813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sjtq77NRqZuHrbwIJzQ8FnOcnTqs+NeOMam1ZM0PEbY=;
        b=SsRPMt17uV1AO96jwJn4hCF2kbKq4KVjC5ESZr9L9NqDdLv7HczRzPQqti2uBxxT+F
         f9pHsv7/yhy5J0a7K5876mhUYRNmZ5vqbzhzlRovrEWNSkX5gpeLmHhI6QcS3LclmHB2
         Dv2lizc1dqY79gu1XYy8j58OukB2BTiLm4VpyhWN0CinmJw7EYUxgDkesOpZV7dlIacU
         VcdTpGAi71jclbVg8gCDybz3kPq2hOZK7iHuqf7b5pN2s8JI+bebApF5aeqPVL8ojjCg
         TBpWjabjb764W+SDHRcG8iFpymxnNpiLeva4up2jOl2sR2YZAWZlkAdsln13CFulX39C
         6ovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688652813; x=1691244813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sjtq77NRqZuHrbwIJzQ8FnOcnTqs+NeOMam1ZM0PEbY=;
        b=bFyIj2b39bP4mRIZkahpZ6KuDVxJPkylMdt8oMnEgN0H7pcyIaiEQq3srhJRrbumKB
         IskpVK6KRpVDj2Hvh1ER1x+z25ubWey893Y3Fo9gg7glrSVVgB0cJXphb+aUHbqgGfID
         /tnOGEToZQMnuAlC7v0fVxB8B/2Rx4aCEEs0h3IVPPpSk3ZGPi9bn9EZBfaNzvSH8PcB
         aaYAs2PuHCXJVihB+5blExwzM/hBblVklXqLLv0zDYRemCwTMpW5yrKf8HBQpUTMXyu1
         mC1iBVBGpWdGxOkRUwXZC0zH4lGy2nuuOlDlEeeGWmNAX/sSPKghh/+RP2wwQbYffJu+
         891w==
X-Gm-Message-State: ABy/qLZ1wMmqO7nlCeC4J8wJPWuRC3LhfHDeUggywDPENGsusmIcF/4W
        0b+hu/8Uj81eklP143UE2DoFvU0fR+Ld45FZ
X-Google-Smtp-Source: APBJJlGLuVEbm+CB54gp79XC6gnvf6Xig3/UVkkKXljuYKFrLA8v4+Pp00gVgJnFn/iO1H+VEK2XFQ==
X-Received: by 2002:a05:6512:451:b0:4f9:5ac3:4133 with SMTP id y17-20020a056512045100b004f95ac34133mr1548695lfk.25.1688652813386;
        Thu, 06 Jul 2023 07:13:33 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id l14-20020a056402344e00b0051e22660835sm834101edc.46.2023.07.06.07.13.32
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 07:13:33 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH] libsepol/cil: support parallel neverallow checks
Date:   Thu,  6 Jul 2023 16:13:29 +0200
Message-Id: <20230706141329.57661-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add support to check for neverallow assertions in parallel.  Since the
policy is not modified during those checks there needs to be no
extensive locking.

The checks are run by semodule(8) if the semanage.conf(5) setting
expand-check is set.

Implement the parallel procedure via OpenMP, to minimize code changes
and to allow users a simple way to enable or disable the functionality
at build time.  Currently the support opt-in.

Example benchmark:

    Benchmark 1: ./test_load_wip.sh (serial)
      Time (mean ± σ):      3.485 s ±  0.019 s    [User: 0.003 s, System: 0.002 s]
      Range (min … max):    3.455 s …  3.501 s    5 runs

    Benchmark 1: ./test_load_wip.sh (parallel)
      Time (mean ± σ):      2.443 s ±  0.035 s    [User: 0.004 s, System: 0.001 s]
      Range (min … max):    2.411 s …  2.500 s    5 runs

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_binary.c | 60 ++++++++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 12 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index c4ee2380..7f6212e3 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -4828,8 +4828,11 @@ static int cil_check_neverallow(const struct cil_db *db, policydb_t *pdb, struct
 
 		rc = check_assertion(pdb, rule);
 		if (rc == CIL_TRUE) {
-			*violation = CIL_TRUE;
-			rc = __cil_print_neverallow_failure(db, node);
+			#pragma omp critical (output)
+			{
+				*violation = CIL_TRUE;
+				rc = __cil_print_neverallow_failure(db, node);
+			}
 			if (rc != SEPOL_OK) {
 				goto exit;
 			}
@@ -4850,8 +4853,11 @@ static int cil_check_neverallow(const struct cil_db *db, policydb_t *pdb, struct
 			rule->xperms = item->data;
 			rc = check_assertion(pdb, rule);
 			if (rc == CIL_TRUE) {
-				*violation = CIL_TRUE;
-				rc = __cil_print_neverallow_failure(db, node);
+				#pragma omp critical (output)
+				{
+					*violation = CIL_TRUE;
+					rc = __cil_print_neverallow_failure(db, node);
+				}
 				if (rc != SEPOL_OK) {
 					goto exit;
 				}
@@ -4876,18 +4882,48 @@ exit:
 
 static int cil_check_neverallows(const struct cil_db *db, policydb_t *pdb, struct cil_list *neverallows, int *violation)
 {
-	int rc = SEPOL_OK;
-	struct cil_list_item *item;
+	int rc_sync = SEPOL_OK;
+
+	#pragma omp parallel
+	{
+
+		#pragma omp single
+		{
+
+			struct cil_list_item *item;
+			cil_list_for_each(item, neverallows) {
+
+				struct cil_tree_node *node = item->data;
+				int rc_test;
+
+				#pragma omp task default(none) firstprivate(node, db, pdb, violation) shared(rc_sync) untied
+				{
+					int rc_task = cil_check_neverallow(
+						db,
+						pdb,
+						node,
+						violation);
+
+					if (rc_task != SEPOL_OK) {
+						#pragma omp atomic write
+						rc_sync = rc_task;
+					}
+				}
+
+				#pragma omp atomic read
+				rc_test = rc_sync;
+
+				if (rc_test != SEPOL_OK)
+					break;
+
+			}
 
-	cil_list_for_each(item, neverallows) {
-		rc = cil_check_neverallow(db, pdb, item->data, violation);
-		if (rc != SEPOL_OK) {
-			goto exit;
 		}
+
+		#pragma omp taskwait
 	}
 
-exit:
-	return rc;
+	return rc_sync;
 }
 
 static struct cil_list *cil_classperms_from_sepol(policydb_t *pdb, uint16_t class, uint32_t data, struct cil_class *class_value_to_cil[], struct cil_perm **perm_value_to_cil[])
-- 
2.40.1

