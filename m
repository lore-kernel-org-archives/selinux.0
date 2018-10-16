Return-Path: <SRS0=LxTM=M4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318BDC070C3
	for <selinux@archiver.kernel.org>; Tue, 16 Oct 2018 10:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F8520881
	for <selinux@archiver.kernel.org>; Tue, 16 Oct 2018 10:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F8520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbeJPRzc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:55:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57394 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbeJPRzb (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 16 Oct 2018 13:55:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1CF0430820DC
        for <selinux@vger.kernel.org>; Tue, 16 Oct 2018 10:05:51 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-204-163.brq.redhat.com [10.40.204.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7963C7A7A4
        for <selinux@vger.kernel.org>; Tue, 16 Oct 2018 10:05:50 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/3] python/sepolicy: Stop rejecting aliases in sepolicy commands
Date:   Tue, 16 Oct 2018 12:05:32 +0200
Message-Id: <20181016100533.12249-3-vmojzis@redhat.com>
In-Reply-To: <20181016100533.12249-1-vmojzis@redhat.com>
References: <20181016100533.12249-1-vmojzis@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 16 Oct 2018 10:05:51 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fix CheckDomain and CheckPortType classes to properly deal with aliases.

Resolves:
   https://bugzilla.redhat.com/show_bug.cgi?id=1600009

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/sepolicy/sepolicy.py          |  8 +++-----
 python/sepolicy/sepolicy/__init__.py | 10 +++++++++-
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/python/sepolicy/sepolicy.py b/python/sepolicy/sepolicy.py
index a000c1ad..01380fbe 100755
--- a/python/sepolicy/sepolicy.py
+++ b/python/sepolicy/sepolicy.py
@@ -60,8 +60,6 @@ class CheckPath(argparse.Action):
 class CheckType(argparse.Action):
 
     def __call__(self, parser, namespace, values, option_string=None):
-        domains = sepolicy.get_all_domains()
-
         if isinstance(values, str):
             setattr(namespace, self.dest, values)
         else:
@@ -103,7 +101,7 @@ class CheckDomain(argparse.Action):
         domains = sepolicy.get_all_domains()
 
         if isinstance(values, str):
-            if values not in domains:
+            if sepolicy.get_real_type_name(values) not in domains:
                 raise ValueError("%s must be an SELinux process domain:\nValid domains: %s" % (values, ", ".join(domains)))
             setattr(namespace, self.dest, values)
         else:
@@ -112,7 +110,7 @@ class CheckDomain(argparse.Action):
                 newval = []
 
             for v in values:
-                if v not in domains:
+                if sepolicy.get_real_type_name(v) not in domains:
                     raise ValueError("%s must be an SELinux process domain:\nValid domains: %s" % (v, ", ".join(domains)))
                 newval.append(v)
             setattr(namespace, self.dest, newval)
@@ -167,7 +165,7 @@ class CheckPortType(argparse.Action):
         if not newval:
             newval = []
         for v in values:
-            if v not in port_types:
+            if sepolicy.get_real_type_name(v) not in port_types:
                 raise ValueError("%s must be an SELinux port type:\nValid port types: %s" % (v, ", ".join(port_types)))
             newval.append(v)
         setattr(namespace, self.dest, values)
diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index 8484b28c..0da3917b 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -447,6 +447,14 @@ def get_file_types(setype):
     return mpaths
 
 
+# determine if entered type is an alias
+# and return corresponding type name
+def get_real_type_name(name):
+    try:
+        return next(info(TYPE, name))["name"]
+    except (RuntimeError, StopIteration):
+        return None
+
 def get_writable_files(setype):
     file_types = get_all_file_types()
     all_writes = []
@@ -1061,7 +1069,7 @@ def gen_short_name(setype):
         domainname = setype[:-2]
     else:
         domainname = setype
-    if domainname + "_t" not in all_domains:
+    if get_real_type_name(domainname + "_t") not in all_domains:
         raise ValueError("domain %s_t does not exist" % domainname)
     if domainname[-1] == 'd':
         short_name = domainname[:-1] + "_"
-- 
2.17.1

