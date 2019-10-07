Return-Path: <SRS0=LR26=YA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E53EECE58C
	for <selinux@archiver.kernel.org>; Mon,  7 Oct 2019 13:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A8042084D
	for <selinux@archiver.kernel.org>; Mon,  7 Oct 2019 13:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfJGNUX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:20:23 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:33236 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfJGNUX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Oct 2019 09:20:23 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 8BF0D72CC6C;
        Mon,  7 Oct 2019 16:20:20 +0300 (MSK)
Received: by imap.altlinux.org (Postfix, from userid 705)
        id 7F24E4A4AE9; Mon,  7 Oct 2019 16:20:20 +0300 (MSK)
Date:   Mon, 7 Oct 2019 16:20:20 +0300
From:   Michael Shigorin <mike@altlinux.org>
To:     selinux@vger.kernel.org
Cc:     Daniel J Walsh <dwalsh@redhat.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: [PATCH] non-gcc-specific exception.sh
Message-ID: <20191007132020.GG4928@imap.altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

	Hello,
please find attached the patch to (hopefully) improve
self-surgery script that uses gcc-specific -aux-info now.
Should help clang, icc and the like (in my case there's
no proper gcc port for the target platform just yet).

-- 
š---- WBR, Michael Shigorin / http://altlinux.org
šš------ http://opennet.ru / http://anna-news.info

--VrqPEDrXMn8OVzN4
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-exception.sh-fixed-to-work-with-non-gcc.patch"

From ccfa41adf46367e132ba7556fad53dfce9ddffaf Mon Sep 17 00:00:00 2001
From: Michael Shigorin <mike@altlinux.org>
Date: Mon, 7 Oct 2019 16:00:39 +0300
Subject: [PATCH] exception.sh: fixed to work with non-gcc

-aux-info is a gccism absent in clang, icc and the like;
let's reimplement this in a slightly cleaner way with -E.

Suggested-by: Evgeny Mareev
---
 libselinux/src/exception.sh  | 12 +++++-------
 libsemanage/src/exception.sh | 12 +++++-------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/libselinux/src/exception.sh b/libselinux/src/exception.sh
index d6c8c71..459295c 100755
--- a/libselinux/src/exception.sh
+++ b/libselinux/src/exception.sh
@@ -15,10 +15,8 @@ echo "
 ;;
 esac
 }
-if ! ${CC:-gcc} -x c -c -I../include - -aux-info temp.aux < ../include/selinux/selinux.h
-then
-    # clang does not support -aux-info so fall back to gcc
-    gcc -x c -c -I../include - -aux-info temp.aux < ../include/selinux/selinux.h
-fi
-for i in `awk '/<stdin>.*extern int/ { print $6 }' temp.aux`; do except $i ; done 
-rm -f -- temp.aux -.o
+
+# equivalent of gcc-specific -aux-info
+${CC:-gcc} -E -I../include -xc ../include/selinux/selinux.h |
+	sed -n 's/^extern * int *\(\w*\) *(.*$/\1/p' |
+	while read f; do except $f; done
diff --git a/libsemanage/src/exception.sh b/libsemanage/src/exception.sh
index 97bc2ae..11586a1 100644
--- a/libsemanage/src/exception.sh
+++ b/libsemanage/src/exception.sh
@@ -9,10 +9,8 @@ echo "
 }
 "
 }
-if ! ${CC:-gcc} -x c -c -I../include - -aux-info temp.aux < ../include/semanage/semanage.h
-then
-    # clang does not support -aux-info so fall back to gcc
-    gcc -x c -c -I../include - -aux-info temp.aux < ../include/semanage/semanage.h
-fi
-for i in `awk '/extern int/ { print $6 }' temp.aux`; do except $i ; done
-rm -f -- temp.aux -.o
+
+# equivalent of gcc-specific -aux-info
+${CC:-gcc} -E -I../include -xc ../include/semanage/semanage.h |
+	sed -n 's/^extern * int *\(\w*\) *(.*$/\1/p' |
+	while read f; do except $f; done
-- 
2.10.4


--VrqPEDrXMn8OVzN4--
