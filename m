Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4E81EF097
	for <selinux@vger.kernel.org>; Tue,  7 Jan 2025 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257586; cv=none; b=HMYrz73+R0AAc+0ckWR52S9w3RWEK3yDdyeFT5ugAg91f5nPnLklhUhNCE5iVxEESAgXKgo6i5SGIinlMduErTCGFz/bdh8GJIIA2Czj8IPeY8o2EIOb+xiOeXAeK+oajzqM/2l4bZu1PGqkLjdXSqESgPIpLR2H5haeiFzRWOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257586; c=relaxed/simple;
	bh=A1VN7N/2Z8J894ixrpvArLa1/VvQBQ4+biisUlcUPDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0AeUyKm77j+08Q7ryskI+cohHtEq7Al8VwrKv++N17ywFcCC9UI/PHnXW4ywXsNEff64oBiITnJ272ikHaWDKUdPv4RcF1LhnbgT55PGi8U9DhKgebbqryKVgFgNgZMIo+Hd7Wtrlp6+/EyHztYX7Kn7G9yEuzud1dz6uQXCiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=oaKHPPr7; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="oaKHPPr7"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1736257574;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35kvOfcicU616OViDfVOjBpbGlR6/3BjcUvzKCWH7gs=;
	b=oaKHPPr7u5sPwdJFBQ/U52cLzhmZ8gmW/5MacKsLnHt5O8rOeboIzwj3y93DjXQhUNeisD
	/j1jUW0Gr6ULSA/SQvoPZ4vMMaY8RPrj30FyaO9kwzBcml8MqRR3Mi41SXl6Ci5InDUjXo
	smz7oJlXhsBD+K6y0e55qU6oQ+aZEiEXID/3vGZsg1930zAoPJyjlUzUX3m1l4FTpe/Mca
	SYte6SpYSgPvUvOhqDKCS/4EEFoTlp5G3Nj3WQxhcorQMuXXFqmk3iRV5AgmKodJNVqIkz
	ujcVonatFl2KAKboc3fc/o55aWOXEdf5ia0tBjTzjjigi3J/3kH2H2v/mnXtog==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH v2 08/17] tests/notify: work with CONFIG_FANOTIFY disabled
Date: Tue,  7 Jan 2025 14:45:56 +0100
Message-ID: <20250107134606.37260-8-cgoettsche@seltendoof.de>
In-Reply-To: <20250107134606.37260-1-cgoettsche@seltendoof.de>
References: <20250107134606.37260-1-cgoettsche@seltendoof.de>
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

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 tests/notify/test            | 172 +++++++++++++++++++++--------------
 tests/notify/test_fanotify.c |  14 ++-
 2 files changed, 114 insertions(+), 72 deletions(-)

diff --git a/tests/notify/test b/tests/notify/test
index 77db8c2..be28ad1 100755
--- a/tests/notify/test
+++ b/tests/notify/test
@@ -1,11 +1,25 @@
 #!/usr/bin/perl
 
 use Test;
-BEGIN { plan tests => 18 }    # number of tests to run
 
-# help the test script locate itself
-$basedir = $0;
-$basedir =~ s|(.*)/[^/]*|$1|;
+BEGIN {
+    # help the test script locate itself
+    $basedir = $0;
+    $basedir =~ s|(.*)/[^/]*|$1|;
+
+    $fanotify_support = 1;
+
+    $result = system("runcon -t test_watch_t $basedir/test_fanotify -c 2>&1");
+
+    # check if CONFIG_FANOTIFY is enabled - ENOSYS
+    if ( $result >> 8 eq 38 ) {
+        $fanotify_support = 0;
+        plan tests => 4;
+    }
+    else {
+        plan tests => 18;
+    }
+}
 
 # Get rid of a testfile and dir from last run if it's there (just in case)
 system("rm -f $basedir/watch_me");
@@ -27,45 +41,53 @@ $exit_val =
   system("runcon -t test_watch_t $basedir/test_inotify $basedir/watch_me 2>&1");
 ok( $exit_val, 0 );
 
