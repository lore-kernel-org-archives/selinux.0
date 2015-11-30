Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tAUDw8vq016125
 for <selinux@tycho.nsa.gov>; Mon, 30 Nov 2015 08:58:11 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (Postfix) with ESMTPS id 021CF552E7
 for <selinux@tycho.nsa.gov>; Mon, 30 Nov 2015 13:57:53 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils: fix 'semanage permissive -l' subcommand
Date: Mon, 30 Nov 2015 14:57:47 +0100
Message-Id: <1448891867-10905-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This reverts the commit 97d06737 which introduced a regression on '-l'
which started to require at least one argument and fixes the original
problem other way. A args.parser value is set now and handlePermissive
function uses it to print an usage message when args.type is not set.

Fixes: semanage permissive -l
  usage: semanage permissive [-h] (-a | -d | -l) [-n] [-N] [-S STORE]
                             type [type ...]
  semanage permissive: error: the following arguments are required: type

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 policycoreutils/semanage/semanage | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/policycoreutils/semanage/semanage b/policycoreutils/semanage/semanage
index ed48c11..7489955 100644
--- a/policycoreutils/semanage/semanage
+++ b/policycoreutils/semanage/semanage
@@ -700,12 +700,17 @@ def handlePermissive(args):
     OBJECT = object_dict['permissive']()
     OBJECT.set_reload(args.noreload)
 
-    if args.action is "add":
-        OBJECT.add(args.type)
     if args.action is "list":
         OBJECT.list(args.noheading)
-    if args.action is "delete":
-        OBJECT.delete(args.type)
+    elif args.type != None:
+        if args.action is "add":
+            OBJECT.add(args.type)
+        if args.action is "delete":
+            OBJECT.delete(args.type)
+    else:
+        args.parser.print_usage(sys.stderr)
+        sys.stderr.write(_('semanage permissive: error: the following argument is required: type\n'))
+        sys.exit(1)
 
 
 def setupPermissiveParser(subparsers):
@@ -721,8 +726,9 @@ def setupPermissiveParser(subparsers):
     parser_add_noheading(permissiveParser, "permissive")
     parser_add_noreload(permissiveParser, "permissive")
     parser_add_store(permissiveParser, "permissive")
-    permissiveParser.add_argument('type', nargs='+', default=None, help=_('type'))
+    permissiveParser.add_argument('type', nargs='?', default=None, help=_('type'))
     permissiveParser.set_defaults(func=handlePermissive)
+    permissiveParser.set_defaults(parser=permissiveParser)
 
 
 def handleDontaudit(args):
-- 
2.6.3
