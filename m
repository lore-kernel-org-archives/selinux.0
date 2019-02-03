Return-Path: <SRS0=Ce+3=QK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B6EC169C4
	for <selinux@archiver.kernel.org>; Sun,  3 Feb 2019 11:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2B220855
	for <selinux@archiver.kernel.org>; Sun,  3 Feb 2019 11:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfBCLCx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 3 Feb 2019 06:02:53 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:49346 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfBCLCx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 3 Feb 2019 06:02:53 -0500
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net [77.133.206.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id E6D9C564752
        for <selinux@vger.kernel.org>; Sun,  3 Feb 2019 12:02:49 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/1] libsepol: do not use uninitialized value for low_value
Date:   Sun,  3 Feb 2019 12:01:52 +0100
Message-Id: <20190203110152.15064-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Feb  3 12:02:50 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

clang's static analyzer reports a warning when low_bit is used without
having been initialized in statements such as:

    low_value = low_bit << 8;

The warning is: "Result of operation is garbage or undefined".

This is caused by low_bit being only initialized when in_range is true.
This issue is not critical because low_value is only used in an
"if (in_range)" block. Silence this warning by moving low_value's
assignment inside this block.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/kernel_to_cil.c | 4 ++--
 libsepol/src/module_to_cil.c | 4 ++--
 libsepol/src/util.c          | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 63e4d4899758..cd3554e8dfd9 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -1614,8 +1614,8 @@ static char *xperms_to_str(avtab_extended_perms_t *xperms)
 
 		if (xperms->specified & AVTAB_XPERMS_IOCTLFUNCTION) {
 			value = xperms->driver<<8 | bit;
-			low_value = xperms->driver<<8 | low_bit;
 			if (in_range) {
+				low_value = xperms->driver<<8 | low_bit;
 				len = snprintf(p, remaining, " (range 0x%hx 0x%hx)", low_value, value);
 				in_range = 0;
 			} else {
@@ -1623,8 +1623,8 @@ static char *xperms_to_str(avtab_extended_perms_t *xperms)
 			}
 		} else if (xperms->specified & AVTAB_XPERMS_IOCTLDRIVER) {
 			value = bit << 8;
-			low_value = low_bit << 8;
 			if (in_range) {
+				low_value = low_bit << 8;
 				len = snprintf(p, remaining, " (range 0x%hx 0x%hx)", low_value, (uint16_t) (value|0xff));
 				in_range = 0;
 			} else {
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 4cb44e0ee657..f04589edaeff 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -655,8 +655,8 @@ static int xperms_to_cil(const av_extended_perms_t *xperms)
 
 		if (xperms->specified & AVTAB_XPERMS_IOCTLFUNCTION) {
 			value = xperms->driver<<8 | bit;
-			low_value = xperms->driver<<8 | low_bit;
 			if (in_range) {
+				low_value = xperms->driver<<8 | low_bit;
 				cil_printf("(range 0x%hx 0x%hx)", low_value, value);
 				in_range = 0;
 			} else {
@@ -664,8 +664,8 @@ static int xperms_to_cil(const av_extended_perms_t *xperms)
 			}
 		} else if (xperms->specified & AVTAB_XPERMS_IOCTLDRIVER) {
 			value = bit << 8;
-			low_value = low_bit << 8;
 			if (in_range) {
+				low_value = low_bit << 8;
 				cil_printf("(range 0x%hx 0x%hx)", low_value, (uint16_t) (value|0xff));
 				in_range = 0;
 			} else {
diff --git a/libsepol/src/util.c b/libsepol/src/util.c
index b00251c69aa5..a4008882b94b 100644
--- a/libsepol/src/util.c
+++ b/libsepol/src/util.c
@@ -159,16 +159,16 @@ char *sepol_extended_perms_to_string(avtab_extended_perms_t *xperms)
 
 		if (xperms->specified & AVTAB_XPERMS_IOCTLFUNCTION) {
 			value = xperms->driver<<8 | bit;
-			low_value = xperms->driver<<8 | low_bit;
 			if (in_range) {
+				low_value = xperms->driver<<8 | low_bit;
 				len = snprintf(p, sizeof(xpermsbuf) - xpermslen, "0x%hx-0x%hx ", low_value, value);
 			} else {
 				len = snprintf(p, sizeof(xpermsbuf) - xpermslen, "0x%hx ", value);
 			}
 		} else if (xperms->specified & AVTAB_XPERMS_IOCTLDRIVER) {
 			value = bit << 8;
-			low_value = low_bit << 8;
 			if (in_range) {
+				low_value = low_bit << 8;
 				len = snprintf(p, sizeof(xpermsbuf) - xpermslen, "0x%hx-0x%hx ", low_value, (uint16_t) (value|0xff));
 			} else {
 				len = snprintf(p, sizeof(xpermsbuf) - xpermslen, "0x%hx-0x%hx ", value, (uint16_t) (value|0xff));
-- 
2.20.1

