Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tAH7bf2X028815
 for <selinux@tycho.nsa.gov>; Tue, 17 Nov 2015 02:37:41 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 by mx1.redhat.com (Postfix) with ESMTPS id C7F4E14CABA
 for <selinux@tycho.nsa.gov>; Tue, 17 Nov 2015 07:37:28 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils: Require at least one argument for 'semanage
 permissive -d'
Date: Tue, 17 Nov 2015 08:37:23 +0100
Message-Id: <1447745843-15057-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fixes: python ./semanage permissive -d
Traceback (most recent call last):
  File "./semanage", line 925, in <module>
    do_parser()
  File "./semanage", line 904, in do_parser
    args.func(args)
  File "./semanage", line 708, in handlePermissive
    OBJECT.delete(args.type)
  File "/selinux.git/policycoreutils/semanage/seobject.py", line 479, in delete
    for n in name.split():
AttributeError: 'NoneType' object has no attribute 'split'

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 policycoreutils/semanage/semanage | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/semanage/semanage b/policycoreutils/semanage/semanage
index 8097208..ed48c11 100644
--- a/policycoreutils/semanage/semanage
+++ b/policycoreutils/semanage/semanage
@@ -721,7 +721,7 @@ def setupPermissiveParser(subparsers):
     parser_add_noheading(permissiveParser, "permissive")
     parser_add_noreload(permissiveParser, "permissive")
     parser_add_store(permissiveParser, "permissive")
-    permissiveParser.add_argument('type', nargs='?', default=None, help=_('type'))
+    permissiveParser.add_argument('type', nargs='+', default=None, help=_('type'))
     permissiveParser.set_defaults(func=handlePermissive)
 
 
-- 
2.6.2