-# Should be able to set non-permissions based fanotify watch
-$exit_val = system(
-    "runcon -t test_watch_t $basedir/test_fanotify $basedir/watch_me 2>&1");
-ok( $exit_val, 0 );
+if ($fanotify_support) {
 
-# Should NOT be able to set permission based fanotify watch
-$exit_val = system(
-    "runcon -t test_watch_t $basedir/test_fanotify -p $basedir/watch_me 2>&1");
-ok($exit_val);    # this should fail
+    # Should be able to set non-permissions based fanotify watch
+    $exit_val = system(
+        "runcon -t test_watch_t $basedir/test_fanotify $basedir/watch_me 2>&1");
+    ok( $exit_val, 0 );
 
-# Should NOT be able to set read based fanotify watch
-$exit_val = system(
-    "runcon -t test_watch_t $basedir/test_fanotify -r $basedir/watch_me 2>&1");
-ok($exit_val);    # this should fail
+    # Should NOT be able to set permission based fanotify watch
+    $exit_val = system(
+"runcon -t test_watch_t $basedir/test_fanotify -p $basedir/watch_me 2>&1"
+    );
+    ok($exit_val);    # this should fail
+
+    # Should NOT be able to set read based fanotify watch
+    $exit_val = system(
+"runcon -t test_watch_t $basedir/test_fanotify -r $basedir/watch_me 2>&1"
+    );
+    ok($exit_val);    # this should fail
+}
 
 # Should NOT be able to set read based inotify watch
 $exit_val = system(
     "runcon -t test_watch_t $basedir/test_inotify -r $basedir/watch_me 2>&1");
-ok($exit_val);    # this should fail
+ok($exit_val);        # this should fail
 
