Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCACD847B
	for <selinux@vger.kernel.org>; Thu, 28 Nov 2024 15:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732807748; cv=none; b=bFlfHd4m2jtjTAlu+IhcKRt1xWqNH8wEaKihBuzhldBwXkpW9MqbMO4G7U0aWdiLRnYyWoxek06gmDuwe/Zenw/dmDTmjX1VXo1vGPJpf7SyZLjG1h2/opgxEBeVWXCeCtlwk5atInGdJeGwRAR8n4ttdyMYPs20NuLf57uDa+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732807748; c=relaxed/simple;
	bh=jMWTY0miLp3ttWuiXCG2mtq15p23KYcMCA1olS2lfE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TtpL4S88SGjNF5vCnFqocIwnbAnCLnQxcdZ5MpV8Rxupzoe5eZo25/EfXR1a/XdcFxcSpEfesMbRdSFb8GQHK9ctbCsLr7+C4orSw91nexImFc2F1AvZ5s8TgHTrvPCyFt8OdAf8x4UQPnyi4+UNnBtjZufDNp9ZjB1+QUE1ih4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=jakcZN5/; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="jakcZN5/"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732807736;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=zkRonoBd42DMjYyyUqHvAawwBbv+NhzgTqmC6oFIM6Y=;
	b=jakcZN5/fmc73XBnA/56NPwBs+5WduBGwCD4k0PyDoqYetlZdFMm9WFEy54CBsu9xW1zxk
	aDsMTaHRiflar9sF9ZbFXEYWjeRK7JbsAvSZjHRJ20HoUi6CPFO6zDb8Sjq/Z+6sEqFvFj
	HAqVUHAOtNrXEYH4vnKYp9tPtGGIglzDnDX2v/v2dht5xUdWBRbJmYzrJGSkxtv8AedAr8
	E232ukL22B7xZQ8RjLk5E0OIpsrFkyp8PkWi7IF2RqM9/y1E15HAYbfUA/yC/5O1WYbhMP
	RM7s2AoIYRlcvE5Cs8LnfmjihGm88SqWhK/ikKhaoLUqQbY0VySMwle2EG2T6g==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH] ioctl: add test for conditional xperms
Date: Thu, 28 Nov 2024 16:28:51 +0100
Message-ID: <20241128152851.14704-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Add checks for extended permission av rules in conditional blocks.
Requires policy version 34.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policy/Makefile                  |  5 ++
 policy/test_ioctl_cond_xperms.te | 26 ++++++++++
 tests/ioctl/.gitignore           |  2 +
 tests/ioctl/test                 | 82 +++++++++++++++++++++++++++++++-
 tests/ioctl/test_siocgifindex.c  | 32 +++++++++++++
 tests/ioctl/test_siocgifname.c   | 32 +++++++++++++
 6 files changed, 177 insertions(+), 2 deletions(-)
 create mode 100644 policy/test_ioctl_cond_xperms.te
 create mode 100644 tests/ioctl/test_siocgifindex.c
 create mode 100644 tests/ioctl/test_siocgifname.c

