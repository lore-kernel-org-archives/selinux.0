Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F998C77B7F
	for <selinux@archiver.kernel.org>; Wed, 17 May 2023 13:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjEQNuu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 May 2023 09:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjEQNut (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 May 2023 09:50:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3536A76B0
        for <selinux@vger.kernel.org>; Wed, 17 May 2023 06:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684331392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TrvXU7qllrr8qDPVHSeAi6Bk5HCWGy+evdXr5eNIyLg=;
        b=fchIpMeqgxTaWinbzJ3l5swXgIYeko/mdArcU9HRX46+EtFKEUqGkPb801XT62TLzcyjtJ
        YqGWBLPQKBn2Evr90GStayrJiJc/m8Bmr5oJzxWlUr9a7lsJigH8Ldtah5BvRjMGB0nv31
        tIcFkIRoBx3rtK8mR7xWUGffNklCU/o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-R8yCg0wkMsCXJehtXiA5uA-1; Wed, 17 May 2023 09:49:51 -0400
X-MC-Unique: R8yCg0wkMsCXJehtXiA5uA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA90D85C075
        for <selinux@vger.kernel.org>; Wed, 17 May 2023 13:49:50 +0000 (UTC)
Received: from P1.redhat.com (unknown [10.45.224.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48E701121314;
        Wed, 17 May 2023 13:49:50 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH 2/4] python/semanage: Drop hard formating from localized strings
Date:   Wed, 17 May 2023 15:49:32 +0200
Message-Id: <20230517134934.709059-2-lautrbach@redhat.com>
In-Reply-To: <20230517134934.709059-1-lautrbach@redhat.com>
References: <20230517134934.709059-1-lautrbach@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It confuses translators and new lines are dropped by parser module anyway.

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 python/audit2allow/audit2allow | 14 ++++++++---
 python/semanage/semanage       | 44 +++++++++++++---------------------
 2 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/python/audit2allow/audit2allow b/python/audit2allow/audit2allow
index 5587a2dbb006..35b0b151ac86 100644
--- a/python/audit2allow/audit2allow
+++ b/python/audit2allow/audit2allow
@@ -234,9 +234,17 @@ class AuditToPolicy:
             print(e)
             sys.exit(1)
 
-        sys.stdout.write(_("******************** IMPORTANT ***********************\n"))
-        sys.stdout.write((_("To make this policy package active, execute:" +
-                            "\n\nsemodule -i %s\n\n") % packagename))
+        sys.stdout.write(
+"""******************** {important} ***********************
+{text}
+
+semodule -i {packagename}
+
+""".format(
+    important=_("IMPORTANT"),
+    text=_("To make this policy package active, execute:"),
+    packagename=packagename
+))
 
     def __output_audit2why(self):
         import selinux
diff --git a/python/semanage/semanage b/python/semanage/semanage
index e0bd98a95c77..898df4b93c10 100644
--- a/python/semanage/semanage
+++ b/python/semanage/semanage
@@ -238,30 +238,22 @@ def parser_add_level(parser, name):
 
 
 def parser_add_range(parser, name):
-    parser.add_argument('-r', '--range', default='',
-                        help=_('''
-MLS/MCS Security Range (MLS/MCS Systems only)
-SELinux Range  for SELinux login mapping
-defaults to the SELinux user record range.
-SELinux Range for SELinux user defaults to s0.
-'''))
+    parser.add_argument('-r', '--range', default='', help=_(
+        "MLS/MCS Security Range (MLS/MCS Systems only) SELinux Range for SELinux login mapping defaults to the SELinux user record range. \
+SELinux Range for SELinux user defaults to s0."
+    ))
 
 
 def parser_add_proto(parser, name):
-    parser.add_argument('-p', '--proto', help=_('''
-    Protocol  for  the specified port (tcp|udp|dccp|sctp) or internet protocol
-    version for the specified node (ipv4|ipv6).
-'''))
+    parser.add_argument('-p', '--proto', help=_(
+        "Protocol for the specified port (tcp|udp|dccp|sctp) or internet protocol version for the specified node (ipv4|ipv6)."
+    ))
 
 def parser_add_subnet_prefix(parser, name):
-    parser.add_argument('-x', '--subnet_prefix', help=_('''
-    Subnet prefix for  the specified infiniband ibpkey.
-'''))
+    parser.add_argument('-x', '--subnet_prefix', help=_('Subnet prefix for  the specified infiniband ibpkey.'))
 
 def parser_add_ibdev_name(parser, name):
-    parser.add_argument('-z', '--ibdev_name', help=_('''
-    Name for the specified infiniband end port.
-'''))
+    parser.add_argument('-z', '--ibdev_name', help=_("Name for the specified infiniband end port."))
 
 def parser_add_modify(parser, name):
     parser.add_argument('-m', '--modify', dest='action', action='store_const', const='modify', help=_("Modify a record of the %s object type") % name)
@@ -372,10 +364,10 @@ If you do not specify a file type, the file type will default to "all files".
     parser_add_extract(fcontext_action, "fcontext")
     parser_add_deleteall(fcontext_action, "fcontext")
 
-    fcontextParser.add_argument('-e', '--equal', help=_('''Substitute  target  path with sourcepath when generating default
-                                                                  label.  This is used with fcontext. Requires source  and  target
-                                                                  path  arguments.  The context labeling for the target subtree is
-                                                                  made equivalent to that defined for the source.'''))
+    fcontextParser.add_argument('-e', '--equal', help=_(
+        "Substitute target path with sourcepath when generating default label. This is used with fcontext. Requires source and target \
+path arguments. The context labeling for the target subtree is made equivalent to that defined for the source."
+    ))
     fcontextParser.add_argument('-f', '--ftype', default="", choices=["a", "f", "d", "c", "b", "s", "l", "p"], help=_(ftype_help))
     parser_add_seuser(fcontextParser, "fcontext")
     parser_add_type(fcontextParser, "fcontext")
@@ -426,9 +418,7 @@ def setupUserParser(subparsers):
     parser_add_range(userParser, "user")
     userParser.add_argument('-R', '--roles', default=[],
                             action=CheckRole,
-                            help=_('''
-SELinux Roles.  You must enclose multiple roles within quotes, separate by spaces. Or specify -R multiple times.
-'''))
+                            help=_("SELinux Roles. You must enclose multiple roles within quotes, separate by spaces. Or specify -R multiple times."))
     userParser.add_argument('-P', '--prefix', default="user", help=argparse.SUPPRESS)
     userParser.add_argument('selinux_name', nargs='?', default=None, help=_('selinux_name'))
     userParser.set_defaults(func=handleUser)
@@ -901,9 +891,9 @@ def setupImportParser(subparsers):
 def createCommandParser():
     commandParser = seParser(prog='semanage',
                              formatter_class=argparse.ArgumentDefaultsHelpFormatter,
-                             description='''semanage is used to configure certain elements
-                                                            of SELinux policy with-out requiring modification
-                                                            to or recompilation from policy source.''')
+                             description=_(
+            "semanage is used to configure certain elements of SELinux policy with-out requiring modification or recompilation from policy source."
+                             ))
 
     #To add a new subcommand define the parser for it in a function above and call it here.
     subparsers = commandParser.add_subparsers(dest='subcommand')
-- 
2.40.1

