Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ADDC433F5
	for <selinux@archiver.kernel.org>; Mon,  4 Oct 2021 12:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 603E46139F
	for <selinux@archiver.kernel.org>; Mon,  4 Oct 2021 12:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbhJDNAx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Oct 2021 09:00:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55570 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234399AbhJDM7P (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Oct 2021 08:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633352245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xM9IkzBTbC7A2wqc3sDqBecyXU4iQd8ooDdE42V5hAI=;
        b=P3gYCXdG+TRUcD8K8sDAaROs6mxsuFwJ3h+Nk3fRYUyAegSpf7OGwxcQM9yRgPo+mgKews
        yOCYNQRGII/EchuLaBaO/Djr+4mWsL0W8ulaac8QixN6QscVY13wnGhPcT/xORFIhA4cUp
        jVBXG6bHz10xA++2/RQyfn6ZSromQFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-5I-VK_PdNnedv7om8cShOA-1; Mon, 04 Oct 2021 08:57:24 -0400
X-MC-Unique: 5I-VK_PdNnedv7om8cShOA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 090C21808324
        for <selinux@vger.kernel.org>; Mon,  4 Oct 2021 12:57:24 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.40.193.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A52560BF4;
        Mon,  4 Oct 2021 12:57:23 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] libselinux/semodule: Improve extracting message
Date:   Mon,  4 Oct 2021 14:57:19 +0200
Message-Id: <20211004125719.1155053-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The code doesn't check the default priority, it just looks for the
highest.

Fixes:

    # semodule -E testmodule
    Module 'testmodule' does not exist at the default priority '400'. Extracting at highest existing priority '400'.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 policycoreutils/semodule/semodule.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index bf9eec02a050..66ea06624eda 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -672,8 +672,7 @@ int main(int argc, char *argv[])
 					}
 
 					semanage_module_info_get_priority(sh, extract_info, &curr_priority);
-					printf("Module '%s' does not exist at the default priority '%d'. "
-							"Extracting at highest existing priority '%d'.\n", mode_arg, priority, curr_priority);
+					printf("Extracting at highest existing priority '%d'.\n", curr_priority);
 					priority = curr_priority;
 				}
 
-- 
2.32.0

