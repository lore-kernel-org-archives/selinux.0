Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B974E80DE
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611115; cv=none; b=Ex1eu5Bun7Z6E24Qoe+mFACCSCd3KL/kG6+drFr2GJ++bkcgK4Sv8SnpwQnDdmOh9KsypxifVtQF51JXL8aYexn05g3DCDF5r/4S777awdAKMdkrGliLcHHBckFveS64mojEUAl4V51QsExnVLFpPInQ/cvoHPz0g5GrzzV0hBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611115; c=relaxed/simple;
	bh=d/zvgRoUgHbn7DAiqeKntb+rkPbihSY8gRNix6TUWE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+KiFQc9xUmLAO/M9klcnBYbM8Qp41aEgkPHRrePiyuN2Fsh9L8A9UxKSkJ+5Asg5qJvP9IFhZ3uxA39BoTAyrVrcw94cZvAQ5h0/SQfi5Ifly5sMVNv5MbRd8MzSoW5EbTyNvXPY92A5Zv2ViG/xpUeRK+ho1+N+keArijQgJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=mNqHsms0; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="mNqHsms0"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790611101;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ni/364nqIH6eFYSO+RJnwbv1+BpKIF+5veDcsWWBZuI=;
	b=mNqHsms0goY3fq4U+k+k/D7KaYBksNpaZv2zqU9DTm2gTcGauTUwX8kbLO9hGARv/6FWir
	M3w65vmpFel/NEL1loDw1mXF/L6WTGWT5DnxVDrFRC4ANneC5e5HU6wrP3CPlg44pEkQue
	dbQKpW+BxcVabuAZvdfD++XYXbohRZAykIZekh78A/13duHewSF6ZfExraAYjzMVApmZrI
	cVUf+8slDXBT2S4eZjdacEE43Ey3iSquY20t/lqe9LnzFTlehP9BYL08xGALIqw6r0eH39
	A/Alks8ubyB2xu0vqUp+T1bKcurwBpNet44cvmGwo5eHNAgyvFN+/gxN9WQoWA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 07/21] Fix typos
Date: Mon, 28 Sep 2026 17:57:38 +0200
Message-ID: <20260928155753.2259807-6-cgoettsche@seltendoof.de>
In-Reply-To: <20260928155753.2259807-1-cgoettsche@seltendoof.de>
References: <20260928155753.2259807-1-cgoettsche@seltendoof.de>
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

Found by codespell(1).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: update wording around posix mqueues
---
 doc/tests/Makefile              | 2 +-
 doc/tests/socket.sgml           | 2 +-
 policy/test_capable_file.te     | 2 +-
 policy/test_capable_net.te      | 2 +-
 policy/test_capable_sys.te      | 2 +-
 policy/test_mqueue.te           | 4 ++--
 tests/binder/service_provider.c | 2 +-
 tests/bounds/test               | 4 ++--
 tests/capable_net/test          | 2 +-
 tests/capable_sys/test          | 2 +-
 tests/file/test                 | 2 +-
 tests/file/test_nofcntl.c       | 2 +-
 tests/file/test_sigiotask.c     | 2 +-
 tests/ioctl/test                | 4 ++--
 tests/ioctl/test_noioctl.c      | 2 +-
 tests/mqueue/mqmgr.c            | 2 +-
 tests/mqueue/test               | 2 +-
 tests/overlay/setup-overlay     | 2 +-
 tests/task_setscheduler/test    | 2 +-
 tests/userfaultfd/userfaultfd.c | 2 +-
 20 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/doc/tests/Makefile b/doc/tests/Makefile
index ead6af2..6b85905 100644
--- a/doc/tests/Makefile
+++ b/doc/tests/Makefile
@@ -10,7 +10,7 @@ TEX	:=	$(patsubst %.sgml, %.tex, $(TOP))
 LOG	:=	$(patsubst %.sgml, %.log, $(TOP))
 OUT	:=	$(patsubst %.sgml, %.out, $(TOP))
 
