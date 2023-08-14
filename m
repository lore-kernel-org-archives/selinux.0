Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF025C001B0
	for <selinux@archiver.kernel.org>; Mon, 14 Aug 2023 15:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbjHNPRd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Aug 2023 11:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjHNPRV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Aug 2023 11:17:21 -0400
X-Greylist: delayed 583 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Aug 2023 08:17:01 PDT
Received: from smtpm3.myservices.hosting (smtpm3.myservices.hosting [185.26.105.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367B6171F
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 08:17:00 -0700 (PDT)
Received: from mail1.netim.hosting (unknown [185.26.106.173])
        by smtpm3.myservices.hosting (Postfix) with ESMTP id 32B9E20F08
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 17:07:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail1.netim.hosting (Postfix) with ESMTP id 8E41180099;
        Mon, 14 Aug 2023 17:07:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail1.netim.hosting
Received: from mail1.netim.hosting ([127.0.0.1])
        by localhost (mail1-2.netim.hosting [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0VU4fZ630GMs; Mon, 14 Aug 2023 17:07:15 +0200 (CEST)
Received: from guix-nuc.home.arpa (unknown [10.192.1.83])
        (Authenticated sender: lumen@makinata.eu)
        by mail1.netim.hosting (Postfix) with ESMTPSA id 051E580098;
        Mon, 14 Aug 2023 17:07:14 +0200 (CEST)
From:   Bruno Victal <mirai@makinata.eu>
To:     selinux@vger.kernel.org
Cc:     Bruno Victal <mirai@makinata.eu>
Subject: [PATCH] secilc: Use versioned DocBook public identifier.
Date:   Mon, 14 Aug 2023 16:07:07 +0100
Message-Id: <260cd39c55ff2d13f5ac916b508f023bedecfce9.1692025627.git.mirai@makinata.eu>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fix xml validation issues that often crop up since the XML catalogs
for DocBook often only contain versioned public identifiers.

Signed-off-by: Bruno Victal <mirai@makinata.eu>
---
 secilc/secil2conf.8.xml | 2 +-
 secilc/secil2tree.8.xml | 2 +-
 secilc/secilc.8.xml     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/secilc/secil2conf.8.xml b/secilc/secil2conf.8.xml
index 33646f97..330b6a07 100644
--- a/secilc/secil2conf.8.xml
+++ b/secilc/secil2conf.8.xml
@@ -1,5 +1,5 @@
 <?xml version="1.0" encoding="UTF-8"?>
-<!DOCTYPE refentry PUBLIC "-//OASIS//DTD DocBook XML//EN"
+<!DOCTYPE refentry PUBLIC "-//OASIS//DTD DocBook XML V4.2//EN"
                "http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd">
 
 <refentry>
diff --git a/secilc/secil2tree.8.xml b/secilc/secil2tree.8.xml
index e95a8947..d7bb177e 100644
--- a/secilc/secil2tree.8.xml
+++ b/secilc/secil2tree.8.xml
@@ -1,5 +1,5 @@
 <?xml version="1.0" encoding="UTF-8"?>
-<!DOCTYPE refentry PUBLIC "-//OASIS//DTD DocBook XML//EN"
+<!DOCTYPE refentry PUBLIC "-//OASIS//DTD DocBook XML V4.2//EN"
                "http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd">
 
 <refentry>
diff --git a/secilc/secilc.8.xml b/secilc/secilc.8.xml
index e9a121e2..5c0680a8 100644
--- a/secilc/secilc.8.xml
+++ b/secilc/secilc.8.xml
@@ -1,5 +1,5 @@
 <?xml version="1.0" encoding="UTF-8"?>
-<!DOCTYPE refentry PUBLIC "-//OASIS//DTD DocBook XML//EN"
+<!DOCTYPE refentry PUBLIC "-//OASIS//DTD DocBook XML V4.2//EN"
                "http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd">
 
 <refentry>

base-commit: f6dc6acfa00707ce25c6357169111937f12512dd
-- 
2.40.1

