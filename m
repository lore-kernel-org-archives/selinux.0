Return-Path: <SRS0=r/KF=OS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E746C07E85
	for <selinux@archiver.kernel.org>; Sun,  9 Dec 2018 15:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E5020865
	for <selinux@archiver.kernel.org>; Sun,  9 Dec 2018 15:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E5020865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m4x.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbeLIPhd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 9 Dec 2018 10:37:33 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:49921 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbeLIPhd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 9 Dec 2018 10:37:33 -0500
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr [89.156.252.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id D8B8A564786
        for <selinux@vger.kernel.org>; Sun,  9 Dec 2018 16:37:30 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/1] python/semanage: do not show "None" levels when using a non-MLS policy
Date:   Sun,  9 Dec 2018 16:37:02 +0100
Message-Id: <20181209153702.24905-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Dec  9 16:37:31 2018 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When MLS is disabled, "semanage export" shows records such as:

    login -a -s sysadm_u -r 'None' me

Prevent "semanage export" from displaying None or empty strings in level
and categories arguments by checking them in all customized() methods.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/semanage/seobject.py | 44 +++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index b8c43efe0101..efec0a553f43 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -747,7 +747,10 @@ class loginRecords(semanageRecords):
         l = []
         ddict = self.get_all(True)
         for k in sorted(ddict.keys()):
-            l.append("-a -s %s -r '%s' %s" % (ddict[k][0], ddict[k][1], k))
+            if ddict[k][1]:
+                l.append("-a -s %s -r '%s' %s" % (ddict[k][0], ddict[k][1], k))
+            else:
+                l.append("-a -s %s %s" % (ddict[k][0], k))
         return l
 
     def list(self, heading=1, locallist=0):
@@ -1014,7 +1017,10 @@ class seluserRecords(semanageRecords):
         l = []
         ddict = self.get_all(True)
         for k in sorted(ddict.keys()):
-            l.append("-a -L %s -r %s -R '%s' %s" % (ddict[k][1], ddict[k][2], ddict[k][3], k))
+            if ddict[k][1] or ddict[k][2]:
+                l.append("-a -L %s -r %s -R '%s' %s" % (ddict[k][1], ddict[k][2], ddict[k][3], k))
+            else:
+                l.append("-a -R '%s' %s" % (ddict[k][3], k))
         return l
 
     def list(self, heading=1, locallist=0):
@@ -1292,10 +1298,11 @@ class portRecords(semanageRecords):
         l = []
         ddict = self.get_all(True)
         for k in sorted(ddict.keys()):
-            if k[0] == k[1]:
-                l.append("-a -t %s -r '%s' -p %s %s" % (ddict[k][0], ddict[k][1], k[2], k[0]))
+            port = k[0] if k[0] == k[1] else "%s-%s" % (k[0], k[1])
+            if ddict[k][1]:
+                l.append("-a -t %s -r '%s' -p %s %s" % (ddict[k][0], ddict[k][1], k[2], port))
             else:
-                l.append("-a -t %s -r '%s' -p %s %s-%s" % (ddict[k][0], ddict[k][1], k[2], k[0], k[1]))
+                l.append("-a -t %s -p %s %s" % (ddict[k][0], k[2], port))
         return l
 
     def list(self, heading=1, locallist=0):
@@ -1549,10 +1556,11 @@ class ibpkeyRecords(semanageRecords):
         ddict = self.get_all(True)
 
         for k in sorted(ddict.keys()):
-            if k[0] == k[1]:
-                l.append("-a -t %s -r '%s' -x %s %s" % (ddict[k][0], ddict[k][1], k[2], k[0]))
+            port = k[0] if k[0] == k[1] else "%s-%s" % (k[0], k[1])
+            if ddict[k][1]:
+                l.append("-a -t %s -r '%s' -x %s %s" % (ddict[k][0], ddict[k][1], k[2], port))
             else:
-                l.append("-a -t %s -r '%s' -x %s %s-%s" % (ddict[k][0], ddict[k][1], k[2], k[0], k[1]))
+                l.append("-a -t %s -x %s %s" % (ddict[k][0], k[2], port))
         return l
 
     def list(self, heading=1, locallist=0):
@@ -1793,7 +1801,10 @@ class ibendportRecords(semanageRecords):
         ddict = self.get_all(True)
 
         for k in sorted(ddict.keys()):
-            l.append("-a -t %s -r '%s' -z %s %s" % (ddict[k][0], ddict[k][1], k[1], k[0]))
+            if ddict[k][1]:
+                l.append("-a -t %s -r '%s' -z %s %s" % (ddict[k][0], ddict[k][1], k[1], k[0]))
+            else:
+                l.append("-a -t %s -z %s %s" % (ddict[k][0], k[1], k[0]))
         return l
 
     def list(self, heading=1, locallist=0):
@@ -2033,7 +2044,10 @@ class nodeRecords(semanageRecords):
         l = []
         ddict = self.get_all(True)
         for k in sorted(ddict.keys()):
-            l.append("-a -M %s -p %s -t %s -r '%s' %s" % (k[1], k[2], ddict[k][2], ddict[k][3], k[0]))
+            if ddict[k][3]:
+                l.append("-a -M %s -p %s -t %s -r '%s' %s" % (k[1], k[2], ddict[k][2], ddict[k][3], k[0]))
+            else:
+                l.append("-a -M %s -p %s -t %s %s" % (k[1], k[2], ddict[k][2], k[0]))
         return l
 
     def list(self, heading=1, locallist=0):
@@ -2227,7 +2241,10 @@ class interfaceRecords(semanageRecords):
         l = []
         ddict = self.get_all(True)
         for k in sorted(ddict.keys()):
-            l.append("-a -t %s -r '%s' %s" % (ddict[k][2], ddict[k][3], k))
+            if ddict[k][3]:
+                l.append("-a -t %s -r '%s' %s" % (ddict[k][2], ddict[k][3], k))
+            else:
+                l.append("-a -t %s %s" % (ddict[k][2], k))
         return l
 
     def list(self, heading=1, locallist=0):
@@ -2609,7 +2626,10 @@ class fcontextRecords(semanageRecords):
         fcon_dict = self.get_all(True)
         for k in sorted(fcon_dict.keys()):
             if fcon_dict[k]:
-                l.append("-a -f %s -t %s -r '%s' '%s'" % (file_type_str_to_option[k[1]], fcon_dict[k][2], fcon_dict[k][3], k[0]))
+                if fcon_dict[k][3]:
+                    l.append("-a -f %s -t %s -r '%s' '%s'" % (file_type_str_to_option[k[1]], fcon_dict[k][2], fcon_dict[k][3], k[0]))
+                else:
+                    l.append("-a -f %s -t %s '%s'" % (file_type_str_to_option[k[1]], fcon_dict[k][2], k[0]))
 
         if len(self.equiv):
             for target in self.equiv.keys():
-- 
2.19.1

