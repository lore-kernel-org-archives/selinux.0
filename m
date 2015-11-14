Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tAE7n9bi005574
 for <selinux@tycho.nsa.gov>; Sat, 14 Nov 2015 02:49:09 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (Postfix) with ESMTPS id 7D7928F4F1
 for <selinux@tycho.nsa.gov>; Sat, 14 Nov 2015 07:48:45 +0000 (UTC)
From: Miroslav Grepl <mgrepl@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils/sandbox: Fix sandbox to propagate specified
 MCS/MLS Security Level.
Date: Sat, 14 Nov 2015 08:48:40 +0100
Message-Id: <1447487320-18763-1-git-send-email-mgrepl@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

If "level" option is used to start sandbox commands, this level is not propagated
to specified  homedir and tmpdir directories. See rhbz #1279006.

Signed-off-by: Miroslav Grepl <mgrepl@redhat.com>
---
 policycoreutils/sandbox/sandbox | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/policycoreutils/sandbox/sandbox b/policycoreutils/sandbox/sandbox
index 5109eca..163afa0 100644
--- a/policycoreutils/sandbox/sandbox
+++ b/policycoreutils/sandbox/sandbox
@@ -406,9 +406,6 @@ sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-
            self.__execcon = "%s:%s:%s:%s" % (con[0], con[1], self.setype, level)
            self.__filecon = "%s:object_r:sandbox_file_t:%s" % (con[0], level)
     def __setup_dir(self):
-           if self.__options.level or self.__options.session:
-                  return
-
            if self.__options.homedir:
                   selinux.chcon(self.__options.homedir, self.__filecon, recursive=True)
                   self.__homedir = self.__options.homedir
-- 
2.6.2