diff --git a/policy/Makefile b/policy/Makefile
index 32d7ede..46e51f3 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -175,6 +175,11 @@ ifeq ($(shell grep -q user_namespace $(POLDEV)/include/support/all_perms.spt &&
 export M4PARAM += -Duser_namespace_defined
 endif
 
+# conditional xperm dependency: policy >= 34
+ifeq ($(shell [ $(POL_VERS) -ge 34 -a $(MAX_KERNEL_POLICY) -ge 34 ] && echo true),true)
+TARGETS += test_ioctl_cond_xperms.te
+endif
+
 all: build
 
 expand_check:
diff --git a/policy/test_ioctl_cond_xperms.te b/policy/test_ioctl_cond_xperms.te
new file mode 100644
index 0000000..03e6c0f
--- /dev/null
+++ b/policy/test_ioctl_cond_xperms.te
@@ -0,0 +1,26 @@
+define(`SIOCGIFNAME', `{ 0x8910 }')
+define(`SIOCGIFINDEX', `{ 0x8933 }')
+
+bool test_ioctl_cond_xperm_switch false;
+
+# Domain for process that is allowed SIOCGIFNAME on true and SIOCGIFINDEX on false.
+type test_ioctl_cond_xperm_a_t;
+testsuite_domain_type(test_ioctl_cond_xperm_a_t)
+typeattribute test_ioctl_cond_xperm_a_t ioctldomain;
+allow test_ioctl_cond_xperm_a_t self:udp_socket { create ioctl };
+if (test_ioctl_cond_xperm_switch) {
+  allowxperm test_ioctl_cond_xperm_a_t self:udp_socket ioctl SIOCGIFNAME;
+} else {
+  allowxperm test_ioctl_cond_xperm_a_t self:udp_socket ioctl SIOCGIFINDEX;
+}
+
+# Domain for process that is allowed SIOCGIFINDEX on true and SIOCGIFNAME on false.
+type test_ioctl_cond_xperm_b_t;
+testsuite_domain_type(test_ioctl_cond_xperm_b_t)
+typeattribute test_ioctl_cond_xperm_b_t ioctldomain;
+allow test_ioctl_cond_xperm_b_t self:udp_socket { create ioctl };
+if (test_ioctl_cond_xperm_switch) {
+  allowxperm test_ioctl_cond_xperm_b_t self:udp_socket ioctl SIOCGIFINDEX;
+} else {
+  allowxperm test_ioctl_cond_xperm_b_t self:udp_socket ioctl SIOCGIFNAME;
+}
diff --git a/tests/ioctl/.gitignore b/tests/ioctl/.gitignore
index e89db81..a4e44e7 100644
--- a/tests/ioctl/.gitignore
+++ b/tests/ioctl/.gitignore
@@ -1,2 +1,4 @@
 test_ioctl
 test_noioctl
+test_siocgifindex
+test_siocgifname
diff --git a/tests/ioctl/test b/tests/ioctl/test
index f313f06..6c33bf5 100755
--- a/tests/ioctl/test
+++ b/tests/ioctl/test
@@ -6,9 +6,11 @@
 use Test;
 
 BEGIN {
-    $test_count  = 2;
-    $test_xperms = 0;
+    $test_count       = 2;
+    $test_xperms      = 0;
+    $test_cond_xperms = 0;
 
+    $polver    = `checkpolicy -V | cut -f 1 -d ' '`;
     $modver    = `checkmodule -V | cut -f 2 -d -`;
     $selinuxfs = `cat /proc/mounts | grep selinuxfs | cut -f 2 -d ' '`;
     chomp($selinuxfs);
@@ -17,6 +19,10 @@ BEGIN {
         $test_xperms = 1;
         $test_count += 2;
     }
+    if ( $polver >= 34 && $kernver >= 34 ) {
+        $test_cond_xperms = 1;
+        $test_count += 15;
+    }
 
     plan tests => $test_count;
 }
@@ -62,6 +68,78 @@ if ($test_xperms) {
     ok($result);
 }
 
+if ($test_cond_xperms) {
+    #
+    # Attempt to perform the ioctls in the false configuration
+    #
+
+    #
+    # First round with boolean set to false
+    #
+    $result = system "setsebool test_ioctl_cond_xperm_switch off 2>&1";
+    ok( $result, 0 );
+
+    $result = system
+      "runcon -t test_ioctl_cond_xperm_a_t -- $basedir/test_siocgifname 2>&1";
+    ok( $result >> 8, 7 );
+
+    $result = system
+      "runcon -t test_ioctl_cond_xperm_a_t -- $basedir/test_siocgifindex 2>&1";
+    ok( $result, 0 );
+
+    $result = system
+      "runcon -t test_ioctl_cond_xperm_b_t -- $basedir/test_siocgifname 2>&1";
+    ok( $result, 0 );
+
+    $result = system
+      "runcon -t test_ioctl_cond_xperm_b_t -- $basedir/test_siocgifindex 2>&1";
+    ok( $result >> 8, 7 );
+
+    #
+    # Second round with boolean set to true
+    #
+    $result = system "setsebool test_ioctl_cond_xperm_switch on 2>&1";
+    ok( $result, 0 );
+
+    $result = system
+      "runcon -t test_ioctl_cond_xperm_a_t -- $basedir/test_siocgifname 2>&1";
+    ok( $result, 0 );
+
+    $result = system
+      "runcon -t test_ioctl_cond_xperm_a_t -- $basedir/test_siocgifindex 2>&1";
+    ok( $result >> 8, 7 );
+
+    $result = system
+      "runcon -t test_ioctl_cond_xperm_b_t -- $basedir/test_siocgifname 2>&1";
+    ok( $result >> 8, 7 );
+
+    $result = system
+      "runcon -t test_ioctl_cond_xperm_b_t -- $basedir/test_siocgifindex 2>&1";
+    ok( $result, 0 );
+
+    $result = system "setsebool test_ioctl_cond_xperm_switch off 2>&1";
+    ok( $result, 0 );
+
+    $result = system
+      "runcon -t test_ioctl_cond_xperm_a_t -- $basedir/test_siocgifname 2>&1";
+    ok( $result >> 8, 7 );
+
+    #
+    # Third (control) round with boolean set to false
+    #
+    $result = system
+      "runcon -t test_ioctl_cond_xperm_a_t -- $basedir/test_siocgifindex 2>&1";
+    ok( $result, 0 );
+
+    $result = system
+      "runcon -t test_ioctl_cond_xperm_b_t -- $basedir/test_siocgifname 2>&1";
+    ok( $result, 0 );
+
+    $result = system
+      "runcon -t test_ioctl_cond_xperm_b_t -- $basedir/test_siocgifindex 2>&1";
+    ok( $result >> 8, 7 );
+}
+
 system "rm -f $basedir/temp_file 2>&1";
 
 exit;
diff --git a/tests/ioctl/test_siocgifindex.c b/tests/ioctl/test_siocgifindex.c
new file mode 100644
index 0000000..ab21ad4
--- /dev/null
+++ b/tests/ioctl/test_siocgifindex.c
@@ -0,0 +1,32 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <errno.h>
+#include <net/if.h>
+
+int main(int argc, char **argv)
+{
+	int sock;
+	int rc;
+	struct ifreq val = {};
+
+	sock = socket(AF_INET, SOCK_DGRAM, 0);
+	if(sock == -1) {
+		perror("test_siocgifindex:open");
+		exit(1);
+	}
+
+	rc = ioctl(sock, SIOCGIFINDEX, &val);
+	if (rc < 0 && errno != ENODEV) {
+		perror("test_siocgifindex:SIOCGIFINDEX");
+		close(sock);
+		exit(7);
+	}
+
+	close(sock);
+	exit(0);
+}
diff --git a/tests/ioctl/test_siocgifname.c b/tests/ioctl/test_siocgifname.c
new file mode 100644
index 0000000..5308bfe
--- /dev/null
+++ b/tests/ioctl/test_siocgifname.c
@@ -0,0 +1,32 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <errno.h>
+#include <net/if.h>
+
+int main(int argc, char **argv)
+{
+	int sock;
+	int rc;
+	struct ifreq val = {};
+
+	sock = socket(AF_INET, SOCK_DGRAM, 0);
+	if(sock == -1) {
+		perror("test_siocgifname:socket");
+		exit(1);
+	}
+
+	rc = ioctl(sock, SIOCGIFNAME, &val);
+	if (rc < 0 && errno != ENODEV) {
+		perror("test_siocgifname:SIOCGIFNAME");
+		close(sock);
+		exit(7);
+	}
+
+	close(sock);
+	exit(0);
+}
-- 
2.45.2

