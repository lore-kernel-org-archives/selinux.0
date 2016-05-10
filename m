Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u4A6vw85009252
 for <selinux@tycho.nsa.gov>; Tue, 10 May 2016 02:57:58 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5ADB63B721
 for <selinux@tycho.nsa.gov>; Tue, 10 May 2016 06:57:55 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils: remove typos from chcat --help
Date: Tue, 10 May 2016 08:57:45 +0200
Message-Id: <1462863465-26111-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 policycoreutils/scripts/chcat | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/scripts/chcat b/policycoreutils/scripts/chcat
index 472785c..267390e 100755
--- a/policycoreutils/scripts/chcat
+++ b/policycoreutils/scripts/chcat
@@ -346,8 +346,8 @@ def translate(cats):
 def usage():
     print(_("Usage %s CATEGORY File ...") % sys.argv[0])
     print(_("Usage %s -l CATEGORY user ...") % sys.argv[0])
-    print(_("Usage %s [[+|-]CATEGORY],...]q File ...") % sys.argv[0])
-    print(_("Usage %s -l [[+|-]CATEGORY],...]q user ...") % sys.argv[0])
+    print(_("Usage %s [[+|-]CATEGORY],...] File ...") % sys.argv[0])
+    print(_("Usage %s -l [[+|-]CATEGORY],...] user ...") % sys.argv[0])
     print(_("Usage %s -d File ...") % sys.argv[0])
     print(_("Usage %s -l -d user ...") % sys.argv[0])
     print(_("Usage %s -L") % sys.argv[0])
-- 
2.7.4
