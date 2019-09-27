Return-Path: <SRS0=oTsg=XW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA83C4360C
	for <selinux@archiver.kernel.org>; Fri, 27 Sep 2019 14:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F6F2146E
	for <selinux@archiver.kernel.org>; Fri, 27 Sep 2019 14:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfI0ONx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Sep 2019 10:13:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbfI0ONx (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 27 Sep 2019 10:13:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9A77C3082A8D
        for <selinux@vger.kernel.org>; Fri, 27 Sep 2019 14:13:52 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20C55600C6
        for <selinux@vger.kernel.org>; Fri, 27 Sep 2019 14:13:51 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] python/semanage: Improve handling of "permissive" statements
Date:   Fri, 27 Sep 2019 16:13:47 +0200
Message-Id: <20190927141347.1422-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 27 Sep 2019 14:13:52 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

- Add "customized" method to permissiveRecords which is than used for
  "semanage permissive --extract" and "semanage export"
- Enable "semanage permissive --deleteall" (already implemented)
- Add "permissive" to the list of modules exported using
  "semanage export"
- Update "semanage permissive" man page

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/semanage/semanage              | 11 ++++++++---
 python/semanage/semanage-permissive.8 |  8 +++++++-
 python/semanage/seobject.py           |  3 +++
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/python/semanage/semanage b/python/semanage/semanage
index f4266cef..864f9212 100644
--- a/python/semanage/semanage
+++ b/python/semanage/semanage
@@ -737,6 +737,11 @@ def handlePermissive(args):
 
     if args.action == "list":
         OBJECT.list(args.noheading)
+    elif args.action == "deleteall":
+        OBJECT.deleteall()
+    elif args.action == "extract":
+        for i in OBJECT.customized():
+            print("permissive %s" % str(i))
     elif args.type is not None:
         if args.action == "add":
             OBJECT.add(args.type)
@@ -752,9 +757,9 @@ def setupPermissiveParser(subparsers):
     pgroup = permissiveParser.add_mutually_exclusive_group(required=True)
     parser_add_add(pgroup, "permissive")
     parser_add_delete(pgroup, "permissive")
+    parser_add_deleteall(pgroup, "permissive")
+    parser_add_extract(pgroup, "permissive")
     parser_add_list(pgroup, "permissive")
-    #TODO: probably should be also added => need to implement own option handling
-    #parser_add_deleteall(pgroup)
 
     parser_add_noheading(permissiveParser, "permissive")
     parser_add_noreload(permissiveParser, "permissive")
@@ -778,7 +783,7 @@ def setupDontauditParser(subparsers):
 
 
 def handleExport(args):
-    manageditems = ["boolean", "login", "interface", "user", "port", "node", "fcontext", "module", "ibendport", "ibpkey"]
+    manageditems = ["boolean", "login", "interface", "user", "port", "node", "fcontext", "module", "ibendport", "ibpkey", "permissive"]
     for i in manageditems:
         print("%s -D" % i)
     for i in manageditems:
diff --git a/python/semanage/semanage-permissive.8 b/python/semanage/semanage-permissive.8
index 1999a451..5c3364fa 100644
--- a/python/semanage/semanage-permissive.8
+++ b/python/semanage/semanage-permissive.8
@@ -2,7 +2,7 @@
 .SH "NAME"
 .B semanage\-permissive \- SELinux Policy Management permissive mapping tool
 .SH "SYNOPSIS"
-.B semanage permissive [\-h] (\-a | \-d | \-l) [\-n] [\-N] [\-S STORE] [type]
+.B semanage permissive [\-h] [\-n] [\-N] [\-S STORE] (\-\-add TYPE | \-\-delete TYPE | \-\-deleteall | \-\-extract | \-\-list)
 
 .SH "DESCRIPTION"
 semanage is used to configure certain elements of SELinux policy without requiring modification to or recompilation from policy sources.  semanage permissive adds or removes a SELinux Policy permissive module.
@@ -18,9 +18,15 @@ Add a record of the specified object type
 .I   \-d, \-\-delete
 Delete a record of the specified object type
 .TP
+.I   \-D, \-\-deleteall
+Remove all local customizations of permissive domains
+.TP
 .I   \-l, \-\-list
 List records of the specified object type
 .TP
+.I   \-E, \-\-extract
+Extract customizable commands, for use within a transaction
+.TP
 .I   \-n, \-\-noheading
 Do not print heading when listing the specified object type
 .TP
diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 8586567b..5e9e3eb5 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -478,6 +478,9 @@ class permissiveRecords(semanageRecords):
                 l.append(name.split("permissive_")[1])
         return l
 
+    def customized(self):
+        return ["-a %s" % x for x in sorted(self.get_all())]
+
     def list(self, heading=1, locallist=0):
         all = [y["name"] for y in [x for x in sepolicy.info(sepolicy.TYPE) if x["permissive"]]]
         if len(all) == 0:
-- 
2.21.0

