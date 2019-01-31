Return-Path: <SRS0=JPc9=QH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B66C169C4
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 19:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106E9218AF
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 19:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfAaTse (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:48:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38392 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbfAaTse (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 31 Jan 2019 14:48:34 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9017D796E2
        for <selinux@vger.kernel.org>; Thu, 31 Jan 2019 19:48:34 +0000 (UTC)
Received: from workstation.redhat.com (unknown [10.40.205.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE3E15D787;
        Thu, 31 Jan 2019 19:48:33 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH 1/2] libselinux: set an appropriate errno in booleans.c
Date:   Thu, 31 Jan 2019 20:48:23 +0100
Message-Id: <20190131194824.4944-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 31 Jan 2019 19:48:34 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fixes:
$ mkdir booleans
$ sudo mount --bind ./booleans /sys/fs/selinux/booleans
$ sudo getsebool -a
getsebool:  Unable to get boolean names:  Success

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libselinux/src/booleans.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
index b3ea3623..a6d46fea 100644
--- a/libselinux/src/booleans.c
+++ b/libselinux/src/booleans.c
@@ -55,6 +55,7 @@ int security_get_boolean_names(char ***names, int *len)
 	snprintf(path, sizeof path, "%s%s", selinux_mnt, SELINUX_BOOL_DIR);
 	*len = scandir(path, &namelist, &filename_select, alphasort);
 	if (*len <= 0) {
+		errno = ENOENT;
 		return -1;
 	}
 
-- 
2.20.1