-all: $(PS) $(PDF) $(HMTL)
+all: $(PS) $(PDF) $(HTML)
 
 $(PS): $(ALL) custom.dsl
 	jw -f docbook -d custom.dsl -b ps $(TOP)
diff --git a/doc/tests/socket.sgml b/doc/tests/socket.sgml
index ca203ac..d1293ad 100644
--- a/doc/tests/socket.sgml
+++ b/doc/tests/socket.sgml
@@ -242,7 +242,7 @@ The socket scripts test the following hooks:
 </para>
 </sect2>
 
-<sect2 id="socket_secure"><title>Secure Socket Sytem Call Tests</title>
+<sect2 id="socket_secure"><title>Secure Socket System Call Tests</title>
 <para>
 The tests in the <filename>socket_secure</filename> and
 <filename>unix_secure</filename> subdirectories create a single server
diff --git a/policy/test_capable_file.te b/policy/test_capable_file.te
index 2377279..2ee5d8f 100644
--- a/policy/test_capable_file.te
+++ b/policy/test_capable_file.te
@@ -29,7 +29,7 @@ type test_nofcap_t;
 typeattribute test_nofcap_t capabledomain;
 testsuite_domain_type(test_nofcap_t)
 
-# Allow these domains to create a temporay file.
+# Allow these domains to create a temporary file.
 allow capabledomain test_file_t:file { setattr rw_file_perms };
 allow capabledomain test_file_t:chr_file { create };
 allow capabledomain test_file_t:dir { setattr rw_dir_perms };
diff --git a/policy/test_capable_net.te b/policy/test_capable_net.te
index a01ba8f..8ec4782 100644
--- a/policy/test_capable_net.te
+++ b/policy/test_capable_net.te
@@ -1,7 +1,7 @@
 #################################
 #
 # Policy for testing network related capabilities. The test_capable_file.te
-# policy is a prequisite for this file.
+# policy is a prerequisite for this file.
 #
 
 # Type for process that is allowed certain capabilities
diff --git a/policy/test_capable_sys.te b/policy/test_capable_sys.te
index 70717f1..05d6da5 100644
--- a/policy/test_capable_sys.te
+++ b/policy/test_capable_sys.te
@@ -1,7 +1,7 @@
 #################################
 #
 # Policy for testing system related capabilities. The test_capable_file.te
-# policy is a prequisite for this file.
+# policy is a prerequisite for this file.
 #
 
 # Type for process that is allowed certain capabilities
diff --git a/policy/test_mqueue.te b/policy/test_mqueue.te
index b938a6b..57626d8 100644
--- a/policy/test_mqueue.te
+++ b/policy/test_mqueue.te
@@ -12,13 +12,13 @@ testsuite_domain_type(test_mqmanageop_t)
 domain_obj_id_change_exemption(test_mqmanageop_t)
 typeattribute test_mqmanageop_t mqopdomain;
 
-# Domain for process that is allowed to read the read posix mqueues
+# Domain for process that is allowed to read from posix mqueues
 type test_mqreadop_t;
 testsuite_domain_type(test_mqreadop_t)
 domain_obj_id_change_exemption(test_mqreadop_t)
 typeattribute test_mqreadop_t mqopdomain;
 
-# Domain for process that is allowed to wirte to write posix mqueues
+# Domain for process that is allowed to write to posix mqueues
 type test_mqwriteop_t;
 testsuite_domain_type(test_mqwriteop_t)
 domain_obj_id_change_exemption(test_mqwriteop_t)
diff --git a/tests/binder/service_provider.c b/tests/binder/service_provider.c
index f47365c..97c59dd 100644
--- a/tests/binder/service_provider.c
+++ b/tests/binder/service_provider.c
@@ -286,7 +286,7 @@ int main(int argc, char **argv)
 	if (fd_type == BPF_TEST)
 		exit(0);
 
-	/* If BPF enabed, then need to set limits */
+	/* If BPF enabled, then need to set limits */
 	if (fd_type == BPF_MAP_FD || fd_type == BPF_PROG_FD)
 		bpf_setrlimit();
 #else
