Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243F723BD06
	for <selinux@vger.kernel.org>; Fri,  6 Jun 2025 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749213388; cv=none; b=paFc4KFQDQ0U7FPJvdktMYS7K8unYbm7kDC05AgroIeieQAXw/kmWuQCBw2x9tqpj0Y0JL21AuIQl78AavHR3nEW+36AIMAegkzKlxee9nOnZjHuPobNbOVbvNANqsou97P98DjSgWUSWrFapxHcS7i6ThG8jhnqmVvE9RjzbWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749213388; c=relaxed/simple;
	bh=yE/Hpe7sBkmdYFplQqtlxD4neSEedgiW/iUp+p1ijKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=CwJ0c9agS8fdz+YYB3URdSy+lXpPyMiIfQGr9QZlgOekXPJ+8SXGbQE2BuhhkdcCkW3QmY8DqKAyxTwMbeBUeZndzm74Jr6KG1/bnMDhLfCUek1SblYSsnx8oJozcBKWD/aKlVrBdMN4mRaE19sAYW/DqQrGZ5LTYglB4Ddou3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jQjPAcPO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQjPAcPO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749213386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9lSGwIYcuPnO26RW/YoSrP9lRCv0zzg0w7pCuSetKt4=;
	b=jQjPAcPOj2UGZFMHo1zEBxWR6nW8wyk8wmzubw2Sbe2g7w3KG32E846Vq39hGKehjcKduv
	q7t5GEk098EPAIcG9S9FCPwOZrOIGc2D9zSY9YwBdf6pg1KBYVKtHJivDBg6jrPJx39H6y
	OROkULnDu++E1KnXzFxpXVm89n19iMQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-V1dFOrnqPiyBWrHoJR6FSg-1; Fri,
 06 Jun 2025 08:36:24 -0400
X-MC-Unique: V1dFOrnqPiyBWrHoJR6FSg-1
X-Mimecast-MFC-AGG-ID: V1dFOrnqPiyBWrHoJR6FSg_1749213384
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F64919560A2
	for <selinux@vger.kernel.org>; Fri,  6 Jun 2025 12:36:24 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.43])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0981319560B2;
	Fri,  6 Jun 2025 12:36:22 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH selinux-testsuite v3 2/2] Add tests for checkpoint_restore in cap2_userns
Date: Fri,  6 Jun 2025 14:35:34 +0200
Message-ID: <20250606123615.1029847-2-lautrbach@redhat.com>
In-Reply-To: <20250606123615.1029847-1-lautrbach@redhat.com>
References: <20250606123615.1029847-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

According to pid_namespaces(7) CAP_CHECK_RESTORE is required to write to
/proc/sys/kernel/ns_last_pid
Check whether a process in user and pid namespace is able to write there
when it has cap2_userns checkpoint_restore allowed.

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---

v3 - redirect stderr to stdout

 policy/test_cap_userns.te | 15 +++++++++++++++
 tests/cap_userns/test     | 36 +++++++++++++++++++++++++++++++++---
 2 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/policy/test_cap_userns.te b/policy/test_cap_userns.te
index 6f444871bcf0..402675b2eb7e 100644
--- a/policy/test_cap_userns.te
+++ b/policy/test_cap_userns.te
@@ -4,6 +4,7 @@
 #
 
 attribute capusernsdomain;
+attribute cap2usernsdomain;
 
 # Domain for process that is allowed non-init userns capabilities
 type test_cap_userns_t;
@@ -22,3 +23,17 @@ typeattribute test_no_cap_userns_t capusernsdomain;
 allow_userns_create(capusernsdomain)
 # linux >= v5.12 needs setfcap to map UID 0
 allow capusernsdomain self:capability setfcap;
+
+# Domain for process that is allowed to use cap_checkpoint_restore
+type test_cap2_userns_t;
+testsuite_domain_type(test_cap2_userns_t)
+typeattribute test_cap2_userns_t cap2usernsdomain;
+allow test_cap2_userns_t self:cap2_userns checkpoint_restore;
+
+# Domain for process that is not to use cap_checkpoint_restore
+type test_no_cap2_userns_t;
+testsuite_domain_type(test_no_cap2_userns_t)
+typeattribute test_no_cap2_userns_t cap2usernsdomain;
+
+# Rules common to both domains.
+kernel_rw_kernel_ns_lastpid_sysctl(cap2usernsdomain)
diff --git a/tests/cap_userns/test b/tests/cap_userns/test
index 917da00e4805..ba7b089435be 100755
--- a/tests/cap_userns/test
+++ b/tests/cap_userns/test
@@ -6,15 +6,28 @@ BEGIN {
     $basedir = $0;
     $basedir =~ s|(.*)/[^/]*|$1|;
 
+    $test_checkpoint = 0;
+
     if ( -e '/proc/sys/kernel/unprivileged_userns_clone' ) {
         system(
             "echo 1 > /proc/sys/kernel/unprivileged_userns_clone 2> /dev/null");
     }
-    if ( system("$basedir/userns_child_exec -t -U > /dev/null 2>&1") == 0 ) {
-        plan tests => 2;
+    if ( system("$basedir/userns_child_exec -t -U > /dev/null 2>&1") != 0 ) {
+        plan skip_all => "CLONE_NEWUSER not supported";
     }
     else {
-        plan skip_all => "CLONE_NEWUSER not supported";
+        $test_count = 2;
+
+        # CAP_CHECKPOINT_RESTORE is supported since 5.9
+        $kvercur = `uname -r`;
+        chomp($kvercur);
+
+        if ( `$basedir/../kvercmp $kvercur 5.9` > 0 ) {
+            $test_checkpoint = 1;
+            $test_count += 2;
+        }
+
+        plan tests => $test_count;
     }
 }
 
@@ -32,6 +45,23 @@ $result = system(
 );
 ok($result);
 
+if ($test_checkpoint) {
+
+    # Verify that test_cap2_userns_t can use cap_checkpoint_restore
+
+    $result = system(
+"$basedir/userns_child_exec -p -U -M '0 0 1' -G '0 0 1' -- runcon -t test_cap2_userns_t -- sh -c 'echo 1000 > /proc/sys/kernel/ns_last_pid' 2>&1"
+    );
+    ok( $result eq 0 );
+
+    # Verify that test_no_cap_userns_t cannot use cap_checkpoint_restore
+
+    $result = system(
+"$basedir/userns_child_exec -p -U -M '0 0 1' -G '0 0 1' -- runcon -t test_no_cap2_userns_t -- sh -c 'echo 1000 > /proc/sys/kernel/ns_last_pid' 2>&1"
+    );
+    ok($result);
+}
+
 if ( -e '/proc/sys/kernel/unprivileged_userns_clone' ) {
     system("echo 0 > /proc/sys/kernel/unprivileged_userns_clone 2> /dev/null");
 }
-- 
2.49.0

