Return-Path: <SRS0=labB=U7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CFCC06513
	for <selinux@archiver.kernel.org>; Tue,  2 Jul 2019 12:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EFBF2146F
	for <selinux@archiver.kernel.org>; Tue,  2 Jul 2019 12:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbfGBMJX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Jul 2019 08:09:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbfGBMJX (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 2 Jul 2019 08:09:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A278C1EB21A
        for <selinux@vger.kernel.org>; Tue,  2 Jul 2019 12:09:23 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0EA60BA48
        for <selinux@vger.kernel.org>; Tue,  2 Jul 2019 12:09:22 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/2] Revert "mcstransd select correct colour range."
Date:   Tue,  2 Jul 2019 14:09:04 +0200
Message-Id: <20190702120905.9808-1-vmojzis@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 02 Jul 2019 12:09:23 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This reverts commit fe17b3d2d924018750386c5ee74f12ca4b054136.

MLS ranges should be compared based on dominance.

This fixes mlscolor-test on mcstrans examples.

Eg. mlscolor-test using /usr/share/mcstrans/examples/urcsts when executed on mls
machine fails as follows:

\#pushd /usr/share/mcstrans/examples/urcsts
\#cp -f secolor.conf /etc/selinux/mls/secolor.conf
\#cp -f setrans.conf /etc/selinux/mls/setrans.conf
\#systemctl restart mcstransd
\#python3 /usr/share/mcstrans/util/mlscolor-test urcsts.color
For 'system_u:system_r:inetd_t:SystemLow' got
	'#000000 #000000 #000000 #000000 #000000 #000000 #000000 #000000' expected
	'#000000 #000000 #000000 #000000 #000000 #000000 #000000 #008000'
...
mlscolor-test done with 19 errors

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 mcstrans/src/mcscolor.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mcstrans/src/mcscolor.c b/mcstrans/src/mcscolor.c
index 6ea1aa97..d597e0df 100644
--- a/mcstrans/src/mcscolor.c
+++ b/mcstrans/src/mcscolor.c
@@ -134,12 +134,12 @@ static const secolor_t *find_color(int idx, const char *component,
 	}
 
 	while (ptr) {
-		if (fnmatch(ptr->pattern, component, 0) == 0) {
-			if (idx == COLOR_RANGE) {
-			    if (check_dominance(ptr->pattern, raw) == 0)
-					return &ptr->color;
-			} else 
-				return &ptr->color;
+		if (idx == COLOR_RANGE) {
+		    if (check_dominance(ptr->pattern, raw) == 0)
+			return &ptr->color;
+		} else {
+		    if (fnmatch(ptr->pattern, component, 0) == 0)
+			return &ptr->color;
 		}
 		ptr = ptr->next;
 	}
-- 
2.17.2

