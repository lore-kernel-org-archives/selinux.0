Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AB52550CA
	for <selinux@vger.kernel.org>; Thu,  5 Jun 2025 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749130469; cv=none; b=pLxhMY94+ZM3OegA3qu+RxtDkGp0DGUeSPC5Dew3jwJNRURMOs00mrLXIRtg+ZrkLLXPGbCfZJxXeJjUHqOdumcWcaex0JoVGTztJaTvG3JIMjhTGvx85mLK6LaDrfhBPT7Ea6j0BiWhh7Lby6LuKb+gsVPWGgHrvddicCH6F08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749130469; c=relaxed/simple;
	bh=It8sXrPSrsIOMAHeqSv4+qTJCn1xgTa107nuGUj4Ba8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=XQmwb8pDlUU8MLNcGHcHhfUtBu5dbFq4cbbbhL8xS5SSxBsDVisNhX3Ng9jli1nvkXmQzfQ6k6TttwGa8lPQO3IYAk9ExYWV57y/5Xjag8bpl37RcHQU7abqLTKadjE37wcecLp99Qgjjg3/wMX1F3bZU6v/5GP8noHGhq4MewU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VP+cySsA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VP+cySsA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749130466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RZvW6+cmK7NoCTagmnIJ6JNKMYJ9P/q07E1xKhRKkVE=;
	b=VP+cySsAUpGEBezbanktNi1tXENfy1O6PAolVymOlQpCSLdgxLxCyW6NBxxI9An4AYjHnK
	06a2pXcbeI7ORJQK5XEgf6Y653OugH7y13MYxhMovCz0JhoMXBBHaamJ5eQUe7/hWBK9L4
	CROdkRFX6jVURKiCOzr5qC2yqsww0R8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-kKoBhLAPNpWNC3OqZj5Vsg-1; Thu,
 05 Jun 2025 09:34:25 -0400
X-MC-Unique: kKoBhLAPNpWNC3OqZj5Vsg-1
X-Mimecast-MFC-AGG-ID: kKoBhLAPNpWNC3OqZj5Vsg_1749130464
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2AE6B1956087
	for <selinux@vger.kernel.org>; Thu,  5 Jun 2025 13:34:24 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.226.60])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2B40F18003FD;
	Thu,  5 Jun 2025 13:34:22 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH selinux-testsuite 2/2] Add tests for checkpoint_restore in cap2_userns
Date: Thu,  5 Jun 2025 15:34:01 +0200
Message-ID: <20250605133414.939461-2-lautrbach@redhat.com>
In-Reply-To: <20250605133414.939461-1-lautrbach@redhat.com>
References: <20250605133414.939461-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

According to pid_namespaces(7) CAP_CHECK_RESTORE is required to write to
/proc/sys/kernel/ns_last_pid
Check whether a process in user and pid namespace is able to write there
when it has cap2_userns checkpoint_restore allowed.

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 policy/test_cap_userns.te | 15 +++++++++++++++
 tests/cap_userns/test     | 16 +++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

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
index 917da00e4805..9cee33df360c 100755
--- a/tests/cap_userns/test
+++ b/tests/cap_userns/test
@@ -11,7 +11,7 @@ BEGIN {
             "echo 1 > /proc/sys/kernel/unprivileged_userns_clone 2> /dev/null");
     }
     if ( system("$basedir/userns_child_exec -t -U > /dev/null 2>&1") == 0 ) {
-        plan tests => 2;
+        plan tests => 4;
     }
     else {
         plan skip_all => "CLONE_NEWUSER not supported";
@@ -32,6 +32,20 @@ $result = system(
 );
 ok($result);
 
+# Verify that test_cap2_userns_t can use cap_checkpoint_restore
+
+$result = system(
+"$basedir/userns_child_exec -p -U -M '0 0 1' -G '0 0 1' -- runcon -t test_cap2_userns_t -- sysctl -w kernel.ns_last_pid=1000 2>&1"
+);
+ok( $result eq 0 );
+
+# Verify that test_no_cap_userns_t cannot use cap_checkpoint_restore
+
+$result = system(
+"$basedir/userns_child_exec -p -U -M '0 0 1' -G '0 0 1' -- runcon -t test_no_cap2_userns_t -- sysctl -w kernel.ns_last_pid=1000 2>&1"
+);
+ok($result);
+
 if ( -e '/proc/sys/kernel/unprivileged_userns_clone' ) {
     system("echo 0 > /proc/sys/kernel/unprivileged_userns_clone 2> /dev/null");
 }
-- 
2.49.0

