Return-Path: <SRS0=WX8y=ON=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DC7C04EB8
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 10:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00C8214C1
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 10:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00C8214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbeLDKfr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:35:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbeLDKfq (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 4 Dec 2018 05:35:46 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6C0733003076
        for <selinux@vger.kernel.org>; Tue,  4 Dec 2018 10:35:46 +0000 (UTC)
Received: from workstation.redhat.com (ovpn-204-216.brq.redhat.com [10.40.204.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9C5160CCF;
        Tue,  4 Dec 2018 10:35:45 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Vit Mojzis <vmojzis@redhat.com>
Subject: [PATCH] python/chcat: use check_call instead of getstatusoutput
Date:   Tue,  4 Dec 2018 11:35:40 +0100
Message-Id: <20181204103540.6041-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 04 Dec 2018 10:35:46 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Vit Mojzis <vmojzis@redhat.com>

Use "check_call" instead of "getstatusoutput" in order for special
characters and spaces in filenames to be handled correctly.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1013774

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/chcat/chcat | 78 ++++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 40 deletions(-)

diff --git a/python/chcat/chcat b/python/chcat/chcat
index edfe5713..a2cc9fa0 100755
--- a/python/chcat/chcat
+++ b/python/chcat/chcat
@@ -22,10 +22,7 @@
 #                                        02111-1307  USA
 #
 #
-try:
-    from subprocess import getstatusoutput
-except ImportError:
-    from commands import getstatusoutput
+import subprocess
 import sys
 import os
 import pwd
@@ -99,12 +96,12 @@ def chcat_user_add(newcat, users):
             new_serange = "%s-%s" % (serange[0], top[0])
 
         if add_ind:
-            cmd = "semanage login -a -r %s -s %s %s" % (new_serange, user[0], u)
+            cmd = ["semanage", "login", "-a", "-r", new_serange, "-s", user[0], u]
         else:
-            cmd = "semanage login -m -r %s -s %s %s" % (new_serange, user[0], u)
-        rc = getstatusoutput(cmd)
-        if rc[0] != 0:
-            print(rc[1])
+            cmd = ["semanage", "login", "-m", "-r", new_serange, "-s", user[0], u]
+        try:
+            subprocess.check_call(cmd, stderr=subprocess.STDOUT, shell=False)
+        except subprocess.CalledProcessError as e:
             errors += 1
 
     return errors
@@ -140,10 +137,11 @@ def chcat_add(orig, newcat, objects, login_ind):
                 cat_string = "%s,%s" % (cat_string, c)
         else:
             cat_string = cat
-        cmd = 'chcon -l %s:%s %s' % (sensitivity, cat_string, f)
-        rc = getstatusoutput(cmd)
-        if rc[0] != 0:
-            print(rc[1])
+
+        cmd = ["chcon", "-l", "%s:%s" % (sensitivity, cat_string), f]
+        try:
+            subprocess.check_call(cmd, stderr=subprocess.STDOUT, shell=False)
+        except subprocess.CalledProcessError as e:
             errors += 1
     return errors
 
@@ -179,13 +177,15 @@ def chcat_user_remove(newcat, users):
             new_serange = "%s-%s" % (serange[0], top[0])
 
         if add_ind:
-            cmd = "semanage login -a -r %s -s %s %s" % (new_serange, user[0], u)
+            cmd = ["semanage", "login", "-a", "-r", new_serange, "-s", user[0], u]
         else:
-            cmd = "semanage login -m -r %s -s %s %s" % (new_serange, user[0], u)
-        rc = getstatusoutput(cmd)
-        if rc[0] != 0:
-            print(rc[1])
+            cmd = ["semanage", "login", "-m", "-r", new_serange, "-s", user[0], u]
+
+        try:
+            subprocess.check_call(cmd, stderr=subprocess.STDOUT, shell=False)
+        except subprocess.CalledProcessError as e:
             errors += 1
+
     return errors
 
 
@@ -224,12 +224,14 @@ def chcat_remove(orig, newcat, objects, login_ind):
             continue
 
         if len(cat) == 0:
-            cmd = 'chcon -l %s %s' % (sensitivity, f)
+            new_serange = sensitivity
         else:
-            cmd = 'chcon -l %s:%s %s' % (sensitivity, cat, f)
-        rc = getstatusoutput(cmd)
-        if rc[0] != 0:
-            print(rc[1])
+            new_serange = '%s:%s' % (sensitivity, cat)
+
+        cmd = ["chcon", "-l", new_serange, f]
+        try:
+            subprocess.check_call(cmd, stderr=subprocess.STDOUT, shell=False)
+        except subprocess.CalledProcessError as e:
             errors += 1
     return errors
 
@@ -247,17 +249,17 @@ def chcat_user_replace(newcat, users):
             add_ind = 1
             user = seusers["__default__"]
         serange = user[1].split("-")
-        new_serange = "%s-%s:%s" % (serange[0], newcat[0], string.join(newcat[1:], ","))
+        new_serange = "%s-%s:%s" % (serange[0], newcat[0], ",".join(newcat[1:]))
         if new_serange[-1:] == ":":
             new_serange = new_serange[:-1]
 
         if add_ind:
-            cmd = "semanage login -a -r %s -s %s %s" % (new_serange, user[0], u)
+            cmd = ["semanage", "login", "-a", "-r", new_serange, "-s", user[0], u]
         else:
-            cmd = "semanage login -m -r %s -s %s %s" % (new_serange, user[0], u)
-        rc = getstatusoutput(cmd)
-        if rc[0] != 0:
-            print(rc[1])
+            cmd = ["semanage", "login", "-m", "-r", new_serange, "-s", user[0], u]
+        try:
+            subprocess.check_call(cmd, stderr=subprocess.STDOUT, shell=False)
+        except subprocess.CalledProcessError as e:
             errors += 1
     return errors
 
@@ -267,20 +269,16 @@ def chcat_replace(newcat, objects, login_ind):
         return chcat_user_replace(newcat, objects)
     errors = 0
     if len(newcat) == 1:
-        sensitivity = newcat[0]
-        cmd = 'chcon -l %s ' % newcat[0]
+        new_serange = newcat[0]
     else:
-        sensitivity = newcat[0]
-        cmd = 'chcon -l %s:%s' % (sensitivity, newcat[1])
+        new_serange = "%s:%s" % (newcat[0], newcat[1])
         for cat in newcat[2:]:
-            cmd = '%s,%s' % (cmd, cat)
+            new_serange = '%s,%s' % (new_serange, cat)
 
-    for f in objects:
-        cmd = "%s %s" % (cmd, f)
-
-    rc = getstatusoutput(cmd)
-    if rc[0] != 0:
-        print(rc[1])
+    cmd = ["chcon", "-l", new_serange] + objects
+    try:
+        subprocess.check_call(cmd, stderr=subprocess.STDOUT, shell=False)
+    except subprocess.CalledProcessError as e:
         errors += 1
 
     return errors
-- 
2.19.2

