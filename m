Return-Path: <SRS0=ShWd=O5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326D9C43387
	for <selinux@archiver.kernel.org>; Thu, 20 Dec 2018 15:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061B621852
	for <selinux@archiver.kernel.org>; Thu, 20 Dec 2018 15:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbeLTPOe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:14:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41212 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbeLTPOe (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 20 Dec 2018 10:14:34 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DCCCD7FDF1
        for <selinux@vger.kernel.org>; Thu, 20 Dec 2018 15:14:33 +0000 (UTC)
Received: from workstation.brq.redhat.com (unknown [10.43.12.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 279E3620AF;
        Thu, 20 Dec 2018 15:14:33 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH 1/4] python/semanage: move valid_types initialisations to class constructors
Date:   Thu, 20 Dec 2018 16:14:17 +0100
Message-Id: <20181220151420.30878-2-plautrba@redhat.com>
In-Reply-To: <20181220151420.30878-1-plautrba@redhat.com>
References: <20181220151420.30878-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 20 Dec 2018 15:14:33 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Based on idea from Nicolas Iooss <nicolas.iooss@m4x.org>

Fixes:
$ sudo semanage
Traceback (most recent call last):
  File "/usr/sbin/semanage", line 28, in <module>
    import seobject
  File "/usr/lib/python3.7/site-packages/seobject.py", line 1045, in <module>
    class portRecords(semanageRecords):
  File "/usr/lib/python3.7/site-packages/seobject.py", line 1047, in portRecords
    valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "port_type"))[0]["types"])
  File "/usr/lib/python3.7/site-packages/sepolicy/__init__.py", line 203, in <genexpr>
    return ({
  File "/usr/lib64/python3.7/site-packages/setools/typeattrquery.py", line 65, in results
    for attr in self.policy.typeattributes():
AttributeError: 'NoneType' object has no attribute 'typeattributes'

https://github.com/SELinuxProject/selinux/issues/81

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/semanage/seobject.py | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index efec0a55..2b43b65c 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -1043,13 +1043,15 @@ class seluserRecords(semanageRecords):
 
 
 class portRecords(semanageRecords):
-    try:
-        valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "port_type"))[0]["types"])
-    except RuntimeError:
-        valid_types = []
+
+    valid_types = []
 
     def __init__(self, args = None):
         semanageRecords.__init__(self, args)
+        try:
+            self.valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "port_type"))[0]["types"])
+        except RuntimeError:
+            pass
 
     def __genkey(self, port, proto):
         if proto == "tcp":
@@ -1823,14 +1825,16 @@ class ibendportRecords(semanageRecords):
             print(rec)
 
 class nodeRecords(semanageRecords):
-    try:
-        valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "node_type"))[0]["types"])
-    except RuntimeError:
-        valid_types = []
+
+    valid_types = []
 
     def __init__(self, args = None):
         semanageRecords.__init__(self, args)
         self.protocol = ["ipv4", "ipv6"]
+        try:
+            self.valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "node_type"))[0]["types"])
+        except RuntimeError:
+            pass
 
     def validate(self, addr, mask, protocol):
         newaddr = addr
@@ -2264,14 +2268,17 @@ class interfaceRecords(semanageRecords):
 
 
 class fcontextRecords(semanageRecords):
-    try:
-        valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "file_type"))[0]["types"])
-        valid_types += list(list(sepolicy.info(sepolicy.ATTRIBUTE, "device_node"))[0]["types"])
-    except RuntimeError:
-        valid_types = []
+
+    valid_types = []
 
     def __init__(self, args = None):
         semanageRecords.__init__(self, args)
+        try:
+            self.valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "file_type"))[0]["types"])
+            self.valid_types += list(list(sepolicy.info(sepolicy.ATTRIBUTE, "device_node"))[0]["types"])
+        except RuntimeError:
+            pass
+
         self.equiv = {}
         self.equiv_dist = {}
         self.equal_ind = False
-- 
2.20.1