diff --git a/tests/bounds/test b/tests/bounds/test
index dd41115..3bf1b6a 100755
--- a/tests/bounds/test
+++ b/tests/bounds/test
@@ -76,8 +76,8 @@ $result = system(
 );
 ok($result);
 
-# It ensure the child domain shall be bounded to the parent.
-# So, we expect all the alloed actiona are intersection with test_bounds_parent_t
+# It ensures the child domain shall be bounded to the parent.
+# So, we expect all the allowed actions are intersections with test_bounds_parent_t
 
 $result = system(
 "runcon -t test_bounds_child_t -- dd if=$basedir/bounds_file_red of=/dev/null count=1 2>&1 > /dev/null"
diff --git a/tests/capable_net/test b/tests/capable_net/test
index 8ef9ecc..dc0b57a 100755
--- a/tests/capable_net/test
+++ b/tests/capable_net/test
@@ -1,6 +1,6 @@
 #!/usr/bin/perl
 #
-# This test performs checks for network-related capabilties.
+# This test performs checks for network-related capabilities.
 #
 
 use Test;
diff --git a/tests/capable_sys/test b/tests/capable_sys/test
index 34ed8c8..132c732 100755
--- a/tests/capable_sys/test
+++ b/tests/capable_sys/test
@@ -1,6 +1,6 @@
 #!/usr/bin/perl
 #
-# This test performs checks for system-related capabilties.
+# This test performs checks for system-related capabilities.
 #
 
 use Test;
diff --git a/tests/file/test b/tests/file/test
index fa28b7c..64dc813 100755
--- a/tests/file/test
+++ b/tests/file/test
@@ -148,7 +148,7 @@ ok($result);
 system "chcon -t nofileop_rw_file_t $basedir/temp_file2 2>&1 > /dev/null";
 
 #
-# Check the fcntl for the bad domain. This uses the read-only accessable file.
+# Check the fcntl for the bad domain. This uses the read-only accessible file.
 #
 $result = system
   "runcon -t test_nofileop_t -- $basedir/test_nofcntl $basedir/temp_file3 2>&1";
diff --git a/tests/file/test_nofcntl.c b/tests/file/test_nofcntl.c
index 3554dec..40976c5 100644
--- a/tests/file/test_nofcntl.c
+++ b/tests/file/test_nofcntl.c
@@ -29,7 +29,7 @@ int main(int argc, char **argv)
 		exit(2);
 	}
 
