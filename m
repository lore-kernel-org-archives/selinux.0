Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t19N6dNP025089
 for <selinux@tycho.nsa.gov>; Mon, 9 Feb 2015 18:06:39 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t19N6aUm005798
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <selinux@tycho.nsa.gov>; Mon, 9 Feb 2015 18:06:36 -0500
Subject: [PATCH 2/4] selinux-testsuite: allow the file test to work with all
 coreutils versions
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Mon, 09 Feb 2015 18:06:35 -0500
Message-ID: <20150209230635.2579.7110.stgit@localhost>
In-Reply-To: <20150209230426.2579.84520.stgit@localhost>
References: <20150209230426.2579.84520.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Prior to coreutils v8.23 the 'ls -Z' output looked like the following:

  # /bin/ls -Z test
  -rw-r--r--. root root unconfined_u:object_r:user_tmp_t:s0 test

However, with the coreutils v8.23 release the output changed to:

  # /bin/ls -Z test
  system_u:object_r:test_file_t:s0 test

This patch attempts to detect the version of /bin/ls in use and adjusts
accordingly.

Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 0 files changed

diff --git a/tests/file/test b/tests/file/test
index e6ed44d..e52744f 100755
--- a/tests/file/test
+++ b/tests/file/test
@@ -47,7 +47,11 @@ system "chcon -t fileop_exec_t $basedir/wait_io 2>&1 > /dev/null";
 #
 $output = `ls -Z $basedir/temp_file`;
 @arr = split(' ', $output);
-$good_file_sid = $arr[3];
+if (index($arr[0], ":") != -1) {
+	$good_file_sid = $arr[0]
+} else {
+	$good_file_sid = $arr[3]
+}
 
 #
 # Attempt to access a restricted file as the 'good' domain.  The first test
