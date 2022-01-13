Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9069C433EF
	for <selinux@archiver.kernel.org>; Thu, 13 Jan 2022 20:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbiAMUoK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Jan 2022 15:44:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54100 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230515AbiAMUoK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Jan 2022 15:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642106649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NZbg7Yf33QwWotW/PA2gqVzkSFJqo9IneF8O+CyB4v4=;
        b=bnjuD0Yt/CiCMLZYEYrtU6p4b55BMqZ6LxFFN2iiKrj9brDb0Rg6nScZpfnIkqXF/TOGnw
        K5TrOGUzcTiOL/ONay/8s2SmnkmFzwqRcVCN8moP7dHne7ik+RjAGCWqHLlquckQS17qiR
        qRYrjJJqcaPqq6dDibkQGLuJeHMKzC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-L5Wrpbk5NYSIrDuxt3mF_w-1; Thu, 13 Jan 2022 15:44:08 -0500
X-MC-Unique: L5Wrpbk5NYSIrDuxt3mF_w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 510561934100
        for <selinux@vger.kernel.org>; Thu, 13 Jan 2022 20:44:07 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.192.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF3A0610A8
        for <selinux@vger.kernel.org>; Thu, 13 Jan 2022 20:44:06 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libselinux: Strip spaces before values in config
Date:   Thu, 13 Jan 2022 21:43:53 +0100
Message-Id: <20220113204353.185947-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Spaces before values in /etc/selinux/config should be ignored just as
spaces after them are.

E.g. "SELINUXTYPE= targeted" should be a valid value.

Fixes:
   # sed -i 's/^SELINUXTYPE=/SELINUXTYPE= /g' /etc/selinux/config
   # dnf install <any_package>
   ...
   RPM: error: selabel_open: (/etc/selinux/ targeted/contexts/files/file_contexts) No such file or directory
   RPM: error: Plugin selinux: hook tsm_pre failed
   ...
   Error: Could not run transaction.

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 libselinux/src/selinux_config.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index 97f81a8b..99cd6124 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -92,6 +92,7 @@ int selinux_getenforcemode(int *enforce)
 	FILE *cfg = fopen(SELINUXCONFIG, "re");
 	if (cfg) {
 		char *buf;
+		char *tag;
 		int len = sizeof(SELINUXTAG) - 1;
 		buf = malloc(selinux_page_size);
 		if (!buf) {
@@ -101,21 +102,24 @@ int selinux_getenforcemode(int *enforce)
 		while (fgets_unlocked(buf, selinux_page_size, cfg)) {
 			if (strncmp(buf, SELINUXTAG, len))
 				continue;
+			tag = buf+len;
+			while (isspace(*tag))
+				tag++;
 			if (!strncasecmp
-			    (buf + len, "enforcing", sizeof("enforcing") - 1)) {
+			    (tag, "enforcing", sizeof("enforcing") - 1)) {
 				*enforce = 1;
 				ret = 0;
 				break;
 			} else
 			    if (!strncasecmp
-				(buf + len, "permissive",
+				(tag, "permissive",
 				 sizeof("permissive") - 1)) {
 				*enforce = 0;
 				ret = 0;
 				break;
 			} else
 			    if (!strncasecmp
-				(buf + len, "disabled",
+				(tag, "disabled",
 				 sizeof("disabled") - 1)) {
 				*enforce = -1;
 				ret = 0;
@@ -176,7 +180,10 @@ static void init_selinux_config(void)
 
 			if (!strncasecmp(buf_p, SELINUXTYPETAG,
 					 sizeof(SELINUXTYPETAG) - 1)) {
-				type = strdup(buf_p + sizeof(SELINUXTYPETAG) - 1);
+				buf_p += sizeof(SELINUXTYPETAG) - 1;
+				while (isspace(*buf_p))
+					buf_p++;
+				type = strdup(buf_p);
 				if (!type) {
 					free(line_buf);
 					fclose(fp);
@@ -199,6 +206,8 @@ static void init_selinux_config(void)
 			} else if (!strncmp(buf_p, REQUIRESEUSERS,
 					    sizeof(REQUIRESEUSERS) - 1)) {
 				value = buf_p + sizeof(REQUIRESEUSERS) - 1;
+				while (isspace(*value))
+					buf_p++;
 				intptr = &require_seusers;
 			} else {
 				continue;
-- 
2.34.1

