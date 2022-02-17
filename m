Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B99EC433F5
	for <selinux@archiver.kernel.org>; Thu, 17 Feb 2022 13:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbiBQNOj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Feb 2022 08:14:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240755AbiBQNOj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Feb 2022 08:14:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C8C42ABD0E
        for <selinux@vger.kernel.org>; Thu, 17 Feb 2022 05:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645103664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iE+CxckCO+7ipdJbB96KKK1D9EwVhLCDG5lLzk1QpNM=;
        b=hkhb7X25uEwn5JvHydysDu3X84nNpAcPxDujr4kEhLfYyLL0zFQ0t7ZrSMnw/xmM7X4dR3
        9v+sYN8EEf9FP80JGnJjsUSc/P0C2NNbDTbz2lRqmchdTpMMXTM5XjgQAe57jnuzcjAcoD
        ES1mfAhGyQqP7wfWL0c8QdQ63f3Net0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-Ir4wBg-7Ob2Qdzjl4AOOGg-1; Thu, 17 Feb 2022 08:14:22 -0500
X-MC-Unique: Ir4wBg-7Ob2Qdzjl4AOOGg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E279801AA6
        for <selinux@vger.kernel.org>; Thu, 17 Feb 2022 13:14:21 +0000 (UTC)
Received: from thinkpad-work.redhat.com (unknown [10.40.194.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CDA806FB0F
        for <selinux@vger.kernel.org>; Thu, 17 Feb 2022 13:14:20 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2] libselinux: Strip spaces before values in config
Date:   Thu, 17 Feb 2022 14:14:15 +0100
Message-Id: <20220217131415.1195383-1-vmojzis@redhat.com>
In-Reply-To: <d7cf167d-1c12-5486-336e-1689c5223631@redhat.com>
References: <d7cf167d-1c12-5486-336e-1689c5223631@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Sorry for the delay. I sent the fixed patch to a wrong mailing list.

 libselinux/src/selinux_config.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index 97f81a8b..d2e49ee1 100644
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
+					value++;
 				intptr = &require_seusers;
 			} else {
 				continue;
-- 
2.30.2