-	/* The next two acesses should fail, so if that happens, we return success. */
+	/* The next two accesses should fail, so if that happens, we return success. */
 
 	rc = fcntl(fd, F_SETFL, 0);
 	if( rc != -1 ) {
diff --git a/tests/file/test_sigiotask.c b/tests/file/test_sigiotask.c
index 97d343b..5a5efc5 100644
--- a/tests/file/test_sigiotask.c
+++ b/tests/file/test_sigiotask.c
@@ -18,7 +18,7 @@
 /*
  * Test the sigio operations by creating a child and registering that process
  * for SIGIO signals for the terminal. The main process forces a SIGIO
- * on the terminal by sending a charcter to that device.
+ * on the terminal by sending a character to that device.
  */
 int main(int argc, char **argv)
 {
diff --git a/tests/ioctl/test b/tests/ioctl/test
index 84e9d35..4e2955c 100755
--- a/tests/ioctl/test
+++ b/tests/ioctl/test
@@ -37,14 +37,14 @@ $result = system "touch $basedir/temp_file 2>&1";
 $result = system "chcon -t test_ioctl_file_t $basedir/temp_file 2>&1";
 
 #
-# Attempt to perform the ioctls on the temproary file as the good domain
+# Attempt to perform the ioctls on the temporary file as the good domain
 #
 $result = system
   "runcon -t test_ioctl_t -- $basedir/test_ioctl $basedir/temp_file 2>&1";
 ok( $result, 0 );
 
 #
-# Attempt to perform the ioctls on the temproary file as the bad domain
+# Attempt to perform the ioctls on the temporary file as the bad domain
 # The test program, test_noioctl.c, determines success/failure for the
 # individual calls, so we expect success always from that program.
 #
diff --git a/tests/ioctl/test_noioctl.c b/tests/ioctl/test_noioctl.c
index 319d90f..ea9f120 100644
--- a/tests/ioctl/test_noioctl.c
+++ b/tests/ioctl/test_noioctl.c
@@ -18,7 +18,7 @@
  * argument. This version of the program expects some of the ioctl()
  * calls to fail, so if one does succeed, we exit with a bad return code.
  * This program expects the domain it is running as to have only read
- * acess to the given file.
+ * access to the given file.
  */
 int main(int argc, char **argv)
 {
diff --git a/tests/mqueue/mqmgr.c b/tests/mqueue/mqmgr.c
index 5a08ce5..d03bf85 100644
--- a/tests/mqueue/mqmgr.c
+++ b/tests/mqueue/mqmgr.c
@@ -10,7 +10,7 @@
 #include<errno.h>
 
 /*
- * Managed the creation and distruction of a posix mqueue.
+ * Managed the creation and destruction of a posix mqueue.
  * The first argument is the name of the mqueue to be managed
  * (including starting '/'). The second argument is the
  * operation. '1' to create, '0' to remove.
diff --git a/tests/mqueue/test b/tests/mqueue/test
index 8334b9b..0cb9c22 100755
--- a/tests/mqueue/test
+++ b/tests/mqueue/test
@@ -8,7 +8,7 @@ use Test::More;
 BEGIN {
     # check if kernel supports posix mqueues file system is mounted
     if ( system("mount | grep -q mqueue") ) {
-        plan skip_all => "mqueue fileystem not supported/mounted";
+        plan skip_all => "mqueue filesystem not supported/mounted";
     }
     else {
         plan tests => 13;
diff --git a/tests/overlay/setup-overlay b/tests/overlay/setup-overlay
index ae817a1..a1203f4 100755
--- a/tests/overlay/setup-overlay
+++ b/tests/overlay/setup-overlay
@@ -31,7 +31,7 @@ setup () {
     # (test_overlay_mounter_t, test_overlay_client_t)
     chcon -R -t test_overlay_files_ro_t $BASEDIR/lower
 
-    # Label noaccessfile and noaccessdir, with types not accessable to either the
+    # Label noaccessfile and noaccessdir, with types not accessible to either the
     # mounter or the client types
     chcon -t test_overlay_files_noaccess_t $BASEDIR/lower/noaccessfile $BASEDIR/lower/noaccessdir $BASEDIR/lower/null_noaccess
     chcon -t test_overlay_mounter_files_t $BASEDIR/lower/mounterfile $BASEDIR/lower/mounterdir $BASEDIR/lower/null_mounter
diff --git a/tests/task_setscheduler/test b/tests/task_setscheduler/test
index c2fe8c6..3730ff7 100755
--- a/tests/task_setscheduler/test
+++ b/tests/task_setscheduler/test
@@ -23,7 +23,7 @@ close($f);
 $cgroup_cpu = "/sys/fs/cgroup/cpu/tasks";
 if ( -w $cgroup_cpu ) {
 
-    # We can only set the scheduler policy fo SCHED_{RR,FIFO} in the root
+    # We can only set the scheduler policy to SCHED_{RR,FIFO} in the root
     # cgroup so move our target process to the root cgroup.
     open( my $fd, ">>", $cgroup_cpu );
     print $fd $pid;
diff --git a/tests/userfaultfd/userfaultfd.c b/tests/userfaultfd/userfaultfd.c
index b788f72..2d58b08 100644
--- a/tests/userfaultfd/userfaultfd.c
+++ b/tests/userfaultfd/userfaultfd.c
@@ -177,7 +177,7 @@ int main (int argc, char *argv[])
 		return -1;
 	}
 
-	/* Acces to the registered memory range should invoke the 'missing'
+	/* Access to the registered memory range should invoke the 'missing'
 	 * userfaultfd page fault, which should get handled by the thread
 	 * created above.
 	 */
-- 
2.55.0

