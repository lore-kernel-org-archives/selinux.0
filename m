Return-Path: <SRS0=IGSF=QW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B3AC43381
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 16:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7BC21927
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 16:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390989AbfBOQAt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:00:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389873AbfBOQAt (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 15 Feb 2019 11:00:49 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 52EFCAD89E
        for <selinux@vger.kernel.org>; Fri, 15 Feb 2019 16:00:48 +0000 (UTC)
Received: from workstation.redhat.com (unknown [10.40.205.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 630525C21E;
        Fri, 15 Feb 2019 16:00:47 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v2 3/3] python/semanage module: Fix handling of -a/-e/-d/-r options
Date:   Fri, 15 Feb 2019 17:00:25 +0100
Message-Id: <20190215160025.9810-3-plautrba@redhat.com>
In-Reply-To: <20190215160025.9810-1-plautrba@redhat.com>
References: <pjdtvh5m8i4.fsf@redhat.com>
 <20190215160025.9810-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 15 Feb 2019 16:00:48 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Previous code traceback-ed when one of the mentioned option was used without
any argument as this state was not handled by the argument parser.

action='store' stores arguments as a list while the original
action='store_const' used str therefore it's needed to convert list to str
before it's sent to moduleRecords class.

Fixes:
^_^ semanage module -a
Traceback (most recent call last):
  File "/usr/sbin/semanage", line 963, in <module>
    do_parser()
  File "/usr/sbin/semanage", line 942, in do_parser
    args.func(args)
  File "/usr/sbin/semanage", line 608, in handleModule
    OBJECT.add(args.module_name, args.priority)
  File "/usr/lib/python3.7/site-packages/seobject.py", line 402, in add
    if not os.path.exists(file):
  File "/usr/lib64/python3.7/genericpath.py", line 19, in exists
    os.stat(path)
TypeError: stat: path should be string, bytes, os.PathLike or integer, not NoneType

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/semanage/semanage | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/python/semanage/semanage b/python/semanage/semanage
index 18191c13..d6d68248 100644
--- a/python/semanage/semanage
+++ b/python/semanage/semanage
@@ -609,14 +609,14 @@ def setupInterfaceParser(subparsers):
 
 def handleModule(args):
     OBJECT = seobject.moduleRecords(args)
-    if args.action == "add":
-        OBJECT.add(args.module_name, args.priority)
-    if args.action == "enable":
-        OBJECT.set_enabled(args.module_name, True)
-    if args.action == "disable":
-        OBJECT.set_enabled(args.module_name, False)
-    if args.action == "remove":
-        OBJECT.delete(args.module_name, args.priority)
+    if args.action_add:
+        OBJECT.add(args.action_add[0], args.priority)
+    if args.action_enable:
+        OBJECT.set_enabled(" ".join(args.action_enable), True)
+    if args.action_disable:
+        OBJECT.set_enabled(" ".join(args.action_disable), False)
+    if args.action_remove:
+        OBJECT.delete(" ".join(args.action_remove), args.priority)
     if args.action == "deleteall":
         OBJECT.deleteall()
     if args.action == "list":
@@ -635,14 +635,13 @@ def setupModuleParser(subparsers):
     parser_add_priority(moduleParser, "module")
 
     mgroup = moduleParser.add_mutually_exclusive_group(required=True)
-    parser_add_add(mgroup, "module")
     parser_add_list(mgroup, "module")
     parser_add_extract(mgroup, "module")
     parser_add_deleteall(mgroup, "module")
-    mgroup.add_argument('-r', '--remove', dest='action', action='store_const', const='remove', help=_("Remove a module"))
-    mgroup.add_argument('-d', '--disable', dest='action', action='store_const', const='disable', help=_("Disable a module"))
-    mgroup.add_argument('-e', '--enable', dest='action', action='store_const', const='enable', help=_("Enable a module"))
-    moduleParser.add_argument('module_name', nargs='?', default=None, help=_('Name of the module to act on'))
+    mgroup.add_argument('-a', '--add', dest='action_add', action='store', nargs=1, metavar='module_name', help=_("Add a module"))
+    mgroup.add_argument('-r', '--remove', dest='action_remove', action='store', nargs='+', metavar='module_name', help=_("Remove a module"))
+    mgroup.add_argument('-d', '--disable', dest='action_disable', action='store', nargs='+', metavar='module_name', help=_("Disable a module"))
+    mgroup.add_argument('-e', '--enable', dest='action_enable', action='store', nargs='+', metavar='module_name', help=_("Enable a module"))
     moduleParser.set_defaults(func=handleModule)
 
 
-- 
2.20.1

