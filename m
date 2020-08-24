Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B33C433DF
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 13:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E8A52074D
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 13:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JzkyX/v2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgHXNp0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:45:26 -0400
Received: from linux.microsoft.com ([13.77.154.182]:41400 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgHXNp0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 09:45:26 -0400
Received: from chpebeni.pebenito.net (pool-108-15-23-247.bltmmd.fios.verizon.net [108.15.23.247])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1B66F20B4908
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 06:45:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1B66F20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598276726;
        bh=+cBwuzq1pIiKy1uH2kwj7CBH4t6lVfHLr8WUj2WSP/Q=;
        h=From:To:Subject:Date:From;
        b=JzkyX/v2v0WtIS5QJKu4TJ1gBfHhsghklUV9fbmHE1a4TPH81Aqr9sWTY0mwPo3AP
         ur8mqVemDnUtUNwGoa2lKo+D14DHFEiyBqlbje2WZohKNbtHMR9VkJxtJ37B0TuagY
         8e9rRNkZk4QF3hIo6Cn4qQ4mIjVaUrGXPxd1ey1g=
From:   Chris PeBenito <chpebeni@linux.microsoft.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 1/1] libselinux: Remove trailing slash on selabel_file lookups.
Date:   Mon, 24 Aug 2020 09:44:16 -0400
Message-Id: <20200824134416.331220-1-chpebeni@linux.microsoft.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Having a trailing slash on a file lookup, e.g. "/some/path/", can
cause a different result, for example,  when file contexts are written to have
the directory have a different label than the contents.  This is inconsistent
with normal Linux behaviors where trailing slashes are ignored.

Many callers already strip the trailing slash before the lookup or users
revise the file contexts to work around this.  This fixes it comprehensively.

v2: fix length issues

Signed-off-by: Chris PeBenito <chpebeni@linux.microsoft.com>
---
 libselinux/src/label_file.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 412904d1..6eeeea68 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -854,6 +854,7 @@ static const struct spec **lookup_all(struct selabel_handle *rec,
 	struct saved_data *data = (struct saved_data *)rec->data;
 	struct spec *spec_arr = data->spec_arr;
 	int i, rc, file_stem;
+	size_t len;
 	mode_t mode = (mode_t)type;
 	char *clean_key = NULL;
 	const char *prev_slash, *next_slash;
@@ -894,6 +895,27 @@ static const struct spec **lookup_all(struct selabel_handle *rec,
 		key = clean_key;
 	}
 
+	/* remove trailing slash */
+	len = strlen(key);
+	if (len == 0) {
+		errno = EINVAL;
+		goto finish;
+	}
+
+	if (key[len - 1] == '/') {
+		/* reuse clean_key from above if available */
+		if (!clean_key) {
+			clean_key = (char *) malloc(len);
+			if (!clean_key)
+				goto finish;
+
+			strncpy(clean_key, key, len - 1);
+		}
+
+		clean_key[len - 1] = '\0';
+		key = clean_key;
+	}
+
 	sub = selabel_sub_key(data, key);
 	if (sub)
 		key = sub;
-- 
2.26.2

