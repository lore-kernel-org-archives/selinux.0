Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4413C433E6
	for <selinux@archiver.kernel.org>; Thu, 14 Jan 2021 16:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7510623B28
	for <selinux@archiver.kernel.org>; Thu, 14 Jan 2021 16:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbhANQAs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Jan 2021 11:00:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39141 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726954AbhANQAs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Jan 2021 11:00:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610639974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8sohalURlLqkS/dAeI29tspxccsdOOzOgo3djb5q6do=;
        b=ejatkV+SluhqdOriKQDm9EEBatJnYyd37ZBTu7veciVGVkH+U64vpmqdhOJyRFyWPOTa6g
        bc/tAx2gadLPEuqOVPgN/4D+YxO3G7r6HO65Lezb0l+qSn9Ov1cioftOuFpGlGR3/GRFFo
        yxGkUcB2Nwe1KFyKbvxi85XP1oKb6JQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-E1EJC4CZOGeJqQhOB-bBKw-1; Thu, 14 Jan 2021 10:59:32 -0500
X-MC-Unique: E1EJC4CZOGeJqQhOB-bBKw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 661AD801FD7
        for <selinux@vger.kernel.org>; Thu, 14 Jan 2021 15:59:31 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.195.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8339D10023B3;
        Thu, 14 Jan 2021 15:59:30 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v2] libselinux: Always close status page fd
Date:   Thu, 14 Jan 2021 16:59:20 +0100
Message-Id: <20210114155920.293559-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

According to mmap(2) after the mmap() call has returned, the file
descriptor, fd, can be closed immediately without invalidating the
mapping.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---

Changes against v1:
- selinux_status_fd is completely droped as it's actually unused

 libselinux/src/sestatus.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/libselinux/src/sestatus.c b/libselinux/src/sestatus.c
index 9ff2785d876a..12b015e088ea 100644
--- a/libselinux/src/sestatus.c
+++ b/libselinux/src/sestatus.c
@@ -37,7 +37,6 @@ struct selinux_status_t
  * Valid Pointer : opened and mapped correctly
  */
 static struct selinux_status_t *selinux_status = NULL;
-static int			selinux_status_fd;
 static uint32_t			last_seqno;
 static uint32_t			last_policyload;
 
@@ -298,11 +297,10 @@ int selinux_status_open(int fallback)
 		goto error;
 
 	selinux_status = mmap(NULL, pagesize, PROT_READ, MAP_SHARED, fd, 0);
+	close(fd);
 	if (selinux_status == MAP_FAILED) {
-		close(fd);
 		goto error;
 	}
-	selinux_status_fd = fd;
 	last_seqno = (uint32_t)(-1);
 
 	/* sequence must not be changed during references */
@@ -336,7 +334,6 @@ error:
 
 		/* mark as fallback mode */
 		selinux_status = MAP_FAILED;
-		selinux_status_fd = avc_netlink_acquire_fd();
 		last_seqno = (uint32_t)(-1);
 
 		if (avc_using_threads)
@@ -388,7 +385,5 @@ void selinux_status_close(void)
 		munmap(selinux_status, pagesize);
 	selinux_status = NULL;
 
-	close(selinux_status_fd);
-	selinux_status_fd = -1;
 	last_seqno = (uint32_t)(-1);
 }
-- 
2.30.0

