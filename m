Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s7SKlZMA017092
 for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2014 16:47:35 -0400
Subject: [PATCH] file: replace 'ls -Z' with 'ls -lZ' for consistent results
From: Paul Moore <pmoore@redhat.com>
To: Serge Hallyn <serge.hallyn@ubuntu.com>, selinux@tycho.nsa.gov
Date: Thu, 28 Aug 2014 16:47:38 -0400
Message-ID: <20140828204738.10801.34505.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I'm not sure the exact date of the change, but 'ls -Z' on Rawhide is
a bit different than in the past; the output now looks like this:

  # /bin/ls -Z test
  system_u:object_r:test_file_t:s0 test

This patch converts the testsuite to use 'ls -lZ' which appears to be
consistent.

Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 tests/file/test |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/file/test b/tests/file/test
index e6ed44d..1c8485a 100755
--- a/tests/file/test
+++ b/tests/file/test
@@ -45,9 +45,9 @@ system "chcon -t fileop_exec_t $basedir/wait_io 2>&1 > /dev/null";
 #
 # Get the SID of the good file.
 #
-$output = `ls -Z $basedir/temp_file`;
+$output = `ls -lZ $basedir/temp_file`;
 @arr = split(' ', $output);
-$good_file_sid = $arr[3];
+$good_file_sid = $arr[4];
 
 #
 # Attempt to access a restricted file as the 'good' domain.  The first test
