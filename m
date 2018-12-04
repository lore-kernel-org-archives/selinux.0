Return-Path: <SRS0=WX8y=ON=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75A9C04EB8
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 16:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896D8206B6
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 16:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 896D8206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbeLDQj3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:39:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39582 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbeLDQj3 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 4 Dec 2018 11:39:29 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B004888E53
        for <selinux@vger.kernel.org>; Tue,  4 Dec 2018 16:39:28 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-204-239.brq.redhat.com [10.40.204.239])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D75160BE5
        for <selinux@vger.kernel.org>; Tue,  4 Dec 2018 16:39:27 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] python/semanage: Include MCS/MLS range when exporting local customizations
Date:   Tue,  4 Dec 2018 17:39:17 +0100
Message-Id: <20181204163917.12949-1-vmojzis@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 04 Dec 2018 16:39:28 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/semanage/seobject.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index c4c65621..b8c43efe 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -1293,9 +1293,9 @@ class portRecords(semanageRecords):
         ddict = self.get_all(True)
         for k in sorted(ddict.keys()):
             if k[0] == k[1]:
-                l.append("-a -t %s -p %s %s" % (ddict[k][0], k[2], k[0]))
+                l.append("-a -t %s -r '%s' -p %s %s" % (ddict[k][0], ddict[k][1], k[2], k[0]))
             else:
-                l.append("-a -t %s -p %s %s-%s" % (ddict[k][0], k[2], k[0], k[1]))
+                l.append("-a -t %s -r '%s' -p %s %s-%s" % (ddict[k][0], ddict[k][1], k[2], k[0], k[1]))
         return l
 
     def list(self, heading=1, locallist=0):
@@ -1550,9 +1550,9 @@ class ibpkeyRecords(semanageRecords):
 
         for k in sorted(ddict.keys()):
             if k[0] == k[1]:
-                l.append("-a -t %s -x %s %s" % (ddict[k][0], k[2], k[0]))
+                l.append("-a -t %s -r '%s' -x %s %s" % (ddict[k][0], ddict[k][1], k[2], k[0]))
             else:
-                l.append("-a -t %s -x %s %s-%s" % (ddict[k][0], k[2], k[0], k[1]))
+                l.append("-a -t %s -r '%s' -x %s %s-%s" % (ddict[k][0], ddict[k][1], k[2], k[0], k[1]))
         return l
 
     def list(self, heading=1, locallist=0):
@@ -1793,7 +1793,7 @@ class ibendportRecords(semanageRecords):
         ddict = self.get_all(True)
 
         for k in sorted(ddict.keys()):
-            l.append("-a -t %s -r %s -z %s %s" % (ddict[k][0], ddict[k][1], k[1], k[0]))
+            l.append("-a -t %s -r '%s' -z %s %s" % (ddict[k][0], ddict[k][1], k[1], k[0]))
         return l
 
     def list(self, heading=1, locallist=0):
@@ -2033,7 +2033,7 @@ class nodeRecords(semanageRecords):
         l = []
         ddict = self.get_all(True)
         for k in sorted(ddict.keys()):
-            l.append("-a -M %s -p %s -t %s %s" % (k[1], k[2], ddict[k][2], k[0]))
+            l.append("-a -M %s -p %s -t %s -r '%s' %s" % (k[1], k[2], ddict[k][2], ddict[k][3], k[0]))
         return l
 
     def list(self, heading=1, locallist=0):
@@ -2227,7 +2227,7 @@ class interfaceRecords(semanageRecords):
         l = []
         ddict = self.get_all(True)
         for k in sorted(ddict.keys()):
-            l.append("-a -t %s %s" % (ddict[k][2], k))
+            l.append("-a -t %s -r '%s' %s" % (ddict[k][2], ddict[k][3], k))
         return l
 
     def list(self, heading=1, locallist=0):
@@ -2609,7 +2609,7 @@ class fcontextRecords(semanageRecords):
         fcon_dict = self.get_all(True)
         for k in sorted(fcon_dict.keys()):
             if fcon_dict[k]:
-                l.append("-a -f %s -t %s '%s'" % (file_type_str_to_option[k[1]], fcon_dict[k][2], k[0]))
+                l.append("-a -f %s -t %s -r '%s' '%s'" % (file_type_str_to_option[k[1]], fcon_dict[k][2], fcon_dict[k][3], k[0]))
 
         if len(self.equiv):
             for target in self.equiv.keys():
-- 
2.17.2

