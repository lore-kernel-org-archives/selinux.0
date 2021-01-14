Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D32C433DB
	for <selinux@archiver.kernel.org>; Thu, 14 Jan 2021 13:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8736423A5D
	for <selinux@archiver.kernel.org>; Thu, 14 Jan 2021 13:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbhANNlI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Jan 2021 08:41:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58160 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726244AbhANNlH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Jan 2021 08:41:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610631581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cZy30JSJbSe+0axgFfnRdZ+/uxKg4yr9J3YJ6ESyA4Q=;
        b=UskcpALGUaCwz+l2eYfEVPo1fRjCurYP9BrmflN48TnIrZxNe6faAyShWV74zc/F6a2tSv
        /FFHo2l/fbAPMRrOn4sgGqrbJoloCwlbi+QYqkPfI3tBA3Jkq1La/xFpiOWldtTTamUXhX
        7drnjdbzVmdjGf4cythryStRnMTwr68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-OacRNCfRPr-5aMs8Q0A9jA-1; Thu, 14 Jan 2021 08:39:38 -0500
X-MC-Unique: OacRNCfRPr-5aMs8Q0A9jA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 331BF806660
        for <selinux@vger.kernel.org>; Thu, 14 Jan 2021 13:39:37 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.195.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E8C5100AE3A;
        Thu, 14 Jan 2021 13:39:36 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] libselinux: Always close status page fd
Date:   Thu, 14 Jan 2021 14:39:10 +0100
Message-Id: <20210114133910.282686-1-plautrba@redhat.com>
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
 libselinux/src/sestatus.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/sestatus.c b/libselinux/src/sestatus.c
index 9ff2785d876a..6a243b7bcdfb 100644
--- a/libselinux/src/sestatus.c
+++ b/libselinux/src/sestatus.c
@@ -298,11 +298,10 @@ int selinux_status_open(int fallback)
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
@@ -379,6 +378,7 @@ void selinux_status_close(void)
 		avc_netlink_release_fd();
 		avc_netlink_close();
 		selinux_status = NULL;
+		close(selinux_status_fd);
 		return;
 	}
 
@@ -388,7 +388,5 @@ void selinux_status_close(void)
 		munmap(selinux_status, pagesize);
 	selinux_status = NULL;
 
-	close(selinux_status_fd);
-	selinux_status_fd = -1;
 	last_seqno = (uint32_t)(-1);
 }
-- 
2.30.0

