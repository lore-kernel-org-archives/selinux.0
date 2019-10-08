Return-Path: <SRS0=qSAh=YB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51092C10F14
	for <selinux@archiver.kernel.org>; Tue,  8 Oct 2019 12:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DB62070B
	for <selinux@archiver.kernel.org>; Tue,  8 Oct 2019 12:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbfJHMWU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:22:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730316AbfJHMWU (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 8 Oct 2019 08:22:20 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8D2493082E0F
        for <selinux@vger.kernel.org>; Tue,  8 Oct 2019 12:22:20 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1110019C68
        for <selinux@vger.kernel.org>; Tue,  8 Oct 2019 12:22:19 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/2] libsemanage: Add support for DCCP and SCTP protocols
Date:   Tue,  8 Oct 2019 14:22:12 +0200
Message-Id: <20191008122213.9227-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 08 Oct 2019 12:22:20 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is necessary for "semanage port" to be able to handle DCCP and SCTP
protocols.

Fixes:
    "port_parse" only handles TCP and UDP protocols

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 libsemanage/include/semanage/port_record.h | 2 ++
 libsemanage/src/ports_file.c               | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/libsemanage/include/semanage/port_record.h b/libsemanage/include/semanage/port_record.h
index 20ae4bd9..71074800 100644
--- a/libsemanage/include/semanage/port_record.h
+++ b/libsemanage/include/semanage/port_record.h
@@ -16,6 +16,8 @@ typedef struct semanage_port_key semanage_port_key_t;
 
 #define SEMANAGE_PROTO_UDP 0
 #define SEMANAGE_PROTO_TCP 1
+#define SEMANAGE_PROTO_DCCP 2
+#define SEMANAGE_PROTO_SCTP 3
 
 /* Key */
 extern int semanage_port_compare(const semanage_port_t * port,
diff --git a/libsemanage/src/ports_file.c b/libsemanage/src/ports_file.c
index 46ee2f00..4738d467 100644
--- a/libsemanage/src/ports_file.c
+++ b/libsemanage/src/ports_file.c
@@ -84,6 +84,10 @@ static int port_parse(semanage_handle_t * handle,
 		semanage_port_set_proto(port, SEMANAGE_PROTO_TCP);
 	else if (!strcasecmp(str, "udp"))
 		semanage_port_set_proto(port, SEMANAGE_PROTO_UDP);
+	else if (!strcasecmp(str, "dccp"))
+		semanage_port_set_proto(port, SEMANAGE_PROTO_DCCP);
+	else if (!strcasecmp(str, "sctp"))
+		semanage_port_set_proto(port, SEMANAGE_PROTO_SCTP);
 	else {
 		ERR(handle, "invalid protocol \"%s\" (%s: %u):\n%s", str,
 		    info->filename, info->lineno, info->orig_line);
-- 
2.21.0

