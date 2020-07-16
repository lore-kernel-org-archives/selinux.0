Return-Path: <SRS0=s7s9=A3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B097C433DF
	for <selinux@archiver.kernel.org>; Thu, 16 Jul 2020 20:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 600F3207FB
	for <selinux@archiver.kernel.org>; Thu, 16 Jul 2020 20:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgGPUjN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jul 2020 16:39:13 -0400
Received: from smtprelay0137.b.hostedemail.com ([64.98.42.137]:39784 "EHLO
        smtprelay.b.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726204AbgGPUjM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jul 2020 16:39:12 -0400
X-Greylist: delayed 590 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Jul 2020 16:39:12 EDT
Received: from smtprelay.b.hostedemail.com (10.5.19.248.rfc1918.com [10.5.19.248])
        by smtpgrave02.b.hostedemail.com (Postfix) with ESMTP id 935AE1804FE28
        for <selinux@vger.kernel.org>; Thu, 16 Jul 2020 20:32:28 +0000 (UTC)
Received: from filter.hostedemail.com (10.5.19.248.rfc1918.com [10.5.19.248])
        by smtprelay02.b.hostedemail.com (Postfix) with ESMTP id EDFF08001923
        for <selinux@vger.kernel.org>; Thu, 16 Jul 2020 20:32:27 +0000 (UTC)
X-Session-Marker: 6D696B6540666C796E2E6F7267
X-HE-Tag: toe00_4a1009526f05
X-Filterd-Recvd-Size: 1889
Received: from imp (pool-173-67-42-132.bltmmd.fios.verizon.net [173.67.42.132])
        (Authenticated sender: mike@flyn.org)
        by omf09.b.hostedemail.com (Postfix) with ESMTPA
        for <selinux@vger.kernel.org>; Thu, 16 Jul 2020 20:32:27 +0000 (UTC)
Message-ID: <8ebd6f4ab80e8b73ce3b4ff4e146c39b2123cec3.camel@flyn.org>
Subject: [PATCH] selinux: make use of variables when defining libdir and 
 includedir
From:   "W. Michael Petullo" <mike@flyn.org>
To:     selinux@vger.kernel.org
Date:   Thu, 16 Jul 2020 15:32:26 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Pkg-config definitions commonly make use of ${exec_prefix} and
${prefix} when defining libdir and includedir, respectively. OpenWrt,
for example, relies on this when it adjusts things for cross
compiling.

Signed-off-by: W. Michael Petullo <mike@flyn.org>
---
 libselinux/src/libselinux.pc.in | 4 ++--
 libsepol/src/libsepol.pc.in     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/libselinux.pc.in
b/libselinux/src/libselinux.pc.in
index 7c66b1fa..d9d58125 100644
--- a/libselinux/src/libselinux.pc.in
+++ b/libselinux/src/libselinux.pc.in
@@ -1,7 +1,7 @@
 prefix=@prefix@
 exec_prefix=${prefix}
-libdir=@libdir@
-includedir=@includedir@
+libdir=${exec_prefix}/lib
+includedir=${prefix}/include

 Name: libselinux
 Description: SELinux utility library
diff --git a/libsepol/src/libsepol.pc.in b/libsepol/src/libsepol.pc.in
index f807fec6..cf2411e4 100644
--- a/libsepol/src/libsepol.pc.in
+++ b/libsepol/src/libsepol.pc.in
@@ -1,7 +1,7 @@
 prefix=@prefix@
 exec_prefix=${prefix}
-libdir=@libdir@
-includedir=@includedir@
+libdir=${exec_prefix}/lib
+includedir=${prefix}/include

 Name: libsepol
 Description: SELinux policy library
-- 
2.26.2


