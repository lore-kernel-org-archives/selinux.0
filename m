Return-Path: <SRS0=61sA=XS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454E5C04EBF
	for <selinux@archiver.kernel.org>; Mon, 23 Sep 2019 14:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2676E20673
	for <selinux@archiver.kernel.org>; Mon, 23 Sep 2019 14:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437957AbfIWOno (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 23 Sep 2019 10:43:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437469AbfIWOno (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 23 Sep 2019 10:43:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AAA313091785
        for <selinux@vger.kernel.org>; Mon, 23 Sep 2019 14:43:44 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 308DD10013D9
        for <selinux@vger.kernel.org>; Mon, 23 Sep 2019 14:43:44 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] policycoreutils/fixfiles: Fix "verify" option
Date:   Mon, 23 Sep 2019 16:43:40 +0200
Message-Id: <20190923144340.3197-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 23 Sep 2019 14:43:44 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

"restorecon -n" (used in the "restore" function) has to be used with
"-v" to display the files whose labels would be changed.

Fixes:
   Fixfiles verify does not report misslabelled files unless "-v" option is
   used.
---
 policycoreutils/scripts/fixfiles | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index 5be9ba6e..1a31e061 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -302,7 +302,7 @@ process() {
 case "$1" in
     restore) restore Relabel;;
     check) VERBOSE="-v"; restore Check -n;;
-    verify) restore Verify -n;;
+    verify) VERBOSE="-v"; restore Verify -n;;
     relabel) relabel;;
     onboot)
 	if [ "$RESTORE_MODE" != DEFAULT ]; then
-- 
2.21.0

