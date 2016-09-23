Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8NHP1ks016040
 for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 13:25:01 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 02DAD3138
 for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 17:24:23 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/2] sandbox: create a new session for sandboxed processes
Date: Fri, 23 Sep 2016 19:24:16 +0200
Message-Id: <20160923172416.25050-2-plautrba@redhat.com>
In-Reply-To: <20160923172416.25050-1-plautrba@redhat.com>
References: <20160923172416.25050-1-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

It helps to prevent sandboxed processes to inject arbitrary commands
into the parent.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 policycoreutils/sandbox/sandbox | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/policycoreutils/sandbox/sandbox b/policycoreutils/sandbox/sandbox
index 9cc13c2..07c340c 100644
--- a/policycoreutils/sandbox/sandbox
+++ b/policycoreutils/sandbox/sandbox
@@ -471,10 +471,15 @@ sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-
                     cmds += ["--"] + self.__paths
                 return subprocess.Popen(cmds).wait()
 
-            selinux.setexeccon(self.__execcon)
-            rc = subprocess.Popen(self.__cmds).wait()
-            selinux.setexeccon(None)
-            return rc
+            pid = os.fork()
+            if pid == 0:
+                rc = os.setsid()
+                if rc:
+                    return rc
+                selinux.setexeccon(self.__execcon)
+                os.execv(self.__cmds[0], self.__cmds)
+            rc = os.waitpid(pid, 0)
+            return os.WEXITSTATUS(rc[1])
 
         finally:
             for i in self.__paths:
-- 
2.9.3
