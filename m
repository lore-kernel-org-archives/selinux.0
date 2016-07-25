Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6PGc4Cr026453
 for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2016 12:38:05 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E85E2D4E4E
 for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2016 16:37:12 +0000 (UTC)
From: Miroslav Vadkerti <mvadkert@redhat.com>
To: selinux@tycho.nsa.gov
Cc: linux-audit@redhat.com, Miroslav Vadkerti <mvadkert@redhat.com>
Subject: [PATCH 2/2] semanage: fix modify action in node and interface
Date: Mon, 25 Jul 2016 18:37:07 +0200
Message-Id: <1469464627-2159-2-git-send-email-mvadkert@redhat.com>
In-Reply-To: <1469464627-2159-1-git-send-email-mvadkert@redhat.com>
References: <1469464627-2159-1-git-send-email-mvadkert@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The modify actions of security context mappings for
interface and node actully called add action.

Signed-off-by: Miroslav Vadkerti <mvadkert@redhat.com>
---
 policycoreutils/semanage/semanage | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/semanage/semanage b/policycoreutils/semanage/semanage
index 954411d..b199ebe 100644
--- a/policycoreutils/semanage/semanage
+++ b/policycoreutils/semanage/semanage
@@ -524,7 +524,7 @@ def handleInterface(args):
     if args.action is "add":
         OBJECT.add(args.interface, args.range, args.type)
     if args.action is "modify":
-        OBJECT.add(args.interface, args.range, args.type)
+        OBJECT.modify(args.interface, args.range, args.type)
     if args.action is "delete":
         OBJECT.delete(args.interface)
     if args.action is "list":
@@ -607,7 +607,7 @@ def handleNode(args):
     if args.action is "add":
         OBJECT.add(args.node, args.netmask, args.proto, args.range, args.type)
     if args.action is "modify":
-        OBJECT.add(args.node, args.netmask, args.proto, args.range, args.type)
+        OBJECT.modify(args.node, args.netmask, args.proto, args.range, args.type)
     if args.action is "delete":
         OBJECT.delete(args.node, args.netmask, args.proto)
     if args.action is "list":
-- 
1.8.3.1
