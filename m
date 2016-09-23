Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8NHP1kr016040
 for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 13:25:01 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0CD9072673
 for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 17:24:22 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2] sandbox: do not try setup directories without -X or -M
Date: Fri, 23 Sep 2016 19:24:15 +0200
Message-Id: <20160923172416.25050-1-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

sandbox tried to copy all affected files to the new home
or tmp even though -M or -X was not specified and there was no new
directory.

Fixes:
$ sandbox ls ~
/usr/bin/sandbox: [Errno 17] File exists: '/root'

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 policycoreutils/sandbox/sandbox | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/policycoreutils/sandbox/sandbox b/policycoreutils/sandbox/sandbox
index 4ed57c1..9cc13c2 100644
--- a/policycoreutils/sandbox/sandbox
+++ b/policycoreutils/sandbox/sandbox
@@ -503,7 +503,8 @@ sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-
         try:
             self.__parse_options()
             self.__gen_context()
-            self.__setup_dir()
+            if self.__mount:
+                self.__setup_dir()
             return self.__execute()
         except KeyboardInterrupt:
             sys.exit(0)
-- 
2.9.3
