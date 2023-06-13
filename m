Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7435FC88CB6
	for <selinux@archiver.kernel.org>; Tue, 13 Jun 2023 09:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240089AbjFMJpU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Jun 2023 05:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240098AbjFMJon (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Jun 2023 05:44:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466B8E3
        for <selinux@vger.kernel.org>; Tue, 13 Jun 2023 02:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686649443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i/ZY6w+Fu00OHN4vw4Swmv4zt86CJlHqc7bbIcSUThQ=;
        b=Tob60q6CcOYJj92XzbvVquSYbVTVVPO5GS6rQHdcyW14ECWG2onmY8MYmDfHSR5LcpMOIw
        D3GApSrssI6emB5dCX0QPR8/LkkM+mTTUKUtvGAcANG45xoBRxzvZqQM6rrM+2uVOrb7pn
        XL2EFWFfmD0/bMzIPLFQkHKXNzP0CA4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-467-IULkSibQNYK7-gFkqJr-gQ-1; Tue, 13 Jun 2023 05:44:02 -0400
X-MC-Unique: IULkSibQNYK7-gFkqJr-gQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB5DB1C0515A
        for <selinux@vger.kernel.org>; Tue, 13 Jun 2023 09:44:01 +0000 (UTC)
Received: from P1.redhat.com (unknown [10.45.225.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19567492CA6;
        Tue, 13 Jun 2023 09:44:00 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     selinux@vger.kernel.org
Cc:     vmojzis@redhat.com, Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH v3 2/4] python: Drop hard formating from localized strings
Date:   Tue, 13 Jun 2023 11:42:43 +0200
Message-ID: <20230613094346.2667592-3-lautrbach@redhat.com>
In-Reply-To: <20230613094346.2667592-1-lautrbach@redhat.com>
References: <20230612162155.2604483-5-lautrbach@redhat.com>
 <20230613094346.2667592-1-lautrbach@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It confuses translators and new lines are dropped by parser module anyway.

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 python/audit2allow/audit2allow | 14 ++++++--
 python/semanage/semanage       | 60 +++++++++++++---------------------
 2 files changed, 34 insertions(+), 40 deletions(-)

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
index e0bd98a95c77..4fdb490f7df4 100644
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
@@ -348,15 +340,6 @@ def handleFcontext(args):
 
 
 def setupFcontextParser(subparsers):
-    ftype_help = '''
-File Type.   This is used with fcontext.  Requires a  file  type
-as  shown  in  the  mode  field by ls, e.g. use d to match only
-directories or f to match only regular files. The following
-file type options can be passed:
-f (regular file),d (directory),c (character device),
-b (block device),s (socket),l (symbolic link),p (named pipe)
-If you do not specify a file type, the file type will default to "all files".
-'''
     generate_usage = generate_custom_usage(usage_fcontext, usage_fcontext_dict)
     fcontextParser = subparsers.add_parser('fcontext', usage=generate_usage, help=_("Manage file context mapping definitions"))
     parser_add_locallist(fcontextParser, "fcontext")
@@ -372,11 +355,16 @@ If you do not specify a file type, the file type will default to "all files".
     parser_add_extract(fcontext_action, "fcontext")
     parser_add_deleteall(fcontext_action, "fcontext")
 
-    fcontextParser.add_argument('-e', '--equal', help=_('''Substitute  target  path with sourcepath when generating default
-                                                                  label.  This is used with fcontext. Requires source  and  target
-                                                                  path  arguments.  The context labeling for the target subtree is
-                                                                  made equivalent to that defined for the source.'''))
-    fcontextParser.add_argument('-f', '--ftype', default="", choices=["a", "f", "d", "c", "b", "s", "l", "p"], help=_(ftype_help))
+    fcontextParser.add_argument('-e', '--equal', help=_(
+        'Substitute target path with sourcepath when generating default label. This is used with fcontext. Requires source and target \
+path arguments. The context labeling for the target subtree is made equivalent to that defined for the source.'
+    ))
+    fcontextParser.add_argument('-f', '--ftype', default="", choices=["a", "f", "d", "c", "b", "s", "l", "p"], help=_(
+        'File Type. This is used with fcontext. Requires a file type as shown in the mode field by ls, e.g. use d to match only \
+directories or f to match only regular files. The following file type options can be passed: f (regular file), d (directory), \
+c (character device), b (block device), s (socket), l (symbolic link), p (named pipe). \
+If you do not specify a file type, the file type will default to "all files".'
+    ))
     parser_add_seuser(fcontextParser, "fcontext")
     parser_add_type(fcontextParser, "fcontext")
     parser_add_range(fcontextParser, "fcontext")
@@ -426,9 +414,7 @@ def setupUserParser(subparsers):
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
@@ -901,9 +887,9 @@ def setupImportParser(subparsers):
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
2.41.0.rc2