-## TEST PERM WATCH
-# Should be able to set permission based fanotify watch
-$exit_val = system(
+if ($fanotify_support) {
+
+    ## TEST PERM WATCH
+    # Should be able to set permission based fanotify watch
+    $exit_val = system(
 "runcon -t test_perm_watch_t $basedir/test_fanotify -p $basedir/watch_me 2>&1"
-);
-ok( $exit_val, 0 );
+    );
+    ok( $exit_val, 0 );
 
-# Should NOT be able to set watch of accesses
-$exit_val = system(
+    # Should NOT be able to set watch of accesses
+    $exit_val = system(
 "runcon -t test_perm_watch_t $basedir/test_fanotify -r $basedir/watch_me 2>&1"
-);
-ok($exit_val);    # this should fail
+    );
+    ok($exit_val);    # this should fail
 
-## TEST READ NO PERM WATCH PERMSISSIONS
-# Should NOT be able to set read and perm watch
-$exit_val = system(
+    ## TEST READ NO PERM WATCH PERMSISSIONS
+    # Should NOT be able to set read and perm watch
+    $exit_val = system(
 "runcon -t test_read_watch_t $basedir/test_fanotify -p -r $basedir/watch_me 2>&1"
-);
-ok($exit_val);    # should fail
+    );
+    ok($exit_val);    # should fail
+}
 
 # Should be able to set read inotify watch
 $exit_val = system(
@@ -73,12 +95,15 @@ $exit_val = system(
 );
 ok( $exit_val, 0 );
 
-## TEST READ WITH PERM WATCH PERMSISSIONS
-# Should be able to set read and perm watch
-$exit_val = system(
+if ($fanotify_support) {
+
+    ## TEST READ WITH PERM WATCH PERMSISSIONS
+    # Should be able to set read and perm watch
+    $exit_val = system(
 "runcon -t test_perm_read_watch_t $basedir/test_fanotify -p -r $basedir/watch_me 2>&1"
-);
-ok( $exit_val, 0 );
+    );
+    ok( $exit_val, 0 );
+}
 
 ## TEST NO WATCH PERMSISSIONS
 # Should NOT be able to set inotify watch
@@ -86,45 +111,52 @@ $exit_val = system(
     "runcon -t test_no_watch_t $basedir/test_inotify $basedir/watch_me 2>&1");
 ok($exit_val);    # this should fail
 
-# Should NOT be able to set any fanotify watch
-$exit_val = system(
-    "runcon -t test_no_watch_t $basedir/test_fanotify $basedir/watch_me 2>&1");
-ok($exit_val);    # this should fail
-
-## TEST READ ONLY
-# Should NOT be able to get read-write descriptor
-$exit_val = system(
-    "runcon -t test_rdonly_t $basedir/test_fanotify -l $basedir/watch_me 2>&1");
-ok($exit_val);    # this should fail
-
-# Should be able to get read-write descriptor
-$exit_val = system(
-    "runcon -t test_watch_t $basedir/test_fanotify -l $basedir/watch_me 2>&1");
-ok( $exit_val, 0 );
-
-## TEST MOUNT WATCHES
-# Should NOT be able to set a watch on a mount point
-$exit_val = system(
-    "runcon -t test_watch_t $basedir/test_fanotify -m $basedir/watch_dir 2>&1");
-ok($exit_val);    # this should fail
-
-# Should be able to set a watch on mount point
-$exit_val = system(
+if ($fanotify_support) {
+
+    # Should NOT be able to set any fanotify watch
+    $exit_val = system(
+"runcon -t test_no_watch_t $basedir/test_fanotify $basedir/watch_me 2>&1"
+    );
+    ok($exit_val);    # this should fail
+
+    ## TEST READ ONLY
+    # Should NOT be able to get read-write descriptor
+    $exit_val = system(
+"runcon -t test_rdonly_t $basedir/test_fanotify -l $basedir/watch_me 2>&1"
+    );
+    ok($exit_val);    # this should fail
+
+    # Should be able to get read-write descriptor
+    $exit_val = system(
+"runcon -t test_watch_t $basedir/test_fanotify -l $basedir/watch_me 2>&1"
+    );
+    ok( $exit_val, 0 );
+
+    ## TEST MOUNT WATCHES
+    # Should NOT be able to set a watch on a mount point
+    $exit_val = system(
+"runcon -t test_watch_t $basedir/test_fanotify -m $basedir/watch_dir 2>&1"
+    );
+    ok($exit_val);    # this should fail
+
+    # Should be able to set a watch on mount point
+    $exit_val = system(
 "runcon -t test_mount_watch_t $basedir/test_fanotify -m $basedir/watch_dir 2>&1"
-);
-ok( $exit_val, 0 );
+    );
+    ok( $exit_val, 0 );
 
-# Should NOT be able to set a perm watch on a mount
-$exit_val = system(
+    # Should NOT be able to set a perm watch on a mount
+    $exit_val = system(
 "runcon -t test_mount_watch_t $basedir/test_fanotify -m -p $basedir/watch_dir 2>&1"
-);
-ok($exit_val);    # this should fail
+    );
+    ok($exit_val);    # this should fail
 
-# Should be able to set a perm watch on a mount object
-$exit_val = system(
+    # Should be able to set a perm watch on a mount object
+    $exit_val = system(
 "runcon -t test_mount_perm_t $basedir/test_fanotify -p -m $basedir/watch_dir 2>&1"
-);
-ok( $exit_val, 0 );
+    );
+    ok( $exit_val, 0 );
+}
 
 # Clean up test file
 system("rm -f $basedir/watch_me");
diff --git a/tests/notify/test_fanotify.c b/tests/notify/test_fanotify.c
index bc3b4c3..fe89265 100644
--- a/tests/notify/test_fanotify.c
+++ b/tests/notify/test_fanotify.c
@@ -5,6 +5,7 @@
 
 #include <getopt.h>
 
+#include <errno.h>
 #include <fcntl.h>
 #include <poll.h>
 #include <sys/fanotify.h>
@@ -12,7 +13,7 @@
 
 void printUsage()
 {
-	fprintf(stderr, "Usage: test_fanotify [-p] [-r] [-l] [-m] file_name\n");
+	fprintf(stderr, "Usage: test_fanotify [-p] [-r] [-l] [-m] [-c] file_name\n");
 	exit(1);
 }
 
@@ -26,13 +27,14 @@ int main(int argc, char *argv[])
 	int mask = FAN_OPEN;  // default mask
 	int flags = FAN_MARK_ADD;
 	int listening = 0;
+	int check = 0;
 
 	// the -p flag will test for watch_with_perm
 	// the mask used at mark will contain FAN_OPEN_PERM
 	//
 	// the -r flag will test for watching accesses to files for reads
 	// the mask will contain FAN_ACCESS
-	while ((arg = getopt(argc, argv, "prlm")) != -1) {
+	while ((arg = getopt(argc, argv, "prlmc")) != -1) {
 		switch (arg) {
 		case 'p':
 			mask |= FAN_OPEN_PERM;
@@ -46,6 +48,9 @@ int main(int argc, char *argv[])
 		case 'm':
 			flags |= FAN_MARK_MOUNT;
 			break;
+		case 'c':
+			check = 1;
+			break;
 		default:
 			printUsage();
 		}
@@ -53,6 +58,11 @@ int main(int argc, char *argv[])
 
 	// get file descriptor for new fanotify event queue
 	fd = fanotify_init(FAN_CLASS_CONTENT, O_RDWR);
+	if (check) {
+		if (fd < 0 && errno == ENOSYS)
+			exit(ENOSYS);
+		exit(0);
+	}
 	if (fd < 0) {
 		perror("fanotify_init:bad file descriptor");
 		exit(1);
-- 
2.47.1

