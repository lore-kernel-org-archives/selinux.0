Return-Path: <SRS0=JJ8R=XP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URI_HEX,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CF6C4CECD
	for <selinux@archiver.kernel.org>; Fri, 20 Sep 2019 06:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E31F20882
	for <selinux@archiver.kernel.org>; Fri, 20 Sep 2019 06:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404717AbfITGAH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Sep 2019 02:00:07 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:57313 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404716AbfITGAG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Sep 2019 02:00:06 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 3223956128C
        for <selinux@vger.kernel.org>; Fri, 20 Sep 2019 08:00:01 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 1/2] libselinux: ensure strlen() is not called on NULL
Date:   Fri, 20 Sep 2019 07:59:54 +0200
Message-Id: <20190920055955.2780-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri Sep 20 08:00:01 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When compile_regex() calls regex_prepare_data() and this function fails
in the following condition:

    *regex = regex_data_create();
    if (!(*regex))
        return -1;

... error_data has been zero-ed and compile_regex() calls:

    regex_format_error(&error_data,
        regex_error_format_buffer,
        sizeof(regex_error_format_buffer));

This leads to a call to strlen(error_data->error_buffer), where
error_data->error_buffer is NULL.

Avoid this by checking that error_data->error_buffer is not NULL before
trying to format it.

This issue has been found using clang's static analyzer:
https://337-118970575-gh.circle-artifacts.com/0/output-scan-build/2019-09-01-181851-6152-1/report-0b122b.html#EndPath

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/src/regex.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index a6fcbbfec1f3..c835dd1b0e5d 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -519,6 +519,29 @@ void regex_format_error(struct regex_error_data const *error_data, char *buffer,
 	if (pos >= buf_size)
 		goto truncated;
 
+	/* Return early if there is no error to format */
+#ifdef USE_PCRE2
+	if (!error_data->error_code) {
+		rc = snprintf(buffer + pos, buf_size - pos, "no error code");
+		if (rc < 0)
+			abort();
+		pos += rc;
+		if (pos >= buf_size)
+			goto truncated;
+		return;
+	}
+#else
+	if (!error_data->error_buffer) {
+		rc = snprintf(buffer + pos, buf_size - pos, "empty error");
+		if (rc < 0)
+			abort();
+		pos += rc;
+		if (pos >= buf_size)
+			goto truncated;
+		return;
+	}
+#endif
+
 	if (error_data->error_offset > 0) {
 #ifdef USE_PCRE2
 		rc = snprintf(buffer + pos, buf_size - pos, "At offset %zu: ",
-- 
2.22.0

