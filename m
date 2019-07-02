Return-Path: <SRS0=labB=U7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5CAC06510
	for <selinux@archiver.kernel.org>; Tue,  2 Jul 2019 12:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299952146F
	for <selinux@archiver.kernel.org>; Tue,  2 Jul 2019 12:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfGBMJ3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Jul 2019 08:09:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbfGBMJ3 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 2 Jul 2019 08:09:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8F7943082E53
        for <selinux@vger.kernel.org>; Tue,  2 Jul 2019 12:09:29 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15F9C60C44
        for <selinux@vger.kernel.org>; Tue,  2 Jul 2019 12:09:28 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/2] Fix mcstrans secolor examples
Date:   Tue,  2 Jul 2019 14:09:05 +0200
Message-Id: <20190702120905.9808-2-vmojzis@redhat.com>
In-Reply-To: <20190702120905.9808-1-vmojzis@redhat.com>
References: <20190702120905.9808-1-vmojzis@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 02 Jul 2019 12:09:29 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

According to "check_dominance" function:
Range defined as "s15:c0.c1023" does not dominate any other range than
 "s15:c0.c1023" (does not dominate "s15", "s15:c0.c200", etc.).
While range defined as "s15-s15:c0.c1023" dominates all of the above.

This is either a bug, or "s15:c0.c1023" should not be used in the
examples.

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 libselinux/man/man5/secolor.conf.5                      | 4 ++--
 libselinux/man/ru/man5/secolor.conf.5                   | 4 ++--
 mcstrans/share/examples/urcsts-via-include/secolor.conf | 2 +-
 mcstrans/share/examples/urcsts/secolor.conf             | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/libselinux/man/man5/secolor.conf.5 b/libselinux/man/man5/secolor.conf.5
index b834577a..a3bf2da1 100644
--- a/libselinux/man/man5/secolor.conf.5
+++ b/libselinux/man/man5/secolor.conf.5
@@ -123,7 +123,7 @@ range s7\-s7:c0.c1023 = black red
 .br
 range s9\-s9:c0.c1023 = black orange
 .br
-range s15:c0.c1023   = black yellow
+range s15\-s15:c0.c1023   = black yellow
 .RE
 
 .sp
@@ -165,7 +165,7 @@ type xguest_t     = black green
 .br
 user sysadm_u     = white black
 .br
-range s0:c0.c1023 = black white
+range s0-s0:c0.c1023 = black white
 .br
 user *            = black white
 .br
diff --git a/libselinux/man/ru/man5/secolor.conf.5 b/libselinux/man/ru/man5/secolor.conf.5
index 4c1236ae..bcae80c1 100644
--- a/libselinux/man/ru/man5/secolor.conf.5
+++ b/libselinux/man/ru/man5/secolor.conf.5
@@ -121,7 +121,7 @@ range s7\-s7:c0.c1023 = black red
 .br
 range s9\-s9:c0.c1023 = black orange
 .br
-range s15:c0.c1023   = black yellow
+range s15\-s15:c0.c1023   = black yellow
 .RE
 
 .sp
@@ -163,7 +163,7 @@ type xguest_t     = black green
 .br
 user sysadm_u     = white black
 .br
-range s0:c0.c1023 = black white
+range s0\-s0:c0.c1023 = black white
 .br
 user *            = black white
 .br
diff --git a/mcstrans/share/examples/urcsts-via-include/secolor.conf b/mcstrans/share/examples/urcsts-via-include/secolor.conf
index d35b3c67..3b3f5430 100644
--- a/mcstrans/share/examples/urcsts-via-include/secolor.conf
+++ b/mcstrans/share/examples/urcsts-via-include/secolor.conf
@@ -17,5 +17,5 @@ range s3-s3:c0.c1023 = black tan
 range s5-s5:c0.c1023 = white blue
 range s7-s7:c0.c1023 = black red
 range s9-s9:c0.c1023 = black orange
-range s15:c0.c1023 = black yellow
+range s15-s15:c0.c1023 = black yellow
 
diff --git a/mcstrans/share/examples/urcsts/secolor.conf b/mcstrans/share/examples/urcsts/secolor.conf
index d35b3c67..3b3f5430 100644
--- a/mcstrans/share/examples/urcsts/secolor.conf
+++ b/mcstrans/share/examples/urcsts/secolor.conf
@@ -17,5 +17,5 @@ range s3-s3:c0.c1023 = black tan
 range s5-s5:c0.c1023 = white blue
 range s7-s7:c0.c1023 = black red
 range s9-s9:c0.c1023 = black orange
-range s15:c0.c1023 = black yellow
+range s15-s15:c0.c1023 = black yellow
 
-- 
2.17.2

